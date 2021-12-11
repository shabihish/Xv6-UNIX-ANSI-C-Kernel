
_kill:     file format elf32-i386


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
  17:	8b 01                	mov    (%ecx),%eax
  19:	8b 51 04             	mov    0x4(%ecx),%edx
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 30                	jle    51 <main+0x51>
  21:	8d 5a 04             	lea    0x4(%edx),%ebx
  24:	8d 34 82             	lea    (%edx,%eax,4),%esi
  27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  2e:	66 90                	xchg   %ax,%ax
  30:	83 ec 0c             	sub    $0xc,%esp
  33:	ff 33                	pushl  (%ebx)
  35:	83 c3 04             	add    $0x4,%ebx
  38:	e8 23 02 00 00       	call   260 <atoi>
  3d:	89 04 24             	mov    %eax,(%esp)
  40:	e8 be 02 00 00       	call   303 <kill>
  45:	83 c4 10             	add    $0x10,%esp
  48:	39 f3                	cmp    %esi,%ebx
  4a:	75 e4                	jne    30 <main+0x30>
  4c:	e8 82 02 00 00       	call   2d3 <exit>
  51:	50                   	push   %eax
  52:	50                   	push   %eax
  53:	68 b8 07 00 00       	push   $0x7b8
  58:	6a 02                	push   $0x2
  5a:	e8 f1 03 00 00       	call   450 <printf>
  5f:	e8 6f 02 00 00       	call   2d3 <exit>
  64:	66 90                	xchg   %ax,%ax
  66:	66 90                	xchg   %ax,%ax
  68:	66 90                	xchg   %ax,%ax
  6a:	66 90                	xchg   %ax,%ax
  6c:	66 90                	xchg   %ax,%ax
  6e:	66 90                	xchg   %ax,%ax

00000070 <strcpy>:
  70:	f3 0f 1e fb          	endbr32 
  74:	55                   	push   %ebp
  75:	31 c0                	xor    %eax,%eax
  77:	89 e5                	mov    %esp,%ebp
  79:	53                   	push   %ebx
  7a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  80:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  84:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  87:	83 c0 01             	add    $0x1,%eax
  8a:	84 d2                	test   %dl,%dl
  8c:	75 f2                	jne    80 <strcpy+0x10>
  8e:	89 c8                	mov    %ecx,%eax
  90:	5b                   	pop    %ebx
  91:	5d                   	pop    %ebp
  92:	c3                   	ret    
  93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000000a0 <strcmp>:
  a0:	f3 0f 1e fb          	endbr32 
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	53                   	push   %ebx
  a8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  ae:	0f b6 01             	movzbl (%ecx),%eax
  b1:	0f b6 1a             	movzbl (%edx),%ebx
  b4:	84 c0                	test   %al,%al
  b6:	75 19                	jne    d1 <strcmp+0x31>
  b8:	eb 26                	jmp    e0 <strcmp+0x40>
  ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  c0:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
  c4:	83 c1 01             	add    $0x1,%ecx
  c7:	83 c2 01             	add    $0x1,%edx
  ca:	0f b6 1a             	movzbl (%edx),%ebx
  cd:	84 c0                	test   %al,%al
  cf:	74 0f                	je     e0 <strcmp+0x40>
  d1:	38 d8                	cmp    %bl,%al
  d3:	74 eb                	je     c0 <strcmp+0x20>
  d5:	29 d8                	sub    %ebx,%eax
  d7:	5b                   	pop    %ebx
  d8:	5d                   	pop    %ebp
  d9:	c3                   	ret    
  da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  e0:	31 c0                	xor    %eax,%eax
  e2:	29 d8                	sub    %ebx,%eax
  e4:	5b                   	pop    %ebx
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ee:	66 90                	xchg   %ax,%ax

