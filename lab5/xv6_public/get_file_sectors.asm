
_get_file_sectors:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	56                   	push   %esi
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 0c             	sub    $0xc,%esp
  17:	83 39 01             	cmpl   $0x1,(%ecx)
  1a:	8b 59 04             	mov    0x4(%ecx),%ebx
  1d:	0f 8e 96 00 00 00    	jle    b9 <main+0xb9>
  23:	50                   	push   %eax
  24:	50                   	push   %eax
  25:	6a 00                	push   $0x0
  27:	ff 73 04             	pushl  0x4(%ebx)
  2a:	e8 44 03 00 00       	call   373 <open>
  2f:	83 c4 10             	add    $0x10,%esp
  32:	89 c6                	mov    %eax,%esi
  34:	85 c0                	test   %eax,%eax
  36:	78 6c                	js     a4 <main+0xa4>
  38:	83 ec 0c             	sub    $0xc,%esp
  3b:	68 20 03 00 00       	push   $0x320
  40:	e8 cb 06 00 00       	call   710 <malloc>
  45:	83 c4 0c             	add    $0xc,%esp
  48:	68 c8 00 00 00       	push   $0xc8
  4d:	89 c3                	mov    %eax,%ebx
  4f:	50                   	push   %eax
  50:	56                   	push   %esi
  51:	8d b3 20 03 00 00    	lea    0x320(%ebx),%esi
  57:	e8 7f 03 00 00       	call   3db <get_file_sectors>
  5c:	5a                   	pop    %edx
  5d:	59                   	pop    %ecx
  5e:	68 54 08 00 00       	push   $0x854
  63:	6a 01                	push   $0x1
  65:	e8 46 04 00 00       	call   4b0 <printf>
  6a:	83 c4 10             	add    $0x10,%esp
  6d:	eb 1b                	jmp    8a <main+0x8a>
  6f:	90                   	nop
  70:	83 ec 04             	sub    $0x4,%esp
  73:	83 c3 04             	add    $0x4,%ebx
  76:	50                   	push   %eax
  77:	68 67 08 00 00       	push   $0x867
  7c:	6a 01                	push   $0x1
  7e:	e8 2d 04 00 00       	call   4b0 <printf>
  83:	83 c4 10             	add    $0x10,%esp
  86:	39 f3                	cmp    %esi,%ebx
  88:	74 07                	je     91 <main+0x91>
  8a:	8b 03                	mov    (%ebx),%eax
  8c:	83 f8 ff             	cmp    $0xffffffff,%eax
  8f:	75 df                	jne    70 <main+0x70>
  91:	50                   	push   %eax
  92:	50                   	push   %eax
  93:	68 65 08 00 00       	push   $0x865
  98:	6a 01                	push   $0x1
  9a:	e8 11 04 00 00       	call   4b0 <printf>
  9f:	e8 8f 02 00 00       	call   333 <exit>
  a4:	56                   	push   %esi
  a5:	ff 73 04             	pushl  0x4(%ebx)
  a8:	68 3d 08 00 00       	push   $0x83d
  ad:	6a 01                	push   $0x1
  af:	e8 fc 03 00 00       	call   4b0 <printf>
  b4:	e8 7a 02 00 00       	call   333 <exit>
  b9:	50                   	push   %eax
  ba:	50                   	push   %eax
  bb:	68 18 08 00 00       	push   $0x818
  c0:	6a 01                	push   $0x1
  c2:	e8 e9 03 00 00       	call   4b0 <printf>
  c7:	e8 67 02 00 00       	call   333 <exit>
  cc:	66 90                	xchg   %ax,%ax
  ce:	66 90                	xchg   %ax,%ax

