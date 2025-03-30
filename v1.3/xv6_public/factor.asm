
_factor:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
    }
    return;
}

int main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 34             	sub    $0x34,%esp
  18:	8b 41 04             	mov    0x4(%ecx),%eax
    int a = atoi(argv[1]);
  1b:	ff 70 04             	pushl  0x4(%eax)
  1e:	e8 3d 03 00 00       	call   360 <atoi>
    unlink("factor_result.txt");
  23:	c7 04 24 d8 08 00 00 	movl   $0x8d8,(%esp)
    int a = atoi(argv[1]);
  2a:	89 c6                	mov    %eax,%esi
    unlink("factor_result.txt");
  2c:	e8 f2 03 00 00       	call   423 <unlink>
    int fd = open("factor_result.txt", O_CREATE | O_RDWR);
  31:	58                   	pop    %eax
  32:	5a                   	pop    %edx
  33:	68 02 02 00 00       	push   $0x202
  38:	68 d8 08 00 00       	push   $0x8d8
  3d:	e8 d1 03 00 00       	call   413 <open>
    for(int i = 1; i <= a; i++)
  42:	83 c4 10             	add    $0x10,%esp
    int fd = open("factor_result.txt", O_CREATE | O_RDWR);
  45:	89 45 d0             	mov    %eax,-0x30(%ebp)
    for(int i = 1; i <= a; i++)
  48:	85 f6                	test   %esi,%esi
  4a:	7e 66                	jle    b2 <main+0xb2>
  4c:	8d 46 01             	lea    0x1(%esi),%eax
  4f:	bb 01 00 00 00       	mov    $0x1,%ebx
  54:	8d 7d de             	lea    -0x22(%ebp),%edi
  57:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  5a:	eb 0c                	jmp    68 <main+0x68>
  5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  60:	83 c3 01             	add    $0x1,%ebx
  63:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
  66:	74 4a                	je     b2 <main+0xb2>
        if(a % i == 0){
  68:	89 f0                	mov    %esi,%eax
  6a:	99                   	cltd   
  6b:	f7 fb                	idiv   %ebx
  6d:	85 d2                	test   %edx,%edx
  6f:	75 ef                	jne    60 <main+0x60>
    if (base < 2 || base > 36) { *result = '\0'; return; }
  71:	b9 0a 00 00 00       	mov    $0xa,%ecx
  76:	89 fa                	mov    %edi,%edx
  78:	89 d8                	mov    %ebx,%eax
    for(int i = 1; i <= a; i++)
  7a:	83 c3 01             	add    $0x1,%ebx
  7d:	e8 4e 00 00 00       	call   d0 <convert_to_string.part.0>
            char ans[10];
            convert_to_string(i, ans, 10);
            write(fd, ans, strlen(ans));
  82:	83 ec 0c             	sub    $0xc,%esp
  85:	57                   	push   %edi
  86:	e8 65 01 00 00       	call   1f0 <strlen>
  8b:	83 c4 0c             	add    $0xc,%esp
  8e:	50                   	push   %eax
  8f:	57                   	push   %edi
  90:	ff 75 d0             	pushl  -0x30(%ebp)
  93:	e8 5b 03 00 00       	call   3f3 <write>
            write(fd, " ", 1);
  98:	83 c4 0c             	add    $0xc,%esp
  9b:	6a 01                	push   $0x1
  9d:	68 ea 08 00 00       	push   $0x8ea
  a2:	ff 75 d0             	pushl  -0x30(%ebp)
  a5:	e8 49 03 00 00       	call   3f3 <write>
  aa:	83 c4 10             	add    $0x10,%esp
    for(int i = 1; i <= a; i++)
  ad:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
  b0:	75 b6                	jne    68 <main+0x68>
        }
    write(fd, "\n", 1);
  b2:	83 ec 04             	sub    $0x4,%esp
  b5:	6a 01                	push   $0x1
  b7:	68 ec 08 00 00       	push   $0x8ec
  bc:	ff 75 d0             	pushl  -0x30(%ebp)
  bf:	e8 2f 03 00 00       	call   3f3 <write>
    exit();
  c4:	e8 0a 03 00 00       	call   3d3 <exit>
  c9:	66 90                	xchg   %ax,%ax
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <convert_to_string.part.0>:
void convert_to_string(int value, char* result, int base) {
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	56                   	push   %esi
  d5:	89 d6                	mov    %edx,%esi
  d7:	53                   	push   %ebx
  d8:	83 ec 08             	sub    $0x8,%esp
  db:	89 4d f0             	mov    %ecx,-0x10(%ebp)
  de:	89 55 ec             	mov    %edx,-0x14(%ebp)
  e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        value /= base;
  e8:	99                   	cltd   
  e9:	89 c7                	mov    %eax,%edi
        *ptr++ = alphabet [35 + (tmp_value - value * base)];
  eb:	8b 1d 54 0c 00 00    	mov    0xc54,%ebx
  f1:	89 f1                	mov    %esi,%ecx
        value /= base;
  f3:	f7 7d f0             	idivl  -0x10(%ebp)
        *ptr++ = alphabet [35 + (tmp_value - value * base)];
  f6:	83 c6 01             	add    $0x1,%esi
  f9:	0f b6 54 13 23       	movzbl 0x23(%ebx,%edx,1),%edx
  fe:	88 56 ff             	mov    %dl,-0x1(%esi)
    } while ( value );
 101:	85 c0                	test   %eax,%eax
 103:	75 e3                	jne    e8 <convert_to_string.part.0+0x18>
 105:	8b 5d ec             	mov    -0x14(%ebp),%ebx
    if (tmp_value < 0) *ptr++ = '-';
 108:	85 ff                	test   %edi,%edi
 10a:	79 0a                	jns    116 <convert_to_string.part.0+0x46>
 10c:	8d 41 02             	lea    0x2(%ecx),%eax
 10f:	c6 06 2d             	movb   $0x2d,(%esi)
 112:	89 f1                	mov    %esi,%ecx
 114:	89 c6                	mov    %eax,%esi
    *ptr-- = '\0';
 116:	c6 06 00             	movb   $0x0,(%esi)
    while(ptr1 < ptr) {
 119:	39 cb                	cmp    %ecx,%ebx
 11b:	73 19                	jae    136 <convert_to_string.part.0+0x66>
 11d:	8d 76 00             	lea    0x0(%esi),%esi
        tmp_char = *ptr;
 120:	0f b6 01             	movzbl (%ecx),%eax
        *ptr--= *ptr1;
 123:	0f b6 13             	movzbl (%ebx),%edx
 126:	83 e9 01             	sub    $0x1,%ecx
        *ptr1++ = tmp_char;
 129:	83 c3 01             	add    $0x1,%ebx
        *ptr--= *ptr1;
 12c:	88 51 01             	mov    %dl,0x1(%ecx)
        *ptr1++ = tmp_char;
 12f:	88 43 ff             	mov    %al,-0x1(%ebx)
    while(ptr1 < ptr) {
 132:	39 d9                	cmp    %ebx,%ecx
 134:	77 ea                	ja     120 <convert_to_string.part.0+0x50>
}
 136:	83 c4 08             	add    $0x8,%esp
 139:	5b                   	pop    %ebx
 13a:	5e                   	pop    %esi
 13b:	5f                   	pop    %edi
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    
 13e:	66 90                	xchg   %ax,%ax

00000140 <convert_to_string>:
void convert_to_string(int value, char* result, int base) {
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	53                   	push   %ebx
 148:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 14e:	8b 55 0c             	mov    0xc(%ebp),%edx
    if (base < 2 || base > 36) { *result = '\0'; return; }
 151:	8d 41 fe             	lea    -0x2(%ecx),%eax
 154:	83 f8 22             	cmp    $0x22,%eax
 157:	77 0f                	ja     168 <convert_to_string+0x28>
 159:	89 d8                	mov    %ebx,%eax
}
 15b:	5b                   	pop    %ebx
 15c:	5d                   	pop    %ebp
 15d:	e9 6e ff ff ff       	jmp    d0 <convert_to_string.part.0>
 162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (base < 2 || base > 36) { *result = '\0'; return; }
 168:	c6 02 00             	movb   $0x0,(%edx)
}
 16b:	5b                   	pop    %ebx
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
 16e:	66 90                	xchg   %ax,%ax