000000f0 <strlen>:
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	8b 55 08             	mov    0x8(%ebp),%edx
  fa:	80 3a 00             	cmpb   $0x0,(%edx)
  fd:	74 21                	je     120 <strlen+0x30>
  ff:	31 c0                	xor    %eax,%eax
 101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 108:	83 c0 01             	add    $0x1,%eax
 10b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 10f:	89 c1                	mov    %eax,%ecx
 111:	75 f5                	jne    108 <strlen+0x18>
 113:	89 c8                	mov    %ecx,%eax
 115:	5d                   	pop    %ebp
 116:	c3                   	ret    
 117:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 11e:	66 90                	xchg   %ax,%ax
 120:	31 c9                	xor    %ecx,%ecx
 122:	5d                   	pop    %ebp
 123:	89 c8                	mov    %ecx,%eax
 125:	c3                   	ret    
 126:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12d:	8d 76 00             	lea    0x0(%esi),%esi

00000130 <memset>:
 130:	f3 0f 1e fb          	endbr32 
 134:	55                   	push   %ebp
 135:	89 e5                	mov    %esp,%ebp
 137:	57                   	push   %edi
 138:	8b 55 08             	mov    0x8(%ebp),%edx
 13b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 13e:	8b 45 0c             	mov    0xc(%ebp),%eax
 141:	89 d7                	mov    %edx,%edi
 143:	fc                   	cld    
 144:	f3 aa                	rep stos %al,%es:(%edi)
 146:	89 d0                	mov    %edx,%eax
 148:	5f                   	pop    %edi
 149:	5d                   	pop    %ebp
 14a:	c3                   	ret    
 14b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 14f:	90                   	nop

00000150 <strchr>:
 150:	f3 0f 1e fb          	endbr32 
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 15e:	0f b6 10             	movzbl (%eax),%edx
 161:	84 d2                	test   %dl,%dl
 163:	75 16                	jne    17b <strchr+0x2b>
 165:	eb 21                	jmp    188 <strchr+0x38>
 167:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16e:	66 90                	xchg   %ax,%ax
 170:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 174:	83 c0 01             	add    $0x1,%eax
 177:	84 d2                	test   %dl,%dl
 179:	74 0d                	je     188 <strchr+0x38>
 17b:	38 d1                	cmp    %dl,%cl
 17d:	75 f1                	jne    170 <strchr+0x20>
 17f:	5d                   	pop    %ebp
 180:	c3                   	ret    
 181:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 188:	31 c0                	xor    %eax,%eax
 18a:	5d                   	pop    %ebp
 18b:	c3                   	ret    
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000190 <gets>:
 190:	f3 0f 1e fb          	endbr32 
 194:	55                   	push   %ebp
 195:	89 e5                	mov    %esp,%ebp
 197:	57                   	push   %edi
 198:	56                   	push   %esi
 199:	31 f6                	xor    %esi,%esi
 19b:	53                   	push   %ebx
 19c:	89 f3                	mov    %esi,%ebx
 19e:	83 ec 1c             	sub    $0x1c,%esp
 1a1:	8b 7d 08             	mov    0x8(%ebp),%edi
 1a4:	eb 33                	jmp    1d9 <gets+0x49>
 1a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1b6:	6a 01                	push   $0x1
 1b8:	50                   	push   %eax
 1b9:	6a 00                	push   $0x0
 1bb:	e8 2b 01 00 00       	call   2eb <read>
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	85 c0                	test   %eax,%eax
 1c5:	7e 1c                	jle    1e3 <gets+0x53>
 1c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1cb:	83 c7 01             	add    $0x1,%edi
 1ce:	88 47 ff             	mov    %al,-0x1(%edi)
 1d1:	3c 0a                	cmp    $0xa,%al
 1d3:	74 23                	je     1f8 <gets+0x68>
 1d5:	3c 0d                	cmp    $0xd,%al
 1d7:	74 1f                	je     1f8 <gets+0x68>
 1d9:	83 c3 01             	add    $0x1,%ebx
 1dc:	89 fe                	mov    %edi,%esi
 1de:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1e1:	7c cd                	jl     1b0 <gets+0x20>
 1e3:	89 f3                	mov    %esi,%ebx
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	c6 03 00             	movb   $0x0,(%ebx)
 1eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ee:	5b                   	pop    %ebx
 1ef:	5e                   	pop    %esi
 1f0:	5f                   	pop    %edi
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1f7:	90                   	nop
 1f8:	8b 75 08             	mov    0x8(%ebp),%esi
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 de                	add    %ebx,%esi
 200:	89 f3                	mov    %esi,%ebx
 202:	c6 03 00             	movb   $0x0,(%ebx)
 205:	8d 65 f4             	lea    -0xc(%ebp),%esp
 208:	5b                   	pop    %ebx
 209:	5e                   	pop    %esi
 20a:	5f                   	pop    %edi
 20b:	5d                   	pop    %ebp
 20c:	c3                   	ret    
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <stat>:
 210:	f3 0f 1e fb          	endbr32 
 214:	55                   	push   %ebp
 215:	89 e5                	mov    %esp,%ebp
 217:	56                   	push   %esi
 218:	53                   	push   %ebx
 219:	83 ec 08             	sub    $0x8,%esp
 21c:	6a 00                	push   $0x0
 21e:	ff 75 08             	pushl  0x8(%ebp)
 221:	e8 ed 00 00 00       	call   313 <open>
 226:	83 c4 10             	add    $0x10,%esp
 229:	85 c0                	test   %eax,%eax
 22b:	78 2b                	js     258 <stat+0x48>
 22d:	83 ec 08             	sub    $0x8,%esp
 230:	ff 75 0c             	pushl  0xc(%ebp)
 233:	89 c3                	mov    %eax,%ebx
 235:	50                   	push   %eax
 236:	e8 f0 00 00 00       	call   32b <fstat>
 23b:	89 1c 24             	mov    %ebx,(%esp)
 23e:	89 c6                	mov    %eax,%esi
 240:	e8 b6 00 00 00       	call   2fb <close>
 245:	83 c4 10             	add    $0x10,%esp
 248:	8d 65 f8             	lea    -0x8(%ebp),%esp
 24b:	89 f0                	mov    %esi,%eax
 24d:	5b                   	pop    %ebx
 24e:	5e                   	pop    %esi
 24f:	5d                   	pop    %ebp
 250:	c3                   	ret    
 251:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 258:	be ff ff ff ff       	mov    $0xffffffff,%esi
 25d:	eb e9                	jmp    248 <stat+0x38>
 25f:	90                   	nop