000000d0 <strcpy>:
  d0:	f3 0f 1e fb          	endbr32 
  d4:	55                   	push   %ebp
  d5:	31 c0                	xor    %eax,%eax
  d7:	89 e5                	mov    %esp,%ebp
  d9:	53                   	push   %ebx
  da:	8b 4d 08             	mov    0x8(%ebp),%ecx
  dd:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  e0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  e4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  e7:	83 c0 01             	add    $0x1,%eax
  ea:	84 d2                	test   %dl,%dl
  ec:	75 f2                	jne    e0 <strcpy+0x10>
  ee:	89 c8                	mov    %ecx,%eax
  f0:	5b                   	pop    %ebx
  f1:	5d                   	pop    %ebp
  f2:	c3                   	ret    
  f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000100 <strcmp>:
 100:	f3 0f 1e fb          	endbr32 
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	53                   	push   %ebx
 108:	8b 4d 08             	mov    0x8(%ebp),%ecx
 10b:	8b 55 0c             	mov    0xc(%ebp),%edx
 10e:	0f b6 01             	movzbl (%ecx),%eax
 111:	0f b6 1a             	movzbl (%edx),%ebx
 114:	84 c0                	test   %al,%al
 116:	75 19                	jne    131 <strcmp+0x31>
 118:	eb 26                	jmp    140 <strcmp+0x40>
 11a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 120:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
 124:	83 c1 01             	add    $0x1,%ecx
 127:	83 c2 01             	add    $0x1,%edx
 12a:	0f b6 1a             	movzbl (%edx),%ebx
 12d:	84 c0                	test   %al,%al
 12f:	74 0f                	je     140 <strcmp+0x40>
 131:	38 d8                	cmp    %bl,%al
 133:	74 eb                	je     120 <strcmp+0x20>
 135:	29 d8                	sub    %ebx,%eax
 137:	5b                   	pop    %ebx
 138:	5d                   	pop    %ebp
 139:	c3                   	ret    
 13a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 140:	31 c0                	xor    %eax,%eax
 142:	29 d8                	sub    %ebx,%eax
 144:	5b                   	pop    %ebx
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax

00000150 <strlen>:
 150:	f3 0f 1e fb          	endbr32 
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	8b 55 08             	mov    0x8(%ebp),%edx
 15a:	80 3a 00             	cmpb   $0x0,(%edx)
 15d:	74 21                	je     180 <strlen+0x30>
 15f:	31 c0                	xor    %eax,%eax
 161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 168:	83 c0 01             	add    $0x1,%eax
 16b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 16f:	89 c1                	mov    %eax,%ecx
 171:	75 f5                	jne    168 <strlen+0x18>
 173:	89 c8                	mov    %ecx,%eax
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 17e:	66 90                	xchg   %ax,%ax
 180:	31 c9                	xor    %ecx,%ecx
 182:	5d                   	pop    %ebp
 183:	89 c8                	mov    %ecx,%eax
 185:	c3                   	ret    
 186:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 18d:	8d 76 00             	lea    0x0(%esi),%esi

00000190 <memset>:
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	57                   	push   %edi
 198:	8b 55 08             	mov    0x8(%ebp),%edx
 19b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 19e:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a1:	89 d7                	mov    %edx,%edi
 1a3:	fc                   	cld    
 1a4:	f3 aa                	rep stos %al,%es:(%edi)
 1a6:	89 d0                	mov    %edx,%eax
 1a8:	5f                   	pop    %edi
 1a9:	5d                   	pop    %ebp
 1aa:	c3                   	ret    
 1ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1af:	90                   	nop

