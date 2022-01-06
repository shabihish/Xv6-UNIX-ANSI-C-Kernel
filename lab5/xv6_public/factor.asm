
_factor:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
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
  1b:	ff 70 04             	pushl  0x4(%eax)
  1e:	e8 3d 03 00 00       	call   360 <atoi>
  23:	c7 04 24 b8 08 00 00 	movl   $0x8b8,(%esp)
  2a:	89 c6                	mov    %eax,%esi
  2c:	e8 f2 03 00 00       	call   423 <unlink>
  31:	58                   	pop    %eax
  32:	5a                   	pop    %edx
  33:	68 02 02 00 00       	push   $0x202
  38:	68 b8 08 00 00       	push   $0x8b8
  3d:	e8 d1 03 00 00       	call   413 <open>
  42:	83 c4 10             	add    $0x10,%esp
  45:	89 45 d0             	mov    %eax,-0x30(%ebp)
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
  68:	89 f0                	mov    %esi,%eax
  6a:	99                   	cltd   
  6b:	f7 fb                	idiv   %ebx
  6d:	85 d2                	test   %edx,%edx
  6f:	75 ef                	jne    60 <main+0x60>
  71:	b9 0a 00 00 00       	mov    $0xa,%ecx
  76:	89 fa                	mov    %edi,%edx
  78:	89 d8                	mov    %ebx,%eax
  7a:	83 c3 01             	add    $0x1,%ebx
  7d:	e8 4e 00 00 00       	call   d0 <convert_to_string.part.0>
  82:	83 ec 0c             	sub    $0xc,%esp
  85:	57                   	push   %edi
  86:	e8 65 01 00 00       	call   1f0 <strlen>
  8b:	83 c4 0c             	add    $0xc,%esp
  8e:	50                   	push   %eax
  8f:	57                   	push   %edi
  90:	ff 75 d0             	pushl  -0x30(%ebp)
  93:	e8 5b 03 00 00       	call   3f3 <write>
  98:	83 c4 0c             	add    $0xc,%esp
  9b:	6a 01                	push   $0x1
  9d:	68 ca 08 00 00       	push   $0x8ca
  a2:	ff 75 d0             	pushl  -0x30(%ebp)
  a5:	e8 49 03 00 00       	call   3f3 <write>
  aa:	83 c4 10             	add    $0x10,%esp
  ad:	39 5d d4             	cmp    %ebx,-0x2c(%ebp)
  b0:	75 b6                	jne    68 <main+0x68>
  b2:	83 ec 04             	sub    $0x4,%esp
  b5:	6a 01                	push   $0x1
  b7:	68 cc 08 00 00       	push   $0x8cc
  bc:	ff 75 d0             	pushl  -0x30(%ebp)
  bf:	e8 2f 03 00 00       	call   3f3 <write>
  c4:	e8 0a 03 00 00       	call   3d3 <exit>
  c9:	66 90                	xchg   %ax,%ax
  cb:	66 90                	xchg   %ax,%ax
  cd:	66 90                	xchg   %ax,%ax
  cf:	90                   	nop

000000d0 <convert_to_string.part.0>:
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
  e8:	99                   	cltd   
  e9:	89 c7                	mov    %eax,%edi
  eb:	8b 1d 34 0c 00 00    	mov    0xc34,%ebx
  f1:	89 f1                	mov    %esi,%ecx
  f3:	f7 7d f0             	idivl  -0x10(%ebp)
  f6:	83 c6 01             	add    $0x1,%esi
  f9:	0f b6 54 13 23       	movzbl 0x23(%ebx,%edx,1),%edx
  fe:	88 56 ff             	mov    %dl,-0x1(%esi)
 101:	85 c0                	test   %eax,%eax
 103:	75 e3                	jne    e8 <convert_to_string.part.0+0x18>
 105:	8b 5d ec             	mov    -0x14(%ebp),%ebx
 108:	85 ff                	test   %edi,%edi
 10a:	79 0a                	jns    116 <convert_to_string.part.0+0x46>
 10c:	8d 41 02             	lea    0x2(%ecx),%eax
 10f:	c6 06 2d             	movb   $0x2d,(%esi)
 112:	89 f1                	mov    %esi,%ecx
 114:	89 c6                	mov    %eax,%esi
 116:	c6 06 00             	movb   $0x0,(%esi)
 119:	39 cb                	cmp    %ecx,%ebx
 11b:	73 19                	jae    136 <convert_to_string.part.0+0x66>
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	0f b6 01             	movzbl (%ecx),%eax
 123:	0f b6 13             	movzbl (%ebx),%edx
 126:	83 e9 01             	sub    $0x1,%ecx
 129:	83 c3 01             	add    $0x1,%ebx
 12c:	88 51 01             	mov    %dl,0x1(%ecx)
 12f:	88 43 ff             	mov    %al,-0x1(%ebx)
 132:	39 d9                	cmp    %ebx,%ecx
 134:	77 ea                	ja     120 <convert_to_string.part.0+0x50>
 136:	83 c4 08             	add    $0x8,%esp
 139:	5b                   	pop    %ebx
 13a:	5e                   	pop    %esi
 13b:	5f                   	pop    %edi
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    
 13e:	66 90                	xchg   %ax,%ax

