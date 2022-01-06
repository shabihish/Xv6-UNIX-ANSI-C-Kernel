
_get_parent_pid:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
  15:	e8 29 03 00 00       	call   343 <get_parent_pid>
  1a:	83 ec 04             	sub    $0x4,%esp
  1d:	50                   	push   %eax
  1e:	68 78 07 00 00       	push   $0x778
  23:	6a 01                	push   $0x1
  25:	e8 e6 03 00 00       	call   410 <printf>
  2a:	e8 64 02 00 00       	call   293 <exit>
  2f:	90                   	nop

00000030 <strcpy>:
  30:	f3 0f 1e fb          	endbr32 
  34:	55                   	push   %ebp
  35:	31 c0                	xor    %eax,%eax
  37:	89 e5                	mov    %esp,%ebp
  39:	53                   	push   %ebx
  3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  40:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  44:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  47:	83 c0 01             	add    $0x1,%eax
  4a:	84 d2                	test   %dl,%dl
  4c:	75 f2                	jne    40 <strcpy+0x10>
  4e:	89 c8                	mov    %ecx,%eax
  50:	5b                   	pop    %ebx
  51:	5d                   	pop    %ebp
  52:	c3                   	ret    
  53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000060 <strcmp>:
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  6e:	0f b6 01             	movzbl (%ecx),%eax
  71:	0f b6 1a             	movzbl (%edx),%ebx
  74:	84 c0                	test   %al,%al
  76:	75 19                	jne    91 <strcmp+0x31>
  78:	eb 26                	jmp    a0 <strcmp+0x40>
  7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  80:	0f b6 41 01          	movzbl 0x1(%ecx),%eax
  84:	83 c1 01             	add    $0x1,%ecx
  87:	83 c2 01             	add    $0x1,%edx
  8a:	0f b6 1a             	movzbl (%edx),%ebx
  8d:	84 c0                	test   %al,%al
  8f:	74 0f                	je     a0 <strcmp+0x40>
  91:	38 d8                	cmp    %bl,%al
  93:	74 eb                	je     80 <strcmp+0x20>
  95:	29 d8                	sub    %ebx,%eax
  97:	5b                   	pop    %ebx
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a0:	31 c0                	xor    %eax,%eax
  a2:	29 d8                	sub    %ebx,%eax
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ae:	66 90                	xchg   %ax,%ax

000000b0 <strlen>:
  b0:	f3 0f 1e fb          	endbr32 
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 55 08             	mov    0x8(%ebp),%edx
  ba:	80 3a 00             	cmpb   $0x0,(%edx)
  bd:	74 21                	je     e0 <strlen+0x30>
  bf:	31 c0                	xor    %eax,%eax
  c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  c8:	83 c0 01             	add    $0x1,%eax
  cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  cf:	89 c1                	mov    %eax,%ecx
  d1:	75 f5                	jne    c8 <strlen+0x18>
  d3:	89 c8                	mov    %ecx,%eax
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  de:	66 90                	xchg   %ax,%ax
  e0:	31 c9                	xor    %ecx,%ecx
  e2:	5d                   	pop    %ebp
  e3:	89 c8                	mov    %ecx,%eax
  e5:	c3                   	ret    
  e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ed:	8d 76 00             	lea    0x0(%esi),%esi

000000f0 <memset>:
  f0:	f3 0f 1e fb          	endbr32 
  f4:	55                   	push   %ebp
  f5:	89 e5                	mov    %esp,%ebp
  f7:	57                   	push   %edi
  f8:	8b 55 08             	mov    0x8(%ebp),%edx
  fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fe:	8b 45 0c             	mov    0xc(%ebp),%eax
 101:	89 d7                	mov    %edx,%edi
 103:	fc                   	cld    
 104:	f3 aa                	rep stos %al,%es:(%edi)
 106:	89 d0                	mov    %edx,%eax
 108:	5f                   	pop    %edi
 109:	5d                   	pop    %ebp
 10a:	c3                   	ret    
 10b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 10f:	90                   	nop

