
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int i;

  if(argc < 2){
   9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
   d:	7f 19                	jg     28 <main+0x28>
    printf(2, "usage: kill pid...\n");
   f:	c7 44 24 04 65 08 00 	movl   $0x865,0x4(%esp)
  16:	00 
  17:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  1e:	e8 76 04 00 00       	call   499 <printf>
    exit();
  23:	e8 a7 02 00 00       	call   2cf <exit>
  }
  for(i=1; i<argc; i++)
  28:	c7 44 24 1c 01 00 00 	movl   $0x1,0x1c(%esp)
  2f:	00 
  30:	eb 27                	jmp    59 <main+0x59>
    kill(atoi(argv[i]));
  32:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  36:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  40:	01 d0                	add    %edx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	89 04 24             	mov    %eax,(%esp)
  47:	e8 f1 01 00 00       	call   23d <atoi>
  4c:	89 04 24             	mov    %eax,(%esp)
  4f:	e8 ab 02 00 00       	call   2ff <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  54:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  59:	8b 44 24 1c          	mov    0x1c(%esp),%eax
  5d:	3b 45 08             	cmp    0x8(%ebp),%eax
  60:	7c d0                	jl     32 <main+0x32>
    kill(atoi(argv[i]));
  exit();
  62:	e8 68 02 00 00       	call   2cf <exit>

00000067 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  67:	55                   	push   %ebp
  68:	89 e5                	mov    %esp,%ebp
  6a:	57                   	push   %edi
  6b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6f:	8b 55 10             	mov    0x10(%ebp),%edx
  72:	8b 45 0c             	mov    0xc(%ebp),%eax
  75:	89 cb                	mov    %ecx,%ebx
  77:	89 df                	mov    %ebx,%edi
  79:	89 d1                	mov    %edx,%ecx
  7b:	fc                   	cld    
  7c:	f3 aa                	rep stos %al,%es:(%edi)
  7e:	89 ca                	mov    %ecx,%edx
  80:	89 fb                	mov    %edi,%ebx
  82:	89 5d 08             	mov    %ebx,0x8(%ebp)
  85:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  88:	5b                   	pop    %ebx
  89:	5f                   	pop    %edi
  8a:	5d                   	pop    %ebp
  8b:	c3                   	ret    

0000008c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  92:	8b 45 08             	mov    0x8(%ebp),%eax
  95:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  98:	90                   	nop
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	8d 50 01             	lea    0x1(%eax),%edx
  9f:	89 55 08             	mov    %edx,0x8(%ebp)
  a2:	8b 55 0c             	mov    0xc(%ebp),%edx
  a5:	8d 4a 01             	lea    0x1(%edx),%ecx
  a8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  ab:	0f b6 12             	movzbl (%edx),%edx
  ae:	88 10                	mov    %dl,(%eax)
  b0:	0f b6 00             	movzbl (%eax),%eax
  b3:	84 c0                	test   %al,%al
  b5:	75 e2                	jne    99 <strcpy+0xd>
    ;
  return os;
  b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ba:	c9                   	leave  
  bb:	c3                   	ret    

000000bc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  bf:	eb 08                	jmp    c9 <strcmp+0xd>
    p++, q++;
  c1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c5:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c9:	8b 45 08             	mov    0x8(%ebp),%eax
  cc:	0f b6 00             	movzbl (%eax),%eax
  cf:	84 c0                	test   %al,%al
  d1:	74 10                	je     e3 <strcmp+0x27>
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	0f b6 10             	movzbl (%eax),%edx
  d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  dc:	0f b6 00             	movzbl (%eax),%eax
  df:	38 c2                	cmp    %al,%dl
  e1:	74 de                	je     c1 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
  e3:	8b 45 08             	mov    0x8(%ebp),%eax
  e6:	0f b6 00             	movzbl (%eax),%eax
  e9:	0f b6 d0             	movzbl %al,%edx
  ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  ef:	0f b6 00             	movzbl (%eax),%eax
  f2:	0f b6 c0             	movzbl %al,%eax
  f5:	29 c2                	sub    %eax,%edx
  f7:	89 d0                	mov    %edx,%eax
}
  f9:	5d                   	pop    %ebp
  fa:	c3                   	ret    