00000170 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 175:	31 c0                	xor    %eax,%eax
{
 177:	89 e5                	mov    %esp,%ebp
 179:	53                   	push   %ebx
 17a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 17d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  while((*s++ = *t++) != 0)
 180:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 184:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 187:	83 c0 01             	add    $0x1,%eax
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strcpy+0x10>
    ;
  return os;
}
 18e:	89 c8                	mov    %ecx,%eax
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1ae:	0f b6 01             	movzbl (%ecx),%eax
 1b1:	0f b6 1a             	movzbl (%edx),%ebx
 1b4:	84 c0                	test   %al,%al
 1b6:	75 19                	jne    1d1 <strcmp+0x31>
 1b8:	eb 26                	jmp    1e0 <strcmp+0x40>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
    p++, q++;
 1c4:	83 c1 01             	add    $0x1,%ecx
 1c7:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1ca:	0f b6 1a             	movzbl (%edx),%ebx
 1cd:	84 c0                	test   %al,%al
 1cf:	74 0f                	je     1e0 <strcmp+0x40>
 1d1:	38 d8                	cmp    %bl,%al
 1d3:	74 eb                	je     1c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1d5:	29 d8                	sub    %ebx,%eax
}
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1e2:	29 d8                	sub    %ebx,%eax
}
 1e4:	5b                   	pop    %ebx
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strlen>:

uint
strlen(const char *s)
{
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1fa:	80 3a 00             	cmpb   $0x0,(%edx)
 1fd:	74 21                	je     220 <strlen+0x30>
 1ff:	31 c0                	xor    %eax,%eax
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 208:	83 c0 01             	add    $0x1,%eax
 20b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 20f:	89 c1                	mov    %eax,%ecx
 211:	75 f5                	jne    208 <strlen+0x18>
    ;
  return n;
}
 213:	89 c8                	mov    %ecx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
  for(n = 0; s[n]; n++)
 220:	31 c9                	xor    %ecx,%ecx
}
 222:	5d                   	pop    %ebp
 223:	89 c8                	mov    %ecx,%eax
 225:	c3                   	ret    
 226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 23b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23e:	8b 45 0c             	mov    0xc(%ebp),%eax
 241:	89 d7                	mov    %edx,%edi
 243:	fc                   	cld    
 244:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 24f:	90                   	nop

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 25e:	0f b6 10             	movzbl (%eax),%edx
 261:	84 d2                	test   %dl,%dl
 263:	75 16                	jne    27b <strchr+0x2b>
 265:	eb 21                	jmp    288 <strchr+0x38>
 267:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 26e:	66 90                	xchg   %ax,%ax
 270:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 274:	83 c0 01             	add    $0x1,%eax
 277:	84 d2                	test   %dl,%dl
 279:	74 0d                	je     288 <strchr+0x38>
    if(*s == c)
 27b:	38 d1                	cmp    %dl,%cl
 27d:	75 f1                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
}
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 288:	31 c0                	xor    %eax,%eax
}
 28a:	5d                   	pop    %ebp
 28b:	c3                   	ret    
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 299:	31 f6                	xor    %esi,%esi
{
 29b:	53                   	push   %ebx
 29c:	89 f3                	mov    %esi,%ebx
 29e:	83 ec 1c             	sub    $0x1c,%esp
 2a1:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a4:	eb 33                	jmp    2d9 <gets+0x49>
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2b6:	6a 01                	push   $0x1
 2b8:	50                   	push   %eax
 2b9:	6a 00                	push   $0x0
 2bb:	e8 2b 01 00 00       	call   3eb <read>
    if(cc < 1)
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	85 c0                	test   %eax,%eax
 2c5:	7e 1c                	jle    2e3 <gets+0x53>
      break;
    buf[i++] = c;
 2c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2cb:	83 c7 01             	add    $0x1,%edi
 2ce:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2d1:	3c 0a                	cmp    $0xa,%al
 2d3:	74 23                	je     2f8 <gets+0x68>
 2d5:	3c 0d                	cmp    $0xd,%al
 2d7:	74 1f                	je     2f8 <gets+0x68>
  for(i=0; i+1 < max; ){
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	89 fe                	mov    %edi,%esi
 2de:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e1:	7c cd                	jl     2b0 <gets+0x20>
 2e3:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2e5:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2e8:	c6 03 00             	movb   $0x0,(%ebx)
}
 2eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2ee:	5b                   	pop    %ebx
 2ef:	5e                   	pop    %esi
 2f0:	5f                   	pop    %edi
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    
 2f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f7:	90                   	nop
 2f8:	8b 75 08             	mov    0x8(%ebp),%esi
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	01 de                	add    %ebx,%esi
 300:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 302:	c6 03 00             	movb   $0x0,(%ebx)
}
 305:	8d 65 f4             	lea    -0xc(%ebp),%esp
 308:	5b                   	pop    %ebx
 309:	5e                   	pop    %esi
 30a:	5f                   	pop    %edi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	f3 0f 1e fb          	endbr32 
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	6a 00                	push   $0x0
 31e:	ff 75 08             	pushl  0x8(%ebp)
 321:	e8 ed 00 00 00       	call   413 <open>
  if(fd < 0)
 326:	83 c4 10             	add    $0x10,%esp
 329:	85 c0                	test   %eax,%eax
 32b:	78 2b                	js     358 <stat+0x48>
    return -1;
  r = fstat(fd, st);
 32d:	83 ec 08             	sub    $0x8,%esp
 330:	ff 75 0c             	pushl  0xc(%ebp)
 333:	89 c3                	mov    %eax,%ebx
 335:	50                   	push   %eax
 336:	e8 f0 00 00 00       	call   42b <fstat>
  close(fd);
 33b:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33e:	89 c6                	mov    %eax,%esi
  close(fd);
 340:	e8 b6 00 00 00       	call   3fb <close>
  return r;
 345:	83 c4 10             	add    $0x10,%esp
}
 348:	8d 65 f8             	lea    -0x8(%ebp),%esp
 34b:	89 f0                	mov    %esi,%eax
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    
 351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
 358:	be ff ff ff ff       	mov    $0xffffffff,%esi
 35d:	eb e9                	jmp    348 <stat+0x38>
 35f:	90                   	nop

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	f3 0f 1e fb          	endbr32 
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	53                   	push   %ebx
 368:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 36b:	0f be 02             	movsbl (%edx),%eax
 36e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 371:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 374:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 379:	77 1a                	ja     395 <atoi+0x35>
 37b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 37f:	90                   	nop
    n = n*10 + *s++ - '0';
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	89 c8                	mov    %ecx,%eax
 397:	5b                   	pop    %ebx
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	57                   	push   %edi
 3a8:	8b 45 10             	mov    0x10(%ebp),%eax
 3ab:	8b 55 08             	mov    0x8(%ebp),%edx
 3ae:	56                   	push   %esi
 3af:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3b2:	85 c0                	test   %eax,%eax
 3b4:	7e 0f                	jle    3c5 <memmove+0x25>
 3b6:	01 d0                	add    %edx,%eax
  dst = vdst;
 3b8:	89 d7                	mov    %edx,%edi
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *dst++ = *src++;
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
  return vdst;
}
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret    

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <calculate_sum_of_digits>:
SYSCALL(calculate_sum_of_digits)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <get_file_sectors>:
SYSCALL(get_file_sectors)
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <get_parent_pid>:
SYSCALL(get_parent_pid)
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <wait_sleeping>:
SYSCALL(wait_sleeping)
 48b:	b8 19 00 00 00       	mov    $0x19,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <set_proc_tracer>:
SYSCALL(set_proc_tracer)
 493:	b8 1a 00 00 00       	mov    $0x1a,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    

0000049b <get_proc_queue_level>:
SYSCALL(get_proc_queue_level)
 49b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret    

000004a3 <set_proc_queue_level>:
SYSCALL(set_proc_queue_level)
 4a3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret    

000004ab <set_HRRN_process_level>:
SYSCALL(set_HRRN_process_level)
 4ab:	b8 1d 00 00 00       	mov    $0x1d,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret    

000004b3 <set_HRRN_system_level>:
SYSCALL(set_HRRN_system_level)
 4b3:	b8 1e 00 00 00       	mov    $0x1e,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret    
 4bb:	66 90                	xchg   %ax,%ax
 4bd:	66 90                	xchg   %ax,%ax
 4bf:	90                   	nop

000004c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
 4c6:	83 ec 3c             	sub    $0x3c,%esp
 4c9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 4cc:	89 d1                	mov    %edx,%ecx
{
 4ce:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
 4d1:	85 d2                	test   %edx,%edx
 4d3:	0f 89 7f 00 00 00    	jns    558 <printint+0x98>
 4d9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4dd:	74 79                	je     558 <printint+0x98>
    neg = 1;
 4df:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 4e6:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
 4e8:	31 db                	xor    %ebx,%ebx
 4ea:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4ed:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 4f0:	89 c8                	mov    %ecx,%eax
 4f2:	31 d2                	xor    %edx,%edx
 4f4:	89 cf                	mov    %ecx,%edi
 4f6:	f7 75 c4             	divl   -0x3c(%ebp)
 4f9:	0f b6 92 40 09 00 00 	movzbl 0x940(%edx),%edx
 500:	89 45 c0             	mov    %eax,-0x40(%ebp)
 503:	89 d8                	mov    %ebx,%eax
 505:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
 508:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
 50b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
 50e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 511:	76 dd                	jbe    4f0 <printint+0x30>
  if(neg)
 513:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 516:	85 c9                	test   %ecx,%ecx
 518:	74 0c                	je     526 <printint+0x66>
    buf[i++] = '-';
 51a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
 51f:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
 521:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
 526:	8b 7d b8             	mov    -0x48(%ebp),%edi
 529:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 52d:	eb 07                	jmp    536 <printint+0x76>
 52f:	90                   	nop
 530:	0f b6 13             	movzbl (%ebx),%edx
 533:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
 536:	83 ec 04             	sub    $0x4,%esp
 539:	88 55 d7             	mov    %dl,-0x29(%ebp)
 53c:	6a 01                	push   $0x1
 53e:	56                   	push   %esi
 53f:	57                   	push   %edi
 540:	e8 ae fe ff ff       	call   3f3 <write>
  while(--i >= 0)
 545:	83 c4 10             	add    $0x10,%esp
 548:	39 de                	cmp    %ebx,%esi
 54a:	75 e4                	jne    530 <printint+0x70>
    putc(fd, buf[i]);
}
 54c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 54f:	5b                   	pop    %ebx
 550:	5e                   	pop    %esi
 551:	5f                   	pop    %edi
 552:	5d                   	pop    %ebp
 553:	c3                   	ret    
 554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 558:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 55f:	eb 87                	jmp    4e8 <printint+0x28>
 561:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 56f:	90                   	nop