00000110 <strchr>:
 110:	f3 0f 1e fb          	endbr32 
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	8b 45 08             	mov    0x8(%ebp),%eax
 11a:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
 11e:	0f b6 10             	movzbl (%eax),%edx
 121:	84 d2                	test   %dl,%dl
 123:	75 16                	jne    13b <strchr+0x2b>
 125:	eb 21                	jmp    148 <strchr+0x38>
 127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 12e:	66 90                	xchg   %ax,%ax
 130:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 134:	83 c0 01             	add    $0x1,%eax
 137:	84 d2                	test   %dl,%dl
 139:	74 0d                	je     148 <strchr+0x38>
 13b:	38 d1                	cmp    %dl,%cl
 13d:	75 f1                	jne    130 <strchr+0x20>
 13f:	5d                   	pop    %ebp
 140:	c3                   	ret    
 141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 148:	31 c0                	xor    %eax,%eax
 14a:	5d                   	pop    %ebp
 14b:	c3                   	ret    
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000150 <gets>:
 150:	f3 0f 1e fb          	endbr32 
 154:	55                   	push   %ebp
 155:	89 e5                	mov    %esp,%ebp
 157:	57                   	push   %edi
 158:	56                   	push   %esi
 159:	31 f6                	xor    %esi,%esi
 15b:	53                   	push   %ebx
 15c:	89 f3                	mov    %esi,%ebx
 15e:	83 ec 1c             	sub    $0x1c,%esp
 161:	8b 7d 08             	mov    0x8(%ebp),%edi
 164:	eb 33                	jmp    199 <gets+0x49>
 166:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 16d:	8d 76 00             	lea    0x0(%esi),%esi
 170:	83 ec 04             	sub    $0x4,%esp
 173:	8d 45 e7             	lea    -0x19(%ebp),%eax
 176:	6a 01                	push   $0x1
 178:	50                   	push   %eax
 179:	6a 00                	push   $0x0
 17b:	e8 2b 01 00 00       	call   2ab <read>
 180:	83 c4 10             	add    $0x10,%esp
 183:	85 c0                	test   %eax,%eax
 185:	7e 1c                	jle    1a3 <gets+0x53>
 187:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 18b:	83 c7 01             	add    $0x1,%edi
 18e:	88 47 ff             	mov    %al,-0x1(%edi)
 191:	3c 0a                	cmp    $0xa,%al
 193:	74 23                	je     1b8 <gets+0x68>
 195:	3c 0d                	cmp    $0xd,%al
 197:	74 1f                	je     1b8 <gets+0x68>
 199:	83 c3 01             	add    $0x1,%ebx
 19c:	89 fe                	mov    %edi,%esi
 19e:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1a1:	7c cd                	jl     170 <gets+0x20>
 1a3:	89 f3                	mov    %esi,%ebx
 1a5:	8b 45 08             	mov    0x8(%ebp),%eax
 1a8:	c6 03 00             	movb   $0x0,(%ebx)
 1ab:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1ae:	5b                   	pop    %ebx
 1af:	5e                   	pop    %esi
 1b0:	5f                   	pop    %edi
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b7:	90                   	nop
 1b8:	8b 75 08             	mov    0x8(%ebp),%esi
 1bb:	8b 45 08             	mov    0x8(%ebp),%eax
 1be:	01 de                	add    %ebx,%esi
 1c0:	89 f3                	mov    %esi,%ebx
 1c2:	c6 03 00             	movb   $0x0,(%ebx)
 1c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c8:	5b                   	pop    %ebx
 1c9:	5e                   	pop    %esi
 1ca:	5f                   	pop    %edi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi

000001d0 <stat>:
 1d0:	f3 0f 1e fb          	endbr32 
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	56                   	push   %esi
 1d8:	53                   	push   %ebx
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	6a 00                	push   $0x0
 1de:	ff 75 08             	pushl  0x8(%ebp)
 1e1:	e8 ed 00 00 00       	call   2d3 <open>
 1e6:	83 c4 10             	add    $0x10,%esp
 1e9:	85 c0                	test   %eax,%eax
 1eb:	78 2b                	js     218 <stat+0x48>
 1ed:	83 ec 08             	sub    $0x8,%esp
 1f0:	ff 75 0c             	pushl  0xc(%ebp)
 1f3:	89 c3                	mov    %eax,%ebx
 1f5:	50                   	push   %eax
 1f6:	e8 f0 00 00 00       	call   2eb <fstat>
 1fb:	89 1c 24             	mov    %ebx,(%esp)
 1fe:	89 c6                	mov    %eax,%esi
 200:	e8 b6 00 00 00       	call   2bb <close>
 205:	83 c4 10             	add    $0x10,%esp
 208:	8d 65 f8             	lea    -0x8(%ebp),%esp
 20b:	89 f0                	mov    %esi,%eax
 20d:	5b                   	pop    %ebx
 20e:	5e                   	pop    %esi
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
 211:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 218:	be ff ff ff ff       	mov    $0xffffffff,%esi
 21d:	eb e9                	jmp    208 <stat+0x38>
 21f:	90                   	nop