00000260 <atoi>:
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	53                   	push   %ebx
 268:	8b 55 08             	mov    0x8(%ebp),%edx
 26b:	0f be 02             	movsbl (%edx),%eax
 26e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 271:	80 f9 09             	cmp    $0x9,%cl
 274:	b9 00 00 00 00       	mov    $0x0,%ecx
 279:	77 1a                	ja     295 <atoi+0x35>
 27b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 27f:	90                   	nop
 280:	83 c2 01             	add    $0x1,%edx
 283:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 286:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 28a:	0f be 02             	movsbl (%edx),%eax
 28d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 290:	80 fb 09             	cmp    $0x9,%bl
 293:	76 eb                	jbe    280 <atoi+0x20>
 295:	89 c8                	mov    %ecx,%eax
 297:	5b                   	pop    %ebx
 298:	5d                   	pop    %ebp
 299:	c3                   	ret    
 29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <memmove>:
 2a0:	f3 0f 1e fb          	endbr32 
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	57                   	push   %edi
 2a8:	8b 45 10             	mov    0x10(%ebp),%eax
 2ab:	8b 55 08             	mov    0x8(%ebp),%edx
 2ae:	56                   	push   %esi
 2af:	8b 75 0c             	mov    0xc(%ebp),%esi
 2b2:	85 c0                	test   %eax,%eax
 2b4:	7e 0f                	jle    2c5 <memmove+0x25>
 2b6:	01 d0                	add    %edx,%eax
 2b8:	89 d7                	mov    %edx,%edi
 2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 2c0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 2c1:	39 f8                	cmp    %edi,%eax
 2c3:	75 fb                	jne    2c0 <memmove+0x20>
 2c5:	5e                   	pop    %esi
 2c6:	89 d0                	mov    %edx,%eax
 2c8:	5f                   	pop    %edi
 2c9:	5d                   	pop    %ebp
 2ca:	c3                   	ret    