00000140 <convert_to_string>:
 140:	f3 0f 1e fb          	endbr32 
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	53                   	push   %ebx
 148:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14b:	8b 5d 08             	mov    0x8(%ebp),%ebx
 14e:	8b 55 0c             	mov    0xc(%ebp),%edx
 151:	8d 41 fe             	lea    -0x2(%ecx),%eax
 154:	83 f8 22             	cmp    $0x22,%eax
 157:	77 0f                	ja     168 <convert_to_string+0x28>
 159:	89 d8                	mov    %ebx,%eax
 15b:	5b                   	pop    %ebx
 15c:	5d                   	pop    %ebp
 15d:	e9 6e ff ff ff       	jmp    d0 <convert_to_string.part.0>
 162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 168:	c6 02 00             	movb   $0x0,(%edx)
 16b:	5b                   	pop    %ebx
 16c:	5d                   	pop    %ebp
 16d:	c3                   	ret    
 16e:	66 90                	xchg   %ax,%ax

00000170 <strcpy>:
 170:	f3 0f 1e fb          	endbr32 
 174:	55                   	push   %ebp
 175:	31 c0                	xor    %eax,%eax
 177:	89 e5                	mov    %esp,%ebp
 179:	53                   	push   %ebx
 17a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 17d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 180:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 184:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 187:	83 c0 01             	add    $0x1,%eax
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strcpy+0x10>
 18e:	89 c8                	mov    %ecx,%eax
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000001a0 <strcmp>:
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1ab:	8b 55 0c             	mov    0xc(%ebp),%edx
 1ae:	0f b6 01             	movzbl (%ecx),%eax
 1b1:	0f b6 1a             	movzbl (%edx),%ebx
 1b4:	84 c0                	test   %al,%al
 1b6:	75 19                	jne    1d1 <strcmp+0x31>
 1b8:	eb 26                	jmp    1e0 <strcmp+0x40>
 1ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 1c4:	83 c1 01             	add    $0x1,%ecx
 1c7:	83 c2 01             	add    $0x1,%edx
 1ca:	0f b6 1a             	movzbl (%edx),%ebx
 1cd:	84 c0                	test   %al,%al
 1cf:	74 0f                	je     1e0 <strcmp+0x40>
 1d1:	38 d8                	cmp    %bl,%al
 1d3:	74 eb                	je     1c0 <strcmp+0x20>
 1d5:	29 d8                	sub    %ebx,%eax
 1d7:	5b                   	pop    %ebx
 1d8:	5d                   	pop    %ebp
 1d9:	c3                   	ret    
 1da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1e0:	31 c0                	xor    %eax,%eax
 1e2:	29 d8                	sub    %ebx,%eax
 1e4:	5b                   	pop    %ebx
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    
 1e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ee:	66 90                	xchg   %ax,%ax

000001f0 <strlen>:
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	8b 55 08             	mov    0x8(%ebp),%edx
 1fa:	80 3a 00             	cmpb   $0x0,(%edx)
 1fd:	74 21                	je     220 <strlen+0x30>
 1ff:	31 c0                	xor    %eax,%eax
 201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 208:	83 c0 01             	add    $0x1,%eax
 20b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 20f:	89 c1                	mov    %eax,%ecx
 211:	75 f5                	jne    208 <strlen+0x18>
 213:	89 c8                	mov    %ecx,%eax
 215:	5d                   	pop    %ebp
 216:	c3                   	ret    
 217:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 21e:	66 90                	xchg   %ax,%ax
 220:	31 c9                	xor    %ecx,%ecx
 222:	5d                   	pop    %ebp
 223:	89 c8                	mov    %ecx,%eax
 225:	c3                   	ret    
 226:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 22d:	8d 76 00             	lea    0x0(%esi),%esi