00000220 <atoi>:
 220:	f3 0f 1e fb          	endbr32 
 224:	55                   	push   %ebp
 225:	89 e5                	mov    %esp,%ebp
 227:	53                   	push   %ebx
 228:	8b 55 08             	mov    0x8(%ebp),%edx
 22b:	0f be 02             	movsbl (%edx),%eax
 22e:	8d 48 d0             	lea    -0x30(%eax),%ecx
 231:	80 f9 09             	cmp    $0x9,%cl
 234:	b9 00 00 00 00       	mov    $0x0,%ecx
 239:	77 1a                	ja     255 <atoi+0x35>
 23b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 23f:	90                   	nop
 240:	83 c2 01             	add    $0x1,%edx
 243:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 246:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
 24a:	0f be 02             	movsbl (%edx),%eax
 24d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 250:	80 fb 09             	cmp    $0x9,%bl
 253:	76 eb                	jbe    240 <atoi+0x20>
 255:	89 c8                	mov    %ecx,%eax
 257:	5b                   	pop    %ebx
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    
 25a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000260 <memmove>:
 260:	f3 0f 1e fb          	endbr32 
 264:	55                   	push   %ebp
 265:	89 e5                	mov    %esp,%ebp
 267:	57                   	push   %edi
 268:	8b 45 10             	mov    0x10(%ebp),%eax
 26b:	8b 55 08             	mov    0x8(%ebp),%edx
 26e:	56                   	push   %esi
 26f:	8b 75 0c             	mov    0xc(%ebp),%esi
 272:	85 c0                	test   %eax,%eax
 274:	7e 0f                	jle    285 <memmove+0x25>
 276:	01 d0                	add    %edx,%eax
 278:	89 d7                	mov    %edx,%edi
 27a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 280:	a4                   	movsb  %ds:(%esi),%es:(%edi)
 281:	39 f8                	cmp    %edi,%eax
 283:	75 fb                	jne    280 <memmove+0x20>
 285:	5e                   	pop    %esi
 286:	89 d0                	mov    %edx,%eax
 288:	5f                   	pop    %edi
 289:	5d                   	pop    %ebp
 28a:	c3                   	ret    

0000028b <fork>:
 28b:	b8 01 00 00 00       	mov    $0x1,%eax
 290:	cd 40                	int    $0x40
 292:	c3                   	ret    

00000293 <exit>:
 293:	b8 02 00 00 00       	mov    $0x2,%eax
 298:	cd 40                	int    $0x40
 29a:	c3                   	ret    

0000029b <wait>:
 29b:	b8 03 00 00 00       	mov    $0x3,%eax
 2a0:	cd 40                	int    $0x40
 2a2:	c3                   	ret    

000002a3 <pipe>:
 2a3:	b8 04 00 00 00       	mov    $0x4,%eax
 2a8:	cd 40                	int    $0x40
 2aa:	c3                   	ret    

000002ab <read>:
 2ab:	b8 05 00 00 00       	mov    $0x5,%eax
 2b0:	cd 40                	int    $0x40
 2b2:	c3                   	ret    

000002b3 <write>:
 2b3:	b8 10 00 00 00       	mov    $0x10,%eax
 2b8:	cd 40                	int    $0x40
 2ba:	c3                   	ret    

000002bb <close>:
 2bb:	b8 15 00 00 00       	mov    $0x15,%eax
 2c0:	cd 40                	int    $0x40
 2c2:	c3                   	ret    

000002c3 <kill>:
 2c3:	b8 06 00 00 00       	mov    $0x6,%eax
 2c8:	cd 40                	int    $0x40
 2ca:	c3                   	ret    

000002cb <exec>:
 2cb:	b8 07 00 00 00       	mov    $0x7,%eax
 2d0:	cd 40                	int    $0x40
 2d2:	c3                   	ret    

