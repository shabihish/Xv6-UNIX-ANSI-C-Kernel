
_tracer_A:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	e8 e3 02 00 00       	call   2fb <fork>
  18:	85 c0                	test   %eax,%eax
  1a:	78 62                	js     7e <main+0x7e>
  1c:	74 10                	je     2e <main+0x2e>
  1e:	66 90                	xchg   %ax,%ax
  20:	e8 e6 02 00 00       	call   30b <wait>
  25:	85 c0                	test   %eax,%eax
  27:	79 f7                	jns    20 <main+0x20>
  29:	e8 d5 02 00 00       	call   303 <exit>
  2e:	83 ec 0c             	sub    $0xc,%esp
  31:	6a 14                	push   $0x14
  33:	e8 5b 03 00 00       	call   393 <sleep>
  38:	e8 76 03 00 00       	call   3b3 <get_parent_pid>
  3d:	89 c3                	mov    %eax,%ebx
  3f:	e8 3f 03 00 00       	call   383 <getpid>
  44:	53                   	push   %ebx
  45:	50                   	push   %eax
  46:	68 fc 07 00 00       	push   $0x7fc
  4b:	6a 01                	push   $0x1
  4d:	e8 2e 04 00 00       	call   480 <printf>
  52:	83 c4 14             	add    $0x14,%esp
  55:	68 e8 03 00 00       	push   $0x3e8
  5a:	e8 34 03 00 00       	call   393 <sleep>
  5f:	e8 4f 03 00 00       	call   3b3 <get_parent_pid>
  64:	89 c3                	mov    %eax,%ebx
  66:	e8 18 03 00 00       	call   383 <getpid>
  6b:	53                   	push   %ebx
  6c:	50                   	push   %eax
  6d:	68 fc 07 00 00       	push   $0x7fc
  72:	6a 01                	push   $0x1
  74:	e8 07 04 00 00       	call   480 <printf>
  79:	83 c4 20             	add    $0x20,%esp
  7c:	eb a2                	jmp    20 <main+0x20>
  7e:	50                   	push   %eax
  7f:	50                   	push   %eax
  80:	68 e8 07 00 00       	push   $0x7e8
  85:	6a 01                	push   $0x1
  87:	e8 f4 03 00 00       	call   480 <printf>
  8c:	e8 72 02 00 00       	call   303 <exit>
  91:	66 90                	xchg   %ax,%ax
  93:	66 90                	xchg   %ax,%ax
  95:	66 90                	xchg   %ax,%ax
  97:	66 90                	xchg   %ax,%ax
  99:	66 90                	xchg   %ax,%ax
  9b:	66 90                	xchg   %ax,%ax
  9d:	66 90                	xchg   %ax,%ax
  9f:	90                   	nop

000000a0 <strcpy>:
  a0:	f3 0f 1e fb          	endbr32 
  a4:	55                   	push   %ebp
  a5:	31 c0                	xor    %eax,%eax
  a7:	89 e5                	mov    %esp,%ebp
  a9:	53                   	push   %ebx
  aa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ad:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  b0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  b4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  b7:	83 c0 01             	add    $0x1,%eax
  ba:	84 d2                	test   %dl,%dl
  bc:	75 f2                	jne    b0 <strcpy+0x10>
  be:	89 c8                	mov    %ecx,%eax
  c0:	5b                   	pop    %ebx
  c1:	5d                   	pop    %ebp
  c2:	c3                   	ret    
  c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000d0 <strcmp>:
  d0:	f3 0f 1e fb          	endbr32 
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	53                   	push   %ebx
  d8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  db:	8b 55 0c             	mov    0xc(%ebp),%edx
  de:	0f b6 01             	movzbl (%ecx),%eax
  e1:	0f b6 1a             	movzbl (%edx),%ebx
  e4:	84 c0                	test   %al,%al
  e6:	75 19                	jne    101 <strcmp+0x31>
  e8:	eb 26                	jmp    110 <strcmp+0x40>
  ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  f0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
  f4:	83 c1 01             	add    $0x1,%ecx
  f7:	83 c2 01             	add    $0x1,%edx
  fa:	0f b6 1a             	movzbl (%edx),%ebx
  fd:	84 c0                	test   %al,%al
  ff:	74 0f                	je     110 <strcmp+0x40>
 101:	38 d8                	cmp    %bl,%al
 103:	74 eb                	je     f0 <strcmp+0x20>
 105:	29 d8                	sub    %ebx,%eax
 107:	5b                   	pop    %ebx
 108:	5d                   	pop    %ebp
 109:	c3                   	ret    
 10a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 110:	31 c0                	xor    %eax,%eax
 112:	29 d8                	sub    %ebx,%eax
 114:	5b                   	pop    %ebx
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11e:	66 90                	xchg   %ax,%ax