000000fb <strlen>:

uint
strlen(const char *s)
{
  fb:	55                   	push   %ebp
  fc:	89 e5                	mov    %esp,%ebp
  fe:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 101:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 108:	eb 04                	jmp    10e <strlen+0x13>
 10a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10e:	8b 55 fc             	mov    -0x4(%ebp),%edx
 111:	8b 45 08             	mov    0x8(%ebp),%eax
 114:	01 d0                	add    %edx,%eax
 116:	0f b6 00             	movzbl (%eax),%eax
 119:	84 c0                	test   %al,%al
 11b:	75 ed                	jne    10a <strlen+0xf>
    ;
  return n;
 11d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 120:	c9                   	leave  
 121:	c3                   	ret    

00000122 <memset>:

void*
memset(void *dst, int c, uint n)
{
 122:	55                   	push   %ebp
 123:	89 e5                	mov    %esp,%ebp
 125:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 128:	8b 45 10             	mov    0x10(%ebp),%eax
 12b:	89 44 24 08          	mov    %eax,0x8(%esp)
 12f:	8b 45 0c             	mov    0xc(%ebp),%eax
 132:	89 44 24 04          	mov    %eax,0x4(%esp)
 136:	8b 45 08             	mov    0x8(%ebp),%eax
 139:	89 04 24             	mov    %eax,(%esp)
 13c:	e8 26 ff ff ff       	call   67 <stosb>
  return dst;
 141:	8b 45 08             	mov    0x8(%ebp),%eax
}
 144:	c9                   	leave  
 145:	c3                   	ret    

00000146 <strchr>:

char*
strchr(const char *s, char c)
{
 146:	55                   	push   %ebp
 147:	89 e5                	mov    %esp,%ebp
 149:	83 ec 04             	sub    $0x4,%esp
 14c:	8b 45 0c             	mov    0xc(%ebp),%eax
 14f:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 152:	eb 14                	jmp    168 <strchr+0x22>
    if(*s == c)
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	0f b6 00             	movzbl (%eax),%eax
 15a:	3a 45 fc             	cmp    -0x4(%ebp),%al
 15d:	75 05                	jne    164 <strchr+0x1e>
      return (char*)s;
 15f:	8b 45 08             	mov    0x8(%ebp),%eax
 162:	eb 13                	jmp    177 <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 164:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 168:	8b 45 08             	mov    0x8(%ebp),%eax
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	84 c0                	test   %al,%al
 170:	75 e2                	jne    154 <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 172:	b8 00 00 00 00       	mov    $0x0,%eax
}
 177:	c9                   	leave  
 178:	c3                   	ret    

00000179 <gets>:

char*
gets(char *buf, int max)
{
 179:	55                   	push   %ebp
 17a:	89 e5                	mov    %esp,%ebp
 17c:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 17f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 186:	eb 4c                	jmp    1d4 <gets+0x5b>
    cc = read(0, &c, 1);
 188:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 18f:	00 
 190:	8d 45 ef             	lea    -0x11(%ebp),%eax
 193:	89 44 24 04          	mov    %eax,0x4(%esp)
 197:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 19e:	e8 44 01 00 00       	call   2e7 <read>
 1a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1aa:	7f 02                	jg     1ae <gets+0x35>
      break;
 1ac:	eb 31                	jmp    1df <gets+0x66>
    buf[i++] = c;
 1ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b1:	8d 50 01             	lea    0x1(%eax),%edx
 1b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b7:	89 c2                	mov    %eax,%edx
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	01 c2                	add    %eax,%edx
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0a                	cmp    $0xa,%al
 1ca:	74 13                	je     1df <gets+0x66>
 1cc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d0:	3c 0d                	cmp    $0xd,%al
 1d2:	74 0b                	je     1df <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d7:	83 c0 01             	add    $0x1,%eax
 1da:	3b 45 0c             	cmp    0xc(%ebp),%eax
 1dd:	7c a9                	jl     188 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 1df:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1e2:	8b 45 08             	mov    0x8(%ebp),%eax
 1e5:	01 d0                	add    %edx,%eax
 1e7:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ed:	c9                   	leave  
 1ee:	c3                   	ret    

000001ef <stat>:

int
stat(const char *n, struct stat *st)
{
 1ef:	55                   	push   %ebp
 1f0:	89 e5                	mov    %esp,%ebp
 1f2:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 1fc:	00 
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	89 04 24             	mov    %eax,(%esp)
 203:	e8 07 01 00 00       	call   30f <open>
 208:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 20b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 20f:	79 07                	jns    218 <stat+0x29>
    return -1;
 211:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 216:	eb 23                	jmp    23b <stat+0x4c>
  r = fstat(fd, st);
 218:	8b 45 0c             	mov    0xc(%ebp),%eax
 21b:	89 44 24 04          	mov    %eax,0x4(%esp)
 21f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 222:	89 04 24             	mov    %eax,(%esp)
 225:	e8 fd 00 00 00       	call   327 <fstat>
 22a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 22d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 230:	89 04 24             	mov    %eax,(%esp)
 233:	e8 bf 00 00 00       	call   2f7 <close>
  return r;
 238:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 23b:	c9                   	leave  
 23c:	c3                   	ret    

0000023d <atoi>:

int
atoi(const char *s)
{
 23d:	55                   	push   %ebp
 23e:	89 e5                	mov    %esp,%ebp
 240:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 243:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 24a:	eb 25                	jmp    271 <atoi+0x34>
    n = n*10 + *s++ - '0';
 24c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24f:	89 d0                	mov    %edx,%eax
 251:	c1 e0 02             	shl    $0x2,%eax
 254:	01 d0                	add    %edx,%eax
 256:	01 c0                	add    %eax,%eax
 258:	89 c1                	mov    %eax,%ecx
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
 25d:	8d 50 01             	lea    0x1(%eax),%edx
 260:	89 55 08             	mov    %edx,0x8(%ebp)
 263:	0f b6 00             	movzbl (%eax),%eax
 266:	0f be c0             	movsbl %al,%eax
 269:	01 c8                	add    %ecx,%eax
 26b:	83 e8 30             	sub    $0x30,%eax
 26e:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 271:	8b 45 08             	mov    0x8(%ebp),%eax
 274:	0f b6 00             	movzbl (%eax),%eax
 277:	3c 2f                	cmp    $0x2f,%al
 279:	7e 0a                	jle    285 <atoi+0x48>
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
 27e:	0f b6 00             	movzbl (%eax),%eax
 281:	3c 39                	cmp    $0x39,%al
 283:	7e c7                	jle    24c <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 285:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 288:	c9                   	leave  
 289:	c3                   	ret    

0000028a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 28a:	55                   	push   %ebp
 28b:	89 e5                	mov    %esp,%ebp
 28d:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 290:	8b 45 08             	mov    0x8(%ebp),%eax
 293:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 296:	8b 45 0c             	mov    0xc(%ebp),%eax
 299:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 29c:	eb 17                	jmp    2b5 <memmove+0x2b>
    *dst++ = *src++;
 29e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a1:	8d 50 01             	lea    0x1(%eax),%edx
 2a4:	89 55 fc             	mov    %edx,-0x4(%ebp)
 2a7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2aa:	8d 4a 01             	lea    0x1(%edx),%ecx
 2ad:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 2b0:	0f b6 12             	movzbl (%edx),%edx
 2b3:	88 10                	mov    %dl,(%eax)
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b5:	8b 45 10             	mov    0x10(%ebp),%eax
 2b8:	8d 50 ff             	lea    -0x1(%eax),%edx
 2bb:	89 55 10             	mov    %edx,0x10(%ebp)
 2be:	85 c0                	test   %eax,%eax
 2c0:	7f dc                	jg     29e <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c5:	c9                   	leave  
 2c6:	c3                   	ret    

000002c7 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2c7:	b8 01 00 00 00       	mov    $0x1,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <exit>:
SYSCALL(exit)
 2cf:	b8 02 00 00 00       	mov    $0x2,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <wait>:
SYSCALL(wait)
 2d7:	b8 03 00 00 00       	mov    $0x3,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <pipe>:
SYSCALL(pipe)
 2df:	b8 04 00 00 00       	mov    $0x4,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <read>:
SYSCALL(read)
 2e7:	b8 05 00 00 00       	mov    $0x5,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <write>:
SYSCALL(write)
 2ef:	b8 10 00 00 00       	mov    $0x10,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <close>:
SYSCALL(close)
 2f7:	b8 15 00 00 00       	mov    $0x15,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <kill>:
SYSCALL(kill)
 2ff:	b8 06 00 00 00       	mov    $0x6,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <exec>:
SYSCALL(exec)
 307:	b8 07 00 00 00       	mov    $0x7,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <open>:
SYSCALL(open)
 30f:	b8 0f 00 00 00       	mov    $0xf,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <mknod>:
SYSCALL(mknod)
 317:	b8 11 00 00 00       	mov    $0x11,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <unlink>:
SYSCALL(unlink)
 31f:	b8 12 00 00 00       	mov    $0x12,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <fstat>:
SYSCALL(fstat)
 327:	b8 08 00 00 00       	mov    $0x8,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <link>:
SYSCALL(link)
 32f:	b8 13 00 00 00       	mov    $0x13,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <mkdir>:
SYSCALL(mkdir)
 337:	b8 14 00 00 00       	mov    $0x14,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <chdir>:
SYSCALL(chdir)
 33f:	b8 09 00 00 00       	mov    $0x9,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <dup>:
SYSCALL(dup)
 347:	b8 0a 00 00 00       	mov    $0xa,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <getpid>:
SYSCALL(getpid)
 34f:	b8 0b 00 00 00       	mov    $0xb,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sbrk>:
SYSCALL(sbrk)
 357:	b8 0c 00 00 00       	mov    $0xc,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <sleep>:
SYSCALL(sleep)
 35f:	b8 0d 00 00 00       	mov    $0xd,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <uptime>:
SYSCALL(uptime)
 367:	b8 0e 00 00 00       	mov    $0xe,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <time>:
SYSCALL(time)
 36f:	b8 16 00 00 00       	mov    $0x16,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <getDate>:
SYSCALL(getDate)
 377:	b8 17 00 00 00       	mov    $0x17,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <IOTime>:
SYSCALL(IOTime)
 37f:	b8 18 00 00 00       	mov    $0x18,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <wait2>:
SYSCALL(wait2)
 387:	b8 19 00 00 00       	mov    $0x19,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <fork2>:
SYSCALL(fork2)
 38f:	b8 1a 00 00 00       	mov    $0x1a,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 397:	55                   	push   %ebp
 398:	89 e5                	mov    %esp,%ebp
 39a:	83 ec 28             	sub    $0x28,%esp
 39d:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a0:	88 45 e4             	mov    %al,-0x1c(%ebp)
  int start = uptime();
 3a3:	e8 bf ff ff ff       	call   367 <uptime>
 3a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  write(fd, &c, 1);
 3ab:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b2:	00 
 3b3:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 3b6:	89 44 24 04          	mov    %eax,0x4(%esp)
 3ba:	8b 45 08             	mov    0x8(%ebp),%eax
 3bd:	89 04 24             	mov    %eax,(%esp)
 3c0:	e8 2a ff ff ff       	call   2ef <write>
  int end = uptime();
 3c5:	e8 9d ff ff ff       	call   367 <uptime>
 3ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  IOTime(end - start);
 3cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3d0:	8b 55 f0             	mov    -0x10(%ebp),%edx
 3d3:	29 c2                	sub    %eax,%edx
 3d5:	89 d0                	mov    %edx,%eax
 3d7:	89 04 24             	mov    %eax,(%esp)
 3da:	e8 a0 ff ff ff       	call   37f <IOTime>
}
 3df:	c9                   	leave  
 3e0:	c3                   	ret    

000003e1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3e1:	55                   	push   %ebp
 3e2:	89 e5                	mov    %esp,%ebp
 3e4:	56                   	push   %esi
 3e5:	53                   	push   %ebx
 3e6:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3e9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f0:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3f4:	74 17                	je     40d <printint+0x2c>
 3f6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3fa:	79 11                	jns    40d <printint+0x2c>
    neg = 1;
 3fc:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 403:	8b 45 0c             	mov    0xc(%ebp),%eax
 406:	f7 d8                	neg    %eax
 408:	89 45 ec             	mov    %eax,-0x14(%ebp)
 40b:	eb 06                	jmp    413 <printint+0x32>
  } else {
    x = xx;
 40d:	8b 45 0c             	mov    0xc(%ebp),%eax
 410:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 413:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 41a:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 41d:	8d 41 01             	lea    0x1(%ecx),%eax
 420:	89 45 f4             	mov    %eax,-0xc(%ebp)
 423:	8b 5d 10             	mov    0x10(%ebp),%ebx
 426:	8b 45 ec             	mov    -0x14(%ebp),%eax
 429:	ba 00 00 00 00       	mov    $0x0,%edx
 42e:	f7 f3                	div    %ebx
 430:	89 d0                	mov    %edx,%eax
 432:	0f b6 80 c4 0a 00 00 	movzbl 0xac4(%eax),%eax
 439:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 43d:	8b 75 10             	mov    0x10(%ebp),%esi
 440:	8b 45 ec             	mov    -0x14(%ebp),%eax
 443:	ba 00 00 00 00       	mov    $0x0,%edx
 448:	f7 f6                	div    %esi
 44a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 44d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 451:	75 c7                	jne    41a <printint+0x39>
  if(neg)
 453:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 457:	74 10                	je     469 <printint+0x88>
    buf[i++] = '-';
 459:	8b 45 f4             	mov    -0xc(%ebp),%eax
 45c:	8d 50 01             	lea    0x1(%eax),%edx
 45f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 462:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 467:	eb 1f                	jmp    488 <printint+0xa7>
 469:	eb 1d                	jmp    488 <printint+0xa7>
    putc(fd, buf[i]);
 46b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 46e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 471:	01 d0                	add    %edx,%eax
 473:	0f b6 00             	movzbl (%eax),%eax
 476:	0f be c0             	movsbl %al,%eax
 479:	89 44 24 04          	mov    %eax,0x4(%esp)
 47d:	8b 45 08             	mov    0x8(%ebp),%eax
 480:	89 04 24             	mov    %eax,(%esp)
 483:	e8 0f ff ff ff       	call   397 <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 488:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 48c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 490:	79 d9                	jns    46b <printint+0x8a>
    putc(fd, buf[i]);
}
 492:	83 c4 30             	add    $0x30,%esp
 495:	5b                   	pop    %ebx
 496:	5e                   	pop    %esi
 497:	5d                   	pop    %ebp
 498:	c3                   	ret    

00000499 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 499:	55                   	push   %ebp
 49a:	89 e5                	mov    %esp,%ebp
 49c:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 49f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a6:	8d 45 0c             	lea    0xc(%ebp),%eax
 4a9:	83 c0 04             	add    $0x4,%eax
 4ac:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4af:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4b6:	e9 7c 01 00 00       	jmp    637 <printf+0x19e>
    c = fmt[i] & 0xff;
 4bb:	8b 55 0c             	mov    0xc(%ebp),%edx
 4be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c1:	01 d0                	add    %edx,%eax
 4c3:	0f b6 00             	movzbl (%eax),%eax
 4c6:	0f be c0             	movsbl %al,%eax
 4c9:	25 ff 00 00 00       	and    $0xff,%eax
 4ce:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d5:	75 2c                	jne    503 <printf+0x6a>
      if(c == '%'){
 4d7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4db:	75 0c                	jne    4e9 <printf+0x50>
        state = '%';
 4dd:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e4:	e9 4a 01 00 00       	jmp    633 <printf+0x19a>
      } else {
        putc(fd, c);
 4e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ec:	0f be c0             	movsbl %al,%eax
 4ef:	89 44 24 04          	mov    %eax,0x4(%esp)
 4f3:	8b 45 08             	mov    0x8(%ebp),%eax
 4f6:	89 04 24             	mov    %eax,(%esp)
 4f9:	e8 99 fe ff ff       	call   397 <putc>
 4fe:	e9 30 01 00 00       	jmp    633 <printf+0x19a>
      }
    } else if(state == '%'){
 503:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 507:	0f 85 26 01 00 00    	jne    633 <printf+0x19a>
      if(c == 'd'){
 50d:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 511:	75 2d                	jne    540 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 513:	8b 45 e8             	mov    -0x18(%ebp),%eax
 516:	8b 00                	mov    (%eax),%eax
 518:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 51f:	00 
 520:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 527:	00 
 528:	89 44 24 04          	mov    %eax,0x4(%esp)
 52c:	8b 45 08             	mov    0x8(%ebp),%eax
 52f:	89 04 24             	mov    %eax,(%esp)
 532:	e8 aa fe ff ff       	call   3e1 <printint>
        ap++;
 537:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53b:	e9 ec 00 00 00       	jmp    62c <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 540:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 544:	74 06                	je     54c <printf+0xb3>
 546:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54a:	75 2d                	jne    579 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 54c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54f:	8b 00                	mov    (%eax),%eax
 551:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 558:	00 
 559:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 560:	00 
 561:	89 44 24 04          	mov    %eax,0x4(%esp)
 565:	8b 45 08             	mov    0x8(%ebp),%eax
 568:	89 04 24             	mov    %eax,(%esp)
 56b:	e8 71 fe ff ff       	call   3e1 <printint>
        ap++;
 570:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 574:	e9 b3 00 00 00       	jmp    62c <printf+0x193>
      } else if(c == 's'){
 579:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 57d:	75 45                	jne    5c4 <printf+0x12b>
        s = (char*)*ap;
 57f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 582:	8b 00                	mov    (%eax),%eax
 584:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 587:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 58b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 58f:	75 09                	jne    59a <printf+0x101>
          s = "(null)";
 591:	c7 45 f4 79 08 00 00 	movl   $0x879,-0xc(%ebp)
        while(*s != 0){
 598:	eb 1e                	jmp    5b8 <printf+0x11f>
 59a:	eb 1c                	jmp    5b8 <printf+0x11f>
          putc(fd, *s);
 59c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59f:	0f b6 00             	movzbl (%eax),%eax
 5a2:	0f be c0             	movsbl %al,%eax
 5a5:	89 44 24 04          	mov    %eax,0x4(%esp)
 5a9:	8b 45 08             	mov    0x8(%ebp),%eax
 5ac:	89 04 24             	mov    %eax,(%esp)
 5af:	e8 e3 fd ff ff       	call   397 <putc>
          s++;
 5b4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 5b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bb:	0f b6 00             	movzbl (%eax),%eax
 5be:	84 c0                	test   %al,%al
 5c0:	75 da                	jne    59c <printf+0x103>
 5c2:	eb 68                	jmp    62c <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5c4:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c8:	75 1d                	jne    5e7 <printf+0x14e>
        putc(fd, *ap);
 5ca:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5cd:	8b 00                	mov    (%eax),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d6:	8b 45 08             	mov    0x8(%ebp),%eax
 5d9:	89 04 24             	mov    %eax,(%esp)
 5dc:	e8 b6 fd ff ff       	call   397 <putc>
        ap++;
 5e1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e5:	eb 45                	jmp    62c <printf+0x193>
      } else if(c == '%'){
 5e7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5eb:	75 17                	jne    604 <printf+0x16b>
        putc(fd, c);
 5ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f0:	0f be c0             	movsbl %al,%eax
 5f3:	89 44 24 04          	mov    %eax,0x4(%esp)
 5f7:	8b 45 08             	mov    0x8(%ebp),%eax
 5fa:	89 04 24             	mov    %eax,(%esp)
 5fd:	e8 95 fd ff ff       	call   397 <putc>
 602:	eb 28                	jmp    62c <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 604:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 60b:	00 
 60c:	8b 45 08             	mov    0x8(%ebp),%eax
 60f:	89 04 24             	mov    %eax,(%esp)
 612:	e8 80 fd ff ff       	call   397 <putc>
        putc(fd, c);
 617:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 61a:	0f be c0             	movsbl %al,%eax
 61d:	89 44 24 04          	mov    %eax,0x4(%esp)
 621:	8b 45 08             	mov    0x8(%ebp),%eax
 624:	89 04 24             	mov    %eax,(%esp)
 627:	e8 6b fd ff ff       	call   397 <putc>
      }
      state = 0;
 62c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 633:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 637:	8b 55 0c             	mov    0xc(%ebp),%edx
 63a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63d:	01 d0                	add    %edx,%eax
 63f:	0f b6 00             	movzbl (%eax),%eax
 642:	84 c0                	test   %al,%al
 644:	0f 85 71 fe ff ff    	jne    4bb <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 64a:	c9                   	leave  
 64b:	c3                   	ret    

0000064c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 64c:	55                   	push   %ebp
 64d:	89 e5                	mov    %esp,%ebp
 64f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	83 e8 08             	sub    $0x8,%eax
 658:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65b:	a1 e0 0a 00 00       	mov    0xae0,%eax
 660:	89 45 fc             	mov    %eax,-0x4(%ebp)
 663:	eb 24                	jmp    689 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 66d:	77 12                	ja     681 <free+0x35>
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 24                	ja     69b <free+0x4f>
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 67f:	77 1a                	ja     69b <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	89 45 fc             	mov    %eax,-0x4(%ebp)
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68f:	76 d4                	jbe    665 <free+0x19>
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 699:	76 ca                	jbe    665 <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ab:	01 c2                	add    %eax,%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	39 c2                	cmp    %eax,%edx
 6b4:	75 24                	jne    6da <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	8b 50 04             	mov    0x4(%eax),%edx
 6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bf:	8b 00                	mov    (%eax),%eax
 6c1:	8b 40 04             	mov    0x4(%eax),%eax
 6c4:	01 c2                	add    %eax,%edx
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 00                	mov    (%eax),%eax
 6d1:	8b 10                	mov    (%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	89 10                	mov    %edx,(%eax)
 6d8:	eb 0a                	jmp    6e4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 40 04             	mov    0x4(%eax),%eax
 6ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	01 d0                	add    %edx,%eax
 6f6:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 6f9:	75 20                	jne    71b <free+0xcf>
    p->s.size += bp->s.size;
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	8b 50 04             	mov    0x4(%eax),%edx
 701:	8b 45 f8             	mov    -0x8(%ebp),%eax
 704:	8b 40 04             	mov    0x4(%eax),%eax
 707:	01 c2                	add    %eax,%edx
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 712:	8b 10                	mov    (%eax),%edx
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	89 10                	mov    %edx,(%eax)
 719:	eb 08                	jmp    723 <free+0xd7>
  } else
    p->s.ptr = bp;
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 721:	89 10                	mov    %edx,(%eax)
  freep = p;
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	a3 e0 0a 00 00       	mov    %eax,0xae0
}
 72b:	c9                   	leave  
 72c:	c3                   	ret    

0000072d <morecore>:

static Header*
morecore(uint nu)
{
 72d:	55                   	push   %ebp
 72e:	89 e5                	mov    %esp,%ebp
 730:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 733:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 73a:	77 07                	ja     743 <morecore+0x16>
    nu = 4096;
 73c:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 743:	8b 45 08             	mov    0x8(%ebp),%eax
 746:	c1 e0 03             	shl    $0x3,%eax
 749:	89 04 24             	mov    %eax,(%esp)
 74c:	e8 06 fc ff ff       	call   357 <sbrk>
 751:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 754:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 758:	75 07                	jne    761 <morecore+0x34>
    return 0;
 75a:	b8 00 00 00 00       	mov    $0x0,%eax
 75f:	eb 22                	jmp    783 <morecore+0x56>
  hp = (Header*)p;
 761:	8b 45 f4             	mov    -0xc(%ebp),%eax
 764:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 767:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76a:	8b 55 08             	mov    0x8(%ebp),%edx
 76d:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	83 c0 08             	add    $0x8,%eax
 776:	89 04 24             	mov    %eax,(%esp)
 779:	e8 ce fe ff ff       	call   64c <free>
  return freep;
 77e:	a1 e0 0a 00 00       	mov    0xae0,%eax
}
 783:	c9                   	leave  
 784:	c3                   	ret    

00000785 <malloc>:

void*
malloc(uint nbytes)
{
 785:	55                   	push   %ebp
 786:	89 e5                	mov    %esp,%ebp
 788:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 78b:	8b 45 08             	mov    0x8(%ebp),%eax
 78e:	83 c0 07             	add    $0x7,%eax
 791:	c1 e8 03             	shr    $0x3,%eax
 794:	83 c0 01             	add    $0x1,%eax
 797:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 79a:	a1 e0 0a 00 00       	mov    0xae0,%eax
 79f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a6:	75 23                	jne    7cb <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a8:	c7 45 f0 d8 0a 00 00 	movl   $0xad8,-0x10(%ebp)
 7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b2:	a3 e0 0a 00 00       	mov    %eax,0xae0
 7b7:	a1 e0 0a 00 00       	mov    0xae0,%eax
 7bc:	a3 d8 0a 00 00       	mov    %eax,0xad8
    base.s.size = 0;
 7c1:	c7 05 dc 0a 00 00 00 	movl   $0x0,0xadc
 7c8:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ce:	8b 00                	mov    (%eax),%eax
 7d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d6:	8b 40 04             	mov    0x4(%eax),%eax
 7d9:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7dc:	72 4d                	jb     82b <malloc+0xa6>
      if(p->s.size == nunits)
 7de:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e1:	8b 40 04             	mov    0x4(%eax),%eax
 7e4:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 7e7:	75 0c                	jne    7f5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ec:	8b 10                	mov    (%eax),%edx
 7ee:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7f1:	89 10                	mov    %edx,(%eax)
 7f3:	eb 26                	jmp    81b <malloc+0x96>
      else {
        p->s.size -= nunits;
 7f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f8:	8b 40 04             	mov    0x4(%eax),%eax
 7fb:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7fe:	89 c2                	mov    %eax,%edx
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 806:	8b 45 f4             	mov    -0xc(%ebp),%eax
 809:	8b 40 04             	mov    0x4(%eax),%eax
 80c:	c1 e0 03             	shl    $0x3,%eax
 80f:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 812:	8b 45 f4             	mov    -0xc(%ebp),%eax
 815:	8b 55 ec             	mov    -0x14(%ebp),%edx
 818:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 81b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81e:	a3 e0 0a 00 00       	mov    %eax,0xae0
      return (void*)(p + 1);
 823:	8b 45 f4             	mov    -0xc(%ebp),%eax
 826:	83 c0 08             	add    $0x8,%eax
 829:	eb 38                	jmp    863 <malloc+0xde>
    }
    if(p == freep)
 82b:	a1 e0 0a 00 00       	mov    0xae0,%eax
 830:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 833:	75 1b                	jne    850 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 835:	8b 45 ec             	mov    -0x14(%ebp),%eax
 838:	89 04 24             	mov    %eax,(%esp)
 83b:	e8 ed fe ff ff       	call   72d <morecore>
 840:	89 45 f4             	mov    %eax,-0xc(%ebp)
 843:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 847:	75 07                	jne    850 <malloc+0xcb>
        return 0;
 849:	b8 00 00 00 00       	mov    $0x0,%eax
 84e:	eb 13                	jmp    863 <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	89 45 f0             	mov    %eax,-0x10(%ebp)
 856:	8b 45 f4             	mov    -0xc(%ebp),%eax
 859:	8b 00                	mov    (%eax),%eax
 85b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 85e:	e9 70 ff ff ff       	jmp    7d3 <malloc+0x4e>
}
 863:	c9                   	leave  
 864:	c3                   	ret    