000002d3 <open>:
 2d3:	b8 0f 00 00 00       	mov    $0xf,%eax
 2d8:	cd 40                	int    $0x40
 2da:	c3                   	ret    

000002db <mknod>:
 2db:	b8 11 00 00 00       	mov    $0x11,%eax
 2e0:	cd 40                	int    $0x40
 2e2:	c3                   	ret    

000002e3 <unlink>:
 2e3:	b8 12 00 00 00       	mov    $0x12,%eax
 2e8:	cd 40                	int    $0x40
 2ea:	c3                   	ret    

000002eb <fstat>:
 2eb:	b8 08 00 00 00       	mov    $0x8,%eax
 2f0:	cd 40                	int    $0x40
 2f2:	c3                   	ret    

000002f3 <link>:
 2f3:	b8 13 00 00 00       	mov    $0x13,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <mkdir>:
 2fb:	b8 14 00 00 00       	mov    $0x14,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <chdir>:
 303:	b8 09 00 00 00       	mov    $0x9,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <dup>:
 30b:	b8 0a 00 00 00       	mov    $0xa,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <getpid>:
 313:	b8 0b 00 00 00       	mov    $0xb,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <sbrk>:
 31b:	b8 0c 00 00 00       	mov    $0xc,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <sleep>:
 323:	b8 0d 00 00 00       	mov    $0xd,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <uptime>:
 32b:	b8 0e 00 00 00       	mov    $0xe,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <calculate_sum_of_digits>:
 333:	b8 16 00 00 00       	mov    $0x16,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <get_file_sectors>:
 33b:	b8 17 00 00 00       	mov    $0x17,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <get_parent_pid>:
 343:	b8 18 00 00 00       	mov    $0x18,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <wait_sleeping>:
 34b:	b8 19 00 00 00       	mov    $0x19,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <set_proc_tracer>:
 353:	b8 1a 00 00 00       	mov    $0x1a,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    
 35b:	66 90                	xchg   %ax,%ax
 35d:	66 90                	xchg   %ax,%ax
 35f:	90                   	nop

00000360 <printint>:
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 3c             	sub    $0x3c,%esp
 369:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
 36c:	89 d1                	mov    %edx,%ecx
 36e:	89 45 b8             	mov    %eax,-0x48(%ebp)
 371:	85 d2                	test   %edx,%edx
 373:	0f 89 7f 00 00 00    	jns    3f8 <printint+0x98>
 379:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 37d:	74 79                	je     3f8 <printint+0x98>
 37f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
 386:	f7 d9                	neg    %ecx
 388:	31 db                	xor    %ebx,%ebx
 38a:	8d 75 d7             	lea    -0x29(%ebp),%esi
 38d:	8d 76 00             	lea    0x0(%esi),%esi
 390:	89 c8                	mov    %ecx,%eax
 392:	31 d2                	xor    %edx,%edx
 394:	89 cf                	mov    %ecx,%edi
 396:	f7 75 c4             	divl   -0x3c(%ebp)
 399:	0f b6 92 a4 07 00 00 	movzbl 0x7a4(%edx),%edx
 3a0:	89 45 c0             	mov    %eax,-0x40(%ebp)
 3a3:	89 d8                	mov    %ebx,%eax
 3a5:	8d 5b 01             	lea    0x1(%ebx),%ebx
 3a8:	8b 4d c0             	mov    -0x40(%ebp),%ecx
 3ab:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
 3ae:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
 3b1:	76 dd                	jbe    390 <printint+0x30>
 3b3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
 3b6:	85 c9                	test   %ecx,%ecx
 3b8:	74 0c                	je     3c6 <printint+0x66>
 3ba:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
 3bf:	89 d8                	mov    %ebx,%eax
 3c1:	ba 2d 00 00 00       	mov    $0x2d,%edx
 3c6:	8b 7d b8             	mov    -0x48(%ebp),%edi
 3c9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
 3cd:	eb 07                	jmp    3d6 <printint+0x76>
 3cf:	90                   	nop
 3d0:	0f b6 13             	movzbl (%ebx),%edx
 3d3:	83 eb 01             	sub    $0x1,%ebx
 3d6:	83 ec 04             	sub    $0x4,%esp
 3d9:	88 55 d7             	mov    %dl,-0x29(%ebp)
 3dc:	6a 01                	push   $0x1
 3de:	56                   	push   %esi
 3df:	57                   	push   %edi
 3e0:	e8 ce fe ff ff       	call   2b3 <write>
 3e5:	83 c4 10             	add    $0x10,%esp
 3e8:	39 de                	cmp    %ebx,%esi
 3ea:	75 e4                	jne    3d0 <printint+0x70>
 3ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ef:	5b                   	pop    %ebx
 3f0:	5e                   	pop    %esi
 3f1:	5f                   	pop    %edi
 3f2:	5d                   	pop    %ebp
 3f3:	c3                   	ret    
 3f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3f8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
 3ff:	eb 87                	jmp    388 <printint+0x28>
 401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 40f:	90                   	nop

