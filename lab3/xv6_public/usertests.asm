
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	f3 0f 1e fb          	endbr32 
       4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       8:	83 e4 f0             	and    $0xfffffff0,%esp
       b:	ff 71 fc             	pushl  -0x4(%ecx)
       e:	55                   	push   %ebp
       f:	89 e5                	mov    %esp,%ebp
      11:	51                   	push   %ecx
      12:	83 ec 0c             	sub    $0xc,%esp
      15:	68 16 4e 00 00       	push   $0x4e16
      1a:	6a 01                	push   $0x1
      1c:	e8 df 3a 00 00       	call   3b00 <printf>
      21:	59                   	pop    %ecx
      22:	58                   	pop    %eax
      23:	6a 00                	push   $0x0
      25:	68 2a 4e 00 00       	push   $0x4e2a
      2a:	e8 84 39 00 00       	call   39b3 <open>
      2f:	83 c4 10             	add    $0x10,%esp
      32:	85 c0                	test   %eax,%eax
      34:	78 13                	js     49 <main+0x49>
      36:	52                   	push   %edx
      37:	52                   	push   %edx
      38:	68 94 55 00 00       	push   $0x5594
      3d:	6a 01                	push   $0x1
      3f:	e8 bc 3a 00 00       	call   3b00 <printf>
      44:	e8 2a 39 00 00       	call   3973 <exit>
      49:	50                   	push   %eax
      4a:	50                   	push   %eax
      4b:	68 00 02 00 00       	push   $0x200
      50:	68 2a 4e 00 00       	push   $0x4e2a
      55:	e8 59 39 00 00       	call   39b3 <open>
      5a:	89 04 24             	mov    %eax,(%esp)
      5d:	e8 39 39 00 00       	call   399b <close>
      62:	e8 29 36 00 00       	call   3690 <argptest>
      67:	e8 04 12 00 00       	call   1270 <createdelete>
      6c:	e8 df 1a 00 00       	call   1b50 <linkunlink>
      71:	e8 da 17 00 00       	call   1850 <concreate>
      76:	e8 f5 0f 00 00       	call   1070 <fourfiles>
      7b:	e8 30 0e 00 00       	call   eb0 <sharedfd>
      80:	e8 ab 32 00 00       	call   3330 <bigargtest>
      85:	e8 06 24 00 00       	call   2490 <bigwrite>
      8a:	e8 a1 32 00 00       	call   3330 <bigargtest>
      8f:	e8 2c 32 00 00       	call   32c0 <bsstest>
      94:	e8 37 2d 00 00       	call   2dd0 <sbrktest>
      99:	e8 62 31 00 00       	call   3200 <validatetest>
      9e:	e8 6d 03 00 00       	call   410 <opentest>
      a3:	e8 08 04 00 00       	call   4b0 <writetest>
      a8:	e8 e3 05 00 00       	call   690 <writetest1>
      ad:	e8 ae 07 00 00       	call   860 <createtest>
      b2:	e8 59 02 00 00       	call   310 <openiputtest>
      b7:	e8 54 01 00 00       	call   210 <exitiputtest>
      bc:	e8 5f 00 00 00       	call   120 <iputtest>
      c1:	e8 1a 0d 00 00       	call   de0 <mem>
      c6:	e8 95 09 00 00       	call   a60 <pipe1>
      cb:	e8 30 0b 00 00       	call   c00 <preempt>
      d0:	e8 8b 0c 00 00       	call   d60 <exitwait>
      d5:	e8 a6 27 00 00       	call   2880 <rmdot>
      da:	e8 61 26 00 00       	call   2740 <fourteen>
      df:	e8 8c 24 00 00       	call   2570 <bigfile>
      e4:	e8 b7 1c 00 00       	call   1da0 <subdir>
      e9:	e8 42 15 00 00       	call   1630 <linktest>
      ee:	e8 ad 13 00 00       	call   14a0 <unlinkread>
      f3:	e8 08 29 00 00       	call   2a00 <dirfile>
      f8:	e8 03 2b 00 00       	call   2c00 <iref>
      fd:	e8 1e 2c 00 00       	call   2d20 <forktest>
     102:	e8 59 1b 00 00       	call   1c60 <bigdir>
     107:	e8 04 35 00 00       	call   3610 <uio>
     10c:	e8 ff 08 00 00       	call   a10 <exectest>
     111:	e8 5d 38 00 00       	call   3973 <exit>
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
     120:	f3 0f 1e fb          	endbr32 
     124:	55                   	push   %ebp
     125:	89 e5                	mov    %esp,%ebp
     127:	83 ec 10             	sub    $0x10,%esp
     12a:	68 bc 3e 00 00       	push   $0x3ebc
     12f:	ff 35 18 5f 00 00    	pushl  0x5f18
     135:	e8 c6 39 00 00       	call   3b00 <printf>
     13a:	c7 04 24 4f 3e 00 00 	movl   $0x3e4f,(%esp)
     141:	e8 95 38 00 00       	call   39db <mkdir>
     146:	83 c4 10             	add    $0x10,%esp
     149:	85 c0                	test   %eax,%eax
     14b:	78 58                	js     1a5 <iputtest+0x85>
     14d:	83 ec 0c             	sub    $0xc,%esp
     150:	68 4f 3e 00 00       	push   $0x3e4f
     155:	e8 89 38 00 00       	call   39e3 <chdir>
     15a:	83 c4 10             	add    $0x10,%esp
     15d:	85 c0                	test   %eax,%eax
     15f:	0f 88 85 00 00 00    	js     1ea <iputtest+0xca>
     165:	83 ec 0c             	sub    $0xc,%esp
     168:	68 4c 3e 00 00       	push   $0x3e4c
     16d:	e8 51 38 00 00       	call   39c3 <unlink>
     172:	83 c4 10             	add    $0x10,%esp
     175:	85 c0                	test   %eax,%eax
     177:	78 5a                	js     1d3 <iputtest+0xb3>
     179:	83 ec 0c             	sub    $0xc,%esp
     17c:	68 71 3e 00 00       	push   $0x3e71
     181:	e8 5d 38 00 00       	call   39e3 <chdir>
     186:	83 c4 10             	add    $0x10,%esp
     189:	85 c0                	test   %eax,%eax
     18b:	78 2f                	js     1bc <iputtest+0x9c>
     18d:	83 ec 08             	sub    $0x8,%esp
     190:	68 f4 3e 00 00       	push   $0x3ef4
     195:	ff 35 18 5f 00 00    	pushl  0x5f18
     19b:	e8 60 39 00 00       	call   3b00 <printf>
     1a0:	83 c4 10             	add    $0x10,%esp
     1a3:	c9                   	leave  
     1a4:	c3                   	ret    
     1a5:	50                   	push   %eax
     1a6:	50                   	push   %eax
     1a7:	68 28 3e 00 00       	push   $0x3e28
     1ac:	ff 35 18 5f 00 00    	pushl  0x5f18
     1b2:	e8 49 39 00 00       	call   3b00 <printf>
     1b7:	e8 b7 37 00 00       	call   3973 <exit>
     1bc:	50                   	push   %eax
     1bd:	50                   	push   %eax
     1be:	68 73 3e 00 00       	push   $0x3e73
     1c3:	ff 35 18 5f 00 00    	pushl  0x5f18
     1c9:	e8 32 39 00 00       	call   3b00 <printf>
     1ce:	e8 a0 37 00 00       	call   3973 <exit>
     1d3:	52                   	push   %edx
     1d4:	52                   	push   %edx
     1d5:	68 57 3e 00 00       	push   $0x3e57
     1da:	ff 35 18 5f 00 00    	pushl  0x5f18
     1e0:	e8 1b 39 00 00       	call   3b00 <printf>
     1e5:	e8 89 37 00 00       	call   3973 <exit>
     1ea:	51                   	push   %ecx
     1eb:	51                   	push   %ecx
     1ec:	68 36 3e 00 00       	push   $0x3e36
     1f1:	ff 35 18 5f 00 00    	pushl  0x5f18
     1f7:	e8 04 39 00 00       	call   3b00 <printf>
     1fc:	e8 72 37 00 00       	call   3973 <exit>
     201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     208:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     20f:	90                   	nop

00000210 <exitiputtest>:
     210:	f3 0f 1e fb          	endbr32 
     214:	55                   	push   %ebp
     215:	89 e5                	mov    %esp,%ebp
     217:	83 ec 10             	sub    $0x10,%esp
     21a:	68 83 3e 00 00       	push   $0x3e83
     21f:	ff 35 18 5f 00 00    	pushl  0x5f18
     225:	e8 d6 38 00 00       	call   3b00 <printf>
     22a:	e8 3c 37 00 00       	call   396b <fork>
     22f:	83 c4 10             	add    $0x10,%esp
     232:	85 c0                	test   %eax,%eax
     234:	0f 88 86 00 00 00    	js     2c0 <exitiputtest+0xb0>
     23a:	75 4c                	jne    288 <exitiputtest+0x78>
     23c:	83 ec 0c             	sub    $0xc,%esp
     23f:	68 4f 3e 00 00       	push   $0x3e4f
     244:	e8 92 37 00 00       	call   39db <mkdir>
     249:	83 c4 10             	add    $0x10,%esp
     24c:	85 c0                	test   %eax,%eax
     24e:	0f 88 83 00 00 00    	js     2d7 <exitiputtest+0xc7>
     254:	83 ec 0c             	sub    $0xc,%esp
     257:	68 4f 3e 00 00       	push   $0x3e4f
     25c:	e8 82 37 00 00       	call   39e3 <chdir>
     261:	83 c4 10             	add    $0x10,%esp
     264:	85 c0                	test   %eax,%eax
     266:	0f 88 82 00 00 00    	js     2ee <exitiputtest+0xde>
     26c:	83 ec 0c             	sub    $0xc,%esp
     26f:	68 4c 3e 00 00       	push   $0x3e4c
     274:	e8 4a 37 00 00       	call   39c3 <unlink>
     279:	83 c4 10             	add    $0x10,%esp
     27c:	85 c0                	test   %eax,%eax
     27e:	78 28                	js     2a8 <exitiputtest+0x98>
     280:	e8 ee 36 00 00       	call   3973 <exit>
     285:	8d 76 00             	lea    0x0(%esi),%esi
     288:	e8 ee 36 00 00       	call   397b <wait>
     28d:	83 ec 08             	sub    $0x8,%esp
     290:	68 a6 3e 00 00       	push   $0x3ea6
     295:	ff 35 18 5f 00 00    	pushl  0x5f18
     29b:	e8 60 38 00 00       	call   3b00 <printf>
     2a0:	83 c4 10             	add    $0x10,%esp
     2a3:	c9                   	leave  
     2a4:	c3                   	ret    
     2a5:	8d 76 00             	lea    0x0(%esi),%esi
     2a8:	83 ec 08             	sub    $0x8,%esp
     2ab:	68 57 3e 00 00       	push   $0x3e57
     2b0:	ff 35 18 5f 00 00    	pushl  0x5f18
     2b6:	e8 45 38 00 00       	call   3b00 <printf>
     2bb:	e8 b3 36 00 00       	call   3973 <exit>
     2c0:	51                   	push   %ecx
     2c1:	51                   	push   %ecx
     2c2:	68 69 4d 00 00       	push   $0x4d69
     2c7:	ff 35 18 5f 00 00    	pushl  0x5f18
     2cd:	e8 2e 38 00 00       	call   3b00 <printf>
     2d2:	e8 9c 36 00 00       	call   3973 <exit>
     2d7:	52                   	push   %edx
     2d8:	52                   	push   %edx
     2d9:	68 28 3e 00 00       	push   $0x3e28
     2de:	ff 35 18 5f 00 00    	pushl  0x5f18
     2e4:	e8 17 38 00 00       	call   3b00 <printf>
     2e9:	e8 85 36 00 00       	call   3973 <exit>
     2ee:	50                   	push   %eax
     2ef:	50                   	push   %eax
     2f0:	68 92 3e 00 00       	push   $0x3e92
     2f5:	ff 35 18 5f 00 00    	pushl  0x5f18
     2fb:	e8 00 38 00 00       	call   3b00 <printf>
     300:	e8 6e 36 00 00       	call   3973 <exit>
     305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     30c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000310 <openiputtest>:
     310:	f3 0f 1e fb          	endbr32 
     314:	55                   	push   %ebp
     315:	89 e5                	mov    %esp,%ebp
     317:	83 ec 10             	sub    $0x10,%esp
     31a:	68 b8 3e 00 00       	push   $0x3eb8
     31f:	ff 35 18 5f 00 00    	pushl  0x5f18
     325:	e8 d6 37 00 00       	call   3b00 <printf>
     32a:	c7 04 24 c7 3e 00 00 	movl   $0x3ec7,(%esp)
     331:	e8 a5 36 00 00       	call   39db <mkdir>
     336:	83 c4 10             	add    $0x10,%esp
     339:	85 c0                	test   %eax,%eax
     33b:	0f 88 9b 00 00 00    	js     3dc <openiputtest+0xcc>
     341:	e8 25 36 00 00       	call   396b <fork>
     346:	85 c0                	test   %eax,%eax
     348:	78 7b                	js     3c5 <openiputtest+0xb5>
     34a:	75 34                	jne    380 <openiputtest+0x70>
     34c:	83 ec 08             	sub    $0x8,%esp
     34f:	6a 02                	push   $0x2
     351:	68 c7 3e 00 00       	push   $0x3ec7
     356:	e8 58 36 00 00       	call   39b3 <open>
     35b:	83 c4 10             	add    $0x10,%esp
     35e:	85 c0                	test   %eax,%eax
     360:	78 5e                	js     3c0 <openiputtest+0xb0>
     362:	83 ec 08             	sub    $0x8,%esp
     365:	68 4c 4e 00 00       	push   $0x4e4c
     36a:	ff 35 18 5f 00 00    	pushl  0x5f18
     370:	e8 8b 37 00 00       	call   3b00 <printf>
     375:	e8 f9 35 00 00       	call   3973 <exit>
     37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     380:	83 ec 0c             	sub    $0xc,%esp
     383:	6a 01                	push   $0x1
     385:	e8 79 36 00 00       	call   3a03 <sleep>
     38a:	c7 04 24 c7 3e 00 00 	movl   $0x3ec7,(%esp)
     391:	e8 2d 36 00 00       	call   39c3 <unlink>
     396:	83 c4 10             	add    $0x10,%esp
     399:	85 c0                	test   %eax,%eax
     39b:	75 56                	jne    3f3 <openiputtest+0xe3>
     39d:	e8 d9 35 00 00       	call   397b <wait>
     3a2:	83 ec 08             	sub    $0x8,%esp
     3a5:	68 f0 3e 00 00       	push   $0x3ef0
     3aa:	ff 35 18 5f 00 00    	pushl  0x5f18
     3b0:	e8 4b 37 00 00       	call   3b00 <printf>
     3b5:	83 c4 10             	add    $0x10,%esp
     3b8:	c9                   	leave  
     3b9:	c3                   	ret    
     3ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3c0:	e8 ae 35 00 00       	call   3973 <exit>
     3c5:	52                   	push   %edx
     3c6:	52                   	push   %edx
     3c7:	68 69 4d 00 00       	push   $0x4d69
     3cc:	ff 35 18 5f 00 00    	pushl  0x5f18
     3d2:	e8 29 37 00 00       	call   3b00 <printf>
     3d7:	e8 97 35 00 00       	call   3973 <exit>
     3dc:	51                   	push   %ecx
     3dd:	51                   	push   %ecx
     3de:	68 cd 3e 00 00       	push   $0x3ecd
     3e3:	ff 35 18 5f 00 00    	pushl  0x5f18
     3e9:	e8 12 37 00 00       	call   3b00 <printf>
     3ee:	e8 80 35 00 00       	call   3973 <exit>
     3f3:	50                   	push   %eax
     3f4:	50                   	push   %eax
     3f5:	68 e1 3e 00 00       	push   $0x3ee1
     3fa:	ff 35 18 5f 00 00    	pushl  0x5f18
     400:	e8 fb 36 00 00       	call   3b00 <printf>
     405:	e8 69 35 00 00       	call   3973 <exit>
     40a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000410 <opentest>:
     410:	f3 0f 1e fb          	endbr32 
     414:	55                   	push   %ebp
     415:	89 e5                	mov    %esp,%ebp
     417:	83 ec 10             	sub    $0x10,%esp
     41a:	68 02 3f 00 00       	push   $0x3f02
     41f:	ff 35 18 5f 00 00    	pushl  0x5f18
     425:	e8 d6 36 00 00       	call   3b00 <printf>
     42a:	58                   	pop    %eax
     42b:	5a                   	pop    %edx
     42c:	6a 00                	push   $0x0
     42e:	68 0d 3f 00 00       	push   $0x3f0d
     433:	e8 7b 35 00 00       	call   39b3 <open>
     438:	83 c4 10             	add    $0x10,%esp
     43b:	85 c0                	test   %eax,%eax
     43d:	78 36                	js     475 <opentest+0x65>
     43f:	83 ec 0c             	sub    $0xc,%esp
     442:	50                   	push   %eax
     443:	e8 53 35 00 00       	call   399b <close>
     448:	5a                   	pop    %edx
     449:	59                   	pop    %ecx
     44a:	6a 00                	push   $0x0
     44c:	68 25 3f 00 00       	push   $0x3f25
     451:	e8 5d 35 00 00       	call   39b3 <open>
     456:	83 c4 10             	add    $0x10,%esp
     459:	85 c0                	test   %eax,%eax
     45b:	79 2f                	jns    48c <opentest+0x7c>
     45d:	83 ec 08             	sub    $0x8,%esp
     460:	68 50 3f 00 00       	push   $0x3f50
     465:	ff 35 18 5f 00 00    	pushl  0x5f18
     46b:	e8 90 36 00 00       	call   3b00 <printf>
     470:	83 c4 10             	add    $0x10,%esp
     473:	c9                   	leave  
     474:	c3                   	ret    
     475:	50                   	push   %eax
     476:	50                   	push   %eax
     477:	68 12 3f 00 00       	push   $0x3f12
     47c:	ff 35 18 5f 00 00    	pushl  0x5f18
     482:	e8 79 36 00 00       	call   3b00 <printf>
     487:	e8 e7 34 00 00       	call   3973 <exit>
     48c:	50                   	push   %eax
     48d:	50                   	push   %eax
     48e:	68 32 3f 00 00       	push   $0x3f32
     493:	ff 35 18 5f 00 00    	pushl  0x5f18
     499:	e8 62 36 00 00       	call   3b00 <printf>
     49e:	e8 d0 34 00 00       	call   3973 <exit>
     4a3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     4aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000004b0 <writetest>:
     4b0:	f3 0f 1e fb          	endbr32 
     4b4:	55                   	push   %ebp
     4b5:	89 e5                	mov    %esp,%ebp
     4b7:	56                   	push   %esi
     4b8:	53                   	push   %ebx
     4b9:	83 ec 08             	sub    $0x8,%esp
     4bc:	68 5e 3f 00 00       	push   $0x3f5e
     4c1:	ff 35 18 5f 00 00    	pushl  0x5f18
     4c7:	e8 34 36 00 00       	call   3b00 <printf>
     4cc:	58                   	pop    %eax
     4cd:	5a                   	pop    %edx
     4ce:	68 02 02 00 00       	push   $0x202
     4d3:	68 6f 3f 00 00       	push   $0x3f6f
     4d8:	e8 d6 34 00 00       	call   39b3 <open>
     4dd:	83 c4 10             	add    $0x10,%esp
     4e0:	85 c0                	test   %eax,%eax
     4e2:	0f 88 8c 01 00 00    	js     674 <writetest+0x1c4>
     4e8:	83 ec 08             	sub    $0x8,%esp
     4eb:	89 c6                	mov    %eax,%esi
     4ed:	31 db                	xor    %ebx,%ebx
     4ef:	68 75 3f 00 00       	push   $0x3f75
     4f4:	ff 35 18 5f 00 00    	pushl  0x5f18
     4fa:	e8 01 36 00 00       	call   3b00 <printf>
     4ff:	83 c4 10             	add    $0x10,%esp
     502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     508:	83 ec 04             	sub    $0x4,%esp
     50b:	6a 0a                	push   $0xa
     50d:	68 ac 3f 00 00       	push   $0x3fac
     512:	56                   	push   %esi
     513:	e8 7b 34 00 00       	call   3993 <write>
     518:	83 c4 10             	add    $0x10,%esp
     51b:	83 f8 0a             	cmp    $0xa,%eax
     51e:	0f 85 d9 00 00 00    	jne    5fd <writetest+0x14d>
     524:	83 ec 04             	sub    $0x4,%esp
     527:	6a 0a                	push   $0xa
     529:	68 b7 3f 00 00       	push   $0x3fb7
     52e:	56                   	push   %esi
     52f:	e8 5f 34 00 00       	call   3993 <write>
     534:	83 c4 10             	add    $0x10,%esp
     537:	83 f8 0a             	cmp    $0xa,%eax
     53a:	0f 85 d6 00 00 00    	jne    616 <writetest+0x166>
     540:	83 c3 01             	add    $0x1,%ebx
     543:	83 fb 64             	cmp    $0x64,%ebx
     546:	75 c0                	jne    508 <writetest+0x58>
     548:	83 ec 08             	sub    $0x8,%esp
     54b:	68 c2 3f 00 00       	push   $0x3fc2
     550:	ff 35 18 5f 00 00    	pushl  0x5f18
     556:	e8 a5 35 00 00       	call   3b00 <printf>
     55b:	89 34 24             	mov    %esi,(%esp)
     55e:	e8 38 34 00 00       	call   399b <close>
     563:	5b                   	pop    %ebx
     564:	5e                   	pop    %esi
     565:	6a 00                	push   $0x0
     567:	68 6f 3f 00 00       	push   $0x3f6f
     56c:	e8 42 34 00 00       	call   39b3 <open>
     571:	83 c4 10             	add    $0x10,%esp
     574:	89 c3                	mov    %eax,%ebx
     576:	85 c0                	test   %eax,%eax
     578:	0f 88 b1 00 00 00    	js     62f <writetest+0x17f>
     57e:	83 ec 08             	sub    $0x8,%esp
     581:	68 cd 3f 00 00       	push   $0x3fcd
     586:	ff 35 18 5f 00 00    	pushl  0x5f18
     58c:	e8 6f 35 00 00       	call   3b00 <printf>
     591:	83 c4 0c             	add    $0xc,%esp
     594:	68 d0 07 00 00       	push   $0x7d0
     599:	68 00 87 00 00       	push   $0x8700
     59e:	53                   	push   %ebx
     59f:	e8 e7 33 00 00       	call   398b <read>
     5a4:	83 c4 10             	add    $0x10,%esp
     5a7:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     5ac:	0f 85 94 00 00 00    	jne    646 <writetest+0x196>
     5b2:	83 ec 08             	sub    $0x8,%esp
     5b5:	68 01 40 00 00       	push   $0x4001
     5ba:	ff 35 18 5f 00 00    	pushl  0x5f18
     5c0:	e8 3b 35 00 00       	call   3b00 <printf>
     5c5:	89 1c 24             	mov    %ebx,(%esp)
     5c8:	e8 ce 33 00 00       	call   399b <close>
     5cd:	c7 04 24 6f 3f 00 00 	movl   $0x3f6f,(%esp)
     5d4:	e8 ea 33 00 00       	call   39c3 <unlink>
     5d9:	83 c4 10             	add    $0x10,%esp
     5dc:	85 c0                	test   %eax,%eax
     5de:	78 7d                	js     65d <writetest+0x1ad>
     5e0:	83 ec 08             	sub    $0x8,%esp
     5e3:	68 29 40 00 00       	push   $0x4029
     5e8:	ff 35 18 5f 00 00    	pushl  0x5f18
     5ee:	e8 0d 35 00 00       	call   3b00 <printf>
     5f3:	83 c4 10             	add    $0x10,%esp
     5f6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     5f9:	5b                   	pop    %ebx
     5fa:	5e                   	pop    %esi
     5fb:	5d                   	pop    %ebp
     5fc:	c3                   	ret    
     5fd:	83 ec 04             	sub    $0x4,%esp
     600:	53                   	push   %ebx
     601:	68 70 4e 00 00       	push   $0x4e70
     606:	ff 35 18 5f 00 00    	pushl  0x5f18
     60c:	e8 ef 34 00 00       	call   3b00 <printf>
     611:	e8 5d 33 00 00       	call   3973 <exit>
     616:	83 ec 04             	sub    $0x4,%esp
     619:	53                   	push   %ebx
     61a:	68 94 4e 00 00       	push   $0x4e94
     61f:	ff 35 18 5f 00 00    	pushl  0x5f18
     625:	e8 d6 34 00 00       	call   3b00 <printf>
     62a:	e8 44 33 00 00       	call   3973 <exit>
     62f:	51                   	push   %ecx
     630:	51                   	push   %ecx
     631:	68 e6 3f 00 00       	push   $0x3fe6
     636:	ff 35 18 5f 00 00    	pushl  0x5f18
     63c:	e8 bf 34 00 00       	call   3b00 <printf>
     641:	e8 2d 33 00 00       	call   3973 <exit>
     646:	52                   	push   %edx
     647:	52                   	push   %edx
     648:	68 2d 43 00 00       	push   $0x432d
     64d:	ff 35 18 5f 00 00    	pushl  0x5f18
     653:	e8 a8 34 00 00       	call   3b00 <printf>
     658:	e8 16 33 00 00       	call   3973 <exit>
     65d:	50                   	push   %eax
     65e:	50                   	push   %eax
     65f:	68 14 40 00 00       	push   $0x4014
     664:	ff 35 18 5f 00 00    	pushl  0x5f18
     66a:	e8 91 34 00 00       	call   3b00 <printf>
     66f:	e8 ff 32 00 00       	call   3973 <exit>
     674:	50                   	push   %eax
     675:	50                   	push   %eax
     676:	68 90 3f 00 00       	push   $0x3f90
     67b:	ff 35 18 5f 00 00    	pushl  0x5f18
     681:	e8 7a 34 00 00       	call   3b00 <printf>
     686:	e8 e8 32 00 00       	call   3973 <exit>
     68b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     68f:	90                   	nop

00000690 <writetest1>:
     690:	f3 0f 1e fb          	endbr32 
     694:	55                   	push   %ebp
     695:	89 e5                	mov    %esp,%ebp
     697:	56                   	push   %esi
     698:	53                   	push   %ebx
     699:	83 ec 08             	sub    $0x8,%esp
     69c:	68 3d 40 00 00       	push   $0x403d
     6a1:	ff 35 18 5f 00 00    	pushl  0x5f18
     6a7:	e8 54 34 00 00       	call   3b00 <printf>
     6ac:	58                   	pop    %eax
     6ad:	5a                   	pop    %edx
     6ae:	68 02 02 00 00       	push   $0x202
     6b3:	68 b7 40 00 00       	push   $0x40b7
     6b8:	e8 f6 32 00 00       	call   39b3 <open>
     6bd:	83 c4 10             	add    $0x10,%esp
     6c0:	85 c0                	test   %eax,%eax
     6c2:	0f 88 5d 01 00 00    	js     825 <writetest1+0x195>
     6c8:	89 c6                	mov    %eax,%esi
     6ca:	31 db                	xor    %ebx,%ebx
     6cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     6d0:	83 ec 04             	sub    $0x4,%esp
     6d3:	89 1d 00 87 00 00    	mov    %ebx,0x8700
     6d9:	68 00 02 00 00       	push   $0x200
     6de:	68 00 87 00 00       	push   $0x8700
     6e3:	56                   	push   %esi
     6e4:	e8 aa 32 00 00       	call   3993 <write>
     6e9:	83 c4 10             	add    $0x10,%esp
     6ec:	3d 00 02 00 00       	cmp    $0x200,%eax
     6f1:	0f 85 b3 00 00 00    	jne    7aa <writetest1+0x11a>
     6f7:	83 c3 01             	add    $0x1,%ebx
     6fa:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     700:	75 ce                	jne    6d0 <writetest1+0x40>
     702:	83 ec 0c             	sub    $0xc,%esp
     705:	56                   	push   %esi
     706:	e8 90 32 00 00       	call   399b <close>
     70b:	5b                   	pop    %ebx
     70c:	5e                   	pop    %esi
     70d:	6a 00                	push   $0x0
     70f:	68 b7 40 00 00       	push   $0x40b7
     714:	e8 9a 32 00 00       	call   39b3 <open>
     719:	83 c4 10             	add    $0x10,%esp
     71c:	89 c3                	mov    %eax,%ebx
     71e:	85 c0                	test   %eax,%eax
     720:	0f 88 e8 00 00 00    	js     80e <writetest1+0x17e>
     726:	31 f6                	xor    %esi,%esi
     728:	eb 1d                	jmp    747 <writetest1+0xb7>
     72a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     730:	3d 00 02 00 00       	cmp    $0x200,%eax
     735:	0f 85 9f 00 00 00    	jne    7da <writetest1+0x14a>
     73b:	a1 00 87 00 00       	mov    0x8700,%eax
     740:	39 f0                	cmp    %esi,%eax
     742:	75 7f                	jne    7c3 <writetest1+0x133>
     744:	83 c6 01             	add    $0x1,%esi
     747:	83 ec 04             	sub    $0x4,%esp
     74a:	68 00 02 00 00       	push   $0x200
     74f:	68 00 87 00 00       	push   $0x8700
     754:	53                   	push   %ebx
     755:	e8 31 32 00 00       	call   398b <read>
     75a:	83 c4 10             	add    $0x10,%esp
     75d:	85 c0                	test   %eax,%eax
     75f:	75 cf                	jne    730 <writetest1+0xa0>
     761:	81 fe 8b 00 00 00    	cmp    $0x8b,%esi
     767:	0f 84 86 00 00 00    	je     7f3 <writetest1+0x163>
     76d:	83 ec 0c             	sub    $0xc,%esp
     770:	53                   	push   %ebx
     771:	e8 25 32 00 00       	call   399b <close>
     776:	c7 04 24 b7 40 00 00 	movl   $0x40b7,(%esp)
     77d:	e8 41 32 00 00       	call   39c3 <unlink>
     782:	83 c4 10             	add    $0x10,%esp
     785:	85 c0                	test   %eax,%eax
     787:	0f 88 af 00 00 00    	js     83c <writetest1+0x1ac>
     78d:	83 ec 08             	sub    $0x8,%esp
     790:	68 de 40 00 00       	push   $0x40de
     795:	ff 35 18 5f 00 00    	pushl  0x5f18
     79b:	e8 60 33 00 00       	call   3b00 <printf>
     7a0:	83 c4 10             	add    $0x10,%esp
     7a3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     7a6:	5b                   	pop    %ebx
     7a7:	5e                   	pop    %esi
     7a8:	5d                   	pop    %ebp
     7a9:	c3                   	ret    
     7aa:	83 ec 04             	sub    $0x4,%esp
     7ad:	53                   	push   %ebx
     7ae:	68 67 40 00 00       	push   $0x4067
     7b3:	ff 35 18 5f 00 00    	pushl  0x5f18
     7b9:	e8 42 33 00 00       	call   3b00 <printf>
     7be:	e8 b0 31 00 00       	call   3973 <exit>
     7c3:	50                   	push   %eax
     7c4:	56                   	push   %esi
     7c5:	68 b8 4e 00 00       	push   $0x4eb8
     7ca:	ff 35 18 5f 00 00    	pushl  0x5f18
     7d0:	e8 2b 33 00 00       	call   3b00 <printf>
     7d5:	e8 99 31 00 00       	call   3973 <exit>
     7da:	83 ec 04             	sub    $0x4,%esp
     7dd:	50                   	push   %eax
     7de:	68 bb 40 00 00       	push   $0x40bb
     7e3:	ff 35 18 5f 00 00    	pushl  0x5f18
     7e9:	e8 12 33 00 00       	call   3b00 <printf>
     7ee:	e8 80 31 00 00       	call   3973 <exit>
     7f3:	52                   	push   %edx
     7f4:	68 8b 00 00 00       	push   $0x8b
     7f9:	68 9e 40 00 00       	push   $0x409e
     7fe:	ff 35 18 5f 00 00    	pushl  0x5f18
     804:	e8 f7 32 00 00       	call   3b00 <printf>
     809:	e8 65 31 00 00       	call   3973 <exit>
     80e:	51                   	push   %ecx
     80f:	51                   	push   %ecx
     810:	68 85 40 00 00       	push   $0x4085
     815:	ff 35 18 5f 00 00    	pushl  0x5f18
     81b:	e8 e0 32 00 00       	call   3b00 <printf>
     820:	e8 4e 31 00 00       	call   3973 <exit>
     825:	50                   	push   %eax
     826:	50                   	push   %eax
     827:	68 4d 40 00 00       	push   $0x404d
     82c:	ff 35 18 5f 00 00    	pushl  0x5f18
     832:	e8 c9 32 00 00       	call   3b00 <printf>
     837:	e8 37 31 00 00       	call   3973 <exit>
     83c:	50                   	push   %eax
     83d:	50                   	push   %eax
     83e:	68 cb 40 00 00       	push   $0x40cb
     843:	ff 35 18 5f 00 00    	pushl  0x5f18
     849:	e8 b2 32 00 00       	call   3b00 <printf>
     84e:	e8 20 31 00 00       	call   3973 <exit>
     853:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     85a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000860 <createtest>:
     860:	f3 0f 1e fb          	endbr32 
     864:	55                   	push   %ebp
     865:	89 e5                	mov    %esp,%ebp
     867:	53                   	push   %ebx
     868:	bb 30 00 00 00       	mov    $0x30,%ebx
     86d:	83 ec 0c             	sub    $0xc,%esp
     870:	68 d8 4e 00 00       	push   $0x4ed8
     875:	ff 35 18 5f 00 00    	pushl  0x5f18
     87b:	e8 80 32 00 00       	call   3b00 <printf>
     880:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
     887:	83 c4 10             	add    $0x10,%esp
     88a:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     891:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     898:	83 ec 08             	sub    $0x8,%esp
     89b:	88 1d 01 a7 00 00    	mov    %bl,0xa701
     8a1:	83 c3 01             	add    $0x1,%ebx
     8a4:	68 02 02 00 00       	push   $0x202
     8a9:	68 00 a7 00 00       	push   $0xa700
     8ae:	e8 00 31 00 00       	call   39b3 <open>
     8b3:	89 04 24             	mov    %eax,(%esp)
     8b6:	e8 e0 30 00 00       	call   399b <close>
     8bb:	83 c4 10             	add    $0x10,%esp
     8be:	80 fb 64             	cmp    $0x64,%bl
     8c1:	75 d5                	jne    898 <createtest+0x38>
     8c3:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
     8ca:	bb 30 00 00 00       	mov    $0x30,%ebx
     8cf:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     8d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     8dd:	8d 76 00             	lea    0x0(%esi),%esi
     8e0:	83 ec 0c             	sub    $0xc,%esp
     8e3:	88 1d 01 a7 00 00    	mov    %bl,0xa701
     8e9:	83 c3 01             	add    $0x1,%ebx
     8ec:	68 00 a7 00 00       	push   $0xa700
     8f1:	e8 cd 30 00 00       	call   39c3 <unlink>
     8f6:	83 c4 10             	add    $0x10,%esp
     8f9:	80 fb 64             	cmp    $0x64,%bl
     8fc:	75 e2                	jne    8e0 <createtest+0x80>
     8fe:	83 ec 08             	sub    $0x8,%esp
     901:	68 00 4f 00 00       	push   $0x4f00
     906:	ff 35 18 5f 00 00    	pushl  0x5f18
     90c:	e8 ef 31 00 00       	call   3b00 <printf>
     911:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     914:	83 c4 10             	add    $0x10,%esp
     917:	c9                   	leave  
     918:	c3                   	ret    
     919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000920 <dirtest>:
     920:	f3 0f 1e fb          	endbr32 
     924:	55                   	push   %ebp
     925:	89 e5                	mov    %esp,%ebp
     927:	83 ec 10             	sub    $0x10,%esp
     92a:	68 ec 40 00 00       	push   $0x40ec
     92f:	ff 35 18 5f 00 00    	pushl  0x5f18
     935:	e8 c6 31 00 00       	call   3b00 <printf>
     93a:	c7 04 24 f8 40 00 00 	movl   $0x40f8,(%esp)
     941:	e8 95 30 00 00       	call   39db <mkdir>
     946:	83 c4 10             	add    $0x10,%esp
     949:	85 c0                	test   %eax,%eax
     94b:	78 58                	js     9a5 <dirtest+0x85>
     94d:	83 ec 0c             	sub    $0xc,%esp
     950:	68 f8 40 00 00       	push   $0x40f8
     955:	e8 89 30 00 00       	call   39e3 <chdir>
     95a:	83 c4 10             	add    $0x10,%esp
     95d:	85 c0                	test   %eax,%eax
     95f:	0f 88 85 00 00 00    	js     9ea <dirtest+0xca>
     965:	83 ec 0c             	sub    $0xc,%esp
     968:	68 9d 46 00 00       	push   $0x469d
     96d:	e8 71 30 00 00       	call   39e3 <chdir>
     972:	83 c4 10             	add    $0x10,%esp
     975:	85 c0                	test   %eax,%eax
     977:	78 5a                	js     9d3 <dirtest+0xb3>
     979:	83 ec 0c             	sub    $0xc,%esp
     97c:	68 f8 40 00 00       	push   $0x40f8
     981:	e8 3d 30 00 00       	call   39c3 <unlink>
     986:	83 c4 10             	add    $0x10,%esp
     989:	85 c0                	test   %eax,%eax
     98b:	78 2f                	js     9bc <dirtest+0x9c>
     98d:	83 ec 08             	sub    $0x8,%esp
     990:	68 35 41 00 00       	push   $0x4135
     995:	ff 35 18 5f 00 00    	pushl  0x5f18
     99b:	e8 60 31 00 00       	call   3b00 <printf>
     9a0:	83 c4 10             	add    $0x10,%esp
     9a3:	c9                   	leave  
     9a4:	c3                   	ret    
     9a5:	50                   	push   %eax
     9a6:	50                   	push   %eax
     9a7:	68 28 3e 00 00       	push   $0x3e28
     9ac:	ff 35 18 5f 00 00    	pushl  0x5f18
     9b2:	e8 49 31 00 00       	call   3b00 <printf>
     9b7:	e8 b7 2f 00 00       	call   3973 <exit>
     9bc:	50                   	push   %eax
     9bd:	50                   	push   %eax
     9be:	68 21 41 00 00       	push   $0x4121
     9c3:	ff 35 18 5f 00 00    	pushl  0x5f18
     9c9:	e8 32 31 00 00       	call   3b00 <printf>
     9ce:	e8 a0 2f 00 00       	call   3973 <exit>
     9d3:	52                   	push   %edx
     9d4:	52                   	push   %edx
     9d5:	68 10 41 00 00       	push   $0x4110
     9da:	ff 35 18 5f 00 00    	pushl  0x5f18
     9e0:	e8 1b 31 00 00       	call   3b00 <printf>
     9e5:	e8 89 2f 00 00       	call   3973 <exit>
     9ea:	51                   	push   %ecx
     9eb:	51                   	push   %ecx
     9ec:	68 fd 40 00 00       	push   $0x40fd
     9f1:	ff 35 18 5f 00 00    	pushl  0x5f18
     9f7:	e8 04 31 00 00       	call   3b00 <printf>
     9fc:	e8 72 2f 00 00       	call   3973 <exit>
     a01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     a0f:	90                   	nop