00000120 <strlen>:
 120:	f3 0f 1e fb          	endbr32 
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	8b 55 08             	mov    0x8(%ebp),%edx
 12a:	80 3a 00             	cmpb   $0x0,(%edx)
 12d:	74 21                	je     150 <strlen+0x30>
 12f:	31 c0                	xor    %eax,%eax
 131:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 138:	83 c0 01             	add    $0x1,%eax
 13b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 13f:	89 c1                	mov    %eax,%ecx
 141:	75 f5                	jne    138 <strlen+0x18>
 143:	89 c8                	mov    %ecx,%eax
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    
 147:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 14e:	66 90                	xchg   %ax,%ax
 150:	31 c9                	xor    %ecx,%ecx
 152:	5d                   	pop    %ebp
 153:	89 c8                	mov    %ecx,%eax
 155:	c3                   	ret    
 156:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 15d:	8d 76 00             	lea    0x0(%esi),%esi

00000160 <memset>:
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	57                   	push   %edi
 168:	8b 55 08             	mov    0x8(%ebp),%edx
 16b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 16e:	8b 45 0c             	mov    0xc(%ebp),%eax
 171:	89 d7                	mov    %edx,%edi
 173:	fc                   	cld    
 174:	f3 aa                	rep stos %al,%es:(%edi)
 176:	89 d0                	mov    %edx,%eax
 178:	5f                   	pop    %edi
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    
 17b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 17f:	90                   	nop

