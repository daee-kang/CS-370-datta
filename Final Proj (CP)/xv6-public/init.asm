
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
   9:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  10:	00 
  11:	c7 04 24 10 09 00 00 	movl   $0x910,(%esp)
  18:	e8 9a 03 00 00       	call   3b7 <open>
  1d:	85 c0                	test   %eax,%eax
  1f:	79 30                	jns    51 <main+0x51>
    mknod("console", 1, 1);
  21:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  28:	00 
  29:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
  30:	00 
  31:	c7 04 24 10 09 00 00 	movl   $0x910,(%esp)
  38:	e8 82 03 00 00       	call   3bf <mknod>
    open("console", O_RDWR);
  3d:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
  44:	00 
  45:	c7 04 24 10 09 00 00 	movl   $0x910,(%esp)
  4c:	e8 66 03 00 00       	call   3b7 <open>
  }
  dup(0);  // stdout
  51:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  58:	e8 92 03 00 00       	call   3ef <dup>
  dup(0);  // stderr
  5d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  64:	e8 86 03 00 00       	call   3ef <dup>

  for(;;){
    printf(1, "init: starting sh\n");
  69:	c7 44 24 04 18 09 00 	movl   $0x918,0x4(%esp)
  70:	00 
  71:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  78:	e8 c4 04 00 00       	call   541 <printf>
    pid = fork();
  7d:	e8 ed 02 00 00       	call   36f <fork>
  82:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    if(pid < 0){
  86:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  8b:	79 19                	jns    a6 <main+0xa6>
      printf(1, "init: fork failed\n");
  8d:	c7 44 24 04 2b 09 00 	movl   $0x92b,0x4(%esp)
  94:	00 
  95:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  9c:	e8 a0 04 00 00       	call   541 <printf>
      exit();
  a1:	e8 d1 02 00 00       	call   377 <exit>
    }
    if(pid == 0){
  a6:	83 7c 24 1c 00       	cmpl   $0x0,0x1c(%esp)
  ab:	75 2d                	jne    da <main+0xda>
      exec("sh", argv);
  ad:	c7 44 24 04 a8 0b 00 	movl   $0xba8,0x4(%esp)
  b4:	00 
  b5:	c7 04 24 0d 09 00 00 	movl   $0x90d,(%esp)
  bc:	e8 ee 02 00 00       	call   3af <exec>
      printf(1, "init: exec sh failed\n");
  c1:	c7 44 24 04 3e 09 00 	movl   $0x93e,0x4(%esp)
  c8:	00 
  c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  d0:	e8 6c 04 00 00       	call   541 <printf>
      exit();
  d5:	e8 9d 02 00 00       	call   377 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  da:	eb 14                	jmp    f0 <main+0xf0>
      printf(1, "zombie!\n");
  dc:	c7 44 24 04 54 09 00 	movl   $0x954,0x4(%esp)
  e3:	00 
  e4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
  eb:	e8 51 04 00 00       	call   541 <printf>
    if(pid == 0){
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  f0:	e8 8a 02 00 00       	call   37f <wait>
  f5:	89 44 24 18          	mov    %eax,0x18(%esp)
  f9:	83 7c 24 18 00       	cmpl   $0x0,0x18(%esp)
  fe:	78 0a                	js     10a <main+0x10a>
 100:	8b 44 24 18          	mov    0x18(%esp),%eax
 104:	3b 44 24 1c          	cmp    0x1c(%esp),%eax
 108:	75 d2                	jne    dc <main+0xdc>
      printf(1, "zombie!\n");
  }
 10a:	e9 5a ff ff ff       	jmp    69 <main+0x69>

0000010f <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 10f:	55                   	push   %ebp
 110:	89 e5                	mov    %esp,%ebp
 112:	57                   	push   %edi
 113:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 114:	8b 4d 08             	mov    0x8(%ebp),%ecx
 117:	8b 55 10             	mov    0x10(%ebp),%edx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 cb                	mov    %ecx,%ebx
 11f:	89 df                	mov    %ebx,%edi
 121:	89 d1                	mov    %edx,%ecx
 123:	fc                   	cld    
 124:	f3 aa                	rep stos %al,%es:(%edi)
 126:	89 ca                	mov    %ecx,%edx
 128:	89 fb                	mov    %edi,%ebx
 12a:	89 5d 08             	mov    %ebx,0x8(%ebp)
 12d:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 130:	5b                   	pop    %ebx
 131:	5f                   	pop    %edi
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    

00000134 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 13a:	8b 45 08             	mov    0x8(%ebp),%eax
 13d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 140:	90                   	nop
 141:	8b 45 08             	mov    0x8(%ebp),%eax
 144:	8d 50 01             	lea    0x1(%eax),%edx
 147:	89 55 08             	mov    %edx,0x8(%ebp)
 14a:	8b 55 0c             	mov    0xc(%ebp),%edx
 14d:	8d 4a 01             	lea    0x1(%edx),%ecx
 150:	89 4d 0c             	mov    %ecx,0xc(%ebp)
 153:	0f b6 12             	movzbl (%edx),%edx
 156:	88 10                	mov    %dl,(%eax)
 158:	0f b6 00             	movzbl (%eax),%eax
 15b:	84 c0                	test   %al,%al
 15d:	75 e2                	jne    141 <strcpy+0xd>
    ;
  return os;
 15f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 162:	c9                   	leave  
 163:	c3                   	ret    

00000164 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 167:	eb 08                	jmp    171 <strcmp+0xd>
    p++, q++;
 169:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16d:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
 171:	8b 45 08             	mov    0x8(%ebp),%eax
 174:	0f b6 00             	movzbl (%eax),%eax
 177:	84 c0                	test   %al,%al
 179:	74 10                	je     18b <strcmp+0x27>
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	0f b6 10             	movzbl (%eax),%edx
 181:	8b 45 0c             	mov    0xc(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	38 c2                	cmp    %al,%dl
 189:	74 de                	je     169 <strcmp+0x5>
    p++, q++;
  return (uchar)*p - (uchar)*q;
 18b:	8b 45 08             	mov    0x8(%ebp),%eax
 18e:	0f b6 00             	movzbl (%eax),%eax
 191:	0f b6 d0             	movzbl %al,%edx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	0f b6 c0             	movzbl %al,%eax
 19d:	29 c2                	sub    %eax,%edx
 19f:	89 d0                	mov    %edx,%eax
}
 1a1:	5d                   	pop    %ebp
 1a2:	c3                   	ret    

000001a3 <strlen>:

uint
strlen(const char *s)
{
 1a3:	55                   	push   %ebp
 1a4:	89 e5                	mov    %esp,%ebp
 1a6:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1b0:	eb 04                	jmp    1b6 <strlen+0x13>
 1b2:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b9:	8b 45 08             	mov    0x8(%ebp),%eax
 1bc:	01 d0                	add    %edx,%eax
 1be:	0f b6 00             	movzbl (%eax),%eax
 1c1:	84 c0                	test   %al,%al
 1c3:	75 ed                	jne    1b2 <strlen+0xf>
    ;
  return n;
 1c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c8:	c9                   	leave  
 1c9:	c3                   	ret    

000001ca <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ca:	55                   	push   %ebp
 1cb:	89 e5                	mov    %esp,%ebp
 1cd:	83 ec 0c             	sub    $0xc,%esp
  stosb(dst, c, n);
 1d0:	8b 45 10             	mov    0x10(%ebp),%eax
 1d3:	89 44 24 08          	mov    %eax,0x8(%esp)
 1d7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1da:	89 44 24 04          	mov    %eax,0x4(%esp)
 1de:	8b 45 08             	mov    0x8(%ebp),%eax
 1e1:	89 04 24             	mov    %eax,(%esp)
 1e4:	e8 26 ff ff ff       	call   10f <stosb>
  return dst;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ec:	c9                   	leave  
 1ed:	c3                   	ret    

000001ee <strchr>:

char*
strchr(const char *s, char c)
{
 1ee:	55                   	push   %ebp
 1ef:	89 e5                	mov    %esp,%ebp
 1f1:	83 ec 04             	sub    $0x4,%esp
 1f4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1f7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1fa:	eb 14                	jmp    210 <strchr+0x22>
    if(*s == c)
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	0f b6 00             	movzbl (%eax),%eax
 202:	3a 45 fc             	cmp    -0x4(%ebp),%al
 205:	75 05                	jne    20c <strchr+0x1e>
      return (char*)s;
 207:	8b 45 08             	mov    0x8(%ebp),%eax
 20a:	eb 13                	jmp    21f <strchr+0x31>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 20c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	0f b6 00             	movzbl (%eax),%eax
 216:	84 c0                	test   %al,%al
 218:	75 e2                	jne    1fc <strchr+0xe>
    if(*s == c)
      return (char*)s;
  return 0;
 21a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 21f:	c9                   	leave  
 220:	c3                   	ret    

00000221 <gets>:

char*
gets(char *buf, int max)
{
 221:	55                   	push   %ebp
 222:	89 e5                	mov    %esp,%ebp
 224:	83 ec 28             	sub    $0x28,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 227:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 22e:	eb 4c                	jmp    27c <gets+0x5b>
    cc = read(0, &c, 1);
 230:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 237:	00 
 238:	8d 45 ef             	lea    -0x11(%ebp),%eax
 23b:	89 44 24 04          	mov    %eax,0x4(%esp)
 23f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 246:	e8 44 01 00 00       	call   38f <read>
 24b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 252:	7f 02                	jg     256 <gets+0x35>
      break;
 254:	eb 31                	jmp    287 <gets+0x66>
    buf[i++] = c;
 256:	8b 45 f4             	mov    -0xc(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25f:	89 c2                	mov    %eax,%edx
 261:	8b 45 08             	mov    0x8(%ebp),%eax
 264:	01 c2                	add    %eax,%edx
 266:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 270:	3c 0a                	cmp    $0xa,%al
 272:	74 13                	je     287 <gets+0x66>
 274:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 278:	3c 0d                	cmp    $0xd,%al
 27a:	74 0b                	je     287 <gets+0x66>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 27c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27f:	83 c0 01             	add    $0x1,%eax
 282:	3b 45 0c             	cmp    0xc(%ebp),%eax
 285:	7c a9                	jl     230 <gets+0xf>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 287:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	01 d0                	add    %edx,%eax
 28f:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 292:	8b 45 08             	mov    0x8(%ebp),%eax
}
 295:	c9                   	leave  
 296:	c3                   	ret    

00000297 <stat>:

int
stat(const char *n, struct stat *st)
{
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	83 ec 28             	sub    $0x28,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 2a4:	00 
 2a5:	8b 45 08             	mov    0x8(%ebp),%eax
 2a8:	89 04 24             	mov    %eax,(%esp)
 2ab:	e8 07 01 00 00       	call   3b7 <open>
 2b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b7:	79 07                	jns    2c0 <stat+0x29>
    return -1;
 2b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2be:	eb 23                	jmp    2e3 <stat+0x4c>
  r = fstat(fd, st);
 2c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 2c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2ca:	89 04 24             	mov    %eax,(%esp)
 2cd:	e8 fd 00 00 00       	call   3cf <fstat>
 2d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2d8:	89 04 24             	mov    %eax,(%esp)
 2db:	e8 bf 00 00 00       	call   39f <close>
  return r;
 2e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    

000002e5 <atoi>:

int
atoi(const char *s)
{
 2e5:	55                   	push   %ebp
 2e6:	89 e5                	mov    %esp,%ebp
 2e8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f2:	eb 25                	jmp    319 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f7:	89 d0                	mov    %edx,%eax
 2f9:	c1 e0 02             	shl    $0x2,%eax
 2fc:	01 d0                	add    %edx,%eax
 2fe:	01 c0                	add    %eax,%eax
 300:	89 c1                	mov    %eax,%ecx
 302:	8b 45 08             	mov    0x8(%ebp),%eax
 305:	8d 50 01             	lea    0x1(%eax),%edx
 308:	89 55 08             	mov    %edx,0x8(%ebp)
 30b:	0f b6 00             	movzbl (%eax),%eax
 30e:	0f be c0             	movsbl %al,%eax
 311:	01 c8                	add    %ecx,%eax
 313:	83 e8 30             	sub    $0x30,%eax
 316:	89 45 fc             	mov    %eax,-0x4(%ebp)
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	0f b6 00             	movzbl (%eax),%eax
 31f:	3c 2f                	cmp    $0x2f,%al
 321:	7e 0a                	jle    32d <atoi+0x48>
 323:	8b 45 08             	mov    0x8(%ebp),%eax
 326:	0f b6 00             	movzbl (%eax),%eax
 329:	3c 39                	cmp    $0x39,%al
 32b:	7e c7                	jle    2f4 <atoi+0xf>
    n = n*10 + *s++ - '0';
  return n;
 32d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 330:	c9                   	leave  
 331:	c3                   	ret    

00000332 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 332:	55                   	push   %ebp
 333:	89 e5                	mov    %esp,%ebp
 335:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 338:	8b 45 08             	mov    0x8(%ebp),%eax
 33b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33e:	8b 45 0c             	mov    0xc(%ebp),%eax
 341:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 344:	eb 17                	jmp    35d <memmove+0x2b>
    *dst++ = *src++;
 346:	8b 45 fc             	mov    -0x4(%ebp),%eax
 349:	8d 50 01             	lea    0x1(%eax),%edx
 34c:	89 55 fc             	mov    %edx,-0x4(%ebp)
 34f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 352:	8d 4a 01             	lea    0x1(%edx),%ecx
 355:	89 4d f8             	mov    %ecx,-0x8(%ebp)
 358:	0f b6 12             	movzbl (%edx),%edx
 35b:	88 10                	mov    %dl,(%eax)
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 35d:	8b 45 10             	mov    0x10(%ebp),%eax
 360:	8d 50 ff             	lea    -0x1(%eax),%edx
 363:	89 55 10             	mov    %edx,0x10(%ebp)
 366:	85 c0                	test   %eax,%eax
 368:	7f dc                	jg     346 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36d:	c9                   	leave  
 36e:	c3                   	ret    

0000036f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 36f:	b8 01 00 00 00       	mov    $0x1,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <exit>:
SYSCALL(exit)
 377:	b8 02 00 00 00       	mov    $0x2,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <wait>:
SYSCALL(wait)
 37f:	b8 03 00 00 00       	mov    $0x3,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <pipe>:
SYSCALL(pipe)
 387:	b8 04 00 00 00       	mov    $0x4,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <read>:
SYSCALL(read)
 38f:	b8 05 00 00 00       	mov    $0x5,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <write>:
SYSCALL(write)
 397:	b8 10 00 00 00       	mov    $0x10,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <close>:
SYSCALL(close)
 39f:	b8 15 00 00 00       	mov    $0x15,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <kill>:
SYSCALL(kill)
 3a7:	b8 06 00 00 00       	mov    $0x6,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <exec>:
SYSCALL(exec)
 3af:	b8 07 00 00 00       	mov    $0x7,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <open>:
SYSCALL(open)
 3b7:	b8 0f 00 00 00       	mov    $0xf,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <mknod>:
SYSCALL(mknod)
 3bf:	b8 11 00 00 00       	mov    $0x11,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <unlink>:
SYSCALL(unlink)
 3c7:	b8 12 00 00 00       	mov    $0x12,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <fstat>:
SYSCALL(fstat)
 3cf:	b8 08 00 00 00       	mov    $0x8,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <link>:
SYSCALL(link)
 3d7:	b8 13 00 00 00       	mov    $0x13,%eax
 3dc:	cd 40                	int    $0x40
 3de:	c3                   	ret    

000003df <mkdir>:
SYSCALL(mkdir)
 3df:	b8 14 00 00 00       	mov    $0x14,%eax
 3e4:	cd 40                	int    $0x40
 3e6:	c3                   	ret    

000003e7 <chdir>:
SYSCALL(chdir)
 3e7:	b8 09 00 00 00       	mov    $0x9,%eax
 3ec:	cd 40                	int    $0x40
 3ee:	c3                   	ret    

000003ef <dup>:
SYSCALL(dup)
 3ef:	b8 0a 00 00 00       	mov    $0xa,%eax
 3f4:	cd 40                	int    $0x40
 3f6:	c3                   	ret    

000003f7 <getpid>:
SYSCALL(getpid)
 3f7:	b8 0b 00 00 00       	mov    $0xb,%eax
 3fc:	cd 40                	int    $0x40
 3fe:	c3                   	ret    

000003ff <sbrk>:
SYSCALL(sbrk)
 3ff:	b8 0c 00 00 00       	mov    $0xc,%eax
 404:	cd 40                	int    $0x40
 406:	c3                   	ret    

00000407 <sleep>:
SYSCALL(sleep)
 407:	b8 0d 00 00 00       	mov    $0xd,%eax
 40c:	cd 40                	int    $0x40
 40e:	c3                   	ret    

0000040f <uptime>:
SYSCALL(uptime)
 40f:	b8 0e 00 00 00       	mov    $0xe,%eax
 414:	cd 40                	int    $0x40
 416:	c3                   	ret    

00000417 <time>:
SYSCALL(time)
 417:	b8 16 00 00 00       	mov    $0x16,%eax
 41c:	cd 40                	int    $0x40
 41e:	c3                   	ret    

0000041f <getDate>:
SYSCALL(getDate)
 41f:	b8 17 00 00 00       	mov    $0x17,%eax
 424:	cd 40                	int    $0x40
 426:	c3                   	ret    

00000427 <IOTime>:
SYSCALL(IOTime)
 427:	b8 18 00 00 00       	mov    $0x18,%eax
 42c:	cd 40                	int    $0x40
 42e:	c3                   	ret    

0000042f <wait2>:
SYSCALL(wait2)
 42f:	b8 19 00 00 00       	mov    $0x19,%eax
 434:	cd 40                	int    $0x40
 436:	c3                   	ret    

00000437 <fork2>:
SYSCALL(fork2)
 437:	b8 1a 00 00 00       	mov    $0x1a,%eax
 43c:	cd 40                	int    $0x40
 43e:	c3                   	ret    

0000043f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 43f:	55                   	push   %ebp
 440:	89 e5                	mov    %esp,%ebp
 442:	83 ec 28             	sub    $0x28,%esp
 445:	8b 45 0c             	mov    0xc(%ebp),%eax
 448:	88 45 e4             	mov    %al,-0x1c(%ebp)
  int start = uptime();
 44b:	e8 bf ff ff ff       	call   40f <uptime>
 450:	89 45 f4             	mov    %eax,-0xc(%ebp)
  write(fd, &c, 1);
 453:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 45a:	00 
 45b:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 45e:	89 44 24 04          	mov    %eax,0x4(%esp)
 462:	8b 45 08             	mov    0x8(%ebp),%eax
 465:	89 04 24             	mov    %eax,(%esp)
 468:	e8 2a ff ff ff       	call   397 <write>
  int end = uptime();
 46d:	e8 9d ff ff ff       	call   40f <uptime>
 472:	89 45 f0             	mov    %eax,-0x10(%ebp)
  IOTime(end - start);
 475:	8b 45 f4             	mov    -0xc(%ebp),%eax
 478:	8b 55 f0             	mov    -0x10(%ebp),%edx
 47b:	29 c2                	sub    %eax,%edx
 47d:	89 d0                	mov    %edx,%eax
 47f:	89 04 24             	mov    %eax,(%esp)
 482:	e8 a0 ff ff ff       	call   427 <IOTime>
}
 487:	c9                   	leave  
 488:	c3                   	ret    

00000489 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 489:	55                   	push   %ebp
 48a:	89 e5                	mov    %esp,%ebp
 48c:	56                   	push   %esi
 48d:	53                   	push   %ebx
 48e:	83 ec 30             	sub    $0x30,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 491:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 498:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 49c:	74 17                	je     4b5 <printint+0x2c>
 49e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4a2:	79 11                	jns    4b5 <printint+0x2c>
    neg = 1;
 4a4:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4ab:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ae:	f7 d8                	neg    %eax
 4b0:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4b3:	eb 06                	jmp    4bb <printint+0x32>
  } else {
    x = xx;
 4b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4c2:	8b 4d f4             	mov    -0xc(%ebp),%ecx
 4c5:	8d 41 01             	lea    0x1(%ecx),%eax
 4c8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4cb:	8b 5d 10             	mov    0x10(%ebp),%ebx
 4ce:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d1:	ba 00 00 00 00       	mov    $0x0,%edx
 4d6:	f7 f3                	div    %ebx
 4d8:	89 d0                	mov    %edx,%eax
 4da:	0f b6 80 b0 0b 00 00 	movzbl 0xbb0(%eax),%eax
 4e1:	88 44 0d dc          	mov    %al,-0x24(%ebp,%ecx,1)
  }while((x /= base) != 0);
 4e5:	8b 75 10             	mov    0x10(%ebp),%esi
 4e8:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4eb:	ba 00 00 00 00       	mov    $0x0,%edx
 4f0:	f7 f6                	div    %esi
 4f2:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4f5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f9:	75 c7                	jne    4c2 <printint+0x39>
  if(neg)
 4fb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 4ff:	74 10                	je     511 <printint+0x88>
    buf[i++] = '-';
 501:	8b 45 f4             	mov    -0xc(%ebp),%eax
 504:	8d 50 01             	lea    0x1(%eax),%edx
 507:	89 55 f4             	mov    %edx,-0xc(%ebp)
 50a:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 50f:	eb 1f                	jmp    530 <printint+0xa7>
 511:	eb 1d                	jmp    530 <printint+0xa7>
    putc(fd, buf[i]);
 513:	8d 55 dc             	lea    -0x24(%ebp),%edx
 516:	8b 45 f4             	mov    -0xc(%ebp),%eax
 519:	01 d0                	add    %edx,%eax
 51b:	0f b6 00             	movzbl (%eax),%eax
 51e:	0f be c0             	movsbl %al,%eax
 521:	89 44 24 04          	mov    %eax,0x4(%esp)
 525:	8b 45 08             	mov    0x8(%ebp),%eax
 528:	89 04 24             	mov    %eax,(%esp)
 52b:	e8 0f ff ff ff       	call   43f <putc>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 530:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 534:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 538:	79 d9                	jns    513 <printint+0x8a>
    putc(fd, buf[i]);
}
 53a:	83 c4 30             	add    $0x30,%esp
 53d:	5b                   	pop    %ebx
 53e:	5e                   	pop    %esi
 53f:	5d                   	pop    %ebp
 540:	c3                   	ret    

00000541 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 541:	55                   	push   %ebp
 542:	89 e5                	mov    %esp,%ebp
 544:	83 ec 38             	sub    $0x38,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 547:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 54e:	8d 45 0c             	lea    0xc(%ebp),%eax
 551:	83 c0 04             	add    $0x4,%eax
 554:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 557:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 55e:	e9 7c 01 00 00       	jmp    6df <printf+0x19e>
    c = fmt[i] & 0xff;
 563:	8b 55 0c             	mov    0xc(%ebp),%edx
 566:	8b 45 f0             	mov    -0x10(%ebp),%eax
 569:	01 d0                	add    %edx,%eax
 56b:	0f b6 00             	movzbl (%eax),%eax
 56e:	0f be c0             	movsbl %al,%eax
 571:	25 ff 00 00 00       	and    $0xff,%eax
 576:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 579:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 57d:	75 2c                	jne    5ab <printf+0x6a>
      if(c == '%'){
 57f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 583:	75 0c                	jne    591 <printf+0x50>
        state = '%';
 585:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 58c:	e9 4a 01 00 00       	jmp    6db <printf+0x19a>
      } else {
        putc(fd, c);
 591:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 594:	0f be c0             	movsbl %al,%eax
 597:	89 44 24 04          	mov    %eax,0x4(%esp)
 59b:	8b 45 08             	mov    0x8(%ebp),%eax
 59e:	89 04 24             	mov    %eax,(%esp)
 5a1:	e8 99 fe ff ff       	call   43f <putc>
 5a6:	e9 30 01 00 00       	jmp    6db <printf+0x19a>
      }
    } else if(state == '%'){
 5ab:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5af:	0f 85 26 01 00 00    	jne    6db <printf+0x19a>
      if(c == 'd'){
 5b5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5b9:	75 2d                	jne    5e8 <printf+0xa7>
        printint(fd, *ap, 10, 1);
 5bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5be:	8b 00                	mov    (%eax),%eax
 5c0:	c7 44 24 0c 01 00 00 	movl   $0x1,0xc(%esp)
 5c7:	00 
 5c8:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
 5cf:	00 
 5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
 5d4:	8b 45 08             	mov    0x8(%ebp),%eax
 5d7:	89 04 24             	mov    %eax,(%esp)
 5da:	e8 aa fe ff ff       	call   489 <printint>
        ap++;
 5df:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e3:	e9 ec 00 00 00       	jmp    6d4 <printf+0x193>
      } else if(c == 'x' || c == 'p'){
 5e8:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5ec:	74 06                	je     5f4 <printf+0xb3>
 5ee:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5f2:	75 2d                	jne    621 <printf+0xe0>
        printint(fd, *ap, 16, 0);
 5f4:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5f7:	8b 00                	mov    (%eax),%eax
 5f9:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
 600:	00 
 601:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
 608:	00 
 609:	89 44 24 04          	mov    %eax,0x4(%esp)
 60d:	8b 45 08             	mov    0x8(%ebp),%eax
 610:	89 04 24             	mov    %eax,(%esp)
 613:	e8 71 fe ff ff       	call   489 <printint>
        ap++;
 618:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61c:	e9 b3 00 00 00       	jmp    6d4 <printf+0x193>
      } else if(c == 's'){
 621:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 625:	75 45                	jne    66c <printf+0x12b>
        s = (char*)*ap;
 627:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62a:	8b 00                	mov    (%eax),%eax
 62c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 62f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 633:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 637:	75 09                	jne    642 <printf+0x101>
          s = "(null)";
 639:	c7 45 f4 5d 09 00 00 	movl   $0x95d,-0xc(%ebp)
        while(*s != 0){
 640:	eb 1e                	jmp    660 <printf+0x11f>
 642:	eb 1c                	jmp    660 <printf+0x11f>
          putc(fd, *s);
 644:	8b 45 f4             	mov    -0xc(%ebp),%eax
 647:	0f b6 00             	movzbl (%eax),%eax
 64a:	0f be c0             	movsbl %al,%eax
 64d:	89 44 24 04          	mov    %eax,0x4(%esp)
 651:	8b 45 08             	mov    0x8(%ebp),%eax
 654:	89 04 24             	mov    %eax,(%esp)
 657:	e8 e3 fd ff ff       	call   43f <putc>
          s++;
 65c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 660:	8b 45 f4             	mov    -0xc(%ebp),%eax
 663:	0f b6 00             	movzbl (%eax),%eax
 666:	84 c0                	test   %al,%al
 668:	75 da                	jne    644 <printf+0x103>
 66a:	eb 68                	jmp    6d4 <printf+0x193>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 66c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 670:	75 1d                	jne    68f <printf+0x14e>
        putc(fd, *ap);
 672:	8b 45 e8             	mov    -0x18(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	89 44 24 04          	mov    %eax,0x4(%esp)
 67e:	8b 45 08             	mov    0x8(%ebp),%eax
 681:	89 04 24             	mov    %eax,(%esp)
 684:	e8 b6 fd ff ff       	call   43f <putc>
        ap++;
 689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68d:	eb 45                	jmp    6d4 <printf+0x193>
      } else if(c == '%'){
 68f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 693:	75 17                	jne    6ac <printf+0x16b>
        putc(fd, c);
 695:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 698:	0f be c0             	movsbl %al,%eax
 69b:	89 44 24 04          	mov    %eax,0x4(%esp)
 69f:	8b 45 08             	mov    0x8(%ebp),%eax
 6a2:	89 04 24             	mov    %eax,(%esp)
 6a5:	e8 95 fd ff ff       	call   43f <putc>
 6aa:	eb 28                	jmp    6d4 <printf+0x193>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ac:	c7 44 24 04 25 00 00 	movl   $0x25,0x4(%esp)
 6b3:	00 
 6b4:	8b 45 08             	mov    0x8(%ebp),%eax
 6b7:	89 04 24             	mov    %eax,(%esp)
 6ba:	e8 80 fd ff ff       	call   43f <putc>
        putc(fd, c);
 6bf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6c2:	0f be c0             	movsbl %al,%eax
 6c5:	89 44 24 04          	mov    %eax,0x4(%esp)
 6c9:	8b 45 08             	mov    0x8(%ebp),%eax
 6cc:	89 04 24             	mov    %eax,(%esp)
 6cf:	e8 6b fd ff ff       	call   43f <putc>
      }
      state = 0;
 6d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 6db:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6df:	8b 55 0c             	mov    0xc(%ebp),%edx
 6e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e5:	01 d0                	add    %edx,%eax
 6e7:	0f b6 00             	movzbl (%eax),%eax
 6ea:	84 c0                	test   %al,%al
 6ec:	0f 85 71 fe ff ff    	jne    563 <printf+0x22>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 6f2:	c9                   	leave  
 6f3:	c3                   	ret    

000006f4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6f4:	55                   	push   %ebp
 6f5:	89 e5                	mov    %esp,%ebp
 6f7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6fa:	8b 45 08             	mov    0x8(%ebp),%eax
 6fd:	83 e8 08             	sub    $0x8,%eax
 700:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 703:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 708:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70b:	eb 24                	jmp    731 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 70d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 710:	8b 00                	mov    (%eax),%eax
 712:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 715:	77 12                	ja     729 <free+0x35>
 717:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71d:	77 24                	ja     743 <free+0x4f>
 71f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 722:	8b 00                	mov    (%eax),%eax
 724:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 727:	77 1a                	ja     743 <free+0x4f>
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	8b 00                	mov    (%eax),%eax
 72e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 731:	8b 45 f8             	mov    -0x8(%ebp),%eax
 734:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 737:	76 d4                	jbe    70d <free+0x19>
 739:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73c:	8b 00                	mov    (%eax),%eax
 73e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 741:	76 ca                	jbe    70d <free+0x19>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	8b 40 04             	mov    0x4(%eax),%eax
 749:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 750:	8b 45 f8             	mov    -0x8(%ebp),%eax
 753:	01 c2                	add    %eax,%edx
 755:	8b 45 fc             	mov    -0x4(%ebp),%eax
 758:	8b 00                	mov    (%eax),%eax
 75a:	39 c2                	cmp    %eax,%edx
 75c:	75 24                	jne    782 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 75e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 761:	8b 50 04             	mov    0x4(%eax),%edx
 764:	8b 45 fc             	mov    -0x4(%ebp),%eax
 767:	8b 00                	mov    (%eax),%eax
 769:	8b 40 04             	mov    0x4(%eax),%eax
 76c:	01 c2                	add    %eax,%edx
 76e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 771:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 774:	8b 45 fc             	mov    -0x4(%ebp),%eax
 777:	8b 00                	mov    (%eax),%eax
 779:	8b 10                	mov    (%eax),%edx
 77b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77e:	89 10                	mov    %edx,(%eax)
 780:	eb 0a                	jmp    78c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 782:	8b 45 fc             	mov    -0x4(%ebp),%eax
 785:	8b 10                	mov    (%eax),%edx
 787:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 78c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78f:	8b 40 04             	mov    0x4(%eax),%eax
 792:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 799:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79c:	01 d0                	add    %edx,%eax
 79e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
 7a1:	75 20                	jne    7c3 <free+0xcf>
    p->s.size += bp->s.size;
 7a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a6:	8b 50 04             	mov    0x4(%eax),%edx
 7a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ac:	8b 40 04             	mov    0x4(%eax),%eax
 7af:	01 c2                	add    %eax,%edx
 7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ba:	8b 10                	mov    (%eax),%edx
 7bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bf:	89 10                	mov    %edx,(%eax)
 7c1:	eb 08                	jmp    7cb <free+0xd7>
  } else
    p->s.ptr = bp;
 7c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c9:	89 10                	mov    %edx,(%eax)
  freep = p;
 7cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ce:	a3 cc 0b 00 00       	mov    %eax,0xbcc
}
 7d3:	c9                   	leave  
 7d4:	c3                   	ret    

000007d5 <morecore>:

static Header*
morecore(uint nu)
{
 7d5:	55                   	push   %ebp
 7d6:	89 e5                	mov    %esp,%ebp
 7d8:	83 ec 28             	sub    $0x28,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7db:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e2:	77 07                	ja     7eb <morecore+0x16>
    nu = 4096;
 7e4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7eb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ee:	c1 e0 03             	shl    $0x3,%eax
 7f1:	89 04 24             	mov    %eax,(%esp)
 7f4:	e8 06 fc ff ff       	call   3ff <sbrk>
 7f9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7fc:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 800:	75 07                	jne    809 <morecore+0x34>
    return 0;
 802:	b8 00 00 00 00       	mov    $0x0,%eax
 807:	eb 22                	jmp    82b <morecore+0x56>
  hp = (Header*)p;
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 812:	8b 55 08             	mov    0x8(%ebp),%edx
 815:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 818:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81b:	83 c0 08             	add    $0x8,%eax
 81e:	89 04 24             	mov    %eax,(%esp)
 821:	e8 ce fe ff ff       	call   6f4 <free>
  return freep;
 826:	a1 cc 0b 00 00       	mov    0xbcc,%eax
}
 82b:	c9                   	leave  
 82c:	c3                   	ret    

0000082d <malloc>:

void*
malloc(uint nbytes)
{
 82d:	55                   	push   %ebp
 82e:	89 e5                	mov    %esp,%ebp
 830:	83 ec 28             	sub    $0x28,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 833:	8b 45 08             	mov    0x8(%ebp),%eax
 836:	83 c0 07             	add    $0x7,%eax
 839:	c1 e8 03             	shr    $0x3,%eax
 83c:	83 c0 01             	add    $0x1,%eax
 83f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 842:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 847:	89 45 f0             	mov    %eax,-0x10(%ebp)
 84a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 84e:	75 23                	jne    873 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 850:	c7 45 f0 c4 0b 00 00 	movl   $0xbc4,-0x10(%ebp)
 857:	8b 45 f0             	mov    -0x10(%ebp),%eax
 85a:	a3 cc 0b 00 00       	mov    %eax,0xbcc
 85f:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 864:	a3 c4 0b 00 00       	mov    %eax,0xbc4
    base.s.size = 0;
 869:	c7 05 c8 0b 00 00 00 	movl   $0x0,0xbc8
 870:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 873:	8b 45 f0             	mov    -0x10(%ebp),%eax
 876:	8b 00                	mov    (%eax),%eax
 878:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 87b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87e:	8b 40 04             	mov    0x4(%eax),%eax
 881:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 884:	72 4d                	jb     8d3 <malloc+0xa6>
      if(p->s.size == nunits)
 886:	8b 45 f4             	mov    -0xc(%ebp),%eax
 889:	8b 40 04             	mov    0x4(%eax),%eax
 88c:	3b 45 ec             	cmp    -0x14(%ebp),%eax
 88f:	75 0c                	jne    89d <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 891:	8b 45 f4             	mov    -0xc(%ebp),%eax
 894:	8b 10                	mov    (%eax),%edx
 896:	8b 45 f0             	mov    -0x10(%ebp),%eax
 899:	89 10                	mov    %edx,(%eax)
 89b:	eb 26                	jmp    8c3 <malloc+0x96>
      else {
        p->s.size -= nunits;
 89d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a0:	8b 40 04             	mov    0x4(%eax),%eax
 8a3:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8a6:	89 c2                	mov    %eax,%edx
 8a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ab:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b1:	8b 40 04             	mov    0x4(%eax),%eax
 8b4:	c1 e0 03             	shl    $0x3,%eax
 8b7:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bd:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c0:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c6:	a3 cc 0b 00 00       	mov    %eax,0xbcc
      return (void*)(p + 1);
 8cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ce:	83 c0 08             	add    $0x8,%eax
 8d1:	eb 38                	jmp    90b <malloc+0xde>
    }
    if(p == freep)
 8d3:	a1 cc 0b 00 00       	mov    0xbcc,%eax
 8d8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8db:	75 1b                	jne    8f8 <malloc+0xcb>
      if((p = morecore(nunits)) == 0)
 8dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
 8e0:	89 04 24             	mov    %eax,(%esp)
 8e3:	e8 ed fe ff ff       	call   7d5 <morecore>
 8e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8ef:	75 07                	jne    8f8 <malloc+0xcb>
        return 0;
 8f1:	b8 00 00 00 00       	mov    $0x0,%eax
 8f6:	eb 13                	jmp    90b <malloc+0xde>
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 901:	8b 00                	mov    (%eax),%eax
 903:	89 45 f4             	mov    %eax,-0xc(%ebp)
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
 906:	e9 70 ff ff ff       	jmp    87b <malloc+0x4e>
}
 90b:	c9                   	leave  
 90c:	c3                   	ret    