00000a10 <exectest>:
     a10:	f3 0f 1e fb          	endbr32 
     a14:	55                   	push   %ebp
     a15:	89 e5                	mov    %esp,%ebp
     a17:	83 ec 10             	sub    $0x10,%esp
     a1a:	68 44 41 00 00       	push   $0x4144
     a1f:	ff 35 18 5f 00 00    	pushl  0x5f18
     a25:	e8 d6 30 00 00       	call   3b00 <printf>
     a2a:	5a                   	pop    %edx
     a2b:	59                   	pop    %ecx
     a2c:	68 1c 5f 00 00       	push   $0x5f1c
     a31:	68 0d 3f 00 00       	push   $0x3f0d
     a36:	e8 70 2f 00 00       	call   39ab <exec>
     a3b:	83 c4 10             	add    $0x10,%esp
     a3e:	85 c0                	test   %eax,%eax
     a40:	78 02                	js     a44 <exectest+0x34>
     a42:	c9                   	leave  
     a43:	c3                   	ret    
     a44:	50                   	push   %eax
     a45:	50                   	push   %eax
     a46:	68 4f 41 00 00       	push   $0x414f
     a4b:	ff 35 18 5f 00 00    	pushl  0x5f18
     a51:	e8 aa 30 00 00       	call   3b00 <printf>
     a56:	e8 18 2f 00 00       	call   3973 <exit>
     a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     a5f:	90                   	nop

00000a60 <pipe1>:
     a60:	f3 0f 1e fb          	endbr32 
     a64:	55                   	push   %ebp
     a65:	89 e5                	mov    %esp,%ebp
     a67:	57                   	push   %edi
     a68:	56                   	push   %esi
     a69:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a6c:	53                   	push   %ebx
     a6d:	83 ec 38             	sub    $0x38,%esp
     a70:	50                   	push   %eax
     a71:	e8 0d 2f 00 00       	call   3983 <pipe>
     a76:	83 c4 10             	add    $0x10,%esp
     a79:	85 c0                	test   %eax,%eax
     a7b:	0f 85 38 01 00 00    	jne    bb9 <pipe1+0x159>
     a81:	e8 e5 2e 00 00       	call   396b <fork>
     a86:	85 c0                	test   %eax,%eax
     a88:	0f 84 8d 00 00 00    	je     b1b <pipe1+0xbb>
     a8e:	0f 8e 38 01 00 00    	jle    bcc <pipe1+0x16c>
     a94:	83 ec 0c             	sub    $0xc,%esp
     a97:	ff 75 e4             	pushl  -0x1c(%ebp)
     a9a:	31 db                	xor    %ebx,%ebx
     a9c:	be 01 00 00 00       	mov    $0x1,%esi
     aa1:	e8 f5 2e 00 00       	call   399b <close>
     aa6:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
     aad:	83 c4 10             	add    $0x10,%esp
     ab0:	83 ec 04             	sub    $0x4,%esp
     ab3:	56                   	push   %esi
     ab4:	68 00 87 00 00       	push   $0x8700
     ab9:	ff 75 e0             	pushl  -0x20(%ebp)
     abc:	e8 ca 2e 00 00       	call   398b <read>
     ac1:	83 c4 10             	add    $0x10,%esp
     ac4:	89 c7                	mov    %eax,%edi
     ac6:	85 c0                	test   %eax,%eax
     ac8:	0f 8e a7 00 00 00    	jle    b75 <pipe1+0x115>
     ace:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
     ad1:	31 c0                	xor    %eax,%eax
     ad3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad7:	90                   	nop
     ad8:	89 da                	mov    %ebx,%edx
     ada:	83 c3 01             	add    $0x1,%ebx
     add:	38 90 00 87 00 00    	cmp    %dl,0x8700(%eax)
     ae3:	75 1c                	jne    b01 <pipe1+0xa1>
     ae5:	83 c0 01             	add    $0x1,%eax
     ae8:	39 d9                	cmp    %ebx,%ecx
     aea:	75 ec                	jne    ad8 <pipe1+0x78>
     aec:	01 f6                	add    %esi,%esi
     aee:	01 7d d4             	add    %edi,-0x2c(%ebp)
     af1:	b8 00 20 00 00       	mov    $0x2000,%eax
     af6:	81 fe 00 20 00 00    	cmp    $0x2000,%esi
     afc:	0f 4f f0             	cmovg  %eax,%esi
     aff:	eb af                	jmp    ab0 <pipe1+0x50>
     b01:	83 ec 08             	sub    $0x8,%esp
     b04:	68 7e 41 00 00       	push   $0x417e
     b09:	6a 01                	push   $0x1
     b0b:	e8 f0 2f 00 00       	call   3b00 <printf>
     b10:	83 c4 10             	add    $0x10,%esp
     b13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b16:	5b                   	pop    %ebx
     b17:	5e                   	pop    %esi
     b18:	5f                   	pop    %edi
     b19:	5d                   	pop    %ebp
     b1a:	c3                   	ret    
     b1b:	83 ec 0c             	sub    $0xc,%esp
     b1e:	ff 75 e0             	pushl  -0x20(%ebp)
     b21:	31 db                	xor    %ebx,%ebx
     b23:	e8 73 2e 00 00       	call   399b <close>
     b28:	83 c4 10             	add    $0x10,%esp
     b2b:	31 c0                	xor    %eax,%eax
     b2d:	8d 76 00             	lea    0x0(%esi),%esi
     b30:	8d 14 18             	lea    (%eax,%ebx,1),%edx
     b33:	83 c0 01             	add    $0x1,%eax
     b36:	88 90 ff 86 00 00    	mov    %dl,0x86ff(%eax)
     b3c:	3d 09 04 00 00       	cmp    $0x409,%eax
     b41:	75 ed                	jne    b30 <pipe1+0xd0>
     b43:	83 ec 04             	sub    $0x4,%esp
     b46:	81 c3 09 04 00 00    	add    $0x409,%ebx
     b4c:	68 09 04 00 00       	push   $0x409
     b51:	68 00 87 00 00       	push   $0x8700
     b56:	ff 75 e4             	pushl  -0x1c(%ebp)
     b59:	e8 35 2e 00 00       	call   3993 <write>
     b5e:	83 c4 10             	add    $0x10,%esp
     b61:	3d 09 04 00 00       	cmp    $0x409,%eax
     b66:	75 77                	jne    bdf <pipe1+0x17f>
     b68:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b6e:	75 bb                	jne    b2b <pipe1+0xcb>
     b70:	e8 fe 2d 00 00       	call   3973 <exit>
     b75:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b7c:	75 26                	jne    ba4 <pipe1+0x144>
     b7e:	83 ec 0c             	sub    $0xc,%esp
     b81:	ff 75 e0             	pushl  -0x20(%ebp)
     b84:	e8 12 2e 00 00       	call   399b <close>
     b89:	e8 ed 2d 00 00       	call   397b <wait>
     b8e:	5a                   	pop    %edx
     b8f:	59                   	pop    %ecx
     b90:	68 a3 41 00 00       	push   $0x41a3
     b95:	6a 01                	push   $0x1
     b97:	e8 64 2f 00 00       	call   3b00 <printf>
     b9c:	83 c4 10             	add    $0x10,%esp
     b9f:	e9 6f ff ff ff       	jmp    b13 <pipe1+0xb3>
     ba4:	53                   	push   %ebx
     ba5:	ff 75 d4             	pushl  -0x2c(%ebp)
     ba8:	68 8c 41 00 00       	push   $0x418c
     bad:	6a 01                	push   $0x1
     baf:	e8 4c 2f 00 00       	call   3b00 <printf>
     bb4:	e8 ba 2d 00 00       	call   3973 <exit>
     bb9:	57                   	push   %edi
     bba:	57                   	push   %edi
     bbb:	68 61 41 00 00       	push   $0x4161
     bc0:	6a 01                	push   $0x1
     bc2:	e8 39 2f 00 00       	call   3b00 <printf>
     bc7:	e8 a7 2d 00 00       	call   3973 <exit>
     bcc:	50                   	push   %eax
     bcd:	50                   	push   %eax
     bce:	68 ad 41 00 00       	push   $0x41ad
     bd3:	6a 01                	push   $0x1
     bd5:	e8 26 2f 00 00       	call   3b00 <printf>
     bda:	e8 94 2d 00 00       	call   3973 <exit>
     bdf:	56                   	push   %esi
     be0:	56                   	push   %esi
     be1:	68 70 41 00 00       	push   $0x4170
     be6:	6a 01                	push   $0x1
     be8:	e8 13 2f 00 00       	call   3b00 <printf>
     bed:	e8 81 2d 00 00       	call   3973 <exit>
     bf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000c00 <preempt>:
     c00:	f3 0f 1e fb          	endbr32 
     c04:	55                   	push   %ebp
     c05:	89 e5                	mov    %esp,%ebp
     c07:	57                   	push   %edi
     c08:	56                   	push   %esi
     c09:	53                   	push   %ebx
     c0a:	83 ec 24             	sub    $0x24,%esp
     c0d:	68 bc 41 00 00       	push   $0x41bc
     c12:	6a 01                	push   $0x1
     c14:	e8 e7 2e 00 00       	call   3b00 <printf>
     c19:	e8 4d 2d 00 00       	call   396b <fork>
     c1e:	83 c4 10             	add    $0x10,%esp
     c21:	85 c0                	test   %eax,%eax
     c23:	75 0b                	jne    c30 <preempt+0x30>
     c25:	eb fe                	jmp    c25 <preempt+0x25>
     c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     c2e:	66 90                	xchg   %ax,%ax
     c30:	89 c7                	mov    %eax,%edi
     c32:	e8 34 2d 00 00       	call   396b <fork>
     c37:	89 c6                	mov    %eax,%esi
     c39:	85 c0                	test   %eax,%eax
     c3b:	75 03                	jne    c40 <preempt+0x40>
     c3d:	eb fe                	jmp    c3d <preempt+0x3d>
     c3f:	90                   	nop
     c40:	83 ec 0c             	sub    $0xc,%esp
     c43:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c46:	50                   	push   %eax
     c47:	e8 37 2d 00 00       	call   3983 <pipe>
     c4c:	e8 1a 2d 00 00       	call   396b <fork>
     c51:	83 c4 10             	add    $0x10,%esp
     c54:	89 c3                	mov    %eax,%ebx
     c56:	85 c0                	test   %eax,%eax
     c58:	75 3e                	jne    c98 <preempt+0x98>
     c5a:	83 ec 0c             	sub    $0xc,%esp
     c5d:	ff 75 e0             	pushl  -0x20(%ebp)
     c60:	e8 36 2d 00 00       	call   399b <close>
     c65:	83 c4 0c             	add    $0xc,%esp
     c68:	6a 01                	push   $0x1
     c6a:	68 81 47 00 00       	push   $0x4781
     c6f:	ff 75 e4             	pushl  -0x1c(%ebp)
     c72:	e8 1c 2d 00 00       	call   3993 <write>
     c77:	83 c4 10             	add    $0x10,%esp
     c7a:	83 f8 01             	cmp    $0x1,%eax
     c7d:	0f 85 a4 00 00 00    	jne    d27 <preempt+0x127>
     c83:	83 ec 0c             	sub    $0xc,%esp
     c86:	ff 75 e4             	pushl  -0x1c(%ebp)
     c89:	e8 0d 2d 00 00       	call   399b <close>
     c8e:	83 c4 10             	add    $0x10,%esp
     c91:	eb fe                	jmp    c91 <preempt+0x91>
     c93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c97:	90                   	nop
     c98:	83 ec 0c             	sub    $0xc,%esp
     c9b:	ff 75 e4             	pushl  -0x1c(%ebp)
     c9e:	e8 f8 2c 00 00       	call   399b <close>
     ca3:	83 c4 0c             	add    $0xc,%esp
     ca6:	68 00 20 00 00       	push   $0x2000
     cab:	68 00 87 00 00       	push   $0x8700
     cb0:	ff 75 e0             	pushl  -0x20(%ebp)
     cb3:	e8 d3 2c 00 00       	call   398b <read>
     cb8:	83 c4 10             	add    $0x10,%esp
     cbb:	83 f8 01             	cmp    $0x1,%eax
     cbe:	75 7e                	jne    d3e <preempt+0x13e>
     cc0:	83 ec 0c             	sub    $0xc,%esp
     cc3:	ff 75 e0             	pushl  -0x20(%ebp)
     cc6:	e8 d0 2c 00 00       	call   399b <close>
     ccb:	58                   	pop    %eax
     ccc:	5a                   	pop    %edx
     ccd:	68 ed 41 00 00       	push   $0x41ed
     cd2:	6a 01                	push   $0x1
     cd4:	e8 27 2e 00 00       	call   3b00 <printf>
     cd9:	89 3c 24             	mov    %edi,(%esp)
     cdc:	e8 c2 2c 00 00       	call   39a3 <kill>
     ce1:	89 34 24             	mov    %esi,(%esp)
     ce4:	e8 ba 2c 00 00       	call   39a3 <kill>
     ce9:	89 1c 24             	mov    %ebx,(%esp)
     cec:	e8 b2 2c 00 00       	call   39a3 <kill>
     cf1:	59                   	pop    %ecx
     cf2:	5b                   	pop    %ebx
     cf3:	68 f6 41 00 00       	push   $0x41f6
     cf8:	6a 01                	push   $0x1
     cfa:	e8 01 2e 00 00       	call   3b00 <printf>
     cff:	e8 77 2c 00 00       	call   397b <wait>
     d04:	e8 72 2c 00 00       	call   397b <wait>
     d09:	e8 6d 2c 00 00       	call   397b <wait>
     d0e:	5e                   	pop    %esi
     d0f:	5f                   	pop    %edi
     d10:	68 ff 41 00 00       	push   $0x41ff
     d15:	6a 01                	push   $0x1
     d17:	e8 e4 2d 00 00       	call   3b00 <printf>
     d1c:	83 c4 10             	add    $0x10,%esp
     d1f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d22:	5b                   	pop    %ebx
     d23:	5e                   	pop    %esi
     d24:	5f                   	pop    %edi
     d25:	5d                   	pop    %ebp
     d26:	c3                   	ret    
     d27:	83 ec 08             	sub    $0x8,%esp
     d2a:	68 c6 41 00 00       	push   $0x41c6
     d2f:	6a 01                	push   $0x1
     d31:	e8 ca 2d 00 00       	call   3b00 <printf>
     d36:	83 c4 10             	add    $0x10,%esp
     d39:	e9 45 ff ff ff       	jmp    c83 <preempt+0x83>
     d3e:	83 ec 08             	sub    $0x8,%esp
     d41:	68 da 41 00 00       	push   $0x41da
     d46:	6a 01                	push   $0x1
     d48:	e8 b3 2d 00 00       	call   3b00 <printf>
     d4d:	83 c4 10             	add    $0x10,%esp
     d50:	eb cd                	jmp    d1f <preempt+0x11f>
     d52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d60 <exitwait>:
     d60:	f3 0f 1e fb          	endbr32 
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	56                   	push   %esi
     d68:	be 64 00 00 00       	mov    $0x64,%esi
     d6d:	53                   	push   %ebx
     d6e:	eb 10                	jmp    d80 <exitwait+0x20>
     d70:	74 68                	je     dda <exitwait+0x7a>
     d72:	e8 04 2c 00 00       	call   397b <wait>
     d77:	39 d8                	cmp    %ebx,%eax
     d79:	75 2d                	jne    da8 <exitwait+0x48>
     d7b:	83 ee 01             	sub    $0x1,%esi
     d7e:	74 41                	je     dc1 <exitwait+0x61>
     d80:	e8 e6 2b 00 00       	call   396b <fork>
     d85:	89 c3                	mov    %eax,%ebx
     d87:	85 c0                	test   %eax,%eax
     d89:	79 e5                	jns    d70 <exitwait+0x10>
     d8b:	83 ec 08             	sub    $0x8,%esp
     d8e:	68 69 4d 00 00       	push   $0x4d69
     d93:	6a 01                	push   $0x1
     d95:	e8 66 2d 00 00       	call   3b00 <printf>
     d9a:	83 c4 10             	add    $0x10,%esp
     d9d:	8d 65 f8             	lea    -0x8(%ebp),%esp
     da0:	5b                   	pop    %ebx
     da1:	5e                   	pop    %esi
     da2:	5d                   	pop    %ebp
     da3:	c3                   	ret    
     da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     da8:	83 ec 08             	sub    $0x8,%esp
     dab:	68 0b 42 00 00       	push   $0x420b
     db0:	6a 01                	push   $0x1
     db2:	e8 49 2d 00 00       	call   3b00 <printf>
     db7:	83 c4 10             	add    $0x10,%esp
     dba:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dbd:	5b                   	pop    %ebx
     dbe:	5e                   	pop    %esi
     dbf:	5d                   	pop    %ebp
     dc0:	c3                   	ret    
     dc1:	83 ec 08             	sub    $0x8,%esp
     dc4:	68 1b 42 00 00       	push   $0x421b
     dc9:	6a 01                	push   $0x1
     dcb:	e8 30 2d 00 00       	call   3b00 <printf>
     dd0:	83 c4 10             	add    $0x10,%esp
     dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
     dd6:	5b                   	pop    %ebx
     dd7:	5e                   	pop    %esi
     dd8:	5d                   	pop    %ebp
     dd9:	c3                   	ret    
     dda:	e8 94 2b 00 00       	call   3973 <exit>
     ddf:	90                   	nop

00000de0 <mem>:
     de0:	f3 0f 1e fb          	endbr32 
     de4:	55                   	push   %ebp
     de5:	89 e5                	mov    %esp,%ebp
     de7:	56                   	push   %esi
     de8:	31 f6                	xor    %esi,%esi
     dea:	53                   	push   %ebx
     deb:	83 ec 08             	sub    $0x8,%esp
     dee:	68 28 42 00 00       	push   $0x4228
     df3:	6a 01                	push   $0x1
     df5:	e8 06 2d 00 00       	call   3b00 <printf>
     dfa:	e8 f4 2b 00 00       	call   39f3 <getpid>
     dff:	89 c3                	mov    %eax,%ebx
     e01:	e8 65 2b 00 00       	call   396b <fork>
     e06:	83 c4 10             	add    $0x10,%esp
     e09:	85 c0                	test   %eax,%eax
     e0b:	74 0f                	je     e1c <mem+0x3c>
     e0d:	e9 8e 00 00 00       	jmp    ea0 <mem+0xc0>
     e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e18:	89 30                	mov    %esi,(%eax)
     e1a:	89 c6                	mov    %eax,%esi
     e1c:	83 ec 0c             	sub    $0xc,%esp
     e1f:	68 11 27 00 00       	push   $0x2711
     e24:	e8 07 2f 00 00       	call   3d30 <malloc>
     e29:	83 c4 10             	add    $0x10,%esp
     e2c:	85 c0                	test   %eax,%eax
     e2e:	75 e8                	jne    e18 <mem+0x38>
     e30:	85 f6                	test   %esi,%esi
     e32:	74 18                	je     e4c <mem+0x6c>
     e34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e38:	89 f0                	mov    %esi,%eax
     e3a:	83 ec 0c             	sub    $0xc,%esp
     e3d:	8b 36                	mov    (%esi),%esi
     e3f:	50                   	push   %eax
     e40:	e8 5b 2e 00 00       	call   3ca0 <free>
     e45:	83 c4 10             	add    $0x10,%esp
     e48:	85 f6                	test   %esi,%esi
     e4a:	75 ec                	jne    e38 <mem+0x58>
     e4c:	83 ec 0c             	sub    $0xc,%esp
     e4f:	68 00 50 00 00       	push   $0x5000
     e54:	e8 d7 2e 00 00       	call   3d30 <malloc>
     e59:	83 c4 10             	add    $0x10,%esp
     e5c:	85 c0                	test   %eax,%eax
     e5e:	74 20                	je     e80 <mem+0xa0>
     e60:	83 ec 0c             	sub    $0xc,%esp
     e63:	50                   	push   %eax
     e64:	e8 37 2e 00 00       	call   3ca0 <free>
     e69:	58                   	pop    %eax
     e6a:	5a                   	pop    %edx
     e6b:	68 4c 42 00 00       	push   $0x424c
     e70:	6a 01                	push   $0x1
     e72:	e8 89 2c 00 00       	call   3b00 <printf>
     e77:	e8 f7 2a 00 00       	call   3973 <exit>
     e7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e80:	83 ec 08             	sub    $0x8,%esp
     e83:	68 32 42 00 00       	push   $0x4232
     e88:	6a 01                	push   $0x1
     e8a:	e8 71 2c 00 00       	call   3b00 <printf>
     e8f:	89 1c 24             	mov    %ebx,(%esp)
     e92:	e8 0c 2b 00 00       	call   39a3 <kill>
     e97:	e8 d7 2a 00 00       	call   3973 <exit>
     e9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ea0:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ea3:	5b                   	pop    %ebx
     ea4:	5e                   	pop    %esi
     ea5:	5d                   	pop    %ebp
     ea6:	e9 d0 2a 00 00       	jmp    397b <wait>
     eab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     eaf:	90                   	nop