000002cb <fork>:
 2cb:	b8 01 00 00 00       	mov    $0x1,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <exit>:
 2d3:	b8 02 00 00 00       	mov    $0x2,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <wait>:
 2db:	b8 03 00 00 00       	mov    $0x3,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <pipe>:
 2e3:	b8 04 00 00 00       	mov    $0x4,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <read>:
 2eb:	b8 05 00 00 00       	mov    $0x5,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <write>:
 2f3:	b8 10 00 00 00       	mov    $0x10,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <close>:
 2fb:	b8 15 00 00 00       	mov    $0x15,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <kill>:
 303:	b8 06 00 00 00       	mov    $0x6,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <exec>:
 30b:	b8 07 00 00 00       	mov    $0x7,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <open>:
 313:	b8 0f 00 00 00       	mov    $0xf,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <mknod>:
 31b:	b8 11 00 00 00       	mov    $0x11,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <unlink>:
 323:	b8 12 00 00 00       	mov    $0x12,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <fstat>:
 32b:	b8 08 00 00 00       	mov    $0x8,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <link>:
 333:	b8 13 00 00 00       	mov    $0x13,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <mkdir>:
 33b:	b8 14 00 00 00       	mov    $0x14,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <chdir>:
 343:	b8 09 00 00 00       	mov    $0x9,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <dup>:
 34b:	b8 0a 00 00 00       	mov    $0xa,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <getpid>:
 353:	b8 0b 00 00 00       	mov    $0xb,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <sbrk>:
 35b:	b8 0c 00 00 00       	mov    $0xc,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <sleep>:
 363:	b8 0d 00 00 00       	mov    $0xd,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <uptime>:
 36b:	b8 0e 00 00 00       	mov    $0xe,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <calculate_sum_of_digits>:
 373:	b8 16 00 00 00       	mov    $0x16,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <get_file_sectors>:
 37b:	b8 17 00 00 00       	mov    $0x17,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <get_parent_pid>:
 383:	b8 18 00 00 00       	mov    $0x18,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <wait_sleeping>:
 38b:	b8 19 00 00 00       	mov    $0x19,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <set_proc_tracer>:
 393:	b8 1a 00 00 00       	mov    $0x1a,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    
 39b:	66 90                	xchg   %ax,%ax
 39d:	66 90                	xchg   %ax,%ax
 39f:	90                   	nop

000003a0 <printint>:
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	83 ec 3c             	sub    $0x3c,%esp
 3a9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 3ac:	89 d1                	mov    %edx,%ecx
 3ae:	89 45 b8             	mov    %eax,-0x48(%ebp)
 3b1:	85 d2                	test   %edx,%edx
 3b3:	0f 89 7f 00 00 00    	jns    438 <printint+0x98>
 3b9:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 3bd:	74 79                	je     438 <printint+0x98>
 3bf:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 3c6:	f7 d9                	neg    %ecx
 3c8:	31 db                	xor    %ebx,%ebx
 3ca:	8d 75 d7             	lea    -0x29(%ebp),%esi
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
 3d0:	89 c8                	mov    %ecx,%eax
 3d2:	31 d2                	xor    %edx,%edx
 3d4:	89 cf                	mov    %ecx,%edi
 3d6:	f7 75 c4             	divl   -0x3c(%ebp)
 3d9:	0f b6 92 d4 07 00 00 	movzbl 0x7d4(%edx),%edx
 3e0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3e3:	89 d8                	mov    %ebx,%eax
 3e5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 3e8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3eb:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 3ee:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3f1:	76 dd                	jbe    3d0 <printint+0x30>
 3f3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3f6:	85 c9                	test   %ecx,%ecx
 3f8:	74 0c                	je     406 <printint+0x66>
 3fa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3ff:	89 d8                	mov    %ebx,%eax
 401:	ba 2d 00 00 00       	mov    $0x2d,%edx
 406:	8b 7d b8             	mov    -0x48(%ebp),%edi
 409:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 40d:	eb 07                	jmp    416 <printint+0x76>
 40f:	90                   	nop
 410:	0f b6 13             	movzbl (%ebx),%edx
 413:	83 eb 01             	sub    $0x1,%ebx
 416:	83 ec 04             	sub    $0x4,%esp
 419:	88 55 d7             	mov    %dl,-0x29(%ebp)
 41c:	6a 01                	push   $0x1
 41e:	56                   	push   %esi
 41f:	57                   	push   %edi
 420:	e8 ce fe ff ff       	call   2f3 <write>
 425:	83 c4 10             	add    $0x10,%esp
 428:	39 de                	cmp    %ebx,%esi
 42a:	75 e4                	jne    410 <printint+0x70>
 42c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 42f:	5b                   	pop    %ebx
 430:	5e                   	pop    %esi
 431:	5f                   	pop    %edi
 432:	5d                   	pop    %ebp
 433:	c3                   	ret    
 434:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 438:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 43f:	eb 87                	jmp    3c8 <printint+0x28>
 441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 448:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 44f:	90                   	nop