00000230 <memset>:
 230:	f3 0f 1e fb          	endbr32 
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	57                   	push   %edi
 238:	8b 55 08             	mov    0x8(%ebp),%edx
 23b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23e:	8b 45 0c             	mov    0xc(%ebp),%eax
 241:	89 d7                	mov    %edx,%edi
 243:	fc                   	cld    
 244:	f3 aa                	rep stos %al,%es:(%edi)
 246:	89 d0                	mov    %edx,%eax
 248:	5f                   	pop    %edi
 249:	5d                   	pop    %ebp
 24a:	c3                   	ret    
 24b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 24f:	90                   	nop

00000250 <strchr>:
 250:	f3 0f 1e fb          	endbr32 
 254:	55                   	push   %ebp
 255:	89 e5                	mov    %esp,%ebp
 257:	8b 45 08             	mov    0x8(%ebp),%eax
 25a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
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
 27b:	38 d1                	cmp    %dl,%cl
 27d:	75 f1                	jne    270 <strchr+0x20>
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 288:	31 c0                	xor    %eax,%eax
 28a:	5d                   	pop    %ebp
 28b:	c3                   	ret    
 28c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000290 <gets>:
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	57                   	push   %edi
 298:	56                   	push   %esi
 299:	31 f6                	xor    %esi,%esi
 29b:	53                   	push   %ebx
 29c:	89 f3                	mov    %esi,%ebx
 29e:	83 ec 1c             	sub    $0x1c,%esp
 2a1:	8b 7d 08             	mov    0x8(%ebp),%edi
 2a4:	eb 33                	jmp    2d9 <gets+0x49>
 2a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
 2b0:	83 ec 04             	sub    $0x4,%esp
 2b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2b6:	6a 01                	push   $0x1
 2b8:	50                   	push   %eax
 2b9:	6a 00                	push   $0x0
 2bb:	e8 2b 01 00 00       	call   3eb <read>
 2c0:	83 c4 10             	add    $0x10,%esp
 2c3:	85 c0                	test   %eax,%eax
 2c5:	7e 1c                	jle    2e3 <gets+0x53>
 2c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2cb:	83 c7 01             	add    $0x1,%edi
 2ce:	88 47 ff             	mov    %al,-0x1(%edi)
 2d1:	3c 0a                	cmp    $0xa,%al
 2d3:	74 23                	je     2f8 <gets+0x68>
 2d5:	3c 0d                	cmp    $0xd,%al
 2d7:	74 1f                	je     2f8 <gets+0x68>
 2d9:	83 c3 01             	add    $0x1,%ebx
 2dc:	89 fe                	mov    %edi,%esi
 2de:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2e1:	7c cd                	jl     2b0 <gets+0x20>
 2e3:	89 f3                	mov    %esi,%ebx
 2e5:	8b 45 08             	mov    0x8(%ebp),%eax
 2e8:	c6 03 00             	movb   $0x0,(%ebx)
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
 302:	c6 03 00             	movb   $0x0,(%ebx)
 305:	8d 65 f4             	lea    -0xc(%ebp),%esp
 308:	5b                   	pop    %ebx
 309:	5e                   	pop    %esi
 30a:	5f                   	pop    %edi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi

00000310 <stat>:
 310:	f3 0f 1e fb          	endbr32 
 314:	55                   	push   %ebp
 315:	89 e5                	mov    %esp,%ebp
 317:	56                   	push   %esi
 318:	53                   	push   %ebx
 319:	83 ec 08             	sub    $0x8,%esp
 31c:	6a 00                	push   $0x0
 31e:	ff 75 08             	pushl  0x8(%ebp)
 321:	e8 ed 00 00 00       	call   413 <open>
 326:	83 c4 10             	add    $0x10,%esp
 329:	85 c0                	test   %eax,%eax
 32b:	78 2b                	js     358 <stat+0x48>
 32d:	83 ec 08             	sub    $0x8,%esp
 330:	ff 75 0c             	pushl  0xc(%ebp)
 333:	89 c3                	mov    %eax,%ebx
 335:	50                   	push   %eax
 336:	e8 f0 00 00 00       	call   42b <fstat>
 33b:	89 1c 24             	mov    %ebx,(%esp)
 33e:	89 c6                	mov    %eax,%esi
 340:	e8 b6 00 00 00       	call   3fb <close>
 345:	83 c4 10             	add    $0x10,%esp
 348:	8d 65 f8             	lea    -0x8(%ebp),%esp
 34b:	89 f0                	mov    %esi,%eax
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5d                   	pop    %ebp
 350:	c3                   	ret    
 351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 358:	be ff ff ff ff       	mov    $0xffffffff,%esi
 35d:	eb e9                	jmp    348 <stat+0x38>
 35f:	90                   	nop