00000eb0 <sharedfd>:
     eb0:	f3 0f 1e fb          	endbr32 
     eb4:	55                   	push   %ebp
     eb5:	89 e5                	mov    %esp,%ebp
     eb7:	57                   	push   %edi
     eb8:	56                   	push   %esi
     eb9:	53                   	push   %ebx
     eba:	83 ec 34             	sub    $0x34,%esp
     ebd:	68 54 42 00 00       	push   $0x4254
     ec2:	6a 01                	push   $0x1
     ec4:	e8 37 2c 00 00       	call   3b00 <printf>
     ec9:	c7 04 24 63 42 00 00 	movl   $0x4263,(%esp)
     ed0:	e8 ee 2a 00 00       	call   39c3 <unlink>
     ed5:	5b                   	pop    %ebx
     ed6:	5e                   	pop    %esi
     ed7:	68 02 02 00 00       	push   $0x202
     edc:	68 63 42 00 00       	push   $0x4263
     ee1:	e8 cd 2a 00 00       	call   39b3 <open>
     ee6:	83 c4 10             	add    $0x10,%esp
     ee9:	85 c0                	test   %eax,%eax
     eeb:	0f 88 26 01 00 00    	js     1017 <sharedfd+0x167>
     ef1:	89 c7                	mov    %eax,%edi
     ef3:	8d 75 de             	lea    -0x22(%ebp),%esi
     ef6:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     efb:	e8 6b 2a 00 00       	call   396b <fork>
     f00:	83 f8 01             	cmp    $0x1,%eax
     f03:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f06:	19 c0                	sbb    %eax,%eax
     f08:	83 ec 04             	sub    $0x4,%esp
     f0b:	83 e0 f3             	and    $0xfffffff3,%eax
     f0e:	6a 0a                	push   $0xa
     f10:	83 c0 70             	add    $0x70,%eax
     f13:	50                   	push   %eax
     f14:	56                   	push   %esi
     f15:	e8 c6 28 00 00       	call   37e0 <memset>
     f1a:	83 c4 10             	add    $0x10,%esp
     f1d:	eb 06                	jmp    f25 <sharedfd+0x75>
     f1f:	90                   	nop
     f20:	83 eb 01             	sub    $0x1,%ebx
     f23:	74 26                	je     f4b <sharedfd+0x9b>
     f25:	83 ec 04             	sub    $0x4,%esp
     f28:	6a 0a                	push   $0xa
     f2a:	56                   	push   %esi
     f2b:	57                   	push   %edi
     f2c:	e8 62 2a 00 00       	call   3993 <write>
     f31:	83 c4 10             	add    $0x10,%esp
     f34:	83 f8 0a             	cmp    $0xa,%eax
     f37:	74 e7                	je     f20 <sharedfd+0x70>
     f39:	83 ec 08             	sub    $0x8,%esp
     f3c:	68 54 4f 00 00       	push   $0x4f54
     f41:	6a 01                	push   $0x1
     f43:	e8 b8 2b 00 00       	call   3b00 <printf>
     f48:	83 c4 10             	add    $0x10,%esp
     f4b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     f4e:	85 c9                	test   %ecx,%ecx
     f50:	0f 84 f5 00 00 00    	je     104b <sharedfd+0x19b>
     f56:	e8 20 2a 00 00       	call   397b <wait>
     f5b:	83 ec 0c             	sub    $0xc,%esp
     f5e:	31 db                	xor    %ebx,%ebx
     f60:	57                   	push   %edi
     f61:	8d 7d e8             	lea    -0x18(%ebp),%edi
     f64:	e8 32 2a 00 00       	call   399b <close>
     f69:	58                   	pop    %eax
     f6a:	5a                   	pop    %edx
     f6b:	6a 00                	push   $0x0
     f6d:	68 63 42 00 00       	push   $0x4263
     f72:	e8 3c 2a 00 00       	call   39b3 <open>
     f77:	83 c4 10             	add    $0x10,%esp
     f7a:	31 d2                	xor    %edx,%edx
     f7c:	89 45 d0             	mov    %eax,-0x30(%ebp)
     f7f:	85 c0                	test   %eax,%eax
     f81:	0f 88 aa 00 00 00    	js     1031 <sharedfd+0x181>
     f87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f8e:	66 90                	xchg   %ax,%ax
     f90:	83 ec 04             	sub    $0x4,%esp
     f93:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f96:	6a 0a                	push   $0xa
     f98:	56                   	push   %esi
     f99:	ff 75 d0             	pushl  -0x30(%ebp)
     f9c:	e8 ea 29 00 00       	call   398b <read>
     fa1:	83 c4 10             	add    $0x10,%esp
     fa4:	85 c0                	test   %eax,%eax
     fa6:	7e 28                	jle    fd0 <sharedfd+0x120>
     fa8:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     fab:	89 f0                	mov    %esi,%eax
     fad:	eb 13                	jmp    fc2 <sharedfd+0x112>
     faf:	90                   	nop
     fb0:	80 f9 70             	cmp    $0x70,%cl
     fb3:	0f 94 c1             	sete   %cl
     fb6:	0f b6 c9             	movzbl %cl,%ecx
     fb9:	01 cb                	add    %ecx,%ebx
     fbb:	83 c0 01             	add    $0x1,%eax
     fbe:	39 c7                	cmp    %eax,%edi
     fc0:	74 ce                	je     f90 <sharedfd+0xe0>
     fc2:	0f b6 08             	movzbl (%eax),%ecx
     fc5:	80 f9 63             	cmp    $0x63,%cl
     fc8:	75 e6                	jne    fb0 <sharedfd+0x100>
     fca:	83 c2 01             	add    $0x1,%edx
     fcd:	eb ec                	jmp    fbb <sharedfd+0x10b>
     fcf:	90                   	nop
     fd0:	83 ec 0c             	sub    $0xc,%esp
     fd3:	ff 75 d0             	pushl  -0x30(%ebp)
     fd6:	e8 c0 29 00 00       	call   399b <close>
     fdb:	c7 04 24 63 42 00 00 	movl   $0x4263,(%esp)
     fe2:	e8 dc 29 00 00       	call   39c3 <unlink>
     fe7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     fea:	83 c4 10             	add    $0x10,%esp
     fed:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     ff3:	75 5b                	jne    1050 <sharedfd+0x1a0>
     ff5:	81 fb 10 27 00 00    	cmp    $0x2710,%ebx
     ffb:	75 53                	jne    1050 <sharedfd+0x1a0>
     ffd:	83 ec 08             	sub    $0x8,%esp
    1000:	68 6c 42 00 00       	push   $0x426c
    1005:	6a 01                	push   $0x1
    1007:	e8 f4 2a 00 00       	call   3b00 <printf>
    100c:	83 c4 10             	add    $0x10,%esp
    100f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1012:	5b                   	pop    %ebx
    1013:	5e                   	pop    %esi
    1014:	5f                   	pop    %edi
    1015:	5d                   	pop    %ebp
    1016:	c3                   	ret    
    1017:	83 ec 08             	sub    $0x8,%esp
    101a:	68 28 4f 00 00       	push   $0x4f28
    101f:	6a 01                	push   $0x1
    1021:	e8 da 2a 00 00       	call   3b00 <printf>
    1026:	83 c4 10             	add    $0x10,%esp
    1029:	8d 65 f4             	lea    -0xc(%ebp),%esp
    102c:	5b                   	pop    %ebx
    102d:	5e                   	pop    %esi
    102e:	5f                   	pop    %edi
    102f:	5d                   	pop    %ebp
    1030:	c3                   	ret    
    1031:	83 ec 08             	sub    $0x8,%esp
    1034:	68 74 4f 00 00       	push   $0x4f74
    1039:	6a 01                	push   $0x1
    103b:	e8 c0 2a 00 00       	call   3b00 <printf>
    1040:	83 c4 10             	add    $0x10,%esp
    1043:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1046:	5b                   	pop    %ebx
    1047:	5e                   	pop    %esi
    1048:	5f                   	pop    %edi
    1049:	5d                   	pop    %ebp
    104a:	c3                   	ret    
    104b:	e8 23 29 00 00       	call   3973 <exit>
    1050:	53                   	push   %ebx
    1051:	52                   	push   %edx
    1052:	68 79 42 00 00       	push   $0x4279
    1057:	6a 01                	push   $0x1
    1059:	e8 a2 2a 00 00       	call   3b00 <printf>
    105e:	e8 10 29 00 00       	call   3973 <exit>
    1063:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    106a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001070 <fourfiles>:
    1070:	f3 0f 1e fb          	endbr32 
    1074:	55                   	push   %ebp
    1075:	89 e5                	mov    %esp,%ebp
    1077:	57                   	push   %edi
    1078:	56                   	push   %esi
    1079:	be 8e 42 00 00       	mov    $0x428e,%esi
    107e:	53                   	push   %ebx
    107f:	31 db                	xor    %ebx,%ebx
    1081:	83 ec 34             	sub    $0x34,%esp
    1084:	c7 45 d8 8e 42 00 00 	movl   $0x428e,-0x28(%ebp)
    108b:	68 94 42 00 00       	push   $0x4294
    1090:	6a 01                	push   $0x1
    1092:	c7 45 dc d7 43 00 00 	movl   $0x43d7,-0x24(%ebp)
    1099:	c7 45 e0 db 43 00 00 	movl   $0x43db,-0x20(%ebp)
    10a0:	c7 45 e4 91 42 00 00 	movl   $0x4291,-0x1c(%ebp)
    10a7:	e8 54 2a 00 00       	call   3b00 <printf>
    10ac:	83 c4 10             	add    $0x10,%esp
    10af:	83 ec 0c             	sub    $0xc,%esp
    10b2:	56                   	push   %esi
    10b3:	e8 0b 29 00 00       	call   39c3 <unlink>
    10b8:	e8 ae 28 00 00       	call   396b <fork>
    10bd:	83 c4 10             	add    $0x10,%esp
    10c0:	85 c0                	test   %eax,%eax
    10c2:	0f 88 60 01 00 00    	js     1228 <fourfiles+0x1b8>
    10c8:	0f 84 e5 00 00 00    	je     11b3 <fourfiles+0x143>
    10ce:	83 c3 01             	add    $0x1,%ebx
    10d1:	83 fb 04             	cmp    $0x4,%ebx
    10d4:	74 06                	je     10dc <fourfiles+0x6c>
    10d6:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    10da:	eb d3                	jmp    10af <fourfiles+0x3f>
    10dc:	e8 9a 28 00 00       	call   397b <wait>
    10e1:	31 f6                	xor    %esi,%esi
    10e3:	e8 93 28 00 00       	call   397b <wait>
    10e8:	e8 8e 28 00 00       	call   397b <wait>
    10ed:	e8 89 28 00 00       	call   397b <wait>
    10f2:	8b 44 b5 d8          	mov    -0x28(%ebp,%esi,4),%eax
    10f6:	83 ec 08             	sub    $0x8,%esp
    10f9:	31 db                	xor    %ebx,%ebx
    10fb:	6a 00                	push   $0x0
    10fd:	50                   	push   %eax
    10fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1101:	e8 ad 28 00 00       	call   39b3 <open>
    1106:	83 c4 10             	add    $0x10,%esp
    1109:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1110:	83 ec 04             	sub    $0x4,%esp
    1113:	68 00 20 00 00       	push   $0x2000
    1118:	68 00 87 00 00       	push   $0x8700
    111d:	ff 75 d4             	pushl  -0x2c(%ebp)
    1120:	e8 66 28 00 00       	call   398b <read>
    1125:	83 c4 10             	add    $0x10,%esp
    1128:	85 c0                	test   %eax,%eax
    112a:	7e 22                	jle    114e <fourfiles+0xde>
    112c:	31 d2                	xor    %edx,%edx
    112e:	66 90                	xchg   %ax,%ax
    1130:	83 fe 01             	cmp    $0x1,%esi
    1133:	0f be ba 00 87 00 00 	movsbl 0x8700(%edx),%edi
    113a:	19 c9                	sbb    %ecx,%ecx
    113c:	83 c1 31             	add    $0x31,%ecx
    113f:	39 cf                	cmp    %ecx,%edi
    1141:	75 5c                	jne    119f <fourfiles+0x12f>
    1143:	83 c2 01             	add    $0x1,%edx
    1146:	39 d0                	cmp    %edx,%eax
    1148:	75 e6                	jne    1130 <fourfiles+0xc0>
    114a:	01 c3                	add    %eax,%ebx
    114c:	eb c2                	jmp    1110 <fourfiles+0xa0>
    114e:	83 ec 0c             	sub    $0xc,%esp
    1151:	ff 75 d4             	pushl  -0x2c(%ebp)
    1154:	e8 42 28 00 00       	call   399b <close>
    1159:	83 c4 10             	add    $0x10,%esp
    115c:	81 fb 70 17 00 00    	cmp    $0x1770,%ebx
    1162:	0f 85 d4 00 00 00    	jne    123c <fourfiles+0x1cc>
    1168:	83 ec 0c             	sub    $0xc,%esp
    116b:	ff 75 d0             	pushl  -0x30(%ebp)
    116e:	e8 50 28 00 00       	call   39c3 <unlink>
    1173:	83 c4 10             	add    $0x10,%esp
    1176:	83 fe 01             	cmp    $0x1,%esi
    1179:	75 1a                	jne    1195 <fourfiles+0x125>
    117b:	83 ec 08             	sub    $0x8,%esp
    117e:	68 d2 42 00 00       	push   $0x42d2
    1183:	6a 01                	push   $0x1
    1185:	e8 76 29 00 00       	call   3b00 <printf>
    118a:	83 c4 10             	add    $0x10,%esp
    118d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1190:	5b                   	pop    %ebx
    1191:	5e                   	pop    %esi
    1192:	5f                   	pop    %edi
    1193:	5d                   	pop    %ebp
    1194:	c3                   	ret    
    1195:	be 01 00 00 00       	mov    $0x1,%esi
    119a:	e9 53 ff ff ff       	jmp    10f2 <fourfiles+0x82>
    119f:	83 ec 08             	sub    $0x8,%esp
    11a2:	68 b5 42 00 00       	push   $0x42b5
    11a7:	6a 01                	push   $0x1
    11a9:	e8 52 29 00 00       	call   3b00 <printf>
    11ae:	e8 c0 27 00 00       	call   3973 <exit>
    11b3:	83 ec 08             	sub    $0x8,%esp
    11b6:	68 02 02 00 00       	push   $0x202
    11bb:	56                   	push   %esi
    11bc:	e8 f2 27 00 00       	call   39b3 <open>
    11c1:	83 c4 10             	add    $0x10,%esp
    11c4:	89 c6                	mov    %eax,%esi
    11c6:	85 c0                	test   %eax,%eax
    11c8:	78 45                	js     120f <fourfiles+0x19f>
    11ca:	83 ec 04             	sub    $0x4,%esp
    11cd:	83 c3 30             	add    $0x30,%ebx
    11d0:	68 00 02 00 00       	push   $0x200
    11d5:	53                   	push   %ebx
    11d6:	bb 0c 00 00 00       	mov    $0xc,%ebx
    11db:	68 00 87 00 00       	push   $0x8700
    11e0:	e8 fb 25 00 00       	call   37e0 <memset>
    11e5:	83 c4 10             	add    $0x10,%esp
    11e8:	83 ec 04             	sub    $0x4,%esp
    11eb:	68 f4 01 00 00       	push   $0x1f4
    11f0:	68 00 87 00 00       	push   $0x8700
    11f5:	56                   	push   %esi
    11f6:	e8 98 27 00 00       	call   3993 <write>
    11fb:	83 c4 10             	add    $0x10,%esp
    11fe:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    1203:	75 4a                	jne    124f <fourfiles+0x1df>
    1205:	83 eb 01             	sub    $0x1,%ebx
    1208:	75 de                	jne    11e8 <fourfiles+0x178>
    120a:	e8 64 27 00 00       	call   3973 <exit>
    120f:	51                   	push   %ecx
    1210:	51                   	push   %ecx
    1211:	68 2f 45 00 00       	push   $0x452f
    1216:	6a 01                	push   $0x1
    1218:	e8 e3 28 00 00       	call   3b00 <printf>
    121d:	e8 51 27 00 00       	call   3973 <exit>
    1222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1228:	83 ec 08             	sub    $0x8,%esp
    122b:	68 69 4d 00 00       	push   $0x4d69
    1230:	6a 01                	push   $0x1
    1232:	e8 c9 28 00 00       	call   3b00 <printf>
    1237:	e8 37 27 00 00       	call   3973 <exit>
    123c:	50                   	push   %eax
    123d:	53                   	push   %ebx
    123e:	68 c1 42 00 00       	push   $0x42c1
    1243:	6a 01                	push   $0x1
    1245:	e8 b6 28 00 00       	call   3b00 <printf>
    124a:	e8 24 27 00 00       	call   3973 <exit>
    124f:	52                   	push   %edx
    1250:	50                   	push   %eax
    1251:	68 a4 42 00 00       	push   $0x42a4
    1256:	6a 01                	push   $0x1
    1258:	e8 a3 28 00 00       	call   3b00 <printf>
    125d:	e8 11 27 00 00       	call   3973 <exit>
    1262:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001270 <createdelete>:
    1270:	f3 0f 1e fb          	endbr32 
    1274:	55                   	push   %ebp
    1275:	89 e5                	mov    %esp,%ebp
    1277:	57                   	push   %edi
    1278:	56                   	push   %esi
    1279:	53                   	push   %ebx
    127a:	31 db                	xor    %ebx,%ebx
    127c:	83 ec 44             	sub    $0x44,%esp
    127f:	68 e0 42 00 00       	push   $0x42e0
    1284:	6a 01                	push   $0x1
    1286:	e8 75 28 00 00       	call   3b00 <printf>
    128b:	83 c4 10             	add    $0x10,%esp
    128e:	e8 d8 26 00 00       	call   396b <fork>
    1293:	85 c0                	test   %eax,%eax
    1295:	0f 88 ce 01 00 00    	js     1469 <createdelete+0x1f9>
    129b:	0f 84 17 01 00 00    	je     13b8 <createdelete+0x148>
    12a1:	83 c3 01             	add    $0x1,%ebx
    12a4:	83 fb 04             	cmp    $0x4,%ebx
    12a7:	75 e5                	jne    128e <createdelete+0x1e>
    12a9:	e8 cd 26 00 00       	call   397b <wait>
    12ae:	8d 7d c8             	lea    -0x38(%ebp),%edi
    12b1:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12b6:	e8 c0 26 00 00       	call   397b <wait>
    12bb:	e8 bb 26 00 00       	call   397b <wait>
    12c0:	e8 b6 26 00 00       	call   397b <wait>
    12c5:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    12c9:	89 7d c0             	mov    %edi,-0x40(%ebp)
    12cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12d0:	8d 46 31             	lea    0x31(%esi),%eax
    12d3:	89 f7                	mov    %esi,%edi
    12d5:	83 c6 01             	add    $0x1,%esi
    12d8:	83 fe 09             	cmp    $0x9,%esi
    12db:	88 45 c7             	mov    %al,-0x39(%ebp)
    12de:	0f 9f c3             	setg   %bl
    12e1:	85 f6                	test   %esi,%esi
    12e3:	0f 94 c0             	sete   %al
    12e6:	09 c3                	or     %eax,%ebx
    12e8:	88 5d c6             	mov    %bl,-0x3a(%ebp)
    12eb:	bb 70 00 00 00       	mov    $0x70,%ebx
    12f0:	83 ec 08             	sub    $0x8,%esp
    12f3:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    12f7:	88 5d c8             	mov    %bl,-0x38(%ebp)
    12fa:	6a 00                	push   $0x0
    12fc:	ff 75 c0             	pushl  -0x40(%ebp)
    12ff:	88 45 c9             	mov    %al,-0x37(%ebp)
    1302:	e8 ac 26 00 00       	call   39b3 <open>
    1307:	83 c4 10             	add    $0x10,%esp
    130a:	80 7d c6 00          	cmpb   $0x0,-0x3a(%ebp)
    130e:	0f 84 8c 00 00 00    	je     13a0 <createdelete+0x130>
    1314:	85 c0                	test   %eax,%eax
    1316:	0f 88 21 01 00 00    	js     143d <createdelete+0x1cd>
    131c:	83 ff 08             	cmp    $0x8,%edi
    131f:	0f 86 60 01 00 00    	jbe    1485 <createdelete+0x215>
    1325:	83 ec 0c             	sub    $0xc,%esp
    1328:	50                   	push   %eax
    1329:	e8 6d 26 00 00       	call   399b <close>
    132e:	83 c4 10             	add    $0x10,%esp
    1331:	83 c3 01             	add    $0x1,%ebx
    1334:	80 fb 74             	cmp    $0x74,%bl
    1337:	75 b7                	jne    12f0 <createdelete+0x80>
    1339:	83 fe 13             	cmp    $0x13,%esi
    133c:	75 92                	jne    12d0 <createdelete+0x60>
    133e:	8b 7d c0             	mov    -0x40(%ebp),%edi
    1341:	be 70 00 00 00       	mov    $0x70,%esi
    1346:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    134d:	8d 76 00             	lea    0x0(%esi),%esi
    1350:	8d 46 c0             	lea    -0x40(%esi),%eax
    1353:	bb 04 00 00 00       	mov    $0x4,%ebx
    1358:	88 45 c7             	mov    %al,-0x39(%ebp)
    135b:	83 ec 0c             	sub    $0xc,%esp
    135e:	89 f0                	mov    %esi,%eax
    1360:	57                   	push   %edi
    1361:	88 45 c8             	mov    %al,-0x38(%ebp)
    1364:	0f b6 45 c7          	movzbl -0x39(%ebp),%eax
    1368:	88 45 c9             	mov    %al,-0x37(%ebp)
    136b:	e8 53 26 00 00       	call   39c3 <unlink>
    1370:	83 c4 10             	add    $0x10,%esp
    1373:	83 eb 01             	sub    $0x1,%ebx
    1376:	75 e3                	jne    135b <createdelete+0xeb>
    1378:	83 c6 01             	add    $0x1,%esi
    137b:	89 f0                	mov    %esi,%eax
    137d:	3c 84                	cmp    $0x84,%al
    137f:	75 cf                	jne    1350 <createdelete+0xe0>
    1381:	83 ec 08             	sub    $0x8,%esp
    1384:	68 f3 42 00 00       	push   $0x42f3
    1389:	6a 01                	push   $0x1
    138b:	e8 70 27 00 00       	call   3b00 <printf>
    1390:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1393:	5b                   	pop    %ebx
    1394:	5e                   	pop    %esi
    1395:	5f                   	pop    %edi
    1396:	5d                   	pop    %ebp
    1397:	c3                   	ret    
    1398:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    139f:	90                   	nop
    13a0:	83 ff 08             	cmp    $0x8,%edi
    13a3:	0f 86 d4 00 00 00    	jbe    147d <createdelete+0x20d>
    13a9:	85 c0                	test   %eax,%eax
    13ab:	78 84                	js     1331 <createdelete+0xc1>
    13ad:	e9 73 ff ff ff       	jmp    1325 <createdelete+0xb5>
    13b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    13b8:	83 c3 70             	add    $0x70,%ebx
    13bb:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13bf:	8d 7d c8             	lea    -0x38(%ebp),%edi
    13c2:	88 5d c8             	mov    %bl,-0x38(%ebp)
    13c5:	31 db                	xor    %ebx,%ebx
    13c7:	eb 0f                	jmp    13d8 <createdelete+0x168>
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13d0:	83 fb 13             	cmp    $0x13,%ebx
    13d3:	74 63                	je     1438 <createdelete+0x1c8>
    13d5:	83 c3 01             	add    $0x1,%ebx
    13d8:	83 ec 08             	sub    $0x8,%esp
    13db:	8d 43 30             	lea    0x30(%ebx),%eax
    13de:	68 02 02 00 00       	push   $0x202
    13e3:	57                   	push   %edi
    13e4:	88 45 c9             	mov    %al,-0x37(%ebp)
    13e7:	e8 c7 25 00 00       	call   39b3 <open>
    13ec:	83 c4 10             	add    $0x10,%esp
    13ef:	85 c0                	test   %eax,%eax
    13f1:	78 62                	js     1455 <createdelete+0x1e5>
    13f3:	83 ec 0c             	sub    $0xc,%esp
    13f6:	50                   	push   %eax
    13f7:	e8 9f 25 00 00       	call   399b <close>
    13fc:	83 c4 10             	add    $0x10,%esp
    13ff:	85 db                	test   %ebx,%ebx
    1401:	74 d2                	je     13d5 <createdelete+0x165>
    1403:	f6 c3 01             	test   $0x1,%bl
    1406:	75 c8                	jne    13d0 <createdelete+0x160>
    1408:	83 ec 0c             	sub    $0xc,%esp
    140b:	89 d8                	mov    %ebx,%eax
    140d:	57                   	push   %edi
    140e:	d1 f8                	sar    %eax
    1410:	83 c0 30             	add    $0x30,%eax
    1413:	88 45 c9             	mov    %al,-0x37(%ebp)
    1416:	e8 a8 25 00 00       	call   39c3 <unlink>
    141b:	83 c4 10             	add    $0x10,%esp
    141e:	85 c0                	test   %eax,%eax
    1420:	79 ae                	jns    13d0 <createdelete+0x160>
    1422:	52                   	push   %edx
    1423:	52                   	push   %edx
    1424:	68 e1 3e 00 00       	push   $0x3ee1
    1429:	6a 01                	push   $0x1
    142b:	e8 d0 26 00 00       	call   3b00 <printf>
    1430:	e8 3e 25 00 00       	call   3973 <exit>
    1435:	8d 76 00             	lea    0x0(%esi),%esi
    1438:	e8 36 25 00 00       	call   3973 <exit>
    143d:	8b 7d c0             	mov    -0x40(%ebp),%edi
    1440:	83 ec 04             	sub    $0x4,%esp
    1443:	57                   	push   %edi
    1444:	68 a0 4f 00 00       	push   $0x4fa0
    1449:	6a 01                	push   $0x1
    144b:	e8 b0 26 00 00       	call   3b00 <printf>
    1450:	e8 1e 25 00 00       	call   3973 <exit>
    1455:	83 ec 08             	sub    $0x8,%esp
    1458:	68 2f 45 00 00       	push   $0x452f
    145d:	6a 01                	push   $0x1
    145f:	e8 9c 26 00 00       	call   3b00 <printf>
    1464:	e8 0a 25 00 00       	call   3973 <exit>
    1469:	83 ec 08             	sub    $0x8,%esp
    146c:	68 69 4d 00 00       	push   $0x4d69
    1471:	6a 01                	push   $0x1
    1473:	e8 88 26 00 00       	call   3b00 <printf>
    1478:	e8 f6 24 00 00       	call   3973 <exit>
    147d:	85 c0                	test   %eax,%eax
    147f:	0f 88 ac fe ff ff    	js     1331 <createdelete+0xc1>
    1485:	8b 7d c0             	mov    -0x40(%ebp),%edi
    1488:	50                   	push   %eax
    1489:	57                   	push   %edi
    148a:	68 c4 4f 00 00       	push   $0x4fc4
    148f:	6a 01                	push   $0x1
    1491:	e8 6a 26 00 00       	call   3b00 <printf>
    1496:	e8 d8 24 00 00       	call   3973 <exit>
    149b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    149f:	90                   	nop

000014a0 <unlinkread>:
    14a0:	f3 0f 1e fb          	endbr32 
    14a4:	55                   	push   %ebp
    14a5:	89 e5                	mov    %esp,%ebp
    14a7:	56                   	push   %esi
    14a8:	53                   	push   %ebx
    14a9:	83 ec 08             	sub    $0x8,%esp
    14ac:	68 04 43 00 00       	push   $0x4304
    14b1:	6a 01                	push   $0x1
    14b3:	e8 48 26 00 00       	call   3b00 <printf>
    14b8:	5b                   	pop    %ebx
    14b9:	5e                   	pop    %esi
    14ba:	68 02 02 00 00       	push   $0x202
    14bf:	68 15 43 00 00       	push   $0x4315
    14c4:	e8 ea 24 00 00       	call   39b3 <open>
    14c9:	83 c4 10             	add    $0x10,%esp
    14cc:	85 c0                	test   %eax,%eax
    14ce:	0f 88 e6 00 00 00    	js     15ba <unlinkread+0x11a>
    14d4:	83 ec 04             	sub    $0x4,%esp
    14d7:	89 c3                	mov    %eax,%ebx
    14d9:	6a 05                	push   $0x5
    14db:	68 3a 43 00 00       	push   $0x433a
    14e0:	50                   	push   %eax
    14e1:	e8 ad 24 00 00       	call   3993 <write>
    14e6:	89 1c 24             	mov    %ebx,(%esp)
    14e9:	e8 ad 24 00 00       	call   399b <close>
    14ee:	58                   	pop    %eax
    14ef:	5a                   	pop    %edx
    14f0:	6a 02                	push   $0x2
    14f2:	68 15 43 00 00       	push   $0x4315
    14f7:	e8 b7 24 00 00       	call   39b3 <open>
    14fc:	83 c4 10             	add    $0x10,%esp
    14ff:	89 c3                	mov    %eax,%ebx
    1501:	85 c0                	test   %eax,%eax
    1503:	0f 88 10 01 00 00    	js     1619 <unlinkread+0x179>
    1509:	83 ec 0c             	sub    $0xc,%esp
    150c:	68 15 43 00 00       	push   $0x4315
    1511:	e8 ad 24 00 00       	call   39c3 <unlink>
    1516:	83 c4 10             	add    $0x10,%esp
    1519:	85 c0                	test   %eax,%eax
    151b:	0f 85 e5 00 00 00    	jne    1606 <unlinkread+0x166>
    1521:	83 ec 08             	sub    $0x8,%esp
    1524:	68 02 02 00 00       	push   $0x202
    1529:	68 15 43 00 00       	push   $0x4315
    152e:	e8 80 24 00 00       	call   39b3 <open>
    1533:	83 c4 0c             	add    $0xc,%esp
    1536:	6a 03                	push   $0x3
    1538:	89 c6                	mov    %eax,%esi
    153a:	68 72 43 00 00       	push   $0x4372
    153f:	50                   	push   %eax
    1540:	e8 4e 24 00 00       	call   3993 <write>
    1545:	89 34 24             	mov    %esi,(%esp)
    1548:	e8 4e 24 00 00       	call   399b <close>
    154d:	83 c4 0c             	add    $0xc,%esp
    1550:	68 00 20 00 00       	push   $0x2000
    1555:	68 00 87 00 00       	push   $0x8700
    155a:	53                   	push   %ebx
    155b:	e8 2b 24 00 00       	call   398b <read>
    1560:	83 c4 10             	add    $0x10,%esp
    1563:	83 f8 05             	cmp    $0x5,%eax
    1566:	0f 85 87 00 00 00    	jne    15f3 <unlinkread+0x153>
    156c:	80 3d 00 87 00 00 68 	cmpb   $0x68,0x8700
    1573:	75 6b                	jne    15e0 <unlinkread+0x140>
    1575:	83 ec 04             	sub    $0x4,%esp
    1578:	6a 0a                	push   $0xa
    157a:	68 00 87 00 00       	push   $0x8700
    157f:	53                   	push   %ebx
    1580:	e8 0e 24 00 00       	call   3993 <write>
    1585:	83 c4 10             	add    $0x10,%esp
    1588:	83 f8 0a             	cmp    $0xa,%eax
    158b:	75 40                	jne    15cd <unlinkread+0x12d>
    158d:	83 ec 0c             	sub    $0xc,%esp
    1590:	53                   	push   %ebx
    1591:	e8 05 24 00 00       	call   399b <close>
    1596:	c7 04 24 15 43 00 00 	movl   $0x4315,(%esp)
    159d:	e8 21 24 00 00       	call   39c3 <unlink>
    15a2:	58                   	pop    %eax
    15a3:	5a                   	pop    %edx
    15a4:	68 bd 43 00 00       	push   $0x43bd
    15a9:	6a 01                	push   $0x1
    15ab:	e8 50 25 00 00       	call   3b00 <printf>
    15b0:	83 c4 10             	add    $0x10,%esp
    15b3:	8d 65 f8             	lea    -0x8(%ebp),%esp
    15b6:	5b                   	pop    %ebx
    15b7:	5e                   	pop    %esi
    15b8:	5d                   	pop    %ebp
    15b9:	c3                   	ret    
    15ba:	51                   	push   %ecx
    15bb:	51                   	push   %ecx
    15bc:	68 20 43 00 00       	push   $0x4320
    15c1:	6a 01                	push   $0x1
    15c3:	e8 38 25 00 00       	call   3b00 <printf>
    15c8:	e8 a6 23 00 00       	call   3973 <exit>
    15cd:	51                   	push   %ecx
    15ce:	51                   	push   %ecx
    15cf:	68 a4 43 00 00       	push   $0x43a4
    15d4:	6a 01                	push   $0x1
    15d6:	e8 25 25 00 00       	call   3b00 <printf>
    15db:	e8 93 23 00 00       	call   3973 <exit>
    15e0:	53                   	push   %ebx
    15e1:	53                   	push   %ebx
    15e2:	68 8d 43 00 00       	push   $0x438d
    15e7:	6a 01                	push   $0x1
    15e9:	e8 12 25 00 00       	call   3b00 <printf>
    15ee:	e8 80 23 00 00       	call   3973 <exit>
    15f3:	56                   	push   %esi
    15f4:	56                   	push   %esi
    15f5:	68 76 43 00 00       	push   $0x4376
    15fa:	6a 01                	push   $0x1
    15fc:	e8 ff 24 00 00       	call   3b00 <printf>
    1601:	e8 6d 23 00 00       	call   3973 <exit>
    1606:	50                   	push   %eax
    1607:	50                   	push   %eax
    1608:	68 58 43 00 00       	push   $0x4358
    160d:	6a 01                	push   $0x1
    160f:	e8 ec 24 00 00       	call   3b00 <printf>
    1614:	e8 5a 23 00 00       	call   3973 <exit>
    1619:	50                   	push   %eax
    161a:	50                   	push   %eax
    161b:	68 40 43 00 00       	push   $0x4340
    1620:	6a 01                	push   $0x1
    1622:	e8 d9 24 00 00       	call   3b00 <printf>
    1627:	e8 47 23 00 00       	call   3973 <exit>
    162c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001630 <linktest>:
    1630:	f3 0f 1e fb          	endbr32 
    1634:	55                   	push   %ebp
    1635:	89 e5                	mov    %esp,%ebp
    1637:	53                   	push   %ebx
    1638:	83 ec 0c             	sub    $0xc,%esp
    163b:	68 cc 43 00 00       	push   $0x43cc
    1640:	6a 01                	push   $0x1
    1642:	e8 b9 24 00 00       	call   3b00 <printf>
    1647:	c7 04 24 d6 43 00 00 	movl   $0x43d6,(%esp)
    164e:	e8 70 23 00 00       	call   39c3 <unlink>
    1653:	c7 04 24 da 43 00 00 	movl   $0x43da,(%esp)
    165a:	e8 64 23 00 00       	call   39c3 <unlink>
    165f:	58                   	pop    %eax
    1660:	5a                   	pop    %edx
    1661:	68 02 02 00 00       	push   $0x202
    1666:	68 d6 43 00 00       	push   $0x43d6
    166b:	e8 43 23 00 00       	call   39b3 <open>
    1670:	83 c4 10             	add    $0x10,%esp
    1673:	85 c0                	test   %eax,%eax
    1675:	0f 88 1e 01 00 00    	js     1799 <linktest+0x169>
    167b:	83 ec 04             	sub    $0x4,%esp
    167e:	89 c3                	mov    %eax,%ebx
    1680:	6a 05                	push   $0x5
    1682:	68 3a 43 00 00       	push   $0x433a
    1687:	50                   	push   %eax
    1688:	e8 06 23 00 00       	call   3993 <write>
    168d:	83 c4 10             	add    $0x10,%esp
    1690:	83 f8 05             	cmp    $0x5,%eax
    1693:	0f 85 98 01 00 00    	jne    1831 <linktest+0x201>
    1699:	83 ec 0c             	sub    $0xc,%esp
    169c:	53                   	push   %ebx
    169d:	e8 f9 22 00 00       	call   399b <close>
    16a2:	5b                   	pop    %ebx
    16a3:	58                   	pop    %eax
    16a4:	68 da 43 00 00       	push   $0x43da
    16a9:	68 d6 43 00 00       	push   $0x43d6
    16ae:	e8 20 23 00 00       	call   39d3 <link>
    16b3:	83 c4 10             	add    $0x10,%esp
    16b6:	85 c0                	test   %eax,%eax
    16b8:	0f 88 60 01 00 00    	js     181e <linktest+0x1ee>
    16be:	83 ec 0c             	sub    $0xc,%esp
    16c1:	68 d6 43 00 00       	push   $0x43d6
    16c6:	e8 f8 22 00 00       	call   39c3 <unlink>
    16cb:	58                   	pop    %eax
    16cc:	5a                   	pop    %edx
    16cd:	6a 00                	push   $0x0
    16cf:	68 d6 43 00 00       	push   $0x43d6
    16d4:	e8 da 22 00 00       	call   39b3 <open>
    16d9:	83 c4 10             	add    $0x10,%esp
    16dc:	85 c0                	test   %eax,%eax
    16de:	0f 89 27 01 00 00    	jns    180b <linktest+0x1db>
    16e4:	83 ec 08             	sub    $0x8,%esp
    16e7:	6a 00                	push   $0x0
    16e9:	68 da 43 00 00       	push   $0x43da
    16ee:	e8 c0 22 00 00       	call   39b3 <open>
    16f3:	83 c4 10             	add    $0x10,%esp
    16f6:	89 c3                	mov    %eax,%ebx
    16f8:	85 c0                	test   %eax,%eax
    16fa:	0f 88 f8 00 00 00    	js     17f8 <linktest+0x1c8>
    1700:	83 ec 04             	sub    $0x4,%esp
    1703:	68 00 20 00 00       	push   $0x2000
    1708:	68 00 87 00 00       	push   $0x8700
    170d:	50                   	push   %eax
    170e:	e8 78 22 00 00       	call   398b <read>
    1713:	83 c4 10             	add    $0x10,%esp
    1716:	83 f8 05             	cmp    $0x5,%eax
    1719:	0f 85 c6 00 00 00    	jne    17e5 <linktest+0x1b5>
    171f:	83 ec 0c             	sub    $0xc,%esp
    1722:	53                   	push   %ebx
    1723:	e8 73 22 00 00       	call   399b <close>
    1728:	58                   	pop    %eax
    1729:	5a                   	pop    %edx
    172a:	68 da 43 00 00       	push   $0x43da
    172f:	68 da 43 00 00       	push   $0x43da
    1734:	e8 9a 22 00 00       	call   39d3 <link>
    1739:	83 c4 10             	add    $0x10,%esp
    173c:	85 c0                	test   %eax,%eax
    173e:	0f 89 8e 00 00 00    	jns    17d2 <linktest+0x1a2>
    1744:	83 ec 0c             	sub    $0xc,%esp
    1747:	68 da 43 00 00       	push   $0x43da
    174c:	e8 72 22 00 00       	call   39c3 <unlink>
    1751:	59                   	pop    %ecx
    1752:	5b                   	pop    %ebx
    1753:	68 d6 43 00 00       	push   $0x43d6
    1758:	68 da 43 00 00       	push   $0x43da
    175d:	e8 71 22 00 00       	call   39d3 <link>
    1762:	83 c4 10             	add    $0x10,%esp
    1765:	85 c0                	test   %eax,%eax
    1767:	79 56                	jns    17bf <linktest+0x18f>
    1769:	83 ec 08             	sub    $0x8,%esp
    176c:	68 d6 43 00 00       	push   $0x43d6
    1771:	68 9e 46 00 00       	push   $0x469e
    1776:	e8 58 22 00 00       	call   39d3 <link>
    177b:	83 c4 10             	add    $0x10,%esp
    177e:	85 c0                	test   %eax,%eax
    1780:	79 2a                	jns    17ac <linktest+0x17c>
    1782:	83 ec 08             	sub    $0x8,%esp
    1785:	68 74 44 00 00       	push   $0x4474
    178a:	6a 01                	push   $0x1
    178c:	e8 6f 23 00 00       	call   3b00 <printf>
    1791:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1794:	83 c4 10             	add    $0x10,%esp
    1797:	c9                   	leave  
    1798:	c3                   	ret    
    1799:	50                   	push   %eax
    179a:	50                   	push   %eax
    179b:	68 de 43 00 00       	push   $0x43de
    17a0:	6a 01                	push   $0x1
    17a2:	e8 59 23 00 00       	call   3b00 <printf>
    17a7:	e8 c7 21 00 00       	call   3973 <exit>
    17ac:	50                   	push   %eax
    17ad:	50                   	push   %eax
    17ae:	68 58 44 00 00       	push   $0x4458
    17b3:	6a 01                	push   $0x1
    17b5:	e8 46 23 00 00       	call   3b00 <printf>
    17ba:	e8 b4 21 00 00       	call   3973 <exit>
    17bf:	52                   	push   %edx
    17c0:	52                   	push   %edx
    17c1:	68 0c 50 00 00       	push   $0x500c
    17c6:	6a 01                	push   $0x1
    17c8:	e8 33 23 00 00       	call   3b00 <printf>
    17cd:	e8 a1 21 00 00       	call   3973 <exit>
    17d2:	50                   	push   %eax
    17d3:	50                   	push   %eax
    17d4:	68 3a 44 00 00       	push   $0x443a
    17d9:	6a 01                	push   $0x1
    17db:	e8 20 23 00 00       	call   3b00 <printf>
    17e0:	e8 8e 21 00 00       	call   3973 <exit>
    17e5:	51                   	push   %ecx
    17e6:	51                   	push   %ecx
    17e7:	68 29 44 00 00       	push   $0x4429
    17ec:	6a 01                	push   $0x1
    17ee:	e8 0d 23 00 00       	call   3b00 <printf>
    17f3:	e8 7b 21 00 00       	call   3973 <exit>
    17f8:	53                   	push   %ebx
    17f9:	53                   	push   %ebx
    17fa:	68 18 44 00 00       	push   $0x4418
    17ff:	6a 01                	push   $0x1
    1801:	e8 fa 22 00 00       	call   3b00 <printf>
    1806:	e8 68 21 00 00       	call   3973 <exit>
    180b:	50                   	push   %eax
    180c:	50                   	push   %eax
    180d:	68 e4 4f 00 00       	push   $0x4fe4
    1812:	6a 01                	push   $0x1
    1814:	e8 e7 22 00 00       	call   3b00 <printf>
    1819:	e8 55 21 00 00       	call   3973 <exit>
    181e:	51                   	push   %ecx
    181f:	51                   	push   %ecx
    1820:	68 03 44 00 00       	push   $0x4403
    1825:	6a 01                	push   $0x1
    1827:	e8 d4 22 00 00       	call   3b00 <printf>
    182c:	e8 42 21 00 00       	call   3973 <exit>
    1831:	50                   	push   %eax
    1832:	50                   	push   %eax
    1833:	68 f1 43 00 00       	push   $0x43f1
    1838:	6a 01                	push   $0x1
    183a:	e8 c1 22 00 00       	call   3b00 <printf>
    183f:	e8 2f 21 00 00       	call   3973 <exit>
    1844:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    184b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    184f:	90                   	nop