00000450 <printf>:
 450:	f3 0f 1e fb          	endbr32 
 454:	55                   	push   %ebp
 455:	89 e5                	mov    %esp,%ebp
 457:	57                   	push   %edi
 458:	56                   	push   %esi
 459:	53                   	push   %ebx
 45a:	83 ec 2c             	sub    $0x2c,%esp
 45d:	8b 75 0c             	mov    0xc(%ebp),%esi
 460:	0f b6 1e             	movzbl (%esi),%ebx
 463:	84 db                	test   %bl,%bl
 465:	0f 84 b4 00 00 00    	je     51f <printf+0xcf>
 46b:	8d 45 10             	lea    0x10(%ebp),%eax
 46e:	83 c6 01             	add    $0x1,%esi
 471:	8d 7d e7             	lea    -0x19(%ebp),%edi
 474:	31 d2                	xor    %edx,%edx
 476:	89 45 d0             	mov    %eax,-0x30(%ebp)
 479:	eb 33                	jmp    4ae <printf+0x5e>
 47b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 47f:	90                   	nop
 480:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 483:	ba 25 00 00 00       	mov    $0x25,%edx
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	74 17                	je     4a4 <printf+0x54>
 48d:	83 ec 04             	sub    $0x4,%esp
 490:	88 5d e7             	mov    %bl,-0x19(%ebp)
 493:	6a 01                	push   $0x1
 495:	57                   	push   %edi
 496:	ff 75 08             	pushl  0x8(%ebp)
 499:	e8 55 fe ff ff       	call   2f3 <write>
 49e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 4a1:	83 c4 10             	add    $0x10,%esp
 4a4:	0f b6 1e             	movzbl (%esi),%ebx
 4a7:	83 c6 01             	add    $0x1,%esi
 4aa:	84 db                	test   %bl,%bl
 4ac:	74 71                	je     51f <printf+0xcf>
 4ae:	0f be cb             	movsbl %bl,%ecx
 4b1:	0f b6 c3             	movzbl %bl,%eax
 4b4:	85 d2                	test   %edx,%edx
 4b6:	74 c8                	je     480 <printf+0x30>
 4b8:	83 fa 25             	cmp    $0x25,%edx
 4bb:	75 e7                	jne    4a4 <printf+0x54>
 4bd:	83 f8 64             	cmp    $0x64,%eax
 4c0:	0f 84 9a 00 00 00    	je     560 <printf+0x110>
 4c6:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 4cc:	83 f9 70             	cmp    $0x70,%ecx
 4cf:	74 5f                	je     530 <printf+0xe0>
 4d1:	83 f8 73             	cmp    $0x73,%eax
 4d4:	0f 84 d6 00 00 00    	je     5b0 <printf+0x160>
 4da:	83 f8 63             	cmp    $0x63,%eax
 4dd:	0f 84 8d 00 00 00    	je     570 <printf+0x120>
 4e3:	83 f8 25             	cmp    $0x25,%eax
 4e6:	0f 84 b4 00 00 00    	je     5a0 <printf+0x150>
 4ec:	83 ec 04             	sub    $0x4,%esp
 4ef:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4f3:	6a 01                	push   $0x1
 4f5:	57                   	push   %edi
 4f6:	ff 75 08             	pushl  0x8(%ebp)
 4f9:	e8 f5 fd ff ff       	call   2f3 <write>
 4fe:	88 5d e7             	mov    %bl,-0x19(%ebp)
 501:	83 c4 0c             	add    $0xc,%esp
 504:	6a 01                	push   $0x1
 506:	83 c6 01             	add    $0x1,%esi
 509:	57                   	push   %edi
 50a:	ff 75 08             	pushl  0x8(%ebp)
 50d:	e8 e1 fd ff ff       	call   2f3 <write>
 512:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 516:	83 c4 10             	add    $0x10,%esp
 519:	31 d2                	xor    %edx,%edx
 51b:	84 db                	test   %bl,%bl
 51d:	75 8f                	jne    4ae <printf+0x5e>
 51f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 522:	5b                   	pop    %ebx
 523:	5e                   	pop    %esi
 524:	5f                   	pop    %edi
 525:	5d                   	pop    %ebp
 526:	c3                   	ret    
 527:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 52e:	66 90                	xchg   %ax,%ax
 530:	83 ec 0c             	sub    $0xc,%esp
 533:	b9 10 00 00 00       	mov    $0x10,%ecx
 538:	6a 00                	push   $0x0
 53a:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 53d:	8b 45 08             	mov    0x8(%ebp),%eax
 540:	8b 13                	mov    (%ebx),%edx
 542:	e8 59 fe ff ff       	call   3a0 <printint>
 547:	89 d8                	mov    %ebx,%eax
 549:	83 c4 10             	add    $0x10,%esp
 54c:	31 d2                	xor    %edx,%edx
 54e:	83 c0 04             	add    $0x4,%eax
 551:	89 45 d0             	mov    %eax,-0x30(%ebp)
 554:	e9 4b ff ff ff       	jmp    4a4 <printf+0x54>
 559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	b9 0a 00 00 00       	mov    $0xa,%ecx
 568:	6a 01                	push   $0x1
 56a:	eb ce                	jmp    53a <printf+0xea>
 56c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 570:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 573:	83 ec 04             	sub    $0x4,%esp
 576:	8b 03                	mov    (%ebx),%eax
 578:	6a 01                	push   $0x1
 57a:	83 c3 04             	add    $0x4,%ebx
 57d:	57                   	push   %edi
 57e:	ff 75 08             	pushl  0x8(%ebp)
 581:	88 45 e7             	mov    %al,-0x19(%ebp)
 584:	e8 6a fd ff ff       	call   2f3 <write>
 589:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 58c:	83 c4 10             	add    $0x10,%esp
 58f:	31 d2                	xor    %edx,%edx
 591:	e9 0e ff ff ff       	jmp    4a4 <printf+0x54>
 596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 59d:	8d 76 00             	lea    0x0(%esi),%esi
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	e9 59 ff ff ff       	jmp    504 <printf+0xb4>
 5ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
 5b0:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b3:	8b 18                	mov    (%eax),%ebx
 5b5:	83 c0 04             	add    $0x4,%eax
 5b8:	89 45 d0             	mov    %eax,-0x30(%ebp)
 5bb:	85 db                	test   %ebx,%ebx
 5bd:	74 17                	je     5d6 <printf+0x186>
 5bf:	0f b6 03             	movzbl (%ebx),%eax
 5c2:	31 d2                	xor    %edx,%edx
 5c4:	84 c0                	test   %al,%al
 5c6:	0f 84 d8 fe ff ff    	je     4a4 <printf+0x54>
 5cc:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5cf:	89 de                	mov    %ebx,%esi
 5d1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5d4:	eb 1a                	jmp    5f0 <printf+0x1a0>
 5d6:	bb cc 07 00 00       	mov    $0x7cc,%ebx
 5db:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5de:	b8 28 00 00 00       	mov    $0x28,%eax
 5e3:	89 de                	mov    %ebx,%esi
 5e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5ef:	90                   	nop
 5f0:	83 ec 04             	sub    $0x4,%esp
 5f3:	83 c6 01             	add    $0x1,%esi
 5f6:	88 45 e7             	mov    %al,-0x19(%ebp)
 5f9:	6a 01                	push   $0x1
 5fb:	57                   	push   %edi
 5fc:	53                   	push   %ebx
 5fd:	e8 f1 fc ff ff       	call   2f3 <write>
 602:	0f b6 06             	movzbl (%esi),%eax
 605:	83 c4 10             	add    $0x10,%esp
 608:	84 c0                	test   %al,%al
 60a:	75 e4                	jne    5f0 <printf+0x1a0>
 60c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 60f:	31 d2                	xor    %edx,%edx
 611:	e9 8e fe ff ff       	jmp    4a4 <printf+0x54>
 616:	66 90                	xchg   %ax,%ax
 618:	66 90                	xchg   %ax,%ax
 61a:	66 90                	xchg   %ax,%ax
 61c:	66 90                	xchg   %ax,%ax
 61e:	66 90                	xchg   %ax,%ax