00000360 <atoi>:
 360:	f3 0f 1e fb          	endbr32 
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	53                   	push   %ebx
 368:	8b 55 08             	mov    0x8(%ebp),%edx
 36b:	0f be 02             	movsbl (%edx),%eax
 36e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 371:	80 f9 09             	cmp    $0x9,%cl
 374:	b9 00 00 00 00       	mov    $0x0,%ecx
 379:	77 1a                	ja     395 <atoi+0x35>
 37b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 37f:	90                   	nop
 380:	83 c2 01             	add    $0x1,%edx
 383:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 386:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 38a:	0f be 02             	movsbl (%edx),%eax
 38d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
 395:	89 c8                	mov    %ecx,%eax
 397:	5b                   	pop    %ebx
 398:	5d                   	pop    %ebp
 399:	c3                   	ret    
 39a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000003a0 <memmove>:
 3a0:	f3 0f 1e fb          	endbr32 
 3a4:	55                   	push   %ebp
 3a5:	89 e5                	mov    %esp,%ebp
 3a7:	57                   	push   %edi
 3a8:	8b 45 10             	mov    0x10(%ebp),%eax
 3ab:	8b 55 08             	mov    0x8(%ebp),%edx
 3ae:	56                   	push   %esi
 3af:	8b 75 0c             	mov    0xc(%ebp),%esi
 3b2:	85 c0                	test   %eax,%eax
 3b4:	7e 0f                	jle    3c5 <memmove+0x25>
 3b6:	01 d0                	add    %edx,%eax
 3b8:	89 d7                	mov    %edx,%edi
 3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 3c1:	39 f8                	cmp    %edi,%eax
 3c3:	75 fb                	jne    3c0 <memmove+0x20>
 3c5:	5e                   	pop    %esi
 3c6:	89 d0                	mov    %edx,%eax
 3c8:	5f                   	pop    %edi
 3c9:	5d                   	pop    %ebp
 3ca:	c3                   	ret    

000003cb <fork>:
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <exit>:
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <wait>:
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <pipe>:
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <read>:
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <write>:
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <close>:
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <kill>:
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <exec>:
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <open>:
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mknod>:
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <unlink>:
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <fstat>:
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <link>:
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mkdir>:
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <chdir>:
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <dup>:
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <getpid>:
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <sbrk>:
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <sleep>:
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <uptime>:
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <calculate_sum_of_digits>:
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <get_file_sectors>:
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <get_parent_pid>:
 483:	b8 18 00 00 00       	mov    $0x18,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret    

0000048b <wait_sleeping>:
 48b:	b8 19 00 00 00       	mov    $0x19,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret    

00000493 <set_proc_tracer>:
 493:	b8 1a 00 00 00       	mov    $0x1a,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret    
 49b:	66 90                	xchg   %ax,%ax
 49d:	66 90                	xchg   %ax,%ax
 49f:	90                   	nop

