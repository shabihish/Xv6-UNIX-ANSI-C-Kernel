
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc e0 c5 10 80       	mov    $0x8010c5e0,%esp
8010002d:	b8 20 35 10 80       	mov    $0x80103520,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx
80100048:	bb 14 c6 10 80       	mov    $0x8010c614,%ebx
8010004d:	83 ec 0c             	sub    $0xc,%esp
80100050:	68 00 79 10 80       	push   $0x80107900
80100055:	68 e0 c5 10 80       	push   $0x8010c5e0
8010005a:	e8 f1 49 00 00       	call   80104a50 <initlock>
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 dc 0c 11 80       	mov    $0x80110cdc,%eax
80100067:	c7 05 2c 0d 11 80 dc 	movl   $0x80110cdc,0x80110d2c
8010006e:	0c 11 80 
80100071:	c7 05 30 0d 11 80 dc 	movl   $0x80110cdc,0x80110d30
80100078:	0c 11 80 
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
80100092:	68 07 79 10 80       	push   $0x80107907
80100097:	50                   	push   %eax
80100098:	e8 73 48 00 00       	call   80104910 <initsleeplock>
8010009d:	a1 30 0d 11 80       	mov    0x80110d30,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
801000b6:	81 fb 80 0a 11 80    	cmp    $0x80110a80,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801000e3:	68 e0 c5 10 80       	push   $0x8010c5e0
801000e8:	e8 e3 4a 00 00       	call   80104bd0 <acquire>
801000ed:	8b 1d 30 0d 11 80    	mov    0x80110d30,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
80100120:	8b 1d 2c 0d 11 80    	mov    0x80110d2c,%ebx
80100126:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb dc 0c 11 80    	cmp    $0x80110cdc,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 e0 c5 10 80       	push   $0x8010c5e0
80100162:	e8 29 4b 00 00       	call   80104c90 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 47 00 00       	call   80104950 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 cf 25 00 00       	call   80102760 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 0e 79 10 80       	push   $0x8010790e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 29 48 00 00       	call   801049f0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
801001d8:	e9 83 25 00 00       	jmp    80102760 <iderw>
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 1f 79 10 80       	push   $0x8010791f
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 e8 47 00 00       	call   801049f0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 98 47 00 00       	call   801049b0 <releasesleep>
80100218:	c7 04 24 e0 c5 10 80 	movl   $0x8010c5e0,(%esp)
8010021f:	e8 ac 49 00 00       	call   80104bd0 <acquire>
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100227:	83 c4 10             	add    $0x10,%esp
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
80100246:	a1 30 0d 11 80       	mov    0x80110d30,%eax
8010024b:	c7 43 50 dc 0c 11 80 	movl   $0x80110cdc,0x50(%ebx)
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
80100255:	a1 30 0d 11 80       	mov    0x80110d30,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
8010025d:	89 1d 30 0d 11 80    	mov    %ebx,0x80110d30
80100263:	c7 45 08 e0 c5 10 80 	movl   $0x8010c5e0,0x8(%ebp)
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
80100270:	e9 1b 4a 00 00       	jmp    80104c90 <release>
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 26 79 10 80       	push   $0x80107926
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
8010029d:	ff 75 08             	pushl  0x8(%ebp)
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
801002a3:	89 de                	mov    %ebx,%esi
801002a5:	e8 56 1a 00 00       	call   80101d00 <iunlock>
801002aa:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
801002b1:	e8 1a 49 00 00       	call   80104bd0 <acquire>
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
801002b9:	83 c4 10             	add    $0x10,%esp
801002bc:	01 df                	add    %ebx,%edi
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
801002c6:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
801002cb:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 40 b5 10 80       	push   $0x8010b540
801002e0:	68 c0 0f 11 80       	push   $0x80110fc0
801002e5:	e8 26 41 00 00       	call   80104410 <sleep>
801002ea:	a1 c0 0f 11 80       	mov    0x80110fc0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
801002fa:	e8 41 3b 00 00       	call   80103e40 <myproc>
801002ff:	8b 48 28             	mov    0x28(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 b5 10 80       	push   $0x8010b540
8010030e:	e8 7d 49 00 00       	call   80104c90 <release>
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 04 19 00 00       	call   80101c20 <ilock>
8010031c:	83 c4 10             	add    $0x10,%esp
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 c0 0f 11 80    	mov    %edx,0x80110fc0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 40 0f 11 80 	movsbl -0x7feef0c0(%edx),%ecx
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
8010034a:	89 d8                	mov    %ebx,%eax
8010034c:	83 eb 01             	sub    $0x1,%ebx
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 40 b5 10 80       	push   $0x8010b540
80100365:	e8 26 49 00 00       	call   80104c90 <release>
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 ad 18 00 00       	call   80101c20 <ilock>
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010037b:	29 d8                	sub    %ebx,%eax
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
80100386:	a3 c0 0f 11 80       	mov    %eax,0x80110fc0
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
8010039c:	fa                   	cli    
8010039d:	c7 05 74 b5 10 80 00 	movl   $0x0,0x8010b574
801003a4:	00 00 00 
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
801003ad:	e8 ce 29 00 00       	call   80102d80 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 2d 79 10 80       	push   $0x8010792d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
801003c9:	c7 04 24 cf 82 10 80 	movl   $0x801082cf,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 8f 46 00 00       	call   80104a70 <getcallerpcs>
801003e1:	83 c4 10             	add    $0x10,%esp
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 41 79 10 80       	push   $0x80107941
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
801003fd:	c7 05 78 b5 10 80 01 	movl   $0x1,0x8010b578
80100404:	00 00 00 
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 c1 60 00 00       	call   801064f0 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
80100447:	0f b6 c0             	movzbl %al,%eax
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
801004a8:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004ad:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004ba:	89 f8                	mov    %edi,%eax
801004bc:	89 ca                	mov    %ecx,%edx
801004be:	ee                   	out    %al,(%dx)
801004bf:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c4:	89 da                	mov    %ebx,%edx
801004c6:	ee                   	out    %al,(%dx)
801004c7:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004cb:	89 ca                	mov    %ecx,%edx
801004cd:	ee                   	out    %al,(%dx)
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004eb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 d6 5f 00 00       	call   801064f0 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 ca 5f 00 00       	call   801064f0 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 be 5f 00 00       	call   801064f0 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100540:	83 ec 04             	sub    $0x4,%esp
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 1a 48 00 00       	call   80104d80 <memmove>
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 65 47 00 00       	call   80104ce0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 45 79 10 80       	push   $0x80107945
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 6d                	js     80100621 <printint+0x81>
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
801005b8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005bb:	31 db                	xor    %ebx,%ebx
801005bd:	8d 7d d7             	lea    -0x29(%ebp),%edi
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	89 ce                	mov    %ecx,%esi
801005c6:	f7 75 d4             	divl   -0x2c(%ebp)
801005c9:	0f b6 92 c8 79 10 80 	movzbl -0x7fef8638(%edx),%edx
801005d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005d3:	89 d8                	mov    %ebx,%eax
801005d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
801005d8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005db:	89 75 d0             	mov    %esi,-0x30(%ebp)
801005de:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
801005e1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005e4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005e7:	73 d7                	jae    801005c0 <printint+0x20>
801005e9:	8b 75 cc             	mov    -0x34(%ebp),%esi
801005ec:	85 f6                	test   %esi,%esi
801005ee:	74 0c                	je     801005fc <printint+0x5c>
801005f0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
801005f5:	89 d8                	mov    %ebx,%eax
801005f7:	ba 2d 00 00 00       	mov    $0x2d,%edx
801005fc:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100600:	0f be c2             	movsbl %dl,%eax
80100603:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 03                	je     80100610 <printint+0x70>
8010060d:	fa                   	cli    
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
80100610:	e8 fb fd ff ff       	call   80100410 <consputc.part.0>
80100615:	39 fb                	cmp    %edi,%ebx
80100617:	74 10                	je     80100629 <printint+0x89>
80100619:	0f be 03             	movsbl (%ebx),%eax
8010061c:	83 eb 01             	sub    $0x1,%ebx
8010061f:	eb e2                	jmp    80100603 <printint+0x63>
80100621:	f7 d8                	neg    %eax
80100623:	89 ce                	mov    %ecx,%esi
80100625:	89 c1                	mov    %eax,%ecx
80100627:	eb 8f                	jmp    801005b8 <printint+0x18>
80100629:	83 c4 2c             	add    $0x2c,%esp
8010062c:	5b                   	pop    %ebx
8010062d:	5e                   	pop    %esi
8010062e:	5f                   	pop    %edi
8010062f:	5d                   	pop    %ebp
80100630:	c3                   	ret    
80100631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100638:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010063f:	90                   	nop

80100640 <consolewrite>:
80100640:	f3 0f 1e fb          	endbr32 
80100644:	55                   	push   %ebp
80100645:	89 e5                	mov    %esp,%ebp
80100647:	57                   	push   %edi
80100648:	56                   	push   %esi
80100649:	53                   	push   %ebx
8010064a:	83 ec 18             	sub    $0x18,%esp
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100653:	e8 a8 16 00 00       	call   80101d00 <iunlock>
80100658:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
8010065f:	e8 6c 45 00 00       	call   80104bd0 <acquire>
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
80100671:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100677:	85 d2                	test   %edx,%edx
80100679:	74 05                	je     80100680 <consolewrite+0x40>
8010067b:	fa                   	cli    
8010067c:	eb fe                	jmp    8010067c <consolewrite+0x3c>
8010067e:	66 90                	xchg   %ax,%ax
80100680:	0f b6 07             	movzbl (%edi),%eax
80100683:	83 c7 01             	add    $0x1,%edi
80100686:	e8 85 fd ff ff       	call   80100410 <consputc.part.0>
8010068b:	39 fe                	cmp    %edi,%esi
8010068d:	75 e2                	jne    80100671 <consolewrite+0x31>
8010068f:	83 ec 0c             	sub    $0xc,%esp
80100692:	68 40 b5 10 80       	push   $0x8010b540
80100697:	e8 f4 45 00 00       	call   80104c90 <release>
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 7b 15 00 00       	call   80101c20 <ilock>
801006a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a8:	89 d8                	mov    %ebx,%eax
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop

801006b0 <cprintf>:
801006b0:	f3 0f 1e fb          	endbr32 
801006b4:	55                   	push   %ebp
801006b5:	89 e5                	mov    %esp,%ebp
801006b7:	57                   	push   %edi
801006b8:	56                   	push   %esi
801006b9:	53                   	push   %ebx
801006ba:	83 ec 1c             	sub    $0x1c,%esp
801006bd:	a1 74 b5 10 80       	mov    0x8010b574,%eax
801006c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006c5:	85 c0                	test   %eax,%eax
801006c7:	0f 85 e8 00 00 00    	jne    801007b5 <cprintf+0x105>
801006cd:	8b 45 08             	mov    0x8(%ebp),%eax
801006d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d3:	85 c0                	test   %eax,%eax
801006d5:	0f 84 5a 01 00 00    	je     80100835 <cprintf+0x185>
801006db:	0f b6 00             	movzbl (%eax),%eax
801006de:	85 c0                	test   %eax,%eax
801006e0:	74 36                	je     80100718 <cprintf+0x68>
801006e2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
801006e5:	31 f6                	xor    %esi,%esi
801006e7:	83 f8 25             	cmp    $0x25,%eax
801006ea:	74 44                	je     80100730 <cprintf+0x80>
801006ec:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801006f2:	85 c9                	test   %ecx,%ecx
801006f4:	74 0f                	je     80100705 <cprintf+0x55>
801006f6:	fa                   	cli    
801006f7:	eb fe                	jmp    801006f7 <cprintf+0x47>
801006f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100700:	b8 25 00 00 00       	mov    $0x25,%eax
80100705:	e8 06 fd ff ff       	call   80100410 <consputc.part.0>
8010070a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010070d:	83 c6 01             	add    $0x1,%esi
80100710:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100714:	85 c0                	test   %eax,%eax
80100716:	75 cf                	jne    801006e7 <cprintf+0x37>
80100718:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071b:	85 c0                	test   %eax,%eax
8010071d:	0f 85 fd 00 00 00    	jne    80100820 <cprintf+0x170>
80100723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100726:	5b                   	pop    %ebx
80100727:	5e                   	pop    %esi
80100728:	5f                   	pop    %edi
80100729:	5d                   	pop    %ebp
8010072a:	c3                   	ret    
8010072b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010072f:	90                   	nop
80100730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100733:	83 c6 01             	add    $0x1,%esi
80100736:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
8010073a:	85 ff                	test   %edi,%edi
8010073c:	74 da                	je     80100718 <cprintf+0x68>
8010073e:	83 ff 70             	cmp    $0x70,%edi
80100741:	74 5a                	je     8010079d <cprintf+0xed>
80100743:	7f 2a                	jg     8010076f <cprintf+0xbf>
80100745:	83 ff 25             	cmp    $0x25,%edi
80100748:	0f 84 92 00 00 00    	je     801007e0 <cprintf+0x130>
8010074e:	83 ff 64             	cmp    $0x64,%edi
80100751:	0f 85 a1 00 00 00    	jne    801007f8 <cprintf+0x148>
80100757:	8b 03                	mov    (%ebx),%eax
80100759:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100761:	ba 0a 00 00 00       	mov    $0xa,%edx
80100766:	89 fb                	mov    %edi,%ebx
80100768:	e8 33 fe ff ff       	call   801005a0 <printint>
8010076d:	eb 9b                	jmp    8010070a <cprintf+0x5a>
8010076f:	83 ff 73             	cmp    $0x73,%edi
80100772:	75 24                	jne    80100798 <cprintf+0xe8>
80100774:	8d 7b 04             	lea    0x4(%ebx),%edi
80100777:	8b 1b                	mov    (%ebx),%ebx
80100779:	85 db                	test   %ebx,%ebx
8010077b:	75 55                	jne    801007d2 <cprintf+0x122>
8010077d:	bb 58 79 10 80       	mov    $0x80107958,%ebx
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
80100787:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
8010078d:	85 d2                	test   %edx,%edx
8010078f:	74 39                	je     801007ca <cprintf+0x11a>
80100791:	fa                   	cli    
80100792:	eb fe                	jmp    80100792 <cprintf+0xe2>
80100794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100798:	83 ff 78             	cmp    $0x78,%edi
8010079b:	75 5b                	jne    801007f8 <cprintf+0x148>
8010079d:	8b 03                	mov    (%ebx),%eax
8010079f:	8d 7b 04             	lea    0x4(%ebx),%edi
801007a2:	31 c9                	xor    %ecx,%ecx
801007a4:	ba 10 00 00 00       	mov    $0x10,%edx
801007a9:	89 fb                	mov    %edi,%ebx
801007ab:	e8 f0 fd ff ff       	call   801005a0 <printint>
801007b0:	e9 55 ff ff ff       	jmp    8010070a <cprintf+0x5a>
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 40 b5 10 80       	push   $0x8010b540
801007bd:	e8 0e 44 00 00       	call   80104bd0 <acquire>
801007c2:	83 c4 10             	add    $0x10,%esp
801007c5:	e9 03 ff ff ff       	jmp    801006cd <cprintf+0x1d>
801007ca:	e8 41 fc ff ff       	call   80100410 <consputc.part.0>
801007cf:	83 c3 01             	add    $0x1,%ebx
801007d2:	0f be 03             	movsbl (%ebx),%eax
801007d5:	84 c0                	test   %al,%al
801007d7:	75 ae                	jne    80100787 <cprintf+0xd7>
801007d9:	89 fb                	mov    %edi,%ebx
801007db:	e9 2a ff ff ff       	jmp    8010070a <cprintf+0x5a>
801007e0:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801007f8:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
80100812:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 40 b5 10 80       	push   $0x8010b540
80100828:	e8 63 44 00 00       	call   80104c90 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 5f 79 10 80       	push   $0x8010795f
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 b6 fe ff ff       	jmp    8010070a <cprintf+0x5a>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <get_cursor_pos>:
80100860:	f3 0f 1e fb          	endbr32 
80100864:	55                   	push   %ebp
80100865:	b8 0e 00 00 00       	mov    $0xe,%eax
8010086a:	89 e5                	mov    %esp,%ebp
8010086c:	56                   	push   %esi
8010086d:	be d4 03 00 00       	mov    $0x3d4,%esi
80100872:	53                   	push   %ebx
80100873:	89 f2                	mov    %esi,%edx
80100875:	ee                   	out    %al,(%dx)
80100876:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010087b:	89 ca                	mov    %ecx,%edx
8010087d:	ec                   	in     (%dx),%al
8010087e:	0f b6 c0             	movzbl %al,%eax
80100881:	89 f2                	mov    %esi,%edx
80100883:	c1 e0 08             	shl    $0x8,%eax
80100886:	89 c3                	mov    %eax,%ebx
80100888:	b8 0f 00 00 00       	mov    $0xf,%eax
8010088d:	ee                   	out    %al,(%dx)
8010088e:	89 ca                	mov    %ecx,%edx
80100890:	ec                   	in     (%dx),%al
80100891:	0f b6 c0             	movzbl %al,%eax
80100894:	09 d8                	or     %ebx,%eax
80100896:	5b                   	pop    %ebx
80100897:	5e                   	pop    %esi
80100898:	5d                   	pop    %ebp
80100899:	c3                   	ret    
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008a0 <swap_last_two_elements>:
801008a0:	f3 0f 1e fb          	endbr32 
801008a4:	55                   	push   %ebp
801008a5:	b8 0e 00 00 00       	mov    $0xe,%eax
801008aa:	89 e5                	mov    %esp,%ebp
801008ac:	57                   	push   %edi
801008ad:	56                   	push   %esi
801008ae:	be d4 03 00 00       	mov    $0x3d4,%esi
801008b3:	53                   	push   %ebx
801008b4:	89 f2                	mov    %esi,%edx
801008b6:	ee                   	out    %al,(%dx)
801008b7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801008bc:	89 da                	mov    %ebx,%edx
801008be:	ec                   	in     (%dx),%al
801008bf:	0f b6 c8             	movzbl %al,%ecx
801008c2:	89 f2                	mov    %esi,%edx
801008c4:	b8 0f 00 00 00       	mov    $0xf,%eax
801008c9:	c1 e1 08             	shl    $0x8,%ecx
801008cc:	ee                   	out    %al,(%dx)
801008cd:	89 da                	mov    %ebx,%edx
801008cf:	ec                   	in     (%dx),%al
801008d0:	0f b6 c0             	movzbl %al,%eax
801008d3:	09 c1                	or     %eax,%ecx
801008d5:	8d 44 09 fa          	lea    -0x6(%ecx,%ecx,1),%eax
801008d9:	66 81 b8 00 80 0b 80 	cmpw   $0x724,-0x7ff48000(%eax)
801008e0:	24 07 
801008e2:	74 42                	je     80100926 <swap_last_two_elements+0x86>
801008e4:	0f b7 90 02 80 0b 80 	movzwl -0x7ff47ffe(%eax),%edx
801008eb:	66 81 fa 24 07       	cmp    $0x724,%dx
801008f0:	74 34                	je     80100926 <swap_last_two_elements+0x86>
801008f2:	0f b7 b8 04 80 0b 80 	movzwl -0x7ff47ffc(%eax),%edi
801008f9:	66 89 90 04 80 0b 80 	mov    %dx,-0x7ff47ffc(%eax)
80100900:	89 f2                	mov    %esi,%edx
80100902:	66 89 b8 02 80 0b 80 	mov    %di,-0x7ff47ffe(%eax)
80100909:	b8 0e 00 00 00       	mov    $0xe,%eax
8010090e:	ee                   	out    %al,(%dx)
8010090f:	89 cf                	mov    %ecx,%edi
80100911:	89 da                	mov    %ebx,%edx
80100913:	c1 ff 08             	sar    $0x8,%edi
80100916:	89 f8                	mov    %edi,%eax
80100918:	ee                   	out    %al,(%dx)
80100919:	b8 0f 00 00 00       	mov    $0xf,%eax
8010091e:	89 f2                	mov    %esi,%edx
80100920:	ee                   	out    %al,(%dx)
80100921:	89 c8                	mov    %ecx,%eax
80100923:	89 da                	mov    %ebx,%edx
80100925:	ee                   	out    %al,(%dx)
80100926:	5b                   	pop    %ebx
80100927:	5e                   	pop    %esi
80100928:	5f                   	pop    %edi
80100929:	5d                   	pop    %ebp
8010092a:	c3                   	ret    
8010092b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010092f:	90                   	nop

80100930 <upper_case>:
80100930:	f3 0f 1e fb          	endbr32 
80100934:	55                   	push   %ebp
80100935:	b8 0e 00 00 00       	mov    $0xe,%eax
8010093a:	89 e5                	mov    %esp,%ebp
8010093c:	57                   	push   %edi
8010093d:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100942:	56                   	push   %esi
80100943:	89 fa                	mov    %edi,%edx
80100945:	53                   	push   %ebx
80100946:	ee                   	out    %al,(%dx)
80100947:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010094c:	89 da                	mov    %ebx,%edx
8010094e:	ec                   	in     (%dx),%al
8010094f:	0f b6 c8             	movzbl %al,%ecx
80100952:	89 fa                	mov    %edi,%edx
80100954:	b8 0f 00 00 00       	mov    $0xf,%eax
80100959:	c1 e1 08             	shl    $0x8,%ecx
8010095c:	89 ce                	mov    %ecx,%esi
8010095e:	ee                   	out    %al,(%dx)
8010095f:	89 da                	mov    %ebx,%edx
80100961:	ec                   	in     (%dx),%al
80100962:	0f b6 c8             	movzbl %al,%ecx
80100965:	09 f1                	or     %esi,%ecx
80100967:	8d 54 09 02          	lea    0x2(%ecx,%ecx,1),%edx
8010096b:	0f b7 82 00 80 0b 80 	movzwl -0x7ff48000(%edx),%eax
80100972:	66 3d 20 07          	cmp    $0x720,%ax
80100976:	74 3b                	je     801009b3 <upper_case+0x83>
80100978:	66 3d 0a 07          	cmp    $0x70a,%ax
8010097c:	74 35                	je     801009b3 <upper_case+0x83>
8010097e:	8d b2 00 80 0b 80    	lea    -0x7ff48000(%edx),%esi
80100984:	29 f2                	sub    %esi,%edx
80100986:	8d 9a 02 80 0b 80    	lea    -0x7ff47ffe(%edx),%ebx
8010098c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100990:	8d 90 9f f8 ff ff    	lea    -0x761(%eax),%edx
80100996:	66 83 fa 19          	cmp    $0x19,%dx
8010099a:	77 06                	ja     801009a2 <upper_case+0x72>
8010099c:	83 e8 20             	sub    $0x20,%eax
8010099f:	66 89 06             	mov    %ax,(%esi)
801009a2:	01 de                	add    %ebx,%esi
801009a4:	0f b7 06             	movzwl (%esi),%eax
801009a7:	66 3d 20 07          	cmp    $0x720,%ax
801009ab:	74 06                	je     801009b3 <upper_case+0x83>
801009ad:	66 3d 0a 07          	cmp    $0x70a,%ax
801009b1:	75 dd                	jne    80100990 <upper_case+0x60>
801009b3:	be d4 03 00 00       	mov    $0x3d4,%esi
801009b8:	b8 0e 00 00 00       	mov    $0xe,%eax
801009bd:	89 f2                	mov    %esi,%edx
801009bf:	ee                   	out    %al,(%dx)
801009c0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801009c5:	89 c8                	mov    %ecx,%eax
801009c7:	c1 f8 08             	sar    $0x8,%eax
801009ca:	89 da                	mov    %ebx,%edx
801009cc:	ee                   	out    %al,(%dx)
801009cd:	b8 0f 00 00 00       	mov    $0xf,%eax
801009d2:	89 f2                	mov    %esi,%edx
801009d4:	ee                   	out    %al,(%dx)
801009d5:	89 c8                	mov    %ecx,%eax
801009d7:	89 da                	mov    %ebx,%edx
801009d9:	ee                   	out    %al,(%dx)
801009da:	5b                   	pop    %ebx
801009db:	5e                   	pop    %esi
801009dc:	5f                   	pop    %edi
801009dd:	5d                   	pop    %ebp
801009de:	c3                   	ret    
801009df:	90                   	nop

801009e0 <move_left>:
801009e0:	f3 0f 1e fb          	endbr32 
801009e4:	55                   	push   %ebp
801009e5:	b8 0e 00 00 00       	mov    $0xe,%eax
801009ea:	89 e5                	mov    %esp,%ebp
801009ec:	57                   	push   %edi
801009ed:	56                   	push   %esi
801009ee:	be d4 03 00 00       	mov    $0x3d4,%esi
801009f3:	53                   	push   %ebx
801009f4:	89 f2                	mov    %esi,%edx
801009f6:	ee                   	out    %al,(%dx)
801009f7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801009fc:	89 da                	mov    %ebx,%edx
801009fe:	ec                   	in     (%dx),%al
801009ff:	bf 0f 00 00 00       	mov    $0xf,%edi
80100a04:	0f b6 c8             	movzbl %al,%ecx
80100a07:	89 f2                	mov    %esi,%edx
80100a09:	c1 e1 08             	shl    $0x8,%ecx
80100a0c:	89 f8                	mov    %edi,%eax
80100a0e:	ee                   	out    %al,(%dx)
80100a0f:	89 da                	mov    %ebx,%edx
80100a11:	ec                   	in     (%dx),%al
80100a12:	0f b6 c0             	movzbl %al,%eax
80100a15:	89 f2                	mov    %esi,%edx
80100a17:	09 c1                	or     %eax,%ecx
80100a19:	89 f8                	mov    %edi,%eax
80100a1b:	83 e9 01             	sub    $0x1,%ecx
80100a1e:	ee                   	out    %al,(%dx)
80100a1f:	89 c8                	mov    %ecx,%eax
80100a21:	89 da                	mov    %ebx,%edx
80100a23:	ee                   	out    %al,(%dx)
80100a24:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a29:	89 f2                	mov    %esi,%edx
80100a2b:	ee                   	out    %al,(%dx)
80100a2c:	89 c8                	mov    %ecx,%eax
80100a2e:	89 da                	mov    %ebx,%edx
80100a30:	c1 f8 08             	sar    $0x8,%eax
80100a33:	ee                   	out    %al,(%dx)
80100a34:	5b                   	pop    %ebx
80100a35:	5e                   	pop    %esi
80100a36:	5f                   	pop    %edi
80100a37:	5d                   	pop    %ebp
80100a38:	c3                   	ret    
80100a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100a40 <move_right>:
80100a40:	f3 0f 1e fb          	endbr32 
80100a44:	55                   	push   %ebp
80100a45:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a4a:	89 e5                	mov    %esp,%ebp
80100a4c:	57                   	push   %edi
80100a4d:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100a52:	56                   	push   %esi
80100a53:	89 fa                	mov    %edi,%edx
80100a55:	53                   	push   %ebx
80100a56:	ee                   	out    %al,(%dx)
80100a57:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a5c:	89 da                	mov    %ebx,%edx
80100a5e:	ec                   	in     (%dx),%al
80100a5f:	0f b6 c8             	movzbl %al,%ecx
80100a62:	89 fa                	mov    %edi,%edx
80100a64:	b8 0f 00 00 00       	mov    $0xf,%eax
80100a69:	89 ce                	mov    %ecx,%esi
80100a6b:	c1 e6 08             	shl    $0x8,%esi
80100a6e:	ee                   	out    %al,(%dx)
80100a6f:	89 da                	mov    %ebx,%edx
80100a71:	ec                   	in     (%dx),%al
80100a72:	0f b6 c8             	movzbl %al,%ecx
80100a75:	09 f1                	or     %esi,%ecx
80100a77:	66 81 bc 09 00 80 0b 	cmpw   $0x70a,-0x7ff48000(%ecx,%ecx,1)
80100a7e:	80 0a 07 
80100a81:	74 03                	je     80100a86 <move_right+0x46>
80100a83:	83 c1 01             	add    $0x1,%ecx
80100a86:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a8b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a90:	89 f2                	mov    %esi,%edx
80100a92:	ee                   	out    %al,(%dx)
80100a93:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a98:	89 c8                	mov    %ecx,%eax
80100a9a:	c1 f8 08             	sar    $0x8,%eax
80100a9d:	89 da                	mov    %ebx,%edx
80100a9f:	ee                   	out    %al,(%dx)
80100aa0:	b8 0f 00 00 00       	mov    $0xf,%eax
80100aa5:	89 f2                	mov    %esi,%edx
80100aa7:	ee                   	out    %al,(%dx)
80100aa8:	89 c8                	mov    %ecx,%eax
80100aaa:	89 da                	mov    %ebx,%edx
80100aac:	ee                   	out    %al,(%dx)
80100aad:	5b                   	pop    %ebx
80100aae:	5e                   	pop    %esi
80100aaf:	5f                   	pop    %edi
80100ab0:	5d                   	pop    %ebp
80100ab1:	c3                   	ret    
80100ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ac0 <insert_at_the_given_pos>:
80100ac0:	f3 0f 1e fb          	endbr32 
80100ac4:	55                   	push   %ebp
80100ac5:	b8 0e 00 00 00       	mov    $0xe,%eax
80100aca:	89 e5                	mov    %esp,%ebp
80100acc:	57                   	push   %edi
80100acd:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100ad2:	56                   	push   %esi
80100ad3:	89 fa                	mov    %edi,%edx
80100ad5:	53                   	push   %ebx
80100ad6:	ee                   	out    %al,(%dx)
80100ad7:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100adc:	89 ca                	mov    %ecx,%edx
80100ade:	ec                   	in     (%dx),%al
80100adf:	0f b6 d8             	movzbl %al,%ebx
80100ae2:	89 fa                	mov    %edi,%edx
80100ae4:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ae9:	89 de                	mov    %ebx,%esi
80100aeb:	c1 e6 08             	shl    $0x8,%esi
80100aee:	ee                   	out    %al,(%dx)
80100aef:	89 ca                	mov    %ecx,%edx
80100af1:	ec                   	in     (%dx),%al
80100af2:	0f b6 d8             	movzbl %al,%ebx
80100af5:	8b 45 0c             	mov    0xc(%ebp),%eax
80100af8:	09 f3                	or     %esi,%ebx
80100afa:	01 d8                	add    %ebx,%eax
80100afc:	39 d8                	cmp    %ebx,%eax
80100afe:	7c 1e                	jl     80100b1e <insert_at_the_given_pos+0x5e>
80100b00:	8d 94 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%edx
80100b07:	8d 84 1b fe 7f 0b 80 	lea    -0x7ff48002(%ebx,%ebx,1),%eax
80100b0e:	66 90                	xchg   %ax,%ax
80100b10:	0f b7 0a             	movzwl (%edx),%ecx
80100b13:	83 ea 02             	sub    $0x2,%edx
80100b16:	66 89 4a 04          	mov    %cx,0x4(%edx)
80100b1a:	39 d0                	cmp    %edx,%eax
80100b1c:	75 f2                	jne    80100b10 <insert_at_the_given_pos+0x50>
80100b1e:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80100b22:	8d 4b 01             	lea    0x1(%ebx),%ecx
80100b25:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b2a:	89 fa                	mov    %edi,%edx
80100b2c:	80 cc 07             	or     $0x7,%ah
80100b2f:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100b36:	80 
80100b37:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b3c:	ee                   	out    %al,(%dx)
80100b3d:	be d5 03 00 00       	mov    $0x3d5,%esi
80100b42:	89 c8                	mov    %ecx,%eax
80100b44:	c1 f8 08             	sar    $0x8,%eax
80100b47:	89 f2                	mov    %esi,%edx
80100b49:	ee                   	out    %al,(%dx)
80100b4a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b4f:	89 fa                	mov    %edi,%edx
80100b51:	ee                   	out    %al,(%dx)
80100b52:	8d 43 01             	lea    0x1(%ebx),%eax
80100b55:	89 f2                	mov    %esi,%edx
80100b57:	ee                   	out    %al,(%dx)
80100b58:	5b                   	pop    %ebx
80100b59:	5e                   	pop    %esi
80100b5a:	5f                   	pop    %edi
80100b5b:	5d                   	pop    %ebp
80100b5c:	c3                   	ret    
80100b5d:	8d 76 00             	lea    0x0(%esi),%esi

80100b60 <consoleintr>:
80100b60:	f3 0f 1e fb          	endbr32 
80100b64:	55                   	push   %ebp
80100b65:	89 e5                	mov    %esp,%ebp
80100b67:	57                   	push   %edi
80100b68:	56                   	push   %esi
80100b69:	53                   	push   %ebx
80100b6a:	31 db                	xor    %ebx,%ebx
80100b6c:	83 ec 28             	sub    $0x28,%esp
80100b6f:	8b 45 08             	mov    0x8(%ebp),%eax
80100b72:	68 40 b5 10 80       	push   $0x8010b540
80100b77:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100b7a:	e8 51 40 00 00       	call   80104bd0 <acquire>
80100b7f:	83 c4 10             	add    $0x10,%esp
80100b82:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b85:	ff d0                	call   *%eax
80100b87:	85 c0                	test   %eax,%eax
80100b89:	78 2c                	js     80100bb7 <consoleintr+0x57>
80100b8b:	83 f8 15             	cmp    $0x15,%eax
80100b8e:	0f 8f ca 01 00 00    	jg     80100d5e <consoleintr+0x1fe>
80100b94:	85 c0                	test   %eax,%eax
80100b96:	74 ea                	je     80100b82 <consoleintr+0x22>
80100b98:	83 f8 15             	cmp    $0x15,%eax
80100b9b:	0f 87 29 02 00 00    	ja     80100dca <consoleintr+0x26a>
80100ba1:	3e ff 24 85 70 79 10 	notrack jmp *-0x7fef8690(,%eax,4)
80100ba8:	80 
80100ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100bac:	bb 01 00 00 00       	mov    $0x1,%ebx
80100bb1:	ff d0                	call   *%eax
80100bb3:	85 c0                	test   %eax,%eax
80100bb5:	79 d4                	jns    80100b8b <consoleintr+0x2b>
80100bb7:	83 ec 0c             	sub    $0xc,%esp
80100bba:	68 40 b5 10 80       	push   $0x8010b540
80100bbf:	e8 cc 40 00 00       	call   80104c90 <release>
80100bc4:	83 c4 10             	add    $0x10,%esp
80100bc7:	85 db                	test   %ebx,%ebx
80100bc9:	0f 85 0f 03 00 00    	jne    80100ede <consoleintr+0x37e>
80100bcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bd2:	5b                   	pop    %ebx
80100bd3:	5e                   	pop    %esi
80100bd4:	5f                   	pop    %edi
80100bd5:	5d                   	pop    %ebp
80100bd6:	c3                   	ret    
80100bd7:	b8 00 01 00 00       	mov    $0x100,%eax
80100bdc:	e8 2f f8 ff ff       	call   80100410 <consputc.part.0>
80100be1:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100be6:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
80100bec:	74 94                	je     80100b82 <consoleintr+0x22>
80100bee:	83 e8 01             	sub    $0x1,%eax
80100bf1:	89 c2                	mov    %eax,%edx
80100bf3:	83 e2 7f             	and    $0x7f,%edx
80100bf6:	80 ba 40 0f 11 80 0a 	cmpb   $0xa,-0x7feef0c0(%edx)
80100bfd:	74 83                	je     80100b82 <consoleintr+0x22>
80100bff:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
80100c05:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
80100c0a:	85 ff                	test   %edi,%edi
80100c0c:	74 c9                	je     80100bd7 <consoleintr+0x77>
80100c0e:	fa                   	cli    
80100c0f:	eb fe                	jmp    80100c0f <consoleintr+0xaf>
80100c11:	e8 8a fc ff ff       	call   801008a0 <swap_last_two_elements>
80100c16:	e9 67 ff ff ff       	jmp    80100b82 <consoleintr+0x22>
80100c1b:	e8 10 fd ff ff       	call   80100930 <upper_case>
80100c20:	e9 5d ff ff ff       	jmp    80100b82 <consoleintr+0x22>
80100c25:	83 f8 7f             	cmp    $0x7f,%eax
80100c28:	0f 85 a4 01 00 00    	jne    80100dd2 <consoleintr+0x272>
80100c2e:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100c33:	3b 05 c4 0f 11 80    	cmp    0x80110fc4,%eax
80100c39:	0f 84 43 ff ff ff    	je     80100b82 <consoleintr+0x22>
80100c3f:	8b 35 78 b5 10 80    	mov    0x8010b578,%esi
80100c45:	83 e8 01             	sub    $0x1,%eax
80100c48:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
80100c4d:	85 f6                	test   %esi,%esi
80100c4f:	0f 84 fc 01 00 00    	je     80100e51 <consoleintr+0x2f1>
80100c55:	fa                   	cli    
80100c56:	eb fe                	jmp    80100c56 <consoleintr+0xf6>
80100c58:	a1 c4 0f 11 80       	mov    0x80110fc4,%eax
80100c5d:	8b 3d 20 b5 10 80    	mov    0x8010b520,%edi
80100c63:	31 c9                	xor    %ecx,%ecx
80100c65:	8b 35 c8 0f 11 80    	mov    0x80110fc8,%esi
80100c6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100c6e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100c71:	39 f0                	cmp    %esi,%eax
80100c73:	0f 84 8a 00 00 00    	je     80100d03 <consoleintr+0x1a3>
80100c79:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100c7c:	eb 63                	jmp    80100ce1 <consoleintr+0x181>
80100c7e:	83 c7 01             	add    $0x1,%edi
80100c81:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c86:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100c8b:	ee                   	out    %al,(%dx)
80100c8c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100c91:	89 da                	mov    %ebx,%edx
80100c93:	ec                   	in     (%dx),%al
80100c94:	0f b6 c8             	movzbl %al,%ecx
80100c97:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100c9c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ca1:	c1 e1 08             	shl    $0x8,%ecx
80100ca4:	ee                   	out    %al,(%dx)
80100ca5:	89 da                	mov    %ebx,%edx
80100ca7:	ec                   	in     (%dx),%al
80100ca8:	0f b6 c0             	movzbl %al,%eax
80100cab:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100cb0:	09 c1                	or     %eax,%ecx
80100cb2:	b8 0f 00 00 00       	mov    $0xf,%eax
80100cb7:	83 e9 01             	sub    $0x1,%ecx
80100cba:	ee                   	out    %al,(%dx)
80100cbb:	89 c8                	mov    %ecx,%eax
80100cbd:	89 da                	mov    %ebx,%edx
80100cbf:	ee                   	out    %al,(%dx)
80100cc0:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cc5:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100cca:	ee                   	out    %al,(%dx)
80100ccb:	89 c8                	mov    %ecx,%eax
80100ccd:	89 da                	mov    %ebx,%edx
80100ccf:	c1 f8 08             	sar    $0x8,%eax
80100cd2:	ee                   	out    %al,(%dx)
80100cd3:	b9 01 00 00 00       	mov    $0x1,%ecx
80100cd8:	3b 75 dc             	cmp    -0x24(%ebp),%esi
80100cdb:	0f 84 5f 01 00 00    	je     80100e40 <consoleintr+0x2e0>
80100ce1:	89 f0                	mov    %esi,%eax
80100ce3:	83 ee 01             	sub    $0x1,%esi
80100ce6:	89 f2                	mov    %esi,%edx
80100ce8:	83 e2 7f             	and    $0x7f,%edx
80100ceb:	80 ba 40 0f 11 80 0a 	cmpb   $0xa,-0x7feef0c0(%edx)
80100cf2:	75 8a                	jne    80100c7e <consoleintr+0x11e>
80100cf4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100cf7:	84 c9                	test   %cl,%cl
80100cf9:	74 08                	je     80100d03 <consoleintr+0x1a3>
80100cfb:	a3 c8 0f 11 80       	mov    %eax,0x80110fc8
80100d00:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100d03:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d08:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d0d:	89 fa                	mov    %edi,%edx
80100d0f:	ee                   	out    %al,(%dx)
80100d10:	be d5 03 00 00       	mov    $0x3d5,%esi
80100d15:	89 f2                	mov    %esi,%edx
80100d17:	ec                   	in     (%dx),%al
80100d18:	0f b6 c8             	movzbl %al,%ecx
80100d1b:	89 fa                	mov    %edi,%edx
80100d1d:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d22:	c1 e1 08             	shl    $0x8,%ecx
80100d25:	ee                   	out    %al,(%dx)
80100d26:	89 f2                	mov    %esi,%edx
80100d28:	ec                   	in     (%dx),%al
80100d29:	0f b6 c0             	movzbl %al,%eax
80100d2c:	89 fa                	mov    %edi,%edx
80100d2e:	09 c1                	or     %eax,%ecx
80100d30:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d35:	83 e9 01             	sub    $0x1,%ecx
80100d38:	ee                   	out    %al,(%dx)
80100d39:	89 c8                	mov    %ecx,%eax
80100d3b:	89 f2                	mov    %esi,%edx
80100d3d:	ee                   	out    %al,(%dx)
80100d3e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d43:	89 fa                	mov    %edi,%edx
80100d45:	ee                   	out    %al,(%dx)
80100d46:	89 c8                	mov    %ecx,%eax
80100d48:	89 f2                	mov    %esi,%edx
80100d4a:	c1 f8 08             	sar    $0x8,%eax
80100d4d:	ee                   	out    %al,(%dx)
80100d4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d51:	83 c0 01             	add    $0x1,%eax
80100d54:	a3 20 b5 10 80       	mov    %eax,0x8010b520
80100d59:	e9 24 fe ff ff       	jmp    80100b82 <consoleintr+0x22>
80100d5e:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100d63:	74 15                	je     80100d7a <consoleintr+0x21a>
80100d65:	3d e5 00 00 00       	cmp    $0xe5,%eax
80100d6a:	0f 85 b5 fe ff ff    	jne    80100c25 <consoleintr+0xc5>
80100d70:	e8 cb fc ff ff       	call   80100a40 <move_right>
80100d75:	e9 08 fe ff ff       	jmp    80100b82 <consoleintr+0x22>
80100d7a:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d7f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d84:	89 fa                	mov    %edi,%edx
80100d86:	ee                   	out    %al,(%dx)
80100d87:	be d5 03 00 00       	mov    $0x3d5,%esi
80100d8c:	89 f2                	mov    %esi,%edx
80100d8e:	ec                   	in     (%dx),%al
80100d8f:	0f b6 c8             	movzbl %al,%ecx
80100d92:	89 fa                	mov    %edi,%edx
80100d94:	b8 0f 00 00 00       	mov    $0xf,%eax
80100d99:	c1 e1 08             	shl    $0x8,%ecx
80100d9c:	ee                   	out    %al,(%dx)
80100d9d:	89 f2                	mov    %esi,%edx
80100d9f:	ec                   	in     (%dx),%al
80100da0:	0f b6 c0             	movzbl %al,%eax
80100da3:	89 fa                	mov    %edi,%edx
80100da5:	09 c1                	or     %eax,%ecx
80100da7:	b8 0f 00 00 00       	mov    $0xf,%eax
80100dac:	83 e9 01             	sub    $0x1,%ecx
80100daf:	ee                   	out    %al,(%dx)
80100db0:	89 c8                	mov    %ecx,%eax
80100db2:	89 f2                	mov    %esi,%edx
80100db4:	ee                   	out    %al,(%dx)
80100db5:	b8 0e 00 00 00       	mov    $0xe,%eax
80100dba:	89 fa                	mov    %edi,%edx
80100dbc:	ee                   	out    %al,(%dx)
80100dbd:	89 c8                	mov    %ecx,%eax
80100dbf:	89 f2                	mov    %esi,%edx
80100dc1:	c1 f8 08             	sar    $0x8,%eax
80100dc4:	ee                   	out    %al,(%dx)
80100dc5:	e9 b8 fd ff ff       	jmp    80100b82 <consoleintr+0x22>
80100dca:	85 c0                	test   %eax,%eax
80100dcc:	0f 84 b0 fd ff ff    	je     80100b82 <consoleintr+0x22>
80100dd2:	8b 15 c8 0f 11 80    	mov    0x80110fc8,%edx
80100dd8:	8b 0d c0 0f 11 80    	mov    0x80110fc0,%ecx
80100dde:	89 d6                	mov    %edx,%esi
80100de0:	29 ce                	sub    %ecx,%esi
80100de2:	83 fe 7f             	cmp    $0x7f,%esi
80100de5:	0f 87 97 fd ff ff    	ja     80100b82 <consoleintr+0x22>
80100deb:	83 f8 0d             	cmp    $0xd,%eax
80100dee:	74 70                	je     80100e60 <consoleintr+0x300>
80100df0:	83 f8 0a             	cmp    $0xa,%eax
80100df3:	0f 84 c5 00 00 00    	je     80100ebe <consoleintr+0x35e>
80100df9:	83 f8 04             	cmp    $0x4,%eax
80100dfc:	0f 84 bc 00 00 00    	je     80100ebe <consoleintr+0x35e>
80100e02:	83 e9 80             	sub    $0xffffff80,%ecx
80100e05:	39 ca                	cmp    %ecx,%edx
80100e07:	0f 84 b1 00 00 00    	je     80100ebe <consoleintr+0x35e>
80100e0d:	8b 0d 20 b5 10 80    	mov    0x8010b520,%ecx
80100e13:	85 c9                	test   %ecx,%ecx
80100e15:	0f 85 a7 00 00 00    	jne    80100ec2 <consoleintr+0x362>
80100e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
80100e1e:	83 e2 7f             	and    $0x7f,%edx
80100e21:	88 82 40 0f 11 80    	mov    %al,-0x7feef0c0(%edx)
80100e27:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100e2d:	89 0d c8 0f 11 80    	mov    %ecx,0x80110fc8
80100e33:	85 d2                	test   %edx,%edx
80100e35:	0f 84 99 00 00 00    	je     80100ed4 <consoleintr+0x374>
80100e3b:	fa                   	cli    
80100e3c:	eb fe                	jmp    80100e3c <consoleintr+0x2dc>
80100e3e:	66 90                	xchg   %ax,%ax
80100e40:	89 35 c8 0f 11 80    	mov    %esi,0x80110fc8
80100e46:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100e49:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100e4c:	e9 b2 fe ff ff       	jmp    80100d03 <consoleintr+0x1a3>
80100e51:	b8 00 01 00 00       	mov    $0x100,%eax
80100e56:	e8 b5 f5 ff ff       	call   80100410 <consputc.part.0>
80100e5b:	e9 22 fd ff ff       	jmp    80100b82 <consoleintr+0x22>
80100e60:	b9 0a 00 00 00       	mov    $0xa,%ecx
80100e65:	b8 0a 00 00 00       	mov    $0xa,%eax
80100e6a:	8d 72 01             	lea    0x1(%edx),%esi
80100e6d:	83 e2 7f             	and    $0x7f,%edx
80100e70:	88 8a 40 0f 11 80    	mov    %cl,-0x7feef0c0(%edx)
80100e76:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
80100e7c:	89 35 c8 0f 11 80    	mov    %esi,0x80110fc8
80100e82:	85 c9                	test   %ecx,%ecx
80100e84:	74 0a                	je     80100e90 <consoleintr+0x330>
80100e86:	fa                   	cli    
80100e87:	eb fe                	jmp    80100e87 <consoleintr+0x327>
80100e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e90:	e8 7b f5 ff ff       	call   80100410 <consputc.part.0>
80100e95:	83 ec 0c             	sub    $0xc,%esp
80100e98:	a1 c8 0f 11 80       	mov    0x80110fc8,%eax
80100e9d:	c7 05 20 b5 10 80 00 	movl   $0x0,0x8010b520
80100ea4:	00 00 00 
80100ea7:	68 c0 0f 11 80       	push   $0x80110fc0
80100eac:	a3 c4 0f 11 80       	mov    %eax,0x80110fc4
80100eb1:	e8 1a 37 00 00       	call   801045d0 <wakeup>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	e9 c4 fc ff ff       	jmp    80100b82 <consoleintr+0x22>
80100ebe:	89 c1                	mov    %eax,%ecx
80100ec0:	eb a8                	jmp    80100e6a <consoleintr+0x30a>
80100ec2:	83 ec 08             	sub    $0x8,%esp
80100ec5:	51                   	push   %ecx
80100ec6:	50                   	push   %eax
80100ec7:	e8 f4 fb ff ff       	call   80100ac0 <insert_at_the_given_pos>
80100ecc:	83 c4 10             	add    $0x10,%esp
80100ecf:	e9 ae fc ff ff       	jmp    80100b82 <consoleintr+0x22>
80100ed4:	e8 37 f5 ff ff       	call   80100410 <consputc.part.0>
80100ed9:	e9 a4 fc ff ff       	jmp    80100b82 <consoleintr+0x22>
80100ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee1:	5b                   	pop    %ebx
80100ee2:	5e                   	pop    %esi
80100ee3:	5f                   	pop    %edi
80100ee4:	5d                   	pop    %ebp
80100ee5:	e9 d6 37 00 00       	jmp    801046c0 <procdump>
80100eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ef0 <consoleinit>:
80100ef0:	f3 0f 1e fb          	endbr32 
80100ef4:	55                   	push   %ebp
80100ef5:	89 e5                	mov    %esp,%ebp
80100ef7:	83 ec 10             	sub    $0x10,%esp
80100efa:	68 68 79 10 80       	push   $0x80107968
80100eff:	68 40 b5 10 80       	push   $0x8010b540
80100f04:	e8 47 3b 00 00       	call   80104a50 <initlock>
80100f09:	58                   	pop    %eax
80100f0a:	5a                   	pop    %edx
80100f0b:	6a 00                	push   $0x0
80100f0d:	6a 01                	push   $0x1
80100f0f:	c7 05 8c 19 11 80 40 	movl   $0x80100640,0x8011198c
80100f16:	06 10 80 
80100f19:	c7 05 88 19 11 80 90 	movl   $0x80100290,0x80111988
80100f20:	02 10 80 
80100f23:	c7 05 74 b5 10 80 01 	movl   $0x1,0x8010b574
80100f2a:	00 00 00 
80100f2d:	e8 de 19 00 00       	call   80102910 <ioapicenable>
80100f32:	83 c4 10             	add    $0x10,%esp
80100f35:	c9                   	leave  
80100f36:	c3                   	ret    
80100f37:	66 90                	xchg   %ax,%ax
80100f39:	66 90                	xchg   %ax,%ax
80100f3b:	66 90                	xchg   %ax,%ax
80100f3d:	66 90                	xchg   %ax,%ax
80100f3f:	90                   	nop

80100f40 <exec>:
80100f40:	f3 0f 1e fb          	endbr32 
80100f44:	55                   	push   %ebp
80100f45:	89 e5                	mov    %esp,%ebp
80100f47:	57                   	push   %edi
80100f48:	56                   	push   %esi
80100f49:	53                   	push   %ebx
80100f4a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
80100f50:	e8 eb 2e 00 00       	call   80103e40 <myproc>
80100f55:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100f5b:	e8 b0 22 00 00       	call   80103210 <begin_op>
80100f60:	83 ec 0c             	sub    $0xc,%esp
80100f63:	ff 75 08             	pushl  0x8(%ebp)
80100f66:	e8 85 15 00 00       	call   801024f0 <namei>
80100f6b:	83 c4 10             	add    $0x10,%esp
80100f6e:	85 c0                	test   %eax,%eax
80100f70:	0f 84 fe 02 00 00    	je     80101274 <exec+0x334>
80100f76:	83 ec 0c             	sub    $0xc,%esp
80100f79:	89 c3                	mov    %eax,%ebx
80100f7b:	50                   	push   %eax
80100f7c:	e8 9f 0c 00 00       	call   80101c20 <ilock>
80100f81:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100f87:	6a 34                	push   $0x34
80100f89:	6a 00                	push   $0x0
80100f8b:	50                   	push   %eax
80100f8c:	53                   	push   %ebx
80100f8d:	e8 8e 0f 00 00       	call   80101f20 <readi>
80100f92:	83 c4 20             	add    $0x20,%esp
80100f95:	83 f8 34             	cmp    $0x34,%eax
80100f98:	74 26                	je     80100fc0 <exec+0x80>
80100f9a:	83 ec 0c             	sub    $0xc,%esp
80100f9d:	53                   	push   %ebx
80100f9e:	e8 1d 0f 00 00       	call   80101ec0 <iunlockput>
80100fa3:	e8 d8 22 00 00       	call   80103280 <end_op>
80100fa8:	83 c4 10             	add    $0x10,%esp
80100fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb3:	5b                   	pop    %ebx
80100fb4:	5e                   	pop    %esi
80100fb5:	5f                   	pop    %edi
80100fb6:	5d                   	pop    %ebp
80100fb7:	c3                   	ret    
80100fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fbf:	90                   	nop
80100fc0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100fc7:	45 4c 46 
80100fca:	75 ce                	jne    80100f9a <exec+0x5a>
80100fcc:	e8 8f 66 00 00       	call   80107660 <setupkvm>
80100fd1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100fd7:	85 c0                	test   %eax,%eax
80100fd9:	74 bf                	je     80100f9a <exec+0x5a>
80100fdb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100fe2:	00 
80100fe3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100fe9:	0f 84 a4 02 00 00    	je     80101293 <exec+0x353>
80100fef:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ff6:	00 00 00 
80100ff9:	31 ff                	xor    %edi,%edi
80100ffb:	e9 86 00 00 00       	jmp    80101086 <exec+0x146>
80101000:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101007:	75 6c                	jne    80101075 <exec+0x135>
80101009:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010100f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101015:	0f 82 87 00 00 00    	jb     801010a2 <exec+0x162>
8010101b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101021:	72 7f                	jb     801010a2 <exec+0x162>
80101023:	83 ec 04             	sub    $0x4,%esp
80101026:	50                   	push   %eax
80101027:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010102d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101033:	e8 48 64 00 00       	call   80107480 <allocuvm>
80101038:	83 c4 10             	add    $0x10,%esp
8010103b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101041:	85 c0                	test   %eax,%eax
80101043:	74 5d                	je     801010a2 <exec+0x162>
80101045:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010104b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101050:	75 50                	jne    801010a2 <exec+0x162>
80101052:	83 ec 0c             	sub    $0xc,%esp
80101055:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
8010105b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101061:	53                   	push   %ebx
80101062:	50                   	push   %eax
80101063:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101069:	e8 42 63 00 00       	call   801073b0 <loaduvm>
8010106e:	83 c4 20             	add    $0x20,%esp
80101071:	85 c0                	test   %eax,%eax
80101073:	78 2d                	js     801010a2 <exec+0x162>
80101075:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010107c:	83 c7 01             	add    $0x1,%edi
8010107f:	83 c6 20             	add    $0x20,%esi
80101082:	39 f8                	cmp    %edi,%eax
80101084:	7e 3a                	jle    801010c0 <exec+0x180>
80101086:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010108c:	6a 20                	push   $0x20
8010108e:	56                   	push   %esi
8010108f:	50                   	push   %eax
80101090:	53                   	push   %ebx
80101091:	e8 8a 0e 00 00       	call   80101f20 <readi>
80101096:	83 c4 10             	add    $0x10,%esp
80101099:	83 f8 20             	cmp    $0x20,%eax
8010109c:	0f 84 5e ff ff ff    	je     80101000 <exec+0xc0>
801010a2:	83 ec 0c             	sub    $0xc,%esp
801010a5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010ab:	e8 30 65 00 00       	call   801075e0 <freevm>
801010b0:	83 c4 10             	add    $0x10,%esp
801010b3:	e9 e2 fe ff ff       	jmp    80100f9a <exec+0x5a>
801010b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010bf:	90                   	nop
801010c0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801010c6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801010cc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801010d2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
801010d8:	83 ec 0c             	sub    $0xc,%esp
801010db:	53                   	push   %ebx
801010dc:	e8 df 0d 00 00       	call   80101ec0 <iunlockput>
801010e1:	e8 9a 21 00 00       	call   80103280 <end_op>
801010e6:	83 c4 0c             	add    $0xc,%esp
801010e9:	56                   	push   %esi
801010ea:	57                   	push   %edi
801010eb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
801010f1:	57                   	push   %edi
801010f2:	e8 89 63 00 00       	call   80107480 <allocuvm>
801010f7:	83 c4 10             	add    $0x10,%esp
801010fa:	89 c6                	mov    %eax,%esi
801010fc:	85 c0                	test   %eax,%eax
801010fe:	0f 84 94 00 00 00    	je     80101198 <exec+0x258>
80101104:	83 ec 08             	sub    $0x8,%esp
80101107:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
8010110d:	89 f3                	mov    %esi,%ebx
8010110f:	50                   	push   %eax
80101110:	57                   	push   %edi
80101111:	31 ff                	xor    %edi,%edi
80101113:	e8 e8 65 00 00       	call   80107700 <clearpteu>
80101118:	8b 45 0c             	mov    0xc(%ebp),%eax
8010111b:	83 c4 10             	add    $0x10,%esp
8010111e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101124:	8b 00                	mov    (%eax),%eax
80101126:	85 c0                	test   %eax,%eax
80101128:	0f 84 8b 00 00 00    	je     801011b9 <exec+0x279>
8010112e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101134:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010113a:	eb 23                	jmp    8010115f <exec+0x21f>
8010113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101140:	8b 45 0c             	mov    0xc(%ebp),%eax
80101143:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
8010114a:	83 c7 01             	add    $0x1,%edi
8010114d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101153:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101156:	85 c0                	test   %eax,%eax
80101158:	74 59                	je     801011b3 <exec+0x273>
8010115a:	83 ff 20             	cmp    $0x20,%edi
8010115d:	74 39                	je     80101198 <exec+0x258>
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	50                   	push   %eax
80101163:	e8 78 3d 00 00       	call   80104ee0 <strlen>
80101168:	f7 d0                	not    %eax
8010116a:	01 c3                	add    %eax,%ebx
8010116c:	58                   	pop    %eax
8010116d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101170:	83 e3 fc             	and    $0xfffffffc,%ebx
80101173:	ff 34 b8             	pushl  (%eax,%edi,4)
80101176:	e8 65 3d 00 00       	call   80104ee0 <strlen>
8010117b:	83 c0 01             	add    $0x1,%eax
8010117e:	50                   	push   %eax
8010117f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101182:	ff 34 b8             	pushl  (%eax,%edi,4)
80101185:	53                   	push   %ebx
80101186:	56                   	push   %esi
80101187:	e8 d4 66 00 00       	call   80107860 <copyout>
8010118c:	83 c4 20             	add    $0x20,%esp
8010118f:	85 c0                	test   %eax,%eax
80101191:	79 ad                	jns    80101140 <exec+0x200>
80101193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101197:	90                   	nop
80101198:	83 ec 0c             	sub    $0xc,%esp
8010119b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011a1:	e8 3a 64 00 00       	call   801075e0 <freevm>
801011a6:	83 c4 10             	add    $0x10,%esp
801011a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011ae:	e9 fd fd ff ff       	jmp    80100fb0 <exec+0x70>
801011b3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801011b9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801011c0:	89 d9                	mov    %ebx,%ecx
801011c2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801011c9:	00 00 00 00 
801011cd:	29 c1                	sub    %eax,%ecx
801011cf:	83 c0 0c             	add    $0xc,%eax
801011d2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
801011d8:	29 c3                	sub    %eax,%ebx
801011da:	50                   	push   %eax
801011db:	52                   	push   %edx
801011dc:	53                   	push   %ebx
801011dd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011e3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801011ea:	ff ff ff 
801011ed:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
801011f3:	e8 68 66 00 00       	call   80107860 <copyout>
801011f8:	83 c4 10             	add    $0x10,%esp
801011fb:	85 c0                	test   %eax,%eax
801011fd:	78 99                	js     80101198 <exec+0x258>
801011ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101202:	8b 55 08             	mov    0x8(%ebp),%edx
80101205:	0f b6 00             	movzbl (%eax),%eax
80101208:	84 c0                	test   %al,%al
8010120a:	74 13                	je     8010121f <exec+0x2df>
8010120c:	89 d1                	mov    %edx,%ecx
8010120e:	66 90                	xchg   %ax,%ax
80101210:	83 c1 01             	add    $0x1,%ecx
80101213:	3c 2f                	cmp    $0x2f,%al
80101215:	0f b6 01             	movzbl (%ecx),%eax
80101218:	0f 44 d1             	cmove  %ecx,%edx
8010121b:	84 c0                	test   %al,%al
8010121d:	75 f1                	jne    80101210 <exec+0x2d0>
8010121f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101225:	83 ec 04             	sub    $0x4,%esp
80101228:	6a 10                	push   $0x10
8010122a:	89 f8                	mov    %edi,%eax
8010122c:	52                   	push   %edx
8010122d:	83 c0 70             	add    $0x70,%eax
80101230:	50                   	push   %eax
80101231:	e8 6a 3c 00 00       	call   80104ea0 <safestrcpy>
80101236:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
8010123c:	89 f8                	mov    %edi,%eax
8010123e:	8b 7f 04             	mov    0x4(%edi),%edi
80101241:	89 30                	mov    %esi,(%eax)
80101243:	89 48 04             	mov    %ecx,0x4(%eax)
80101246:	89 c1                	mov    %eax,%ecx
80101248:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010124e:	8b 40 1c             	mov    0x1c(%eax),%eax
80101251:	89 50 38             	mov    %edx,0x38(%eax)
80101254:	8b 41 1c             	mov    0x1c(%ecx),%eax
80101257:	89 58 44             	mov    %ebx,0x44(%eax)
8010125a:	89 0c 24             	mov    %ecx,(%esp)
8010125d:	e8 be 5f 00 00       	call   80107220 <switchuvm>
80101262:	89 3c 24             	mov    %edi,(%esp)
80101265:	e8 76 63 00 00       	call   801075e0 <freevm>
8010126a:	83 c4 10             	add    $0x10,%esp
8010126d:	31 c0                	xor    %eax,%eax
8010126f:	e9 3c fd ff ff       	jmp    80100fb0 <exec+0x70>
80101274:	e8 07 20 00 00       	call   80103280 <end_op>
80101279:	83 ec 0c             	sub    $0xc,%esp
8010127c:	68 d9 79 10 80       	push   $0x801079d9
80101281:	e8 2a f4 ff ff       	call   801006b0 <cprintf>
80101286:	83 c4 10             	add    $0x10,%esp
80101289:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010128e:	e9 1d fd ff ff       	jmp    80100fb0 <exec+0x70>
80101293:	31 ff                	xor    %edi,%edi
80101295:	be 00 20 00 00       	mov    $0x2000,%esi
8010129a:	e9 39 fe ff ff       	jmp    801010d8 <exec+0x198>
8010129f:	90                   	nop

801012a0 <fileinit>:
801012a0:	f3 0f 1e fb          	endbr32 
801012a4:	55                   	push   %ebp
801012a5:	89 e5                	mov    %esp,%ebp
801012a7:	83 ec 10             	sub    $0x10,%esp
801012aa:	68 e5 79 10 80       	push   $0x801079e5
801012af:	68 e0 0f 11 80       	push   $0x80110fe0
801012b4:	e8 97 37 00 00       	call   80104a50 <initlock>
801012b9:	83 c4 10             	add    $0x10,%esp
801012bc:	c9                   	leave  
801012bd:	c3                   	ret    
801012be:	66 90                	xchg   %ax,%ax

801012c0 <filealloc>:
801012c0:	f3 0f 1e fb          	endbr32 
801012c4:	55                   	push   %ebp
801012c5:	89 e5                	mov    %esp,%ebp
801012c7:	53                   	push   %ebx
801012c8:	bb 14 10 11 80       	mov    $0x80111014,%ebx
801012cd:	83 ec 10             	sub    $0x10,%esp
801012d0:	68 e0 0f 11 80       	push   $0x80110fe0
801012d5:	e8 f6 38 00 00       	call   80104bd0 <acquire>
801012da:	83 c4 10             	add    $0x10,%esp
801012dd:	eb 0c                	jmp    801012eb <filealloc+0x2b>
801012df:	90                   	nop
801012e0:	83 c3 18             	add    $0x18,%ebx
801012e3:	81 fb 74 19 11 80    	cmp    $0x80111974,%ebx
801012e9:	74 25                	je     80101310 <filealloc+0x50>
801012eb:	8b 43 04             	mov    0x4(%ebx),%eax
801012ee:	85 c0                	test   %eax,%eax
801012f0:	75 ee                	jne    801012e0 <filealloc+0x20>
801012f2:	83 ec 0c             	sub    $0xc,%esp
801012f5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
801012fc:	68 e0 0f 11 80       	push   $0x80110fe0
80101301:	e8 8a 39 00 00       	call   80104c90 <release>
80101306:	89 d8                	mov    %ebx,%eax
80101308:	83 c4 10             	add    $0x10,%esp
8010130b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010130e:	c9                   	leave  
8010130f:	c3                   	ret    
80101310:	83 ec 0c             	sub    $0xc,%esp
80101313:	31 db                	xor    %ebx,%ebx
80101315:	68 e0 0f 11 80       	push   $0x80110fe0
8010131a:	e8 71 39 00 00       	call   80104c90 <release>
8010131f:	89 d8                	mov    %ebx,%eax
80101321:	83 c4 10             	add    $0x10,%esp
80101324:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101327:	c9                   	leave  
80101328:	c3                   	ret    
80101329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101330 <filedup>:
80101330:	f3 0f 1e fb          	endbr32 
80101334:	55                   	push   %ebp
80101335:	89 e5                	mov    %esp,%ebp
80101337:	53                   	push   %ebx
80101338:	83 ec 10             	sub    $0x10,%esp
8010133b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010133e:	68 e0 0f 11 80       	push   $0x80110fe0
80101343:	e8 88 38 00 00       	call   80104bd0 <acquire>
80101348:	8b 43 04             	mov    0x4(%ebx),%eax
8010134b:	83 c4 10             	add    $0x10,%esp
8010134e:	85 c0                	test   %eax,%eax
80101350:	7e 1a                	jle    8010136c <filedup+0x3c>
80101352:	83 c0 01             	add    $0x1,%eax
80101355:	83 ec 0c             	sub    $0xc,%esp
80101358:	89 43 04             	mov    %eax,0x4(%ebx)
8010135b:	68 e0 0f 11 80       	push   $0x80110fe0
80101360:	e8 2b 39 00 00       	call   80104c90 <release>
80101365:	89 d8                	mov    %ebx,%eax
80101367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010136a:	c9                   	leave  
8010136b:	c3                   	ret    
8010136c:	83 ec 0c             	sub    $0xc,%esp
8010136f:	68 ec 79 10 80       	push   $0x801079ec
80101374:	e8 17 f0 ff ff       	call   80100390 <panic>
80101379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101380 <fileclose>:
80101380:	f3 0f 1e fb          	endbr32 
80101384:	55                   	push   %ebp
80101385:	89 e5                	mov    %esp,%ebp
80101387:	57                   	push   %edi
80101388:	56                   	push   %esi
80101389:	53                   	push   %ebx
8010138a:	83 ec 28             	sub    $0x28,%esp
8010138d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101390:	68 e0 0f 11 80       	push   $0x80110fe0
80101395:	e8 36 38 00 00       	call   80104bd0 <acquire>
8010139a:	8b 53 04             	mov    0x4(%ebx),%edx
8010139d:	83 c4 10             	add    $0x10,%esp
801013a0:	85 d2                	test   %edx,%edx
801013a2:	0f 8e a1 00 00 00    	jle    80101449 <fileclose+0xc9>
801013a8:	83 ea 01             	sub    $0x1,%edx
801013ab:	89 53 04             	mov    %edx,0x4(%ebx)
801013ae:	75 40                	jne    801013f0 <fileclose+0x70>
801013b0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	8b 3b                	mov    (%ebx),%edi
801013b9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801013bf:	8b 73 0c             	mov    0xc(%ebx),%esi
801013c2:	88 45 e7             	mov    %al,-0x19(%ebp)
801013c5:	8b 43 10             	mov    0x10(%ebx),%eax
801013c8:	68 e0 0f 11 80       	push   $0x80110fe0
801013cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013d0:	e8 bb 38 00 00       	call   80104c90 <release>
801013d5:	83 c4 10             	add    $0x10,%esp
801013d8:	83 ff 01             	cmp    $0x1,%edi
801013db:	74 53                	je     80101430 <fileclose+0xb0>
801013dd:	83 ff 02             	cmp    $0x2,%edi
801013e0:	74 26                	je     80101408 <fileclose+0x88>
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	5b                   	pop    %ebx
801013e6:	5e                   	pop    %esi
801013e7:	5f                   	pop    %edi
801013e8:	5d                   	pop    %ebp
801013e9:	c3                   	ret    
801013ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013f0:	c7 45 08 e0 0f 11 80 	movl   $0x80110fe0,0x8(%ebp)
801013f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fa:	5b                   	pop    %ebx
801013fb:	5e                   	pop    %esi
801013fc:	5f                   	pop    %edi
801013fd:	5d                   	pop    %ebp
801013fe:	e9 8d 38 00 00       	jmp    80104c90 <release>
80101403:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101407:	90                   	nop
80101408:	e8 03 1e 00 00       	call   80103210 <begin_op>
8010140d:	83 ec 0c             	sub    $0xc,%esp
80101410:	ff 75 e0             	pushl  -0x20(%ebp)
80101413:	e8 38 09 00 00       	call   80101d50 <iput>
80101418:	83 c4 10             	add    $0x10,%esp
8010141b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010141e:	5b                   	pop    %ebx
8010141f:	5e                   	pop    %esi
80101420:	5f                   	pop    %edi
80101421:	5d                   	pop    %ebp
80101422:	e9 59 1e 00 00       	jmp    80103280 <end_op>
80101427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010142e:	66 90                	xchg   %ax,%ax
80101430:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101434:	83 ec 08             	sub    $0x8,%esp
80101437:	53                   	push   %ebx
80101438:	56                   	push   %esi
80101439:	e8 a2 25 00 00       	call   801039e0 <pipeclose>
8010143e:	83 c4 10             	add    $0x10,%esp
80101441:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101444:	5b                   	pop    %ebx
80101445:	5e                   	pop    %esi
80101446:	5f                   	pop    %edi
80101447:	5d                   	pop    %ebp
80101448:	c3                   	ret    
80101449:	83 ec 0c             	sub    $0xc,%esp
8010144c:	68 f4 79 10 80       	push   $0x801079f4
80101451:	e8 3a ef ff ff       	call   80100390 <panic>
80101456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145d:	8d 76 00             	lea    0x0(%esi),%esi

80101460 <filestat>:
80101460:	f3 0f 1e fb          	endbr32 
80101464:	55                   	push   %ebp
80101465:	89 e5                	mov    %esp,%ebp
80101467:	53                   	push   %ebx
80101468:	83 ec 04             	sub    $0x4,%esp
8010146b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010146e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101471:	75 2d                	jne    801014a0 <filestat+0x40>
80101473:	83 ec 0c             	sub    $0xc,%esp
80101476:	ff 73 10             	pushl  0x10(%ebx)
80101479:	e8 a2 07 00 00       	call   80101c20 <ilock>
8010147e:	58                   	pop    %eax
8010147f:	5a                   	pop    %edx
80101480:	ff 75 0c             	pushl  0xc(%ebp)
80101483:	ff 73 10             	pushl  0x10(%ebx)
80101486:	e8 65 0a 00 00       	call   80101ef0 <stati>
8010148b:	59                   	pop    %ecx
8010148c:	ff 73 10             	pushl  0x10(%ebx)
8010148f:	e8 6c 08 00 00       	call   80101d00 <iunlock>
80101494:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101497:	83 c4 10             	add    $0x10,%esp
8010149a:	31 c0                	xor    %eax,%eax
8010149c:	c9                   	leave  
8010149d:	c3                   	ret    
8010149e:	66 90                	xchg   %ax,%ax
801014a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801014a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014a8:	c9                   	leave  
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014b0 <fileread>:
801014b0:	f3 0f 1e fb          	endbr32 
801014b4:	55                   	push   %ebp
801014b5:	89 e5                	mov    %esp,%ebp
801014b7:	57                   	push   %edi
801014b8:	56                   	push   %esi
801014b9:	53                   	push   %ebx
801014ba:	83 ec 0c             	sub    $0xc,%esp
801014bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801014c0:	8b 75 0c             	mov    0xc(%ebp),%esi
801014c3:	8b 7d 10             	mov    0x10(%ebp),%edi
801014c6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801014ca:	74 64                	je     80101530 <fileread+0x80>
801014cc:	8b 03                	mov    (%ebx),%eax
801014ce:	83 f8 01             	cmp    $0x1,%eax
801014d1:	74 45                	je     80101518 <fileread+0x68>
801014d3:	83 f8 02             	cmp    $0x2,%eax
801014d6:	75 5f                	jne    80101537 <fileread+0x87>
801014d8:	83 ec 0c             	sub    $0xc,%esp
801014db:	ff 73 10             	pushl  0x10(%ebx)
801014de:	e8 3d 07 00 00       	call   80101c20 <ilock>
801014e3:	57                   	push   %edi
801014e4:	ff 73 14             	pushl  0x14(%ebx)
801014e7:	56                   	push   %esi
801014e8:	ff 73 10             	pushl  0x10(%ebx)
801014eb:	e8 30 0a 00 00       	call   80101f20 <readi>
801014f0:	83 c4 20             	add    $0x20,%esp
801014f3:	89 c6                	mov    %eax,%esi
801014f5:	85 c0                	test   %eax,%eax
801014f7:	7e 03                	jle    801014fc <fileread+0x4c>
801014f9:	01 43 14             	add    %eax,0x14(%ebx)
801014fc:	83 ec 0c             	sub    $0xc,%esp
801014ff:	ff 73 10             	pushl  0x10(%ebx)
80101502:	e8 f9 07 00 00       	call   80101d00 <iunlock>
80101507:	83 c4 10             	add    $0x10,%esp
8010150a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150d:	89 f0                	mov    %esi,%eax
8010150f:	5b                   	pop    %ebx
80101510:	5e                   	pop    %esi
80101511:	5f                   	pop    %edi
80101512:	5d                   	pop    %ebp
80101513:	c3                   	ret    
80101514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101518:	8b 43 0c             	mov    0xc(%ebx),%eax
8010151b:	89 45 08             	mov    %eax,0x8(%ebp)
8010151e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101521:	5b                   	pop    %ebx
80101522:	5e                   	pop    %esi
80101523:	5f                   	pop    %edi
80101524:	5d                   	pop    %ebp
80101525:	e9 56 26 00 00       	jmp    80103b80 <piperead>
8010152a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101530:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101535:	eb d3                	jmp    8010150a <fileread+0x5a>
80101537:	83 ec 0c             	sub    $0xc,%esp
8010153a:	68 fe 79 10 80       	push   $0x801079fe
8010153f:	e8 4c ee ff ff       	call   80100390 <panic>
80101544:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010154b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010154f:	90                   	nop

80101550 <filewrite>:
80101550:	f3 0f 1e fb          	endbr32 
80101554:	55                   	push   %ebp
80101555:	89 e5                	mov    %esp,%ebp
80101557:	57                   	push   %edi
80101558:	56                   	push   %esi
80101559:	53                   	push   %ebx
8010155a:	83 ec 1c             	sub    $0x1c,%esp
8010155d:	8b 45 0c             	mov    0xc(%ebp),%eax
80101560:	8b 75 08             	mov    0x8(%ebp),%esi
80101563:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101566:	8b 45 10             	mov    0x10(%ebp),%eax
80101569:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
8010156d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101570:	0f 84 c1 00 00 00    	je     80101637 <filewrite+0xe7>
80101576:	8b 06                	mov    (%esi),%eax
80101578:	83 f8 01             	cmp    $0x1,%eax
8010157b:	0f 84 c3 00 00 00    	je     80101644 <filewrite+0xf4>
80101581:	83 f8 02             	cmp    $0x2,%eax
80101584:	0f 85 cc 00 00 00    	jne    80101656 <filewrite+0x106>
8010158a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010158d:	31 ff                	xor    %edi,%edi
8010158f:	85 c0                	test   %eax,%eax
80101591:	7f 34                	jg     801015c7 <filewrite+0x77>
80101593:	e9 98 00 00 00       	jmp    80101630 <filewrite+0xe0>
80101598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010159f:	90                   	nop
801015a0:	01 46 14             	add    %eax,0x14(%esi)
801015a3:	83 ec 0c             	sub    $0xc,%esp
801015a6:	ff 76 10             	pushl  0x10(%esi)
801015a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
801015ac:	e8 4f 07 00 00       	call   80101d00 <iunlock>
801015b1:	e8 ca 1c 00 00       	call   80103280 <end_op>
801015b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015b9:	83 c4 10             	add    $0x10,%esp
801015bc:	39 c3                	cmp    %eax,%ebx
801015be:	75 60                	jne    80101620 <filewrite+0xd0>
801015c0:	01 df                	add    %ebx,%edi
801015c2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801015c5:	7e 69                	jle    80101630 <filewrite+0xe0>
801015c7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801015ca:	b8 00 06 00 00       	mov    $0x600,%eax
801015cf:	29 fb                	sub    %edi,%ebx
801015d1:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801015d7:	0f 4f d8             	cmovg  %eax,%ebx
801015da:	e8 31 1c 00 00       	call   80103210 <begin_op>
801015df:	83 ec 0c             	sub    $0xc,%esp
801015e2:	ff 76 10             	pushl  0x10(%esi)
801015e5:	e8 36 06 00 00       	call   80101c20 <ilock>
801015ea:	8b 45 dc             	mov    -0x24(%ebp),%eax
801015ed:	53                   	push   %ebx
801015ee:	ff 76 14             	pushl  0x14(%esi)
801015f1:	01 f8                	add    %edi,%eax
801015f3:	50                   	push   %eax
801015f4:	ff 76 10             	pushl  0x10(%esi)
801015f7:	e8 24 0a 00 00       	call   80102020 <writei>
801015fc:	83 c4 20             	add    $0x20,%esp
801015ff:	85 c0                	test   %eax,%eax
80101601:	7f 9d                	jg     801015a0 <filewrite+0x50>
80101603:	83 ec 0c             	sub    $0xc,%esp
80101606:	ff 76 10             	pushl  0x10(%esi)
80101609:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010160c:	e8 ef 06 00 00       	call   80101d00 <iunlock>
80101611:	e8 6a 1c 00 00       	call   80103280 <end_op>
80101616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101619:	83 c4 10             	add    $0x10,%esp
8010161c:	85 c0                	test   %eax,%eax
8010161e:	75 17                	jne    80101637 <filewrite+0xe7>
80101620:	83 ec 0c             	sub    $0xc,%esp
80101623:	68 07 7a 10 80       	push   $0x80107a07
80101628:	e8 63 ed ff ff       	call   80100390 <panic>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi
80101630:	89 f8                	mov    %edi,%eax
80101632:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101635:	74 05                	je     8010163c <filewrite+0xec>
80101637:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010163c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010163f:	5b                   	pop    %ebx
80101640:	5e                   	pop    %esi
80101641:	5f                   	pop    %edi
80101642:	5d                   	pop    %ebp
80101643:	c3                   	ret    
80101644:	8b 46 0c             	mov    0xc(%esi),%eax
80101647:	89 45 08             	mov    %eax,0x8(%ebp)
8010164a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164d:	5b                   	pop    %ebx
8010164e:	5e                   	pop    %esi
8010164f:	5f                   	pop    %edi
80101650:	5d                   	pop    %ebp
80101651:	e9 2a 24 00 00       	jmp    80103a80 <pipewrite>
80101656:	83 ec 0c             	sub    $0xc,%esp
80101659:	68 0d 7a 10 80       	push   $0x80107a0d
8010165e:	e8 2d ed ff ff       	call   80100390 <panic>
80101663:	66 90                	xchg   %ax,%ax
80101665:	66 90                	xchg   %ax,%ax
80101667:	66 90                	xchg   %ax,%ax
80101669:	66 90                	xchg   %ax,%ax
8010166b:	66 90                	xchg   %ax,%ax
8010166d:	66 90                	xchg   %ax,%ax
8010166f:	90                   	nop

80101670 <bfree>:
80101670:	55                   	push   %ebp
80101671:	89 c1                	mov    %eax,%ecx
80101673:	89 d0                	mov    %edx,%eax
80101675:	c1 e8 0c             	shr    $0xc,%eax
80101678:	03 05 f8 19 11 80    	add    0x801119f8,%eax
8010167e:	89 e5                	mov    %esp,%ebp
80101680:	56                   	push   %esi
80101681:	53                   	push   %ebx
80101682:	89 d3                	mov    %edx,%ebx
80101684:	83 ec 08             	sub    $0x8,%esp
80101687:	50                   	push   %eax
80101688:	51                   	push   %ecx
80101689:	e8 42 ea ff ff       	call   801000d0 <bread>
8010168e:	89 d9                	mov    %ebx,%ecx
80101690:	c1 fb 03             	sar    $0x3,%ebx
80101693:	ba 01 00 00 00       	mov    $0x1,%edx
80101698:	83 e1 07             	and    $0x7,%ecx
8010169b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801016a1:	83 c4 10             	add    $0x10,%esp
801016a4:	d3 e2                	shl    %cl,%edx
801016a6:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801016ab:	85 d1                	test   %edx,%ecx
801016ad:	74 25                	je     801016d4 <bfree+0x64>
801016af:	f7 d2                	not    %edx
801016b1:	83 ec 0c             	sub    $0xc,%esp
801016b4:	89 c6                	mov    %eax,%esi
801016b6:	21 ca                	and    %ecx,%edx
801016b8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
801016bc:	50                   	push   %eax
801016bd:	e8 2e 1d 00 00       	call   801033f0 <log_write>
801016c2:	89 34 24             	mov    %esi,(%esp)
801016c5:	e8 26 eb ff ff       	call   801001f0 <brelse>
801016ca:	83 c4 10             	add    $0x10,%esp
801016cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d0:	5b                   	pop    %ebx
801016d1:	5e                   	pop    %esi
801016d2:	5d                   	pop    %ebp
801016d3:	c3                   	ret    
801016d4:	83 ec 0c             	sub    $0xc,%esp
801016d7:	68 17 7a 10 80       	push   $0x80107a17
801016dc:	e8 af ec ff ff       	call   80100390 <panic>
801016e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ef:	90                   	nop

801016f0 <balloc>:
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	56                   	push   %esi
801016f5:	53                   	push   %ebx
801016f6:	83 ec 1c             	sub    $0x1c,%esp
801016f9:	8b 0d e0 19 11 80    	mov    0x801119e0,%ecx
801016ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101702:	85 c9                	test   %ecx,%ecx
80101704:	0f 84 87 00 00 00    	je     80101791 <balloc+0xa1>
8010170a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
80101711:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101714:	83 ec 08             	sub    $0x8,%esp
80101717:	89 f0                	mov    %esi,%eax
80101719:	c1 f8 0c             	sar    $0xc,%eax
8010171c:	03 05 f8 19 11 80    	add    0x801119f8,%eax
80101722:	50                   	push   %eax
80101723:	ff 75 d8             	pushl  -0x28(%ebp)
80101726:	e8 a5 e9 ff ff       	call   801000d0 <bread>
8010172b:	83 c4 10             	add    $0x10,%esp
8010172e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101731:	a1 e0 19 11 80       	mov    0x801119e0,%eax
80101736:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101739:	31 c0                	xor    %eax,%eax
8010173b:	eb 2f                	jmp    8010176c <balloc+0x7c>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi
80101740:	89 c1                	mov    %eax,%ecx
80101742:	bb 01 00 00 00       	mov    $0x1,%ebx
80101747:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010174a:	83 e1 07             	and    $0x7,%ecx
8010174d:	d3 e3                	shl    %cl,%ebx
8010174f:	89 c1                	mov    %eax,%ecx
80101751:	c1 f9 03             	sar    $0x3,%ecx
80101754:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101759:	89 fa                	mov    %edi,%edx
8010175b:	85 df                	test   %ebx,%edi
8010175d:	74 41                	je     801017a0 <balloc+0xb0>
8010175f:	83 c0 01             	add    $0x1,%eax
80101762:	83 c6 01             	add    $0x1,%esi
80101765:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010176a:	74 05                	je     80101771 <balloc+0x81>
8010176c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010176f:	77 cf                	ja     80101740 <balloc+0x50>
80101771:	83 ec 0c             	sub    $0xc,%esp
80101774:	ff 75 e4             	pushl  -0x1c(%ebp)
80101777:	e8 74 ea ff ff       	call   801001f0 <brelse>
8010177c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101783:	83 c4 10             	add    $0x10,%esp
80101786:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101789:	39 05 e0 19 11 80    	cmp    %eax,0x801119e0
8010178f:	77 80                	ja     80101711 <balloc+0x21>
80101791:	83 ec 0c             	sub    $0xc,%esp
80101794:	68 2a 7a 10 80       	push   $0x80107a2a
80101799:	e8 f2 eb ff ff       	call   80100390 <panic>
8010179e:	66 90                	xchg   %ax,%ax
801017a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801017a3:	83 ec 0c             	sub    $0xc,%esp
801017a6:	09 da                	or     %ebx,%edx
801017a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
801017ac:	57                   	push   %edi
801017ad:	e8 3e 1c 00 00       	call   801033f0 <log_write>
801017b2:	89 3c 24             	mov    %edi,(%esp)
801017b5:	e8 36 ea ff ff       	call   801001f0 <brelse>
801017ba:	58                   	pop    %eax
801017bb:	5a                   	pop    %edx
801017bc:	56                   	push   %esi
801017bd:	ff 75 d8             	pushl  -0x28(%ebp)
801017c0:	e8 0b e9 ff ff       	call   801000d0 <bread>
801017c5:	83 c4 0c             	add    $0xc,%esp
801017c8:	89 c3                	mov    %eax,%ebx
801017ca:	8d 40 5c             	lea    0x5c(%eax),%eax
801017cd:	68 00 02 00 00       	push   $0x200
801017d2:	6a 00                	push   $0x0
801017d4:	50                   	push   %eax
801017d5:	e8 06 35 00 00       	call   80104ce0 <memset>
801017da:	89 1c 24             	mov    %ebx,(%esp)
801017dd:	e8 0e 1c 00 00       	call   801033f0 <log_write>
801017e2:	89 1c 24             	mov    %ebx,(%esp)
801017e5:	e8 06 ea ff ff       	call   801001f0 <brelse>
801017ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017ed:	89 f0                	mov    %esi,%eax
801017ef:	5b                   	pop    %ebx
801017f0:	5e                   	pop    %esi
801017f1:	5f                   	pop    %edi
801017f2:	5d                   	pop    %ebp
801017f3:	c3                   	ret    
801017f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801017fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801017ff:	90                   	nop

80101800 <iget>:
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	57                   	push   %edi
80101804:	89 c7                	mov    %eax,%edi
80101806:	56                   	push   %esi
80101807:	31 f6                	xor    %esi,%esi
80101809:	53                   	push   %ebx
8010180a:	bb 34 1a 11 80       	mov    $0x80111a34,%ebx
8010180f:	83 ec 28             	sub    $0x28,%esp
80101812:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101815:	68 00 1a 11 80       	push   $0x80111a00
8010181a:	e8 b1 33 00 00       	call   80104bd0 <acquire>
8010181f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101822:	83 c4 10             	add    $0x10,%esp
80101825:	eb 1b                	jmp    80101842 <iget+0x42>
80101827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010182e:	66 90                	xchg   %ax,%ax
80101830:	39 3b                	cmp    %edi,(%ebx)
80101832:	74 6c                	je     801018a0 <iget+0xa0>
80101834:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010183a:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
80101840:	73 26                	jae    80101868 <iget+0x68>
80101842:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101845:	85 c9                	test   %ecx,%ecx
80101847:	7f e7                	jg     80101830 <iget+0x30>
80101849:	85 f6                	test   %esi,%esi
8010184b:	75 e7                	jne    80101834 <iget+0x34>
8010184d:	89 d8                	mov    %ebx,%eax
8010184f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101855:	85 c9                	test   %ecx,%ecx
80101857:	75 6e                	jne    801018c7 <iget+0xc7>
80101859:	89 c6                	mov    %eax,%esi
8010185b:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
80101861:	72 df                	jb     80101842 <iget+0x42>
80101863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101867:	90                   	nop
80101868:	85 f6                	test   %esi,%esi
8010186a:	74 73                	je     801018df <iget+0xdf>
8010186c:	83 ec 0c             	sub    $0xc,%esp
8010186f:	89 3e                	mov    %edi,(%esi)
80101871:	89 56 04             	mov    %edx,0x4(%esi)
80101874:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
80101882:	68 00 1a 11 80       	push   $0x80111a00
80101887:	e8 04 34 00 00       	call   80104c90 <release>
8010188c:	83 c4 10             	add    $0x10,%esp
8010188f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101892:	89 f0                	mov    %esi,%eax
80101894:	5b                   	pop    %ebx
80101895:	5e                   	pop    %esi
80101896:	5f                   	pop    %edi
80101897:	5d                   	pop    %ebp
80101898:	c3                   	ret    
80101899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018a0:	39 53 04             	cmp    %edx,0x4(%ebx)
801018a3:	75 8f                	jne    80101834 <iget+0x34>
801018a5:	83 ec 0c             	sub    $0xc,%esp
801018a8:	83 c1 01             	add    $0x1,%ecx
801018ab:	89 de                	mov    %ebx,%esi
801018ad:	68 00 1a 11 80       	push   $0x80111a00
801018b2:	89 4b 08             	mov    %ecx,0x8(%ebx)
801018b5:	e8 d6 33 00 00       	call   80104c90 <release>
801018ba:	83 c4 10             	add    $0x10,%esp
801018bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018c0:	89 f0                	mov    %esi,%eax
801018c2:	5b                   	pop    %ebx
801018c3:	5e                   	pop    %esi
801018c4:	5f                   	pop    %edi
801018c5:	5d                   	pop    %ebp
801018c6:	c3                   	ret    
801018c7:	81 fb 54 36 11 80    	cmp    $0x80113654,%ebx
801018cd:	73 10                	jae    801018df <iget+0xdf>
801018cf:	8b 4b 08             	mov    0x8(%ebx),%ecx
801018d2:	85 c9                	test   %ecx,%ecx
801018d4:	0f 8f 56 ff ff ff    	jg     80101830 <iget+0x30>
801018da:	e9 6e ff ff ff       	jmp    8010184d <iget+0x4d>
801018df:	83 ec 0c             	sub    $0xc,%esp
801018e2:	68 40 7a 10 80       	push   $0x80107a40
801018e7:	e8 a4 ea ff ff       	call   80100390 <panic>
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018f0 <bmap>:
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	57                   	push   %edi
801018f4:	56                   	push   %esi
801018f5:	89 c6                	mov    %eax,%esi
801018f7:	53                   	push   %ebx
801018f8:	83 ec 1c             	sub    $0x1c,%esp
801018fb:	83 fa 0b             	cmp    $0xb,%edx
801018fe:	0f 86 84 00 00 00    	jbe    80101988 <bmap+0x98>
80101904:	8d 5a f4             	lea    -0xc(%edx),%ebx
80101907:	83 fb 7f             	cmp    $0x7f,%ebx
8010190a:	0f 87 98 00 00 00    	ja     801019a8 <bmap+0xb8>
80101910:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101916:	8b 16                	mov    (%esi),%edx
80101918:	85 c0                	test   %eax,%eax
8010191a:	74 54                	je     80101970 <bmap+0x80>
8010191c:	83 ec 08             	sub    $0x8,%esp
8010191f:	50                   	push   %eax
80101920:	52                   	push   %edx
80101921:	e8 aa e7 ff ff       	call   801000d0 <bread>
80101926:	83 c4 10             	add    $0x10,%esp
80101929:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010192d:	89 c7                	mov    %eax,%edi
8010192f:	8b 1a                	mov    (%edx),%ebx
80101931:	85 db                	test   %ebx,%ebx
80101933:	74 1b                	je     80101950 <bmap+0x60>
80101935:	83 ec 0c             	sub    $0xc,%esp
80101938:	57                   	push   %edi
80101939:	e8 b2 e8 ff ff       	call   801001f0 <brelse>
8010193e:	83 c4 10             	add    $0x10,%esp
80101941:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101944:	89 d8                	mov    %ebx,%eax
80101946:	5b                   	pop    %ebx
80101947:	5e                   	pop    %esi
80101948:	5f                   	pop    %edi
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010194f:	90                   	nop
80101950:	8b 06                	mov    (%esi),%eax
80101952:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101955:	e8 96 fd ff ff       	call   801016f0 <balloc>
8010195a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010195d:	83 ec 0c             	sub    $0xc,%esp
80101960:	89 c3                	mov    %eax,%ebx
80101962:	89 02                	mov    %eax,(%edx)
80101964:	57                   	push   %edi
80101965:	e8 86 1a 00 00       	call   801033f0 <log_write>
8010196a:	83 c4 10             	add    $0x10,%esp
8010196d:	eb c6                	jmp    80101935 <bmap+0x45>
8010196f:	90                   	nop
80101970:	89 d0                	mov    %edx,%eax
80101972:	e8 79 fd ff ff       	call   801016f0 <balloc>
80101977:	8b 16                	mov    (%esi),%edx
80101979:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010197f:	eb 9b                	jmp    8010191c <bmap+0x2c>
80101981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101988:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010198b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010198e:	85 db                	test   %ebx,%ebx
80101990:	75 af                	jne    80101941 <bmap+0x51>
80101992:	8b 00                	mov    (%eax),%eax
80101994:	e8 57 fd ff ff       	call   801016f0 <balloc>
80101999:	89 47 5c             	mov    %eax,0x5c(%edi)
8010199c:	89 c3                	mov    %eax,%ebx
8010199e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019a1:	89 d8                	mov    %ebx,%eax
801019a3:	5b                   	pop    %ebx
801019a4:	5e                   	pop    %esi
801019a5:	5f                   	pop    %edi
801019a6:	5d                   	pop    %ebp
801019a7:	c3                   	ret    
801019a8:	83 ec 0c             	sub    $0xc,%esp
801019ab:	68 50 7a 10 80       	push   $0x80107a50
801019b0:	e8 db e9 ff ff       	call   80100390 <panic>
801019b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019c0 <readsb>:
801019c0:	f3 0f 1e fb          	endbr32 
801019c4:	55                   	push   %ebp
801019c5:	89 e5                	mov    %esp,%ebp
801019c7:	56                   	push   %esi
801019c8:	53                   	push   %ebx
801019c9:	8b 75 0c             	mov    0xc(%ebp),%esi
801019cc:	83 ec 08             	sub    $0x8,%esp
801019cf:	6a 01                	push   $0x1
801019d1:	ff 75 08             	pushl  0x8(%ebp)
801019d4:	e8 f7 e6 ff ff       	call   801000d0 <bread>
801019d9:	83 c4 0c             	add    $0xc,%esp
801019dc:	89 c3                	mov    %eax,%ebx
801019de:	8d 40 5c             	lea    0x5c(%eax),%eax
801019e1:	6a 1c                	push   $0x1c
801019e3:	50                   	push   %eax
801019e4:	56                   	push   %esi
801019e5:	e8 96 33 00 00       	call   80104d80 <memmove>
801019ea:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019ed:	83 c4 10             	add    $0x10,%esp
801019f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019f3:	5b                   	pop    %ebx
801019f4:	5e                   	pop    %esi
801019f5:	5d                   	pop    %ebp
801019f6:	e9 f5 e7 ff ff       	jmp    801001f0 <brelse>
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop

80101a00 <iinit>:
80101a00:	f3 0f 1e fb          	endbr32 
80101a04:	55                   	push   %ebp
80101a05:	89 e5                	mov    %esp,%ebp
80101a07:	53                   	push   %ebx
80101a08:	bb 40 1a 11 80       	mov    $0x80111a40,%ebx
80101a0d:	83 ec 0c             	sub    $0xc,%esp
80101a10:	68 63 7a 10 80       	push   $0x80107a63
80101a15:	68 00 1a 11 80       	push   $0x80111a00
80101a1a:	e8 31 30 00 00       	call   80104a50 <initlock>
80101a1f:	83 c4 10             	add    $0x10,%esp
80101a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101a28:	83 ec 08             	sub    $0x8,%esp
80101a2b:	68 6a 7a 10 80       	push   $0x80107a6a
80101a30:	53                   	push   %ebx
80101a31:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a37:	e8 d4 2e 00 00       	call   80104910 <initsleeplock>
80101a3c:	83 c4 10             	add    $0x10,%esp
80101a3f:	81 fb 60 36 11 80    	cmp    $0x80113660,%ebx
80101a45:	75 e1                	jne    80101a28 <iinit+0x28>
80101a47:	83 ec 08             	sub    $0x8,%esp
80101a4a:	68 e0 19 11 80       	push   $0x801119e0
80101a4f:	ff 75 08             	pushl  0x8(%ebp)
80101a52:	e8 69 ff ff ff       	call   801019c0 <readsb>
80101a57:	ff 35 f8 19 11 80    	pushl  0x801119f8
80101a5d:	ff 35 f4 19 11 80    	pushl  0x801119f4
80101a63:	ff 35 f0 19 11 80    	pushl  0x801119f0
80101a69:	ff 35 ec 19 11 80    	pushl  0x801119ec
80101a6f:	ff 35 e8 19 11 80    	pushl  0x801119e8
80101a75:	ff 35 e4 19 11 80    	pushl  0x801119e4
80101a7b:	ff 35 e0 19 11 80    	pushl  0x801119e0
80101a81:	68 d0 7a 10 80       	push   $0x80107ad0
80101a86:	e8 25 ec ff ff       	call   801006b0 <cprintf>
80101a8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a8e:	83 c4 30             	add    $0x30,%esp
80101a91:	c9                   	leave  
80101a92:	c3                   	ret    
80101a93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101aa0 <ialloc>:
80101aa0:	f3 0f 1e fb          	endbr32 
80101aa4:	55                   	push   %ebp
80101aa5:	89 e5                	mov    %esp,%ebp
80101aa7:	57                   	push   %edi
80101aa8:	56                   	push   %esi
80101aa9:	53                   	push   %ebx
80101aaa:	83 ec 1c             	sub    $0x1c,%esp
80101aad:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ab0:	83 3d e8 19 11 80 01 	cmpl   $0x1,0x801119e8
80101ab7:	8b 75 08             	mov    0x8(%ebp),%esi
80101aba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101abd:	0f 86 8d 00 00 00    	jbe    80101b50 <ialloc+0xb0>
80101ac3:	bf 01 00 00 00       	mov    $0x1,%edi
80101ac8:	eb 1d                	jmp    80101ae7 <ialloc+0x47>
80101aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ad0:	83 ec 0c             	sub    $0xc,%esp
80101ad3:	83 c7 01             	add    $0x1,%edi
80101ad6:	53                   	push   %ebx
80101ad7:	e8 14 e7 ff ff       	call   801001f0 <brelse>
80101adc:	83 c4 10             	add    $0x10,%esp
80101adf:	3b 3d e8 19 11 80    	cmp    0x801119e8,%edi
80101ae5:	73 69                	jae    80101b50 <ialloc+0xb0>
80101ae7:	89 f8                	mov    %edi,%eax
80101ae9:	83 ec 08             	sub    $0x8,%esp
80101aec:	c1 e8 03             	shr    $0x3,%eax
80101aef:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101af5:	50                   	push   %eax
80101af6:	56                   	push   %esi
80101af7:	e8 d4 e5 ff ff       	call   801000d0 <bread>
80101afc:	83 c4 10             	add    $0x10,%esp
80101aff:	89 c3                	mov    %eax,%ebx
80101b01:	89 f8                	mov    %edi,%eax
80101b03:	83 e0 07             	and    $0x7,%eax
80101b06:	c1 e0 06             	shl    $0x6,%eax
80101b09:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
80101b0d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101b11:	75 bd                	jne    80101ad0 <ialloc+0x30>
80101b13:	83 ec 04             	sub    $0x4,%esp
80101b16:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b19:	6a 40                	push   $0x40
80101b1b:	6a 00                	push   $0x0
80101b1d:	51                   	push   %ecx
80101b1e:	e8 bd 31 00 00       	call   80104ce0 <memset>
80101b23:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b27:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b2a:	66 89 01             	mov    %ax,(%ecx)
80101b2d:	89 1c 24             	mov    %ebx,(%esp)
80101b30:	e8 bb 18 00 00       	call   801033f0 <log_write>
80101b35:	89 1c 24             	mov    %ebx,(%esp)
80101b38:	e8 b3 e6 ff ff       	call   801001f0 <brelse>
80101b3d:	83 c4 10             	add    $0x10,%esp
80101b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b43:	89 fa                	mov    %edi,%edx
80101b45:	5b                   	pop    %ebx
80101b46:	89 f0                	mov    %esi,%eax
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	e9 b0 fc ff ff       	jmp    80101800 <iget>
80101b50:	83 ec 0c             	sub    $0xc,%esp
80101b53:	68 70 7a 10 80       	push   $0x80107a70
80101b58:	e8 33 e8 ff ff       	call   80100390 <panic>
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi

80101b60 <iupdate>:
80101b60:	f3 0f 1e fb          	endbr32 
80101b64:	55                   	push   %ebp
80101b65:	89 e5                	mov    %esp,%ebp
80101b67:	56                   	push   %esi
80101b68:	53                   	push   %ebx
80101b69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101b6c:	8b 43 04             	mov    0x4(%ebx),%eax
80101b6f:	83 c3 5c             	add    $0x5c,%ebx
80101b72:	83 ec 08             	sub    $0x8,%esp
80101b75:	c1 e8 03             	shr    $0x3,%eax
80101b78:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101b7e:	50                   	push   %eax
80101b7f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101b82:	e8 49 e5 ff ff       	call   801000d0 <bread>
80101b87:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80101b8b:	83 c4 0c             	add    $0xc,%esp
80101b8e:	89 c6                	mov    %eax,%esi
80101b90:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101b93:	83 e0 07             	and    $0x7,%eax
80101b96:	c1 e0 06             	shl    $0x6,%eax
80101b99:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101b9d:	66 89 10             	mov    %dx,(%eax)
80101ba0:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101ba4:	83 c0 0c             	add    $0xc,%eax
80101ba7:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101bab:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101baf:	66 89 50 f8          	mov    %dx,-0x8(%eax)
80101bb3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101bb7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101bbb:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101bbe:	89 50 fc             	mov    %edx,-0x4(%eax)
80101bc1:	6a 34                	push   $0x34
80101bc3:	53                   	push   %ebx
80101bc4:	50                   	push   %eax
80101bc5:	e8 b6 31 00 00       	call   80104d80 <memmove>
80101bca:	89 34 24             	mov    %esi,(%esp)
80101bcd:	e8 1e 18 00 00       	call   801033f0 <log_write>
80101bd2:	89 75 08             	mov    %esi,0x8(%ebp)
80101bd5:	83 c4 10             	add    $0x10,%esp
80101bd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101bdb:	5b                   	pop    %ebx
80101bdc:	5e                   	pop    %esi
80101bdd:	5d                   	pop    %ebp
80101bde:	e9 0d e6 ff ff       	jmp    801001f0 <brelse>
80101be3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101bf0 <idup>:
80101bf0:	f3 0f 1e fb          	endbr32 
80101bf4:	55                   	push   %ebp
80101bf5:	89 e5                	mov    %esp,%ebp
80101bf7:	53                   	push   %ebx
80101bf8:	83 ec 10             	sub    $0x10,%esp
80101bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101bfe:	68 00 1a 11 80       	push   $0x80111a00
80101c03:	e8 c8 2f 00 00       	call   80104bd0 <acquire>
80101c08:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80101c0c:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101c13:	e8 78 30 00 00       	call   80104c90 <release>
80101c18:	89 d8                	mov    %ebx,%eax
80101c1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c1d:	c9                   	leave  
80101c1e:	c3                   	ret    
80101c1f:	90                   	nop

80101c20 <ilock>:
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	56                   	push   %esi
80101c28:	53                   	push   %ebx
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101c2c:	85 db                	test   %ebx,%ebx
80101c2e:	0f 84 b3 00 00 00    	je     80101ce7 <ilock+0xc7>
80101c34:	8b 53 08             	mov    0x8(%ebx),%edx
80101c37:	85 d2                	test   %edx,%edx
80101c39:	0f 8e a8 00 00 00    	jle    80101ce7 <ilock+0xc7>
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c45:	50                   	push   %eax
80101c46:	e8 05 2d 00 00       	call   80104950 <acquiresleep>
80101c4b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101c4e:	83 c4 10             	add    $0x10,%esp
80101c51:	85 c0                	test   %eax,%eax
80101c53:	74 0b                	je     80101c60 <ilock+0x40>
80101c55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c58:	5b                   	pop    %ebx
80101c59:	5e                   	pop    %esi
80101c5a:	5d                   	pop    %ebp
80101c5b:	c3                   	ret    
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c60:	8b 43 04             	mov    0x4(%ebx),%eax
80101c63:	83 ec 08             	sub    $0x8,%esp
80101c66:	c1 e8 03             	shr    $0x3,%eax
80101c69:	03 05 f4 19 11 80    	add    0x801119f4,%eax
80101c6f:	50                   	push   %eax
80101c70:	ff 33                	pushl  (%ebx)
80101c72:	e8 59 e4 ff ff       	call   801000d0 <bread>
80101c77:	83 c4 0c             	add    $0xc,%esp
80101c7a:	89 c6                	mov    %eax,%esi
80101c7c:	8b 43 04             	mov    0x4(%ebx),%eax
80101c7f:	83 e0 07             	and    $0x7,%eax
80101c82:	c1 e0 06             	shl    $0x6,%eax
80101c85:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101c89:	0f b7 10             	movzwl (%eax),%edx
80101c8c:	83 c0 0c             	add    $0xc,%eax
80101c8f:	66 89 53 50          	mov    %dx,0x50(%ebx)
80101c93:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101c97:	66 89 53 52          	mov    %dx,0x52(%ebx)
80101c9b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101c9f:	66 89 53 54          	mov    %dx,0x54(%ebx)
80101ca3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101ca7:	66 89 53 56          	mov    %dx,0x56(%ebx)
80101cab:	8b 50 fc             	mov    -0x4(%eax),%edx
80101cae:	89 53 58             	mov    %edx,0x58(%ebx)
80101cb1:	6a 34                	push   $0x34
80101cb3:	50                   	push   %eax
80101cb4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101cb7:	50                   	push   %eax
80101cb8:	e8 c3 30 00 00       	call   80104d80 <memmove>
80101cbd:	89 34 24             	mov    %esi,(%esp)
80101cc0:	e8 2b e5 ff ff       	call   801001f0 <brelse>
80101cc5:	83 c4 10             	add    $0x10,%esp
80101cc8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
80101ccd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
80101cd4:	0f 85 7b ff ff ff    	jne    80101c55 <ilock+0x35>
80101cda:	83 ec 0c             	sub    $0xc,%esp
80101cdd:	68 88 7a 10 80       	push   $0x80107a88
80101ce2:	e8 a9 e6 ff ff       	call   80100390 <panic>
80101ce7:	83 ec 0c             	sub    $0xc,%esp
80101cea:	68 82 7a 10 80       	push   $0x80107a82
80101cef:	e8 9c e6 ff ff       	call   80100390 <panic>
80101cf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cff:	90                   	nop

80101d00 <iunlock>:
80101d00:	f3 0f 1e fb          	endbr32 
80101d04:	55                   	push   %ebp
80101d05:	89 e5                	mov    %esp,%ebp
80101d07:	56                   	push   %esi
80101d08:	53                   	push   %ebx
80101d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d0c:	85 db                	test   %ebx,%ebx
80101d0e:	74 28                	je     80101d38 <iunlock+0x38>
80101d10:	83 ec 0c             	sub    $0xc,%esp
80101d13:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d16:	56                   	push   %esi
80101d17:	e8 d4 2c 00 00       	call   801049f0 <holdingsleep>
80101d1c:	83 c4 10             	add    $0x10,%esp
80101d1f:	85 c0                	test   %eax,%eax
80101d21:	74 15                	je     80101d38 <iunlock+0x38>
80101d23:	8b 43 08             	mov    0x8(%ebx),%eax
80101d26:	85 c0                	test   %eax,%eax
80101d28:	7e 0e                	jle    80101d38 <iunlock+0x38>
80101d2a:	89 75 08             	mov    %esi,0x8(%ebp)
80101d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d30:	5b                   	pop    %ebx
80101d31:	5e                   	pop    %esi
80101d32:	5d                   	pop    %ebp
80101d33:	e9 78 2c 00 00       	jmp    801049b0 <releasesleep>
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	68 97 7a 10 80       	push   $0x80107a97
80101d40:	e8 4b e6 ff ff       	call   80100390 <panic>
80101d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d50 <iput>:
80101d50:	f3 0f 1e fb          	endbr32 
80101d54:	55                   	push   %ebp
80101d55:	89 e5                	mov    %esp,%ebp
80101d57:	57                   	push   %edi
80101d58:	56                   	push   %esi
80101d59:	53                   	push   %ebx
80101d5a:	83 ec 28             	sub    $0x28,%esp
80101d5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101d60:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101d63:	57                   	push   %edi
80101d64:	e8 e7 2b 00 00       	call   80104950 <acquiresleep>
80101d69:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101d6c:	83 c4 10             	add    $0x10,%esp
80101d6f:	85 d2                	test   %edx,%edx
80101d71:	74 07                	je     80101d7a <iput+0x2a>
80101d73:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101d78:	74 36                	je     80101db0 <iput+0x60>
80101d7a:	83 ec 0c             	sub    $0xc,%esp
80101d7d:	57                   	push   %edi
80101d7e:	e8 2d 2c 00 00       	call   801049b0 <releasesleep>
80101d83:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101d8a:	e8 41 2e 00 00       	call   80104bd0 <acquire>
80101d8f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c7 45 08 00 1a 11 80 	movl   $0x80111a00,0x8(%ebp)
80101d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da0:	5b                   	pop    %ebx
80101da1:	5e                   	pop    %esi
80101da2:	5f                   	pop    %edi
80101da3:	5d                   	pop    %ebp
80101da4:	e9 e7 2e 00 00       	jmp    80104c90 <release>
80101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	68 00 1a 11 80       	push   $0x80111a00
80101db8:	e8 13 2e 00 00       	call   80104bd0 <acquire>
80101dbd:	8b 73 08             	mov    0x8(%ebx),%esi
80101dc0:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
80101dc7:	e8 c4 2e 00 00       	call   80104c90 <release>
80101dcc:	83 c4 10             	add    $0x10,%esp
80101dcf:	83 fe 01             	cmp    $0x1,%esi
80101dd2:	75 a6                	jne    80101d7a <iput+0x2a>
80101dd4:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101dda:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ddd:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101de0:	89 cf                	mov    %ecx,%edi
80101de2:	eb 0b                	jmp    80101def <iput+0x9f>
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101de8:	83 c6 04             	add    $0x4,%esi
80101deb:	39 fe                	cmp    %edi,%esi
80101ded:	74 19                	je     80101e08 <iput+0xb8>
80101def:	8b 16                	mov    (%esi),%edx
80101df1:	85 d2                	test   %edx,%edx
80101df3:	74 f3                	je     80101de8 <iput+0x98>
80101df5:	8b 03                	mov    (%ebx),%eax
80101df7:	e8 74 f8 ff ff       	call   80101670 <bfree>
80101dfc:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101e02:	eb e4                	jmp    80101de8 <iput+0x98>
80101e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e08:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101e0e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e11:	85 c0                	test   %eax,%eax
80101e13:	75 33                	jne    80101e48 <iput+0xf8>
80101e15:	83 ec 0c             	sub    $0xc,%esp
80101e18:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80101e1f:	53                   	push   %ebx
80101e20:	e8 3b fd ff ff       	call   80101b60 <iupdate>
80101e25:	31 c0                	xor    %eax,%eax
80101e27:	66 89 43 50          	mov    %ax,0x50(%ebx)
80101e2b:	89 1c 24             	mov    %ebx,(%esp)
80101e2e:	e8 2d fd ff ff       	call   80101b60 <iupdate>
80101e33:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101e3a:	83 c4 10             	add    $0x10,%esp
80101e3d:	e9 38 ff ff ff       	jmp    80101d7a <iput+0x2a>
80101e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101e48:	83 ec 08             	sub    $0x8,%esp
80101e4b:	50                   	push   %eax
80101e4c:	ff 33                	pushl  (%ebx)
80101e4e:	e8 7d e2 ff ff       	call   801000d0 <bread>
80101e53:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e56:	83 c4 10             	add    $0x10,%esp
80101e59:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101e62:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e65:	89 cf                	mov    %ecx,%edi
80101e67:	eb 0e                	jmp    80101e77 <iput+0x127>
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e70:	83 c6 04             	add    $0x4,%esi
80101e73:	39 f7                	cmp    %esi,%edi
80101e75:	74 19                	je     80101e90 <iput+0x140>
80101e77:	8b 16                	mov    (%esi),%edx
80101e79:	85 d2                	test   %edx,%edx
80101e7b:	74 f3                	je     80101e70 <iput+0x120>
80101e7d:	8b 03                	mov    (%ebx),%eax
80101e7f:	e8 ec f7 ff ff       	call   80101670 <bfree>
80101e84:	eb ea                	jmp    80101e70 <iput+0x120>
80101e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e8d:	8d 76 00             	lea    0x0(%esi),%esi
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e96:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e99:	e8 52 e3 ff ff       	call   801001f0 <brelse>
80101e9e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101ea4:	8b 03                	mov    (%ebx),%eax
80101ea6:	e8 c5 f7 ff ff       	call   80101670 <bfree>
80101eab:	83 c4 10             	add    $0x10,%esp
80101eae:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101eb5:	00 00 00 
80101eb8:	e9 58 ff ff ff       	jmp    80101e15 <iput+0xc5>
80101ebd:	8d 76 00             	lea    0x0(%esi),%esi

80101ec0 <iunlockput>:
80101ec0:	f3 0f 1e fb          	endbr32 
80101ec4:	55                   	push   %ebp
80101ec5:	89 e5                	mov    %esp,%ebp
80101ec7:	53                   	push   %ebx
80101ec8:	83 ec 10             	sub    $0x10,%esp
80101ecb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ece:	53                   	push   %ebx
80101ecf:	e8 2c fe ff ff       	call   80101d00 <iunlock>
80101ed4:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101ed7:	83 c4 10             	add    $0x10,%esp
80101eda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101edd:	c9                   	leave  
80101ede:	e9 6d fe ff ff       	jmp    80101d50 <iput>
80101ee3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ef0 <stati>:
80101ef0:	f3 0f 1e fb          	endbr32 
80101ef4:	55                   	push   %ebp
80101ef5:	89 e5                	mov    %esp,%ebp
80101ef7:	8b 55 08             	mov    0x8(%ebp),%edx
80101efa:	8b 45 0c             	mov    0xc(%ebp),%eax
80101efd:	8b 0a                	mov    (%edx),%ecx
80101eff:	89 48 04             	mov    %ecx,0x4(%eax)
80101f02:	8b 4a 04             	mov    0x4(%edx),%ecx
80101f05:	89 48 08             	mov    %ecx,0x8(%eax)
80101f08:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101f0c:	66 89 08             	mov    %cx,(%eax)
80101f0f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101f13:	66 89 48 0c          	mov    %cx,0xc(%eax)
80101f17:	8b 52 58             	mov    0x58(%edx),%edx
80101f1a:	89 50 10             	mov    %edx,0x10(%eax)
80101f1d:	5d                   	pop    %ebp
80101f1e:	c3                   	ret    
80101f1f:	90                   	nop

80101f20 <readi>:
80101f20:	f3 0f 1e fb          	endbr32 
80101f24:	55                   	push   %ebp
80101f25:	89 e5                	mov    %esp,%ebp
80101f27:	57                   	push   %edi
80101f28:	56                   	push   %esi
80101f29:	53                   	push   %ebx
80101f2a:	83 ec 1c             	sub    $0x1c,%esp
80101f2d:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101f30:	8b 45 08             	mov    0x8(%ebp),%eax
80101f33:	8b 75 10             	mov    0x10(%ebp),%esi
80101f36:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101f39:	8b 7d 14             	mov    0x14(%ebp),%edi
80101f3c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80101f41:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f44:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101f47:	0f 84 a3 00 00 00    	je     80101ff0 <readi+0xd0>
80101f4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f50:	8b 40 58             	mov    0x58(%eax),%eax
80101f53:	39 c6                	cmp    %eax,%esi
80101f55:	0f 87 b6 00 00 00    	ja     80102011 <readi+0xf1>
80101f5b:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f5e:	31 c9                	xor    %ecx,%ecx
80101f60:	89 da                	mov    %ebx,%edx
80101f62:	01 f2                	add    %esi,%edx
80101f64:	0f 92 c1             	setb   %cl
80101f67:	89 cf                	mov    %ecx,%edi
80101f69:	0f 82 a2 00 00 00    	jb     80102011 <readi+0xf1>
80101f6f:	89 c1                	mov    %eax,%ecx
80101f71:	29 f1                	sub    %esi,%ecx
80101f73:	39 d0                	cmp    %edx,%eax
80101f75:	0f 43 cb             	cmovae %ebx,%ecx
80101f78:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101f7b:	85 c9                	test   %ecx,%ecx
80101f7d:	74 63                	je     80101fe2 <readi+0xc2>
80101f7f:	90                   	nop
80101f80:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101f83:	89 f2                	mov    %esi,%edx
80101f85:	c1 ea 09             	shr    $0x9,%edx
80101f88:	89 d8                	mov    %ebx,%eax
80101f8a:	e8 61 f9 ff ff       	call   801018f0 <bmap>
80101f8f:	83 ec 08             	sub    $0x8,%esp
80101f92:	50                   	push   %eax
80101f93:	ff 33                	pushl  (%ebx)
80101f95:	e8 36 e1 ff ff       	call   801000d0 <bread>
80101f9a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f9d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101fa2:	83 c4 0c             	add    $0xc,%esp
80101fa5:	89 c2                	mov    %eax,%edx
80101fa7:	89 f0                	mov    %esi,%eax
80101fa9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fae:	29 fb                	sub    %edi,%ebx
80101fb0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101fb3:	29 c1                	sub    %eax,%ecx
80101fb5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101fb9:	39 d9                	cmp    %ebx,%ecx
80101fbb:	0f 46 d9             	cmovbe %ecx,%ebx
80101fbe:	53                   	push   %ebx
80101fbf:	01 df                	add    %ebx,%edi
80101fc1:	01 de                	add    %ebx,%esi
80101fc3:	50                   	push   %eax
80101fc4:	ff 75 e0             	pushl  -0x20(%ebp)
80101fc7:	e8 b4 2d 00 00       	call   80104d80 <memmove>
80101fcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fcf:	89 14 24             	mov    %edx,(%esp)
80101fd2:	e8 19 e2 ff ff       	call   801001f0 <brelse>
80101fd7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101fda:	83 c4 10             	add    $0x10,%esp
80101fdd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101fe0:	77 9e                	ja     80101f80 <readi+0x60>
80101fe2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101fe5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe8:	5b                   	pop    %ebx
80101fe9:	5e                   	pop    %esi
80101fea:	5f                   	pop    %edi
80101feb:	5d                   	pop    %ebp
80101fec:	c3                   	ret    
80101fed:	8d 76 00             	lea    0x0(%esi),%esi
80101ff0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ff4:	66 83 f8 09          	cmp    $0x9,%ax
80101ff8:	77 17                	ja     80102011 <readi+0xf1>
80101ffa:	8b 04 c5 80 19 11 80 	mov    -0x7feee680(,%eax,8),%eax
80102001:	85 c0                	test   %eax,%eax
80102003:	74 0c                	je     80102011 <readi+0xf1>
80102005:	89 7d 10             	mov    %edi,0x10(%ebp)
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
8010200f:	ff e0                	jmp    *%eax
80102011:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102016:	eb cd                	jmp    80101fe5 <readi+0xc5>
80102018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010201f:	90                   	nop

80102020 <writei>:
80102020:	f3 0f 1e fb          	endbr32 
80102024:	55                   	push   %ebp
80102025:	89 e5                	mov    %esp,%ebp
80102027:	57                   	push   %edi
80102028:	56                   	push   %esi
80102029:	53                   	push   %ebx
8010202a:	83 ec 1c             	sub    $0x1c,%esp
8010202d:	8b 45 08             	mov    0x8(%ebp),%eax
80102030:	8b 75 0c             	mov    0xc(%ebp),%esi
80102033:	8b 7d 14             	mov    0x14(%ebp),%edi
80102036:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
8010203b:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010203e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102041:	8b 75 10             	mov    0x10(%ebp),%esi
80102044:	89 7d e0             	mov    %edi,-0x20(%ebp)
80102047:	0f 84 b3 00 00 00    	je     80102100 <writei+0xe0>
8010204d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102050:	39 70 58             	cmp    %esi,0x58(%eax)
80102053:	0f 82 e3 00 00 00    	jb     8010213c <writei+0x11c>
80102059:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010205c:	89 f8                	mov    %edi,%eax
8010205e:	01 f0                	add    %esi,%eax
80102060:	0f 82 d6 00 00 00    	jb     8010213c <writei+0x11c>
80102066:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010206b:	0f 87 cb 00 00 00    	ja     8010213c <writei+0x11c>
80102071:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102078:	85 ff                	test   %edi,%edi
8010207a:	74 75                	je     801020f1 <writei+0xd1>
8010207c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102080:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102083:	89 f2                	mov    %esi,%edx
80102085:	c1 ea 09             	shr    $0x9,%edx
80102088:	89 f8                	mov    %edi,%eax
8010208a:	e8 61 f8 ff ff       	call   801018f0 <bmap>
8010208f:	83 ec 08             	sub    $0x8,%esp
80102092:	50                   	push   %eax
80102093:	ff 37                	pushl  (%edi)
80102095:	e8 36 e0 ff ff       	call   801000d0 <bread>
8010209a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010209f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020a2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
801020a5:	89 c7                	mov    %eax,%edi
801020a7:	89 f0                	mov    %esi,%eax
801020a9:	83 c4 0c             	add    $0xc,%esp
801020ac:	25 ff 01 00 00       	and    $0x1ff,%eax
801020b1:	29 c1                	sub    %eax,%ecx
801020b3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
801020b7:	39 d9                	cmp    %ebx,%ecx
801020b9:	0f 46 d9             	cmovbe %ecx,%ebx
801020bc:	53                   	push   %ebx
801020bd:	01 de                	add    %ebx,%esi
801020bf:	ff 75 dc             	pushl  -0x24(%ebp)
801020c2:	50                   	push   %eax
801020c3:	e8 b8 2c 00 00       	call   80104d80 <memmove>
801020c8:	89 3c 24             	mov    %edi,(%esp)
801020cb:	e8 20 13 00 00       	call   801033f0 <log_write>
801020d0:	89 3c 24             	mov    %edi,(%esp)
801020d3:	e8 18 e1 ff ff       	call   801001f0 <brelse>
801020d8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801020db:	83 c4 10             	add    $0x10,%esp
801020de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020e1:	01 5d dc             	add    %ebx,-0x24(%ebp)
801020e4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801020e7:	77 97                	ja     80102080 <writei+0x60>
801020e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801020ec:	3b 70 58             	cmp    0x58(%eax),%esi
801020ef:	77 37                	ja     80102128 <writei+0x108>
801020f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801020f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020f7:	5b                   	pop    %ebx
801020f8:	5e                   	pop    %esi
801020f9:	5f                   	pop    %edi
801020fa:	5d                   	pop    %ebp
801020fb:	c3                   	ret    
801020fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102100:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102104:	66 83 f8 09          	cmp    $0x9,%ax
80102108:	77 32                	ja     8010213c <writei+0x11c>
8010210a:	8b 04 c5 84 19 11 80 	mov    -0x7feee67c(,%eax,8),%eax
80102111:	85 c0                	test   %eax,%eax
80102113:	74 27                	je     8010213c <writei+0x11c>
80102115:	89 7d 10             	mov    %edi,0x10(%ebp)
80102118:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010211b:	5b                   	pop    %ebx
8010211c:	5e                   	pop    %esi
8010211d:	5f                   	pop    %edi
8010211e:	5d                   	pop    %ebp
8010211f:	ff e0                	jmp    *%eax
80102121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102128:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010212b:	83 ec 0c             	sub    $0xc,%esp
8010212e:	89 70 58             	mov    %esi,0x58(%eax)
80102131:	50                   	push   %eax
80102132:	e8 29 fa ff ff       	call   80101b60 <iupdate>
80102137:	83 c4 10             	add    $0x10,%esp
8010213a:	eb b5                	jmp    801020f1 <writei+0xd1>
8010213c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102141:	eb b1                	jmp    801020f4 <writei+0xd4>
80102143:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010214a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102150 <namecmp>:
80102150:	f3 0f 1e fb          	endbr32 
80102154:	55                   	push   %ebp
80102155:	89 e5                	mov    %esp,%ebp
80102157:	83 ec 0c             	sub    $0xc,%esp
8010215a:	6a 0e                	push   $0xe
8010215c:	ff 75 0c             	pushl  0xc(%ebp)
8010215f:	ff 75 08             	pushl  0x8(%ebp)
80102162:	e8 89 2c 00 00       	call   80104df0 <strncmp>
80102167:	c9                   	leave  
80102168:	c3                   	ret    
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <dirlookup>:
80102170:	f3 0f 1e fb          	endbr32 
80102174:	55                   	push   %ebp
80102175:	89 e5                	mov    %esp,%ebp
80102177:	57                   	push   %edi
80102178:	56                   	push   %esi
80102179:	53                   	push   %ebx
8010217a:	83 ec 1c             	sub    $0x1c,%esp
8010217d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102180:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102185:	0f 85 89 00 00 00    	jne    80102214 <dirlookup+0xa4>
8010218b:	8b 53 58             	mov    0x58(%ebx),%edx
8010218e:	31 ff                	xor    %edi,%edi
80102190:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102193:	85 d2                	test   %edx,%edx
80102195:	74 42                	je     801021d9 <dirlookup+0x69>
80102197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219e:	66 90                	xchg   %ax,%ax
801021a0:	6a 10                	push   $0x10
801021a2:	57                   	push   %edi
801021a3:	56                   	push   %esi
801021a4:	53                   	push   %ebx
801021a5:	e8 76 fd ff ff       	call   80101f20 <readi>
801021aa:	83 c4 10             	add    $0x10,%esp
801021ad:	83 f8 10             	cmp    $0x10,%eax
801021b0:	75 55                	jne    80102207 <dirlookup+0x97>
801021b2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021b7:	74 18                	je     801021d1 <dirlookup+0x61>
801021b9:	83 ec 04             	sub    $0x4,%esp
801021bc:	8d 45 da             	lea    -0x26(%ebp),%eax
801021bf:	6a 0e                	push   $0xe
801021c1:	50                   	push   %eax
801021c2:	ff 75 0c             	pushl  0xc(%ebp)
801021c5:	e8 26 2c 00 00       	call   80104df0 <strncmp>
801021ca:	83 c4 10             	add    $0x10,%esp
801021cd:	85 c0                	test   %eax,%eax
801021cf:	74 17                	je     801021e8 <dirlookup+0x78>
801021d1:	83 c7 10             	add    $0x10,%edi
801021d4:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021d7:	72 c7                	jb     801021a0 <dirlookup+0x30>
801021d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021dc:	31 c0                	xor    %eax,%eax
801021de:	5b                   	pop    %ebx
801021df:	5e                   	pop    %esi
801021e0:	5f                   	pop    %edi
801021e1:	5d                   	pop    %ebp
801021e2:	c3                   	ret    
801021e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021e7:	90                   	nop
801021e8:	8b 45 10             	mov    0x10(%ebp),%eax
801021eb:	85 c0                	test   %eax,%eax
801021ed:	74 05                	je     801021f4 <dirlookup+0x84>
801021ef:	8b 45 10             	mov    0x10(%ebp),%eax
801021f2:	89 38                	mov    %edi,(%eax)
801021f4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
801021f8:	8b 03                	mov    (%ebx),%eax
801021fa:	e8 01 f6 ff ff       	call   80101800 <iget>
801021ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102202:	5b                   	pop    %ebx
80102203:	5e                   	pop    %esi
80102204:	5f                   	pop    %edi
80102205:	5d                   	pop    %ebp
80102206:	c3                   	ret    
80102207:	83 ec 0c             	sub    $0xc,%esp
8010220a:	68 b1 7a 10 80       	push   $0x80107ab1
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 9f 7a 10 80       	push   $0x80107a9f
8010221c:	e8 6f e1 ff ff       	call   80100390 <panic>
80102221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010222f:	90                   	nop

80102230 <namex>:
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	57                   	push   %edi
80102234:	56                   	push   %esi
80102235:	53                   	push   %ebx
80102236:	89 c3                	mov    %eax,%ebx
80102238:	83 ec 1c             	sub    $0x1c,%esp
8010223b:	80 38 2f             	cmpb   $0x2f,(%eax)
8010223e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102241:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102244:	0f 84 86 01 00 00    	je     801023d0 <namex+0x1a0>
8010224a:	e8 f1 1b 00 00       	call   80103e40 <myproc>
8010224f:	83 ec 0c             	sub    $0xc,%esp
80102252:	89 df                	mov    %ebx,%edi
80102254:	8b 70 6c             	mov    0x6c(%eax),%esi
80102257:	68 00 1a 11 80       	push   $0x80111a00
8010225c:	e8 6f 29 00 00       	call   80104bd0 <acquire>
80102261:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102265:	c7 04 24 00 1a 11 80 	movl   $0x80111a00,(%esp)
8010226c:	e8 1f 2a 00 00       	call   80104c90 <release>
80102271:	83 c4 10             	add    $0x10,%esp
80102274:	eb 0d                	jmp    80102283 <namex+0x53>
80102276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227d:	8d 76 00             	lea    0x0(%esi),%esi
80102280:	83 c7 01             	add    $0x1,%edi
80102283:	0f b6 07             	movzbl (%edi),%eax
80102286:	3c 2f                	cmp    $0x2f,%al
80102288:	74 f6                	je     80102280 <namex+0x50>
8010228a:	84 c0                	test   %al,%al
8010228c:	0f 84 ee 00 00 00    	je     80102380 <namex+0x150>
80102292:	0f b6 07             	movzbl (%edi),%eax
80102295:	84 c0                	test   %al,%al
80102297:	0f 84 fb 00 00 00    	je     80102398 <namex+0x168>
8010229d:	89 fb                	mov    %edi,%ebx
8010229f:	3c 2f                	cmp    $0x2f,%al
801022a1:	0f 84 f1 00 00 00    	je     80102398 <namex+0x168>
801022a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ae:	66 90                	xchg   %ax,%ax
801022b0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
801022b4:	83 c3 01             	add    $0x1,%ebx
801022b7:	3c 2f                	cmp    $0x2f,%al
801022b9:	74 04                	je     801022bf <namex+0x8f>
801022bb:	84 c0                	test   %al,%al
801022bd:	75 f1                	jne    801022b0 <namex+0x80>
801022bf:	89 d8                	mov    %ebx,%eax
801022c1:	29 f8                	sub    %edi,%eax
801022c3:	83 f8 0d             	cmp    $0xd,%eax
801022c6:	0f 8e 84 00 00 00    	jle    80102350 <namex+0x120>
801022cc:	83 ec 04             	sub    $0x4,%esp
801022cf:	6a 0e                	push   $0xe
801022d1:	57                   	push   %edi
801022d2:	89 df                	mov    %ebx,%edi
801022d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801022d7:	e8 a4 2a 00 00       	call   80104d80 <memmove>
801022dc:	83 c4 10             	add    $0x10,%esp
801022df:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801022e2:	75 0c                	jne    801022f0 <namex+0xc0>
801022e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801022e8:	83 c7 01             	add    $0x1,%edi
801022eb:	80 3f 2f             	cmpb   $0x2f,(%edi)
801022ee:	74 f8                	je     801022e8 <namex+0xb8>
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	56                   	push   %esi
801022f4:	e8 27 f9 ff ff       	call   80101c20 <ilock>
801022f9:	83 c4 10             	add    $0x10,%esp
801022fc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102301:	0f 85 a1 00 00 00    	jne    801023a8 <namex+0x178>
80102307:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010230a:	85 d2                	test   %edx,%edx
8010230c:	74 09                	je     80102317 <namex+0xe7>
8010230e:	80 3f 00             	cmpb   $0x0,(%edi)
80102311:	0f 84 d9 00 00 00    	je     801023f0 <namex+0x1c0>
80102317:	83 ec 04             	sub    $0x4,%esp
8010231a:	6a 00                	push   $0x0
8010231c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010231f:	56                   	push   %esi
80102320:	e8 4b fe ff ff       	call   80102170 <dirlookup>
80102325:	83 c4 10             	add    $0x10,%esp
80102328:	89 c3                	mov    %eax,%ebx
8010232a:	85 c0                	test   %eax,%eax
8010232c:	74 7a                	je     801023a8 <namex+0x178>
8010232e:	83 ec 0c             	sub    $0xc,%esp
80102331:	56                   	push   %esi
80102332:	e8 c9 f9 ff ff       	call   80101d00 <iunlock>
80102337:	89 34 24             	mov    %esi,(%esp)
8010233a:	89 de                	mov    %ebx,%esi
8010233c:	e8 0f fa ff ff       	call   80101d50 <iput>
80102341:	83 c4 10             	add    $0x10,%esp
80102344:	e9 3a ff ff ff       	jmp    80102283 <namex+0x53>
80102349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102350:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102353:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102356:	89 4d dc             	mov    %ecx,-0x24(%ebp)
80102359:	83 ec 04             	sub    $0x4,%esp
8010235c:	50                   	push   %eax
8010235d:	57                   	push   %edi
8010235e:	89 df                	mov    %ebx,%edi
80102360:	ff 75 e4             	pushl  -0x1c(%ebp)
80102363:	e8 18 2a 00 00       	call   80104d80 <memmove>
80102368:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010236b:	83 c4 10             	add    $0x10,%esp
8010236e:	c6 00 00             	movb   $0x0,(%eax)
80102371:	e9 69 ff ff ff       	jmp    801022df <namex+0xaf>
80102376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010237d:	8d 76 00             	lea    0x0(%esi),%esi
80102380:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102383:	85 c0                	test   %eax,%eax
80102385:	0f 85 85 00 00 00    	jne    80102410 <namex+0x1e0>
8010238b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010238e:	89 f0                	mov    %esi,%eax
80102390:	5b                   	pop    %ebx
80102391:	5e                   	pop    %esi
80102392:	5f                   	pop    %edi
80102393:	5d                   	pop    %ebp
80102394:	c3                   	ret    
80102395:	8d 76 00             	lea    0x0(%esi),%esi
80102398:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010239b:	89 fb                	mov    %edi,%ebx
8010239d:	89 45 dc             	mov    %eax,-0x24(%ebp)
801023a0:	31 c0                	xor    %eax,%eax
801023a2:	eb b5                	jmp    80102359 <namex+0x129>
801023a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801023a8:	83 ec 0c             	sub    $0xc,%esp
801023ab:	56                   	push   %esi
801023ac:	e8 4f f9 ff ff       	call   80101d00 <iunlock>
801023b1:	89 34 24             	mov    %esi,(%esp)
801023b4:	31 f6                	xor    %esi,%esi
801023b6:	e8 95 f9 ff ff       	call   80101d50 <iput>
801023bb:	83 c4 10             	add    $0x10,%esp
801023be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023c1:	89 f0                	mov    %esi,%eax
801023c3:	5b                   	pop    %ebx
801023c4:	5e                   	pop    %esi
801023c5:	5f                   	pop    %edi
801023c6:	5d                   	pop    %ebp
801023c7:	c3                   	ret    
801023c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023cf:	90                   	nop
801023d0:	ba 01 00 00 00       	mov    $0x1,%edx
801023d5:	b8 01 00 00 00       	mov    $0x1,%eax
801023da:	89 df                	mov    %ebx,%edi
801023dc:	e8 1f f4 ff ff       	call   80101800 <iget>
801023e1:	89 c6                	mov    %eax,%esi
801023e3:	e9 9b fe ff ff       	jmp    80102283 <namex+0x53>
801023e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ef:	90                   	nop
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	56                   	push   %esi
801023f4:	e8 07 f9 ff ff       	call   80101d00 <iunlock>
801023f9:	83 c4 10             	add    $0x10,%esp
801023fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023ff:	89 f0                	mov    %esi,%eax
80102401:	5b                   	pop    %ebx
80102402:	5e                   	pop    %esi
80102403:	5f                   	pop    %edi
80102404:	5d                   	pop    %ebp
80102405:	c3                   	ret    
80102406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010240d:	8d 76 00             	lea    0x0(%esi),%esi
80102410:	83 ec 0c             	sub    $0xc,%esp
80102413:	56                   	push   %esi
80102414:	31 f6                	xor    %esi,%esi
80102416:	e8 35 f9 ff ff       	call   80101d50 <iput>
8010241b:	83 c4 10             	add    $0x10,%esp
8010241e:	e9 68 ff ff ff       	jmp    8010238b <namex+0x15b>
80102423:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010242a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102430 <dirlink>:
80102430:	f3 0f 1e fb          	endbr32 
80102434:	55                   	push   %ebp
80102435:	89 e5                	mov    %esp,%ebp
80102437:	57                   	push   %edi
80102438:	56                   	push   %esi
80102439:	53                   	push   %ebx
8010243a:	83 ec 20             	sub    $0x20,%esp
8010243d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102440:	6a 00                	push   $0x0
80102442:	ff 75 0c             	pushl  0xc(%ebp)
80102445:	53                   	push   %ebx
80102446:	e8 25 fd ff ff       	call   80102170 <dirlookup>
8010244b:	83 c4 10             	add    $0x10,%esp
8010244e:	85 c0                	test   %eax,%eax
80102450:	75 6b                	jne    801024bd <dirlink+0x8d>
80102452:	8b 7b 58             	mov    0x58(%ebx),%edi
80102455:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102458:	85 ff                	test   %edi,%edi
8010245a:	74 2d                	je     80102489 <dirlink+0x59>
8010245c:	31 ff                	xor    %edi,%edi
8010245e:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102461:	eb 0d                	jmp    80102470 <dirlink+0x40>
80102463:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102467:	90                   	nop
80102468:	83 c7 10             	add    $0x10,%edi
8010246b:	3b 7b 58             	cmp    0x58(%ebx),%edi
8010246e:	73 19                	jae    80102489 <dirlink+0x59>
80102470:	6a 10                	push   $0x10
80102472:	57                   	push   %edi
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
80102475:	e8 a6 fa ff ff       	call   80101f20 <readi>
8010247a:	83 c4 10             	add    $0x10,%esp
8010247d:	83 f8 10             	cmp    $0x10,%eax
80102480:	75 4e                	jne    801024d0 <dirlink+0xa0>
80102482:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102487:	75 df                	jne    80102468 <dirlink+0x38>
80102489:	83 ec 04             	sub    $0x4,%esp
8010248c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010248f:	6a 0e                	push   $0xe
80102491:	ff 75 0c             	pushl  0xc(%ebp)
80102494:	50                   	push   %eax
80102495:	e8 a6 29 00 00       	call   80104e40 <strncpy>
8010249a:	6a 10                	push   $0x10
8010249c:	8b 45 10             	mov    0x10(%ebp),%eax
8010249f:	57                   	push   %edi
801024a0:	56                   	push   %esi
801024a1:	53                   	push   %ebx
801024a2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
801024a6:	e8 75 fb ff ff       	call   80102020 <writei>
801024ab:	83 c4 20             	add    $0x20,%esp
801024ae:	83 f8 10             	cmp    $0x10,%eax
801024b1:	75 2a                	jne    801024dd <dirlink+0xad>
801024b3:	31 c0                	xor    %eax,%eax
801024b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024b8:	5b                   	pop    %ebx
801024b9:	5e                   	pop    %esi
801024ba:	5f                   	pop    %edi
801024bb:	5d                   	pop    %ebp
801024bc:	c3                   	ret    
801024bd:	83 ec 0c             	sub    $0xc,%esp
801024c0:	50                   	push   %eax
801024c1:	e8 8a f8 ff ff       	call   80101d50 <iput>
801024c6:	83 c4 10             	add    $0x10,%esp
801024c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024ce:	eb e5                	jmp    801024b5 <dirlink+0x85>
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 c0 7a 10 80       	push   $0x80107ac0
801024d8:	e8 b3 de ff ff       	call   80100390 <panic>
801024dd:	83 ec 0c             	sub    $0xc,%esp
801024e0:	68 b2 80 10 80       	push   $0x801080b2
801024e5:	e8 a6 de ff ff       	call   80100390 <panic>
801024ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801024f0 <namei>:
801024f0:	f3 0f 1e fb          	endbr32 
801024f4:	55                   	push   %ebp
801024f5:	31 d2                	xor    %edx,%edx
801024f7:	89 e5                	mov    %esp,%ebp
801024f9:	83 ec 18             	sub    $0x18,%esp
801024fc:	8b 45 08             	mov    0x8(%ebp),%eax
801024ff:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102502:	e8 29 fd ff ff       	call   80102230 <namex>
80102507:	c9                   	leave  
80102508:	c3                   	ret    
80102509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102510 <nameiparent>:
80102510:	f3 0f 1e fb          	endbr32 
80102514:	55                   	push   %ebp
80102515:	ba 01 00 00 00       	mov    $0x1,%edx
8010251a:	89 e5                	mov    %esp,%ebp
8010251c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010251f:	8b 45 08             	mov    0x8(%ebp),%eax
80102522:	5d                   	pop    %ebp
80102523:	e9 08 fd ff ff       	jmp    80102230 <namex>
80102528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010252f:	90                   	nop

80102530 <getbmap>:
80102530:	f3 0f 1e fb          	endbr32 
80102534:	55                   	push   %ebp
80102535:	89 e5                	mov    %esp,%ebp
80102537:	8b 55 0c             	mov    0xc(%ebp),%edx
8010253a:	8b 45 08             	mov    0x8(%ebp),%eax
8010253d:	5d                   	pop    %ebp
8010253e:	e9 ad f3 ff ff       	jmp    801018f0 <bmap>
80102543:	66 90                	xchg   %ax,%ax
80102545:	66 90                	xchg   %ax,%ax
80102547:	66 90                	xchg   %ax,%ax
80102549:	66 90                	xchg   %ax,%ax
8010254b:	66 90                	xchg   %ax,%ax
8010254d:	66 90                	xchg   %ax,%ax
8010254f:	90                   	nop

80102550 <idestart>:
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	57                   	push   %edi
80102554:	56                   	push   %esi
80102555:	53                   	push   %ebx
80102556:	83 ec 0c             	sub    $0xc,%esp
80102559:	85 c0                	test   %eax,%eax
8010255b:	0f 84 b4 00 00 00    	je     80102615 <idestart+0xc5>
80102561:	8b 70 08             	mov    0x8(%eax),%esi
80102564:	89 c3                	mov    %eax,%ebx
80102566:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010256c:	0f 87 96 00 00 00    	ja     80102608 <idestart+0xb8>
80102572:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010257e:	66 90                	xchg   %ax,%ax
80102580:	89 ca                	mov    %ecx,%edx
80102582:	ec                   	in     (%dx),%al
80102583:	83 e0 c0             	and    $0xffffffc0,%eax
80102586:	3c 40                	cmp    $0x40,%al
80102588:	75 f6                	jne    80102580 <idestart+0x30>
8010258a:	31 ff                	xor    %edi,%edi
8010258c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102591:	89 f8                	mov    %edi,%eax
80102593:	ee                   	out    %al,(%dx)
80102594:	b8 01 00 00 00       	mov    $0x1,%eax
80102599:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010259e:	ee                   	out    %al,(%dx)
8010259f:	ba f3 01 00 00       	mov    $0x1f3,%edx
801025a4:	89 f0                	mov    %esi,%eax
801025a6:	ee                   	out    %al,(%dx)
801025a7:	89 f0                	mov    %esi,%eax
801025a9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025ae:	c1 f8 08             	sar    $0x8,%eax
801025b1:	ee                   	out    %al,(%dx)
801025b2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025b7:	89 f8                	mov    %edi,%eax
801025b9:	ee                   	out    %al,(%dx)
801025ba:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801025be:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025c3:	c1 e0 04             	shl    $0x4,%eax
801025c6:	83 e0 10             	and    $0x10,%eax
801025c9:	83 c8 e0             	or     $0xffffffe0,%eax
801025cc:	ee                   	out    %al,(%dx)
801025cd:	f6 03 04             	testb  $0x4,(%ebx)
801025d0:	75 16                	jne    801025e8 <idestart+0x98>
801025d2:	b8 20 00 00 00       	mov    $0x20,%eax
801025d7:	89 ca                	mov    %ecx,%edx
801025d9:	ee                   	out    %al,(%dx)
801025da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025dd:	5b                   	pop    %ebx
801025de:	5e                   	pop    %esi
801025df:	5f                   	pop    %edi
801025e0:	5d                   	pop    %ebp
801025e1:	c3                   	ret    
801025e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801025e8:	b8 30 00 00 00       	mov    $0x30,%eax
801025ed:	89 ca                	mov    %ecx,%edx
801025ef:	ee                   	out    %al,(%dx)
801025f0:	b9 80 00 00 00       	mov    $0x80,%ecx
801025f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801025f8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025fd:	fc                   	cld    
801025fe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
80102600:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102603:	5b                   	pop    %ebx
80102604:	5e                   	pop    %esi
80102605:	5f                   	pop    %edi
80102606:	5d                   	pop    %ebp
80102607:	c3                   	ret    
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	68 2c 7b 10 80       	push   $0x80107b2c
80102610:	e8 7b dd ff ff       	call   80100390 <panic>
80102615:	83 ec 0c             	sub    $0xc,%esp
80102618:	68 23 7b 10 80       	push   $0x80107b23
8010261d:	e8 6e dd ff ff       	call   80100390 <panic>
80102622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102630 <ideinit>:
80102630:	f3 0f 1e fb          	endbr32 
80102634:	55                   	push   %ebp
80102635:	89 e5                	mov    %esp,%ebp
80102637:	83 ec 10             	sub    $0x10,%esp
8010263a:	68 3e 7b 10 80       	push   $0x80107b3e
8010263f:	68 a0 b5 10 80       	push   $0x8010b5a0
80102644:	e8 07 24 00 00       	call   80104a50 <initlock>
80102649:	58                   	pop    %eax
8010264a:	a1 20 3d 11 80       	mov    0x80113d20,%eax
8010264f:	5a                   	pop    %edx
80102650:	83 e8 01             	sub    $0x1,%eax
80102653:	50                   	push   %eax
80102654:	6a 0e                	push   $0xe
80102656:	e8 b5 02 00 00       	call   80102910 <ioapicenable>
8010265b:	83 c4 10             	add    $0x10,%esp
8010265e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102663:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102667:	90                   	nop
80102668:	ec                   	in     (%dx),%al
80102669:	83 e0 c0             	and    $0xffffffc0,%eax
8010266c:	3c 40                	cmp    $0x40,%al
8010266e:	75 f8                	jne    80102668 <ideinit+0x38>
80102670:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102675:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010267a:	ee                   	out    %al,(%dx)
8010267b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102680:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102685:	eb 0e                	jmp    80102695 <ideinit+0x65>
80102687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268e:	66 90                	xchg   %ax,%ax
80102690:	83 e9 01             	sub    $0x1,%ecx
80102693:	74 0f                	je     801026a4 <ideinit+0x74>
80102695:	ec                   	in     (%dx),%al
80102696:	84 c0                	test   %al,%al
80102698:	74 f6                	je     80102690 <ideinit+0x60>
8010269a:	c7 05 80 b5 10 80 01 	movl   $0x1,0x8010b580
801026a1:	00 00 00 
801026a4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026a9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026ae:	ee                   	out    %al,(%dx)
801026af:	c9                   	leave  
801026b0:	c3                   	ret    
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026bf:	90                   	nop

801026c0 <ideintr>:
801026c0:	f3 0f 1e fb          	endbr32 
801026c4:	55                   	push   %ebp
801026c5:	89 e5                	mov    %esp,%ebp
801026c7:	57                   	push   %edi
801026c8:	56                   	push   %esi
801026c9:	53                   	push   %ebx
801026ca:	83 ec 18             	sub    $0x18,%esp
801026cd:	68 a0 b5 10 80       	push   $0x8010b5a0
801026d2:	e8 f9 24 00 00       	call   80104bd0 <acquire>
801026d7:	8b 1d 84 b5 10 80    	mov    0x8010b584,%ebx
801026dd:	83 c4 10             	add    $0x10,%esp
801026e0:	85 db                	test   %ebx,%ebx
801026e2:	74 5f                	je     80102743 <ideintr+0x83>
801026e4:	8b 43 58             	mov    0x58(%ebx),%eax
801026e7:	a3 84 b5 10 80       	mov    %eax,0x8010b584
801026ec:	8b 33                	mov    (%ebx),%esi
801026ee:	f7 c6 04 00 00 00    	test   $0x4,%esi
801026f4:	75 2b                	jne    80102721 <ideintr+0x61>
801026f6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026ff:	90                   	nop
80102700:	ec                   	in     (%dx),%al
80102701:	89 c1                	mov    %eax,%ecx
80102703:	83 e1 c0             	and    $0xffffffc0,%ecx
80102706:	80 f9 40             	cmp    $0x40,%cl
80102709:	75 f5                	jne    80102700 <ideintr+0x40>
8010270b:	a8 21                	test   $0x21,%al
8010270d:	75 12                	jne    80102721 <ideintr+0x61>
8010270f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102712:	b9 80 00 00 00       	mov    $0x80,%ecx
80102717:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010271c:	fc                   	cld    
8010271d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010271f:	8b 33                	mov    (%ebx),%esi
80102721:	83 e6 fb             	and    $0xfffffffb,%esi
80102724:	83 ec 0c             	sub    $0xc,%esp
80102727:	83 ce 02             	or     $0x2,%esi
8010272a:	89 33                	mov    %esi,(%ebx)
8010272c:	53                   	push   %ebx
8010272d:	e8 9e 1e 00 00       	call   801045d0 <wakeup>
80102732:	a1 84 b5 10 80       	mov    0x8010b584,%eax
80102737:	83 c4 10             	add    $0x10,%esp
8010273a:	85 c0                	test   %eax,%eax
8010273c:	74 05                	je     80102743 <ideintr+0x83>
8010273e:	e8 0d fe ff ff       	call   80102550 <idestart>
80102743:	83 ec 0c             	sub    $0xc,%esp
80102746:	68 a0 b5 10 80       	push   $0x8010b5a0
8010274b:	e8 40 25 00 00       	call   80104c90 <release>
80102750:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102753:	5b                   	pop    %ebx
80102754:	5e                   	pop    %esi
80102755:	5f                   	pop    %edi
80102756:	5d                   	pop    %ebp
80102757:	c3                   	ret    
80102758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010275f:	90                   	nop

80102760 <iderw>:
80102760:	f3 0f 1e fb          	endbr32 
80102764:	55                   	push   %ebp
80102765:	89 e5                	mov    %esp,%ebp
80102767:	53                   	push   %ebx
80102768:	83 ec 10             	sub    $0x10,%esp
8010276b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010276e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102771:	50                   	push   %eax
80102772:	e8 79 22 00 00       	call   801049f0 <holdingsleep>
80102777:	83 c4 10             	add    $0x10,%esp
8010277a:	85 c0                	test   %eax,%eax
8010277c:	0f 84 cf 00 00 00    	je     80102851 <iderw+0xf1>
80102782:	8b 03                	mov    (%ebx),%eax
80102784:	83 e0 06             	and    $0x6,%eax
80102787:	83 f8 02             	cmp    $0x2,%eax
8010278a:	0f 84 b4 00 00 00    	je     80102844 <iderw+0xe4>
80102790:	8b 53 04             	mov    0x4(%ebx),%edx
80102793:	85 d2                	test   %edx,%edx
80102795:	74 0d                	je     801027a4 <iderw+0x44>
80102797:	a1 80 b5 10 80       	mov    0x8010b580,%eax
8010279c:	85 c0                	test   %eax,%eax
8010279e:	0f 84 93 00 00 00    	je     80102837 <iderw+0xd7>
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 a0 b5 10 80       	push   $0x8010b5a0
801027ac:	e8 1f 24 00 00       	call   80104bd0 <acquire>
801027b1:	a1 84 b5 10 80       	mov    0x8010b584,%eax
801027b6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
801027bd:	83 c4 10             	add    $0x10,%esp
801027c0:	85 c0                	test   %eax,%eax
801027c2:	74 6c                	je     80102830 <iderw+0xd0>
801027c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027c8:	89 c2                	mov    %eax,%edx
801027ca:	8b 40 58             	mov    0x58(%eax),%eax
801027cd:	85 c0                	test   %eax,%eax
801027cf:	75 f7                	jne    801027c8 <iderw+0x68>
801027d1:	83 c2 58             	add    $0x58,%edx
801027d4:	89 1a                	mov    %ebx,(%edx)
801027d6:	39 1d 84 b5 10 80    	cmp    %ebx,0x8010b584
801027dc:	74 42                	je     80102820 <iderw+0xc0>
801027de:	8b 03                	mov    (%ebx),%eax
801027e0:	83 e0 06             	and    $0x6,%eax
801027e3:	83 f8 02             	cmp    $0x2,%eax
801027e6:	74 23                	je     8010280b <iderw+0xab>
801027e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ef:	90                   	nop
801027f0:	83 ec 08             	sub    $0x8,%esp
801027f3:	68 a0 b5 10 80       	push   $0x8010b5a0
801027f8:	53                   	push   %ebx
801027f9:	e8 12 1c 00 00       	call   80104410 <sleep>
801027fe:	8b 03                	mov    (%ebx),%eax
80102800:	83 c4 10             	add    $0x10,%esp
80102803:	83 e0 06             	and    $0x6,%eax
80102806:	83 f8 02             	cmp    $0x2,%eax
80102809:	75 e5                	jne    801027f0 <iderw+0x90>
8010280b:	c7 45 08 a0 b5 10 80 	movl   $0x8010b5a0,0x8(%ebp)
80102812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102815:	c9                   	leave  
80102816:	e9 75 24 00 00       	jmp    80104c90 <release>
8010281b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010281f:	90                   	nop
80102820:	89 d8                	mov    %ebx,%eax
80102822:	e8 29 fd ff ff       	call   80102550 <idestart>
80102827:	eb b5                	jmp    801027de <iderw+0x7e>
80102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102830:	ba 84 b5 10 80       	mov    $0x8010b584,%edx
80102835:	eb 9d                	jmp    801027d4 <iderw+0x74>
80102837:	83 ec 0c             	sub    $0xc,%esp
8010283a:	68 6d 7b 10 80       	push   $0x80107b6d
8010283f:	e8 4c db ff ff       	call   80100390 <panic>
80102844:	83 ec 0c             	sub    $0xc,%esp
80102847:	68 58 7b 10 80       	push   $0x80107b58
8010284c:	e8 3f db ff ff       	call   80100390 <panic>
80102851:	83 ec 0c             	sub    $0xc,%esp
80102854:	68 42 7b 10 80       	push   $0x80107b42
80102859:	e8 32 db ff ff       	call   80100390 <panic>
8010285e:	66 90                	xchg   %ax,%ax

80102860 <ioapicinit>:
80102860:	f3 0f 1e fb          	endbr32 
80102864:	55                   	push   %ebp
80102865:	c7 05 54 36 11 80 00 	movl   $0xfec00000,0x80113654
8010286c:	00 c0 fe 
8010286f:	89 e5                	mov    %esp,%ebp
80102871:	56                   	push   %esi
80102872:	53                   	push   %ebx
80102873:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010287a:	00 00 00 
8010287d:	8b 15 54 36 11 80    	mov    0x80113654,%edx
80102883:	8b 72 10             	mov    0x10(%edx),%esi
80102886:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
8010288c:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
80102892:	0f b6 15 80 37 11 80 	movzbl 0x80113780,%edx
80102899:	c1 ee 10             	shr    $0x10,%esi
8010289c:	89 f0                	mov    %esi,%eax
8010289e:	0f b6 f0             	movzbl %al,%esi
801028a1:	8b 41 10             	mov    0x10(%ecx),%eax
801028a4:	c1 e8 18             	shr    $0x18,%eax
801028a7:	39 c2                	cmp    %eax,%edx
801028a9:	74 16                	je     801028c1 <ioapicinit+0x61>
801028ab:	83 ec 0c             	sub    $0xc,%esp
801028ae:	68 8c 7b 10 80       	push   $0x80107b8c
801028b3:	e8 f8 dd ff ff       	call   801006b0 <cprintf>
801028b8:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
801028be:	83 c4 10             	add    $0x10,%esp
801028c1:	83 c6 21             	add    $0x21,%esi
801028c4:	ba 10 00 00 00       	mov    $0x10,%edx
801028c9:	b8 20 00 00 00       	mov    $0x20,%eax
801028ce:	66 90                	xchg   %ax,%ax
801028d0:	89 11                	mov    %edx,(%ecx)
801028d2:	89 c3                	mov    %eax,%ebx
801028d4:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
801028da:	83 c0 01             	add    $0x1,%eax
801028dd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
801028e3:	89 59 10             	mov    %ebx,0x10(%ecx)
801028e6:	8d 5a 01             	lea    0x1(%edx),%ebx
801028e9:	83 c2 02             	add    $0x2,%edx
801028ec:	89 19                	mov    %ebx,(%ecx)
801028ee:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
801028f4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
801028fb:	39 f0                	cmp    %esi,%eax
801028fd:	75 d1                	jne    801028d0 <ioapicinit+0x70>
801028ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102902:	5b                   	pop    %ebx
80102903:	5e                   	pop    %esi
80102904:	5d                   	pop    %ebp
80102905:	c3                   	ret    
80102906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290d:	8d 76 00             	lea    0x0(%esi),%esi

80102910 <ioapicenable>:
80102910:	f3 0f 1e fb          	endbr32 
80102914:	55                   	push   %ebp
80102915:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
8010291b:	89 e5                	mov    %esp,%ebp
8010291d:	8b 45 08             	mov    0x8(%ebp),%eax
80102920:	8d 50 20             	lea    0x20(%eax),%edx
80102923:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102927:	89 01                	mov    %eax,(%ecx)
80102929:	8b 0d 54 36 11 80    	mov    0x80113654,%ecx
8010292f:	83 c0 01             	add    $0x1,%eax
80102932:	89 51 10             	mov    %edx,0x10(%ecx)
80102935:	8b 55 0c             	mov    0xc(%ebp),%edx
80102938:	89 01                	mov    %eax,(%ecx)
8010293a:	a1 54 36 11 80       	mov    0x80113654,%eax
8010293f:	c1 e2 18             	shl    $0x18,%edx
80102942:	89 50 10             	mov    %edx,0x10(%eax)
80102945:	5d                   	pop    %ebp
80102946:	c3                   	ret    
80102947:	66 90                	xchg   %ax,%ax
80102949:	66 90                	xchg   %ax,%ax
8010294b:	66 90                	xchg   %ax,%ax
8010294d:	66 90                	xchg   %ax,%ax
8010294f:	90                   	nop

80102950 <kfree>:
80102950:	f3 0f 1e fb          	endbr32 
80102954:	55                   	push   %ebp
80102955:	89 e5                	mov    %esp,%ebp
80102957:	53                   	push   %ebx
80102958:	83 ec 04             	sub    $0x4,%esp
8010295b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010295e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102964:	75 7a                	jne    801029e0 <kfree+0x90>
80102966:	81 fb c8 65 11 80    	cmp    $0x801165c8,%ebx
8010296c:	72 72                	jb     801029e0 <kfree+0x90>
8010296e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102974:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102979:	77 65                	ja     801029e0 <kfree+0x90>
8010297b:	83 ec 04             	sub    $0x4,%esp
8010297e:	68 00 10 00 00       	push   $0x1000
80102983:	6a 01                	push   $0x1
80102985:	53                   	push   %ebx
80102986:	e8 55 23 00 00       	call   80104ce0 <memset>
8010298b:	8b 15 94 36 11 80    	mov    0x80113694,%edx
80102991:	83 c4 10             	add    $0x10,%esp
80102994:	85 d2                	test   %edx,%edx
80102996:	75 20                	jne    801029b8 <kfree+0x68>
80102998:	a1 98 36 11 80       	mov    0x80113698,%eax
8010299d:	89 03                	mov    %eax,(%ebx)
8010299f:	a1 94 36 11 80       	mov    0x80113694,%eax
801029a4:	89 1d 98 36 11 80    	mov    %ebx,0x80113698
801029aa:	85 c0                	test   %eax,%eax
801029ac:	75 22                	jne    801029d0 <kfree+0x80>
801029ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029b1:	c9                   	leave  
801029b2:	c3                   	ret    
801029b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029b7:	90                   	nop
801029b8:	83 ec 0c             	sub    $0xc,%esp
801029bb:	68 60 36 11 80       	push   $0x80113660
801029c0:	e8 0b 22 00 00       	call   80104bd0 <acquire>
801029c5:	83 c4 10             	add    $0x10,%esp
801029c8:	eb ce                	jmp    80102998 <kfree+0x48>
801029ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029d0:	c7 45 08 60 36 11 80 	movl   $0x80113660,0x8(%ebp)
801029d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029da:	c9                   	leave  
801029db:	e9 b0 22 00 00       	jmp    80104c90 <release>
801029e0:	83 ec 0c             	sub    $0xc,%esp
801029e3:	68 be 7b 10 80       	push   $0x80107bbe
801029e8:	e8 a3 d9 ff ff       	call   80100390 <panic>
801029ed:	8d 76 00             	lea    0x0(%esi),%esi

801029f0 <freerange>:
801029f0:	f3 0f 1e fb          	endbr32 
801029f4:	55                   	push   %ebp
801029f5:	89 e5                	mov    %esp,%ebp
801029f7:	56                   	push   %esi
801029f8:	8b 45 08             	mov    0x8(%ebp),%eax
801029fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801029fe:	53                   	push   %ebx
801029ff:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a05:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102a0b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a11:	39 de                	cmp    %ebx,%esi
80102a13:	72 1f                	jb     80102a34 <freerange+0x44>
80102a15:	8d 76 00             	lea    0x0(%esi),%esi
80102a18:	83 ec 0c             	sub    $0xc,%esp
80102a1b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a27:	50                   	push   %eax
80102a28:	e8 23 ff ff ff       	call   80102950 <kfree>
80102a2d:	83 c4 10             	add    $0x10,%esp
80102a30:	39 f3                	cmp    %esi,%ebx
80102a32:	76 e4                	jbe    80102a18 <freerange+0x28>
80102a34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a37:	5b                   	pop    %ebx
80102a38:	5e                   	pop    %esi
80102a39:	5d                   	pop    %ebp
80102a3a:	c3                   	ret    
80102a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a3f:	90                   	nop

80102a40 <kinit1>:
80102a40:	f3 0f 1e fb          	endbr32 
80102a44:	55                   	push   %ebp
80102a45:	89 e5                	mov    %esp,%ebp
80102a47:	56                   	push   %esi
80102a48:	53                   	push   %ebx
80102a49:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a4c:	83 ec 08             	sub    $0x8,%esp
80102a4f:	68 c4 7b 10 80       	push   $0x80107bc4
80102a54:	68 60 36 11 80       	push   $0x80113660
80102a59:	e8 f2 1f 00 00       	call   80104a50 <initlock>
80102a5e:	8b 45 08             	mov    0x8(%ebp),%eax
80102a61:	83 c4 10             	add    $0x10,%esp
80102a64:	c7 05 94 36 11 80 00 	movl   $0x0,0x80113694
80102a6b:	00 00 00 
80102a6e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a74:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102a7a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a80:	39 de                	cmp    %ebx,%esi
80102a82:	72 20                	jb     80102aa4 <kinit1+0x64>
80102a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a88:	83 ec 0c             	sub    $0xc,%esp
80102a8b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102a91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a97:	50                   	push   %eax
80102a98:	e8 b3 fe ff ff       	call   80102950 <kfree>
80102a9d:	83 c4 10             	add    $0x10,%esp
80102aa0:	39 de                	cmp    %ebx,%esi
80102aa2:	73 e4                	jae    80102a88 <kinit1+0x48>
80102aa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102aa7:	5b                   	pop    %ebx
80102aa8:	5e                   	pop    %esi
80102aa9:	5d                   	pop    %ebp
80102aaa:	c3                   	ret    
80102aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aaf:	90                   	nop

80102ab0 <kinit2>:
80102ab0:	f3 0f 1e fb          	endbr32 
80102ab4:	55                   	push   %ebp
80102ab5:	89 e5                	mov    %esp,%ebp
80102ab7:	56                   	push   %esi
80102ab8:	8b 45 08             	mov    0x8(%ebp),%eax
80102abb:	8b 75 0c             	mov    0xc(%ebp),%esi
80102abe:	53                   	push   %ebx
80102abf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ac5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102acb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ad1:	39 de                	cmp    %ebx,%esi
80102ad3:	72 1f                	jb     80102af4 <kinit2+0x44>
80102ad5:	8d 76 00             	lea    0x0(%esi),%esi
80102ad8:	83 ec 0c             	sub    $0xc,%esp
80102adb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102ae1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ae7:	50                   	push   %eax
80102ae8:	e8 63 fe ff ff       	call   80102950 <kfree>
80102aed:	83 c4 10             	add    $0x10,%esp
80102af0:	39 de                	cmp    %ebx,%esi
80102af2:	73 e4                	jae    80102ad8 <kinit2+0x28>
80102af4:	c7 05 94 36 11 80 01 	movl   $0x1,0x80113694
80102afb:	00 00 00 
80102afe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b01:	5b                   	pop    %ebx
80102b02:	5e                   	pop    %esi
80102b03:	5d                   	pop    %ebp
80102b04:	c3                   	ret    
80102b05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b10 <kalloc>:
80102b10:	f3 0f 1e fb          	endbr32 
80102b14:	a1 94 36 11 80       	mov    0x80113694,%eax
80102b19:	85 c0                	test   %eax,%eax
80102b1b:	75 1b                	jne    80102b38 <kalloc+0x28>
80102b1d:	a1 98 36 11 80       	mov    0x80113698,%eax
80102b22:	85 c0                	test   %eax,%eax
80102b24:	74 0a                	je     80102b30 <kalloc+0x20>
80102b26:	8b 10                	mov    (%eax),%edx
80102b28:	89 15 98 36 11 80    	mov    %edx,0x80113698
80102b2e:	c3                   	ret    
80102b2f:	90                   	nop
80102b30:	c3                   	ret    
80102b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b38:	55                   	push   %ebp
80102b39:	89 e5                	mov    %esp,%ebp
80102b3b:	83 ec 24             	sub    $0x24,%esp
80102b3e:	68 60 36 11 80       	push   $0x80113660
80102b43:	e8 88 20 00 00       	call   80104bd0 <acquire>
80102b48:	a1 98 36 11 80       	mov    0x80113698,%eax
80102b4d:	8b 15 94 36 11 80    	mov    0x80113694,%edx
80102b53:	83 c4 10             	add    $0x10,%esp
80102b56:	85 c0                	test   %eax,%eax
80102b58:	74 08                	je     80102b62 <kalloc+0x52>
80102b5a:	8b 08                	mov    (%eax),%ecx
80102b5c:	89 0d 98 36 11 80    	mov    %ecx,0x80113698
80102b62:	85 d2                	test   %edx,%edx
80102b64:	74 16                	je     80102b7c <kalloc+0x6c>
80102b66:	83 ec 0c             	sub    $0xc,%esp
80102b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b6c:	68 60 36 11 80       	push   $0x80113660
80102b71:	e8 1a 21 00 00       	call   80104c90 <release>
80102b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b79:	83 c4 10             	add    $0x10,%esp
80102b7c:	c9                   	leave  
80102b7d:	c3                   	ret    
80102b7e:	66 90                	xchg   %ax,%ax

80102b80 <kbdgetc>:
80102b80:	f3 0f 1e fb          	endbr32 
80102b84:	ba 64 00 00 00       	mov    $0x64,%edx
80102b89:	ec                   	in     (%dx),%al
80102b8a:	a8 01                	test   $0x1,%al
80102b8c:	0f 84 be 00 00 00    	je     80102c50 <kbdgetc+0xd0>
80102b92:	55                   	push   %ebp
80102b93:	ba 60 00 00 00       	mov    $0x60,%edx
80102b98:	89 e5                	mov    %esp,%ebp
80102b9a:	53                   	push   %ebx
80102b9b:	ec                   	in     (%dx),%al
80102b9c:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
80102ba2:	0f b6 d0             	movzbl %al,%edx
80102ba5:	3c e0                	cmp    $0xe0,%al
80102ba7:	74 57                	je     80102c00 <kbdgetc+0x80>
80102ba9:	89 d9                	mov    %ebx,%ecx
80102bab:	83 e1 40             	and    $0x40,%ecx
80102bae:	84 c0                	test   %al,%al
80102bb0:	78 5e                	js     80102c10 <kbdgetc+0x90>
80102bb2:	85 c9                	test   %ecx,%ecx
80102bb4:	74 09                	je     80102bbf <kbdgetc+0x3f>
80102bb6:	83 c8 80             	or     $0xffffff80,%eax
80102bb9:	83 e3 bf             	and    $0xffffffbf,%ebx
80102bbc:	0f b6 d0             	movzbl %al,%edx
80102bbf:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
80102bc6:	0f b6 82 00 7c 10 80 	movzbl -0x7fef8400(%edx),%eax
80102bcd:	09 d9                	or     %ebx,%ecx
80102bcf:	31 c1                	xor    %eax,%ecx
80102bd1:	89 c8                	mov    %ecx,%eax
80102bd3:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
80102bd9:	83 e0 03             	and    $0x3,%eax
80102bdc:	83 e1 08             	and    $0x8,%ecx
80102bdf:	8b 04 85 e0 7b 10 80 	mov    -0x7fef8420(,%eax,4),%eax
80102be6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
80102bea:	74 0b                	je     80102bf7 <kbdgetc+0x77>
80102bec:	8d 50 9f             	lea    -0x61(%eax),%edx
80102bef:	83 fa 19             	cmp    $0x19,%edx
80102bf2:	77 44                	ja     80102c38 <kbdgetc+0xb8>
80102bf4:	83 e8 20             	sub    $0x20,%eax
80102bf7:	5b                   	pop    %ebx
80102bf8:	5d                   	pop    %ebp
80102bf9:	c3                   	ret    
80102bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102c00:	83 cb 40             	or     $0x40,%ebx
80102c03:	31 c0                	xor    %eax,%eax
80102c05:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
80102c0b:	5b                   	pop    %ebx
80102c0c:	5d                   	pop    %ebp
80102c0d:	c3                   	ret    
80102c0e:	66 90                	xchg   %ax,%ax
80102c10:	83 e0 7f             	and    $0x7f,%eax
80102c13:	85 c9                	test   %ecx,%ecx
80102c15:	0f 44 d0             	cmove  %eax,%edx
80102c18:	31 c0                	xor    %eax,%eax
80102c1a:	0f b6 8a 00 7d 10 80 	movzbl -0x7fef8300(%edx),%ecx
80102c21:	83 c9 40             	or     $0x40,%ecx
80102c24:	0f b6 c9             	movzbl %cl,%ecx
80102c27:	f7 d1                	not    %ecx
80102c29:	21 d9                	and    %ebx,%ecx
80102c2b:	5b                   	pop    %ebx
80102c2c:	5d                   	pop    %ebp
80102c2d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
80102c33:	c3                   	ret    
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102c38:	8d 48 bf             	lea    -0x41(%eax),%ecx
80102c3b:	8d 50 20             	lea    0x20(%eax),%edx
80102c3e:	5b                   	pop    %ebx
80102c3f:	5d                   	pop    %ebp
80102c40:	83 f9 1a             	cmp    $0x1a,%ecx
80102c43:	0f 42 c2             	cmovb  %edx,%eax
80102c46:	c3                   	ret    
80102c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c4e:	66 90                	xchg   %ax,%ax
80102c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102c55:	c3                   	ret    
80102c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c5d:	8d 76 00             	lea    0x0(%esi),%esi

80102c60 <kbdintr>:
80102c60:	f3 0f 1e fb          	endbr32 
80102c64:	55                   	push   %ebp
80102c65:	89 e5                	mov    %esp,%ebp
80102c67:	83 ec 14             	sub    $0x14,%esp
80102c6a:	68 80 2b 10 80       	push   $0x80102b80
80102c6f:	e8 ec de ff ff       	call   80100b60 <consoleintr>
80102c74:	83 c4 10             	add    $0x10,%esp
80102c77:	c9                   	leave  
80102c78:	c3                   	ret    
80102c79:	66 90                	xchg   %ax,%ax
80102c7b:	66 90                	xchg   %ax,%ax
80102c7d:	66 90                	xchg   %ax,%ax
80102c7f:	90                   	nop

80102c80 <lapicinit>:
80102c80:	f3 0f 1e fb          	endbr32 
80102c84:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102c89:	85 c0                	test   %eax,%eax
80102c8b:	0f 84 c7 00 00 00    	je     80102d58 <lapicinit+0xd8>
80102c91:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102c98:	01 00 00 
80102c9b:	8b 50 20             	mov    0x20(%eax),%edx
80102c9e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ca5:	00 00 00 
80102ca8:	8b 50 20             	mov    0x20(%eax),%edx
80102cab:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102cb2:	00 02 00 
80102cb5:	8b 50 20             	mov    0x20(%eax),%edx
80102cb8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102cbf:	96 98 00 
80102cc2:	8b 50 20             	mov    0x20(%eax),%edx
80102cc5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102ccc:	00 01 00 
80102ccf:	8b 50 20             	mov    0x20(%eax),%edx
80102cd2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102cd9:	00 01 00 
80102cdc:	8b 50 20             	mov    0x20(%eax),%edx
80102cdf:	8b 50 30             	mov    0x30(%eax),%edx
80102ce2:	c1 ea 10             	shr    $0x10,%edx
80102ce5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102ceb:	75 73                	jne    80102d60 <lapicinit+0xe0>
80102ced:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102cf4:	00 00 00 
80102cf7:	8b 50 20             	mov    0x20(%eax),%edx
80102cfa:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d01:	00 00 00 
80102d04:	8b 50 20             	mov    0x20(%eax),%edx
80102d07:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d0e:	00 00 00 
80102d11:	8b 50 20             	mov    0x20(%eax),%edx
80102d14:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d1b:	00 00 00 
80102d1e:	8b 50 20             	mov    0x20(%eax),%edx
80102d21:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d28:	00 00 00 
80102d2b:	8b 50 20             	mov    0x20(%eax),%edx
80102d2e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d35:	85 08 00 
80102d38:	8b 50 20             	mov    0x20(%eax),%edx
80102d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d3f:	90                   	nop
80102d40:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d46:	80 e6 10             	and    $0x10,%dh
80102d49:	75 f5                	jne    80102d40 <lapicinit+0xc0>
80102d4b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d52:	00 00 00 
80102d55:	8b 40 20             	mov    0x20(%eax),%eax
80102d58:	c3                   	ret    
80102d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d60:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102d67:	00 01 00 
80102d6a:	8b 50 20             	mov    0x20(%eax),%edx
80102d6d:	e9 7b ff ff ff       	jmp    80102ced <lapicinit+0x6d>
80102d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <lapicid>:
80102d80:	f3 0f 1e fb          	endbr32 
80102d84:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102d89:	85 c0                	test   %eax,%eax
80102d8b:	74 0b                	je     80102d98 <lapicid+0x18>
80102d8d:	8b 40 20             	mov    0x20(%eax),%eax
80102d90:	c1 e8 18             	shr    $0x18,%eax
80102d93:	c3                   	ret    
80102d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d98:	31 c0                	xor    %eax,%eax
80102d9a:	c3                   	ret    
80102d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d9f:	90                   	nop

80102da0 <lapiceoi>:
80102da0:	f3 0f 1e fb          	endbr32 
80102da4:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102da9:	85 c0                	test   %eax,%eax
80102dab:	74 0d                	je     80102dba <lapiceoi+0x1a>
80102dad:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102db4:	00 00 00 
80102db7:	8b 40 20             	mov    0x20(%eax),%eax
80102dba:	c3                   	ret    
80102dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dbf:	90                   	nop

80102dc0 <microdelay>:
80102dc0:	f3 0f 1e fb          	endbr32 
80102dc4:	c3                   	ret    
80102dc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102dd0 <lapicstartap>:
80102dd0:	f3 0f 1e fb          	endbr32 
80102dd4:	55                   	push   %ebp
80102dd5:	b8 0f 00 00 00       	mov    $0xf,%eax
80102dda:	ba 70 00 00 00       	mov    $0x70,%edx
80102ddf:	89 e5                	mov    %esp,%ebp
80102de1:	53                   	push   %ebx
80102de2:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102de5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102de8:	ee                   	out    %al,(%dx)
80102de9:	b8 0a 00 00 00       	mov    $0xa,%eax
80102dee:	ba 71 00 00 00       	mov    $0x71,%edx
80102df3:	ee                   	out    %al,(%dx)
80102df4:	31 c0                	xor    %eax,%eax
80102df6:	c1 e3 18             	shl    $0x18,%ebx
80102df9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
80102dff:	89 c8                	mov    %ecx,%eax
80102e01:	c1 e9 0c             	shr    $0xc,%ecx
80102e04:	89 da                	mov    %ebx,%edx
80102e06:	c1 e8 04             	shr    $0x4,%eax
80102e09:	80 cd 06             	or     $0x6,%ch
80102e0c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
80102e12:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102e17:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
80102e1d:	8b 58 20             	mov    0x20(%eax),%ebx
80102e20:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e27:	c5 00 00 
80102e2a:	8b 58 20             	mov    0x20(%eax),%ebx
80102e2d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e34:	85 00 00 
80102e37:	8b 58 20             	mov    0x20(%eax),%ebx
80102e3a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102e40:	8b 58 20             	mov    0x20(%eax),%ebx
80102e43:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102e49:	8b 58 20             	mov    0x20(%eax),%ebx
80102e4c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
80102e52:	8b 50 20             	mov    0x20(%eax),%edx
80102e55:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80102e5b:	5b                   	pop    %ebx
80102e5c:	8b 40 20             	mov    0x20(%eax),%eax
80102e5f:	5d                   	pop    %ebp
80102e60:	c3                   	ret    
80102e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop

80102e70 <cmostime>:
80102e70:	f3 0f 1e fb          	endbr32 
80102e74:	55                   	push   %ebp
80102e75:	b8 0b 00 00 00       	mov    $0xb,%eax
80102e7a:	ba 70 00 00 00       	mov    $0x70,%edx
80102e7f:	89 e5                	mov    %esp,%ebp
80102e81:	57                   	push   %edi
80102e82:	56                   	push   %esi
80102e83:	53                   	push   %ebx
80102e84:	83 ec 4c             	sub    $0x4c,%esp
80102e87:	ee                   	out    %al,(%dx)
80102e88:	ba 71 00 00 00       	mov    $0x71,%edx
80102e8d:	ec                   	in     (%dx),%al
80102e8e:	83 e0 04             	and    $0x4,%eax
80102e91:	bb 70 00 00 00       	mov    $0x70,%ebx
80102e96:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ea0:	31 c0                	xor    %eax,%eax
80102ea2:	89 da                	mov    %ebx,%edx
80102ea4:	ee                   	out    %al,(%dx)
80102ea5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102eaa:	89 ca                	mov    %ecx,%edx
80102eac:	ec                   	in     (%dx),%al
80102ead:	88 45 b7             	mov    %al,-0x49(%ebp)
80102eb0:	89 da                	mov    %ebx,%edx
80102eb2:	b8 02 00 00 00       	mov    $0x2,%eax
80102eb7:	ee                   	out    %al,(%dx)
80102eb8:	89 ca                	mov    %ecx,%edx
80102eba:	ec                   	in     (%dx),%al
80102ebb:	88 45 b6             	mov    %al,-0x4a(%ebp)
80102ebe:	89 da                	mov    %ebx,%edx
80102ec0:	b8 04 00 00 00       	mov    $0x4,%eax
80102ec5:	ee                   	out    %al,(%dx)
80102ec6:	89 ca                	mov    %ecx,%edx
80102ec8:	ec                   	in     (%dx),%al
80102ec9:	88 45 b5             	mov    %al,-0x4b(%ebp)
80102ecc:	89 da                	mov    %ebx,%edx
80102ece:	b8 07 00 00 00       	mov    $0x7,%eax
80102ed3:	ee                   	out    %al,(%dx)
80102ed4:	89 ca                	mov    %ecx,%edx
80102ed6:	ec                   	in     (%dx),%al
80102ed7:	88 45 b4             	mov    %al,-0x4c(%ebp)
80102eda:	89 da                	mov    %ebx,%edx
80102edc:	b8 08 00 00 00       	mov    $0x8,%eax
80102ee1:	ee                   	out    %al,(%dx)
80102ee2:	89 ca                	mov    %ecx,%edx
80102ee4:	ec                   	in     (%dx),%al
80102ee5:	89 c7                	mov    %eax,%edi
80102ee7:	89 da                	mov    %ebx,%edx
80102ee9:	b8 09 00 00 00       	mov    $0x9,%eax
80102eee:	ee                   	out    %al,(%dx)
80102eef:	89 ca                	mov    %ecx,%edx
80102ef1:	ec                   	in     (%dx),%al
80102ef2:	89 c6                	mov    %eax,%esi
80102ef4:	89 da                	mov    %ebx,%edx
80102ef6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102efb:	ee                   	out    %al,(%dx)
80102efc:	89 ca                	mov    %ecx,%edx
80102efe:	ec                   	in     (%dx),%al
80102eff:	84 c0                	test   %al,%al
80102f01:	78 9d                	js     80102ea0 <cmostime+0x30>
80102f03:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f07:	89 fa                	mov    %edi,%edx
80102f09:	0f b6 fa             	movzbl %dl,%edi
80102f0c:	89 f2                	mov    %esi,%edx
80102f0e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f11:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f15:	0f b6 f2             	movzbl %dl,%esi
80102f18:	89 da                	mov    %ebx,%edx
80102f1a:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102f1d:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102f20:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102f24:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102f27:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102f2a:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102f2e:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102f31:	31 c0                	xor    %eax,%eax
80102f33:	ee                   	out    %al,(%dx)
80102f34:	89 ca                	mov    %ecx,%edx
80102f36:	ec                   	in     (%dx),%al
80102f37:	0f b6 c0             	movzbl %al,%eax
80102f3a:	89 da                	mov    %ebx,%edx
80102f3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f3f:	b8 02 00 00 00       	mov    $0x2,%eax
80102f44:	ee                   	out    %al,(%dx)
80102f45:	89 ca                	mov    %ecx,%edx
80102f47:	ec                   	in     (%dx),%al
80102f48:	0f b6 c0             	movzbl %al,%eax
80102f4b:	89 da                	mov    %ebx,%edx
80102f4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102f50:	b8 04 00 00 00       	mov    $0x4,%eax
80102f55:	ee                   	out    %al,(%dx)
80102f56:	89 ca                	mov    %ecx,%edx
80102f58:	ec                   	in     (%dx),%al
80102f59:	0f b6 c0             	movzbl %al,%eax
80102f5c:	89 da                	mov    %ebx,%edx
80102f5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f61:	b8 07 00 00 00       	mov    $0x7,%eax
80102f66:	ee                   	out    %al,(%dx)
80102f67:	89 ca                	mov    %ecx,%edx
80102f69:	ec                   	in     (%dx),%al
80102f6a:	0f b6 c0             	movzbl %al,%eax
80102f6d:	89 da                	mov    %ebx,%edx
80102f6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f72:	b8 08 00 00 00       	mov    $0x8,%eax
80102f77:	ee                   	out    %al,(%dx)
80102f78:	89 ca                	mov    %ecx,%edx
80102f7a:	ec                   	in     (%dx),%al
80102f7b:	0f b6 c0             	movzbl %al,%eax
80102f7e:	89 da                	mov    %ebx,%edx
80102f80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102f83:	b8 09 00 00 00       	mov    $0x9,%eax
80102f88:	ee                   	out    %al,(%dx)
80102f89:	89 ca                	mov    %ecx,%edx
80102f8b:	ec                   	in     (%dx),%al
80102f8c:	0f b6 c0             	movzbl %al,%eax
80102f8f:	83 ec 04             	sub    $0x4,%esp
80102f92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102f95:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102f98:	6a 18                	push   $0x18
80102f9a:	50                   	push   %eax
80102f9b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102f9e:	50                   	push   %eax
80102f9f:	e8 8c 1d 00 00       	call   80104d30 <memcmp>
80102fa4:	83 c4 10             	add    $0x10,%esp
80102fa7:	85 c0                	test   %eax,%eax
80102fa9:	0f 85 f1 fe ff ff    	jne    80102ea0 <cmostime+0x30>
80102faf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102fb3:	75 78                	jne    8010302d <cmostime+0x1bd>
80102fb5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fb8:	89 c2                	mov    %eax,%edx
80102fba:	83 e0 0f             	and    $0xf,%eax
80102fbd:	c1 ea 04             	shr    $0x4,%edx
80102fc0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fc3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fc6:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102fc9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102fcc:	89 c2                	mov    %eax,%edx
80102fce:	83 e0 0f             	and    $0xf,%eax
80102fd1:	c1 ea 04             	shr    $0x4,%edx
80102fd4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fd7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fda:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102fdd:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102fe0:	89 c2                	mov    %eax,%edx
80102fe2:	83 e0 0f             	and    $0xf,%eax
80102fe5:	c1 ea 04             	shr    $0x4,%edx
80102fe8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102feb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fee:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102ff1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ff4:	89 c2                	mov    %eax,%edx
80102ff6:	83 e0 0f             	and    $0xf,%eax
80102ff9:	c1 ea 04             	shr    $0x4,%edx
80102ffc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103002:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103005:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103008:	89 c2                	mov    %eax,%edx
8010300a:	83 e0 0f             	and    $0xf,%eax
8010300d:	c1 ea 04             	shr    $0x4,%edx
80103010:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103013:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103016:	89 45 c8             	mov    %eax,-0x38(%ebp)
80103019:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010301c:	89 c2                	mov    %eax,%edx
8010301e:	83 e0 0f             	and    $0xf,%eax
80103021:	c1 ea 04             	shr    $0x4,%edx
80103024:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103027:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010302a:	89 45 cc             	mov    %eax,-0x34(%ebp)
8010302d:	8b 75 08             	mov    0x8(%ebp),%esi
80103030:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103033:	89 06                	mov    %eax,(%esi)
80103035:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103038:	89 46 04             	mov    %eax,0x4(%esi)
8010303b:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010303e:	89 46 08             	mov    %eax,0x8(%esi)
80103041:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80103044:	89 46 0c             	mov    %eax,0xc(%esi)
80103047:	8b 45 c8             	mov    -0x38(%ebp),%eax
8010304a:	89 46 10             	mov    %eax,0x10(%esi)
8010304d:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103050:	89 46 14             	mov    %eax,0x14(%esi)
80103053:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
8010305a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010305d:	5b                   	pop    %ebx
8010305e:	5e                   	pop    %esi
8010305f:	5f                   	pop    %edi
80103060:	5d                   	pop    %ebp
80103061:	c3                   	ret    
80103062:	66 90                	xchg   %ax,%ax
80103064:	66 90                	xchg   %ax,%ax
80103066:	66 90                	xchg   %ax,%ax
80103068:	66 90                	xchg   %ax,%ax
8010306a:	66 90                	xchg   %ax,%ax
8010306c:	66 90                	xchg   %ax,%ax
8010306e:	66 90                	xchg   %ax,%ax

80103070 <install_trans>:
80103070:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
80103076:	85 c9                	test   %ecx,%ecx
80103078:	0f 8e 8a 00 00 00    	jle    80103108 <install_trans+0x98>
8010307e:	55                   	push   %ebp
8010307f:	89 e5                	mov    %esp,%ebp
80103081:	57                   	push   %edi
80103082:	31 ff                	xor    %edi,%edi
80103084:	56                   	push   %esi
80103085:	53                   	push   %ebx
80103086:	83 ec 0c             	sub    $0xc,%esp
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103090:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80103095:	83 ec 08             	sub    $0x8,%esp
80103098:	01 f8                	add    %edi,%eax
8010309a:	83 c0 01             	add    $0x1,%eax
8010309d:	50                   	push   %eax
8010309e:	ff 35 e4 36 11 80    	pushl  0x801136e4
801030a4:	e8 27 d0 ff ff       	call   801000d0 <bread>
801030a9:	89 c6                	mov    %eax,%esi
801030ab:	58                   	pop    %eax
801030ac:	5a                   	pop    %edx
801030ad:	ff 34 bd ec 36 11 80 	pushl  -0x7feec914(,%edi,4)
801030b4:	ff 35 e4 36 11 80    	pushl  0x801136e4
801030ba:	83 c7 01             	add    $0x1,%edi
801030bd:	e8 0e d0 ff ff       	call   801000d0 <bread>
801030c2:	83 c4 0c             	add    $0xc,%esp
801030c5:	89 c3                	mov    %eax,%ebx
801030c7:	8d 46 5c             	lea    0x5c(%esi),%eax
801030ca:	68 00 02 00 00       	push   $0x200
801030cf:	50                   	push   %eax
801030d0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801030d3:	50                   	push   %eax
801030d4:	e8 a7 1c 00 00       	call   80104d80 <memmove>
801030d9:	89 1c 24             	mov    %ebx,(%esp)
801030dc:	e8 cf d0 ff ff       	call   801001b0 <bwrite>
801030e1:	89 34 24             	mov    %esi,(%esp)
801030e4:	e8 07 d1 ff ff       	call   801001f0 <brelse>
801030e9:	89 1c 24             	mov    %ebx,(%esp)
801030ec:	e8 ff d0 ff ff       	call   801001f0 <brelse>
801030f1:	83 c4 10             	add    $0x10,%esp
801030f4:	39 3d e8 36 11 80    	cmp    %edi,0x801136e8
801030fa:	7f 94                	jg     80103090 <install_trans+0x20>
801030fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030ff:	5b                   	pop    %ebx
80103100:	5e                   	pop    %esi
80103101:	5f                   	pop    %edi
80103102:	5d                   	pop    %ebp
80103103:	c3                   	ret    
80103104:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103108:	c3                   	ret    
80103109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103110 <write_head>:
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	53                   	push   %ebx
80103114:	83 ec 0c             	sub    $0xc,%esp
80103117:	ff 35 d4 36 11 80    	pushl  0x801136d4
8010311d:	ff 35 e4 36 11 80    	pushl  0x801136e4
80103123:	e8 a8 cf ff ff       	call   801000d0 <bread>
80103128:	83 c4 10             	add    $0x10,%esp
8010312b:	89 c3                	mov    %eax,%ebx
8010312d:	a1 e8 36 11 80       	mov    0x801136e8,%eax
80103132:	89 43 5c             	mov    %eax,0x5c(%ebx)
80103135:	85 c0                	test   %eax,%eax
80103137:	7e 19                	jle    80103152 <write_head+0x42>
80103139:	31 d2                	xor    %edx,%edx
8010313b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010313f:	90                   	nop
80103140:	8b 0c 95 ec 36 11 80 	mov    -0x7feec914(,%edx,4),%ecx
80103147:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010314b:	83 c2 01             	add    $0x1,%edx
8010314e:	39 d0                	cmp    %edx,%eax
80103150:	75 ee                	jne    80103140 <write_head+0x30>
80103152:	83 ec 0c             	sub    $0xc,%esp
80103155:	53                   	push   %ebx
80103156:	e8 55 d0 ff ff       	call   801001b0 <bwrite>
8010315b:	89 1c 24             	mov    %ebx,(%esp)
8010315e:	e8 8d d0 ff ff       	call   801001f0 <brelse>
80103163:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103166:	83 c4 10             	add    $0x10,%esp
80103169:	c9                   	leave  
8010316a:	c3                   	ret    
8010316b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010316f:	90                   	nop

80103170 <initlog>:
80103170:	f3 0f 1e fb          	endbr32 
80103174:	55                   	push   %ebp
80103175:	89 e5                	mov    %esp,%ebp
80103177:	53                   	push   %ebx
80103178:	83 ec 2c             	sub    $0x2c,%esp
8010317b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010317e:	68 00 7e 10 80       	push   $0x80107e00
80103183:	68 a0 36 11 80       	push   $0x801136a0
80103188:	e8 c3 18 00 00       	call   80104a50 <initlock>
8010318d:	58                   	pop    %eax
8010318e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103191:	5a                   	pop    %edx
80103192:	50                   	push   %eax
80103193:	53                   	push   %ebx
80103194:	e8 27 e8 ff ff       	call   801019c0 <readsb>
80103199:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010319c:	59                   	pop    %ecx
8010319d:	89 1d e4 36 11 80    	mov    %ebx,0x801136e4
801031a3:	8b 55 e8             	mov    -0x18(%ebp),%edx
801031a6:	a3 d4 36 11 80       	mov    %eax,0x801136d4
801031ab:	89 15 d8 36 11 80    	mov    %edx,0x801136d8
801031b1:	5a                   	pop    %edx
801031b2:	50                   	push   %eax
801031b3:	53                   	push   %ebx
801031b4:	e8 17 cf ff ff       	call   801000d0 <bread>
801031b9:	83 c4 10             	add    $0x10,%esp
801031bc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801031bf:	89 0d e8 36 11 80    	mov    %ecx,0x801136e8
801031c5:	85 c9                	test   %ecx,%ecx
801031c7:	7e 19                	jle    801031e2 <initlog+0x72>
801031c9:	31 d2                	xor    %edx,%edx
801031cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031cf:	90                   	nop
801031d0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801031d4:	89 1c 95 ec 36 11 80 	mov    %ebx,-0x7feec914(,%edx,4)
801031db:	83 c2 01             	add    $0x1,%edx
801031de:	39 d1                	cmp    %edx,%ecx
801031e0:	75 ee                	jne    801031d0 <initlog+0x60>
801031e2:	83 ec 0c             	sub    $0xc,%esp
801031e5:	50                   	push   %eax
801031e6:	e8 05 d0 ff ff       	call   801001f0 <brelse>
801031eb:	e8 80 fe ff ff       	call   80103070 <install_trans>
801031f0:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
801031f7:	00 00 00 
801031fa:	e8 11 ff ff ff       	call   80103110 <write_head>
801031ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103202:	83 c4 10             	add    $0x10,%esp
80103205:	c9                   	leave  
80103206:	c3                   	ret    
80103207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010320e:	66 90                	xchg   %ax,%ax

80103210 <begin_op>:
80103210:	f3 0f 1e fb          	endbr32 
80103214:	55                   	push   %ebp
80103215:	89 e5                	mov    %esp,%ebp
80103217:	83 ec 14             	sub    $0x14,%esp
8010321a:	68 a0 36 11 80       	push   $0x801136a0
8010321f:	e8 ac 19 00 00       	call   80104bd0 <acquire>
80103224:	83 c4 10             	add    $0x10,%esp
80103227:	eb 1c                	jmp    80103245 <begin_op+0x35>
80103229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103230:	83 ec 08             	sub    $0x8,%esp
80103233:	68 a0 36 11 80       	push   $0x801136a0
80103238:	68 a0 36 11 80       	push   $0x801136a0
8010323d:	e8 ce 11 00 00       	call   80104410 <sleep>
80103242:	83 c4 10             	add    $0x10,%esp
80103245:	a1 e0 36 11 80       	mov    0x801136e0,%eax
8010324a:	85 c0                	test   %eax,%eax
8010324c:	75 e2                	jne    80103230 <begin_op+0x20>
8010324e:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80103253:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80103259:	83 c0 01             	add    $0x1,%eax
8010325c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010325f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103262:	83 fa 1e             	cmp    $0x1e,%edx
80103265:	7f c9                	jg     80103230 <begin_op+0x20>
80103267:	83 ec 0c             	sub    $0xc,%esp
8010326a:	a3 dc 36 11 80       	mov    %eax,0x801136dc
8010326f:	68 a0 36 11 80       	push   $0x801136a0
80103274:	e8 17 1a 00 00       	call   80104c90 <release>
80103279:	83 c4 10             	add    $0x10,%esp
8010327c:	c9                   	leave  
8010327d:	c3                   	ret    
8010327e:	66 90                	xchg   %ax,%ax

80103280 <end_op>:
80103280:	f3 0f 1e fb          	endbr32 
80103284:	55                   	push   %ebp
80103285:	89 e5                	mov    %esp,%ebp
80103287:	57                   	push   %edi
80103288:	56                   	push   %esi
80103289:	53                   	push   %ebx
8010328a:	83 ec 18             	sub    $0x18,%esp
8010328d:	68 a0 36 11 80       	push   $0x801136a0
80103292:	e8 39 19 00 00       	call   80104bd0 <acquire>
80103297:	a1 dc 36 11 80       	mov    0x801136dc,%eax
8010329c:	8b 35 e0 36 11 80    	mov    0x801136e0,%esi
801032a2:	83 c4 10             	add    $0x10,%esp
801032a5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032a8:	89 1d dc 36 11 80    	mov    %ebx,0x801136dc
801032ae:	85 f6                	test   %esi,%esi
801032b0:	0f 85 1e 01 00 00    	jne    801033d4 <end_op+0x154>
801032b6:	85 db                	test   %ebx,%ebx
801032b8:	0f 85 f2 00 00 00    	jne    801033b0 <end_op+0x130>
801032be:	c7 05 e0 36 11 80 01 	movl   $0x1,0x801136e0
801032c5:	00 00 00 
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	68 a0 36 11 80       	push   $0x801136a0
801032d0:	e8 bb 19 00 00       	call   80104c90 <release>
801032d5:	8b 0d e8 36 11 80    	mov    0x801136e8,%ecx
801032db:	83 c4 10             	add    $0x10,%esp
801032de:	85 c9                	test   %ecx,%ecx
801032e0:	7f 3e                	jg     80103320 <end_op+0xa0>
801032e2:	83 ec 0c             	sub    $0xc,%esp
801032e5:	68 a0 36 11 80       	push   $0x801136a0
801032ea:	e8 e1 18 00 00       	call   80104bd0 <acquire>
801032ef:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801032f6:	c7 05 e0 36 11 80 00 	movl   $0x0,0x801136e0
801032fd:	00 00 00 
80103300:	e8 cb 12 00 00       	call   801045d0 <wakeup>
80103305:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
8010330c:	e8 7f 19 00 00       	call   80104c90 <release>
80103311:	83 c4 10             	add    $0x10,%esp
80103314:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103317:	5b                   	pop    %ebx
80103318:	5e                   	pop    %esi
80103319:	5f                   	pop    %edi
8010331a:	5d                   	pop    %ebp
8010331b:	c3                   	ret    
8010331c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103320:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80103325:	83 ec 08             	sub    $0x8,%esp
80103328:	01 d8                	add    %ebx,%eax
8010332a:	83 c0 01             	add    $0x1,%eax
8010332d:	50                   	push   %eax
8010332e:	ff 35 e4 36 11 80    	pushl  0x801136e4
80103334:	e8 97 cd ff ff       	call   801000d0 <bread>
80103339:	89 c6                	mov    %eax,%esi
8010333b:	58                   	pop    %eax
8010333c:	5a                   	pop    %edx
8010333d:	ff 34 9d ec 36 11 80 	pushl  -0x7feec914(,%ebx,4)
80103344:	ff 35 e4 36 11 80    	pushl  0x801136e4
8010334a:	83 c3 01             	add    $0x1,%ebx
8010334d:	e8 7e cd ff ff       	call   801000d0 <bread>
80103352:	83 c4 0c             	add    $0xc,%esp
80103355:	89 c7                	mov    %eax,%edi
80103357:	8d 40 5c             	lea    0x5c(%eax),%eax
8010335a:	68 00 02 00 00       	push   $0x200
8010335f:	50                   	push   %eax
80103360:	8d 46 5c             	lea    0x5c(%esi),%eax
80103363:	50                   	push   %eax
80103364:	e8 17 1a 00 00       	call   80104d80 <memmove>
80103369:	89 34 24             	mov    %esi,(%esp)
8010336c:	e8 3f ce ff ff       	call   801001b0 <bwrite>
80103371:	89 3c 24             	mov    %edi,(%esp)
80103374:	e8 77 ce ff ff       	call   801001f0 <brelse>
80103379:	89 34 24             	mov    %esi,(%esp)
8010337c:	e8 6f ce ff ff       	call   801001f0 <brelse>
80103381:	83 c4 10             	add    $0x10,%esp
80103384:	3b 1d e8 36 11 80    	cmp    0x801136e8,%ebx
8010338a:	7c 94                	jl     80103320 <end_op+0xa0>
8010338c:	e8 7f fd ff ff       	call   80103110 <write_head>
80103391:	e8 da fc ff ff       	call   80103070 <install_trans>
80103396:	c7 05 e8 36 11 80 00 	movl   $0x0,0x801136e8
8010339d:	00 00 00 
801033a0:	e8 6b fd ff ff       	call   80103110 <write_head>
801033a5:	e9 38 ff ff ff       	jmp    801032e2 <end_op+0x62>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033b0:	83 ec 0c             	sub    $0xc,%esp
801033b3:	68 a0 36 11 80       	push   $0x801136a0
801033b8:	e8 13 12 00 00       	call   801045d0 <wakeup>
801033bd:	c7 04 24 a0 36 11 80 	movl   $0x801136a0,(%esp)
801033c4:	e8 c7 18 00 00       	call   80104c90 <release>
801033c9:	83 c4 10             	add    $0x10,%esp
801033cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033cf:	5b                   	pop    %ebx
801033d0:	5e                   	pop    %esi
801033d1:	5f                   	pop    %edi
801033d2:	5d                   	pop    %ebp
801033d3:	c3                   	ret    
801033d4:	83 ec 0c             	sub    $0xc,%esp
801033d7:	68 04 7e 10 80       	push   $0x80107e04
801033dc:	e8 af cf ff ff       	call   80100390 <panic>
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ef:	90                   	nop

801033f0 <log_write>:
801033f0:	f3 0f 1e fb          	endbr32 
801033f4:	55                   	push   %ebp
801033f5:	89 e5                	mov    %esp,%ebp
801033f7:	53                   	push   %ebx
801033f8:	83 ec 04             	sub    $0x4,%esp
801033fb:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
80103401:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103404:	83 fa 1d             	cmp    $0x1d,%edx
80103407:	0f 8f 91 00 00 00    	jg     8010349e <log_write+0xae>
8010340d:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80103412:	83 e8 01             	sub    $0x1,%eax
80103415:	39 c2                	cmp    %eax,%edx
80103417:	0f 8d 81 00 00 00    	jge    8010349e <log_write+0xae>
8010341d:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	0f 8e 81 00 00 00    	jle    801034ab <log_write+0xbb>
8010342a:	83 ec 0c             	sub    $0xc,%esp
8010342d:	68 a0 36 11 80       	push   $0x801136a0
80103432:	e8 99 17 00 00       	call   80104bd0 <acquire>
80103437:	8b 15 e8 36 11 80    	mov    0x801136e8,%edx
8010343d:	83 c4 10             	add    $0x10,%esp
80103440:	85 d2                	test   %edx,%edx
80103442:	7e 4e                	jle    80103492 <log_write+0xa2>
80103444:	8b 4b 08             	mov    0x8(%ebx),%ecx
80103447:	31 c0                	xor    %eax,%eax
80103449:	eb 0c                	jmp    80103457 <log_write+0x67>
8010344b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010344f:	90                   	nop
80103450:	83 c0 01             	add    $0x1,%eax
80103453:	39 c2                	cmp    %eax,%edx
80103455:	74 29                	je     80103480 <log_write+0x90>
80103457:	39 0c 85 ec 36 11 80 	cmp    %ecx,-0x7feec914(,%eax,4)
8010345e:	75 f0                	jne    80103450 <log_write+0x60>
80103460:	89 0c 85 ec 36 11 80 	mov    %ecx,-0x7feec914(,%eax,4)
80103467:	83 0b 04             	orl    $0x4,(%ebx)
8010346a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010346d:	c7 45 08 a0 36 11 80 	movl   $0x801136a0,0x8(%ebp)
80103474:	c9                   	leave  
80103475:	e9 16 18 00 00       	jmp    80104c90 <release>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103480:	89 0c 95 ec 36 11 80 	mov    %ecx,-0x7feec914(,%edx,4)
80103487:	83 c2 01             	add    $0x1,%edx
8010348a:	89 15 e8 36 11 80    	mov    %edx,0x801136e8
80103490:	eb d5                	jmp    80103467 <log_write+0x77>
80103492:	8b 43 08             	mov    0x8(%ebx),%eax
80103495:	a3 ec 36 11 80       	mov    %eax,0x801136ec
8010349a:	75 cb                	jne    80103467 <log_write+0x77>
8010349c:	eb e9                	jmp    80103487 <log_write+0x97>
8010349e:	83 ec 0c             	sub    $0xc,%esp
801034a1:	68 13 7e 10 80       	push   $0x80107e13
801034a6:	e8 e5 ce ff ff       	call   80100390 <panic>
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	68 29 7e 10 80       	push   $0x80107e29
801034b3:	e8 d8 ce ff ff       	call   80100390 <panic>
801034b8:	66 90                	xchg   %ax,%ax
801034ba:	66 90                	xchg   %ax,%ax
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <mpmain>:
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
801034c4:	83 ec 04             	sub    $0x4,%esp
801034c7:	e8 54 09 00 00       	call   80103e20 <cpuid>
801034cc:	89 c3                	mov    %eax,%ebx
801034ce:	e8 4d 09 00 00       	call   80103e20 <cpuid>
801034d3:	83 ec 04             	sub    $0x4,%esp
801034d6:	53                   	push   %ebx
801034d7:	50                   	push   %eax
801034d8:	68 44 7e 10 80       	push   $0x80107e44
801034dd:	e8 ce d1 ff ff       	call   801006b0 <cprintf>
801034e2:	e8 49 2c 00 00       	call   80106130 <idtinit>
801034e7:	e8 c4 08 00 00       	call   80103db0 <mycpu>
801034ec:	89 c2                	mov    %eax,%edx
801034ee:	b8 01 00 00 00       	mov    $0x1,%eax
801034f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
801034fa:	e8 21 0c 00 00       	call   80104120 <scheduler>
801034ff:	90                   	nop

80103500 <mpenter>:
80103500:	f3 0f 1e fb          	endbr32 
80103504:	55                   	push   %ebp
80103505:	89 e5                	mov    %esp,%ebp
80103507:	83 ec 08             	sub    $0x8,%esp
8010350a:	e8 f1 3c 00 00       	call   80107200 <switchkvm>
8010350f:	e8 5c 3c 00 00       	call   80107170 <seginit>
80103514:	e8 67 f7 ff ff       	call   80102c80 <lapicinit>
80103519:	e8 a2 ff ff ff       	call   801034c0 <mpmain>
8010351e:	66 90                	xchg   %ax,%ax

80103520 <main>:
80103520:	f3 0f 1e fb          	endbr32 
80103524:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103528:	83 e4 f0             	and    $0xfffffff0,%esp
8010352b:	ff 71 fc             	pushl  -0x4(%ecx)
8010352e:	55                   	push   %ebp
8010352f:	89 e5                	mov    %esp,%ebp
80103531:	53                   	push   %ebx
80103532:	51                   	push   %ecx
80103533:	83 ec 08             	sub    $0x8,%esp
80103536:	68 00 00 40 80       	push   $0x80400000
8010353b:	68 c8 65 11 80       	push   $0x801165c8
80103540:	e8 fb f4 ff ff       	call   80102a40 <kinit1>
80103545:	e8 96 41 00 00       	call   801076e0 <kvmalloc>
8010354a:	e8 81 01 00 00       	call   801036d0 <mpinit>
8010354f:	e8 2c f7 ff ff       	call   80102c80 <lapicinit>
80103554:	e8 17 3c 00 00       	call   80107170 <seginit>
80103559:	e8 52 03 00 00       	call   801038b0 <picinit>
8010355e:	e8 fd f2 ff ff       	call   80102860 <ioapicinit>
80103563:	e8 88 d9 ff ff       	call   80100ef0 <consoleinit>
80103568:	e8 c3 2e 00 00       	call   80106430 <uartinit>
8010356d:	e8 1e 08 00 00       	call   80103d90 <pinit>
80103572:	e8 39 2b 00 00       	call   801060b0 <tvinit>
80103577:	e8 c4 ca ff ff       	call   80100040 <binit>
8010357c:	e8 1f dd ff ff       	call   801012a0 <fileinit>
80103581:	e8 aa f0 ff ff       	call   80102630 <ideinit>
80103586:	83 c4 0c             	add    $0xc,%esp
80103589:	68 8a 00 00 00       	push   $0x8a
8010358e:	68 8c b4 10 80       	push   $0x8010b48c
80103593:	68 00 70 00 80       	push   $0x80007000
80103598:	e8 e3 17 00 00       	call   80104d80 <memmove>
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	69 05 20 3d 11 80 b0 	imul   $0xb0,0x80113d20,%eax
801035a7:	00 00 00 
801035aa:	05 a0 37 11 80       	add    $0x801137a0,%eax
801035af:	3d a0 37 11 80       	cmp    $0x801137a0,%eax
801035b4:	76 7a                	jbe    80103630 <main+0x110>
801035b6:	bb a0 37 11 80       	mov    $0x801137a0,%ebx
801035bb:	eb 1c                	jmp    801035d9 <main+0xb9>
801035bd:	8d 76 00             	lea    0x0(%esi),%esi
801035c0:	69 05 20 3d 11 80 b0 	imul   $0xb0,0x80113d20,%eax
801035c7:	00 00 00 
801035ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035d0:	05 a0 37 11 80       	add    $0x801137a0,%eax
801035d5:	39 c3                	cmp    %eax,%ebx
801035d7:	73 57                	jae    80103630 <main+0x110>
801035d9:	e8 d2 07 00 00       	call   80103db0 <mycpu>
801035de:	39 c3                	cmp    %eax,%ebx
801035e0:	74 de                	je     801035c0 <main+0xa0>
801035e2:	e8 29 f5 ff ff       	call   80102b10 <kalloc>
801035e7:	83 ec 08             	sub    $0x8,%esp
801035ea:	c7 05 f8 6f 00 80 00 	movl   $0x80103500,0x80006ff8
801035f1:	35 10 80 
801035f4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801035fb:	a0 10 00 
801035fe:	05 00 10 00 00       	add    $0x1000,%eax
80103603:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
80103608:	0f b6 03             	movzbl (%ebx),%eax
8010360b:	68 00 70 00 00       	push   $0x7000
80103610:	50                   	push   %eax
80103611:	e8 ba f7 ff ff       	call   80102dd0 <lapicstartap>
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103620:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103626:	85 c0                	test   %eax,%eax
80103628:	74 f6                	je     80103620 <main+0x100>
8010362a:	eb 94                	jmp    801035c0 <main+0xa0>
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103630:	83 ec 08             	sub    $0x8,%esp
80103633:	68 00 00 00 8e       	push   $0x8e000000
80103638:	68 00 00 40 80       	push   $0x80400000
8010363d:	e8 6e f4 ff ff       	call   80102ab0 <kinit2>
80103642:	e8 29 08 00 00       	call   80103e70 <userinit>
80103647:	e8 74 fe ff ff       	call   801034c0 <mpmain>
8010364c:	66 90                	xchg   %ax,%ax
8010364e:	66 90                	xchg   %ax,%ax

80103650 <mpsearch1>:
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
80103655:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
8010365b:	53                   	push   %ebx
8010365c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
8010365f:	83 ec 0c             	sub    $0xc,%esp
80103662:	39 de                	cmp    %ebx,%esi
80103664:	72 10                	jb     80103676 <mpsearch1+0x26>
80103666:	eb 50                	jmp    801036b8 <mpsearch1+0x68>
80103668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010366f:	90                   	nop
80103670:	89 fe                	mov    %edi,%esi
80103672:	39 fb                	cmp    %edi,%ebx
80103674:	76 42                	jbe    801036b8 <mpsearch1+0x68>
80103676:	83 ec 04             	sub    $0x4,%esp
80103679:	8d 7e 10             	lea    0x10(%esi),%edi
8010367c:	6a 04                	push   $0x4
8010367e:	68 58 7e 10 80       	push   $0x80107e58
80103683:	56                   	push   %esi
80103684:	e8 a7 16 00 00       	call   80104d30 <memcmp>
80103689:	83 c4 10             	add    $0x10,%esp
8010368c:	85 c0                	test   %eax,%eax
8010368e:	75 e0                	jne    80103670 <mpsearch1+0x20>
80103690:	89 f2                	mov    %esi,%edx
80103692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103698:	0f b6 0a             	movzbl (%edx),%ecx
8010369b:	83 c2 01             	add    $0x1,%edx
8010369e:	01 c8                	add    %ecx,%eax
801036a0:	39 fa                	cmp    %edi,%edx
801036a2:	75 f4                	jne    80103698 <mpsearch1+0x48>
801036a4:	84 c0                	test   %al,%al
801036a6:	75 c8                	jne    80103670 <mpsearch1+0x20>
801036a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ab:	89 f0                	mov    %esi,%eax
801036ad:	5b                   	pop    %ebx
801036ae:	5e                   	pop    %esi
801036af:	5f                   	pop    %edi
801036b0:	5d                   	pop    %ebp
801036b1:	c3                   	ret    
801036b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036bb:	31 f6                	xor    %esi,%esi
801036bd:	5b                   	pop    %ebx
801036be:	89 f0                	mov    %esi,%eax
801036c0:	5e                   	pop    %esi
801036c1:	5f                   	pop    %edi
801036c2:	5d                   	pop    %ebp
801036c3:	c3                   	ret    
801036c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036cf:	90                   	nop

801036d0 <mpinit>:
801036d0:	f3 0f 1e fb          	endbr32 
801036d4:	55                   	push   %ebp
801036d5:	89 e5                	mov    %esp,%ebp
801036d7:	57                   	push   %edi
801036d8:	56                   	push   %esi
801036d9:	53                   	push   %ebx
801036da:	83 ec 1c             	sub    $0x1c,%esp
801036dd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801036e4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801036eb:	c1 e0 08             	shl    $0x8,%eax
801036ee:	09 d0                	or     %edx,%eax
801036f0:	c1 e0 04             	shl    $0x4,%eax
801036f3:	75 1b                	jne    80103710 <mpinit+0x40>
801036f5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801036fc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103703:	c1 e0 08             	shl    $0x8,%eax
80103706:	09 d0                	or     %edx,%eax
80103708:	c1 e0 0a             	shl    $0xa,%eax
8010370b:	2d 00 04 00 00       	sub    $0x400,%eax
80103710:	ba 00 04 00 00       	mov    $0x400,%edx
80103715:	e8 36 ff ff ff       	call   80103650 <mpsearch1>
8010371a:	89 c6                	mov    %eax,%esi
8010371c:	85 c0                	test   %eax,%eax
8010371e:	0f 84 4c 01 00 00    	je     80103870 <mpinit+0x1a0>
80103724:	8b 5e 04             	mov    0x4(%esi),%ebx
80103727:	85 db                	test   %ebx,%ebx
80103729:	0f 84 61 01 00 00    	je     80103890 <mpinit+0x1c0>
8010372f:	83 ec 04             	sub    $0x4,%esp
80103732:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80103738:	6a 04                	push   $0x4
8010373a:	68 5d 7e 10 80       	push   $0x80107e5d
8010373f:	50                   	push   %eax
80103740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103743:	e8 e8 15 00 00       	call   80104d30 <memcmp>
80103748:	83 c4 10             	add    $0x10,%esp
8010374b:	85 c0                	test   %eax,%eax
8010374d:	0f 85 3d 01 00 00    	jne    80103890 <mpinit+0x1c0>
80103753:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010375a:	3c 01                	cmp    $0x1,%al
8010375c:	74 08                	je     80103766 <mpinit+0x96>
8010375e:	3c 04                	cmp    $0x4,%al
80103760:	0f 85 2a 01 00 00    	jne    80103890 <mpinit+0x1c0>
80103766:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
8010376d:	66 85 d2             	test   %dx,%dx
80103770:	74 26                	je     80103798 <mpinit+0xc8>
80103772:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103775:	89 d8                	mov    %ebx,%eax
80103777:	31 d2                	xor    %edx,%edx
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103780:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103787:	83 c0 01             	add    $0x1,%eax
8010378a:	01 ca                	add    %ecx,%edx
8010378c:	39 f8                	cmp    %edi,%eax
8010378e:	75 f0                	jne    80103780 <mpinit+0xb0>
80103790:	84 d2                	test   %dl,%dl
80103792:	0f 85 f8 00 00 00    	jne    80103890 <mpinit+0x1c0>
80103798:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010379e:	a3 9c 36 11 80       	mov    %eax,0x8011369c
801037a3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801037a9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
801037b0:	bb 01 00 00 00       	mov    $0x1,%ebx
801037b5:	03 55 e4             	add    -0x1c(%ebp),%edx
801037b8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801037bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037bf:	90                   	nop
801037c0:	39 c2                	cmp    %eax,%edx
801037c2:	76 15                	jbe    801037d9 <mpinit+0x109>
801037c4:	0f b6 08             	movzbl (%eax),%ecx
801037c7:	80 f9 02             	cmp    $0x2,%cl
801037ca:	74 5c                	je     80103828 <mpinit+0x158>
801037cc:	77 42                	ja     80103810 <mpinit+0x140>
801037ce:	84 c9                	test   %cl,%cl
801037d0:	74 6e                	je     80103840 <mpinit+0x170>
801037d2:	83 c0 08             	add    $0x8,%eax
801037d5:	39 c2                	cmp    %eax,%edx
801037d7:	77 eb                	ja     801037c4 <mpinit+0xf4>
801037d9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801037dc:	85 db                	test   %ebx,%ebx
801037de:	0f 84 b9 00 00 00    	je     8010389d <mpinit+0x1cd>
801037e4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801037e8:	74 15                	je     801037ff <mpinit+0x12f>
801037ea:	b8 70 00 00 00       	mov    $0x70,%eax
801037ef:	ba 22 00 00 00       	mov    $0x22,%edx
801037f4:	ee                   	out    %al,(%dx)
801037f5:	ba 23 00 00 00       	mov    $0x23,%edx
801037fa:	ec                   	in     (%dx),%al
801037fb:	83 c8 01             	or     $0x1,%eax
801037fe:	ee                   	out    %al,(%dx)
801037ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103802:	5b                   	pop    %ebx
80103803:	5e                   	pop    %esi
80103804:	5f                   	pop    %edi
80103805:	5d                   	pop    %ebp
80103806:	c3                   	ret    
80103807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010380e:	66 90                	xchg   %ax,%ax
80103810:	83 e9 03             	sub    $0x3,%ecx
80103813:	80 f9 01             	cmp    $0x1,%cl
80103816:	76 ba                	jbe    801037d2 <mpinit+0x102>
80103818:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010381f:	eb 9f                	jmp    801037c0 <mpinit+0xf0>
80103821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103828:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
8010382c:	83 c0 08             	add    $0x8,%eax
8010382f:	88 0d 80 37 11 80    	mov    %cl,0x80113780
80103835:	eb 89                	jmp    801037c0 <mpinit+0xf0>
80103837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010383e:	66 90                	xchg   %ax,%ax
80103840:	8b 0d 20 3d 11 80    	mov    0x80113d20,%ecx
80103846:	83 f9 07             	cmp    $0x7,%ecx
80103849:	7f 19                	jg     80103864 <mpinit+0x194>
8010384b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103851:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103855:	83 c1 01             	add    $0x1,%ecx
80103858:	89 0d 20 3d 11 80    	mov    %ecx,0x80113d20
8010385e:	88 9f a0 37 11 80    	mov    %bl,-0x7feec860(%edi)
80103864:	83 c0 14             	add    $0x14,%eax
80103867:	e9 54 ff ff ff       	jmp    801037c0 <mpinit+0xf0>
8010386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103870:	ba 00 00 01 00       	mov    $0x10000,%edx
80103875:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010387a:	e8 d1 fd ff ff       	call   80103650 <mpsearch1>
8010387f:	89 c6                	mov    %eax,%esi
80103881:	85 c0                	test   %eax,%eax
80103883:	0f 85 9b fe ff ff    	jne    80103724 <mpinit+0x54>
80103889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103890:	83 ec 0c             	sub    $0xc,%esp
80103893:	68 62 7e 10 80       	push   $0x80107e62
80103898:	e8 f3 ca ff ff       	call   80100390 <panic>
8010389d:	83 ec 0c             	sub    $0xc,%esp
801038a0:	68 7c 7e 10 80       	push   $0x80107e7c
801038a5:	e8 e6 ca ff ff       	call   80100390 <panic>
801038aa:	66 90                	xchg   %ax,%ax
801038ac:	66 90                	xchg   %ax,%ax
801038ae:	66 90                	xchg   %ax,%ax

801038b0 <picinit>:
801038b0:	f3 0f 1e fb          	endbr32 
801038b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038b9:	ba 21 00 00 00       	mov    $0x21,%edx
801038be:	ee                   	out    %al,(%dx)
801038bf:	ba a1 00 00 00       	mov    $0xa1,%edx
801038c4:	ee                   	out    %al,(%dx)
801038c5:	c3                   	ret    
801038c6:	66 90                	xchg   %ax,%ax
801038c8:	66 90                	xchg   %ax,%ax
801038ca:	66 90                	xchg   %ax,%ax
801038cc:	66 90                	xchg   %ax,%ax
801038ce:	66 90                	xchg   %ax,%ax

801038d0 <pipealloc>:
801038d0:	f3 0f 1e fb          	endbr32 
801038d4:	55                   	push   %ebp
801038d5:	89 e5                	mov    %esp,%ebp
801038d7:	57                   	push   %edi
801038d8:	56                   	push   %esi
801038d9:	53                   	push   %ebx
801038da:	83 ec 0c             	sub    $0xc,%esp
801038dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038e0:	8b 75 0c             	mov    0xc(%ebp),%esi
801038e3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801038ef:	e8 cc d9 ff ff       	call   801012c0 <filealloc>
801038f4:	89 03                	mov    %eax,(%ebx)
801038f6:	85 c0                	test   %eax,%eax
801038f8:	0f 84 ac 00 00 00    	je     801039aa <pipealloc+0xda>
801038fe:	e8 bd d9 ff ff       	call   801012c0 <filealloc>
80103903:	89 06                	mov    %eax,(%esi)
80103905:	85 c0                	test   %eax,%eax
80103907:	0f 84 8b 00 00 00    	je     80103998 <pipealloc+0xc8>
8010390d:	e8 fe f1 ff ff       	call   80102b10 <kalloc>
80103912:	89 c7                	mov    %eax,%edi
80103914:	85 c0                	test   %eax,%eax
80103916:	0f 84 b4 00 00 00    	je     801039d0 <pipealloc+0x100>
8010391c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103923:	00 00 00 
80103926:	83 ec 08             	sub    $0x8,%esp
80103929:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103930:	00 00 00 
80103933:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010393a:	00 00 00 
8010393d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103944:	00 00 00 
80103947:	68 9b 7e 10 80       	push   $0x80107e9b
8010394c:	50                   	push   %eax
8010394d:	e8 fe 10 00 00       	call   80104a50 <initlock>
80103952:	8b 03                	mov    (%ebx),%eax
80103954:	83 c4 10             	add    $0x10,%esp
80103957:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
8010395d:	8b 03                	mov    (%ebx),%eax
8010395f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103963:	8b 03                	mov    (%ebx),%eax
80103965:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103969:	8b 03                	mov    (%ebx),%eax
8010396b:	89 78 0c             	mov    %edi,0xc(%eax)
8010396e:	8b 06                	mov    (%esi),%eax
80103970:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103976:	8b 06                	mov    (%esi),%eax
80103978:	c6 40 08 00          	movb   $0x0,0x8(%eax)
8010397c:	8b 06                	mov    (%esi),%eax
8010397e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103982:	8b 06                	mov    (%esi),%eax
80103984:	89 78 0c             	mov    %edi,0xc(%eax)
80103987:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010398a:	31 c0                	xor    %eax,%eax
8010398c:	5b                   	pop    %ebx
8010398d:	5e                   	pop    %esi
8010398e:	5f                   	pop    %edi
8010398f:	5d                   	pop    %ebp
80103990:	c3                   	ret    
80103991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103998:	8b 03                	mov    (%ebx),%eax
8010399a:	85 c0                	test   %eax,%eax
8010399c:	74 1e                	je     801039bc <pipealloc+0xec>
8010399e:	83 ec 0c             	sub    $0xc,%esp
801039a1:	50                   	push   %eax
801039a2:	e8 d9 d9 ff ff       	call   80101380 <fileclose>
801039a7:	83 c4 10             	add    $0x10,%esp
801039aa:	8b 06                	mov    (%esi),%eax
801039ac:	85 c0                	test   %eax,%eax
801039ae:	74 0c                	je     801039bc <pipealloc+0xec>
801039b0:	83 ec 0c             	sub    $0xc,%esp
801039b3:	50                   	push   %eax
801039b4:	e8 c7 d9 ff ff       	call   80101380 <fileclose>
801039b9:	83 c4 10             	add    $0x10,%esp
801039bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801039c4:	5b                   	pop    %ebx
801039c5:	5e                   	pop    %esi
801039c6:	5f                   	pop    %edi
801039c7:	5d                   	pop    %ebp
801039c8:	c3                   	ret    
801039c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039d0:	8b 03                	mov    (%ebx),%eax
801039d2:	85 c0                	test   %eax,%eax
801039d4:	75 c8                	jne    8010399e <pipealloc+0xce>
801039d6:	eb d2                	jmp    801039aa <pipealloc+0xda>
801039d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039df:	90                   	nop

801039e0 <pipeclose>:
801039e0:	f3 0f 1e fb          	endbr32 
801039e4:	55                   	push   %ebp
801039e5:	89 e5                	mov    %esp,%ebp
801039e7:	56                   	push   %esi
801039e8:	53                   	push   %ebx
801039e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801039ef:	83 ec 0c             	sub    $0xc,%esp
801039f2:	53                   	push   %ebx
801039f3:	e8 d8 11 00 00       	call   80104bd0 <acquire>
801039f8:	83 c4 10             	add    $0x10,%esp
801039fb:	85 f6                	test   %esi,%esi
801039fd:	74 41                	je     80103a40 <pipeclose+0x60>
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103a08:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a0f:	00 00 00 
80103a12:	50                   	push   %eax
80103a13:	e8 b8 0b 00 00       	call   801045d0 <wakeup>
80103a18:	83 c4 10             	add    $0x10,%esp
80103a1b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a21:	85 d2                	test   %edx,%edx
80103a23:	75 0a                	jne    80103a2f <pipeclose+0x4f>
80103a25:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a2b:	85 c0                	test   %eax,%eax
80103a2d:	74 31                	je     80103a60 <pipeclose+0x80>
80103a2f:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a35:	5b                   	pop    %ebx
80103a36:	5e                   	pop    %esi
80103a37:	5d                   	pop    %ebp
80103a38:	e9 53 12 00 00       	jmp    80104c90 <release>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103a49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a50:	00 00 00 
80103a53:	50                   	push   %eax
80103a54:	e8 77 0b 00 00       	call   801045d0 <wakeup>
80103a59:	83 c4 10             	add    $0x10,%esp
80103a5c:	eb bd                	jmp    80103a1b <pipeclose+0x3b>
80103a5e:	66 90                	xchg   %ax,%ax
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	53                   	push   %ebx
80103a64:	e8 27 12 00 00       	call   80104c90 <release>
80103a69:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a6c:	83 c4 10             	add    $0x10,%esp
80103a6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a72:	5b                   	pop    %ebx
80103a73:	5e                   	pop    %esi
80103a74:	5d                   	pop    %ebp
80103a75:	e9 d6 ee ff ff       	jmp    80102950 <kfree>
80103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a80 <pipewrite>:
80103a80:	f3 0f 1e fb          	endbr32 
80103a84:	55                   	push   %ebp
80103a85:	89 e5                	mov    %esp,%ebp
80103a87:	57                   	push   %edi
80103a88:	56                   	push   %esi
80103a89:	53                   	push   %ebx
80103a8a:	83 ec 28             	sub    $0x28,%esp
80103a8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a90:	53                   	push   %ebx
80103a91:	e8 3a 11 00 00       	call   80104bd0 <acquire>
80103a96:	8b 45 10             	mov    0x10(%ebp),%eax
80103a99:	83 c4 10             	add    $0x10,%esp
80103a9c:	85 c0                	test   %eax,%eax
80103a9e:	0f 8e bc 00 00 00    	jle    80103b60 <pipewrite+0xe0>
80103aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103aa7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
80103aad:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103ab3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ab6:	03 45 10             	add    0x10(%ebp),%eax
80103ab9:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103abc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103ac2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103ac8:	89 ca                	mov    %ecx,%edx
80103aca:	05 00 02 00 00       	add    $0x200,%eax
80103acf:	39 c1                	cmp    %eax,%ecx
80103ad1:	74 3b                	je     80103b0e <pipewrite+0x8e>
80103ad3:	eb 63                	jmp    80103b38 <pipewrite+0xb8>
80103ad5:	8d 76 00             	lea    0x0(%esi),%esi
80103ad8:	e8 63 03 00 00       	call   80103e40 <myproc>
80103add:	8b 48 28             	mov    0x28(%eax),%ecx
80103ae0:	85 c9                	test   %ecx,%ecx
80103ae2:	75 34                	jne    80103b18 <pipewrite+0x98>
80103ae4:	83 ec 0c             	sub    $0xc,%esp
80103ae7:	57                   	push   %edi
80103ae8:	e8 e3 0a 00 00       	call   801045d0 <wakeup>
80103aed:	58                   	pop    %eax
80103aee:	5a                   	pop    %edx
80103aef:	53                   	push   %ebx
80103af0:	56                   	push   %esi
80103af1:	e8 1a 09 00 00       	call   80104410 <sleep>
80103af6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103afc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b02:	83 c4 10             	add    $0x10,%esp
80103b05:	05 00 02 00 00       	add    $0x200,%eax
80103b0a:	39 c2                	cmp    %eax,%edx
80103b0c:	75 2a                	jne    80103b38 <pipewrite+0xb8>
80103b0e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b14:	85 c0                	test   %eax,%eax
80103b16:	75 c0                	jne    80103ad8 <pipewrite+0x58>
80103b18:	83 ec 0c             	sub    $0xc,%esp
80103b1b:	53                   	push   %ebx
80103b1c:	e8 6f 11 00 00       	call   80104c90 <release>
80103b21:	83 c4 10             	add    $0x10,%esp
80103b24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103b29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b2c:	5b                   	pop    %ebx
80103b2d:	5e                   	pop    %esi
80103b2e:	5f                   	pop    %edi
80103b2f:	5d                   	pop    %ebp
80103b30:	c3                   	ret    
80103b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103b38:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b3b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b3e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b44:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103b4a:	0f b6 06             	movzbl (%esi),%eax
80103b4d:	83 c6 01             	add    $0x1,%esi
80103b50:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103b53:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80103b57:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b5a:	0f 85 5c ff ff ff    	jne    80103abc <pipewrite+0x3c>
80103b60:	83 ec 0c             	sub    $0xc,%esp
80103b63:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b69:	50                   	push   %eax
80103b6a:	e8 61 0a 00 00       	call   801045d0 <wakeup>
80103b6f:	89 1c 24             	mov    %ebx,(%esp)
80103b72:	e8 19 11 00 00       	call   80104c90 <release>
80103b77:	8b 45 10             	mov    0x10(%ebp),%eax
80103b7a:	83 c4 10             	add    $0x10,%esp
80103b7d:	eb aa                	jmp    80103b29 <pipewrite+0xa9>
80103b7f:	90                   	nop

80103b80 <piperead>:
80103b80:	f3 0f 1e fb          	endbr32 
80103b84:	55                   	push   %ebp
80103b85:	89 e5                	mov    %esp,%ebp
80103b87:	57                   	push   %edi
80103b88:	56                   	push   %esi
80103b89:	53                   	push   %ebx
80103b8a:	83 ec 18             	sub    $0x18,%esp
80103b8d:	8b 75 08             	mov    0x8(%ebp),%esi
80103b90:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103b93:	56                   	push   %esi
80103b94:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103b9a:	e8 31 10 00 00       	call   80104bd0 <acquire>
80103b9f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ba5:	83 c4 10             	add    $0x10,%esp
80103ba8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bae:	74 33                	je     80103be3 <piperead+0x63>
80103bb0:	eb 3b                	jmp    80103bed <piperead+0x6d>
80103bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103bb8:	e8 83 02 00 00       	call   80103e40 <myproc>
80103bbd:	8b 48 28             	mov    0x28(%eax),%ecx
80103bc0:	85 c9                	test   %ecx,%ecx
80103bc2:	0f 85 88 00 00 00    	jne    80103c50 <piperead+0xd0>
80103bc8:	83 ec 08             	sub    $0x8,%esp
80103bcb:	56                   	push   %esi
80103bcc:	53                   	push   %ebx
80103bcd:	e8 3e 08 00 00       	call   80104410 <sleep>
80103bd2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103bd8:	83 c4 10             	add    $0x10,%esp
80103bdb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103be1:	75 0a                	jne    80103bed <piperead+0x6d>
80103be3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103be9:	85 c0                	test   %eax,%eax
80103beb:	75 cb                	jne    80103bb8 <piperead+0x38>
80103bed:	8b 55 10             	mov    0x10(%ebp),%edx
80103bf0:	31 db                	xor    %ebx,%ebx
80103bf2:	85 d2                	test   %edx,%edx
80103bf4:	7f 28                	jg     80103c1e <piperead+0x9e>
80103bf6:	eb 34                	jmp    80103c2c <piperead+0xac>
80103bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bff:	90                   	nop
80103c00:	8d 48 01             	lea    0x1(%eax),%ecx
80103c03:	25 ff 01 00 00       	and    $0x1ff,%eax
80103c08:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103c0e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103c13:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103c16:	83 c3 01             	add    $0x1,%ebx
80103c19:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c1c:	74 0e                	je     80103c2c <piperead+0xac>
80103c1e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c24:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c2a:	75 d4                	jne    80103c00 <piperead+0x80>
80103c2c:	83 ec 0c             	sub    $0xc,%esp
80103c2f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c35:	50                   	push   %eax
80103c36:	e8 95 09 00 00       	call   801045d0 <wakeup>
80103c3b:	89 34 24             	mov    %esi,(%esp)
80103c3e:	e8 4d 10 00 00       	call   80104c90 <release>
80103c43:	83 c4 10             	add    $0x10,%esp
80103c46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c49:	89 d8                	mov    %ebx,%eax
80103c4b:	5b                   	pop    %ebx
80103c4c:	5e                   	pop    %esi
80103c4d:	5f                   	pop    %edi
80103c4e:	5d                   	pop    %ebp
80103c4f:	c3                   	ret    
80103c50:	83 ec 0c             	sub    $0xc,%esp
80103c53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c58:	56                   	push   %esi
80103c59:	e8 32 10 00 00       	call   80104c90 <release>
80103c5e:	83 c4 10             	add    $0x10,%esp
80103c61:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c64:	89 d8                	mov    %ebx,%eax
80103c66:	5b                   	pop    %ebx
80103c67:	5e                   	pop    %esi
80103c68:	5f                   	pop    %edi
80103c69:	5d                   	pop    %ebp
80103c6a:	c3                   	ret    
80103c6b:	66 90                	xchg   %ax,%ax
80103c6d:	66 90                	xchg   %ax,%ax
80103c6f:	90                   	nop

80103c70 <allocproc>:
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	53                   	push   %ebx
80103c74:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
80103c79:	83 ec 10             	sub    $0x10,%esp
80103c7c:	68 40 3d 11 80       	push   $0x80113d40
80103c81:	e8 4a 0f 00 00       	call   80104bd0 <acquire>
80103c86:	83 c4 10             	add    $0x10,%esp
80103c89:	eb 10                	jmp    80103c9b <allocproc+0x2b>
80103c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c8f:	90                   	nop
80103c90:	83 eb 80             	sub    $0xffffff80,%ebx
80103c93:	81 fb 74 5d 11 80    	cmp    $0x80115d74,%ebx
80103c99:	74 75                	je     80103d10 <allocproc+0xa0>
80103c9b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103c9e:	85 c0                	test   %eax,%eax
80103ca0:	75 ee                	jne    80103c90 <allocproc+0x20>
80103ca2:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80103ca7:	83 ec 0c             	sub    $0xc,%esp
80103caa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80103cb1:	89 43 10             	mov    %eax,0x10(%ebx)
80103cb4:	8d 50 01             	lea    0x1(%eax),%edx
80103cb7:	68 40 3d 11 80       	push   $0x80113d40
80103cbc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80103cc2:	e8 c9 0f 00 00       	call   80104c90 <release>
80103cc7:	e8 44 ee ff ff       	call   80102b10 <kalloc>
80103ccc:	83 c4 10             	add    $0x10,%esp
80103ccf:	89 43 08             	mov    %eax,0x8(%ebx)
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	74 53                	je     80103d29 <allocproc+0xb9>
80103cd6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
80103cdc:	83 ec 04             	sub    $0x4,%esp
80103cdf:	05 9c 0f 00 00       	add    $0xf9c,%eax
80103ce4:	89 53 1c             	mov    %edx,0x1c(%ebx)
80103ce7:	c7 40 14 9f 60 10 80 	movl   $0x8010609f,0x14(%eax)
80103cee:	89 43 20             	mov    %eax,0x20(%ebx)
80103cf1:	6a 14                	push   $0x14
80103cf3:	6a 00                	push   $0x0
80103cf5:	50                   	push   %eax
80103cf6:	e8 e5 0f 00 00       	call   80104ce0 <memset>
80103cfb:	8b 43 20             	mov    0x20(%ebx),%eax
80103cfe:	83 c4 10             	add    $0x10,%esp
80103d01:	c7 40 10 40 3d 10 80 	movl   $0x80103d40,0x10(%eax)
80103d08:	89 d8                	mov    %ebx,%eax
80103d0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d0d:	c9                   	leave  
80103d0e:	c3                   	ret    
80103d0f:	90                   	nop
80103d10:	83 ec 0c             	sub    $0xc,%esp
80103d13:	31 db                	xor    %ebx,%ebx
80103d15:	68 40 3d 11 80       	push   $0x80113d40
80103d1a:	e8 71 0f 00 00       	call   80104c90 <release>
80103d1f:	89 d8                	mov    %ebx,%eax
80103d21:	83 c4 10             	add    $0x10,%esp
80103d24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d27:	c9                   	leave  
80103d28:	c3                   	ret    
80103d29:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80103d30:	31 db                	xor    %ebx,%ebx
80103d32:	89 d8                	mov    %ebx,%eax
80103d34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d37:	c9                   	leave  
80103d38:	c3                   	ret    
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <forkret>:
80103d40:	f3 0f 1e fb          	endbr32 
80103d44:	55                   	push   %ebp
80103d45:	89 e5                	mov    %esp,%ebp
80103d47:	83 ec 14             	sub    $0x14,%esp
80103d4a:	68 40 3d 11 80       	push   $0x80113d40
80103d4f:	e8 3c 0f 00 00       	call   80104c90 <release>
80103d54:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103d59:	83 c4 10             	add    $0x10,%esp
80103d5c:	85 c0                	test   %eax,%eax
80103d5e:	75 08                	jne    80103d68 <forkret+0x28>
80103d60:	c9                   	leave  
80103d61:	c3                   	ret    
80103d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103d68:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103d6f:	00 00 00 
80103d72:	83 ec 0c             	sub    $0xc,%esp
80103d75:	6a 01                	push   $0x1
80103d77:	e8 84 dc ff ff       	call   80101a00 <iinit>
80103d7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103d83:	e8 e8 f3 ff ff       	call   80103170 <initlog>
80103d88:	83 c4 10             	add    $0x10,%esp
80103d8b:	c9                   	leave  
80103d8c:	c3                   	ret    
80103d8d:	8d 76 00             	lea    0x0(%esi),%esi

80103d90 <pinit>:
80103d90:	f3 0f 1e fb          	endbr32 
80103d94:	55                   	push   %ebp
80103d95:	89 e5                	mov    %esp,%ebp
80103d97:	83 ec 10             	sub    $0x10,%esp
80103d9a:	68 a0 7e 10 80       	push   $0x80107ea0
80103d9f:	68 40 3d 11 80       	push   $0x80113d40
80103da4:	e8 a7 0c 00 00       	call   80104a50 <initlock>
80103da9:	83 c4 10             	add    $0x10,%esp
80103dac:	c9                   	leave  
80103dad:	c3                   	ret    
80103dae:	66 90                	xchg   %ax,%ax

80103db0 <mycpu>:
80103db0:	f3 0f 1e fb          	endbr32 
80103db4:	55                   	push   %ebp
80103db5:	89 e5                	mov    %esp,%ebp
80103db7:	56                   	push   %esi
80103db8:	53                   	push   %ebx
80103db9:	9c                   	pushf  
80103dba:	58                   	pop    %eax
80103dbb:	f6 c4 02             	test   $0x2,%ah
80103dbe:	75 4a                	jne    80103e0a <mycpu+0x5a>
80103dc0:	e8 bb ef ff ff       	call   80102d80 <lapicid>
80103dc5:	8b 35 20 3d 11 80    	mov    0x80113d20,%esi
80103dcb:	89 c3                	mov    %eax,%ebx
80103dcd:	85 f6                	test   %esi,%esi
80103dcf:	7e 2c                	jle    80103dfd <mycpu+0x4d>
80103dd1:	31 d2                	xor    %edx,%edx
80103dd3:	eb 0a                	jmp    80103ddf <mycpu+0x2f>
80103dd5:	8d 76 00             	lea    0x0(%esi),%esi
80103dd8:	83 c2 01             	add    $0x1,%edx
80103ddb:	39 f2                	cmp    %esi,%edx
80103ddd:	74 1e                	je     80103dfd <mycpu+0x4d>
80103ddf:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103de5:	0f b6 81 a0 37 11 80 	movzbl -0x7feec860(%ecx),%eax
80103dec:	39 d8                	cmp    %ebx,%eax
80103dee:	75 e8                	jne    80103dd8 <mycpu+0x28>
80103df0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df3:	8d 81 a0 37 11 80    	lea    -0x7feec860(%ecx),%eax
80103df9:	5b                   	pop    %ebx
80103dfa:	5e                   	pop    %esi
80103dfb:	5d                   	pop    %ebp
80103dfc:	c3                   	ret    
80103dfd:	83 ec 0c             	sub    $0xc,%esp
80103e00:	68 a7 7e 10 80       	push   $0x80107ea7
80103e05:	e8 86 c5 ff ff       	call   80100390 <panic>
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 84 7f 10 80       	push   $0x80107f84
80103e12:	e8 79 c5 ff ff       	call   80100390 <panic>
80103e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e1e:	66 90                	xchg   %ax,%ax

80103e20 <cpuid>:
80103e20:	f3 0f 1e fb          	endbr32 
80103e24:	55                   	push   %ebp
80103e25:	89 e5                	mov    %esp,%ebp
80103e27:	83 ec 08             	sub    $0x8,%esp
80103e2a:	e8 81 ff ff ff       	call   80103db0 <mycpu>
80103e2f:	c9                   	leave  
80103e30:	2d a0 37 11 80       	sub    $0x801137a0,%eax
80103e35:	c1 f8 04             	sar    $0x4,%eax
80103e38:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
80103e3e:	c3                   	ret    
80103e3f:	90                   	nop

80103e40 <myproc>:
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	53                   	push   %ebx
80103e48:	83 ec 04             	sub    $0x4,%esp
80103e4b:	e8 80 0c 00 00       	call   80104ad0 <pushcli>
80103e50:	e8 5b ff ff ff       	call   80103db0 <mycpu>
80103e55:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103e5b:	e8 c0 0c 00 00       	call   80104b20 <popcli>
80103e60:	83 c4 04             	add    $0x4,%esp
80103e63:	89 d8                	mov    %ebx,%eax
80103e65:	5b                   	pop    %ebx
80103e66:	5d                   	pop    %ebp
80103e67:	c3                   	ret    
80103e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e6f:	90                   	nop

80103e70 <userinit>:
80103e70:	f3 0f 1e fb          	endbr32 
80103e74:	55                   	push   %ebp
80103e75:	89 e5                	mov    %esp,%ebp
80103e77:	53                   	push   %ebx
80103e78:	83 ec 04             	sub    $0x4,%esp
80103e7b:	e8 f0 fd ff ff       	call   80103c70 <allocproc>
80103e80:	89 c3                	mov    %eax,%ebx
80103e82:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
80103e87:	e8 d4 37 00 00       	call   80107660 <setupkvm>
80103e8c:	89 43 04             	mov    %eax,0x4(%ebx)
80103e8f:	85 c0                	test   %eax,%eax
80103e91:	0f 84 bd 00 00 00    	je     80103f54 <userinit+0xe4>
80103e97:	83 ec 04             	sub    $0x4,%esp
80103e9a:	68 2c 00 00 00       	push   $0x2c
80103e9f:	68 60 b4 10 80       	push   $0x8010b460
80103ea4:	50                   	push   %eax
80103ea5:	e8 86 34 00 00       	call   80107330 <inituvm>
80103eaa:	83 c4 0c             	add    $0xc,%esp
80103ead:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
80103eb3:	6a 4c                	push   $0x4c
80103eb5:	6a 00                	push   $0x0
80103eb7:	ff 73 1c             	pushl  0x1c(%ebx)
80103eba:	e8 21 0e 00 00       	call   80104ce0 <memset>
80103ebf:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ec2:	ba 1b 00 00 00       	mov    $0x1b,%edx
80103ec7:	83 c4 0c             	add    $0xc,%esp
80103eca:	b9 23 00 00 00       	mov    $0x23,%ecx
80103ecf:	66 89 50 3c          	mov    %dx,0x3c(%eax)
80103ed3:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ed6:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80103eda:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103edd:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ee1:	66 89 50 28          	mov    %dx,0x28(%eax)
80103ee5:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ee8:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103eec:	66 89 50 48          	mov    %dx,0x48(%eax)
80103ef0:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103ef3:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
80103efa:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103efd:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
80103f04:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f07:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
80103f0e:	8d 43 70             	lea    0x70(%ebx),%eax
80103f11:	6a 10                	push   $0x10
80103f13:	68 d0 7e 10 80       	push   $0x80107ed0
80103f18:	50                   	push   %eax
80103f19:	e8 82 0f 00 00       	call   80104ea0 <safestrcpy>
80103f1e:	c7 04 24 d9 7e 10 80 	movl   $0x80107ed9,(%esp)
80103f25:	e8 c6 e5 ff ff       	call   801024f0 <namei>
80103f2a:	89 43 6c             	mov    %eax,0x6c(%ebx)
80103f2d:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103f34:	e8 97 0c 00 00       	call   80104bd0 <acquire>
80103f39:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
80103f40:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
80103f47:	e8 44 0d 00 00       	call   80104c90 <release>
80103f4c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103f4f:	83 c4 10             	add    $0x10,%esp
80103f52:	c9                   	leave  
80103f53:	c3                   	ret    
80103f54:	83 ec 0c             	sub    $0xc,%esp
80103f57:	68 b7 7e 10 80       	push   $0x80107eb7
80103f5c:	e8 2f c4 ff ff       	call   80100390 <panic>
80103f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f6f:	90                   	nop

80103f70 <growproc>:
80103f70:	f3 0f 1e fb          	endbr32 
80103f74:	55                   	push   %ebp
80103f75:	89 e5                	mov    %esp,%ebp
80103f77:	56                   	push   %esi
80103f78:	53                   	push   %ebx
80103f79:	8b 75 08             	mov    0x8(%ebp),%esi
80103f7c:	e8 4f 0b 00 00       	call   80104ad0 <pushcli>
80103f81:	e8 2a fe ff ff       	call   80103db0 <mycpu>
80103f86:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80103f8c:	e8 8f 0b 00 00       	call   80104b20 <popcli>
80103f91:	8b 03                	mov    (%ebx),%eax
80103f93:	85 f6                	test   %esi,%esi
80103f95:	7f 19                	jg     80103fb0 <growproc+0x40>
80103f97:	75 37                	jne    80103fd0 <growproc+0x60>
80103f99:	83 ec 0c             	sub    $0xc,%esp
80103f9c:	89 03                	mov    %eax,(%ebx)
80103f9e:	53                   	push   %ebx
80103f9f:	e8 7c 32 00 00       	call   80107220 <switchuvm>
80103fa4:	83 c4 10             	add    $0x10,%esp
80103fa7:	31 c0                	xor    %eax,%eax
80103fa9:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fac:	5b                   	pop    %ebx
80103fad:	5e                   	pop    %esi
80103fae:	5d                   	pop    %ebp
80103faf:	c3                   	ret    
80103fb0:	83 ec 04             	sub    $0x4,%esp
80103fb3:	01 c6                	add    %eax,%esi
80103fb5:	56                   	push   %esi
80103fb6:	50                   	push   %eax
80103fb7:	ff 73 04             	pushl  0x4(%ebx)
80103fba:	e8 c1 34 00 00       	call   80107480 <allocuvm>
80103fbf:	83 c4 10             	add    $0x10,%esp
80103fc2:	85 c0                	test   %eax,%eax
80103fc4:	75 d3                	jne    80103f99 <growproc+0x29>
80103fc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103fcb:	eb dc                	jmp    80103fa9 <growproc+0x39>
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi
80103fd0:	83 ec 04             	sub    $0x4,%esp
80103fd3:	01 c6                	add    %eax,%esi
80103fd5:	56                   	push   %esi
80103fd6:	50                   	push   %eax
80103fd7:	ff 73 04             	pushl  0x4(%ebx)
80103fda:	e8 d1 35 00 00       	call   801075b0 <deallocuvm>
80103fdf:	83 c4 10             	add    $0x10,%esp
80103fe2:	85 c0                	test   %eax,%eax
80103fe4:	75 b3                	jne    80103f99 <growproc+0x29>
80103fe6:	eb de                	jmp    80103fc6 <growproc+0x56>
80103fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fef:	90                   	nop

80103ff0 <fork>:
80103ff0:	f3 0f 1e fb          	endbr32 
80103ff4:	55                   	push   %ebp
80103ff5:	89 e5                	mov    %esp,%ebp
80103ff7:	57                   	push   %edi
80103ff8:	56                   	push   %esi
80103ff9:	53                   	push   %ebx
80103ffa:	83 ec 1c             	sub    $0x1c,%esp
80103ffd:	e8 ce 0a 00 00       	call   80104ad0 <pushcli>
80104002:	e8 a9 fd ff ff       	call   80103db0 <mycpu>
80104007:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
8010400d:	e8 0e 0b 00 00       	call   80104b20 <popcli>
80104012:	e8 59 fc ff ff       	call   80103c70 <allocproc>
80104017:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010401a:	85 c0                	test   %eax,%eax
8010401c:	0f 84 c3 00 00 00    	je     801040e5 <fork+0xf5>
80104022:	83 ec 08             	sub    $0x8,%esp
80104025:	ff 33                	pushl  (%ebx)
80104027:	89 c7                	mov    %eax,%edi
80104029:	ff 73 04             	pushl  0x4(%ebx)
8010402c:	e8 ff 36 00 00       	call   80107730 <copyuvm>
80104031:	83 c4 10             	add    $0x10,%esp
80104034:	89 47 04             	mov    %eax,0x4(%edi)
80104037:	85 c0                	test   %eax,%eax
80104039:	0f 84 ad 00 00 00    	je     801040ec <fork+0xfc>
8010403f:	8b 03                	mov    (%ebx),%eax
80104041:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104044:	89 01                	mov    %eax,(%ecx)
80104046:	8b 79 1c             	mov    0x1c(%ecx),%edi
80104049:	89 c8                	mov    %ecx,%eax
8010404b:	89 59 14             	mov    %ebx,0x14(%ecx)
8010404e:	c7 41 18 00 00 00 00 	movl   $0x0,0x18(%ecx)
80104055:	b9 13 00 00 00       	mov    $0x13,%ecx
8010405a:	8b 73 1c             	mov    0x1c(%ebx),%esi
8010405d:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
8010405f:	31 f6                	xor    %esi,%esi
80104061:	8b 40 1c             	mov    0x1c(%eax),%eax
80104064:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
8010406b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010406f:	90                   	nop
80104070:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80104074:	85 c0                	test   %eax,%eax
80104076:	74 13                	je     8010408b <fork+0x9b>
80104078:	83 ec 0c             	sub    $0xc,%esp
8010407b:	50                   	push   %eax
8010407c:	e8 af d2 ff ff       	call   80101330 <filedup>
80104081:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104084:	83 c4 10             	add    $0x10,%esp
80104087:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
8010408b:	83 c6 01             	add    $0x1,%esi
8010408e:	83 fe 10             	cmp    $0x10,%esi
80104091:	75 dd                	jne    80104070 <fork+0x80>
80104093:	83 ec 0c             	sub    $0xc,%esp
80104096:	ff 73 6c             	pushl  0x6c(%ebx)
80104099:	83 c3 70             	add    $0x70,%ebx
8010409c:	e8 4f db ff ff       	call   80101bf0 <idup>
801040a1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801040a4:	83 c4 0c             	add    $0xc,%esp
801040a7:	89 47 6c             	mov    %eax,0x6c(%edi)
801040aa:	8d 47 70             	lea    0x70(%edi),%eax
801040ad:	6a 10                	push   $0x10
801040af:	53                   	push   %ebx
801040b0:	50                   	push   %eax
801040b1:	e8 ea 0d 00 00       	call   80104ea0 <safestrcpy>
801040b6:	8b 5f 10             	mov    0x10(%edi),%ebx
801040b9:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801040c0:	e8 0b 0b 00 00       	call   80104bd0 <acquire>
801040c5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
801040cc:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801040d3:	e8 b8 0b 00 00       	call   80104c90 <release>
801040d8:	83 c4 10             	add    $0x10,%esp
801040db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801040de:	89 d8                	mov    %ebx,%eax
801040e0:	5b                   	pop    %ebx
801040e1:	5e                   	pop    %esi
801040e2:	5f                   	pop    %edi
801040e3:	5d                   	pop    %ebp
801040e4:	c3                   	ret    
801040e5:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801040ea:	eb ef                	jmp    801040db <fork+0xeb>
801040ec:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801040ef:	83 ec 0c             	sub    $0xc,%esp
801040f2:	ff 73 08             	pushl  0x8(%ebx)
801040f5:	e8 56 e8 ff ff       	call   80102950 <kfree>
801040fa:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104101:	83 c4 10             	add    $0x10,%esp
80104104:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010410b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104110:	eb c9                	jmp    801040db <fork+0xeb>
80104112:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104120 <scheduler>:
80104120:	f3 0f 1e fb          	endbr32 
80104124:	55                   	push   %ebp
80104125:	89 e5                	mov    %esp,%ebp
80104127:	57                   	push   %edi
80104128:	56                   	push   %esi
80104129:	53                   	push   %ebx
8010412a:	83 ec 0c             	sub    $0xc,%esp
8010412d:	e8 7e fc ff ff       	call   80103db0 <mycpu>
80104132:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104139:	00 00 00 
8010413c:	89 c6                	mov    %eax,%esi
8010413e:	8d 78 04             	lea    0x4(%eax),%edi
80104141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104148:	fb                   	sti    
80104149:	83 ec 0c             	sub    $0xc,%esp
8010414c:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
80104151:	68 40 3d 11 80       	push   $0x80113d40
80104156:	e8 75 0a 00 00       	call   80104bd0 <acquire>
8010415b:	83 c4 10             	add    $0x10,%esp
8010415e:	66 90                	xchg   %ax,%ax
80104160:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104164:	75 33                	jne    80104199 <scheduler+0x79>
80104166:	83 ec 0c             	sub    $0xc,%esp
80104169:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
8010416f:	53                   	push   %ebx
80104170:	e8 ab 30 00 00       	call   80107220 <switchuvm>
80104175:	58                   	pop    %eax
80104176:	5a                   	pop    %edx
80104177:	ff 73 20             	pushl  0x20(%ebx)
8010417a:	57                   	push   %edi
8010417b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104182:	e8 7c 0d 00 00       	call   80104f03 <swtch>
80104187:	e8 74 30 00 00       	call   80107200 <switchkvm>
8010418c:	83 c4 10             	add    $0x10,%esp
8010418f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104196:	00 00 00 
80104199:	83 eb 80             	sub    $0xffffff80,%ebx
8010419c:	81 fb 74 5d 11 80    	cmp    $0x80115d74,%ebx
801041a2:	75 bc                	jne    80104160 <scheduler+0x40>
801041a4:	83 ec 0c             	sub    $0xc,%esp
801041a7:	68 40 3d 11 80       	push   $0x80113d40
801041ac:	e8 df 0a 00 00       	call   80104c90 <release>
801041b1:	83 c4 10             	add    $0x10,%esp
801041b4:	eb 92                	jmp    80104148 <scheduler+0x28>
801041b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041bd:	8d 76 00             	lea    0x0(%esi),%esi

801041c0 <sched>:
801041c0:	f3 0f 1e fb          	endbr32 
801041c4:	55                   	push   %ebp
801041c5:	89 e5                	mov    %esp,%ebp
801041c7:	56                   	push   %esi
801041c8:	53                   	push   %ebx
801041c9:	e8 02 09 00 00       	call   80104ad0 <pushcli>
801041ce:	e8 dd fb ff ff       	call   80103db0 <mycpu>
801041d3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801041d9:	e8 42 09 00 00       	call   80104b20 <popcli>
801041de:	83 ec 0c             	sub    $0xc,%esp
801041e1:	68 40 3d 11 80       	push   $0x80113d40
801041e6:	e8 95 09 00 00       	call   80104b80 <holding>
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	85 c0                	test   %eax,%eax
801041f0:	74 4f                	je     80104241 <sched+0x81>
801041f2:	e8 b9 fb ff ff       	call   80103db0 <mycpu>
801041f7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801041fe:	75 68                	jne    80104268 <sched+0xa8>
80104200:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104204:	74 55                	je     8010425b <sched+0x9b>
80104206:	9c                   	pushf  
80104207:	58                   	pop    %eax
80104208:	f6 c4 02             	test   $0x2,%ah
8010420b:	75 41                	jne    8010424e <sched+0x8e>
8010420d:	e8 9e fb ff ff       	call   80103db0 <mycpu>
80104212:	83 c3 20             	add    $0x20,%ebx
80104215:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
8010421b:	e8 90 fb ff ff       	call   80103db0 <mycpu>
80104220:	83 ec 08             	sub    $0x8,%esp
80104223:	ff 70 04             	pushl  0x4(%eax)
80104226:	53                   	push   %ebx
80104227:	e8 d7 0c 00 00       	call   80104f03 <swtch>
8010422c:	e8 7f fb ff ff       	call   80103db0 <mycpu>
80104231:	83 c4 10             	add    $0x10,%esp
80104234:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
8010423a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010423d:	5b                   	pop    %ebx
8010423e:	5e                   	pop    %esi
8010423f:	5d                   	pop    %ebp
80104240:	c3                   	ret    
80104241:	83 ec 0c             	sub    $0xc,%esp
80104244:	68 db 7e 10 80       	push   $0x80107edb
80104249:	e8 42 c1 ff ff       	call   80100390 <panic>
8010424e:	83 ec 0c             	sub    $0xc,%esp
80104251:	68 07 7f 10 80       	push   $0x80107f07
80104256:	e8 35 c1 ff ff       	call   80100390 <panic>
8010425b:	83 ec 0c             	sub    $0xc,%esp
8010425e:	68 f9 7e 10 80       	push   $0x80107ef9
80104263:	e8 28 c1 ff ff       	call   80100390 <panic>
80104268:	83 ec 0c             	sub    $0xc,%esp
8010426b:	68 ed 7e 10 80       	push   $0x80107eed
80104270:	e8 1b c1 ff ff       	call   80100390 <panic>
80104275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010427c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104280 <exit>:
80104280:	f3 0f 1e fb          	endbr32 
80104284:	55                   	push   %ebp
80104285:	89 e5                	mov    %esp,%ebp
80104287:	57                   	push   %edi
80104288:	56                   	push   %esi
80104289:	53                   	push   %ebx
8010428a:	83 ec 0c             	sub    $0xc,%esp
8010428d:	e8 3e 08 00 00       	call   80104ad0 <pushcli>
80104292:	e8 19 fb ff ff       	call   80103db0 <mycpu>
80104297:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
8010429d:	e8 7e 08 00 00       	call   80104b20 <popcli>
801042a2:	8d 5e 2c             	lea    0x2c(%esi),%ebx
801042a5:	8d 7e 6c             	lea    0x6c(%esi),%edi
801042a8:	39 35 d8 b5 10 80    	cmp    %esi,0x8010b5d8
801042ae:	0f 84 f3 00 00 00    	je     801043a7 <exit+0x127>
801042b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801042b8:	8b 03                	mov    (%ebx),%eax
801042ba:	85 c0                	test   %eax,%eax
801042bc:	74 12                	je     801042d0 <exit+0x50>
801042be:	83 ec 0c             	sub    $0xc,%esp
801042c1:	50                   	push   %eax
801042c2:	e8 b9 d0 ff ff       	call   80101380 <fileclose>
801042c7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801042cd:	83 c4 10             	add    $0x10,%esp
801042d0:	83 c3 04             	add    $0x4,%ebx
801042d3:	39 df                	cmp    %ebx,%edi
801042d5:	75 e1                	jne    801042b8 <exit+0x38>
801042d7:	e8 34 ef ff ff       	call   80103210 <begin_op>
801042dc:	83 ec 0c             	sub    $0xc,%esp
801042df:	ff 76 6c             	pushl  0x6c(%esi)
801042e2:	e8 69 da ff ff       	call   80101d50 <iput>
801042e7:	e8 94 ef ff ff       	call   80103280 <end_op>
801042ec:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
801042f3:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801042fa:	e8 d1 08 00 00       	call   80104bd0 <acquire>
801042ff:	8b 56 14             	mov    0x14(%esi),%edx
80104302:	83 c4 10             	add    $0x10,%esp
80104305:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
8010430a:	eb 0e                	jmp    8010431a <exit+0x9a>
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104310:	83 e8 80             	sub    $0xffffff80,%eax
80104313:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
80104318:	74 1c                	je     80104336 <exit+0xb6>
8010431a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010431e:	75 f0                	jne    80104310 <exit+0x90>
80104320:	3b 50 24             	cmp    0x24(%eax),%edx
80104323:	75 eb                	jne    80104310 <exit+0x90>
80104325:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010432c:	83 e8 80             	sub    $0xffffff80,%eax
8010432f:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
80104334:	75 e4                	jne    8010431a <exit+0x9a>
80104336:	8b 0d d8 b5 10 80    	mov    0x8010b5d8,%ecx
8010433c:	ba 74 3d 11 80       	mov    $0x80113d74,%edx
80104341:	eb 10                	jmp    80104353 <exit+0xd3>
80104343:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104347:	90                   	nop
80104348:	83 ea 80             	sub    $0xffffff80,%edx
8010434b:	81 fa 74 5d 11 80    	cmp    $0x80115d74,%edx
80104351:	74 3b                	je     8010438e <exit+0x10e>
80104353:	39 72 14             	cmp    %esi,0x14(%edx)
80104356:	75 f0                	jne    80104348 <exit+0xc8>
80104358:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
8010435c:	89 4a 14             	mov    %ecx,0x14(%edx)
8010435f:	75 e7                	jne    80104348 <exit+0xc8>
80104361:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
80104366:	eb 12                	jmp    8010437a <exit+0xfa>
80104368:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010436f:	90                   	nop
80104370:	83 e8 80             	sub    $0xffffff80,%eax
80104373:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
80104378:	74 ce                	je     80104348 <exit+0xc8>
8010437a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010437e:	75 f0                	jne    80104370 <exit+0xf0>
80104380:	3b 48 24             	cmp    0x24(%eax),%ecx
80104383:	75 eb                	jne    80104370 <exit+0xf0>
80104385:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010438c:	eb e2                	jmp    80104370 <exit+0xf0>
8010438e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
80104395:	e8 26 fe ff ff       	call   801041c0 <sched>
8010439a:	83 ec 0c             	sub    $0xc,%esp
8010439d:	68 28 7f 10 80       	push   $0x80107f28
801043a2:	e8 e9 bf ff ff       	call   80100390 <panic>
801043a7:	83 ec 0c             	sub    $0xc,%esp
801043aa:	68 1b 7f 10 80       	push   $0x80107f1b
801043af:	e8 dc bf ff ff       	call   80100390 <panic>
801043b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043bf:	90                   	nop

801043c0 <yield>:
801043c0:	f3 0f 1e fb          	endbr32 
801043c4:	55                   	push   %ebp
801043c5:	89 e5                	mov    %esp,%ebp
801043c7:	53                   	push   %ebx
801043c8:	83 ec 10             	sub    $0x10,%esp
801043cb:	68 40 3d 11 80       	push   $0x80113d40
801043d0:	e8 fb 07 00 00       	call   80104bd0 <acquire>
801043d5:	e8 f6 06 00 00       	call   80104ad0 <pushcli>
801043da:	e8 d1 f9 ff ff       	call   80103db0 <mycpu>
801043df:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801043e5:	e8 36 07 00 00       	call   80104b20 <popcli>
801043ea:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801043f1:	e8 ca fd ff ff       	call   801041c0 <sched>
801043f6:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
801043fd:	e8 8e 08 00 00       	call   80104c90 <release>
80104402:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104405:	83 c4 10             	add    $0x10,%esp
80104408:	c9                   	leave  
80104409:	c3                   	ret    
8010440a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104410 <sleep>:
80104410:	f3 0f 1e fb          	endbr32 
80104414:	55                   	push   %ebp
80104415:	89 e5                	mov    %esp,%ebp
80104417:	57                   	push   %edi
80104418:	56                   	push   %esi
80104419:	53                   	push   %ebx
8010441a:	83 ec 0c             	sub    $0xc,%esp
8010441d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104420:	8b 75 0c             	mov    0xc(%ebp),%esi
80104423:	e8 a8 06 00 00       	call   80104ad0 <pushcli>
80104428:	e8 83 f9 ff ff       	call   80103db0 <mycpu>
8010442d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104433:	e8 e8 06 00 00       	call   80104b20 <popcli>
80104438:	85 db                	test   %ebx,%ebx
8010443a:	0f 84 83 00 00 00    	je     801044c3 <sleep+0xb3>
80104440:	85 f6                	test   %esi,%esi
80104442:	74 72                	je     801044b6 <sleep+0xa6>
80104444:	81 fe 40 3d 11 80    	cmp    $0x80113d40,%esi
8010444a:	74 4c                	je     80104498 <sleep+0x88>
8010444c:	83 ec 0c             	sub    $0xc,%esp
8010444f:	68 40 3d 11 80       	push   $0x80113d40
80104454:	e8 77 07 00 00       	call   80104bd0 <acquire>
80104459:	89 34 24             	mov    %esi,(%esp)
8010445c:	e8 2f 08 00 00       	call   80104c90 <release>
80104461:	89 7b 24             	mov    %edi,0x24(%ebx)
80104464:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
8010446b:	e8 50 fd ff ff       	call   801041c0 <sched>
80104470:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104477:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
8010447e:	e8 0d 08 00 00       	call   80104c90 <release>
80104483:	89 75 08             	mov    %esi,0x8(%ebp)
80104486:	83 c4 10             	add    $0x10,%esp
80104489:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010448c:	5b                   	pop    %ebx
8010448d:	5e                   	pop    %esi
8010448e:	5f                   	pop    %edi
8010448f:	5d                   	pop    %ebp
80104490:	e9 3b 07 00 00       	jmp    80104bd0 <acquire>
80104495:	8d 76 00             	lea    0x0(%esi),%esi
80104498:	89 7b 24             	mov    %edi,0x24(%ebx)
8010449b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
801044a2:	e8 19 fd ff ff       	call   801041c0 <sched>
801044a7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
801044ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044b1:	5b                   	pop    %ebx
801044b2:	5e                   	pop    %esi
801044b3:	5f                   	pop    %edi
801044b4:	5d                   	pop    %ebp
801044b5:	c3                   	ret    
801044b6:	83 ec 0c             	sub    $0xc,%esp
801044b9:	68 3a 7f 10 80       	push   $0x80107f3a
801044be:	e8 cd be ff ff       	call   80100390 <panic>
801044c3:	83 ec 0c             	sub    $0xc,%esp
801044c6:	68 34 7f 10 80       	push   $0x80107f34
801044cb:	e8 c0 be ff ff       	call   80100390 <panic>

801044d0 <wait>:
801044d0:	f3 0f 1e fb          	endbr32 
801044d4:	55                   	push   %ebp
801044d5:	89 e5                	mov    %esp,%ebp
801044d7:	56                   	push   %esi
801044d8:	53                   	push   %ebx
801044d9:	e8 f2 05 00 00       	call   80104ad0 <pushcli>
801044de:	e8 cd f8 ff ff       	call   80103db0 <mycpu>
801044e3:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
801044e9:	e8 32 06 00 00       	call   80104b20 <popcli>
801044ee:	83 ec 0c             	sub    $0xc,%esp
801044f1:	68 40 3d 11 80       	push   $0x80113d40
801044f6:	e8 d5 06 00 00       	call   80104bd0 <acquire>
801044fb:	83 c4 10             	add    $0x10,%esp
801044fe:	31 c0                	xor    %eax,%eax
80104500:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
80104505:	eb 14                	jmp    8010451b <wait+0x4b>
80104507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010450e:	66 90                	xchg   %ax,%ax
80104510:	83 eb 80             	sub    $0xffffff80,%ebx
80104513:	81 fb 74 5d 11 80    	cmp    $0x80115d74,%ebx
80104519:	74 1b                	je     80104536 <wait+0x66>
8010451b:	39 73 14             	cmp    %esi,0x14(%ebx)
8010451e:	75 f0                	jne    80104510 <wait+0x40>
80104520:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104524:	74 32                	je     80104558 <wait+0x88>
80104526:	83 eb 80             	sub    $0xffffff80,%ebx
80104529:	b8 01 00 00 00       	mov    $0x1,%eax
8010452e:	81 fb 74 5d 11 80    	cmp    $0x80115d74,%ebx
80104534:	75 e5                	jne    8010451b <wait+0x4b>
80104536:	85 c0                	test   %eax,%eax
80104538:	74 74                	je     801045ae <wait+0xde>
8010453a:	8b 46 28             	mov    0x28(%esi),%eax
8010453d:	85 c0                	test   %eax,%eax
8010453f:	75 6d                	jne    801045ae <wait+0xde>
80104541:	83 ec 08             	sub    $0x8,%esp
80104544:	68 40 3d 11 80       	push   $0x80113d40
80104549:	56                   	push   %esi
8010454a:	e8 c1 fe ff ff       	call   80104410 <sleep>
8010454f:	83 c4 10             	add    $0x10,%esp
80104552:	eb aa                	jmp    801044fe <wait+0x2e>
80104554:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104558:	83 ec 0c             	sub    $0xc,%esp
8010455b:	ff 73 08             	pushl  0x8(%ebx)
8010455e:	8b 73 10             	mov    0x10(%ebx),%esi
80104561:	e8 ea e3 ff ff       	call   80102950 <kfree>
80104566:	5a                   	pop    %edx
80104567:	ff 73 04             	pushl  0x4(%ebx)
8010456a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104571:	e8 6a 30 00 00       	call   801075e0 <freevm>
80104576:	c7 04 24 40 3d 11 80 	movl   $0x80113d40,(%esp)
8010457d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104584:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
8010458b:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
8010458f:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
80104596:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010459d:	e8 ee 06 00 00       	call   80104c90 <release>
801045a2:	83 c4 10             	add    $0x10,%esp
801045a5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045a8:	89 f0                	mov    %esi,%eax
801045aa:	5b                   	pop    %ebx
801045ab:	5e                   	pop    %esi
801045ac:	5d                   	pop    %ebp
801045ad:	c3                   	ret    
801045ae:	83 ec 0c             	sub    $0xc,%esp
801045b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
801045b6:	68 40 3d 11 80       	push   $0x80113d40
801045bb:	e8 d0 06 00 00       	call   80104c90 <release>
801045c0:	83 c4 10             	add    $0x10,%esp
801045c3:	eb e0                	jmp    801045a5 <wait+0xd5>
801045c5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <wakeup>:
801045d0:	f3 0f 1e fb          	endbr32 
801045d4:	55                   	push   %ebp
801045d5:	89 e5                	mov    %esp,%ebp
801045d7:	53                   	push   %ebx
801045d8:	83 ec 10             	sub    $0x10,%esp
801045db:	8b 5d 08             	mov    0x8(%ebp),%ebx
801045de:	68 40 3d 11 80       	push   $0x80113d40
801045e3:	e8 e8 05 00 00       	call   80104bd0 <acquire>
801045e8:	83 c4 10             	add    $0x10,%esp
801045eb:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
801045f0:	eb 10                	jmp    80104602 <wakeup+0x32>
801045f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801045f8:	83 e8 80             	sub    $0xffffff80,%eax
801045fb:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
80104600:	74 1c                	je     8010461e <wakeup+0x4e>
80104602:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104606:	75 f0                	jne    801045f8 <wakeup+0x28>
80104608:	3b 58 24             	cmp    0x24(%eax),%ebx
8010460b:	75 eb                	jne    801045f8 <wakeup+0x28>
8010460d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104614:	83 e8 80             	sub    $0xffffff80,%eax
80104617:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
8010461c:	75 e4                	jne    80104602 <wakeup+0x32>
8010461e:	c7 45 08 40 3d 11 80 	movl   $0x80113d40,0x8(%ebp)
80104625:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104628:	c9                   	leave  
80104629:	e9 62 06 00 00       	jmp    80104c90 <release>
8010462e:	66 90                	xchg   %ax,%ax

80104630 <kill>:
80104630:	f3 0f 1e fb          	endbr32 
80104634:	55                   	push   %ebp
80104635:	89 e5                	mov    %esp,%ebp
80104637:	53                   	push   %ebx
80104638:	83 ec 10             	sub    $0x10,%esp
8010463b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010463e:	68 40 3d 11 80       	push   $0x80113d40
80104643:	e8 88 05 00 00       	call   80104bd0 <acquire>
80104648:	83 c4 10             	add    $0x10,%esp
8010464b:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
80104650:	eb 10                	jmp    80104662 <kill+0x32>
80104652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104658:	83 e8 80             	sub    $0xffffff80,%eax
8010465b:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
80104660:	74 36                	je     80104698 <kill+0x68>
80104662:	39 58 10             	cmp    %ebx,0x10(%eax)
80104665:	75 f1                	jne    80104658 <kill+0x28>
80104667:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010466b:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
80104672:	75 07                	jne    8010467b <kill+0x4b>
80104674:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010467b:	83 ec 0c             	sub    $0xc,%esp
8010467e:	68 40 3d 11 80       	push   $0x80113d40
80104683:	e8 08 06 00 00       	call   80104c90 <release>
80104688:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010468b:	83 c4 10             	add    $0x10,%esp
8010468e:	31 c0                	xor    %eax,%eax
80104690:	c9                   	leave  
80104691:	c3                   	ret    
80104692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104698:	83 ec 0c             	sub    $0xc,%esp
8010469b:	68 40 3d 11 80       	push   $0x80113d40
801046a0:	e8 eb 05 00 00       	call   80104c90 <release>
801046a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046a8:	83 c4 10             	add    $0x10,%esp
801046ab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046b0:	c9                   	leave  
801046b1:	c3                   	ret    
801046b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801046c0 <procdump>:
801046c0:	f3 0f 1e fb          	endbr32 
801046c4:	55                   	push   %ebp
801046c5:	89 e5                	mov    %esp,%ebp
801046c7:	57                   	push   %edi
801046c8:	56                   	push   %esi
801046c9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801046cc:	53                   	push   %ebx
801046cd:	bb e4 3d 11 80       	mov    $0x80113de4,%ebx
801046d2:	83 ec 3c             	sub    $0x3c,%esp
801046d5:	eb 28                	jmp    801046ff <procdump+0x3f>
801046d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046de:	66 90                	xchg   %ax,%ax
801046e0:	83 ec 0c             	sub    $0xc,%esp
801046e3:	68 cf 82 10 80       	push   $0x801082cf
801046e8:	e8 c3 bf ff ff       	call   801006b0 <cprintf>
801046ed:	83 c4 10             	add    $0x10,%esp
801046f0:	83 eb 80             	sub    $0xffffff80,%ebx
801046f3:	81 fb e4 5d 11 80    	cmp    $0x80115de4,%ebx
801046f9:	0f 84 81 00 00 00    	je     80104780 <procdump+0xc0>
801046ff:	8b 43 9c             	mov    -0x64(%ebx),%eax
80104702:	85 c0                	test   %eax,%eax
80104704:	74 ea                	je     801046f0 <procdump+0x30>
80104706:	ba 4b 7f 10 80       	mov    $0x80107f4b,%edx
8010470b:	83 f8 05             	cmp    $0x5,%eax
8010470e:	77 11                	ja     80104721 <procdump+0x61>
80104710:	8b 14 85 ac 7f 10 80 	mov    -0x7fef8054(,%eax,4),%edx
80104717:	b8 4b 7f 10 80       	mov    $0x80107f4b,%eax
8010471c:	85 d2                	test   %edx,%edx
8010471e:	0f 44 d0             	cmove  %eax,%edx
80104721:	53                   	push   %ebx
80104722:	52                   	push   %edx
80104723:	ff 73 a0             	pushl  -0x60(%ebx)
80104726:	68 4f 7f 10 80       	push   $0x80107f4f
8010472b:	e8 80 bf ff ff       	call   801006b0 <cprintf>
80104730:	83 c4 10             	add    $0x10,%esp
80104733:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104737:	75 a7                	jne    801046e0 <procdump+0x20>
80104739:	83 ec 08             	sub    $0x8,%esp
8010473c:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010473f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104742:	50                   	push   %eax
80104743:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104746:	8b 40 0c             	mov    0xc(%eax),%eax
80104749:	83 c0 08             	add    $0x8,%eax
8010474c:	50                   	push   %eax
8010474d:	e8 1e 03 00 00       	call   80104a70 <getcallerpcs>
80104752:	83 c4 10             	add    $0x10,%esp
80104755:	8d 76 00             	lea    0x0(%esi),%esi
80104758:	8b 17                	mov    (%edi),%edx
8010475a:	85 d2                	test   %edx,%edx
8010475c:	74 82                	je     801046e0 <procdump+0x20>
8010475e:	83 ec 08             	sub    $0x8,%esp
80104761:	83 c7 04             	add    $0x4,%edi
80104764:	52                   	push   %edx
80104765:	68 41 79 10 80       	push   $0x80107941
8010476a:	e8 41 bf ff ff       	call   801006b0 <cprintf>
8010476f:	83 c4 10             	add    $0x10,%esp
80104772:	39 fe                	cmp    %edi,%esi
80104774:	75 e2                	jne    80104758 <procdump+0x98>
80104776:	e9 65 ff ff ff       	jmp    801046e0 <procdump+0x20>
8010477b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop
80104780:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104783:	5b                   	pop    %ebx
80104784:	5e                   	pop    %esi
80104785:	5f                   	pop    %edi
80104786:	5d                   	pop    %ebp
80104787:	c3                   	ret    
80104788:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010478f:	90                   	nop

80104790 <wait_sleeping>:
80104790:	f3 0f 1e fb          	endbr32 
80104794:	55                   	push   %ebp
80104795:	89 e5                	mov    %esp,%ebp
80104797:	53                   	push   %ebx
80104798:	83 ec 04             	sub    $0x4,%esp
8010479b:	e8 30 03 00 00       	call   80104ad0 <pushcli>
801047a0:	e8 0b f6 ff ff       	call   80103db0 <mycpu>
801047a5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801047ab:	e8 70 03 00 00       	call   80104b20 <popcli>
801047b0:	83 ec 0c             	sub    $0xc,%esp
801047b3:	68 40 3d 11 80       	push   $0x80113d40
801047b8:	e8 13 04 00 00       	call   80104bd0 <acquire>
801047bd:	83 c4 10             	add    $0x10,%esp
801047c0:	31 d2                	xor    %edx,%edx
801047c2:	b8 74 3d 11 80       	mov    $0x80113d74,%eax
801047c7:	eb 11                	jmp    801047da <wait_sleeping+0x4a>
801047c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047d0:	83 e8 80             	sub    $0xffffff80,%eax
801047d3:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
801047d8:	74 1a                	je     801047f4 <wait_sleeping+0x64>
801047da:	39 58 18             	cmp    %ebx,0x18(%eax)
801047dd:	75 f1                	jne    801047d0 <wait_sleeping+0x40>
801047df:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801047e3:	74 33                	je     80104818 <wait_sleeping+0x88>
801047e5:	83 e8 80             	sub    $0xffffff80,%eax
801047e8:	ba 01 00 00 00       	mov    $0x1,%edx
801047ed:	3d 74 5d 11 80       	cmp    $0x80115d74,%eax
801047f2:	75 e6                	jne    801047da <wait_sleeping+0x4a>
801047f4:	85 d2                	test   %edx,%edx
801047f6:	74 3a                	je     80104832 <wait_sleeping+0xa2>
801047f8:	8b 43 28             	mov    0x28(%ebx),%eax
801047fb:	85 c0                	test   %eax,%eax
801047fd:	75 33                	jne    80104832 <wait_sleeping+0xa2>
801047ff:	83 ec 08             	sub    $0x8,%esp
80104802:	68 40 3d 11 80       	push   $0x80113d40
80104807:	53                   	push   %ebx
80104808:	e8 03 fc ff ff       	call   80104410 <sleep>
8010480d:	83 c4 10             	add    $0x10,%esp
80104810:	eb ae                	jmp    801047c0 <wait_sleeping+0x30>
80104812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104818:	83 ec 0c             	sub    $0xc,%esp
8010481b:	8b 58 10             	mov    0x10(%eax),%ebx
8010481e:	68 40 3d 11 80       	push   $0x80113d40
80104823:	e8 68 04 00 00       	call   80104c90 <release>
80104828:	83 c4 10             	add    $0x10,%esp
8010482b:	89 d8                	mov    %ebx,%eax
8010482d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104830:	c9                   	leave  
80104831:	c3                   	ret    
80104832:	83 ec 0c             	sub    $0xc,%esp
80104835:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010483a:	68 40 3d 11 80       	push   $0x80113d40
8010483f:	e8 4c 04 00 00       	call   80104c90 <release>
80104844:	83 c4 10             	add    $0x10,%esp
80104847:	eb e2                	jmp    8010482b <wait_sleeping+0x9b>
80104849:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104850 <set_proc_tracer>:
80104850:	f3 0f 1e fb          	endbr32 
80104854:	55                   	push   %ebp
80104855:	89 e5                	mov    %esp,%ebp
80104857:	56                   	push   %esi
80104858:	53                   	push   %ebx
80104859:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010485c:	83 ec 18             	sub    $0x18,%esp
8010485f:	50                   	push   %eax
80104860:	6a 00                	push   $0x0
80104862:	e8 59 07 00 00       	call   80104fc0 <argint>
80104867:	83 c4 10             	add    $0x10,%esp
8010486a:	85 c0                	test   %eax,%eax
8010486c:	0f 88 8a 00 00 00    	js     801048fc <set_proc_tracer+0xac>
80104872:	83 ec 0c             	sub    $0xc,%esp
80104875:	bb 74 3d 11 80       	mov    $0x80113d74,%ebx
8010487a:	68 40 3d 11 80       	push   $0x80113d40
8010487f:	e8 4c 03 00 00       	call   80104bd0 <acquire>
80104884:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104887:	83 c4 10             	add    $0x10,%esp
8010488a:	eb 0f                	jmp    8010489b <set_proc_tracer+0x4b>
8010488c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104890:	83 eb 80             	sub    $0xffffff80,%ebx
80104893:	81 fb 74 5d 11 80    	cmp    $0x80115d74,%ebx
80104899:	74 45                	je     801048e0 <set_proc_tracer+0x90>
8010489b:	39 43 10             	cmp    %eax,0x10(%ebx)
8010489e:	75 f0                	jne    80104890 <set_proc_tracer+0x40>
801048a0:	8b 53 18             	mov    0x18(%ebx),%edx
801048a3:	85 d2                	test   %edx,%edx
801048a5:	75 e9                	jne    80104890 <set_proc_tracer+0x40>
801048a7:	e8 24 02 00 00       	call   80104ad0 <pushcli>
801048ac:	e8 ff f4 ff ff       	call   80103db0 <mycpu>
801048b1:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
801048b7:	e8 64 02 00 00       	call   80104b20 <popcli>
801048bc:	83 ec 0c             	sub    $0xc,%esp
801048bf:	68 40 3d 11 80       	push   $0x80113d40
801048c4:	89 73 18             	mov    %esi,0x18(%ebx)
801048c7:	e8 c4 03 00 00       	call   80104c90 <release>
801048cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801048cf:	83 c4 10             	add    $0x10,%esp
801048d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048d5:	5b                   	pop    %ebx
801048d6:	5e                   	pop    %esi
801048d7:	5d                   	pop    %ebp
801048d8:	c3                   	ret    
801048d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048e0:	83 ec 0c             	sub    $0xc,%esp
801048e3:	68 40 3d 11 80       	push   $0x80113d40
801048e8:	e8 a3 03 00 00       	call   80104c90 <release>
801048ed:	83 c4 10             	add    $0x10,%esp
801048f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048f8:	5b                   	pop    %ebx
801048f9:	5e                   	pop    %esi
801048fa:	5d                   	pop    %ebp
801048fb:	c3                   	ret    
801048fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104901:	eb cf                	jmp    801048d2 <set_proc_tracer+0x82>
80104903:	66 90                	xchg   %ax,%ax
80104905:	66 90                	xchg   %ax,%ax
80104907:	66 90                	xchg   %ax,%ax
80104909:	66 90                	xchg   %ax,%ax
8010490b:	66 90                	xchg   %ax,%ax
8010490d:	66 90                	xchg   %ax,%ax
8010490f:	90                   	nop

80104910 <initsleeplock>:
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	53                   	push   %ebx
80104918:	83 ec 0c             	sub    $0xc,%esp
8010491b:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010491e:	68 c4 7f 10 80       	push   $0x80107fc4
80104923:	8d 43 04             	lea    0x4(%ebx),%eax
80104926:	50                   	push   %eax
80104927:	e8 24 01 00 00       	call   80104a50 <initlock>
8010492c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010492f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104935:	83 c4 10             	add    $0x10,%esp
80104938:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
8010493f:	89 43 38             	mov    %eax,0x38(%ebx)
80104942:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104945:	c9                   	leave  
80104946:	c3                   	ret    
80104947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010494e:	66 90                	xchg   %ax,%ax

80104950 <acquiresleep>:
80104950:	f3 0f 1e fb          	endbr32 
80104954:	55                   	push   %ebp
80104955:	89 e5                	mov    %esp,%ebp
80104957:	56                   	push   %esi
80104958:	53                   	push   %ebx
80104959:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010495c:	8d 73 04             	lea    0x4(%ebx),%esi
8010495f:	83 ec 0c             	sub    $0xc,%esp
80104962:	56                   	push   %esi
80104963:	e8 68 02 00 00       	call   80104bd0 <acquire>
80104968:	8b 13                	mov    (%ebx),%edx
8010496a:	83 c4 10             	add    $0x10,%esp
8010496d:	85 d2                	test   %edx,%edx
8010496f:	74 1a                	je     8010498b <acquiresleep+0x3b>
80104971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104978:	83 ec 08             	sub    $0x8,%esp
8010497b:	56                   	push   %esi
8010497c:	53                   	push   %ebx
8010497d:	e8 8e fa ff ff       	call   80104410 <sleep>
80104982:	8b 03                	mov    (%ebx),%eax
80104984:	83 c4 10             	add    $0x10,%esp
80104987:	85 c0                	test   %eax,%eax
80104989:	75 ed                	jne    80104978 <acquiresleep+0x28>
8010498b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104991:	e8 aa f4 ff ff       	call   80103e40 <myproc>
80104996:	8b 40 10             	mov    0x10(%eax),%eax
80104999:	89 43 3c             	mov    %eax,0x3c(%ebx)
8010499c:	89 75 08             	mov    %esi,0x8(%ebp)
8010499f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049a2:	5b                   	pop    %ebx
801049a3:	5e                   	pop    %esi
801049a4:	5d                   	pop    %ebp
801049a5:	e9 e6 02 00 00       	jmp    80104c90 <release>
801049aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049b0 <releasesleep>:
801049b0:	f3 0f 1e fb          	endbr32 
801049b4:	55                   	push   %ebp
801049b5:	89 e5                	mov    %esp,%ebp
801049b7:	56                   	push   %esi
801049b8:	53                   	push   %ebx
801049b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049bc:	8d 73 04             	lea    0x4(%ebx),%esi
801049bf:	83 ec 0c             	sub    $0xc,%esp
801049c2:	56                   	push   %esi
801049c3:	e8 08 02 00 00       	call   80104bd0 <acquire>
801049c8:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801049ce:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
801049d5:	89 1c 24             	mov    %ebx,(%esp)
801049d8:	e8 f3 fb ff ff       	call   801045d0 <wakeup>
801049dd:	89 75 08             	mov    %esi,0x8(%ebp)
801049e0:	83 c4 10             	add    $0x10,%esp
801049e3:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049e6:	5b                   	pop    %ebx
801049e7:	5e                   	pop    %esi
801049e8:	5d                   	pop    %ebp
801049e9:	e9 a2 02 00 00       	jmp    80104c90 <release>
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <holdingsleep>:
801049f0:	f3 0f 1e fb          	endbr32 
801049f4:	55                   	push   %ebp
801049f5:	89 e5                	mov    %esp,%ebp
801049f7:	57                   	push   %edi
801049f8:	31 ff                	xor    %edi,%edi
801049fa:	56                   	push   %esi
801049fb:	53                   	push   %ebx
801049fc:	83 ec 18             	sub    $0x18,%esp
801049ff:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104a02:	8d 73 04             	lea    0x4(%ebx),%esi
80104a05:	56                   	push   %esi
80104a06:	e8 c5 01 00 00       	call   80104bd0 <acquire>
80104a0b:	8b 03                	mov    (%ebx),%eax
80104a0d:	83 c4 10             	add    $0x10,%esp
80104a10:	85 c0                	test   %eax,%eax
80104a12:	75 1c                	jne    80104a30 <holdingsleep+0x40>
80104a14:	83 ec 0c             	sub    $0xc,%esp
80104a17:	56                   	push   %esi
80104a18:	e8 73 02 00 00       	call   80104c90 <release>
80104a1d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a20:	89 f8                	mov    %edi,%eax
80104a22:	5b                   	pop    %ebx
80104a23:	5e                   	pop    %esi
80104a24:	5f                   	pop    %edi
80104a25:	5d                   	pop    %ebp
80104a26:	c3                   	ret    
80104a27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a2e:	66 90                	xchg   %ax,%ax
80104a30:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104a33:	e8 08 f4 ff ff       	call   80103e40 <myproc>
80104a38:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a3b:	0f 94 c0             	sete   %al
80104a3e:	0f b6 c0             	movzbl %al,%eax
80104a41:	89 c7                	mov    %eax,%edi
80104a43:	eb cf                	jmp    80104a14 <holdingsleep+0x24>
80104a45:	66 90                	xchg   %ax,%ax
80104a47:	66 90                	xchg   %ax,%ax
80104a49:	66 90                	xchg   %ax,%ax
80104a4b:	66 90                	xchg   %ax,%ax
80104a4d:	66 90                	xchg   %ax,%ax
80104a4f:	90                   	nop

80104a50 <initlock>:
80104a50:	f3 0f 1e fb          	endbr32 
80104a54:	55                   	push   %ebp
80104a55:	89 e5                	mov    %esp,%ebp
80104a57:	8b 45 08             	mov    0x8(%ebp),%eax
80104a5a:	8b 55 0c             	mov    0xc(%ebp),%edx
80104a5d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104a63:	89 50 04             	mov    %edx,0x4(%eax)
80104a66:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104a6d:	5d                   	pop    %ebp
80104a6e:	c3                   	ret    
80104a6f:	90                   	nop

80104a70 <getcallerpcs>:
80104a70:	f3 0f 1e fb          	endbr32 
80104a74:	55                   	push   %ebp
80104a75:	31 d2                	xor    %edx,%edx
80104a77:	89 e5                	mov    %esp,%ebp
80104a79:	53                   	push   %ebx
80104a7a:	8b 45 08             	mov    0x8(%ebp),%eax
80104a7d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104a80:	83 e8 08             	sub    $0x8,%eax
80104a83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a87:	90                   	nop
80104a88:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104a8e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104a94:	77 1a                	ja     80104ab0 <getcallerpcs+0x40>
80104a96:	8b 58 04             	mov    0x4(%eax),%ebx
80104a99:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
80104a9c:	83 c2 01             	add    $0x1,%edx
80104a9f:	8b 00                	mov    (%eax),%eax
80104aa1:	83 fa 0a             	cmp    $0xa,%edx
80104aa4:	75 e2                	jne    80104a88 <getcallerpcs+0x18>
80104aa6:	5b                   	pop    %ebx
80104aa7:	5d                   	pop    %ebp
80104aa8:	c3                   	ret    
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab0:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104ab3:	8d 51 28             	lea    0x28(%ecx),%edx
80104ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104abd:	8d 76 00             	lea    0x0(%esi),%esi
80104ac0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ac6:	83 c0 04             	add    $0x4,%eax
80104ac9:	39 d0                	cmp    %edx,%eax
80104acb:	75 f3                	jne    80104ac0 <getcallerpcs+0x50>
80104acd:	5b                   	pop    %ebx
80104ace:	5d                   	pop    %ebp
80104acf:	c3                   	ret    

80104ad0 <pushcli>:
80104ad0:	f3 0f 1e fb          	endbr32 
80104ad4:	55                   	push   %ebp
80104ad5:	89 e5                	mov    %esp,%ebp
80104ad7:	53                   	push   %ebx
80104ad8:	83 ec 04             	sub    $0x4,%esp
80104adb:	9c                   	pushf  
80104adc:	5b                   	pop    %ebx
80104add:	fa                   	cli    
80104ade:	e8 cd f2 ff ff       	call   80103db0 <mycpu>
80104ae3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104ae9:	85 c0                	test   %eax,%eax
80104aeb:	74 13                	je     80104b00 <pushcli+0x30>
80104aed:	e8 be f2 ff ff       	call   80103db0 <mycpu>
80104af2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104af9:	83 c4 04             	add    $0x4,%esp
80104afc:	5b                   	pop    %ebx
80104afd:	5d                   	pop    %ebp
80104afe:	c3                   	ret    
80104aff:	90                   	nop
80104b00:	e8 ab f2 ff ff       	call   80103db0 <mycpu>
80104b05:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104b0b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104b11:	eb da                	jmp    80104aed <pushcli+0x1d>
80104b13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b20 <popcli>:
80104b20:	f3 0f 1e fb          	endbr32 
80104b24:	55                   	push   %ebp
80104b25:	89 e5                	mov    %esp,%ebp
80104b27:	83 ec 08             	sub    $0x8,%esp
80104b2a:	9c                   	pushf  
80104b2b:	58                   	pop    %eax
80104b2c:	f6 c4 02             	test   $0x2,%ah
80104b2f:	75 31                	jne    80104b62 <popcli+0x42>
80104b31:	e8 7a f2 ff ff       	call   80103db0 <mycpu>
80104b36:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104b3d:	78 30                	js     80104b6f <popcli+0x4f>
80104b3f:	e8 6c f2 ff ff       	call   80103db0 <mycpu>
80104b44:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104b4a:	85 d2                	test   %edx,%edx
80104b4c:	74 02                	je     80104b50 <popcli+0x30>
80104b4e:	c9                   	leave  
80104b4f:	c3                   	ret    
80104b50:	e8 5b f2 ff ff       	call   80103db0 <mycpu>
80104b55:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104b5b:	85 c0                	test   %eax,%eax
80104b5d:	74 ef                	je     80104b4e <popcli+0x2e>
80104b5f:	fb                   	sti    
80104b60:	c9                   	leave  
80104b61:	c3                   	ret    
80104b62:	83 ec 0c             	sub    $0xc,%esp
80104b65:	68 cf 7f 10 80       	push   $0x80107fcf
80104b6a:	e8 21 b8 ff ff       	call   80100390 <panic>
80104b6f:	83 ec 0c             	sub    $0xc,%esp
80104b72:	68 e6 7f 10 80       	push   $0x80107fe6
80104b77:	e8 14 b8 ff ff       	call   80100390 <panic>
80104b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b80 <holding>:
80104b80:	f3 0f 1e fb          	endbr32 
80104b84:	55                   	push   %ebp
80104b85:	89 e5                	mov    %esp,%ebp
80104b87:	56                   	push   %esi
80104b88:	53                   	push   %ebx
80104b89:	8b 75 08             	mov    0x8(%ebp),%esi
80104b8c:	31 db                	xor    %ebx,%ebx
80104b8e:	e8 3d ff ff ff       	call   80104ad0 <pushcli>
80104b93:	8b 06                	mov    (%esi),%eax
80104b95:	85 c0                	test   %eax,%eax
80104b97:	75 0f                	jne    80104ba8 <holding+0x28>
80104b99:	e8 82 ff ff ff       	call   80104b20 <popcli>
80104b9e:	89 d8                	mov    %ebx,%eax
80104ba0:	5b                   	pop    %ebx
80104ba1:	5e                   	pop    %esi
80104ba2:	5d                   	pop    %ebp
80104ba3:	c3                   	ret    
80104ba4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ba8:	8b 5e 08             	mov    0x8(%esi),%ebx
80104bab:	e8 00 f2 ff ff       	call   80103db0 <mycpu>
80104bb0:	39 c3                	cmp    %eax,%ebx
80104bb2:	0f 94 c3             	sete   %bl
80104bb5:	e8 66 ff ff ff       	call   80104b20 <popcli>
80104bba:	0f b6 db             	movzbl %bl,%ebx
80104bbd:	89 d8                	mov    %ebx,%eax
80104bbf:	5b                   	pop    %ebx
80104bc0:	5e                   	pop    %esi
80104bc1:	5d                   	pop    %ebp
80104bc2:	c3                   	ret    
80104bc3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bd0 <acquire>:
80104bd0:	f3 0f 1e fb          	endbr32 
80104bd4:	55                   	push   %ebp
80104bd5:	89 e5                	mov    %esp,%ebp
80104bd7:	56                   	push   %esi
80104bd8:	53                   	push   %ebx
80104bd9:	e8 f2 fe ff ff       	call   80104ad0 <pushcli>
80104bde:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104be1:	83 ec 0c             	sub    $0xc,%esp
80104be4:	53                   	push   %ebx
80104be5:	e8 96 ff ff ff       	call   80104b80 <holding>
80104bea:	83 c4 10             	add    $0x10,%esp
80104bed:	85 c0                	test   %eax,%eax
80104bef:	0f 85 7f 00 00 00    	jne    80104c74 <acquire+0xa4>
80104bf5:	89 c6                	mov    %eax,%esi
80104bf7:	ba 01 00 00 00       	mov    $0x1,%edx
80104bfc:	eb 05                	jmp    80104c03 <acquire+0x33>
80104bfe:	66 90                	xchg   %ax,%ax
80104c00:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c03:	89 d0                	mov    %edx,%eax
80104c05:	f0 87 03             	lock xchg %eax,(%ebx)
80104c08:	85 c0                	test   %eax,%eax
80104c0a:	75 f4                	jne    80104c00 <acquire+0x30>
80104c0c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104c11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c14:	e8 97 f1 ff ff       	call   80103db0 <mycpu>
80104c19:	89 43 08             	mov    %eax,0x8(%ebx)
80104c1c:	89 e8                	mov    %ebp,%eax
80104c1e:	66 90                	xchg   %ax,%ax
80104c20:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104c26:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104c2c:	77 22                	ja     80104c50 <acquire+0x80>
80104c2e:	8b 50 04             	mov    0x4(%eax),%edx
80104c31:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
80104c35:	83 c6 01             	add    $0x1,%esi
80104c38:	8b 00                	mov    (%eax),%eax
80104c3a:	83 fe 0a             	cmp    $0xa,%esi
80104c3d:	75 e1                	jne    80104c20 <acquire+0x50>
80104c3f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c42:	5b                   	pop    %ebx
80104c43:	5e                   	pop    %esi
80104c44:	5d                   	pop    %ebp
80104c45:	c3                   	ret    
80104c46:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c4d:	8d 76 00             	lea    0x0(%esi),%esi
80104c50:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104c54:	83 c3 34             	add    $0x34,%ebx
80104c57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5e:	66 90                	xchg   %ax,%ax
80104c60:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c66:	83 c0 04             	add    $0x4,%eax
80104c69:	39 d8                	cmp    %ebx,%eax
80104c6b:	75 f3                	jne    80104c60 <acquire+0x90>
80104c6d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c70:	5b                   	pop    %ebx
80104c71:	5e                   	pop    %esi
80104c72:	5d                   	pop    %ebp
80104c73:	c3                   	ret    
80104c74:	83 ec 0c             	sub    $0xc,%esp
80104c77:	68 ed 7f 10 80       	push   $0x80107fed
80104c7c:	e8 0f b7 ff ff       	call   80100390 <panic>
80104c81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c8f:	90                   	nop

80104c90 <release>:
80104c90:	f3 0f 1e fb          	endbr32 
80104c94:	55                   	push   %ebp
80104c95:	89 e5                	mov    %esp,%ebp
80104c97:	53                   	push   %ebx
80104c98:	83 ec 10             	sub    $0x10,%esp
80104c9b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104c9e:	53                   	push   %ebx
80104c9f:	e8 dc fe ff ff       	call   80104b80 <holding>
80104ca4:	83 c4 10             	add    $0x10,%esp
80104ca7:	85 c0                	test   %eax,%eax
80104ca9:	74 22                	je     80104ccd <release+0x3d>
80104cab:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104cb2:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104cb9:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104cbe:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104cc4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cc7:	c9                   	leave  
80104cc8:	e9 53 fe ff ff       	jmp    80104b20 <popcli>
80104ccd:	83 ec 0c             	sub    $0xc,%esp
80104cd0:	68 f5 7f 10 80       	push   $0x80107ff5
80104cd5:	e8 b6 b6 ff ff       	call   80100390 <panic>
80104cda:	66 90                	xchg   %ax,%ax
80104cdc:	66 90                	xchg   %ax,%ax
80104cde:	66 90                	xchg   %ax,%ax

80104ce0 <memset>:
80104ce0:	f3 0f 1e fb          	endbr32 
80104ce4:	55                   	push   %ebp
80104ce5:	89 e5                	mov    %esp,%ebp
80104ce7:	57                   	push   %edi
80104ce8:	8b 55 08             	mov    0x8(%ebp),%edx
80104ceb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104cee:	53                   	push   %ebx
80104cef:	8b 45 0c             	mov    0xc(%ebp),%eax
80104cf2:	89 d7                	mov    %edx,%edi
80104cf4:	09 cf                	or     %ecx,%edi
80104cf6:	83 e7 03             	and    $0x3,%edi
80104cf9:	75 25                	jne    80104d20 <memset+0x40>
80104cfb:	0f b6 f8             	movzbl %al,%edi
80104cfe:	c1 e0 18             	shl    $0x18,%eax
80104d01:	89 fb                	mov    %edi,%ebx
80104d03:	c1 e9 02             	shr    $0x2,%ecx
80104d06:	c1 e3 10             	shl    $0x10,%ebx
80104d09:	09 d8                	or     %ebx,%eax
80104d0b:	09 f8                	or     %edi,%eax
80104d0d:	c1 e7 08             	shl    $0x8,%edi
80104d10:	09 f8                	or     %edi,%eax
80104d12:	89 d7                	mov    %edx,%edi
80104d14:	fc                   	cld    
80104d15:	f3 ab                	rep stos %eax,%es:(%edi)
80104d17:	5b                   	pop    %ebx
80104d18:	89 d0                	mov    %edx,%eax
80104d1a:	5f                   	pop    %edi
80104d1b:	5d                   	pop    %ebp
80104d1c:	c3                   	ret    
80104d1d:	8d 76 00             	lea    0x0(%esi),%esi
80104d20:	89 d7                	mov    %edx,%edi
80104d22:	fc                   	cld    
80104d23:	f3 aa                	rep stos %al,%es:(%edi)
80104d25:	5b                   	pop    %ebx
80104d26:	89 d0                	mov    %edx,%eax
80104d28:	5f                   	pop    %edi
80104d29:	5d                   	pop    %ebp
80104d2a:	c3                   	ret    
80104d2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d2f:	90                   	nop

80104d30 <memcmp>:
80104d30:	f3 0f 1e fb          	endbr32 
80104d34:	55                   	push   %ebp
80104d35:	89 e5                	mov    %esp,%ebp
80104d37:	56                   	push   %esi
80104d38:	8b 75 10             	mov    0x10(%ebp),%esi
80104d3b:	8b 55 08             	mov    0x8(%ebp),%edx
80104d3e:	53                   	push   %ebx
80104d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d42:	85 f6                	test   %esi,%esi
80104d44:	74 2a                	je     80104d70 <memcmp+0x40>
80104d46:	01 c6                	add    %eax,%esi
80104d48:	eb 10                	jmp    80104d5a <memcmp+0x2a>
80104d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d50:	83 c0 01             	add    $0x1,%eax
80104d53:	83 c2 01             	add    $0x1,%edx
80104d56:	39 f0                	cmp    %esi,%eax
80104d58:	74 16                	je     80104d70 <memcmp+0x40>
80104d5a:	0f b6 0a             	movzbl (%edx),%ecx
80104d5d:	0f b6 18             	movzbl (%eax),%ebx
80104d60:	38 d9                	cmp    %bl,%cl
80104d62:	74 ec                	je     80104d50 <memcmp+0x20>
80104d64:	0f b6 c1             	movzbl %cl,%eax
80104d67:	29 d8                	sub    %ebx,%eax
80104d69:	5b                   	pop    %ebx
80104d6a:	5e                   	pop    %esi
80104d6b:	5d                   	pop    %ebp
80104d6c:	c3                   	ret    
80104d6d:	8d 76 00             	lea    0x0(%esi),%esi
80104d70:	5b                   	pop    %ebx
80104d71:	31 c0                	xor    %eax,%eax
80104d73:	5e                   	pop    %esi
80104d74:	5d                   	pop    %ebp
80104d75:	c3                   	ret    
80104d76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi

80104d80 <memmove>:
80104d80:	f3 0f 1e fb          	endbr32 
80104d84:	55                   	push   %ebp
80104d85:	89 e5                	mov    %esp,%ebp
80104d87:	57                   	push   %edi
80104d88:	8b 55 08             	mov    0x8(%ebp),%edx
80104d8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104d8e:	56                   	push   %esi
80104d8f:	8b 75 0c             	mov    0xc(%ebp),%esi
80104d92:	39 d6                	cmp    %edx,%esi
80104d94:	73 2a                	jae    80104dc0 <memmove+0x40>
80104d96:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80104d99:	39 fa                	cmp    %edi,%edx
80104d9b:	73 23                	jae    80104dc0 <memmove+0x40>
80104d9d:	8d 41 ff             	lea    -0x1(%ecx),%eax
80104da0:	85 c9                	test   %ecx,%ecx
80104da2:	74 13                	je     80104db7 <memmove+0x37>
80104da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104da8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104dac:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104daf:	83 e8 01             	sub    $0x1,%eax
80104db2:	83 f8 ff             	cmp    $0xffffffff,%eax
80104db5:	75 f1                	jne    80104da8 <memmove+0x28>
80104db7:	5e                   	pop    %esi
80104db8:	89 d0                	mov    %edx,%eax
80104dba:	5f                   	pop    %edi
80104dbb:	5d                   	pop    %ebp
80104dbc:	c3                   	ret    
80104dbd:	8d 76 00             	lea    0x0(%esi),%esi
80104dc0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80104dc3:	89 d7                	mov    %edx,%edi
80104dc5:	85 c9                	test   %ecx,%ecx
80104dc7:	74 ee                	je     80104db7 <memmove+0x37>
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dd0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80104dd1:	39 f0                	cmp    %esi,%eax
80104dd3:	75 fb                	jne    80104dd0 <memmove+0x50>
80104dd5:	5e                   	pop    %esi
80104dd6:	89 d0                	mov    %edx,%eax
80104dd8:	5f                   	pop    %edi
80104dd9:	5d                   	pop    %ebp
80104dda:	c3                   	ret    
80104ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ddf:	90                   	nop

80104de0 <memcpy>:
80104de0:	f3 0f 1e fb          	endbr32 
80104de4:	eb 9a                	jmp    80104d80 <memmove>
80104de6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ded:	8d 76 00             	lea    0x0(%esi),%esi

80104df0 <strncmp>:
80104df0:	f3 0f 1e fb          	endbr32 
80104df4:	55                   	push   %ebp
80104df5:	89 e5                	mov    %esp,%ebp
80104df7:	56                   	push   %esi
80104df8:	8b 75 10             	mov    0x10(%ebp),%esi
80104dfb:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104dfe:	53                   	push   %ebx
80104dff:	8b 45 0c             	mov    0xc(%ebp),%eax
80104e02:	85 f6                	test   %esi,%esi
80104e04:	74 32                	je     80104e38 <strncmp+0x48>
80104e06:	01 c6                	add    %eax,%esi
80104e08:	eb 14                	jmp    80104e1e <strncmp+0x2e>
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e10:	38 da                	cmp    %bl,%dl
80104e12:	75 14                	jne    80104e28 <strncmp+0x38>
80104e14:	83 c0 01             	add    $0x1,%eax
80104e17:	83 c1 01             	add    $0x1,%ecx
80104e1a:	39 f0                	cmp    %esi,%eax
80104e1c:	74 1a                	je     80104e38 <strncmp+0x48>
80104e1e:	0f b6 11             	movzbl (%ecx),%edx
80104e21:	0f b6 18             	movzbl (%eax),%ebx
80104e24:	84 d2                	test   %dl,%dl
80104e26:	75 e8                	jne    80104e10 <strncmp+0x20>
80104e28:	0f b6 c2             	movzbl %dl,%eax
80104e2b:	29 d8                	sub    %ebx,%eax
80104e2d:	5b                   	pop    %ebx
80104e2e:	5e                   	pop    %esi
80104e2f:	5d                   	pop    %ebp
80104e30:	c3                   	ret    
80104e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e38:	5b                   	pop    %ebx
80104e39:	31 c0                	xor    %eax,%eax
80104e3b:	5e                   	pop    %esi
80104e3c:	5d                   	pop    %ebp
80104e3d:	c3                   	ret    
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <strncpy>:
80104e40:	f3 0f 1e fb          	endbr32 
80104e44:	55                   	push   %ebp
80104e45:	89 e5                	mov    %esp,%ebp
80104e47:	57                   	push   %edi
80104e48:	56                   	push   %esi
80104e49:	8b 75 08             	mov    0x8(%ebp),%esi
80104e4c:	53                   	push   %ebx
80104e4d:	8b 45 10             	mov    0x10(%ebp),%eax
80104e50:	89 f2                	mov    %esi,%edx
80104e52:	eb 1b                	jmp    80104e6f <strncpy+0x2f>
80104e54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e58:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104e5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104e5f:	83 c2 01             	add    $0x1,%edx
80104e62:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80104e66:	89 f9                	mov    %edi,%ecx
80104e68:	88 4a ff             	mov    %cl,-0x1(%edx)
80104e6b:	84 c9                	test   %cl,%cl
80104e6d:	74 09                	je     80104e78 <strncpy+0x38>
80104e6f:	89 c3                	mov    %eax,%ebx
80104e71:	83 e8 01             	sub    $0x1,%eax
80104e74:	85 db                	test   %ebx,%ebx
80104e76:	7f e0                	jg     80104e58 <strncpy+0x18>
80104e78:	89 d1                	mov    %edx,%ecx
80104e7a:	85 c0                	test   %eax,%eax
80104e7c:	7e 15                	jle    80104e93 <strncpy+0x53>
80104e7e:	66 90                	xchg   %ax,%ax
80104e80:	83 c1 01             	add    $0x1,%ecx
80104e83:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80104e87:	89 c8                	mov    %ecx,%eax
80104e89:	f7 d0                	not    %eax
80104e8b:	01 d0                	add    %edx,%eax
80104e8d:	01 d8                	add    %ebx,%eax
80104e8f:	85 c0                	test   %eax,%eax
80104e91:	7f ed                	jg     80104e80 <strncpy+0x40>
80104e93:	5b                   	pop    %ebx
80104e94:	89 f0                	mov    %esi,%eax
80104e96:	5e                   	pop    %esi
80104e97:	5f                   	pop    %edi
80104e98:	5d                   	pop    %ebp
80104e99:	c3                   	ret    
80104e9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ea0 <safestrcpy>:
80104ea0:	f3 0f 1e fb          	endbr32 
80104ea4:	55                   	push   %ebp
80104ea5:	89 e5                	mov    %esp,%ebp
80104ea7:	56                   	push   %esi
80104ea8:	8b 55 10             	mov    0x10(%ebp),%edx
80104eab:	8b 75 08             	mov    0x8(%ebp),%esi
80104eae:	53                   	push   %ebx
80104eaf:	8b 45 0c             	mov    0xc(%ebp),%eax
80104eb2:	85 d2                	test   %edx,%edx
80104eb4:	7e 21                	jle    80104ed7 <safestrcpy+0x37>
80104eb6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104eba:	89 f2                	mov    %esi,%edx
80104ebc:	eb 12                	jmp    80104ed0 <safestrcpy+0x30>
80104ebe:	66 90                	xchg   %ax,%ax
80104ec0:	0f b6 08             	movzbl (%eax),%ecx
80104ec3:	83 c0 01             	add    $0x1,%eax
80104ec6:	83 c2 01             	add    $0x1,%edx
80104ec9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104ecc:	84 c9                	test   %cl,%cl
80104ece:	74 04                	je     80104ed4 <safestrcpy+0x34>
80104ed0:	39 d8                	cmp    %ebx,%eax
80104ed2:	75 ec                	jne    80104ec0 <safestrcpy+0x20>
80104ed4:	c6 02 00             	movb   $0x0,(%edx)
80104ed7:	89 f0                	mov    %esi,%eax
80104ed9:	5b                   	pop    %ebx
80104eda:	5e                   	pop    %esi
80104edb:	5d                   	pop    %ebp
80104edc:	c3                   	ret    
80104edd:	8d 76 00             	lea    0x0(%esi),%esi

80104ee0 <strlen>:
80104ee0:	f3 0f 1e fb          	endbr32 
80104ee4:	55                   	push   %ebp
80104ee5:	31 c0                	xor    %eax,%eax
80104ee7:	89 e5                	mov    %esp,%ebp
80104ee9:	8b 55 08             	mov    0x8(%ebp),%edx
80104eec:	80 3a 00             	cmpb   $0x0,(%edx)
80104eef:	74 10                	je     80104f01 <strlen+0x21>
80104ef1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef8:	83 c0 01             	add    $0x1,%eax
80104efb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104eff:	75 f7                	jne    80104ef8 <strlen+0x18>
80104f01:	5d                   	pop    %ebp
80104f02:	c3                   	ret    

80104f03 <swtch>:
80104f03:	8b 44 24 04          	mov    0x4(%esp),%eax
80104f07:	8b 54 24 08          	mov    0x8(%esp),%edx
80104f0b:	55                   	push   %ebp
80104f0c:	53                   	push   %ebx
80104f0d:	56                   	push   %esi
80104f0e:	57                   	push   %edi
80104f0f:	89 20                	mov    %esp,(%eax)
80104f11:	89 d4                	mov    %edx,%esp
80104f13:	5f                   	pop    %edi
80104f14:	5e                   	pop    %esi
80104f15:	5b                   	pop    %ebx
80104f16:	5d                   	pop    %ebp
80104f17:	c3                   	ret    
80104f18:	66 90                	xchg   %ax,%ax
80104f1a:	66 90                	xchg   %ax,%ax
80104f1c:	66 90                	xchg   %ax,%ax
80104f1e:	66 90                	xchg   %ax,%ax

80104f20 <fetchint>:
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
80104f25:	89 e5                	mov    %esp,%ebp
80104f27:	53                   	push   %ebx
80104f28:	83 ec 04             	sub    $0x4,%esp
80104f2b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f2e:	e8 0d ef ff ff       	call   80103e40 <myproc>
80104f33:	8b 00                	mov    (%eax),%eax
80104f35:	39 d8                	cmp    %ebx,%eax
80104f37:	76 17                	jbe    80104f50 <fetchint+0x30>
80104f39:	8d 53 04             	lea    0x4(%ebx),%edx
80104f3c:	39 d0                	cmp    %edx,%eax
80104f3e:	72 10                	jb     80104f50 <fetchint+0x30>
80104f40:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f43:	8b 13                	mov    (%ebx),%edx
80104f45:	89 10                	mov    %edx,(%eax)
80104f47:	31 c0                	xor    %eax,%eax
80104f49:	83 c4 04             	add    $0x4,%esp
80104f4c:	5b                   	pop    %ebx
80104f4d:	5d                   	pop    %ebp
80104f4e:	c3                   	ret    
80104f4f:	90                   	nop
80104f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f55:	eb f2                	jmp    80104f49 <fetchint+0x29>
80104f57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <fetchstr>:
80104f60:	f3 0f 1e fb          	endbr32 
80104f64:	55                   	push   %ebp
80104f65:	89 e5                	mov    %esp,%ebp
80104f67:	53                   	push   %ebx
80104f68:	83 ec 04             	sub    $0x4,%esp
80104f6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104f6e:	e8 cd ee ff ff       	call   80103e40 <myproc>
80104f73:	39 18                	cmp    %ebx,(%eax)
80104f75:	76 31                	jbe    80104fa8 <fetchstr+0x48>
80104f77:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f7a:	89 1a                	mov    %ebx,(%edx)
80104f7c:	8b 10                	mov    (%eax),%edx
80104f7e:	39 d3                	cmp    %edx,%ebx
80104f80:	73 26                	jae    80104fa8 <fetchstr+0x48>
80104f82:	89 d8                	mov    %ebx,%eax
80104f84:	eb 11                	jmp    80104f97 <fetchstr+0x37>
80104f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
80104f90:	83 c0 01             	add    $0x1,%eax
80104f93:	39 c2                	cmp    %eax,%edx
80104f95:	76 11                	jbe    80104fa8 <fetchstr+0x48>
80104f97:	80 38 00             	cmpb   $0x0,(%eax)
80104f9a:	75 f4                	jne    80104f90 <fetchstr+0x30>
80104f9c:	83 c4 04             	add    $0x4,%esp
80104f9f:	29 d8                	sub    %ebx,%eax
80104fa1:	5b                   	pop    %ebx
80104fa2:	5d                   	pop    %ebp
80104fa3:	c3                   	ret    
80104fa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fa8:	83 c4 04             	add    $0x4,%esp
80104fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fb0:	5b                   	pop    %ebx
80104fb1:	5d                   	pop    %ebp
80104fb2:	c3                   	ret    
80104fb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fc0 <argint>:
80104fc0:	f3 0f 1e fb          	endbr32 
80104fc4:	55                   	push   %ebp
80104fc5:	89 e5                	mov    %esp,%ebp
80104fc7:	56                   	push   %esi
80104fc8:	53                   	push   %ebx
80104fc9:	e8 72 ee ff ff       	call   80103e40 <myproc>
80104fce:	8b 55 08             	mov    0x8(%ebp),%edx
80104fd1:	8b 40 1c             	mov    0x1c(%eax),%eax
80104fd4:	8b 40 44             	mov    0x44(%eax),%eax
80104fd7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80104fda:	e8 61 ee ff ff       	call   80103e40 <myproc>
80104fdf:	8d 73 04             	lea    0x4(%ebx),%esi
80104fe2:	8b 00                	mov    (%eax),%eax
80104fe4:	39 c6                	cmp    %eax,%esi
80104fe6:	73 18                	jae    80105000 <argint+0x40>
80104fe8:	8d 53 08             	lea    0x8(%ebx),%edx
80104feb:	39 d0                	cmp    %edx,%eax
80104fed:	72 11                	jb     80105000 <argint+0x40>
80104fef:	8b 45 0c             	mov    0xc(%ebp),%eax
80104ff2:	8b 53 04             	mov    0x4(%ebx),%edx
80104ff5:	89 10                	mov    %edx,(%eax)
80104ff7:	31 c0                	xor    %eax,%eax
80104ff9:	5b                   	pop    %ebx
80104ffa:	5e                   	pop    %esi
80104ffb:	5d                   	pop    %ebp
80104ffc:	c3                   	ret    
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
80105000:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105005:	eb f2                	jmp    80104ff9 <argint+0x39>
80105007:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010500e:	66 90                	xchg   %ax,%ax

80105010 <argptr>:
80105010:	f3 0f 1e fb          	endbr32 
80105014:	55                   	push   %ebp
80105015:	89 e5                	mov    %esp,%ebp
80105017:	56                   	push   %esi
80105018:	53                   	push   %ebx
80105019:	83 ec 10             	sub    $0x10,%esp
8010501c:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010501f:	e8 1c ee ff ff       	call   80103e40 <myproc>
80105024:	83 ec 08             	sub    $0x8,%esp
80105027:	89 c6                	mov    %eax,%esi
80105029:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010502c:	50                   	push   %eax
8010502d:	ff 75 08             	pushl  0x8(%ebp)
80105030:	e8 8b ff ff ff       	call   80104fc0 <argint>
80105035:	83 c4 10             	add    $0x10,%esp
80105038:	85 c0                	test   %eax,%eax
8010503a:	78 24                	js     80105060 <argptr+0x50>
8010503c:	85 db                	test   %ebx,%ebx
8010503e:	78 20                	js     80105060 <argptr+0x50>
80105040:	8b 16                	mov    (%esi),%edx
80105042:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105045:	39 c2                	cmp    %eax,%edx
80105047:	76 17                	jbe    80105060 <argptr+0x50>
80105049:	01 c3                	add    %eax,%ebx
8010504b:	39 da                	cmp    %ebx,%edx
8010504d:	72 11                	jb     80105060 <argptr+0x50>
8010504f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105052:	89 02                	mov    %eax,(%edx)
80105054:	31 c0                	xor    %eax,%eax
80105056:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105059:	5b                   	pop    %ebx
8010505a:	5e                   	pop    %esi
8010505b:	5d                   	pop    %ebp
8010505c:	c3                   	ret    
8010505d:	8d 76 00             	lea    0x0(%esi),%esi
80105060:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105065:	eb ef                	jmp    80105056 <argptr+0x46>
80105067:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010506e:	66 90                	xchg   %ax,%ax

80105070 <argstr>:
80105070:	f3 0f 1e fb          	endbr32 
80105074:	55                   	push   %ebp
80105075:	89 e5                	mov    %esp,%ebp
80105077:	83 ec 20             	sub    $0x20,%esp
8010507a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010507d:	50                   	push   %eax
8010507e:	ff 75 08             	pushl  0x8(%ebp)
80105081:	e8 3a ff ff ff       	call   80104fc0 <argint>
80105086:	83 c4 10             	add    $0x10,%esp
80105089:	85 c0                	test   %eax,%eax
8010508b:	78 13                	js     801050a0 <argstr+0x30>
8010508d:	83 ec 08             	sub    $0x8,%esp
80105090:	ff 75 0c             	pushl  0xc(%ebp)
80105093:	ff 75 f4             	pushl  -0xc(%ebp)
80105096:	e8 c5 fe ff ff       	call   80104f60 <fetchstr>
8010509b:	83 c4 10             	add    $0x10,%esp
8010509e:	c9                   	leave  
8010509f:	c3                   	ret    
801050a0:	c9                   	leave  
801050a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a6:	c3                   	ret    
801050a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050ae:	66 90                	xchg   %ax,%ax

801050b0 <syscall>:
801050b0:	f3 0f 1e fb          	endbr32 
801050b4:	55                   	push   %ebp
801050b5:	89 e5                	mov    %esp,%ebp
801050b7:	53                   	push   %ebx
801050b8:	83 ec 04             	sub    $0x4,%esp
801050bb:	e8 80 ed ff ff       	call   80103e40 <myproc>
801050c0:	89 c3                	mov    %eax,%ebx
801050c2:	8b 40 1c             	mov    0x1c(%eax),%eax
801050c5:	8b 40 1c             	mov    0x1c(%eax),%eax
801050c8:	8d 50 ff             	lea    -0x1(%eax),%edx
801050cb:	83 fa 19             	cmp    $0x19,%edx
801050ce:	77 20                	ja     801050f0 <syscall+0x40>
801050d0:	8b 14 85 20 80 10 80 	mov    -0x7fef7fe0(,%eax,4),%edx
801050d7:	85 d2                	test   %edx,%edx
801050d9:	74 15                	je     801050f0 <syscall+0x40>
801050db:	ff d2                	call   *%edx
801050dd:	89 c2                	mov    %eax,%edx
801050df:	8b 43 1c             	mov    0x1c(%ebx),%eax
801050e2:	89 50 1c             	mov    %edx,0x1c(%eax)
801050e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050e8:	c9                   	leave  
801050e9:	c3                   	ret    
801050ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050f0:	50                   	push   %eax
801050f1:	8d 43 70             	lea    0x70(%ebx),%eax
801050f4:	50                   	push   %eax
801050f5:	ff 73 10             	pushl  0x10(%ebx)
801050f8:	68 fd 7f 10 80       	push   $0x80107ffd
801050fd:	e8 ae b5 ff ff       	call   801006b0 <cprintf>
80105102:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105105:	83 c4 10             	add    $0x10,%esp
80105108:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
8010510f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105112:	c9                   	leave  
80105113:	c3                   	ret    
80105114:	66 90                	xchg   %ax,%ax
80105116:	66 90                	xchg   %ax,%ax
80105118:	66 90                	xchg   %ax,%ax
8010511a:	66 90                	xchg   %ax,%ax
8010511c:	66 90                	xchg   %ax,%ax
8010511e:	66 90                	xchg   %ax,%ax

80105120 <create>:
80105120:	55                   	push   %ebp
80105121:	89 e5                	mov    %esp,%ebp
80105123:	57                   	push   %edi
80105124:	56                   	push   %esi
80105125:	8d 7d da             	lea    -0x26(%ebp),%edi
80105128:	53                   	push   %ebx
80105129:	83 ec 34             	sub    $0x34,%esp
8010512c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010512f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105132:	57                   	push   %edi
80105133:	50                   	push   %eax
80105134:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105137:	89 4d cc             	mov    %ecx,-0x34(%ebp)
8010513a:	e8 d1 d3 ff ff       	call   80102510 <nameiparent>
8010513f:	83 c4 10             	add    $0x10,%esp
80105142:	85 c0                	test   %eax,%eax
80105144:	0f 84 46 01 00 00    	je     80105290 <create+0x170>
8010514a:	83 ec 0c             	sub    $0xc,%esp
8010514d:	89 c3                	mov    %eax,%ebx
8010514f:	50                   	push   %eax
80105150:	e8 cb ca ff ff       	call   80101c20 <ilock>
80105155:	83 c4 0c             	add    $0xc,%esp
80105158:	6a 00                	push   $0x0
8010515a:	57                   	push   %edi
8010515b:	53                   	push   %ebx
8010515c:	e8 0f d0 ff ff       	call   80102170 <dirlookup>
80105161:	83 c4 10             	add    $0x10,%esp
80105164:	89 c6                	mov    %eax,%esi
80105166:	85 c0                	test   %eax,%eax
80105168:	74 56                	je     801051c0 <create+0xa0>
8010516a:	83 ec 0c             	sub    $0xc,%esp
8010516d:	53                   	push   %ebx
8010516e:	e8 4d cd ff ff       	call   80101ec0 <iunlockput>
80105173:	89 34 24             	mov    %esi,(%esp)
80105176:	e8 a5 ca ff ff       	call   80101c20 <ilock>
8010517b:	83 c4 10             	add    $0x10,%esp
8010517e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105183:	75 1b                	jne    801051a0 <create+0x80>
80105185:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010518a:	75 14                	jne    801051a0 <create+0x80>
8010518c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010518f:	89 f0                	mov    %esi,%eax
80105191:	5b                   	pop    %ebx
80105192:	5e                   	pop    %esi
80105193:	5f                   	pop    %edi
80105194:	5d                   	pop    %ebp
80105195:	c3                   	ret    
80105196:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
801051a0:	83 ec 0c             	sub    $0xc,%esp
801051a3:	56                   	push   %esi
801051a4:	31 f6                	xor    %esi,%esi
801051a6:	e8 15 cd ff ff       	call   80101ec0 <iunlockput>
801051ab:	83 c4 10             	add    $0x10,%esp
801051ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051b1:	89 f0                	mov    %esi,%eax
801051b3:	5b                   	pop    %ebx
801051b4:	5e                   	pop    %esi
801051b5:	5f                   	pop    %edi
801051b6:	5d                   	pop    %ebp
801051b7:	c3                   	ret    
801051b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051bf:	90                   	nop
801051c0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801051c4:	83 ec 08             	sub    $0x8,%esp
801051c7:	50                   	push   %eax
801051c8:	ff 33                	pushl  (%ebx)
801051ca:	e8 d1 c8 ff ff       	call   80101aa0 <ialloc>
801051cf:	83 c4 10             	add    $0x10,%esp
801051d2:	89 c6                	mov    %eax,%esi
801051d4:	85 c0                	test   %eax,%eax
801051d6:	0f 84 cd 00 00 00    	je     801052a9 <create+0x189>
801051dc:	83 ec 0c             	sub    $0xc,%esp
801051df:	50                   	push   %eax
801051e0:	e8 3b ca ff ff       	call   80101c20 <ilock>
801051e5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801051e9:	66 89 46 52          	mov    %ax,0x52(%esi)
801051ed:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801051f1:	66 89 46 54          	mov    %ax,0x54(%esi)
801051f5:	b8 01 00 00 00       	mov    $0x1,%eax
801051fa:	66 89 46 56          	mov    %ax,0x56(%esi)
801051fe:	89 34 24             	mov    %esi,(%esp)
80105201:	e8 5a c9 ff ff       	call   80101b60 <iupdate>
80105206:	83 c4 10             	add    $0x10,%esp
80105209:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010520e:	74 30                	je     80105240 <create+0x120>
80105210:	83 ec 04             	sub    $0x4,%esp
80105213:	ff 76 04             	pushl  0x4(%esi)
80105216:	57                   	push   %edi
80105217:	53                   	push   %ebx
80105218:	e8 13 d2 ff ff       	call   80102430 <dirlink>
8010521d:	83 c4 10             	add    $0x10,%esp
80105220:	85 c0                	test   %eax,%eax
80105222:	78 78                	js     8010529c <create+0x17c>
80105224:	83 ec 0c             	sub    $0xc,%esp
80105227:	53                   	push   %ebx
80105228:	e8 93 cc ff ff       	call   80101ec0 <iunlockput>
8010522d:	83 c4 10             	add    $0x10,%esp
80105230:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105233:	89 f0                	mov    %esi,%eax
80105235:	5b                   	pop    %ebx
80105236:	5e                   	pop    %esi
80105237:	5f                   	pop    %edi
80105238:	5d                   	pop    %ebp
80105239:	c3                   	ret    
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105240:	83 ec 0c             	sub    $0xc,%esp
80105243:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105248:	53                   	push   %ebx
80105249:	e8 12 c9 ff ff       	call   80101b60 <iupdate>
8010524e:	83 c4 0c             	add    $0xc,%esp
80105251:	ff 76 04             	pushl  0x4(%esi)
80105254:	68 a8 80 10 80       	push   $0x801080a8
80105259:	56                   	push   %esi
8010525a:	e8 d1 d1 ff ff       	call   80102430 <dirlink>
8010525f:	83 c4 10             	add    $0x10,%esp
80105262:	85 c0                	test   %eax,%eax
80105264:	78 18                	js     8010527e <create+0x15e>
80105266:	83 ec 04             	sub    $0x4,%esp
80105269:	ff 73 04             	pushl  0x4(%ebx)
8010526c:	68 a7 80 10 80       	push   $0x801080a7
80105271:	56                   	push   %esi
80105272:	e8 b9 d1 ff ff       	call   80102430 <dirlink>
80105277:	83 c4 10             	add    $0x10,%esp
8010527a:	85 c0                	test   %eax,%eax
8010527c:	79 92                	jns    80105210 <create+0xf0>
8010527e:	83 ec 0c             	sub    $0xc,%esp
80105281:	68 9b 80 10 80       	push   $0x8010809b
80105286:	e8 05 b1 ff ff       	call   80100390 <panic>
8010528b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010528f:	90                   	nop
80105290:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105293:	31 f6                	xor    %esi,%esi
80105295:	5b                   	pop    %ebx
80105296:	89 f0                	mov    %esi,%eax
80105298:	5e                   	pop    %esi
80105299:	5f                   	pop    %edi
8010529a:	5d                   	pop    %ebp
8010529b:	c3                   	ret    
8010529c:	83 ec 0c             	sub    $0xc,%esp
8010529f:	68 aa 80 10 80       	push   $0x801080aa
801052a4:	e8 e7 b0 ff ff       	call   80100390 <panic>
801052a9:	83 ec 0c             	sub    $0xc,%esp
801052ac:	68 8c 80 10 80       	push   $0x8010808c
801052b1:	e8 da b0 ff ff       	call   80100390 <panic>
801052b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <argfd.constprop.0>:
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	56                   	push   %esi
801052c4:	89 d6                	mov    %edx,%esi
801052c6:	53                   	push   %ebx
801052c7:	89 c3                	mov    %eax,%ebx
801052c9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801052cc:	83 ec 18             	sub    $0x18,%esp
801052cf:	50                   	push   %eax
801052d0:	6a 00                	push   $0x0
801052d2:	e8 e9 fc ff ff       	call   80104fc0 <argint>
801052d7:	83 c4 10             	add    $0x10,%esp
801052da:	85 c0                	test   %eax,%eax
801052dc:	78 2a                	js     80105308 <argfd.constprop.0+0x48>
801052de:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801052e2:	77 24                	ja     80105308 <argfd.constprop.0+0x48>
801052e4:	e8 57 eb ff ff       	call   80103e40 <myproc>
801052e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801052ec:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
801052f0:	85 c0                	test   %eax,%eax
801052f2:	74 14                	je     80105308 <argfd.constprop.0+0x48>
801052f4:	85 db                	test   %ebx,%ebx
801052f6:	74 02                	je     801052fa <argfd.constprop.0+0x3a>
801052f8:	89 13                	mov    %edx,(%ebx)
801052fa:	89 06                	mov    %eax,(%esi)
801052fc:	31 c0                	xor    %eax,%eax
801052fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105301:	5b                   	pop    %ebx
80105302:	5e                   	pop    %esi
80105303:	5d                   	pop    %ebp
80105304:	c3                   	ret    
80105305:	8d 76 00             	lea    0x0(%esi),%esi
80105308:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530d:	eb ef                	jmp    801052fe <argfd.constprop.0+0x3e>
8010530f:	90                   	nop

80105310 <sys_dup>:
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
80105315:	31 c0                	xor    %eax,%eax
80105317:	89 e5                	mov    %esp,%ebp
80105319:	56                   	push   %esi
8010531a:	53                   	push   %ebx
8010531b:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010531e:	83 ec 10             	sub    $0x10,%esp
80105321:	e8 9a ff ff ff       	call   801052c0 <argfd.constprop.0>
80105326:	85 c0                	test   %eax,%eax
80105328:	78 1e                	js     80105348 <sys_dup+0x38>
8010532a:	8b 75 f4             	mov    -0xc(%ebp),%esi
8010532d:	31 db                	xor    %ebx,%ebx
8010532f:	e8 0c eb ff ff       	call   80103e40 <myproc>
80105334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105338:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
8010533c:	85 d2                	test   %edx,%edx
8010533e:	74 20                	je     80105360 <sys_dup+0x50>
80105340:	83 c3 01             	add    $0x1,%ebx
80105343:	83 fb 10             	cmp    $0x10,%ebx
80105346:	75 f0                	jne    80105338 <sys_dup+0x28>
80105348:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010534b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105350:	89 d8                	mov    %ebx,%eax
80105352:	5b                   	pop    %ebx
80105353:	5e                   	pop    %esi
80105354:	5d                   	pop    %ebp
80105355:	c3                   	ret    
80105356:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010535d:	8d 76 00             	lea    0x0(%esi),%esi
80105360:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
80105364:	83 ec 0c             	sub    $0xc,%esp
80105367:	ff 75 f4             	pushl  -0xc(%ebp)
8010536a:	e8 c1 bf ff ff       	call   80101330 <filedup>
8010536f:	83 c4 10             	add    $0x10,%esp
80105372:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105375:	89 d8                	mov    %ebx,%eax
80105377:	5b                   	pop    %ebx
80105378:	5e                   	pop    %esi
80105379:	5d                   	pop    %ebp
8010537a:	c3                   	ret    
8010537b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010537f:	90                   	nop

80105380 <sys_read>:
80105380:	f3 0f 1e fb          	endbr32 
80105384:	55                   	push   %ebp
80105385:	31 c0                	xor    %eax,%eax
80105387:	89 e5                	mov    %esp,%ebp
80105389:	83 ec 18             	sub    $0x18,%esp
8010538c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010538f:	e8 2c ff ff ff       	call   801052c0 <argfd.constprop.0>
80105394:	85 c0                	test   %eax,%eax
80105396:	78 48                	js     801053e0 <sys_read+0x60>
80105398:	83 ec 08             	sub    $0x8,%esp
8010539b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010539e:	50                   	push   %eax
8010539f:	6a 02                	push   $0x2
801053a1:	e8 1a fc ff ff       	call   80104fc0 <argint>
801053a6:	83 c4 10             	add    $0x10,%esp
801053a9:	85 c0                	test   %eax,%eax
801053ab:	78 33                	js     801053e0 <sys_read+0x60>
801053ad:	83 ec 04             	sub    $0x4,%esp
801053b0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801053b3:	ff 75 f0             	pushl  -0x10(%ebp)
801053b6:	50                   	push   %eax
801053b7:	6a 01                	push   $0x1
801053b9:	e8 52 fc ff ff       	call   80105010 <argptr>
801053be:	83 c4 10             	add    $0x10,%esp
801053c1:	85 c0                	test   %eax,%eax
801053c3:	78 1b                	js     801053e0 <sys_read+0x60>
801053c5:	83 ec 04             	sub    $0x4,%esp
801053c8:	ff 75 f0             	pushl  -0x10(%ebp)
801053cb:	ff 75 f4             	pushl  -0xc(%ebp)
801053ce:	ff 75 ec             	pushl  -0x14(%ebp)
801053d1:	e8 da c0 ff ff       	call   801014b0 <fileread>
801053d6:	83 c4 10             	add    $0x10,%esp
801053d9:	c9                   	leave  
801053da:	c3                   	ret    
801053db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053df:	90                   	nop
801053e0:	c9                   	leave  
801053e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801053e6:	c3                   	ret    
801053e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053ee:	66 90                	xchg   %ax,%ax

801053f0 <sys_write>:
801053f0:	f3 0f 1e fb          	endbr32 
801053f4:	55                   	push   %ebp
801053f5:	31 c0                	xor    %eax,%eax
801053f7:	89 e5                	mov    %esp,%ebp
801053f9:	83 ec 18             	sub    $0x18,%esp
801053fc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801053ff:	e8 bc fe ff ff       	call   801052c0 <argfd.constprop.0>
80105404:	85 c0                	test   %eax,%eax
80105406:	78 48                	js     80105450 <sys_write+0x60>
80105408:	83 ec 08             	sub    $0x8,%esp
8010540b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010540e:	50                   	push   %eax
8010540f:	6a 02                	push   $0x2
80105411:	e8 aa fb ff ff       	call   80104fc0 <argint>
80105416:	83 c4 10             	add    $0x10,%esp
80105419:	85 c0                	test   %eax,%eax
8010541b:	78 33                	js     80105450 <sys_write+0x60>
8010541d:	83 ec 04             	sub    $0x4,%esp
80105420:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105423:	ff 75 f0             	pushl  -0x10(%ebp)
80105426:	50                   	push   %eax
80105427:	6a 01                	push   $0x1
80105429:	e8 e2 fb ff ff       	call   80105010 <argptr>
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	85 c0                	test   %eax,%eax
80105433:	78 1b                	js     80105450 <sys_write+0x60>
80105435:	83 ec 04             	sub    $0x4,%esp
80105438:	ff 75 f0             	pushl  -0x10(%ebp)
8010543b:	ff 75 f4             	pushl  -0xc(%ebp)
8010543e:	ff 75 ec             	pushl  -0x14(%ebp)
80105441:	e8 0a c1 ff ff       	call   80101550 <filewrite>
80105446:	83 c4 10             	add    $0x10,%esp
80105449:	c9                   	leave  
8010544a:	c3                   	ret    
8010544b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010544f:	90                   	nop
80105450:	c9                   	leave  
80105451:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105456:	c3                   	ret    
80105457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545e:	66 90                	xchg   %ax,%ax

80105460 <sys_close>:
80105460:	f3 0f 1e fb          	endbr32 
80105464:	55                   	push   %ebp
80105465:	89 e5                	mov    %esp,%ebp
80105467:	83 ec 18             	sub    $0x18,%esp
8010546a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010546d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105470:	e8 4b fe ff ff       	call   801052c0 <argfd.constprop.0>
80105475:	85 c0                	test   %eax,%eax
80105477:	78 27                	js     801054a0 <sys_close+0x40>
80105479:	e8 c2 e9 ff ff       	call   80103e40 <myproc>
8010547e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105481:	83 ec 0c             	sub    $0xc,%esp
80105484:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
8010548b:	00 
8010548c:	ff 75 f4             	pushl  -0xc(%ebp)
8010548f:	e8 ec be ff ff       	call   80101380 <fileclose>
80105494:	83 c4 10             	add    $0x10,%esp
80105497:	31 c0                	xor    %eax,%eax
80105499:	c9                   	leave  
8010549a:	c3                   	ret    
8010549b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010549f:	90                   	nop
801054a0:	c9                   	leave  
801054a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054a6:	c3                   	ret    
801054a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ae:	66 90                	xchg   %ax,%ax

801054b0 <sys_fstat>:
801054b0:	f3 0f 1e fb          	endbr32 
801054b4:	55                   	push   %ebp
801054b5:	31 c0                	xor    %eax,%eax
801054b7:	89 e5                	mov    %esp,%ebp
801054b9:	83 ec 18             	sub    $0x18,%esp
801054bc:	8d 55 f0             	lea    -0x10(%ebp),%edx
801054bf:	e8 fc fd ff ff       	call   801052c0 <argfd.constprop.0>
801054c4:	85 c0                	test   %eax,%eax
801054c6:	78 30                	js     801054f8 <sys_fstat+0x48>
801054c8:	83 ec 04             	sub    $0x4,%esp
801054cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054ce:	6a 14                	push   $0x14
801054d0:	50                   	push   %eax
801054d1:	6a 01                	push   $0x1
801054d3:	e8 38 fb ff ff       	call   80105010 <argptr>
801054d8:	83 c4 10             	add    $0x10,%esp
801054db:	85 c0                	test   %eax,%eax
801054dd:	78 19                	js     801054f8 <sys_fstat+0x48>
801054df:	83 ec 08             	sub    $0x8,%esp
801054e2:	ff 75 f4             	pushl  -0xc(%ebp)
801054e5:	ff 75 f0             	pushl  -0x10(%ebp)
801054e8:	e8 73 bf ff ff       	call   80101460 <filestat>
801054ed:	83 c4 10             	add    $0x10,%esp
801054f0:	c9                   	leave  
801054f1:	c3                   	ret    
801054f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054f8:	c9                   	leave  
801054f9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801054fe:	c3                   	ret    
801054ff:	90                   	nop

80105500 <sys_link>:
80105500:	f3 0f 1e fb          	endbr32 
80105504:	55                   	push   %ebp
80105505:	89 e5                	mov    %esp,%ebp
80105507:	57                   	push   %edi
80105508:	56                   	push   %esi
80105509:	8d 45 d4             	lea    -0x2c(%ebp),%eax
8010550c:	53                   	push   %ebx
8010550d:	83 ec 34             	sub    $0x34,%esp
80105510:	50                   	push   %eax
80105511:	6a 00                	push   $0x0
80105513:	e8 58 fb ff ff       	call   80105070 <argstr>
80105518:	83 c4 10             	add    $0x10,%esp
8010551b:	85 c0                	test   %eax,%eax
8010551d:	0f 88 ff 00 00 00    	js     80105622 <sys_link+0x122>
80105523:	83 ec 08             	sub    $0x8,%esp
80105526:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105529:	50                   	push   %eax
8010552a:	6a 01                	push   $0x1
8010552c:	e8 3f fb ff ff       	call   80105070 <argstr>
80105531:	83 c4 10             	add    $0x10,%esp
80105534:	85 c0                	test   %eax,%eax
80105536:	0f 88 e6 00 00 00    	js     80105622 <sys_link+0x122>
8010553c:	e8 cf dc ff ff       	call   80103210 <begin_op>
80105541:	83 ec 0c             	sub    $0xc,%esp
80105544:	ff 75 d4             	pushl  -0x2c(%ebp)
80105547:	e8 a4 cf ff ff       	call   801024f0 <namei>
8010554c:	83 c4 10             	add    $0x10,%esp
8010554f:	89 c3                	mov    %eax,%ebx
80105551:	85 c0                	test   %eax,%eax
80105553:	0f 84 e8 00 00 00    	je     80105641 <sys_link+0x141>
80105559:	83 ec 0c             	sub    $0xc,%esp
8010555c:	50                   	push   %eax
8010555d:	e8 be c6 ff ff       	call   80101c20 <ilock>
80105562:	83 c4 10             	add    $0x10,%esp
80105565:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010556a:	0f 84 b9 00 00 00    	je     80105629 <sys_link+0x129>
80105570:	83 ec 0c             	sub    $0xc,%esp
80105573:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
80105578:	8d 7d da             	lea    -0x26(%ebp),%edi
8010557b:	53                   	push   %ebx
8010557c:	e8 df c5 ff ff       	call   80101b60 <iupdate>
80105581:	89 1c 24             	mov    %ebx,(%esp)
80105584:	e8 77 c7 ff ff       	call   80101d00 <iunlock>
80105589:	58                   	pop    %eax
8010558a:	5a                   	pop    %edx
8010558b:	57                   	push   %edi
8010558c:	ff 75 d0             	pushl  -0x30(%ebp)
8010558f:	e8 7c cf ff ff       	call   80102510 <nameiparent>
80105594:	83 c4 10             	add    $0x10,%esp
80105597:	89 c6                	mov    %eax,%esi
80105599:	85 c0                	test   %eax,%eax
8010559b:	74 5f                	je     801055fc <sys_link+0xfc>
8010559d:	83 ec 0c             	sub    $0xc,%esp
801055a0:	50                   	push   %eax
801055a1:	e8 7a c6 ff ff       	call   80101c20 <ilock>
801055a6:	8b 03                	mov    (%ebx),%eax
801055a8:	83 c4 10             	add    $0x10,%esp
801055ab:	39 06                	cmp    %eax,(%esi)
801055ad:	75 41                	jne    801055f0 <sys_link+0xf0>
801055af:	83 ec 04             	sub    $0x4,%esp
801055b2:	ff 73 04             	pushl  0x4(%ebx)
801055b5:	57                   	push   %edi
801055b6:	56                   	push   %esi
801055b7:	e8 74 ce ff ff       	call   80102430 <dirlink>
801055bc:	83 c4 10             	add    $0x10,%esp
801055bf:	85 c0                	test   %eax,%eax
801055c1:	78 2d                	js     801055f0 <sys_link+0xf0>
801055c3:	83 ec 0c             	sub    $0xc,%esp
801055c6:	56                   	push   %esi
801055c7:	e8 f4 c8 ff ff       	call   80101ec0 <iunlockput>
801055cc:	89 1c 24             	mov    %ebx,(%esp)
801055cf:	e8 7c c7 ff ff       	call   80101d50 <iput>
801055d4:	e8 a7 dc ff ff       	call   80103280 <end_op>
801055d9:	83 c4 10             	add    $0x10,%esp
801055dc:	31 c0                	xor    %eax,%eax
801055de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055e1:	5b                   	pop    %ebx
801055e2:	5e                   	pop    %esi
801055e3:	5f                   	pop    %edi
801055e4:	5d                   	pop    %ebp
801055e5:	c3                   	ret    
801055e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ed:	8d 76 00             	lea    0x0(%esi),%esi
801055f0:	83 ec 0c             	sub    $0xc,%esp
801055f3:	56                   	push   %esi
801055f4:	e8 c7 c8 ff ff       	call   80101ec0 <iunlockput>
801055f9:	83 c4 10             	add    $0x10,%esp
801055fc:	83 ec 0c             	sub    $0xc,%esp
801055ff:	53                   	push   %ebx
80105600:	e8 1b c6 ff ff       	call   80101c20 <ilock>
80105605:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010560a:	89 1c 24             	mov    %ebx,(%esp)
8010560d:	e8 4e c5 ff ff       	call   80101b60 <iupdate>
80105612:	89 1c 24             	mov    %ebx,(%esp)
80105615:	e8 a6 c8 ff ff       	call   80101ec0 <iunlockput>
8010561a:	e8 61 dc ff ff       	call   80103280 <end_op>
8010561f:	83 c4 10             	add    $0x10,%esp
80105622:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105627:	eb b5                	jmp    801055de <sys_link+0xde>
80105629:	83 ec 0c             	sub    $0xc,%esp
8010562c:	53                   	push   %ebx
8010562d:	e8 8e c8 ff ff       	call   80101ec0 <iunlockput>
80105632:	e8 49 dc ff ff       	call   80103280 <end_op>
80105637:	83 c4 10             	add    $0x10,%esp
8010563a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010563f:	eb 9d                	jmp    801055de <sys_link+0xde>
80105641:	e8 3a dc ff ff       	call   80103280 <end_op>
80105646:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010564b:	eb 91                	jmp    801055de <sys_link+0xde>
8010564d:	8d 76 00             	lea    0x0(%esi),%esi

80105650 <sys_unlink>:
80105650:	f3 0f 1e fb          	endbr32 
80105654:	55                   	push   %ebp
80105655:	89 e5                	mov    %esp,%ebp
80105657:	57                   	push   %edi
80105658:	56                   	push   %esi
80105659:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010565c:	53                   	push   %ebx
8010565d:	83 ec 54             	sub    $0x54,%esp
80105660:	50                   	push   %eax
80105661:	6a 00                	push   $0x0
80105663:	e8 08 fa ff ff       	call   80105070 <argstr>
80105668:	83 c4 10             	add    $0x10,%esp
8010566b:	85 c0                	test   %eax,%eax
8010566d:	0f 88 7d 01 00 00    	js     801057f0 <sys_unlink+0x1a0>
80105673:	e8 98 db ff ff       	call   80103210 <begin_op>
80105678:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010567b:	83 ec 08             	sub    $0x8,%esp
8010567e:	53                   	push   %ebx
8010567f:	ff 75 c0             	pushl  -0x40(%ebp)
80105682:	e8 89 ce ff ff       	call   80102510 <nameiparent>
80105687:	83 c4 10             	add    $0x10,%esp
8010568a:	89 c6                	mov    %eax,%esi
8010568c:	85 c0                	test   %eax,%eax
8010568e:	0f 84 66 01 00 00    	je     801057fa <sys_unlink+0x1aa>
80105694:	83 ec 0c             	sub    $0xc,%esp
80105697:	50                   	push   %eax
80105698:	e8 83 c5 ff ff       	call   80101c20 <ilock>
8010569d:	58                   	pop    %eax
8010569e:	5a                   	pop    %edx
8010569f:	68 a8 80 10 80       	push   $0x801080a8
801056a4:	53                   	push   %ebx
801056a5:	e8 a6 ca ff ff       	call   80102150 <namecmp>
801056aa:	83 c4 10             	add    $0x10,%esp
801056ad:	85 c0                	test   %eax,%eax
801056af:	0f 84 03 01 00 00    	je     801057b8 <sys_unlink+0x168>
801056b5:	83 ec 08             	sub    $0x8,%esp
801056b8:	68 a7 80 10 80       	push   $0x801080a7
801056bd:	53                   	push   %ebx
801056be:	e8 8d ca ff ff       	call   80102150 <namecmp>
801056c3:	83 c4 10             	add    $0x10,%esp
801056c6:	85 c0                	test   %eax,%eax
801056c8:	0f 84 ea 00 00 00    	je     801057b8 <sys_unlink+0x168>
801056ce:	83 ec 04             	sub    $0x4,%esp
801056d1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801056d4:	50                   	push   %eax
801056d5:	53                   	push   %ebx
801056d6:	56                   	push   %esi
801056d7:	e8 94 ca ff ff       	call   80102170 <dirlookup>
801056dc:	83 c4 10             	add    $0x10,%esp
801056df:	89 c3                	mov    %eax,%ebx
801056e1:	85 c0                	test   %eax,%eax
801056e3:	0f 84 cf 00 00 00    	je     801057b8 <sys_unlink+0x168>
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	50                   	push   %eax
801056ed:	e8 2e c5 ff ff       	call   80101c20 <ilock>
801056f2:	83 c4 10             	add    $0x10,%esp
801056f5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801056fa:	0f 8e 23 01 00 00    	jle    80105823 <sys_unlink+0x1d3>
80105700:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105705:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105708:	74 66                	je     80105770 <sys_unlink+0x120>
8010570a:	83 ec 04             	sub    $0x4,%esp
8010570d:	6a 10                	push   $0x10
8010570f:	6a 00                	push   $0x0
80105711:	57                   	push   %edi
80105712:	e8 c9 f5 ff ff       	call   80104ce0 <memset>
80105717:	6a 10                	push   $0x10
80105719:	ff 75 c4             	pushl  -0x3c(%ebp)
8010571c:	57                   	push   %edi
8010571d:	56                   	push   %esi
8010571e:	e8 fd c8 ff ff       	call   80102020 <writei>
80105723:	83 c4 20             	add    $0x20,%esp
80105726:	83 f8 10             	cmp    $0x10,%eax
80105729:	0f 85 e7 00 00 00    	jne    80105816 <sys_unlink+0x1c6>
8010572f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105734:	0f 84 96 00 00 00    	je     801057d0 <sys_unlink+0x180>
8010573a:	83 ec 0c             	sub    $0xc,%esp
8010573d:	56                   	push   %esi
8010573e:	e8 7d c7 ff ff       	call   80101ec0 <iunlockput>
80105743:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105748:	89 1c 24             	mov    %ebx,(%esp)
8010574b:	e8 10 c4 ff ff       	call   80101b60 <iupdate>
80105750:	89 1c 24             	mov    %ebx,(%esp)
80105753:	e8 68 c7 ff ff       	call   80101ec0 <iunlockput>
80105758:	e8 23 db ff ff       	call   80103280 <end_op>
8010575d:	83 c4 10             	add    $0x10,%esp
80105760:	31 c0                	xor    %eax,%eax
80105762:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105765:	5b                   	pop    %ebx
80105766:	5e                   	pop    %esi
80105767:	5f                   	pop    %edi
80105768:	5d                   	pop    %ebp
80105769:	c3                   	ret    
8010576a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105770:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105774:	76 94                	jbe    8010570a <sys_unlink+0xba>
80105776:	ba 20 00 00 00       	mov    $0x20,%edx
8010577b:	eb 0b                	jmp    80105788 <sys_unlink+0x138>
8010577d:	8d 76 00             	lea    0x0(%esi),%esi
80105780:	83 c2 10             	add    $0x10,%edx
80105783:	39 53 58             	cmp    %edx,0x58(%ebx)
80105786:	76 82                	jbe    8010570a <sys_unlink+0xba>
80105788:	6a 10                	push   $0x10
8010578a:	52                   	push   %edx
8010578b:	57                   	push   %edi
8010578c:	53                   	push   %ebx
8010578d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105790:	e8 8b c7 ff ff       	call   80101f20 <readi>
80105795:	83 c4 10             	add    $0x10,%esp
80105798:	8b 55 b4             	mov    -0x4c(%ebp),%edx
8010579b:	83 f8 10             	cmp    $0x10,%eax
8010579e:	75 69                	jne    80105809 <sys_unlink+0x1b9>
801057a0:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801057a5:	74 d9                	je     80105780 <sys_unlink+0x130>
801057a7:	83 ec 0c             	sub    $0xc,%esp
801057aa:	53                   	push   %ebx
801057ab:	e8 10 c7 ff ff       	call   80101ec0 <iunlockput>
801057b0:	83 c4 10             	add    $0x10,%esp
801057b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057b7:	90                   	nop
801057b8:	83 ec 0c             	sub    $0xc,%esp
801057bb:	56                   	push   %esi
801057bc:	e8 ff c6 ff ff       	call   80101ec0 <iunlockput>
801057c1:	e8 ba da ff ff       	call   80103280 <end_op>
801057c6:	83 c4 10             	add    $0x10,%esp
801057c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057ce:	eb 92                	jmp    80105762 <sys_unlink+0x112>
801057d0:	83 ec 0c             	sub    $0xc,%esp
801057d3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
801057d8:	56                   	push   %esi
801057d9:	e8 82 c3 ff ff       	call   80101b60 <iupdate>
801057de:	83 c4 10             	add    $0x10,%esp
801057e1:	e9 54 ff ff ff       	jmp    8010573a <sys_unlink+0xea>
801057e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801057ed:	8d 76 00             	lea    0x0(%esi),%esi
801057f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057f5:	e9 68 ff ff ff       	jmp    80105762 <sys_unlink+0x112>
801057fa:	e8 81 da ff ff       	call   80103280 <end_op>
801057ff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105804:	e9 59 ff ff ff       	jmp    80105762 <sys_unlink+0x112>
80105809:	83 ec 0c             	sub    $0xc,%esp
8010580c:	68 cc 80 10 80       	push   $0x801080cc
80105811:	e8 7a ab ff ff       	call   80100390 <panic>
80105816:	83 ec 0c             	sub    $0xc,%esp
80105819:	68 de 80 10 80       	push   $0x801080de
8010581e:	e8 6d ab ff ff       	call   80100390 <panic>
80105823:	83 ec 0c             	sub    $0xc,%esp
80105826:	68 ba 80 10 80       	push   $0x801080ba
8010582b:	e8 60 ab ff ff       	call   80100390 <panic>

80105830 <sys_open>:
80105830:	f3 0f 1e fb          	endbr32 
80105834:	55                   	push   %ebp
80105835:	89 e5                	mov    %esp,%ebp
80105837:	57                   	push   %edi
80105838:	56                   	push   %esi
80105839:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010583c:	53                   	push   %ebx
8010583d:	83 ec 24             	sub    $0x24,%esp
80105840:	50                   	push   %eax
80105841:	6a 00                	push   $0x0
80105843:	e8 28 f8 ff ff       	call   80105070 <argstr>
80105848:	83 c4 10             	add    $0x10,%esp
8010584b:	85 c0                	test   %eax,%eax
8010584d:	0f 88 8a 00 00 00    	js     801058dd <sys_open+0xad>
80105853:	83 ec 08             	sub    $0x8,%esp
80105856:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105859:	50                   	push   %eax
8010585a:	6a 01                	push   $0x1
8010585c:	e8 5f f7 ff ff       	call   80104fc0 <argint>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 75                	js     801058dd <sys_open+0xad>
80105868:	e8 a3 d9 ff ff       	call   80103210 <begin_op>
8010586d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105871:	75 75                	jne    801058e8 <sys_open+0xb8>
80105873:	83 ec 0c             	sub    $0xc,%esp
80105876:	ff 75 e0             	pushl  -0x20(%ebp)
80105879:	e8 72 cc ff ff       	call   801024f0 <namei>
8010587e:	83 c4 10             	add    $0x10,%esp
80105881:	89 c6                	mov    %eax,%esi
80105883:	85 c0                	test   %eax,%eax
80105885:	74 7e                	je     80105905 <sys_open+0xd5>
80105887:	83 ec 0c             	sub    $0xc,%esp
8010588a:	50                   	push   %eax
8010588b:	e8 90 c3 ff ff       	call   80101c20 <ilock>
80105890:	83 c4 10             	add    $0x10,%esp
80105893:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105898:	0f 84 c2 00 00 00    	je     80105960 <sys_open+0x130>
8010589e:	e8 1d ba ff ff       	call   801012c0 <filealloc>
801058a3:	89 c7                	mov    %eax,%edi
801058a5:	85 c0                	test   %eax,%eax
801058a7:	74 23                	je     801058cc <sys_open+0x9c>
801058a9:	e8 92 e5 ff ff       	call   80103e40 <myproc>
801058ae:	31 db                	xor    %ebx,%ebx
801058b0:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
801058b4:	85 d2                	test   %edx,%edx
801058b6:	74 60                	je     80105918 <sys_open+0xe8>
801058b8:	83 c3 01             	add    $0x1,%ebx
801058bb:	83 fb 10             	cmp    $0x10,%ebx
801058be:	75 f0                	jne    801058b0 <sys_open+0x80>
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	57                   	push   %edi
801058c4:	e8 b7 ba ff ff       	call   80101380 <fileclose>
801058c9:	83 c4 10             	add    $0x10,%esp
801058cc:	83 ec 0c             	sub    $0xc,%esp
801058cf:	56                   	push   %esi
801058d0:	e8 eb c5 ff ff       	call   80101ec0 <iunlockput>
801058d5:	e8 a6 d9 ff ff       	call   80103280 <end_op>
801058da:	83 c4 10             	add    $0x10,%esp
801058dd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801058e2:	eb 6d                	jmp    80105951 <sys_open+0x121>
801058e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058e8:	83 ec 0c             	sub    $0xc,%esp
801058eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
801058ee:	31 c9                	xor    %ecx,%ecx
801058f0:	ba 02 00 00 00       	mov    $0x2,%edx
801058f5:	6a 00                	push   $0x0
801058f7:	e8 24 f8 ff ff       	call   80105120 <create>
801058fc:	83 c4 10             	add    $0x10,%esp
801058ff:	89 c6                	mov    %eax,%esi
80105901:	85 c0                	test   %eax,%eax
80105903:	75 99                	jne    8010589e <sys_open+0x6e>
80105905:	e8 76 d9 ff ff       	call   80103280 <end_op>
8010590a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010590f:	eb 40                	jmp    80105951 <sys_open+0x121>
80105911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105918:	83 ec 0c             	sub    $0xc,%esp
8010591b:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
8010591f:	56                   	push   %esi
80105920:	e8 db c3 ff ff       	call   80101d00 <iunlock>
80105925:	e8 56 d9 ff ff       	call   80103280 <end_op>
8010592a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105930:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105933:	83 c4 10             	add    $0x10,%esp
80105936:	89 77 10             	mov    %esi,0x10(%edi)
80105939:	89 d0                	mov    %edx,%eax
8010593b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105942:	f7 d0                	not    %eax
80105944:	83 e0 01             	and    $0x1,%eax
80105947:	83 e2 03             	and    $0x3,%edx
8010594a:	88 47 08             	mov    %al,0x8(%edi)
8010594d:	0f 95 47 09          	setne  0x9(%edi)
80105951:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105954:	89 d8                	mov    %ebx,%eax
80105956:	5b                   	pop    %ebx
80105957:	5e                   	pop    %esi
80105958:	5f                   	pop    %edi
80105959:	5d                   	pop    %ebp
8010595a:	c3                   	ret    
8010595b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010595f:	90                   	nop
80105960:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105963:	85 c9                	test   %ecx,%ecx
80105965:	0f 84 33 ff ff ff    	je     8010589e <sys_open+0x6e>
8010596b:	e9 5c ff ff ff       	jmp    801058cc <sys_open+0x9c>

80105970 <sys_mkdir>:
80105970:	f3 0f 1e fb          	endbr32 
80105974:	55                   	push   %ebp
80105975:	89 e5                	mov    %esp,%ebp
80105977:	83 ec 18             	sub    $0x18,%esp
8010597a:	e8 91 d8 ff ff       	call   80103210 <begin_op>
8010597f:	83 ec 08             	sub    $0x8,%esp
80105982:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105985:	50                   	push   %eax
80105986:	6a 00                	push   $0x0
80105988:	e8 e3 f6 ff ff       	call   80105070 <argstr>
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	85 c0                	test   %eax,%eax
80105992:	78 34                	js     801059c8 <sys_mkdir+0x58>
80105994:	83 ec 0c             	sub    $0xc,%esp
80105997:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010599a:	31 c9                	xor    %ecx,%ecx
8010599c:	ba 01 00 00 00       	mov    $0x1,%edx
801059a1:	6a 00                	push   $0x0
801059a3:	e8 78 f7 ff ff       	call   80105120 <create>
801059a8:	83 c4 10             	add    $0x10,%esp
801059ab:	85 c0                	test   %eax,%eax
801059ad:	74 19                	je     801059c8 <sys_mkdir+0x58>
801059af:	83 ec 0c             	sub    $0xc,%esp
801059b2:	50                   	push   %eax
801059b3:	e8 08 c5 ff ff       	call   80101ec0 <iunlockput>
801059b8:	e8 c3 d8 ff ff       	call   80103280 <end_op>
801059bd:	83 c4 10             	add    $0x10,%esp
801059c0:	31 c0                	xor    %eax,%eax
801059c2:	c9                   	leave  
801059c3:	c3                   	ret    
801059c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059c8:	e8 b3 d8 ff ff       	call   80103280 <end_op>
801059cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801059d2:	c9                   	leave  
801059d3:	c3                   	ret    
801059d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801059db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801059df:	90                   	nop

801059e0 <sys_mknod>:
801059e0:	f3 0f 1e fb          	endbr32 
801059e4:	55                   	push   %ebp
801059e5:	89 e5                	mov    %esp,%ebp
801059e7:	83 ec 18             	sub    $0x18,%esp
801059ea:	e8 21 d8 ff ff       	call   80103210 <begin_op>
801059ef:	83 ec 08             	sub    $0x8,%esp
801059f2:	8d 45 ec             	lea    -0x14(%ebp),%eax
801059f5:	50                   	push   %eax
801059f6:	6a 00                	push   $0x0
801059f8:	e8 73 f6 ff ff       	call   80105070 <argstr>
801059fd:	83 c4 10             	add    $0x10,%esp
80105a00:	85 c0                	test   %eax,%eax
80105a02:	78 64                	js     80105a68 <sys_mknod+0x88>
80105a04:	83 ec 08             	sub    $0x8,%esp
80105a07:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105a0a:	50                   	push   %eax
80105a0b:	6a 01                	push   $0x1
80105a0d:	e8 ae f5 ff ff       	call   80104fc0 <argint>
80105a12:	83 c4 10             	add    $0x10,%esp
80105a15:	85 c0                	test   %eax,%eax
80105a17:	78 4f                	js     80105a68 <sys_mknod+0x88>
80105a19:	83 ec 08             	sub    $0x8,%esp
80105a1c:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a1f:	50                   	push   %eax
80105a20:	6a 02                	push   $0x2
80105a22:	e8 99 f5 ff ff       	call   80104fc0 <argint>
80105a27:	83 c4 10             	add    $0x10,%esp
80105a2a:	85 c0                	test   %eax,%eax
80105a2c:	78 3a                	js     80105a68 <sys_mknod+0x88>
80105a2e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105a32:	83 ec 0c             	sub    $0xc,%esp
80105a35:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105a39:	ba 03 00 00 00       	mov    $0x3,%edx
80105a3e:	50                   	push   %eax
80105a3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105a42:	e8 d9 f6 ff ff       	call   80105120 <create>
80105a47:	83 c4 10             	add    $0x10,%esp
80105a4a:	85 c0                	test   %eax,%eax
80105a4c:	74 1a                	je     80105a68 <sys_mknod+0x88>
80105a4e:	83 ec 0c             	sub    $0xc,%esp
80105a51:	50                   	push   %eax
80105a52:	e8 69 c4 ff ff       	call   80101ec0 <iunlockput>
80105a57:	e8 24 d8 ff ff       	call   80103280 <end_op>
80105a5c:	83 c4 10             	add    $0x10,%esp
80105a5f:	31 c0                	xor    %eax,%eax
80105a61:	c9                   	leave  
80105a62:	c3                   	ret    
80105a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a67:	90                   	nop
80105a68:	e8 13 d8 ff ff       	call   80103280 <end_op>
80105a6d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a72:	c9                   	leave  
80105a73:	c3                   	ret    
80105a74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a7f:	90                   	nop

80105a80 <sys_chdir>:
80105a80:	f3 0f 1e fb          	endbr32 
80105a84:	55                   	push   %ebp
80105a85:	89 e5                	mov    %esp,%ebp
80105a87:	56                   	push   %esi
80105a88:	53                   	push   %ebx
80105a89:	83 ec 10             	sub    $0x10,%esp
80105a8c:	e8 af e3 ff ff       	call   80103e40 <myproc>
80105a91:	89 c6                	mov    %eax,%esi
80105a93:	e8 78 d7 ff ff       	call   80103210 <begin_op>
80105a98:	83 ec 08             	sub    $0x8,%esp
80105a9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105a9e:	50                   	push   %eax
80105a9f:	6a 00                	push   $0x0
80105aa1:	e8 ca f5 ff ff       	call   80105070 <argstr>
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	85 c0                	test   %eax,%eax
80105aab:	78 73                	js     80105b20 <sys_chdir+0xa0>
80105aad:	83 ec 0c             	sub    $0xc,%esp
80105ab0:	ff 75 f4             	pushl  -0xc(%ebp)
80105ab3:	e8 38 ca ff ff       	call   801024f0 <namei>
80105ab8:	83 c4 10             	add    $0x10,%esp
80105abb:	89 c3                	mov    %eax,%ebx
80105abd:	85 c0                	test   %eax,%eax
80105abf:	74 5f                	je     80105b20 <sys_chdir+0xa0>
80105ac1:	83 ec 0c             	sub    $0xc,%esp
80105ac4:	50                   	push   %eax
80105ac5:	e8 56 c1 ff ff       	call   80101c20 <ilock>
80105aca:	83 c4 10             	add    $0x10,%esp
80105acd:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ad2:	75 2c                	jne    80105b00 <sys_chdir+0x80>
80105ad4:	83 ec 0c             	sub    $0xc,%esp
80105ad7:	53                   	push   %ebx
80105ad8:	e8 23 c2 ff ff       	call   80101d00 <iunlock>
80105add:	58                   	pop    %eax
80105ade:	ff 76 6c             	pushl  0x6c(%esi)
80105ae1:	e8 6a c2 ff ff       	call   80101d50 <iput>
80105ae6:	e8 95 d7 ff ff       	call   80103280 <end_op>
80105aeb:	89 5e 6c             	mov    %ebx,0x6c(%esi)
80105aee:	83 c4 10             	add    $0x10,%esp
80105af1:	31 c0                	xor    %eax,%eax
80105af3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105af6:	5b                   	pop    %ebx
80105af7:	5e                   	pop    %esi
80105af8:	5d                   	pop    %ebp
80105af9:	c3                   	ret    
80105afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	53                   	push   %ebx
80105b04:	e8 b7 c3 ff ff       	call   80101ec0 <iunlockput>
80105b09:	e8 72 d7 ff ff       	call   80103280 <end_op>
80105b0e:	83 c4 10             	add    $0x10,%esp
80105b11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b16:	eb db                	jmp    80105af3 <sys_chdir+0x73>
80105b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105b1f:	90                   	nop
80105b20:	e8 5b d7 ff ff       	call   80103280 <end_op>
80105b25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b2a:	eb c7                	jmp    80105af3 <sys_chdir+0x73>
80105b2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b30 <sys_exec>:
80105b30:	f3 0f 1e fb          	endbr32 
80105b34:	55                   	push   %ebp
80105b35:	89 e5                	mov    %esp,%ebp
80105b37:	57                   	push   %edi
80105b38:	56                   	push   %esi
80105b39:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105b3f:	53                   	push   %ebx
80105b40:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105b46:	50                   	push   %eax
80105b47:	6a 00                	push   $0x0
80105b49:	e8 22 f5 ff ff       	call   80105070 <argstr>
80105b4e:	83 c4 10             	add    $0x10,%esp
80105b51:	85 c0                	test   %eax,%eax
80105b53:	0f 88 8b 00 00 00    	js     80105be4 <sys_exec+0xb4>
80105b59:	83 ec 08             	sub    $0x8,%esp
80105b5c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105b62:	50                   	push   %eax
80105b63:	6a 01                	push   $0x1
80105b65:	e8 56 f4 ff ff       	call   80104fc0 <argint>
80105b6a:	83 c4 10             	add    $0x10,%esp
80105b6d:	85 c0                	test   %eax,%eax
80105b6f:	78 73                	js     80105be4 <sys_exec+0xb4>
80105b71:	83 ec 04             	sub    $0x4,%esp
80105b74:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105b7a:	31 db                	xor    %ebx,%ebx
80105b7c:	68 80 00 00 00       	push   $0x80
80105b81:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105b87:	6a 00                	push   $0x0
80105b89:	50                   	push   %eax
80105b8a:	e8 51 f1 ff ff       	call   80104ce0 <memset>
80105b8f:	83 c4 10             	add    $0x10,%esp
80105b92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105b98:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105b9e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105ba5:	83 ec 08             	sub    $0x8,%esp
80105ba8:	57                   	push   %edi
80105ba9:	01 f0                	add    %esi,%eax
80105bab:	50                   	push   %eax
80105bac:	e8 6f f3 ff ff       	call   80104f20 <fetchint>
80105bb1:	83 c4 10             	add    $0x10,%esp
80105bb4:	85 c0                	test   %eax,%eax
80105bb6:	78 2c                	js     80105be4 <sys_exec+0xb4>
80105bb8:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105bbe:	85 c0                	test   %eax,%eax
80105bc0:	74 36                	je     80105bf8 <sys_exec+0xc8>
80105bc2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105bc8:	83 ec 08             	sub    $0x8,%esp
80105bcb:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105bce:	52                   	push   %edx
80105bcf:	50                   	push   %eax
80105bd0:	e8 8b f3 ff ff       	call   80104f60 <fetchstr>
80105bd5:	83 c4 10             	add    $0x10,%esp
80105bd8:	85 c0                	test   %eax,%eax
80105bda:	78 08                	js     80105be4 <sys_exec+0xb4>
80105bdc:	83 c3 01             	add    $0x1,%ebx
80105bdf:	83 fb 20             	cmp    $0x20,%ebx
80105be2:	75 b4                	jne    80105b98 <sys_exec+0x68>
80105be4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105be7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bec:	5b                   	pop    %ebx
80105bed:	5e                   	pop    %esi
80105bee:	5f                   	pop    %edi
80105bef:	5d                   	pop    %ebp
80105bf0:	c3                   	ret    
80105bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105bf8:	83 ec 08             	sub    $0x8,%esp
80105bfb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105c01:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105c08:	00 00 00 00 
80105c0c:	50                   	push   %eax
80105c0d:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105c13:	e8 28 b3 ff ff       	call   80100f40 <exec>
80105c18:	83 c4 10             	add    $0x10,%esp
80105c1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c1e:	5b                   	pop    %ebx
80105c1f:	5e                   	pop    %esi
80105c20:	5f                   	pop    %edi
80105c21:	5d                   	pop    %ebp
80105c22:	c3                   	ret    
80105c23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c30 <sys_pipe>:
80105c30:	f3 0f 1e fb          	endbr32 
80105c34:	55                   	push   %ebp
80105c35:	89 e5                	mov    %esp,%ebp
80105c37:	57                   	push   %edi
80105c38:	56                   	push   %esi
80105c39:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105c3c:	53                   	push   %ebx
80105c3d:	83 ec 20             	sub    $0x20,%esp
80105c40:	6a 08                	push   $0x8
80105c42:	50                   	push   %eax
80105c43:	6a 00                	push   $0x0
80105c45:	e8 c6 f3 ff ff       	call   80105010 <argptr>
80105c4a:	83 c4 10             	add    $0x10,%esp
80105c4d:	85 c0                	test   %eax,%eax
80105c4f:	78 4e                	js     80105c9f <sys_pipe+0x6f>
80105c51:	83 ec 08             	sub    $0x8,%esp
80105c54:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105c57:	50                   	push   %eax
80105c58:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105c5b:	50                   	push   %eax
80105c5c:	e8 6f dc ff ff       	call   801038d0 <pipealloc>
80105c61:	83 c4 10             	add    $0x10,%esp
80105c64:	85 c0                	test   %eax,%eax
80105c66:	78 37                	js     80105c9f <sys_pipe+0x6f>
80105c68:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105c6b:	31 db                	xor    %ebx,%ebx
80105c6d:	e8 ce e1 ff ff       	call   80103e40 <myproc>
80105c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c78:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
80105c7c:	85 f6                	test   %esi,%esi
80105c7e:	74 30                	je     80105cb0 <sys_pipe+0x80>
80105c80:	83 c3 01             	add    $0x1,%ebx
80105c83:	83 fb 10             	cmp    $0x10,%ebx
80105c86:	75 f0                	jne    80105c78 <sys_pipe+0x48>
80105c88:	83 ec 0c             	sub    $0xc,%esp
80105c8b:	ff 75 e0             	pushl  -0x20(%ebp)
80105c8e:	e8 ed b6 ff ff       	call   80101380 <fileclose>
80105c93:	58                   	pop    %eax
80105c94:	ff 75 e4             	pushl  -0x1c(%ebp)
80105c97:	e8 e4 b6 ff ff       	call   80101380 <fileclose>
80105c9c:	83 c4 10             	add    $0x10,%esp
80105c9f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ca4:	eb 5b                	jmp    80105d01 <sys_pipe+0xd1>
80105ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cad:	8d 76 00             	lea    0x0(%esi),%esi
80105cb0:	8d 73 08             	lea    0x8(%ebx),%esi
80105cb3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
80105cb7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105cba:	e8 81 e1 ff ff       	call   80103e40 <myproc>
80105cbf:	31 d2                	xor    %edx,%edx
80105cc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cc8:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
80105ccc:	85 c9                	test   %ecx,%ecx
80105cce:	74 20                	je     80105cf0 <sys_pipe+0xc0>
80105cd0:	83 c2 01             	add    $0x1,%edx
80105cd3:	83 fa 10             	cmp    $0x10,%edx
80105cd6:	75 f0                	jne    80105cc8 <sys_pipe+0x98>
80105cd8:	e8 63 e1 ff ff       	call   80103e40 <myproc>
80105cdd:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
80105ce4:	00 
80105ce5:	eb a1                	jmp    80105c88 <sys_pipe+0x58>
80105ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cee:	66 90                	xchg   %ax,%ax
80105cf0:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
80105cf4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cf7:	89 18                	mov    %ebx,(%eax)
80105cf9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105cfc:	89 50 04             	mov    %edx,0x4(%eax)
80105cff:	31 c0                	xor    %eax,%eax
80105d01:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d04:	5b                   	pop    %ebx
80105d05:	5e                   	pop    %esi
80105d06:	5f                   	pop    %edi
80105d07:	5d                   	pop    %ebp
80105d08:	c3                   	ret    
80105d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d10 <sys_get_file_sectors>:
80105d10:	f3 0f 1e fb          	endbr32 
80105d14:	55                   	push   %ebp
80105d15:	89 e5                	mov    %esp,%ebp
80105d17:	57                   	push   %edi
80105d18:	56                   	push   %esi
80105d19:	8d 55 d8             	lea    -0x28(%ebp),%edx
80105d1c:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105d1f:	53                   	push   %ebx
80105d20:	83 ec 2c             	sub    $0x2c,%esp
80105d23:	e8 98 f5 ff ff       	call   801052c0 <argfd.constprop.0>
80105d28:	85 c0                	test   %eax,%eax
80105d2a:	0f 88 c0 00 00 00    	js     80105df0 <sys_get_file_sectors+0xe0>
80105d30:	83 ec 08             	sub    $0x8,%esp
80105d33:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d36:	50                   	push   %eax
80105d37:	6a 02                	push   $0x2
80105d39:	e8 82 f2 ff ff       	call   80104fc0 <argint>
80105d3e:	83 c4 10             	add    $0x10,%esp
80105d41:	85 c0                	test   %eax,%eax
80105d43:	0f 88 a7 00 00 00    	js     80105df0 <sys_get_file_sectors+0xe0>
80105d49:	83 ec 04             	sub    $0x4,%esp
80105d4c:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105d4f:	ff 75 e4             	pushl  -0x1c(%ebp)
80105d52:	50                   	push   %eax
80105d53:	6a 01                	push   $0x1
80105d55:	e8 b6 f2 ff ff       	call   80105010 <argptr>
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	85 c0                	test   %eax,%eax
80105d5f:	0f 88 8b 00 00 00    	js     80105df0 <sys_get_file_sectors+0xe0>
80105d65:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d68:	31 d2                	xor    %edx,%edx
80105d6a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80105d6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105d70:	8b 40 10             	mov    0x10(%eax),%eax
80105d73:	8b 70 58             	mov    0x58(%eax),%esi
80105d76:	f7 c6 ff 01 00 00    	test   $0x1ff,%esi
80105d7c:	0f 95 c2             	setne  %dl
80105d7f:	c1 ee 09             	shr    $0x9,%esi
80105d82:	01 d6                	add    %edx,%esi
80105d84:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105d87:	39 d6                	cmp    %edx,%esi
80105d89:	0f 4f f2             	cmovg  %edx,%esi
80105d8c:	85 f6                	test   %esi,%esi
80105d8e:	7e 37                	jle    80105dc7 <sys_get_file_sectors+0xb7>
80105d90:	31 db                	xor    %ebx,%ebx
80105d92:	eb 0a                	jmp    80105d9e <sys_get_file_sectors+0x8e>
80105d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d98:	8b 45 d8             	mov    -0x28(%ebp),%eax
80105d9b:	8b 40 10             	mov    0x10(%eax),%eax
80105d9e:	83 ec 08             	sub    $0x8,%esp
80105da1:	53                   	push   %ebx
80105da2:	50                   	push   %eax
80105da3:	e8 88 c7 ff ff       	call   80102530 <getbmap>
80105da8:	89 c7                	mov    %eax,%edi
80105daa:	58                   	pop    %eax
80105dab:	5a                   	pop    %edx
80105dac:	57                   	push   %edi
80105dad:	68 ed 80 10 80       	push   $0x801080ed
80105db2:	e8 f9 a8 ff ff       	call   801006b0 <cprintf>
80105db7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105dba:	83 c4 10             	add    $0x10,%esp
80105dbd:	89 3c 98             	mov    %edi,(%eax,%ebx,4)
80105dc0:	83 c3 01             	add    $0x1,%ebx
80105dc3:	39 de                	cmp    %ebx,%esi
80105dc5:	75 d1                	jne    80105d98 <sys_get_file_sectors+0x88>
80105dc7:	83 ec 0c             	sub    $0xc,%esp
80105dca:	68 cf 82 10 80       	push   $0x801082cf
80105dcf:	e8 dc a8 ff ff       	call   801006b0 <cprintf>
80105dd4:	83 c4 10             	add    $0x10,%esp
80105dd7:	31 c0                	xor    %eax,%eax
80105dd9:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80105ddc:	7e 0a                	jle    80105de8 <sys_get_file_sectors+0xd8>
80105dde:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80105de1:	c7 04 b1 ff ff ff ff 	movl   $0xffffffff,(%ecx,%esi,4)
80105de8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105deb:	5b                   	pop    %ebx
80105dec:	5e                   	pop    %esi
80105ded:	5f                   	pop    %edi
80105dee:	5d                   	pop    %ebp
80105def:	c3                   	ret    
80105df0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df5:	eb f1                	jmp    80105de8 <sys_get_file_sectors+0xd8>
80105df7:	66 90                	xchg   %ax,%ax
80105df9:	66 90                	xchg   %ax,%ax
80105dfb:	66 90                	xchg   %ax,%ax
80105dfd:	66 90                	xchg   %ax,%ax
80105dff:	90                   	nop

80105e00 <sys_fork>:
80105e00:	f3 0f 1e fb          	endbr32 
80105e04:	e9 e7 e1 ff ff       	jmp    80103ff0 <fork>
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_exit>:
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	83 ec 08             	sub    $0x8,%esp
80105e1a:	e8 61 e4 ff ff       	call   80104280 <exit>
80105e1f:	31 c0                	xor    %eax,%eax
80105e21:	c9                   	leave  
80105e22:	c3                   	ret    
80105e23:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105e30 <sys_wait>:
80105e30:	f3 0f 1e fb          	endbr32 
80105e34:	e9 97 e6 ff ff       	jmp    801044d0 <wait>
80105e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e40 <sys_wait_sleeping>:
80105e40:	f3 0f 1e fb          	endbr32 
80105e44:	e9 47 e9 ff ff       	jmp    80104790 <wait_sleeping>
80105e49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e50 <sys_set_proc_tracer>:
80105e50:	f3 0f 1e fb          	endbr32 
80105e54:	e9 f7 e9 ff ff       	jmp    80104850 <set_proc_tracer>
80105e59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e60 <sys_kill>:
80105e60:	f3 0f 1e fb          	endbr32 
80105e64:	55                   	push   %ebp
80105e65:	89 e5                	mov    %esp,%ebp
80105e67:	83 ec 20             	sub    $0x20,%esp
80105e6a:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e6d:	50                   	push   %eax
80105e6e:	6a 00                	push   $0x0
80105e70:	e8 4b f1 ff ff       	call   80104fc0 <argint>
80105e75:	83 c4 10             	add    $0x10,%esp
80105e78:	85 c0                	test   %eax,%eax
80105e7a:	78 14                	js     80105e90 <sys_kill+0x30>
80105e7c:	83 ec 0c             	sub    $0xc,%esp
80105e7f:	ff 75 f4             	pushl  -0xc(%ebp)
80105e82:	e8 a9 e7 ff ff       	call   80104630 <kill>
80105e87:	83 c4 10             	add    $0x10,%esp
80105e8a:	c9                   	leave  
80105e8b:	c3                   	ret    
80105e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e90:	c9                   	leave  
80105e91:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e96:	c3                   	ret    
80105e97:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e9e:	66 90                	xchg   %ax,%ax

80105ea0 <sys_calculate_sum_of_digits>:
80105ea0:	f3 0f 1e fb          	endbr32 
80105ea4:	55                   	push   %ebp
80105ea5:	89 e5                	mov    %esp,%ebp
80105ea7:	57                   	push   %edi
80105ea8:	56                   	push   %esi
80105ea9:	53                   	push   %ebx
80105eaa:	83 ec 0c             	sub    $0xc,%esp
80105ead:	e8 8e df ff ff       	call   80103e40 <myproc>
80105eb2:	ba 67 66 66 66       	mov    $0x66666667,%edx
80105eb7:	8b 40 1c             	mov    0x1c(%eax),%eax
80105eba:	8b 48 14             	mov    0x14(%eax),%ecx
80105ebd:	89 c8                	mov    %ecx,%eax
80105ebf:	f7 ea                	imul   %edx
80105ec1:	89 c8                	mov    %ecx,%eax
80105ec3:	c1 f8 1f             	sar    $0x1f,%eax
80105ec6:	c1 fa 02             	sar    $0x2,%edx
80105ec9:	89 d3                	mov    %edx,%ebx
80105ecb:	29 c3                	sub    %eax,%ebx
80105ecd:	8d 41 09             	lea    0x9(%ecx),%eax
80105ed0:	83 f8 12             	cmp    $0x12,%eax
80105ed3:	76 3e                	jbe    80105f13 <sys_calculate_sum_of_digits+0x73>
80105ed5:	31 f6                	xor    %esi,%esi
80105ed7:	bf 67 66 66 66       	mov    $0x66666667,%edi
80105edc:	eb 04                	jmp    80105ee2 <sys_calculate_sum_of_digits+0x42>
80105ede:	66 90                	xchg   %ax,%ax
80105ee0:	89 d3                	mov    %edx,%ebx
80105ee2:	89 c8                	mov    %ecx,%eax
80105ee4:	f7 ef                	imul   %edi
80105ee6:	89 c8                	mov    %ecx,%eax
80105ee8:	c1 f8 1f             	sar    $0x1f,%eax
80105eeb:	c1 fa 02             	sar    $0x2,%edx
80105eee:	29 c2                	sub    %eax,%edx
80105ef0:	8d 04 92             	lea    (%edx,%edx,4),%eax
80105ef3:	01 c0                	add    %eax,%eax
80105ef5:	29 c1                	sub    %eax,%ecx
80105ef7:	89 d8                	mov    %ebx,%eax
80105ef9:	f7 ef                	imul   %edi
80105efb:	89 d8                	mov    %ebx,%eax
80105efd:	01 ce                	add    %ecx,%esi
80105eff:	89 d9                	mov    %ebx,%ecx
80105f01:	c1 f8 1f             	sar    $0x1f,%eax
80105f04:	c1 fa 02             	sar    $0x2,%edx
80105f07:	29 c2                	sub    %eax,%edx
80105f09:	8d 43 09             	lea    0x9(%ebx),%eax
80105f0c:	83 f8 12             	cmp    $0x12,%eax
80105f0f:	77 cf                	ja     80105ee0 <sys_calculate_sum_of_digits+0x40>
80105f11:	01 f1                	add    %esi,%ecx
80105f13:	83 c4 0c             	add    $0xc,%esp
80105f16:	89 c8                	mov    %ecx,%eax
80105f18:	5b                   	pop    %ebx
80105f19:	5e                   	pop    %esi
80105f1a:	5f                   	pop    %edi
80105f1b:	5d                   	pop    %ebp
80105f1c:	c3                   	ret    
80105f1d:	8d 76 00             	lea    0x0(%esi),%esi

80105f20 <sys_getpid>:
80105f20:	f3 0f 1e fb          	endbr32 
80105f24:	55                   	push   %ebp
80105f25:	89 e5                	mov    %esp,%ebp
80105f27:	83 ec 08             	sub    $0x8,%esp
80105f2a:	e8 11 df ff ff       	call   80103e40 <myproc>
80105f2f:	8b 40 10             	mov    0x10(%eax),%eax
80105f32:	c9                   	leave  
80105f33:	c3                   	ret    
80105f34:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f3f:	90                   	nop

80105f40 <sys_sbrk>:
80105f40:	f3 0f 1e fb          	endbr32 
80105f44:	55                   	push   %ebp
80105f45:	89 e5                	mov    %esp,%ebp
80105f47:	53                   	push   %ebx
80105f48:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f4b:	83 ec 1c             	sub    $0x1c,%esp
80105f4e:	50                   	push   %eax
80105f4f:	6a 00                	push   $0x0
80105f51:	e8 6a f0 ff ff       	call   80104fc0 <argint>
80105f56:	83 c4 10             	add    $0x10,%esp
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	78 23                	js     80105f80 <sys_sbrk+0x40>
80105f5d:	e8 de de ff ff       	call   80103e40 <myproc>
80105f62:	83 ec 0c             	sub    $0xc,%esp
80105f65:	8b 18                	mov    (%eax),%ebx
80105f67:	ff 75 f4             	pushl  -0xc(%ebp)
80105f6a:	e8 01 e0 ff ff       	call   80103f70 <growproc>
80105f6f:	83 c4 10             	add    $0x10,%esp
80105f72:	85 c0                	test   %eax,%eax
80105f74:	78 0a                	js     80105f80 <sys_sbrk+0x40>
80105f76:	89 d8                	mov    %ebx,%eax
80105f78:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f7b:	c9                   	leave  
80105f7c:	c3                   	ret    
80105f7d:	8d 76 00             	lea    0x0(%esi),%esi
80105f80:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105f85:	eb ef                	jmp    80105f76 <sys_sbrk+0x36>
80105f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f8e:	66 90                	xchg   %ax,%ax

80105f90 <sys_sleep>:
80105f90:	f3 0f 1e fb          	endbr32 
80105f94:	55                   	push   %ebp
80105f95:	89 e5                	mov    %esp,%ebp
80105f97:	53                   	push   %ebx
80105f98:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f9b:	83 ec 1c             	sub    $0x1c,%esp
80105f9e:	50                   	push   %eax
80105f9f:	6a 00                	push   $0x0
80105fa1:	e8 1a f0 ff ff       	call   80104fc0 <argint>
80105fa6:	83 c4 10             	add    $0x10,%esp
80105fa9:	85 c0                	test   %eax,%eax
80105fab:	0f 88 86 00 00 00    	js     80106037 <sys_sleep+0xa7>
80105fb1:	83 ec 0c             	sub    $0xc,%esp
80105fb4:	68 80 5d 11 80       	push   $0x80115d80
80105fb9:	e8 12 ec ff ff       	call   80104bd0 <acquire>
80105fbe:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105fc1:	8b 1d c0 65 11 80    	mov    0x801165c0,%ebx
80105fc7:	83 c4 10             	add    $0x10,%esp
80105fca:	85 d2                	test   %edx,%edx
80105fcc:	75 23                	jne    80105ff1 <sys_sleep+0x61>
80105fce:	eb 50                	jmp    80106020 <sys_sleep+0x90>
80105fd0:	83 ec 08             	sub    $0x8,%esp
80105fd3:	68 80 5d 11 80       	push   $0x80115d80
80105fd8:	68 c0 65 11 80       	push   $0x801165c0
80105fdd:	e8 2e e4 ff ff       	call   80104410 <sleep>
80105fe2:	a1 c0 65 11 80       	mov    0x801165c0,%eax
80105fe7:	83 c4 10             	add    $0x10,%esp
80105fea:	29 d8                	sub    %ebx,%eax
80105fec:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105fef:	73 2f                	jae    80106020 <sys_sleep+0x90>
80105ff1:	e8 4a de ff ff       	call   80103e40 <myproc>
80105ff6:	8b 40 28             	mov    0x28(%eax),%eax
80105ff9:	85 c0                	test   %eax,%eax
80105ffb:	74 d3                	je     80105fd0 <sys_sleep+0x40>
80105ffd:	83 ec 0c             	sub    $0xc,%esp
80106000:	68 80 5d 11 80       	push   $0x80115d80
80106005:	e8 86 ec ff ff       	call   80104c90 <release>
8010600a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010600d:	83 c4 10             	add    $0x10,%esp
80106010:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106015:	c9                   	leave  
80106016:	c3                   	ret    
80106017:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010601e:	66 90                	xchg   %ax,%ax
80106020:	83 ec 0c             	sub    $0xc,%esp
80106023:	68 80 5d 11 80       	push   $0x80115d80
80106028:	e8 63 ec ff ff       	call   80104c90 <release>
8010602d:	83 c4 10             	add    $0x10,%esp
80106030:	31 c0                	xor    %eax,%eax
80106032:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106035:	c9                   	leave  
80106036:	c3                   	ret    
80106037:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010603c:	eb f4                	jmp    80106032 <sys_sleep+0xa2>
8010603e:	66 90                	xchg   %ax,%ax

80106040 <sys_uptime>:
80106040:	f3 0f 1e fb          	endbr32 
80106044:	55                   	push   %ebp
80106045:	89 e5                	mov    %esp,%ebp
80106047:	53                   	push   %ebx
80106048:	83 ec 10             	sub    $0x10,%esp
8010604b:	68 80 5d 11 80       	push   $0x80115d80
80106050:	e8 7b eb ff ff       	call   80104bd0 <acquire>
80106055:	8b 1d c0 65 11 80    	mov    0x801165c0,%ebx
8010605b:	c7 04 24 80 5d 11 80 	movl   $0x80115d80,(%esp)
80106062:	e8 29 ec ff ff       	call   80104c90 <release>
80106067:	89 d8                	mov    %ebx,%eax
80106069:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010606c:	c9                   	leave  
8010606d:	c3                   	ret    
8010606e:	66 90                	xchg   %ax,%ax

80106070 <sys_get_parent_pid>:
80106070:	f3 0f 1e fb          	endbr32 
80106074:	55                   	push   %ebp
80106075:	89 e5                	mov    %esp,%ebp
80106077:	83 ec 08             	sub    $0x8,%esp
8010607a:	e8 c1 dd ff ff       	call   80103e40 <myproc>
8010607f:	8b 40 14             	mov    0x14(%eax),%eax
80106082:	8b 40 10             	mov    0x10(%eax),%eax
80106085:	c9                   	leave  
80106086:	c3                   	ret    

80106087 <alltraps>:
80106087:	1e                   	push   %ds
80106088:	06                   	push   %es
80106089:	0f a0                	push   %fs
8010608b:	0f a8                	push   %gs
8010608d:	60                   	pusha  
8010608e:	66 b8 10 00          	mov    $0x10,%ax
80106092:	8e d8                	mov    %eax,%ds
80106094:	8e c0                	mov    %eax,%es
80106096:	54                   	push   %esp
80106097:	e8 c4 00 00 00       	call   80106160 <trap>
8010609c:	83 c4 04             	add    $0x4,%esp

8010609f <trapret>:
8010609f:	61                   	popa   
801060a0:	0f a9                	pop    %gs
801060a2:	0f a1                	pop    %fs
801060a4:	07                   	pop    %es
801060a5:	1f                   	pop    %ds
801060a6:	83 c4 08             	add    $0x8,%esp
801060a9:	cf                   	iret   
801060aa:	66 90                	xchg   %ax,%ax
801060ac:	66 90                	xchg   %ax,%ax
801060ae:	66 90                	xchg   %ax,%ax

801060b0 <tvinit>:
801060b0:	f3 0f 1e fb          	endbr32 
801060b4:	55                   	push   %ebp
801060b5:	31 c0                	xor    %eax,%eax
801060b7:	89 e5                	mov    %esp,%ebp
801060b9:	83 ec 08             	sub    $0x8,%esp
801060bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801060c0:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
801060c7:	c7 04 c5 c2 5d 11 80 	movl   $0x8e000008,-0x7feea23e(,%eax,8)
801060ce:	08 00 00 8e 
801060d2:	66 89 14 c5 c0 5d 11 	mov    %dx,-0x7feea240(,%eax,8)
801060d9:	80 
801060da:	c1 ea 10             	shr    $0x10,%edx
801060dd:	66 89 14 c5 c6 5d 11 	mov    %dx,-0x7feea23a(,%eax,8)
801060e4:	80 
801060e5:	83 c0 01             	add    $0x1,%eax
801060e8:	3d 00 01 00 00       	cmp    $0x100,%eax
801060ed:	75 d1                	jne    801060c0 <tvinit+0x10>
801060ef:	83 ec 08             	sub    $0x8,%esp
801060f2:	a1 08 b1 10 80       	mov    0x8010b108,%eax
801060f7:	c7 05 c2 5f 11 80 08 	movl   $0xef000008,0x80115fc2
801060fe:	00 00 ef 
80106101:	68 f1 80 10 80       	push   $0x801080f1
80106106:	68 80 5d 11 80       	push   $0x80115d80
8010610b:	66 a3 c0 5f 11 80    	mov    %ax,0x80115fc0
80106111:	c1 e8 10             	shr    $0x10,%eax
80106114:	66 a3 c6 5f 11 80    	mov    %ax,0x80115fc6
8010611a:	e8 31 e9 ff ff       	call   80104a50 <initlock>
8010611f:	83 c4 10             	add    $0x10,%esp
80106122:	c9                   	leave  
80106123:	c3                   	ret    
80106124:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010612b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010612f:	90                   	nop

80106130 <idtinit>:
80106130:	f3 0f 1e fb          	endbr32 
80106134:	55                   	push   %ebp
80106135:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010613a:	89 e5                	mov    %esp,%ebp
8010613c:	83 ec 10             	sub    $0x10,%esp
8010613f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80106143:	b8 c0 5d 11 80       	mov    $0x80115dc0,%eax
80106148:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010614c:	c1 e8 10             	shr    $0x10,%eax
8010614f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80106153:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106156:	0f 01 18             	lidtl  (%eax)
80106159:	c9                   	leave  
8010615a:	c3                   	ret    
8010615b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010615f:	90                   	nop

80106160 <trap>:
80106160:	f3 0f 1e fb          	endbr32 
80106164:	55                   	push   %ebp
80106165:	89 e5                	mov    %esp,%ebp
80106167:	57                   	push   %edi
80106168:	56                   	push   %esi
80106169:	53                   	push   %ebx
8010616a:	83 ec 1c             	sub    $0x1c,%esp
8010616d:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106170:	8b 43 30             	mov    0x30(%ebx),%eax
80106173:	83 f8 40             	cmp    $0x40,%eax
80106176:	0f 84 bc 01 00 00    	je     80106338 <trap+0x1d8>
8010617c:	83 e8 20             	sub    $0x20,%eax
8010617f:	83 f8 1f             	cmp    $0x1f,%eax
80106182:	77 08                	ja     8010618c <trap+0x2c>
80106184:	3e ff 24 85 98 81 10 	notrack jmp *-0x7fef7e68(,%eax,4)
8010618b:	80 
8010618c:	e8 af dc ff ff       	call   80103e40 <myproc>
80106191:	8b 7b 38             	mov    0x38(%ebx),%edi
80106194:	85 c0                	test   %eax,%eax
80106196:	0f 84 eb 01 00 00    	je     80106387 <trap+0x227>
8010619c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801061a0:	0f 84 e1 01 00 00    	je     80106387 <trap+0x227>
801061a6:	0f 20 d1             	mov    %cr2,%ecx
801061a9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
801061ac:	e8 6f dc ff ff       	call   80103e20 <cpuid>
801061b1:	8b 73 30             	mov    0x30(%ebx),%esi
801061b4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801061b7:	8b 43 34             	mov    0x34(%ebx),%eax
801061ba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801061bd:	e8 7e dc ff ff       	call   80103e40 <myproc>
801061c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801061c5:	e8 76 dc ff ff       	call   80103e40 <myproc>
801061ca:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801061cd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801061d0:	51                   	push   %ecx
801061d1:	57                   	push   %edi
801061d2:	52                   	push   %edx
801061d3:	ff 75 e4             	pushl  -0x1c(%ebp)
801061d6:	56                   	push   %esi
801061d7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801061da:	83 c6 70             	add    $0x70,%esi
801061dd:	56                   	push   %esi
801061de:	ff 70 10             	pushl  0x10(%eax)
801061e1:	68 54 81 10 80       	push   $0x80108154
801061e6:	e8 c5 a4 ff ff       	call   801006b0 <cprintf>
801061eb:	83 c4 20             	add    $0x20,%esp
801061ee:	e8 4d dc ff ff       	call   80103e40 <myproc>
801061f3:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
801061fa:	e8 41 dc ff ff       	call   80103e40 <myproc>
801061ff:	85 c0                	test   %eax,%eax
80106201:	74 1d                	je     80106220 <trap+0xc0>
80106203:	e8 38 dc ff ff       	call   80103e40 <myproc>
80106208:	8b 50 28             	mov    0x28(%eax),%edx
8010620b:	85 d2                	test   %edx,%edx
8010620d:	74 11                	je     80106220 <trap+0xc0>
8010620f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106213:	83 e0 03             	and    $0x3,%eax
80106216:	66 83 f8 03          	cmp    $0x3,%ax
8010621a:	0f 84 50 01 00 00    	je     80106370 <trap+0x210>
80106220:	e8 1b dc ff ff       	call   80103e40 <myproc>
80106225:	85 c0                	test   %eax,%eax
80106227:	74 0f                	je     80106238 <trap+0xd8>
80106229:	e8 12 dc ff ff       	call   80103e40 <myproc>
8010622e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106232:	0f 84 e8 00 00 00    	je     80106320 <trap+0x1c0>
80106238:	e8 03 dc ff ff       	call   80103e40 <myproc>
8010623d:	85 c0                	test   %eax,%eax
8010623f:	74 1d                	je     8010625e <trap+0xfe>
80106241:	e8 fa db ff ff       	call   80103e40 <myproc>
80106246:	8b 40 28             	mov    0x28(%eax),%eax
80106249:	85 c0                	test   %eax,%eax
8010624b:	74 11                	je     8010625e <trap+0xfe>
8010624d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106251:	83 e0 03             	and    $0x3,%eax
80106254:	66 83 f8 03          	cmp    $0x3,%ax
80106258:	0f 84 03 01 00 00    	je     80106361 <trap+0x201>
8010625e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106261:	5b                   	pop    %ebx
80106262:	5e                   	pop    %esi
80106263:	5f                   	pop    %edi
80106264:	5d                   	pop    %ebp
80106265:	c3                   	ret    
80106266:	e8 55 c4 ff ff       	call   801026c0 <ideintr>
8010626b:	e8 30 cb ff ff       	call   80102da0 <lapiceoi>
80106270:	e8 cb db ff ff       	call   80103e40 <myproc>
80106275:	85 c0                	test   %eax,%eax
80106277:	75 8a                	jne    80106203 <trap+0xa3>
80106279:	eb a5                	jmp    80106220 <trap+0xc0>
8010627b:	e8 a0 db ff ff       	call   80103e20 <cpuid>
80106280:	85 c0                	test   %eax,%eax
80106282:	75 e7                	jne    8010626b <trap+0x10b>
80106284:	83 ec 0c             	sub    $0xc,%esp
80106287:	68 80 5d 11 80       	push   $0x80115d80
8010628c:	e8 3f e9 ff ff       	call   80104bd0 <acquire>
80106291:	c7 04 24 c0 65 11 80 	movl   $0x801165c0,(%esp)
80106298:	83 05 c0 65 11 80 01 	addl   $0x1,0x801165c0
8010629f:	e8 2c e3 ff ff       	call   801045d0 <wakeup>
801062a4:	c7 04 24 80 5d 11 80 	movl   $0x80115d80,(%esp)
801062ab:	e8 e0 e9 ff ff       	call   80104c90 <release>
801062b0:	83 c4 10             	add    $0x10,%esp
801062b3:	eb b6                	jmp    8010626b <trap+0x10b>
801062b5:	e8 a6 c9 ff ff       	call   80102c60 <kbdintr>
801062ba:	e8 e1 ca ff ff       	call   80102da0 <lapiceoi>
801062bf:	e8 7c db ff ff       	call   80103e40 <myproc>
801062c4:	85 c0                	test   %eax,%eax
801062c6:	0f 85 37 ff ff ff    	jne    80106203 <trap+0xa3>
801062cc:	e9 4f ff ff ff       	jmp    80106220 <trap+0xc0>
801062d1:	e8 4a 02 00 00       	call   80106520 <uartintr>
801062d6:	e8 c5 ca ff ff       	call   80102da0 <lapiceoi>
801062db:	e8 60 db ff ff       	call   80103e40 <myproc>
801062e0:	85 c0                	test   %eax,%eax
801062e2:	0f 85 1b ff ff ff    	jne    80106203 <trap+0xa3>
801062e8:	e9 33 ff ff ff       	jmp    80106220 <trap+0xc0>
801062ed:	8b 7b 38             	mov    0x38(%ebx),%edi
801062f0:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801062f4:	e8 27 db ff ff       	call   80103e20 <cpuid>
801062f9:	57                   	push   %edi
801062fa:	56                   	push   %esi
801062fb:	50                   	push   %eax
801062fc:	68 fc 80 10 80       	push   $0x801080fc
80106301:	e8 aa a3 ff ff       	call   801006b0 <cprintf>
80106306:	e8 95 ca ff ff       	call   80102da0 <lapiceoi>
8010630b:	83 c4 10             	add    $0x10,%esp
8010630e:	e8 2d db ff ff       	call   80103e40 <myproc>
80106313:	85 c0                	test   %eax,%eax
80106315:	0f 85 e8 fe ff ff    	jne    80106203 <trap+0xa3>
8010631b:	e9 00 ff ff ff       	jmp    80106220 <trap+0xc0>
80106320:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106324:	0f 85 0e ff ff ff    	jne    80106238 <trap+0xd8>
8010632a:	e8 91 e0 ff ff       	call   801043c0 <yield>
8010632f:	e9 04 ff ff ff       	jmp    80106238 <trap+0xd8>
80106334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106338:	e8 03 db ff ff       	call   80103e40 <myproc>
8010633d:	8b 70 28             	mov    0x28(%eax),%esi
80106340:	85 f6                	test   %esi,%esi
80106342:	75 3c                	jne    80106380 <trap+0x220>
80106344:	e8 f7 da ff ff       	call   80103e40 <myproc>
80106349:	89 58 1c             	mov    %ebx,0x1c(%eax)
8010634c:	e8 5f ed ff ff       	call   801050b0 <syscall>
80106351:	e8 ea da ff ff       	call   80103e40 <myproc>
80106356:	8b 48 28             	mov    0x28(%eax),%ecx
80106359:	85 c9                	test   %ecx,%ecx
8010635b:	0f 84 fd fe ff ff    	je     8010625e <trap+0xfe>
80106361:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106364:	5b                   	pop    %ebx
80106365:	5e                   	pop    %esi
80106366:	5f                   	pop    %edi
80106367:	5d                   	pop    %ebp
80106368:	e9 13 df ff ff       	jmp    80104280 <exit>
8010636d:	8d 76 00             	lea    0x0(%esi),%esi
80106370:	e8 0b df ff ff       	call   80104280 <exit>
80106375:	e9 a6 fe ff ff       	jmp    80106220 <trap+0xc0>
8010637a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106380:	e8 fb de ff ff       	call   80104280 <exit>
80106385:	eb bd                	jmp    80106344 <trap+0x1e4>
80106387:	0f 20 d6             	mov    %cr2,%esi
8010638a:	e8 91 da ff ff       	call   80103e20 <cpuid>
8010638f:	83 ec 0c             	sub    $0xc,%esp
80106392:	56                   	push   %esi
80106393:	57                   	push   %edi
80106394:	50                   	push   %eax
80106395:	ff 73 30             	pushl  0x30(%ebx)
80106398:	68 20 81 10 80       	push   $0x80108120
8010639d:	e8 0e a3 ff ff       	call   801006b0 <cprintf>
801063a2:	83 c4 14             	add    $0x14,%esp
801063a5:	68 f6 80 10 80       	push   $0x801080f6
801063aa:	e8 e1 9f ff ff       	call   80100390 <panic>
801063af:	90                   	nop

801063b0 <uartgetc>:
801063b0:	f3 0f 1e fb          	endbr32 
801063b4:	a1 dc b5 10 80       	mov    0x8010b5dc,%eax
801063b9:	85 c0                	test   %eax,%eax
801063bb:	74 1b                	je     801063d8 <uartgetc+0x28>
801063bd:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063c2:	ec                   	in     (%dx),%al
801063c3:	a8 01                	test   $0x1,%al
801063c5:	74 11                	je     801063d8 <uartgetc+0x28>
801063c7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063cc:	ec                   	in     (%dx),%al
801063cd:	0f b6 c0             	movzbl %al,%eax
801063d0:	c3                   	ret    
801063d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801063dd:	c3                   	ret    
801063de:	66 90                	xchg   %ax,%ax

801063e0 <uartputc.part.0>:
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	57                   	push   %edi
801063e4:	89 c7                	mov    %eax,%edi
801063e6:	56                   	push   %esi
801063e7:	be fd 03 00 00       	mov    $0x3fd,%esi
801063ec:	53                   	push   %ebx
801063ed:	bb 80 00 00 00       	mov    $0x80,%ebx
801063f2:	83 ec 0c             	sub    $0xc,%esp
801063f5:	eb 1b                	jmp    80106412 <uartputc.part.0+0x32>
801063f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063fe:	66 90                	xchg   %ax,%ax
80106400:	83 ec 0c             	sub    $0xc,%esp
80106403:	6a 0a                	push   $0xa
80106405:	e8 b6 c9 ff ff       	call   80102dc0 <microdelay>
8010640a:	83 c4 10             	add    $0x10,%esp
8010640d:	83 eb 01             	sub    $0x1,%ebx
80106410:	74 07                	je     80106419 <uartputc.part.0+0x39>
80106412:	89 f2                	mov    %esi,%edx
80106414:	ec                   	in     (%dx),%al
80106415:	a8 20                	test   $0x20,%al
80106417:	74 e7                	je     80106400 <uartputc.part.0+0x20>
80106419:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010641e:	89 f8                	mov    %edi,%eax
80106420:	ee                   	out    %al,(%dx)
80106421:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106424:	5b                   	pop    %ebx
80106425:	5e                   	pop    %esi
80106426:	5f                   	pop    %edi
80106427:	5d                   	pop    %ebp
80106428:	c3                   	ret    
80106429:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106430 <uartinit>:
80106430:	f3 0f 1e fb          	endbr32 
80106434:	55                   	push   %ebp
80106435:	31 c9                	xor    %ecx,%ecx
80106437:	89 c8                	mov    %ecx,%eax
80106439:	89 e5                	mov    %esp,%ebp
8010643b:	57                   	push   %edi
8010643c:	56                   	push   %esi
8010643d:	53                   	push   %ebx
8010643e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106443:	89 da                	mov    %ebx,%edx
80106445:	83 ec 0c             	sub    $0xc,%esp
80106448:	ee                   	out    %al,(%dx)
80106449:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010644e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106453:	89 fa                	mov    %edi,%edx
80106455:	ee                   	out    %al,(%dx)
80106456:	b8 0c 00 00 00       	mov    $0xc,%eax
8010645b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106460:	ee                   	out    %al,(%dx)
80106461:	be f9 03 00 00       	mov    $0x3f9,%esi
80106466:	89 c8                	mov    %ecx,%eax
80106468:	89 f2                	mov    %esi,%edx
8010646a:	ee                   	out    %al,(%dx)
8010646b:	b8 03 00 00 00       	mov    $0x3,%eax
80106470:	89 fa                	mov    %edi,%edx
80106472:	ee                   	out    %al,(%dx)
80106473:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106478:	89 c8                	mov    %ecx,%eax
8010647a:	ee                   	out    %al,(%dx)
8010647b:	b8 01 00 00 00       	mov    $0x1,%eax
80106480:	89 f2                	mov    %esi,%edx
80106482:	ee                   	out    %al,(%dx)
80106483:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106488:	ec                   	in     (%dx),%al
80106489:	3c ff                	cmp    $0xff,%al
8010648b:	74 52                	je     801064df <uartinit+0xaf>
8010648d:	c7 05 dc b5 10 80 01 	movl   $0x1,0x8010b5dc
80106494:	00 00 00 
80106497:	89 da                	mov    %ebx,%edx
80106499:	ec                   	in     (%dx),%al
8010649a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010649f:	ec                   	in     (%dx),%al
801064a0:	83 ec 08             	sub    $0x8,%esp
801064a3:	be 76 00 00 00       	mov    $0x76,%esi
801064a8:	bb 18 82 10 80       	mov    $0x80108218,%ebx
801064ad:	6a 00                	push   $0x0
801064af:	6a 04                	push   $0x4
801064b1:	e8 5a c4 ff ff       	call   80102910 <ioapicenable>
801064b6:	83 c4 10             	add    $0x10,%esp
801064b9:	b8 78 00 00 00       	mov    $0x78,%eax
801064be:	eb 04                	jmp    801064c4 <uartinit+0x94>
801064c0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
801064c4:	8b 15 dc b5 10 80    	mov    0x8010b5dc,%edx
801064ca:	85 d2                	test   %edx,%edx
801064cc:	74 08                	je     801064d6 <uartinit+0xa6>
801064ce:	0f be c0             	movsbl %al,%eax
801064d1:	e8 0a ff ff ff       	call   801063e0 <uartputc.part.0>
801064d6:	89 f0                	mov    %esi,%eax
801064d8:	83 c3 01             	add    $0x1,%ebx
801064db:	84 c0                	test   %al,%al
801064dd:	75 e1                	jne    801064c0 <uartinit+0x90>
801064df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064e2:	5b                   	pop    %ebx
801064e3:	5e                   	pop    %esi
801064e4:	5f                   	pop    %edi
801064e5:	5d                   	pop    %ebp
801064e6:	c3                   	ret    
801064e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064ee:	66 90                	xchg   %ax,%ax

801064f0 <uartputc>:
801064f0:	f3 0f 1e fb          	endbr32 
801064f4:	55                   	push   %ebp
801064f5:	8b 15 dc b5 10 80    	mov    0x8010b5dc,%edx
801064fb:	89 e5                	mov    %esp,%ebp
801064fd:	8b 45 08             	mov    0x8(%ebp),%eax
80106500:	85 d2                	test   %edx,%edx
80106502:	74 0c                	je     80106510 <uartputc+0x20>
80106504:	5d                   	pop    %ebp
80106505:	e9 d6 fe ff ff       	jmp    801063e0 <uartputc.part.0>
8010650a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106510:	5d                   	pop    %ebp
80106511:	c3                   	ret    
80106512:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106520 <uartintr>:
80106520:	f3 0f 1e fb          	endbr32 
80106524:	55                   	push   %ebp
80106525:	89 e5                	mov    %esp,%ebp
80106527:	83 ec 14             	sub    $0x14,%esp
8010652a:	68 b0 63 10 80       	push   $0x801063b0
8010652f:	e8 2c a6 ff ff       	call   80100b60 <consoleintr>
80106534:	83 c4 10             	add    $0x10,%esp
80106537:	c9                   	leave  
80106538:	c3                   	ret    

80106539 <vector0>:
80106539:	6a 00                	push   $0x0
8010653b:	6a 00                	push   $0x0
8010653d:	e9 45 fb ff ff       	jmp    80106087 <alltraps>

80106542 <vector1>:
80106542:	6a 00                	push   $0x0
80106544:	6a 01                	push   $0x1
80106546:	e9 3c fb ff ff       	jmp    80106087 <alltraps>

8010654b <vector2>:
8010654b:	6a 00                	push   $0x0
8010654d:	6a 02                	push   $0x2
8010654f:	e9 33 fb ff ff       	jmp    80106087 <alltraps>

80106554 <vector3>:
80106554:	6a 00                	push   $0x0
80106556:	6a 03                	push   $0x3
80106558:	e9 2a fb ff ff       	jmp    80106087 <alltraps>

8010655d <vector4>:
8010655d:	6a 00                	push   $0x0
8010655f:	6a 04                	push   $0x4
80106561:	e9 21 fb ff ff       	jmp    80106087 <alltraps>

80106566 <vector5>:
80106566:	6a 00                	push   $0x0
80106568:	6a 05                	push   $0x5
8010656a:	e9 18 fb ff ff       	jmp    80106087 <alltraps>

8010656f <vector6>:
8010656f:	6a 00                	push   $0x0
80106571:	6a 06                	push   $0x6
80106573:	e9 0f fb ff ff       	jmp    80106087 <alltraps>

80106578 <vector7>:
80106578:	6a 00                	push   $0x0
8010657a:	6a 07                	push   $0x7
8010657c:	e9 06 fb ff ff       	jmp    80106087 <alltraps>

80106581 <vector8>:
80106581:	6a 08                	push   $0x8
80106583:	e9 ff fa ff ff       	jmp    80106087 <alltraps>

80106588 <vector9>:
80106588:	6a 00                	push   $0x0
8010658a:	6a 09                	push   $0x9
8010658c:	e9 f6 fa ff ff       	jmp    80106087 <alltraps>

80106591 <vector10>:
80106591:	6a 0a                	push   $0xa
80106593:	e9 ef fa ff ff       	jmp    80106087 <alltraps>

80106598 <vector11>:
80106598:	6a 0b                	push   $0xb
8010659a:	e9 e8 fa ff ff       	jmp    80106087 <alltraps>

8010659f <vector12>:
8010659f:	6a 0c                	push   $0xc
801065a1:	e9 e1 fa ff ff       	jmp    80106087 <alltraps>

801065a6 <vector13>:
801065a6:	6a 0d                	push   $0xd
801065a8:	e9 da fa ff ff       	jmp    80106087 <alltraps>

801065ad <vector14>:
801065ad:	6a 0e                	push   $0xe
801065af:	e9 d3 fa ff ff       	jmp    80106087 <alltraps>

801065b4 <vector15>:
801065b4:	6a 00                	push   $0x0
801065b6:	6a 0f                	push   $0xf
801065b8:	e9 ca fa ff ff       	jmp    80106087 <alltraps>

801065bd <vector16>:
801065bd:	6a 00                	push   $0x0
801065bf:	6a 10                	push   $0x10
801065c1:	e9 c1 fa ff ff       	jmp    80106087 <alltraps>

801065c6 <vector17>:
801065c6:	6a 11                	push   $0x11
801065c8:	e9 ba fa ff ff       	jmp    80106087 <alltraps>

801065cd <vector18>:
801065cd:	6a 00                	push   $0x0
801065cf:	6a 12                	push   $0x12
801065d1:	e9 b1 fa ff ff       	jmp    80106087 <alltraps>

801065d6 <vector19>:
801065d6:	6a 00                	push   $0x0
801065d8:	6a 13                	push   $0x13
801065da:	e9 a8 fa ff ff       	jmp    80106087 <alltraps>

801065df <vector20>:
801065df:	6a 00                	push   $0x0
801065e1:	6a 14                	push   $0x14
801065e3:	e9 9f fa ff ff       	jmp    80106087 <alltraps>

801065e8 <vector21>:
801065e8:	6a 00                	push   $0x0
801065ea:	6a 15                	push   $0x15
801065ec:	e9 96 fa ff ff       	jmp    80106087 <alltraps>

801065f1 <vector22>:
801065f1:	6a 00                	push   $0x0
801065f3:	6a 16                	push   $0x16
801065f5:	e9 8d fa ff ff       	jmp    80106087 <alltraps>

801065fa <vector23>:
801065fa:	6a 00                	push   $0x0
801065fc:	6a 17                	push   $0x17
801065fe:	e9 84 fa ff ff       	jmp    80106087 <alltraps>

80106603 <vector24>:
80106603:	6a 00                	push   $0x0
80106605:	6a 18                	push   $0x18
80106607:	e9 7b fa ff ff       	jmp    80106087 <alltraps>

8010660c <vector25>:
8010660c:	6a 00                	push   $0x0
8010660e:	6a 19                	push   $0x19
80106610:	e9 72 fa ff ff       	jmp    80106087 <alltraps>

80106615 <vector26>:
80106615:	6a 00                	push   $0x0
80106617:	6a 1a                	push   $0x1a
80106619:	e9 69 fa ff ff       	jmp    80106087 <alltraps>

8010661e <vector27>:
8010661e:	6a 00                	push   $0x0
80106620:	6a 1b                	push   $0x1b
80106622:	e9 60 fa ff ff       	jmp    80106087 <alltraps>

80106627 <vector28>:
80106627:	6a 00                	push   $0x0
80106629:	6a 1c                	push   $0x1c
8010662b:	e9 57 fa ff ff       	jmp    80106087 <alltraps>

80106630 <vector29>:
80106630:	6a 00                	push   $0x0
80106632:	6a 1d                	push   $0x1d
80106634:	e9 4e fa ff ff       	jmp    80106087 <alltraps>

80106639 <vector30>:
80106639:	6a 00                	push   $0x0
8010663b:	6a 1e                	push   $0x1e
8010663d:	e9 45 fa ff ff       	jmp    80106087 <alltraps>

80106642 <vector31>:
80106642:	6a 00                	push   $0x0
80106644:	6a 1f                	push   $0x1f
80106646:	e9 3c fa ff ff       	jmp    80106087 <alltraps>

8010664b <vector32>:
8010664b:	6a 00                	push   $0x0
8010664d:	6a 20                	push   $0x20
8010664f:	e9 33 fa ff ff       	jmp    80106087 <alltraps>

80106654 <vector33>:
80106654:	6a 00                	push   $0x0
80106656:	6a 21                	push   $0x21
80106658:	e9 2a fa ff ff       	jmp    80106087 <alltraps>

8010665d <vector34>:
8010665d:	6a 00                	push   $0x0
8010665f:	6a 22                	push   $0x22
80106661:	e9 21 fa ff ff       	jmp    80106087 <alltraps>

80106666 <vector35>:
80106666:	6a 00                	push   $0x0
80106668:	6a 23                	push   $0x23
8010666a:	e9 18 fa ff ff       	jmp    80106087 <alltraps>

8010666f <vector36>:
8010666f:	6a 00                	push   $0x0
80106671:	6a 24                	push   $0x24
80106673:	e9 0f fa ff ff       	jmp    80106087 <alltraps>

80106678 <vector37>:
80106678:	6a 00                	push   $0x0
8010667a:	6a 25                	push   $0x25
8010667c:	e9 06 fa ff ff       	jmp    80106087 <alltraps>

80106681 <vector38>:
80106681:	6a 00                	push   $0x0
80106683:	6a 26                	push   $0x26
80106685:	e9 fd f9 ff ff       	jmp    80106087 <alltraps>

8010668a <vector39>:
8010668a:	6a 00                	push   $0x0
8010668c:	6a 27                	push   $0x27
8010668e:	e9 f4 f9 ff ff       	jmp    80106087 <alltraps>

80106693 <vector40>:
80106693:	6a 00                	push   $0x0
80106695:	6a 28                	push   $0x28
80106697:	e9 eb f9 ff ff       	jmp    80106087 <alltraps>

8010669c <vector41>:
8010669c:	6a 00                	push   $0x0
8010669e:	6a 29                	push   $0x29
801066a0:	e9 e2 f9 ff ff       	jmp    80106087 <alltraps>

801066a5 <vector42>:
801066a5:	6a 00                	push   $0x0
801066a7:	6a 2a                	push   $0x2a
801066a9:	e9 d9 f9 ff ff       	jmp    80106087 <alltraps>

801066ae <vector43>:
801066ae:	6a 00                	push   $0x0
801066b0:	6a 2b                	push   $0x2b
801066b2:	e9 d0 f9 ff ff       	jmp    80106087 <alltraps>

801066b7 <vector44>:
801066b7:	6a 00                	push   $0x0
801066b9:	6a 2c                	push   $0x2c
801066bb:	e9 c7 f9 ff ff       	jmp    80106087 <alltraps>

801066c0 <vector45>:
801066c0:	6a 00                	push   $0x0
801066c2:	6a 2d                	push   $0x2d
801066c4:	e9 be f9 ff ff       	jmp    80106087 <alltraps>

801066c9 <vector46>:
801066c9:	6a 00                	push   $0x0
801066cb:	6a 2e                	push   $0x2e
801066cd:	e9 b5 f9 ff ff       	jmp    80106087 <alltraps>

801066d2 <vector47>:
801066d2:	6a 00                	push   $0x0
801066d4:	6a 2f                	push   $0x2f
801066d6:	e9 ac f9 ff ff       	jmp    80106087 <alltraps>

801066db <vector48>:
801066db:	6a 00                	push   $0x0
801066dd:	6a 30                	push   $0x30
801066df:	e9 a3 f9 ff ff       	jmp    80106087 <alltraps>

801066e4 <vector49>:
801066e4:	6a 00                	push   $0x0
801066e6:	6a 31                	push   $0x31
801066e8:	e9 9a f9 ff ff       	jmp    80106087 <alltraps>

801066ed <vector50>:
801066ed:	6a 00                	push   $0x0
801066ef:	6a 32                	push   $0x32
801066f1:	e9 91 f9 ff ff       	jmp    80106087 <alltraps>

801066f6 <vector51>:
801066f6:	6a 00                	push   $0x0
801066f8:	6a 33                	push   $0x33
801066fa:	e9 88 f9 ff ff       	jmp    80106087 <alltraps>

801066ff <vector52>:
801066ff:	6a 00                	push   $0x0
80106701:	6a 34                	push   $0x34
80106703:	e9 7f f9 ff ff       	jmp    80106087 <alltraps>

80106708 <vector53>:
80106708:	6a 00                	push   $0x0
8010670a:	6a 35                	push   $0x35
8010670c:	e9 76 f9 ff ff       	jmp    80106087 <alltraps>

80106711 <vector54>:
80106711:	6a 00                	push   $0x0
80106713:	6a 36                	push   $0x36
80106715:	e9 6d f9 ff ff       	jmp    80106087 <alltraps>

8010671a <vector55>:
8010671a:	6a 00                	push   $0x0
8010671c:	6a 37                	push   $0x37
8010671e:	e9 64 f9 ff ff       	jmp    80106087 <alltraps>

80106723 <vector56>:
80106723:	6a 00                	push   $0x0
80106725:	6a 38                	push   $0x38
80106727:	e9 5b f9 ff ff       	jmp    80106087 <alltraps>

8010672c <vector57>:
8010672c:	6a 00                	push   $0x0
8010672e:	6a 39                	push   $0x39
80106730:	e9 52 f9 ff ff       	jmp    80106087 <alltraps>

80106735 <vector58>:
80106735:	6a 00                	push   $0x0
80106737:	6a 3a                	push   $0x3a
80106739:	e9 49 f9 ff ff       	jmp    80106087 <alltraps>

8010673e <vector59>:
8010673e:	6a 00                	push   $0x0
80106740:	6a 3b                	push   $0x3b
80106742:	e9 40 f9 ff ff       	jmp    80106087 <alltraps>

80106747 <vector60>:
80106747:	6a 00                	push   $0x0
80106749:	6a 3c                	push   $0x3c
8010674b:	e9 37 f9 ff ff       	jmp    80106087 <alltraps>

80106750 <vector61>:
80106750:	6a 00                	push   $0x0
80106752:	6a 3d                	push   $0x3d
80106754:	e9 2e f9 ff ff       	jmp    80106087 <alltraps>

80106759 <vector62>:
80106759:	6a 00                	push   $0x0
8010675b:	6a 3e                	push   $0x3e
8010675d:	e9 25 f9 ff ff       	jmp    80106087 <alltraps>

80106762 <vector63>:
80106762:	6a 00                	push   $0x0
80106764:	6a 3f                	push   $0x3f
80106766:	e9 1c f9 ff ff       	jmp    80106087 <alltraps>

8010676b <vector64>:
8010676b:	6a 00                	push   $0x0
8010676d:	6a 40                	push   $0x40
8010676f:	e9 13 f9 ff ff       	jmp    80106087 <alltraps>

80106774 <vector65>:
80106774:	6a 00                	push   $0x0
80106776:	6a 41                	push   $0x41
80106778:	e9 0a f9 ff ff       	jmp    80106087 <alltraps>

8010677d <vector66>:
8010677d:	6a 00                	push   $0x0
8010677f:	6a 42                	push   $0x42
80106781:	e9 01 f9 ff ff       	jmp    80106087 <alltraps>

80106786 <vector67>:
80106786:	6a 00                	push   $0x0
80106788:	6a 43                	push   $0x43
8010678a:	e9 f8 f8 ff ff       	jmp    80106087 <alltraps>

8010678f <vector68>:
8010678f:	6a 00                	push   $0x0
80106791:	6a 44                	push   $0x44
80106793:	e9 ef f8 ff ff       	jmp    80106087 <alltraps>

80106798 <vector69>:
80106798:	6a 00                	push   $0x0
8010679a:	6a 45                	push   $0x45
8010679c:	e9 e6 f8 ff ff       	jmp    80106087 <alltraps>

801067a1 <vector70>:
801067a1:	6a 00                	push   $0x0
801067a3:	6a 46                	push   $0x46
801067a5:	e9 dd f8 ff ff       	jmp    80106087 <alltraps>

801067aa <vector71>:
801067aa:	6a 00                	push   $0x0
801067ac:	6a 47                	push   $0x47
801067ae:	e9 d4 f8 ff ff       	jmp    80106087 <alltraps>

801067b3 <vector72>:
801067b3:	6a 00                	push   $0x0
801067b5:	6a 48                	push   $0x48
801067b7:	e9 cb f8 ff ff       	jmp    80106087 <alltraps>

801067bc <vector73>:
801067bc:	6a 00                	push   $0x0
801067be:	6a 49                	push   $0x49
801067c0:	e9 c2 f8 ff ff       	jmp    80106087 <alltraps>

801067c5 <vector74>:
801067c5:	6a 00                	push   $0x0
801067c7:	6a 4a                	push   $0x4a
801067c9:	e9 b9 f8 ff ff       	jmp    80106087 <alltraps>

801067ce <vector75>:
801067ce:	6a 00                	push   $0x0
801067d0:	6a 4b                	push   $0x4b
801067d2:	e9 b0 f8 ff ff       	jmp    80106087 <alltraps>

801067d7 <vector76>:
801067d7:	6a 00                	push   $0x0
801067d9:	6a 4c                	push   $0x4c
801067db:	e9 a7 f8 ff ff       	jmp    80106087 <alltraps>

801067e0 <vector77>:
801067e0:	6a 00                	push   $0x0
801067e2:	6a 4d                	push   $0x4d
801067e4:	e9 9e f8 ff ff       	jmp    80106087 <alltraps>

801067e9 <vector78>:
801067e9:	6a 00                	push   $0x0
801067eb:	6a 4e                	push   $0x4e
801067ed:	e9 95 f8 ff ff       	jmp    80106087 <alltraps>

801067f2 <vector79>:
801067f2:	6a 00                	push   $0x0
801067f4:	6a 4f                	push   $0x4f
801067f6:	e9 8c f8 ff ff       	jmp    80106087 <alltraps>

801067fb <vector80>:
801067fb:	6a 00                	push   $0x0
801067fd:	6a 50                	push   $0x50
801067ff:	e9 83 f8 ff ff       	jmp    80106087 <alltraps>

80106804 <vector81>:
80106804:	6a 00                	push   $0x0
80106806:	6a 51                	push   $0x51
80106808:	e9 7a f8 ff ff       	jmp    80106087 <alltraps>

8010680d <vector82>:
8010680d:	6a 00                	push   $0x0
8010680f:	6a 52                	push   $0x52
80106811:	e9 71 f8 ff ff       	jmp    80106087 <alltraps>

80106816 <vector83>:
80106816:	6a 00                	push   $0x0
80106818:	6a 53                	push   $0x53
8010681a:	e9 68 f8 ff ff       	jmp    80106087 <alltraps>

8010681f <vector84>:
8010681f:	6a 00                	push   $0x0
80106821:	6a 54                	push   $0x54
80106823:	e9 5f f8 ff ff       	jmp    80106087 <alltraps>

80106828 <vector85>:
80106828:	6a 00                	push   $0x0
8010682a:	6a 55                	push   $0x55
8010682c:	e9 56 f8 ff ff       	jmp    80106087 <alltraps>

80106831 <vector86>:
80106831:	6a 00                	push   $0x0
80106833:	6a 56                	push   $0x56
80106835:	e9 4d f8 ff ff       	jmp    80106087 <alltraps>

8010683a <vector87>:
8010683a:	6a 00                	push   $0x0
8010683c:	6a 57                	push   $0x57
8010683e:	e9 44 f8 ff ff       	jmp    80106087 <alltraps>

80106843 <vector88>:
80106843:	6a 00                	push   $0x0
80106845:	6a 58                	push   $0x58
80106847:	e9 3b f8 ff ff       	jmp    80106087 <alltraps>

8010684c <vector89>:
8010684c:	6a 00                	push   $0x0
8010684e:	6a 59                	push   $0x59
80106850:	e9 32 f8 ff ff       	jmp    80106087 <alltraps>

80106855 <vector90>:
80106855:	6a 00                	push   $0x0
80106857:	6a 5a                	push   $0x5a
80106859:	e9 29 f8 ff ff       	jmp    80106087 <alltraps>

8010685e <vector91>:
8010685e:	6a 00                	push   $0x0
80106860:	6a 5b                	push   $0x5b
80106862:	e9 20 f8 ff ff       	jmp    80106087 <alltraps>

80106867 <vector92>:
80106867:	6a 00                	push   $0x0
80106869:	6a 5c                	push   $0x5c
8010686b:	e9 17 f8 ff ff       	jmp    80106087 <alltraps>

80106870 <vector93>:
80106870:	6a 00                	push   $0x0
80106872:	6a 5d                	push   $0x5d
80106874:	e9 0e f8 ff ff       	jmp    80106087 <alltraps>

80106879 <vector94>:
80106879:	6a 00                	push   $0x0
8010687b:	6a 5e                	push   $0x5e
8010687d:	e9 05 f8 ff ff       	jmp    80106087 <alltraps>

80106882 <vector95>:
80106882:	6a 00                	push   $0x0
80106884:	6a 5f                	push   $0x5f
80106886:	e9 fc f7 ff ff       	jmp    80106087 <alltraps>

8010688b <vector96>:
8010688b:	6a 00                	push   $0x0
8010688d:	6a 60                	push   $0x60
8010688f:	e9 f3 f7 ff ff       	jmp    80106087 <alltraps>

80106894 <vector97>:
80106894:	6a 00                	push   $0x0
80106896:	6a 61                	push   $0x61
80106898:	e9 ea f7 ff ff       	jmp    80106087 <alltraps>

8010689d <vector98>:
8010689d:	6a 00                	push   $0x0
8010689f:	6a 62                	push   $0x62
801068a1:	e9 e1 f7 ff ff       	jmp    80106087 <alltraps>

801068a6 <vector99>:
801068a6:	6a 00                	push   $0x0
801068a8:	6a 63                	push   $0x63
801068aa:	e9 d8 f7 ff ff       	jmp    80106087 <alltraps>

801068af <vector100>:
801068af:	6a 00                	push   $0x0
801068b1:	6a 64                	push   $0x64
801068b3:	e9 cf f7 ff ff       	jmp    80106087 <alltraps>

801068b8 <vector101>:
801068b8:	6a 00                	push   $0x0
801068ba:	6a 65                	push   $0x65
801068bc:	e9 c6 f7 ff ff       	jmp    80106087 <alltraps>

801068c1 <vector102>:
801068c1:	6a 00                	push   $0x0
801068c3:	6a 66                	push   $0x66
801068c5:	e9 bd f7 ff ff       	jmp    80106087 <alltraps>

801068ca <vector103>:
801068ca:	6a 00                	push   $0x0
801068cc:	6a 67                	push   $0x67
801068ce:	e9 b4 f7 ff ff       	jmp    80106087 <alltraps>

801068d3 <vector104>:
801068d3:	6a 00                	push   $0x0
801068d5:	6a 68                	push   $0x68
801068d7:	e9 ab f7 ff ff       	jmp    80106087 <alltraps>

801068dc <vector105>:
801068dc:	6a 00                	push   $0x0
801068de:	6a 69                	push   $0x69
801068e0:	e9 a2 f7 ff ff       	jmp    80106087 <alltraps>

801068e5 <vector106>:
801068e5:	6a 00                	push   $0x0
801068e7:	6a 6a                	push   $0x6a
801068e9:	e9 99 f7 ff ff       	jmp    80106087 <alltraps>

801068ee <vector107>:
801068ee:	6a 00                	push   $0x0
801068f0:	6a 6b                	push   $0x6b
801068f2:	e9 90 f7 ff ff       	jmp    80106087 <alltraps>

801068f7 <vector108>:
801068f7:	6a 00                	push   $0x0
801068f9:	6a 6c                	push   $0x6c
801068fb:	e9 87 f7 ff ff       	jmp    80106087 <alltraps>

80106900 <vector109>:
80106900:	6a 00                	push   $0x0
80106902:	6a 6d                	push   $0x6d
80106904:	e9 7e f7 ff ff       	jmp    80106087 <alltraps>

80106909 <vector110>:
80106909:	6a 00                	push   $0x0
8010690b:	6a 6e                	push   $0x6e
8010690d:	e9 75 f7 ff ff       	jmp    80106087 <alltraps>

80106912 <vector111>:
80106912:	6a 00                	push   $0x0
80106914:	6a 6f                	push   $0x6f
80106916:	e9 6c f7 ff ff       	jmp    80106087 <alltraps>

8010691b <vector112>:
8010691b:	6a 00                	push   $0x0
8010691d:	6a 70                	push   $0x70
8010691f:	e9 63 f7 ff ff       	jmp    80106087 <alltraps>

80106924 <vector113>:
80106924:	6a 00                	push   $0x0
80106926:	6a 71                	push   $0x71
80106928:	e9 5a f7 ff ff       	jmp    80106087 <alltraps>

8010692d <vector114>:
8010692d:	6a 00                	push   $0x0
8010692f:	6a 72                	push   $0x72
80106931:	e9 51 f7 ff ff       	jmp    80106087 <alltraps>

80106936 <vector115>:
80106936:	6a 00                	push   $0x0
80106938:	6a 73                	push   $0x73
8010693a:	e9 48 f7 ff ff       	jmp    80106087 <alltraps>

8010693f <vector116>:
8010693f:	6a 00                	push   $0x0
80106941:	6a 74                	push   $0x74
80106943:	e9 3f f7 ff ff       	jmp    80106087 <alltraps>

80106948 <vector117>:
80106948:	6a 00                	push   $0x0
8010694a:	6a 75                	push   $0x75
8010694c:	e9 36 f7 ff ff       	jmp    80106087 <alltraps>

80106951 <vector118>:
80106951:	6a 00                	push   $0x0
80106953:	6a 76                	push   $0x76
80106955:	e9 2d f7 ff ff       	jmp    80106087 <alltraps>

8010695a <vector119>:
8010695a:	6a 00                	push   $0x0
8010695c:	6a 77                	push   $0x77
8010695e:	e9 24 f7 ff ff       	jmp    80106087 <alltraps>

80106963 <vector120>:
80106963:	6a 00                	push   $0x0
80106965:	6a 78                	push   $0x78
80106967:	e9 1b f7 ff ff       	jmp    80106087 <alltraps>

8010696c <vector121>:
8010696c:	6a 00                	push   $0x0
8010696e:	6a 79                	push   $0x79
80106970:	e9 12 f7 ff ff       	jmp    80106087 <alltraps>

80106975 <vector122>:
80106975:	6a 00                	push   $0x0
80106977:	6a 7a                	push   $0x7a
80106979:	e9 09 f7 ff ff       	jmp    80106087 <alltraps>

8010697e <vector123>:
8010697e:	6a 00                	push   $0x0
80106980:	6a 7b                	push   $0x7b
80106982:	e9 00 f7 ff ff       	jmp    80106087 <alltraps>

80106987 <vector124>:
80106987:	6a 00                	push   $0x0
80106989:	6a 7c                	push   $0x7c
8010698b:	e9 f7 f6 ff ff       	jmp    80106087 <alltraps>

80106990 <vector125>:
80106990:	6a 00                	push   $0x0
80106992:	6a 7d                	push   $0x7d
80106994:	e9 ee f6 ff ff       	jmp    80106087 <alltraps>

80106999 <vector126>:
80106999:	6a 00                	push   $0x0
8010699b:	6a 7e                	push   $0x7e
8010699d:	e9 e5 f6 ff ff       	jmp    80106087 <alltraps>

801069a2 <vector127>:
801069a2:	6a 00                	push   $0x0
801069a4:	6a 7f                	push   $0x7f
801069a6:	e9 dc f6 ff ff       	jmp    80106087 <alltraps>

801069ab <vector128>:
801069ab:	6a 00                	push   $0x0
801069ad:	68 80 00 00 00       	push   $0x80
801069b2:	e9 d0 f6 ff ff       	jmp    80106087 <alltraps>

801069b7 <vector129>:
801069b7:	6a 00                	push   $0x0
801069b9:	68 81 00 00 00       	push   $0x81
801069be:	e9 c4 f6 ff ff       	jmp    80106087 <alltraps>

801069c3 <vector130>:
801069c3:	6a 00                	push   $0x0
801069c5:	68 82 00 00 00       	push   $0x82
801069ca:	e9 b8 f6 ff ff       	jmp    80106087 <alltraps>

801069cf <vector131>:
801069cf:	6a 00                	push   $0x0
801069d1:	68 83 00 00 00       	push   $0x83
801069d6:	e9 ac f6 ff ff       	jmp    80106087 <alltraps>

801069db <vector132>:
801069db:	6a 00                	push   $0x0
801069dd:	68 84 00 00 00       	push   $0x84
801069e2:	e9 a0 f6 ff ff       	jmp    80106087 <alltraps>

801069e7 <vector133>:
801069e7:	6a 00                	push   $0x0
801069e9:	68 85 00 00 00       	push   $0x85
801069ee:	e9 94 f6 ff ff       	jmp    80106087 <alltraps>

801069f3 <vector134>:
801069f3:	6a 00                	push   $0x0
801069f5:	68 86 00 00 00       	push   $0x86
801069fa:	e9 88 f6 ff ff       	jmp    80106087 <alltraps>

801069ff <vector135>:
801069ff:	6a 00                	push   $0x0
80106a01:	68 87 00 00 00       	push   $0x87
80106a06:	e9 7c f6 ff ff       	jmp    80106087 <alltraps>

80106a0b <vector136>:
80106a0b:	6a 00                	push   $0x0
80106a0d:	68 88 00 00 00       	push   $0x88
80106a12:	e9 70 f6 ff ff       	jmp    80106087 <alltraps>

80106a17 <vector137>:
80106a17:	6a 00                	push   $0x0
80106a19:	68 89 00 00 00       	push   $0x89
80106a1e:	e9 64 f6 ff ff       	jmp    80106087 <alltraps>

80106a23 <vector138>:
80106a23:	6a 00                	push   $0x0
80106a25:	68 8a 00 00 00       	push   $0x8a
80106a2a:	e9 58 f6 ff ff       	jmp    80106087 <alltraps>

80106a2f <vector139>:
80106a2f:	6a 00                	push   $0x0
80106a31:	68 8b 00 00 00       	push   $0x8b
80106a36:	e9 4c f6 ff ff       	jmp    80106087 <alltraps>

80106a3b <vector140>:
80106a3b:	6a 00                	push   $0x0
80106a3d:	68 8c 00 00 00       	push   $0x8c
80106a42:	e9 40 f6 ff ff       	jmp    80106087 <alltraps>

80106a47 <vector141>:
80106a47:	6a 00                	push   $0x0
80106a49:	68 8d 00 00 00       	push   $0x8d
80106a4e:	e9 34 f6 ff ff       	jmp    80106087 <alltraps>

80106a53 <vector142>:
80106a53:	6a 00                	push   $0x0
80106a55:	68 8e 00 00 00       	push   $0x8e
80106a5a:	e9 28 f6 ff ff       	jmp    80106087 <alltraps>

80106a5f <vector143>:
80106a5f:	6a 00                	push   $0x0
80106a61:	68 8f 00 00 00       	push   $0x8f
80106a66:	e9 1c f6 ff ff       	jmp    80106087 <alltraps>

80106a6b <vector144>:
80106a6b:	6a 00                	push   $0x0
80106a6d:	68 90 00 00 00       	push   $0x90
80106a72:	e9 10 f6 ff ff       	jmp    80106087 <alltraps>

80106a77 <vector145>:
80106a77:	6a 00                	push   $0x0
80106a79:	68 91 00 00 00       	push   $0x91
80106a7e:	e9 04 f6 ff ff       	jmp    80106087 <alltraps>

80106a83 <vector146>:
80106a83:	6a 00                	push   $0x0
80106a85:	68 92 00 00 00       	push   $0x92
80106a8a:	e9 f8 f5 ff ff       	jmp    80106087 <alltraps>

80106a8f <vector147>:
80106a8f:	6a 00                	push   $0x0
80106a91:	68 93 00 00 00       	push   $0x93
80106a96:	e9 ec f5 ff ff       	jmp    80106087 <alltraps>

80106a9b <vector148>:
80106a9b:	6a 00                	push   $0x0
80106a9d:	68 94 00 00 00       	push   $0x94
80106aa2:	e9 e0 f5 ff ff       	jmp    80106087 <alltraps>

80106aa7 <vector149>:
80106aa7:	6a 00                	push   $0x0
80106aa9:	68 95 00 00 00       	push   $0x95
80106aae:	e9 d4 f5 ff ff       	jmp    80106087 <alltraps>

80106ab3 <vector150>:
80106ab3:	6a 00                	push   $0x0
80106ab5:	68 96 00 00 00       	push   $0x96
80106aba:	e9 c8 f5 ff ff       	jmp    80106087 <alltraps>

80106abf <vector151>:
80106abf:	6a 00                	push   $0x0
80106ac1:	68 97 00 00 00       	push   $0x97
80106ac6:	e9 bc f5 ff ff       	jmp    80106087 <alltraps>

80106acb <vector152>:
80106acb:	6a 00                	push   $0x0
80106acd:	68 98 00 00 00       	push   $0x98
80106ad2:	e9 b0 f5 ff ff       	jmp    80106087 <alltraps>

80106ad7 <vector153>:
80106ad7:	6a 00                	push   $0x0
80106ad9:	68 99 00 00 00       	push   $0x99
80106ade:	e9 a4 f5 ff ff       	jmp    80106087 <alltraps>

80106ae3 <vector154>:
80106ae3:	6a 00                	push   $0x0
80106ae5:	68 9a 00 00 00       	push   $0x9a
80106aea:	e9 98 f5 ff ff       	jmp    80106087 <alltraps>

80106aef <vector155>:
80106aef:	6a 00                	push   $0x0
80106af1:	68 9b 00 00 00       	push   $0x9b
80106af6:	e9 8c f5 ff ff       	jmp    80106087 <alltraps>

80106afb <vector156>:
80106afb:	6a 00                	push   $0x0
80106afd:	68 9c 00 00 00       	push   $0x9c
80106b02:	e9 80 f5 ff ff       	jmp    80106087 <alltraps>

80106b07 <vector157>:
80106b07:	6a 00                	push   $0x0
80106b09:	68 9d 00 00 00       	push   $0x9d
80106b0e:	e9 74 f5 ff ff       	jmp    80106087 <alltraps>

80106b13 <vector158>:
80106b13:	6a 00                	push   $0x0
80106b15:	68 9e 00 00 00       	push   $0x9e
80106b1a:	e9 68 f5 ff ff       	jmp    80106087 <alltraps>

80106b1f <vector159>:
80106b1f:	6a 00                	push   $0x0
80106b21:	68 9f 00 00 00       	push   $0x9f
80106b26:	e9 5c f5 ff ff       	jmp    80106087 <alltraps>

80106b2b <vector160>:
80106b2b:	6a 00                	push   $0x0
80106b2d:	68 a0 00 00 00       	push   $0xa0
80106b32:	e9 50 f5 ff ff       	jmp    80106087 <alltraps>

80106b37 <vector161>:
80106b37:	6a 00                	push   $0x0
80106b39:	68 a1 00 00 00       	push   $0xa1
80106b3e:	e9 44 f5 ff ff       	jmp    80106087 <alltraps>

80106b43 <vector162>:
80106b43:	6a 00                	push   $0x0
80106b45:	68 a2 00 00 00       	push   $0xa2
80106b4a:	e9 38 f5 ff ff       	jmp    80106087 <alltraps>

80106b4f <vector163>:
80106b4f:	6a 00                	push   $0x0
80106b51:	68 a3 00 00 00       	push   $0xa3
80106b56:	e9 2c f5 ff ff       	jmp    80106087 <alltraps>

80106b5b <vector164>:
80106b5b:	6a 00                	push   $0x0
80106b5d:	68 a4 00 00 00       	push   $0xa4
80106b62:	e9 20 f5 ff ff       	jmp    80106087 <alltraps>

80106b67 <vector165>:
80106b67:	6a 00                	push   $0x0
80106b69:	68 a5 00 00 00       	push   $0xa5
80106b6e:	e9 14 f5 ff ff       	jmp    80106087 <alltraps>

80106b73 <vector166>:
80106b73:	6a 00                	push   $0x0
80106b75:	68 a6 00 00 00       	push   $0xa6
80106b7a:	e9 08 f5 ff ff       	jmp    80106087 <alltraps>

80106b7f <vector167>:
80106b7f:	6a 00                	push   $0x0
80106b81:	68 a7 00 00 00       	push   $0xa7
80106b86:	e9 fc f4 ff ff       	jmp    80106087 <alltraps>

80106b8b <vector168>:
80106b8b:	6a 00                	push   $0x0
80106b8d:	68 a8 00 00 00       	push   $0xa8
80106b92:	e9 f0 f4 ff ff       	jmp    80106087 <alltraps>

80106b97 <vector169>:
80106b97:	6a 00                	push   $0x0
80106b99:	68 a9 00 00 00       	push   $0xa9
80106b9e:	e9 e4 f4 ff ff       	jmp    80106087 <alltraps>

80106ba3 <vector170>:
80106ba3:	6a 00                	push   $0x0
80106ba5:	68 aa 00 00 00       	push   $0xaa
80106baa:	e9 d8 f4 ff ff       	jmp    80106087 <alltraps>

80106baf <vector171>:
80106baf:	6a 00                	push   $0x0
80106bb1:	68 ab 00 00 00       	push   $0xab
80106bb6:	e9 cc f4 ff ff       	jmp    80106087 <alltraps>

80106bbb <vector172>:
80106bbb:	6a 00                	push   $0x0
80106bbd:	68 ac 00 00 00       	push   $0xac
80106bc2:	e9 c0 f4 ff ff       	jmp    80106087 <alltraps>

80106bc7 <vector173>:
80106bc7:	6a 00                	push   $0x0
80106bc9:	68 ad 00 00 00       	push   $0xad
80106bce:	e9 b4 f4 ff ff       	jmp    80106087 <alltraps>

80106bd3 <vector174>:
80106bd3:	6a 00                	push   $0x0
80106bd5:	68 ae 00 00 00       	push   $0xae
80106bda:	e9 a8 f4 ff ff       	jmp    80106087 <alltraps>

80106bdf <vector175>:
80106bdf:	6a 00                	push   $0x0
80106be1:	68 af 00 00 00       	push   $0xaf
80106be6:	e9 9c f4 ff ff       	jmp    80106087 <alltraps>

80106beb <vector176>:
80106beb:	6a 00                	push   $0x0
80106bed:	68 b0 00 00 00       	push   $0xb0
80106bf2:	e9 90 f4 ff ff       	jmp    80106087 <alltraps>

80106bf7 <vector177>:
80106bf7:	6a 00                	push   $0x0
80106bf9:	68 b1 00 00 00       	push   $0xb1
80106bfe:	e9 84 f4 ff ff       	jmp    80106087 <alltraps>

80106c03 <vector178>:
80106c03:	6a 00                	push   $0x0
80106c05:	68 b2 00 00 00       	push   $0xb2
80106c0a:	e9 78 f4 ff ff       	jmp    80106087 <alltraps>

80106c0f <vector179>:
80106c0f:	6a 00                	push   $0x0
80106c11:	68 b3 00 00 00       	push   $0xb3
80106c16:	e9 6c f4 ff ff       	jmp    80106087 <alltraps>

80106c1b <vector180>:
80106c1b:	6a 00                	push   $0x0
80106c1d:	68 b4 00 00 00       	push   $0xb4
80106c22:	e9 60 f4 ff ff       	jmp    80106087 <alltraps>

80106c27 <vector181>:
80106c27:	6a 00                	push   $0x0
80106c29:	68 b5 00 00 00       	push   $0xb5
80106c2e:	e9 54 f4 ff ff       	jmp    80106087 <alltraps>

80106c33 <vector182>:
80106c33:	6a 00                	push   $0x0
80106c35:	68 b6 00 00 00       	push   $0xb6
80106c3a:	e9 48 f4 ff ff       	jmp    80106087 <alltraps>

80106c3f <vector183>:
80106c3f:	6a 00                	push   $0x0
80106c41:	68 b7 00 00 00       	push   $0xb7
80106c46:	e9 3c f4 ff ff       	jmp    80106087 <alltraps>

80106c4b <vector184>:
80106c4b:	6a 00                	push   $0x0
80106c4d:	68 b8 00 00 00       	push   $0xb8
80106c52:	e9 30 f4 ff ff       	jmp    80106087 <alltraps>

80106c57 <vector185>:
80106c57:	6a 00                	push   $0x0
80106c59:	68 b9 00 00 00       	push   $0xb9
80106c5e:	e9 24 f4 ff ff       	jmp    80106087 <alltraps>

80106c63 <vector186>:
80106c63:	6a 00                	push   $0x0
80106c65:	68 ba 00 00 00       	push   $0xba
80106c6a:	e9 18 f4 ff ff       	jmp    80106087 <alltraps>

80106c6f <vector187>:
80106c6f:	6a 00                	push   $0x0
80106c71:	68 bb 00 00 00       	push   $0xbb
80106c76:	e9 0c f4 ff ff       	jmp    80106087 <alltraps>

80106c7b <vector188>:
80106c7b:	6a 00                	push   $0x0
80106c7d:	68 bc 00 00 00       	push   $0xbc
80106c82:	e9 00 f4 ff ff       	jmp    80106087 <alltraps>

80106c87 <vector189>:
80106c87:	6a 00                	push   $0x0
80106c89:	68 bd 00 00 00       	push   $0xbd
80106c8e:	e9 f4 f3 ff ff       	jmp    80106087 <alltraps>

80106c93 <vector190>:
80106c93:	6a 00                	push   $0x0
80106c95:	68 be 00 00 00       	push   $0xbe
80106c9a:	e9 e8 f3 ff ff       	jmp    80106087 <alltraps>

80106c9f <vector191>:
80106c9f:	6a 00                	push   $0x0
80106ca1:	68 bf 00 00 00       	push   $0xbf
80106ca6:	e9 dc f3 ff ff       	jmp    80106087 <alltraps>

80106cab <vector192>:
80106cab:	6a 00                	push   $0x0
80106cad:	68 c0 00 00 00       	push   $0xc0
80106cb2:	e9 d0 f3 ff ff       	jmp    80106087 <alltraps>

80106cb7 <vector193>:
80106cb7:	6a 00                	push   $0x0
80106cb9:	68 c1 00 00 00       	push   $0xc1
80106cbe:	e9 c4 f3 ff ff       	jmp    80106087 <alltraps>

80106cc3 <vector194>:
80106cc3:	6a 00                	push   $0x0
80106cc5:	68 c2 00 00 00       	push   $0xc2
80106cca:	e9 b8 f3 ff ff       	jmp    80106087 <alltraps>

80106ccf <vector195>:
80106ccf:	6a 00                	push   $0x0
80106cd1:	68 c3 00 00 00       	push   $0xc3
80106cd6:	e9 ac f3 ff ff       	jmp    80106087 <alltraps>

80106cdb <vector196>:
80106cdb:	6a 00                	push   $0x0
80106cdd:	68 c4 00 00 00       	push   $0xc4
80106ce2:	e9 a0 f3 ff ff       	jmp    80106087 <alltraps>

80106ce7 <vector197>:
80106ce7:	6a 00                	push   $0x0
80106ce9:	68 c5 00 00 00       	push   $0xc5
80106cee:	e9 94 f3 ff ff       	jmp    80106087 <alltraps>

80106cf3 <vector198>:
80106cf3:	6a 00                	push   $0x0
80106cf5:	68 c6 00 00 00       	push   $0xc6
80106cfa:	e9 88 f3 ff ff       	jmp    80106087 <alltraps>

80106cff <vector199>:
80106cff:	6a 00                	push   $0x0
80106d01:	68 c7 00 00 00       	push   $0xc7
80106d06:	e9 7c f3 ff ff       	jmp    80106087 <alltraps>

80106d0b <vector200>:
80106d0b:	6a 00                	push   $0x0
80106d0d:	68 c8 00 00 00       	push   $0xc8
80106d12:	e9 70 f3 ff ff       	jmp    80106087 <alltraps>

80106d17 <vector201>:
80106d17:	6a 00                	push   $0x0
80106d19:	68 c9 00 00 00       	push   $0xc9
80106d1e:	e9 64 f3 ff ff       	jmp    80106087 <alltraps>

80106d23 <vector202>:
80106d23:	6a 00                	push   $0x0
80106d25:	68 ca 00 00 00       	push   $0xca
80106d2a:	e9 58 f3 ff ff       	jmp    80106087 <alltraps>

80106d2f <vector203>:
80106d2f:	6a 00                	push   $0x0
80106d31:	68 cb 00 00 00       	push   $0xcb
80106d36:	e9 4c f3 ff ff       	jmp    80106087 <alltraps>

80106d3b <vector204>:
80106d3b:	6a 00                	push   $0x0
80106d3d:	68 cc 00 00 00       	push   $0xcc
80106d42:	e9 40 f3 ff ff       	jmp    80106087 <alltraps>

80106d47 <vector205>:
80106d47:	6a 00                	push   $0x0
80106d49:	68 cd 00 00 00       	push   $0xcd
80106d4e:	e9 34 f3 ff ff       	jmp    80106087 <alltraps>

80106d53 <vector206>:
80106d53:	6a 00                	push   $0x0
80106d55:	68 ce 00 00 00       	push   $0xce
80106d5a:	e9 28 f3 ff ff       	jmp    80106087 <alltraps>

80106d5f <vector207>:
80106d5f:	6a 00                	push   $0x0
80106d61:	68 cf 00 00 00       	push   $0xcf
80106d66:	e9 1c f3 ff ff       	jmp    80106087 <alltraps>

80106d6b <vector208>:
80106d6b:	6a 00                	push   $0x0
80106d6d:	68 d0 00 00 00       	push   $0xd0
80106d72:	e9 10 f3 ff ff       	jmp    80106087 <alltraps>

80106d77 <vector209>:
80106d77:	6a 00                	push   $0x0
80106d79:	68 d1 00 00 00       	push   $0xd1
80106d7e:	e9 04 f3 ff ff       	jmp    80106087 <alltraps>

80106d83 <vector210>:
80106d83:	6a 00                	push   $0x0
80106d85:	68 d2 00 00 00       	push   $0xd2
80106d8a:	e9 f8 f2 ff ff       	jmp    80106087 <alltraps>

80106d8f <vector211>:
80106d8f:	6a 00                	push   $0x0
80106d91:	68 d3 00 00 00       	push   $0xd3
80106d96:	e9 ec f2 ff ff       	jmp    80106087 <alltraps>

80106d9b <vector212>:
80106d9b:	6a 00                	push   $0x0
80106d9d:	68 d4 00 00 00       	push   $0xd4
80106da2:	e9 e0 f2 ff ff       	jmp    80106087 <alltraps>

80106da7 <vector213>:
80106da7:	6a 00                	push   $0x0
80106da9:	68 d5 00 00 00       	push   $0xd5
80106dae:	e9 d4 f2 ff ff       	jmp    80106087 <alltraps>

80106db3 <vector214>:
80106db3:	6a 00                	push   $0x0
80106db5:	68 d6 00 00 00       	push   $0xd6
80106dba:	e9 c8 f2 ff ff       	jmp    80106087 <alltraps>

80106dbf <vector215>:
80106dbf:	6a 00                	push   $0x0
80106dc1:	68 d7 00 00 00       	push   $0xd7
80106dc6:	e9 bc f2 ff ff       	jmp    80106087 <alltraps>

80106dcb <vector216>:
80106dcb:	6a 00                	push   $0x0
80106dcd:	68 d8 00 00 00       	push   $0xd8
80106dd2:	e9 b0 f2 ff ff       	jmp    80106087 <alltraps>

80106dd7 <vector217>:
80106dd7:	6a 00                	push   $0x0
80106dd9:	68 d9 00 00 00       	push   $0xd9
80106dde:	e9 a4 f2 ff ff       	jmp    80106087 <alltraps>

80106de3 <vector218>:
80106de3:	6a 00                	push   $0x0
80106de5:	68 da 00 00 00       	push   $0xda
80106dea:	e9 98 f2 ff ff       	jmp    80106087 <alltraps>

80106def <vector219>:
80106def:	6a 00                	push   $0x0
80106df1:	68 db 00 00 00       	push   $0xdb
80106df6:	e9 8c f2 ff ff       	jmp    80106087 <alltraps>

80106dfb <vector220>:
80106dfb:	6a 00                	push   $0x0
80106dfd:	68 dc 00 00 00       	push   $0xdc
80106e02:	e9 80 f2 ff ff       	jmp    80106087 <alltraps>

80106e07 <vector221>:
80106e07:	6a 00                	push   $0x0
80106e09:	68 dd 00 00 00       	push   $0xdd
80106e0e:	e9 74 f2 ff ff       	jmp    80106087 <alltraps>

80106e13 <vector222>:
80106e13:	6a 00                	push   $0x0
80106e15:	68 de 00 00 00       	push   $0xde
80106e1a:	e9 68 f2 ff ff       	jmp    80106087 <alltraps>

80106e1f <vector223>:
80106e1f:	6a 00                	push   $0x0
80106e21:	68 df 00 00 00       	push   $0xdf
80106e26:	e9 5c f2 ff ff       	jmp    80106087 <alltraps>

80106e2b <vector224>:
80106e2b:	6a 00                	push   $0x0
80106e2d:	68 e0 00 00 00       	push   $0xe0
80106e32:	e9 50 f2 ff ff       	jmp    80106087 <alltraps>

80106e37 <vector225>:
80106e37:	6a 00                	push   $0x0
80106e39:	68 e1 00 00 00       	push   $0xe1
80106e3e:	e9 44 f2 ff ff       	jmp    80106087 <alltraps>

80106e43 <vector226>:
80106e43:	6a 00                	push   $0x0
80106e45:	68 e2 00 00 00       	push   $0xe2
80106e4a:	e9 38 f2 ff ff       	jmp    80106087 <alltraps>

80106e4f <vector227>:
80106e4f:	6a 00                	push   $0x0
80106e51:	68 e3 00 00 00       	push   $0xe3
80106e56:	e9 2c f2 ff ff       	jmp    80106087 <alltraps>

80106e5b <vector228>:
80106e5b:	6a 00                	push   $0x0
80106e5d:	68 e4 00 00 00       	push   $0xe4
80106e62:	e9 20 f2 ff ff       	jmp    80106087 <alltraps>

80106e67 <vector229>:
80106e67:	6a 00                	push   $0x0
80106e69:	68 e5 00 00 00       	push   $0xe5
80106e6e:	e9 14 f2 ff ff       	jmp    80106087 <alltraps>

80106e73 <vector230>:
80106e73:	6a 00                	push   $0x0
80106e75:	68 e6 00 00 00       	push   $0xe6
80106e7a:	e9 08 f2 ff ff       	jmp    80106087 <alltraps>

80106e7f <vector231>:
80106e7f:	6a 00                	push   $0x0
80106e81:	68 e7 00 00 00       	push   $0xe7
80106e86:	e9 fc f1 ff ff       	jmp    80106087 <alltraps>

80106e8b <vector232>:
80106e8b:	6a 00                	push   $0x0
80106e8d:	68 e8 00 00 00       	push   $0xe8
80106e92:	e9 f0 f1 ff ff       	jmp    80106087 <alltraps>

80106e97 <vector233>:
80106e97:	6a 00                	push   $0x0
80106e99:	68 e9 00 00 00       	push   $0xe9
80106e9e:	e9 e4 f1 ff ff       	jmp    80106087 <alltraps>

80106ea3 <vector234>:
80106ea3:	6a 00                	push   $0x0
80106ea5:	68 ea 00 00 00       	push   $0xea
80106eaa:	e9 d8 f1 ff ff       	jmp    80106087 <alltraps>

80106eaf <vector235>:
80106eaf:	6a 00                	push   $0x0
80106eb1:	68 eb 00 00 00       	push   $0xeb
80106eb6:	e9 cc f1 ff ff       	jmp    80106087 <alltraps>

80106ebb <vector236>:
80106ebb:	6a 00                	push   $0x0
80106ebd:	68 ec 00 00 00       	push   $0xec
80106ec2:	e9 c0 f1 ff ff       	jmp    80106087 <alltraps>

80106ec7 <vector237>:
80106ec7:	6a 00                	push   $0x0
80106ec9:	68 ed 00 00 00       	push   $0xed
80106ece:	e9 b4 f1 ff ff       	jmp    80106087 <alltraps>

80106ed3 <vector238>:
80106ed3:	6a 00                	push   $0x0
80106ed5:	68 ee 00 00 00       	push   $0xee
80106eda:	e9 a8 f1 ff ff       	jmp    80106087 <alltraps>

80106edf <vector239>:
80106edf:	6a 00                	push   $0x0
80106ee1:	68 ef 00 00 00       	push   $0xef
80106ee6:	e9 9c f1 ff ff       	jmp    80106087 <alltraps>

80106eeb <vector240>:
80106eeb:	6a 00                	push   $0x0
80106eed:	68 f0 00 00 00       	push   $0xf0
80106ef2:	e9 90 f1 ff ff       	jmp    80106087 <alltraps>

80106ef7 <vector241>:
80106ef7:	6a 00                	push   $0x0
80106ef9:	68 f1 00 00 00       	push   $0xf1
80106efe:	e9 84 f1 ff ff       	jmp    80106087 <alltraps>

80106f03 <vector242>:
80106f03:	6a 00                	push   $0x0
80106f05:	68 f2 00 00 00       	push   $0xf2
80106f0a:	e9 78 f1 ff ff       	jmp    80106087 <alltraps>

80106f0f <vector243>:
80106f0f:	6a 00                	push   $0x0
80106f11:	68 f3 00 00 00       	push   $0xf3
80106f16:	e9 6c f1 ff ff       	jmp    80106087 <alltraps>

80106f1b <vector244>:
80106f1b:	6a 00                	push   $0x0
80106f1d:	68 f4 00 00 00       	push   $0xf4
80106f22:	e9 60 f1 ff ff       	jmp    80106087 <alltraps>

80106f27 <vector245>:
80106f27:	6a 00                	push   $0x0
80106f29:	68 f5 00 00 00       	push   $0xf5
80106f2e:	e9 54 f1 ff ff       	jmp    80106087 <alltraps>

80106f33 <vector246>:
80106f33:	6a 00                	push   $0x0
80106f35:	68 f6 00 00 00       	push   $0xf6
80106f3a:	e9 48 f1 ff ff       	jmp    80106087 <alltraps>

80106f3f <vector247>:
80106f3f:	6a 00                	push   $0x0
80106f41:	68 f7 00 00 00       	push   $0xf7
80106f46:	e9 3c f1 ff ff       	jmp    80106087 <alltraps>

80106f4b <vector248>:
80106f4b:	6a 00                	push   $0x0
80106f4d:	68 f8 00 00 00       	push   $0xf8
80106f52:	e9 30 f1 ff ff       	jmp    80106087 <alltraps>

80106f57 <vector249>:
80106f57:	6a 00                	push   $0x0
80106f59:	68 f9 00 00 00       	push   $0xf9
80106f5e:	e9 24 f1 ff ff       	jmp    80106087 <alltraps>

80106f63 <vector250>:
80106f63:	6a 00                	push   $0x0
80106f65:	68 fa 00 00 00       	push   $0xfa
80106f6a:	e9 18 f1 ff ff       	jmp    80106087 <alltraps>

80106f6f <vector251>:
80106f6f:	6a 00                	push   $0x0
80106f71:	68 fb 00 00 00       	push   $0xfb
80106f76:	e9 0c f1 ff ff       	jmp    80106087 <alltraps>

80106f7b <vector252>:
80106f7b:	6a 00                	push   $0x0
80106f7d:	68 fc 00 00 00       	push   $0xfc
80106f82:	e9 00 f1 ff ff       	jmp    80106087 <alltraps>

80106f87 <vector253>:
80106f87:	6a 00                	push   $0x0
80106f89:	68 fd 00 00 00       	push   $0xfd
80106f8e:	e9 f4 f0 ff ff       	jmp    80106087 <alltraps>

80106f93 <vector254>:
80106f93:	6a 00                	push   $0x0
80106f95:	68 fe 00 00 00       	push   $0xfe
80106f9a:	e9 e8 f0 ff ff       	jmp    80106087 <alltraps>

80106f9f <vector255>:
80106f9f:	6a 00                	push   $0x0
80106fa1:	68 ff 00 00 00       	push   $0xff
80106fa6:	e9 dc f0 ff ff       	jmp    80106087 <alltraps>
80106fab:	66 90                	xchg   %ax,%ax
80106fad:	66 90                	xchg   %ax,%ax
80106faf:	90                   	nop

80106fb0 <walkpgdir>:
80106fb0:	55                   	push   %ebp
80106fb1:	89 e5                	mov    %esp,%ebp
80106fb3:	57                   	push   %edi
80106fb4:	56                   	push   %esi
80106fb5:	89 d6                	mov    %edx,%esi
80106fb7:	c1 ea 16             	shr    $0x16,%edx
80106fba:	53                   	push   %ebx
80106fbb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
80106fbe:	83 ec 0c             	sub    $0xc,%esp
80106fc1:	8b 1f                	mov    (%edi),%ebx
80106fc3:	f6 c3 01             	test   $0x1,%bl
80106fc6:	74 28                	je     80106ff0 <walkpgdir+0x40>
80106fc8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80106fce:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80106fd4:	89 f0                	mov    %esi,%eax
80106fd6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fd9:	c1 e8 0a             	shr    $0xa,%eax
80106fdc:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fe1:	01 d8                	add    %ebx,%eax
80106fe3:	5b                   	pop    %ebx
80106fe4:	5e                   	pop    %esi
80106fe5:	5f                   	pop    %edi
80106fe6:	5d                   	pop    %ebp
80106fe7:	c3                   	ret    
80106fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106fef:	90                   	nop
80106ff0:	85 c9                	test   %ecx,%ecx
80106ff2:	74 2c                	je     80107020 <walkpgdir+0x70>
80106ff4:	e8 17 bb ff ff       	call   80102b10 <kalloc>
80106ff9:	89 c3                	mov    %eax,%ebx
80106ffb:	85 c0                	test   %eax,%eax
80106ffd:	74 21                	je     80107020 <walkpgdir+0x70>
80106fff:	83 ec 04             	sub    $0x4,%esp
80107002:	68 00 10 00 00       	push   $0x1000
80107007:	6a 00                	push   $0x0
80107009:	50                   	push   %eax
8010700a:	e8 d1 dc ff ff       	call   80104ce0 <memset>
8010700f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107015:	83 c4 10             	add    $0x10,%esp
80107018:	83 c8 07             	or     $0x7,%eax
8010701b:	89 07                	mov    %eax,(%edi)
8010701d:	eb b5                	jmp    80106fd4 <walkpgdir+0x24>
8010701f:	90                   	nop
80107020:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107023:	31 c0                	xor    %eax,%eax
80107025:	5b                   	pop    %ebx
80107026:	5e                   	pop    %esi
80107027:	5f                   	pop    %edi
80107028:	5d                   	pop    %ebp
80107029:	c3                   	ret    
8010702a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107030 <mappages>:
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	89 c7                	mov    %eax,%edi
80107036:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
8010703a:	56                   	push   %esi
8010703b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107040:	89 d6                	mov    %edx,%esi
80107042:	53                   	push   %ebx
80107043:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
80107049:	83 ec 1c             	sub    $0x1c,%esp
8010704c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010704f:	8b 45 08             	mov    0x8(%ebp),%eax
80107052:	29 f0                	sub    %esi,%eax
80107054:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107057:	eb 1f                	jmp    80107078 <mappages+0x48>
80107059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107060:	f6 00 01             	testb  $0x1,(%eax)
80107063:	75 45                	jne    801070aa <mappages+0x7a>
80107065:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107068:	83 cb 01             	or     $0x1,%ebx
8010706b:	89 18                	mov    %ebx,(%eax)
8010706d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107070:	74 2e                	je     801070a0 <mappages+0x70>
80107072:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107078:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010707b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107080:	89 f2                	mov    %esi,%edx
80107082:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107085:	89 f8                	mov    %edi,%eax
80107087:	e8 24 ff ff ff       	call   80106fb0 <walkpgdir>
8010708c:	85 c0                	test   %eax,%eax
8010708e:	75 d0                	jne    80107060 <mappages+0x30>
80107090:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107093:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107098:	5b                   	pop    %ebx
80107099:	5e                   	pop    %esi
8010709a:	5f                   	pop    %edi
8010709b:	5d                   	pop    %ebp
8010709c:	c3                   	ret    
8010709d:	8d 76 00             	lea    0x0(%esi),%esi
801070a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070a3:	31 c0                	xor    %eax,%eax
801070a5:	5b                   	pop    %ebx
801070a6:	5e                   	pop    %esi
801070a7:	5f                   	pop    %edi
801070a8:	5d                   	pop    %ebp
801070a9:	c3                   	ret    
801070aa:	83 ec 0c             	sub    $0xc,%esp
801070ad:	68 20 82 10 80       	push   $0x80108220
801070b2:	e8 d9 92 ff ff       	call   80100390 <panic>
801070b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070be:	66 90                	xchg   %ax,%ax

801070c0 <deallocuvm.part.0>:
801070c0:	55                   	push   %ebp
801070c1:	89 e5                	mov    %esp,%ebp
801070c3:	57                   	push   %edi
801070c4:	56                   	push   %esi
801070c5:	89 c6                	mov    %eax,%esi
801070c7:	53                   	push   %ebx
801070c8:	89 d3                	mov    %edx,%ebx
801070ca:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801070d0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801070d6:	83 ec 1c             	sub    $0x1c,%esp
801070d9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801070dc:	39 da                	cmp    %ebx,%edx
801070de:	73 5b                	jae    8010713b <deallocuvm.part.0+0x7b>
801070e0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801070e3:	89 d7                	mov    %edx,%edi
801070e5:	eb 14                	jmp    801070fb <deallocuvm.part.0+0x3b>
801070e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070ee:	66 90                	xchg   %ax,%ax
801070f0:	81 c7 00 10 00 00    	add    $0x1000,%edi
801070f6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801070f9:	76 40                	jbe    8010713b <deallocuvm.part.0+0x7b>
801070fb:	31 c9                	xor    %ecx,%ecx
801070fd:	89 fa                	mov    %edi,%edx
801070ff:	89 f0                	mov    %esi,%eax
80107101:	e8 aa fe ff ff       	call   80106fb0 <walkpgdir>
80107106:	89 c3                	mov    %eax,%ebx
80107108:	85 c0                	test   %eax,%eax
8010710a:	74 44                	je     80107150 <deallocuvm.part.0+0x90>
8010710c:	8b 00                	mov    (%eax),%eax
8010710e:	a8 01                	test   $0x1,%al
80107110:	74 de                	je     801070f0 <deallocuvm.part.0+0x30>
80107112:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107117:	74 47                	je     80107160 <deallocuvm.part.0+0xa0>
80107119:	83 ec 0c             	sub    $0xc,%esp
8010711c:	05 00 00 00 80       	add    $0x80000000,%eax
80107121:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107127:	50                   	push   %eax
80107128:	e8 23 b8 ff ff       	call   80102950 <kfree>
8010712d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107133:	83 c4 10             	add    $0x10,%esp
80107136:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107139:	77 c0                	ja     801070fb <deallocuvm.part.0+0x3b>
8010713b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010713e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107141:	5b                   	pop    %ebx
80107142:	5e                   	pop    %esi
80107143:	5f                   	pop    %edi
80107144:	5d                   	pop    %ebp
80107145:	c3                   	ret    
80107146:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010714d:	8d 76 00             	lea    0x0(%esi),%esi
80107150:	89 fa                	mov    %edi,%edx
80107152:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107158:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010715e:	eb 96                	jmp    801070f6 <deallocuvm.part.0+0x36>
80107160:	83 ec 0c             	sub    $0xc,%esp
80107163:	68 be 7b 10 80       	push   $0x80107bbe
80107168:	e8 23 92 ff ff       	call   80100390 <panic>
8010716d:	8d 76 00             	lea    0x0(%esi),%esi

80107170 <seginit>:
80107170:	f3 0f 1e fb          	endbr32 
80107174:	55                   	push   %ebp
80107175:	89 e5                	mov    %esp,%ebp
80107177:	83 ec 18             	sub    $0x18,%esp
8010717a:	e8 a1 cc ff ff       	call   80103e20 <cpuid>
8010717f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107184:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010718a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
8010718e:	c7 80 18 38 11 80 ff 	movl   $0xffff,-0x7feec7e8(%eax)
80107195:	ff 00 00 
80107198:	c7 80 1c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7e4(%eax)
8010719f:	9a cf 00 
801071a2:	c7 80 20 38 11 80 ff 	movl   $0xffff,-0x7feec7e0(%eax)
801071a9:	ff 00 00 
801071ac:	c7 80 24 38 11 80 00 	movl   $0xcf9200,-0x7feec7dc(%eax)
801071b3:	92 cf 00 
801071b6:	c7 80 28 38 11 80 ff 	movl   $0xffff,-0x7feec7d8(%eax)
801071bd:	ff 00 00 
801071c0:	c7 80 2c 38 11 80 00 	movl   $0xcffa00,-0x7feec7d4(%eax)
801071c7:	fa cf 00 
801071ca:	c7 80 30 38 11 80 ff 	movl   $0xffff,-0x7feec7d0(%eax)
801071d1:	ff 00 00 
801071d4:	c7 80 34 38 11 80 00 	movl   $0xcff200,-0x7feec7cc(%eax)
801071db:	f2 cf 00 
801071de:	05 10 38 11 80       	add    $0x80113810,%eax
801071e3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
801071e7:	c1 e8 10             	shr    $0x10,%eax
801071ea:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
801071ee:	8d 45 f2             	lea    -0xe(%ebp),%eax
801071f1:	0f 01 10             	lgdtl  (%eax)
801071f4:	c9                   	leave  
801071f5:	c3                   	ret    
801071f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801071fd:	8d 76 00             	lea    0x0(%esi),%esi

80107200 <switchkvm>:
80107200:	f3 0f 1e fb          	endbr32 
80107204:	a1 c4 65 11 80       	mov    0x801165c4,%eax
80107209:	05 00 00 00 80       	add    $0x80000000,%eax
8010720e:	0f 22 d8             	mov    %eax,%cr3
80107211:	c3                   	ret    
80107212:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107220 <switchuvm>:
80107220:	f3 0f 1e fb          	endbr32 
80107224:	55                   	push   %ebp
80107225:	89 e5                	mov    %esp,%ebp
80107227:	57                   	push   %edi
80107228:	56                   	push   %esi
80107229:	53                   	push   %ebx
8010722a:	83 ec 1c             	sub    $0x1c,%esp
8010722d:	8b 75 08             	mov    0x8(%ebp),%esi
80107230:	85 f6                	test   %esi,%esi
80107232:	0f 84 cb 00 00 00    	je     80107303 <switchuvm+0xe3>
80107238:	8b 46 08             	mov    0x8(%esi),%eax
8010723b:	85 c0                	test   %eax,%eax
8010723d:	0f 84 da 00 00 00    	je     8010731d <switchuvm+0xfd>
80107243:	8b 46 04             	mov    0x4(%esi),%eax
80107246:	85 c0                	test   %eax,%eax
80107248:	0f 84 c2 00 00 00    	je     80107310 <switchuvm+0xf0>
8010724e:	e8 7d d8 ff ff       	call   80104ad0 <pushcli>
80107253:	e8 58 cb ff ff       	call   80103db0 <mycpu>
80107258:	89 c3                	mov    %eax,%ebx
8010725a:	e8 51 cb ff ff       	call   80103db0 <mycpu>
8010725f:	89 c7                	mov    %eax,%edi
80107261:	e8 4a cb ff ff       	call   80103db0 <mycpu>
80107266:	83 c7 08             	add    $0x8,%edi
80107269:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010726c:	e8 3f cb ff ff       	call   80103db0 <mycpu>
80107271:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107274:	ba 67 00 00 00       	mov    $0x67,%edx
80107279:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107280:	83 c0 08             	add    $0x8,%eax
80107283:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
8010728a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
8010728f:	83 c1 08             	add    $0x8,%ecx
80107292:	c1 e8 18             	shr    $0x18,%eax
80107295:	c1 e9 10             	shr    $0x10,%ecx
80107298:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010729e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801072a4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801072a9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
801072b0:	bb 10 00 00 00       	mov    $0x10,%ebx
801072b5:	e8 f6 ca ff ff       	call   80103db0 <mycpu>
801072ba:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
801072c1:	e8 ea ca ff ff       	call   80103db0 <mycpu>
801072c6:	66 89 58 10          	mov    %bx,0x10(%eax)
801072ca:	8b 5e 08             	mov    0x8(%esi),%ebx
801072cd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801072d3:	e8 d8 ca ff ff       	call   80103db0 <mycpu>
801072d8:	89 58 0c             	mov    %ebx,0xc(%eax)
801072db:	e8 d0 ca ff ff       	call   80103db0 <mycpu>
801072e0:	66 89 78 6e          	mov    %di,0x6e(%eax)
801072e4:	b8 28 00 00 00       	mov    $0x28,%eax
801072e9:	0f 00 d8             	ltr    %ax
801072ec:	8b 46 04             	mov    0x4(%esi),%eax
801072ef:	05 00 00 00 80       	add    $0x80000000,%eax
801072f4:	0f 22 d8             	mov    %eax,%cr3
801072f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072fa:	5b                   	pop    %ebx
801072fb:	5e                   	pop    %esi
801072fc:	5f                   	pop    %edi
801072fd:	5d                   	pop    %ebp
801072fe:	e9 1d d8 ff ff       	jmp    80104b20 <popcli>
80107303:	83 ec 0c             	sub    $0xc,%esp
80107306:	68 26 82 10 80       	push   $0x80108226
8010730b:	e8 80 90 ff ff       	call   80100390 <panic>
80107310:	83 ec 0c             	sub    $0xc,%esp
80107313:	68 51 82 10 80       	push   $0x80108251
80107318:	e8 73 90 ff ff       	call   80100390 <panic>
8010731d:	83 ec 0c             	sub    $0xc,%esp
80107320:	68 3c 82 10 80       	push   $0x8010823c
80107325:	e8 66 90 ff ff       	call   80100390 <panic>
8010732a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107330 <inituvm>:
80107330:	f3 0f 1e fb          	endbr32 
80107334:	55                   	push   %ebp
80107335:	89 e5                	mov    %esp,%ebp
80107337:	57                   	push   %edi
80107338:	56                   	push   %esi
80107339:	53                   	push   %ebx
8010733a:	83 ec 1c             	sub    $0x1c,%esp
8010733d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107340:	8b 75 10             	mov    0x10(%ebp),%esi
80107343:	8b 7d 08             	mov    0x8(%ebp),%edi
80107346:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107349:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010734f:	77 4b                	ja     8010739c <inituvm+0x6c>
80107351:	e8 ba b7 ff ff       	call   80102b10 <kalloc>
80107356:	83 ec 04             	sub    $0x4,%esp
80107359:	68 00 10 00 00       	push   $0x1000
8010735e:	89 c3                	mov    %eax,%ebx
80107360:	6a 00                	push   $0x0
80107362:	50                   	push   %eax
80107363:	e8 78 d9 ff ff       	call   80104ce0 <memset>
80107368:	58                   	pop    %eax
80107369:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010736f:	5a                   	pop    %edx
80107370:	6a 06                	push   $0x6
80107372:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107377:	31 d2                	xor    %edx,%edx
80107379:	50                   	push   %eax
8010737a:	89 f8                	mov    %edi,%eax
8010737c:	e8 af fc ff ff       	call   80107030 <mappages>
80107381:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107384:	89 75 10             	mov    %esi,0x10(%ebp)
80107387:	83 c4 10             	add    $0x10,%esp
8010738a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010738d:	89 45 0c             	mov    %eax,0xc(%ebp)
80107390:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107393:	5b                   	pop    %ebx
80107394:	5e                   	pop    %esi
80107395:	5f                   	pop    %edi
80107396:	5d                   	pop    %ebp
80107397:	e9 e4 d9 ff ff       	jmp    80104d80 <memmove>
8010739c:	83 ec 0c             	sub    $0xc,%esp
8010739f:	68 65 82 10 80       	push   $0x80108265
801073a4:	e8 e7 8f ff ff       	call   80100390 <panic>
801073a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801073b0 <loaduvm>:
801073b0:	f3 0f 1e fb          	endbr32 
801073b4:	55                   	push   %ebp
801073b5:	89 e5                	mov    %esp,%ebp
801073b7:	57                   	push   %edi
801073b8:	56                   	push   %esi
801073b9:	53                   	push   %ebx
801073ba:	83 ec 1c             	sub    $0x1c,%esp
801073bd:	8b 45 0c             	mov    0xc(%ebp),%eax
801073c0:	8b 75 18             	mov    0x18(%ebp),%esi
801073c3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801073c8:	0f 85 99 00 00 00    	jne    80107467 <loaduvm+0xb7>
801073ce:	01 f0                	add    %esi,%eax
801073d0:	89 f3                	mov    %esi,%ebx
801073d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073d5:	8b 45 14             	mov    0x14(%ebp),%eax
801073d8:	01 f0                	add    %esi,%eax
801073da:	89 45 e0             	mov    %eax,-0x20(%ebp)
801073dd:	85 f6                	test   %esi,%esi
801073df:	75 15                	jne    801073f6 <loaduvm+0x46>
801073e1:	eb 6d                	jmp    80107450 <loaduvm+0xa0>
801073e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801073e7:	90                   	nop
801073e8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801073ee:	89 f0                	mov    %esi,%eax
801073f0:	29 d8                	sub    %ebx,%eax
801073f2:	39 c6                	cmp    %eax,%esi
801073f4:	76 5a                	jbe    80107450 <loaduvm+0xa0>
801073f6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801073f9:	8b 45 08             	mov    0x8(%ebp),%eax
801073fc:	31 c9                	xor    %ecx,%ecx
801073fe:	29 da                	sub    %ebx,%edx
80107400:	e8 ab fb ff ff       	call   80106fb0 <walkpgdir>
80107405:	85 c0                	test   %eax,%eax
80107407:	74 51                	je     8010745a <loaduvm+0xaa>
80107409:	8b 00                	mov    (%eax),%eax
8010740b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010740e:	bf 00 10 00 00       	mov    $0x1000,%edi
80107413:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107418:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010741e:	0f 46 fb             	cmovbe %ebx,%edi
80107421:	29 d9                	sub    %ebx,%ecx
80107423:	05 00 00 00 80       	add    $0x80000000,%eax
80107428:	57                   	push   %edi
80107429:	51                   	push   %ecx
8010742a:	50                   	push   %eax
8010742b:	ff 75 10             	pushl  0x10(%ebp)
8010742e:	e8 ed aa ff ff       	call   80101f20 <readi>
80107433:	83 c4 10             	add    $0x10,%esp
80107436:	39 f8                	cmp    %edi,%eax
80107438:	74 ae                	je     801073e8 <loaduvm+0x38>
8010743a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010743d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107442:	5b                   	pop    %ebx
80107443:	5e                   	pop    %esi
80107444:	5f                   	pop    %edi
80107445:	5d                   	pop    %ebp
80107446:	c3                   	ret    
80107447:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010744e:	66 90                	xchg   %ax,%ax
80107450:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107453:	31 c0                	xor    %eax,%eax
80107455:	5b                   	pop    %ebx
80107456:	5e                   	pop    %esi
80107457:	5f                   	pop    %edi
80107458:	5d                   	pop    %ebp
80107459:	c3                   	ret    
8010745a:	83 ec 0c             	sub    $0xc,%esp
8010745d:	68 7f 82 10 80       	push   $0x8010827f
80107462:	e8 29 8f ff ff       	call   80100390 <panic>
80107467:	83 ec 0c             	sub    $0xc,%esp
8010746a:	68 20 83 10 80       	push   $0x80108320
8010746f:	e8 1c 8f ff ff       	call   80100390 <panic>
80107474:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010747b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010747f:	90                   	nop

80107480 <allocuvm>:
80107480:	f3 0f 1e fb          	endbr32 
80107484:	55                   	push   %ebp
80107485:	89 e5                	mov    %esp,%ebp
80107487:	57                   	push   %edi
80107488:	56                   	push   %esi
80107489:	53                   	push   %ebx
8010748a:	83 ec 1c             	sub    $0x1c,%esp
8010748d:	8b 45 10             	mov    0x10(%ebp),%eax
80107490:	8b 7d 08             	mov    0x8(%ebp),%edi
80107493:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107496:	85 c0                	test   %eax,%eax
80107498:	0f 88 b2 00 00 00    	js     80107550 <allocuvm+0xd0>
8010749e:	3b 45 0c             	cmp    0xc(%ebp),%eax
801074a1:	8b 45 0c             	mov    0xc(%ebp),%eax
801074a4:	0f 82 96 00 00 00    	jb     80107540 <allocuvm+0xc0>
801074aa:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801074b0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801074b6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074b9:	77 40                	ja     801074fb <allocuvm+0x7b>
801074bb:	e9 83 00 00 00       	jmp    80107543 <allocuvm+0xc3>
801074c0:	83 ec 04             	sub    $0x4,%esp
801074c3:	68 00 10 00 00       	push   $0x1000
801074c8:	6a 00                	push   $0x0
801074ca:	50                   	push   %eax
801074cb:	e8 10 d8 ff ff       	call   80104ce0 <memset>
801074d0:	58                   	pop    %eax
801074d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801074d7:	5a                   	pop    %edx
801074d8:	6a 06                	push   $0x6
801074da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801074df:	89 f2                	mov    %esi,%edx
801074e1:	50                   	push   %eax
801074e2:	89 f8                	mov    %edi,%eax
801074e4:	e8 47 fb ff ff       	call   80107030 <mappages>
801074e9:	83 c4 10             	add    $0x10,%esp
801074ec:	85 c0                	test   %eax,%eax
801074ee:	78 78                	js     80107568 <allocuvm+0xe8>
801074f0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074f6:	39 75 10             	cmp    %esi,0x10(%ebp)
801074f9:	76 48                	jbe    80107543 <allocuvm+0xc3>
801074fb:	e8 10 b6 ff ff       	call   80102b10 <kalloc>
80107500:	89 c3                	mov    %eax,%ebx
80107502:	85 c0                	test   %eax,%eax
80107504:	75 ba                	jne    801074c0 <allocuvm+0x40>
80107506:	83 ec 0c             	sub    $0xc,%esp
80107509:	68 9d 82 10 80       	push   $0x8010829d
8010750e:	e8 9d 91 ff ff       	call   801006b0 <cprintf>
80107513:	8b 45 0c             	mov    0xc(%ebp),%eax
80107516:	83 c4 10             	add    $0x10,%esp
80107519:	39 45 10             	cmp    %eax,0x10(%ebp)
8010751c:	74 32                	je     80107550 <allocuvm+0xd0>
8010751e:	8b 55 10             	mov    0x10(%ebp),%edx
80107521:	89 c1                	mov    %eax,%ecx
80107523:	89 f8                	mov    %edi,%eax
80107525:	e8 96 fb ff ff       	call   801070c0 <deallocuvm.part.0>
8010752a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107531:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107534:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107537:	5b                   	pop    %ebx
80107538:	5e                   	pop    %esi
80107539:	5f                   	pop    %edi
8010753a:	5d                   	pop    %ebp
8010753b:	c3                   	ret    
8010753c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107540:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107543:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107546:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107549:	5b                   	pop    %ebx
8010754a:	5e                   	pop    %esi
8010754b:	5f                   	pop    %edi
8010754c:	5d                   	pop    %ebp
8010754d:	c3                   	ret    
8010754e:	66 90                	xchg   %ax,%ax
80107550:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107557:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010755a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010755d:	5b                   	pop    %ebx
8010755e:	5e                   	pop    %esi
8010755f:	5f                   	pop    %edi
80107560:	5d                   	pop    %ebp
80107561:	c3                   	ret    
80107562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107568:	83 ec 0c             	sub    $0xc,%esp
8010756b:	68 b5 82 10 80       	push   $0x801082b5
80107570:	e8 3b 91 ff ff       	call   801006b0 <cprintf>
80107575:	8b 45 0c             	mov    0xc(%ebp),%eax
80107578:	83 c4 10             	add    $0x10,%esp
8010757b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010757e:	74 0c                	je     8010758c <allocuvm+0x10c>
80107580:	8b 55 10             	mov    0x10(%ebp),%edx
80107583:	89 c1                	mov    %eax,%ecx
80107585:	89 f8                	mov    %edi,%eax
80107587:	e8 34 fb ff ff       	call   801070c0 <deallocuvm.part.0>
8010758c:	83 ec 0c             	sub    $0xc,%esp
8010758f:	53                   	push   %ebx
80107590:	e8 bb b3 ff ff       	call   80102950 <kfree>
80107595:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010759c:	83 c4 10             	add    $0x10,%esp
8010759f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801075a2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075a5:	5b                   	pop    %ebx
801075a6:	5e                   	pop    %esi
801075a7:	5f                   	pop    %edi
801075a8:	5d                   	pop    %ebp
801075a9:	c3                   	ret    
801075aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075b0 <deallocuvm>:
801075b0:	f3 0f 1e fb          	endbr32 
801075b4:	55                   	push   %ebp
801075b5:	89 e5                	mov    %esp,%ebp
801075b7:	8b 55 0c             	mov    0xc(%ebp),%edx
801075ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
801075bd:	8b 45 08             	mov    0x8(%ebp),%eax
801075c0:	39 d1                	cmp    %edx,%ecx
801075c2:	73 0c                	jae    801075d0 <deallocuvm+0x20>
801075c4:	5d                   	pop    %ebp
801075c5:	e9 f6 fa ff ff       	jmp    801070c0 <deallocuvm.part.0>
801075ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075d0:	89 d0                	mov    %edx,%eax
801075d2:	5d                   	pop    %ebp
801075d3:	c3                   	ret    
801075d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801075db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801075df:	90                   	nop

801075e0 <freevm>:
801075e0:	f3 0f 1e fb          	endbr32 
801075e4:	55                   	push   %ebp
801075e5:	89 e5                	mov    %esp,%ebp
801075e7:	57                   	push   %edi
801075e8:	56                   	push   %esi
801075e9:	53                   	push   %ebx
801075ea:	83 ec 0c             	sub    $0xc,%esp
801075ed:	8b 75 08             	mov    0x8(%ebp),%esi
801075f0:	85 f6                	test   %esi,%esi
801075f2:	74 55                	je     80107649 <freevm+0x69>
801075f4:	31 c9                	xor    %ecx,%ecx
801075f6:	ba 00 00 00 80       	mov    $0x80000000,%edx
801075fb:	89 f0                	mov    %esi,%eax
801075fd:	89 f3                	mov    %esi,%ebx
801075ff:	e8 bc fa ff ff       	call   801070c0 <deallocuvm.part.0>
80107604:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010760a:	eb 0b                	jmp    80107617 <freevm+0x37>
8010760c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107610:	83 c3 04             	add    $0x4,%ebx
80107613:	39 df                	cmp    %ebx,%edi
80107615:	74 23                	je     8010763a <freevm+0x5a>
80107617:	8b 03                	mov    (%ebx),%eax
80107619:	a8 01                	test   $0x1,%al
8010761b:	74 f3                	je     80107610 <freevm+0x30>
8010761d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107622:	83 ec 0c             	sub    $0xc,%esp
80107625:	83 c3 04             	add    $0x4,%ebx
80107628:	05 00 00 00 80       	add    $0x80000000,%eax
8010762d:	50                   	push   %eax
8010762e:	e8 1d b3 ff ff       	call   80102950 <kfree>
80107633:	83 c4 10             	add    $0x10,%esp
80107636:	39 df                	cmp    %ebx,%edi
80107638:	75 dd                	jne    80107617 <freevm+0x37>
8010763a:	89 75 08             	mov    %esi,0x8(%ebp)
8010763d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107640:	5b                   	pop    %ebx
80107641:	5e                   	pop    %esi
80107642:	5f                   	pop    %edi
80107643:	5d                   	pop    %ebp
80107644:	e9 07 b3 ff ff       	jmp    80102950 <kfree>
80107649:	83 ec 0c             	sub    $0xc,%esp
8010764c:	68 d1 82 10 80       	push   $0x801082d1
80107651:	e8 3a 8d ff ff       	call   80100390 <panic>
80107656:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765d:	8d 76 00             	lea    0x0(%esi),%esi

80107660 <setupkvm>:
80107660:	f3 0f 1e fb          	endbr32 
80107664:	55                   	push   %ebp
80107665:	89 e5                	mov    %esp,%ebp
80107667:	56                   	push   %esi
80107668:	53                   	push   %ebx
80107669:	e8 a2 b4 ff ff       	call   80102b10 <kalloc>
8010766e:	89 c6                	mov    %eax,%esi
80107670:	85 c0                	test   %eax,%eax
80107672:	74 42                	je     801076b6 <setupkvm+0x56>
80107674:	83 ec 04             	sub    $0x4,%esp
80107677:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
8010767c:	68 00 10 00 00       	push   $0x1000
80107681:	6a 00                	push   $0x0
80107683:	50                   	push   %eax
80107684:	e8 57 d6 ff ff       	call   80104ce0 <memset>
80107689:	83 c4 10             	add    $0x10,%esp
8010768c:	8b 43 04             	mov    0x4(%ebx),%eax
8010768f:	83 ec 08             	sub    $0x8,%esp
80107692:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107695:	ff 73 0c             	pushl  0xc(%ebx)
80107698:	8b 13                	mov    (%ebx),%edx
8010769a:	50                   	push   %eax
8010769b:	29 c1                	sub    %eax,%ecx
8010769d:	89 f0                	mov    %esi,%eax
8010769f:	e8 8c f9 ff ff       	call   80107030 <mappages>
801076a4:	83 c4 10             	add    $0x10,%esp
801076a7:	85 c0                	test   %eax,%eax
801076a9:	78 15                	js     801076c0 <setupkvm+0x60>
801076ab:	83 c3 10             	add    $0x10,%ebx
801076ae:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
801076b4:	75 d6                	jne    8010768c <setupkvm+0x2c>
801076b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076b9:	89 f0                	mov    %esi,%eax
801076bb:	5b                   	pop    %ebx
801076bc:	5e                   	pop    %esi
801076bd:	5d                   	pop    %ebp
801076be:	c3                   	ret    
801076bf:	90                   	nop
801076c0:	83 ec 0c             	sub    $0xc,%esp
801076c3:	56                   	push   %esi
801076c4:	31 f6                	xor    %esi,%esi
801076c6:	e8 15 ff ff ff       	call   801075e0 <freevm>
801076cb:	83 c4 10             	add    $0x10,%esp
801076ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801076d1:	89 f0                	mov    %esi,%eax
801076d3:	5b                   	pop    %ebx
801076d4:	5e                   	pop    %esi
801076d5:	5d                   	pop    %ebp
801076d6:	c3                   	ret    
801076d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076de:	66 90                	xchg   %ax,%ax

801076e0 <kvmalloc>:
801076e0:	f3 0f 1e fb          	endbr32 
801076e4:	55                   	push   %ebp
801076e5:	89 e5                	mov    %esp,%ebp
801076e7:	83 ec 08             	sub    $0x8,%esp
801076ea:	e8 71 ff ff ff       	call   80107660 <setupkvm>
801076ef:	a3 c4 65 11 80       	mov    %eax,0x801165c4
801076f4:	05 00 00 00 80       	add    $0x80000000,%eax
801076f9:	0f 22 d8             	mov    %eax,%cr3
801076fc:	c9                   	leave  
801076fd:	c3                   	ret    
801076fe:	66 90                	xchg   %ax,%ax

80107700 <clearpteu>:
80107700:	f3 0f 1e fb          	endbr32 
80107704:	55                   	push   %ebp
80107705:	31 c9                	xor    %ecx,%ecx
80107707:	89 e5                	mov    %esp,%ebp
80107709:	83 ec 08             	sub    $0x8,%esp
8010770c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010770f:	8b 45 08             	mov    0x8(%ebp),%eax
80107712:	e8 99 f8 ff ff       	call   80106fb0 <walkpgdir>
80107717:	85 c0                	test   %eax,%eax
80107719:	74 05                	je     80107720 <clearpteu+0x20>
8010771b:	83 20 fb             	andl   $0xfffffffb,(%eax)
8010771e:	c9                   	leave  
8010771f:	c3                   	ret    
80107720:	83 ec 0c             	sub    $0xc,%esp
80107723:	68 e2 82 10 80       	push   $0x801082e2
80107728:	e8 63 8c ff ff       	call   80100390 <panic>
8010772d:	8d 76 00             	lea    0x0(%esi),%esi

80107730 <copyuvm>:
80107730:	f3 0f 1e fb          	endbr32 
80107734:	55                   	push   %ebp
80107735:	89 e5                	mov    %esp,%ebp
80107737:	57                   	push   %edi
80107738:	56                   	push   %esi
80107739:	53                   	push   %ebx
8010773a:	83 ec 1c             	sub    $0x1c,%esp
8010773d:	e8 1e ff ff ff       	call   80107660 <setupkvm>
80107742:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107745:	85 c0                	test   %eax,%eax
80107747:	0f 84 9b 00 00 00    	je     801077e8 <copyuvm+0xb8>
8010774d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107750:	85 c9                	test   %ecx,%ecx
80107752:	0f 84 90 00 00 00    	je     801077e8 <copyuvm+0xb8>
80107758:	31 f6                	xor    %esi,%esi
8010775a:	eb 46                	jmp    801077a2 <copyuvm+0x72>
8010775c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107760:	83 ec 04             	sub    $0x4,%esp
80107763:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107769:	68 00 10 00 00       	push   $0x1000
8010776e:	57                   	push   %edi
8010776f:	50                   	push   %eax
80107770:	e8 0b d6 ff ff       	call   80104d80 <memmove>
80107775:	58                   	pop    %eax
80107776:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010777c:	5a                   	pop    %edx
8010777d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107780:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107785:	89 f2                	mov    %esi,%edx
80107787:	50                   	push   %eax
80107788:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010778b:	e8 a0 f8 ff ff       	call   80107030 <mappages>
80107790:	83 c4 10             	add    $0x10,%esp
80107793:	85 c0                	test   %eax,%eax
80107795:	78 61                	js     801077f8 <copyuvm+0xc8>
80107797:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010779d:	39 75 0c             	cmp    %esi,0xc(%ebp)
801077a0:	76 46                	jbe    801077e8 <copyuvm+0xb8>
801077a2:	8b 45 08             	mov    0x8(%ebp),%eax
801077a5:	31 c9                	xor    %ecx,%ecx
801077a7:	89 f2                	mov    %esi,%edx
801077a9:	e8 02 f8 ff ff       	call   80106fb0 <walkpgdir>
801077ae:	85 c0                	test   %eax,%eax
801077b0:	74 61                	je     80107813 <copyuvm+0xe3>
801077b2:	8b 00                	mov    (%eax),%eax
801077b4:	a8 01                	test   $0x1,%al
801077b6:	74 4e                	je     80107806 <copyuvm+0xd6>
801077b8:	89 c7                	mov    %eax,%edi
801077ba:	25 ff 0f 00 00       	and    $0xfff,%eax
801077bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077c2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801077c8:	e8 43 b3 ff ff       	call   80102b10 <kalloc>
801077cd:	89 c3                	mov    %eax,%ebx
801077cf:	85 c0                	test   %eax,%eax
801077d1:	75 8d                	jne    80107760 <copyuvm+0x30>
801077d3:	83 ec 0c             	sub    $0xc,%esp
801077d6:	ff 75 e0             	pushl  -0x20(%ebp)
801077d9:	e8 02 fe ff ff       	call   801075e0 <freevm>
801077de:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801077e5:	83 c4 10             	add    $0x10,%esp
801077e8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801077eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077ee:	5b                   	pop    %ebx
801077ef:	5e                   	pop    %esi
801077f0:	5f                   	pop    %edi
801077f1:	5d                   	pop    %ebp
801077f2:	c3                   	ret    
801077f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077f7:	90                   	nop
801077f8:	83 ec 0c             	sub    $0xc,%esp
801077fb:	53                   	push   %ebx
801077fc:	e8 4f b1 ff ff       	call   80102950 <kfree>
80107801:	83 c4 10             	add    $0x10,%esp
80107804:	eb cd                	jmp    801077d3 <copyuvm+0xa3>
80107806:	83 ec 0c             	sub    $0xc,%esp
80107809:	68 06 83 10 80       	push   $0x80108306
8010780e:	e8 7d 8b ff ff       	call   80100390 <panic>
80107813:	83 ec 0c             	sub    $0xc,%esp
80107816:	68 ec 82 10 80       	push   $0x801082ec
8010781b:	e8 70 8b ff ff       	call   80100390 <panic>

80107820 <uva2ka>:
80107820:	f3 0f 1e fb          	endbr32 
80107824:	55                   	push   %ebp
80107825:	31 c9                	xor    %ecx,%ecx
80107827:	89 e5                	mov    %esp,%ebp
80107829:	83 ec 08             	sub    $0x8,%esp
8010782c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010782f:	8b 45 08             	mov    0x8(%ebp),%eax
80107832:	e8 79 f7 ff ff       	call   80106fb0 <walkpgdir>
80107837:	8b 00                	mov    (%eax),%eax
80107839:	c9                   	leave  
8010783a:	89 c2                	mov    %eax,%edx
8010783c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107841:	83 e2 05             	and    $0x5,%edx
80107844:	05 00 00 00 80       	add    $0x80000000,%eax
80107849:	83 fa 05             	cmp    $0x5,%edx
8010784c:	ba 00 00 00 00       	mov    $0x0,%edx
80107851:	0f 45 c2             	cmovne %edx,%eax
80107854:	c3                   	ret    
80107855:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010785c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107860 <copyout>:
80107860:	f3 0f 1e fb          	endbr32 
80107864:	55                   	push   %ebp
80107865:	89 e5                	mov    %esp,%ebp
80107867:	57                   	push   %edi
80107868:	56                   	push   %esi
80107869:	53                   	push   %ebx
8010786a:	83 ec 0c             	sub    $0xc,%esp
8010786d:	8b 75 14             	mov    0x14(%ebp),%esi
80107870:	8b 55 0c             	mov    0xc(%ebp),%edx
80107873:	85 f6                	test   %esi,%esi
80107875:	75 3c                	jne    801078b3 <copyout+0x53>
80107877:	eb 67                	jmp    801078e0 <copyout+0x80>
80107879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107880:	8b 55 0c             	mov    0xc(%ebp),%edx
80107883:	89 fb                	mov    %edi,%ebx
80107885:	29 d3                	sub    %edx,%ebx
80107887:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010788d:	39 f3                	cmp    %esi,%ebx
8010788f:	0f 47 de             	cmova  %esi,%ebx
80107892:	29 fa                	sub    %edi,%edx
80107894:	83 ec 04             	sub    $0x4,%esp
80107897:	01 c2                	add    %eax,%edx
80107899:	53                   	push   %ebx
8010789a:	ff 75 10             	pushl  0x10(%ebp)
8010789d:	52                   	push   %edx
8010789e:	e8 dd d4 ff ff       	call   80104d80 <memmove>
801078a3:	01 5d 10             	add    %ebx,0x10(%ebp)
801078a6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
801078ac:	83 c4 10             	add    $0x10,%esp
801078af:	29 de                	sub    %ebx,%esi
801078b1:	74 2d                	je     801078e0 <copyout+0x80>
801078b3:	89 d7                	mov    %edx,%edi
801078b5:	83 ec 08             	sub    $0x8,%esp
801078b8:	89 55 0c             	mov    %edx,0xc(%ebp)
801078bb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801078c1:	57                   	push   %edi
801078c2:	ff 75 08             	pushl  0x8(%ebp)
801078c5:	e8 56 ff ff ff       	call   80107820 <uva2ka>
801078ca:	83 c4 10             	add    $0x10,%esp
801078cd:	85 c0                	test   %eax,%eax
801078cf:	75 af                	jne    80107880 <copyout+0x20>
801078d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078d4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801078d9:	5b                   	pop    %ebx
801078da:	5e                   	pop    %esi
801078db:	5f                   	pop    %edi
801078dc:	5d                   	pop    %ebp
801078dd:	c3                   	ret    
801078de:	66 90                	xchg   %ax,%ax
801078e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078e3:	31 c0                	xor    %eax,%eax
801078e5:	5b                   	pop    %ebx
801078e6:	5e                   	pop    %esi
801078e7:	5f                   	pop    %edi
801078e8:	5d                   	pop    %ebp
801078e9:	c3                   	ret    