000001b0 <strchr>:
 1b0:	f3 0f 1e fb          	endbr32 
 1b4:	55                   	push   %ebp
 1b5:	89 e5                	mov    %esp,%ebp
 1b7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ba:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 1be:	0f b6 10             	movzbl (%eax),%edx
 1c1:	84 d2                	test   %dl,%dl
 1c3:	75 16                	jne    1db <strchr+0x2b>
 1c5:	eb 21                	jmp    1e8 <strchr+0x38>
 1c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ce:	66 90                	xchg   %ax,%ax
 1d0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1d4:	83 c0 01             	add    $0x1,%eax
 1d7:	84 d2                	test   %dl,%dl
 1d9:	74 0d                	je     1e8 <strchr+0x38>
 1db:	38 d1                	cmp    %dl,%cl
 1dd:	75 f1                	jne    1d0 <strchr+0x20>
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    
 1e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e8:	31 c0                	xor    %eax,%eax
 1ea:	5d                   	pop    %ebp
 1eb:	c3                   	ret    
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001f0 <gets>:
 1f0:	f3 0f 1e fb          	endbr32 
 1f4:	55                   	push   %ebp
 1f5:	89 e5                	mov    %esp,%ebp
 1f7:	57                   	push   %edi
 1f8:	56                   	push   %esi
 1f9:	31 f6                	xor    %esi,%esi
 1fb:	53                   	push   %ebx
 1fc:	89 f3                	mov    %esi,%ebx
 1fe:	83 ec 1c             	sub    $0x1c,%esp
 201:	8b 7d 08             	mov    0x8(%ebp),%edi
 204:	eb 33                	jmp    239 <gets+0x49>
 206:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 ec 04             	sub    $0x4,%esp
 213:	8d 45 e7             	lea    -0x19(%ebp),%eax
 216:	6a 01                	push   $0x1
 218:	50                   	push   %eax
 219:	6a 00                	push   $0x0
 21b:	e8 2b 01 00 00       	call   34b <read>
 220:	83 c4 10             	add    $0x10,%esp
 223:	85 c0                	test   %eax,%eax
 225:	7e 1c                	jle    243 <gets+0x53>
 227:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 22b:	83 c7 01             	add    $0x1,%edi
 22e:	88 47 ff             	mov    %al,-0x1(%edi)
 231:	3c 0a                	cmp    $0xa,%al
 233:	74 23                	je     258 <gets+0x68>
 235:	3c 0d                	cmp    $0xd,%al
 237:	74 1f                	je     258 <gets+0x68>
 239:	83 c3 01             	add    $0x1,%ebx
 23c:	89 fe                	mov    %edi,%esi
 23e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 241:	7c cd                	jl     210 <gets+0x20>
 243:	89 f3                	mov    %esi,%ebx
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	c6 03 00             	movb   $0x0,(%ebx)
 24b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 24e:	5b                   	pop    %ebx
 24f:	5e                   	pop    %esi
 250:	5f                   	pop    %edi
 251:	5d                   	pop    %ebp
 252:	c3                   	ret    
 253:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 257:	90                   	nop
 258:	8b 75 08             	mov    0x8(%ebp),%esi
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	01 de                	add    %ebx,%esi
 260:	89 f3                	mov    %esi,%ebx
 262:	c6 03 00             	movb   $0x0,(%ebx)
 265:	8d 65 f4             	lea    -0xc(%ebp),%esp
 268:	5b                   	pop    %ebx
 269:	5e                   	pop    %esi
 26a:	5f                   	pop    %edi
 26b:	5d                   	pop    %ebp
 26c:	c3                   	ret    
 26d:	8d 76 00             	lea    0x0(%esi),%esi

00000270 <stat>:
 270:	f3 0f 1e fb          	endbr32 
 274:	55                   	push   %ebp
 275:	89 e5                	mov    %esp,%ebp
 277:	56                   	push   %esi
 278:	53                   	push   %ebx
 279:	83 ec 08             	sub    $0x8,%esp
 27c:	6a 00                	push   $0x0
 27e:	ff 75 08             	pushl  0x8(%ebp)
 281:	e8 ed 00 00 00       	call   373 <open>
 286:	83 c4 10             	add    $0x10,%esp
 289:	85 c0                	test   %eax,%eax
 28b:	78 2b                	js     2b8 <stat+0x48>
 28d:	83 ec 08             	sub    $0x8,%esp
 290:	ff 75 0c             	pushl  0xc(%ebp)
 293:	89 c3                	mov    %eax,%ebx
 295:	50                   	push   %eax
 296:	e8 f0 00 00 00       	call   38b <fstat>
 29b:	89 1c 24             	mov    %ebx,(%esp)
 29e:	89 c6                	mov    %eax,%esi
 2a0:	e8 b6 00 00 00       	call   35b <close>
 2a5:	83 c4 10             	add    $0x10,%esp
 2a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2ab:	89 f0                	mov    %esi,%eax
 2ad:	5b                   	pop    %ebx
 2ae:	5e                   	pop    %esi
 2af:	5d                   	pop    %ebp
 2b0:	c3                   	ret    
 2b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 2b8:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2bd:	eb e9                	jmp    2a8 <stat+0x38>
 2bf:	90                   	nop

