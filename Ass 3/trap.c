#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
            cpuid(), tf->cs, tf->eip);
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    switch(tf->trapno){
      //defined pretty error message
        case T_DIVIDE: //0
          cprintf("trap error: divide error\n");
          break;
        case T_DEBUG: //1
          cprintf("trap error: debug exception\n");
          break;
        case T_NMI: //2
          cprintf("trap error: non-maskable interrupt\n");
          break;
        case T_BRKPT: //3
          cprintf("trap error: breakpoint\n");
          break;
        case T_OFLOW: //4
          cprintf("trap error: overflow\n");
          break;
        case T_BOUND: //5
          cprintf("trap error: bounds check\n");
          break;
        case T_ILLOP: //6
          cprintf("trap error: illegal opcode\n");
          break;
        case T_DEVICE: //7
          cprintf("trap error: device not available\n");
          break;
        case T_DBLFLT: //8
          cprintf("trap error: double fault\n");
          break;
        case T_TSS: //10
          cprintf("trap error: invalid task switch segment\n");
          break;
        case T_SEGNP: //11
          cprintf("trap error: segment not present\n");
          break;
        case T_STACK: //12
          cprintf("trap error: stack exception\n");
          break;
        case T_GPFLT: //13
          cprintf("trap error: general protection fault\n");
          break;
        case T_PGFLT: //14
          cprintf("trap error: page fault\n");
          break;
        case T_FPERR: //16
          cprintf("trap error: floating point error\n");
          break;
        case T_ALIGN: //17
          cprintf("trap error: alignment check\n");
          break;
        case T_MCHK: //18
          cprintf("trap error: machine check\n");
          break;
        case T_SIMDERR: //19
          cprintf("trap error: SIMD floating point error\n");
          break;
    }
    myproc()->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();
}