00001850 <concreate>:
    1850:	f3 0f 1e fb          	endbr32 
    1854:	55                   	push   %ebp
    1855:	89 e5                	mov    %esp,%ebp
    1857:	57                   	push   %edi
    1858:	56                   	push   %esi
    1859:	31 f6                	xor    %esi,%esi
    185b:	53                   	push   %ebx
    185c:	8d 5d ad             	lea    -0x53(%ebp),%ebx
    185f:	83 ec 64             	sub    $0x64,%esp
    1862:	68 81 44 00 00       	push   $0x4481
    1867:	6a 01                	push   $0x1
    1869:	e8 92 22 00 00       	call   3b00 <printf>
    186e:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
    1872:	83 c4 10             	add    $0x10,%esp
    1875:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
    1879:	eb 48                	jmp    18c3 <concreate+0x73>
    187b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    187f:	90                   	nop
    1880:	69 c6 ab aa aa aa    	imul   $0xaaaaaaab,%esi,%eax
    1886:	3d ab aa aa aa       	cmp    $0xaaaaaaab,%eax
    188b:	0f 83 af 00 00 00    	jae    1940 <concreate+0xf0>
    1891:	83 ec 08             	sub    $0x8,%esp
    1894:	68 02 02 00 00       	push   $0x202
    1899:	53                   	push   %ebx
    189a:	e8 14 21 00 00       	call   39b3 <open>
    189f:	83 c4 10             	add    $0x10,%esp
    18a2:	85 c0                	test   %eax,%eax
    18a4:	78 5f                	js     1905 <concreate+0xb5>
    18a6:	83 ec 0c             	sub    $0xc,%esp
    18a9:	83 c6 01             	add    $0x1,%esi
    18ac:	50                   	push   %eax
    18ad:	e8 e9 20 00 00       	call   399b <close>
    18b2:	83 c4 10             	add    $0x10,%esp
    18b5:	e8 c1 20 00 00       	call   397b <wait>
    18ba:	83 fe 28             	cmp    $0x28,%esi
    18bd:	0f 84 9f 00 00 00    	je     1962 <concreate+0x112>
    18c3:	83 ec 0c             	sub    $0xc,%esp
    18c6:	8d 46 30             	lea    0x30(%esi),%eax
    18c9:	53                   	push   %ebx
    18ca:	88 45 ae             	mov    %al,-0x52(%ebp)
    18cd:	e8 f1 20 00 00       	call   39c3 <unlink>
    18d2:	e8 94 20 00 00       	call   396b <fork>
    18d7:	83 c4 10             	add    $0x10,%esp
    18da:	85 c0                	test   %eax,%eax
    18dc:	75 a2                	jne    1880 <concreate+0x30>
    18de:	69 f6 cd cc cc cc    	imul   $0xcccccccd,%esi,%esi
    18e4:	81 fe cd cc cc cc    	cmp    $0xcccccccd,%esi
    18ea:	73 34                	jae    1920 <concreate+0xd0>
    18ec:	83 ec 08             	sub    $0x8,%esp
    18ef:	68 02 02 00 00       	push   $0x202
    18f4:	53                   	push   %ebx
    18f5:	e8 b9 20 00 00       	call   39b3 <open>
    18fa:	83 c4 10             	add    $0x10,%esp
    18fd:	85 c0                	test   %eax,%eax
    18ff:	0f 89 39 02 00 00    	jns    1b3e <concreate+0x2ee>
    1905:	83 ec 04             	sub    $0x4,%esp
    1908:	53                   	push   %ebx
    1909:	68 94 44 00 00       	push   $0x4494
    190e:	6a 01                	push   $0x1
    1910:	e8 eb 21 00 00       	call   3b00 <printf>
    1915:	e8 59 20 00 00       	call   3973 <exit>
    191a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1920:	83 ec 08             	sub    $0x8,%esp
    1923:	53                   	push   %ebx
    1924:	68 91 44 00 00       	push   $0x4491
    1929:	e8 a5 20 00 00       	call   39d3 <link>
    192e:	83 c4 10             	add    $0x10,%esp
    1931:	e8 3d 20 00 00       	call   3973 <exit>
    1936:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    193d:	8d 76 00             	lea    0x0(%esi),%esi
    1940:	83 ec 08             	sub    $0x8,%esp
    1943:	83 c6 01             	add    $0x1,%esi
    1946:	53                   	push   %ebx
    1947:	68 91 44 00 00       	push   $0x4491
    194c:	e8 82 20 00 00       	call   39d3 <link>
    1951:	83 c4 10             	add    $0x10,%esp
    1954:	e8 22 20 00 00       	call   397b <wait>
    1959:	83 fe 28             	cmp    $0x28,%esi
    195c:	0f 85 61 ff ff ff    	jne    18c3 <concreate+0x73>
    1962:	83 ec 04             	sub    $0x4,%esp
    1965:	8d 45 c0             	lea    -0x40(%ebp),%eax
    1968:	6a 28                	push   $0x28
    196a:	6a 00                	push   $0x0
    196c:	50                   	push   %eax
    196d:	e8 6e 1e 00 00       	call   37e0 <memset>
    1972:	5e                   	pop    %esi
    1973:	5f                   	pop    %edi
    1974:	6a 00                	push   $0x0
    1976:	68 9e 46 00 00       	push   $0x469e
    197b:	8d 7d b0             	lea    -0x50(%ebp),%edi
    197e:	e8 30 20 00 00       	call   39b3 <open>
    1983:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    198a:	83 c4 10             	add    $0x10,%esp
    198d:	89 c6                	mov    %eax,%esi
    198f:	90                   	nop
    1990:	83 ec 04             	sub    $0x4,%esp
    1993:	6a 10                	push   $0x10
    1995:	57                   	push   %edi
    1996:	56                   	push   %esi
    1997:	e8 ef 1f 00 00       	call   398b <read>
    199c:	83 c4 10             	add    $0x10,%esp
    199f:	85 c0                	test   %eax,%eax
    19a1:	7e 3d                	jle    19e0 <concreate+0x190>
    19a3:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    19a8:	74 e6                	je     1990 <concreate+0x140>
    19aa:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    19ae:	75 e0                	jne    1990 <concreate+0x140>
    19b0:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    19b4:	75 da                	jne    1990 <concreate+0x140>
    19b6:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    19ba:	83 e8 30             	sub    $0x30,%eax
    19bd:	83 f8 27             	cmp    $0x27,%eax
    19c0:	0f 87 60 01 00 00    	ja     1b26 <concreate+0x2d6>
    19c6:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    19cb:	0f 85 3d 01 00 00    	jne    1b0e <concreate+0x2be>
    19d1:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
    19d5:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
    19da:	eb b4                	jmp    1990 <concreate+0x140>
    19dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    19e0:	83 ec 0c             	sub    $0xc,%esp
    19e3:	56                   	push   %esi
    19e4:	e8 b2 1f 00 00       	call   399b <close>
    19e9:	83 c4 10             	add    $0x10,%esp
    19ec:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    19f0:	0f 85 05 01 00 00    	jne    1afb <concreate+0x2ab>
    19f6:	31 f6                	xor    %esi,%esi
    19f8:	eb 4c                	jmp    1a46 <concreate+0x1f6>
    19fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1a00:	85 ff                	test   %edi,%edi
    1a02:	74 05                	je     1a09 <concreate+0x1b9>
    1a04:	83 f8 01             	cmp    $0x1,%eax
    1a07:	74 6c                	je     1a75 <concreate+0x225>
    1a09:	83 ec 0c             	sub    $0xc,%esp
    1a0c:	53                   	push   %ebx
    1a0d:	e8 b1 1f 00 00       	call   39c3 <unlink>
    1a12:	89 1c 24             	mov    %ebx,(%esp)
    1a15:	e8 a9 1f 00 00       	call   39c3 <unlink>
    1a1a:	89 1c 24             	mov    %ebx,(%esp)
    1a1d:	e8 a1 1f 00 00       	call   39c3 <unlink>
    1a22:	89 1c 24             	mov    %ebx,(%esp)
    1a25:	e8 99 1f 00 00       	call   39c3 <unlink>
    1a2a:	83 c4 10             	add    $0x10,%esp
    1a2d:	85 ff                	test   %edi,%edi
    1a2f:	0f 84 fc fe ff ff    	je     1931 <concreate+0xe1>
    1a35:	e8 41 1f 00 00       	call   397b <wait>
    1a3a:	83 c6 01             	add    $0x1,%esi
    1a3d:	83 fe 28             	cmp    $0x28,%esi
    1a40:	0f 84 8a 00 00 00    	je     1ad0 <concreate+0x280>
    1a46:	8d 46 30             	lea    0x30(%esi),%eax
    1a49:	88 45 ae             	mov    %al,-0x52(%ebp)
    1a4c:	e8 1a 1f 00 00       	call   396b <fork>
    1a51:	89 c7                	mov    %eax,%edi
    1a53:	85 c0                	test   %eax,%eax
    1a55:	0f 88 8c 00 00 00    	js     1ae7 <concreate+0x297>
    1a5b:	b8 ab aa aa aa       	mov    $0xaaaaaaab,%eax
    1a60:	f7 e6                	mul    %esi
    1a62:	89 d0                	mov    %edx,%eax
    1a64:	83 e2 fe             	and    $0xfffffffe,%edx
    1a67:	d1 e8                	shr    %eax
    1a69:	01 c2                	add    %eax,%edx
    1a6b:	89 f0                	mov    %esi,%eax
    1a6d:	29 d0                	sub    %edx,%eax
    1a6f:	89 c1                	mov    %eax,%ecx
    1a71:	09 f9                	or     %edi,%ecx
    1a73:	75 8b                	jne    1a00 <concreate+0x1b0>
    1a75:	83 ec 08             	sub    $0x8,%esp
    1a78:	6a 00                	push   $0x0
    1a7a:	53                   	push   %ebx
    1a7b:	e8 33 1f 00 00       	call   39b3 <open>
    1a80:	89 04 24             	mov    %eax,(%esp)
    1a83:	e8 13 1f 00 00       	call   399b <close>
    1a88:	58                   	pop    %eax
    1a89:	5a                   	pop    %edx
    1a8a:	6a 00                	push   $0x0
    1a8c:	53                   	push   %ebx
    1a8d:	e8 21 1f 00 00       	call   39b3 <open>
    1a92:	89 04 24             	mov    %eax,(%esp)
    1a95:	e8 01 1f 00 00       	call   399b <close>
    1a9a:	59                   	pop    %ecx
    1a9b:	58                   	pop    %eax
    1a9c:	6a 00                	push   $0x0
    1a9e:	53                   	push   %ebx
    1a9f:	e8 0f 1f 00 00       	call   39b3 <open>
    1aa4:	89 04 24             	mov    %eax,(%esp)
    1aa7:	e8 ef 1e 00 00       	call   399b <close>
    1aac:	58                   	pop    %eax
    1aad:	5a                   	pop    %edx
    1aae:	6a 00                	push   $0x0
    1ab0:	53                   	push   %ebx
    1ab1:	e8 fd 1e 00 00       	call   39b3 <open>
    1ab6:	89 04 24             	mov    %eax,(%esp)
    1ab9:	e8 dd 1e 00 00       	call   399b <close>
    1abe:	83 c4 10             	add    $0x10,%esp
    1ac1:	e9 67 ff ff ff       	jmp    1a2d <concreate+0x1dd>
    1ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1acd:	8d 76 00             	lea    0x0(%esi),%esi
    1ad0:	83 ec 08             	sub    $0x8,%esp
    1ad3:	68 e6 44 00 00       	push   $0x44e6
    1ad8:	6a 01                	push   $0x1
    1ada:	e8 21 20 00 00       	call   3b00 <printf>
    1adf:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1ae2:	5b                   	pop    %ebx
    1ae3:	5e                   	pop    %esi
    1ae4:	5f                   	pop    %edi
    1ae5:	5d                   	pop    %ebp
    1ae6:	c3                   	ret    
    1ae7:	83 ec 08             	sub    $0x8,%esp
    1aea:	68 69 4d 00 00       	push   $0x4d69
    1aef:	6a 01                	push   $0x1
    1af1:	e8 0a 20 00 00       	call   3b00 <printf>
    1af6:	e8 78 1e 00 00       	call   3973 <exit>
    1afb:	51                   	push   %ecx
    1afc:	51                   	push   %ecx
    1afd:	68 30 50 00 00       	push   $0x5030
    1b02:	6a 01                	push   $0x1
    1b04:	e8 f7 1f 00 00       	call   3b00 <printf>
    1b09:	e8 65 1e 00 00       	call   3973 <exit>
    1b0e:	83 ec 04             	sub    $0x4,%esp
    1b11:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1b14:	50                   	push   %eax
    1b15:	68 c9 44 00 00       	push   $0x44c9
    1b1a:	6a 01                	push   $0x1
    1b1c:	e8 df 1f 00 00       	call   3b00 <printf>
    1b21:	e8 4d 1e 00 00       	call   3973 <exit>
    1b26:	83 ec 04             	sub    $0x4,%esp
    1b29:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1b2c:	50                   	push   %eax
    1b2d:	68 b0 44 00 00       	push   $0x44b0
    1b32:	6a 01                	push   $0x1
    1b34:	e8 c7 1f 00 00       	call   3b00 <printf>
    1b39:	e8 35 1e 00 00       	call   3973 <exit>
    1b3e:	83 ec 0c             	sub    $0xc,%esp
    1b41:	50                   	push   %eax
    1b42:	e8 54 1e 00 00       	call   399b <close>
    1b47:	83 c4 10             	add    $0x10,%esp
    1b4a:	e9 e2 fd ff ff       	jmp    1931 <concreate+0xe1>
    1b4f:	90                   	nop

00001b50 <linkunlink>:
    1b50:	f3 0f 1e fb          	endbr32 
    1b54:	55                   	push   %ebp
    1b55:	89 e5                	mov    %esp,%ebp
    1b57:	57                   	push   %edi
    1b58:	56                   	push   %esi
    1b59:	53                   	push   %ebx
    1b5a:	83 ec 24             	sub    $0x24,%esp
    1b5d:	68 f4 44 00 00       	push   $0x44f4
    1b62:	6a 01                	push   $0x1
    1b64:	e8 97 1f 00 00       	call   3b00 <printf>
    1b69:	c7 04 24 81 47 00 00 	movl   $0x4781,(%esp)
    1b70:	e8 4e 1e 00 00       	call   39c3 <unlink>
    1b75:	e8 f1 1d 00 00       	call   396b <fork>
    1b7a:	83 c4 10             	add    $0x10,%esp
    1b7d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    1b80:	85 c0                	test   %eax,%eax
    1b82:	0f 88 b2 00 00 00    	js     1c3a <linkunlink+0xea>
    1b88:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b8c:	bb 64 00 00 00       	mov    $0x64,%ebx
    1b91:	be ab aa aa aa       	mov    $0xaaaaaaab,%esi
    1b96:	19 ff                	sbb    %edi,%edi
    1b98:	83 e7 60             	and    $0x60,%edi
    1b9b:	83 c7 01             	add    $0x1,%edi
    1b9e:	eb 1a                	jmp    1bba <linkunlink+0x6a>
    1ba0:	83 f8 01             	cmp    $0x1,%eax
    1ba3:	74 7b                	je     1c20 <linkunlink+0xd0>
    1ba5:	83 ec 0c             	sub    $0xc,%esp
    1ba8:	68 81 47 00 00       	push   $0x4781
    1bad:	e8 11 1e 00 00       	call   39c3 <unlink>
    1bb2:	83 c4 10             	add    $0x10,%esp
    1bb5:	83 eb 01             	sub    $0x1,%ebx
    1bb8:	74 41                	je     1bfb <linkunlink+0xab>
    1bba:	69 cf 6d 4e c6 41    	imul   $0x41c64e6d,%edi,%ecx
    1bc0:	8d b9 39 30 00 00    	lea    0x3039(%ecx),%edi
    1bc6:	89 f8                	mov    %edi,%eax
    1bc8:	f7 e6                	mul    %esi
    1bca:	89 d0                	mov    %edx,%eax
    1bcc:	83 e2 fe             	and    $0xfffffffe,%edx
    1bcf:	d1 e8                	shr    %eax
    1bd1:	01 c2                	add    %eax,%edx
    1bd3:	89 f8                	mov    %edi,%eax
    1bd5:	29 d0                	sub    %edx,%eax
    1bd7:	75 c7                	jne    1ba0 <linkunlink+0x50>
    1bd9:	83 ec 08             	sub    $0x8,%esp
    1bdc:	68 02 02 00 00       	push   $0x202
    1be1:	68 81 47 00 00       	push   $0x4781
    1be6:	e8 c8 1d 00 00       	call   39b3 <open>
    1beb:	89 04 24             	mov    %eax,(%esp)
    1bee:	e8 a8 1d 00 00       	call   399b <close>
    1bf3:	83 c4 10             	add    $0x10,%esp
    1bf6:	83 eb 01             	sub    $0x1,%ebx
    1bf9:	75 bf                	jne    1bba <linkunlink+0x6a>
    1bfb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    1bfe:	85 c0                	test   %eax,%eax
    1c00:	74 4b                	je     1c4d <linkunlink+0xfd>
    1c02:	e8 74 1d 00 00       	call   397b <wait>
    1c07:	83 ec 08             	sub    $0x8,%esp
    1c0a:	68 09 45 00 00       	push   $0x4509
    1c0f:	6a 01                	push   $0x1
    1c11:	e8 ea 1e 00 00       	call   3b00 <printf>
    1c16:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1c19:	5b                   	pop    %ebx
    1c1a:	5e                   	pop    %esi
    1c1b:	5f                   	pop    %edi
    1c1c:	5d                   	pop    %ebp
    1c1d:	c3                   	ret    
    1c1e:	66 90                	xchg   %ax,%ax
    1c20:	83 ec 08             	sub    $0x8,%esp
    1c23:	68 81 47 00 00       	push   $0x4781
    1c28:	68 05 45 00 00       	push   $0x4505
    1c2d:	e8 a1 1d 00 00       	call   39d3 <link>
    1c32:	83 c4 10             	add    $0x10,%esp
    1c35:	e9 7b ff ff ff       	jmp    1bb5 <linkunlink+0x65>
    1c3a:	52                   	push   %edx
    1c3b:	52                   	push   %edx
    1c3c:	68 69 4d 00 00       	push   $0x4d69
    1c41:	6a 01                	push   $0x1
    1c43:	e8 b8 1e 00 00       	call   3b00 <printf>
    1c48:	e8 26 1d 00 00       	call   3973 <exit>
    1c4d:	e8 21 1d 00 00       	call   3973 <exit>
    1c52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1c59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001c60 <bigdir>:
    1c60:	f3 0f 1e fb          	endbr32 
    1c64:	55                   	push   %ebp
    1c65:	89 e5                	mov    %esp,%ebp
    1c67:	57                   	push   %edi
    1c68:	56                   	push   %esi
    1c69:	53                   	push   %ebx
    1c6a:	83 ec 24             	sub    $0x24,%esp
    1c6d:	68 18 45 00 00       	push   $0x4518
    1c72:	6a 01                	push   $0x1
    1c74:	e8 87 1e 00 00       	call   3b00 <printf>
    1c79:	c7 04 24 25 45 00 00 	movl   $0x4525,(%esp)
    1c80:	e8 3e 1d 00 00       	call   39c3 <unlink>
    1c85:	5a                   	pop    %edx
    1c86:	59                   	pop    %ecx
    1c87:	68 00 02 00 00       	push   $0x200
    1c8c:	68 25 45 00 00       	push   $0x4525
    1c91:	e8 1d 1d 00 00       	call   39b3 <open>
    1c96:	83 c4 10             	add    $0x10,%esp
    1c99:	85 c0                	test   %eax,%eax
    1c9b:	0f 88 ea 00 00 00    	js     1d8b <bigdir+0x12b>
    1ca1:	83 ec 0c             	sub    $0xc,%esp
    1ca4:	31 f6                	xor    %esi,%esi
    1ca6:	8d 7d de             	lea    -0x22(%ebp),%edi
    1ca9:	50                   	push   %eax
    1caa:	e8 ec 1c 00 00       	call   399b <close>
    1caf:	83 c4 10             	add    $0x10,%esp
    1cb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1cb8:	89 f0                	mov    %esi,%eax
    1cba:	83 ec 08             	sub    $0x8,%esp
    1cbd:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1cc1:	c1 f8 06             	sar    $0x6,%eax
    1cc4:	57                   	push   %edi
    1cc5:	83 c0 30             	add    $0x30,%eax
    1cc8:	68 25 45 00 00       	push   $0x4525
    1ccd:	88 45 df             	mov    %al,-0x21(%ebp)
    1cd0:	89 f0                	mov    %esi,%eax
    1cd2:	83 e0 3f             	and    $0x3f,%eax
    1cd5:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1cd9:	83 c0 30             	add    $0x30,%eax
    1cdc:	88 45 e0             	mov    %al,-0x20(%ebp)
    1cdf:	e8 ef 1c 00 00       	call   39d3 <link>
    1ce4:	83 c4 10             	add    $0x10,%esp
    1ce7:	89 c3                	mov    %eax,%ebx
    1ce9:	85 c0                	test   %eax,%eax
    1ceb:	75 76                	jne    1d63 <bigdir+0x103>
    1ced:	83 c6 01             	add    $0x1,%esi
    1cf0:	81 fe f4 01 00 00    	cmp    $0x1f4,%esi
    1cf6:	75 c0                	jne    1cb8 <bigdir+0x58>
    1cf8:	83 ec 0c             	sub    $0xc,%esp
    1cfb:	68 25 45 00 00       	push   $0x4525
    1d00:	e8 be 1c 00 00       	call   39c3 <unlink>
    1d05:	83 c4 10             	add    $0x10,%esp
    1d08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1d0f:	90                   	nop
    1d10:	89 d8                	mov    %ebx,%eax
    1d12:	83 ec 0c             	sub    $0xc,%esp
    1d15:	c6 45 de 78          	movb   $0x78,-0x22(%ebp)
    1d19:	c1 f8 06             	sar    $0x6,%eax
    1d1c:	57                   	push   %edi
    1d1d:	83 c0 30             	add    $0x30,%eax
    1d20:	c6 45 e1 00          	movb   $0x0,-0x1f(%ebp)
    1d24:	88 45 df             	mov    %al,-0x21(%ebp)
    1d27:	89 d8                	mov    %ebx,%eax
    1d29:	83 e0 3f             	and    $0x3f,%eax
    1d2c:	83 c0 30             	add    $0x30,%eax
    1d2f:	88 45 e0             	mov    %al,-0x20(%ebp)
    1d32:	e8 8c 1c 00 00       	call   39c3 <unlink>
    1d37:	83 c4 10             	add    $0x10,%esp
    1d3a:	85 c0                	test   %eax,%eax
    1d3c:	75 39                	jne    1d77 <bigdir+0x117>
    1d3e:	83 c3 01             	add    $0x1,%ebx
    1d41:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1d47:	75 c7                	jne    1d10 <bigdir+0xb0>
    1d49:	83 ec 08             	sub    $0x8,%esp
    1d4c:	68 67 45 00 00       	push   $0x4567
    1d51:	6a 01                	push   $0x1
    1d53:	e8 a8 1d 00 00       	call   3b00 <printf>
    1d58:	83 c4 10             	add    $0x10,%esp
    1d5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1d5e:	5b                   	pop    %ebx
    1d5f:	5e                   	pop    %esi
    1d60:	5f                   	pop    %edi
    1d61:	5d                   	pop    %ebp
    1d62:	c3                   	ret    
    1d63:	83 ec 08             	sub    $0x8,%esp
    1d66:	68 3e 45 00 00       	push   $0x453e
    1d6b:	6a 01                	push   $0x1
    1d6d:	e8 8e 1d 00 00       	call   3b00 <printf>
    1d72:	e8 fc 1b 00 00       	call   3973 <exit>
    1d77:	83 ec 08             	sub    $0x8,%esp
    1d7a:	68 52 45 00 00       	push   $0x4552
    1d7f:	6a 01                	push   $0x1
    1d81:	e8 7a 1d 00 00       	call   3b00 <printf>
    1d86:	e8 e8 1b 00 00       	call   3973 <exit>
    1d8b:	50                   	push   %eax
    1d8c:	50                   	push   %eax
    1d8d:	68 28 45 00 00       	push   $0x4528
    1d92:	6a 01                	push   $0x1
    1d94:	e8 67 1d 00 00       	call   3b00 <printf>
    1d99:	e8 d5 1b 00 00       	call   3973 <exit>
    1d9e:	66 90                	xchg   %ax,%ax