000002c0 <atoi>:
 2c0:	f3 0f 1e fb          	endbr32 
 2c4:	55                   	push   %ebp
 2c5:	89 e5                	mov    %esp,%ebp
 2c7:	53                   	push   %ebx
 2c8:	8b 55 08             	mov    0x8(%ebp),%edx
 2cb:	0f be 02             	movsbl (%edx),%eax
 2ce:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2d1:	80 f9 09             	cmp    $0x9,%cl
 2d4:	b9 00 00 00 00       	mov    $0x0,%ecx
 2d9:	77 1a                	ja     2f5 <atoi+0x35>
 2db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2df:	90                   	nop
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2e6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 2ea:	0f be 02             	movsbl (%edx),%eax
 2ed:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2f0:	80 fb 09             	cmp    $0x9,%bl
 2f3:	76 eb                	jbe    2e0 <atoi+0x20>
 2f5:	89 c8                	mov    %ecx,%eax
 2f7:	5b                   	pop    %ebx
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    
 2fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000300 <memmove>:
 300:	f3 0f 1e fb          	endbr32 
 304:	55                   	push   %ebp
 305:	89 e5                	mov    %esp,%ebp
 307:	57                   	push   %edi
 308:	8b 45 10             	mov    0x10(%ebp),%eax
 30b:	8b 55 08             	mov    0x8(%ebp),%edx
 30e:	56                   	push   %esi
 30f:	8b 75 0c             	mov    0xc(%ebp),%esi
 312:	85 c0                	test   %eax,%eax
 314:	7e 0f                	jle    325 <memmove+0x25>
 316:	01 d0                	add    %edx,%eax
 318:	89 d7                	mov    %edx,%edi
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 320:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 321:	39 f8                	cmp    %edi,%eax
 323:	75 fb                	jne    320 <memmove+0x20>
 325:	5e                   	pop    %esi
 326:	89 d0                	mov    %edx,%eax
 328:	5f                   	pop    %edi
 329:	5d                   	pop    %ebp
 32a:	c3                   	ret    

0000032b <fork>:
 32b:	b8 01 00 00 00       	mov    $0x1,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <exit>:
 333:	b8 02 00 00 00       	mov    $0x2,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <wait>:
 33b:	b8 03 00 00 00       	mov    $0x3,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <pipe>:
 343:	b8 04 00 00 00       	mov    $0x4,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <read>:
 34b:	b8 05 00 00 00       	mov    $0x5,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <write>:
 353:	b8 10 00 00 00       	mov    $0x10,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <close>:
 35b:	b8 15 00 00 00       	mov    $0x15,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <kill>:
 363:	b8 06 00 00 00       	mov    $0x6,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <exec>:
 36b:	b8 07 00 00 00       	mov    $0x7,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <open>:
 373:	b8 0f 00 00 00       	mov    $0xf,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <mknod>:
 37b:	b8 11 00 00 00       	mov    $0x11,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <unlink>:
 383:	b8 12 00 00 00       	mov    $0x12,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <fstat>:
 38b:	b8 08 00 00 00       	mov    $0x8,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <link>:
 393:	b8 13 00 00 00       	mov    $0x13,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mkdir>:
 39b:	b8 14 00 00 00       	mov    $0x14,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <chdir>:
 3a3:	b8 09 00 00 00       	mov    $0x9,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <dup>:
 3ab:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <getpid>:
 3b3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <sbrk>:
 3bb:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <sleep>:
 3c3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <uptime>:
 3cb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <calculate_sum_of_digits>:
 3d3:	b8 16 00 00 00       	mov    $0x16,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <get_file_sectors>:
 3db:	b8 17 00 00 00       	mov    $0x17,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <get_parent_pid>:
 3e3:	b8 18 00 00 00       	mov    $0x18,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <wait_sleeping>:
 3eb:	b8 19 00 00 00       	mov    $0x19,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <set_proc_tracer>:
 3f3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    
 3fb:	66 90                	xchg   %ax,%ax
 3fd:	66 90                	xchg   %ax,%ax
 3ff:	90                   	nop