000004a0 <printint>:
 4a0:	55                   	push   %ebp
 4a1:	89 e5                	mov    %esp,%ebp
 4a3:	57                   	push   %edi
 4a4:	56                   	push   %esi
 4a5:	53                   	push   %ebx
 4a6:	83 ec 3c             	sub    $0x3c,%esp
 4a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 4ac:	89 d1                	mov    %edx,%ecx
 4ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
 4b1:	85 d2                	test   %edx,%edx
 4b3:	0f 89 7f 00 00 00    	jns    538 <printint+0x98>
 4b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 4bd:	74 79                	je     538 <printint+0x98>
 4bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 4c6:	f7 d9                	neg    %ecx
 4c8:	31 db                	xor    %ebx,%ebx
 4ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 4cd:	8d 76 00             	lea    0x0(%esi),%esi
 4d0:	89 c8                	mov    %ecx,%eax
 4d2:	31 d2                	xor    %edx,%edx
 4d4:	89 cf                	mov    %ecx,%edi
 4d6:	f7 75 c4             	divl   -0x3c(%ebp)
 4d9:	0f b6 92 20 09 00 00 	movzbl 0x920(%edx),%edx
 4e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 4e3:	89 d8                	mov    %ebx,%eax
 4e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 4e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 4eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 4ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 4f1:	76 dd                	jbe    4d0 <printint+0x30>
 4f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 4f6:	85 c9                	test   %ecx,%ecx
 4f8:	74 0c                	je     506 <printint+0x66>
 4fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 4ff:	89 d8                	mov    %ebx,%eax
 501:	ba 2d 00 00 00       	mov    $0x2d,%edx
 506:	8b 7d b8             	mov    -0x48(%ebp),%edi
 509:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 50d:	eb 07                	jmp    516 <printint+0x76>
 50f:	90                   	nop
 510:	0f b6 13             	movzbl (%ebx),%edx
 513:	83 eb 01             	sub    $0x1,%ebx
 516:	83 ec 04             	sub    $0x4,%esp
 519:	88 55 d7             	mov    %dl,-0x29(%ebp)
 51c:	6a 01                	push   $0x1
 51e:	56                   	push   %esi
 51f:	57                   	push   %edi
 520:	e8 ce fe ff ff       	call   3f3 <write>
 525:	83 c4 10             	add    $0x10,%esp
 528:	39 de                	cmp    %ebx,%esi
 52a:	75 e4                	jne    510 <printint+0x70>
 52c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 52f:	5b                   	pop    %ebx
 530:	5e                   	pop    %esi
 531:	5f                   	pop    %edi
 532:	5d                   	pop    %ebp
 533:	c3                   	ret    
 534:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 538:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 53f:	eb 87                	jmp    4c8 <printint+0x28>
 541:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 548:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 54f:	90                   	nop