00001da0 <subdir>:
    1da0:	f3 0f 1e fb          	endbr32 
    1da4:	55                   	push   %ebp
    1da5:	89 e5                	mov    %esp,%ebp
    1da7:	53                   	push   %ebx
    1da8:	83 ec 0c             	sub    $0xc,%esp
    1dab:	68 72 45 00 00       	push   $0x4572
    1db0:	6a 01                	push   $0x1
    1db2:	e8 49 1d 00 00       	call   3b00 <printf>
    1db7:	c7 04 24 fb 45 00 00 	movl   $0x45fb,(%esp)
    1dbe:	e8 00 1c 00 00       	call   39c3 <unlink>
    1dc3:	c7 04 24 98 46 00 00 	movl   $0x4698,(%esp)
    1dca:	e8 0c 1c 00 00       	call   39db <mkdir>
    1dcf:	83 c4 10             	add    $0x10,%esp
    1dd2:	85 c0                	test   %eax,%eax
    1dd4:	0f 85 b3 05 00 00    	jne    238d <subdir+0x5ed>
    1dda:	83 ec 08             	sub    $0x8,%esp
    1ddd:	68 02 02 00 00       	push   $0x202
    1de2:	68 d1 45 00 00       	push   $0x45d1
    1de7:	e8 c7 1b 00 00       	call   39b3 <open>
    1dec:	83 c4 10             	add    $0x10,%esp
    1def:	89 c3                	mov    %eax,%ebx
    1df1:	85 c0                	test   %eax,%eax
    1df3:	0f 88 81 05 00 00    	js     237a <subdir+0x5da>
    1df9:	83 ec 04             	sub    $0x4,%esp
    1dfc:	6a 02                	push   $0x2
    1dfe:	68 fb 45 00 00       	push   $0x45fb
    1e03:	50                   	push   %eax
    1e04:	e8 8a 1b 00 00       	call   3993 <write>
    1e09:	89 1c 24             	mov    %ebx,(%esp)
    1e0c:	e8 8a 1b 00 00       	call   399b <close>
    1e11:	c7 04 24 98 46 00 00 	movl   $0x4698,(%esp)
    1e18:	e8 a6 1b 00 00       	call   39c3 <unlink>
    1e1d:	83 c4 10             	add    $0x10,%esp
    1e20:	85 c0                	test   %eax,%eax
    1e22:	0f 89 3f 05 00 00    	jns    2367 <subdir+0x5c7>
    1e28:	83 ec 0c             	sub    $0xc,%esp
    1e2b:	68 ac 45 00 00       	push   $0x45ac
    1e30:	e8 a6 1b 00 00       	call   39db <mkdir>
    1e35:	83 c4 10             	add    $0x10,%esp
    1e38:	85 c0                	test   %eax,%eax
    1e3a:	0f 85 14 05 00 00    	jne    2354 <subdir+0x5b4>
    1e40:	83 ec 08             	sub    $0x8,%esp
    1e43:	68 02 02 00 00       	push   $0x202
    1e48:	68 ce 45 00 00       	push   $0x45ce
    1e4d:	e8 61 1b 00 00       	call   39b3 <open>
    1e52:	83 c4 10             	add    $0x10,%esp
    1e55:	89 c3                	mov    %eax,%ebx
    1e57:	85 c0                	test   %eax,%eax
    1e59:	0f 88 24 04 00 00    	js     2283 <subdir+0x4e3>
    1e5f:	83 ec 04             	sub    $0x4,%esp
    1e62:	6a 02                	push   $0x2
    1e64:	68 ef 45 00 00       	push   $0x45ef
    1e69:	50                   	push   %eax
    1e6a:	e8 24 1b 00 00       	call   3993 <write>
    1e6f:	89 1c 24             	mov    %ebx,(%esp)
    1e72:	e8 24 1b 00 00       	call   399b <close>
    1e77:	58                   	pop    %eax
    1e78:	5a                   	pop    %edx
    1e79:	6a 00                	push   $0x0
    1e7b:	68 f2 45 00 00       	push   $0x45f2
    1e80:	e8 2e 1b 00 00       	call   39b3 <open>
    1e85:	83 c4 10             	add    $0x10,%esp
    1e88:	89 c3                	mov    %eax,%ebx
    1e8a:	85 c0                	test   %eax,%eax
    1e8c:	0f 88 de 03 00 00    	js     2270 <subdir+0x4d0>
    1e92:	83 ec 04             	sub    $0x4,%esp
    1e95:	68 00 20 00 00       	push   $0x2000
    1e9a:	68 00 87 00 00       	push   $0x8700
    1e9f:	50                   	push   %eax
    1ea0:	e8 e6 1a 00 00       	call   398b <read>
    1ea5:	83 c4 10             	add    $0x10,%esp
    1ea8:	83 f8 02             	cmp    $0x2,%eax
    1eab:	0f 85 3a 03 00 00    	jne    21eb <subdir+0x44b>
    1eb1:	80 3d 00 87 00 00 66 	cmpb   $0x66,0x8700
    1eb8:	0f 85 2d 03 00 00    	jne    21eb <subdir+0x44b>
    1ebe:	83 ec 0c             	sub    $0xc,%esp
    1ec1:	53                   	push   %ebx
    1ec2:	e8 d4 1a 00 00       	call   399b <close>
    1ec7:	59                   	pop    %ecx
    1ec8:	5b                   	pop    %ebx
    1ec9:	68 32 46 00 00       	push   $0x4632
    1ece:	68 ce 45 00 00       	push   $0x45ce
    1ed3:	e8 fb 1a 00 00       	call   39d3 <link>
    1ed8:	83 c4 10             	add    $0x10,%esp
    1edb:	85 c0                	test   %eax,%eax
    1edd:	0f 85 c6 03 00 00    	jne    22a9 <subdir+0x509>
    1ee3:	83 ec 0c             	sub    $0xc,%esp
    1ee6:	68 ce 45 00 00       	push   $0x45ce
    1eeb:	e8 d3 1a 00 00       	call   39c3 <unlink>
    1ef0:	83 c4 10             	add    $0x10,%esp
    1ef3:	85 c0                	test   %eax,%eax
    1ef5:	0f 85 16 03 00 00    	jne    2211 <subdir+0x471>
    1efb:	83 ec 08             	sub    $0x8,%esp
    1efe:	6a 00                	push   $0x0
    1f00:	68 ce 45 00 00       	push   $0x45ce
    1f05:	e8 a9 1a 00 00       	call   39b3 <open>
    1f0a:	83 c4 10             	add    $0x10,%esp
    1f0d:	85 c0                	test   %eax,%eax
    1f0f:	0f 89 2c 04 00 00    	jns    2341 <subdir+0x5a1>
    1f15:	83 ec 0c             	sub    $0xc,%esp
    1f18:	68 98 46 00 00       	push   $0x4698
    1f1d:	e8 c1 1a 00 00       	call   39e3 <chdir>
    1f22:	83 c4 10             	add    $0x10,%esp
    1f25:	85 c0                	test   %eax,%eax
    1f27:	0f 85 01 04 00 00    	jne    232e <subdir+0x58e>
    1f2d:	83 ec 0c             	sub    $0xc,%esp
    1f30:	68 66 46 00 00       	push   $0x4666
    1f35:	e8 a9 1a 00 00       	call   39e3 <chdir>
    1f3a:	83 c4 10             	add    $0x10,%esp
    1f3d:	85 c0                	test   %eax,%eax
    1f3f:	0f 85 b9 02 00 00    	jne    21fe <subdir+0x45e>
    1f45:	83 ec 0c             	sub    $0xc,%esp
    1f48:	68 8c 46 00 00       	push   $0x468c
    1f4d:	e8 91 1a 00 00       	call   39e3 <chdir>
    1f52:	83 c4 10             	add    $0x10,%esp
    1f55:	85 c0                	test   %eax,%eax
    1f57:	0f 85 a1 02 00 00    	jne    21fe <subdir+0x45e>
    1f5d:	83 ec 0c             	sub    $0xc,%esp
    1f60:	68 9b 46 00 00       	push   $0x469b
    1f65:	e8 79 1a 00 00       	call   39e3 <chdir>
    1f6a:	83 c4 10             	add    $0x10,%esp
    1f6d:	85 c0                	test   %eax,%eax
    1f6f:	0f 85 21 03 00 00    	jne    2296 <subdir+0x4f6>
    1f75:	83 ec 08             	sub    $0x8,%esp
    1f78:	6a 00                	push   $0x0
    1f7a:	68 32 46 00 00       	push   $0x4632
    1f7f:	e8 2f 1a 00 00       	call   39b3 <open>
    1f84:	83 c4 10             	add    $0x10,%esp
    1f87:	89 c3                	mov    %eax,%ebx
    1f89:	85 c0                	test   %eax,%eax
    1f8b:	0f 88 e0 04 00 00    	js     2471 <subdir+0x6d1>
    1f91:	83 ec 04             	sub    $0x4,%esp
    1f94:	68 00 20 00 00       	push   $0x2000
    1f99:	68 00 87 00 00       	push   $0x8700
    1f9e:	50                   	push   %eax
    1f9f:	e8 e7 19 00 00       	call   398b <read>
    1fa4:	83 c4 10             	add    $0x10,%esp
    1fa7:	83 f8 02             	cmp    $0x2,%eax
    1faa:	0f 85 ae 04 00 00    	jne    245e <subdir+0x6be>
    1fb0:	83 ec 0c             	sub    $0xc,%esp
    1fb3:	53                   	push   %ebx
    1fb4:	e8 e2 19 00 00       	call   399b <close>
    1fb9:	58                   	pop    %eax
    1fba:	5a                   	pop    %edx
    1fbb:	6a 00                	push   $0x0
    1fbd:	68 ce 45 00 00       	push   $0x45ce
    1fc2:	e8 ec 19 00 00       	call   39b3 <open>
    1fc7:	83 c4 10             	add    $0x10,%esp
    1fca:	85 c0                	test   %eax,%eax
    1fcc:	0f 89 65 02 00 00    	jns    2237 <subdir+0x497>
    1fd2:	83 ec 08             	sub    $0x8,%esp
    1fd5:	68 02 02 00 00       	push   $0x202
    1fda:	68 e6 46 00 00       	push   $0x46e6
    1fdf:	e8 cf 19 00 00       	call   39b3 <open>
    1fe4:	83 c4 10             	add    $0x10,%esp
    1fe7:	85 c0                	test   %eax,%eax
    1fe9:	0f 89 35 02 00 00    	jns    2224 <subdir+0x484>
    1fef:	83 ec 08             	sub    $0x8,%esp
    1ff2:	68 02 02 00 00       	push   $0x202
    1ff7:	68 0b 47 00 00       	push   $0x470b
    1ffc:	e8 b2 19 00 00       	call   39b3 <open>
    2001:	83 c4 10             	add    $0x10,%esp
    2004:	85 c0                	test   %eax,%eax
    2006:	0f 89 0f 03 00 00    	jns    231b <subdir+0x57b>
    200c:	83 ec 08             	sub    $0x8,%esp
    200f:	68 00 02 00 00       	push   $0x200
    2014:	68 98 46 00 00       	push   $0x4698
    2019:	e8 95 19 00 00       	call   39b3 <open>
    201e:	83 c4 10             	add    $0x10,%esp
    2021:	85 c0                	test   %eax,%eax
    2023:	0f 89 df 02 00 00    	jns    2308 <subdir+0x568>
    2029:	83 ec 08             	sub    $0x8,%esp
    202c:	6a 02                	push   $0x2
    202e:	68 98 46 00 00       	push   $0x4698
    2033:	e8 7b 19 00 00       	call   39b3 <open>
    2038:	83 c4 10             	add    $0x10,%esp
    203b:	85 c0                	test   %eax,%eax
    203d:	0f 89 b2 02 00 00    	jns    22f5 <subdir+0x555>
    2043:	83 ec 08             	sub    $0x8,%esp
    2046:	6a 01                	push   $0x1
    2048:	68 98 46 00 00       	push   $0x4698
    204d:	e8 61 19 00 00       	call   39b3 <open>
    2052:	83 c4 10             	add    $0x10,%esp
    2055:	85 c0                	test   %eax,%eax
    2057:	0f 89 85 02 00 00    	jns    22e2 <subdir+0x542>
    205d:	83 ec 08             	sub    $0x8,%esp
    2060:	68 7a 47 00 00       	push   $0x477a
    2065:	68 e6 46 00 00       	push   $0x46e6
    206a:	e8 64 19 00 00       	call   39d3 <link>
    206f:	83 c4 10             	add    $0x10,%esp
    2072:	85 c0                	test   %eax,%eax
    2074:	0f 84 55 02 00 00    	je     22cf <subdir+0x52f>
    207a:	83 ec 08             	sub    $0x8,%esp
    207d:	68 7a 47 00 00       	push   $0x477a
    2082:	68 0b 47 00 00       	push   $0x470b
    2087:	e8 47 19 00 00       	call   39d3 <link>
    208c:	83 c4 10             	add    $0x10,%esp
    208f:	85 c0                	test   %eax,%eax
    2091:	0f 84 25 02 00 00    	je     22bc <subdir+0x51c>
    2097:	83 ec 08             	sub    $0x8,%esp
    209a:	68 32 46 00 00       	push   $0x4632
    209f:	68 d1 45 00 00       	push   $0x45d1
    20a4:	e8 2a 19 00 00       	call   39d3 <link>
    20a9:	83 c4 10             	add    $0x10,%esp
    20ac:	85 c0                	test   %eax,%eax
    20ae:	0f 84 a9 01 00 00    	je     225d <subdir+0x4bd>
    20b4:	83 ec 0c             	sub    $0xc,%esp
    20b7:	68 e6 46 00 00       	push   $0x46e6
    20bc:	e8 1a 19 00 00       	call   39db <mkdir>
    20c1:	83 c4 10             	add    $0x10,%esp
    20c4:	85 c0                	test   %eax,%eax
    20c6:	0f 84 7e 01 00 00    	je     224a <subdir+0x4aa>
    20cc:	83 ec 0c             	sub    $0xc,%esp
    20cf:	68 0b 47 00 00       	push   $0x470b
    20d4:	e8 02 19 00 00       	call   39db <mkdir>
    20d9:	83 c4 10             	add    $0x10,%esp
    20dc:	85 c0                	test   %eax,%eax
    20de:	0f 84 67 03 00 00    	je     244b <subdir+0x6ab>
    20e4:	83 ec 0c             	sub    $0xc,%esp
    20e7:	68 32 46 00 00       	push   $0x4632
    20ec:	e8 ea 18 00 00       	call   39db <mkdir>
    20f1:	83 c4 10             	add    $0x10,%esp
    20f4:	85 c0                	test   %eax,%eax
    20f6:	0f 84 3c 03 00 00    	je     2438 <subdir+0x698>
    20fc:	83 ec 0c             	sub    $0xc,%esp
    20ff:	68 0b 47 00 00       	push   $0x470b
    2104:	e8 ba 18 00 00       	call   39c3 <unlink>
    2109:	83 c4 10             	add    $0x10,%esp
    210c:	85 c0                	test   %eax,%eax
    210e:	0f 84 11 03 00 00    	je     2425 <subdir+0x685>
    2114:	83 ec 0c             	sub    $0xc,%esp
    2117:	68 e6 46 00 00       	push   $0x46e6
    211c:	e8 a2 18 00 00       	call   39c3 <unlink>
    2121:	83 c4 10             	add    $0x10,%esp
    2124:	85 c0                	test   %eax,%eax
    2126:	0f 84 e6 02 00 00    	je     2412 <subdir+0x672>
    212c:	83 ec 0c             	sub    $0xc,%esp
    212f:	68 d1 45 00 00       	push   $0x45d1
    2134:	e8 aa 18 00 00       	call   39e3 <chdir>
    2139:	83 c4 10             	add    $0x10,%esp
    213c:	85 c0                	test   %eax,%eax
    213e:	0f 84 bb 02 00 00    	je     23ff <subdir+0x65f>
    2144:	83 ec 0c             	sub    $0xc,%esp
    2147:	68 7d 47 00 00       	push   $0x477d
    214c:	e8 92 18 00 00       	call   39e3 <chdir>
    2151:	83 c4 10             	add    $0x10,%esp
    2154:	85 c0                	test   %eax,%eax
    2156:	0f 84 90 02 00 00    	je     23ec <subdir+0x64c>
    215c:	83 ec 0c             	sub    $0xc,%esp
    215f:	68 32 46 00 00       	push   $0x4632
    2164:	e8 5a 18 00 00       	call   39c3 <unlink>
    2169:	83 c4 10             	add    $0x10,%esp
    216c:	85 c0                	test   %eax,%eax
    216e:	0f 85 9d 00 00 00    	jne    2211 <subdir+0x471>
    2174:	83 ec 0c             	sub    $0xc,%esp
    2177:	68 d1 45 00 00       	push   $0x45d1
    217c:	e8 42 18 00 00       	call   39c3 <unlink>
    2181:	83 c4 10             	add    $0x10,%esp
    2184:	85 c0                	test   %eax,%eax
    2186:	0f 85 4d 02 00 00    	jne    23d9 <subdir+0x639>
    218c:	83 ec 0c             	sub    $0xc,%esp
    218f:	68 98 46 00 00       	push   $0x4698
    2194:	e8 2a 18 00 00       	call   39c3 <unlink>
    2199:	83 c4 10             	add    $0x10,%esp
    219c:	85 c0                	test   %eax,%eax
    219e:	0f 84 22 02 00 00    	je     23c6 <subdir+0x626>
    21a4:	83 ec 0c             	sub    $0xc,%esp
    21a7:	68 ad 45 00 00       	push   $0x45ad
    21ac:	e8 12 18 00 00       	call   39c3 <unlink>
    21b1:	83 c4 10             	add    $0x10,%esp
    21b4:	85 c0                	test   %eax,%eax
    21b6:	0f 88 f7 01 00 00    	js     23b3 <subdir+0x613>
    21bc:	83 ec 0c             	sub    $0xc,%esp
    21bf:	68 98 46 00 00       	push   $0x4698
    21c4:	e8 fa 17 00 00       	call   39c3 <unlink>
    21c9:	83 c4 10             	add    $0x10,%esp
    21cc:	85 c0                	test   %eax,%eax
    21ce:	0f 88 cc 01 00 00    	js     23a0 <subdir+0x600>
    21d4:	83 ec 08             	sub    $0x8,%esp
    21d7:	68 7a 48 00 00       	push   $0x487a
    21dc:	6a 01                	push   $0x1
    21de:	e8 1d 19 00 00       	call   3b00 <printf>
    21e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    21e6:	83 c4 10             	add    $0x10,%esp
    21e9:	c9                   	leave  
    21ea:	c3                   	ret    
    21eb:	50                   	push   %eax
    21ec:	50                   	push   %eax
    21ed:	68 17 46 00 00       	push   $0x4617
    21f2:	6a 01                	push   $0x1
    21f4:	e8 07 19 00 00       	call   3b00 <printf>
    21f9:	e8 75 17 00 00       	call   3973 <exit>
    21fe:	50                   	push   %eax
    21ff:	50                   	push   %eax
    2200:	68 72 46 00 00       	push   $0x4672
    2205:	6a 01                	push   $0x1
    2207:	e8 f4 18 00 00       	call   3b00 <printf>
    220c:	e8 62 17 00 00       	call   3973 <exit>
    2211:	50                   	push   %eax
    2212:	50                   	push   %eax
    2213:	68 3d 46 00 00       	push   $0x463d
    2218:	6a 01                	push   $0x1
    221a:	e8 e1 18 00 00       	call   3b00 <printf>
    221f:	e8 4f 17 00 00       	call   3973 <exit>
    2224:	51                   	push   %ecx
    2225:	51                   	push   %ecx
    2226:	68 ef 46 00 00       	push   $0x46ef
    222b:	6a 01                	push   $0x1
    222d:	e8 ce 18 00 00       	call   3b00 <printf>
    2232:	e8 3c 17 00 00       	call   3973 <exit>
    2237:	53                   	push   %ebx
    2238:	53                   	push   %ebx
    2239:	68 d4 50 00 00       	push   $0x50d4
    223e:	6a 01                	push   $0x1
    2240:	e8 bb 18 00 00       	call   3b00 <printf>
    2245:	e8 29 17 00 00       	call   3973 <exit>
    224a:	51                   	push   %ecx
    224b:	51                   	push   %ecx
    224c:	68 83 47 00 00       	push   $0x4783
    2251:	6a 01                	push   $0x1
    2253:	e8 a8 18 00 00       	call   3b00 <printf>
    2258:	e8 16 17 00 00       	call   3973 <exit>
    225d:	53                   	push   %ebx
    225e:	53                   	push   %ebx
    225f:	68 44 51 00 00       	push   $0x5144
    2264:	6a 01                	push   $0x1
    2266:	e8 95 18 00 00       	call   3b00 <printf>
    226b:	e8 03 17 00 00       	call   3973 <exit>
    2270:	50                   	push   %eax
    2271:	50                   	push   %eax
    2272:	68 fe 45 00 00       	push   $0x45fe
    2277:	6a 01                	push   $0x1
    2279:	e8 82 18 00 00       	call   3b00 <printf>
    227e:	e8 f0 16 00 00       	call   3973 <exit>
    2283:	51                   	push   %ecx
    2284:	51                   	push   %ecx
    2285:	68 d7 45 00 00       	push   $0x45d7
    228a:	6a 01                	push   $0x1
    228c:	e8 6f 18 00 00       	call   3b00 <printf>
    2291:	e8 dd 16 00 00       	call   3973 <exit>
    2296:	50                   	push   %eax
    2297:	50                   	push   %eax
    2298:	68 a0 46 00 00       	push   $0x46a0
    229d:	6a 01                	push   $0x1
    229f:	e8 5c 18 00 00       	call   3b00 <printf>
    22a4:	e8 ca 16 00 00       	call   3973 <exit>
    22a9:	52                   	push   %edx
    22aa:	52                   	push   %edx
    22ab:	68 8c 50 00 00       	push   $0x508c
    22b0:	6a 01                	push   $0x1
    22b2:	e8 49 18 00 00       	call   3b00 <printf>
    22b7:	e8 b7 16 00 00       	call   3973 <exit>
    22bc:	50                   	push   %eax
    22bd:	50                   	push   %eax
    22be:	68 20 51 00 00       	push   $0x5120
    22c3:	6a 01                	push   $0x1
    22c5:	e8 36 18 00 00       	call   3b00 <printf>
    22ca:	e8 a4 16 00 00       	call   3973 <exit>
    22cf:	50                   	push   %eax
    22d0:	50                   	push   %eax
    22d1:	68 fc 50 00 00       	push   $0x50fc
    22d6:	6a 01                	push   $0x1
    22d8:	e8 23 18 00 00       	call   3b00 <printf>
    22dd:	e8 91 16 00 00       	call   3973 <exit>
    22e2:	50                   	push   %eax
    22e3:	50                   	push   %eax
    22e4:	68 5f 47 00 00       	push   $0x475f
    22e9:	6a 01                	push   $0x1
    22eb:	e8 10 18 00 00       	call   3b00 <printf>
    22f0:	e8 7e 16 00 00       	call   3973 <exit>
    22f5:	50                   	push   %eax
    22f6:	50                   	push   %eax
    22f7:	68 46 47 00 00       	push   $0x4746
    22fc:	6a 01                	push   $0x1
    22fe:	e8 fd 17 00 00       	call   3b00 <printf>
    2303:	e8 6b 16 00 00       	call   3973 <exit>
    2308:	50                   	push   %eax
    2309:	50                   	push   %eax
    230a:	68 30 47 00 00       	push   $0x4730
    230f:	6a 01                	push   $0x1
    2311:	e8 ea 17 00 00       	call   3b00 <printf>
    2316:	e8 58 16 00 00       	call   3973 <exit>
    231b:	52                   	push   %edx
    231c:	52                   	push   %edx
    231d:	68 14 47 00 00       	push   $0x4714
    2322:	6a 01                	push   $0x1
    2324:	e8 d7 17 00 00       	call   3b00 <printf>
    2329:	e8 45 16 00 00       	call   3973 <exit>
    232e:	50                   	push   %eax
    232f:	50                   	push   %eax
    2330:	68 55 46 00 00       	push   $0x4655
    2335:	6a 01                	push   $0x1
    2337:	e8 c4 17 00 00       	call   3b00 <printf>
    233c:	e8 32 16 00 00       	call   3973 <exit>
    2341:	50                   	push   %eax
    2342:	50                   	push   %eax
    2343:	68 b0 50 00 00       	push   $0x50b0
    2348:	6a 01                	push   $0x1
    234a:	e8 b1 17 00 00       	call   3b00 <printf>
    234f:	e8 1f 16 00 00       	call   3973 <exit>
    2354:	53                   	push   %ebx
    2355:	53                   	push   %ebx
    2356:	68 b3 45 00 00       	push   $0x45b3
    235b:	6a 01                	push   $0x1
    235d:	e8 9e 17 00 00       	call   3b00 <printf>
    2362:	e8 0c 16 00 00       	call   3973 <exit>
    2367:	50                   	push   %eax
    2368:	50                   	push   %eax
    2369:	68 64 50 00 00       	push   $0x5064
    236e:	6a 01                	push   $0x1
    2370:	e8 8b 17 00 00       	call   3b00 <printf>
    2375:	e8 f9 15 00 00       	call   3973 <exit>
    237a:	50                   	push   %eax
    237b:	50                   	push   %eax
    237c:	68 97 45 00 00       	push   $0x4597
    2381:	6a 01                	push   $0x1
    2383:	e8 78 17 00 00       	call   3b00 <printf>
    2388:	e8 e6 15 00 00       	call   3973 <exit>
    238d:	50                   	push   %eax
    238e:	50                   	push   %eax
    238f:	68 7f 45 00 00       	push   $0x457f
    2394:	6a 01                	push   $0x1
    2396:	e8 65 17 00 00       	call   3b00 <printf>
    239b:	e8 d3 15 00 00       	call   3973 <exit>
    23a0:	50                   	push   %eax
    23a1:	50                   	push   %eax
    23a2:	68 68 48 00 00       	push   $0x4868
    23a7:	6a 01                	push   $0x1
    23a9:	e8 52 17 00 00       	call   3b00 <printf>
    23ae:	e8 c0 15 00 00       	call   3973 <exit>
    23b3:	52                   	push   %edx
    23b4:	52                   	push   %edx
    23b5:	68 53 48 00 00       	push   $0x4853
    23ba:	6a 01                	push   $0x1
    23bc:	e8 3f 17 00 00       	call   3b00 <printf>
    23c1:	e8 ad 15 00 00       	call   3973 <exit>
    23c6:	51                   	push   %ecx
    23c7:	51                   	push   %ecx
    23c8:	68 68 51 00 00       	push   $0x5168
    23cd:	6a 01                	push   $0x1
    23cf:	e8 2c 17 00 00       	call   3b00 <printf>
    23d4:	e8 9a 15 00 00       	call   3973 <exit>
    23d9:	53                   	push   %ebx
    23da:	53                   	push   %ebx
    23db:	68 3e 48 00 00       	push   $0x483e
    23e0:	6a 01                	push   $0x1
    23e2:	e8 19 17 00 00       	call   3b00 <printf>
    23e7:	e8 87 15 00 00       	call   3973 <exit>
    23ec:	50                   	push   %eax
    23ed:	50                   	push   %eax
    23ee:	68 26 48 00 00       	push   $0x4826
    23f3:	6a 01                	push   $0x1
    23f5:	e8 06 17 00 00       	call   3b00 <printf>
    23fa:	e8 74 15 00 00       	call   3973 <exit>
    23ff:	50                   	push   %eax
    2400:	50                   	push   %eax
    2401:	68 0e 48 00 00       	push   $0x480e
    2406:	6a 01                	push   $0x1
    2408:	e8 f3 16 00 00       	call   3b00 <printf>
    240d:	e8 61 15 00 00       	call   3973 <exit>
    2412:	50                   	push   %eax
    2413:	50                   	push   %eax
    2414:	68 f2 47 00 00       	push   $0x47f2
    2419:	6a 01                	push   $0x1
    241b:	e8 e0 16 00 00       	call   3b00 <printf>
    2420:	e8 4e 15 00 00       	call   3973 <exit>
    2425:	50                   	push   %eax
    2426:	50                   	push   %eax
    2427:	68 d6 47 00 00       	push   $0x47d6
    242c:	6a 01                	push   $0x1
    242e:	e8 cd 16 00 00       	call   3b00 <printf>
    2433:	e8 3b 15 00 00       	call   3973 <exit>
    2438:	50                   	push   %eax
    2439:	50                   	push   %eax
    243a:	68 b9 47 00 00       	push   $0x47b9
    243f:	6a 01                	push   $0x1
    2441:	e8 ba 16 00 00       	call   3b00 <printf>
    2446:	e8 28 15 00 00       	call   3973 <exit>
    244b:	52                   	push   %edx
    244c:	52                   	push   %edx
    244d:	68 9e 47 00 00       	push   $0x479e
    2452:	6a 01                	push   $0x1
    2454:	e8 a7 16 00 00       	call   3b00 <printf>
    2459:	e8 15 15 00 00       	call   3973 <exit>
    245e:	51                   	push   %ecx
    245f:	51                   	push   %ecx
    2460:	68 cb 46 00 00       	push   $0x46cb
    2465:	6a 01                	push   $0x1
    2467:	e8 94 16 00 00       	call   3b00 <printf>
    246c:	e8 02 15 00 00       	call   3973 <exit>
    2471:	53                   	push   %ebx
    2472:	53                   	push   %ebx
    2473:	68 b3 46 00 00       	push   $0x46b3
    2478:	6a 01                	push   $0x1
    247a:	e8 81 16 00 00       	call   3b00 <printf>
    247f:	e8 ef 14 00 00       	call   3973 <exit>
    2484:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    248b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    248f:	90                   	nop

00002490 <bigwrite>:
    2490:	f3 0f 1e fb          	endbr32 
    2494:	55                   	push   %ebp
    2495:	89 e5                	mov    %esp,%ebp
    2497:	56                   	push   %esi
    2498:	53                   	push   %ebx
    2499:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    249e:	83 ec 08             	sub    $0x8,%esp
    24a1:	68 85 48 00 00       	push   $0x4885
    24a6:	6a 01                	push   $0x1
    24a8:	e8 53 16 00 00       	call   3b00 <printf>
    24ad:	c7 04 24 94 48 00 00 	movl   $0x4894,(%esp)
    24b4:	e8 0a 15 00 00       	call   39c3 <unlink>
    24b9:	83 c4 10             	add    $0x10,%esp
    24bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    24c0:	83 ec 08             	sub    $0x8,%esp
    24c3:	68 02 02 00 00       	push   $0x202
    24c8:	68 94 48 00 00       	push   $0x4894
    24cd:	e8 e1 14 00 00       	call   39b3 <open>
    24d2:	83 c4 10             	add    $0x10,%esp
    24d5:	89 c6                	mov    %eax,%esi
    24d7:	85 c0                	test   %eax,%eax
    24d9:	78 7e                	js     2559 <bigwrite+0xc9>
    24db:	83 ec 04             	sub    $0x4,%esp
    24de:	53                   	push   %ebx
    24df:	68 00 87 00 00       	push   $0x8700
    24e4:	50                   	push   %eax
    24e5:	e8 a9 14 00 00       	call   3993 <write>
    24ea:	83 c4 10             	add    $0x10,%esp
    24ed:	39 d8                	cmp    %ebx,%eax
    24ef:	75 55                	jne    2546 <bigwrite+0xb6>
    24f1:	83 ec 04             	sub    $0x4,%esp
    24f4:	53                   	push   %ebx
    24f5:	68 00 87 00 00       	push   $0x8700
    24fa:	56                   	push   %esi
    24fb:	e8 93 14 00 00       	call   3993 <write>
    2500:	83 c4 10             	add    $0x10,%esp
    2503:	39 d8                	cmp    %ebx,%eax
    2505:	75 3f                	jne    2546 <bigwrite+0xb6>
    2507:	83 ec 0c             	sub    $0xc,%esp
    250a:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    2510:	56                   	push   %esi
    2511:	e8 85 14 00 00       	call   399b <close>
    2516:	c7 04 24 94 48 00 00 	movl   $0x4894,(%esp)
    251d:	e8 a1 14 00 00       	call   39c3 <unlink>
    2522:	83 c4 10             	add    $0x10,%esp
    2525:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    252b:	75 93                	jne    24c0 <bigwrite+0x30>
    252d:	83 ec 08             	sub    $0x8,%esp
    2530:	68 c7 48 00 00       	push   $0x48c7
    2535:	6a 01                	push   $0x1
    2537:	e8 c4 15 00 00       	call   3b00 <printf>
    253c:	83 c4 10             	add    $0x10,%esp
    253f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    2542:	5b                   	pop    %ebx
    2543:	5e                   	pop    %esi
    2544:	5d                   	pop    %ebp
    2545:	c3                   	ret    
    2546:	50                   	push   %eax
    2547:	53                   	push   %ebx
    2548:	68 b5 48 00 00       	push   $0x48b5
    254d:	6a 01                	push   $0x1
    254f:	e8 ac 15 00 00       	call   3b00 <printf>
    2554:	e8 1a 14 00 00       	call   3973 <exit>
    2559:	83 ec 08             	sub    $0x8,%esp
    255c:	68 9d 48 00 00       	push   $0x489d
    2561:	6a 01                	push   $0x1
    2563:	e8 98 15 00 00       	call   3b00 <printf>
    2568:	e8 06 14 00 00       	call   3973 <exit>
    256d:	8d 76 00             	lea    0x0(%esi),%esi

00002570 <bigfile>:
    2570:	f3 0f 1e fb          	endbr32 
    2574:	55                   	push   %ebp
    2575:	89 e5                	mov    %esp,%ebp
    2577:	57                   	push   %edi
    2578:	56                   	push   %esi
    2579:	53                   	push   %ebx
    257a:	83 ec 14             	sub    $0x14,%esp
    257d:	68 d4 48 00 00       	push   $0x48d4
    2582:	6a 01                	push   $0x1
    2584:	e8 77 15 00 00       	call   3b00 <printf>
    2589:	c7 04 24 f0 48 00 00 	movl   $0x48f0,(%esp)
    2590:	e8 2e 14 00 00       	call   39c3 <unlink>
    2595:	58                   	pop    %eax
    2596:	5a                   	pop    %edx
    2597:	68 02 02 00 00       	push   $0x202
    259c:	68 f0 48 00 00       	push   $0x48f0
    25a1:	e8 0d 14 00 00       	call   39b3 <open>
    25a6:	83 c4 10             	add    $0x10,%esp
    25a9:	85 c0                	test   %eax,%eax
    25ab:	0f 88 5a 01 00 00    	js     270b <bigfile+0x19b>
    25b1:	89 c6                	mov    %eax,%esi
    25b3:	31 db                	xor    %ebx,%ebx
    25b5:	8d 76 00             	lea    0x0(%esi),%esi
    25b8:	83 ec 04             	sub    $0x4,%esp
    25bb:	68 58 02 00 00       	push   $0x258
    25c0:	53                   	push   %ebx
    25c1:	68 00 87 00 00       	push   $0x8700
    25c6:	e8 15 12 00 00       	call   37e0 <memset>
    25cb:	83 c4 0c             	add    $0xc,%esp
    25ce:	68 58 02 00 00       	push   $0x258
    25d3:	68 00 87 00 00       	push   $0x8700
    25d8:	56                   	push   %esi
    25d9:	e8 b5 13 00 00       	call   3993 <write>
    25de:	83 c4 10             	add    $0x10,%esp
    25e1:	3d 58 02 00 00       	cmp    $0x258,%eax
    25e6:	0f 85 f8 00 00 00    	jne    26e4 <bigfile+0x174>
    25ec:	83 c3 01             	add    $0x1,%ebx
    25ef:	83 fb 14             	cmp    $0x14,%ebx
    25f2:	75 c4                	jne    25b8 <bigfile+0x48>
    25f4:	83 ec 0c             	sub    $0xc,%esp
    25f7:	56                   	push   %esi
    25f8:	e8 9e 13 00 00       	call   399b <close>
    25fd:	5e                   	pop    %esi
    25fe:	5f                   	pop    %edi
    25ff:	6a 00                	push   $0x0
    2601:	68 f0 48 00 00       	push   $0x48f0
    2606:	e8 a8 13 00 00       	call   39b3 <open>
    260b:	83 c4 10             	add    $0x10,%esp
    260e:	89 c6                	mov    %eax,%esi
    2610:	85 c0                	test   %eax,%eax
    2612:	0f 88 e0 00 00 00    	js     26f8 <bigfile+0x188>
    2618:	31 db                	xor    %ebx,%ebx
    261a:	31 ff                	xor    %edi,%edi
    261c:	eb 30                	jmp    264e <bigfile+0xde>
    261e:	66 90                	xchg   %ax,%ax
    2620:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    2625:	0f 85 91 00 00 00    	jne    26bc <bigfile+0x14c>
    262b:	89 fa                	mov    %edi,%edx
    262d:	0f be 05 00 87 00 00 	movsbl 0x8700,%eax
    2634:	d1 fa                	sar    %edx
    2636:	39 d0                	cmp    %edx,%eax
    2638:	75 6e                	jne    26a8 <bigfile+0x138>
    263a:	0f be 15 2b 88 00 00 	movsbl 0x882b,%edx
    2641:	39 d0                	cmp    %edx,%eax
    2643:	75 63                	jne    26a8 <bigfile+0x138>
    2645:	81 c3 2c 01 00 00    	add    $0x12c,%ebx
    264b:	83 c7 01             	add    $0x1,%edi
    264e:	83 ec 04             	sub    $0x4,%esp
    2651:	68 2c 01 00 00       	push   $0x12c
    2656:	68 00 87 00 00       	push   $0x8700
    265b:	56                   	push   %esi
    265c:	e8 2a 13 00 00       	call   398b <read>
    2661:	83 c4 10             	add    $0x10,%esp
    2664:	85 c0                	test   %eax,%eax
    2666:	78 68                	js     26d0 <bigfile+0x160>
    2668:	75 b6                	jne    2620 <bigfile+0xb0>
    266a:	83 ec 0c             	sub    $0xc,%esp
    266d:	56                   	push   %esi
    266e:	e8 28 13 00 00       	call   399b <close>
    2673:	83 c4 10             	add    $0x10,%esp
    2676:	81 fb e0 2e 00 00    	cmp    $0x2ee0,%ebx
    267c:	0f 85 9c 00 00 00    	jne    271e <bigfile+0x1ae>
    2682:	83 ec 0c             	sub    $0xc,%esp
    2685:	68 f0 48 00 00       	push   $0x48f0
    268a:	e8 34 13 00 00       	call   39c3 <unlink>
    268f:	58                   	pop    %eax
    2690:	5a                   	pop    %edx
    2691:	68 7f 49 00 00       	push   $0x497f
    2696:	6a 01                	push   $0x1
    2698:	e8 63 14 00 00       	call   3b00 <printf>
    269d:	83 c4 10             	add    $0x10,%esp
    26a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    26a3:	5b                   	pop    %ebx
    26a4:	5e                   	pop    %esi
    26a5:	5f                   	pop    %edi
    26a6:	5d                   	pop    %ebp
    26a7:	c3                   	ret    
    26a8:	83 ec 08             	sub    $0x8,%esp
    26ab:	68 4c 49 00 00       	push   $0x494c
    26b0:	6a 01                	push   $0x1
    26b2:	e8 49 14 00 00       	call   3b00 <printf>
    26b7:	e8 b7 12 00 00       	call   3973 <exit>
    26bc:	83 ec 08             	sub    $0x8,%esp
    26bf:	68 38 49 00 00       	push   $0x4938
    26c4:	6a 01                	push   $0x1
    26c6:	e8 35 14 00 00       	call   3b00 <printf>
    26cb:	e8 a3 12 00 00       	call   3973 <exit>
    26d0:	83 ec 08             	sub    $0x8,%esp
    26d3:	68 23 49 00 00       	push   $0x4923
    26d8:	6a 01                	push   $0x1
    26da:	e8 21 14 00 00       	call   3b00 <printf>
    26df:	e8 8f 12 00 00       	call   3973 <exit>
    26e4:	83 ec 08             	sub    $0x8,%esp
    26e7:	68 f8 48 00 00       	push   $0x48f8
    26ec:	6a 01                	push   $0x1
    26ee:	e8 0d 14 00 00       	call   3b00 <printf>
    26f3:	e8 7b 12 00 00       	call   3973 <exit>
    26f8:	53                   	push   %ebx
    26f9:	53                   	push   %ebx
    26fa:	68 0e 49 00 00       	push   $0x490e
    26ff:	6a 01                	push   $0x1
    2701:	e8 fa 13 00 00       	call   3b00 <printf>
    2706:	e8 68 12 00 00       	call   3973 <exit>
    270b:	50                   	push   %eax
    270c:	50                   	push   %eax
    270d:	68 e2 48 00 00       	push   $0x48e2
    2712:	6a 01                	push   $0x1
    2714:	e8 e7 13 00 00       	call   3b00 <printf>
    2719:	e8 55 12 00 00       	call   3973 <exit>
    271e:	51                   	push   %ecx
    271f:	51                   	push   %ecx
    2720:	68 65 49 00 00       	push   $0x4965
    2725:	6a 01                	push   $0x1
    2727:	e8 d4 13 00 00       	call   3b00 <printf>
    272c:	e8 42 12 00 00       	call   3973 <exit>
    2731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    2738:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    273f:	90                   	nop

00002740 <fourteen>:
    2740:	f3 0f 1e fb          	endbr32 
    2744:	55                   	push   %ebp
    2745:	89 e5                	mov    %esp,%ebp
    2747:	83 ec 10             	sub    $0x10,%esp
    274a:	68 90 49 00 00       	push   $0x4990
    274f:	6a 01                	push   $0x1
    2751:	e8 aa 13 00 00       	call   3b00 <printf>
    2756:	c7 04 24 cb 49 00 00 	movl   $0x49cb,(%esp)
    275d:	e8 79 12 00 00       	call   39db <mkdir>
    2762:	83 c4 10             	add    $0x10,%esp
    2765:	85 c0                	test   %eax,%eax
    2767:	0f 85 97 00 00 00    	jne    2804 <fourteen+0xc4>
    276d:	83 ec 0c             	sub    $0xc,%esp
    2770:	68 88 51 00 00       	push   $0x5188
    2775:	e8 61 12 00 00       	call   39db <mkdir>
    277a:	83 c4 10             	add    $0x10,%esp
    277d:	85 c0                	test   %eax,%eax
    277f:	0f 85 de 00 00 00    	jne    2863 <fourteen+0x123>
    2785:	83 ec 08             	sub    $0x8,%esp
    2788:	68 00 02 00 00       	push   $0x200
    278d:	68 d8 51 00 00       	push   $0x51d8
    2792:	e8 1c 12 00 00       	call   39b3 <open>
    2797:	83 c4 10             	add    $0x10,%esp
    279a:	85 c0                	test   %eax,%eax
    279c:	0f 88 ae 00 00 00    	js     2850 <fourteen+0x110>
    27a2:	83 ec 0c             	sub    $0xc,%esp
    27a5:	50                   	push   %eax
    27a6:	e8 f0 11 00 00       	call   399b <close>
    27ab:	58                   	pop    %eax
    27ac:	5a                   	pop    %edx
    27ad:	6a 00                	push   $0x0
    27af:	68 48 52 00 00       	push   $0x5248
    27b4:	e8 fa 11 00 00       	call   39b3 <open>
    27b9:	83 c4 10             	add    $0x10,%esp
    27bc:	85 c0                	test   %eax,%eax
    27be:	78 7d                	js     283d <fourteen+0xfd>
    27c0:	83 ec 0c             	sub    $0xc,%esp
    27c3:	50                   	push   %eax
    27c4:	e8 d2 11 00 00       	call   399b <close>
    27c9:	c7 04 24 bc 49 00 00 	movl   $0x49bc,(%esp)
    27d0:	e8 06 12 00 00       	call   39db <mkdir>
    27d5:	83 c4 10             	add    $0x10,%esp
    27d8:	85 c0                	test   %eax,%eax
    27da:	74 4e                	je     282a <fourteen+0xea>
    27dc:	83 ec 0c             	sub    $0xc,%esp
    27df:	68 e4 52 00 00       	push   $0x52e4
    27e4:	e8 f2 11 00 00       	call   39db <mkdir>
    27e9:	83 c4 10             	add    $0x10,%esp
    27ec:	85 c0                	test   %eax,%eax
    27ee:	74 27                	je     2817 <fourteen+0xd7>
    27f0:	83 ec 08             	sub    $0x8,%esp
    27f3:	68 da 49 00 00       	push   $0x49da
    27f8:	6a 01                	push   $0x1
    27fa:	e8 01 13 00 00       	call   3b00 <printf>
    27ff:	83 c4 10             	add    $0x10,%esp
    2802:	c9                   	leave  
    2803:	c3                   	ret    
    2804:	50                   	push   %eax
    2805:	50                   	push   %eax
    2806:	68 9f 49 00 00       	push   $0x499f
    280b:	6a 01                	push   $0x1
    280d:	e8 ee 12 00 00       	call   3b00 <printf>
    2812:	e8 5c 11 00 00       	call   3973 <exit>
    2817:	50                   	push   %eax
    2818:	50                   	push   %eax
    2819:	68 04 53 00 00       	push   $0x5304
    281e:	6a 01                	push   $0x1
    2820:	e8 db 12 00 00       	call   3b00 <printf>
    2825:	e8 49 11 00 00       	call   3973 <exit>
    282a:	52                   	push   %edx
    282b:	52                   	push   %edx
    282c:	68 b4 52 00 00       	push   $0x52b4
    2831:	6a 01                	push   $0x1
    2833:	e8 c8 12 00 00       	call   3b00 <printf>
    2838:	e8 36 11 00 00       	call   3973 <exit>
    283d:	51                   	push   %ecx
    283e:	51                   	push   %ecx
    283f:	68 78 52 00 00       	push   $0x5278
    2844:	6a 01                	push   $0x1
    2846:	e8 b5 12 00 00       	call   3b00 <printf>
    284b:	e8 23 11 00 00       	call   3973 <exit>
    2850:	51                   	push   %ecx
    2851:	51                   	push   %ecx
    2852:	68 08 52 00 00       	push   $0x5208
    2857:	6a 01                	push   $0x1
    2859:	e8 a2 12 00 00       	call   3b00 <printf>
    285e:	e8 10 11 00 00       	call   3973 <exit>
    2863:	50                   	push   %eax
    2864:	50                   	push   %eax
    2865:	68 a8 51 00 00       	push   $0x51a8
    286a:	6a 01                	push   $0x1
    286c:	e8 8f 12 00 00       	call   3b00 <printf>
    2871:	e8 fd 10 00 00       	call   3973 <exit>
    2876:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    287d:	8d 76 00             	lea    0x0(%esi),%esi