00000400 <printint>:
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	83 ec 3c             	sub    $0x3c,%esp
 409:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 40c:	89 d1                	mov    %edx,%ecx
 40e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 411:	85 d2                	test   %edx,%edx
 413:	0f 89 7f 00 00 00    	jns    498 <printint+0x98>
 419:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 41d:	74 79                	je     498 <printint+0x98>
 41f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 426:	f7 d9                	neg    %ecx
 428:	31 db                	xor    %ebx,%ebx
 42a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 42d:	8d 76 00             	lea    0x0(%esi),%esi
 430:	89 c8                	mov    %ecx,%eax
 432:	31 d2                	xor    %edx,%edx
 434:	89 cf                	mov    %ecx,%edi
 436:	f7 75 c4             	divl   -0x3c(%ebp)
 439:	0f b6 92 74 08 00 00 	movzbl 0x874(%edx),%edx
 440:	89 45 c0             	mov    %eax,-0x40(%ebp)
 443:	89 d8                	mov    %ebx,%eax
 445:	8d 5b 01             	lea    0x1(%ebx),%ebx
 448:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 44b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 44e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 451:	76 dd                	jbe    430 <printint+0x30>
 453:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 456:	85 c9                	test   %ecx,%ecx
 458:	74 0c                	je     466 <printint+0x66>
 45a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 45f:	89 d8                	mov    %ebx,%eax
 461:	ba 2d 00 00 00       	mov    $0x2d,%edx
 466:	8b 7d b8             	mov    -0x48(%ebp),%edi
 469:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 46d:	eb 07                	jmp    476 <printint+0x76>
 46f:	90                   	nop
 470:	0f b6 13             	movzbl (%ebx),%edx
 473:	83 eb 01             	sub    $0x1,%ebx
 476:	83 ec 04             	sub    $0x4,%esp
 479:	88 55 d7             	mov    %dl,-0x29(%ebp)
 47c:	6a 01                	push   $0x1
 47e:	56                   	push   %esi
 47f:	57                   	push   %edi
 480:	e8 ce fe ff ff       	call   353 <write>
 485:	83 c4 10             	add    $0x10,%esp
 488:	39 de                	cmp    %ebx,%esi
 48a:	75 e4                	jne    470 <printint+0x70>
 48c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5f                   	pop    %edi
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 498:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 49f:	eb 87                	jmp    428 <printint+0x28>
 4a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop

000004b0 <printf>:
 4b0:	f3 0f 1e fb          	endbr32 
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	57                   	push   %edi
 4b8:	56                   	push   %esi
 4b9:	53                   	push   %ebx
 4ba:	83 ec 2c             	sub    $0x2c,%esp
 4bd:	8b 75 0c             	mov    0xc(%ebp),%esi
 4c0:	0f b6 1e             	movzbl (%esi),%ebx
 4c3:	84 db                	test   %bl,%bl
 4c5:	0f 84 b4 00 00 00    	je     57f <printf+0xcf>
 4cb:	8d 45 10             	lea    0x10(%ebp),%eax
 4ce:	83 c6 01             	add    $0x1,%esi
 4d1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4d4:	31 d2                	xor    %edx,%edx
 4d6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4d9:	eb 33                	jmp    50e <printf+0x5e>
 4db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4df:	90                   	nop
 4e0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4e3:	ba 25 00 00 00       	mov    $0x25,%edx
 4e8:	83 f8 25             	cmp    $0x25,%eax
 4eb:	74 17                	je     504 <printf+0x54>
 4ed:	83 ec 04             	sub    $0x4,%esp
 4f0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4f3:	6a 01                	push   $0x1
 4f5:	57                   	push   %edi
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 55 fe ff ff       	call   353 <write>
 4fe:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 501:	83 c4 10             	add    $0x10,%esp
 504:	0f b6 1e             	movzbl (%esi),%ebx
 507:	83 c6 01             	add    $0x1,%esi
 50a:	84 db                	test   %bl,%bl
 50c:	74 71                	je     57f <printf+0xcf>
 50e:	0f be cb             	movsbl %bl,%ecx
 511:	0f b6 c3             	movzbl %bl,%eax
 514:	85 d2                	test   %edx,%edx
 516:	74 c8                	je     4e0 <printf+0x30>
 518:	83 fa 25             	cmp    $0x25,%edx
 51b:	75 e7                	jne    504 <printf+0x54>
 51d:	83 f8 64             	cmp    $0x64,%eax
 520:	0f 84 9a 00 00 00    	je     5c0 <printf+0x110>
 526:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 52c:	83 f9 70             	cmp    $0x70,%ecx
 52f:	74 5f                	je     590 <printf+0xe0>
 531:	83 f8 73             	cmp    $0x73,%eax
 534:	0f 84 d6 00 00 00    	je     610 <printf+0x160>
 53a:	83 f8 63             	cmp    $0x63,%eax
 53d:	0f 84 8d 00 00 00    	je     5d0 <printf+0x120>
 543:	83 f8 25             	cmp    $0x25,%eax
 546:	0f 84 b4 00 00 00    	je     600 <printf+0x150>
 54c:	83 ec 04             	sub    $0x4,%esp
 54f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 553:	6a 01                	push   $0x1
 555:	57                   	push   %edi
 556:	ff 75 08             	pushl  0x8(%ebp)
 559:	e8 f5 fd ff ff       	call   353 <write>
 55e:	88 5d e7             	mov    %bl,-0x19(%ebp)
 561:	83 c4 0c             	add    $0xc,%esp
 564:	6a 01                	push   $0x1
 566:	83 c6 01             	add    $0x1,%esi
 569:	57                   	push   %edi
 56a:	ff 75 08             	pushl  0x8(%ebp)
 56d:	e8 e1 fd ff ff       	call   353 <write>
 572:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 576:	83 c4 10             	add    $0x10,%esp
 579:	31 d2                	xor    %edx,%edx
 57b:	84 db                	test   %bl,%bl
 57d:	75 8f                	jne    50e <printf+0x5e>
 57f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 582:	5b                   	pop    %ebx
 583:	5e                   	pop    %esi
 584:	5f                   	pop    %edi
 585:	5d                   	pop    %ebp
 586:	c3                   	ret    
 587:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 58e:	66 90                	xchg   %ax,%ax
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 10 00 00 00       	mov    $0x10,%ecx
 598:	6a 00                	push   $0x0
 59a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	8b 13                	mov    (%ebx),%edx
 5a2:	e8 59 fe ff ff       	call   400 <printint>
 5a7:	89 d8                	mov    %ebx,%eax
 5a9:	83 c4 10             	add    $0x10,%esp
 5ac:	31 d2                	xor    %edx,%edx
 5ae:	83 c0 04             	add    $0x4,%eax
 5b1:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5b4:	e9 4b ff ff ff       	jmp    504 <printf+0x54>
 5b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5c0:	83 ec 0c             	sub    $0xc,%esp
 5c3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 5c8:	6a 01                	push   $0x1
 5ca:	eb ce                	jmp    59a <printf+0xea>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5d3:	83 ec 04             	sub    $0x4,%esp
 5d6:	8b 03                	mov    (%ebx),%eax
 5d8:	6a 01                	push   $0x1
 5da:	83 c3 04             	add    $0x4,%ebx
 5dd:	57                   	push   %edi
 5de:	ff 75 08             	pushl  0x8(%ebp)
 5e1:	88 45 e7             	mov    %al,-0x19(%ebp)
 5e4:	e8 6a fd ff ff       	call   353 <write>
 5e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ec:	83 c4 10             	add    $0x10,%esp
 5ef:	31 d2                	xor    %edx,%edx
 5f1:	e9 0e ff ff ff       	jmp    504 <printf+0x54>
 5f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5fd:	8d 76 00             	lea    0x0(%esi),%esi
 600:	88 5d e7             	mov    %bl,-0x19(%ebp)
 603:	83 ec 04             	sub    $0x4,%esp
 606:	e9 59 ff ff ff       	jmp    564 <printf+0xb4>
 60b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 60f:	90                   	nop
 610:	8b 45 d0             	mov    -0x30(%ebp),%eax
 613:	8b 18                	mov    (%eax),%ebx
 615:	83 c0 04             	add    $0x4,%eax
 618:	89 45 d0             	mov    %eax,-0x30(%ebp)
 61b:	85 db                	test   %ebx,%ebx
 61d:	74 17                	je     636 <printf+0x186>
 61f:	0f b6 03             	movzbl (%ebx),%eax
 622:	31 d2                	xor    %edx,%edx
 624:	84 c0                	test   %al,%al
 626:	0f 84 d8 fe ff ff    	je     504 <printf+0x54>
 62c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 62f:	89 de                	mov    %ebx,%esi
 631:	8b 5d 08             	mov    0x8(%ebp),%ebx
 634:	eb 1a                	jmp    650 <printf+0x1a0>
 636:	bb 6b 08 00 00       	mov    $0x86b,%ebx
 63b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 63e:	b8 28 00 00 00       	mov    $0x28,%eax
 643:	89 de                	mov    %ebx,%esi
 645:	8b 5d 08             	mov    0x8(%ebp),%ebx
 648:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 64f:	90                   	nop
 650:	83 ec 04             	sub    $0x4,%esp
 653:	83 c6 01             	add    $0x1,%esi
 656:	88 45 e7             	mov    %al,-0x19(%ebp)
 659:	6a 01                	push   $0x1
 65b:	57                   	push   %edi
 65c:	53                   	push   %ebx
 65d:	e8 f1 fc ff ff       	call   353 <write>
 662:	0f b6 06             	movzbl (%esi),%eax
 665:	83 c4 10             	add    $0x10,%esp
 668:	84 c0                	test   %al,%al
 66a:	75 e4                	jne    650 <printf+0x1a0>
 66c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 66f:	31 d2                	xor    %edx,%edx
 671:	e9 8e fe ff ff       	jmp    504 <printf+0x54>
 676:	66 90                	xchg   %ax,%ax
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
 680:	f3 0f 1e fb          	endbr32 
 684:	55                   	push   %ebp
 685:	a1 24 0b 00 00       	mov    0xb24,%eax
 68a:	89 e5                	mov    %esp,%ebp
 68c:	57                   	push   %edi
 68d:	56                   	push   %esi
 68e:	53                   	push   %ebx
 68f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 692:	8b 10                	mov    (%eax),%edx
 694:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 697:	39 c8                	cmp    %ecx,%eax
 699:	73 15                	jae    6b0 <free+0x30>
 69b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 69f:	90                   	nop
 6a0:	39 d1                	cmp    %edx,%ecx
 6a2:	72 14                	jb     6b8 <free+0x38>
 6a4:	39 d0                	cmp    %edx,%eax
 6a6:	73 10                	jae    6b8 <free+0x38>
 6a8:	89 d0                	mov    %edx,%eax
 6aa:	8b 10                	mov    (%eax),%edx
 6ac:	39 c8                	cmp    %ecx,%eax
 6ae:	72 f0                	jb     6a0 <free+0x20>
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 f4                	jb     6a8 <free+0x28>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	73 f0                	jae    6a8 <free+0x28>
 6b8:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6bb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6be:	39 fa                	cmp    %edi,%edx
 6c0:	74 1e                	je     6e0 <free+0x60>
 6c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6cb:	39 f1                	cmp    %esi,%ecx
 6cd:	74 28                	je     6f7 <free+0x77>
 6cf:	89 08                	mov    %ecx,(%eax)
 6d1:	5b                   	pop    %ebx
 6d2:	a3 24 0b 00 00       	mov    %eax,0xb24
 6d7:	5e                   	pop    %esi
 6d8:	5f                   	pop    %edi
 6d9:	5d                   	pop    %ebp
 6da:	c3                   	ret    
 6db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6df:	90                   	nop
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 d8                	jne    6cf <free+0x4f>
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
 6fa:	a3 24 0b 00 00       	mov    %eax,0xb24
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
 710:	f3 0f 1e fb          	endbr32 
 714:	55                   	push   %ebp
 715:	89 e5                	mov    %esp,%ebp
 717:	57                   	push   %edi
 718:	56                   	push   %esi
 719:	53                   	push   %ebx
 71a:	83 ec 1c             	sub    $0x1c,%esp
 71d:	8b 45 08             	mov    0x8(%ebp),%eax
 720:	8b 3d 24 0b 00 00    	mov    0xb24,%edi
 726:	8d 70 07             	lea    0x7(%eax),%esi
 729:	c1 ee 03             	shr    $0x3,%esi
 72c:	83 c6 01             	add    $0x1,%esi
 72f:	85 ff                	test   %edi,%edi
 731:	0f 84 a9 00 00 00    	je     7e0 <malloc+0xd0>
 737:	8b 07                	mov    (%edi),%eax
 739:	8b 48 04             	mov    0x4(%eax),%ecx
 73c:	39 f1                	cmp    %esi,%ecx
 73e:	73 6d                	jae    7ad <malloc+0x9d>
 740:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 746:	bb 00 10 00 00       	mov    $0x1000,%ebx
 74b:	0f 43 de             	cmovae %esi,%ebx
 74e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 755:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 758:	eb 17                	jmp    771 <malloc+0x61>
 75a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 760:	8b 10                	mov    (%eax),%edx
 762:	8b 4a 04             	mov    0x4(%edx),%ecx
 765:	39 f1                	cmp    %esi,%ecx
 767:	73 4f                	jae    7b8 <malloc+0xa8>
 769:	8b 3d 24 0b 00 00    	mov    0xb24,%edi
 76f:	89 d0                	mov    %edx,%eax
 771:	39 c7                	cmp    %eax,%edi
 773:	75 eb                	jne    760 <malloc+0x50>
 775:	83 ec 0c             	sub    $0xc,%esp
 778:	ff 75 e4             	pushl  -0x1c(%ebp)
 77b:	e8 3b fc ff ff       	call   3bb <sbrk>
 780:	83 c4 10             	add    $0x10,%esp
 783:	83 f8 ff             	cmp    $0xffffffff,%eax
 786:	74 1b                	je     7a3 <malloc+0x93>
 788:	89 58 04             	mov    %ebx,0x4(%eax)
 78b:	83 ec 0c             	sub    $0xc,%esp
 78e:	83 c0 08             	add    $0x8,%eax
 791:	50                   	push   %eax
 792:	e8 e9 fe ff ff       	call   680 <free>
 797:	a1 24 0b 00 00       	mov    0xb24,%eax
 79c:	83 c4 10             	add    $0x10,%esp
 79f:	85 c0                	test   %eax,%eax
 7a1:	75 bd                	jne    760 <malloc+0x50>
 7a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7a6:	31 c0                	xor    %eax,%eax
 7a8:	5b                   	pop    %ebx
 7a9:	5e                   	pop    %esi
 7aa:	5f                   	pop    %edi
 7ab:	5d                   	pop    %ebp
 7ac:	c3                   	ret    
 7ad:	89 c2                	mov    %eax,%edx
 7af:	89 f8                	mov    %edi,%eax
 7b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7b8:	39 ce                	cmp    %ecx,%esi
 7ba:	74 54                	je     810 <malloc+0x100>
 7bc:	29 f1                	sub    %esi,%ecx
 7be:	89 4a 04             	mov    %ecx,0x4(%edx)
 7c1:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 7c4:	89 72 04             	mov    %esi,0x4(%edx)
 7c7:	a3 24 0b 00 00       	mov    %eax,0xb24
 7cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7cf:	8d 42 08             	lea    0x8(%edx),%eax
 7d2:	5b                   	pop    %ebx
 7d3:	5e                   	pop    %esi
 7d4:	5f                   	pop    %edi
 7d5:	5d                   	pop    %ebp
 7d6:	c3                   	ret    
 7d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7de:	66 90                	xchg   %ax,%ax
 7e0:	c7 05 24 0b 00 00 28 	movl   $0xb28,0xb24
 7e7:	0b 00 00 
 7ea:	bf 28 0b 00 00       	mov    $0xb28,%edi
 7ef:	c7 05 28 0b 00 00 28 	movl   $0xb28,0xb28
 7f6:	0b 00 00 
 7f9:	89 f8                	mov    %edi,%eax
 7fb:	c7 05 2c 0b 00 00 00 	movl   $0x0,0xb2c
 802:	00 00 00 
 805:	e9 36 ff ff ff       	jmp    740 <malloc+0x30>
 80a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 810:	8b 0a                	mov    (%edx),%ecx
 812:	89 08                	mov    %ecx,(%eax)
 814:	eb b1                	jmp    7c7 <malloc+0xb7>