00000180 <strchr>:
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	8b 45 08             	mov    0x8(%ebp),%eax
 18a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 18e:	0f b6 10             	movzbl (%eax),%edx
 191:	84 d2                	test   %dl,%dl
 193:	75 16                	jne    1ab <strchr+0x2b>
 195:	eb 21                	jmp    1b8 <strchr+0x38>
 197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 19e:	66 90                	xchg   %ax,%ax
 1a0:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 1a4:	83 c0 01             	add    $0x1,%eax
 1a7:	84 d2                	test   %dl,%dl
 1a9:	74 0d                	je     1b8 <strchr+0x38>
 1ab:	38 d1                	cmp    %dl,%cl
 1ad:	75 f1                	jne    1a0 <strchr+0x20>
 1af:	5d                   	pop    %ebp
 1b0:	c3                   	ret    
 1b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b8:	31 c0                	xor    %eax,%eax
 1ba:	5d                   	pop    %ebp
 1bb:	c3                   	ret    
 1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001c0 <gets>:
 1c0:	f3 0f 1e fb          	endbr32 
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
 1c7:	57                   	push   %edi
 1c8:	56                   	push   %esi
 1c9:	31 f6                	xor    %esi,%esi
 1cb:	53                   	push   %ebx
 1cc:	89 f3                	mov    %esi,%ebx
 1ce:	83 ec 1c             	sub    $0x1c,%esp
 1d1:	8b 7d 08             	mov    0x8(%ebp),%edi
 1d4:	eb 33                	jmp    209 <gets+0x49>
 1d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
 1e0:	83 ec 04             	sub    $0x4,%esp
 1e3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1e6:	6a 01                	push   $0x1
 1e8:	50                   	push   %eax
 1e9:	6a 00                	push   $0x0
 1eb:	e8 2b 01 00 00       	call   31b <read>
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	85 c0                	test   %eax,%eax
 1f5:	7e 1c                	jle    213 <gets+0x53>
 1f7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1fb:	83 c7 01             	add    $0x1,%edi
 1fe:	88 47 ff             	mov    %al,-0x1(%edi)
 201:	3c 0a                	cmp    $0xa,%al
 203:	74 23                	je     228 <gets+0x68>
 205:	3c 0d                	cmp    $0xd,%al
 207:	74 1f                	je     228 <gets+0x68>
 209:	83 c3 01             	add    $0x1,%ebx
 20c:	89 fe                	mov    %edi,%esi
 20e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 211:	7c cd                	jl     1e0 <gets+0x20>
 213:	89 f3                	mov    %esi,%ebx
 215:	8b 45 08             	mov    0x8(%ebp),%eax
 218:	c6 03 00             	movb   $0x0,(%ebx)
 21b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 21e:	5b                   	pop    %ebx
 21f:	5e                   	pop    %esi
 220:	5f                   	pop    %edi
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 227:	90                   	nop
 228:	8b 75 08             	mov    0x8(%ebp),%esi
 22b:	8b 45 08             	mov    0x8(%ebp),%eax
 22e:	01 de                	add    %ebx,%esi
 230:	89 f3                	mov    %esi,%ebx
 232:	c6 03 00             	movb   $0x0,(%ebx)
 235:	8d 65 f4             	lea    -0xc(%ebp),%esp
 238:	5b                   	pop    %ebx
 239:	5e                   	pop    %esi
 23a:	5f                   	pop    %edi
 23b:	5d                   	pop    %ebp
 23c:	c3                   	ret    
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <stat>:
 240:	f3 0f 1e fb          	endbr32 
 244:	55                   	push   %ebp
 245:	89 e5                	mov    %esp,%ebp
 247:	56                   	push   %esi
 248:	53                   	push   %ebx
 249:	83 ec 08             	sub    $0x8,%esp
 24c:	6a 00                	push   $0x0
 24e:	ff 75 08             	pushl  0x8(%ebp)
 251:	e8 ed 00 00 00       	call   343 <open>
 256:	83 c4 10             	add    $0x10,%esp
 259:	85 c0                	test   %eax,%eax
 25b:	78 2b                	js     288 <stat+0x48>
 25d:	83 ec 08             	sub    $0x8,%esp
 260:	ff 75 0c             	pushl  0xc(%ebp)
 263:	89 c3                	mov    %eax,%ebx
 265:	50                   	push   %eax
 266:	e8 f0 00 00 00       	call   35b <fstat>
 26b:	89 1c 24             	mov    %ebx,(%esp)
 26e:	89 c6                	mov    %eax,%esi
 270:	e8 b6 00 00 00       	call   32b <close>
 275:	83 c4 10             	add    $0x10,%esp
 278:	8d 65 f8             	lea    -0x8(%ebp),%esp
 27b:	89 f0                	mov    %esi,%eax
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5d                   	pop    %ebp
 280:	c3                   	ret    
 281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 288:	be ff ff ff ff       	mov    $0xffffffff,%esi
 28d:	eb e9                	jmp    278 <stat+0x38>
 28f:	90                   	nop

00000290 <atoi>:
 290:	f3 0f 1e fb          	endbr32 
 294:	55                   	push   %ebp
 295:	89 e5                	mov    %esp,%ebp
 297:	53                   	push   %ebx
 298:	8b 55 08             	mov    0x8(%ebp),%edx
 29b:	0f be 02             	movsbl (%edx),%eax
 29e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2a1:	80 f9 09             	cmp    $0x9,%cl
 2a4:	b9 00 00 00 00       	mov    $0x0,%ecx
 2a9:	77 1a                	ja     2c5 <atoi+0x35>
 2ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2af:	90                   	nop
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2b6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 2ba:	0f be 02             	movsbl (%edx),%eax
 2bd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2c0:	80 fb 09             	cmp    $0x9,%bl
 2c3:	76 eb                	jbe    2b0 <atoi+0x20>
 2c5:	89 c8                	mov    %ecx,%eax
 2c7:	5b                   	pop    %ebx
 2c8:	5d                   	pop    %ebp
 2c9:	c3                   	ret    
 2ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002d0 <memmove>:
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	57                   	push   %edi
 2d8:	8b 45 10             	mov    0x10(%ebp),%eax
 2db:	8b 55 08             	mov    0x8(%ebp),%edx
 2de:	56                   	push   %esi
 2df:	8b 75 0c             	mov    0xc(%ebp),%esi
 2e2:	85 c0                	test   %eax,%eax
 2e4:	7e 0f                	jle    2f5 <memmove+0x25>
 2e6:	01 d0                	add    %edx,%eax
 2e8:	89 d7                	mov    %edx,%edi
 2ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2f0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 2f1:	39 f8                	cmp    %edi,%eax
 2f3:	75 fb                	jne    2f0 <memmove+0x20>
 2f5:	5e                   	pop    %esi
 2f6:	89 d0                	mov    %edx,%eax
 2f8:	5f                   	pop    %edi
 2f9:	5d                   	pop    %ebp
 2fa:	c3                   	ret    