00002880 <rmdot>:
    2880:	f3 0f 1e fb          	endbr32 
    2884:	55                   	push   %ebp
    2885:	89 e5                	mov    %esp,%ebp
    2887:	83 ec 10             	sub    $0x10,%esp
    288a:	68 e7 49 00 00       	push   $0x49e7
    288f:	6a 01                	push   $0x1
    2891:	e8 6a 12 00 00       	call   3b00 <printf>
    2896:	c7 04 24 f3 49 00 00 	movl   $0x49f3,(%esp)
    289d:	e8 39 11 00 00       	call   39db <mkdir>
    28a2:	83 c4 10             	add    $0x10,%esp
    28a5:	85 c0                	test   %eax,%eax
    28a7:	0f 85 b0 00 00 00    	jne    295d <rmdot+0xdd>
    28ad:	83 ec 0c             	sub    $0xc,%esp
    28b0:	68 f3 49 00 00       	push   $0x49f3
    28b5:	e8 29 11 00 00       	call   39e3 <chdir>
    28ba:	83 c4 10             	add    $0x10,%esp
    28bd:	85 c0                	test   %eax,%eax
    28bf:	0f 85 1d 01 00 00    	jne    29e2 <rmdot+0x162>
    28c5:	83 ec 0c             	sub    $0xc,%esp
    28c8:	68 9e 46 00 00       	push   $0x469e
    28cd:	e8 f1 10 00 00       	call   39c3 <unlink>
    28d2:	83 c4 10             	add    $0x10,%esp
    28d5:	85 c0                	test   %eax,%eax
    28d7:	0f 84 f2 00 00 00    	je     29cf <rmdot+0x14f>
    28dd:	83 ec 0c             	sub    $0xc,%esp
    28e0:	68 9d 46 00 00       	push   $0x469d
    28e5:	e8 d9 10 00 00       	call   39c3 <unlink>
    28ea:	83 c4 10             	add    $0x10,%esp
    28ed:	85 c0                	test   %eax,%eax
    28ef:	0f 84 c7 00 00 00    	je     29bc <rmdot+0x13c>
    28f5:	83 ec 0c             	sub    $0xc,%esp
    28f8:	68 71 3e 00 00       	push   $0x3e71
    28fd:	e8 e1 10 00 00       	call   39e3 <chdir>
    2902:	83 c4 10             	add    $0x10,%esp
    2905:	85 c0                	test   %eax,%eax
    2907:	0f 85 9c 00 00 00    	jne    29a9 <rmdot+0x129>
    290d:	83 ec 0c             	sub    $0xc,%esp
    2910:	68 3b 4a 00 00       	push   $0x4a3b
    2915:	e8 a9 10 00 00       	call   39c3 <unlink>
    291a:	83 c4 10             	add    $0x10,%esp
    291d:	85 c0                	test   %eax,%eax
    291f:	74 75                	je     2996 <rmdot+0x116>
    2921:	83 ec 0c             	sub    $0xc,%esp
    2924:	68 59 4a 00 00       	push   $0x4a59
    2929:	e8 95 10 00 00       	call   39c3 <unlink>
    292e:	83 c4 10             	add    $0x10,%esp
    2931:	85 c0                	test   %eax,%eax
    2933:	74 4e                	je     2983 <rmdot+0x103>
    2935:	83 ec 0c             	sub    $0xc,%esp
    2938:	68 f3 49 00 00       	push   $0x49f3
    293d:	e8 81 10 00 00       	call   39c3 <unlink>
    2942:	83 c4 10             	add    $0x10,%esp
    2945:	85 c0                	test   %eax,%eax
    2947:	75 27                	jne    2970 <rmdot+0xf0>
    2949:	83 ec 08             	sub    $0x8,%esp
    294c:	68 8e 4a 00 00       	push   $0x4a8e
    2951:	6a 01                	push   $0x1
    2953:	e8 a8 11 00 00       	call   3b00 <printf>
    2958:	83 c4 10             	add    $0x10,%esp
    295b:	c9                   	leave  
    295c:	c3                   	ret    
    295d:	50                   	push   %eax
    295e:	50                   	push   %eax
    295f:	68 f8 49 00 00       	push   $0x49f8
    2964:	6a 01                	push   $0x1
    2966:	e8 95 11 00 00       	call   3b00 <printf>
    296b:	e8 03 10 00 00       	call   3973 <exit>
    2970:	50                   	push   %eax
    2971:	50                   	push   %eax
    2972:	68 79 4a 00 00       	push   $0x4a79
    2977:	6a 01                	push   $0x1
    2979:	e8 82 11 00 00       	call   3b00 <printf>
    297e:	e8 f0 0f 00 00       	call   3973 <exit>
    2983:	52                   	push   %edx
    2984:	52                   	push   %edx
    2985:	68 61 4a 00 00       	push   $0x4a61
    298a:	6a 01                	push   $0x1
    298c:	e8 6f 11 00 00       	call   3b00 <printf>
    2991:	e8 dd 0f 00 00       	call   3973 <exit>
    2996:	51                   	push   %ecx
    2997:	51                   	push   %ecx
    2998:	68 42 4a 00 00       	push   $0x4a42
    299d:	6a 01                	push   $0x1
    299f:	e8 5c 11 00 00       	call   3b00 <printf>
    29a4:	e8 ca 0f 00 00       	call   3973 <exit>
    29a9:	50                   	push   %eax
    29aa:	50                   	push   %eax
    29ab:	68 73 3e 00 00       	push   $0x3e73
    29b0:	6a 01                	push   $0x1
    29b2:	e8 49 11 00 00       	call   3b00 <printf>
    29b7:	e8 b7 0f 00 00       	call   3973 <exit>
    29bc:	50                   	push   %eax
    29bd:	50                   	push   %eax
    29be:	68 2c 4a 00 00       	push   $0x4a2c
    29c3:	6a 01                	push   $0x1
    29c5:	e8 36 11 00 00       	call   3b00 <printf>
    29ca:	e8 a4 0f 00 00       	call   3973 <exit>
    29cf:	50                   	push   %eax
    29d0:	50                   	push   %eax
    29d1:	68 1e 4a 00 00       	push   $0x4a1e
    29d6:	6a 01                	push   $0x1
    29d8:	e8 23 11 00 00       	call   3b00 <printf>
    29dd:	e8 91 0f 00 00       	call   3973 <exit>
    29e2:	50                   	push   %eax
    29e3:	50                   	push   %eax
    29e4:	68 0b 4a 00 00       	push   $0x4a0b
    29e9:	6a 01                	push   $0x1
    29eb:	e8 10 11 00 00       	call   3b00 <printf>
    29f0:	e8 7e 0f 00 00       	call   3973 <exit>
    29f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    29fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00002a00 <dirfile>:
    2a00:	f3 0f 1e fb          	endbr32 
    2a04:	55                   	push   %ebp
    2a05:	89 e5                	mov    %esp,%ebp
    2a07:	53                   	push   %ebx
    2a08:	83 ec 0c             	sub    $0xc,%esp
    2a0b:	68 98 4a 00 00       	push   $0x4a98
    2a10:	6a 01                	push   $0x1
    2a12:	e8 e9 10 00 00       	call   3b00 <printf>
    2a17:	5b                   	pop    %ebx
    2a18:	58                   	pop    %eax
    2a19:	68 00 02 00 00       	push   $0x200
    2a1e:	68 a5 4a 00 00       	push   $0x4aa5
    2a23:	e8 8b 0f 00 00       	call   39b3 <open>
    2a28:	83 c4 10             	add    $0x10,%esp
    2a2b:	85 c0                	test   %eax,%eax
    2a2d:	0f 88 43 01 00 00    	js     2b76 <dirfile+0x176>
    2a33:	83 ec 0c             	sub    $0xc,%esp
    2a36:	50                   	push   %eax
    2a37:	e8 5f 0f 00 00       	call   399b <close>
    2a3c:	c7 04 24 a5 4a 00 00 	movl   $0x4aa5,(%esp)
    2a43:	e8 9b 0f 00 00       	call   39e3 <chdir>
    2a48:	83 c4 10             	add    $0x10,%esp
    2a4b:	85 c0                	test   %eax,%eax
    2a4d:	0f 84 10 01 00 00    	je     2b63 <dirfile+0x163>
    2a53:	83 ec 08             	sub    $0x8,%esp
    2a56:	6a 00                	push   $0x0
    2a58:	68 de 4a 00 00       	push   $0x4ade
    2a5d:	e8 51 0f 00 00       	call   39b3 <open>
    2a62:	83 c4 10             	add    $0x10,%esp
    2a65:	85 c0                	test   %eax,%eax
    2a67:	0f 89 e3 00 00 00    	jns    2b50 <dirfile+0x150>
    2a6d:	83 ec 08             	sub    $0x8,%esp
    2a70:	68 00 02 00 00       	push   $0x200
    2a75:	68 de 4a 00 00       	push   $0x4ade
    2a7a:	e8 34 0f 00 00       	call   39b3 <open>
    2a7f:	83 c4 10             	add    $0x10,%esp
    2a82:	85 c0                	test   %eax,%eax
    2a84:	0f 89 c6 00 00 00    	jns    2b50 <dirfile+0x150>
    2a8a:	83 ec 0c             	sub    $0xc,%esp
    2a8d:	68 de 4a 00 00       	push   $0x4ade
    2a92:	e8 44 0f 00 00       	call   39db <mkdir>
    2a97:	83 c4 10             	add    $0x10,%esp
    2a9a:	85 c0                	test   %eax,%eax
    2a9c:	0f 84 46 01 00 00    	je     2be8 <dirfile+0x1e8>
    2aa2:	83 ec 0c             	sub    $0xc,%esp
    2aa5:	68 de 4a 00 00       	push   $0x4ade
    2aaa:	e8 14 0f 00 00       	call   39c3 <unlink>
    2aaf:	83 c4 10             	add    $0x10,%esp
    2ab2:	85 c0                	test   %eax,%eax
    2ab4:	0f 84 1b 01 00 00    	je     2bd5 <dirfile+0x1d5>
    2aba:	83 ec 08             	sub    $0x8,%esp
    2abd:	68 de 4a 00 00       	push   $0x4ade
    2ac2:	68 42 4b 00 00       	push   $0x4b42
    2ac7:	e8 07 0f 00 00       	call   39d3 <link>
    2acc:	83 c4 10             	add    $0x10,%esp
    2acf:	85 c0                	test   %eax,%eax
    2ad1:	0f 84 eb 00 00 00    	je     2bc2 <dirfile+0x1c2>
    2ad7:	83 ec 0c             	sub    $0xc,%esp
    2ada:	68 a5 4a 00 00       	push   $0x4aa5
    2adf:	e8 df 0e 00 00       	call   39c3 <unlink>
    2ae4:	83 c4 10             	add    $0x10,%esp
    2ae7:	85 c0                	test   %eax,%eax
    2ae9:	0f 85 c0 00 00 00    	jne    2baf <dirfile+0x1af>
    2aef:	83 ec 08             	sub    $0x8,%esp
    2af2:	6a 02                	push   $0x2
    2af4:	68 9e 46 00 00       	push   $0x469e
    2af9:	e8 b5 0e 00 00       	call   39b3 <open>
    2afe:	83 c4 10             	add    $0x10,%esp
    2b01:	85 c0                	test   %eax,%eax
    2b03:	0f 89 93 00 00 00    	jns    2b9c <dirfile+0x19c>
    2b09:	83 ec 08             	sub    $0x8,%esp
    2b0c:	6a 00                	push   $0x0
    2b0e:	68 9e 46 00 00       	push   $0x469e
    2b13:	e8 9b 0e 00 00       	call   39b3 <open>
    2b18:	83 c4 0c             	add    $0xc,%esp
    2b1b:	6a 01                	push   $0x1
    2b1d:	89 c3                	mov    %eax,%ebx
    2b1f:	68 81 47 00 00       	push   $0x4781
    2b24:	50                   	push   %eax
    2b25:	e8 69 0e 00 00       	call   3993 <write>
    2b2a:	83 c4 10             	add    $0x10,%esp
    2b2d:	85 c0                	test   %eax,%eax
    2b2f:	7f 58                	jg     2b89 <dirfile+0x189>
    2b31:	83 ec 0c             	sub    $0xc,%esp
    2b34:	53                   	push   %ebx
    2b35:	e8 61 0e 00 00       	call   399b <close>
    2b3a:	58                   	pop    %eax
    2b3b:	5a                   	pop    %edx
    2b3c:	68 75 4b 00 00       	push   $0x4b75
    2b41:	6a 01                	push   $0x1
    2b43:	e8 b8 0f 00 00       	call   3b00 <printf>
    2b48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2b4b:	83 c4 10             	add    $0x10,%esp
    2b4e:	c9                   	leave  
    2b4f:	c3                   	ret    
    2b50:	50                   	push   %eax
    2b51:	50                   	push   %eax
    2b52:	68 e9 4a 00 00       	push   $0x4ae9
    2b57:	6a 01                	push   $0x1
    2b59:	e8 a2 0f 00 00       	call   3b00 <printf>
    2b5e:	e8 10 0e 00 00       	call   3973 <exit>
    2b63:	52                   	push   %edx
    2b64:	52                   	push   %edx
    2b65:	68 c4 4a 00 00       	push   $0x4ac4
    2b6a:	6a 01                	push   $0x1
    2b6c:	e8 8f 0f 00 00       	call   3b00 <printf>
    2b71:	e8 fd 0d 00 00       	call   3973 <exit>
    2b76:	51                   	push   %ecx
    2b77:	51                   	push   %ecx
    2b78:	68 ad 4a 00 00       	push   $0x4aad
    2b7d:	6a 01                	push   $0x1
    2b7f:	e8 7c 0f 00 00       	call   3b00 <printf>
    2b84:	e8 ea 0d 00 00       	call   3973 <exit>
    2b89:	51                   	push   %ecx
    2b8a:	51                   	push   %ecx
    2b8b:	68 61 4b 00 00       	push   $0x4b61
    2b90:	6a 01                	push   $0x1
    2b92:	e8 69 0f 00 00       	call   3b00 <printf>
    2b97:	e8 d7 0d 00 00       	call   3973 <exit>
    2b9c:	53                   	push   %ebx
    2b9d:	53                   	push   %ebx
    2b9e:	68 58 53 00 00       	push   $0x5358
    2ba3:	6a 01                	push   $0x1
    2ba5:	e8 56 0f 00 00       	call   3b00 <printf>
    2baa:	e8 c4 0d 00 00       	call   3973 <exit>
    2baf:	50                   	push   %eax
    2bb0:	50                   	push   %eax
    2bb1:	68 49 4b 00 00       	push   $0x4b49
    2bb6:	6a 01                	push   $0x1
    2bb8:	e8 43 0f 00 00       	call   3b00 <printf>
    2bbd:	e8 b1 0d 00 00       	call   3973 <exit>
    2bc2:	50                   	push   %eax
    2bc3:	50                   	push   %eax
    2bc4:	68 38 53 00 00       	push   $0x5338
    2bc9:	6a 01                	push   $0x1
    2bcb:	e8 30 0f 00 00       	call   3b00 <printf>
    2bd0:	e8 9e 0d 00 00       	call   3973 <exit>
    2bd5:	50                   	push   %eax
    2bd6:	50                   	push   %eax
    2bd7:	68 24 4b 00 00       	push   $0x4b24
    2bdc:	6a 01                	push   $0x1
    2bde:	e8 1d 0f 00 00       	call   3b00 <printf>
    2be3:	e8 8b 0d 00 00       	call   3973 <exit>
    2be8:	50                   	push   %eax
    2be9:	50                   	push   %eax
    2bea:	68 07 4b 00 00       	push   $0x4b07
    2bef:	6a 01                	push   $0x1
    2bf1:	e8 0a 0f 00 00       	call   3b00 <printf>
    2bf6:	e8 78 0d 00 00       	call   3973 <exit>
    2bfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2bff:	90                   	nop

00002c00 <iref>:
    2c00:	f3 0f 1e fb          	endbr32 
    2c04:	55                   	push   %ebp
    2c05:	89 e5                	mov    %esp,%ebp
    2c07:	53                   	push   %ebx
    2c08:	bb 33 00 00 00       	mov    $0x33,%ebx
    2c0d:	83 ec 0c             	sub    $0xc,%esp
    2c10:	68 85 4b 00 00       	push   $0x4b85
    2c15:	6a 01                	push   $0x1
    2c17:	e8 e4 0e 00 00       	call   3b00 <printf>
    2c1c:	83 c4 10             	add    $0x10,%esp
    2c1f:	90                   	nop
    2c20:	83 ec 0c             	sub    $0xc,%esp
    2c23:	68 96 4b 00 00       	push   $0x4b96
    2c28:	e8 ae 0d 00 00       	call   39db <mkdir>
    2c2d:	83 c4 10             	add    $0x10,%esp
    2c30:	85 c0                	test   %eax,%eax
    2c32:	0f 85 bb 00 00 00    	jne    2cf3 <iref+0xf3>
    2c38:	83 ec 0c             	sub    $0xc,%esp
    2c3b:	68 96 4b 00 00       	push   $0x4b96
    2c40:	e8 9e 0d 00 00       	call   39e3 <chdir>
    2c45:	83 c4 10             	add    $0x10,%esp
    2c48:	85 c0                	test   %eax,%eax
    2c4a:	0f 85 b7 00 00 00    	jne    2d07 <iref+0x107>
    2c50:	83 ec 0c             	sub    $0xc,%esp
    2c53:	68 4b 42 00 00       	push   $0x424b
    2c58:	e8 7e 0d 00 00       	call   39db <mkdir>
    2c5d:	59                   	pop    %ecx
    2c5e:	58                   	pop    %eax
    2c5f:	68 4b 42 00 00       	push   $0x424b
    2c64:	68 42 4b 00 00       	push   $0x4b42
    2c69:	e8 65 0d 00 00       	call   39d3 <link>
    2c6e:	58                   	pop    %eax
    2c6f:	5a                   	pop    %edx
    2c70:	68 00 02 00 00       	push   $0x200
    2c75:	68 4b 42 00 00       	push   $0x424b
    2c7a:	e8 34 0d 00 00       	call   39b3 <open>
    2c7f:	83 c4 10             	add    $0x10,%esp
    2c82:	85 c0                	test   %eax,%eax
    2c84:	78 0c                	js     2c92 <iref+0x92>
    2c86:	83 ec 0c             	sub    $0xc,%esp
    2c89:	50                   	push   %eax
    2c8a:	e8 0c 0d 00 00       	call   399b <close>
    2c8f:	83 c4 10             	add    $0x10,%esp
    2c92:	83 ec 08             	sub    $0x8,%esp
    2c95:	68 00 02 00 00       	push   $0x200
    2c9a:	68 80 47 00 00       	push   $0x4780
    2c9f:	e8 0f 0d 00 00       	call   39b3 <open>
    2ca4:	83 c4 10             	add    $0x10,%esp
    2ca7:	85 c0                	test   %eax,%eax
    2ca9:	78 0c                	js     2cb7 <iref+0xb7>
    2cab:	83 ec 0c             	sub    $0xc,%esp
    2cae:	50                   	push   %eax
    2caf:	e8 e7 0c 00 00       	call   399b <close>
    2cb4:	83 c4 10             	add    $0x10,%esp
    2cb7:	83 ec 0c             	sub    $0xc,%esp
    2cba:	68 80 47 00 00       	push   $0x4780
    2cbf:	e8 ff 0c 00 00       	call   39c3 <unlink>
    2cc4:	83 c4 10             	add    $0x10,%esp
    2cc7:	83 eb 01             	sub    $0x1,%ebx
    2cca:	0f 85 50 ff ff ff    	jne    2c20 <iref+0x20>
    2cd0:	83 ec 0c             	sub    $0xc,%esp
    2cd3:	68 71 3e 00 00       	push   $0x3e71
    2cd8:	e8 06 0d 00 00       	call   39e3 <chdir>
    2cdd:	58                   	pop    %eax
    2cde:	5a                   	pop    %edx
    2cdf:	68 c4 4b 00 00       	push   $0x4bc4
    2ce4:	6a 01                	push   $0x1
    2ce6:	e8 15 0e 00 00       	call   3b00 <printf>
    2ceb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2cee:	83 c4 10             	add    $0x10,%esp
    2cf1:	c9                   	leave  
    2cf2:	c3                   	ret    
    2cf3:	83 ec 08             	sub    $0x8,%esp
    2cf6:	68 9c 4b 00 00       	push   $0x4b9c
    2cfb:	6a 01                	push   $0x1
    2cfd:	e8 fe 0d 00 00       	call   3b00 <printf>
    2d02:	e8 6c 0c 00 00       	call   3973 <exit>
    2d07:	83 ec 08             	sub    $0x8,%esp
    2d0a:	68 b0 4b 00 00       	push   $0x4bb0
    2d0f:	6a 01                	push   $0x1
    2d11:	e8 ea 0d 00 00       	call   3b00 <printf>
    2d16:	e8 58 0c 00 00       	call   3973 <exit>
    2d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2d1f:	90                   	nop

00002d20 <forktest>:
    2d20:	f3 0f 1e fb          	endbr32 
    2d24:	55                   	push   %ebp
    2d25:	89 e5                	mov    %esp,%ebp
    2d27:	53                   	push   %ebx
    2d28:	31 db                	xor    %ebx,%ebx
    2d2a:	83 ec 0c             	sub    $0xc,%esp
    2d2d:	68 d8 4b 00 00       	push   $0x4bd8
    2d32:	6a 01                	push   $0x1
    2d34:	e8 c7 0d 00 00       	call   3b00 <printf>
    2d39:	83 c4 10             	add    $0x10,%esp
    2d3c:	eb 0f                	jmp    2d4d <forktest+0x2d>
    2d3e:	66 90                	xchg   %ax,%ax
    2d40:	74 4a                	je     2d8c <forktest+0x6c>
    2d42:	83 c3 01             	add    $0x1,%ebx
    2d45:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2d4b:	74 6b                	je     2db8 <forktest+0x98>
    2d4d:	e8 19 0c 00 00       	call   396b <fork>
    2d52:	85 c0                	test   %eax,%eax
    2d54:	79 ea                	jns    2d40 <forktest+0x20>
    2d56:	85 db                	test   %ebx,%ebx
    2d58:	74 14                	je     2d6e <forktest+0x4e>
    2d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    2d60:	e8 16 0c 00 00       	call   397b <wait>
    2d65:	85 c0                	test   %eax,%eax
    2d67:	78 28                	js     2d91 <forktest+0x71>
    2d69:	83 eb 01             	sub    $0x1,%ebx
    2d6c:	75 f2                	jne    2d60 <forktest+0x40>
    2d6e:	e8 08 0c 00 00       	call   397b <wait>
    2d73:	83 f8 ff             	cmp    $0xffffffff,%eax
    2d76:	75 2d                	jne    2da5 <forktest+0x85>
    2d78:	83 ec 08             	sub    $0x8,%esp
    2d7b:	68 0a 4c 00 00       	push   $0x4c0a
    2d80:	6a 01                	push   $0x1
    2d82:	e8 79 0d 00 00       	call   3b00 <printf>
    2d87:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    2d8a:	c9                   	leave  
    2d8b:	c3                   	ret    
    2d8c:	e8 e2 0b 00 00       	call   3973 <exit>
    2d91:	83 ec 08             	sub    $0x8,%esp
    2d94:	68 e3 4b 00 00       	push   $0x4be3
    2d99:	6a 01                	push   $0x1
    2d9b:	e8 60 0d 00 00       	call   3b00 <printf>
    2da0:	e8 ce 0b 00 00       	call   3973 <exit>
    2da5:	52                   	push   %edx
    2da6:	52                   	push   %edx
    2da7:	68 f7 4b 00 00       	push   $0x4bf7
    2dac:	6a 01                	push   $0x1
    2dae:	e8 4d 0d 00 00       	call   3b00 <printf>
    2db3:	e8 bb 0b 00 00       	call   3973 <exit>
    2db8:	50                   	push   %eax
    2db9:	50                   	push   %eax
    2dba:	68 78 53 00 00       	push   $0x5378
    2dbf:	6a 01                	push   $0x1
    2dc1:	e8 3a 0d 00 00       	call   3b00 <printf>
    2dc6:	e8 a8 0b 00 00       	call   3973 <exit>
    2dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    2dcf:	90                   	nop

00002dd0 <sbrktest>:
    2dd0:	f3 0f 1e fb          	endbr32 
    2dd4:	55                   	push   %ebp
    2dd5:	89 e5                	mov    %esp,%ebp
    2dd7:	57                   	push   %edi
    2dd8:	31 ff                	xor    %edi,%edi
    2dda:	56                   	push   %esi
    2ddb:	53                   	push   %ebx
    2ddc:	83 ec 54             	sub    $0x54,%esp
    2ddf:	68 18 4c 00 00       	push   $0x4c18
    2de4:	ff 35 18 5f 00 00    	pushl  0x5f18
    2dea:	e8 11 0d 00 00       	call   3b00 <printf>
    2def:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2df6:	e8 00 0c 00 00       	call   39fb <sbrk>
    2dfb:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2e02:	89 c3                	mov    %eax,%ebx
    2e04:	e8 f2 0b 00 00       	call   39fb <sbrk>
    2e09:	83 c4 10             	add    $0x10,%esp
    2e0c:	89 c6                	mov    %eax,%esi
    2e0e:	eb 02                	jmp    2e12 <sbrktest+0x42>
    2e10:	89 c6                	mov    %eax,%esi
    2e12:	83 ec 0c             	sub    $0xc,%esp
    2e15:	6a 01                	push   $0x1
    2e17:	e8 df 0b 00 00       	call   39fb <sbrk>
    2e1c:	83 c4 10             	add    $0x10,%esp
    2e1f:	39 f0                	cmp    %esi,%eax
    2e21:	0f 85 84 02 00 00    	jne    30ab <sbrktest+0x2db>
    2e27:	83 c7 01             	add    $0x1,%edi
    2e2a:	c6 06 01             	movb   $0x1,(%esi)
    2e2d:	8d 46 01             	lea    0x1(%esi),%eax
    2e30:	81 ff 88 13 00 00    	cmp    $0x1388,%edi
    2e36:	75 d8                	jne    2e10 <sbrktest+0x40>
    2e38:	e8 2e 0b 00 00       	call   396b <fork>
    2e3d:	89 c7                	mov    %eax,%edi
    2e3f:	85 c0                	test   %eax,%eax
    2e41:	0f 88 91 03 00 00    	js     31d8 <sbrktest+0x408>
    2e47:	83 ec 0c             	sub    $0xc,%esp
    2e4a:	83 c6 02             	add    $0x2,%esi
    2e4d:	6a 01                	push   $0x1
    2e4f:	e8 a7 0b 00 00       	call   39fb <sbrk>
    2e54:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e5b:	e8 9b 0b 00 00       	call   39fb <sbrk>
    2e60:	83 c4 10             	add    $0x10,%esp
    2e63:	39 c6                	cmp    %eax,%esi
    2e65:	0f 85 56 03 00 00    	jne    31c1 <sbrktest+0x3f1>
    2e6b:	85 ff                	test   %edi,%edi
    2e6d:	0f 84 49 03 00 00    	je     31bc <sbrktest+0x3ec>
    2e73:	e8 03 0b 00 00       	call   397b <wait>
    2e78:	83 ec 0c             	sub    $0xc,%esp
    2e7b:	6a 00                	push   $0x0
    2e7d:	e8 79 0b 00 00       	call   39fb <sbrk>
    2e82:	89 c6                	mov    %eax,%esi
    2e84:	b8 00 00 40 06       	mov    $0x6400000,%eax
    2e89:	29 f0                	sub    %esi,%eax
    2e8b:	89 04 24             	mov    %eax,(%esp)
    2e8e:	e8 68 0b 00 00       	call   39fb <sbrk>
    2e93:	83 c4 10             	add    $0x10,%esp
    2e96:	39 c6                	cmp    %eax,%esi
    2e98:	0f 85 07 03 00 00    	jne    31a5 <sbrktest+0x3d5>
    2e9e:	83 ec 0c             	sub    $0xc,%esp
    2ea1:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff
    2ea8:	6a 00                	push   $0x0
    2eaa:	e8 4c 0b 00 00       	call   39fb <sbrk>
    2eaf:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2eb6:	89 c6                	mov    %eax,%esi
    2eb8:	e8 3e 0b 00 00       	call   39fb <sbrk>
    2ebd:	83 c4 10             	add    $0x10,%esp
    2ec0:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ec3:	0f 84 c5 02 00 00    	je     318e <sbrktest+0x3be>
    2ec9:	83 ec 0c             	sub    $0xc,%esp
    2ecc:	6a 00                	push   $0x0
    2ece:	e8 28 0b 00 00       	call   39fb <sbrk>
    2ed3:	8d 96 00 f0 ff ff    	lea    -0x1000(%esi),%edx
    2ed9:	83 c4 10             	add    $0x10,%esp
    2edc:	39 d0                	cmp    %edx,%eax
    2ede:	0f 85 93 02 00 00    	jne    3177 <sbrktest+0x3a7>
    2ee4:	83 ec 0c             	sub    $0xc,%esp
    2ee7:	6a 00                	push   $0x0
    2ee9:	e8 0d 0b 00 00       	call   39fb <sbrk>
    2eee:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2ef5:	89 c6                	mov    %eax,%esi
    2ef7:	e8 ff 0a 00 00       	call   39fb <sbrk>
    2efc:	83 c4 10             	add    $0x10,%esp
    2eff:	89 c7                	mov    %eax,%edi
    2f01:	39 c6                	cmp    %eax,%esi
    2f03:	0f 85 57 02 00 00    	jne    3160 <sbrktest+0x390>
    2f09:	83 ec 0c             	sub    $0xc,%esp
    2f0c:	6a 00                	push   $0x0
    2f0e:	e8 e8 0a 00 00       	call   39fb <sbrk>
    2f13:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    2f19:	83 c4 10             	add    $0x10,%esp
    2f1c:	39 c2                	cmp    %eax,%edx
    2f1e:	0f 85 3c 02 00 00    	jne    3160 <sbrktest+0x390>
    2f24:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    2f2b:	0f 84 18 02 00 00    	je     3149 <sbrktest+0x379>
    2f31:	83 ec 0c             	sub    $0xc,%esp
    2f34:	6a 00                	push   $0x0
    2f36:	e8 c0 0a 00 00       	call   39fb <sbrk>
    2f3b:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f42:	89 c6                	mov    %eax,%esi
    2f44:	e8 b2 0a 00 00       	call   39fb <sbrk>
    2f49:	89 d9                	mov    %ebx,%ecx
    2f4b:	29 c1                	sub    %eax,%ecx
    2f4d:	89 0c 24             	mov    %ecx,(%esp)
    2f50:	e8 a6 0a 00 00       	call   39fb <sbrk>
    2f55:	83 c4 10             	add    $0x10,%esp
    2f58:	39 c6                	cmp    %eax,%esi
    2f5a:	0f 85 d2 01 00 00    	jne    3132 <sbrktest+0x362>
    2f60:	be 00 00 00 80       	mov    $0x80000000,%esi
    2f65:	8d 76 00             	lea    0x0(%esi),%esi
    2f68:	e8 86 0a 00 00       	call   39f3 <getpid>
    2f6d:	89 c7                	mov    %eax,%edi
    2f6f:	e8 f7 09 00 00       	call   396b <fork>
    2f74:	85 c0                	test   %eax,%eax
    2f76:	0f 88 9e 01 00 00    	js     311a <sbrktest+0x34a>
    2f7c:	0f 84 76 01 00 00    	je     30f8 <sbrktest+0x328>
    2f82:	e8 f4 09 00 00       	call   397b <wait>
    2f87:	81 c6 50 c3 00 00    	add    $0xc350,%esi
    2f8d:	81 fe 80 84 1e 80    	cmp    $0x801e8480,%esi
    2f93:	75 d3                	jne    2f68 <sbrktest+0x198>
    2f95:	83 ec 0c             	sub    $0xc,%esp
    2f98:	8d 45 b8             	lea    -0x48(%ebp),%eax
    2f9b:	50                   	push   %eax
    2f9c:	e8 e2 09 00 00       	call   3983 <pipe>
    2fa1:	83 c4 10             	add    $0x10,%esp
    2fa4:	85 c0                	test   %eax,%eax
    2fa6:	0f 85 34 01 00 00    	jne    30e0 <sbrktest+0x310>
    2fac:	8d 75 c0             	lea    -0x40(%ebp),%esi
    2faf:	89 f7                	mov    %esi,%edi
    2fb1:	e8 b5 09 00 00       	call   396b <fork>
    2fb6:	89 07                	mov    %eax,(%edi)
    2fb8:	85 c0                	test   %eax,%eax
    2fba:	0f 84 8f 00 00 00    	je     304f <sbrktest+0x27f>
    2fc0:	83 f8 ff             	cmp    $0xffffffff,%eax
    2fc3:	74 14                	je     2fd9 <sbrktest+0x209>
    2fc5:	83 ec 04             	sub    $0x4,%esp
    2fc8:	8d 45 b7             	lea    -0x49(%ebp),%eax
    2fcb:	6a 01                	push   $0x1
    2fcd:	50                   	push   %eax
    2fce:	ff 75 b8             	pushl  -0x48(%ebp)
    2fd1:	e8 b5 09 00 00       	call   398b <read>
    2fd6:	83 c4 10             	add    $0x10,%esp
    2fd9:	83 c7 04             	add    $0x4,%edi
    2fdc:	8d 45 e8             	lea    -0x18(%ebp),%eax
    2fdf:	39 c7                	cmp    %eax,%edi
    2fe1:	75 ce                	jne    2fb1 <sbrktest+0x1e1>
    2fe3:	83 ec 0c             	sub    $0xc,%esp
    2fe6:	68 00 10 00 00       	push   $0x1000
    2feb:	e8 0b 0a 00 00       	call   39fb <sbrk>
    2ff0:	83 c4 10             	add    $0x10,%esp
    2ff3:	89 c7                	mov    %eax,%edi
    2ff5:	8b 06                	mov    (%esi),%eax
    2ff7:	83 f8 ff             	cmp    $0xffffffff,%eax
    2ffa:	74 11                	je     300d <sbrktest+0x23d>
    2ffc:	83 ec 0c             	sub    $0xc,%esp
    2fff:	50                   	push   %eax
    3000:	e8 9e 09 00 00       	call   39a3 <kill>
    3005:	e8 71 09 00 00       	call   397b <wait>
    300a:	83 c4 10             	add    $0x10,%esp
    300d:	83 c6 04             	add    $0x4,%esi
    3010:	8d 45 e8             	lea    -0x18(%ebp),%eax
    3013:	39 f0                	cmp    %esi,%eax
    3015:	75 de                	jne    2ff5 <sbrktest+0x225>
    3017:	83 ff ff             	cmp    $0xffffffff,%edi
    301a:	0f 84 a9 00 00 00    	je     30c9 <sbrktest+0x2f9>
    3020:	83 ec 0c             	sub    $0xc,%esp
    3023:	6a 00                	push   $0x0
    3025:	e8 d1 09 00 00       	call   39fb <sbrk>
    302a:	83 c4 10             	add    $0x10,%esp
    302d:	39 c3                	cmp    %eax,%ebx
    302f:	72 61                	jb     3092 <sbrktest+0x2c2>
    3031:	83 ec 08             	sub    $0x8,%esp
    3034:	68 c0 4c 00 00       	push   $0x4cc0
    3039:	ff 35 18 5f 00 00    	pushl  0x5f18
    303f:	e8 bc 0a 00 00       	call   3b00 <printf>
    3044:	83 c4 10             	add    $0x10,%esp
    3047:	8d 65 f4             	lea    -0xc(%ebp),%esp
    304a:	5b                   	pop    %ebx
    304b:	5e                   	pop    %esi
    304c:	5f                   	pop    %edi
    304d:	5d                   	pop    %ebp
    304e:	c3                   	ret    
    304f:	83 ec 0c             	sub    $0xc,%esp
    3052:	6a 00                	push   $0x0
    3054:	e8 a2 09 00 00       	call   39fb <sbrk>
    3059:	89 c2                	mov    %eax,%edx
    305b:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3060:	29 d0                	sub    %edx,%eax
    3062:	89 04 24             	mov    %eax,(%esp)
    3065:	e8 91 09 00 00       	call   39fb <sbrk>
    306a:	83 c4 0c             	add    $0xc,%esp
    306d:	6a 01                	push   $0x1
    306f:	68 81 47 00 00       	push   $0x4781
    3074:	ff 75 bc             	pushl  -0x44(%ebp)
    3077:	e8 17 09 00 00       	call   3993 <write>
    307c:	83 c4 10             	add    $0x10,%esp
    307f:	90                   	nop
    3080:	83 ec 0c             	sub    $0xc,%esp
    3083:	68 e8 03 00 00       	push   $0x3e8
    3088:	e8 76 09 00 00       	call   3a03 <sleep>
    308d:	83 c4 10             	add    $0x10,%esp
    3090:	eb ee                	jmp    3080 <sbrktest+0x2b0>
    3092:	83 ec 0c             	sub    $0xc,%esp
    3095:	6a 00                	push   $0x0
    3097:	e8 5f 09 00 00       	call   39fb <sbrk>
    309c:	29 c3                	sub    %eax,%ebx
    309e:	89 1c 24             	mov    %ebx,(%esp)
    30a1:	e8 55 09 00 00       	call   39fb <sbrk>
    30a6:	83 c4 10             	add    $0x10,%esp
    30a9:	eb 86                	jmp    3031 <sbrktest+0x261>
    30ab:	83 ec 0c             	sub    $0xc,%esp
    30ae:	50                   	push   %eax
    30af:	56                   	push   %esi
    30b0:	57                   	push   %edi
    30b1:	68 23 4c 00 00       	push   $0x4c23
    30b6:	ff 35 18 5f 00 00    	pushl  0x5f18
    30bc:	e8 3f 0a 00 00       	call   3b00 <printf>
    30c1:	83 c4 20             	add    $0x20,%esp
    30c4:	e8 aa 08 00 00       	call   3973 <exit>
    30c9:	50                   	push   %eax
    30ca:	50                   	push   %eax
    30cb:	68 a5 4c 00 00       	push   $0x4ca5
    30d0:	ff 35 18 5f 00 00    	pushl  0x5f18
    30d6:	e8 25 0a 00 00       	call   3b00 <printf>
    30db:	e8 93 08 00 00       	call   3973 <exit>
    30e0:	52                   	push   %edx
    30e1:	52                   	push   %edx
    30e2:	68 61 41 00 00       	push   $0x4161
    30e7:	6a 01                	push   $0x1
    30e9:	e8 12 0a 00 00       	call   3b00 <printf>
    30ee:	e8 80 08 00 00       	call   3973 <exit>
    30f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    30f7:	90                   	nop
    30f8:	0f be 06             	movsbl (%esi),%eax
    30fb:	50                   	push   %eax
    30fc:	56                   	push   %esi
    30fd:	68 8c 4c 00 00       	push   $0x4c8c
    3102:	ff 35 18 5f 00 00    	pushl  0x5f18
    3108:	e8 f3 09 00 00       	call   3b00 <printf>
    310d:	89 3c 24             	mov    %edi,(%esp)
    3110:	e8 8e 08 00 00       	call   39a3 <kill>
    3115:	e8 59 08 00 00       	call   3973 <exit>
    311a:	83 ec 08             	sub    $0x8,%esp
    311d:	68 69 4d 00 00       	push   $0x4d69
    3122:	ff 35 18 5f 00 00    	pushl  0x5f18
    3128:	e8 d3 09 00 00       	call   3b00 <printf>
    312d:	e8 41 08 00 00       	call   3973 <exit>
    3132:	50                   	push   %eax
    3133:	56                   	push   %esi
    3134:	68 6c 54 00 00       	push   $0x546c
    3139:	ff 35 18 5f 00 00    	pushl  0x5f18
    313f:	e8 bc 09 00 00       	call   3b00 <printf>
    3144:	e8 2a 08 00 00       	call   3973 <exit>
    3149:	51                   	push   %ecx
    314a:	51                   	push   %ecx
    314b:	68 3c 54 00 00       	push   $0x543c
    3150:	ff 35 18 5f 00 00    	pushl  0x5f18
    3156:	e8 a5 09 00 00       	call   3b00 <printf>
    315b:	e8 13 08 00 00       	call   3973 <exit>
    3160:	57                   	push   %edi
    3161:	56                   	push   %esi
    3162:	68 14 54 00 00       	push   $0x5414
    3167:	ff 35 18 5f 00 00    	pushl  0x5f18
    316d:	e8 8e 09 00 00       	call   3b00 <printf>
    3172:	e8 fc 07 00 00       	call   3973 <exit>
    3177:	50                   	push   %eax
    3178:	56                   	push   %esi
    3179:	68 dc 53 00 00       	push   $0x53dc
    317e:	ff 35 18 5f 00 00    	pushl  0x5f18
    3184:	e8 77 09 00 00       	call   3b00 <printf>
    3189:	e8 e5 07 00 00       	call   3973 <exit>
    318e:	53                   	push   %ebx
    318f:	53                   	push   %ebx
    3190:	68 71 4c 00 00       	push   $0x4c71
    3195:	ff 35 18 5f 00 00    	pushl  0x5f18
    319b:	e8 60 09 00 00       	call   3b00 <printf>
    31a0:	e8 ce 07 00 00       	call   3973 <exit>
    31a5:	56                   	push   %esi
    31a6:	56                   	push   %esi
    31a7:	68 9c 53 00 00       	push   $0x539c
    31ac:	ff 35 18 5f 00 00    	pushl  0x5f18
    31b2:	e8 49 09 00 00       	call   3b00 <printf>
    31b7:	e8 b7 07 00 00       	call   3973 <exit>
    31bc:	e8 b2 07 00 00       	call   3973 <exit>
    31c1:	57                   	push   %edi
    31c2:	57                   	push   %edi
    31c3:	68 55 4c 00 00       	push   $0x4c55
    31c8:	ff 35 18 5f 00 00    	pushl  0x5f18
    31ce:	e8 2d 09 00 00       	call   3b00 <printf>
    31d3:	e8 9b 07 00 00       	call   3973 <exit>
    31d8:	50                   	push   %eax
    31d9:	50                   	push   %eax
    31da:	68 3e 4c 00 00       	push   $0x4c3e
    31df:	ff 35 18 5f 00 00    	pushl  0x5f18
    31e5:	e8 16 09 00 00       	call   3b00 <printf>
    31ea:	e8 84 07 00 00       	call   3973 <exit>
    31ef:	90                   	nop