00000410 <printf>:
 410:	f3 0f 1e fb          	endbr32 
 414:	55                   	push   %ebp
 415:	89 e5                	mov    %esp,%ebp
 417:	57                   	push   %edi
 418:	56                   	push   %esi
 419:	53                   	push   %ebx
 41a:	83 ec 2c             	sub    $0x2c,%esp
 41d:	8b 75 0c             	mov    0xc(%ebp),%esi
 420:	0f b6 1e             	movzbl (%esi),%ebx
 423:	84 db                	test   %bl,%bl
 425:	0f 84 b4 00 00 00    	je     4df <printf+0xcf>
 42b:	8d 45 10             	lea    0x10(%ebp),%eax
 42e:	83 c6 01             	add    $0x1,%esi
 431:	8d 7d e7             	lea    -0x19(%ebp),%edi
 434:	31 d2                	xor    %edx,%edx
 436:	89 45 d0             	mov    %eax,-0x30(%ebp)
 439:	eb 33                	jmp    46e <printf+0x5e>
 43b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 43f:	90                   	nop
 440:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 443:	ba 25 00 00 00       	mov    $0x25,%edx
 448:	83 f8 25             	cmp    $0x25,%eax
 44b:	74 17                	je     464 <printf+0x54>
 44d:	83 ec 04             	sub    $0x4,%esp
 450:	88 5d e7             	mov    %bl,-0x19(%ebp)
 453:	6a 01                	push   $0x1
 455:	57                   	push   %edi
 456:	ff 75 08             	pushl  0x8(%ebp)
 459:	e8 55 fe ff ff       	call   2b3 <write>
 45e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 461:	83 c4 10             	add    $0x10,%esp
 464:	0f b6 1e             	movzbl (%esi),%ebx
 467:	83 c6 01             	add    $0x1,%esi
 46a:	84 db                	test   %bl,%bl
 46c:	74 71                	je     4df <printf+0xcf>
 46e:	0f be cb             	movsbl %bl,%ecx
 471:	0f b6 c3             	movzbl %bl,%eax
 474:	85 d2                	test   %edx,%edx
 476:	74 c8                	je     440 <printf+0x30>
 478:	83 fa 25             	cmp    $0x25,%edx
 47b:	75 e7                	jne    464 <printf+0x54>
 47d:	83 f8 64             	cmp    $0x64,%eax
 480:	0f 84 9a 00 00 00    	je     520 <printf+0x110>
 486:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 48c:	83 f9 70             	cmp    $0x70,%ecx
 48f:	74 5f                	je     4f0 <printf+0xe0>
 491:	83 f8 73             	cmp    $0x73,%eax
 494:	0f 84 d6 00 00 00    	je     570 <printf+0x160>
 49a:	83 f8 63             	cmp    $0x63,%eax
 49d:	0f 84 8d 00 00 00    	je     530 <printf+0x120>
 4a3:	83 f8 25             	cmp    $0x25,%eax
 4a6:	0f 84 b4 00 00 00    	je     560 <printf+0x150>
 4ac:	83 ec 04             	sub    $0x4,%esp
 4af:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4b3:	6a 01                	push   $0x1
 4b5:	57                   	push   %edi
 4b6:	ff 75 08             	pushl  0x8(%ebp)
 4b9:	e8 f5 fd ff ff       	call   2b3 <write>
 4be:	88 5d e7             	mov    %bl,-0x19(%ebp)
 4c1:	83 c4 0c             	add    $0xc,%esp
 4c4:	6a 01                	push   $0x1
 4c6:	83 c6 01             	add    $0x1,%esi
 4c9:	57                   	push   %edi
 4ca:	ff 75 08             	pushl  0x8(%ebp)
 4cd:	e8 e1 fd ff ff       	call   2b3 <write>
 4d2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4d6:	83 c4 10             	add    $0x10,%esp
 4d9:	31 d2                	xor    %edx,%edx
 4db:	84 db                	test   %bl,%bl
 4dd:	75 8f                	jne    46e <printf+0x5e>
 4df:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e2:	5b                   	pop    %ebx
 4e3:	5e                   	pop    %esi
 4e4:	5f                   	pop    %edi
 4e5:	5d                   	pop    %ebp
 4e6:	c3                   	ret    
 4e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4ee:	66 90                	xchg   %ax,%ax
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	b9 10 00 00 00       	mov    $0x10,%ecx
 4f8:	6a 00                	push   $0x0
 4fa:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 4fd:	8b 45 08             	mov    0x8(%ebp),%eax
 500:	8b 13                	mov    (%ebx),%edx
 502:	e8 59 fe ff ff       	call   360 <printint>
 507:	89 d8                	mov    %ebx,%eax
 509:	83 c4 10             	add    $0x10,%esp
 50c:	31 d2                	xor    %edx,%edx
 50e:	83 c0 04             	add    $0x4,%eax
 511:	89 45 d0             	mov    %eax,-0x30(%ebp)
 514:	e9 4b ff ff ff       	jmp    464 <printf+0x54>
 519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 520:	83 ec 0c             	sub    $0xc,%esp
 523:	b9 0a 00 00 00       	mov    $0xa,%ecx
 528:	6a 01                	push   $0x1
 52a:	eb ce                	jmp    4fa <printf+0xea>
 52c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 530:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 533:	83 ec 04             	sub    $0x4,%esp
 536:	8b 03                	mov    (%ebx),%eax
 538:	6a 01                	push   $0x1
 53a:	83 c3 04             	add    $0x4,%ebx
 53d:	57                   	push   %edi
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	88 45 e7             	mov    %al,-0x19(%ebp)
 544:	e8 6a fd ff ff       	call   2b3 <write>
 549:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 54c:	83 c4 10             	add    $0x10,%esp
 54f:	31 d2                	xor    %edx,%edx
 551:	e9 0e ff ff ff       	jmp    464 <printf+0x54>
 556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 55d:	8d 76 00             	lea    0x0(%esi),%esi
 560:	88 5d e7             	mov    %bl,-0x19(%ebp)
 563:	83 ec 04             	sub    $0x4,%esp
 566:	e9 59 ff ff ff       	jmp    4c4 <printf+0xb4>
 56b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 56f:	90                   	nop
 570:	8b 45 d0             	mov    -0x30(%ebp),%eax
 573:	8b 18                	mov    (%eax),%ebx
 575:	83 c0 04             	add    $0x4,%eax
 578:	89 45 d0             	mov    %eax,-0x30(%ebp)
 57b:	85 db                	test   %ebx,%ebx
 57d:	74 17                	je     596 <printf+0x186>
 57f:	0f b6 03             	movzbl (%ebx),%eax
 582:	31 d2                	xor    %edx,%edx
 584:	84 c0                	test   %al,%al
 586:	0f 84 d8 fe ff ff    	je     464 <printf+0x54>
 58c:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 58f:	89 de                	mov    %ebx,%esi
 591:	8b 5d 08             	mov    0x8(%ebp),%ebx
 594:	eb 1a                	jmp    5b0 <printf+0x1a0>
 596:	bb 9b 07 00 00       	mov    $0x79b,%ebx
 59b:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 59e:	b8 28 00 00 00       	mov    $0x28,%eax
 5a3:	89 de                	mov    %ebx,%esi
 5a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 5af:	90                   	nop
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	83 c6 01             	add    $0x1,%esi
 5b6:	88 45 e7             	mov    %al,-0x19(%ebp)
 5b9:	6a 01                	push   $0x1
 5bb:	57                   	push   %edi
 5bc:	53                   	push   %ebx
 5bd:	e8 f1 fc ff ff       	call   2b3 <write>
 5c2:	0f b6 06             	movzbl (%esi),%eax
 5c5:	83 c4 10             	add    $0x10,%esp
 5c8:	84 c0                	test   %al,%al
 5ca:	75 e4                	jne    5b0 <printf+0x1a0>
 5cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5cf:	31 d2                	xor    %edx,%edx
 5d1:	e9 8e fe ff ff       	jmp    464 <printf+0x54>
 5d6:	66 90                	xchg   %ax,%ax
 5d8:	66 90                	xchg   %ax,%ax
 5da:	66 90                	xchg   %ax,%ax
 5dc:	66 90                	xchg   %ax,%ax
 5de:	66 90                	xchg   %ax,%ax