00000570 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 570:	f3 0f 1e fb          	endbr32 
 574:	55                   	push   %ebp
 575:	89 e5                	mov    %esp,%ebp
 577:	57                   	push   %edi
 578:	56                   	push   %esi
 579:	53                   	push   %ebx
 57a:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 57d:	8b 75 0c             	mov    0xc(%ebp),%esi
 580:	0f b6 1e             	movzbl (%esi),%ebx
 583:	84 db                	test   %bl,%bl
 585:	0f 84 b4 00 00 00    	je     63f <printf+0xcf>
  ap = (uint*)(void*)&fmt + 1;
 58b:	8d 45 10             	lea    0x10(%ebp),%eax
 58e:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 591:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
 594:	31 d2                	xor    %edx,%edx
  ap = (uint*)(void*)&fmt + 1;
 596:	89 45 d0             	mov    %eax,-0x30(%ebp)
 599:	eb 33                	jmp    5ce <printf+0x5e>
 59b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 59f:	90                   	nop
 5a0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5a3:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5a8:	83 f8 25             	cmp    $0x25,%eax
 5ab:	74 17                	je     5c4 <printf+0x54>
  write(fd, &c, 1);
 5ad:	83 ec 04             	sub    $0x4,%esp
 5b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5b3:	6a 01                	push   $0x1
 5b5:	57                   	push   %edi
 5b6:	ff 75 08             	pushl  0x8(%ebp)
 5b9:	e8 35 fe ff ff       	call   3f3 <write>
 5be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5c1:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5c4:	0f b6 1e             	movzbl (%esi),%ebx
 5c7:	83 c6 01             	add    $0x1,%esi
 5ca:	84 db                	test   %bl,%bl
 5cc:	74 71                	je     63f <printf+0xcf>
    c = fmt[i] & 0xff;
 5ce:	0f be cb             	movsbl %bl,%ecx
 5d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5d4:	85 d2                	test   %edx,%edx
 5d6:	74 c8                	je     5a0 <printf+0x30>
      }
    } else if(state == '%'){
 5d8:	83 fa 25             	cmp    $0x25,%edx
 5db:	75 e7                	jne    5c4 <printf+0x54>
      if(c == 'd'){
 5dd:	83 f8 64             	cmp    $0x64,%eax
 5e0:	0f 84 9a 00 00 00    	je     680 <printf+0x110>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 5e6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5ec:	83 f9 70             	cmp    $0x70,%ecx
 5ef:	74 5f                	je     650 <printf+0xe0>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 5f1:	83 f8 73             	cmp    $0x73,%eax
 5f4:	0f 84 d6 00 00 00    	je     6d0 <printf+0x160>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 5fa:	83 f8 63             	cmp    $0x63,%eax
 5fd:	0f 84 8d 00 00 00    	je     690 <printf+0x120>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 603:	83 f8 25             	cmp    $0x25,%eax
 606:	0f 84 b4 00 00 00    	je     6c0 <printf+0x150>
  write(fd, &c, 1);
 60c:	83 ec 04             	sub    $0x4,%esp
 60f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 613:	6a 01                	push   $0x1
 615:	57                   	push   %edi
 616:	ff 75 08             	pushl  0x8(%ebp)
 619:	e8 d5 fd ff ff       	call   3f3 <write>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 61e:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 621:	83 c4 0c             	add    $0xc,%esp
 624:	6a 01                	push   $0x1
 626:	83 c6 01             	add    $0x1,%esi
 629:	57                   	push   %edi
 62a:	ff 75 08             	pushl  0x8(%ebp)
 62d:	e8 c1 fd ff ff       	call   3f3 <write>
  for(i = 0; fmt[i]; i++){
 632:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
        putc(fd, c);
 636:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 639:	31 d2                	xor    %edx,%edx
  for(i = 0; fmt[i]; i++){
 63b:	84 db                	test   %bl,%bl
 63d:	75 8f                	jne    5ce <printf+0x5e>
    }
  }
}
 63f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 642:	5b                   	pop    %ebx
 643:	5e                   	pop    %esi
 644:	5f                   	pop    %edi
 645:	5d                   	pop    %ebp
 646:	c3                   	ret    
 647:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 16, 0);
 650:	83 ec 0c             	sub    $0xc,%esp
 653:	b9 10 00 00 00       	mov    $0x10,%ecx
 658:	6a 00                	push   $0x0
 65a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 65d:	8b 45 08             	mov    0x8(%ebp),%eax
 660:	8b 13                	mov    (%ebx),%edx
 662:	e8 59 fe ff ff       	call   4c0 <printint>
        ap++;
 667:	89 d8                	mov    %ebx,%eax
 669:	83 c4 10             	add    $0x10,%esp
      state = 0;
 66c:	31 d2                	xor    %edx,%edx
        ap++;
 66e:	83 c0 04             	add    $0x4,%eax
 671:	89 45 d0             	mov    %eax,-0x30(%ebp)
 674:	e9 4b ff ff ff       	jmp    5c4 <printf+0x54>
 679:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printint(fd, *ap, 10, 1);
 680:	83 ec 0c             	sub    $0xc,%esp
 683:	b9 0a 00 00 00       	mov    $0xa,%ecx
 688:	6a 01                	push   $0x1
 68a:	eb ce                	jmp    65a <printf+0xea>
 68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        putc(fd, *ap);
 690:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 693:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 696:	8b 03                	mov    (%ebx),%eax
  write(fd, &c, 1);
 698:	6a 01                	push   $0x1
        ap++;
 69a:	83 c3 04             	add    $0x4,%ebx
  write(fd, &c, 1);
 69d:	57                   	push   %edi
 69e:	ff 75 08             	pushl  0x8(%ebp)
        putc(fd, *ap);
 6a1:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6a4:	e8 4a fd ff ff       	call   3f3 <write>
        ap++;
 6a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 0e ff ff ff       	jmp    5c4 <printf+0x54>
 6b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6bd:	8d 76 00             	lea    0x0(%esi),%esi
        putc(fd, c);
 6c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 6c3:	83 ec 04             	sub    $0x4,%esp
 6c6:	e9 59 ff ff ff       	jmp    624 <printf+0xb4>
 6cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6cf:	90                   	nop
        s = (char*)*ap;
 6d0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6d3:	8b 18                	mov    (%eax),%ebx
        ap++;
 6d5:	83 c0 04             	add    $0x4,%eax
 6d8:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6db:	85 db                	test   %ebx,%ebx
 6dd:	74 17                	je     6f6 <printf+0x186>
        while(*s != 0){
 6df:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6e2:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6e4:	84 c0                	test   %al,%al
 6e6:	0f 84 d8 fe ff ff    	je     5c4 <printf+0x54>
 6ec:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ef:	89 de                	mov    %ebx,%esi
 6f1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6f4:	eb 1a                	jmp    710 <printf+0x1a0>
          s = "(null)";
 6f6:	bb 38 09 00 00       	mov    $0x938,%ebx
        while(*s != 0){
 6fb:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6fe:	b8 28 00 00 00       	mov    $0x28,%eax
 703:	89 de                	mov    %ebx,%esi
 705:	8b 5d 08             	mov    0x8(%ebp),%ebx
 708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 70f:	90                   	nop
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
          s++;
 713:	83 c6 01             	add    $0x1,%esi
 716:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 719:	6a 01                	push   $0x1
 71b:	57                   	push   %edi
 71c:	53                   	push   %ebx
 71d:	e8 d1 fc ff ff       	call   3f3 <write>
        while(*s != 0){
 722:	0f b6 06             	movzbl (%esi),%eax
 725:	83 c4 10             	add    $0x10,%esp
 728:	84 c0                	test   %al,%al
 72a:	75 e4                	jne    710 <printf+0x1a0>
 72c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
      state = 0;
 72f:	31 d2                	xor    %edx,%edx
 731:	e9 8e fe ff ff       	jmp    5c4 <printf+0x54>
 736:	66 90                	xchg   %ax,%ax
 738:	66 90                	xchg   %ax,%ax
 73a:	66 90                	xchg   %ax,%ax
 73c:	66 90                	xchg   %ax,%ax
 73e:	66 90                	xchg   %ax,%ax

00000740 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 740:	f3 0f 1e fb          	endbr32 
 744:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 745:	a1 58 0c 00 00       	mov    0xc58,%eax
{
 74a:	89 e5                	mov    %esp,%ebp
 74c:	57                   	push   %edi
 74d:	56                   	push   %esi
 74e:	53                   	push   %ebx
 74f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 752:	8b 10                	mov    (%eax),%edx
  bp = (Header*)ap - 1;
 754:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 757:	39 c8                	cmp    %ecx,%eax
 759:	73 15                	jae    770 <free+0x30>
 75b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 75f:	90                   	nop
 760:	39 d1                	cmp    %edx,%ecx
 762:	72 14                	jb     778 <free+0x38>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 764:	39 d0                	cmp    %edx,%eax
 766:	73 10                	jae    778 <free+0x38>
{
 768:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 76a:	8b 10                	mov    (%eax),%edx
 76c:	39 c8                	cmp    %ecx,%eax
 76e:	72 f0                	jb     760 <free+0x20>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 770:	39 d0                	cmp    %edx,%eax
 772:	72 f4                	jb     768 <free+0x28>
 774:	39 d1                	cmp    %edx,%ecx
 776:	73 f0                	jae    768 <free+0x28>
      break;
  if(bp + bp->s.size == p->s.ptr){
 778:	8b 73 fc             	mov    -0x4(%ebx),%esi
 77b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 77e:	39 fa                	cmp    %edi,%edx
 780:	74 1e                	je     7a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 782:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 785:	8b 50 04             	mov    0x4(%eax),%edx
 788:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 78b:	39 f1                	cmp    %esi,%ecx
 78d:	74 28                	je     7b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 78f:	89 08                	mov    %ecx,(%eax)
  freep = p;
}
 791:	5b                   	pop    %ebx
  freep = p;
 792:	a3 58 0c 00 00       	mov    %eax,0xc58
}
 797:	5e                   	pop    %esi
 798:	5f                   	pop    %edi
 799:	5d                   	pop    %ebp
 79a:	c3                   	ret    
 79b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 79f:	90                   	nop
    bp->s.size += p->s.ptr->s.size;
 7a0:	03 72 04             	add    0x4(%edx),%esi
 7a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7a6:	8b 10                	mov    (%eax),%edx
 7a8:	8b 12                	mov    (%edx),%edx
 7aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7ad:	8b 50 04             	mov    0x4(%eax),%edx
 7b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7b3:	39 f1                	cmp    %esi,%ecx
 7b5:	75 d8                	jne    78f <free+0x4f>
    p->s.size += bp->s.size;
 7b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7ba:	a3 58 0c 00 00       	mov    %eax,0xc58
    p->s.size += bp->s.size;
 7bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7c5:	89 10                	mov    %edx,(%eax)
}
 7c7:	5b                   	pop    %ebx
 7c8:	5e                   	pop    %esi
 7c9:	5f                   	pop    %edi
 7ca:	5d                   	pop    %ebp
 7cb:	c3                   	ret    
 7cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7d0:	f3 0f 1e fb          	endbr32 
 7d4:	55                   	push   %ebp
 7d5:	89 e5                	mov    %esp,%ebp
 7d7:	57                   	push   %edi
 7d8:	56                   	push   %esi
 7d9:	53                   	push   %ebx
 7da:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7dd:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7e0:	8b 3d 58 0c 00 00    	mov    0xc58,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7e6:	8d 70 07             	lea    0x7(%eax),%esi
 7e9:	c1 ee 03             	shr    $0x3,%esi
 7ec:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
 7ef:	85 ff                	test   %edi,%edi
 7f1:	0f 84 a9 00 00 00    	je     8a0 <malloc+0xd0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f7:	8b 07                	mov    (%edi),%eax
    if(p->s.size >= nunits){
 7f9:	8b 48 04             	mov    0x4(%eax),%ecx
 7fc:	39 f1                	cmp    %esi,%ecx
 7fe:	73 6d                	jae    86d <malloc+0x9d>
 800:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 806:	bb 00 10 00 00       	mov    $0x1000,%ebx
 80b:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
 80e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 815:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 818:	eb 17                	jmp    831 <malloc+0x61>
 81a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 820:	8b 10                	mov    (%eax),%edx
    if(p->s.size >= nunits){
 822:	8b 4a 04             	mov    0x4(%edx),%ecx
 825:	39 f1                	cmp    %esi,%ecx
 827:	73 4f                	jae    878 <malloc+0xa8>
 829:	8b 3d 58 0c 00 00    	mov    0xc58,%edi
 82f:	89 d0                	mov    %edx,%eax
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 831:	39 c7                	cmp    %eax,%edi
 833:	75 eb                	jne    820 <malloc+0x50>
  p = sbrk(nu * sizeof(Header));
 835:	83 ec 0c             	sub    $0xc,%esp
 838:	ff 75 e4             	pushl  -0x1c(%ebp)
 83b:	e8 1b fc ff ff       	call   45b <sbrk>
  if(p == (char*)-1)
 840:	83 c4 10             	add    $0x10,%esp
 843:	83 f8 ff             	cmp    $0xffffffff,%eax
 846:	74 1b                	je     863 <malloc+0x93>
  hp->s.size = nu;
 848:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 84b:	83 ec 0c             	sub    $0xc,%esp
 84e:	83 c0 08             	add    $0x8,%eax
 851:	50                   	push   %eax
 852:	e8 e9 fe ff ff       	call   740 <free>
  return freep;
 857:	a1 58 0c 00 00       	mov    0xc58,%eax
      if((p = morecore(nunits)) == 0)
 85c:	83 c4 10             	add    $0x10,%esp
 85f:	85 c0                	test   %eax,%eax
 861:	75 bd                	jne    820 <malloc+0x50>
        return 0;
  }
}
 863:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 866:	31 c0                	xor    %eax,%eax
}
 868:	5b                   	pop    %ebx
 869:	5e                   	pop    %esi
 86a:	5f                   	pop    %edi
 86b:	5d                   	pop    %ebp
 86c:	c3                   	ret    
    if(p->s.size >= nunits){
 86d:	89 c2                	mov    %eax,%edx
 86f:	89 f8                	mov    %edi,%eax
 871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->s.size == nunits)
 878:	39 ce                	cmp    %ecx,%esi
 87a:	74 54                	je     8d0 <malloc+0x100>
        p->s.size -= nunits;
 87c:	29 f1                	sub    %esi,%ecx
 87e:	89 4a 04             	mov    %ecx,0x4(%edx)
        p += p->s.size;
 881:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
        p->s.size = nunits;
 884:	89 72 04             	mov    %esi,0x4(%edx)
      freep = prevp;
 887:	a3 58 0c 00 00       	mov    %eax,0xc58
}
 88c:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 88f:	8d 42 08             	lea    0x8(%edx),%eax
}
 892:	5b                   	pop    %ebx
 893:	5e                   	pop    %esi
 894:	5f                   	pop    %edi
 895:	5d                   	pop    %ebp
 896:	c3                   	ret    
 897:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 89e:	66 90                	xchg   %ax,%ax
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 05 58 0c 00 00 5c 	movl   $0xc5c,0xc58
 8a7:	0c 00 00 
    base.s.size = 0;
 8aa:	bf 5c 0c 00 00       	mov    $0xc5c,%edi
    base.s.ptr = freep = prevp = &base;
 8af:	c7 05 5c 0c 00 00 5c 	movl   $0xc5c,0xc5c
 8b6:	0c 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b9:	89 f8                	mov    %edi,%eax
    base.s.size = 0;
 8bb:	c7 05 60 0c 00 00 00 	movl   $0x0,0xc60
 8c2:	00 00 00 
    if(p->s.size >= nunits){
 8c5:	e9 36 ff ff ff       	jmp    800 <malloc+0x30>
 8ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 0a                	mov    (%edx),%ecx
 8d2:	89 08                	mov    %ecx,(%eax)
 8d4:	eb b1                	jmp    887 <malloc+0xb7>