00000620 <free>:
 620:	f3 0f 1e fb          	endbr32 
 624:	55                   	push   %ebp
 625:	a1 84 0a 00 00       	mov    0xa84,%eax
 62a:	89 e5                	mov    %esp,%ebp
 62c:	57                   	push   %edi
 62d:	56                   	push   %esi
 62e:	53                   	push   %ebx
 62f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 632:	8b 10                	mov    (%eax),%edx
 634:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 637:	39 c8                	cmp    %ecx,%eax
 639:	73 15                	jae    650 <free+0x30>
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
 640:	39 d1                	cmp    %edx,%ecx
 642:	72 14                	jb     658 <free+0x38>
 644:	39 d0                	cmp    %edx,%eax
 646:	73 10                	jae    658 <free+0x38>
 648:	89 d0                	mov    %edx,%eax
 64a:	8b 10                	mov    (%eax),%edx
 64c:	39 c8                	cmp    %ecx,%eax
 64e:	72 f0                	jb     640 <free+0x20>
 650:	39 d0                	cmp    %edx,%eax
 652:	72 f4                	jb     648 <free+0x28>
 654:	39 d1                	cmp    %edx,%ecx
 656:	73 f0                	jae    648 <free+0x28>
 658:	8b 73 fc             	mov    -0x4(%ebx),%esi
 65b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 65e:	39 fa                	cmp    %edi,%edx
 660:	74 1e                	je     680 <free+0x60>
 662:	89 53 f8             	mov    %edx,-0x8(%ebx)
 665:	8b 50 04             	mov    0x4(%eax),%edx
 668:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 66b:	39 f1                	cmp    %esi,%ecx
 66d:	74 28                	je     697 <free+0x77>
 66f:	89 08                	mov    %ecx,(%eax)
 671:	5b                   	pop    %ebx
 672:	a3 84 0a 00 00       	mov    %eax,0xa84
 677:	5e                   	pop    %esi
 678:	5f                   	pop    %edi
 679:	5d                   	pop    %ebp
 67a:	c3                   	ret    
 67b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 67f:	90                   	nop
 680:	03 72 04             	add    0x4(%edx),%esi
 683:	89 73 fc             	mov    %esi,-0x4(%ebx)
 686:	8b 10                	mov    (%eax),%edx
 688:	8b 12                	mov    (%edx),%edx
 68a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 693:	39 f1                	cmp    %esi,%ecx
 695:	75 d8                	jne    66f <free+0x4f>
 697:	03 53 fc             	add    -0x4(%ebx),%edx
 69a:	a3 84 0a 00 00       	mov    %eax,0xa84
 69f:	89 50 04             	mov    %edx,0x4(%eax)
 6a2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6a5:	89 10                	mov    %edx,(%eax)
 6a7:	5b                   	pop    %ebx
 6a8:	5e                   	pop    %esi
 6a9:	5f                   	pop    %edi
 6aa:	5d                   	pop    %ebp
 6ab:	c3                   	ret    
 6ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006b0 <malloc>:
 6b0:	f3 0f 1e fb          	endbr32 
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	57                   	push   %edi
 6b8:	56                   	push   %esi
 6b9:	53                   	push   %ebx
 6ba:	83 ec 1c             	sub    $0x1c,%esp
 6bd:	8b 45 08             	mov    0x8(%ebp),%eax
 6c0:	8b 3d 84 0a 00 00    	mov    0xa84,%edi
 6c6:	8d 70 07             	lea    0x7(%eax),%esi
 6c9:	c1 ee 03             	shr    $0x3,%esi
 6cc:	83 c6 01             	add    $0x1,%esi
 6cf:	85 ff                	test   %edi,%edi
 6d1:	0f 84 a9 00 00 00    	je     780 <malloc+0xd0>
 6d7:	8b 07                	mov    (%edi),%eax
 6d9:	8b 48 04             	mov    0x4(%eax),%ecx
 6dc:	39 f1                	cmp    %esi,%ecx
 6de:	73 6d                	jae    74d <malloc+0x9d>
 6e0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6e6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6eb:	0f 43 de             	cmovae %esi,%ebx
 6ee:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6f5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6f8:	eb 17                	jmp    711 <malloc+0x61>
 6fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 700:	8b 10                	mov    (%eax),%edx
 702:	8b 4a 04             	mov    0x4(%edx),%ecx
 705:	39 f1                	cmp    %esi,%ecx
 707:	73 4f                	jae    758 <malloc+0xa8>
 709:	8b 3d 84 0a 00 00    	mov    0xa84,%edi
 70f:	89 d0                	mov    %edx,%eax
 711:	39 c7                	cmp    %eax,%edi
 713:	75 eb                	jne    700 <malloc+0x50>
 715:	83 ec 0c             	sub    $0xc,%esp
 718:	ff 75 e4             	pushl  -0x1c(%ebp)
 71b:	e8 3b fc ff ff       	call   35b <sbrk>
 720:	83 c4 10             	add    $0x10,%esp
 723:	83 f8 ff             	cmp    $0xffffffff,%eax
 726:	74 1b                	je     743 <malloc+0x93>
 728:	89 58 04             	mov    %ebx,0x4(%eax)
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	83 c0 08             	add    $0x8,%eax
 731:	50                   	push   %eax
 732:	e8 e9 fe ff ff       	call   620 <free>
 737:	a1 84 0a 00 00       	mov    0xa84,%eax
 73c:	83 c4 10             	add    $0x10,%esp
 73f:	85 c0                	test   %eax,%eax
 741:	75 bd                	jne    700 <malloc+0x50>
 743:	8d 65 f4             	lea    -0xc(%ebp),%esp
 746:	31 c0                	xor    %eax,%eax
 748:	5b                   	pop    %ebx
 749:	5e                   	pop    %esi
 74a:	5f                   	pop    %edi
 74b:	5d                   	pop    %ebp
 74c:	c3                   	ret    
 74d:	89 c2                	mov    %eax,%edx
 74f:	89 f8                	mov    %edi,%eax
 751:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 758:	39 ce                	cmp    %ecx,%esi
 75a:	74 54                	je     7b0 <malloc+0x100>
 75c:	29 f1                	sub    %esi,%ecx
 75e:	89 4a 04             	mov    %ecx,0x4(%edx)
 761:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 764:	89 72 04             	mov    %esi,0x4(%edx)
 767:	a3 84 0a 00 00       	mov    %eax,0xa84
 76c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 76f:	8d 42 08             	lea    0x8(%edx),%eax
 772:	5b                   	pop    %ebx
 773:	5e                   	pop    %esi
 774:	5f                   	pop    %edi
 775:	5d                   	pop    %ebp
 776:	c3                   	ret    
 777:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 77e:	66 90                	xchg   %ax,%ax
 780:	c7 05 84 0a 00 00 88 	movl   $0xa88,0xa84
 787:	0a 00 00 
 78a:	bf 88 0a 00 00       	mov    $0xa88,%edi
 78f:	c7 05 88 0a 00 00 88 	movl   $0xa88,0xa88
 796:	0a 00 00 
 799:	89 f8                	mov    %edi,%eax
 79b:	c7 05 8c 0a 00 00 00 	movl   $0x0,0xa8c
 7a2:	00 00 00 
 7a5:	e9 36 ff ff ff       	jmp    6e0 <malloc+0x30>
 7aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 7b0:	8b 0a                	mov    (%edx),%ecx
 7b2:	89 08                	mov    %ecx,(%eax)
 7b4:	eb b1                	jmp    767 <malloc+0xb7>