000031f0 <validateint>:
    31f0:	f3 0f 1e fb          	endbr32 
    31f4:	c3                   	ret    
    31f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    31fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003200 <validatetest>:
    3200:	f3 0f 1e fb          	endbr32 
    3204:	55                   	push   %ebp
    3205:	89 e5                	mov    %esp,%ebp
    3207:	56                   	push   %esi
    3208:	31 f6                	xor    %esi,%esi
    320a:	53                   	push   %ebx
    320b:	83 ec 08             	sub    $0x8,%esp
    320e:	68 ce 4c 00 00       	push   $0x4cce
    3213:	ff 35 18 5f 00 00    	pushl  0x5f18
    3219:	e8 e2 08 00 00       	call   3b00 <printf>
    321e:	83 c4 10             	add    $0x10,%esp
    3221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3228:	e8 3e 07 00 00       	call   396b <fork>
    322d:	89 c3                	mov    %eax,%ebx
    322f:	85 c0                	test   %eax,%eax
    3231:	74 63                	je     3296 <validatetest+0x96>
    3233:	83 ec 0c             	sub    $0xc,%esp
    3236:	6a 00                	push   $0x0
    3238:	e8 c6 07 00 00       	call   3a03 <sleep>
    323d:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3244:	e8 ba 07 00 00       	call   3a03 <sleep>
    3249:	89 1c 24             	mov    %ebx,(%esp)
    324c:	e8 52 07 00 00       	call   39a3 <kill>
    3251:	e8 25 07 00 00       	call   397b <wait>
    3256:	58                   	pop    %eax
    3257:	5a                   	pop    %edx
    3258:	56                   	push   %esi
    3259:	68 dd 4c 00 00       	push   $0x4cdd
    325e:	e8 70 07 00 00       	call   39d3 <link>
    3263:	83 c4 10             	add    $0x10,%esp
    3266:	83 f8 ff             	cmp    $0xffffffff,%eax
    3269:	75 30                	jne    329b <validatetest+0x9b>
    326b:	81 c6 00 10 00 00    	add    $0x1000,%esi
    3271:	81 fe 00 40 11 00    	cmp    $0x114000,%esi
    3277:	75 af                	jne    3228 <validatetest+0x28>
    3279:	83 ec 08             	sub    $0x8,%esp
    327c:	68 01 4d 00 00       	push   $0x4d01
    3281:	ff 35 18 5f 00 00    	pushl  0x5f18
    3287:	e8 74 08 00 00       	call   3b00 <printf>
    328c:	83 c4 10             	add    $0x10,%esp
    328f:	8d 65 f8             	lea    -0x8(%ebp),%esp
    3292:	5b                   	pop    %ebx
    3293:	5e                   	pop    %esi
    3294:	5d                   	pop    %ebp
    3295:	c3                   	ret    
    3296:	e8 d8 06 00 00       	call   3973 <exit>
    329b:	83 ec 08             	sub    $0x8,%esp
    329e:	68 e8 4c 00 00       	push   $0x4ce8
    32a3:	ff 35 18 5f 00 00    	pushl  0x5f18
    32a9:	e8 52 08 00 00       	call   3b00 <printf>
    32ae:	e8 c0 06 00 00       	call   3973 <exit>
    32b3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    32ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000032c0 <bsstest>:
    32c0:	f3 0f 1e fb          	endbr32 
    32c4:	55                   	push   %ebp
    32c5:	89 e5                	mov    %esp,%ebp
    32c7:	83 ec 10             	sub    $0x10,%esp
    32ca:	68 0e 4d 00 00       	push   $0x4d0e
    32cf:	ff 35 18 5f 00 00    	pushl  0x5f18
    32d5:	e8 26 08 00 00       	call   3b00 <printf>
    32da:	83 c4 10             	add    $0x10,%esp
    32dd:	31 c0                	xor    %eax,%eax
    32df:	90                   	nop
    32e0:	80 b8 e0 5f 00 00 00 	cmpb   $0x0,0x5fe0(%eax)
    32e7:	75 22                	jne    330b <bsstest+0x4b>
    32e9:	83 c0 01             	add    $0x1,%eax
    32ec:	3d 10 27 00 00       	cmp    $0x2710,%eax
    32f1:	75 ed                	jne    32e0 <bsstest+0x20>
    32f3:	83 ec 08             	sub    $0x8,%esp
    32f6:	68 29 4d 00 00       	push   $0x4d29
    32fb:	ff 35 18 5f 00 00    	pushl  0x5f18
    3301:	e8 fa 07 00 00       	call   3b00 <printf>
    3306:	83 c4 10             	add    $0x10,%esp
    3309:	c9                   	leave  
    330a:	c3                   	ret    
    330b:	83 ec 08             	sub    $0x8,%esp
    330e:	68 18 4d 00 00       	push   $0x4d18
    3313:	ff 35 18 5f 00 00    	pushl  0x5f18
    3319:	e8 e2 07 00 00       	call   3b00 <printf>
    331e:	e8 50 06 00 00       	call   3973 <exit>
    3323:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    332a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003330 <bigargtest>:
    3330:	f3 0f 1e fb          	endbr32 
    3334:	55                   	push   %ebp
    3335:	89 e5                	mov    %esp,%ebp
    3337:	83 ec 14             	sub    $0x14,%esp
    333a:	68 36 4d 00 00       	push   $0x4d36
    333f:	e8 7f 06 00 00       	call   39c3 <unlink>
    3344:	e8 22 06 00 00       	call   396b <fork>
    3349:	83 c4 10             	add    $0x10,%esp
    334c:	85 c0                	test   %eax,%eax
    334e:	74 40                	je     3390 <bigargtest+0x60>
    3350:	0f 88 c1 00 00 00    	js     3417 <bigargtest+0xe7>
    3356:	e8 20 06 00 00       	call   397b <wait>
    335b:	83 ec 08             	sub    $0x8,%esp
    335e:	6a 00                	push   $0x0
    3360:	68 36 4d 00 00       	push   $0x4d36
    3365:	e8 49 06 00 00       	call   39b3 <open>
    336a:	83 c4 10             	add    $0x10,%esp
    336d:	85 c0                	test   %eax,%eax
    336f:	0f 88 8b 00 00 00    	js     3400 <bigargtest+0xd0>
    3375:	83 ec 0c             	sub    $0xc,%esp
    3378:	50                   	push   %eax
    3379:	e8 1d 06 00 00       	call   399b <close>
    337e:	c7 04 24 36 4d 00 00 	movl   $0x4d36,(%esp)
    3385:	e8 39 06 00 00       	call   39c3 <unlink>
    338a:	83 c4 10             	add    $0x10,%esp
    338d:	c9                   	leave  
    338e:	c3                   	ret    
    338f:	90                   	nop
    3390:	c7 04 85 40 5f 00 00 	movl   $0x5490,0x5f40(,%eax,4)
    3397:	90 54 00 00 
    339b:	83 c0 01             	add    $0x1,%eax
    339e:	83 f8 1f             	cmp    $0x1f,%eax
    33a1:	75 ed                	jne    3390 <bigargtest+0x60>
    33a3:	51                   	push   %ecx
    33a4:	51                   	push   %ecx
    33a5:	68 40 4d 00 00       	push   $0x4d40
    33aa:	ff 35 18 5f 00 00    	pushl  0x5f18
    33b0:	c7 05 bc 5f 00 00 00 	movl   $0x0,0x5fbc
    33b7:	00 00 00 
    33ba:	e8 41 07 00 00       	call   3b00 <printf>
    33bf:	58                   	pop    %eax
    33c0:	5a                   	pop    %edx
    33c1:	68 40 5f 00 00       	push   $0x5f40
    33c6:	68 0d 3f 00 00       	push   $0x3f0d
    33cb:	e8 db 05 00 00       	call   39ab <exec>
    33d0:	59                   	pop    %ecx
    33d1:	58                   	pop    %eax
    33d2:	68 4d 4d 00 00       	push   $0x4d4d
    33d7:	ff 35 18 5f 00 00    	pushl  0x5f18
    33dd:	e8 1e 07 00 00       	call   3b00 <printf>
    33e2:	58                   	pop    %eax
    33e3:	5a                   	pop    %edx
    33e4:	68 00 02 00 00       	push   $0x200
    33e9:	68 36 4d 00 00       	push   $0x4d36
    33ee:	e8 c0 05 00 00       	call   39b3 <open>
    33f3:	89 04 24             	mov    %eax,(%esp)
    33f6:	e8 a0 05 00 00       	call   399b <close>
    33fb:	e8 73 05 00 00       	call   3973 <exit>
    3400:	50                   	push   %eax
    3401:	50                   	push   %eax
    3402:	68 76 4d 00 00       	push   $0x4d76
    3407:	ff 35 18 5f 00 00    	pushl  0x5f18
    340d:	e8 ee 06 00 00       	call   3b00 <printf>
    3412:	e8 5c 05 00 00       	call   3973 <exit>
    3417:	52                   	push   %edx
    3418:	52                   	push   %edx
    3419:	68 5d 4d 00 00       	push   $0x4d5d
    341e:	ff 35 18 5f 00 00    	pushl  0x5f18
    3424:	e8 d7 06 00 00       	call   3b00 <printf>
    3429:	e8 45 05 00 00       	call   3973 <exit>
    342e:	66 90                	xchg   %ax,%ax

00003430 <fsfull>:
    3430:	f3 0f 1e fb          	endbr32 
    3434:	55                   	push   %ebp
    3435:	89 e5                	mov    %esp,%ebp
    3437:	57                   	push   %edi
    3438:	56                   	push   %esi
    3439:	31 f6                	xor    %esi,%esi
    343b:	53                   	push   %ebx
    343c:	83 ec 54             	sub    $0x54,%esp
    343f:	68 8b 4d 00 00       	push   $0x4d8b
    3444:	6a 01                	push   $0x1
    3446:	e8 b5 06 00 00       	call   3b00 <printf>
    344b:	83 c4 10             	add    $0x10,%esp
    344e:	66 90                	xchg   %ax,%ax
    3450:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3455:	b9 cd cc cc cc       	mov    $0xcccccccd,%ecx
    345a:	83 ec 04             	sub    $0x4,%esp
    345d:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    3461:	f7 e6                	mul    %esi
    3463:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    3467:	c1 ea 06             	shr    $0x6,%edx
    346a:	8d 42 30             	lea    0x30(%edx),%eax
    346d:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    3473:	88 45 a9             	mov    %al,-0x57(%ebp)
    3476:	89 f0                	mov    %esi,%eax
    3478:	29 d0                	sub    %edx,%eax
    347a:	89 c2                	mov    %eax,%edx
    347c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3481:	f7 e2                	mul    %edx
    3483:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    3488:	c1 ea 05             	shr    $0x5,%edx
    348b:	83 c2 30             	add    $0x30,%edx
    348e:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3491:	f7 e6                	mul    %esi
    3493:	89 f0                	mov    %esi,%eax
    3495:	c1 ea 05             	shr    $0x5,%edx
    3498:	6b d2 64             	imul   $0x64,%edx,%edx
    349b:	29 d0                	sub    %edx,%eax
    349d:	f7 e1                	mul    %ecx
    349f:	89 f0                	mov    %esi,%eax
    34a1:	c1 ea 03             	shr    $0x3,%edx
    34a4:	83 c2 30             	add    $0x30,%edx
    34a7:	88 55 ab             	mov    %dl,-0x55(%ebp)
    34aa:	f7 e1                	mul    %ecx
    34ac:	89 f1                	mov    %esi,%ecx
    34ae:	c1 ea 03             	shr    $0x3,%edx
    34b1:	8d 04 92             	lea    (%edx,%edx,4),%eax
    34b4:	01 c0                	add    %eax,%eax
    34b6:	29 c1                	sub    %eax,%ecx
    34b8:	89 c8                	mov    %ecx,%eax
    34ba:	83 c0 30             	add    $0x30,%eax
    34bd:	88 45 ac             	mov    %al,-0x54(%ebp)
    34c0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34c3:	50                   	push   %eax
    34c4:	68 98 4d 00 00       	push   $0x4d98
    34c9:	6a 01                	push   $0x1
    34cb:	e8 30 06 00 00       	call   3b00 <printf>
    34d0:	58                   	pop    %eax
    34d1:	8d 45 a8             	lea    -0x58(%ebp),%eax
    34d4:	5a                   	pop    %edx
    34d5:	68 02 02 00 00       	push   $0x202
    34da:	50                   	push   %eax
    34db:	e8 d3 04 00 00       	call   39b3 <open>
    34e0:	83 c4 10             	add    $0x10,%esp
    34e3:	89 c7                	mov    %eax,%edi
    34e5:	85 c0                	test   %eax,%eax
    34e7:	78 4d                	js     3536 <fsfull+0x106>
    34e9:	31 db                	xor    %ebx,%ebx
    34eb:	eb 05                	jmp    34f2 <fsfull+0xc2>
    34ed:	8d 76 00             	lea    0x0(%esi),%esi
    34f0:	01 c3                	add    %eax,%ebx
    34f2:	83 ec 04             	sub    $0x4,%esp
    34f5:	68 00 02 00 00       	push   $0x200
    34fa:	68 00 87 00 00       	push   $0x8700
    34ff:	57                   	push   %edi
    3500:	e8 8e 04 00 00       	call   3993 <write>
    3505:	83 c4 10             	add    $0x10,%esp
    3508:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    350d:	7f e1                	jg     34f0 <fsfull+0xc0>
    350f:	83 ec 04             	sub    $0x4,%esp
    3512:	53                   	push   %ebx
    3513:	68 b4 4d 00 00       	push   $0x4db4
    3518:	6a 01                	push   $0x1
    351a:	e8 e1 05 00 00       	call   3b00 <printf>
    351f:	89 3c 24             	mov    %edi,(%esp)
    3522:	e8 74 04 00 00       	call   399b <close>
    3527:	83 c4 10             	add    $0x10,%esp
    352a:	85 db                	test   %ebx,%ebx
    352c:	74 1e                	je     354c <fsfull+0x11c>
    352e:	83 c6 01             	add    $0x1,%esi
    3531:	e9 1a ff ff ff       	jmp    3450 <fsfull+0x20>
    3536:	83 ec 04             	sub    $0x4,%esp
    3539:	8d 45 a8             	lea    -0x58(%ebp),%eax
    353c:	50                   	push   %eax
    353d:	68 a4 4d 00 00       	push   $0x4da4
    3542:	6a 01                	push   $0x1
    3544:	e8 b7 05 00 00       	call   3b00 <printf>
    3549:	83 c4 10             	add    $0x10,%esp
    354c:	bf d3 4d 62 10       	mov    $0x10624dd3,%edi
    3551:	bb 1f 85 eb 51       	mov    $0x51eb851f,%ebx
    3556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    355d:	8d 76 00             	lea    0x0(%esi),%esi
    3560:	89 f0                	mov    %esi,%eax
    3562:	89 f1                	mov    %esi,%ecx
    3564:	83 ec 0c             	sub    $0xc,%esp
    3567:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    356b:	f7 ef                	imul   %edi
    356d:	c1 f9 1f             	sar    $0x1f,%ecx
    3570:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    3574:	c1 fa 06             	sar    $0x6,%edx
    3577:	29 ca                	sub    %ecx,%edx
    3579:	8d 42 30             	lea    0x30(%edx),%eax
    357c:	69 d2 e8 03 00 00    	imul   $0x3e8,%edx,%edx
    3582:	88 45 a9             	mov    %al,-0x57(%ebp)
    3585:	89 f0                	mov    %esi,%eax
    3587:	29 d0                	sub    %edx,%eax
    3589:	f7 e3                	mul    %ebx
    358b:	89 f0                	mov    %esi,%eax
    358d:	c1 ea 05             	shr    $0x5,%edx
    3590:	83 c2 30             	add    $0x30,%edx
    3593:	88 55 aa             	mov    %dl,-0x56(%ebp)
    3596:	f7 eb                	imul   %ebx
    3598:	89 f0                	mov    %esi,%eax
    359a:	c1 fa 05             	sar    $0x5,%edx
    359d:	29 ca                	sub    %ecx,%edx
    359f:	6b d2 64             	imul   $0x64,%edx,%edx
    35a2:	29 d0                	sub    %edx,%eax
    35a4:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
    35a9:	f7 e2                	mul    %edx
    35ab:	89 f0                	mov    %esi,%eax
    35ad:	c1 ea 03             	shr    $0x3,%edx
    35b0:	83 c2 30             	add    $0x30,%edx
    35b3:	88 55 ab             	mov    %dl,-0x55(%ebp)
    35b6:	ba 67 66 66 66       	mov    $0x66666667,%edx
    35bb:	f7 ea                	imul   %edx
    35bd:	c1 fa 02             	sar    $0x2,%edx
    35c0:	29 ca                	sub    %ecx,%edx
    35c2:	89 f1                	mov    %esi,%ecx
    35c4:	83 ee 01             	sub    $0x1,%esi
    35c7:	8d 04 92             	lea    (%edx,%edx,4),%eax
    35ca:	01 c0                	add    %eax,%eax
    35cc:	29 c1                	sub    %eax,%ecx
    35ce:	89 c8                	mov    %ecx,%eax
    35d0:	83 c0 30             	add    $0x30,%eax
    35d3:	88 45 ac             	mov    %al,-0x54(%ebp)
    35d6:	8d 45 a8             	lea    -0x58(%ebp),%eax
    35d9:	50                   	push   %eax
    35da:	e8 e4 03 00 00       	call   39c3 <unlink>
    35df:	83 c4 10             	add    $0x10,%esp
    35e2:	83 fe ff             	cmp    $0xffffffff,%esi
    35e5:	0f 85 75 ff ff ff    	jne    3560 <fsfull+0x130>
    35eb:	83 ec 08             	sub    $0x8,%esp
    35ee:	68 c4 4d 00 00       	push   $0x4dc4
    35f3:	6a 01                	push   $0x1
    35f5:	e8 06 05 00 00       	call   3b00 <printf>
    35fa:	83 c4 10             	add    $0x10,%esp
    35fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3600:	5b                   	pop    %ebx
    3601:	5e                   	pop    %esi
    3602:	5f                   	pop    %edi
    3603:	5d                   	pop    %ebp
    3604:	c3                   	ret    
    3605:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    360c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003610 <uio>:
    3610:	f3 0f 1e fb          	endbr32 
    3614:	55                   	push   %ebp
    3615:	89 e5                	mov    %esp,%ebp
    3617:	83 ec 10             	sub    $0x10,%esp
    361a:	68 da 4d 00 00       	push   $0x4dda
    361f:	6a 01                	push   $0x1
    3621:	e8 da 04 00 00       	call   3b00 <printf>
    3626:	e8 40 03 00 00       	call   396b <fork>
    362b:	83 c4 10             	add    $0x10,%esp
    362e:	85 c0                	test   %eax,%eax
    3630:	74 1b                	je     364d <uio+0x3d>
    3632:	78 3d                	js     3671 <uio+0x61>
    3634:	e8 42 03 00 00       	call   397b <wait>
    3639:	83 ec 08             	sub    $0x8,%esp
    363c:	68 e4 4d 00 00       	push   $0x4de4
    3641:	6a 01                	push   $0x1
    3643:	e8 b8 04 00 00       	call   3b00 <printf>
    3648:	83 c4 10             	add    $0x10,%esp
    364b:	c9                   	leave  
    364c:	c3                   	ret    
    364d:	b8 09 00 00 00       	mov    $0x9,%eax
    3652:	ba 70 00 00 00       	mov    $0x70,%edx
    3657:	ee                   	out    %al,(%dx)
    3658:	ba 71 00 00 00       	mov    $0x71,%edx
    365d:	ec                   	in     (%dx),%al
    365e:	52                   	push   %edx
    365f:	52                   	push   %edx
    3660:	68 70 55 00 00       	push   $0x5570
    3665:	6a 01                	push   $0x1
    3667:	e8 94 04 00 00       	call   3b00 <printf>
    366c:	e8 02 03 00 00       	call   3973 <exit>
    3671:	50                   	push   %eax
    3672:	50                   	push   %eax
    3673:	68 69 4d 00 00       	push   $0x4d69
    3678:	6a 01                	push   $0x1
    367a:	e8 81 04 00 00       	call   3b00 <printf>
    367f:	e8 ef 02 00 00       	call   3973 <exit>
    3684:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    368b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    368f:	90                   	nop

00003690 <argptest>:
    3690:	f3 0f 1e fb          	endbr32 
    3694:	55                   	push   %ebp
    3695:	89 e5                	mov    %esp,%ebp
    3697:	53                   	push   %ebx
    3698:	83 ec 0c             	sub    $0xc,%esp
    369b:	6a 00                	push   $0x0
    369d:	68 f3 4d 00 00       	push   $0x4df3
    36a2:	e8 0c 03 00 00       	call   39b3 <open>
    36a7:	83 c4 10             	add    $0x10,%esp
    36aa:	85 c0                	test   %eax,%eax
    36ac:	78 39                	js     36e7 <argptest+0x57>
    36ae:	83 ec 0c             	sub    $0xc,%esp
    36b1:	89 c3                	mov    %eax,%ebx
    36b3:	6a 00                	push   $0x0
    36b5:	e8 41 03 00 00       	call   39fb <sbrk>
    36ba:	83 c4 0c             	add    $0xc,%esp
    36bd:	83 e8 01             	sub    $0x1,%eax
    36c0:	6a ff                	push   $0xffffffff
    36c2:	50                   	push   %eax
    36c3:	53                   	push   %ebx
    36c4:	e8 c2 02 00 00       	call   398b <read>
    36c9:	89 1c 24             	mov    %ebx,(%esp)
    36cc:	e8 ca 02 00 00       	call   399b <close>
    36d1:	58                   	pop    %eax
    36d2:	5a                   	pop    %edx
    36d3:	68 05 4e 00 00       	push   $0x4e05
    36d8:	6a 01                	push   $0x1
    36da:	e8 21 04 00 00       	call   3b00 <printf>
    36df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    36e2:	83 c4 10             	add    $0x10,%esp
    36e5:	c9                   	leave  
    36e6:	c3                   	ret    
    36e7:	51                   	push   %ecx
    36e8:	51                   	push   %ecx
    36e9:	68 f8 4d 00 00       	push   $0x4df8
    36ee:	6a 02                	push   $0x2
    36f0:	e8 0b 04 00 00       	call   3b00 <printf>
    36f5:	e8 79 02 00 00       	call   3973 <exit>
    36fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00003700 <rand>:
    3700:	f3 0f 1e fb          	endbr32 
    3704:	69 05 14 5f 00 00 0d 	imul   $0x19660d,0x5f14,%eax
    370b:	66 19 00 
    370e:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3713:	a3 14 5f 00 00       	mov    %eax,0x5f14
    3718:	c3                   	ret    
    3719:	66 90                	xchg   %ax,%ax
    371b:	66 90                	xchg   %ax,%ax
    371d:	66 90                	xchg   %ax,%ax
    371f:	90                   	nop

00003720 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3720:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3721:	31 c0                	xor    %eax,%eax
{
    3723:	89 e5                	mov    %esp,%ebp
    3725:	53                   	push   %ebx
    3726:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3729:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    372c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
    3730:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
    3734:	88 14 01             	mov    %dl,(%ecx,%eax,1)
    3737:	83 c0 01             	add    $0x1,%eax
    373a:	84 d2                	test   %dl,%dl
    373c:	75 f2                	jne    3730 <strcpy+0x10>
    ;
  return os;
}
    373e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3741:	89 c8                	mov    %ecx,%eax
    3743:	c9                   	leave  
    3744:	c3                   	ret    
    3745:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    374c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003750 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3750:	55                   	push   %ebp
    3751:	89 e5                	mov    %esp,%ebp
    3753:	53                   	push   %ebx
    3754:	8b 55 08             	mov    0x8(%ebp),%edx
    3757:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    375a:	0f b6 02             	movzbl (%edx),%eax
    375d:	84 c0                	test   %al,%al
    375f:	75 17                	jne    3778 <strcmp+0x28>
    3761:	eb 3a                	jmp    379d <strcmp+0x4d>
    3763:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3767:	90                   	nop
    3768:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
    376c:	83 c2 01             	add    $0x1,%edx
    376f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
    3772:	84 c0                	test   %al,%al
    3774:	74 1a                	je     3790 <strcmp+0x40>
    p++, q++;
    3776:	89 d9                	mov    %ebx,%ecx
  while(*p && *p == *q)
    3778:	0f b6 19             	movzbl (%ecx),%ebx
    377b:	38 c3                	cmp    %al,%bl
    377d:	74 e9                	je     3768 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
    377f:	29 d8                	sub    %ebx,%eax
}
    3781:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3784:	c9                   	leave  
    3785:	c3                   	ret    
    3786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    378d:	8d 76 00             	lea    0x0(%esi),%esi
  return (uchar)*p - (uchar)*q;
    3790:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
    3794:	31 c0                	xor    %eax,%eax
    3796:	29 d8                	sub    %ebx,%eax
}
    3798:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    379b:	c9                   	leave  
    379c:	c3                   	ret    
  return (uchar)*p - (uchar)*q;
    379d:	0f b6 19             	movzbl (%ecx),%ebx
    37a0:	31 c0                	xor    %eax,%eax
    37a2:	eb db                	jmp    377f <strcmp+0x2f>
    37a4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    37af:	90                   	nop

000037b0 <strlen>:

uint
strlen(const char *s)
{
    37b0:	55                   	push   %ebp
    37b1:	89 e5                	mov    %esp,%ebp
    37b3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
    37b6:	80 3a 00             	cmpb   $0x0,(%edx)
    37b9:	74 15                	je     37d0 <strlen+0x20>
    37bb:	31 c0                	xor    %eax,%eax
    37bd:	8d 76 00             	lea    0x0(%esi),%esi
    37c0:	83 c0 01             	add    $0x1,%eax
    37c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
    37c7:	89 c1                	mov    %eax,%ecx
    37c9:	75 f5                	jne    37c0 <strlen+0x10>
    ;
  return n;
}
    37cb:	89 c8                	mov    %ecx,%eax
    37cd:	5d                   	pop    %ebp
    37ce:	c3                   	ret    
    37cf:	90                   	nop
  for(n = 0; s[n]; n++)
    37d0:	31 c9                	xor    %ecx,%ecx
}
    37d2:	5d                   	pop    %ebp
    37d3:	89 c8                	mov    %ecx,%eax
    37d5:	c3                   	ret    
    37d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    37dd:	8d 76 00             	lea    0x0(%esi),%esi