000002fb <fork>:
 2fb:	b8 01 00 00 00       	mov    $0x1,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <exit>:
 303:	b8 02 00 00 00       	mov    $0x2,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <wait>:
 30b:	b8 03 00 00 00       	mov    $0x3,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <pipe>:
 313:	b8 04 00 00 00       	mov    $0x4,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <read>:
 31b:	b8 05 00 00 00       	mov    $0x5,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <write>:
 323:	b8 10 00 00 00       	mov    $0x10,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <close>:
 32b:	b8 15 00 00 00       	mov    $0x15,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <kill>:
 333:	b8 06 00 00 00       	mov    $0x6,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <exec>:
 33b:	b8 07 00 00 00       	mov    $0x7,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <open>:
 343:	b8 0f 00 00 00       	mov    $0xf,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <mknod>:
 34b:	b8 11 00 00 00       	mov    $0x11,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <unlink>:
 353:	b8 12 00 00 00       	mov    $0x12,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <fstat>:
 35b:	b8 08 00 00 00       	mov    $0x8,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <link>:
 363:	b8 13 00 00 00       	mov    $0x13,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <mkdir>:
 36b:	b8 14 00 00 00       	mov    $0x14,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <chdir>:
 373:	b8 09 00 00 00       	mov    $0x9,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <dup>:
 37b:	b8 0a 00 00 00       	mov    $0xa,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <getpid>:
 383:	b8 0b 00 00 00       	mov    $0xb,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <sbrk>:
 38b:	b8 0c 00 00 00       	mov    $0xc,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <sleep>:
 393:	b8 0d 00 00 00       	mov    $0xd,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <uptime>:
 39b:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <calculate_sum_of_digits>:
 3a3:	b8 16 00 00 00       	mov    $0x16,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <get_file_sectors>:
 3ab:	b8 17 00 00 00       	mov    $0x17,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <get_parent_pid>:
 3b3:	b8 18 00 00 00       	mov    $0x18,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait_sleeping>:
 3bb:	b8 19 00 00 00       	mov    $0x19,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <set_proc_tracer>:
 3c3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    
 3cb:	66 90                	xchg   %ax,%ax
 3cd:	66 90                	xchg   %ax,%ax
 3cf:	90                   	nop

000003d0 <printint>:
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	83 ec 3c             	sub    $0x3c,%esp
 3d9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 3dc:	89 d1                	mov    %edx,%ecx
 3de:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3e1:	85 d2                	test   %edx,%edx
 3e3:	0f 89 7f 00 00 00    	jns    468 <printint+0x98>
 3e9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3ed:	74 79                	je     468 <printint+0x98>
 3ef:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 3f6:	f7 d9                	neg    %ecx
 3f8:	31 db                	xor    %ebx,%ebx
 3fa:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3fd:	8d 76 00             	lea    0x0(%esi),%esi
 400:	89 c8                	mov    %ecx,%eax
 402:	31 d2                	xor    %edx,%edx
 404:	89 cf                	mov    %ecx,%edi
 406:	f7 75 c4             	divl   -0x3c(%ebp)
 409:	0f b6 92 24 08 00 00 	movzbl 0x824(%edx),%edx
 410:	89 45 c0             	mov    %eax,-0x40(%ebp)
 413:	89 d8                	mov    %ebx,%eax
 415:	8d 5b 01             	lea    0x1(%ebx),%ebx
 418:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 41b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 41e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 421:	76 dd                	jbe    400 <printint+0x30>
 423:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 426:	85 c9                	test   %ecx,%ecx
 428:	74 0c                	je     436 <printint+0x66>
 42a:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 42f:	89 d8                	mov    %ebx,%eax
 431:	ba 2d 00 00 00       	mov    $0x2d,%edx
 436:	8b 7d b8             	mov    -0x48(%ebp),%edi
 439:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 43d:	eb 07                	jmp    446 <printint+0x76>
 43f:	90                   	nop
 440:	0f b6 13             	movzbl (%ebx),%edx
 443:	83 eb 01             	sub    $0x1,%ebx
 446:	83 ec 04             	sub    $0x4,%esp
 449:	88 55 d7             	mov    %dl,-0x29(%ebp)
 44c:	6a 01                	push   $0x1
 44e:	56                   	push   %esi
 44f:	57                   	push   %edi
 450:	e8 ce fe ff ff       	call   323 <write>
 455:	83 c4 10             	add    $0x10,%esp
 458:	39 de                	cmp    %ebx,%esi
 45a:	75 e4                	jne    440 <printint+0x70>
 45c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 45f:	5b                   	pop    %ebx
 460:	5e                   	pop    %esi
 461:	5f                   	pop    %edi
 462:	5d                   	pop    %ebp
 463:	c3                   	ret    
 464:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 468:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 46f:	eb 87                	jmp    3f8 <printint+0x28>
 471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop

00000480 <printf>:
 480:	f3 0f 1e fb          	endbr32 
 484:	55                   	push   %ebp
 485:	89 e5                	mov    %esp,%ebp
 487:	57                   	push   %edi
 488:	56                   	push   %esi
 489:	53                   	push   %ebx
 48a:	83 ec 2c             	sub    $0x2c,%esp
 48d:	8b 75 0c             	mov    0xc(%ebp),%esi
 490:	0f b6 1e             	movzbl (%esi),%ebx
 493:	84 db                	test   %bl,%bl
 495:	0f 84 b4 00 00 00    	je     54f <printf+0xcf>
 49b:	8d 45 10             	lea    0x10(%ebp),%eax
 49e:	83 c6 01             	add    $0x1,%esi
 4a1:	8d 7d e7             	lea    -0x19(%ebp),%edi
 4a4:	31 d2                	xor    %edx,%edx
 4a6:	89 45 d0             	mov    %eax,-0x30(%ebp)
 4a9:	eb 33                	jmp    4de <printf+0x5e>
 4ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 4af:	90                   	nop
 4b0:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 4b3:	ba 25 00 00 00       	mov    $0x25,%edx
 4b8:	83 f8 25             	cmp    $0x25,%eax
 4bb:	74 17                	je     4d4 <printf+0x54>
 4bd:	83 ec 04             	sub    $0x4,%esp
 4c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4c3:	6a 01                	push   $0x1
 4c5:	57                   	push   %edi
 4c6:	ff 75 08             	pushl  0x8(%ebp)
 4c9:	e8 55 fe ff ff       	call   323 <write>
 4ce:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4d1:	83 c4 10             	add    $0x10,%esp
 4d4:	0f b6 1e             	movzbl (%esi),%ebx
 4d7:	83 c6 01             	add    $0x1,%esi
 4da:	84 db                	test   %bl,%bl
 4dc:	74 71                	je     54f <printf+0xcf>
 4de:	0f be cb             	movsbl %bl,%ecx
 4e1:	0f b6 c3             	movzbl %bl,%eax
 4e4:	85 d2                	test   %edx,%edx
 4e6:	74 c8                	je     4b0 <printf+0x30>
 4e8:	83 fa 25             	cmp    $0x25,%edx
 4eb:	75 e7                	jne    4d4 <printf+0x54>
 4ed:	83 f8 64             	cmp    $0x64,%eax
 4f0:	0f 84 9a 00 00 00    	je     590 <printf+0x110>
 4f6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4fc:	83 f9 70             	cmp    $0x70,%ecx
 4ff:	74 5f                	je     560 <printf+0xe0>
 501:	83 f8 73             	cmp    $0x73,%eax
 504:	0f 84 d6 00 00 00    	je     5e0 <printf+0x160>
 50a:	83 f8 63             	cmp    $0x63,%eax
 50d:	0f 84 8d 00 00 00    	je     5a0 <printf+0x120>
 513:	83 f8 25             	cmp    $0x25,%eax
 516:	0f 84 b4 00 00 00    	je     5d0 <printf+0x150>
 51c:	83 ec 04             	sub    $0x4,%esp
 51f:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 523:	6a 01                	push   $0x1
 525:	57                   	push   %edi
 526:	ff 75 08             	pushl  0x8(%ebp)
 529:	e8 f5 fd ff ff       	call   323 <write>
 52e:	88 5d e7             	mov    %bl,-0x19(%ebp)
 531:	83 c4 0c             	add    $0xc,%esp
 534:	6a 01                	push   $0x1
 536:	83 c6 01             	add    $0x1,%esi
 539:	57                   	push   %edi
 53a:	ff 75 08             	pushl  0x8(%ebp)
 53d:	e8 e1 fd ff ff       	call   323 <write>
 542:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 546:	83 c4 10             	add    $0x10,%esp
 549:	31 d2                	xor    %edx,%edx
 54b:	84 db                	test   %bl,%bl
 54d:	75 8f                	jne    4de <printf+0x5e>
 54f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 552:	5b                   	pop    %ebx
 553:	5e                   	pop    %esi
 554:	5f                   	pop    %edi
 555:	5d                   	pop    %ebp
 556:	c3                   	ret    
 557:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55e:	66 90                	xchg   %ax,%ax
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 10 00 00 00       	mov    $0x10,%ecx
 568:	6a 00                	push   $0x0
 56a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	8b 13                	mov    (%ebx),%edx
 572:	e8 59 fe ff ff       	call   3d0 <printint>
 577:	89 d8                	mov    %ebx,%eax
 579:	83 c4 10             	add    $0x10,%esp
 57c:	31 d2                	xor    %edx,%edx
 57e:	83 c0 04             	add    $0x4,%eax
 581:	89 45 d0             	mov    %eax,-0x30(%ebp)
 584:	e9 4b ff ff ff       	jmp    4d4 <printf+0x54>
 589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
 598:	6a 01                	push   $0x1
 59a:	eb ce                	jmp    56a <printf+0xea>
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5a0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	8b 03                	mov    (%ebx),%eax
 5a8:	6a 01                	push   $0x1
 5aa:	83 c3 04             	add    $0x4,%ebx
 5ad:	57                   	push   %edi
 5ae:	ff 75 08             	pushl  0x8(%ebp)
 5b1:	88 45 e7             	mov    %al,-0x19(%ebp)
 5b4:	e8 6a fd ff ff       	call   323 <write>
 5b9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5bc:	83 c4 10             	add    $0x10,%esp
 5bf:	31 d2                	xor    %edx,%edx
 5c1:	e9 0e ff ff ff       	jmp    4d4 <printf+0x54>
 5c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5cd:	8d 76 00             	lea    0x0(%esi),%esi
 5d0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5d3:	83 ec 04             	sub    $0x4,%esp
 5d6:	e9 59 ff ff ff       	jmp    534 <printf+0xb4>
 5db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5df:	90                   	nop
 5e0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5e3:	8b 18                	mov    (%eax),%ebx
 5e5:	83 c0 04             	add    $0x4,%eax
 5e8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5eb:	85 db                	test   %ebx,%ebx
 5ed:	74 17                	je     606 <printf+0x186>
 5ef:	0f b6 03             	movzbl (%ebx),%eax
 5f2:	31 d2                	xor    %edx,%edx
 5f4:	84 c0                	test   %al,%al
 5f6:	0f 84 d8 fe ff ff    	je     4d4 <printf+0x54>
 5fc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5ff:	89 de                	mov    %ebx,%esi
 601:	8b 5d 08             	mov    0x8(%ebp),%ebx
 604:	eb 1a                	jmp    620 <printf+0x1a0>
 606:	bb 1b 08 00 00       	mov    $0x81b,%ebx
 60b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 60e:	b8 28 00 00 00       	mov    $0x28,%eax
 613:	89 de                	mov    %ebx,%esi
 615:	8b 5d 08             	mov    0x8(%ebp),%ebx
 618:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 61f:	90                   	nop
 620:	83 ec 04             	sub    $0x4,%esp
 623:	83 c6 01             	add    $0x1,%esi
 626:	88 45 e7             	mov    %al,-0x19(%ebp)
 629:	6a 01                	push   $0x1
 62b:	57                   	push   %edi
 62c:	53                   	push   %ebx
 62d:	e8 f1 fc ff ff       	call   323 <write>
 632:	0f b6 06             	movzbl (%esi),%eax
 635:	83 c4 10             	add    $0x10,%esp
 638:	84 c0                	test   %al,%al
 63a:	75 e4                	jne    620 <printf+0x1a0>
 63c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 63f:	31 d2                	xor    %edx,%edx
 641:	e9 8e fe ff ff       	jmp    4d4 <printf+0x54>
 646:	66 90                	xchg   %ax,%ax
 648:	66 90                	xchg   %ax,%ax
 64a:	66 90                	xchg   %ax,%ax
 64c:	66 90                	xchg   %ax,%ax
 64e:	66 90                	xchg   %ax,%ax