00000550 <printf>:
 550:	f3 0f 1e fb          	endbr32 
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	57                   	push   %edi
 558:	56                   	push   %esi
 559:	53                   	push   %ebx
 55a:	83 ec 2c             	sub    $0x2c,%esp
 55d:	8b 75 0c             	mov    0xc(%ebp),%esi
 560:	0f b6 1e             	movzbl (%esi),%ebx
 563:	84 db                	test   %bl,%bl
 565:	0f 84 b4 00 00 00    	je     61f <printf+0xcf>
 56b:	8d 45 10             	lea    0x10(%ebp),%eax
 56e:	83 c6 01             	add    $0x1,%esi
 571:	8d 7d e7             	lea    -0x19(%ebp),%edi
 574:	31 d2                	xor    %edx,%edx
 576:	89 45 d0             	mov    %eax,-0x30(%ebp)
 579:	eb 33                	jmp    5ae <printf+0x5e>
 57b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 57f:	90                   	nop
 580:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 583:	ba 25 00 00 00       	mov    $0x25,%edx
 588:	83 f8 25             	cmp    $0x25,%eax
 58b:	74 17                	je     5a4 <printf+0x54>
 58d:	83 ec 04             	sub    $0x4,%esp
 590:	88 5d e7             	mov    %bl,-0x19(%ebp)
 593:	6a 01                	push   $0x1
 595:	57                   	push   %edi
 596:	ff 75 08             	pushl  0x8(%ebp)
 599:	e8 55 fe ff ff       	call   3f3 <write>
 59e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 5a1:	83 c4 10             	add    $0x10,%esp
 5a4:	0f b6 1e             	movzbl (%esi),%ebx
 5a7:	83 c6 01             	add    $0x1,%esi
 5aa:	84 db                	test   %bl,%bl
 5ac:	74 71                	je     61f <printf+0xcf>
 5ae:	0f be cb             	movsbl %bl,%ecx
 5b1:	0f b6 c3             	movzbl %bl,%eax
 5b4:	85 d2                	test   %edx,%edx
 5b6:	74 c8                	je     580 <printf+0x30>
 5b8:	83 fa 25             	cmp    $0x25,%edx
 5bb:	75 e7                	jne    5a4 <printf+0x54>
 5bd:	83 f8 64             	cmp    $0x64,%eax
 5c0:	0f 84 9a 00 00 00    	je     660 <printf+0x110>
 5c6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 5cc:	83 f9 70             	cmp    $0x70,%ecx
 5cf:	74 5f                	je     630 <printf+0xe0>
 5d1:	83 f8 73             	cmp    $0x73,%eax
 5d4:	0f 84 d6 00 00 00    	je     6b0 <printf+0x160>
 5da:	83 f8 63             	cmp    $0x63,%eax
 5dd:	0f 84 8d 00 00 00    	je     670 <printf+0x120>
 5e3:	83 f8 25             	cmp    $0x25,%eax
 5e6:	0f 84 b4 00 00 00    	je     6a0 <printf+0x150>
 5ec:	83 ec 04             	sub    $0x4,%esp
 5ef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 5f3:	6a 01                	push   $0x1
 5f5:	57                   	push   %edi
 5f6:	ff 75 08             	pushl  0x8(%ebp)
 5f9:	e8 f5 fd ff ff       	call   3f3 <write>
 5fe:	88 5d e7             	mov    %bl,-0x19(%ebp)
 601:	83 c4 0c             	add    $0xc,%esp
 604:	6a 01                	push   $0x1
 606:	83 c6 01             	add    $0x1,%esi
 609:	57                   	push   %edi
 60a:	ff 75 08             	pushl  0x8(%ebp)
 60d:	e8 e1 fd ff ff       	call   3f3 <write>
 612:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 616:	83 c4 10             	add    $0x10,%esp
 619:	31 d2                	xor    %edx,%edx
 61b:	84 db                	test   %bl,%bl
 61d:	75 8f                	jne    5ae <printf+0x5e>
 61f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 622:	5b                   	pop    %ebx
 623:	5e                   	pop    %esi
 624:	5f                   	pop    %edi
 625:	5d                   	pop    %ebp
 626:	c3                   	ret    
 627:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 62e:	66 90                	xchg   %ax,%ax
 630:	83 ec 0c             	sub    $0xc,%esp
 633:	b9 10 00 00 00       	mov    $0x10,%ecx
 638:	6a 00                	push   $0x0
 63a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 63d:	8b 45 08             	mov    0x8(%ebp),%eax
 640:	8b 13                	mov    (%ebx),%edx
 642:	e8 59 fe ff ff       	call   4a0 <printint>
 647:	89 d8                	mov    %ebx,%eax
 649:	83 c4 10             	add    $0x10,%esp
 64c:	31 d2                	xor    %edx,%edx
 64e:	83 c0 04             	add    $0x4,%eax
 651:	89 45 d0             	mov    %eax,-0x30(%ebp)
 654:	e9 4b ff ff ff       	jmp    5a4 <printf+0x54>
 659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 660:	83 ec 0c             	sub    $0xc,%esp
 663:	b9 0a 00 00 00       	mov    $0xa,%ecx
 668:	6a 01                	push   $0x1
 66a:	eb ce                	jmp    63a <printf+0xea>
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 670:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 673:	83 ec 04             	sub    $0x4,%esp
 676:	8b 03                	mov    (%ebx),%eax
 678:	6a 01                	push   $0x1
 67a:	83 c3 04             	add    $0x4,%ebx
 67d:	57                   	push   %edi
 67e:	ff 75 08             	pushl  0x8(%ebp)
 681:	88 45 e7             	mov    %al,-0x19(%ebp)
 684:	e8 6a fd ff ff       	call   3f3 <write>
 689:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 68c:	83 c4 10             	add    $0x10,%esp
 68f:	31 d2                	xor    %edx,%edx
 691:	e9 0e ff ff ff       	jmp    5a4 <printf+0x54>
 696:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 69d:	8d 76 00             	lea    0x0(%esi),%esi
 6a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 6a3:	83 ec 04             	sub    $0x4,%esp
 6a6:	e9 59 ff ff ff       	jmp    604 <printf+0xb4>
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
 6b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b3:	8b 18                	mov    (%eax),%ebx
 6b5:	83 c0 04             	add    $0x4,%eax
 6b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 6bb:	85 db                	test   %ebx,%ebx
 6bd:	74 17                	je     6d6 <printf+0x186>
 6bf:	0f b6 03             	movzbl (%ebx),%eax
 6c2:	31 d2                	xor    %edx,%edx
 6c4:	84 c0                	test   %al,%al
 6c6:	0f 84 d8 fe ff ff    	je     5a4 <printf+0x54>
 6cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6cf:	89 de                	mov    %ebx,%esi
 6d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6d4:	eb 1a                	jmp    6f0 <printf+0x1a0>
 6d6:	bb 18 09 00 00       	mov    $0x918,%ebx
 6db:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6de:	b8 28 00 00 00       	mov    $0x28,%eax
 6e3:	89 de                	mov    %ebx,%esi
 6e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 6e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 6ef:	90                   	nop
 6f0:	83 ec 04             	sub    $0x4,%esp
 6f3:	83 c6 01             	add    $0x1,%esi
 6f6:	88 45 e7             	mov    %al,-0x19(%ebp)
 6f9:	6a 01                	push   $0x1
 6fb:	57                   	push   %edi
 6fc:	53                   	push   %ebx
 6fd:	e8 f1 fc ff ff       	call   3f3 <write>
 702:	0f b6 06             	movzbl (%esi),%eax
 705:	83 c4 10             	add    $0x10,%esp
 708:	84 c0                	test   %al,%al
 70a:	75 e4                	jne    6f0 <printf+0x1a0>
 70c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 70f:	31 d2                	xor    %edx,%edx
 711:	e9 8e fe ff ff       	jmp    5a4 <printf+0x54>
 716:	66 90                	xchg   %ax,%ax
 718:	66 90                	xchg   %ax,%ax
 71a:	66 90                	xchg   %ax,%ax
 71c:	66 90                	xchg   %ax,%ax
 71e:	66 90                	xchg   %ax,%ax