000005e0 <free>:
 5e0:	f3 0f 1e fb          	endbr32 
 5e4:	55                   	push   %ebp
 5e5:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 5ea:	89 e5                	mov    %esp,%ebp
 5ec:	57                   	push   %edi
 5ed:	56                   	push   %esi
 5ee:	53                   	push   %ebx
 5ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5f2:	8b 10                	mov    (%eax),%edx
 5f4:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 5f7:	39 c8                	cmp    %ecx,%eax
 5f9:	73 15                	jae    610 <free+0x30>
 5fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 5ff:	90                   	nop
 600:	39 d1                	cmp    %edx,%ecx
 602:	72 14                	jb     618 <free+0x38>
 604:	39 d0                	cmp    %edx,%eax
 606:	73 10                	jae    618 <free+0x38>
 608:	89 d0                	mov    %edx,%eax
 60a:	8b 10                	mov    (%eax),%edx
 60c:	39 c8                	cmp    %ecx,%eax
 60e:	72 f0                	jb     600 <free+0x20>
 610:	39 d0                	cmp    %edx,%eax
 612:	72 f4                	jb     608 <free+0x28>
 614:	39 d1                	cmp    %edx,%ecx
 616:	73 f0                	jae    608 <free+0x28>
 618:	8b 73 fc             	mov    -0x4(%ebx),%esi
 61b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 61e:	39 fa                	cmp    %edi,%edx
 620:	74 1e                	je     640 <free+0x60>
 622:	89 53 f8             	mov    %edx,-0x8(%ebx)
 625:	8b 50 04             	mov    0x4(%eax),%edx
 628:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 62b:	39 f1                	cmp    %esi,%ecx
 62d:	74 28                	je     657 <free+0x77>
 62f:	89 08                	mov    %ecx,(%eax)
 631:	5b                   	pop    %ebx
 632:	a3 4c 0a 00 00       	mov    %eax,0xa4c
 637:	5e                   	pop    %esi
 638:	5f                   	pop    %edi
 639:	5d                   	pop    %ebp
 63a:	c3                   	ret    
 63b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 63f:	90                   	nop
 640:	03 72 04             	add    0x4(%edx),%esi
 643:	89 73 fc             	mov    %esi,-0x4(%ebx)
 646:	8b 10                	mov    (%eax),%edx
 648:	8b 12                	mov    (%edx),%edx
 64a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 64d:	8b 50 04             	mov    0x4(%eax),%edx
 650:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 653:	39 f1                	cmp    %esi,%ecx
 655:	75 d8                	jne    62f <free+0x4f>
 657:	03 53 fc             	add    -0x4(%ebx),%edx
 65a:	a3 4c 0a 00 00       	mov    %eax,0xa4c
 65f:	89 50 04             	mov    %edx,0x4(%eax)
 662:	8b 53 f8             	mov    -0x8(%ebx),%edx
 665:	89 10                	mov    %edx,(%eax)
 667:	5b                   	pop    %ebx
 668:	5e                   	pop    %esi
 669:	5f                   	pop    %edi
 66a:	5d                   	pop    %ebp
 66b:	c3                   	ret    
 66c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000670 <malloc>:
 670:	f3 0f 1e fb          	endbr32 
 674:	55                   	push   %ebp
 675:	89 e5                	mov    %esp,%ebp
 677:	57                   	push   %edi
 678:	56                   	push   %esi
 679:	53                   	push   %ebx
 67a:	83 ec 1c             	sub    $0x1c,%esp
 67d:	8b 45 08             	mov    0x8(%ebp),%eax
 680:	8b 3d 4c 0a 00 00    	mov    0xa4c,%edi
 686:	8d 70 07             	lea    0x7(%eax),%esi
 689:	c1 ee 03             	shr    $0x3,%esi
 68c:	83 c6 01             	add    $0x1,%esi
 68f:	85 ff                	test   %edi,%edi
 691:	0f 84 a9 00 00 00    	je     740 <malloc+0xd0>
 697:	8b 07                	mov    (%edi),%eax
 699:	8b 48 04             	mov    0x4(%eax),%ecx
 69c:	39 f1                	cmp    %esi,%ecx
 69e:	73 6d                	jae    70d <malloc+0x9d>
 6a0:	81 fe 00 10 00 00    	cmp    $0x1000,%esi
 6a6:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6ab:	0f 43 de             	cmovae %esi,%ebx
 6ae:	8d 0c dd 00 00 00 00 	lea    0x0(,%ebx,8),%ecx
 6b5:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
 6b8:	eb 17                	jmp    6d1 <malloc+0x61>
 6ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 6c0:	8b 10                	mov    (%eax),%edx
 6c2:	8b 4a 04             	mov    0x4(%edx),%ecx
 6c5:	39 f1                	cmp    %esi,%ecx
 6c7:	73 4f                	jae    718 <malloc+0xa8>
 6c9:	8b 3d 4c 0a 00 00    	mov    0xa4c,%edi
 6cf:	89 d0                	mov    %edx,%eax
 6d1:	39 c7                	cmp    %eax,%edi
 6d3:	75 eb                	jne    6c0 <malloc+0x50>
 6d5:	83 ec 0c             	sub    $0xc,%esp
 6d8:	ff 75 e4             	pushl  -0x1c(%ebp)
 6db:	e8 3b fc ff ff       	call   31b <sbrk>
 6e0:	83 c4 10             	add    $0x10,%esp
 6e3:	83 f8 ff             	cmp    $0xffffffff,%eax
 6e6:	74 1b                	je     703 <malloc+0x93>
 6e8:	89 58 04             	mov    %ebx,0x4(%eax)
 6eb:	83 ec 0c             	sub    $0xc,%esp
 6ee:	83 c0 08             	add    $0x8,%eax
 6f1:	50                   	push   %eax
 6f2:	e8 e9 fe ff ff       	call   5e0 <free>
 6f7:	a1 4c 0a 00 00       	mov    0xa4c,%eax
 6fc:	83 c4 10             	add    $0x10,%esp
 6ff:	85 c0                	test   %eax,%eax
 701:	75 bd                	jne    6c0 <malloc+0x50>
 703:	8d 65 f4             	lea    -0xc(%ebp),%esp
 706:	31 c0                	xor    %eax,%eax
 708:	5b                   	pop    %ebx
 709:	5e                   	pop    %esi
 70a:	5f                   	pop    %edi
 70b:	5d                   	pop    %ebp
 70c:	c3                   	ret    
 70d:	89 c2                	mov    %eax,%edx
 70f:	89 f8                	mov    %edi,%eax
 711:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 718:	39 ce                	cmp    %ecx,%esi
 71a:	74 54                	je     770 <malloc+0x100>
 71c:	29 f1                	sub    %esi,%ecx
 71e:	89 4a 04             	mov    %ecx,0x4(%edx)
 721:	8d 14 ca             	lea    (%edx,%ecx,8),%edx
 724:	89 72 04             	mov    %esi,0x4(%edx)
 727:	a3 4c 0a 00 00       	mov    %eax,0xa4c
 72c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 72f:	8d 42 08             	lea    0x8(%edx),%eax
 732:	5b                   	pop    %ebx
 733:	5e                   	pop    %esi
 734:	5f                   	pop    %edi
 735:	5d                   	pop    %ebp
 736:	c3                   	ret    
 737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 73e:	66 90                	xchg   %ax,%ax
 740:	c7 05 4c 0a 00 00 50 	movl   $0xa50,0xa4c
 747:	0a 00 00 
 74a:	bf 50 0a 00 00       	mov    $0xa50,%edi
 74f:	c7 05 50 0a 00 00 50 	movl   $0xa50,0xa50
 756:	0a 00 00 
 759:	89 f8                	mov    %edi,%eax
 75b:	c7 05 54 0a 00 00 00 	movl   $0x0,0xa54
 762:	00 00 00 
 765:	e9 36 ff ff ff       	jmp    6a0 <malloc+0x30>
 76a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 770:	8b 0a                	mov    (%edx),%ecx
 772:	89 08                	mov    %ecx,(%eax)
 774:	eb b1                	jmp    727 <malloc+0xb7>