00000650 <free>:
 650:	f3 0f 1e fb          	endbr32 
 654:	55                   	push   %ebp
 655:	a1 d0 0a 00 00       	mov    0xad0,%eax
 65a:	89 e5                	mov    %esp,%ebp
 65c:	57                   	push   %edi
 65d:	56                   	push   %esi
 65e:	53                   	push   %ebx
 65f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 662:	8b 10                	mov    (%eax),%edx
 664:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 667:	39 c8                	cmp    %ecx,%eax
 669:	73 15                	jae    680 <free+0x30>
 66b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 66f:	90                   	nop
 670:	39 d1                	cmp    %edx,%ecx
 672:	72 14                	jb     688 <free+0x38>
 674:	39 d0                	cmp    %edx,%eax
 676:	73 10                	jae    688 <free+0x38>
 678:	89 d0                	mov    %edx,%eax
 67a:	8b 10                	mov    (%eax),%edx
 67c:	39 c8                	cmp    %ecx,%eax
 67e:	72 f0                	jb     670 <free+0x20>
 680:	39 d0                	cmp    %edx,%eax
 682:	72 f4                	jb     678 <free+0x28>
 684:	39 d1                	cmp    %edx,%ecx
 686:	73 f0                	jae    678 <free+0x28>
 688:	8b 73 fc             	mov    -0x4(%ebx),%esi
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 fa                	cmp    %edi,%edx
 690:	74 1e                	je     6b0 <free+0x60>
 692:	89 53 f8             	mov    %edx,-0x8(%ebx)
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69b:	39 f1                	cmp    %esi,%ecx
 69d:	74 28                	je     6c7 <free+0x77>
 69f:	89 08                	mov    %ecx,(%eax)
 6a1:	5b                   	pop    %ebx
 6a2:	a3 d0 0a 00 00       	mov    %eax,0xad0
 6a7:	5e                   	pop    %esi
 6a8:	5f                   	pop    %edi
 6a9:	5d                   	pop    %ebp
 6aa:	c3                   	ret    
 6ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 6af:	90                   	nop
 6b0:	03 72 04             	add    0x4(%edx),%esi
 6b3:	89 73 fc             	mov    %esi,-0x4(%ebx)
 6b6:	8b 10                	mov    (%eax),%edx
 6b8:	8b 12                	mov    (%edx),%edx
 6ba:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6bd:	8b 50 04             	mov    0x4(%eax),%edx
 6c0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6c3:	39 f1                	cmp    %esi,%ecx
 6c5:	75 d8                	jne    69f <free+0x4f>
 6c7:	03 53 fc             	add    -0x4(%ebx),%edx
 6ca:	a3 d0 0a 00 00       	mov    %eax,0xad0
 6cf:	89 50 04             	mov    %edx,0x4(%eax)
 6d2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6d5:	89 10                	mov    %edx,(%eax)
 6d7:	5b                   	pop    %ebx
 6d8:	5e                   	pop    %esi
 6d9:	5f                   	pop    %edi
 6da:	5d                   	pop    %ebp
 6db:	c3                   	ret    
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006e0 <malloc>:
 6e0:	f3 0f 1e fb          	endbr32 
 6e4:	55                   	push   %ebp
 6e5:	89 e5                	mov    %esp,%ebp
 6e7:	57                   	push   %edi
 6e8:	56                   	push   %esi
 6e9:	53                   	push   %ebx
 6ea:	83 ec 1c             	sub    $0x1c,%esp
 6ed:	8b 45 08             	mov    0x8(%ebp),%eax
 6f0:	8b 3d d0 0a 00 00    	mov    0xad0,%edi
 6f6:	8d 70 07             	lea    0x7(%eax),%esi
 6f9:	c1 ee 03             	shr    $0x3,%esi
 6fc:	83 c6 01             	add    $0x1,%esi
 6ff:	85 ff                	test   %edi,%edi
 701:	0f 84 a9 00 00 00    	je     7b0 <malloc+0xd0>
 707:	8b 07                	mov    (%edi),%eax
 709:	8b 48 04             	mov    0x4(%eax),%ecx
 70c:	39 f1                	cmp    %esi,%ecx
 70e:	73 6d                	jae    77d <malloc+0x9d>
 710:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 716:	bb 00 10 00 00       	mov    $0x1000,%ebx
 71b:	0f 43 de             	cmovae %esi,%ebx
 71e:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 725:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 728:	eb 17                	jmp    741 <malloc+0x61>
 72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 730:	8b 10                	mov    (%eax),%edx
 732:	8b 4a 04             	mov    0x4(%edx),%ecx
 735:	39 f1                	cmp    %esi,%ecx
 737:	73 4f                	jae    788 <malloc+0xa8>
 739:	8b 3d d0 0a 00 00    	mov    0xad0,%edi
 73f:	89 d0                	mov    %edx,%eax
 741:	39 c7                	cmp    %eax,%edi
 743:	75 eb                	jne    730 <malloc+0x50>
 745:	83 ec 0c             	sub    $0xc,%esp
 748:	ff 75 e4             	pushl  -0x1c(%ebp)
 74b:	e8 3b fc ff ff       	call   38b <sbrk>
 750:	83 c4 10             	add    $0x10,%esp
 753:	83 f8 ff             	cmp    $0xffffffff,%eax
 756:	74 1b                	je     773 <malloc+0x93>
 758:	89 58 04             	mov    %ebx,0x4(%eax)
 75b:	83 ec 0c             	sub    $0xc,%esp
 75e:	83 c0 08             	add    $0x8,%eax
 761:	50                   	push   %eax
 762:	e8 e9 fe ff ff       	call   650 <free>
 767:	a1 d0 0a 00 00       	mov    0xad0,%eax
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	85 c0                	test   %eax,%eax
 771:	75 bd                	jne    730 <malloc+0x50>
 773:	8d 65 f4             	lea    -0xc(%ebp),%esp
 776:	31 c0                	xor    %eax,%eax
 778:	5b                   	pop    %ebx
 779:	5e                   	pop    %esi
 77a:	5f                   	pop    %edi
 77b:	5d                   	pop    %ebp
 77c:	c3                   	ret    
 77d:	89 c2                	mov    %eax,%edx
 77f:	89 f8                	mov    %edi,%eax
 781:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 788:	39 ce                	cmp    %ecx,%esi
 78a:	74 54                	je     7e0 <malloc+0x100>
 78c:	29 f1                	sub    %esi,%ecx
 78e:	89 4a 04             	mov    %ecx,0x4(%edx)
 791:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 794:	89 72 04             	mov    %esi,0x4(%edx)
 797:	a3 d0 0a 00 00       	mov    %eax,0xad0
 79c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 79f:	8d 42 08             	lea    0x8(%edx),%eax
 7a2:	5b                   	pop    %ebx
 7a3:	5e                   	pop    %esi
 7a4:	5f                   	pop    %edi
 7a5:	5d                   	pop    %ebp
 7a6:	c3                   	ret    
 7a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 7ae:	66 90                	xchg   %ax,%ax
 7b0:	c7 05 d0 0a 00 00 d4 	movl   $0xad4,0xad0
 7b7:	0a 00 00 
 7ba:	bf d4 0a 00 00       	mov    $0xad4,%edi
 7bf:	c7 05 d4 0a 00 00 d4 	movl   $0xad4,0xad4
 7c6:	0a 00 00 
 7c9:	89 f8                	mov    %edi,%eax
 7cb:	c7 05 d8 0a 00 00 00 	movl   $0x0,0xad8
 7d2:	00 00 00 
 7d5:	e9 36 ff ff ff       	jmp    710 <malloc+0x30>
 7da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7e0:	8b 0a                	mov    (%edx),%ecx
 7e2:	89 08                	mov    %ecx,(%eax)
 7e4:	eb b1                	jmp    797 <malloc+0xb7>