00000720 <free>:
 720:	f3 0f 1e fb          	endbr32 
 724:	55                   	push   %ebp
 725:	a1 38 0c 00 00       	mov    0xc38,%eax
 72a:	89 e5                	mov    %esp,%ebp
 72c:	57                   	push   %edi
 72d:	56                   	push   %esi
 72e:	53                   	push   %ebx
 72f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 732:	8b 10                	mov    (%eax),%edx
 734:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 737:	39 c8                	cmp    %ecx,%eax
 739:	73 15                	jae    750 <free+0x30>
 73b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 73f:	90                   	nop
 740:	39 d1                	cmp    %edx,%ecx
 742:	72 14                	jb     758 <free+0x38>
 744:	39 d0                	cmp    %edx,%eax
 746:	73 10                	jae    758 <free+0x38>
 748:	89 d0                	mov    %edx,%eax
 74a:	8b 10                	mov    (%eax),%edx
 74c:	39 c8                	cmp    %ecx,%eax
 74e:	72 f0                	jb     740 <free+0x20>
 750:	39 d0                	cmp    %edx,%eax
 752:	72 f4                	jb     748 <free+0x28>
 754:	39 d1                	cmp    %edx,%ecx
 756:	73 f0                	jae    748 <free+0x28>
 758:	8b 73 fc             	mov    -0x4(%ebx),%esi
 75b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75e:	39 fa                	cmp    %edi,%edx
 760:	74 1e                	je     780 <free+0x60>
 762:	89 53 f8             	mov    %edx,-0x8(%ebx)
 765:	8b 50 04             	mov    0x4(%eax),%edx
 768:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 76b:	39 f1                	cmp    %esi,%ecx
 76d:	74 28                	je     797 <free+0x77>
 76f:	89 08                	mov    %ecx,(%eax)
 771:	5b                   	pop    %ebx
 772:	a3 38 0c 00 00       	mov    %eax,0xc38
 777:	5e                   	pop    %esi
 778:	5f                   	pop    %edi
 779:	5d                   	pop    %ebp
 77a:	c3                   	ret    
 77b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 77f:	90                   	nop
 780:	03 72 04             	add    0x4(%edx),%esi
 783:	89 73 fc             	mov    %esi,-0x4(%ebx)
 786:	8b 10                	mov    (%eax),%edx
 788:	8b 12                	mov    (%edx),%edx
 78a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 78d:	8b 50 04             	mov    0x4(%eax),%edx
 790:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 793:	39 f1                	cmp    %esi,%ecx
 795:	75 d8                	jne    76f <free+0x4f>
 797:	03 53 fc             	add    -0x4(%ebx),%edx
 79a:	a3 38 0c 00 00       	mov    %eax,0xc38
 79f:	89 50 04             	mov    %edx,0x4(%eax)
 7a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 7a5:	89 10                	mov    %edx,(%eax)
 7a7:	5b                   	pop    %ebx
 7a8:	5e                   	pop    %esi
 7a9:	5f                   	pop    %edi
 7aa:	5d                   	pop    %ebp
 7ab:	c3                   	ret    
 7ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007b0 <malloc>:
 7b0:	f3 0f 1e fb          	endbr32 
 7b4:	55                   	push   %ebp
 7b5:	89 e5                	mov    %esp,%ebp
 7b7:	57                   	push   %edi
 7b8:	56                   	push   %esi
 7b9:	53                   	push   %ebx
 7ba:	83 ec 1c             	sub    $0x1c,%esp
 7bd:	8b 45 08             	mov    0x8(%ebp),%eax
 7c0:	8b 3d 38 0c 00 00    	mov    0xc38,%edi
 7c6:	8d 70 07             	lea    0x7(%eax),%esi
 7c9:	c1 ee 03             	shr    $0x3,%esi
 7cc:	83 c6 01             	add    $0x1,%esi
 7cf:	85 ff                	test   %edi,%edi
 7d1:	0f 84 a9 00 00 00    	je     880 <malloc+0xd0>
 7d7:	8b 07                	mov    (%edi),%eax
 7d9:	8b 48 04             	mov    0x4(%eax),%ecx
 7dc:	39 f1                	cmp    %esi,%ecx
 7de:	73 6d                	jae    84d <malloc+0x9d>
 7e0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 7e6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7eb:	0f 43 de             	cmovae %esi,%ebx
 7ee:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 7f5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 7f8:	eb 17                	jmp    811 <malloc+0x61>
 7fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 800:	8b 10                	mov    (%eax),%edx
 802:	8b 4a 04             	mov    0x4(%edx),%ecx
 805:	39 f1                	cmp    %esi,%ecx
 807:	73 4f                	jae    858 <malloc+0xa8>
 809:	8b 3d 38 0c 00 00    	mov    0xc38,%edi
 80f:	89 d0                	mov    %edx,%eax
 811:	39 c7                	cmp    %eax,%edi
 813:	75 eb                	jne    800 <malloc+0x50>
 815:	83 ec 0c             	sub    $0xc,%esp
 818:	ff 75 e4             	pushl  -0x1c(%ebp)
 81b:	e8 3b fc ff ff       	call   45b <sbrk>
 820:	83 c4 10             	add    $0x10,%esp
 823:	83 f8 ff             	cmp    $0xffffffff,%eax
 826:	74 1b                	je     843 <malloc+0x93>
 828:	89 58 04             	mov    %ebx,0x4(%eax)
 82b:	83 ec 0c             	sub    $0xc,%esp
 82e:	83 c0 08             	add    $0x8,%eax
 831:	50                   	push   %eax
 832:	e8 e9 fe ff ff       	call   720 <free>
 837:	a1 38 0c 00 00       	mov    0xc38,%eax
 83c:	83 c4 10             	add    $0x10,%esp
 83f:	85 c0                	test   %eax,%eax
 841:	75 bd                	jne    800 <malloc+0x50>
 843:	8d 65 f4             	lea    -0xc(%ebp),%esp
 846:	31 c0                	xor    %eax,%eax
 848:	5b                   	pop    %ebx
 849:	5e                   	pop    %esi
 84a:	5f                   	pop    %edi
 84b:	5d                   	pop    %ebp
 84c:	c3                   	ret    
 84d:	89 c2                	mov    %eax,%edx
 84f:	89 f8                	mov    %edi,%eax
 851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 858:	39 ce                	cmp    %ecx,%esi
 85a:	74 54                	je     8b0 <malloc+0x100>
 85c:	29 f1                	sub    %esi,%ecx
 85e:	89 4a 04             	mov    %ecx,0x4(%edx)
 861:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 864:	89 72 04             	mov    %esi,0x4(%edx)
 867:	a3 38 0c 00 00       	mov    %eax,0xc38
 86c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 86f:	8d 42 08             	lea    0x8(%edx),%eax
 872:	5b                   	pop    %ebx
 873:	5e                   	pop    %esi
 874:	5f                   	pop    %edi
 875:	5d                   	pop    %ebp
 876:	c3                   	ret    
 877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 87e:	66 90                	xchg   %ax,%ax
 880:	c7 05 38 0c 00 00 3c 	movl   $0xc3c,0xc38
 887:	0c 00 00 
 88a:	bf 3c 0c 00 00       	mov    $0xc3c,%edi
 88f:	c7 05 3c 0c 00 00 3c 	movl   $0xc3c,0xc3c
 896:	0c 00 00 
 899:	89 f8                	mov    %edi,%eax
 89b:	c7 05 40 0c 00 00 00 	movl   $0x0,0xc40
 8a2:	00 00 00 
 8a5:	e9 36 ff ff ff       	jmp    7e0 <malloc+0x30>
 8aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 8b0:	8b 0a                	mov    (%edx),%ecx
 8b2:	89 08                	mov    %ecx,(%eax)
 8b4:	eb b1                	jmp    867 <malloc+0xb7>