000037e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    37e0:	55                   	push   %ebp
    37e1:	89 e5                	mov    %esp,%ebp
    37e3:	57                   	push   %edi
    37e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    37e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    37ea:	8b 45 0c             	mov    0xc(%ebp),%eax
    37ed:	89 d7                	mov    %edx,%edi
    37ef:	fc                   	cld    
    37f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    37f2:	8b 7d fc             	mov    -0x4(%ebp),%edi
    37f5:	89 d0                	mov    %edx,%eax
    37f7:	c9                   	leave  
    37f8:	c3                   	ret    
    37f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00003800 <strchr>:

char*
strchr(const char *s, char c)
{
    3800:	55                   	push   %ebp
    3801:	89 e5                	mov    %esp,%ebp
    3803:	8b 45 08             	mov    0x8(%ebp),%eax
    3806:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
    380a:	0f b6 10             	movzbl (%eax),%edx
    380d:	84 d2                	test   %dl,%dl
    380f:	75 12                	jne    3823 <strchr+0x23>
    3811:	eb 1d                	jmp    3830 <strchr+0x30>
    3813:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3817:	90                   	nop
    3818:	0f b6 50 01          	movzbl 0x1(%eax),%edx
    381c:	83 c0 01             	add    $0x1,%eax
    381f:	84 d2                	test   %dl,%dl
    3821:	74 0d                	je     3830 <strchr+0x30>
    if(*s == c)
    3823:	38 d1                	cmp    %dl,%cl
    3825:	75 f1                	jne    3818 <strchr+0x18>
      return (char*)s;
  return 0;
}
    3827:	5d                   	pop    %ebp
    3828:	c3                   	ret    
    3829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
    3830:	31 c0                	xor    %eax,%eax
}
    3832:	5d                   	pop    %ebp
    3833:	c3                   	ret    
    3834:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    383b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    383f:	90                   	nop

00003840 <gets>:

char*
gets(char *buf, int max)
{
    3840:	55                   	push   %ebp
    3841:	89 e5                	mov    %esp,%ebp
    3843:	57                   	push   %edi
    3844:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
    3845:	8d 7d e7             	lea    -0x19(%ebp),%edi
{
    3848:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
    3849:	31 db                	xor    %ebx,%ebx
{
    384b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
    384e:	eb 27                	jmp    3877 <gets+0x37>
    cc = read(0, &c, 1);
    3850:	83 ec 04             	sub    $0x4,%esp
    3853:	6a 01                	push   $0x1
    3855:	57                   	push   %edi
    3856:	6a 00                	push   $0x0
    3858:	e8 2e 01 00 00       	call   398b <read>
    if(cc < 1)
    385d:	83 c4 10             	add    $0x10,%esp
    3860:	85 c0                	test   %eax,%eax
    3862:	7e 1d                	jle    3881 <gets+0x41>
      break;
    buf[i++] = c;
    3864:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    3868:	8b 55 08             	mov    0x8(%ebp),%edx
    386b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
    386f:	3c 0a                	cmp    $0xa,%al
    3871:	74 1d                	je     3890 <gets+0x50>
    3873:	3c 0d                	cmp    $0xd,%al
    3875:	74 19                	je     3890 <gets+0x50>
  for(i=0; i+1 < max; ){
    3877:	89 de                	mov    %ebx,%esi
    3879:	83 c3 01             	add    $0x1,%ebx
    387c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    387f:	7c cf                	jl     3850 <gets+0x10>
      break;
  }
  buf[i] = '\0';
    3881:	8b 45 08             	mov    0x8(%ebp),%eax
    3884:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3888:	8d 65 f4             	lea    -0xc(%ebp),%esp
    388b:	5b                   	pop    %ebx
    388c:	5e                   	pop    %esi
    388d:	5f                   	pop    %edi
    388e:	5d                   	pop    %ebp
    388f:	c3                   	ret    
  buf[i] = '\0';
    3890:	8b 45 08             	mov    0x8(%ebp),%eax
    3893:	89 de                	mov    %ebx,%esi
    3895:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
}
    3899:	8d 65 f4             	lea    -0xc(%ebp),%esp
    389c:	5b                   	pop    %ebx
    389d:	5e                   	pop    %esi
    389e:	5f                   	pop    %edi
    389f:	5d                   	pop    %ebp
    38a0:	c3                   	ret    
    38a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38af:	90                   	nop

000038b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    38b0:	55                   	push   %ebp
    38b1:	89 e5                	mov    %esp,%ebp
    38b3:	56                   	push   %esi
    38b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    38b5:	83 ec 08             	sub    $0x8,%esp
    38b8:	6a 00                	push   $0x0
    38ba:	ff 75 08             	pushl  0x8(%ebp)
    38bd:	e8 f1 00 00 00       	call   39b3 <open>
  if(fd < 0)
    38c2:	83 c4 10             	add    $0x10,%esp
    38c5:	85 c0                	test   %eax,%eax
    38c7:	78 27                	js     38f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    38c9:	83 ec 08             	sub    $0x8,%esp
    38cc:	ff 75 0c             	pushl  0xc(%ebp)
    38cf:	89 c3                	mov    %eax,%ebx
    38d1:	50                   	push   %eax
    38d2:	e8 f4 00 00 00       	call   39cb <fstat>
  close(fd);
    38d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    38da:	89 c6                	mov    %eax,%esi
  close(fd);
    38dc:	e8 ba 00 00 00       	call   399b <close>
  return r;
    38e1:	83 c4 10             	add    $0x10,%esp
}
    38e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    38e7:	89 f0                	mov    %esi,%eax
    38e9:	5b                   	pop    %ebx
    38ea:	5e                   	pop    %esi
    38eb:	5d                   	pop    %ebp
    38ec:	c3                   	ret    
    38ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    38f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    38f5:	eb ed                	jmp    38e4 <stat+0x34>
    38f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    38fe:	66 90                	xchg   %ax,%ax

00003900 <atoi>:

int
atoi(const char *s)
{
    3900:	55                   	push   %ebp
    3901:	89 e5                	mov    %esp,%ebp
    3903:	53                   	push   %ebx
    3904:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3907:	0f be 02             	movsbl (%edx),%eax
    390a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    390d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    3910:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    3915:	77 1e                	ja     3935 <atoi+0x35>
    3917:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    391e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3920:	83 c2 01             	add    $0x1,%edx
    3923:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    3926:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    392a:	0f be 02             	movsbl (%edx),%eax
    392d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    3930:	80 fb 09             	cmp    $0x9,%bl
    3933:	76 eb                	jbe    3920 <atoi+0x20>
  return n;
}
    3935:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3938:	89 c8                	mov    %ecx,%eax
    393a:	c9                   	leave  
    393b:	c3                   	ret    
    393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00003940 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3940:	55                   	push   %ebp
    3941:	89 e5                	mov    %esp,%ebp
    3943:	57                   	push   %edi
    3944:	8b 45 10             	mov    0x10(%ebp),%eax
    3947:	8b 55 08             	mov    0x8(%ebp),%edx
    394a:	56                   	push   %esi
    394b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    394e:	85 c0                	test   %eax,%eax
    3950:	7e 13                	jle    3965 <memmove+0x25>
    3952:	01 d0                	add    %edx,%eax
  dst = vdst;
    3954:	89 d7                	mov    %edx,%edi
    3956:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    395d:	8d 76 00             	lea    0x0(%esi),%esi
    *dst++ = *src++;
    3960:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    3961:	39 f8                	cmp    %edi,%eax
    3963:	75 fb                	jne    3960 <memmove+0x20>
  return vdst;
}
    3965:	5e                   	pop    %esi
    3966:	89 d0                	mov    %edx,%eax
    3968:	5f                   	pop    %edi
    3969:	5d                   	pop    %ebp
    396a:	c3                   	ret    

0000396b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    396b:	b8 01 00 00 00       	mov    $0x1,%eax
    3970:	cd 40                	int    $0x40
    3972:	c3                   	ret    

00003973 <exit>:
SYSCALL(exit)
    3973:	b8 02 00 00 00       	mov    $0x2,%eax
    3978:	cd 40                	int    $0x40
    397a:	c3                   	ret    

0000397b <wait>:
SYSCALL(wait)
    397b:	b8 03 00 00 00       	mov    $0x3,%eax
    3980:	cd 40                	int    $0x40
    3982:	c3                   	ret    

00003983 <pipe>:
SYSCALL(pipe)
    3983:	b8 04 00 00 00       	mov    $0x4,%eax
    3988:	cd 40                	int    $0x40
    398a:	c3                   	ret    

0000398b <read>:
SYSCALL(read)
    398b:	b8 05 00 00 00       	mov    $0x5,%eax
    3990:	cd 40                	int    $0x40
    3992:	c3                   	ret    

00003993 <write>:
SYSCALL(write)
    3993:	b8 10 00 00 00       	mov    $0x10,%eax
    3998:	cd 40                	int    $0x40
    399a:	c3                   	ret    

0000399b <close>:
SYSCALL(close)
    399b:	b8 15 00 00 00       	mov    $0x15,%eax
    39a0:	cd 40                	int    $0x40
    39a2:	c3                   	ret    

000039a3 <kill>:
SYSCALL(kill)
    39a3:	b8 06 00 00 00       	mov    $0x6,%eax
    39a8:	cd 40                	int    $0x40
    39aa:	c3                   	ret    

000039ab <exec>:
SYSCALL(exec)
    39ab:	b8 07 00 00 00       	mov    $0x7,%eax
    39b0:	cd 40                	int    $0x40
    39b2:	c3                   	ret    

000039b3 <open>:
SYSCALL(open)
    39b3:	b8 0f 00 00 00       	mov    $0xf,%eax
    39b8:	cd 40                	int    $0x40
    39ba:	c3                   	ret    

000039bb <mknod>:
SYSCALL(mknod)
    39bb:	b8 11 00 00 00       	mov    $0x11,%eax
    39c0:	cd 40                	int    $0x40
    39c2:	c3                   	ret    

000039c3 <unlink>:
SYSCALL(unlink)
    39c3:	b8 12 00 00 00       	mov    $0x12,%eax
    39c8:	cd 40                	int    $0x40
    39ca:	c3                   	ret    

000039cb <fstat>:
SYSCALL(fstat)
    39cb:	b8 08 00 00 00       	mov    $0x8,%eax
    39d0:	cd 40                	int    $0x40
    39d2:	c3                   	ret    

000039d3 <link>:
SYSCALL(link)
    39d3:	b8 13 00 00 00       	mov    $0x13,%eax
    39d8:	cd 40                	int    $0x40
    39da:	c3                   	ret    

000039db <mkdir>:
SYSCALL(mkdir)
    39db:	b8 14 00 00 00       	mov    $0x14,%eax
    39e0:	cd 40                	int    $0x40
    39e2:	c3                   	ret    

000039e3 <chdir>:
SYSCALL(chdir)
    39e3:	b8 09 00 00 00       	mov    $0x9,%eax
    39e8:	cd 40                	int    $0x40
    39ea:	c3                   	ret    

000039eb <dup>:
SYSCALL(dup)
    39eb:	b8 0a 00 00 00       	mov    $0xa,%eax
    39f0:	cd 40                	int    $0x40
    39f2:	c3                   	ret    

000039f3 <getpid>:
SYSCALL(getpid)
    39f3:	b8 0b 00 00 00       	mov    $0xb,%eax
    39f8:	cd 40                	int    $0x40
    39fa:	c3                   	ret    

000039fb <sbrk>:
SYSCALL(sbrk)
    39fb:	b8 0c 00 00 00       	mov    $0xc,%eax
    3a00:	cd 40                	int    $0x40
    3a02:	c3                   	ret    

00003a03 <sleep>:
SYSCALL(sleep)
    3a03:	b8 0d 00 00 00       	mov    $0xd,%eax
    3a08:	cd 40                	int    $0x40
    3a0a:	c3                   	ret    

00003a0b <uptime>:
SYSCALL(uptime)
    3a0b:	b8 0e 00 00 00       	mov    $0xe,%eax
    3a10:	cd 40                	int    $0x40
    3a12:	c3                   	ret    

00003a13 <calculate_sum_of_digits>:
SYSCALL(calculate_sum_of_digits)
    3a13:	b8 16 00 00 00       	mov    $0x16,%eax
    3a18:	cd 40                	int    $0x40
    3a1a:	c3                   	ret    

00003a1b <get_file_sectors>:
SYSCALL(get_file_sectors)
    3a1b:	b8 17 00 00 00       	mov    $0x17,%eax
    3a20:	cd 40                	int    $0x40
    3a22:	c3                   	ret    

00003a23 <get_parent_pid>:
SYSCALL(get_parent_pid)
    3a23:	b8 18 00 00 00       	mov    $0x18,%eax
    3a28:	cd 40                	int    $0x40
    3a2a:	c3                   	ret    

00003a2b <wait_sleeping>:
SYSCALL(wait_sleeping)
    3a2b:	b8 19 00 00 00       	mov    $0x19,%eax
    3a30:	cd 40                	int    $0x40
    3a32:	c3                   	ret    

00003a33 <set_proc_tracer>:
SYSCALL(set_proc_tracer)
    3a33:	b8 1a 00 00 00       	mov    $0x1a,%eax
    3a38:	cd 40                	int    $0x40
    3a3a:	c3                   	ret    

00003a3b <get_proc_queue_level>:
SYSCALL(get_proc_queue_level)
    3a3b:	b8 1b 00 00 00       	mov    $0x1b,%eax
    3a40:	cd 40                	int    $0x40
    3a42:	c3                   	ret    

00003a43 <set_proc_queue_level>:
SYSCALL(set_proc_queue_level)
    3a43:	b8 1c 00 00 00       	mov    $0x1c,%eax
    3a48:	cd 40                	int    $0x40
    3a4a:	c3                   	ret    
    3a4b:	66 90                	xchg   %ax,%ax
    3a4d:	66 90                	xchg   %ax,%ax
    3a4f:	90                   	nop

00003a50 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3a50:	55                   	push   %ebp
    3a51:	89 e5                	mov    %esp,%ebp
    3a53:	57                   	push   %edi
    3a54:	56                   	push   %esi
    3a55:	53                   	push   %ebx
    3a56:	83 ec 3c             	sub    $0x3c,%esp
    3a59:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3a5c:	89 d1                	mov    %edx,%ecx
{
    3a5e:	89 45 b8             	mov    %eax,-0x48(%ebp)
  if(sgn && xx < 0){
    3a61:	85 d2                	test   %edx,%edx
    3a63:	0f 89 7f 00 00 00    	jns    3ae8 <printint+0x98>
    3a69:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    3a6d:	74 79                	je     3ae8 <printint+0x98>
    neg = 1;
    3a6f:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3a76:	f7 d9                	neg    %ecx
  } else {
    x = xx;
  }

  i = 0;
    3a78:	31 db                	xor    %ebx,%ebx
    3a7a:	8d 75 d7             	lea    -0x29(%ebp),%esi
    3a7d:	8d 76 00             	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    3a80:	89 c8                	mov    %ecx,%eax
    3a82:	31 d2                	xor    %edx,%edx
    3a84:	89 cf                	mov    %ecx,%edi
    3a86:	f7 75 c4             	divl   -0x3c(%ebp)
    3a89:	0f b6 92 20 56 00 00 	movzbl 0x5620(%edx),%edx
    3a90:	89 45 c0             	mov    %eax,-0x40(%ebp)
    3a93:	89 d8                	mov    %ebx,%eax
    3a95:	8d 5b 01             	lea    0x1(%ebx),%ebx
  }while((x /= base) != 0);
    3a98:	8b 4d c0             	mov    -0x40(%ebp),%ecx
    buf[i++] = digits[x % base];
    3a9b:	88 14 1e             	mov    %dl,(%esi,%ebx,1)
  }while((x /= base) != 0);
    3a9e:	39 7d c4             	cmp    %edi,-0x3c(%ebp)
    3aa1:	76 dd                	jbe    3a80 <printint+0x30>
  if(neg)
    3aa3:	8b 4d bc             	mov    -0x44(%ebp),%ecx
    3aa6:	85 c9                	test   %ecx,%ecx
    3aa8:	74 0c                	je     3ab6 <printint+0x66>
    buf[i++] = '-';
    3aaa:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
    buf[i++] = digits[x % base];
    3aaf:	89 d8                	mov    %ebx,%eax
    buf[i++] = '-';
    3ab1:	ba 2d 00 00 00       	mov    $0x2d,%edx

  while(--i >= 0)
    3ab6:	8b 7d b8             	mov    -0x48(%ebp),%edi
    3ab9:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
    3abd:	eb 07                	jmp    3ac6 <printint+0x76>
    3abf:	90                   	nop
    putc(fd, buf[i]);
    3ac0:	0f b6 13             	movzbl (%ebx),%edx
    3ac3:	83 eb 01             	sub    $0x1,%ebx
  write(fd, &c, 1);
    3ac6:	83 ec 04             	sub    $0x4,%esp
    3ac9:	88 55 d7             	mov    %dl,-0x29(%ebp)
    3acc:	6a 01                	push   $0x1
    3ace:	56                   	push   %esi
    3acf:	57                   	push   %edi
    3ad0:	e8 be fe ff ff       	call   3993 <write>
  while(--i >= 0)
    3ad5:	83 c4 10             	add    $0x10,%esp
    3ad8:	39 de                	cmp    %ebx,%esi
    3ada:	75 e4                	jne    3ac0 <printint+0x70>
}
    3adc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3adf:	5b                   	pop    %ebx
    3ae0:	5e                   	pop    %esi
    3ae1:	5f                   	pop    %edi
    3ae2:	5d                   	pop    %ebp
    3ae3:	c3                   	ret    
    3ae4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    3ae8:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    3aef:	eb 87                	jmp    3a78 <printint+0x28>
    3af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3af8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3aff:	90                   	nop

00003b00 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    3b00:	55                   	push   %ebp
    3b01:	89 e5                	mov    %esp,%ebp
    3b03:	57                   	push   %edi
    3b04:	56                   	push   %esi
    3b05:	53                   	push   %ebx
    3b06:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3b09:	8b 5d 0c             	mov    0xc(%ebp),%ebx
{
    3b0c:	8b 75 08             	mov    0x8(%ebp),%esi
  for(i = 0; fmt[i]; i++){
    3b0f:	0f b6 13             	movzbl (%ebx),%edx
    3b12:	84 d2                	test   %dl,%dl
    3b14:	74 6a                	je     3b80 <printf+0x80>
  ap = (uint*)(void*)&fmt + 1;
    3b16:	8d 45 10             	lea    0x10(%ebp),%eax
    3b19:	83 c3 01             	add    $0x1,%ebx
  write(fd, &c, 1);
    3b1c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  state = 0;
    3b1f:	31 c9                	xor    %ecx,%ecx
  ap = (uint*)(void*)&fmt + 1;
    3b21:	89 45 d0             	mov    %eax,-0x30(%ebp)
    3b24:	eb 36                	jmp    3b5c <printf+0x5c>
    3b26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b2d:	8d 76 00             	lea    0x0(%esi),%esi
    3b30:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3b33:	b9 25 00 00 00       	mov    $0x25,%ecx
      if(c == '%'){
    3b38:	83 f8 25             	cmp    $0x25,%eax
    3b3b:	74 15                	je     3b52 <printf+0x52>
  write(fd, &c, 1);
    3b3d:	83 ec 04             	sub    $0x4,%esp
    3b40:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3b43:	6a 01                	push   $0x1
    3b45:	57                   	push   %edi
    3b46:	56                   	push   %esi
    3b47:	e8 47 fe ff ff       	call   3993 <write>
    3b4c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      } else {
        putc(fd, c);
    3b4f:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    3b52:	0f b6 13             	movzbl (%ebx),%edx
    3b55:	83 c3 01             	add    $0x1,%ebx
    3b58:	84 d2                	test   %dl,%dl
    3b5a:	74 24                	je     3b80 <printf+0x80>
    c = fmt[i] & 0xff;
    3b5c:	0f b6 c2             	movzbl %dl,%eax
    if(state == 0){
    3b5f:	85 c9                	test   %ecx,%ecx
    3b61:	74 cd                	je     3b30 <printf+0x30>
      }
    } else if(state == '%'){
    3b63:	83 f9 25             	cmp    $0x25,%ecx
    3b66:	75 ea                	jne    3b52 <printf+0x52>
      if(c == 'd'){
    3b68:	83 f8 25             	cmp    $0x25,%eax
    3b6b:	0f 84 07 01 00 00    	je     3c78 <printf+0x178>
    3b71:	83 e8 63             	sub    $0x63,%eax
    3b74:	83 f8 15             	cmp    $0x15,%eax
    3b77:	77 17                	ja     3b90 <printf+0x90>
    3b79:	ff 24 85 c8 55 00 00 	jmp    *0x55c8(,%eax,4)
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3b80:	8d 65 f4             	lea    -0xc(%ebp),%esp
    3b83:	5b                   	pop    %ebx
    3b84:	5e                   	pop    %esi
    3b85:	5f                   	pop    %edi
    3b86:	5d                   	pop    %ebp
    3b87:	c3                   	ret    
    3b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3b8f:	90                   	nop
  write(fd, &c, 1);
    3b90:	83 ec 04             	sub    $0x4,%esp
    3b93:	88 55 d4             	mov    %dl,-0x2c(%ebp)
    3b96:	6a 01                	push   $0x1
    3b98:	57                   	push   %edi
    3b99:	56                   	push   %esi
    3b9a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    3b9e:	e8 f0 fd ff ff       	call   3993 <write>
        putc(fd, c);
    3ba3:	0f b6 55 d4          	movzbl -0x2c(%ebp),%edx
  write(fd, &c, 1);
    3ba7:	83 c4 0c             	add    $0xc,%esp
    3baa:	88 55 e7             	mov    %dl,-0x19(%ebp)
    3bad:	6a 01                	push   $0x1
    3baf:	57                   	push   %edi
    3bb0:	56                   	push   %esi
    3bb1:	e8 dd fd ff ff       	call   3993 <write>
        putc(fd, c);
    3bb6:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3bb9:	31 c9                	xor    %ecx,%ecx
    3bbb:	eb 95                	jmp    3b52 <printf+0x52>
    3bbd:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    3bc0:	83 ec 0c             	sub    $0xc,%esp
    3bc3:	b9 10 00 00 00       	mov    $0x10,%ecx
    3bc8:	6a 00                	push   $0x0
    3bca:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3bcd:	8b 10                	mov    (%eax),%edx
    3bcf:	89 f0                	mov    %esi,%eax
    3bd1:	e8 7a fe ff ff       	call   3a50 <printint>
        ap++;
    3bd6:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3bda:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3bdd:	31 c9                	xor    %ecx,%ecx
    3bdf:	e9 6e ff ff ff       	jmp    3b52 <printf+0x52>
    3be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    3be8:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3beb:	8b 10                	mov    (%eax),%edx
        ap++;
    3bed:	83 c0 04             	add    $0x4,%eax
    3bf0:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    3bf3:	85 d2                	test   %edx,%edx
    3bf5:	0f 84 8d 00 00 00    	je     3c88 <printf+0x188>
        while(*s != 0){
    3bfb:	0f b6 02             	movzbl (%edx),%eax
      state = 0;
    3bfe:	31 c9                	xor    %ecx,%ecx
        while(*s != 0){
    3c00:	84 c0                	test   %al,%al
    3c02:	0f 84 4a ff ff ff    	je     3b52 <printf+0x52>
    3c08:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3c0b:	89 d3                	mov    %edx,%ebx
    3c0d:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    3c10:	83 ec 04             	sub    $0x4,%esp
          s++;
    3c13:	83 c3 01             	add    $0x1,%ebx
    3c16:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3c19:	6a 01                	push   $0x1
    3c1b:	57                   	push   %edi
    3c1c:	56                   	push   %esi
    3c1d:	e8 71 fd ff ff       	call   3993 <write>
        while(*s != 0){
    3c22:	0f b6 03             	movzbl (%ebx),%eax
    3c25:	83 c4 10             	add    $0x10,%esp
    3c28:	84 c0                	test   %al,%al
    3c2a:	75 e4                	jne    3c10 <printf+0x110>
      state = 0;
    3c2c:	8b 5d d4             	mov    -0x2c(%ebp),%ebx
    3c2f:	31 c9                	xor    %ecx,%ecx
    3c31:	e9 1c ff ff ff       	jmp    3b52 <printf+0x52>
    3c36:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3c3d:	8d 76 00             	lea    0x0(%esi),%esi
        printint(fd, *ap, 10, 1);
    3c40:	83 ec 0c             	sub    $0xc,%esp
    3c43:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3c48:	6a 01                	push   $0x1
    3c4a:	e9 7b ff ff ff       	jmp    3bca <printf+0xca>
    3c4f:	90                   	nop
        putc(fd, *ap);
    3c50:	8b 45 d0             	mov    -0x30(%ebp),%eax
  write(fd, &c, 1);
    3c53:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    3c56:	8b 00                	mov    (%eax),%eax
  write(fd, &c, 1);
    3c58:	6a 01                	push   $0x1
    3c5a:	57                   	push   %edi
    3c5b:	56                   	push   %esi
        putc(fd, *ap);
    3c5c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    3c5f:	e8 2f fd ff ff       	call   3993 <write>
        ap++;
    3c64:	83 45 d0 04          	addl   $0x4,-0x30(%ebp)
    3c68:	83 c4 10             	add    $0x10,%esp
      state = 0;
    3c6b:	31 c9                	xor    %ecx,%ecx
    3c6d:	e9 e0 fe ff ff       	jmp    3b52 <printf+0x52>
    3c72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        putc(fd, c);
    3c78:	88 55 e7             	mov    %dl,-0x19(%ebp)
  write(fd, &c, 1);
    3c7b:	83 ec 04             	sub    $0x4,%esp
    3c7e:	e9 2a ff ff ff       	jmp    3bad <printf+0xad>
    3c83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    3c87:	90                   	nop
          s = "(null)";
    3c88:	ba be 55 00 00       	mov    $0x55be,%edx
        while(*s != 0){
    3c8d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
    3c90:	b8 28 00 00 00       	mov    $0x28,%eax
    3c95:	89 d3                	mov    %edx,%ebx
    3c97:	e9 74 ff ff ff       	jmp    3c10 <printf+0x110>
    3c9c:	66 90                	xchg   %ax,%ax
    3c9e:	66 90                	xchg   %ax,%ax

00003ca0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3ca0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3ca1:	a1 c0 5f 00 00       	mov    0x5fc0,%eax
{
    3ca6:	89 e5                	mov    %esp,%ebp
    3ca8:	57                   	push   %edi
    3ca9:	56                   	push   %esi
    3caa:	53                   	push   %ebx
    3cab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    3cae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3cb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    3cb8:	89 c2                	mov    %eax,%edx
    3cba:	8b 00                	mov    (%eax),%eax
    3cbc:	39 ca                	cmp    %ecx,%edx
    3cbe:	73 30                	jae    3cf0 <free+0x50>
    3cc0:	39 c1                	cmp    %eax,%ecx
    3cc2:	72 04                	jb     3cc8 <free+0x28>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3cc4:	39 c2                	cmp    %eax,%edx
    3cc6:	72 f0                	jb     3cb8 <free+0x18>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3cc8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3ccb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3cce:	39 f8                	cmp    %edi,%eax
    3cd0:	74 30                	je     3d02 <free+0x62>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    3cd2:	89 43 f8             	mov    %eax,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3cd5:	8b 42 04             	mov    0x4(%edx),%eax
    3cd8:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3cdb:	39 f1                	cmp    %esi,%ecx
    3cdd:	74 3a                	je     3d19 <free+0x79>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    3cdf:	89 0a                	mov    %ecx,(%edx)
  } else
    p->s.ptr = bp;
  freep = p;
}
    3ce1:	5b                   	pop    %ebx
  freep = p;
    3ce2:	89 15 c0 5f 00 00    	mov    %edx,0x5fc0
}
    3ce8:	5e                   	pop    %esi
    3ce9:	5f                   	pop    %edi
    3cea:	5d                   	pop    %ebp
    3ceb:	c3                   	ret    
    3cec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3cf0:	39 c2                	cmp    %eax,%edx
    3cf2:	72 c4                	jb     3cb8 <free+0x18>
    3cf4:	39 c1                	cmp    %eax,%ecx
    3cf6:	73 c0                	jae    3cb8 <free+0x18>
  if(bp + bp->s.size == p->s.ptr){
    3cf8:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3cfb:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    3cfe:	39 f8                	cmp    %edi,%eax
    3d00:	75 d0                	jne    3cd2 <free+0x32>
    bp->s.size += p->s.ptr->s.size;
    3d02:	03 70 04             	add    0x4(%eax),%esi
    3d05:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3d08:	8b 02                	mov    (%edx),%eax
    3d0a:	8b 00                	mov    (%eax),%eax
    3d0c:	89 43 f8             	mov    %eax,-0x8(%ebx)
  if(p + p->s.size == bp){
    3d0f:	8b 42 04             	mov    0x4(%edx),%eax
    3d12:	8d 34 c2             	lea    (%edx,%eax,8),%esi
    3d15:	39 f1                	cmp    %esi,%ecx
    3d17:	75 c6                	jne    3cdf <free+0x3f>
    p->s.size += bp->s.size;
    3d19:	03 43 fc             	add    -0x4(%ebx),%eax
  freep = p;
    3d1c:	89 15 c0 5f 00 00    	mov    %edx,0x5fc0
    p->s.size += bp->s.size;
    3d22:	89 42 04             	mov    %eax,0x4(%edx)
    p->s.ptr = bp->s.ptr;
    3d25:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    3d28:	89 0a                	mov    %ecx,(%edx)
}
    3d2a:	5b                   	pop    %ebx
    3d2b:	5e                   	pop    %esi
    3d2c:	5f                   	pop    %edi
    3d2d:	5d                   	pop    %ebp
    3d2e:	c3                   	ret    
    3d2f:	90                   	nop

00003d30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3d30:	55                   	push   %ebp
    3d31:	89 e5                	mov    %esp,%ebp
    3d33:	57                   	push   %edi
    3d34:	56                   	push   %esi
    3d35:	53                   	push   %ebx
    3d36:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3d39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    3d3c:	8b 3d c0 5f 00 00    	mov    0x5fc0,%edi
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3d42:	8d 70 07             	lea    0x7(%eax),%esi
    3d45:	c1 ee 03             	shr    $0x3,%esi
    3d48:	83 c6 01             	add    $0x1,%esi
  if((prevp = freep) == 0){
    3d4b:	85 ff                	test   %edi,%edi
    3d4d:	0f 84 9d 00 00 00    	je     3df0 <malloc+0xc0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d53:	8b 17                	mov    (%edi),%edx
    if(p->s.size >= nunits){
    3d55:	8b 4a 04             	mov    0x4(%edx),%ecx
    3d58:	39 f1                	cmp    %esi,%ecx
    3d5a:	73 6a                	jae    3dc6 <malloc+0x96>
    3d5c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    3d61:	39 de                	cmp    %ebx,%esi
    3d63:	0f 43 de             	cmovae %esi,%ebx
  p = sbrk(nu * sizeof(Header));
    3d66:	8d 04 dd 00 00 00 00 	lea    0x0(,%ebx,8),%eax
    3d6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    3d70:	eb 17                	jmp    3d89 <malloc+0x59>
    3d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3d78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3d7a:	8b 48 04             	mov    0x4(%eax),%ecx
    3d7d:	39 f1                	cmp    %esi,%ecx
    3d7f:	73 4f                	jae    3dd0 <malloc+0xa0>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3d81:	8b 3d c0 5f 00 00    	mov    0x5fc0,%edi
    3d87:	89 c2                	mov    %eax,%edx
    3d89:	39 d7                	cmp    %edx,%edi
    3d8b:	75 eb                	jne    3d78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    3d8d:	83 ec 0c             	sub    $0xc,%esp
    3d90:	ff 75 e4             	pushl  -0x1c(%ebp)
    3d93:	e8 63 fc ff ff       	call   39fb <sbrk>
  if(p == (char*)-1)
    3d98:	83 c4 10             	add    $0x10,%esp
    3d9b:	83 f8 ff             	cmp    $0xffffffff,%eax
    3d9e:	74 1c                	je     3dbc <malloc+0x8c>
  hp->s.size = nu;
    3da0:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    3da3:	83 ec 0c             	sub    $0xc,%esp
    3da6:	83 c0 08             	add    $0x8,%eax
    3da9:	50                   	push   %eax
    3daa:	e8 f1 fe ff ff       	call   3ca0 <free>
  return freep;
    3daf:	8b 15 c0 5f 00 00    	mov    0x5fc0,%edx
      if((p = morecore(nunits)) == 0)
    3db5:	83 c4 10             	add    $0x10,%esp
    3db8:	85 d2                	test   %edx,%edx
    3dba:	75 bc                	jne    3d78 <malloc+0x48>
        return 0;
  }
}
    3dbc:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    3dbf:	31 c0                	xor    %eax,%eax
}
    3dc1:	5b                   	pop    %ebx
    3dc2:	5e                   	pop    %esi
    3dc3:	5f                   	pop    %edi
    3dc4:	5d                   	pop    %ebp
    3dc5:	c3                   	ret    
    if(p->s.size >= nunits){
    3dc6:	89 d0                	mov    %edx,%eax
    3dc8:	89 fa                	mov    %edi,%edx
    3dca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    3dd0:	39 ce                	cmp    %ecx,%esi
    3dd2:	74 4c                	je     3e20 <malloc+0xf0>
        p->s.size -= nunits;
    3dd4:	29 f1                	sub    %esi,%ecx
    3dd6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3dd9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3ddc:	89 70 04             	mov    %esi,0x4(%eax)
      freep = prevp;
    3ddf:	89 15 c0 5f 00 00    	mov    %edx,0x5fc0
}
    3de5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    3de8:	83 c0 08             	add    $0x8,%eax
}
    3deb:	5b                   	pop    %ebx
    3dec:	5e                   	pop    %esi
    3ded:	5f                   	pop    %edi
    3dee:	5d                   	pop    %ebp
    3def:	c3                   	ret    
    base.s.ptr = freep = prevp = &base;
    3df0:	c7 05 c0 5f 00 00 c4 	movl   $0x5fc4,0x5fc0
    3df7:	5f 00 00 
    base.s.size = 0;
    3dfa:	bf c4 5f 00 00       	mov    $0x5fc4,%edi
    base.s.ptr = freep = prevp = &base;
    3dff:	c7 05 c4 5f 00 00 c4 	movl   $0x5fc4,0x5fc4
    3e06:	5f 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3e09:	89 fa                	mov    %edi,%edx
    base.s.size = 0;
    3e0b:	c7 05 c8 5f 00 00 00 	movl   $0x0,0x5fc8
    3e12:	00 00 00 
    if(p->s.size >= nunits){
    3e15:	e9 42 ff ff ff       	jmp    3d5c <malloc+0x2c>
    3e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        prevp->s.ptr = p->s.ptr;
    3e20:	8b 08                	mov    (%eax),%ecx
    3e22:	89 0a                	mov    %ecx,(%edx)
    3e24:	eb b9                	jmp    3ddf <malloc+0xaf>
