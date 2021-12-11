
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
80100028:	bc f0 6b 11 80       	mov    $0x80116bf0,%esp
8010002d:	b8 30 35 10 80       	mov    $0x80103530,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 7e 10 80       	push   $0x80107ee0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 25 4e 00 00       	call   80104e80 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 7e 10 80       	push   $0x80107ee7
80100097:	50                   	push   %eax
80100098:	e8 b3 4c 00 00       	call   80104d50 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave  
801000c2:	c3                   	ret    
801000c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 67 4f 00 00       	call   80105050 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 89 4e 00 00       	call   80104ff0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 4c 00 00       	call   80104d90 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret    
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 1f 26 00 00       	call   801027b0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 7e 10 80       	push   $0x80107eee
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
801001ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801001af:	90                   	nop

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 6d 4c 00 00       	call   80104e30 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave  
  iderw(b);
801001d4:	e9 d7 25 00 00       	jmp    801027b0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 7e 10 80       	push   $0x80107eff
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
801001e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801001ed:	8d 76 00             	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 2c 4c 00 00       	call   80104e30 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 4b 00 00       	call   80104df0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 30 4e 00 00       	call   80105050 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2f                	jne    8010025f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 43 54             	mov    0x54(%ebx),%eax
80100233:	8b 53 50             	mov    0x50(%ebx),%edx
80100236:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100239:	8b 43 50             	mov    0x50(%ebx),%eax
8010023c:	8b 53 54             	mov    0x54(%ebx),%edx
8010023f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100242:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
    b->prev = &bcache.head;
80100247:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100251:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100256:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100259:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
  }
  
  release(&bcache.lock);
8010025f:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
}
80100266:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100269:	5b                   	pop    %ebx
8010026a:	5e                   	pop    %esi
8010026b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010026c:	e9 7f 4d 00 00       	jmp    80104ff0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 06 7f 10 80       	push   $0x80107f06
80100279:	e8 02 01 00 00       	call   80100380 <panic>
8010027e:	66 90                	xchg   %ax,%ax

80100280 <consoleread>:
    }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
    uint target;
    int c;

    iunlock(ip);
8010028f:	ff 75 08             	pushl  0x8(%ebp)
    target = n;
80100292:	89 df                	mov    %ebx,%edi
    iunlock(ip);
80100294:	e8 87 1a 00 00       	call   80101d20 <iunlock>
    acquire(&cons.lock);
80100299:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801002a0:	e8 ab 4d 00 00       	call   80105050 <acquire>
    while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>
        while(input.r == input.w){
801002b0:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002b5:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
            if(myproc()->killed){
                release(&cons.lock);
                ilock(ip);
                return -1;
            }
            sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 20 ff 10 80       	push   $0x8010ff20
801002c8:	68 00 ff 10 80       	push   $0x8010ff00
801002cd:	e8 0e 46 00 00       	call   801048e0 <sleep>
        while(input.r == input.w){
801002d2:	a1 00 ff 10 80       	mov    0x8010ff00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
            if(myproc()->killed){
801002e2:	e8 a9 3b 00 00       	call   80103e90 <myproc>
801002e7:	8b 48 28             	mov    0x28(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
                release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ff 10 80       	push   $0x8010ff20
801002f6:	e8 f5 4c 00 00       	call   80104ff0 <release>
                ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	pushl  0x8(%ebp)
801002ff:	e8 3c 19 00 00       	call   80101c40 <ilock>
                return -1;
80100304:	83 c4 10             	add    $0x10,%esp
    }
    release(&cons.lock);
    ilock(ip);

    return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret    
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 00 ff 10 80    	mov    %edx,0x8010ff00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 fe 10 80 	movsbl -0x7fef0180(%edx),%ecx
        if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
        *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
        --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
        *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
        if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
    release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 20 ff 10 80       	push   $0x8010ff20
8010034c:	e8 9f 4c 00 00       	call   80104ff0 <release>
    ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	pushl  0x8(%ebp)
80100355:	e8 e6 18 00 00       	call   80101c40 <ilock>
    return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret    
            if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
                input.r--;
8010036d:	a3 00 ff 10 80       	mov    %eax,0x8010ff00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010037b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010037f:	90                   	nop

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli    
    cons.locking = 0;
80100389:	c7 05 54 ff 10 80 00 	movl   $0x0,0x8010ff54
80100390:	00 00 00 
    getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
    cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 22 2a 00 00       	call   80102dc0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 7f 10 80       	push   $0x80107f0d
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
    cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
    cprintf("\n");
801003b5:	c7 04 24 bd 84 10 80 	movl   $0x801084bd,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
    getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 d3 4a 00 00       	call   80104ea0 <getcallerpcs>
    for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
        cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
    for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
        cprintf(" %p", pcs[i]);
801003d8:	68 21 7f 10 80       	push   $0x80107f21
801003dd:	e8 be 02 00 00       	call   801006a0 <cprintf>
    for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
    panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ff 10 80 01 	movl   $0x1,0x8010ff58
801003f0:	00 00 00 
    for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801003fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100400 <consputc.part.0>:
consputc(int c)
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	57                   	push   %edi
80100404:	56                   	push   %esi
80100405:	53                   	push   %ebx
80100406:	89 c3                	mov    %eax,%ebx
80100408:	83 ec 1c             	sub    $0x1c,%esp
    if(c == BACKSPACE){
8010040b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100410:	0f 84 ea 00 00 00    	je     80100500 <consputc.part.0+0x100>
        uartputc(c);
80100416:	83 ec 0c             	sub    $0xc,%esp
80100419:	50                   	push   %eax
8010041a:	e8 e1 65 00 00       	call   80106a00 <uartputc>
8010041f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100422:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100427:	b8 0e 00 00 00       	mov    $0xe,%eax
8010042c:	89 fa                	mov    %edi,%edx
8010042e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042f:	be d5 03 00 00       	mov    $0x3d5,%esi
80100434:	89 f2                	mov    %esi,%edx
80100436:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100437:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010043a:	89 fa                	mov    %edi,%edx
8010043c:	b8 0f 00 00 00       	mov    $0xf,%eax
80100441:	c1 e1 08             	shl    $0x8,%ecx
80100444:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100445:	89 f2                	mov    %esi,%edx
80100447:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100448:	0f b6 c0             	movzbl %al,%eax
8010044b:	09 c8                	or     %ecx,%eax
    if(c == '\n')
8010044d:	83 fb 0a             	cmp    $0xa,%ebx
80100450:	0f 84 92 00 00 00    	je     801004e8 <consputc.part.0+0xe8>
    else if(c == BACKSPACE){
80100456:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010045c:	74 72                	je     801004d0 <consputc.part.0+0xd0>
        crt[pos++] = (c&0xff) | 0x0700;  // black on white
8010045e:	0f b6 db             	movzbl %bl,%ebx
80100461:	8d 70 01             	lea    0x1(%eax),%esi
80100464:	80 cf 07             	or     $0x7,%bh
80100467:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
8010046e:	80 
    if(pos < 0 || pos > 25*80)
8010046f:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100475:	0f 8f fb 00 00 00    	jg     80100576 <consputc.part.0+0x176>
    if((pos/80) >= 24){  // Scroll up.
8010047b:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100481:	0f 8f a9 00 00 00    	jg     80100530 <consputc.part.0+0x130>
    outb(CRTPORT+1, pos>>8);
80100487:	89 f0                	mov    %esi,%eax
    crt[pos] = ' ' | 0x0700;
80100489:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
    outb(CRTPORT+1, pos);
80100490:	88 45 e7             	mov    %al,-0x19(%ebp)
    outb(CRTPORT+1, pos>>8);
80100493:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100496:	bb d4 03 00 00       	mov    $0x3d4,%ebx
8010049b:	b8 0e 00 00 00       	mov    $0xe,%eax
801004a0:	89 da                	mov    %ebx,%edx
801004a2:	ee                   	out    %al,(%dx)
801004a3:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004a8:	89 f8                	mov    %edi,%eax
801004aa:	89 ca                	mov    %ecx,%edx
801004ac:	ee                   	out    %al,(%dx)
801004ad:	b8 0f 00 00 00       	mov    $0xf,%eax
801004b2:	89 da                	mov    %ebx,%edx
801004b4:	ee                   	out    %al,(%dx)
801004b5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
    crt[pos] = ' ' | 0x0700;
801004bc:	b8 20 07 00 00       	mov    $0x720,%eax
801004c1:	66 89 06             	mov    %ax,(%esi)
}
801004c4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004c7:	5b                   	pop    %ebx
801004c8:	5e                   	pop    %esi
801004c9:	5f                   	pop    %edi
801004ca:	5d                   	pop    %ebp
801004cb:	c3                   	ret    
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(pos > 0) --pos;
801004d0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004d3:	85 c0                	test   %eax,%eax
801004d5:	75 98                	jne    8010046f <consputc.part.0+0x6f>
801004d7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004db:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004e0:	31 ff                	xor    %edi,%edi
801004e2:	eb b2                	jmp    80100496 <consputc.part.0+0x96>
801004e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pos += 80 - pos%80;
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 70 50             	lea    0x50(%eax),%esi
801004fb:	e9 6f ff ff ff       	jmp    8010046f <consputc.part.0+0x6f>
        uartputc('\b'); uartputc(' '); uartputc('\b');
80100500:	83 ec 0c             	sub    $0xc,%esp
80100503:	6a 08                	push   $0x8
80100505:	e8 f6 64 00 00       	call   80106a00 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 ea 64 00 00       	call   80106a00 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 de 64 00 00       	call   80106a00 <uartputc>
80100522:	83 c4 10             	add    $0x10,%esp
80100525:	e9 f8 fe ff ff       	jmp    80100422 <consputc.part.0+0x22>
8010052a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100530:	83 ec 04             	sub    $0x4,%esp
        pos -= 80;
80100533:	8d 5e b0             	lea    -0x50(%esi),%ebx
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100536:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
    outb(CRTPORT+1, pos);
8010053d:	bf 07 00 00 00       	mov    $0x7,%edi
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100542:	68 60 0e 00 00       	push   $0xe60
80100547:	68 a0 80 0b 80       	push   $0x800b80a0
8010054c:	68 00 80 0b 80       	push   $0x800b8000
80100551:	e8 5a 4c 00 00       	call   801051b0 <memmove>
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 a5 4b 00 00       	call   80105110 <memset>
    outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
        panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 25 7f 10 80       	push   $0x80107f25
8010057e:	e8 fd fd ff ff       	call   80100380 <panic>
80100583:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010058a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100590 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100590:	55                   	push   %ebp
80100591:	89 e5                	mov    %esp,%ebp
80100593:	57                   	push   %edi
80100594:	56                   	push   %esi
80100595:	53                   	push   %ebx
80100596:	83 ec 18             	sub    $0x18,%esp
    int i;

    iunlock(ip);
80100599:	ff 75 08             	pushl  0x8(%ebp)
{
8010059c:	8b 75 10             	mov    0x10(%ebp),%esi
    iunlock(ip);
8010059f:	e8 7c 17 00 00       	call   80101d20 <iunlock>
    acquire(&cons.lock);
801005a4:	c7 04 24 20 ff 10 80 	movl   $0x8010ff20,(%esp)
801005ab:	e8 a0 4a 00 00       	call   80105050 <acquire>
    for(i = 0; i < n; i++)
801005b0:	83 c4 10             	add    $0x10,%esp
801005b3:	85 f6                	test   %esi,%esi
801005b5:	7e 25                	jle    801005dc <consolewrite+0x4c>
801005b7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801005ba:	8d 3c 33             	lea    (%ebx,%esi,1),%edi
    if(panicked){
801005bd:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
        consputc(buf[i] & 0xff);
801005c3:	0f b6 03             	movzbl (%ebx),%eax
    if(panicked){
801005c6:	85 d2                	test   %edx,%edx
801005c8:	74 06                	je     801005d0 <consolewrite+0x40>
  asm volatile("cli");
801005ca:	fa                   	cli    
        for(;;)
801005cb:	eb fe                	jmp    801005cb <consolewrite+0x3b>
801005cd:	8d 76 00             	lea    0x0(%esi),%esi
801005d0:	e8 2b fe ff ff       	call   80100400 <consputc.part.0>
    for(i = 0; i < n; i++)
801005d5:	83 c3 01             	add    $0x1,%ebx
801005d8:	39 df                	cmp    %ebx,%edi
801005da:	75 e1                	jne    801005bd <consolewrite+0x2d>
    release(&cons.lock);
801005dc:	83 ec 0c             	sub    $0xc,%esp
801005df:	68 20 ff 10 80       	push   $0x8010ff20
801005e4:	e8 07 4a 00 00       	call   80104ff0 <release>
    ilock(ip);
801005e9:	58                   	pop    %eax
801005ea:	ff 75 08             	pushl  0x8(%ebp)
801005ed:	e8 4e 16 00 00       	call   80101c40 <ilock>

    return n;
}
801005f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005f5:	89 f0                	mov    %esi,%eax
801005f7:	5b                   	pop    %ebx
801005f8:	5e                   	pop    %esi
801005f9:	5f                   	pop    %edi
801005fa:	5d                   	pop    %ebp
801005fb:	c3                   	ret    
801005fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100600 <printint>:
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 2c             	sub    $0x2c,%esp
80100609:	89 55 d4             	mov    %edx,-0x2c(%ebp)
8010060c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    if(sign && (sign = xx < 0))
8010060f:	85 c9                	test   %ecx,%ecx
80100611:	74 04                	je     80100617 <printint+0x17>
80100613:	85 c0                	test   %eax,%eax
80100615:	78 6d                	js     80100684 <printint+0x84>
        x = xx;
80100617:	c7 45 d0 00 00 00 00 	movl   $0x0,-0x30(%ebp)
8010061e:	89 c1                	mov    %eax,%ecx
    i = 0;
80100620:	31 db                	xor    %ebx,%ebx
80100622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        buf[i++] = digits[x % base];
80100628:	89 c8                	mov    %ecx,%eax
8010062a:	31 d2                	xor    %edx,%edx
8010062c:	89 de                	mov    %ebx,%esi
8010062e:	89 cf                	mov    %ecx,%edi
80100630:	f7 75 d4             	divl   -0x2c(%ebp)
80100633:	8d 5b 01             	lea    0x1(%ebx),%ebx
80100636:	0f b6 92 a8 7f 10 80 	movzbl -0x7fef8058(%edx),%edx
    }while((x /= base) != 0);
8010063d:	89 c1                	mov    %eax,%ecx
        buf[i++] = digits[x % base];
8010063f:	88 54 1d d7          	mov    %dl,-0x29(%ebp,%ebx,1)
    }while((x /= base) != 0);
80100643:	3b 7d d4             	cmp    -0x2c(%ebp),%edi
80100646:	73 e0                	jae    80100628 <printint+0x28>
    if(sign)
80100648:	8b 4d d0             	mov    -0x30(%ebp),%ecx
8010064b:	85 c9                	test   %ecx,%ecx
8010064d:	74 0c                	je     8010065b <printint+0x5b>
        buf[i++] = '-';
8010064f:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
        buf[i++] = digits[x % base];
80100654:	89 de                	mov    %ebx,%esi
        buf[i++] = '-';
80100656:	ba 2d 00 00 00       	mov    $0x2d,%edx
    while(--i >= 0)
8010065b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
8010065f:	0f be c2             	movsbl %dl,%eax
    if(panicked){
80100662:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100668:	85 d2                	test   %edx,%edx
8010066a:	74 04                	je     80100670 <printint+0x70>
8010066c:	fa                   	cli    
        for(;;)
8010066d:	eb fe                	jmp    8010066d <printint+0x6d>
8010066f:	90                   	nop
80100670:	e8 8b fd ff ff       	call   80100400 <consputc.part.0>
    while(--i >= 0)
80100675:	8d 45 d7             	lea    -0x29(%ebp),%eax
80100678:	39 c3                	cmp    %eax,%ebx
8010067a:	74 0e                	je     8010068a <printint+0x8a>
        consputc(buf[i]);
8010067c:	0f be 03             	movsbl (%ebx),%eax
8010067f:	83 eb 01             	sub    $0x1,%ebx
80100682:	eb de                	jmp    80100662 <printint+0x62>
        x = -xx;
80100684:	f7 d8                	neg    %eax
80100686:	89 c1                	mov    %eax,%ecx
80100688:	eb 96                	jmp    80100620 <printint+0x20>
}
8010068a:	83 c4 2c             	add    $0x2c,%esp
8010068d:	5b                   	pop    %ebx
8010068e:	5e                   	pop    %esi
8010068f:	5f                   	pop    %edi
80100690:	5d                   	pop    %ebp
80100691:	c3                   	ret    
80100692:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100699:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801006a0 <cprintf>:
{
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	83 ec 1c             	sub    $0x1c,%esp
    locking = cons.locking;
801006a9:	a1 54 ff 10 80       	mov    0x8010ff54,%eax
801006ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(locking)
801006b1:	85 c0                	test   %eax,%eax
801006b3:	0f 85 27 01 00 00    	jne    801007e0 <cprintf+0x140>
    if (fmt == 0)
801006b9:	8b 75 08             	mov    0x8(%ebp),%esi
801006bc:	85 f6                	test   %esi,%esi
801006be:	0f 84 ac 01 00 00    	je     80100870 <cprintf+0x1d0>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006c4:	0f b6 06             	movzbl (%esi),%eax
    argp = (uint*)(void*)(&fmt + 1);
801006c7:	8d 7d 0c             	lea    0xc(%ebp),%edi
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ca:	31 db                	xor    %ebx,%ebx
801006cc:	85 c0                	test   %eax,%eax
801006ce:	74 56                	je     80100726 <cprintf+0x86>
        if(c != '%'){
801006d0:	83 f8 25             	cmp    $0x25,%eax
801006d3:	0f 85 cf 00 00 00    	jne    801007a8 <cprintf+0x108>
        c = fmt[++i] & 0xff;
801006d9:	83 c3 01             	add    $0x1,%ebx
801006dc:	0f b6 14 1e          	movzbl (%esi,%ebx,1),%edx
        if(c == 0)
801006e0:	85 d2                	test   %edx,%edx
801006e2:	74 42                	je     80100726 <cprintf+0x86>
        switch(c){
801006e4:	83 fa 70             	cmp    $0x70,%edx
801006e7:	0f 84 90 00 00 00    	je     8010077d <cprintf+0xdd>
801006ed:	7f 51                	jg     80100740 <cprintf+0xa0>
801006ef:	83 fa 25             	cmp    $0x25,%edx
801006f2:	0f 84 c0 00 00 00    	je     801007b8 <cprintf+0x118>
801006f8:	83 fa 64             	cmp    $0x64,%edx
801006fb:	0f 85 f4 00 00 00    	jne    801007f5 <cprintf+0x155>
                printint(*argp++, 10, 1);
80100701:	8d 47 04             	lea    0x4(%edi),%eax
80100704:	b9 01 00 00 00       	mov    $0x1,%ecx
80100709:	ba 0a 00 00 00       	mov    $0xa,%edx
8010070e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100711:	8b 07                	mov    (%edi),%eax
80100713:	e8 e8 fe ff ff       	call   80100600 <printint>
80100718:	8b 7d e0             	mov    -0x20(%ebp),%edi
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010071b:	83 c3 01             	add    $0x1,%ebx
8010071e:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100722:	85 c0                	test   %eax,%eax
80100724:	75 aa                	jne    801006d0 <cprintf+0x30>
    if(locking)
80100726:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100729:	85 c0                	test   %eax,%eax
8010072b:	0f 85 22 01 00 00    	jne    80100853 <cprintf+0x1b3>
}
80100731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100734:	5b                   	pop    %ebx
80100735:	5e                   	pop    %esi
80100736:	5f                   	pop    %edi
80100737:	5d                   	pop    %ebp
80100738:	c3                   	ret    
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        switch(c){
80100740:	83 fa 73             	cmp    $0x73,%edx
80100743:	75 33                	jne    80100778 <cprintf+0xd8>
                if((s = (char*)*argp++) == 0)
80100745:	8d 47 04             	lea    0x4(%edi),%eax
80100748:	8b 3f                	mov    (%edi),%edi
8010074a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010074d:	85 ff                	test   %edi,%edi
8010074f:	0f 84 e3 00 00 00    	je     80100838 <cprintf+0x198>
                for(; *s; s++)
80100755:	0f be 07             	movsbl (%edi),%eax
80100758:	84 c0                	test   %al,%al
8010075a:	0f 84 08 01 00 00    	je     80100868 <cprintf+0x1c8>
    if(panicked){
80100760:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100766:	85 d2                	test   %edx,%edx
80100768:	0f 84 b2 00 00 00    	je     80100820 <cprintf+0x180>
8010076e:	fa                   	cli    
        for(;;)
8010076f:	eb fe                	jmp    8010076f <cprintf+0xcf>
80100771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        switch(c){
80100778:	83 fa 78             	cmp    $0x78,%edx
8010077b:	75 78                	jne    801007f5 <cprintf+0x155>
                printint(*argp++, 16, 0);
8010077d:	8d 47 04             	lea    0x4(%edi),%eax
80100780:	31 c9                	xor    %ecx,%ecx
80100782:	ba 10 00 00 00       	mov    $0x10,%edx
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100787:	83 c3 01             	add    $0x1,%ebx
                printint(*argp++, 16, 0);
8010078a:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010078d:	8b 07                	mov    (%edi),%eax
8010078f:	e8 6c fe ff ff       	call   80100600 <printint>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100794:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
                printint(*argp++, 16, 0);
80100798:	8b 7d e0             	mov    -0x20(%ebp),%edi
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010079b:	85 c0                	test   %eax,%eax
8010079d:	0f 85 2d ff ff ff    	jne    801006d0 <cprintf+0x30>
801007a3:	eb 81                	jmp    80100726 <cprintf+0x86>
801007a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(panicked){
801007a8:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007ae:	85 c9                	test   %ecx,%ecx
801007b0:	74 14                	je     801007c6 <cprintf+0x126>
801007b2:	fa                   	cli    
        for(;;)
801007b3:	eb fe                	jmp    801007b3 <cprintf+0x113>
801007b5:	8d 76 00             	lea    0x0(%esi),%esi
    if(panicked){
801007b8:	a1 58 ff 10 80       	mov    0x8010ff58,%eax
801007bd:	85 c0                	test   %eax,%eax
801007bf:	75 6c                	jne    8010082d <cprintf+0x18d>
801007c1:	b8 25 00 00 00       	mov    $0x25,%eax
801007c6:	e8 35 fc ff ff       	call   80100400 <consputc.part.0>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007cb:	83 c3 01             	add    $0x1,%ebx
801007ce:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007d2:	85 c0                	test   %eax,%eax
801007d4:	0f 85 f6 fe ff ff    	jne    801006d0 <cprintf+0x30>
801007da:	e9 47 ff ff ff       	jmp    80100726 <cprintf+0x86>
801007df:	90                   	nop
        acquire(&cons.lock);
801007e0:	83 ec 0c             	sub    $0xc,%esp
801007e3:	68 20 ff 10 80       	push   $0x8010ff20
801007e8:	e8 63 48 00 00       	call   80105050 <acquire>
801007ed:	83 c4 10             	add    $0x10,%esp
801007f0:	e9 c4 fe ff ff       	jmp    801006b9 <cprintf+0x19>
    if(panicked){
801007f5:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
801007fb:	85 c9                	test   %ecx,%ecx
801007fd:	75 31                	jne    80100830 <cprintf+0x190>
801007ff:	b8 25 00 00 00       	mov    $0x25,%eax
80100804:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100807:	e8 f4 fb ff ff       	call   80100400 <consputc.part.0>
8010080c:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
80100812:	85 d2                	test   %edx,%edx
80100814:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100817:	74 2e                	je     80100847 <cprintf+0x1a7>
80100819:	fa                   	cli    
        for(;;)
8010081a:	eb fe                	jmp    8010081a <cprintf+0x17a>
8010081c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100820:	e8 db fb ff ff       	call   80100400 <consputc.part.0>
                for(; *s; s++)
80100825:	83 c7 01             	add    $0x1,%edi
80100828:	e9 28 ff ff ff       	jmp    80100755 <cprintf+0xb5>
8010082d:	fa                   	cli    
        for(;;)
8010082e:	eb fe                	jmp    8010082e <cprintf+0x18e>
80100830:	fa                   	cli    
80100831:	eb fe                	jmp    80100831 <cprintf+0x191>
80100833:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100837:	90                   	nop
                    s = "(null)";
80100838:	bf 38 7f 10 80       	mov    $0x80107f38,%edi
                for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
        release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 90 47 00 00       	call   80104ff0 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
                if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
        panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 3f 7f 10 80       	push   $0x80107f3f
80100878:	e8 03 fb ff ff       	call   80100380 <panic>
8010087d:	8d 76 00             	lea    0x0(%esi),%esi

80100880 <get_cursor_pos>:
int get_cursor_pos(){
80100880:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100881:	b8 0e 00 00 00       	mov    $0xe,%eax
80100886:	89 e5                	mov    %esp,%ebp
80100888:	56                   	push   %esi
80100889:	be d4 03 00 00       	mov    $0x3d4,%esi
8010088e:	53                   	push   %ebx
8010088f:	89 f2                	mov    %esi,%edx
80100891:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100892:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100897:	89 da                	mov    %ebx,%edx
80100899:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
8010089a:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010089d:	89 f2                	mov    %esi,%edx
8010089f:	b8 0f 00 00 00       	mov    $0xf,%eax
801008a4:	c1 e1 08             	shl    $0x8,%ecx
801008a7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008a8:	89 da                	mov    %ebx,%edx
801008aa:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
801008ab:	0f b6 c0             	movzbl %al,%eax
}
801008ae:	5b                   	pop    %ebx
801008af:	5e                   	pop    %esi
    pos |= inb(CRTPORT+1);
801008b0:	09 c8                	or     %ecx,%eax
}
801008b2:	5d                   	pop    %ebp
801008b3:	c3                   	ret    
801008b4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801008bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801008bf:	90                   	nop

801008c0 <swap_last_two_elements>:
void swap_last_two_elements(){
801008c0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008c1:	b8 0e 00 00 00       	mov    $0xe,%eax
801008c6:	89 e5                	mov    %esp,%ebp
801008c8:	57                   	push   %edi
801008c9:	56                   	push   %esi
801008ca:	be d4 03 00 00       	mov    $0x3d4,%esi
801008cf:	53                   	push   %ebx
801008d0:	89 f2                	mov    %esi,%edx
801008d2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008d3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801008d8:	89 da                	mov    %ebx,%edx
801008da:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
801008db:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008de:	89 f2                	mov    %esi,%edx
801008e0:	b8 0f 00 00 00       	mov    $0xf,%eax
801008e5:	c1 e1 08             	shl    $0x8,%ecx
801008e8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008e9:	89 da                	mov    %ebx,%edx
801008eb:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
801008ec:	0f b6 c0             	movzbl %al,%eax
801008ef:	09 c1                	or     %eax,%ecx
    if(crt[pos - 3] == ('$' | 0x0700) || crt[pos - 2] == ('$' | 0x0700)) //there arent at least two elements
801008f1:	8d 44 09 fa          	lea    -0x6(%ecx,%ecx,1),%eax
801008f5:	66 81 b8 00 80 0b 80 	cmpw   $0x724,-0x7ff48000(%eax)
801008fc:	24 07 
801008fe:	74 42                	je     80100942 <swap_last_two_elements+0x82>
80100900:	0f b7 90 02 80 0b 80 	movzwl -0x7ff47ffe(%eax),%edx
80100907:	66 81 fa 24 07       	cmp    $0x724,%dx
8010090c:	74 34                	je     80100942 <swap_last_two_elements+0x82>
    ushort temp = crt[pos - 1];
8010090e:	0f b7 b8 04 80 0b 80 	movzwl -0x7ff47ffc(%eax),%edi
    crt[pos - 1] = crt[pos - 2];
80100915:	66 89 90 04 80 0b 80 	mov    %dx,-0x7ff47ffc(%eax)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010091c:	89 f2                	mov    %esi,%edx
    ushort temp = crt[pos - 1];
8010091e:	66 89 b8 02 80 0b 80 	mov    %di,-0x7ff47ffe(%eax)
80100925:	b8 0e 00 00 00       	mov    $0xe,%eax
8010092a:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
8010092b:	89 cf                	mov    %ecx,%edi
8010092d:	89 da                	mov    %ebx,%edx
8010092f:	c1 ff 08             	sar    $0x8,%edi
80100932:	89 f8                	mov    %edi,%eax
80100934:	ee                   	out    %al,(%dx)
80100935:	b8 0f 00 00 00       	mov    $0xf,%eax
8010093a:	89 f2                	mov    %esi,%edx
8010093c:	ee                   	out    %al,(%dx)
8010093d:	89 c8                	mov    %ecx,%eax
8010093f:	89 da                	mov    %ebx,%edx
80100941:	ee                   	out    %al,(%dx)
}
80100942:	5b                   	pop    %ebx
80100943:	5e                   	pop    %esi
80100944:	5f                   	pop    %edi
80100945:	5d                   	pop    %ebp
80100946:	c3                   	ret    
80100947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010094e:	66 90                	xchg   %ax,%ax

80100950 <upper_case>:
void upper_case(){
80100950:	55                   	push   %ebp
80100951:	b8 0e 00 00 00       	mov    $0xe,%eax
80100956:	89 e5                	mov    %esp,%ebp
80100958:	56                   	push   %esi
80100959:	be d4 03 00 00       	mov    $0x3d4,%esi
8010095e:	53                   	push   %ebx
8010095f:	89 f2                	mov    %esi,%edx
80100961:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100962:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100967:	89 da                	mov    %ebx,%edx
80100969:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
8010096a:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010096d:	89 f2                	mov    %esi,%edx
8010096f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100974:	c1 e1 08             	shl    $0x8,%ecx
80100977:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100978:	89 da                	mov    %ebx,%edx
8010097a:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
8010097b:	0f b6 d8             	movzbl %al,%ebx
8010097e:	09 cb                	or     %ecx,%ebx
    for(i = pos + 1; crt[i] != (' ' | 0x0700) && crt[i] != ('\n' | 0x0700); i++)
80100980:	8d 44 1b 02          	lea    0x2(%ebx,%ebx,1),%eax
80100984:	0f b7 90 00 80 0b 80 	movzwl -0x7ff48000(%eax),%edx
8010098b:	66 81 fa 20 07       	cmp    $0x720,%dx
80100990:	74 43                	je     801009d5 <upper_case+0x85>
80100992:	66 81 fa 0a 07       	cmp    $0x70a,%dx
80100997:	74 3c                	je     801009d5 <upper_case+0x85>
80100999:	8d b0 00 80 0b 80    	lea    -0x7ff48000(%eax),%esi
8010099f:	29 f0                	sub    %esi,%eax
801009a1:	2d fe 7f f4 7f       	sub    $0x7ff47ffe,%eax
801009a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801009ad:	8d 76 00             	lea    0x0(%esi),%esi
        if(crt[i] >= ('a' | 0x0700) && crt[i] <= ('z' | 0x0700))
801009b0:	8d 8a 9f f8 ff ff    	lea    -0x761(%edx),%ecx
801009b6:	66 83 f9 19          	cmp    $0x19,%cx
801009ba:	77 06                	ja     801009c2 <upper_case+0x72>
            crt[i] -= 32;
801009bc:	83 ea 20             	sub    $0x20,%edx
801009bf:	66 89 16             	mov    %dx,(%esi)
    for(i = pos + 1; crt[i] != (' ' | 0x0700) && crt[i] != ('\n' | 0x0700); i++)
801009c2:	01 c6                	add    %eax,%esi
801009c4:	0f b7 16             	movzwl (%esi),%edx
801009c7:	66 81 fa 20 07       	cmp    $0x720,%dx
801009cc:	74 07                	je     801009d5 <upper_case+0x85>
801009ce:	66 81 fa 0a 07       	cmp    $0x70a,%dx
801009d3:	75 db                	jne    801009b0 <upper_case+0x60>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009d5:	be d4 03 00 00       	mov    $0x3d4,%esi
801009da:	b8 0e 00 00 00       	mov    $0xe,%eax
801009df:	89 f2                	mov    %esi,%edx
801009e1:	ee                   	out    %al,(%dx)
801009e2:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
    outb(CRTPORT+1, pos>>8);
801009e7:	89 d8                	mov    %ebx,%eax
801009e9:	c1 f8 08             	sar    $0x8,%eax
801009ec:	89 ca                	mov    %ecx,%edx
801009ee:	ee                   	out    %al,(%dx)
801009ef:	b8 0f 00 00 00       	mov    $0xf,%eax
801009f4:	89 f2                	mov    %esi,%edx
801009f6:	ee                   	out    %al,(%dx)
801009f7:	89 d8                	mov    %ebx,%eax
801009f9:	89 ca                	mov    %ecx,%edx
801009fb:	ee                   	out    %al,(%dx)
}
801009fc:	5b                   	pop    %ebx
801009fd:	5e                   	pop    %esi
801009fe:	5d                   	pop    %ebp
801009ff:	c3                   	ret    

80100a00 <move_left>:
void move_left(){
80100a00:	55                   	push   %ebp
80100a01:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a06:	89 e5                	mov    %esp,%ebp
80100a08:	57                   	push   %edi
80100a09:	56                   	push   %esi
80100a0a:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a0f:	53                   	push   %ebx
80100a10:	89 f2                	mov    %esi,%edx
80100a12:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a13:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a18:	89 da                	mov    %ebx,%edx
80100a1a:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100a1b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a1e:	bf 0f 00 00 00       	mov    $0xf,%edi
80100a23:	89 f2                	mov    %esi,%edx
80100a25:	89 c1                	mov    %eax,%ecx
80100a27:	89 f8                	mov    %edi,%eax
80100a29:	c1 e1 08             	shl    $0x8,%ecx
80100a2c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a2d:	89 da                	mov    %ebx,%edx
80100a2f:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100a30:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a33:	89 f2                	mov    %esi,%edx
80100a35:	09 c1                	or     %eax,%ecx
80100a37:	89 f8                	mov    %edi,%eax
    pos--;
80100a39:	83 e9 01             	sub    $0x1,%ecx
80100a3c:	ee                   	out    %al,(%dx)
80100a3d:	89 c8                	mov    %ecx,%eax
80100a3f:	89 da                	mov    %ebx,%edx
80100a41:	ee                   	out    %al,(%dx)
80100a42:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a47:	89 f2                	mov    %esi,%edx
80100a49:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100a4a:	89 c8                	mov    %ecx,%eax
80100a4c:	89 da                	mov    %ebx,%edx
80100a4e:	c1 f8 08             	sar    $0x8,%eax
80100a51:	ee                   	out    %al,(%dx)
}
80100a52:	5b                   	pop    %ebx
80100a53:	5e                   	pop    %esi
80100a54:	5f                   	pop    %edi
80100a55:	5d                   	pop    %ebp
80100a56:	c3                   	ret    
80100a57:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100a5e:	66 90                	xchg   %ax,%ax

80100a60 <move_right>:
void move_right(){
80100a60:	55                   	push   %ebp
80100a61:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a66:	89 e5                	mov    %esp,%ebp
80100a68:	56                   	push   %esi
80100a69:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a6e:	53                   	push   %ebx
80100a6f:	89 f2                	mov    %esi,%edx
80100a71:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a72:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100a77:	89 ca                	mov    %ecx,%edx
80100a79:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100a7a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a7d:	89 f2                	mov    %esi,%edx
80100a7f:	b8 0f 00 00 00       	mov    $0xf,%eax
80100a84:	c1 e3 08             	shl    $0x8,%ebx
80100a87:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a88:	89 ca                	mov    %ecx,%edx
80100a8a:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100a8b:	0f b6 c8             	movzbl %al,%ecx
80100a8e:	09 d9                	or     %ebx,%ecx
    if(crt[pos] != ('\n' | 0x0700)) pos++;
80100a90:	66 81 bc 09 00 80 0b 	cmpw   $0x70a,-0x7ff48000(%ecx,%ecx,1)
80100a97:	80 0a 07 
80100a9a:	74 03                	je     80100a9f <move_right+0x3f>
80100a9c:	83 c1 01             	add    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a9f:	be d4 03 00 00       	mov    $0x3d4,%esi
80100aa4:	b8 0e 00 00 00       	mov    $0xe,%eax
80100aa9:	89 f2                	mov    %esi,%edx
80100aab:	ee                   	out    %al,(%dx)
80100aac:	bb d5 03 00 00       	mov    $0x3d5,%ebx
    outb(CRTPORT+1, pos>>8);
80100ab1:	89 c8                	mov    %ecx,%eax
80100ab3:	c1 f8 08             	sar    $0x8,%eax
80100ab6:	89 da                	mov    %ebx,%edx
80100ab8:	ee                   	out    %al,(%dx)
80100ab9:	b8 0f 00 00 00       	mov    $0xf,%eax
80100abe:	89 f2                	mov    %esi,%edx
80100ac0:	ee                   	out    %al,(%dx)
80100ac1:	89 c8                	mov    %ecx,%eax
80100ac3:	89 da                	mov    %ebx,%edx
80100ac5:	ee                   	out    %al,(%dx)
}
80100ac6:	5b                   	pop    %ebx
80100ac7:	5e                   	pop    %esi
80100ac8:	5d                   	pop    %ebp
80100ac9:	c3                   	ret    
80100aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ad0 <insert_at_the_given_pos>:
void insert_at_the_given_pos(int c, int new_pos){
80100ad0:	55                   	push   %ebp
80100ad1:	b8 0e 00 00 00       	mov    $0xe,%eax
80100ad6:	89 e5                	mov    %esp,%ebp
80100ad8:	57                   	push   %edi
80100ad9:	56                   	push   %esi
80100ada:	be d4 03 00 00       	mov    $0x3d4,%esi
80100adf:	53                   	push   %ebx
80100ae0:	89 f2                	mov    %esi,%edx
80100ae2:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ae3:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100ae8:	89 da                	mov    %ebx,%edx
80100aea:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100aeb:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100aee:	89 f2                	mov    %esi,%edx
80100af0:	b8 0f 00 00 00       	mov    $0xf,%eax
80100af5:	c1 e1 08             	shl    $0x8,%ecx
80100af8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100af9:	89 da                	mov    %ebx,%edx
80100afb:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100afc:	0f b6 d8             	movzbl %al,%ebx
    for(int i = pos + new_pos; i >= pos; i--){
80100aff:	8b 45 0c             	mov    0xc(%ebp),%eax
    pos |= inb(CRTPORT+1);
80100b02:	09 cb                	or     %ecx,%ebx
    for(int i = pos + new_pos; i >= pos; i--){
80100b04:	01 d8                	add    %ebx,%eax
80100b06:	39 d8                	cmp    %ebx,%eax
80100b08:	7c 24                	jl     80100b2e <insert_at_the_given_pos+0x5e>
80100b0a:	8d 94 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%edx
80100b11:	8d 84 1b fe 7f 0b 80 	lea    -0x7ff48002(%ebx,%ebx,1),%eax
80100b18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100b1f:	90                   	nop
        crt[i+1] = crt[i];
80100b20:	0f b7 0a             	movzwl (%edx),%ecx
    for(int i = pos + new_pos; i >= pos; i--){
80100b23:	83 ea 02             	sub    $0x2,%edx
        crt[i+1] = crt[i];
80100b26:	66 89 4a 04          	mov    %cx,0x4(%edx)
    for(int i = pos + new_pos; i >= pos; i--){
80100b2a:	39 d0                	cmp    %edx,%eax
80100b2c:	75 f2                	jne    80100b20 <insert_at_the_given_pos+0x50>
    crt[pos+1] = (c&0xff) | 0x0700;
80100b2e:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80100b32:	8d 4b 01             	lea    0x1(%ebx),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b35:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b3a:	89 fa                	mov    %edi,%edx
80100b3c:	80 cc 07             	or     $0x7,%ah
80100b3f:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100b46:	80 
80100b47:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b4c:	ee                   	out    %al,(%dx)
80100b4d:	be d5 03 00 00       	mov    $0x3d5,%esi
    outb(CRTPORT+1, (pos+1)>>8);
80100b52:	89 c8                	mov    %ecx,%eax
80100b54:	c1 f8 08             	sar    $0x8,%eax
80100b57:	89 f2                	mov    %esi,%edx
80100b59:	ee                   	out    %al,(%dx)
80100b5a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b5f:	89 fa                	mov    %edi,%edx
80100b61:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos+1);
80100b62:	8d 43 01             	lea    0x1(%ebx),%eax
80100b65:	89 f2                	mov    %esi,%edx
80100b67:	ee                   	out    %al,(%dx)
}
80100b68:	5b                   	pop    %ebx
80100b69:	5e                   	pop    %esi
80100b6a:	5f                   	pop    %edi
80100b6b:	5d                   	pop    %ebp
80100b6c:	c3                   	ret    
80100b6d:	8d 76 00             	lea    0x0(%esi),%esi

80100b70 <consoleintr>:
{
80100b70:	55                   	push   %ebp
80100b71:	89 e5                	mov    %esp,%ebp
80100b73:	57                   	push   %edi
80100b74:	56                   	push   %esi
80100b75:	53                   	push   %ebx
80100b76:	83 ec 38             	sub    $0x38,%esp
80100b79:	8b 45 08             	mov    0x8(%ebp),%eax
    acquire(&cons.lock);
80100b7c:	68 20 ff 10 80       	push   $0x8010ff20
{
80100b81:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    acquire(&cons.lock);
80100b84:	e8 c7 44 00 00       	call   80105050 <acquire>
    int c, doprocdump = 0;
80100b89:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    while((c = getc()) >= 0){
80100b90:	83 c4 10             	add    $0x10,%esp
80100b93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100b97:	90                   	nop
80100b98:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100b9b:	ff d0                	call   *%eax
80100b9d:	85 c0                	test   %eax,%eax
80100b9f:	78 7f                	js     80100c20 <consoleintr+0xb0>
        switch(c){
80100ba1:	83 f8 15             	cmp    $0x15,%eax
80100ba4:	7f 52                	jg     80100bf8 <consoleintr+0x88>
80100ba6:	85 c0                	test   %eax,%eax
80100ba8:	74 ee                	je     80100b98 <consoleintr+0x28>
80100baa:	83 f8 15             	cmp    $0x15,%eax
80100bad:	0f 87 4c 02 00 00    	ja     80100dff <consoleintr+0x28f>
80100bb3:	ff 24 85 50 7f 10 80 	jmp    *-0x7fef80b0(,%eax,4)
80100bba:	b8 00 01 00 00       	mov    $0x100,%eax
80100bbf:	e8 3c f8 ff ff       	call   80100400 <consputc.part.0>
                while(input.e != input.w &&
80100bc4:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100bc9:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100bcf:	74 c7                	je     80100b98 <consoleintr+0x28>
                      input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100bd1:	83 e8 01             	sub    $0x1,%eax
80100bd4:	89 c2                	mov    %eax,%edx
80100bd6:	83 e2 7f             	and    $0x7f,%edx
                while(input.e != input.w &&
80100bd9:	80 ba 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%edx)
80100be0:	74 b6                	je     80100b98 <consoleintr+0x28>
    if(panicked){
80100be2:	8b 35 58 ff 10 80    	mov    0x8010ff58,%esi
                    input.e--;
80100be8:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
    if(panicked){
80100bed:	85 f6                	test   %esi,%esi
80100bef:	74 c9                	je     80100bba <consoleintr+0x4a>
  asm volatile("cli");
80100bf1:	fa                   	cli    
        for(;;)
80100bf2:	eb fe                	jmp    80100bf2 <consoleintr+0x82>
80100bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        switch(c){
80100bf8:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100bfd:	0f 84 ad 01 00 00    	je     80100db0 <consoleintr+0x240>
80100c03:	3d e5 00 00 00       	cmp    $0xe5,%eax
80100c08:	75 3e                	jne    80100c48 <consoleintr+0xd8>
                move_right();
80100c0a:	e8 51 fe ff ff       	call   80100a60 <move_right>
    while((c = getc()) >= 0){
80100c0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100c12:	ff d0                	call   *%eax
80100c14:	85 c0                	test   %eax,%eax
80100c16:	79 89                	jns    80100ba1 <consoleintr+0x31>
80100c18:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100c1f:	90                   	nop
    release(&cons.lock);
80100c20:	83 ec 0c             	sub    $0xc,%esp
80100c23:	68 20 ff 10 80       	push   $0x8010ff20
80100c28:	e8 c3 43 00 00       	call   80104ff0 <release>
    if(doprocdump) {
80100c2d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100c30:	83 c4 10             	add    $0x10,%esp
80100c33:	85 c0                	test   %eax,%eax
80100c35:	0f 85 5a 02 00 00    	jne    80100e95 <consoleintr+0x325>
}
80100c3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100c3e:	5b                   	pop    %ebx
80100c3f:	5e                   	pop    %esi
80100c40:	5f                   	pop    %edi
80100c41:	5d                   	pop    %ebp
80100c42:	c3                   	ret    
80100c43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c47:	90                   	nop
        switch(c){
80100c48:	83 f8 7f             	cmp    $0x7f,%eax
80100c4b:	0f 85 b6 01 00 00    	jne    80100e07 <consoleintr+0x297>
                if(input.e != input.w){
80100c51:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
80100c56:	3b 05 04 ff 10 80    	cmp    0x8010ff04,%eax
80100c5c:	0f 84 36 ff ff ff    	je     80100b98 <consoleintr+0x28>
    if(panicked){
80100c62:	8b 1d 58 ff 10 80    	mov    0x8010ff58,%ebx
                    input.e--;
80100c68:	83 e8 01             	sub    $0x1,%eax
80100c6b:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
    if(panicked){
80100c70:	85 db                	test   %ebx,%ebx
80100c72:	0f 84 03 02 00 00    	je     80100e7b <consoleintr+0x30b>
80100c78:	fa                   	cli    
        for(;;)
80100c79:	eb fe                	jmp    80100c79 <consoleintr+0x109>
80100c7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100c7f:	90                   	nop
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100c80:	8b 35 0c ff 10 80    	mov    0x8010ff0c,%esi
80100c86:	a1 04 ff 10 80       	mov    0x8010ff04,%eax
80100c8b:	31 d2                	xor    %edx,%edx
80100c8d:	8b 3d 08 ff 10 80    	mov    0x8010ff08,%edi
80100c93:	89 75 e0             	mov    %esi,-0x20(%ebp)
80100c96:	89 75 d0             	mov    %esi,-0x30(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c99:	be d4 03 00 00       	mov    $0x3d4,%esi
80100c9e:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100ca1:	39 f8                	cmp    %edi,%eax
80100ca3:	75 66                	jne    80100d0b <consoleintr+0x19b>
80100ca5:	e9 82 00 00 00       	jmp    80100d2c <consoleintr+0x1bc>
80100caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                    number_of_left_moves++;
80100cb0:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80100cb4:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cb9:	89 f2                	mov    %esi,%edx
80100cbb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cbc:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100cc1:	89 da                	mov    %ebx,%edx
80100cc3:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100cc4:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cc7:	89 f2                	mov    %esi,%edx
80100cc9:	b8 0f 00 00 00       	mov    $0xf,%eax
80100cce:	c1 e1 08             	shl    $0x8,%ecx
80100cd1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100cd2:	89 da                	mov    %ebx,%edx
80100cd4:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100cd5:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cd8:	89 f2                	mov    %esi,%edx
80100cda:	09 c1                	or     %eax,%ecx
80100cdc:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos--;
80100ce1:	83 e9 01             	sub    $0x1,%ecx
80100ce4:	ee                   	out    %al,(%dx)
80100ce5:	89 c8                	mov    %ecx,%eax
80100ce7:	89 da                	mov    %ebx,%edx
80100ce9:	ee                   	out    %al,(%dx)
80100cea:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cef:	89 f2                	mov    %esi,%edx
80100cf1:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100cf2:	89 c8                	mov    %ecx,%eax
80100cf4:	89 da                	mov    %ebx,%edx
80100cf6:	c1 f8 08             	sar    $0x8,%eax
80100cf9:	ee                   	out    %al,(%dx)
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100cfa:	ba 01 00 00 00       	mov    $0x1,%edx
80100cff:	3b 7d dc             	cmp    -0x24(%ebp),%edi
80100d02:	0f 84 68 01 00 00    	je     80100e70 <consoleintr+0x300>
80100d08:	89 7d d8             	mov    %edi,-0x28(%ebp)
80100d0b:	83 ef 01             	sub    $0x1,%edi
80100d0e:	89 f8                	mov    %edi,%eax
80100d10:	83 e0 7f             	and    $0x7f,%eax
80100d13:	80 b8 80 fe 10 80 0a 	cmpb   $0xa,-0x7fef0180(%eax)
80100d1a:	75 94                	jne    80100cb0 <consoleintr+0x140>
80100d1c:	84 d2                	test   %dl,%dl
80100d1e:	0f 84 66 01 00 00    	je     80100e8a <consoleintr+0x31a>
80100d24:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100d27:	a3 08 ff 10 80       	mov    %eax,0x8010ff08
80100d2c:	be d4 03 00 00       	mov    $0x3d4,%esi
80100d31:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d36:	89 f2                	mov    %esi,%edx
80100d38:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d39:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100d3e:	89 da                	mov    %ebx,%edx
80100d40:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d41:	bf 0f 00 00 00       	mov    $0xf,%edi
    pos = inb(CRTPORT+1) << 8;
80100d46:	0f b6 c8             	movzbl %al,%ecx
80100d49:	89 f2                	mov    %esi,%edx
80100d4b:	c1 e1 08             	shl    $0x8,%ecx
80100d4e:	89 f8                	mov    %edi,%eax
80100d50:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d51:	89 da                	mov    %ebx,%edx
80100d53:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100d54:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d57:	89 f2                	mov    %esi,%edx
80100d59:	09 c1                	or     %eax,%ecx
80100d5b:	89 f8                	mov    %edi,%eax
    pos--;
80100d5d:	83 e9 01             	sub    $0x1,%ecx
80100d60:	ee                   	out    %al,(%dx)
80100d61:	89 c8                	mov    %ecx,%eax
80100d63:	89 da                	mov    %ebx,%edx
80100d65:	ee                   	out    %al,(%dx)
80100d66:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d6b:	89 f2                	mov    %esi,%edx
80100d6d:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100d6e:	89 c8                	mov    %ecx,%eax
80100d70:	89 da                	mov    %ebx,%edx
80100d72:	c1 f8 08             	sar    $0x8,%eax
80100d75:	ee                   	out    %al,(%dx)
                number_of_left_moves++;
80100d76:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d79:	83 c0 01             	add    $0x1,%eax
80100d7c:	a3 0c ff 10 80       	mov    %eax,0x8010ff0c
                break;
80100d81:	e9 12 fe ff ff       	jmp    80100b98 <consoleintr+0x28>
                swap_last_two_elements();
80100d86:	e8 35 fb ff ff       	call   801008c0 <swap_last_two_elements>
                break;
80100d8b:	e9 08 fe ff ff       	jmp    80100b98 <consoleintr+0x28>
                upper_case();
80100d90:	e8 bb fb ff ff       	call   80100950 <upper_case>
                break;
80100d95:	e9 fe fd ff ff       	jmp    80100b98 <consoleintr+0x28>
        switch(c){
80100d9a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
80100da1:	e9 f2 fd ff ff       	jmp    80100b98 <consoleintr+0x28>
80100da6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100dad:	8d 76 00             	lea    0x0(%esi),%esi
80100db0:	be d4 03 00 00       	mov    $0x3d4,%esi
80100db5:	b8 0e 00 00 00       	mov    $0xe,%eax
80100dba:	89 f2                	mov    %esi,%edx
80100dbc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100dbd:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100dc2:	89 da                	mov    %ebx,%edx
80100dc4:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100dc5:	bf 0f 00 00 00       	mov    $0xf,%edi
    pos = inb(CRTPORT+1) << 8;
80100dca:	0f b6 c8             	movzbl %al,%ecx
80100dcd:	89 f2                	mov    %esi,%edx
80100dcf:	c1 e1 08             	shl    $0x8,%ecx
80100dd2:	89 f8                	mov    %edi,%eax
80100dd4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100dd5:	89 da                	mov    %ebx,%edx
80100dd7:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100dd8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ddb:	89 f2                	mov    %esi,%edx
80100ddd:	09 c1                	or     %eax,%ecx
80100ddf:	89 f8                	mov    %edi,%eax
    pos--;
80100de1:	83 e9 01             	sub    $0x1,%ecx
80100de4:	ee                   	out    %al,(%dx)
80100de5:	89 c8                	mov    %ecx,%eax
80100de7:	89 da                	mov    %ebx,%edx
80100de9:	ee                   	out    %al,(%dx)
80100dea:	b8 0e 00 00 00       	mov    $0xe,%eax
80100def:	89 f2                	mov    %esi,%edx
80100df1:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100df2:	89 c8                	mov    %ecx,%eax
80100df4:	89 da                	mov    %ebx,%edx
80100df6:	c1 f8 08             	sar    $0x8,%eax
80100df9:	ee                   	out    %al,(%dx)
}
80100dfa:	e9 99 fd ff ff       	jmp    80100b98 <consoleintr+0x28>
                if(c != 0 && input.e-input.r < INPUT_BUF){
80100dff:	85 c0                	test   %eax,%eax
80100e01:	0f 84 91 fd ff ff    	je     80100b98 <consoleintr+0x28>
80100e07:	8b 15 08 ff 10 80    	mov    0x8010ff08,%edx
80100e0d:	8b 0d 00 ff 10 80    	mov    0x8010ff00,%ecx
80100e13:	89 d3                	mov    %edx,%ebx
80100e15:	29 cb                	sub    %ecx,%ebx
80100e17:	83 fb 7f             	cmp    $0x7f,%ebx
80100e1a:	0f 87 78 fd ff ff    	ja     80100b98 <consoleintr+0x28>
                    c = (c == '\r') ? '\n' : c;
80100e20:	83 f8 0d             	cmp    $0xd,%eax
80100e23:	0f 84 9f 00 00 00    	je     80100ec8 <consoleintr+0x358>
                    if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100e29:	83 f8 0a             	cmp    $0xa,%eax
80100e2c:	74 73                	je     80100ea1 <consoleintr+0x331>
80100e2e:	83 f8 04             	cmp    $0x4,%eax
80100e31:	74 6e                	je     80100ea1 <consoleintr+0x331>
80100e33:	83 e9 80             	sub    $0xffffff80,%ecx
80100e36:	39 ca                	cmp    %ecx,%edx
80100e38:	74 67                	je     80100ea1 <consoleintr+0x331>
                        if(number_of_left_moves == 0){
80100e3a:	8b 0d 0c ff 10 80    	mov    0x8010ff0c,%ecx
80100e40:	85 c9                	test   %ecx,%ecx
80100e42:	0f 85 ba 00 00 00    	jne    80100f02 <consoleintr+0x392>
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e48:	8d 4a 01             	lea    0x1(%edx),%ecx
80100e4b:	83 e2 7f             	and    $0x7f,%edx
80100e4e:	88 82 80 fe 10 80    	mov    %al,-0x7fef0180(%edx)
    if(panicked){
80100e54:	8b 15 58 ff 10 80    	mov    0x8010ff58,%edx
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e5a:	89 0d 08 ff 10 80    	mov    %ecx,0x8010ff08
    if(panicked){
80100e60:	85 d2                	test   %edx,%edx
80100e62:	0f 84 ac 00 00 00    	je     80100f14 <consoleintr+0x3a4>
  asm volatile("cli");
80100e68:	fa                   	cli    
        for(;;)
80100e69:	eb fe                	jmp    80100e69 <consoleintr+0x2f9>
80100e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e6f:	90                   	nop
80100e70:	89 3d 08 ff 10 80    	mov    %edi,0x8010ff08
80100e76:	e9 b1 fe ff ff       	jmp    80100d2c <consoleintr+0x1bc>
80100e7b:	b8 00 01 00 00       	mov    $0x100,%eax
80100e80:	e8 7b f5 ff ff       	call   80100400 <consputc.part.0>
80100e85:	e9 0e fd ff ff       	jmp    80100b98 <consoleintr+0x28>
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100e8a:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100e8d:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100e90:	e9 97 fe ff ff       	jmp    80100d2c <consoleintr+0x1bc>
}
80100e95:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e98:	5b                   	pop    %ebx
80100e99:	5e                   	pop    %esi
80100e9a:	5f                   	pop    %edi
80100e9b:	5d                   	pop    %ebp
        procdump();  // now call procdump() wo. cons.lock held
80100e9c:	e9 df 3b 00 00       	jmp    80104a80 <procdump>
                            input.buf[input.e++ % INPUT_BUF] = c;
80100ea1:	89 c1                	mov    %eax,%ecx
                        input.buf[input.e++ % INPUT_BUF] = c;
80100ea3:	8d 5a 01             	lea    0x1(%edx),%ebx
80100ea6:	83 e2 7f             	and    $0x7f,%edx
80100ea9:	88 8a 80 fe 10 80    	mov    %cl,-0x7fef0180(%edx)
    if(panicked){
80100eaf:	8b 0d 58 ff 10 80    	mov    0x8010ff58,%ecx
                        input.buf[input.e++ % INPUT_BUF] = c;
80100eb5:	89 1d 08 ff 10 80    	mov    %ebx,0x8010ff08
    if(panicked){
80100ebb:	85 c9                	test   %ecx,%ecx
80100ebd:	74 15                	je     80100ed4 <consoleintr+0x364>
80100ebf:	fa                   	cli    
        for(;;)
80100ec0:	eb fe                	jmp    80100ec0 <consoleintr+0x350>
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100ec8:	b9 0a 00 00 00       	mov    $0xa,%ecx
                    c = (c == '\r') ? '\n' : c;
80100ecd:	b8 0a 00 00 00       	mov    $0xa,%eax
80100ed2:	eb cf                	jmp    80100ea3 <consoleintr+0x333>
80100ed4:	e8 27 f5 ff ff       	call   80100400 <consputc.part.0>
                        wakeup(&input.r);
80100ed9:	83 ec 0c             	sub    $0xc,%esp
                        input.w = input.e;
80100edc:	a1 08 ff 10 80       	mov    0x8010ff08,%eax
                        number_of_left_moves =0;
80100ee1:	c7 05 0c ff 10 80 00 	movl   $0x0,0x8010ff0c
80100ee8:	00 00 00 
                        wakeup(&input.r);
80100eeb:	68 00 ff 10 80       	push   $0x8010ff00
                        input.w = input.e;
80100ef0:	a3 04 ff 10 80       	mov    %eax,0x8010ff04
                        wakeup(&input.r);
80100ef5:	e8 a6 3a 00 00       	call   801049a0 <wakeup>
80100efa:	83 c4 10             	add    $0x10,%esp
80100efd:	e9 96 fc ff ff       	jmp    80100b98 <consoleintr+0x28>
                            insert_at_the_given_pos(c,number_of_left_moves);
80100f02:	83 ec 08             	sub    $0x8,%esp
80100f05:	51                   	push   %ecx
80100f06:	50                   	push   %eax
80100f07:	e8 c4 fb ff ff       	call   80100ad0 <insert_at_the_given_pos>
80100f0c:	83 c4 10             	add    $0x10,%esp
80100f0f:	e9 84 fc ff ff       	jmp    80100b98 <consoleintr+0x28>
80100f14:	e8 e7 f4 ff ff       	call   80100400 <consputc.part.0>
80100f19:	e9 7a fc ff ff       	jmp    80100b98 <consoleintr+0x28>
80100f1e:	66 90                	xchg   %ax,%ax

80100f20 <consoleinit>:

void
consoleinit(void)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	83 ec 10             	sub    $0x10,%esp
    initlock(&cons.lock, "console");
80100f26:	68 48 7f 10 80       	push   $0x80107f48
80100f2b:	68 20 ff 10 80       	push   $0x8010ff20
80100f30:	e8 4b 3f 00 00       	call   80104e80 <initlock>

    devsw[CONSOLE].write = consolewrite;
    devsw[CONSOLE].read = consoleread;
    cons.locking = 1;

    ioapicenable(IRQ_KBD, 0);
80100f35:	58                   	pop    %eax
80100f36:	5a                   	pop    %edx
80100f37:	6a 00                	push   $0x0
80100f39:	6a 01                	push   $0x1
    devsw[CONSOLE].write = consolewrite;
80100f3b:	c7 05 0c 09 11 80 90 	movl   $0x80100590,0x8011090c
80100f42:	05 10 80 
    devsw[CONSOLE].read = consoleread;
80100f45:	c7 05 08 09 11 80 80 	movl   $0x80100280,0x80110908
80100f4c:	02 10 80 
    cons.locking = 1;
80100f4f:	c7 05 54 ff 10 80 01 	movl   $0x1,0x8010ff54
80100f56:	00 00 00 
    ioapicenable(IRQ_KBD, 0);
80100f59:	e8 f2 19 00 00       	call   80102950 <ioapicenable>
}
80100f5e:	83 c4 10             	add    $0x10,%esp
80100f61:	c9                   	leave  
80100f62:	c3                   	ret    
80100f63:	66 90                	xchg   %ax,%ax
80100f65:	66 90                	xchg   %ax,%ax
80100f67:	66 90                	xchg   %ax,%ax
80100f69:	66 90                	xchg   %ax,%ax
80100f6b:	66 90                	xchg   %ax,%ax
80100f6d:	66 90                	xchg   %ax,%ax
80100f6f:	90                   	nop

80100f70 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	57                   	push   %edi
80100f74:	56                   	push   %esi
80100f75:	53                   	push   %ebx
80100f76:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100f7c:	e8 0f 2f 00 00       	call   80103e90 <myproc>
80100f81:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100f87:	e8 a4 22 00 00       	call   80103230 <begin_op>

  if((ip = namei(path)) == 0){
80100f8c:	83 ec 0c             	sub    $0xc,%esp
80100f8f:	ff 75 08             	pushl  0x8(%ebp)
80100f92:	e8 c9 15 00 00       	call   80102560 <namei>
80100f97:	83 c4 10             	add    $0x10,%esp
80100f9a:	85 c0                	test   %eax,%eax
80100f9c:	0f 84 02 03 00 00    	je     801012a4 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100fa2:	83 ec 0c             	sub    $0xc,%esp
80100fa5:	89 c3                	mov    %eax,%ebx
80100fa7:	50                   	push   %eax
80100fa8:	e8 93 0c 00 00       	call   80101c40 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100fad:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100fb3:	6a 34                	push   $0x34
80100fb5:	6a 00                	push   $0x0
80100fb7:	50                   	push   %eax
80100fb8:	53                   	push   %ebx
80100fb9:	e8 92 0f 00 00       	call   80101f50 <readi>
80100fbe:	83 c4 20             	add    $0x20,%esp
80100fc1:	83 f8 34             	cmp    $0x34,%eax
80100fc4:	74 22                	je     80100fe8 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100fc6:	83 ec 0c             	sub    $0xc,%esp
80100fc9:	53                   	push   %ebx
80100fca:	e8 01 0f 00 00       	call   80101ed0 <iunlockput>
    end_op();
80100fcf:	e8 cc 22 00 00       	call   801032a0 <end_op>
80100fd4:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100fd7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fdc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fdf:	5b                   	pop    %ebx
80100fe0:	5e                   	pop    %esi
80100fe1:	5f                   	pop    %edi
80100fe2:	5d                   	pop    %ebp
80100fe3:	c3                   	ret    
80100fe4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100fe8:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100fef:	45 4c 46 
80100ff2:	75 d2                	jne    80100fc6 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100ff4:	e8 97 6b 00 00       	call   80107b90 <setupkvm>
80100ff9:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100fff:	85 c0                	test   %eax,%eax
80101001:	74 c3                	je     80100fc6 <exec+0x56>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101003:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
8010100a:	00 
8010100b:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80101011:	0f 84 ac 02 00 00    	je     801012c3 <exec+0x353>
  sz = 0;
80101017:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
8010101e:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101021:	31 ff                	xor    %edi,%edi
80101023:	e9 8e 00 00 00       	jmp    801010b6 <exec+0x146>
80101028:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010102f:	90                   	nop
    if(ph.type != ELF_PROG_LOAD)
80101030:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101037:	75 6c                	jne    801010a5 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101039:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010103f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101045:	0f 82 87 00 00 00    	jb     801010d2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010104b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101051:	72 7f                	jb     801010d2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101053:	83 ec 04             	sub    $0x4,%esp
80101056:	50                   	push   %eax
80101057:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010105d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101063:	e8 48 69 00 00       	call   801079b0 <allocuvm>
80101068:	83 c4 10             	add    $0x10,%esp
8010106b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101071:	85 c0                	test   %eax,%eax
80101073:	74 5d                	je     801010d2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101075:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010107b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101080:	75 50                	jne    801010d2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101082:	83 ec 0c             	sub    $0xc,%esp
80101085:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
8010108b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101091:	53                   	push   %ebx
80101092:	50                   	push   %eax
80101093:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101099:	e8 22 68 00 00       	call   801078c0 <loaduvm>
8010109e:	83 c4 20             	add    $0x20,%esp
801010a1:	85 c0                	test   %eax,%eax
801010a3:	78 2d                	js     801010d2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801010a5:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
801010ac:	83 c7 01             	add    $0x1,%edi
801010af:	83 c6 20             	add    $0x20,%esi
801010b2:	39 f8                	cmp    %edi,%eax
801010b4:	7e 3a                	jle    801010f0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
801010b6:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
801010bc:	6a 20                	push   $0x20
801010be:	56                   	push   %esi
801010bf:	50                   	push   %eax
801010c0:	53                   	push   %ebx
801010c1:	e8 8a 0e 00 00       	call   80101f50 <readi>
801010c6:	83 c4 10             	add    $0x10,%esp
801010c9:	83 f8 20             	cmp    $0x20,%eax
801010cc:	0f 84 5e ff ff ff    	je     80101030 <exec+0xc0>
    freevm(pgdir);
801010d2:	83 ec 0c             	sub    $0xc,%esp
801010d5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010db:	e8 30 6a 00 00       	call   80107b10 <freevm>
  if(ip){
801010e0:	83 c4 10             	add    $0x10,%esp
801010e3:	e9 de fe ff ff       	jmp    80100fc6 <exec+0x56>
801010e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010ef:	90                   	nop
  sz = PGROUNDUP(sz);
801010f0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801010f6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801010fc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101102:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80101108:	83 ec 0c             	sub    $0xc,%esp
8010110b:	53                   	push   %ebx
8010110c:	e8 bf 0d 00 00       	call   80101ed0 <iunlockput>
  end_op();
80101111:	e8 8a 21 00 00       	call   801032a0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80101116:	83 c4 0c             	add    $0xc,%esp
80101119:	56                   	push   %esi
8010111a:	57                   	push   %edi
8010111b:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80101121:	57                   	push   %edi
80101122:	e8 89 68 00 00       	call   801079b0 <allocuvm>
80101127:	83 c4 10             	add    $0x10,%esp
8010112a:	89 c6                	mov    %eax,%esi
8010112c:	85 c0                	test   %eax,%eax
8010112e:	0f 84 94 00 00 00    	je     801011c8 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010113d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010113f:	50                   	push   %eax
80101140:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101141:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101143:	e8 e8 6a 00 00       	call   80107c30 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101148:	8b 45 0c             	mov    0xc(%ebp),%eax
8010114b:	83 c4 10             	add    $0x10,%esp
8010114e:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80101154:	8b 00                	mov    (%eax),%eax
80101156:	85 c0                	test   %eax,%eax
80101158:	0f 84 8b 00 00 00    	je     801011e9 <exec+0x279>
8010115e:	89 b5 f0 fe ff ff    	mov    %esi,-0x110(%ebp)
80101164:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
8010116a:	eb 23                	jmp    8010118f <exec+0x21f>
8010116c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101170:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80101173:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010117a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010117d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101183:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101186:	85 c0                	test   %eax,%eax
80101188:	74 59                	je     801011e3 <exec+0x273>
    if(argc >= MAXARG)
8010118a:	83 ff 20             	cmp    $0x20,%edi
8010118d:	74 39                	je     801011c8 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	50                   	push   %eax
80101193:	e8 78 41 00 00       	call   80105310 <strlen>
80101198:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010119a:	58                   	pop    %eax
8010119b:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010119e:	83 eb 01             	sub    $0x1,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011a1:	ff 34 b8             	pushl  (%eax,%edi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
801011a4:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
801011a7:	e8 64 41 00 00       	call   80105310 <strlen>
801011ac:	83 c0 01             	add    $0x1,%eax
801011af:	50                   	push   %eax
801011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801011b3:	ff 34 b8             	pushl  (%eax,%edi,4)
801011b6:	53                   	push   %ebx
801011b7:	56                   	push   %esi
801011b8:	e8 43 6c 00 00       	call   80107e00 <copyout>
801011bd:	83 c4 20             	add    $0x20,%esp
801011c0:	85 c0                	test   %eax,%eax
801011c2:	79 ac                	jns    80101170 <exec+0x200>
801011c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
801011c8:	83 ec 0c             	sub    $0xc,%esp
801011cb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011d1:	e8 3a 69 00 00       	call   80107b10 <freevm>
801011d6:	83 c4 10             	add    $0x10,%esp
  return -1;
801011d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011de:	e9 f9 fd ff ff       	jmp    80100fdc <exec+0x6c>
801011e3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011e9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801011f0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801011f2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801011f9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011fd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801011ff:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
80101202:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
80101208:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
8010120a:	50                   	push   %eax
8010120b:	52                   	push   %edx
8010120c:	53                   	push   %ebx
8010120d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
80101213:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
8010121a:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
8010121d:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80101223:	e8 d8 6b 00 00       	call   80107e00 <copyout>
80101228:	83 c4 10             	add    $0x10,%esp
8010122b:	85 c0                	test   %eax,%eax
8010122d:	78 99                	js     801011c8 <exec+0x258>
  for(last=s=path; *s; s++)
8010122f:	8b 45 08             	mov    0x8(%ebp),%eax
80101232:	8b 55 08             	mov    0x8(%ebp),%edx
80101235:	0f b6 00             	movzbl (%eax),%eax
80101238:	84 c0                	test   %al,%al
8010123a:	74 13                	je     8010124f <exec+0x2df>
8010123c:	89 d1                	mov    %edx,%ecx
8010123e:	66 90                	xchg   %ax,%ax
      last = s+1;
80101240:	83 c1 01             	add    $0x1,%ecx
80101243:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101245:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101248:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010124b:	84 c0                	test   %al,%al
8010124d:	75 f1                	jne    80101240 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010124f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101255:	83 ec 04             	sub    $0x4,%esp
80101258:	6a 10                	push   $0x10
8010125a:	89 f8                	mov    %edi,%eax
8010125c:	52                   	push   %edx
8010125d:	83 c0 70             	add    $0x70,%eax
80101260:	50                   	push   %eax
80101261:	e8 6a 40 00 00       	call   801052d0 <safestrcpy>
  curproc->pgdir = pgdir;
80101266:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010126c:	89 f8                	mov    %edi,%eax
8010126e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101271:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101273:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101276:	89 c1                	mov    %eax,%ecx
80101278:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010127e:	8b 40 1c             	mov    0x1c(%eax),%eax
80101281:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101284:	8b 41 1c             	mov    0x1c(%ecx),%eax
80101287:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010128a:	89 0c 24             	mov    %ecx,(%esp)
8010128d:	e8 9e 64 00 00       	call   80107730 <switchuvm>
  freevm(oldpgdir);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 76 68 00 00       	call   80107b10 <freevm>
  return 0;
8010129a:	83 c4 10             	add    $0x10,%esp
8010129d:	31 c0                	xor    %eax,%eax
8010129f:	e9 38 fd ff ff       	jmp    80100fdc <exec+0x6c>
    end_op();
801012a4:	e8 f7 1f 00 00       	call   801032a0 <end_op>
    cprintf("exec: fail\n");
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 b9 7f 10 80       	push   $0x80107fb9
801012b1:	e8 ea f3 ff ff       	call   801006a0 <cprintf>
    return -1;
801012b6:	83 c4 10             	add    $0x10,%esp
801012b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012be:	e9 19 fd ff ff       	jmp    80100fdc <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801012c3:	be 00 20 00 00       	mov    $0x2000,%esi
801012c8:	31 ff                	xor    %edi,%edi
801012ca:	e9 39 fe ff ff       	jmp    80101108 <exec+0x198>
801012cf:	90                   	nop

801012d0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801012d0:	55                   	push   %ebp
801012d1:	89 e5                	mov    %esp,%ebp
801012d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801012d6:	68 c5 7f 10 80       	push   $0x80107fc5
801012db:	68 60 ff 10 80       	push   $0x8010ff60
801012e0:	e8 9b 3b 00 00       	call   80104e80 <initlock>
}
801012e5:	83 c4 10             	add    $0x10,%esp
801012e8:	c9                   	leave  
801012e9:	c3                   	ret    
801012ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801012f0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012f4:	bb 94 ff 10 80       	mov    $0x8010ff94,%ebx
{
801012f9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801012fc:	68 60 ff 10 80       	push   $0x8010ff60
80101301:	e8 4a 3d 00 00       	call   80105050 <acquire>
80101306:	83 c4 10             	add    $0x10,%esp
80101309:	eb 10                	jmp    8010131b <filealloc+0x2b>
8010130b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010130f:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101310:	83 c3 18             	add    $0x18,%ebx
80101313:	81 fb f4 08 11 80    	cmp    $0x801108f4,%ebx
80101319:	74 25                	je     80101340 <filealloc+0x50>
    if(f->ref == 0){
8010131b:	8b 43 04             	mov    0x4(%ebx),%eax
8010131e:	85 c0                	test   %eax,%eax
80101320:	75 ee                	jne    80101310 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101322:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101325:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010132c:	68 60 ff 10 80       	push   $0x8010ff60
80101331:	e8 ba 3c 00 00       	call   80104ff0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101336:	89 d8                	mov    %ebx,%eax
      return f;
80101338:	83 c4 10             	add    $0x10,%esp
}
8010133b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010133e:	c9                   	leave  
8010133f:	c3                   	ret    
  release(&ftable.lock);
80101340:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101343:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101345:	68 60 ff 10 80       	push   $0x8010ff60
8010134a:	e8 a1 3c 00 00       	call   80104ff0 <release>
}
8010134f:	89 d8                	mov    %ebx,%eax
  return 0;
80101351:	83 c4 10             	add    $0x10,%esp
}
80101354:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101357:	c9                   	leave  
80101358:	c3                   	ret    
80101359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101360 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101360:	55                   	push   %ebp
80101361:	89 e5                	mov    %esp,%ebp
80101363:	53                   	push   %ebx
80101364:	83 ec 10             	sub    $0x10,%esp
80101367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010136a:	68 60 ff 10 80       	push   $0x8010ff60
8010136f:	e8 dc 3c 00 00       	call   80105050 <acquire>
  if(f->ref < 1)
80101374:	8b 43 04             	mov    0x4(%ebx),%eax
80101377:	83 c4 10             	add    $0x10,%esp
8010137a:	85 c0                	test   %eax,%eax
8010137c:	7e 1a                	jle    80101398 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010137e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101381:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101384:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101387:	68 60 ff 10 80       	push   $0x8010ff60
8010138c:	e8 5f 3c 00 00       	call   80104ff0 <release>
  return f;
}
80101391:	89 d8                	mov    %ebx,%eax
80101393:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101396:	c9                   	leave  
80101397:	c3                   	ret    
    panic("filedup");
80101398:	83 ec 0c             	sub    $0xc,%esp
8010139b:	68 cc 7f 10 80       	push   $0x80107fcc
801013a0:	e8 db ef ff ff       	call   80100380 <panic>
801013a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801013ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013b0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	83 ec 28             	sub    $0x28,%esp
801013b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801013bc:	68 60 ff 10 80       	push   $0x8010ff60
801013c1:	e8 8a 3c 00 00       	call   80105050 <acquire>
  if(f->ref < 1)
801013c6:	8b 53 04             	mov    0x4(%ebx),%edx
801013c9:	83 c4 10             	add    $0x10,%esp
801013cc:	85 d2                	test   %edx,%edx
801013ce:	0f 8e a5 00 00 00    	jle    80101479 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801013d4:	83 ea 01             	sub    $0x1,%edx
801013d7:	89 53 04             	mov    %edx,0x4(%ebx)
801013da:	75 44                	jne    80101420 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801013dc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801013e0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801013e3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801013e5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801013eb:	8b 73 0c             	mov    0xc(%ebx),%esi
801013ee:	88 45 e7             	mov    %al,-0x19(%ebp)
801013f1:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801013f4:	68 60 ff 10 80       	push   $0x8010ff60
  ff = *f;
801013f9:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801013fc:	e8 ef 3b 00 00       	call   80104ff0 <release>

  if(ff.type == FD_PIPE)
80101401:	83 c4 10             	add    $0x10,%esp
80101404:	83 ff 01             	cmp    $0x1,%edi
80101407:	74 57                	je     80101460 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101409:	83 ff 02             	cmp    $0x2,%edi
8010140c:	74 2a                	je     80101438 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010140e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101411:	5b                   	pop    %ebx
80101412:	5e                   	pop    %esi
80101413:	5f                   	pop    %edi
80101414:	5d                   	pop    %ebp
80101415:	c3                   	ret    
80101416:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010141d:	8d 76 00             	lea    0x0(%esi),%esi
    release(&ftable.lock);
80101420:	c7 45 08 60 ff 10 80 	movl   $0x8010ff60,0x8(%ebp)
}
80101427:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010142a:	5b                   	pop    %ebx
8010142b:	5e                   	pop    %esi
8010142c:	5f                   	pop    %edi
8010142d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010142e:	e9 bd 3b 00 00       	jmp    80104ff0 <release>
80101433:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101437:	90                   	nop
    begin_op();
80101438:	e8 f3 1d 00 00       	call   80103230 <begin_op>
    iput(ff.ip);
8010143d:	83 ec 0c             	sub    $0xc,%esp
80101440:	ff 75 e0             	pushl  -0x20(%ebp)
80101443:	e8 28 09 00 00       	call   80101d70 <iput>
    end_op();
80101448:	83 c4 10             	add    $0x10,%esp
}
8010144b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010144e:	5b                   	pop    %ebx
8010144f:	5e                   	pop    %esi
80101450:	5f                   	pop    %edi
80101451:	5d                   	pop    %ebp
    end_op();
80101452:	e9 49 1e 00 00       	jmp    801032a0 <end_op>
80101457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101460:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101464:	83 ec 08             	sub    $0x8,%esp
80101467:	53                   	push   %ebx
80101468:	56                   	push   %esi
80101469:	e8 92 25 00 00       	call   80103a00 <pipeclose>
8010146e:	83 c4 10             	add    $0x10,%esp
}
80101471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101474:	5b                   	pop    %ebx
80101475:	5e                   	pop    %esi
80101476:	5f                   	pop    %edi
80101477:	5d                   	pop    %ebp
80101478:	c3                   	ret    
    panic("fileclose");
80101479:	83 ec 0c             	sub    $0xc,%esp
8010147c:	68 d4 7f 10 80       	push   $0x80107fd4
80101481:	e8 fa ee ff ff       	call   80100380 <panic>
80101486:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010148d:	8d 76 00             	lea    0x0(%esi),%esi

80101490 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	83 ec 04             	sub    $0x4,%esp
80101497:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010149a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010149d:	75 31                	jne    801014d0 <filestat+0x40>
    ilock(f->ip);
8010149f:	83 ec 0c             	sub    $0xc,%esp
801014a2:	ff 73 10             	pushl  0x10(%ebx)
801014a5:	e8 96 07 00 00       	call   80101c40 <ilock>
    stati(f->ip, st);
801014aa:	58                   	pop    %eax
801014ab:	5a                   	pop    %edx
801014ac:	ff 75 0c             	pushl  0xc(%ebp)
801014af:	ff 73 10             	pushl  0x10(%ebx)
801014b2:	e8 69 0a 00 00       	call   80101f20 <stati>
    iunlock(f->ip);
801014b7:	59                   	pop    %ecx
801014b8:	ff 73 10             	pushl  0x10(%ebx)
801014bb:	e8 60 08 00 00       	call   80101d20 <iunlock>
    return 0;
  }
  return -1;
}
801014c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801014c3:	83 c4 10             	add    $0x10,%esp
801014c6:	31 c0                	xor    %eax,%eax
}
801014c8:	c9                   	leave  
801014c9:	c3                   	ret    
801014ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801014d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801014d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801014d8:	c9                   	leave  
801014d9:	c3                   	ret    
801014da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014e0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801014e0:	55                   	push   %ebp
801014e1:	89 e5                	mov    %esp,%ebp
801014e3:	57                   	push   %edi
801014e4:	56                   	push   %esi
801014e5:	53                   	push   %ebx
801014e6:	83 ec 0c             	sub    $0xc,%esp
801014e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801014ec:	8b 75 0c             	mov    0xc(%ebp),%esi
801014ef:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801014f2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801014f6:	74 60                	je     80101558 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801014f8:	8b 03                	mov    (%ebx),%eax
801014fa:	83 f8 01             	cmp    $0x1,%eax
801014fd:	74 41                	je     80101540 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801014ff:	83 f8 02             	cmp    $0x2,%eax
80101502:	75 5b                	jne    8010155f <fileread+0x7f>
    ilock(f->ip);
80101504:	83 ec 0c             	sub    $0xc,%esp
80101507:	ff 73 10             	pushl  0x10(%ebx)
8010150a:	e8 31 07 00 00       	call   80101c40 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010150f:	57                   	push   %edi
80101510:	ff 73 14             	pushl  0x14(%ebx)
80101513:	56                   	push   %esi
80101514:	ff 73 10             	pushl  0x10(%ebx)
80101517:	e8 34 0a 00 00       	call   80101f50 <readi>
8010151c:	83 c4 20             	add    $0x20,%esp
8010151f:	89 c6                	mov    %eax,%esi
80101521:	85 c0                	test   %eax,%eax
80101523:	7e 03                	jle    80101528 <fileread+0x48>
      f->off += r;
80101525:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101528:	83 ec 0c             	sub    $0xc,%esp
8010152b:	ff 73 10             	pushl  0x10(%ebx)
8010152e:	e8 ed 07 00 00       	call   80101d20 <iunlock>
    return r;
80101533:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101536:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101539:	89 f0                	mov    %esi,%eax
8010153b:	5b                   	pop    %ebx
8010153c:	5e                   	pop    %esi
8010153d:	5f                   	pop    %edi
8010153e:	5d                   	pop    %ebp
8010153f:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80101540:	8b 43 0c             	mov    0xc(%ebx),%eax
80101543:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101546:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101549:	5b                   	pop    %ebx
8010154a:	5e                   	pop    %esi
8010154b:	5f                   	pop    %edi
8010154c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010154d:	e9 4e 26 00 00       	jmp    80103ba0 <piperead>
80101552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101558:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010155d:	eb d7                	jmp    80101536 <fileread+0x56>
  panic("fileread");
8010155f:	83 ec 0c             	sub    $0xc,%esp
80101562:	68 de 7f 10 80       	push   $0x80107fde
80101567:	e8 14 ee ff ff       	call   80100380 <panic>
8010156c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101570 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101570:	55                   	push   %ebp
80101571:	89 e5                	mov    %esp,%ebp
80101573:	57                   	push   %edi
80101574:	56                   	push   %esi
80101575:	53                   	push   %ebx
80101576:	83 ec 1c             	sub    $0x1c,%esp
80101579:	8b 45 0c             	mov    0xc(%ebp),%eax
8010157c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010157f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101582:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101585:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101589:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010158c:	0f 84 bd 00 00 00    	je     8010164f <filewrite+0xdf>
    return -1;
  if(f->type == FD_PIPE)
80101592:	8b 03                	mov    (%ebx),%eax
80101594:	83 f8 01             	cmp    $0x1,%eax
80101597:	0f 84 bf 00 00 00    	je     8010165c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010159d:	83 f8 02             	cmp    $0x2,%eax
801015a0:	0f 85 c8 00 00 00    	jne    8010166e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801015a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801015a9:	31 f6                	xor    %esi,%esi
    while(i < n){
801015ab:	85 c0                	test   %eax,%eax
801015ad:	7f 30                	jg     801015df <filewrite+0x6f>
801015af:	e9 94 00 00 00       	jmp    80101648 <filewrite+0xd8>
801015b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801015b8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801015bb:	83 ec 0c             	sub    $0xc,%esp
801015be:	ff 73 10             	pushl  0x10(%ebx)
        f->off += r;
801015c1:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801015c4:	e8 57 07 00 00       	call   80101d20 <iunlock>
      end_op();
801015c9:	e8 d2 1c 00 00       	call   801032a0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801015ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015d1:	83 c4 10             	add    $0x10,%esp
801015d4:	39 c7                	cmp    %eax,%edi
801015d6:	75 5c                	jne    80101634 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801015d8:	01 fe                	add    %edi,%esi
    while(i < n){
801015da:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801015dd:	7e 69                	jle    80101648 <filewrite+0xd8>
      int n1 = n - i;
801015df:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801015e2:	b8 00 06 00 00       	mov    $0x600,%eax
801015e7:	29 f7                	sub    %esi,%edi
801015e9:	39 c7                	cmp    %eax,%edi
801015eb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801015ee:	e8 3d 1c 00 00       	call   80103230 <begin_op>
      ilock(f->ip);
801015f3:	83 ec 0c             	sub    $0xc,%esp
801015f6:	ff 73 10             	pushl  0x10(%ebx)
801015f9:	e8 42 06 00 00       	call   80101c40 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801015fe:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101601:	57                   	push   %edi
80101602:	ff 73 14             	pushl  0x14(%ebx)
80101605:	01 f0                	add    %esi,%eax
80101607:	50                   	push   %eax
80101608:	ff 73 10             	pushl  0x10(%ebx)
8010160b:	e8 40 0a 00 00       	call   80102050 <writei>
80101610:	83 c4 20             	add    $0x20,%esp
80101613:	85 c0                	test   %eax,%eax
80101615:	7f a1                	jg     801015b8 <filewrite+0x48>
      iunlock(f->ip);
80101617:	83 ec 0c             	sub    $0xc,%esp
8010161a:	ff 73 10             	pushl  0x10(%ebx)
8010161d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101620:	e8 fb 06 00 00       	call   80101d20 <iunlock>
      end_op();
80101625:	e8 76 1c 00 00       	call   801032a0 <end_op>
      if(r < 0)
8010162a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010162d:	83 c4 10             	add    $0x10,%esp
80101630:	85 c0                	test   %eax,%eax
80101632:	75 1b                	jne    8010164f <filewrite+0xdf>
        panic("short filewrite");
80101634:	83 ec 0c             	sub    $0xc,%esp
80101637:	68 e7 7f 10 80       	push   $0x80107fe7
8010163c:	e8 3f ed ff ff       	call   80100380 <panic>
80101641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101648:	89 f0                	mov    %esi,%eax
8010164a:	3b 75 e4             	cmp    -0x1c(%ebp),%esi
8010164d:	74 05                	je     80101654 <filewrite+0xe4>
8010164f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
80101654:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5f                   	pop    %edi
8010165a:	5d                   	pop    %ebp
8010165b:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
8010165c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010165f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101662:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101665:	5b                   	pop    %ebx
80101666:	5e                   	pop    %esi
80101667:	5f                   	pop    %edi
80101668:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101669:	e9 32 24 00 00       	jmp    80103aa0 <pipewrite>
  panic("filewrite");
8010166e:	83 ec 0c             	sub    $0xc,%esp
80101671:	68 ed 7f 10 80       	push   $0x80107fed
80101676:	e8 05 ed ff ff       	call   80100380 <panic>
8010167b:	66 90                	xchg   %ax,%ax
8010167d:	66 90                	xchg   %ax,%ax
8010167f:	90                   	nop

80101680 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101680:	55                   	push   %ebp
80101681:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101683:	89 d0                	mov    %edx,%eax
80101685:	c1 e8 0c             	shr    $0xc,%eax
80101688:	03 05 cc 25 11 80    	add    0x801125cc,%eax
{
8010168e:	89 e5                	mov    %esp,%ebp
80101690:	56                   	push   %esi
80101691:	53                   	push   %ebx
80101692:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101694:	83 ec 08             	sub    $0x8,%esp
80101697:	50                   	push   %eax
80101698:	51                   	push   %ecx
80101699:	e8 32 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010169e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801016a0:	c1 fb 03             	sar    $0x3,%ebx
801016a3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801016a6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801016a8:	83 e1 07             	and    $0x7,%ecx
801016ab:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801016b0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801016b6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801016b8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801016bd:	85 c1                	test   %eax,%ecx
801016bf:	74 23                	je     801016e4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801016c1:	f7 d0                	not    %eax
  log_write(bp);
801016c3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801016c6:	21 c8                	and    %ecx,%eax
801016c8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801016cc:	56                   	push   %esi
801016cd:	e8 3e 1d 00 00       	call   80103410 <log_write>
  brelse(bp);
801016d2:	89 34 24             	mov    %esi,(%esp)
801016d5:	e8 16 eb ff ff       	call   801001f0 <brelse>
}
801016da:	83 c4 10             	add    $0x10,%esp
801016dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016e0:	5b                   	pop    %ebx
801016e1:	5e                   	pop    %esi
801016e2:	5d                   	pop    %ebp
801016e3:	c3                   	ret    
    panic("freeing free block");
801016e4:	83 ec 0c             	sub    $0xc,%esp
801016e7:	68 f7 7f 10 80       	push   $0x80107ff7
801016ec:	e8 8f ec ff ff       	call   80100380 <panic>
801016f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ff:	90                   	nop

80101700 <balloc>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	57                   	push   %edi
80101704:	56                   	push   %esi
80101705:	53                   	push   %ebx
80101706:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
80101709:	8b 0d b4 25 11 80    	mov    0x801125b4,%ecx
{
8010170f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101712:	85 c9                	test   %ecx,%ecx
80101714:	0f 84 87 00 00 00    	je     801017a1 <balloc+0xa1>
8010171a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101721:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101724:	83 ec 08             	sub    $0x8,%esp
80101727:	89 f0                	mov    %esi,%eax
80101729:	c1 f8 0c             	sar    $0xc,%eax
8010172c:	03 05 cc 25 11 80    	add    0x801125cc,%eax
80101732:	50                   	push   %eax
80101733:	ff 75 d8             	pushl  -0x28(%ebp)
80101736:	e8 95 e9 ff ff       	call   801000d0 <bread>
8010173b:	83 c4 10             	add    $0x10,%esp
8010173e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101741:	a1 b4 25 11 80       	mov    0x801125b4,%eax
80101746:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101749:	31 c0                	xor    %eax,%eax
8010174b:	eb 2f                	jmp    8010177c <balloc+0x7c>
8010174d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101750:	89 c1                	mov    %eax,%ecx
80101752:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101757:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010175a:	83 e1 07             	and    $0x7,%ecx
8010175d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010175f:	89 c1                	mov    %eax,%ecx
80101761:	c1 f9 03             	sar    $0x3,%ecx
80101764:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101769:	89 fa                	mov    %edi,%edx
8010176b:	85 df                	test   %ebx,%edi
8010176d:	74 41                	je     801017b0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010176f:	83 c0 01             	add    $0x1,%eax
80101772:	83 c6 01             	add    $0x1,%esi
80101775:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010177a:	74 05                	je     80101781 <balloc+0x81>
8010177c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010177f:	77 cf                	ja     80101750 <balloc+0x50>
    brelse(bp);
80101781:	83 ec 0c             	sub    $0xc,%esp
80101784:	ff 75 e4             	pushl  -0x1c(%ebp)
80101787:	e8 64 ea ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010178c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101793:	83 c4 10             	add    $0x10,%esp
80101796:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101799:	39 05 b4 25 11 80    	cmp    %eax,0x801125b4
8010179f:	77 80                	ja     80101721 <balloc+0x21>
  panic("balloc: out of blocks");
801017a1:	83 ec 0c             	sub    $0xc,%esp
801017a4:	68 0a 80 10 80       	push   $0x8010800a
801017a9:	e8 d2 eb ff ff       	call   80100380 <panic>
801017ae:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801017b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801017b3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801017b6:	09 da                	or     %ebx,%edx
801017b8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801017bc:	57                   	push   %edi
801017bd:	e8 4e 1c 00 00       	call   80103410 <log_write>
        brelse(bp);
801017c2:	89 3c 24             	mov    %edi,(%esp)
801017c5:	e8 26 ea ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801017ca:	58                   	pop    %eax
801017cb:	5a                   	pop    %edx
801017cc:	56                   	push   %esi
801017cd:	ff 75 d8             	pushl  -0x28(%ebp)
801017d0:	e8 fb e8 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801017d5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801017d8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801017da:	8d 40 5c             	lea    0x5c(%eax),%eax
801017dd:	68 00 02 00 00       	push   $0x200
801017e2:	6a 00                	push   $0x0
801017e4:	50                   	push   %eax
801017e5:	e8 26 39 00 00       	call   80105110 <memset>
  log_write(bp);
801017ea:	89 1c 24             	mov    %ebx,(%esp)
801017ed:	e8 1e 1c 00 00       	call   80103410 <log_write>
  brelse(bp);
801017f2:	89 1c 24             	mov    %ebx,(%esp)
801017f5:	e8 f6 e9 ff ff       	call   801001f0 <brelse>
}
801017fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017fd:	89 f0                	mov    %esi,%eax
801017ff:	5b                   	pop    %ebx
80101800:	5e                   	pop    %esi
80101801:	5f                   	pop    %edi
80101802:	5d                   	pop    %ebp
80101803:	c3                   	ret    
80101804:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010180b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010180f:	90                   	nop

80101810 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	57                   	push   %edi
80101814:	89 c7                	mov    %eax,%edi
80101816:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101817:	31 f6                	xor    %esi,%esi
{
80101819:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010181a:	bb 94 09 11 80       	mov    $0x80110994,%ebx
{
8010181f:	83 ec 28             	sub    $0x28,%esp
80101822:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101825:	68 60 09 11 80       	push   $0x80110960
8010182a:	e8 21 38 00 00       	call   80105050 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010182f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101832:	83 c4 10             	add    $0x10,%esp
80101835:	eb 1b                	jmp    80101852 <iget+0x42>
80101837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010183e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101840:	39 3b                	cmp    %edi,(%ebx)
80101842:	74 6c                	je     801018b0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101844:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010184a:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
80101850:	73 26                	jae    80101878 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101852:	8b 43 08             	mov    0x8(%ebx),%eax
80101855:	85 c0                	test   %eax,%eax
80101857:	7f e7                	jg     80101840 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101859:	85 f6                	test   %esi,%esi
8010185b:	75 e7                	jne    80101844 <iget+0x34>
8010185d:	85 c0                	test   %eax,%eax
8010185f:	75 76                	jne    801018d7 <iget+0xc7>
80101861:	89 de                	mov    %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101863:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101869:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
8010186f:	72 e1                	jb     80101852 <iget+0x42>
80101871:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101878:	85 f6                	test   %esi,%esi
8010187a:	74 79                	je     801018f5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010187c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010187f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101881:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101884:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010188b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101892:	68 60 09 11 80       	push   $0x80110960
80101897:	e8 54 37 00 00       	call   80104ff0 <release>

  return ip;
8010189c:	83 c4 10             	add    $0x10,%esp
}
8010189f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018a2:	89 f0                	mov    %esi,%eax
801018a4:	5b                   	pop    %ebx
801018a5:	5e                   	pop    %esi
801018a6:	5f                   	pop    %edi
801018a7:	5d                   	pop    %ebp
801018a8:	c3                   	ret    
801018a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018b0:	39 53 04             	cmp    %edx,0x4(%ebx)
801018b3:	75 8f                	jne    80101844 <iget+0x34>
      release(&icache.lock);
801018b5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801018b8:	83 c0 01             	add    $0x1,%eax
      return ip;
801018bb:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801018bd:	68 60 09 11 80       	push   $0x80110960
      ip->ref++;
801018c2:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801018c5:	e8 26 37 00 00       	call   80104ff0 <release>
      return ip;
801018ca:	83 c4 10             	add    $0x10,%esp
}
801018cd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018d0:	89 f0                	mov    %esi,%eax
801018d2:	5b                   	pop    %ebx
801018d3:	5e                   	pop    %esi
801018d4:	5f                   	pop    %edi
801018d5:	5d                   	pop    %ebp
801018d6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018d7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801018dd:	81 fb b4 25 11 80    	cmp    $0x801125b4,%ebx
801018e3:	73 10                	jae    801018f5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018e5:	8b 43 08             	mov    0x8(%ebx),%eax
801018e8:	85 c0                	test   %eax,%eax
801018ea:	0f 8f 50 ff ff ff    	jg     80101840 <iget+0x30>
801018f0:	e9 68 ff ff ff       	jmp    8010185d <iget+0x4d>
    panic("iget: no inodes");
801018f5:	83 ec 0c             	sub    $0xc,%esp
801018f8:	68 20 80 10 80       	push   $0x80108020
801018fd:	e8 7e ea ff ff       	call   80100380 <panic>
80101902:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101910 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101910:	55                   	push   %ebp
80101911:	89 e5                	mov    %esp,%ebp
80101913:	57                   	push   %edi
80101914:	56                   	push   %esi
80101915:	89 c6                	mov    %eax,%esi
80101917:	53                   	push   %ebx
80101918:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010191b:	83 fa 0b             	cmp    $0xb,%edx
8010191e:	0f 86 8c 00 00 00    	jbe    801019b0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101924:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101927:	83 fb 7f             	cmp    $0x7f,%ebx
8010192a:	0f 87 a2 00 00 00    	ja     801019d2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101930:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101936:	85 c0                	test   %eax,%eax
80101938:	74 5e                	je     80101998 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010193a:	83 ec 08             	sub    $0x8,%esp
8010193d:	50                   	push   %eax
8010193e:	ff 36                	pushl  (%esi)
80101940:	e8 8b e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101945:	83 c4 10             	add    $0x10,%esp
80101948:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010194c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010194e:	8b 3b                	mov    (%ebx),%edi
80101950:	85 ff                	test   %edi,%edi
80101952:	74 1c                	je     80101970 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101954:	83 ec 0c             	sub    $0xc,%esp
80101957:	52                   	push   %edx
80101958:	e8 93 e8 ff ff       	call   801001f0 <brelse>
8010195d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101960:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101963:	89 f8                	mov    %edi,%eax
80101965:	5b                   	pop    %ebx
80101966:	5e                   	pop    %esi
80101967:	5f                   	pop    %edi
80101968:	5d                   	pop    %ebp
80101969:	c3                   	ret    
8010196a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101970:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101973:	8b 06                	mov    (%esi),%eax
80101975:	e8 86 fd ff ff       	call   80101700 <balloc>
      log_write(bp);
8010197a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010197d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101980:	89 03                	mov    %eax,(%ebx)
80101982:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101984:	52                   	push   %edx
80101985:	e8 86 1a 00 00       	call   80103410 <log_write>
8010198a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010198d:	83 c4 10             	add    $0x10,%esp
80101990:	eb c2                	jmp    80101954 <bmap+0x44>
80101992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101998:	8b 06                	mov    (%esi),%eax
8010199a:	e8 61 fd ff ff       	call   80101700 <balloc>
8010199f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801019a5:	eb 93                	jmp    8010193a <bmap+0x2a>
801019a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019ae:	66 90                	xchg   %ax,%ax
    if((addr = ip->addrs[bn]) == 0)
801019b0:	8d 5a 14             	lea    0x14(%edx),%ebx
801019b3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801019b7:	85 ff                	test   %edi,%edi
801019b9:	75 a5                	jne    80101960 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801019bb:	8b 00                	mov    (%eax),%eax
801019bd:	e8 3e fd ff ff       	call   80101700 <balloc>
801019c2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801019c6:	89 c7                	mov    %eax,%edi
}
801019c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019cb:	5b                   	pop    %ebx
801019cc:	89 f8                	mov    %edi,%eax
801019ce:	5e                   	pop    %esi
801019cf:	5f                   	pop    %edi
801019d0:	5d                   	pop    %ebp
801019d1:	c3                   	ret    
  panic("bmap: out of range");
801019d2:	83 ec 0c             	sub    $0xc,%esp
801019d5:	68 30 80 10 80       	push   $0x80108030
801019da:	e8 a1 e9 ff ff       	call   80100380 <panic>
801019df:	90                   	nop

801019e0 <readsb>:
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	56                   	push   %esi
801019e4:	53                   	push   %ebx
801019e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801019e8:	83 ec 08             	sub    $0x8,%esp
801019eb:	6a 01                	push   $0x1
801019ed:	ff 75 08             	pushl  0x8(%ebp)
801019f0:	e8 db e6 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801019f5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801019f8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801019fa:	8d 40 5c             	lea    0x5c(%eax),%eax
801019fd:	6a 1c                	push   $0x1c
801019ff:	50                   	push   %eax
80101a00:	56                   	push   %esi
80101a01:	e8 aa 37 00 00       	call   801051b0 <memmove>
  brelse(bp);
80101a06:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101a09:	83 c4 10             	add    $0x10,%esp
}
80101a0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a0f:	5b                   	pop    %ebx
80101a10:	5e                   	pop    %esi
80101a11:	5d                   	pop    %ebp
  brelse(bp);
80101a12:	e9 d9 e7 ff ff       	jmp    801001f0 <brelse>
80101a17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a1e:	66 90                	xchg   %ax,%ax

80101a20 <iinit>:
{
80101a20:	55                   	push   %ebp
80101a21:	89 e5                	mov    %esp,%ebp
80101a23:	53                   	push   %ebx
80101a24:	bb a0 09 11 80       	mov    $0x801109a0,%ebx
80101a29:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101a2c:	68 43 80 10 80       	push   $0x80108043
80101a31:	68 60 09 11 80       	push   $0x80110960
80101a36:	e8 45 34 00 00       	call   80104e80 <initlock>
  for(i = 0; i < NINODE; i++) {
80101a3b:	83 c4 10             	add    $0x10,%esp
80101a3e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101a40:	83 ec 08             	sub    $0x8,%esp
80101a43:	68 4a 80 10 80       	push   $0x8010804a
80101a48:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101a49:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101a4f:	e8 fc 32 00 00       	call   80104d50 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101a54:	83 c4 10             	add    $0x10,%esp
80101a57:	81 fb c0 25 11 80    	cmp    $0x801125c0,%ebx
80101a5d:	75 e1                	jne    80101a40 <iinit+0x20>
  bp = bread(dev, 1);
80101a5f:	83 ec 08             	sub    $0x8,%esp
80101a62:	6a 01                	push   $0x1
80101a64:	ff 75 08             	pushl  0x8(%ebp)
80101a67:	e8 64 e6 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101a6c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101a6f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101a71:	8d 40 5c             	lea    0x5c(%eax),%eax
80101a74:	6a 1c                	push   $0x1c
80101a76:	50                   	push   %eax
80101a77:	68 b4 25 11 80       	push   $0x801125b4
80101a7c:	e8 2f 37 00 00       	call   801051b0 <memmove>
  brelse(bp);
80101a81:	89 1c 24             	mov    %ebx,(%esp)
80101a84:	e8 67 e7 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101a89:	ff 35 cc 25 11 80    	pushl  0x801125cc
80101a8f:	ff 35 c8 25 11 80    	pushl  0x801125c8
80101a95:	ff 35 c4 25 11 80    	pushl  0x801125c4
80101a9b:	ff 35 c0 25 11 80    	pushl  0x801125c0
80101aa1:	ff 35 bc 25 11 80    	pushl  0x801125bc
80101aa7:	ff 35 b8 25 11 80    	pushl  0x801125b8
80101aad:	ff 35 b4 25 11 80    	pushl  0x801125b4
80101ab3:	68 b0 80 10 80       	push   $0x801080b0
80101ab8:	e8 e3 eb ff ff       	call   801006a0 <cprintf>
}
80101abd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ac0:	83 c4 30             	add    $0x30,%esp
80101ac3:	c9                   	leave  
80101ac4:	c3                   	ret    
80101ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ad0 <ialloc>:
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 1c             	sub    $0x1c,%esp
80101ad9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101adc:	83 3d bc 25 11 80 01 	cmpl   $0x1,0x801125bc
{
80101ae3:	8b 75 08             	mov    0x8(%ebp),%esi
80101ae6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101ae9:	0f 86 91 00 00 00    	jbe    80101b80 <ialloc+0xb0>
80101aef:	bf 01 00 00 00       	mov    $0x1,%edi
80101af4:	eb 21                	jmp    80101b17 <ialloc+0x47>
80101af6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101afd:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101b00:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101b03:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101b06:	53                   	push   %ebx
80101b07:	e8 e4 e6 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101b0c:	83 c4 10             	add    $0x10,%esp
80101b0f:	3b 3d bc 25 11 80    	cmp    0x801125bc,%edi
80101b15:	73 69                	jae    80101b80 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101b17:	89 f8                	mov    %edi,%eax
80101b19:	83 ec 08             	sub    $0x8,%esp
80101b1c:	c1 e8 03             	shr    $0x3,%eax
80101b1f:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101b25:	50                   	push   %eax
80101b26:	56                   	push   %esi
80101b27:	e8 a4 e5 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101b2c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101b2f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101b31:	89 f8                	mov    %edi,%eax
80101b33:	83 e0 07             	and    $0x7,%eax
80101b36:	c1 e0 06             	shl    $0x6,%eax
80101b39:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101b3d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101b41:	75 bd                	jne    80101b00 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101b43:	83 ec 04             	sub    $0x4,%esp
80101b46:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b49:	6a 40                	push   $0x40
80101b4b:	6a 00                	push   $0x0
80101b4d:	51                   	push   %ecx
80101b4e:	e8 bd 35 00 00       	call   80105110 <memset>
      dip->type = type;
80101b53:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b57:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b5a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101b5d:	89 1c 24             	mov    %ebx,(%esp)
80101b60:	e8 ab 18 00 00       	call   80103410 <log_write>
      brelse(bp);
80101b65:	89 1c 24             	mov    %ebx,(%esp)
80101b68:	e8 83 e6 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101b6d:	83 c4 10             	add    $0x10,%esp
}
80101b70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101b73:	89 fa                	mov    %edi,%edx
}
80101b75:	5b                   	pop    %ebx
      return iget(dev, inum);
80101b76:	89 f0                	mov    %esi,%eax
}
80101b78:	5e                   	pop    %esi
80101b79:	5f                   	pop    %edi
80101b7a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101b7b:	e9 90 fc ff ff       	jmp    80101810 <iget>
  panic("ialloc: no inodes");
80101b80:	83 ec 0c             	sub    $0xc,%esp
80101b83:	68 50 80 10 80       	push   $0x80108050
80101b88:	e8 f3 e7 ff ff       	call   80100380 <panic>
80101b8d:	8d 76 00             	lea    0x0(%esi),%esi

80101b90 <iupdate>:
{
80101b90:	55                   	push   %ebp
80101b91:	89 e5                	mov    %esp,%ebp
80101b93:	56                   	push   %esi
80101b94:	53                   	push   %ebx
80101b95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b98:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b9b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b9e:	83 ec 08             	sub    $0x8,%esp
80101ba1:	c1 e8 03             	shr    $0x3,%eax
80101ba4:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101baa:	50                   	push   %eax
80101bab:	ff 73 a4             	pushl  -0x5c(%ebx)
80101bae:	e8 1d e5 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101bb3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bb7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101bba:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101bbc:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101bbf:	83 e0 07             	and    $0x7,%eax
80101bc2:	c1 e0 06             	shl    $0x6,%eax
80101bc5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101bc9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101bcc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bd0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101bd3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101bd7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101bdb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101bdf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101be3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101be7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101bea:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bed:	6a 34                	push   $0x34
80101bef:	53                   	push   %ebx
80101bf0:	50                   	push   %eax
80101bf1:	e8 ba 35 00 00       	call   801051b0 <memmove>
  log_write(bp);
80101bf6:	89 34 24             	mov    %esi,(%esp)
80101bf9:	e8 12 18 00 00       	call   80103410 <log_write>
  brelse(bp);
80101bfe:	89 75 08             	mov    %esi,0x8(%ebp)
80101c01:	83 c4 10             	add    $0x10,%esp
}
80101c04:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c07:	5b                   	pop    %ebx
80101c08:	5e                   	pop    %esi
80101c09:	5d                   	pop    %ebp
  brelse(bp);
80101c0a:	e9 e1 e5 ff ff       	jmp    801001f0 <brelse>
80101c0f:	90                   	nop

80101c10 <idup>:
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	53                   	push   %ebx
80101c14:	83 ec 10             	sub    $0x10,%esp
80101c17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101c1a:	68 60 09 11 80       	push   $0x80110960
80101c1f:	e8 2c 34 00 00       	call   80105050 <acquire>
  ip->ref++;
80101c24:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c28:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101c2f:	e8 bc 33 00 00       	call   80104ff0 <release>
}
80101c34:	89 d8                	mov    %ebx,%eax
80101c36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c39:	c9                   	leave  
80101c3a:	c3                   	ret    
80101c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101c3f:	90                   	nop

80101c40 <ilock>:
{
80101c40:	55                   	push   %ebp
80101c41:	89 e5                	mov    %esp,%ebp
80101c43:	56                   	push   %esi
80101c44:	53                   	push   %ebx
80101c45:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101c48:	85 db                	test   %ebx,%ebx
80101c4a:	0f 84 b7 00 00 00    	je     80101d07 <ilock+0xc7>
80101c50:	8b 53 08             	mov    0x8(%ebx),%edx
80101c53:	85 d2                	test   %edx,%edx
80101c55:	0f 8e ac 00 00 00    	jle    80101d07 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101c5b:	83 ec 0c             	sub    $0xc,%esp
80101c5e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c61:	50                   	push   %eax
80101c62:	e8 29 31 00 00       	call   80104d90 <acquiresleep>
  if(ip->valid == 0){
80101c67:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101c6a:	83 c4 10             	add    $0x10,%esp
80101c6d:	85 c0                	test   %eax,%eax
80101c6f:	74 0f                	je     80101c80 <ilock+0x40>
}
80101c71:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c74:	5b                   	pop    %ebx
80101c75:	5e                   	pop    %esi
80101c76:	5d                   	pop    %ebp
80101c77:	c3                   	ret    
80101c78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c7f:	90                   	nop
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c80:	8b 43 04             	mov    0x4(%ebx),%eax
80101c83:	83 ec 08             	sub    $0x8,%esp
80101c86:	c1 e8 03             	shr    $0x3,%eax
80101c89:	03 05 c8 25 11 80    	add    0x801125c8,%eax
80101c8f:	50                   	push   %eax
80101c90:	ff 33                	pushl  (%ebx)
80101c92:	e8 39 e4 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c97:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c9a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c9c:	8b 43 04             	mov    0x4(%ebx),%eax
80101c9f:	83 e0 07             	and    $0x7,%eax
80101ca2:	c1 e0 06             	shl    $0x6,%eax
80101ca5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101ca9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cac:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101caf:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101cb3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101cb7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101cbb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101cbf:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101cc3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101cc7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101ccb:	8b 50 fc             	mov    -0x4(%eax),%edx
80101cce:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cd1:	6a 34                	push   $0x34
80101cd3:	50                   	push   %eax
80101cd4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101cd7:	50                   	push   %eax
80101cd8:	e8 d3 34 00 00       	call   801051b0 <memmove>
    brelse(bp);
80101cdd:	89 34 24             	mov    %esi,(%esp)
80101ce0:	e8 0b e5 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101ce5:	83 c4 10             	add    $0x10,%esp
80101ce8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101ced:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101cf4:	0f 85 77 ff ff ff    	jne    80101c71 <ilock+0x31>
      panic("ilock: no type");
80101cfa:	83 ec 0c             	sub    $0xc,%esp
80101cfd:	68 68 80 10 80       	push   $0x80108068
80101d02:	e8 79 e6 ff ff       	call   80100380 <panic>
    panic("ilock");
80101d07:	83 ec 0c             	sub    $0xc,%esp
80101d0a:	68 62 80 10 80       	push   $0x80108062
80101d0f:	e8 6c e6 ff ff       	call   80100380 <panic>
80101d14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101d1f:	90                   	nop

80101d20 <iunlock>:
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	56                   	push   %esi
80101d24:	53                   	push   %ebx
80101d25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d28:	85 db                	test   %ebx,%ebx
80101d2a:	74 28                	je     80101d54 <iunlock+0x34>
80101d2c:	83 ec 0c             	sub    $0xc,%esp
80101d2f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d32:	56                   	push   %esi
80101d33:	e8 f8 30 00 00       	call   80104e30 <holdingsleep>
80101d38:	83 c4 10             	add    $0x10,%esp
80101d3b:	85 c0                	test   %eax,%eax
80101d3d:	74 15                	je     80101d54 <iunlock+0x34>
80101d3f:	8b 43 08             	mov    0x8(%ebx),%eax
80101d42:	85 c0                	test   %eax,%eax
80101d44:	7e 0e                	jle    80101d54 <iunlock+0x34>
  releasesleep(&ip->lock);
80101d46:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101d49:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d4c:	5b                   	pop    %ebx
80101d4d:	5e                   	pop    %esi
80101d4e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101d4f:	e9 9c 30 00 00       	jmp    80104df0 <releasesleep>
    panic("iunlock");
80101d54:	83 ec 0c             	sub    $0xc,%esp
80101d57:	68 77 80 10 80       	push   $0x80108077
80101d5c:	e8 1f e6 ff ff       	call   80100380 <panic>
80101d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d6f:	90                   	nop

80101d70 <iput>:
{
80101d70:	55                   	push   %ebp
80101d71:	89 e5                	mov    %esp,%ebp
80101d73:	57                   	push   %edi
80101d74:	56                   	push   %esi
80101d75:	53                   	push   %ebx
80101d76:	83 ec 28             	sub    $0x28,%esp
80101d79:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101d7c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101d7f:	57                   	push   %edi
80101d80:	e8 0b 30 00 00       	call   80104d90 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101d85:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101d88:	83 c4 10             	add    $0x10,%esp
80101d8b:	85 d2                	test   %edx,%edx
80101d8d:	74 07                	je     80101d96 <iput+0x26>
80101d8f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101d94:	74 32                	je     80101dc8 <iput+0x58>
  releasesleep(&ip->lock);
80101d96:	83 ec 0c             	sub    $0xc,%esp
80101d99:	57                   	push   %edi
80101d9a:	e8 51 30 00 00       	call   80104df0 <releasesleep>
  acquire(&icache.lock);
80101d9f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101da6:	e8 a5 32 00 00       	call   80105050 <acquire>
  ip->ref--;
80101dab:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101daf:	83 c4 10             	add    $0x10,%esp
80101db2:	c7 45 08 60 09 11 80 	movl   $0x80110960,0x8(%ebp)
}
80101db9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dbc:	5b                   	pop    %ebx
80101dbd:	5e                   	pop    %esi
80101dbe:	5f                   	pop    %edi
80101dbf:	5d                   	pop    %ebp
  release(&icache.lock);
80101dc0:	e9 2b 32 00 00       	jmp    80104ff0 <release>
80101dc5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101dc8:	83 ec 0c             	sub    $0xc,%esp
80101dcb:	68 60 09 11 80       	push   $0x80110960
80101dd0:	e8 7b 32 00 00       	call   80105050 <acquire>
    int r = ip->ref;
80101dd5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101dd8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ddf:	e8 0c 32 00 00       	call   80104ff0 <release>
    if(r == 1){
80101de4:	83 c4 10             	add    $0x10,%esp
80101de7:	83 fe 01             	cmp    $0x1,%esi
80101dea:	75 aa                	jne    80101d96 <iput+0x26>
80101dec:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101df2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101df5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101df8:	89 cf                	mov    %ecx,%edi
80101dfa:	eb 0b                	jmp    80101e07 <iput+0x97>
80101dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101e00:	83 c6 04             	add    $0x4,%esi
80101e03:	39 fe                	cmp    %edi,%esi
80101e05:	74 19                	je     80101e20 <iput+0xb0>
    if(ip->addrs[i]){
80101e07:	8b 16                	mov    (%esi),%edx
80101e09:	85 d2                	test   %edx,%edx
80101e0b:	74 f3                	je     80101e00 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101e0d:	8b 03                	mov    (%ebx),%eax
80101e0f:	e8 6c f8 ff ff       	call   80101680 <bfree>
      ip->addrs[i] = 0;
80101e14:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101e1a:	eb e4                	jmp    80101e00 <iput+0x90>
80101e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101e20:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101e26:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e29:	85 c0                	test   %eax,%eax
80101e2b:	75 2d                	jne    80101e5a <iput+0xea>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101e2d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101e30:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101e37:	53                   	push   %ebx
80101e38:	e8 53 fd ff ff       	call   80101b90 <iupdate>
      ip->type = 0;
80101e3d:	31 c0                	xor    %eax,%eax
80101e3f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101e43:	89 1c 24             	mov    %ebx,(%esp)
80101e46:	e8 45 fd ff ff       	call   80101b90 <iupdate>
      ip->valid = 0;
80101e4b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101e52:	83 c4 10             	add    $0x10,%esp
80101e55:	e9 3c ff ff ff       	jmp    80101d96 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e5a:	83 ec 08             	sub    $0x8,%esp
80101e5d:	50                   	push   %eax
80101e5e:	ff 33                	pushl  (%ebx)
80101e60:	e8 6b e2 ff ff       	call   801000d0 <bread>
80101e65:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e68:	83 c4 10             	add    $0x10,%esp
80101e6b:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e71:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e74:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e77:	89 cf                	mov    %ecx,%edi
80101e79:	eb 0c                	jmp    80101e87 <iput+0x117>
80101e7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101e7f:	90                   	nop
80101e80:	83 c6 04             	add    $0x4,%esi
80101e83:	39 f7                	cmp    %esi,%edi
80101e85:	74 0f                	je     80101e96 <iput+0x126>
      if(a[j])
80101e87:	8b 16                	mov    (%esi),%edx
80101e89:	85 d2                	test   %edx,%edx
80101e8b:	74 f3                	je     80101e80 <iput+0x110>
        bfree(ip->dev, a[j]);
80101e8d:	8b 03                	mov    (%ebx),%eax
80101e8f:	e8 ec f7 ff ff       	call   80101680 <bfree>
80101e94:	eb ea                	jmp    80101e80 <iput+0x110>
    brelse(bp);
80101e96:	83 ec 0c             	sub    $0xc,%esp
80101e99:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e9c:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e9f:	e8 4c e3 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ea4:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101eaa:	8b 03                	mov    (%ebx),%eax
80101eac:	e8 cf f7 ff ff       	call   80101680 <bfree>
    ip->addrs[NDIRECT] = 0;
80101eb1:	83 c4 10             	add    $0x10,%esp
80101eb4:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101ebb:	00 00 00 
80101ebe:	e9 6a ff ff ff       	jmp    80101e2d <iput+0xbd>
80101ec3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ed0 <iunlockput>:
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	56                   	push   %esi
80101ed4:	53                   	push   %ebx
80101ed5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ed8:	85 db                	test   %ebx,%ebx
80101eda:	74 34                	je     80101f10 <iunlockput+0x40>
80101edc:	83 ec 0c             	sub    $0xc,%esp
80101edf:	8d 73 0c             	lea    0xc(%ebx),%esi
80101ee2:	56                   	push   %esi
80101ee3:	e8 48 2f 00 00       	call   80104e30 <holdingsleep>
80101ee8:	83 c4 10             	add    $0x10,%esp
80101eeb:	85 c0                	test   %eax,%eax
80101eed:	74 21                	je     80101f10 <iunlockput+0x40>
80101eef:	8b 43 08             	mov    0x8(%ebx),%eax
80101ef2:	85 c0                	test   %eax,%eax
80101ef4:	7e 1a                	jle    80101f10 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101ef6:	83 ec 0c             	sub    $0xc,%esp
80101ef9:	56                   	push   %esi
80101efa:	e8 f1 2e 00 00       	call   80104df0 <releasesleep>
  iput(ip);
80101eff:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101f02:	83 c4 10             	add    $0x10,%esp
}
80101f05:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101f08:	5b                   	pop    %ebx
80101f09:	5e                   	pop    %esi
80101f0a:	5d                   	pop    %ebp
  iput(ip);
80101f0b:	e9 60 fe ff ff       	jmp    80101d70 <iput>
    panic("iunlock");
80101f10:	83 ec 0c             	sub    $0xc,%esp
80101f13:	68 77 80 10 80       	push   $0x80108077
80101f18:	e8 63 e4 ff ff       	call   80100380 <panic>
80101f1d:	8d 76 00             	lea    0x0(%esi),%esi

80101f20 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101f20:	55                   	push   %ebp
80101f21:	89 e5                	mov    %esp,%ebp
80101f23:	8b 55 08             	mov    0x8(%ebp),%edx
80101f26:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101f29:	8b 0a                	mov    (%edx),%ecx
80101f2b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101f2e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101f31:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101f34:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101f38:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101f3b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101f3f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101f43:	8b 52 58             	mov    0x58(%edx),%edx
80101f46:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f49:	5d                   	pop    %ebp
80101f4a:	c3                   	ret    
80101f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f4f:	90                   	nop

80101f50 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101f50:	55                   	push   %ebp
80101f51:	89 e5                	mov    %esp,%ebp
80101f53:	57                   	push   %edi
80101f54:	56                   	push   %esi
80101f55:	53                   	push   %ebx
80101f56:	83 ec 1c             	sub    $0x1c,%esp
80101f59:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101f5c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f5f:	8b 75 10             	mov    0x10(%ebp),%esi
80101f62:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101f65:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f68:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f6d:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f70:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101f73:	0f 84 a7 00 00 00    	je     80102020 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101f79:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101f7c:	8b 40 58             	mov    0x58(%eax),%eax
80101f7f:	39 c6                	cmp    %eax,%esi
80101f81:	0f 87 ba 00 00 00    	ja     80102041 <readi+0xf1>
80101f87:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f8a:	31 c9                	xor    %ecx,%ecx
80101f8c:	89 da                	mov    %ebx,%edx
80101f8e:	01 f2                	add    %esi,%edx
80101f90:	0f 92 c1             	setb   %cl
80101f93:	89 cf                	mov    %ecx,%edi
80101f95:	0f 82 a6 00 00 00    	jb     80102041 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101f9b:	89 c1                	mov    %eax,%ecx
80101f9d:	29 f1                	sub    %esi,%ecx
80101f9f:	39 d0                	cmp    %edx,%eax
80101fa1:	0f 43 cb             	cmovae %ebx,%ecx
80101fa4:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fa7:	85 c9                	test   %ecx,%ecx
80101fa9:	74 67                	je     80102012 <readi+0xc2>
80101fab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101faf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fb0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101fb3:	89 f2                	mov    %esi,%edx
80101fb5:	c1 ea 09             	shr    $0x9,%edx
80101fb8:	89 d8                	mov    %ebx,%eax
80101fba:	e8 51 f9 ff ff       	call   80101910 <bmap>
80101fbf:	83 ec 08             	sub    $0x8,%esp
80101fc2:	50                   	push   %eax
80101fc3:	ff 33                	pushl  (%ebx)
80101fc5:	e8 06 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101fca:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101fcd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fd2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101fd4:	89 f0                	mov    %esi,%eax
80101fd6:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fdb:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101fdd:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fe0:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101fe2:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fe6:	39 d9                	cmp    %ebx,%ecx
80101fe8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101feb:	83 c4 0c             	add    $0xc,%esp
80101fee:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fef:	01 df                	add    %ebx,%edi
80101ff1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101ff3:	50                   	push   %eax
80101ff4:	ff 75 e0             	pushl  -0x20(%ebp)
80101ff7:	e8 b4 31 00 00       	call   801051b0 <memmove>
    brelse(bp);
80101ffc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fff:	89 14 24             	mov    %edx,(%esp)
80102002:	e8 e9 e1 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102007:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010200a:	83 c4 10             	add    $0x10,%esp
8010200d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80102010:	77 9e                	ja     80101fb0 <readi+0x60>
  }
  return n;
80102012:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80102015:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102018:	5b                   	pop    %ebx
80102019:	5e                   	pop    %esi
8010201a:	5f                   	pop    %edi
8010201b:	5d                   	pop    %ebp
8010201c:	c3                   	ret    
8010201d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102020:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102024:	66 83 f8 09          	cmp    $0x9,%ax
80102028:	77 17                	ja     80102041 <readi+0xf1>
8010202a:	8b 04 c5 00 09 11 80 	mov    -0x7feef700(,%eax,8),%eax
80102031:	85 c0                	test   %eax,%eax
80102033:	74 0c                	je     80102041 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102035:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010203b:	5b                   	pop    %ebx
8010203c:	5e                   	pop    %esi
8010203d:	5f                   	pop    %edi
8010203e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010203f:	ff e0                	jmp    *%eax
      return -1;
80102041:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102046:	eb cd                	jmp    80102015 <readi+0xc5>
80102048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010204f:	90                   	nop

80102050 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80102050:	55                   	push   %ebp
80102051:	89 e5                	mov    %esp,%ebp
80102053:	57                   	push   %edi
80102054:	56                   	push   %esi
80102055:	53                   	push   %ebx
80102056:	83 ec 1c             	sub    $0x1c,%esp
80102059:	8b 45 08             	mov    0x8(%ebp),%eax
8010205c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010205f:	8b 55 14             	mov    0x14(%ebp),%edx
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102062:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80102067:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010206a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010206d:	8b 75 10             	mov    0x10(%ebp),%esi
80102070:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(ip->type == T_DEV){
80102073:	0f 84 b7 00 00 00    	je     80102130 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80102079:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010207c:	3b 70 58             	cmp    0x58(%eax),%esi
8010207f:	0f 87 e7 00 00 00    	ja     8010216c <writei+0x11c>
80102085:	8b 7d e0             	mov    -0x20(%ebp),%edi
80102088:	31 d2                	xor    %edx,%edx
8010208a:	89 f8                	mov    %edi,%eax
8010208c:	01 f0                	add    %esi,%eax
8010208e:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102091:	3d 00 18 01 00       	cmp    $0x11800,%eax
80102096:	0f 87 d0 00 00 00    	ja     8010216c <writei+0x11c>
8010209c:	85 d2                	test   %edx,%edx
8010209e:	0f 85 c8 00 00 00    	jne    8010216c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801020ab:	85 ff                	test   %edi,%edi
801020ad:	74 72                	je     80102121 <writei+0xd1>
801020af:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020b0:	8b 7d d8             	mov    -0x28(%ebp),%edi
801020b3:	89 f2                	mov    %esi,%edx
801020b5:	c1 ea 09             	shr    $0x9,%edx
801020b8:	89 f8                	mov    %edi,%eax
801020ba:	e8 51 f8 ff ff       	call   80101910 <bmap>
801020bf:	83 ec 08             	sub    $0x8,%esp
801020c2:	50                   	push   %eax
801020c3:	ff 37                	pushl  (%edi)
801020c5:	e8 06 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801020ca:	b9 00 02 00 00       	mov    $0x200,%ecx
801020cf:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020d2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020d5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801020d7:	89 f0                	mov    %esi,%eax
801020d9:	25 ff 01 00 00       	and    $0x1ff,%eax
801020de:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801020e0:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801020e4:	39 d9                	cmp    %ebx,%ecx
801020e6:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801020e9:	83 c4 0c             	add    $0xc,%esp
801020ec:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020ed:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
801020ef:	ff 75 dc             	pushl  -0x24(%ebp)
801020f2:	50                   	push   %eax
801020f3:	e8 b8 30 00 00       	call   801051b0 <memmove>
    log_write(bp);
801020f8:	89 3c 24             	mov    %edi,(%esp)
801020fb:	e8 10 13 00 00       	call   80103410 <log_write>
    brelse(bp);
80102100:	89 3c 24             	mov    %edi,(%esp)
80102103:	e8 e8 e0 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102108:	01 5d e4             	add    %ebx,-0x1c(%ebp)
8010210b:	83 c4 10             	add    $0x10,%esp
8010210e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102111:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102114:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80102117:	77 97                	ja     801020b0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102119:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010211c:	3b 70 58             	cmp    0x58(%eax),%esi
8010211f:	77 37                	ja     80102158 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102121:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102124:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102127:	5b                   	pop    %ebx
80102128:	5e                   	pop    %esi
80102129:	5f                   	pop    %edi
8010212a:	5d                   	pop    %ebp
8010212b:	c3                   	ret    
8010212c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102130:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102134:	66 83 f8 09          	cmp    $0x9,%ax
80102138:	77 32                	ja     8010216c <writei+0x11c>
8010213a:	8b 04 c5 04 09 11 80 	mov    -0x7feef6fc(,%eax,8),%eax
80102141:	85 c0                	test   %eax,%eax
80102143:	74 27                	je     8010216c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102145:	89 55 10             	mov    %edx,0x10(%ebp)
}
80102148:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010214b:	5b                   	pop    %ebx
8010214c:	5e                   	pop    %esi
8010214d:	5f                   	pop    %edi
8010214e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010214f:	ff e0                	jmp    *%eax
80102151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102158:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010215b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010215e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102161:	50                   	push   %eax
80102162:	e8 29 fa ff ff       	call   80101b90 <iupdate>
80102167:	83 c4 10             	add    $0x10,%esp
8010216a:	eb b5                	jmp    80102121 <writei+0xd1>
      return -1;
8010216c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102171:	eb b1                	jmp    80102124 <writei+0xd4>
80102173:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010217a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102180 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102180:	55                   	push   %ebp
80102181:	89 e5                	mov    %esp,%ebp
80102183:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102186:	6a 0e                	push   $0xe
80102188:	ff 75 0c             	pushl  0xc(%ebp)
8010218b:	ff 75 08             	pushl  0x8(%ebp)
8010218e:	e8 8d 30 00 00       	call   80105220 <strncmp>
}
80102193:	c9                   	leave  
80102194:	c3                   	ret    
80102195:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801021a0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021a0:	55                   	push   %ebp
801021a1:	89 e5                	mov    %esp,%ebp
801021a3:	57                   	push   %edi
801021a4:	56                   	push   %esi
801021a5:	53                   	push   %ebx
801021a6:	83 ec 1c             	sub    $0x1c,%esp
801021a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
801021ac:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801021b1:	0f 85 85 00 00 00    	jne    8010223c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
801021b7:	8b 53 58             	mov    0x58(%ebx),%edx
801021ba:	31 ff                	xor    %edi,%edi
801021bc:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021bf:	85 d2                	test   %edx,%edx
801021c1:	74 3e                	je     80102201 <dirlookup+0x61>
801021c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021c7:	90                   	nop
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021c8:	6a 10                	push   $0x10
801021ca:	57                   	push   %edi
801021cb:	56                   	push   %esi
801021cc:	53                   	push   %ebx
801021cd:	e8 7e fd ff ff       	call   80101f50 <readi>
801021d2:	83 c4 10             	add    $0x10,%esp
801021d5:	83 f8 10             	cmp    $0x10,%eax
801021d8:	75 55                	jne    8010222f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
801021da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021df:	74 18                	je     801021f9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
801021e1:	83 ec 04             	sub    $0x4,%esp
801021e4:	8d 45 da             	lea    -0x26(%ebp),%eax
801021e7:	6a 0e                	push   $0xe
801021e9:	50                   	push   %eax
801021ea:	ff 75 0c             	pushl  0xc(%ebp)
801021ed:	e8 2e 30 00 00       	call   80105220 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801021f2:	83 c4 10             	add    $0x10,%esp
801021f5:	85 c0                	test   %eax,%eax
801021f7:	74 17                	je     80102210 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021f9:	83 c7 10             	add    $0x10,%edi
801021fc:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021ff:	72 c7                	jb     801021c8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102201:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102204:	31 c0                	xor    %eax,%eax
}
80102206:	5b                   	pop    %ebx
80102207:	5e                   	pop    %esi
80102208:	5f                   	pop    %edi
80102209:	5d                   	pop    %ebp
8010220a:	c3                   	ret    
8010220b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010220f:	90                   	nop
      if(poff)
80102210:	8b 45 10             	mov    0x10(%ebp),%eax
80102213:	85 c0                	test   %eax,%eax
80102215:	74 05                	je     8010221c <dirlookup+0x7c>
        *poff = off;
80102217:	8b 45 10             	mov    0x10(%ebp),%eax
8010221a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
8010221c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102220:	8b 03                	mov    (%ebx),%eax
80102222:	e8 e9 f5 ff ff       	call   80101810 <iget>
}
80102227:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010222a:	5b                   	pop    %ebx
8010222b:	5e                   	pop    %esi
8010222c:	5f                   	pop    %edi
8010222d:	5d                   	pop    %ebp
8010222e:	c3                   	ret    
      panic("dirlookup read");
8010222f:	83 ec 0c             	sub    $0xc,%esp
80102232:	68 91 80 10 80       	push   $0x80108091
80102237:	e8 44 e1 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
8010223c:	83 ec 0c             	sub    $0xc,%esp
8010223f:	68 7f 80 10 80       	push   $0x8010807f
80102244:	e8 37 e1 ff ff       	call   80100380 <panic>
80102249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102250 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102250:	55                   	push   %ebp
80102251:	89 e5                	mov    %esp,%ebp
80102253:	57                   	push   %edi
80102254:	56                   	push   %esi
80102255:	53                   	push   %ebx
80102256:	89 c3                	mov    %eax,%ebx
80102258:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010225b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010225e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102261:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102264:	0f 84 64 01 00 00    	je     801023ce <namex+0x17e>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010226a:	e8 21 1c 00 00       	call   80103e90 <myproc>
  acquire(&icache.lock);
8010226f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102272:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80102275:	68 60 09 11 80       	push   $0x80110960
8010227a:	e8 d1 2d 00 00       	call   80105050 <acquire>
  ip->ref++;
8010227f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102283:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010228a:	e8 61 2d 00 00       	call   80104ff0 <release>
8010228f:	83 c4 10             	add    $0x10,%esp
80102292:	eb 07                	jmp    8010229b <namex+0x4b>
80102294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102298:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010229b:	0f b6 03             	movzbl (%ebx),%eax
8010229e:	3c 2f                	cmp    $0x2f,%al
801022a0:	74 f6                	je     80102298 <namex+0x48>
  if(*path == 0)
801022a2:	84 c0                	test   %al,%al
801022a4:	0f 84 06 01 00 00    	je     801023b0 <namex+0x160>
  while(*path != '/' && *path != 0)
801022aa:	0f b6 03             	movzbl (%ebx),%eax
801022ad:	84 c0                	test   %al,%al
801022af:	0f 84 10 01 00 00    	je     801023c5 <namex+0x175>
801022b5:	89 df                	mov    %ebx,%edi
801022b7:	3c 2f                	cmp    $0x2f,%al
801022b9:	0f 84 06 01 00 00    	je     801023c5 <namex+0x175>
801022bf:	90                   	nop
801022c0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
801022c4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
801022c7:	3c 2f                	cmp    $0x2f,%al
801022c9:	74 04                	je     801022cf <namex+0x7f>
801022cb:	84 c0                	test   %al,%al
801022cd:	75 f1                	jne    801022c0 <namex+0x70>
  len = path - s;
801022cf:	89 f8                	mov    %edi,%eax
801022d1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
801022d3:	83 f8 0d             	cmp    $0xd,%eax
801022d6:	0f 8e ac 00 00 00    	jle    80102388 <namex+0x138>
    memmove(name, s, DIRSIZ);
801022dc:	83 ec 04             	sub    $0x4,%esp
801022df:	6a 0e                	push   $0xe
801022e1:	53                   	push   %ebx
    path++;
801022e2:	89 fb                	mov    %edi,%ebx
    memmove(name, s, DIRSIZ);
801022e4:	ff 75 e4             	pushl  -0x1c(%ebp)
801022e7:	e8 c4 2e 00 00       	call   801051b0 <memmove>
801022ec:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801022ef:	80 3f 2f             	cmpb   $0x2f,(%edi)
801022f2:	75 0c                	jne    80102300 <namex+0xb0>
801022f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801022f8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801022fb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801022fe:	74 f8                	je     801022f8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102300:	83 ec 0c             	sub    $0xc,%esp
80102303:	56                   	push   %esi
80102304:	e8 37 f9 ff ff       	call   80101c40 <ilock>
    if(ip->type != T_DIR){
80102309:	83 c4 10             	add    $0x10,%esp
8010230c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102311:	0f 85 cd 00 00 00    	jne    801023e4 <namex+0x194>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102317:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010231a:	85 c0                	test   %eax,%eax
8010231c:	74 09                	je     80102327 <namex+0xd7>
8010231e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102321:	0f 84 22 01 00 00    	je     80102449 <namex+0x1f9>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102327:	83 ec 04             	sub    $0x4,%esp
8010232a:	6a 00                	push   $0x0
8010232c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010232f:	56                   	push   %esi
80102330:	e8 6b fe ff ff       	call   801021a0 <dirlookup>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102335:	8d 56 0c             	lea    0xc(%esi),%edx
    if((next = dirlookup(ip, name, 0)) == 0){
80102338:	83 c4 10             	add    $0x10,%esp
8010233b:	89 c7                	mov    %eax,%edi
8010233d:	85 c0                	test   %eax,%eax
8010233f:	0f 84 e1 00 00 00    	je     80102426 <namex+0x1d6>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102345:	83 ec 0c             	sub    $0xc,%esp
80102348:	89 55 e0             	mov    %edx,-0x20(%ebp)
8010234b:	52                   	push   %edx
8010234c:	e8 df 2a 00 00       	call   80104e30 <holdingsleep>
80102351:	83 c4 10             	add    $0x10,%esp
80102354:	85 c0                	test   %eax,%eax
80102356:	0f 84 30 01 00 00    	je     8010248c <namex+0x23c>
8010235c:	8b 56 08             	mov    0x8(%esi),%edx
8010235f:	85 d2                	test   %edx,%edx
80102361:	0f 8e 25 01 00 00    	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102367:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010236a:	83 ec 0c             	sub    $0xc,%esp
8010236d:	52                   	push   %edx
8010236e:	e8 7d 2a 00 00       	call   80104df0 <releasesleep>
  iput(ip);
80102373:	89 34 24             	mov    %esi,(%esp)
80102376:	89 fe                	mov    %edi,%esi
80102378:	e8 f3 f9 ff ff       	call   80101d70 <iput>
8010237d:	83 c4 10             	add    $0x10,%esp
80102380:	e9 16 ff ff ff       	jmp    8010229b <namex+0x4b>
80102385:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102388:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010238b:	8d 14 01             	lea    (%ecx,%eax,1),%edx
    memmove(name, s, len);
8010238e:	83 ec 04             	sub    $0x4,%esp
80102391:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102394:	50                   	push   %eax
80102395:	53                   	push   %ebx
    name[len] = 0;
80102396:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102398:	ff 75 e4             	pushl  -0x1c(%ebp)
8010239b:	e8 10 2e 00 00       	call   801051b0 <memmove>
    name[len] = 0;
801023a0:	8b 55 e0             	mov    -0x20(%ebp),%edx
801023a3:	83 c4 10             	add    $0x10,%esp
801023a6:	c6 02 00             	movb   $0x0,(%edx)
801023a9:	e9 41 ff ff ff       	jmp    801022ef <namex+0x9f>
801023ae:	66 90                	xchg   %ax,%ax
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
801023b0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801023b3:	85 c0                	test   %eax,%eax
801023b5:	0f 85 be 00 00 00    	jne    80102479 <namex+0x229>
    iput(ip);
    return 0;
  }
  return ip;
}
801023bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023be:	89 f0                	mov    %esi,%eax
801023c0:	5b                   	pop    %ebx
801023c1:	5e                   	pop    %esi
801023c2:	5f                   	pop    %edi
801023c3:	5d                   	pop    %ebp
801023c4:	c3                   	ret    
  while(*path != '/' && *path != 0)
801023c5:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801023c8:	89 df                	mov    %ebx,%edi
801023ca:	31 c0                	xor    %eax,%eax
801023cc:	eb c0                	jmp    8010238e <namex+0x13e>
    ip = iget(ROOTDEV, ROOTINO);
801023ce:	ba 01 00 00 00       	mov    $0x1,%edx
801023d3:	b8 01 00 00 00       	mov    $0x1,%eax
801023d8:	e8 33 f4 ff ff       	call   80101810 <iget>
801023dd:	89 c6                	mov    %eax,%esi
801023df:	e9 b7 fe ff ff       	jmp    8010229b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801023e4:	83 ec 0c             	sub    $0xc,%esp
801023e7:	8d 5e 0c             	lea    0xc(%esi),%ebx
801023ea:	53                   	push   %ebx
801023eb:	e8 40 2a 00 00       	call   80104e30 <holdingsleep>
801023f0:	83 c4 10             	add    $0x10,%esp
801023f3:	85 c0                	test   %eax,%eax
801023f5:	0f 84 91 00 00 00    	je     8010248c <namex+0x23c>
801023fb:	8b 46 08             	mov    0x8(%esi),%eax
801023fe:	85 c0                	test   %eax,%eax
80102400:	0f 8e 86 00 00 00    	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102406:	83 ec 0c             	sub    $0xc,%esp
80102409:	53                   	push   %ebx
8010240a:	e8 e1 29 00 00       	call   80104df0 <releasesleep>
  iput(ip);
8010240f:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102412:	31 f6                	xor    %esi,%esi
  iput(ip);
80102414:	e8 57 f9 ff ff       	call   80101d70 <iput>
      return 0;
80102419:	83 c4 10             	add    $0x10,%esp
}
8010241c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010241f:	89 f0                	mov    %esi,%eax
80102421:	5b                   	pop    %ebx
80102422:	5e                   	pop    %esi
80102423:	5f                   	pop    %edi
80102424:	5d                   	pop    %ebp
80102425:	c3                   	ret    
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102426:	83 ec 0c             	sub    $0xc,%esp
80102429:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010242c:	52                   	push   %edx
8010242d:	e8 fe 29 00 00       	call   80104e30 <holdingsleep>
80102432:	83 c4 10             	add    $0x10,%esp
80102435:	85 c0                	test   %eax,%eax
80102437:	74 53                	je     8010248c <namex+0x23c>
80102439:	8b 4e 08             	mov    0x8(%esi),%ecx
8010243c:	85 c9                	test   %ecx,%ecx
8010243e:	7e 4c                	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102440:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102443:	83 ec 0c             	sub    $0xc,%esp
80102446:	52                   	push   %edx
80102447:	eb c1                	jmp    8010240a <namex+0x1ba>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102449:	83 ec 0c             	sub    $0xc,%esp
8010244c:	8d 5e 0c             	lea    0xc(%esi),%ebx
8010244f:	53                   	push   %ebx
80102450:	e8 db 29 00 00       	call   80104e30 <holdingsleep>
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	85 c0                	test   %eax,%eax
8010245a:	74 30                	je     8010248c <namex+0x23c>
8010245c:	8b 7e 08             	mov    0x8(%esi),%edi
8010245f:	85 ff                	test   %edi,%edi
80102461:	7e 29                	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102463:	83 ec 0c             	sub    $0xc,%esp
80102466:	53                   	push   %ebx
80102467:	e8 84 29 00 00       	call   80104df0 <releasesleep>
}
8010246c:	83 c4 10             	add    $0x10,%esp
}
8010246f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102472:	89 f0                	mov    %esi,%eax
80102474:	5b                   	pop    %ebx
80102475:	5e                   	pop    %esi
80102476:	5f                   	pop    %edi
80102477:	5d                   	pop    %ebp
80102478:	c3                   	ret    
    iput(ip);
80102479:	83 ec 0c             	sub    $0xc,%esp
8010247c:	56                   	push   %esi
    return 0;
8010247d:	31 f6                	xor    %esi,%esi
    iput(ip);
8010247f:	e8 ec f8 ff ff       	call   80101d70 <iput>
    return 0;
80102484:	83 c4 10             	add    $0x10,%esp
80102487:	e9 2f ff ff ff       	jmp    801023bb <namex+0x16b>
    panic("iunlock");
8010248c:	83 ec 0c             	sub    $0xc,%esp
8010248f:	68 77 80 10 80       	push   $0x80108077
80102494:	e8 e7 de ff ff       	call   80100380 <panic>
80102499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801024a0 <dirlink>:
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	57                   	push   %edi
801024a4:	56                   	push   %esi
801024a5:	53                   	push   %ebx
801024a6:	83 ec 20             	sub    $0x20,%esp
801024a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801024ac:	6a 00                	push   $0x0
801024ae:	ff 75 0c             	pushl  0xc(%ebp)
801024b1:	53                   	push   %ebx
801024b2:	e8 e9 fc ff ff       	call   801021a0 <dirlookup>
801024b7:	83 c4 10             	add    $0x10,%esp
801024ba:	85 c0                	test   %eax,%eax
801024bc:	75 67                	jne    80102525 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801024be:	8b 7b 58             	mov    0x58(%ebx),%edi
801024c1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801024c4:	85 ff                	test   %edi,%edi
801024c6:	74 29                	je     801024f1 <dirlink+0x51>
801024c8:	31 ff                	xor    %edi,%edi
801024ca:	8d 75 d8             	lea    -0x28(%ebp),%esi
801024cd:	eb 09                	jmp    801024d8 <dirlink+0x38>
801024cf:	90                   	nop
801024d0:	83 c7 10             	add    $0x10,%edi
801024d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801024d6:	73 19                	jae    801024f1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024d8:	6a 10                	push   $0x10
801024da:	57                   	push   %edi
801024db:	56                   	push   %esi
801024dc:	53                   	push   %ebx
801024dd:	e8 6e fa ff ff       	call   80101f50 <readi>
801024e2:	83 c4 10             	add    $0x10,%esp
801024e5:	83 f8 10             	cmp    $0x10,%eax
801024e8:	75 4e                	jne    80102538 <dirlink+0x98>
    if(de.inum == 0)
801024ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801024ef:	75 df                	jne    801024d0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801024f1:	83 ec 04             	sub    $0x4,%esp
801024f4:	8d 45 da             	lea    -0x26(%ebp),%eax
801024f7:	6a 0e                	push   $0xe
801024f9:	ff 75 0c             	pushl  0xc(%ebp)
801024fc:	50                   	push   %eax
801024fd:	e8 6e 2d 00 00       	call   80105270 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102502:	6a 10                	push   $0x10
  de.inum = inum;
80102504:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102507:	57                   	push   %edi
80102508:	56                   	push   %esi
80102509:	53                   	push   %ebx
  de.inum = inum;
8010250a:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010250e:	e8 3d fb ff ff       	call   80102050 <writei>
80102513:	83 c4 20             	add    $0x20,%esp
80102516:	83 f8 10             	cmp    $0x10,%eax
80102519:	75 2a                	jne    80102545 <dirlink+0xa5>
  return 0;
8010251b:	31 c0                	xor    %eax,%eax
}
8010251d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102520:	5b                   	pop    %ebx
80102521:	5e                   	pop    %esi
80102522:	5f                   	pop    %edi
80102523:	5d                   	pop    %ebp
80102524:	c3                   	ret    
    iput(ip);
80102525:	83 ec 0c             	sub    $0xc,%esp
80102528:	50                   	push   %eax
80102529:	e8 42 f8 ff ff       	call   80101d70 <iput>
    return -1;
8010252e:	83 c4 10             	add    $0x10,%esp
80102531:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102536:	eb e5                	jmp    8010251d <dirlink+0x7d>
      panic("dirlink read");
80102538:	83 ec 0c             	sub    $0xc,%esp
8010253b:	68 a0 80 10 80       	push   $0x801080a0
80102540:	e8 3b de ff ff       	call   80100380 <panic>
    panic("dirlink");
80102545:	83 ec 0c             	sub    $0xc,%esp
80102548:	68 da 86 10 80       	push   $0x801086da
8010254d:	e8 2e de ff ff       	call   80100380 <panic>
80102552:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102560 <namei>:

struct inode*
namei(char *path)
{
80102560:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102561:	31 d2                	xor    %edx,%edx
{
80102563:	89 e5                	mov    %esp,%ebp
80102565:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102568:	8b 45 08             	mov    0x8(%ebp),%eax
8010256b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010256e:	e8 dd fc ff ff       	call   80102250 <namex>
}
80102573:	c9                   	leave  
80102574:	c3                   	ret    
80102575:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010257c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102580 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102580:	55                   	push   %ebp
  return namex(path, 1, name);
80102581:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102586:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102588:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010258b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010258e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010258f:	e9 bc fc ff ff       	jmp    80102250 <namex>
80102594:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010259b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010259f:	90                   	nop

801025a0 <getbmap>:

int getbmap(struct inode* ip, uint n){
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
    return bmap(ip, n);
801025a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801025a6:	8b 45 08             	mov    0x8(%ebp),%eax
801025a9:	5d                   	pop    %ebp
    return bmap(ip, n);
801025aa:	e9 61 f3 ff ff       	jmp    80101910 <bmap>
801025af:	90                   	nop

801025b0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	57                   	push   %edi
801025b4:	56                   	push   %esi
801025b5:	53                   	push   %ebx
801025b6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801025b9:	85 c0                	test   %eax,%eax
801025bb:	0f 84 b4 00 00 00    	je     80102675 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801025c1:	8b 70 08             	mov    0x8(%eax),%esi
801025c4:	89 c3                	mov    %eax,%ebx
801025c6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801025cc:	0f 87 96 00 00 00    	ja     80102668 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801025d2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801025d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801025de:	66 90                	xchg   %ax,%ax
801025e0:	89 ca                	mov    %ecx,%edx
801025e2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801025e3:	83 e0 c0             	and    $0xffffffc0,%eax
801025e6:	3c 40                	cmp    $0x40,%al
801025e8:	75 f6                	jne    801025e0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025ea:	31 ff                	xor    %edi,%edi
801025ec:	ba f6 03 00 00       	mov    $0x3f6,%edx
801025f1:	89 f8                	mov    %edi,%eax
801025f3:	ee                   	out    %al,(%dx)
801025f4:	b8 01 00 00 00       	mov    $0x1,%eax
801025f9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801025fe:	ee                   	out    %al,(%dx)
801025ff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102604:	89 f0                	mov    %esi,%eax
80102606:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102607:	89 f0                	mov    %esi,%eax
80102609:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010260e:	c1 f8 08             	sar    $0x8,%eax
80102611:	ee                   	out    %al,(%dx)
80102612:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102617:	89 f8                	mov    %edi,%eax
80102619:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010261a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010261e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102623:	c1 e0 04             	shl    $0x4,%eax
80102626:	83 e0 10             	and    $0x10,%eax
80102629:	83 c8 e0             	or     $0xffffffe0,%eax
8010262c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010262d:	f6 03 04             	testb  $0x4,(%ebx)
80102630:	75 16                	jne    80102648 <idestart+0x98>
80102632:	b8 20 00 00 00       	mov    $0x20,%eax
80102637:	89 ca                	mov    %ecx,%edx
80102639:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010263a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010263d:	5b                   	pop    %ebx
8010263e:	5e                   	pop    %esi
8010263f:	5f                   	pop    %edi
80102640:	5d                   	pop    %ebp
80102641:	c3                   	ret    
80102642:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102648:	b8 30 00 00 00       	mov    $0x30,%eax
8010264d:	89 ca                	mov    %ecx,%edx
8010264f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102650:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102655:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102658:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010265d:	fc                   	cld    
8010265e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102660:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102663:	5b                   	pop    %ebx
80102664:	5e                   	pop    %esi
80102665:	5f                   	pop    %edi
80102666:	5d                   	pop    %ebp
80102667:	c3                   	ret    
    panic("incorrect blockno");
80102668:	83 ec 0c             	sub    $0xc,%esp
8010266b:	68 0c 81 10 80       	push   $0x8010810c
80102670:	e8 0b dd ff ff       	call   80100380 <panic>
    panic("idestart");
80102675:	83 ec 0c             	sub    $0xc,%esp
80102678:	68 03 81 10 80       	push   $0x80108103
8010267d:	e8 fe dc ff ff       	call   80100380 <panic>
80102682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102690 <ideinit>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102696:	68 1e 81 10 80       	push   $0x8010811e
8010269b:	68 00 26 11 80       	push   $0x80112600
801026a0:	e8 db 27 00 00       	call   80104e80 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
801026a5:	58                   	pop    %eax
801026a6:	a1 84 27 11 80       	mov    0x80112784,%eax
801026ab:	5a                   	pop    %edx
801026ac:	83 e8 01             	sub    $0x1,%eax
801026af:	50                   	push   %eax
801026b0:	6a 0e                	push   $0xe
801026b2:	e8 99 02 00 00       	call   80102950 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801026b7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026ba:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026bf:	90                   	nop
801026c0:	ec                   	in     (%dx),%al
801026c1:	83 e0 c0             	and    $0xffffffc0,%eax
801026c4:	3c 40                	cmp    $0x40,%al
801026c6:	75 f8                	jne    801026c0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026c8:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801026cd:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026d2:	ee                   	out    %al,(%dx)
801026d3:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026d8:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026dd:	eb 06                	jmp    801026e5 <ideinit+0x55>
801026df:	90                   	nop
  for(i=0; i<1000; i++){
801026e0:	83 e9 01             	sub    $0x1,%ecx
801026e3:	74 0f                	je     801026f4 <ideinit+0x64>
801026e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801026e6:	84 c0                	test   %al,%al
801026e8:	74 f6                	je     801026e0 <ideinit+0x50>
      havedisk1 = 1;
801026ea:	c7 05 e0 25 11 80 01 	movl   $0x1,0x801125e0
801026f1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026fe:	ee                   	out    %al,(%dx)
}
801026ff:	c9                   	leave  
80102700:	c3                   	ret    
80102701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102708:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010270f:	90                   	nop

80102710 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	57                   	push   %edi
80102714:	56                   	push   %esi
80102715:	53                   	push   %ebx
80102716:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102719:	68 00 26 11 80       	push   $0x80112600
8010271e:	e8 2d 29 00 00       	call   80105050 <acquire>

  if((b = idequeue) == 0){
80102723:	8b 1d e4 25 11 80    	mov    0x801125e4,%ebx
80102729:	83 c4 10             	add    $0x10,%esp
8010272c:	85 db                	test   %ebx,%ebx
8010272e:	74 63                	je     80102793 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102730:	8b 43 58             	mov    0x58(%ebx),%eax
80102733:	a3 e4 25 11 80       	mov    %eax,0x801125e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102738:	8b 33                	mov    (%ebx),%esi
8010273a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102740:	75 2f                	jne    80102771 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102742:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102747:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010274e:	66 90                	xchg   %ax,%ax
80102750:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102751:	89 c1                	mov    %eax,%ecx
80102753:	83 e1 c0             	and    $0xffffffc0,%ecx
80102756:	80 f9 40             	cmp    $0x40,%cl
80102759:	75 f5                	jne    80102750 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010275b:	a8 21                	test   $0x21,%al
8010275d:	75 12                	jne    80102771 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010275f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102762:	b9 80 00 00 00       	mov    $0x80,%ecx
80102767:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010276c:	fc                   	cld    
8010276d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010276f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102771:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102774:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102777:	83 ce 02             	or     $0x2,%esi
8010277a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010277c:	53                   	push   %ebx
8010277d:	e8 1e 22 00 00       	call   801049a0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102782:	a1 e4 25 11 80       	mov    0x801125e4,%eax
80102787:	83 c4 10             	add    $0x10,%esp
8010278a:	85 c0                	test   %eax,%eax
8010278c:	74 05                	je     80102793 <ideintr+0x83>
    idestart(idequeue);
8010278e:	e8 1d fe ff ff       	call   801025b0 <idestart>
    release(&idelock);
80102793:	83 ec 0c             	sub    $0xc,%esp
80102796:	68 00 26 11 80       	push   $0x80112600
8010279b:	e8 50 28 00 00       	call   80104ff0 <release>

  release(&idelock);
}
801027a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027a3:	5b                   	pop    %ebx
801027a4:	5e                   	pop    %esi
801027a5:	5f                   	pop    %edi
801027a6:	5d                   	pop    %ebp
801027a7:	c3                   	ret    
801027a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027af:	90                   	nop

801027b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	53                   	push   %ebx
801027b4:	83 ec 10             	sub    $0x10,%esp
801027b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801027ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801027bd:	50                   	push   %eax
801027be:	e8 6d 26 00 00       	call   80104e30 <holdingsleep>
801027c3:	83 c4 10             	add    $0x10,%esp
801027c6:	85 c0                	test   %eax,%eax
801027c8:	0f 84 c3 00 00 00    	je     80102891 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801027ce:	8b 03                	mov    (%ebx),%eax
801027d0:	83 e0 06             	and    $0x6,%eax
801027d3:	83 f8 02             	cmp    $0x2,%eax
801027d6:	0f 84 a8 00 00 00    	je     80102884 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801027dc:	8b 53 04             	mov    0x4(%ebx),%edx
801027df:	85 d2                	test   %edx,%edx
801027e1:	74 0d                	je     801027f0 <iderw+0x40>
801027e3:	a1 e0 25 11 80       	mov    0x801125e0,%eax
801027e8:	85 c0                	test   %eax,%eax
801027ea:	0f 84 87 00 00 00    	je     80102877 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027f0:	83 ec 0c             	sub    $0xc,%esp
801027f3:	68 00 26 11 80       	push   $0x80112600
801027f8:	e8 53 28 00 00       	call   80105050 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027fd:	a1 e4 25 11 80       	mov    0x801125e4,%eax
  b->qnext = 0;
80102802:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102809:	83 c4 10             	add    $0x10,%esp
8010280c:	85 c0                	test   %eax,%eax
8010280e:	74 60                	je     80102870 <iderw+0xc0>
80102810:	89 c2                	mov    %eax,%edx
80102812:	8b 40 58             	mov    0x58(%eax),%eax
80102815:	85 c0                	test   %eax,%eax
80102817:	75 f7                	jne    80102810 <iderw+0x60>
80102819:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010281c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010281e:	39 1d e4 25 11 80    	cmp    %ebx,0x801125e4
80102824:	74 3a                	je     80102860 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102826:	8b 03                	mov    (%ebx),%eax
80102828:	83 e0 06             	and    $0x6,%eax
8010282b:	83 f8 02             	cmp    $0x2,%eax
8010282e:	74 1b                	je     8010284b <iderw+0x9b>
    sleep(b, &idelock);
80102830:	83 ec 08             	sub    $0x8,%esp
80102833:	68 00 26 11 80       	push   $0x80112600
80102838:	53                   	push   %ebx
80102839:	e8 a2 20 00 00       	call   801048e0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010283e:	8b 03                	mov    (%ebx),%eax
80102840:	83 c4 10             	add    $0x10,%esp
80102843:	83 e0 06             	and    $0x6,%eax
80102846:	83 f8 02             	cmp    $0x2,%eax
80102849:	75 e5                	jne    80102830 <iderw+0x80>
  }


  release(&idelock);
8010284b:	c7 45 08 00 26 11 80 	movl   $0x80112600,0x8(%ebp)
}
80102852:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102855:	c9                   	leave  
  release(&idelock);
80102856:	e9 95 27 00 00       	jmp    80104ff0 <release>
8010285b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010285f:	90                   	nop
    idestart(b);
80102860:	89 d8                	mov    %ebx,%eax
80102862:	e8 49 fd ff ff       	call   801025b0 <idestart>
80102867:	eb bd                	jmp    80102826 <iderw+0x76>
80102869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102870:	ba e4 25 11 80       	mov    $0x801125e4,%edx
80102875:	eb a5                	jmp    8010281c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102877:	83 ec 0c             	sub    $0xc,%esp
8010287a:	68 4d 81 10 80       	push   $0x8010814d
8010287f:	e8 fc da ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102884:	83 ec 0c             	sub    $0xc,%esp
80102887:	68 38 81 10 80       	push   $0x80108138
8010288c:	e8 ef da ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102891:	83 ec 0c             	sub    $0xc,%esp
80102894:	68 22 81 10 80       	push   $0x80108122
80102899:	e8 e2 da ff ff       	call   80100380 <panic>
8010289e:	66 90                	xchg   %ax,%ax

801028a0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801028a0:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801028a1:	c7 05 34 26 11 80 00 	movl   $0xfec00000,0x80112634
801028a8:	00 c0 fe 
{
801028ab:	89 e5                	mov    %esp,%ebp
801028ad:	56                   	push   %esi
801028ae:	53                   	push   %ebx
  ioapic->reg = reg;
801028af:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801028b6:	00 00 00 
  return ioapic->data;
801028b9:	8b 15 34 26 11 80    	mov    0x80112634,%edx
801028bf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801028c2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801028c8:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801028ce:	0f b6 15 80 27 11 80 	movzbl 0x80112780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801028d5:	c1 ee 10             	shr    $0x10,%esi
801028d8:	89 f0                	mov    %esi,%eax
801028da:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801028dd:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801028e0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801028e3:	39 c2                	cmp    %eax,%edx
801028e5:	74 16                	je     801028fd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028e7:	83 ec 0c             	sub    $0xc,%esp
801028ea:	68 6c 81 10 80       	push   $0x8010816c
801028ef:	e8 ac dd ff ff       	call   801006a0 <cprintf>
  ioapic->reg = reg;
801028f4:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
801028fa:	83 c4 10             	add    $0x10,%esp
801028fd:	83 c6 21             	add    $0x21,%esi
{
80102900:	ba 10 00 00 00       	mov    $0x10,%edx
80102905:	b8 20 00 00 00       	mov    $0x20,%eax
8010290a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ioapic->reg = reg;
80102910:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102912:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
80102914:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  for(i = 0; i <= maxintr; i++){
8010291a:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
8010291d:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
80102923:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
80102926:	8d 5a 01             	lea    0x1(%edx),%ebx
  for(i = 0; i <= maxintr; i++){
80102929:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
8010292c:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
8010292e:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
80102934:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
8010293b:	39 f0                	cmp    %esi,%eax
8010293d:	75 d1                	jne    80102910 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
8010293f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102942:	5b                   	pop    %ebx
80102943:	5e                   	pop    %esi
80102944:	5d                   	pop    %ebp
80102945:	c3                   	ret    
80102946:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010294d:	8d 76 00             	lea    0x0(%esi),%esi

80102950 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102950:	55                   	push   %ebp
  ioapic->reg = reg;
80102951:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
{
80102957:	89 e5                	mov    %esp,%ebp
80102959:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010295c:	8d 50 20             	lea    0x20(%eax),%edx
8010295f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102963:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102965:	8b 0d 34 26 11 80    	mov    0x80112634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010296b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010296e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102971:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102974:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102976:	a1 34 26 11 80       	mov    0x80112634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010297b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010297e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102981:	5d                   	pop    %ebp
80102982:	c3                   	ret    
80102983:	66 90                	xchg   %ax,%ax
80102985:	66 90                	xchg   %ax,%ax
80102987:	66 90                	xchg   %ax,%ax
80102989:	66 90                	xchg   %ax,%ax
8010298b:	66 90                	xchg   %ax,%ax
8010298d:	66 90                	xchg   %ax,%ax
8010298f:	90                   	nop

80102990 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102990:	55                   	push   %ebp
80102991:	89 e5                	mov    %esp,%ebp
80102993:	53                   	push   %ebx
80102994:	83 ec 04             	sub    $0x4,%esp
80102997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010299a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801029a0:	75 76                	jne    80102a18 <kfree+0x88>
801029a2:	81 fb f0 6b 11 80    	cmp    $0x80116bf0,%ebx
801029a8:	72 6e                	jb     80102a18 <kfree+0x88>
801029aa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801029b0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801029b5:	77 61                	ja     80102a18 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801029b7:	83 ec 04             	sub    $0x4,%esp
801029ba:	68 00 10 00 00       	push   $0x1000
801029bf:	6a 01                	push   $0x1
801029c1:	53                   	push   %ebx
801029c2:	e8 49 27 00 00       	call   80105110 <memset>

  if(kmem.use_lock)
801029c7:	8b 15 74 26 11 80    	mov    0x80112674,%edx
801029cd:	83 c4 10             	add    $0x10,%esp
801029d0:	85 d2                	test   %edx,%edx
801029d2:	75 1c                	jne    801029f0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801029d4:	a1 78 26 11 80       	mov    0x80112678,%eax
801029d9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801029db:	a1 74 26 11 80       	mov    0x80112674,%eax
  kmem.freelist = r;
801029e0:	89 1d 78 26 11 80    	mov    %ebx,0x80112678
  if(kmem.use_lock)
801029e6:	85 c0                	test   %eax,%eax
801029e8:	75 1e                	jne    80102a08 <kfree+0x78>
    release(&kmem.lock);
}
801029ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029ed:	c9                   	leave  
801029ee:	c3                   	ret    
801029ef:	90                   	nop
    acquire(&kmem.lock);
801029f0:	83 ec 0c             	sub    $0xc,%esp
801029f3:	68 40 26 11 80       	push   $0x80112640
801029f8:	e8 53 26 00 00       	call   80105050 <acquire>
801029fd:	83 c4 10             	add    $0x10,%esp
80102a00:	eb d2                	jmp    801029d4 <kfree+0x44>
80102a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102a08:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102a0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a12:	c9                   	leave  
    release(&kmem.lock);
80102a13:	e9 d8 25 00 00       	jmp    80104ff0 <release>
    panic("kfree");
80102a18:	83 ec 0c             	sub    $0xc,%esp
80102a1b:	68 9e 81 10 80       	push   $0x8010819e
80102a20:	e8 5b d9 ff ff       	call   80100380 <panic>
80102a25:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102a30 <freerange>:
{
80102a30:	55                   	push   %ebp
80102a31:	89 e5                	mov    %esp,%ebp
80102a33:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a34:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a37:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a3a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a3b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a41:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a47:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a4d:	39 de                	cmp    %ebx,%esi
80102a4f:	72 23                	jb     80102a74 <freerange+0x44>
80102a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a58:	83 ec 0c             	sub    $0xc,%esp
80102a5b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a61:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a67:	50                   	push   %eax
80102a68:	e8 23 ff ff ff       	call   80102990 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a6d:	83 c4 10             	add    $0x10,%esp
80102a70:	39 f3                	cmp    %esi,%ebx
80102a72:	76 e4                	jbe    80102a58 <freerange+0x28>
}
80102a74:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a77:	5b                   	pop    %ebx
80102a78:	5e                   	pop    %esi
80102a79:	5d                   	pop    %ebp
80102a7a:	c3                   	ret    
80102a7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a7f:	90                   	nop

80102a80 <kinit2>:
{
80102a80:	55                   	push   %ebp
80102a81:	89 e5                	mov    %esp,%ebp
80102a83:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102a84:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102a87:	8b 75 0c             	mov    0xc(%ebp),%esi
80102a8a:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102a8b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a91:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a97:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a9d:	39 de                	cmp    %ebx,%esi
80102a9f:	72 23                	jb     80102ac4 <kinit2+0x44>
80102aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102aa8:	83 ec 0c             	sub    $0xc,%esp
80102aab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ab1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102ab7:	50                   	push   %eax
80102ab8:	e8 d3 fe ff ff       	call   80102990 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102abd:	83 c4 10             	add    $0x10,%esp
80102ac0:	39 de                	cmp    %ebx,%esi
80102ac2:	73 e4                	jae    80102aa8 <kinit2+0x28>
  kmem.use_lock = 1;
80102ac4:	c7 05 74 26 11 80 01 	movl   $0x1,0x80112674
80102acb:	00 00 00 
}
80102ace:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ad1:	5b                   	pop    %ebx
80102ad2:	5e                   	pop    %esi
80102ad3:	5d                   	pop    %ebp
80102ad4:	c3                   	ret    
80102ad5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102ae0 <kinit1>:
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	56                   	push   %esi
80102ae4:	53                   	push   %ebx
80102ae5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102ae8:	83 ec 08             	sub    $0x8,%esp
80102aeb:	68 a4 81 10 80       	push   $0x801081a4
80102af0:	68 40 26 11 80       	push   $0x80112640
80102af5:	e8 86 23 00 00       	call   80104e80 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102afa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102afd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b00:	c7 05 74 26 11 80 00 	movl   $0x0,0x80112674
80102b07:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102b0a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102b10:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b16:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102b1c:	39 de                	cmp    %ebx,%esi
80102b1e:	72 1c                	jb     80102b3c <kinit1+0x5c>
    kfree(p);
80102b20:	83 ec 0c             	sub    $0xc,%esp
80102b23:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102b2f:	50                   	push   %eax
80102b30:	e8 5b fe ff ff       	call   80102990 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102b35:	83 c4 10             	add    $0x10,%esp
80102b38:	39 de                	cmp    %ebx,%esi
80102b3a:	73 e4                	jae    80102b20 <kinit1+0x40>
}
80102b3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b3f:	5b                   	pop    %ebx
80102b40:	5e                   	pop    %esi
80102b41:	5d                   	pop    %ebp
80102b42:	c3                   	ret    
80102b43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b50 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
80102b50:	a1 74 26 11 80       	mov    0x80112674,%eax
80102b55:	85 c0                	test   %eax,%eax
80102b57:	75 1f                	jne    80102b78 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b59:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(r)
80102b5e:	85 c0                	test   %eax,%eax
80102b60:	74 0e                	je     80102b70 <kalloc+0x20>
    kmem.freelist = r->next;
80102b62:	8b 10                	mov    (%eax),%edx
80102b64:	89 15 78 26 11 80    	mov    %edx,0x80112678
  if(kmem.use_lock)
80102b6a:	c3                   	ret    
80102b6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b6f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102b70:	c3                   	ret    
80102b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102b78:	55                   	push   %ebp
80102b79:	89 e5                	mov    %esp,%ebp
80102b7b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102b7e:	68 40 26 11 80       	push   $0x80112640
80102b83:	e8 c8 24 00 00       	call   80105050 <acquire>
  r = kmem.freelist;
80102b88:	a1 78 26 11 80       	mov    0x80112678,%eax
  if(kmem.use_lock)
80102b8d:	8b 15 74 26 11 80    	mov    0x80112674,%edx
  if(r)
80102b93:	83 c4 10             	add    $0x10,%esp
80102b96:	85 c0                	test   %eax,%eax
80102b98:	74 08                	je     80102ba2 <kalloc+0x52>
    kmem.freelist = r->next;
80102b9a:	8b 08                	mov    (%eax),%ecx
80102b9c:	89 0d 78 26 11 80    	mov    %ecx,0x80112678
  if(kmem.use_lock)
80102ba2:	85 d2                	test   %edx,%edx
80102ba4:	74 16                	je     80102bbc <kalloc+0x6c>
    release(&kmem.lock);
80102ba6:	83 ec 0c             	sub    $0xc,%esp
80102ba9:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102bac:	68 40 26 11 80       	push   $0x80112640
80102bb1:	e8 3a 24 00 00       	call   80104ff0 <release>
  return (char*)r;
80102bb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102bb9:	83 c4 10             	add    $0x10,%esp
}
80102bbc:	c9                   	leave  
80102bbd:	c3                   	ret    
80102bbe:	66 90                	xchg   %ax,%ax

80102bc0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bc0:	ba 64 00 00 00       	mov    $0x64,%edx
80102bc5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102bc6:	a8 01                	test   $0x1,%al
80102bc8:	0f 84 c2 00 00 00    	je     80102c90 <kbdgetc+0xd0>
{
80102bce:	55                   	push   %ebp
80102bcf:	ba 60 00 00 00       	mov    $0x60,%edx
80102bd4:	89 e5                	mov    %esp,%ebp
80102bd6:	53                   	push   %ebx
80102bd7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
80102bd8:	8b 1d 7c 26 11 80    	mov    0x8011267c,%ebx
  data = inb(KBDATAP);
80102bde:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
80102be1:	3c e0                	cmp    $0xe0,%al
80102be3:	74 5b                	je     80102c40 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102be5:	89 da                	mov    %ebx,%edx
80102be7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
80102bea:	84 c0                	test   %al,%al
80102bec:	78 62                	js     80102c50 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102bee:	85 d2                	test   %edx,%edx
80102bf0:	74 09                	je     80102bfb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102bf2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102bf5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102bf8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
80102bfb:	0f b6 91 e0 82 10 80 	movzbl -0x7fef7d20(%ecx),%edx
  shift ^= togglecode[data];
80102c02:	0f b6 81 e0 81 10 80 	movzbl -0x7fef7e20(%ecx),%eax
  shift |= shiftcode[data];
80102c09:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
80102c0b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c0d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80102c0f:	89 15 7c 26 11 80    	mov    %edx,0x8011267c
  c = charcode[shift & (CTL | SHIFT)][data];
80102c15:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102c18:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80102c1b:	8b 04 85 c0 81 10 80 	mov    -0x7fef7e40(,%eax,4),%eax
80102c22:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102c26:	74 0b                	je     80102c33 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102c28:	8d 50 9f             	lea    -0x61(%eax),%edx
80102c2b:	83 fa 19             	cmp    $0x19,%edx
80102c2e:	77 48                	ja     80102c78 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102c30:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102c33:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c36:	c9                   	leave  
80102c37:	c3                   	ret    
80102c38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c3f:	90                   	nop
    shift |= E0ESC;
80102c40:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102c43:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c45:	89 1d 7c 26 11 80    	mov    %ebx,0x8011267c
}
80102c4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c4e:	c9                   	leave  
80102c4f:	c3                   	ret    
    data = (shift & E0ESC ? data : data & 0x7F);
80102c50:	83 e0 7f             	and    $0x7f,%eax
80102c53:	85 d2                	test   %edx,%edx
80102c55:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102c58:	0f b6 81 e0 82 10 80 	movzbl -0x7fef7d20(%ecx),%eax
80102c5f:	83 c8 40             	or     $0x40,%eax
80102c62:	0f b6 c0             	movzbl %al,%eax
80102c65:	f7 d0                	not    %eax
80102c67:	21 d8                	and    %ebx,%eax
}
80102c69:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    shift &= ~(shiftcode[data] | E0ESC);
80102c6c:	a3 7c 26 11 80       	mov    %eax,0x8011267c
    return 0;
80102c71:	31 c0                	xor    %eax,%eax
}
80102c73:	c9                   	leave  
80102c74:	c3                   	ret    
80102c75:	8d 76 00             	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102c78:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102c7b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102c7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c81:	c9                   	leave  
      c += 'a' - 'A';
80102c82:	83 f9 1a             	cmp    $0x1a,%ecx
80102c85:	0f 42 c2             	cmovb  %edx,%eax
}
80102c88:	c3                   	ret    
80102c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102c90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102c95:	c3                   	ret    
80102c96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c9d:	8d 76 00             	lea    0x0(%esi),%esi

80102ca0 <kbdintr>:

void
kbdintr(void)
{
80102ca0:	55                   	push   %ebp
80102ca1:	89 e5                	mov    %esp,%ebp
80102ca3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102ca6:	68 c0 2b 10 80       	push   $0x80102bc0
80102cab:	e8 c0 de ff ff       	call   80100b70 <consoleintr>
}
80102cb0:	83 c4 10             	add    $0x10,%esp
80102cb3:	c9                   	leave  
80102cb4:	c3                   	ret    
80102cb5:	66 90                	xchg   %ax,%ax
80102cb7:	66 90                	xchg   %ax,%ax
80102cb9:	66 90                	xchg   %ax,%ax
80102cbb:	66 90                	xchg   %ax,%ax
80102cbd:	66 90                	xchg   %ax,%ax
80102cbf:	90                   	nop

80102cc0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102cc0:	a1 80 26 11 80       	mov    0x80112680,%eax
80102cc5:	85 c0                	test   %eax,%eax
80102cc7:	0f 84 cb 00 00 00    	je     80102d98 <lapicinit+0xd8>
  lapic[index] = value;
80102ccd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102cd4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cd7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cda:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ce1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ce4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ce7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102cee:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102cf1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cf4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102cfb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102cfe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d01:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102d08:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d0b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d0e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102d15:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d18:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102d1b:	8b 50 30             	mov    0x30(%eax),%edx
80102d1e:	c1 ea 10             	shr    $0x10,%edx
80102d21:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102d27:	75 77                	jne    80102da0 <lapicinit+0xe0>
  lapic[index] = value;
80102d29:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102d30:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d33:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d36:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d3d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d40:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d43:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d4a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d4d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d50:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d57:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d5a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d5d:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d64:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d67:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d6a:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d71:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102d74:	8b 50 20             	mov    0x20(%eax),%edx
80102d77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d7e:	66 90                	xchg   %ax,%ax
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102d80:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d86:	80 e6 10             	and    $0x10,%dh
80102d89:	75 f5                	jne    80102d80 <lapicinit+0xc0>
  lapic[index] = value;
80102d8b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d92:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d95:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102d98:	c3                   	ret    
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102da0:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102da7:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102daa:	8b 50 20             	mov    0x20(%eax),%edx
}
80102dad:	e9 77 ff ff ff       	jmp    80102d29 <lapicinit+0x69>
80102db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102dc0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102dc0:	a1 80 26 11 80       	mov    0x80112680,%eax
80102dc5:	85 c0                	test   %eax,%eax
80102dc7:	74 07                	je     80102dd0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102dc9:	8b 40 20             	mov    0x20(%eax),%eax
80102dcc:	c1 e8 18             	shr    $0x18,%eax
80102dcf:	c3                   	ret    
    return 0;
80102dd0:	31 c0                	xor    %eax,%eax
}
80102dd2:	c3                   	ret    
80102dd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102de0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102de0:	a1 80 26 11 80       	mov    0x80112680,%eax
80102de5:	85 c0                	test   %eax,%eax
80102de7:	74 0d                	je     80102df6 <lapiceoi+0x16>
  lapic[index] = value;
80102de9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102df0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102df3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102df6:	c3                   	ret    
80102df7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dfe:	66 90                	xchg   %ax,%ax

80102e00 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102e00:	c3                   	ret    
80102e01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e0f:	90                   	nop

80102e10 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102e10:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e11:	b8 0f 00 00 00       	mov    $0xf,%eax
80102e16:	ba 70 00 00 00       	mov    $0x70,%edx
80102e1b:	89 e5                	mov    %esp,%ebp
80102e1d:	53                   	push   %ebx
80102e1e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e21:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102e24:	ee                   	out    %al,(%dx)
80102e25:	b8 0a 00 00 00       	mov    $0xa,%eax
80102e2a:	ba 71 00 00 00       	mov    $0x71,%edx
80102e2f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102e30:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102e32:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102e35:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102e3b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e3d:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102e40:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102e42:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e45:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e48:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102e4e:	a1 80 26 11 80       	mov    0x80112680,%eax
80102e53:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e59:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e5c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e63:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e66:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e69:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e70:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e73:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e76:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e7c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e7f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e85:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e88:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e8e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e91:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e97:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102e9a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e9d:	c9                   	leave  
80102e9e:	c3                   	ret    
80102e9f:	90                   	nop

80102ea0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102ea0:	55                   	push   %ebp
80102ea1:	b8 0b 00 00 00       	mov    $0xb,%eax
80102ea6:	ba 70 00 00 00       	mov    $0x70,%edx
80102eab:	89 e5                	mov    %esp,%ebp
80102ead:	57                   	push   %edi
80102eae:	56                   	push   %esi
80102eaf:	53                   	push   %ebx
80102eb0:	83 ec 4c             	sub    $0x4c,%esp
80102eb3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eb4:	ba 71 00 00 00       	mov    $0x71,%edx
80102eb9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102eba:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ebd:	bb 70 00 00 00       	mov    $0x70,%ebx
80102ec2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102ec5:	8d 76 00             	lea    0x0(%esi),%esi
80102ec8:	31 c0                	xor    %eax,%eax
80102eca:	89 da                	mov    %ebx,%edx
80102ecc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ecd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102ed2:	89 ca                	mov    %ecx,%edx
80102ed4:	ec                   	in     (%dx),%al
80102ed5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ed8:	89 da                	mov    %ebx,%edx
80102eda:	b8 02 00 00 00       	mov    $0x2,%eax
80102edf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee0:	89 ca                	mov    %ecx,%edx
80102ee2:	ec                   	in     (%dx),%al
80102ee3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ee6:	89 da                	mov    %ebx,%edx
80102ee8:	b8 04 00 00 00       	mov    $0x4,%eax
80102eed:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eee:	89 ca                	mov    %ecx,%edx
80102ef0:	ec                   	in     (%dx),%al
80102ef1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef4:	89 da                	mov    %ebx,%edx
80102ef6:	b8 07 00 00 00       	mov    $0x7,%eax
80102efb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102efc:	89 ca                	mov    %ecx,%edx
80102efe:	ec                   	in     (%dx),%al
80102eff:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f02:	89 da                	mov    %ebx,%edx
80102f04:	b8 08 00 00 00       	mov    $0x8,%eax
80102f09:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f0a:	89 ca                	mov    %ecx,%edx
80102f0c:	ec                   	in     (%dx),%al
80102f0d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f0f:	89 da                	mov    %ebx,%edx
80102f11:	b8 09 00 00 00       	mov    $0x9,%eax
80102f16:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f17:	89 ca                	mov    %ecx,%edx
80102f19:	ec                   	in     (%dx),%al
80102f1a:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f1c:	89 da                	mov    %ebx,%edx
80102f1e:	b8 0a 00 00 00       	mov    $0xa,%eax
80102f23:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f24:	89 ca                	mov    %ecx,%edx
80102f26:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102f27:	84 c0                	test   %al,%al
80102f29:	78 9d                	js     80102ec8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102f2b:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f2f:	89 fa                	mov    %edi,%edx
80102f31:	0f b6 fa             	movzbl %dl,%edi
80102f34:	89 f2                	mov    %esi,%edx
80102f36:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f39:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f3d:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f40:	89 da                	mov    %ebx,%edx
80102f42:	89 7d c8             	mov    %edi,-0x38(%ebp)
80102f45:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102f48:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102f4c:	89 75 cc             	mov    %esi,-0x34(%ebp)
80102f4f:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102f52:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102f56:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102f59:	31 c0                	xor    %eax,%eax
80102f5b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f5c:	89 ca                	mov    %ecx,%edx
80102f5e:	ec                   	in     (%dx),%al
80102f5f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f62:	89 da                	mov    %ebx,%edx
80102f64:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f67:	b8 02 00 00 00       	mov    $0x2,%eax
80102f6c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f6d:	89 ca                	mov    %ecx,%edx
80102f6f:	ec                   	in     (%dx),%al
80102f70:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f73:	89 da                	mov    %ebx,%edx
80102f75:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102f78:	b8 04 00 00 00       	mov    $0x4,%eax
80102f7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f7e:	89 ca                	mov    %ecx,%edx
80102f80:	ec                   	in     (%dx),%al
80102f81:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f84:	89 da                	mov    %ebx,%edx
80102f86:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f89:	b8 07 00 00 00       	mov    $0x7,%eax
80102f8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f8f:	89 ca                	mov    %ecx,%edx
80102f91:	ec                   	in     (%dx),%al
80102f92:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f95:	89 da                	mov    %ebx,%edx
80102f97:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f9a:	b8 08 00 00 00       	mov    $0x8,%eax
80102f9f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fa0:	89 ca                	mov    %ecx,%edx
80102fa2:	ec                   	in     (%dx),%al
80102fa3:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fa6:	89 da                	mov    %ebx,%edx
80102fa8:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102fab:	b8 09 00 00 00       	mov    $0x9,%eax
80102fb0:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fb1:	89 ca                	mov    %ecx,%edx
80102fb3:	ec                   	in     (%dx),%al
80102fb4:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102fb7:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102fba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102fbd:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102fc0:	6a 18                	push   $0x18
80102fc2:	50                   	push   %eax
80102fc3:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102fc6:	50                   	push   %eax
80102fc7:	e8 94 21 00 00       	call   80105160 <memcmp>
80102fcc:	83 c4 10             	add    $0x10,%esp
80102fcf:	85 c0                	test   %eax,%eax
80102fd1:	0f 85 f1 fe ff ff    	jne    80102ec8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102fd7:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102fdb:	75 78                	jne    80103055 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102fdd:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fe0:	89 c2                	mov    %eax,%edx
80102fe2:	83 e0 0f             	and    $0xf,%eax
80102fe5:	c1 ea 04             	shr    $0x4,%edx
80102fe8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102feb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fee:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ff1:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ff4:	89 c2                	mov    %eax,%edx
80102ff6:	83 e0 0f             	and    $0xf,%eax
80102ff9:	c1 ea 04             	shr    $0x4,%edx
80102ffc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103002:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103005:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103008:	89 c2                	mov    %eax,%edx
8010300a:	83 e0 0f             	and    $0xf,%eax
8010300d:	c1 ea 04             	shr    $0x4,%edx
80103010:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103013:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103016:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80103019:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010301c:	89 c2                	mov    %eax,%edx
8010301e:	83 e0 0f             	and    $0xf,%eax
80103021:	c1 ea 04             	shr    $0x4,%edx
80103024:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103027:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010302a:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
8010302d:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103030:	89 c2                	mov    %eax,%edx
80103032:	83 e0 0f             	and    $0xf,%eax
80103035:	c1 ea 04             	shr    $0x4,%edx
80103038:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010303b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010303e:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103041:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103044:	89 c2                	mov    %eax,%edx
80103046:	83 e0 0f             	and    $0xf,%eax
80103049:	c1 ea 04             	shr    $0x4,%edx
8010304c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010304f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103052:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103055:	8b 75 08             	mov    0x8(%ebp),%esi
80103058:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010305b:	89 06                	mov    %eax,(%esi)
8010305d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103060:	89 46 04             	mov    %eax,0x4(%esi)
80103063:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103066:	89 46 08             	mov    %eax,0x8(%esi)
80103069:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010306c:	89 46 0c             	mov    %eax,0xc(%esi)
8010306f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103072:	89 46 10             	mov    %eax,0x10(%esi)
80103075:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103078:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
8010307b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80103082:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103085:	5b                   	pop    %ebx
80103086:	5e                   	pop    %esi
80103087:	5f                   	pop    %edi
80103088:	5d                   	pop    %ebp
80103089:	c3                   	ret    
8010308a:	66 90                	xchg   %ax,%ax
8010308c:	66 90                	xchg   %ax,%ax
8010308e:	66 90                	xchg   %ax,%ax

80103090 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103090:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
80103096:	85 c9                	test   %ecx,%ecx
80103098:	0f 8e 8a 00 00 00    	jle    80103128 <install_trans+0x98>
{
8010309e:	55                   	push   %ebp
8010309f:	89 e5                	mov    %esp,%ebp
801030a1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801030a2:	31 ff                	xor    %edi,%edi
{
801030a4:	56                   	push   %esi
801030a5:	53                   	push   %ebx
801030a6:	83 ec 0c             	sub    $0xc,%esp
801030a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801030b0:	a1 d4 26 11 80       	mov    0x801126d4,%eax
801030b5:	83 ec 08             	sub    $0x8,%esp
801030b8:	01 f8                	add    %edi,%eax
801030ba:	83 c0 01             	add    $0x1,%eax
801030bd:	50                   	push   %eax
801030be:	ff 35 e4 26 11 80    	pushl  0x801126e4
801030c4:	e8 07 d0 ff ff       	call   801000d0 <bread>
801030c9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030cb:	58                   	pop    %eax
801030cc:	5a                   	pop    %edx
801030cd:	ff 34 bd ec 26 11 80 	pushl  -0x7feed914(,%edi,4)
801030d4:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
801030da:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030dd:	e8 ee cf ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030e2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030e5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030e7:	8d 46 5c             	lea    0x5c(%esi),%eax
801030ea:	68 00 02 00 00       	push   $0x200
801030ef:	50                   	push   %eax
801030f0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801030f3:	50                   	push   %eax
801030f4:	e8 b7 20 00 00       	call   801051b0 <memmove>
    bwrite(dbuf);  // write dst to disk
801030f9:	89 1c 24             	mov    %ebx,(%esp)
801030fc:	e8 af d0 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103101:	89 34 24             	mov    %esi,(%esp)
80103104:	e8 e7 d0 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103109:	89 1c 24             	mov    %ebx,(%esp)
8010310c:	e8 df d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103111:	83 c4 10             	add    $0x10,%esp
80103114:	39 3d e8 26 11 80    	cmp    %edi,0x801126e8
8010311a:	7f 94                	jg     801030b0 <install_trans+0x20>
  }
}
8010311c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010311f:	5b                   	pop    %ebx
80103120:	5e                   	pop    %esi
80103121:	5f                   	pop    %edi
80103122:	5d                   	pop    %ebp
80103123:	c3                   	ret    
80103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103128:	c3                   	ret    
80103129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103130 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103130:	55                   	push   %ebp
80103131:	89 e5                	mov    %esp,%ebp
80103133:	53                   	push   %ebx
80103134:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103137:	ff 35 d4 26 11 80    	pushl  0x801126d4
8010313d:	ff 35 e4 26 11 80    	pushl  0x801126e4
80103143:	e8 88 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103148:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010314b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010314d:	a1 e8 26 11 80       	mov    0x801126e8,%eax
80103152:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103155:	85 c0                	test   %eax,%eax
80103157:	7e 19                	jle    80103172 <write_head+0x42>
80103159:	31 d2                	xor    %edx,%edx
8010315b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010315f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103160:	8b 0c 95 ec 26 11 80 	mov    -0x7feed914(,%edx,4),%ecx
80103167:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010316b:	83 c2 01             	add    $0x1,%edx
8010316e:	39 d0                	cmp    %edx,%eax
80103170:	75 ee                	jne    80103160 <write_head+0x30>
  }
  bwrite(buf);
80103172:	83 ec 0c             	sub    $0xc,%esp
80103175:	53                   	push   %ebx
80103176:	e8 35 d0 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010317b:	89 1c 24             	mov    %ebx,(%esp)
8010317e:	e8 6d d0 ff ff       	call   801001f0 <brelse>
}
80103183:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103186:	83 c4 10             	add    $0x10,%esp
80103189:	c9                   	leave  
8010318a:	c3                   	ret    
8010318b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010318f:	90                   	nop

80103190 <initlog>:
{
80103190:	55                   	push   %ebp
80103191:	89 e5                	mov    %esp,%ebp
80103193:	53                   	push   %ebx
80103194:	83 ec 2c             	sub    $0x2c,%esp
80103197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010319a:	68 e0 83 10 80       	push   $0x801083e0
8010319f:	68 a0 26 11 80       	push   $0x801126a0
801031a4:	e8 d7 1c 00 00       	call   80104e80 <initlock>
  readsb(dev, &sb);
801031a9:	58                   	pop    %eax
801031aa:	8d 45 dc             	lea    -0x24(%ebp),%eax
801031ad:	5a                   	pop    %edx
801031ae:	50                   	push   %eax
801031af:	53                   	push   %ebx
801031b0:	e8 2b e8 ff ff       	call   801019e0 <readsb>
  log.start = sb.logstart;
801031b5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
801031b8:	59                   	pop    %ecx
  log.dev = dev;
801031b9:	89 1d e4 26 11 80    	mov    %ebx,0x801126e4
  log.size = sb.nlog;
801031bf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801031c2:	a3 d4 26 11 80       	mov    %eax,0x801126d4
  log.size = sb.nlog;
801031c7:	89 15 d8 26 11 80    	mov    %edx,0x801126d8
  struct buf *buf = bread(log.dev, log.start);
801031cd:	5a                   	pop    %edx
801031ce:	50                   	push   %eax
801031cf:	53                   	push   %ebx
801031d0:	e8 fb ce ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801031d5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801031d8:	8b 58 5c             	mov    0x5c(%eax),%ebx
801031db:	89 1d e8 26 11 80    	mov    %ebx,0x801126e8
  for (i = 0; i < log.lh.n; i++) {
801031e1:	85 db                	test   %ebx,%ebx
801031e3:	7e 1d                	jle    80103202 <initlog+0x72>
801031e5:	31 d2                	xor    %edx,%edx
801031e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031ee:	66 90                	xchg   %ax,%ax
    log.lh.block[i] = lh->block[i];
801031f0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
801031f4:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801031fb:	83 c2 01             	add    $0x1,%edx
801031fe:	39 d3                	cmp    %edx,%ebx
80103200:	75 ee                	jne    801031f0 <initlog+0x60>
  brelse(buf);
80103202:	83 ec 0c             	sub    $0xc,%esp
80103205:	50                   	push   %eax
80103206:	e8 e5 cf ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
8010320b:	e8 80 fe ff ff       	call   80103090 <install_trans>
  log.lh.n = 0;
80103210:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
80103217:	00 00 00 
  write_head(); // clear the log
8010321a:	e8 11 ff ff ff       	call   80103130 <write_head>
}
8010321f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103222:	83 c4 10             	add    $0x10,%esp
80103225:	c9                   	leave  
80103226:	c3                   	ret    
80103227:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010322e:	66 90                	xchg   %ax,%ax

80103230 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103236:	68 a0 26 11 80       	push   $0x801126a0
8010323b:	e8 10 1e 00 00       	call   80105050 <acquire>
80103240:	83 c4 10             	add    $0x10,%esp
80103243:	eb 18                	jmp    8010325d <begin_op+0x2d>
80103245:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103248:	83 ec 08             	sub    $0x8,%esp
8010324b:	68 a0 26 11 80       	push   $0x801126a0
80103250:	68 a0 26 11 80       	push   $0x801126a0
80103255:	e8 86 16 00 00       	call   801048e0 <sleep>
8010325a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
8010325d:	a1 e0 26 11 80       	mov    0x801126e0,%eax
80103262:	85 c0                	test   %eax,%eax
80103264:	75 e2                	jne    80103248 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103266:	a1 dc 26 11 80       	mov    0x801126dc,%eax
8010326b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103271:	83 c0 01             	add    $0x1,%eax
80103274:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103277:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010327a:	83 fa 1e             	cmp    $0x1e,%edx
8010327d:	7f c9                	jg     80103248 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010327f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103282:	a3 dc 26 11 80       	mov    %eax,0x801126dc
      release(&log.lock);
80103287:	68 a0 26 11 80       	push   $0x801126a0
8010328c:	e8 5f 1d 00 00       	call   80104ff0 <release>
      break;
    }
  }
}
80103291:	83 c4 10             	add    $0x10,%esp
80103294:	c9                   	leave  
80103295:	c3                   	ret    
80103296:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010329d:	8d 76 00             	lea    0x0(%esi),%esi

801032a0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801032a0:	55                   	push   %ebp
801032a1:	89 e5                	mov    %esp,%ebp
801032a3:	57                   	push   %edi
801032a4:	56                   	push   %esi
801032a5:	53                   	push   %ebx
801032a6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
801032a9:	68 a0 26 11 80       	push   $0x801126a0
801032ae:	e8 9d 1d 00 00       	call   80105050 <acquire>
  log.outstanding -= 1;
801032b3:	a1 dc 26 11 80       	mov    0x801126dc,%eax
  if(log.committing)
801032b8:	8b 35 e0 26 11 80    	mov    0x801126e0,%esi
801032be:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801032c1:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032c4:	89 1d dc 26 11 80    	mov    %ebx,0x801126dc
  if(log.committing)
801032ca:	85 f6                	test   %esi,%esi
801032cc:	0f 85 22 01 00 00    	jne    801033f4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801032d2:	85 db                	test   %ebx,%ebx
801032d4:	0f 85 f6 00 00 00    	jne    801033d0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801032da:	c7 05 e0 26 11 80 01 	movl   $0x1,0x801126e0
801032e1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801032e4:	83 ec 0c             	sub    $0xc,%esp
801032e7:	68 a0 26 11 80       	push   $0x801126a0
801032ec:	e8 ff 1c 00 00       	call   80104ff0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801032f1:	8b 0d e8 26 11 80    	mov    0x801126e8,%ecx
801032f7:	83 c4 10             	add    $0x10,%esp
801032fa:	85 c9                	test   %ecx,%ecx
801032fc:	7f 42                	jg     80103340 <end_op+0xa0>
    acquire(&log.lock);
801032fe:	83 ec 0c             	sub    $0xc,%esp
80103301:	68 a0 26 11 80       	push   $0x801126a0
80103306:	e8 45 1d 00 00       	call   80105050 <acquire>
    wakeup(&log);
8010330b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80103312:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80103319:	00 00 00 
    wakeup(&log);
8010331c:	e8 7f 16 00 00       	call   801049a0 <wakeup>
    release(&log.lock);
80103321:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103328:	e8 c3 1c 00 00       	call   80104ff0 <release>
8010332d:	83 c4 10             	add    $0x10,%esp
}
80103330:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103333:	5b                   	pop    %ebx
80103334:	5e                   	pop    %esi
80103335:	5f                   	pop    %edi
80103336:	5d                   	pop    %ebp
80103337:	c3                   	ret    
80103338:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010333f:	90                   	nop
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103340:	a1 d4 26 11 80       	mov    0x801126d4,%eax
80103345:	83 ec 08             	sub    $0x8,%esp
80103348:	01 d8                	add    %ebx,%eax
8010334a:	83 c0 01             	add    $0x1,%eax
8010334d:	50                   	push   %eax
8010334e:	ff 35 e4 26 11 80    	pushl  0x801126e4
80103354:	e8 77 cd ff ff       	call   801000d0 <bread>
80103359:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010335b:	58                   	pop    %eax
8010335c:	5a                   	pop    %edx
8010335d:	ff 34 9d ec 26 11 80 	pushl  -0x7feed914(,%ebx,4)
80103364:	ff 35 e4 26 11 80    	pushl  0x801126e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010336a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010336d:	e8 5e cd ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103372:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103375:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103377:	8d 40 5c             	lea    0x5c(%eax),%eax
8010337a:	68 00 02 00 00       	push   $0x200
8010337f:	50                   	push   %eax
80103380:	8d 46 5c             	lea    0x5c(%esi),%eax
80103383:	50                   	push   %eax
80103384:	e8 27 1e 00 00       	call   801051b0 <memmove>
    bwrite(to);  // write the log
80103389:	89 34 24             	mov    %esi,(%esp)
8010338c:	e8 1f ce ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103391:	89 3c 24             	mov    %edi,(%esp)
80103394:	e8 57 ce ff ff       	call   801001f0 <brelse>
    brelse(to);
80103399:	89 34 24             	mov    %esi,(%esp)
8010339c:	e8 4f ce ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801033a1:	83 c4 10             	add    $0x10,%esp
801033a4:	3b 1d e8 26 11 80    	cmp    0x801126e8,%ebx
801033aa:	7c 94                	jl     80103340 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
801033ac:	e8 7f fd ff ff       	call   80103130 <write_head>
    install_trans(); // Now install writes to home locations
801033b1:	e8 da fc ff ff       	call   80103090 <install_trans>
    log.lh.n = 0;
801033b6:	c7 05 e8 26 11 80 00 	movl   $0x0,0x801126e8
801033bd:	00 00 00 
    write_head();    // Erase the transaction from the log
801033c0:	e8 6b fd ff ff       	call   80103130 <write_head>
801033c5:	e9 34 ff ff ff       	jmp    801032fe <end_op+0x5e>
801033ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801033d0:	83 ec 0c             	sub    $0xc,%esp
801033d3:	68 a0 26 11 80       	push   $0x801126a0
801033d8:	e8 c3 15 00 00       	call   801049a0 <wakeup>
  release(&log.lock);
801033dd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801033e4:	e8 07 1c 00 00       	call   80104ff0 <release>
801033e9:	83 c4 10             	add    $0x10,%esp
}
801033ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033ef:	5b                   	pop    %ebx
801033f0:	5e                   	pop    %esi
801033f1:	5f                   	pop    %edi
801033f2:	5d                   	pop    %ebp
801033f3:	c3                   	ret    
    panic("log.committing");
801033f4:	83 ec 0c             	sub    $0xc,%esp
801033f7:	68 e4 83 10 80       	push   $0x801083e4
801033fc:	e8 7f cf ff ff       	call   80100380 <panic>
80103401:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103408:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010340f:	90                   	nop

80103410 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	53                   	push   %ebx
80103414:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103417:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
{
8010341d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103420:	83 fa 1d             	cmp    $0x1d,%edx
80103423:	0f 8f 85 00 00 00    	jg     801034ae <log_write+0x9e>
80103429:	a1 d8 26 11 80       	mov    0x801126d8,%eax
8010342e:	83 e8 01             	sub    $0x1,%eax
80103431:	39 c2                	cmp    %eax,%edx
80103433:	7d 79                	jge    801034ae <log_write+0x9e>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103435:	a1 dc 26 11 80       	mov    0x801126dc,%eax
8010343a:	85 c0                	test   %eax,%eax
8010343c:	7e 7d                	jle    801034bb <log_write+0xab>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010343e:	83 ec 0c             	sub    $0xc,%esp
80103441:	68 a0 26 11 80       	push   $0x801126a0
80103446:	e8 05 1c 00 00       	call   80105050 <acquire>
  for (i = 0; i < log.lh.n; i++) {
8010344b:	8b 15 e8 26 11 80    	mov    0x801126e8,%edx
80103451:	83 c4 10             	add    $0x10,%esp
80103454:	85 d2                	test   %edx,%edx
80103456:	7e 4a                	jle    801034a2 <log_write+0x92>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103458:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010345b:	31 c0                	xor    %eax,%eax
8010345d:	eb 08                	jmp    80103467 <log_write+0x57>
8010345f:	90                   	nop
80103460:	83 c0 01             	add    $0x1,%eax
80103463:	39 c2                	cmp    %eax,%edx
80103465:	74 29                	je     80103490 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103467:	39 0c 85 ec 26 11 80 	cmp    %ecx,-0x7feed914(,%eax,4)
8010346e:	75 f0                	jne    80103460 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103470:	89 0c 85 ec 26 11 80 	mov    %ecx,-0x7feed914(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103477:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010347a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010347d:	c7 45 08 a0 26 11 80 	movl   $0x801126a0,0x8(%ebp)
}
80103484:	c9                   	leave  
  release(&log.lock);
80103485:	e9 66 1b 00 00       	jmp    80104ff0 <release>
8010348a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103490:	89 0c 95 ec 26 11 80 	mov    %ecx,-0x7feed914(,%edx,4)
    log.lh.n++;
80103497:	83 c2 01             	add    $0x1,%edx
8010349a:	89 15 e8 26 11 80    	mov    %edx,0x801126e8
801034a0:	eb d5                	jmp    80103477 <log_write+0x67>
  log.lh.block[i] = b->blockno;
801034a2:	8b 43 08             	mov    0x8(%ebx),%eax
801034a5:	a3 ec 26 11 80       	mov    %eax,0x801126ec
  if (i == log.lh.n)
801034aa:	75 cb                	jne    80103477 <log_write+0x67>
801034ac:	eb e9                	jmp    80103497 <log_write+0x87>
    panic("too big a transaction");
801034ae:	83 ec 0c             	sub    $0xc,%esp
801034b1:	68 f3 83 10 80       	push   $0x801083f3
801034b6:	e8 c5 ce ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	68 09 84 10 80       	push   $0x80108409
801034c3:	e8 b8 ce ff ff       	call   80100380 <panic>
801034c8:	66 90                	xchg   %ax,%ax
801034ca:	66 90                	xchg   %ax,%ax
801034cc:	66 90                	xchg   %ax,%ax
801034ce:	66 90                	xchg   %ax,%ax

801034d0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	53                   	push   %ebx
801034d4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801034d7:	e8 94 09 00 00       	call   80103e70 <cpuid>
801034dc:	89 c3                	mov    %eax,%ebx
801034de:	e8 8d 09 00 00       	call   80103e70 <cpuid>
801034e3:	83 ec 04             	sub    $0x4,%esp
801034e6:	53                   	push   %ebx
801034e7:	50                   	push   %eax
801034e8:	68 24 84 10 80       	push   $0x80108424
801034ed:	e8 ae d1 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
801034f2:	e8 19 31 00 00       	call   80106610 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801034f7:	e8 14 09 00 00       	call   80103e10 <mycpu>
801034fc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801034fe:	b8 01 00 00 00       	mov    $0x1,%eax
80103503:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010350a:	e8 e1 0e 00 00       	call   801043f0 <scheduler>
8010350f:	90                   	nop

80103510 <mpenter>:
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103516:	e8 05 42 00 00       	call   80107720 <switchkvm>
  seginit();
8010351b:	e8 70 41 00 00       	call   80107690 <seginit>
  lapicinit();
80103520:	e8 9b f7 ff ff       	call   80102cc0 <lapicinit>
  mpmain();
80103525:	e8 a6 ff ff ff       	call   801034d0 <mpmain>
8010352a:	66 90                	xchg   %ax,%ax
8010352c:	66 90                	xchg   %ax,%ax
8010352e:	66 90                	xchg   %ax,%ax

80103530 <main>:
{
80103530:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103534:	83 e4 f0             	and    $0xfffffff0,%esp
80103537:	ff 71 fc             	pushl  -0x4(%ecx)
8010353a:	55                   	push   %ebp
8010353b:	89 e5                	mov    %esp,%ebp
8010353d:	53                   	push   %ebx
8010353e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010353f:	83 ec 08             	sub    $0x8,%esp
80103542:	68 00 00 40 80       	push   $0x80400000
80103547:	68 f0 6b 11 80       	push   $0x80116bf0
8010354c:	e8 8f f5 ff ff       	call   80102ae0 <kinit1>
  kvmalloc();      // kernel page table
80103551:	e8 ba 46 00 00       	call   80107c10 <kvmalloc>
  mpinit();        // detect other processors
80103556:	e8 85 01 00 00       	call   801036e0 <mpinit>
  lapicinit();     // interrupt controller
8010355b:	e8 60 f7 ff ff       	call   80102cc0 <lapicinit>
  seginit();       // segment descriptors
80103560:	e8 2b 41 00 00       	call   80107690 <seginit>
  picinit();       // disable pic
80103565:	e8 76 03 00 00       	call   801038e0 <picinit>
  ioapicinit();    // another interrupt controller
8010356a:	e8 31 f3 ff ff       	call   801028a0 <ioapicinit>
  consoleinit();   // console hardware
8010356f:	e8 ac d9 ff ff       	call   80100f20 <consoleinit>
  uartinit();      // serial port
80103574:	e8 87 33 00 00       	call   80106900 <uartinit>
  pinit();         // process table
80103579:	e8 72 08 00 00       	call   80103df0 <pinit>
  tvinit();        // trap vectors
8010357e:	e8 0d 30 00 00       	call   80106590 <tvinit>
  binit();         // buffer cache
80103583:	e8 b8 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103588:	e8 43 dd ff ff       	call   801012d0 <fileinit>
  ideinit();       // disk 
8010358d:	e8 fe f0 ff ff       	call   80102690 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103592:	83 c4 0c             	add    $0xc,%esp
80103595:	68 8a 00 00 00       	push   $0x8a
8010359a:	68 8c b4 10 80       	push   $0x8010b48c
8010359f:	68 00 70 00 80       	push   $0x80007000
801035a4:	e8 07 1c 00 00       	call   801051b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
801035a9:	83 c4 10             	add    $0x10,%esp
801035ac:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801035b3:	00 00 00 
801035b6:	05 a0 27 11 80       	add    $0x801127a0,%eax
801035bb:	3d a0 27 11 80       	cmp    $0x801127a0,%eax
801035c0:	76 7e                	jbe    80103640 <main+0x110>
801035c2:	bb a0 27 11 80       	mov    $0x801127a0,%ebx
801035c7:	eb 20                	jmp    801035e9 <main+0xb9>
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801035d0:	69 05 84 27 11 80 b0 	imul   $0xb0,0x80112784,%eax
801035d7:	00 00 00 
801035da:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035e0:	05 a0 27 11 80       	add    $0x801127a0,%eax
801035e5:	39 c3                	cmp    %eax,%ebx
801035e7:	73 57                	jae    80103640 <main+0x110>
    if(c == mycpu())  // We've started already.
801035e9:	e8 22 08 00 00       	call   80103e10 <mycpu>
801035ee:	39 c3                	cmp    %eax,%ebx
801035f0:	74 de                	je     801035d0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801035f2:	e8 59 f5 ff ff       	call   80102b50 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801035f7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801035fa:	c7 05 f8 6f 00 80 10 	movl   $0x80103510,0x80006ff8
80103601:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103604:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010360b:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010360e:	05 00 10 00 00       	add    $0x1000,%eax
80103613:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103618:	0f b6 03             	movzbl (%ebx),%eax
8010361b:	68 00 70 00 00       	push   $0x7000
80103620:	50                   	push   %eax
80103621:	e8 ea f7 ff ff       	call   80102e10 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103626:	83 c4 10             	add    $0x10,%esp
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103630:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103636:	85 c0                	test   %eax,%eax
80103638:	74 f6                	je     80103630 <main+0x100>
8010363a:	eb 94                	jmp    801035d0 <main+0xa0>
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103640:	83 ec 08             	sub    $0x8,%esp
80103643:	68 00 00 00 8e       	push   $0x8e000000
80103648:	68 00 00 40 80       	push   $0x80400000
8010364d:	e8 2e f4 ff ff       	call   80102a80 <kinit2>
  userinit();      // first user process
80103652:	e8 69 08 00 00       	call   80103ec0 <userinit>
  mpmain();        // finish this processor's setup
80103657:	e8 74 fe ff ff       	call   801034d0 <mpmain>
8010365c:	66 90                	xchg   %ax,%ax
8010365e:	66 90                	xchg   %ax,%ax

80103660 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103660:	55                   	push   %ebp
80103661:	89 e5                	mov    %esp,%ebp
80103663:	57                   	push   %edi
80103664:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103665:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010366b:	53                   	push   %ebx
  e = addr+len;
8010366c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010366f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103672:	39 de                	cmp    %ebx,%esi
80103674:	72 10                	jb     80103686 <mpsearch1+0x26>
80103676:	eb 50                	jmp    801036c8 <mpsearch1+0x68>
80103678:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010367f:	90                   	nop
80103680:	89 fe                	mov    %edi,%esi
80103682:	39 fb                	cmp    %edi,%ebx
80103684:	76 42                	jbe    801036c8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103686:	83 ec 04             	sub    $0x4,%esp
80103689:	8d 7e 10             	lea    0x10(%esi),%edi
8010368c:	6a 04                	push   $0x4
8010368e:	68 38 84 10 80       	push   $0x80108438
80103693:	56                   	push   %esi
80103694:	e8 c7 1a 00 00       	call   80105160 <memcmp>
80103699:	83 c4 10             	add    $0x10,%esp
8010369c:	85 c0                	test   %eax,%eax
8010369e:	75 e0                	jne    80103680 <mpsearch1+0x20>
801036a0:	89 f2                	mov    %esi,%edx
801036a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
801036a8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801036ab:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801036ae:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801036b0:	39 fa                	cmp    %edi,%edx
801036b2:	75 f4                	jne    801036a8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036b4:	84 c0                	test   %al,%al
801036b6:	75 c8                	jne    80103680 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801036b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036bb:	89 f0                	mov    %esi,%eax
801036bd:	5b                   	pop    %ebx
801036be:	5e                   	pop    %esi
801036bf:	5f                   	pop    %edi
801036c0:	5d                   	pop    %ebp
801036c1:	c3                   	ret    
801036c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036cb:	31 f6                	xor    %esi,%esi
}
801036cd:	5b                   	pop    %ebx
801036ce:	89 f0                	mov    %esi,%eax
801036d0:	5e                   	pop    %esi
801036d1:	5f                   	pop    %edi
801036d2:	5d                   	pop    %ebp
801036d3:	c3                   	ret    
801036d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801036db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036df:	90                   	nop

801036e0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	57                   	push   %edi
801036e4:	56                   	push   %esi
801036e5:	53                   	push   %ebx
801036e6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801036e9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801036f0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801036f7:	c1 e0 08             	shl    $0x8,%eax
801036fa:	09 d0                	or     %edx,%eax
801036fc:	c1 e0 04             	shl    $0x4,%eax
801036ff:	75 1b                	jne    8010371c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103701:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103708:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010370f:	c1 e0 08             	shl    $0x8,%eax
80103712:	09 d0                	or     %edx,%eax
80103714:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103717:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010371c:	ba 00 04 00 00       	mov    $0x400,%edx
80103721:	e8 3a ff ff ff       	call   80103660 <mpsearch1>
80103726:	89 c3                	mov    %eax,%ebx
80103728:	85 c0                	test   %eax,%eax
8010372a:	0f 84 40 01 00 00    	je     80103870 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103730:	8b 73 04             	mov    0x4(%ebx),%esi
80103733:	85 f6                	test   %esi,%esi
80103735:	0f 84 25 01 00 00    	je     80103860 <mpinit+0x180>
  if(memcmp(conf, "PCMP", 4) != 0)
8010373b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010373e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103744:	6a 04                	push   $0x4
80103746:	68 3d 84 10 80       	push   $0x8010843d
8010374b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010374c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010374f:	e8 0c 1a 00 00       	call   80105160 <memcmp>
80103754:	83 c4 10             	add    $0x10,%esp
80103757:	85 c0                	test   %eax,%eax
80103759:	0f 85 01 01 00 00    	jne    80103860 <mpinit+0x180>
  if(conf->version != 1 && conf->version != 4)
8010375f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103766:	3c 01                	cmp    $0x1,%al
80103768:	74 08                	je     80103772 <mpinit+0x92>
8010376a:	3c 04                	cmp    $0x4,%al
8010376c:	0f 85 ee 00 00 00    	jne    80103860 <mpinit+0x180>
  if(sum((uchar*)conf, conf->length) != 0)
80103772:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103779:	66 85 d2             	test   %dx,%dx
8010377c:	74 22                	je     801037a0 <mpinit+0xc0>
8010377e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103781:	89 f0                	mov    %esi,%eax
  sum = 0;
80103783:	31 d2                	xor    %edx,%edx
80103785:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103788:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010378f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103792:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103794:	39 c7                	cmp    %eax,%edi
80103796:	75 f0                	jne    80103788 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103798:	84 d2                	test   %dl,%dl
8010379a:	0f 85 c0 00 00 00    	jne    80103860 <mpinit+0x180>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801037a0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
801037a6:	a3 80 26 11 80       	mov    %eax,0x80112680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037ab:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801037b2:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
  ismp = 1;
801037b8:	be 01 00 00 00       	mov    $0x1,%esi
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037bd:	03 55 e4             	add    -0x1c(%ebp),%edx
801037c0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801037c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037c7:	90                   	nop
801037c8:	39 d0                	cmp    %edx,%eax
801037ca:	73 15                	jae    801037e1 <mpinit+0x101>
    switch(*p){
801037cc:	0f b6 08             	movzbl (%eax),%ecx
801037cf:	80 f9 02             	cmp    $0x2,%cl
801037d2:	74 4c                	je     80103820 <mpinit+0x140>
801037d4:	77 3a                	ja     80103810 <mpinit+0x130>
801037d6:	84 c9                	test   %cl,%cl
801037d8:	74 56                	je     80103830 <mpinit+0x150>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801037da:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037dd:	39 d0                	cmp    %edx,%eax
801037df:	72 eb                	jb     801037cc <mpinit+0xec>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801037e1:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801037e4:	85 f6                	test   %esi,%esi
801037e6:	0f 84 d9 00 00 00    	je     801038c5 <mpinit+0x1e5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801037ec:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801037f0:	74 15                	je     80103807 <mpinit+0x127>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037f2:	b8 70 00 00 00       	mov    $0x70,%eax
801037f7:	ba 22 00 00 00       	mov    $0x22,%edx
801037fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037fd:	ba 23 00 00 00       	mov    $0x23,%edx
80103802:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103803:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103806:	ee                   	out    %al,(%dx)
  }
}
80103807:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010380a:	5b                   	pop    %ebx
8010380b:	5e                   	pop    %esi
8010380c:	5f                   	pop    %edi
8010380d:	5d                   	pop    %ebp
8010380e:	c3                   	ret    
8010380f:	90                   	nop
    switch(*p){
80103810:	83 e9 03             	sub    $0x3,%ecx
80103813:	80 f9 01             	cmp    $0x1,%cl
80103816:	76 c2                	jbe    801037da <mpinit+0xfa>
80103818:	31 f6                	xor    %esi,%esi
8010381a:	eb ac                	jmp    801037c8 <mpinit+0xe8>
8010381c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103820:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103824:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103827:	88 0d 80 27 11 80    	mov    %cl,0x80112780
      continue;
8010382d:	eb 99                	jmp    801037c8 <mpinit+0xe8>
8010382f:	90                   	nop
      if(ncpu < NCPU) {
80103830:	8b 0d 84 27 11 80    	mov    0x80112784,%ecx
80103836:	83 f9 07             	cmp    $0x7,%ecx
80103839:	7f 19                	jg     80103854 <mpinit+0x174>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010383b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103841:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103845:	83 c1 01             	add    $0x1,%ecx
80103848:	89 0d 84 27 11 80    	mov    %ecx,0x80112784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010384e:	88 9f a0 27 11 80    	mov    %bl,-0x7feed860(%edi)
      p += sizeof(struct mpproc);
80103854:	83 c0 14             	add    $0x14,%eax
      continue;
80103857:	e9 6c ff ff ff       	jmp    801037c8 <mpinit+0xe8>
8010385c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103860:	83 ec 0c             	sub    $0xc,%esp
80103863:	68 42 84 10 80       	push   $0x80108442
80103868:	e8 13 cb ff ff       	call   80100380 <panic>
8010386d:	8d 76 00             	lea    0x0(%esi),%esi
{
80103870:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103875:	eb 13                	jmp    8010388a <mpinit+0x1aa>
80103877:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010387e:	66 90                	xchg   %ax,%ax
  for(p = addr; p < e; p += sizeof(struct mp))
80103880:	89 f3                	mov    %esi,%ebx
80103882:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103888:	74 d6                	je     80103860 <mpinit+0x180>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010388a:	83 ec 04             	sub    $0x4,%esp
8010388d:	8d 73 10             	lea    0x10(%ebx),%esi
80103890:	6a 04                	push   $0x4
80103892:	68 38 84 10 80       	push   $0x80108438
80103897:	53                   	push   %ebx
80103898:	e8 c3 18 00 00       	call   80105160 <memcmp>
8010389d:	83 c4 10             	add    $0x10,%esp
801038a0:	85 c0                	test   %eax,%eax
801038a2:	75 dc                	jne    80103880 <mpinit+0x1a0>
801038a4:	89 da                	mov    %ebx,%edx
801038a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038ad:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801038b0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801038b3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801038b6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801038b8:	39 d6                	cmp    %edx,%esi
801038ba:	75 f4                	jne    801038b0 <mpinit+0x1d0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801038bc:	84 c0                	test   %al,%al
801038be:	75 c0                	jne    80103880 <mpinit+0x1a0>
801038c0:	e9 6b fe ff ff       	jmp    80103730 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801038c5:	83 ec 0c             	sub    $0xc,%esp
801038c8:	68 5c 84 10 80       	push   $0x8010845c
801038cd:	e8 ae ca ff ff       	call   80100380 <panic>
801038d2:	66 90                	xchg   %ax,%ax
801038d4:	66 90                	xchg   %ax,%ax
801038d6:	66 90                	xchg   %ax,%ax
801038d8:	66 90                	xchg   %ax,%ax
801038da:	66 90                	xchg   %ax,%ax
801038dc:	66 90                	xchg   %ax,%ax
801038de:	66 90                	xchg   %ax,%ax

801038e0 <picinit>:
801038e0:	f3 0f 1e fb          	endbr32 
801038e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038e9:	ba 21 00 00 00       	mov    $0x21,%edx
801038ee:	ee                   	out    %al,(%dx)
801038ef:	ba a1 00 00 00       	mov    $0xa1,%edx
801038f4:	ee                   	out    %al,(%dx)
801038f5:	c3                   	ret    
801038f6:	66 90                	xchg   %ax,%ax
801038f8:	66 90                	xchg   %ax,%ax
801038fa:	66 90                	xchg   %ax,%ax
801038fc:	66 90                	xchg   %ax,%ax
801038fe:	66 90                	xchg   %ax,%ax

80103900 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	57                   	push   %edi
80103904:	56                   	push   %esi
80103905:	53                   	push   %ebx
80103906:	83 ec 0c             	sub    $0xc,%esp
80103909:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010390f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103915:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010391b:	e8 d0 d9 ff ff       	call   801012f0 <filealloc>
80103920:	89 03                	mov    %eax,(%ebx)
80103922:	85 c0                	test   %eax,%eax
80103924:	0f 84 a8 00 00 00    	je     801039d2 <pipealloc+0xd2>
8010392a:	e8 c1 d9 ff ff       	call   801012f0 <filealloc>
8010392f:	89 06                	mov    %eax,(%esi)
80103931:	85 c0                	test   %eax,%eax
80103933:	0f 84 87 00 00 00    	je     801039c0 <pipealloc+0xc0>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103939:	e8 12 f2 ff ff       	call   80102b50 <kalloc>
8010393e:	89 c7                	mov    %eax,%edi
80103940:	85 c0                	test   %eax,%eax
80103942:	0f 84 b0 00 00 00    	je     801039f8 <pipealloc+0xf8>
    goto bad;
  p->readopen = 1;
80103948:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010394f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103952:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103955:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010395c:	00 00 00 
  p->nwrite = 0;
8010395f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103966:	00 00 00 
  p->nread = 0;
80103969:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103970:	00 00 00 
  initlock(&p->lock, "pipe");
80103973:	68 7b 84 10 80       	push   $0x8010847b
80103978:	50                   	push   %eax
80103979:	e8 02 15 00 00       	call   80104e80 <initlock>
  (*f0)->type = FD_PIPE;
8010397e:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103980:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103983:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103989:	8b 03                	mov    (%ebx),%eax
8010398b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010398f:	8b 03                	mov    (%ebx),%eax
80103991:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103995:	8b 03                	mov    (%ebx),%eax
80103997:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010399a:	8b 06                	mov    (%esi),%eax
8010399c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801039a2:	8b 06                	mov    (%esi),%eax
801039a4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801039a8:	8b 06                	mov    (%esi),%eax
801039aa:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801039ae:	8b 06                	mov    (%esi),%eax
801039b0:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801039b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801039b6:	31 c0                	xor    %eax,%eax
}
801039b8:	5b                   	pop    %ebx
801039b9:	5e                   	pop    %esi
801039ba:	5f                   	pop    %edi
801039bb:	5d                   	pop    %ebp
801039bc:	c3                   	ret    
801039bd:	8d 76 00             	lea    0x0(%esi),%esi
  if(*f0)
801039c0:	8b 03                	mov    (%ebx),%eax
801039c2:	85 c0                	test   %eax,%eax
801039c4:	74 1e                	je     801039e4 <pipealloc+0xe4>
    fileclose(*f0);
801039c6:	83 ec 0c             	sub    $0xc,%esp
801039c9:	50                   	push   %eax
801039ca:	e8 e1 d9 ff ff       	call   801013b0 <fileclose>
801039cf:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801039d2:	8b 06                	mov    (%esi),%eax
801039d4:	85 c0                	test   %eax,%eax
801039d6:	74 0c                	je     801039e4 <pipealloc+0xe4>
    fileclose(*f1);
801039d8:	83 ec 0c             	sub    $0xc,%esp
801039db:	50                   	push   %eax
801039dc:	e8 cf d9 ff ff       	call   801013b0 <fileclose>
801039e1:	83 c4 10             	add    $0x10,%esp
}
801039e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801039e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801039ec:	5b                   	pop    %ebx
801039ed:	5e                   	pop    %esi
801039ee:	5f                   	pop    %edi
801039ef:	5d                   	pop    %ebp
801039f0:	c3                   	ret    
801039f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801039f8:	8b 03                	mov    (%ebx),%eax
801039fa:	85 c0                	test   %eax,%eax
801039fc:	75 c8                	jne    801039c6 <pipealloc+0xc6>
801039fe:	eb d2                	jmp    801039d2 <pipealloc+0xd2>

80103a00 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103a00:	55                   	push   %ebp
80103a01:	89 e5                	mov    %esp,%ebp
80103a03:	56                   	push   %esi
80103a04:	53                   	push   %ebx
80103a05:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103a08:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
80103a0b:	83 ec 0c             	sub    $0xc,%esp
80103a0e:	53                   	push   %ebx
80103a0f:	e8 3c 16 00 00       	call   80105050 <acquire>
  if(writable){
80103a14:	83 c4 10             	add    $0x10,%esp
80103a17:	85 f6                	test   %esi,%esi
80103a19:	74 65                	je     80103a80 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
80103a1b:	83 ec 0c             	sub    $0xc,%esp
80103a1e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103a24:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a2b:	00 00 00 
    wakeup(&p->nread);
80103a2e:	50                   	push   %eax
80103a2f:	e8 6c 0f 00 00       	call   801049a0 <wakeup>
80103a34:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a37:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a3d:	85 d2                	test   %edx,%edx
80103a3f:	75 0a                	jne    80103a4b <pipeclose+0x4b>
80103a41:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a47:	85 c0                	test   %eax,%eax
80103a49:	74 15                	je     80103a60 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a4b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a51:	5b                   	pop    %ebx
80103a52:	5e                   	pop    %esi
80103a53:	5d                   	pop    %ebp
    release(&p->lock);
80103a54:	e9 97 15 00 00       	jmp    80104ff0 <release>
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	53                   	push   %ebx
80103a64:	e8 87 15 00 00       	call   80104ff0 <release>
    kfree((char*)p);
80103a69:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a6c:	83 c4 10             	add    $0x10,%esp
}
80103a6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a72:	5b                   	pop    %ebx
80103a73:	5e                   	pop    %esi
80103a74:	5d                   	pop    %ebp
    kfree((char*)p);
80103a75:	e9 16 ef ff ff       	jmp    80102990 <kfree>
80103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103a80:	83 ec 0c             	sub    $0xc,%esp
80103a83:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103a89:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a90:	00 00 00 
    wakeup(&p->nwrite);
80103a93:	50                   	push   %eax
80103a94:	e8 07 0f 00 00       	call   801049a0 <wakeup>
80103a99:	83 c4 10             	add    $0x10,%esp
80103a9c:	eb 99                	jmp    80103a37 <pipeclose+0x37>
80103a9e:	66 90                	xchg   %ax,%ax

80103aa0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	57                   	push   %edi
80103aa4:	56                   	push   %esi
80103aa5:	53                   	push   %ebx
80103aa6:	83 ec 28             	sub    $0x28,%esp
80103aa9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103aac:	53                   	push   %ebx
80103aad:	e8 9e 15 00 00       	call   80105050 <acquire>
  for(i = 0; i < n; i++){
80103ab2:	8b 45 10             	mov    0x10(%ebp),%eax
80103ab5:	83 c4 10             	add    $0x10,%esp
80103ab8:	85 c0                	test   %eax,%eax
80103aba:	0f 8e c0 00 00 00    	jle    80103b80 <pipewrite+0xe0>
80103ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ac3:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103ac9:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103acf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ad2:	03 45 10             	add    0x10(%ebp),%eax
80103ad5:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ad8:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103ade:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ae4:	89 ca                	mov    %ecx,%edx
80103ae6:	05 00 02 00 00       	add    $0x200,%eax
80103aeb:	39 c1                	cmp    %eax,%ecx
80103aed:	74 3f                	je     80103b2e <pipewrite+0x8e>
80103aef:	eb 67                	jmp    80103b58 <pipewrite+0xb8>
80103af1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103af8:	e8 93 03 00 00       	call   80103e90 <myproc>
80103afd:	8b 48 28             	mov    0x28(%eax),%ecx
80103b00:	85 c9                	test   %ecx,%ecx
80103b02:	75 34                	jne    80103b38 <pipewrite+0x98>
      wakeup(&p->nread);
80103b04:	83 ec 0c             	sub    $0xc,%esp
80103b07:	57                   	push   %edi
80103b08:	e8 93 0e 00 00       	call   801049a0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b0d:	58                   	pop    %eax
80103b0e:	5a                   	pop    %edx
80103b0f:	53                   	push   %ebx
80103b10:	56                   	push   %esi
80103b11:	e8 ca 0d 00 00       	call   801048e0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103b16:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103b1c:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b22:	83 c4 10             	add    $0x10,%esp
80103b25:	05 00 02 00 00       	add    $0x200,%eax
80103b2a:	39 c2                	cmp    %eax,%edx
80103b2c:	75 2a                	jne    80103b58 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103b2e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b34:	85 c0                	test   %eax,%eax
80103b36:	75 c0                	jne    80103af8 <pipewrite+0x58>
        release(&p->lock);
80103b38:	83 ec 0c             	sub    $0xc,%esp
80103b3b:	53                   	push   %ebx
80103b3c:	e8 af 14 00 00       	call   80104ff0 <release>
        return -1;
80103b41:	83 c4 10             	add    $0x10,%esp
80103b44:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103b49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b4c:	5b                   	pop    %ebx
80103b4d:	5e                   	pop    %esi
80103b4e:	5f                   	pop    %edi
80103b4f:	5d                   	pop    %ebp
80103b50:	c3                   	ret    
80103b51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b58:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b5b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b5e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b64:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103b6a:	0f b6 06             	movzbl (%esi),%eax
  for(i = 0; i < n; i++){
80103b6d:	83 c6 01             	add    $0x1,%esi
80103b70:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b73:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103b77:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b7a:	0f 85 58 ff ff ff    	jne    80103ad8 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103b80:	83 ec 0c             	sub    $0xc,%esp
80103b83:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b89:	50                   	push   %eax
80103b8a:	e8 11 0e 00 00       	call   801049a0 <wakeup>
  release(&p->lock);
80103b8f:	89 1c 24             	mov    %ebx,(%esp)
80103b92:	e8 59 14 00 00       	call   80104ff0 <release>
  return n;
80103b97:	8b 45 10             	mov    0x10(%ebp),%eax
80103b9a:	83 c4 10             	add    $0x10,%esp
80103b9d:	eb aa                	jmp    80103b49 <pipewrite+0xa9>
80103b9f:	90                   	nop

80103ba0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103ba0:	55                   	push   %ebp
80103ba1:	89 e5                	mov    %esp,%ebp
80103ba3:	57                   	push   %edi
80103ba4:	56                   	push   %esi
80103ba5:	53                   	push   %ebx
80103ba6:	83 ec 18             	sub    $0x18,%esp
80103ba9:	8b 75 08             	mov    0x8(%ebp),%esi
80103bac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103baf:	56                   	push   %esi
80103bb0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103bb6:	e8 95 14 00 00       	call   80105050 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103bbb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103bc1:	83 c4 10             	add    $0x10,%esp
80103bc4:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bca:	74 2f                	je     80103bfb <piperead+0x5b>
80103bcc:	eb 37                	jmp    80103c05 <piperead+0x65>
80103bce:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103bd0:	e8 bb 02 00 00       	call   80103e90 <myproc>
80103bd5:	8b 48 28             	mov    0x28(%eax),%ecx
80103bd8:	85 c9                	test   %ecx,%ecx
80103bda:	0f 85 80 00 00 00    	jne    80103c60 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103be0:	83 ec 08             	sub    $0x8,%esp
80103be3:	56                   	push   %esi
80103be4:	53                   	push   %ebx
80103be5:	e8 f6 0c 00 00       	call   801048e0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103bea:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103bf0:	83 c4 10             	add    $0x10,%esp
80103bf3:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103bf9:	75 0a                	jne    80103c05 <piperead+0x65>
80103bfb:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103c01:	85 c0                	test   %eax,%eax
80103c03:	75 cb                	jne    80103bd0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c05:	8b 55 10             	mov    0x10(%ebp),%edx
80103c08:	31 db                	xor    %ebx,%ebx
80103c0a:	85 d2                	test   %edx,%edx
80103c0c:	7f 20                	jg     80103c2e <piperead+0x8e>
80103c0e:	eb 2c                	jmp    80103c3c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103c10:	8d 48 01             	lea    0x1(%eax),%ecx
80103c13:	25 ff 01 00 00       	and    $0x1ff,%eax
80103c18:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103c1e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103c23:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c26:	83 c3 01             	add    $0x1,%ebx
80103c29:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c2c:	74 0e                	je     80103c3c <piperead+0x9c>
    if(p->nread == p->nwrite)
80103c2e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c34:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c3a:	75 d4                	jne    80103c10 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103c3c:	83 ec 0c             	sub    $0xc,%esp
80103c3f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c45:	50                   	push   %eax
80103c46:	e8 55 0d 00 00       	call   801049a0 <wakeup>
  release(&p->lock);
80103c4b:	89 34 24             	mov    %esi,(%esp)
80103c4e:	e8 9d 13 00 00       	call   80104ff0 <release>
  return i;
80103c53:	83 c4 10             	add    $0x10,%esp
}
80103c56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c59:	89 d8                	mov    %ebx,%eax
80103c5b:	5b                   	pop    %ebx
80103c5c:	5e                   	pop    %esi
80103c5d:	5f                   	pop    %edi
80103c5e:	5d                   	pop    %ebp
80103c5f:	c3                   	ret    
      release(&p->lock);
80103c60:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c63:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c68:	56                   	push   %esi
80103c69:	e8 82 13 00 00       	call   80104ff0 <release>
      return -1;
80103c6e:	83 c4 10             	add    $0x10,%esp
}
80103c71:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c74:	89 d8                	mov    %ebx,%eax
80103c76:	5b                   	pop    %ebx
80103c77:	5e                   	pop    %esi
80103c78:	5f                   	pop    %edi
80103c79:	5d                   	pop    %ebp
80103c7a:	c3                   	ret    
80103c7b:	66 90                	xchg   %ax,%ax
80103c7d:	66 90                	xchg   %ax,%ax
80103c7f:	90                   	nop

80103c80 <allocproc>:
// Otherwise return 0.

int first_time = 1;
static struct proc*
allocproc(void)
{
80103c80:	55                   	push   %ebp
80103c81:	89 e5                	mov    %esp,%ebp
80103c83:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c84:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
{
80103c89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c8c:	68 40 2d 11 80       	push   $0x80112d40
80103c91:	e8 ba 13 00 00       	call   80105050 <acquire>
80103c96:	83 c4 10             	add    $0x10,%esp
80103c99:	eb 17                	jmp    80103cb2 <allocproc+0x32>
80103c9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c9f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103ca0:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103ca6:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80103cac:	0f 84 be 00 00 00    	je     80103d70 <allocproc+0xf0>
    if(p->state == UNUSED)
80103cb2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103cb5:	85 c0                	test   %eax,%eax
80103cb7:	75 e7                	jne    80103ca0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103cb9:	a1 08 b0 10 80       	mov    0x8010b008,%eax

  // RR queue initialization
  p->RR_priority = next_RR_priority;
  next_RR_priority++;

  release(&ptable.lock);
80103cbe:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103cc1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->level = 2;   // Default scheduling queue (LCFS)
80103cc8:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103ccf:	00 00 00 
  p->pid = nextpid++;
80103cd2:	8d 50 01             	lea    0x1(%eax),%edx
80103cd5:	89 43 10             	mov    %eax,0x10(%ebx)
  p->arrival_time = ticks;
80103cd8:	a1 80 53 11 80       	mov    0x80115380,%eax
  p->exec_cycle = 1;
80103cdd:	c7 83 88 00 00 00 01 	movl   $0x1,0x88(%ebx)
80103ce4:	00 00 00 
  p->arrival_time = ticks;
80103ce7:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  p->HRRN_priority = ticks * 100; // default unique priority (will change in relevant syscall)
80103ced:	6b c0 64             	imul   $0x64,%eax,%eax
  p->last_execution = 0;
80103cf0:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
80103cf7:	00 00 00 
  p->pid = nextpid++;
80103cfa:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  p->HRRN_priority = ticks * 100; // default unique priority (will change in relevant syscall)
80103d00:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  p->RR_priority = next_RR_priority;
80103d06:	a1 20 2d 11 80       	mov    0x80112d20,%eax
80103d0b:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  next_RR_priority++;
80103d11:	83 c0 01             	add    $0x1,%eax
  release(&ptable.lock);
80103d14:	68 40 2d 11 80       	push   $0x80112d40
  next_RR_priority++;
80103d19:	a3 20 2d 11 80       	mov    %eax,0x80112d20
  release(&ptable.lock);
80103d1e:	e8 cd 12 00 00       	call   80104ff0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d23:	e8 28 ee ff ff       	call   80102b50 <kalloc>
80103d28:	83 c4 10             	add    $0x10,%esp
80103d2b:	89 43 08             	mov    %eax,0x8(%ebx)
80103d2e:	85 c0                	test   %eax,%eax
80103d30:	74 57                	je     80103d89 <allocproc+0x109>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103d32:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103d38:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d3b:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d40:	89 53 1c             	mov    %edx,0x1c(%ebx)
  *(uint*)sp = (uint)trapret;
80103d43:	c7 40 14 7f 65 10 80 	movl   $0x8010657f,0x14(%eax)
  p->context = (struct context*)sp;
80103d4a:	89 43 20             	mov    %eax,0x20(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d4d:	6a 14                	push   $0x14
80103d4f:	6a 00                	push   $0x0
80103d51:	50                   	push   %eax
80103d52:	e8 b9 13 00 00       	call   80105110 <memset>
  p->context->eip = (uint)forkret;
80103d57:	8b 43 20             	mov    0x20(%ebx),%eax

  return p;
80103d5a:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d5d:	c7 40 10 a0 3d 10 80 	movl   $0x80103da0,0x10(%eax)
}
80103d64:	89 d8                	mov    %ebx,%eax
80103d66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d69:	c9                   	leave  
80103d6a:	c3                   	ret    
80103d6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d6f:	90                   	nop
  release(&ptable.lock);
80103d70:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d73:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d75:	68 40 2d 11 80       	push   $0x80112d40
80103d7a:	e8 71 12 00 00       	call   80104ff0 <release>
}
80103d7f:	89 d8                	mov    %ebx,%eax
  return 0;
80103d81:	83 c4 10             	add    $0x10,%esp
}
80103d84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d87:	c9                   	leave  
80103d88:	c3                   	ret    
    p->state = UNUSED;
80103d89:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d90:	31 db                	xor    %ebx,%ebx
}
80103d92:	89 d8                	mov    %ebx,%eax
80103d94:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d97:	c9                   	leave  
80103d98:	c3                   	ret    
80103d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103da0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103da6:	68 40 2d 11 80       	push   $0x80112d40
80103dab:	e8 40 12 00 00       	call   80104ff0 <release>

  if (first) {
80103db0:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	85 c0                	test   %eax,%eax
80103dba:	75 04                	jne    80103dc0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103dbc:	c9                   	leave  
80103dbd:	c3                   	ret    
80103dbe:	66 90                	xchg   %ax,%ax
    first = 0;
80103dc0:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103dc7:	00 00 00 
    iinit(ROOTDEV);
80103dca:	83 ec 0c             	sub    $0xc,%esp
80103dcd:	6a 01                	push   $0x1
80103dcf:	e8 4c dc ff ff       	call   80101a20 <iinit>
    initlog(ROOTDEV);
80103dd4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103ddb:	e8 b0 f3 ff ff       	call   80103190 <initlog>
}
80103de0:	83 c4 10             	add    $0x10,%esp
80103de3:	c9                   	leave  
80103de4:	c3                   	ret    
80103de5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103dec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103df0 <pinit>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103df6:	68 80 84 10 80       	push   $0x80108480
80103dfb:	68 40 2d 11 80       	push   $0x80112d40
80103e00:	e8 7b 10 00 00       	call   80104e80 <initlock>
}
80103e05:	83 c4 10             	add    $0x10,%esp
80103e08:	c9                   	leave  
80103e09:	c3                   	ret    
80103e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e10 <mycpu>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	56                   	push   %esi
80103e14:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e15:	9c                   	pushf  
80103e16:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e17:	f6 c4 02             	test   $0x2,%ah
80103e1a:	75 46                	jne    80103e62 <mycpu+0x52>
  apicid = lapicid();
80103e1c:	e8 9f ef ff ff       	call   80102dc0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e21:	8b 35 84 27 11 80    	mov    0x80112784,%esi
80103e27:	85 f6                	test   %esi,%esi
80103e29:	7e 2a                	jle    80103e55 <mycpu+0x45>
80103e2b:	31 d2                	xor    %edx,%edx
80103e2d:	eb 08                	jmp    80103e37 <mycpu+0x27>
80103e2f:	90                   	nop
80103e30:	83 c2 01             	add    $0x1,%edx
80103e33:	39 f2                	cmp    %esi,%edx
80103e35:	74 1e                	je     80103e55 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103e37:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103e3d:	0f b6 99 a0 27 11 80 	movzbl -0x7feed860(%ecx),%ebx
80103e44:	39 c3                	cmp    %eax,%ebx
80103e46:	75 e8                	jne    80103e30 <mycpu+0x20>
}
80103e48:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103e4b:	8d 81 a0 27 11 80    	lea    -0x7feed860(%ecx),%eax
}
80103e51:	5b                   	pop    %ebx
80103e52:	5e                   	pop    %esi
80103e53:	5d                   	pop    %ebp
80103e54:	c3                   	ret    
  panic("unknown apicid\n");
80103e55:	83 ec 0c             	sub    $0xc,%esp
80103e58:	68 87 84 10 80       	push   $0x80108487
80103e5d:	e8 1e c5 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e62:	83 ec 0c             	sub    $0xc,%esp
80103e65:	68 84 85 10 80       	push   $0x80108584
80103e6a:	e8 11 c5 ff ff       	call   80100380 <panic>
80103e6f:	90                   	nop

80103e70 <cpuid>:
cpuid() {
80103e70:	55                   	push   %ebp
80103e71:	89 e5                	mov    %esp,%ebp
80103e73:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103e76:	e8 95 ff ff ff       	call   80103e10 <mycpu>
}
80103e7b:	c9                   	leave  
  return mycpu()-cpus;
80103e7c:	2d a0 27 11 80       	sub    $0x801127a0,%eax
80103e81:	c1 f8 04             	sar    $0x4,%eax
80103e84:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103e8a:	c3                   	ret    
80103e8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103e8f:	90                   	nop

80103e90 <myproc>:
myproc(void) {
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	53                   	push   %ebx
80103e94:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103e97:	e8 64 10 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80103e9c:	e8 6f ff ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80103ea1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea7:	e8 a4 10 00 00       	call   80104f50 <popcli>
}
80103eac:	89 d8                	mov    %ebx,%eax
80103eae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103eb1:	c9                   	leave  
80103eb2:	c3                   	ret    
80103eb3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ec0 <userinit>:
{
80103ec0:	55                   	push   %ebp
80103ec1:	89 e5                	mov    %esp,%ebp
80103ec3:	53                   	push   %ebx
80103ec4:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ec7:	e8 b4 fd ff ff       	call   80103c80 <allocproc>
80103ecc:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103ece:	a3 74 53 11 80       	mov    %eax,0x80115374
  if((p->pgdir = setupkvm()) == 0)
80103ed3:	e8 b8 3c 00 00       	call   80107b90 <setupkvm>
80103ed8:	89 43 04             	mov    %eax,0x4(%ebx)
80103edb:	85 c0                	test   %eax,%eax
80103edd:	0f 84 d6 00 00 00    	je     80103fb9 <userinit+0xf9>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ee3:	83 ec 04             	sub    $0x4,%esp
80103ee6:	68 2c 00 00 00       	push   $0x2c
80103eeb:	68 60 b4 10 80       	push   $0x8010b460
80103ef0:	50                   	push   %eax
80103ef1:	e8 4a 39 00 00       	call   80107840 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ef6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ef9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103eff:	6a 4c                	push   $0x4c
80103f01:	6a 00                	push   $0x0
80103f03:	ff 73 1c             	pushl  0x1c(%ebx)
80103f06:	e8 05 12 00 00       	call   80105110 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f0b:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f0e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f13:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f18:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f1c:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f1f:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103f23:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f26:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f2a:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103f2e:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f31:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f35:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103f39:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f3c:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103f43:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f46:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103f4d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f50:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  p->level = 2;
80103f57:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103f5e:	00 00 00 
    cprintf("init PID: %d \n", p->pid);
80103f61:	58                   	pop    %eax
80103f62:	5a                   	pop    %edx
80103f63:	ff 73 10             	pushl  0x10(%ebx)
80103f66:	68 b0 84 10 80       	push   $0x801084b0
80103f6b:	e8 30 c7 ff ff       	call   801006a0 <cprintf>
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f70:	83 c4 0c             	add    $0xc,%esp
80103f73:	8d 43 70             	lea    0x70(%ebx),%eax
80103f76:	6a 10                	push   $0x10
80103f78:	68 bf 84 10 80       	push   $0x801084bf
80103f7d:	50                   	push   %eax
80103f7e:	e8 4d 13 00 00       	call   801052d0 <safestrcpy>
  p->cwd = namei("/");
80103f83:	c7 04 24 c8 84 10 80 	movl   $0x801084c8,(%esp)
80103f8a:	e8 d1 e5 ff ff       	call   80102560 <namei>
80103f8f:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103f92:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f99:	e8 b2 10 00 00       	call   80105050 <acquire>
  p->state = RUNNABLE;
80103f9e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fa5:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103fac:	e8 3f 10 00 00       	call   80104ff0 <release>
}
80103fb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb4:	83 c4 10             	add    $0x10,%esp
80103fb7:	c9                   	leave  
80103fb8:	c3                   	ret    
    panic("userinit: out of memory?");
80103fb9:	83 ec 0c             	sub    $0xc,%esp
80103fbc:	68 97 84 10 80       	push   $0x80108497
80103fc1:	e8 ba c3 ff ff       	call   80100380 <panic>
80103fc6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fcd:	8d 76 00             	lea    0x0(%esi),%esi

80103fd0 <growproc>:
{
80103fd0:	55                   	push   %ebp
80103fd1:	89 e5                	mov    %esp,%ebp
80103fd3:	56                   	push   %esi
80103fd4:	53                   	push   %ebx
80103fd5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103fd8:	e8 23 0f 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80103fdd:	e8 2e fe ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80103fe2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fe8:	e8 63 0f 00 00       	call   80104f50 <popcli>
  sz = curproc->sz;
80103fed:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103fef:	85 f6                	test   %esi,%esi
80103ff1:	7f 1d                	jg     80104010 <growproc+0x40>
  } else if(n < 0){
80103ff3:	75 3b                	jne    80104030 <growproc+0x60>
  switchuvm(curproc);
80103ff5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ff8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103ffa:	53                   	push   %ebx
80103ffb:	e8 30 37 00 00       	call   80107730 <switchuvm>
  return 0;
80104000:	83 c4 10             	add    $0x10,%esp
80104003:	31 c0                	xor    %eax,%eax
}
80104005:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104008:	5b                   	pop    %ebx
80104009:	5e                   	pop    %esi
8010400a:	5d                   	pop    %ebp
8010400b:	c3                   	ret    
8010400c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104010:	83 ec 04             	sub    $0x4,%esp
80104013:	01 c6                	add    %eax,%esi
80104015:	56                   	push   %esi
80104016:	50                   	push   %eax
80104017:	ff 73 04             	pushl  0x4(%ebx)
8010401a:	e8 91 39 00 00       	call   801079b0 <allocuvm>
8010401f:	83 c4 10             	add    $0x10,%esp
80104022:	85 c0                	test   %eax,%eax
80104024:	75 cf                	jne    80103ff5 <growproc+0x25>
      return -1;
80104026:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010402b:	eb d8                	jmp    80104005 <growproc+0x35>
8010402d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104030:	83 ec 04             	sub    $0x4,%esp
80104033:	01 c6                	add    %eax,%esi
80104035:	56                   	push   %esi
80104036:	50                   	push   %eax
80104037:	ff 73 04             	pushl  0x4(%ebx)
8010403a:	e8 a1 3a 00 00       	call   80107ae0 <deallocuvm>
8010403f:	83 c4 10             	add    $0x10,%esp
80104042:	85 c0                	test   %eax,%eax
80104044:	75 af                	jne    80103ff5 <growproc+0x25>
80104046:	eb de                	jmp    80104026 <growproc+0x56>
80104048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404f:	90                   	nop

80104050 <fork>:
{
80104050:	55                   	push   %ebp
80104051:	89 e5                	mov    %esp,%ebp
80104053:	57                   	push   %edi
80104054:	56                   	push   %esi
80104055:	53                   	push   %ebx
80104056:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104059:	e8 a2 0e 00 00       	call   80104f00 <pushcli>
  c = mycpu();
8010405e:	e8 ad fd ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104063:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104069:	e8 e2 0e 00 00       	call   80104f50 <popcli>
  if((np = allocproc()) == 0){
8010406e:	e8 0d fc ff ff       	call   80103c80 <allocproc>
80104073:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104076:	85 c0                	test   %eax,%eax
80104078:	0f 84 c7 00 00 00    	je     80104145 <fork+0xf5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010407e:	83 ec 08             	sub    $0x8,%esp
80104081:	ff 33                	pushl  (%ebx)
80104083:	89 c7                	mov    %eax,%edi
80104085:	ff 73 04             	pushl  0x4(%ebx)
80104088:	e8 f3 3b 00 00       	call   80107c80 <copyuvm>
8010408d:	83 c4 10             	add    $0x10,%esp
80104090:	89 47 04             	mov    %eax,0x4(%edi)
80104093:	85 c0                	test   %eax,%eax
80104095:	0f 84 b1 00 00 00    	je     8010414c <fork+0xfc>
  np->sz = curproc->sz;
8010409b:	8b 03                	mov    (%ebx),%eax
8010409d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801040a0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801040a2:	8b 79 1c             	mov    0x1c(%ecx),%edi
  np->parent = curproc;
801040a5:	89 c8                	mov    %ecx,%eax
801040a7:	89 59 14             	mov    %ebx,0x14(%ecx)
  np->tracer = 0;
801040aa:	c7 41 18 00 00 00 00 	movl   $0x0,0x18(%ecx)
  *np->tf = *curproc->tf;
801040b1:	b9 13 00 00 00       	mov    $0x13,%ecx
801040b6:	8b 73 1c             	mov    0x1c(%ebx),%esi
801040b9:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801040bb:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801040bd:	8b 40 1c             	mov    0x1c(%eax),%eax
801040c0:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801040c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801040ce:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[i])
801040d0:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
801040d4:	85 c0                	test   %eax,%eax
801040d6:	74 13                	je     801040eb <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801040d8:	83 ec 0c             	sub    $0xc,%esp
801040db:	50                   	push   %eax
801040dc:	e8 7f d2 ff ff       	call   80101360 <filedup>
801040e1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801040e4:	83 c4 10             	add    $0x10,%esp
801040e7:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801040eb:	83 c6 01             	add    $0x1,%esi
801040ee:	83 fe 10             	cmp    $0x10,%esi
801040f1:	75 dd                	jne    801040d0 <fork+0x80>
  np->cwd = idup(curproc->cwd);
801040f3:	83 ec 0c             	sub    $0xc,%esp
801040f6:	ff 73 6c             	pushl  0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801040f9:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
801040fc:	e8 0f db ff ff       	call   80101c10 <idup>
80104101:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104104:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104107:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010410a:	8d 47 70             	lea    0x70(%edi),%eax
8010410d:	6a 10                	push   $0x10
8010410f:	53                   	push   %ebx
80104110:	50                   	push   %eax
80104111:	e8 ba 11 00 00       	call   801052d0 <safestrcpy>
  pid = np->pid;
80104116:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104119:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104120:	e8 2b 0f 00 00       	call   80105050 <acquire>
  np->state = RUNNABLE;
80104125:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010412c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104133:	e8 b8 0e 00 00       	call   80104ff0 <release>
  return pid;
80104138:	83 c4 10             	add    $0x10,%esp
}
8010413b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010413e:	89 d8                	mov    %ebx,%eax
80104140:	5b                   	pop    %ebx
80104141:	5e                   	pop    %esi
80104142:	5f                   	pop    %edi
80104143:	5d                   	pop    %ebp
80104144:	c3                   	ret    
    return -1;
80104145:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010414a:	eb ef                	jmp    8010413b <fork+0xeb>
    kfree(np->kstack);
8010414c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010414f:	83 ec 0c             	sub    $0xc,%esp
80104152:	ff 73 08             	pushl  0x8(%ebx)
80104155:	e8 36 e8 ff ff       	call   80102990 <kfree>
    np->kstack = 0;
8010415a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104161:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104164:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010416b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104170:	eb c9                	jmp    8010413b <fork+0xeb>
80104172:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104180 <set_HRRN_process_level>:
void set_HRRN_process_level(int pid , int priority){
80104180:	55                   	push   %ebp
80104181:	89 e5                	mov    %esp,%ebp
80104183:	56                   	push   %esi
80104184:	53                   	push   %ebx
80104185:	8b 75 0c             	mov    0xc(%ebp),%esi
80104188:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010418b:	83 ec 0c             	sub    $0xc,%esp
8010418e:	68 40 2d 11 80       	push   $0x80112d40
80104193:	e8 b8 0e 00 00       	call   80105050 <acquire>
80104198:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010419b:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
    if(p->pid == pid){
801041a0:	39 58 10             	cmp    %ebx,0x10(%eax)
801041a3:	75 06                	jne    801041ab <set_HRRN_process_level+0x2b>
      p->HRRN_priority = priority;
801041a5:	89 b0 84 00 00 00    	mov    %esi,0x84(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801041ab:	05 98 00 00 00       	add    $0x98,%eax
801041b0:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801041b5:	75 e9                	jne    801041a0 <set_HRRN_process_level+0x20>
  release(&ptable.lock);
801041b7:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801041be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041c1:	5b                   	pop    %ebx
801041c2:	5e                   	pop    %esi
801041c3:	5d                   	pop    %ebp
  release(&ptable.lock);
801041c4:	e9 27 0e 00 00       	jmp    80104ff0 <release>
801041c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041d0 <get_HRRN_priority>:
float get_HRRN_priority(struct proc* p){
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	56                   	push   %esi
801041d4:	53                   	push   %ebx
801041d5:	83 ec 1c             	sub    $0x1c,%esp
801041d8:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&tickslock);
801041db:	68 a0 53 11 80       	push   $0x801153a0
801041e0:	e8 6b 0e 00 00       	call   80105050 <acquire>
  int current = ticks;
801041e5:	8b 35 80 53 11 80    	mov    0x80115380,%esi
  release(&tickslock);
801041eb:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
801041f2:	e8 f9 0d 00 00       	call   80104ff0 <release>
  float waiting_time = (float)(current - p->arrival_time);
801041f7:	89 f0                	mov    %esi,%eax
801041f9:	2b 83 90 00 00 00    	sub    0x90(%ebx),%eax
  cprintf("waiting time : %f\n", waiting_time);
801041ff:	c7 04 24 ca 84 10 80 	movl   $0x801084ca,(%esp)
  float waiting_time = (float)(current - p->arrival_time);
80104206:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104209:	db 45 f4             	fildl  -0xc(%ebp)
  cprintf("waiting time : %f\n", waiting_time);
8010420c:	d9 c0                	fld    %st(0)
8010420e:	d9 5d f4             	fstps  -0xc(%ebp)
80104211:	dd 5c 24 04          	fstpl  0x4(%esp)
80104215:	e8 86 c4 ff ff       	call   801006a0 <cprintf>
  float HRRN = (waiting_time + p->exec_cycle) / p->exec_cycle;
8010421a:	db 83 88 00 00 00    	fildl  0x88(%ebx)
  return (HRRN + p->HRRN_priority) / 2;
80104220:	db 83 84 00 00 00    	fildl  0x84(%ebx)
  float HRRN = (waiting_time + p->exec_cycle) / p->exec_cycle;
80104226:	d9 45 f4             	flds   -0xc(%ebp)
80104229:	d8 c2                	fadd   %st(2),%st
8010422b:	de f2                	fdivp  %st,%st(2)
  return (HRRN + p->HRRN_priority) / 2;
8010422d:	de c1                	faddp  %st,%st(1)
8010422f:	d8 0d c4 85 10 80    	fmuls  0x801085c4
}
80104235:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104238:	5b                   	pop    %ebx
80104239:	5e                   	pop    %esi
8010423a:	5d                   	pop    %ebp
8010423b:	c3                   	ret    
8010423c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104240 <HRRN>:
struct proc* HRRN(){
80104240:	55                   	push   %ebp
80104241:	89 e5                	mov    %esp,%ebp
80104243:	56                   	push   %esi
    struct proc* p,* min_p = 0;
80104244:	31 f6                	xor    %esi,%esi
struct proc* HRRN(){
80104246:	53                   	push   %ebx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104247:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
struct proc* HRRN(){
8010424c:	83 ec 10             	sub    $0x10,%esp
    float min_priority = 9999999;
8010424f:	d9 05 c8 85 10 80    	flds   0x801085c8
80104255:	d9 5d f4             	fstps  -0xc(%ebp)
80104258:	eb 14                	jmp    8010426e <HRRN+0x2e>
8010425a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104260:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104266:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
8010426c:	74 43                	je     801042b1 <HRRN+0x71>
      if(p -> state == RUNNABLE && p -> level == 3){
8010426e:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104272:	75 ec                	jne    80104260 <HRRN+0x20>
80104274:	83 bb 80 00 00 00 03 	cmpl   $0x3,0x80(%ebx)
8010427b:	75 e3                	jne    80104260 <HRRN+0x20>
        if(get_HRRN_priority(p) < min_priority){
8010427d:	83 ec 0c             	sub    $0xc,%esp
80104280:	53                   	push   %ebx
80104281:	e8 4a ff ff ff       	call   801041d0 <get_HRRN_priority>
80104286:	d9 45 f4             	flds   -0xc(%ebp)
80104289:	83 c4 10             	add    $0x10,%esp
8010428c:	df f1                	fcomip %st(1),%st
8010428e:	dd d8                	fstp   %st(0)
80104290:	76 ce                	jbe    80104260 <HRRN+0x20>
          min_priority = get_HRRN_priority(p);
80104292:	83 ec 0c             	sub    $0xc,%esp
80104295:	89 de                	mov    %ebx,%esi
80104297:	53                   	push   %ebx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104298:	81 c3 98 00 00 00    	add    $0x98,%ebx
          min_priority = get_HRRN_priority(p);
8010429e:	e8 2d ff ff ff       	call   801041d0 <get_HRRN_priority>
801042a3:	83 c4 10             	add    $0x10,%esp
801042a6:	d9 5d f4             	fstps  -0xc(%ebp)
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042a9:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
801042af:	75 bd                	jne    8010426e <HRRN+0x2e>
}
801042b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042b4:	89 f0                	mov    %esi,%eax
801042b6:	5b                   	pop    %ebx
801042b7:	5e                   	pop    %esi
801042b8:	5d                   	pop    %ebp
801042b9:	c3                   	ret    
801042ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801042c0 <RR>:
struct proc* RR(){
801042c0:	55                   	push   %ebp
    int min_priority = 9999999, max_priority = -1;
801042c1:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042c6:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
struct proc* RR(){
801042cb:	89 e5                	mov    %esp,%ebp
801042cd:	56                   	push   %esi
    struct proc* p,*min_p = 0;
801042ce:	31 f6                	xor    %esi,%esi
struct proc* RR(){
801042d0:	53                   	push   %ebx
    int min_priority = 9999999, max_priority = -1;
801042d1:	bb 7f 96 98 00       	mov    $0x98967f,%ebx
801042d6:	eb 14                	jmp    801042ec <RR+0x2c>
801042d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801042df:	90                   	nop
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042e0:	05 98 00 00 00       	add    $0x98,%eax
801042e5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801042ea:	74 34                	je     80104320 <RR+0x60>
        if(p -> state == RUNNABLE && p -> level == 1){
801042ec:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801042f0:	75 ee                	jne    801042e0 <RR+0x20>
801042f2:	83 b8 80 00 00 00 01 	cmpl   $0x1,0x80(%eax)
801042f9:	75 e5                	jne    801042e0 <RR+0x20>
            if(p->RR_priority < min_priority){
801042fb:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80104301:	39 da                	cmp    %ebx,%edx
80104303:	7d 04                	jge    80104309 <RR+0x49>
80104305:	89 d3                	mov    %edx,%ebx
80104307:	89 c6                	mov    %eax,%esi
            if(p->RR_priority > max_priority){
80104309:	39 d1                	cmp    %edx,%ecx
8010430b:	0f 4c ca             	cmovl  %edx,%ecx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010430e:	05 98 00 00 00       	add    $0x98,%eax
80104313:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104318:	75 d2                	jne    801042ec <RR+0x2c>
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(min_p)
80104320:	85 f6                	test   %esi,%esi
80104322:	74 09                	je     8010432d <RR+0x6d>
        min_p->RR_priority = max_priority + 1;
80104324:	83 c1 01             	add    $0x1,%ecx
80104327:	89 8e 8c 00 00 00    	mov    %ecx,0x8c(%esi)
}
8010432d:	89 f0                	mov    %esi,%eax
8010432f:	5b                   	pop    %ebx
80104330:	5e                   	pop    %esi
80104331:	5d                   	pop    %ebp
80104332:	c3                   	ret    
80104333:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010433a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104340 <LCFS>:
  struct proc* p = 0 ,* latest_p = 0;
80104340:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104342:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104347:	eb 13                	jmp    8010435c <LCFS+0x1c>
80104349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104350:	05 98 00 00 00       	add    $0x98,%eax
80104355:	3d 74 53 11 80       	cmp    $0x80115374,%eax
8010435a:	74 2e                	je     8010438a <LCFS+0x4a>
      if(p -> state == RUNNABLE && p -> level == 2){
8010435c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104360:	75 ee                	jne    80104350 <LCFS+0x10>
80104362:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
80104369:	75 e5                	jne    80104350 <LCFS+0x10>
          if(latest_p != 0){
8010436b:	85 d2                	test   %edx,%edx
8010436d:	74 21                	je     80104390 <LCFS+0x50>
              if(p->arrival_time > latest_p->arrival_time)
8010436f:	8b 8a 90 00 00 00    	mov    0x90(%edx),%ecx
80104375:	39 88 90 00 00 00    	cmp    %ecx,0x90(%eax)
8010437b:	0f 4f d0             	cmovg  %eax,%edx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010437e:	05 98 00 00 00       	add    $0x98,%eax
80104383:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104388:	75 d2                	jne    8010435c <LCFS+0x1c>
}
8010438a:	89 d0                	mov    %edx,%eax
8010438c:	c3                   	ret    
8010438d:	8d 76 00             	lea    0x0(%esi),%esi
80104390:	89 c2                	mov    %eax,%edx
80104392:	eb bc                	jmp    80104350 <LCFS+0x10>
80104394:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010439b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010439f:	90                   	nop

801043a0 <aging>:
          if(ticks - p->last_execution >= 8000)
801043a0:	8b 0d 80 53 11 80    	mov    0x80115380,%ecx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043a6:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801043ab:	eb 0f                	jmp    801043bc <aging+0x1c>
801043ad:	8d 76 00             	lea    0x0(%esi),%esi
801043b0:	05 98 00 00 00       	add    $0x98,%eax
801043b5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801043ba:	74 2f                	je     801043eb <aging+0x4b>
      if(p -> state == RUNNABLE /*&& p -> level == 2*/){
801043bc:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801043c0:	75 ee                	jne    801043b0 <aging+0x10>
          if(ticks - p->last_execution >= 8000)
801043c2:	89 ca                	mov    %ecx,%edx
801043c4:	2b 90 94 00 00 00    	sub    0x94(%eax),%edx
801043ca:	81 fa 3f 1f 00 00    	cmp    $0x1f3f,%edx
801043d0:	76 de                	jbe    801043b0 <aging+0x10>
            p->level = 1;
801043d2:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
801043d9:	00 00 00 
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043dc:	05 98 00 00 00       	add    $0x98,%eax
            p->last_execution = ticks;
801043e1:	89 48 fc             	mov    %ecx,-0x4(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043e4:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801043e9:	75 d1                	jne    801043bc <aging+0x1c>
}
801043eb:	c3                   	ret    
801043ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801043f0 <scheduler>:
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	57                   	push   %edi
801043f4:	56                   	push   %esi
801043f5:	53                   	push   %ebx
801043f6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801043f9:	e8 12 fa ff ff       	call   80103e10 <mycpu>
  c->proc = 0;
801043fe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104405:	00 00 00 
  struct cpu *c = mycpu();
80104408:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
8010440a:	8d 70 04             	lea    0x4(%eax),%esi
8010440d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104410:	fb                   	sti    
    acquire(&ptable.lock);
80104411:	83 ec 0c             	sub    $0xc,%esp
80104414:	68 40 2d 11 80       	push   $0x80112d40
80104419:	e8 32 0c 00 00       	call   80105050 <acquire>
     p = RR();
8010441e:	e8 9d fe ff ff       	call   801042c0 <RR>
     if(p == 0)
80104423:	83 c4 10             	add    $0x10,%esp
     p = RR();
80104426:	89 c7                	mov    %eax,%edi
     if(p == 0)
80104428:	85 c0                	test   %eax,%eax
8010442a:	74 54                	je     80104480 <scheduler+0x90>
    switchuvm(p);
8010442c:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
8010442f:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
    switchuvm(p);
80104435:	57                   	push   %edi
80104436:	e8 f5 32 00 00       	call   80107730 <switchuvm>
    p->last_execution = ticks;
8010443b:	a1 80 53 11 80       	mov    0x80115380,%eax
    p->state = RUNNING;
80104440:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
    p->last_execution = ticks;
80104447:	89 87 94 00 00 00    	mov    %eax,0x94(%edi)
    swtch(&(c->scheduler), p->context);
8010444d:	58                   	pop    %eax
8010444e:	5a                   	pop    %edx
8010444f:	ff 77 20             	pushl  0x20(%edi)
80104452:	56                   	push   %esi
80104453:	e8 db 0e 00 00       	call   80105333 <swtch>
    switchkvm();
80104458:	e8 c3 32 00 00       	call   80107720 <switchkvm>
    c->proc = 0;
8010445d:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104464:	00 00 00 
    release(&ptable.lock);
80104467:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010446e:	e8 7d 0b 00 00       	call   80104ff0 <release>
80104473:	83 c4 10             	add    $0x10,%esp
80104476:	eb 98                	jmp    80104410 <scheduler+0x20>
80104478:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010447f:	90                   	nop
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104480:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104485:	eb 17                	jmp    8010449e <scheduler+0xae>
80104487:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010448e:	66 90                	xchg   %ax,%ax
80104490:	81 c2 98 00 00 00    	add    $0x98,%edx
80104496:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
8010449c:	74 32                	je     801044d0 <scheduler+0xe0>
      if(p -> state == RUNNABLE && p -> level == 2){
8010449e:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
801044a2:	75 ec                	jne    80104490 <scheduler+0xa0>
801044a4:	83 ba 80 00 00 00 02 	cmpl   $0x2,0x80(%edx)
801044ab:	75 e3                	jne    80104490 <scheduler+0xa0>
          if(latest_p != 0){
801044ad:	85 ff                	test   %edi,%edi
801044af:	74 3f                	je     801044f0 <scheduler+0x100>
              if(p->arrival_time > latest_p->arrival_time)
801044b1:	8b 87 90 00 00 00    	mov    0x90(%edi),%eax
801044b7:	39 82 90 00 00 00    	cmp    %eax,0x90(%edx)
801044bd:	0f 4f fa             	cmovg  %edx,%edi
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801044c0:	81 c2 98 00 00 00    	add    $0x98,%edx
801044c6:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
801044cc:	75 d0                	jne    8010449e <scheduler+0xae>
801044ce:	66 90                	xchg   %ax,%ax
     if(p == 0){
801044d0:	85 ff                	test   %edi,%edi
801044d2:	0f 85 54 ff ff ff    	jne    8010442c <scheduler+0x3c>
         release(&ptable.lock);
801044d8:	83 ec 0c             	sub    $0xc,%esp
801044db:	68 40 2d 11 80       	push   $0x80112d40
801044e0:	e8 0b 0b 00 00       	call   80104ff0 <release>
          continue;}
801044e5:	83 c4 10             	add    $0x10,%esp
801044e8:	e9 23 ff ff ff       	jmp    80104410 <scheduler+0x20>
801044ed:	8d 76 00             	lea    0x0(%esi),%esi
801044f0:	89 d7                	mov    %edx,%edi
801044f2:	eb 9c                	jmp    80104490 <scheduler+0xa0>
801044f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801044ff:	90                   	nop

80104500 <sched>:
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	56                   	push   %esi
80104504:	53                   	push   %ebx
  pushcli();
80104505:	e8 f6 09 00 00       	call   80104f00 <pushcli>
  c = mycpu();
8010450a:	e8 01 f9 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
8010450f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104515:	e8 36 0a 00 00       	call   80104f50 <popcli>
  if(!holding(&ptable.lock))
8010451a:	83 ec 0c             	sub    $0xc,%esp
8010451d:	68 40 2d 11 80       	push   $0x80112d40
80104522:	e8 89 0a 00 00       	call   80104fb0 <holding>
80104527:	83 c4 10             	add    $0x10,%esp
8010452a:	85 c0                	test   %eax,%eax
8010452c:	74 4f                	je     8010457d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010452e:	e8 dd f8 ff ff       	call   80103e10 <mycpu>
80104533:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010453a:	75 68                	jne    801045a4 <sched+0xa4>
  if(p->state == RUNNING)
8010453c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104540:	74 55                	je     80104597 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104542:	9c                   	pushf  
80104543:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104544:	f6 c4 02             	test   $0x2,%ah
80104547:	75 41                	jne    8010458a <sched+0x8a>
  intena = mycpu()->intena;
80104549:	e8 c2 f8 ff ff       	call   80103e10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010454e:	83 c3 20             	add    $0x20,%ebx
  intena = mycpu()->intena;
80104551:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104557:	e8 b4 f8 ff ff       	call   80103e10 <mycpu>
8010455c:	83 ec 08             	sub    $0x8,%esp
8010455f:	ff 70 04             	pushl  0x4(%eax)
80104562:	53                   	push   %ebx
80104563:	e8 cb 0d 00 00       	call   80105333 <swtch>
  mycpu()->intena = intena;
80104568:	e8 a3 f8 ff ff       	call   80103e10 <mycpu>
}
8010456d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104570:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104576:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104579:	5b                   	pop    %ebx
8010457a:	5e                   	pop    %esi
8010457b:	5d                   	pop    %ebp
8010457c:	c3                   	ret    
    panic("sched ptable.lock");
8010457d:	83 ec 0c             	sub    $0xc,%esp
80104580:	68 dd 84 10 80       	push   $0x801084dd
80104585:	e8 f6 bd ff ff       	call   80100380 <panic>
    panic("sched interruptible");
8010458a:	83 ec 0c             	sub    $0xc,%esp
8010458d:	68 09 85 10 80       	push   $0x80108509
80104592:	e8 e9 bd ff ff       	call   80100380 <panic>
    panic("sched running");
80104597:	83 ec 0c             	sub    $0xc,%esp
8010459a:	68 fb 84 10 80       	push   $0x801084fb
8010459f:	e8 dc bd ff ff       	call   80100380 <panic>
    panic("sched locks");
801045a4:	83 ec 0c             	sub    $0xc,%esp
801045a7:	68 ef 84 10 80       	push   $0x801084ef
801045ac:	e8 cf bd ff ff       	call   80100380 <panic>
801045b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045bf:	90                   	nop

801045c0 <exit>:
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	57                   	push   %edi
801045c4:	56                   	push   %esi
801045c5:	53                   	push   %ebx
801045c6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801045c9:	e8 c2 f8 ff ff       	call   80103e90 <myproc>
  if(curproc == initproc)
801045ce:	39 05 74 53 11 80    	cmp    %eax,0x80115374
801045d4:	0f 84 07 01 00 00    	je     801046e1 <exit+0x121>
801045da:	89 c3                	mov    %eax,%ebx
801045dc:	8d 70 2c             	lea    0x2c(%eax),%esi
801045df:	8d 78 6c             	lea    0x6c(%eax),%edi
801045e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
801045e8:	8b 06                	mov    (%esi),%eax
801045ea:	85 c0                	test   %eax,%eax
801045ec:	74 12                	je     80104600 <exit+0x40>
      fileclose(curproc->ofile[fd]);
801045ee:	83 ec 0c             	sub    $0xc,%esp
801045f1:	50                   	push   %eax
801045f2:	e8 b9 cd ff ff       	call   801013b0 <fileclose>
      curproc->ofile[fd] = 0;
801045f7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801045fd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104600:	83 c6 04             	add    $0x4,%esi
80104603:	39 f7                	cmp    %esi,%edi
80104605:	75 e1                	jne    801045e8 <exit+0x28>
  begin_op();
80104607:	e8 24 ec ff ff       	call   80103230 <begin_op>
  iput(curproc->cwd);
8010460c:	83 ec 0c             	sub    $0xc,%esp
8010460f:	ff 73 6c             	pushl  0x6c(%ebx)
80104612:	e8 59 d7 ff ff       	call   80101d70 <iput>
  end_op();
80104617:	e8 84 ec ff ff       	call   801032a0 <end_op>
  curproc->cwd = 0;
8010461c:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
  acquire(&ptable.lock);
80104623:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010462a:	e8 21 0a 00 00       	call   80105050 <acquire>
  wakeup1(curproc->parent);
8010462f:	8b 53 14             	mov    0x14(%ebx),%edx
80104632:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104635:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010463a:	eb 10                	jmp    8010464c <exit+0x8c>
8010463c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104640:	05 98 00 00 00       	add    $0x98,%eax
80104645:	3d 74 53 11 80       	cmp    $0x80115374,%eax
8010464a:	74 1e                	je     8010466a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
8010464c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104650:	75 ee                	jne    80104640 <exit+0x80>
80104652:	3b 50 24             	cmp    0x24(%eax),%edx
80104655:	75 e9                	jne    80104640 <exit+0x80>
      p->state = RUNNABLE;
80104657:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010465e:	05 98 00 00 00       	add    $0x98,%eax
80104663:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104668:	75 e2                	jne    8010464c <exit+0x8c>
      p->parent = initproc;
8010466a:	8b 0d 74 53 11 80    	mov    0x80115374,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104670:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104675:	eb 17                	jmp    8010468e <exit+0xce>
80104677:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010467e:	66 90                	xchg   %ax,%ax
80104680:	81 c2 98 00 00 00    	add    $0x98,%edx
80104686:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
8010468c:	74 3a                	je     801046c8 <exit+0x108>
    if(p->parent == curproc){
8010468e:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104691:	75 ed                	jne    80104680 <exit+0xc0>
      if(p->state == ZOMBIE)
80104693:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104697:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010469a:	75 e4                	jne    80104680 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010469c:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801046a1:	eb 11                	jmp    801046b4 <exit+0xf4>
801046a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046a7:	90                   	nop
801046a8:	05 98 00 00 00       	add    $0x98,%eax
801046ad:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801046b2:	74 cc                	je     80104680 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
801046b4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046b8:	75 ee                	jne    801046a8 <exit+0xe8>
801046ba:	3b 48 24             	cmp    0x24(%eax),%ecx
801046bd:	75 e9                	jne    801046a8 <exit+0xe8>
      p->state = RUNNABLE;
801046bf:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801046c6:	eb e0                	jmp    801046a8 <exit+0xe8>
  curproc->state = ZOMBIE;
801046c8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801046cf:	e8 2c fe ff ff       	call   80104500 <sched>
  panic("zombie exit");
801046d4:	83 ec 0c             	sub    $0xc,%esp
801046d7:	68 2a 85 10 80       	push   $0x8010852a
801046dc:	e8 9f bc ff ff       	call   80100380 <panic>
    panic("init exiting");
801046e1:	83 ec 0c             	sub    $0xc,%esp
801046e4:	68 1d 85 10 80       	push   $0x8010851d
801046e9:	e8 92 bc ff ff       	call   80100380 <panic>
801046ee:	66 90                	xchg   %ax,%ax

801046f0 <wait>:
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
  pushcli();
801046f5:	e8 06 08 00 00       	call   80104f00 <pushcli>
  c = mycpu();
801046fa:	e8 11 f7 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
801046ff:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104705:	e8 46 08 00 00       	call   80104f50 <popcli>
  acquire(&ptable.lock);
8010470a:	83 ec 0c             	sub    $0xc,%esp
8010470d:	68 40 2d 11 80       	push   $0x80112d40
80104712:	e8 39 09 00 00       	call   80105050 <acquire>
80104717:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010471a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010471c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104721:	eb 13                	jmp    80104736 <wait+0x46>
80104723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104727:	90                   	nop
80104728:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010472e:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104734:	74 1e                	je     80104754 <wait+0x64>
      if(p->parent != curproc)
80104736:	39 73 14             	cmp    %esi,0x14(%ebx)
80104739:	75 ed                	jne    80104728 <wait+0x38>
      if(p->state == ZOMBIE){
8010473b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010473f:	74 5f                	je     801047a0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104741:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
80104747:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010474c:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104752:	75 e2                	jne    80104736 <wait+0x46>
    if(!havekids || curproc->killed){
80104754:	85 c0                	test   %eax,%eax
80104756:	0f 84 9a 00 00 00    	je     801047f6 <wait+0x106>
8010475c:	8b 46 28             	mov    0x28(%esi),%eax
8010475f:	85 c0                	test   %eax,%eax
80104761:	0f 85 8f 00 00 00    	jne    801047f6 <wait+0x106>
  pushcli();
80104767:	e8 94 07 00 00       	call   80104f00 <pushcli>
  c = mycpu();
8010476c:	e8 9f f6 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104771:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104777:	e8 d4 07 00 00       	call   80104f50 <popcli>
  if(p == 0)
8010477c:	85 db                	test   %ebx,%ebx
8010477e:	0f 84 89 00 00 00    	je     8010480d <wait+0x11d>
  p->chan = chan;
80104784:	89 73 24             	mov    %esi,0x24(%ebx)
  p->state = SLEEPING;
80104787:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010478e:	e8 6d fd ff ff       	call   80104500 <sched>
  p->chan = 0;
80104793:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
8010479a:	e9 7b ff ff ff       	jmp    8010471a <wait+0x2a>
8010479f:	90                   	nop
        kfree(p->kstack);
801047a0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801047a3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801047a6:	ff 73 08             	pushl  0x8(%ebx)
801047a9:	e8 e2 e1 ff ff       	call   80102990 <kfree>
        p->kstack = 0;
801047ae:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801047b5:	5a                   	pop    %edx
801047b6:	ff 73 04             	pushl  0x4(%ebx)
801047b9:	e8 52 33 00 00       	call   80107b10 <freevm>
        p->pid = 0;
801047be:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801047c5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801047cc:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
801047d0:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
        p->state = UNUSED;
801047d7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801047de:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
801047e5:	e8 06 08 00 00       	call   80104ff0 <release>
        return pid;
801047ea:	83 c4 10             	add    $0x10,%esp
}
801047ed:	8d 65 f8             	lea    -0x8(%ebp),%esp
801047f0:	89 f0                	mov    %esi,%eax
801047f2:	5b                   	pop    %ebx
801047f3:	5e                   	pop    %esi
801047f4:	5d                   	pop    %ebp
801047f5:	c3                   	ret    
      release(&ptable.lock);
801047f6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801047f9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801047fe:	68 40 2d 11 80       	push   $0x80112d40
80104803:	e8 e8 07 00 00       	call   80104ff0 <release>
      return -1;
80104808:	83 c4 10             	add    $0x10,%esp
8010480b:	eb e0                	jmp    801047ed <wait+0xfd>
    panic("sleep");
8010480d:	83 ec 0c             	sub    $0xc,%esp
80104810:	68 36 85 10 80       	push   $0x80108536
80104815:	e8 66 bb ff ff       	call   80100380 <panic>
8010481a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104820 <yield>:
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104827:	68 40 2d 11 80       	push   $0x80112d40
8010482c:	e8 1f 08 00 00       	call   80105050 <acquire>
  pushcli();
80104831:	e8 ca 06 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80104836:	e8 d5 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
8010483b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104841:	e8 0a 07 00 00       	call   80104f50 <popcli>
  myproc()->state = RUNNABLE;
80104846:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
8010484d:	e8 ae 06 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80104852:	e8 b9 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104857:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010485d:	e8 ee 06 00 00       	call   80104f50 <popcli>
          if(ticks - p->last_execution >= 8000)
80104862:	8b 0d 80 53 11 80    	mov    0x80115380,%ecx
80104868:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010486b:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
  myproc()->exec_cycle += 1;
80104870:	83 83 88 00 00 00 01 	addl   $0x1,0x88(%ebx)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104877:	eb 13                	jmp    8010488c <yield+0x6c>
80104879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104880:	05 98 00 00 00       	add    $0x98,%eax
80104885:	3d 74 53 11 80       	cmp    $0x80115374,%eax
8010488a:	74 2f                	je     801048bb <yield+0x9b>
      if(p -> state == RUNNABLE /*&& p -> level == 2*/){
8010488c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104890:	75 ee                	jne    80104880 <yield+0x60>
          if(ticks - p->last_execution >= 8000)
80104892:	89 ca                	mov    %ecx,%edx
80104894:	2b 90 94 00 00 00    	sub    0x94(%eax),%edx
8010489a:	81 fa 3f 1f 00 00    	cmp    $0x1f3f,%edx
801048a0:	76 de                	jbe    80104880 <yield+0x60>
            p->level = 1;
801048a2:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
801048a9:	00 00 00 
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801048ac:	05 98 00 00 00       	add    $0x98,%eax
            p->last_execution = ticks;
801048b1:	89 48 fc             	mov    %ecx,-0x4(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801048b4:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801048b9:	75 d1                	jne    8010488c <yield+0x6c>
  sched();
801048bb:	e8 40 fc ff ff       	call   80104500 <sched>
  release(&ptable.lock);
801048c0:	83 ec 0c             	sub    $0xc,%esp
801048c3:	68 40 2d 11 80       	push   $0x80112d40
801048c8:	e8 23 07 00 00       	call   80104ff0 <release>
}
801048cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048d0:	83 c4 10             	add    $0x10,%esp
801048d3:	c9                   	leave  
801048d4:	c3                   	ret    
801048d5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048e0 <sleep>:
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	57                   	push   %edi
801048e4:	56                   	push   %esi
801048e5:	53                   	push   %ebx
801048e6:	83 ec 0c             	sub    $0xc,%esp
801048e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801048ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801048ef:	e8 0c 06 00 00       	call   80104f00 <pushcli>
  c = mycpu();
801048f4:	e8 17 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
801048f9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048ff:	e8 4c 06 00 00       	call   80104f50 <popcli>
  if(p == 0)
80104904:	85 db                	test   %ebx,%ebx
80104906:	0f 84 87 00 00 00    	je     80104993 <sleep+0xb3>
  if(lk == 0)
8010490c:	85 f6                	test   %esi,%esi
8010490e:	74 76                	je     80104986 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104910:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
80104916:	74 50                	je     80104968 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104918:	83 ec 0c             	sub    $0xc,%esp
8010491b:	68 40 2d 11 80       	push   $0x80112d40
80104920:	e8 2b 07 00 00       	call   80105050 <acquire>
    release(lk);
80104925:	89 34 24             	mov    %esi,(%esp)
80104928:	e8 c3 06 00 00       	call   80104ff0 <release>
  p->chan = chan;
8010492d:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
80104930:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104937:	e8 c4 fb ff ff       	call   80104500 <sched>
  p->chan = 0;
8010493c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
    release(&ptable.lock);
80104943:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010494a:	e8 a1 06 00 00       	call   80104ff0 <release>
    acquire(lk);
8010494f:	89 75 08             	mov    %esi,0x8(%ebp)
80104952:	83 c4 10             	add    $0x10,%esp
}
80104955:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104958:	5b                   	pop    %ebx
80104959:	5e                   	pop    %esi
8010495a:	5f                   	pop    %edi
8010495b:	5d                   	pop    %ebp
    acquire(lk);
8010495c:	e9 ef 06 00 00       	jmp    80105050 <acquire>
80104961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104968:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
8010496b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104972:	e8 89 fb ff ff       	call   80104500 <sched>
  p->chan = 0;
80104977:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
8010497e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104981:	5b                   	pop    %ebx
80104982:	5e                   	pop    %esi
80104983:	5f                   	pop    %edi
80104984:	5d                   	pop    %ebp
80104985:	c3                   	ret    
    panic("sleep without lk");
80104986:	83 ec 0c             	sub    $0xc,%esp
80104989:	68 3c 85 10 80       	push   $0x8010853c
8010498e:	e8 ed b9 ff ff       	call   80100380 <panic>
    panic("sleep");
80104993:	83 ec 0c             	sub    $0xc,%esp
80104996:	68 36 85 10 80       	push   $0x80108536
8010499b:	e8 e0 b9 ff ff       	call   80100380 <panic>

801049a0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	53                   	push   %ebx
801049a4:	83 ec 10             	sub    $0x10,%esp
801049a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801049aa:	68 40 2d 11 80       	push   $0x80112d40
801049af:	e8 9c 06 00 00       	call   80105050 <acquire>
801049b4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049b7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801049bc:	eb 0e                	jmp    801049cc <wakeup+0x2c>
801049be:	66 90                	xchg   %ax,%ax
801049c0:	05 98 00 00 00       	add    $0x98,%eax
801049c5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801049ca:	74 1e                	je     801049ea <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801049cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801049d0:	75 ee                	jne    801049c0 <wakeup+0x20>
801049d2:	3b 58 24             	cmp    0x24(%eax),%ebx
801049d5:	75 e9                	jne    801049c0 <wakeup+0x20>
      p->state = RUNNABLE;
801049d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049de:	05 98 00 00 00       	add    $0x98,%eax
801049e3:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801049e8:	75 e2                	jne    801049cc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801049ea:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801049f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049f4:	c9                   	leave  
  release(&ptable.lock);
801049f5:	e9 f6 05 00 00       	jmp    80104ff0 <release>
801049fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a00 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104a00:	55                   	push   %ebp
80104a01:	89 e5                	mov    %esp,%ebp
80104a03:	53                   	push   %ebx
80104a04:	83 ec 10             	sub    $0x10,%esp
80104a07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104a0a:	68 40 2d 11 80       	push   $0x80112d40
80104a0f:	e8 3c 06 00 00       	call   80105050 <acquire>
80104a14:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a17:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104a1c:	eb 0e                	jmp    80104a2c <kill+0x2c>
80104a1e:	66 90                	xchg   %ax,%ax
80104a20:	05 98 00 00 00       	add    $0x98,%eax
80104a25:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104a2a:	74 34                	je     80104a60 <kill+0x60>
    if(p->pid == pid){
80104a2c:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a2f:	75 ef                	jne    80104a20 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a31:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a35:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      if(p->state == SLEEPING)
80104a3c:	75 07                	jne    80104a45 <kill+0x45>
        p->state = RUNNABLE;
80104a3e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a45:	83 ec 0c             	sub    $0xc,%esp
80104a48:	68 40 2d 11 80       	push   $0x80112d40
80104a4d:	e8 9e 05 00 00       	call   80104ff0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104a52:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104a55:	83 c4 10             	add    $0x10,%esp
80104a58:	31 c0                	xor    %eax,%eax
}
80104a5a:	c9                   	leave  
80104a5b:	c3                   	ret    
80104a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104a60:	83 ec 0c             	sub    $0xc,%esp
80104a63:	68 40 2d 11 80       	push   $0x80112d40
80104a68:	e8 83 05 00 00       	call   80104ff0 <release>
}
80104a6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104a70:	83 c4 10             	add    $0x10,%esp
80104a73:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a78:	c9                   	leave  
80104a79:	c3                   	ret    
80104a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a80 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a80:	55                   	push   %ebp
80104a81:	89 e5                	mov    %esp,%ebp
80104a83:	57                   	push   %edi
80104a84:	56                   	push   %esi
80104a85:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104a88:	53                   	push   %ebx
80104a89:	bb e4 2d 11 80       	mov    $0x80112de4,%ebx
80104a8e:	83 ec 3c             	sub    $0x3c,%esp
80104a91:	eb 27                	jmp    80104aba <procdump+0x3a>
80104a93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a97:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104a98:	83 ec 0c             	sub    $0xc,%esp
80104a9b:	68 bd 84 10 80       	push   $0x801084bd
80104aa0:	e8 fb bb ff ff       	call   801006a0 <cprintf>
80104aa5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa8:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104aae:	81 fb e4 53 11 80    	cmp    $0x801153e4,%ebx
80104ab4:	0f 84 7e 00 00 00    	je     80104b38 <procdump+0xb8>
    if(p->state == UNUSED)
80104aba:	8b 43 9c             	mov    -0x64(%ebx),%eax
80104abd:	85 c0                	test   %eax,%eax
80104abf:	74 e7                	je     80104aa8 <procdump+0x28>
      state = "???";
80104ac1:	ba 4d 85 10 80       	mov    $0x8010854d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104ac6:	83 f8 05             	cmp    $0x5,%eax
80104ac9:	77 11                	ja     80104adc <procdump+0x5c>
80104acb:	8b 14 85 ac 85 10 80 	mov    -0x7fef7a54(,%eax,4),%edx
      state = "???";
80104ad2:	b8 4d 85 10 80       	mov    $0x8010854d,%eax
80104ad7:	85 d2                	test   %edx,%edx
80104ad9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104adc:	53                   	push   %ebx
80104add:	52                   	push   %edx
80104ade:	ff 73 a0             	pushl  -0x60(%ebx)
80104ae1:	68 51 85 10 80       	push   $0x80108551
80104ae6:	e8 b5 bb ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80104aeb:	83 c4 10             	add    $0x10,%esp
80104aee:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104af2:	75 a4                	jne    80104a98 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104af4:	83 ec 08             	sub    $0x8,%esp
80104af7:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104afa:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104afd:	50                   	push   %eax
80104afe:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104b01:	8b 40 0c             	mov    0xc(%eax),%eax
80104b04:	83 c0 08             	add    $0x8,%eax
80104b07:	50                   	push   %eax
80104b08:	e8 93 03 00 00       	call   80104ea0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b0d:	83 c4 10             	add    $0x10,%esp
80104b10:	8b 17                	mov    (%edi),%edx
80104b12:	85 d2                	test   %edx,%edx
80104b14:	74 82                	je     80104a98 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104b16:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104b19:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104b1c:	52                   	push   %edx
80104b1d:	68 21 7f 10 80       	push   $0x80107f21
80104b22:	e8 79 bb ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b27:	83 c4 10             	add    $0x10,%esp
80104b2a:	39 fe                	cmp    %edi,%esi
80104b2c:	75 e2                	jne    80104b10 <procdump+0x90>
80104b2e:	e9 65 ff ff ff       	jmp    80104a98 <procdump+0x18>
80104b33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b37:	90                   	nop
  }
}
80104b38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b3b:	5b                   	pop    %ebx
80104b3c:	5e                   	pop    %esi
80104b3d:	5f                   	pop    %edi
80104b3e:	5d                   	pop    %ebp
80104b3f:	c3                   	ret    

80104b40 <wait_sleeping>:


int
wait_sleeping(void)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	56                   	push   %esi
80104b44:	53                   	push   %ebx
  pushcli();
80104b45:	e8 b6 03 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80104b4a:	e8 c1 f2 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104b4f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b55:	e8 f6 03 00 00       	call   80104f50 <popcli>
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104b5a:	83 ec 0c             	sub    $0xc,%esp
80104b5d:	68 40 2d 11 80       	push   $0x80112d40
80104b62:	e8 e9 04 00 00       	call   80105050 <acquire>
80104b67:	83 c4 10             	add    $0x10,%esp
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104b6a:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b6c:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104b71:	eb 11                	jmp    80104b84 <wait_sleeping+0x44>
80104b73:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b77:	90                   	nop
80104b78:	05 98 00 00 00       	add    $0x98,%eax
80104b7d:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104b82:	74 1c                	je     80104ba0 <wait_sleeping+0x60>
            if(p->tracer != curproc)
80104b84:	39 58 18             	cmp    %ebx,0x18(%eax)
80104b87:	75 ef                	jne    80104b78 <wait_sleeping+0x38>
                continue;
            havekids = 1;
            if(p->state == SLEEPING){
80104b89:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b8d:	74 51                	je     80104be0 <wait_sleeping+0xa0>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b8f:	05 98 00 00 00       	add    $0x98,%eax
            havekids = 1;
80104b94:	ba 01 00 00 00       	mov    $0x1,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b99:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104b9e:	75 e4                	jne    80104b84 <wait_sleeping+0x44>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104ba0:	85 d2                	test   %edx,%edx
80104ba2:	74 58                	je     80104bfc <wait_sleeping+0xbc>
80104ba4:	8b 43 28             	mov    0x28(%ebx),%eax
80104ba7:	85 c0                	test   %eax,%eax
80104ba9:	75 51                	jne    80104bfc <wait_sleeping+0xbc>
  pushcli();
80104bab:	e8 50 03 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80104bb0:	e8 5b f2 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104bb5:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104bbb:	e8 90 03 00 00       	call   80104f50 <popcli>
  if(p == 0)
80104bc0:	85 f6                	test   %esi,%esi
80104bc2:	74 4f                	je     80104c13 <wait_sleeping+0xd3>
  p->chan = chan;
80104bc4:	89 5e 24             	mov    %ebx,0x24(%esi)
  p->state = SLEEPING;
80104bc7:	c7 46 0c 02 00 00 00 	movl   $0x2,0xc(%esi)
  sched();
80104bce:	e8 2d f9 ff ff       	call   80104500 <sched>
  p->chan = 0;
80104bd3:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
}
80104bda:	eb 8e                	jmp    80104b6a <wait_sleeping+0x2a>
80104bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                release(&ptable.lock);
80104be0:	83 ec 0c             	sub    $0xc,%esp
                pid = p->pid;
80104be3:	8b 58 10             	mov    0x10(%eax),%ebx
                release(&ptable.lock);
80104be6:	68 40 2d 11 80       	push   $0x80112d40
80104beb:	e8 00 04 00 00       	call   80104ff0 <release>
                return pid;
80104bf0:	83 c4 10             	add    $0x10,%esp
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104bf3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bf6:	89 d8                	mov    %ebx,%eax
80104bf8:	5b                   	pop    %ebx
80104bf9:	5e                   	pop    %esi
80104bfa:	5d                   	pop    %ebp
80104bfb:	c3                   	ret    
            release(&ptable.lock);
80104bfc:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104bff:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
            release(&ptable.lock);
80104c04:	68 40 2d 11 80       	push   $0x80112d40
80104c09:	e8 e2 03 00 00       	call   80104ff0 <release>
            return -1;
80104c0e:	83 c4 10             	add    $0x10,%esp
80104c11:	eb e0                	jmp    80104bf3 <wait_sleeping+0xb3>
    panic("sleep");
80104c13:	83 ec 0c             	sub    $0xc,%esp
80104c16:	68 36 85 10 80       	push   $0x80108536
80104c1b:	e8 60 b7 ff ff       	call   80100380 <panic>

80104c20 <set_proc_tracer>:

int set_proc_tracer(void){
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	56                   	push   %esi
80104c24:	53                   	push   %ebx
    int pid;
    if(argint(0, &pid)<0)
80104c25:	8d 45 f4             	lea    -0xc(%ebp),%eax
int set_proc_tracer(void){
80104c28:	83 ec 18             	sub    $0x18,%esp
    if(argint(0, &pid)<0)
80104c2b:	50                   	push   %eax
80104c2c:	6a 00                	push   $0x0
80104c2e:	e8 ad 07 00 00       	call   801053e0 <argint>
80104c33:	83 c4 10             	add    $0x10,%esp
80104c36:	85 c0                	test   %eax,%eax
80104c38:	0f 88 8e 00 00 00    	js     80104ccc <set_proc_tracer+0xac>
        return -1;

    struct proc* p;
    acquire(&ptable.lock);
80104c3e:	83 ec 0c             	sub    $0xc,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c41:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80104c46:	68 40 2d 11 80       	push   $0x80112d40
80104c4b:	e8 00 04 00 00       	call   80105050 <acquire>
        if(p->pid != pid)
80104c50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c53:	83 c4 10             	add    $0x10,%esp
80104c56:	eb 16                	jmp    80104c6e <set_proc_tracer+0x4e>
80104c58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c60:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104c66:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104c6c:	74 42                	je     80104cb0 <set_proc_tracer+0x90>
        if(p->pid != pid)
80104c6e:	39 43 10             	cmp    %eax,0x10(%ebx)
80104c71:	75 ed                	jne    80104c60 <set_proc_tracer+0x40>
            continue;
        if(!p->tracer){
80104c73:	8b 53 18             	mov    0x18(%ebx),%edx
80104c76:	85 d2                	test   %edx,%edx
80104c78:	75 e6                	jne    80104c60 <set_proc_tracer+0x40>
  pushcli();
80104c7a:	e8 81 02 00 00       	call   80104f00 <pushcli>
  c = mycpu();
80104c7f:	e8 8c f1 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104c84:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104c8a:	e8 c1 02 00 00       	call   80104f50 <popcli>
            p->tracer = myproc();
            release(&ptable.lock);
80104c8f:	83 ec 0c             	sub    $0xc,%esp
80104c92:	68 40 2d 11 80       	push   $0x80112d40
            p->tracer = myproc();
80104c97:	89 73 18             	mov    %esi,0x18(%ebx)
            release(&ptable.lock);
80104c9a:	e8 51 03 00 00       	call   80104ff0 <release>
            return pid;
80104c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ca2:	83 c4 10             	add    $0x10,%esp
        }
    }
    release(&ptable.lock);
    return -1;
}
80104ca5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ca8:	5b                   	pop    %ebx
80104ca9:	5e                   	pop    %esi
80104caa:	5d                   	pop    %ebp
80104cab:	c3                   	ret    
80104cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104cb0:	83 ec 0c             	sub    $0xc,%esp
80104cb3:	68 40 2d 11 80       	push   $0x80112d40
80104cb8:	e8 33 03 00 00       	call   80104ff0 <release>
    return -1;
80104cbd:	83 c4 10             	add    $0x10,%esp
}
80104cc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104cc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cc8:	5b                   	pop    %ebx
80104cc9:	5e                   	pop    %esi
80104cca:	5d                   	pop    %ebp
80104ccb:	c3                   	ret    
        return -1;
80104ccc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104cd1:	eb d2                	jmp    80104ca5 <set_proc_tracer+0x85>
80104cd3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ce0 <get_proc_queue_level>:

int get_proc_queue_level(int pid){
80104ce0:	55                   	push   %ebp
    struct proc* p;

//    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
//        cprintf("PID %d's level: %d\n", p->pid, p->level);
//    }
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
80104ce1:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
int get_proc_queue_level(int pid){
80104ce6:	89 e5                	mov    %esp,%ebp
80104ce8:	8b 55 08             	mov    0x8(%ebp),%edx
80104ceb:	eb 0f                	jmp    80104cfc <get_proc_queue_level+0x1c>
80104ced:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
80104cf0:	05 98 00 00 00       	add    $0x98,%eax
80104cf5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104cfa:	74 14                	je     80104d10 <get_proc_queue_level+0x30>
        if (p->pid == pid)
80104cfc:	39 50 10             	cmp    %edx,0x10(%eax)
80104cff:	75 ef                	jne    80104cf0 <get_proc_queue_level+0x10>
            return p->level;
80104d01:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
    }
    return -1;
}
80104d07:	5d                   	pop    %ebp
80104d08:	c3                   	ret    
80104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d15:	5d                   	pop    %ebp
80104d16:	c3                   	ret    
80104d17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <set_proc_queue_level>:

void set_proc_queue_level(int pid, int target_level){
80104d20:	55                   	push   %ebp
    struct proc* p;

    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104d21:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
void set_proc_queue_level(int pid, int target_level){
80104d26:	89 e5                	mov    %esp,%ebp
80104d28:	8b 55 08             	mov    0x8(%ebp),%edx
80104d2b:	eb 0f                	jmp    80104d3c <set_proc_queue_level+0x1c>
80104d2d:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104d30:	05 98 00 00 00       	add    $0x98,%eax
80104d35:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104d3a:	74 0e                	je     80104d4a <set_proc_queue_level+0x2a>
        if(p->pid == pid){
80104d3c:	39 50 10             	cmp    %edx,0x10(%eax)
80104d3f:	75 ef                	jne    80104d30 <set_proc_queue_level+0x10>
            p->level = target_level;
80104d41:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d44:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
            return;
        }
}
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
80104d4c:	66 90                	xchg   %ax,%ax
80104d4e:	66 90                	xchg   %ax,%ax

80104d50 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	53                   	push   %ebx
80104d54:	83 ec 0c             	sub    $0xc,%esp
80104d57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104d5a:	68 cc 85 10 80       	push   $0x801085cc
80104d5f:	8d 43 04             	lea    0x4(%ebx),%eax
80104d62:	50                   	push   %eax
80104d63:	e8 18 01 00 00       	call   80104e80 <initlock>
  lk->name = name;
80104d68:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104d6b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104d71:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104d74:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104d7b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104d7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d81:	c9                   	leave  
80104d82:	c3                   	ret    
80104d83:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d90 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
80104d95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104d98:	8d 73 04             	lea    0x4(%ebx),%esi
80104d9b:	83 ec 0c             	sub    $0xc,%esp
80104d9e:	56                   	push   %esi
80104d9f:	e8 ac 02 00 00       	call   80105050 <acquire>
  while (lk->locked) {
80104da4:	8b 13                	mov    (%ebx),%edx
80104da6:	83 c4 10             	add    $0x10,%esp
80104da9:	85 d2                	test   %edx,%edx
80104dab:	74 16                	je     80104dc3 <acquiresleep+0x33>
80104dad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104db0:	83 ec 08             	sub    $0x8,%esp
80104db3:	56                   	push   %esi
80104db4:	53                   	push   %ebx
80104db5:	e8 26 fb ff ff       	call   801048e0 <sleep>
  while (lk->locked) {
80104dba:	8b 03                	mov    (%ebx),%eax
80104dbc:	83 c4 10             	add    $0x10,%esp
80104dbf:	85 c0                	test   %eax,%eax
80104dc1:	75 ed                	jne    80104db0 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104dc3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104dc9:	e8 c2 f0 ff ff       	call   80103e90 <myproc>
80104dce:	8b 40 10             	mov    0x10(%eax),%eax
80104dd1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104dd4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104dd7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dda:	5b                   	pop    %ebx
80104ddb:	5e                   	pop    %esi
80104ddc:	5d                   	pop    %ebp
  release(&lk->lk);
80104ddd:	e9 0e 02 00 00       	jmp    80104ff0 <release>
80104de2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104df0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	56                   	push   %esi
80104df4:	53                   	push   %ebx
80104df5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104df8:	8d 73 04             	lea    0x4(%ebx),%esi
80104dfb:	83 ec 0c             	sub    $0xc,%esp
80104dfe:	56                   	push   %esi
80104dff:	e8 4c 02 00 00       	call   80105050 <acquire>
  lk->locked = 0;
80104e04:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e0a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104e11:	89 1c 24             	mov    %ebx,(%esp)
80104e14:	e8 87 fb ff ff       	call   801049a0 <wakeup>
  release(&lk->lk);
80104e19:	89 75 08             	mov    %esi,0x8(%ebp)
80104e1c:	83 c4 10             	add    $0x10,%esp
}
80104e1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e22:	5b                   	pop    %ebx
80104e23:	5e                   	pop    %esi
80104e24:	5d                   	pop    %ebp
  release(&lk->lk);
80104e25:	e9 c6 01 00 00       	jmp    80104ff0 <release>
80104e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e30 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	57                   	push   %edi
80104e34:	31 ff                	xor    %edi,%edi
80104e36:	56                   	push   %esi
80104e37:	53                   	push   %ebx
80104e38:	83 ec 18             	sub    $0x18,%esp
80104e3b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104e3e:	8d 73 04             	lea    0x4(%ebx),%esi
80104e41:	56                   	push   %esi
80104e42:	e8 09 02 00 00       	call   80105050 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104e47:	8b 03                	mov    (%ebx),%eax
80104e49:	83 c4 10             	add    $0x10,%esp
80104e4c:	85 c0                	test   %eax,%eax
80104e4e:	75 18                	jne    80104e68 <holdingsleep+0x38>
  release(&lk->lk);
80104e50:	83 ec 0c             	sub    $0xc,%esp
80104e53:	56                   	push   %esi
80104e54:	e8 97 01 00 00       	call   80104ff0 <release>
  return r;
}
80104e59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e5c:	89 f8                	mov    %edi,%eax
80104e5e:	5b                   	pop    %ebx
80104e5f:	5e                   	pop    %esi
80104e60:	5f                   	pop    %edi
80104e61:	5d                   	pop    %ebp
80104e62:	c3                   	ret    
80104e63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e67:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104e68:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104e6b:	e8 20 f0 ff ff       	call   80103e90 <myproc>
80104e70:	39 58 10             	cmp    %ebx,0x10(%eax)
80104e73:	0f 94 c0             	sete   %al
80104e76:	0f b6 c0             	movzbl %al,%eax
80104e79:	89 c7                	mov    %eax,%edi
80104e7b:	eb d3                	jmp    80104e50 <holdingsleep+0x20>
80104e7d:	66 90                	xchg   %ax,%ax
80104e7f:	90                   	nop

80104e80 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e80:	55                   	push   %ebp
80104e81:	89 e5                	mov    %esp,%ebp
80104e83:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104e86:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104e89:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104e8f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104e92:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e99:	5d                   	pop    %ebp
80104e9a:	c3                   	ret    
80104e9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e9f:	90                   	nop

80104ea0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104ea0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104ea1:	31 d2                	xor    %edx,%edx
{
80104ea3:	89 e5                	mov    %esp,%ebp
80104ea5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104ea6:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104ea9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104eac:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104eaf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104eb0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104eb6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104ebc:	77 1a                	ja     80104ed8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104ebe:	8b 58 04             	mov    0x4(%eax),%ebx
80104ec1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104ec4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104ec7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104ec9:	83 fa 0a             	cmp    $0xa,%edx
80104ecc:	75 e2                	jne    80104eb0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104ece:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ed1:	c9                   	leave  
80104ed2:	c3                   	ret    
80104ed3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ed7:	90                   	nop
  for(; i < 10; i++)
80104ed8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104edb:	8d 51 28             	lea    0x28(%ecx),%edx
80104ede:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104ee0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104ee6:	83 c0 04             	add    $0x4,%eax
80104ee9:	39 d0                	cmp    %edx,%eax
80104eeb:	75 f3                	jne    80104ee0 <getcallerpcs+0x40>
}
80104eed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ef0:	c9                   	leave  
80104ef1:	c3                   	ret    
80104ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f00 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	53                   	push   %ebx
80104f04:	83 ec 04             	sub    $0x4,%esp
80104f07:	9c                   	pushf  
80104f08:	5b                   	pop    %ebx
  asm volatile("cli");
80104f09:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104f0a:	e8 01 ef ff ff       	call   80103e10 <mycpu>
80104f0f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104f15:	85 c0                	test   %eax,%eax
80104f17:	74 17                	je     80104f30 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104f19:	e8 f2 ee ff ff       	call   80103e10 <mycpu>
80104f1e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104f25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f28:	c9                   	leave  
80104f29:	c3                   	ret    
80104f2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104f30:	e8 db ee ff ff       	call   80103e10 <mycpu>
80104f35:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104f3b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104f41:	eb d6                	jmp    80104f19 <pushcli+0x19>
80104f43:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f50 <popcli>:

void
popcli(void)
{
80104f50:	55                   	push   %ebp
80104f51:	89 e5                	mov    %esp,%ebp
80104f53:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104f56:	9c                   	pushf  
80104f57:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104f58:	f6 c4 02             	test   $0x2,%ah
80104f5b:	75 35                	jne    80104f92 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104f5d:	e8 ae ee ff ff       	call   80103e10 <mycpu>
80104f62:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104f69:	78 34                	js     80104f9f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104f6b:	e8 a0 ee ff ff       	call   80103e10 <mycpu>
80104f70:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104f76:	85 d2                	test   %edx,%edx
80104f78:	74 06                	je     80104f80 <popcli+0x30>
    sti();
}
80104f7a:	c9                   	leave  
80104f7b:	c3                   	ret    
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104f80:	e8 8b ee ff ff       	call   80103e10 <mycpu>
80104f85:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104f8b:	85 c0                	test   %eax,%eax
80104f8d:	74 eb                	je     80104f7a <popcli+0x2a>
  asm volatile("sti");
80104f8f:	fb                   	sti    
}
80104f90:	c9                   	leave  
80104f91:	c3                   	ret    
    panic("popcli - interruptible");
80104f92:	83 ec 0c             	sub    $0xc,%esp
80104f95:	68 d7 85 10 80       	push   $0x801085d7
80104f9a:	e8 e1 b3 ff ff       	call   80100380 <panic>
    panic("popcli");
80104f9f:	83 ec 0c             	sub    $0xc,%esp
80104fa2:	68 ee 85 10 80       	push   $0x801085ee
80104fa7:	e8 d4 b3 ff ff       	call   80100380 <panic>
80104fac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104fb0 <holding>:
{
80104fb0:	55                   	push   %ebp
80104fb1:	89 e5                	mov    %esp,%ebp
80104fb3:	56                   	push   %esi
80104fb4:	53                   	push   %ebx
80104fb5:	8b 75 08             	mov    0x8(%ebp),%esi
80104fb8:	31 db                	xor    %ebx,%ebx
  pushcli();
80104fba:	e8 41 ff ff ff       	call   80104f00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104fbf:	8b 06                	mov    (%esi),%eax
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	75 0b                	jne    80104fd0 <holding+0x20>
  popcli();
80104fc5:	e8 86 ff ff ff       	call   80104f50 <popcli>
}
80104fca:	89 d8                	mov    %ebx,%eax
80104fcc:	5b                   	pop    %ebx
80104fcd:	5e                   	pop    %esi
80104fce:	5d                   	pop    %ebp
80104fcf:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104fd0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104fd3:	e8 38 ee ff ff       	call   80103e10 <mycpu>
80104fd8:	39 c3                	cmp    %eax,%ebx
80104fda:	0f 94 c3             	sete   %bl
  popcli();
80104fdd:	e8 6e ff ff ff       	call   80104f50 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104fe2:	0f b6 db             	movzbl %bl,%ebx
}
80104fe5:	89 d8                	mov    %ebx,%eax
80104fe7:	5b                   	pop    %ebx
80104fe8:	5e                   	pop    %esi
80104fe9:	5d                   	pop    %ebp
80104fea:	c3                   	ret    
80104feb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fef:	90                   	nop

80104ff0 <release>:
{
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	53                   	push   %ebx
80104ff5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104ff8:	e8 03 ff ff ff       	call   80104f00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104ffd:	8b 03                	mov    (%ebx),%eax
80104fff:	85 c0                	test   %eax,%eax
80105001:	75 15                	jne    80105018 <release+0x28>
  popcli();
80105003:	e8 48 ff ff ff       	call   80104f50 <popcli>
    panic("release");
80105008:	83 ec 0c             	sub    $0xc,%esp
8010500b:	68 f5 85 10 80       	push   $0x801085f5
80105010:	e8 6b b3 ff ff       	call   80100380 <panic>
80105015:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105018:	8b 73 08             	mov    0x8(%ebx),%esi
8010501b:	e8 f0 ed ff ff       	call   80103e10 <mycpu>
80105020:	39 c6                	cmp    %eax,%esi
80105022:	75 df                	jne    80105003 <release+0x13>
  popcli();
80105024:	e8 27 ff ff ff       	call   80104f50 <popcli>
  lk->pcs[0] = 0;
80105029:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105030:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105037:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010503c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105042:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105045:	5b                   	pop    %ebx
80105046:	5e                   	pop    %esi
80105047:	5d                   	pop    %ebp
  popcli();
80105048:	e9 03 ff ff ff       	jmp    80104f50 <popcli>
8010504d:	8d 76 00             	lea    0x0(%esi),%esi

80105050 <acquire>:
{
80105050:	55                   	push   %ebp
80105051:	89 e5                	mov    %esp,%ebp
80105053:	53                   	push   %ebx
80105054:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105057:	e8 a4 fe ff ff       	call   80104f00 <pushcli>
  if(holding(lk))
8010505c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010505f:	e8 9c fe ff ff       	call   80104f00 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105064:	8b 03                	mov    (%ebx),%eax
80105066:	85 c0                	test   %eax,%eax
80105068:	75 7e                	jne    801050e8 <acquire+0x98>
  popcli();
8010506a:	e8 e1 fe ff ff       	call   80104f50 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010506f:	b9 01 00 00 00       	mov    $0x1,%ecx
80105074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105078:	8b 55 08             	mov    0x8(%ebp),%edx
8010507b:	89 c8                	mov    %ecx,%eax
8010507d:	f0 87 02             	lock xchg %eax,(%edx)
80105080:	85 c0                	test   %eax,%eax
80105082:	75 f4                	jne    80105078 <acquire+0x28>
  __sync_synchronize();
80105084:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105089:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010508c:	e8 7f ed ff ff       	call   80103e10 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105091:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105094:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105096:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105099:	31 c0                	xor    %eax,%eax
8010509b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010509f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050a0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801050a6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801050ac:	77 1a                	ja     801050c8 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
801050ae:	8b 5a 04             	mov    0x4(%edx),%ebx
801050b1:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801050b5:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801050b8:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801050ba:	83 f8 0a             	cmp    $0xa,%eax
801050bd:	75 e1                	jne    801050a0 <acquire+0x50>
}
801050bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050c2:	c9                   	leave  
801050c3:	c3                   	ret    
801050c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
801050c8:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
801050cc:	8d 51 34             	lea    0x34(%ecx),%edx
801050cf:	90                   	nop
    pcs[i] = 0;
801050d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801050d6:	83 c0 04             	add    $0x4,%eax
801050d9:	39 c2                	cmp    %eax,%edx
801050db:	75 f3                	jne    801050d0 <acquire+0x80>
}
801050dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050e0:	c9                   	leave  
801050e1:	c3                   	ret    
801050e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801050e8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801050eb:	e8 20 ed ff ff       	call   80103e10 <mycpu>
801050f0:	39 c3                	cmp    %eax,%ebx
801050f2:	0f 85 72 ff ff ff    	jne    8010506a <acquire+0x1a>
  popcli();
801050f8:	e8 53 fe ff ff       	call   80104f50 <popcli>
    panic("acquire");
801050fd:	83 ec 0c             	sub    $0xc,%esp
80105100:	68 fd 85 10 80       	push   $0x801085fd
80105105:	e8 76 b2 ff ff       	call   80100380 <panic>
8010510a:	66 90                	xchg   %ax,%ax
8010510c:	66 90                	xchg   %ax,%ax
8010510e:	66 90                	xchg   %ax,%ax

80105110 <memset>:
80105110:	f3 0f 1e fb          	endbr32 
80105114:	55                   	push   %ebp
80105115:	89 e5                	mov    %esp,%ebp
80105117:	57                   	push   %edi
80105118:	8b 55 08             	mov    0x8(%ebp),%edx
8010511b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010511e:	53                   	push   %ebx
8010511f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105122:	89 d7                	mov    %edx,%edi
80105124:	09 cf                	or     %ecx,%edi
80105126:	83 e7 03             	and    $0x3,%edi
80105129:	75 25                	jne    80105150 <memset+0x40>
8010512b:	0f b6 f8             	movzbl %al,%edi
8010512e:	c1 e0 18             	shl    $0x18,%eax
80105131:	89 fb                	mov    %edi,%ebx
80105133:	c1 e9 02             	shr    $0x2,%ecx
80105136:	c1 e3 10             	shl    $0x10,%ebx
80105139:	09 d8                	or     %ebx,%eax
8010513b:	09 f8                	or     %edi,%eax
8010513d:	c1 e7 08             	shl    $0x8,%edi
80105140:	09 f8                	or     %edi,%eax
80105142:	89 d7                	mov    %edx,%edi
80105144:	fc                   	cld    
80105145:	f3 ab                	rep stos %eax,%es:(%edi)
80105147:	5b                   	pop    %ebx
80105148:	89 d0                	mov    %edx,%eax
8010514a:	5f                   	pop    %edi
8010514b:	5d                   	pop    %ebp
8010514c:	c3                   	ret    
8010514d:	8d 76 00             	lea    0x0(%esi),%esi
80105150:	89 d7                	mov    %edx,%edi
80105152:	fc                   	cld    
80105153:	f3 aa                	rep stos %al,%es:(%edi)
80105155:	5b                   	pop    %ebx
80105156:	89 d0                	mov    %edx,%eax
80105158:	5f                   	pop    %edi
80105159:	5d                   	pop    %ebp
8010515a:	c3                   	ret    
8010515b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010515f:	90                   	nop

80105160 <memcmp>:
80105160:	f3 0f 1e fb          	endbr32 
80105164:	55                   	push   %ebp
80105165:	89 e5                	mov    %esp,%ebp
80105167:	56                   	push   %esi
80105168:	8b 75 10             	mov    0x10(%ebp),%esi
8010516b:	8b 55 08             	mov    0x8(%ebp),%edx
8010516e:	53                   	push   %ebx
8010516f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105172:	85 f6                	test   %esi,%esi
80105174:	74 2a                	je     801051a0 <memcmp+0x40>
80105176:	01 c6                	add    %eax,%esi
80105178:	eb 10                	jmp    8010518a <memcmp+0x2a>
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105180:	83 c0 01             	add    $0x1,%eax
80105183:	83 c2 01             	add    $0x1,%edx
80105186:	39 f0                	cmp    %esi,%eax
80105188:	74 16                	je     801051a0 <memcmp+0x40>
8010518a:	0f b6 0a             	movzbl (%edx),%ecx
8010518d:	0f b6 18             	movzbl (%eax),%ebx
80105190:	38 d9                	cmp    %bl,%cl
80105192:	74 ec                	je     80105180 <memcmp+0x20>
80105194:	0f b6 c1             	movzbl %cl,%eax
80105197:	29 d8                	sub    %ebx,%eax
80105199:	5b                   	pop    %ebx
8010519a:	5e                   	pop    %esi
8010519b:	5d                   	pop    %ebp
8010519c:	c3                   	ret    
8010519d:	8d 76 00             	lea    0x0(%esi),%esi
801051a0:	5b                   	pop    %ebx
801051a1:	31 c0                	xor    %eax,%eax
801051a3:	5e                   	pop    %esi
801051a4:	5d                   	pop    %ebp
801051a5:	c3                   	ret    
801051a6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ad:	8d 76 00             	lea    0x0(%esi),%esi

801051b0 <memmove>:
801051b0:	f3 0f 1e fb          	endbr32 
801051b4:	55                   	push   %ebp
801051b5:	89 e5                	mov    %esp,%ebp
801051b7:	57                   	push   %edi
801051b8:	8b 55 08             	mov    0x8(%ebp),%edx
801051bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801051be:	56                   	push   %esi
801051bf:	8b 75 0c             	mov    0xc(%ebp),%esi
801051c2:	39 d6                	cmp    %edx,%esi
801051c4:	73 2a                	jae    801051f0 <memmove+0x40>
801051c6:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
801051c9:	39 fa                	cmp    %edi,%edx
801051cb:	73 23                	jae    801051f0 <memmove+0x40>
801051cd:	8d 41 ff             	lea    -0x1(%ecx),%eax
801051d0:	85 c9                	test   %ecx,%ecx
801051d2:	74 13                	je     801051e7 <memmove+0x37>
801051d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051d8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801051dc:	88 0c 02             	mov    %cl,(%edx,%eax,1)
801051df:	83 e8 01             	sub    $0x1,%eax
801051e2:	83 f8 ff             	cmp    $0xffffffff,%eax
801051e5:	75 f1                	jne    801051d8 <memmove+0x28>
801051e7:	5e                   	pop    %esi
801051e8:	89 d0                	mov    %edx,%eax
801051ea:	5f                   	pop    %edi
801051eb:	5d                   	pop    %ebp
801051ec:	c3                   	ret    
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
801051f0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801051f3:	89 d7                	mov    %edx,%edi
801051f5:	85 c9                	test   %ecx,%ecx
801051f7:	74 ee                	je     801051e7 <memmove+0x37>
801051f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105200:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105201:	39 f0                	cmp    %esi,%eax
80105203:	75 fb                	jne    80105200 <memmove+0x50>
80105205:	5e                   	pop    %esi
80105206:	89 d0                	mov    %edx,%eax
80105208:	5f                   	pop    %edi
80105209:	5d                   	pop    %ebp
8010520a:	c3                   	ret    
8010520b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010520f:	90                   	nop

80105210 <memcpy>:
80105210:	f3 0f 1e fb          	endbr32 
80105214:	eb 9a                	jmp    801051b0 <memmove>
80105216:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010521d:	8d 76 00             	lea    0x0(%esi),%esi

80105220 <strncmp>:
80105220:	f3 0f 1e fb          	endbr32 
80105224:	55                   	push   %ebp
80105225:	89 e5                	mov    %esp,%ebp
80105227:	56                   	push   %esi
80105228:	8b 75 10             	mov    0x10(%ebp),%esi
8010522b:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010522e:	53                   	push   %ebx
8010522f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105232:	85 f6                	test   %esi,%esi
80105234:	74 32                	je     80105268 <strncmp+0x48>
80105236:	01 c6                	add    %eax,%esi
80105238:	eb 14                	jmp    8010524e <strncmp+0x2e>
8010523a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105240:	38 da                	cmp    %bl,%dl
80105242:	75 14                	jne    80105258 <strncmp+0x38>
80105244:	83 c0 01             	add    $0x1,%eax
80105247:	83 c1 01             	add    $0x1,%ecx
8010524a:	39 f0                	cmp    %esi,%eax
8010524c:	74 1a                	je     80105268 <strncmp+0x48>
8010524e:	0f b6 11             	movzbl (%ecx),%edx
80105251:	0f b6 18             	movzbl (%eax),%ebx
80105254:	84 d2                	test   %dl,%dl
80105256:	75 e8                	jne    80105240 <strncmp+0x20>
80105258:	0f b6 c2             	movzbl %dl,%eax
8010525b:	29 d8                	sub    %ebx,%eax
8010525d:	5b                   	pop    %ebx
8010525e:	5e                   	pop    %esi
8010525f:	5d                   	pop    %ebp
80105260:	c3                   	ret    
80105261:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105268:	5b                   	pop    %ebx
80105269:	31 c0                	xor    %eax,%eax
8010526b:	5e                   	pop    %esi
8010526c:	5d                   	pop    %ebp
8010526d:	c3                   	ret    
8010526e:	66 90                	xchg   %ax,%ax

80105270 <strncpy>:
80105270:	f3 0f 1e fb          	endbr32 
80105274:	55                   	push   %ebp
80105275:	89 e5                	mov    %esp,%ebp
80105277:	57                   	push   %edi
80105278:	56                   	push   %esi
80105279:	8b 75 08             	mov    0x8(%ebp),%esi
8010527c:	53                   	push   %ebx
8010527d:	8b 45 10             	mov    0x10(%ebp),%eax
80105280:	89 f2                	mov    %esi,%edx
80105282:	eb 1b                	jmp    8010529f <strncpy+0x2f>
80105284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105288:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010528c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010528f:	83 c2 01             	add    $0x1,%edx
80105292:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105296:	89 f9                	mov    %edi,%ecx
80105298:	88 4a ff             	mov    %cl,-0x1(%edx)
8010529b:	84 c9                	test   %cl,%cl
8010529d:	74 09                	je     801052a8 <strncpy+0x38>
8010529f:	89 c3                	mov    %eax,%ebx
801052a1:	83 e8 01             	sub    $0x1,%eax
801052a4:	85 db                	test   %ebx,%ebx
801052a6:	7f e0                	jg     80105288 <strncpy+0x18>
801052a8:	89 d1                	mov    %edx,%ecx
801052aa:	85 c0                	test   %eax,%eax
801052ac:	7e 15                	jle    801052c3 <strncpy+0x53>
801052ae:	66 90                	xchg   %ax,%ax
801052b0:	83 c1 01             	add    $0x1,%ecx
801052b3:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
801052b7:	89 c8                	mov    %ecx,%eax
801052b9:	f7 d0                	not    %eax
801052bb:	01 d0                	add    %edx,%eax
801052bd:	01 d8                	add    %ebx,%eax
801052bf:	85 c0                	test   %eax,%eax
801052c1:	7f ed                	jg     801052b0 <strncpy+0x40>
801052c3:	5b                   	pop    %ebx
801052c4:	89 f0                	mov    %esi,%eax
801052c6:	5e                   	pop    %esi
801052c7:	5f                   	pop    %edi
801052c8:	5d                   	pop    %ebp
801052c9:	c3                   	ret    
801052ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052d0 <safestrcpy>:
801052d0:	f3 0f 1e fb          	endbr32 
801052d4:	55                   	push   %ebp
801052d5:	89 e5                	mov    %esp,%ebp
801052d7:	56                   	push   %esi
801052d8:	8b 55 10             	mov    0x10(%ebp),%edx
801052db:	8b 75 08             	mov    0x8(%ebp),%esi
801052de:	53                   	push   %ebx
801052df:	8b 45 0c             	mov    0xc(%ebp),%eax
801052e2:	85 d2                	test   %edx,%edx
801052e4:	7e 21                	jle    80105307 <safestrcpy+0x37>
801052e6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801052ea:	89 f2                	mov    %esi,%edx
801052ec:	eb 12                	jmp    80105300 <safestrcpy+0x30>
801052ee:	66 90                	xchg   %ax,%ax
801052f0:	0f b6 08             	movzbl (%eax),%ecx
801052f3:	83 c0 01             	add    $0x1,%eax
801052f6:	83 c2 01             	add    $0x1,%edx
801052f9:	88 4a ff             	mov    %cl,-0x1(%edx)
801052fc:	84 c9                	test   %cl,%cl
801052fe:	74 04                	je     80105304 <safestrcpy+0x34>
80105300:	39 d8                	cmp    %ebx,%eax
80105302:	75 ec                	jne    801052f0 <safestrcpy+0x20>
80105304:	c6 02 00             	movb   $0x0,(%edx)
80105307:	89 f0                	mov    %esi,%eax
80105309:	5b                   	pop    %ebx
8010530a:	5e                   	pop    %esi
8010530b:	5d                   	pop    %ebp
8010530c:	c3                   	ret    
8010530d:	8d 76 00             	lea    0x0(%esi),%esi

80105310 <strlen>:
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
80105315:	31 c0                	xor    %eax,%eax
80105317:	89 e5                	mov    %esp,%ebp
80105319:	8b 55 08             	mov    0x8(%ebp),%edx
8010531c:	80 3a 00             	cmpb   $0x0,(%edx)
8010531f:	74 10                	je     80105331 <strlen+0x21>
80105321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105328:	83 c0 01             	add    $0x1,%eax
8010532b:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
8010532f:	75 f7                	jne    80105328 <strlen+0x18>
80105331:	5d                   	pop    %ebp
80105332:	c3                   	ret    

80105333 <swtch>:
80105333:	8b 44 24 04          	mov    0x4(%esp),%eax
80105337:	8b 54 24 08          	mov    0x8(%esp),%edx
8010533b:	55                   	push   %ebp
8010533c:	53                   	push   %ebx
8010533d:	56                   	push   %esi
8010533e:	57                   	push   %edi
8010533f:	89 20                	mov    %esp,(%eax)
80105341:	89 d4                	mov    %edx,%esp
80105343:	5f                   	pop    %edi
80105344:	5e                   	pop    %esi
80105345:	5b                   	pop    %ebx
80105346:	5d                   	pop    %ebp
80105347:	c3                   	ret    
80105348:	66 90                	xchg   %ax,%ax
8010534a:	66 90                	xchg   %ax,%ax
8010534c:	66 90                	xchg   %ax,%ax
8010534e:	66 90                	xchg   %ax,%ax

80105350 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105350:	55                   	push   %ebp
80105351:	89 e5                	mov    %esp,%ebp
80105353:	53                   	push   %ebx
80105354:	83 ec 04             	sub    $0x4,%esp
80105357:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010535a:	e8 31 eb ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010535f:	8b 00                	mov    (%eax),%eax
80105361:	39 d8                	cmp    %ebx,%eax
80105363:	76 1b                	jbe    80105380 <fetchint+0x30>
80105365:	8d 53 04             	lea    0x4(%ebx),%edx
80105368:	39 d0                	cmp    %edx,%eax
8010536a:	72 14                	jb     80105380 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010536c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010536f:	8b 13                	mov    (%ebx),%edx
80105371:	89 10                	mov    %edx,(%eax)
  return 0;
80105373:	31 c0                	xor    %eax,%eax
}
80105375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105378:	c9                   	leave  
80105379:	c3                   	ret    
8010537a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105380:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105385:	eb ee                	jmp    80105375 <fetchint+0x25>
80105387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010538e:	66 90                	xchg   %ax,%ax

80105390 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	53                   	push   %ebx
80105394:	83 ec 04             	sub    $0x4,%esp
80105397:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010539a:	e8 f1 ea ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz)
8010539f:	39 18                	cmp    %ebx,(%eax)
801053a1:	76 2d                	jbe    801053d0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801053a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801053a6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801053a8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801053aa:	39 d3                	cmp    %edx,%ebx
801053ac:	73 22                	jae    801053d0 <fetchstr+0x40>
801053ae:	89 d8                	mov    %ebx,%eax
801053b0:	eb 0d                	jmp    801053bf <fetchstr+0x2f>
801053b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801053b8:	83 c0 01             	add    $0x1,%eax
801053bb:	39 c2                	cmp    %eax,%edx
801053bd:	76 11                	jbe    801053d0 <fetchstr+0x40>
    if(*s == 0)
801053bf:	80 38 00             	cmpb   $0x0,(%eax)
801053c2:	75 f4                	jne    801053b8 <fetchstr+0x28>
      return s - *pp;
801053c4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
801053c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053c9:	c9                   	leave  
801053ca:	c3                   	ret    
801053cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801053cf:	90                   	nop
801053d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801053d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053d8:	c9                   	leave  
801053d9:	c3                   	ret    
801053da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801053e0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	56                   	push   %esi
801053e4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801053e5:	e8 a6 ea ff ff       	call   80103e90 <myproc>
801053ea:	8b 55 08             	mov    0x8(%ebp),%edx
801053ed:	8b 40 1c             	mov    0x1c(%eax),%eax
801053f0:	8b 40 44             	mov    0x44(%eax),%eax
801053f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801053f6:	e8 95 ea ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801053fb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053fe:	8b 00                	mov    (%eax),%eax
80105400:	39 c6                	cmp    %eax,%esi
80105402:	73 1c                	jae    80105420 <argint+0x40>
80105404:	8d 53 08             	lea    0x8(%ebx),%edx
80105407:	39 d0                	cmp    %edx,%eax
80105409:	72 15                	jb     80105420 <argint+0x40>
  *ip = *(int*)(addr);
8010540b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010540e:	8b 53 04             	mov    0x4(%ebx),%edx
80105411:	89 10                	mov    %edx,(%eax)
  return 0;
80105413:	31 c0                	xor    %eax,%eax
}
80105415:	5b                   	pop    %ebx
80105416:	5e                   	pop    %esi
80105417:	5d                   	pop    %ebp
80105418:	c3                   	ret    
80105419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105425:	eb ee                	jmp    80105415 <argint+0x35>
80105427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010542e:	66 90                	xchg   %ax,%ax

80105430 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105430:	55                   	push   %ebp
80105431:	89 e5                	mov    %esp,%ebp
80105433:	57                   	push   %edi
80105434:	56                   	push   %esi
80105435:	53                   	push   %ebx
80105436:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105439:	e8 52 ea ff ff       	call   80103e90 <myproc>
8010543e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105440:	e8 4b ea ff ff       	call   80103e90 <myproc>
80105445:	8b 55 08             	mov    0x8(%ebp),%edx
80105448:	8b 40 1c             	mov    0x1c(%eax),%eax
8010544b:	8b 40 44             	mov    0x44(%eax),%eax
8010544e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105451:	e8 3a ea ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105456:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105459:	8b 00                	mov    (%eax),%eax
8010545b:	39 c7                	cmp    %eax,%edi
8010545d:	73 31                	jae    80105490 <argptr+0x60>
8010545f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105462:	39 c8                	cmp    %ecx,%eax
80105464:	72 2a                	jb     80105490 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105466:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105469:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010546c:	85 d2                	test   %edx,%edx
8010546e:	78 20                	js     80105490 <argptr+0x60>
80105470:	8b 16                	mov    (%esi),%edx
80105472:	39 c2                	cmp    %eax,%edx
80105474:	76 1a                	jbe    80105490 <argptr+0x60>
80105476:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105479:	01 c3                	add    %eax,%ebx
8010547b:	39 da                	cmp    %ebx,%edx
8010547d:	72 11                	jb     80105490 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010547f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105482:	89 02                	mov    %eax,(%edx)
  return 0;
80105484:	31 c0                	xor    %eax,%eax
}
80105486:	83 c4 0c             	add    $0xc,%esp
80105489:	5b                   	pop    %ebx
8010548a:	5e                   	pop    %esi
8010548b:	5f                   	pop    %edi
8010548c:	5d                   	pop    %ebp
8010548d:	c3                   	ret    
8010548e:	66 90                	xchg   %ax,%ax
    return -1;
80105490:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105495:	eb ef                	jmp    80105486 <argptr+0x56>
80105497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010549e:	66 90                	xchg   %ax,%ax

801054a0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
801054a0:	55                   	push   %ebp
801054a1:	89 e5                	mov    %esp,%ebp
801054a3:	56                   	push   %esi
801054a4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054a5:	e8 e6 e9 ff ff       	call   80103e90 <myproc>
801054aa:	8b 55 08             	mov    0x8(%ebp),%edx
801054ad:	8b 40 1c             	mov    0x1c(%eax),%eax
801054b0:	8b 40 44             	mov    0x44(%eax),%eax
801054b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054b6:	e8 d5 e9 ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054bb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054be:	8b 00                	mov    (%eax),%eax
801054c0:	39 c6                	cmp    %eax,%esi
801054c2:	73 44                	jae    80105508 <argstr+0x68>
801054c4:	8d 53 08             	lea    0x8(%ebx),%edx
801054c7:	39 d0                	cmp    %edx,%eax
801054c9:	72 3d                	jb     80105508 <argstr+0x68>
  *ip = *(int*)(addr);
801054cb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
801054ce:	e8 bd e9 ff ff       	call   80103e90 <myproc>
  if(addr >= curproc->sz)
801054d3:	3b 18                	cmp    (%eax),%ebx
801054d5:	73 31                	jae    80105508 <argstr+0x68>
  *pp = (char*)addr;
801054d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801054da:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801054dc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801054de:	39 d3                	cmp    %edx,%ebx
801054e0:	73 26                	jae    80105508 <argstr+0x68>
801054e2:	89 d8                	mov    %ebx,%eax
801054e4:	eb 11                	jmp    801054f7 <argstr+0x57>
801054e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ed:	8d 76 00             	lea    0x0(%esi),%esi
801054f0:	83 c0 01             	add    $0x1,%eax
801054f3:	39 c2                	cmp    %eax,%edx
801054f5:	76 11                	jbe    80105508 <argstr+0x68>
    if(*s == 0)
801054f7:	80 38 00             	cmpb   $0x0,(%eax)
801054fa:	75 f4                	jne    801054f0 <argstr+0x50>
      return s - *pp;
801054fc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801054fe:	5b                   	pop    %ebx
801054ff:	5e                   	pop    %esi
80105500:	5d                   	pop    %ebp
80105501:	c3                   	ret    
80105502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105508:	5b                   	pop    %ebx
    return -1;
80105509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010550e:	5e                   	pop    %esi
8010550f:	5d                   	pop    %ebp
80105510:	c3                   	ret    
80105511:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105518:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010551f:	90                   	nop

80105520 <syscall>:
[SYS_set_proc_queue_level] sys_set_proc_level,
};

void
syscall(void)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	53                   	push   %ebx
80105524:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80105527:	e8 64 e9 ff ff       	call   80103e90 <myproc>
8010552c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
8010552e:	8b 40 1c             	mov    0x1c(%eax),%eax
80105531:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105534:	8d 50 ff             	lea    -0x1(%eax),%edx
80105537:	83 fa 1b             	cmp    $0x1b,%edx
8010553a:	77 24                	ja     80105560 <syscall+0x40>
8010553c:	8b 14 85 40 86 10 80 	mov    -0x7fef79c0(,%eax,4),%edx
80105543:	85 d2                	test   %edx,%edx
80105545:	74 19                	je     80105560 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105547:	ff d2                	call   *%edx
80105549:	89 c2                	mov    %eax,%edx
8010554b:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010554e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105551:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105554:	c9                   	leave  
80105555:	c3                   	ret    
80105556:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105560:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105561:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105564:	50                   	push   %eax
80105565:	ff 73 10             	pushl  0x10(%ebx)
80105568:	68 05 86 10 80       	push   $0x80108605
8010556d:	e8 2e b1 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80105572:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105575:	83 c4 10             	add    $0x10,%esp
80105578:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010557f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105582:	c9                   	leave  
80105583:	c3                   	ret    
80105584:	66 90                	xchg   %ax,%ax
80105586:	66 90                	xchg   %ax,%ax
80105588:	66 90                	xchg   %ax,%ax
8010558a:	66 90                	xchg   %ax,%ax
8010558c:	66 90                	xchg   %ax,%ax
8010558e:	66 90                	xchg   %ax,%ax

80105590 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105595:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105598:	53                   	push   %ebx
80105599:	83 ec 34             	sub    $0x34,%esp
8010559c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010559f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
801055a2:	57                   	push   %edi
801055a3:	50                   	push   %eax
{
801055a4:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801055a7:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
801055aa:	e8 d1 cf ff ff       	call   80102580 <nameiparent>
801055af:	83 c4 10             	add    $0x10,%esp
801055b2:	85 c0                	test   %eax,%eax
801055b4:	0f 84 46 01 00 00    	je     80105700 <create+0x170>
    return 0;
  ilock(dp);
801055ba:	83 ec 0c             	sub    $0xc,%esp
801055bd:	89 c3                	mov    %eax,%ebx
801055bf:	50                   	push   %eax
801055c0:	e8 7b c6 ff ff       	call   80101c40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
801055c5:	83 c4 0c             	add    $0xc,%esp
801055c8:	6a 00                	push   $0x0
801055ca:	57                   	push   %edi
801055cb:	53                   	push   %ebx
801055cc:	e8 cf cb ff ff       	call   801021a0 <dirlookup>
801055d1:	83 c4 10             	add    $0x10,%esp
801055d4:	89 c6                	mov    %eax,%esi
801055d6:	85 c0                	test   %eax,%eax
801055d8:	74 56                	je     80105630 <create+0xa0>
    iunlockput(dp);
801055da:	83 ec 0c             	sub    $0xc,%esp
801055dd:	53                   	push   %ebx
801055de:	e8 ed c8 ff ff       	call   80101ed0 <iunlockput>
    ilock(ip);
801055e3:	89 34 24             	mov    %esi,(%esp)
801055e6:	e8 55 c6 ff ff       	call   80101c40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801055eb:	83 c4 10             	add    $0x10,%esp
801055ee:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801055f3:	75 1b                	jne    80105610 <create+0x80>
801055f5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801055fa:	75 14                	jne    80105610 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801055fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055ff:	89 f0                	mov    %esi,%eax
80105601:	5b                   	pop    %ebx
80105602:	5e                   	pop    %esi
80105603:	5f                   	pop    %edi
80105604:	5d                   	pop    %ebp
80105605:	c3                   	ret    
80105606:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010560d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105610:	83 ec 0c             	sub    $0xc,%esp
80105613:	56                   	push   %esi
    return 0;
80105614:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105616:	e8 b5 c8 ff ff       	call   80101ed0 <iunlockput>
    return 0;
8010561b:	83 c4 10             	add    $0x10,%esp
}
8010561e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105621:	89 f0                	mov    %esi,%eax
80105623:	5b                   	pop    %ebx
80105624:	5e                   	pop    %esi
80105625:	5f                   	pop    %edi
80105626:	5d                   	pop    %ebp
80105627:	c3                   	ret    
80105628:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010562f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105630:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105634:	83 ec 08             	sub    $0x8,%esp
80105637:	50                   	push   %eax
80105638:	ff 33                	pushl  (%ebx)
8010563a:	e8 91 c4 ff ff       	call   80101ad0 <ialloc>
8010563f:	83 c4 10             	add    $0x10,%esp
80105642:	89 c6                	mov    %eax,%esi
80105644:	85 c0                	test   %eax,%eax
80105646:	0f 84 cd 00 00 00    	je     80105719 <create+0x189>
  ilock(ip);
8010564c:	83 ec 0c             	sub    $0xc,%esp
8010564f:	50                   	push   %eax
80105650:	e8 eb c5 ff ff       	call   80101c40 <ilock>
  ip->major = major;
80105655:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105659:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010565d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105661:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105665:	b8 01 00 00 00       	mov    $0x1,%eax
8010566a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010566e:	89 34 24             	mov    %esi,(%esp)
80105671:	e8 1a c5 ff ff       	call   80101b90 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105676:	83 c4 10             	add    $0x10,%esp
80105679:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010567e:	74 30                	je     801056b0 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105680:	83 ec 04             	sub    $0x4,%esp
80105683:	ff 76 04             	pushl  0x4(%esi)
80105686:	57                   	push   %edi
80105687:	53                   	push   %ebx
80105688:	e8 13 ce ff ff       	call   801024a0 <dirlink>
8010568d:	83 c4 10             	add    $0x10,%esp
80105690:	85 c0                	test   %eax,%eax
80105692:	78 78                	js     8010570c <create+0x17c>
  iunlockput(dp);
80105694:	83 ec 0c             	sub    $0xc,%esp
80105697:	53                   	push   %ebx
80105698:	e8 33 c8 ff ff       	call   80101ed0 <iunlockput>
  return ip;
8010569d:	83 c4 10             	add    $0x10,%esp
}
801056a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801056a3:	89 f0                	mov    %esi,%eax
801056a5:	5b                   	pop    %ebx
801056a6:	5e                   	pop    %esi
801056a7:	5f                   	pop    %edi
801056a8:	5d                   	pop    %ebp
801056a9:	c3                   	ret    
801056aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
801056b0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
801056b3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
801056b8:	53                   	push   %ebx
801056b9:	e8 d2 c4 ff ff       	call   80101b90 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
801056be:	83 c4 0c             	add    $0xc,%esp
801056c1:	ff 76 04             	pushl  0x4(%esi)
801056c4:	68 d0 86 10 80       	push   $0x801086d0
801056c9:	56                   	push   %esi
801056ca:	e8 d1 cd ff ff       	call   801024a0 <dirlink>
801056cf:	83 c4 10             	add    $0x10,%esp
801056d2:	85 c0                	test   %eax,%eax
801056d4:	78 18                	js     801056ee <create+0x15e>
801056d6:	83 ec 04             	sub    $0x4,%esp
801056d9:	ff 73 04             	pushl  0x4(%ebx)
801056dc:	68 cf 86 10 80       	push   $0x801086cf
801056e1:	56                   	push   %esi
801056e2:	e8 b9 cd ff ff       	call   801024a0 <dirlink>
801056e7:	83 c4 10             	add    $0x10,%esp
801056ea:	85 c0                	test   %eax,%eax
801056ec:	79 92                	jns    80105680 <create+0xf0>
      panic("create dots");
801056ee:	83 ec 0c             	sub    $0xc,%esp
801056f1:	68 c3 86 10 80       	push   $0x801086c3
801056f6:	e8 85 ac ff ff       	call   80100380 <panic>
801056fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056ff:	90                   	nop
}
80105700:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105703:	31 f6                	xor    %esi,%esi
}
80105705:	5b                   	pop    %ebx
80105706:	89 f0                	mov    %esi,%eax
80105708:	5e                   	pop    %esi
80105709:	5f                   	pop    %edi
8010570a:	5d                   	pop    %ebp
8010570b:	c3                   	ret    
    panic("create: dirlink");
8010570c:	83 ec 0c             	sub    $0xc,%esp
8010570f:	68 d2 86 10 80       	push   $0x801086d2
80105714:	e8 67 ac ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80105719:	83 ec 0c             	sub    $0xc,%esp
8010571c:	68 b4 86 10 80       	push   $0x801086b4
80105721:	e8 5a ac ff ff       	call   80100380 <panic>
80105726:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010572d:	8d 76 00             	lea    0x0(%esi),%esi

80105730 <sys_dup>:
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	56                   	push   %esi
80105734:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105735:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105738:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010573b:	50                   	push   %eax
8010573c:	6a 00                	push   $0x0
8010573e:	e8 9d fc ff ff       	call   801053e0 <argint>
80105743:	83 c4 10             	add    $0x10,%esp
80105746:	85 c0                	test   %eax,%eax
80105748:	78 36                	js     80105780 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010574a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010574e:	77 30                	ja     80105780 <sys_dup+0x50>
80105750:	e8 3b e7 ff ff       	call   80103e90 <myproc>
80105755:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105758:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010575c:	85 f6                	test   %esi,%esi
8010575e:	74 20                	je     80105780 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105760:	e8 2b e7 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105765:	31 db                	xor    %ebx,%ebx
80105767:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010576e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105770:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105774:	85 d2                	test   %edx,%edx
80105776:	74 18                	je     80105790 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105778:	83 c3 01             	add    $0x1,%ebx
8010577b:	83 fb 10             	cmp    $0x10,%ebx
8010577e:	75 f0                	jne    80105770 <sys_dup+0x40>
}
80105780:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105783:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105788:	89 d8                	mov    %ebx,%eax
8010578a:	5b                   	pop    %ebx
8010578b:	5e                   	pop    %esi
8010578c:	5d                   	pop    %ebp
8010578d:	c3                   	ret    
8010578e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105790:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105793:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80105797:	56                   	push   %esi
80105798:	e8 c3 bb ff ff       	call   80101360 <filedup>
  return fd;
8010579d:	83 c4 10             	add    $0x10,%esp
}
801057a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057a3:	89 d8                	mov    %ebx,%eax
801057a5:	5b                   	pop    %ebx
801057a6:	5e                   	pop    %esi
801057a7:	5d                   	pop    %ebp
801057a8:	c3                   	ret    
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801057b0 <sys_read>:
{
801057b0:	55                   	push   %ebp
801057b1:	89 e5                	mov    %esp,%ebp
801057b3:	56                   	push   %esi
801057b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801057b5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801057b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801057bb:	53                   	push   %ebx
801057bc:	6a 00                	push   $0x0
801057be:	e8 1d fc ff ff       	call   801053e0 <argint>
801057c3:	83 c4 10             	add    $0x10,%esp
801057c6:	85 c0                	test   %eax,%eax
801057c8:	78 5e                	js     80105828 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801057ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801057ce:	77 58                	ja     80105828 <sys_read+0x78>
801057d0:	e8 bb e6 ff ff       	call   80103e90 <myproc>
801057d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057d8:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
801057dc:	85 f6                	test   %esi,%esi
801057de:	74 48                	je     80105828 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801057e0:	83 ec 08             	sub    $0x8,%esp
801057e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057e6:	50                   	push   %eax
801057e7:	6a 02                	push   $0x2
801057e9:	e8 f2 fb ff ff       	call   801053e0 <argint>
801057ee:	83 c4 10             	add    $0x10,%esp
801057f1:	85 c0                	test   %eax,%eax
801057f3:	78 33                	js     80105828 <sys_read+0x78>
801057f5:	83 ec 04             	sub    $0x4,%esp
801057f8:	ff 75 f0             	pushl  -0x10(%ebp)
801057fb:	53                   	push   %ebx
801057fc:	6a 01                	push   $0x1
801057fe:	e8 2d fc ff ff       	call   80105430 <argptr>
80105803:	83 c4 10             	add    $0x10,%esp
80105806:	85 c0                	test   %eax,%eax
80105808:	78 1e                	js     80105828 <sys_read+0x78>
  return fileread(f, p, n);
8010580a:	83 ec 04             	sub    $0x4,%esp
8010580d:	ff 75 f0             	pushl  -0x10(%ebp)
80105810:	ff 75 f4             	pushl  -0xc(%ebp)
80105813:	56                   	push   %esi
80105814:	e8 c7 bc ff ff       	call   801014e0 <fileread>
80105819:	83 c4 10             	add    $0x10,%esp
}
8010581c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010581f:	5b                   	pop    %ebx
80105820:	5e                   	pop    %esi
80105821:	5d                   	pop    %ebp
80105822:	c3                   	ret    
80105823:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105827:	90                   	nop
    return -1;
80105828:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010582d:	eb ed                	jmp    8010581c <sys_read+0x6c>
8010582f:	90                   	nop

80105830 <sys_write>:
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	56                   	push   %esi
80105834:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105835:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105838:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010583b:	53                   	push   %ebx
8010583c:	6a 00                	push   $0x0
8010583e:	e8 9d fb ff ff       	call   801053e0 <argint>
80105843:	83 c4 10             	add    $0x10,%esp
80105846:	85 c0                	test   %eax,%eax
80105848:	78 5e                	js     801058a8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010584a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010584e:	77 58                	ja     801058a8 <sys_write+0x78>
80105850:	e8 3b e6 ff ff       	call   80103e90 <myproc>
80105855:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105858:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010585c:	85 f6                	test   %esi,%esi
8010585e:	74 48                	je     801058a8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105860:	83 ec 08             	sub    $0x8,%esp
80105863:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105866:	50                   	push   %eax
80105867:	6a 02                	push   $0x2
80105869:	e8 72 fb ff ff       	call   801053e0 <argint>
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	85 c0                	test   %eax,%eax
80105873:	78 33                	js     801058a8 <sys_write+0x78>
80105875:	83 ec 04             	sub    $0x4,%esp
80105878:	ff 75 f0             	pushl  -0x10(%ebp)
8010587b:	53                   	push   %ebx
8010587c:	6a 01                	push   $0x1
8010587e:	e8 ad fb ff ff       	call   80105430 <argptr>
80105883:	83 c4 10             	add    $0x10,%esp
80105886:	85 c0                	test   %eax,%eax
80105888:	78 1e                	js     801058a8 <sys_write+0x78>
  return filewrite(f, p, n);
8010588a:	83 ec 04             	sub    $0x4,%esp
8010588d:	ff 75 f0             	pushl  -0x10(%ebp)
80105890:	ff 75 f4             	pushl  -0xc(%ebp)
80105893:	56                   	push   %esi
80105894:	e8 d7 bc ff ff       	call   80101570 <filewrite>
80105899:	83 c4 10             	add    $0x10,%esp
}
8010589c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010589f:	5b                   	pop    %ebx
801058a0:	5e                   	pop    %esi
801058a1:	5d                   	pop    %ebp
801058a2:	c3                   	ret    
801058a3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058a7:	90                   	nop
    return -1;
801058a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058ad:	eb ed                	jmp    8010589c <sys_write+0x6c>
801058af:	90                   	nop

801058b0 <sys_close>:
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	56                   	push   %esi
801058b4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058b8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058bb:	50                   	push   %eax
801058bc:	6a 00                	push   $0x0
801058be:	e8 1d fb ff ff       	call   801053e0 <argint>
801058c3:	83 c4 10             	add    $0x10,%esp
801058c6:	85 c0                	test   %eax,%eax
801058c8:	78 3e                	js     80105908 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058ca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058ce:	77 38                	ja     80105908 <sys_close+0x58>
801058d0:	e8 bb e5 ff ff       	call   80103e90 <myproc>
801058d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058d8:	8d 5a 08             	lea    0x8(%edx),%ebx
801058db:	8b 74 98 0c          	mov    0xc(%eax,%ebx,4),%esi
801058df:	85 f6                	test   %esi,%esi
801058e1:	74 25                	je     80105908 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801058e3:	e8 a8 e5 ff ff       	call   80103e90 <myproc>
  fileclose(f);
801058e8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801058eb:	c7 44 98 0c 00 00 00 	movl   $0x0,0xc(%eax,%ebx,4)
801058f2:	00 
  fileclose(f);
801058f3:	56                   	push   %esi
801058f4:	e8 b7 ba ff ff       	call   801013b0 <fileclose>
  return 0;
801058f9:	83 c4 10             	add    $0x10,%esp
801058fc:	31 c0                	xor    %eax,%eax
}
801058fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105901:	5b                   	pop    %ebx
80105902:	5e                   	pop    %esi
80105903:	5d                   	pop    %ebp
80105904:	c3                   	ret    
80105905:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105908:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010590d:	eb ef                	jmp    801058fe <sys_close+0x4e>
8010590f:	90                   	nop

80105910 <sys_fstat>:
{
80105910:	55                   	push   %ebp
80105911:	89 e5                	mov    %esp,%ebp
80105913:	56                   	push   %esi
80105914:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105915:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105918:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010591b:	53                   	push   %ebx
8010591c:	6a 00                	push   $0x0
8010591e:	e8 bd fa ff ff       	call   801053e0 <argint>
80105923:	83 c4 10             	add    $0x10,%esp
80105926:	85 c0                	test   %eax,%eax
80105928:	78 46                	js     80105970 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010592a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010592e:	77 40                	ja     80105970 <sys_fstat+0x60>
80105930:	e8 5b e5 ff ff       	call   80103e90 <myproc>
80105935:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105938:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010593c:	85 f6                	test   %esi,%esi
8010593e:	74 30                	je     80105970 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105940:	83 ec 04             	sub    $0x4,%esp
80105943:	6a 14                	push   $0x14
80105945:	53                   	push   %ebx
80105946:	6a 01                	push   $0x1
80105948:	e8 e3 fa ff ff       	call   80105430 <argptr>
8010594d:	83 c4 10             	add    $0x10,%esp
80105950:	85 c0                	test   %eax,%eax
80105952:	78 1c                	js     80105970 <sys_fstat+0x60>
  return filestat(f, st);
80105954:	83 ec 08             	sub    $0x8,%esp
80105957:	ff 75 f4             	pushl  -0xc(%ebp)
8010595a:	56                   	push   %esi
8010595b:	e8 30 bb ff ff       	call   80101490 <filestat>
80105960:	83 c4 10             	add    $0x10,%esp
}
80105963:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105966:	5b                   	pop    %ebx
80105967:	5e                   	pop    %esi
80105968:	5d                   	pop    %ebp
80105969:	c3                   	ret    
8010596a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105970:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105975:	eb ec                	jmp    80105963 <sys_fstat+0x53>
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax

80105980 <sys_link>:
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	57                   	push   %edi
80105984:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105985:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105988:	53                   	push   %ebx
80105989:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010598c:	50                   	push   %eax
8010598d:	6a 00                	push   $0x0
8010598f:	e8 0c fb ff ff       	call   801054a0 <argstr>
80105994:	83 c4 10             	add    $0x10,%esp
80105997:	85 c0                	test   %eax,%eax
80105999:	0f 88 fb 00 00 00    	js     80105a9a <sys_link+0x11a>
8010599f:	83 ec 08             	sub    $0x8,%esp
801059a2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801059a5:	50                   	push   %eax
801059a6:	6a 01                	push   $0x1
801059a8:	e8 f3 fa ff ff       	call   801054a0 <argstr>
801059ad:	83 c4 10             	add    $0x10,%esp
801059b0:	85 c0                	test   %eax,%eax
801059b2:	0f 88 e2 00 00 00    	js     80105a9a <sys_link+0x11a>
  begin_op();
801059b8:	e8 73 d8 ff ff       	call   80103230 <begin_op>
  if((ip = namei(old)) == 0){
801059bd:	83 ec 0c             	sub    $0xc,%esp
801059c0:	ff 75 d4             	pushl  -0x2c(%ebp)
801059c3:	e8 98 cb ff ff       	call   80102560 <namei>
801059c8:	83 c4 10             	add    $0x10,%esp
801059cb:	89 c3                	mov    %eax,%ebx
801059cd:	85 c0                	test   %eax,%eax
801059cf:	0f 84 e4 00 00 00    	je     80105ab9 <sys_link+0x139>
  ilock(ip);
801059d5:	83 ec 0c             	sub    $0xc,%esp
801059d8:	50                   	push   %eax
801059d9:	e8 62 c2 ff ff       	call   80101c40 <ilock>
  if(ip->type == T_DIR){
801059de:	83 c4 10             	add    $0x10,%esp
801059e1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059e6:	0f 84 b5 00 00 00    	je     80105aa1 <sys_link+0x121>
  iupdate(ip);
801059ec:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801059ef:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801059f4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801059f7:	53                   	push   %ebx
801059f8:	e8 93 c1 ff ff       	call   80101b90 <iupdate>
  iunlock(ip);
801059fd:	89 1c 24             	mov    %ebx,(%esp)
80105a00:	e8 1b c3 ff ff       	call   80101d20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a05:	58                   	pop    %eax
80105a06:	5a                   	pop    %edx
80105a07:	57                   	push   %edi
80105a08:	ff 75 d0             	pushl  -0x30(%ebp)
80105a0b:	e8 70 cb ff ff       	call   80102580 <nameiparent>
80105a10:	83 c4 10             	add    $0x10,%esp
80105a13:	89 c6                	mov    %eax,%esi
80105a15:	85 c0                	test   %eax,%eax
80105a17:	74 5b                	je     80105a74 <sys_link+0xf4>
  ilock(dp);
80105a19:	83 ec 0c             	sub    $0xc,%esp
80105a1c:	50                   	push   %eax
80105a1d:	e8 1e c2 ff ff       	call   80101c40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a22:	8b 03                	mov    (%ebx),%eax
80105a24:	83 c4 10             	add    $0x10,%esp
80105a27:	39 06                	cmp    %eax,(%esi)
80105a29:	75 3d                	jne    80105a68 <sys_link+0xe8>
80105a2b:	83 ec 04             	sub    $0x4,%esp
80105a2e:	ff 73 04             	pushl  0x4(%ebx)
80105a31:	57                   	push   %edi
80105a32:	56                   	push   %esi
80105a33:	e8 68 ca ff ff       	call   801024a0 <dirlink>
80105a38:	83 c4 10             	add    $0x10,%esp
80105a3b:	85 c0                	test   %eax,%eax
80105a3d:	78 29                	js     80105a68 <sys_link+0xe8>
  iunlockput(dp);
80105a3f:	83 ec 0c             	sub    $0xc,%esp
80105a42:	56                   	push   %esi
80105a43:	e8 88 c4 ff ff       	call   80101ed0 <iunlockput>
  iput(ip);
80105a48:	89 1c 24             	mov    %ebx,(%esp)
80105a4b:	e8 20 c3 ff ff       	call   80101d70 <iput>
  end_op();
80105a50:	e8 4b d8 ff ff       	call   801032a0 <end_op>
  return 0;
80105a55:	83 c4 10             	add    $0x10,%esp
80105a58:	31 c0                	xor    %eax,%eax
}
80105a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a5d:	5b                   	pop    %ebx
80105a5e:	5e                   	pop    %esi
80105a5f:	5f                   	pop    %edi
80105a60:	5d                   	pop    %ebp
80105a61:	c3                   	ret    
80105a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105a68:	83 ec 0c             	sub    $0xc,%esp
80105a6b:	56                   	push   %esi
80105a6c:	e8 5f c4 ff ff       	call   80101ed0 <iunlockput>
    goto bad;
80105a71:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105a74:	83 ec 0c             	sub    $0xc,%esp
80105a77:	53                   	push   %ebx
80105a78:	e8 c3 c1 ff ff       	call   80101c40 <ilock>
  ip->nlink--;
80105a7d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a82:	89 1c 24             	mov    %ebx,(%esp)
80105a85:	e8 06 c1 ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105a8a:	89 1c 24             	mov    %ebx,(%esp)
80105a8d:	e8 3e c4 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105a92:	e8 09 d8 ff ff       	call   801032a0 <end_op>
  return -1;
80105a97:	83 c4 10             	add    $0x10,%esp
80105a9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a9f:	eb b9                	jmp    80105a5a <sys_link+0xda>
    iunlockput(ip);
80105aa1:	83 ec 0c             	sub    $0xc,%esp
80105aa4:	53                   	push   %ebx
80105aa5:	e8 26 c4 ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105aaa:	e8 f1 d7 ff ff       	call   801032a0 <end_op>
    return -1;
80105aaf:	83 c4 10             	add    $0x10,%esp
80105ab2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ab7:	eb a1                	jmp    80105a5a <sys_link+0xda>
    end_op();
80105ab9:	e8 e2 d7 ff ff       	call   801032a0 <end_op>
    return -1;
80105abe:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ac3:	eb 95                	jmp    80105a5a <sys_link+0xda>
80105ac5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ad0 <sys_unlink>:
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	57                   	push   %edi
80105ad4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105ad5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105ad8:	53                   	push   %ebx
80105ad9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105adc:	50                   	push   %eax
80105add:	6a 00                	push   $0x0
80105adf:	e8 bc f9 ff ff       	call   801054a0 <argstr>
80105ae4:	83 c4 10             	add    $0x10,%esp
80105ae7:	85 c0                	test   %eax,%eax
80105ae9:	0f 88 7a 01 00 00    	js     80105c69 <sys_unlink+0x199>
  begin_op();
80105aef:	e8 3c d7 ff ff       	call   80103230 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105af4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105af7:	83 ec 08             	sub    $0x8,%esp
80105afa:	53                   	push   %ebx
80105afb:	ff 75 c0             	pushl  -0x40(%ebp)
80105afe:	e8 7d ca ff ff       	call   80102580 <nameiparent>
80105b03:	83 c4 10             	add    $0x10,%esp
80105b06:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105b09:	85 c0                	test   %eax,%eax
80105b0b:	0f 84 62 01 00 00    	je     80105c73 <sys_unlink+0x1a3>
  ilock(dp);
80105b11:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105b14:	83 ec 0c             	sub    $0xc,%esp
80105b17:	57                   	push   %edi
80105b18:	e8 23 c1 ff ff       	call   80101c40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b1d:	58                   	pop    %eax
80105b1e:	5a                   	pop    %edx
80105b1f:	68 d0 86 10 80       	push   $0x801086d0
80105b24:	53                   	push   %ebx
80105b25:	e8 56 c6 ff ff       	call   80102180 <namecmp>
80105b2a:	83 c4 10             	add    $0x10,%esp
80105b2d:	85 c0                	test   %eax,%eax
80105b2f:	0f 84 fb 00 00 00    	je     80105c30 <sys_unlink+0x160>
80105b35:	83 ec 08             	sub    $0x8,%esp
80105b38:	68 cf 86 10 80       	push   $0x801086cf
80105b3d:	53                   	push   %ebx
80105b3e:	e8 3d c6 ff ff       	call   80102180 <namecmp>
80105b43:	83 c4 10             	add    $0x10,%esp
80105b46:	85 c0                	test   %eax,%eax
80105b48:	0f 84 e2 00 00 00    	je     80105c30 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b4e:	83 ec 04             	sub    $0x4,%esp
80105b51:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105b54:	50                   	push   %eax
80105b55:	53                   	push   %ebx
80105b56:	57                   	push   %edi
80105b57:	e8 44 c6 ff ff       	call   801021a0 <dirlookup>
80105b5c:	83 c4 10             	add    $0x10,%esp
80105b5f:	89 c3                	mov    %eax,%ebx
80105b61:	85 c0                	test   %eax,%eax
80105b63:	0f 84 c7 00 00 00    	je     80105c30 <sys_unlink+0x160>
  ilock(ip);
80105b69:	83 ec 0c             	sub    $0xc,%esp
80105b6c:	50                   	push   %eax
80105b6d:	e8 ce c0 ff ff       	call   80101c40 <ilock>
  if(ip->nlink < 1)
80105b72:	83 c4 10             	add    $0x10,%esp
80105b75:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105b7a:	0f 8e 1c 01 00 00    	jle    80105c9c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105b80:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b85:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105b88:	74 66                	je     80105bf0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105b8a:	83 ec 04             	sub    $0x4,%esp
80105b8d:	6a 10                	push   $0x10
80105b8f:	6a 00                	push   $0x0
80105b91:	57                   	push   %edi
80105b92:	e8 79 f5 ff ff       	call   80105110 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b97:	6a 10                	push   $0x10
80105b99:	ff 75 c4             	pushl  -0x3c(%ebp)
80105b9c:	57                   	push   %edi
80105b9d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105ba0:	e8 ab c4 ff ff       	call   80102050 <writei>
80105ba5:	83 c4 20             	add    $0x20,%esp
80105ba8:	83 f8 10             	cmp    $0x10,%eax
80105bab:	0f 85 de 00 00 00    	jne    80105c8f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105bb1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bb6:	0f 84 94 00 00 00    	je     80105c50 <sys_unlink+0x180>
  iunlockput(dp);
80105bbc:	83 ec 0c             	sub    $0xc,%esp
80105bbf:	ff 75 b4             	pushl  -0x4c(%ebp)
80105bc2:	e8 09 c3 ff ff       	call   80101ed0 <iunlockput>
  ip->nlink--;
80105bc7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105bcc:	89 1c 24             	mov    %ebx,(%esp)
80105bcf:	e8 bc bf ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105bd4:	89 1c 24             	mov    %ebx,(%esp)
80105bd7:	e8 f4 c2 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105bdc:	e8 bf d6 ff ff       	call   801032a0 <end_op>
  return 0;
80105be1:	83 c4 10             	add    $0x10,%esp
80105be4:	31 c0                	xor    %eax,%eax
}
80105be6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105be9:	5b                   	pop    %ebx
80105bea:	5e                   	pop    %esi
80105beb:	5f                   	pop    %edi
80105bec:	5d                   	pop    %ebp
80105bed:	c3                   	ret    
80105bee:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105bf0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105bf4:	76 94                	jbe    80105b8a <sys_unlink+0xba>
80105bf6:	be 20 00 00 00       	mov    $0x20,%esi
80105bfb:	eb 0b                	jmp    80105c08 <sys_unlink+0x138>
80105bfd:	8d 76 00             	lea    0x0(%esi),%esi
80105c00:	83 c6 10             	add    $0x10,%esi
80105c03:	3b 73 58             	cmp    0x58(%ebx),%esi
80105c06:	73 82                	jae    80105b8a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c08:	6a 10                	push   $0x10
80105c0a:	56                   	push   %esi
80105c0b:	57                   	push   %edi
80105c0c:	53                   	push   %ebx
80105c0d:	e8 3e c3 ff ff       	call   80101f50 <readi>
80105c12:	83 c4 10             	add    $0x10,%esp
80105c15:	83 f8 10             	cmp    $0x10,%eax
80105c18:	75 68                	jne    80105c82 <sys_unlink+0x1b2>
    if(de.inum != 0)
80105c1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c1f:	74 df                	je     80105c00 <sys_unlink+0x130>
    iunlockput(ip);
80105c21:	83 ec 0c             	sub    $0xc,%esp
80105c24:	53                   	push   %ebx
80105c25:	e8 a6 c2 ff ff       	call   80101ed0 <iunlockput>
    goto bad;
80105c2a:	83 c4 10             	add    $0x10,%esp
80105c2d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105c30:	83 ec 0c             	sub    $0xc,%esp
80105c33:	ff 75 b4             	pushl  -0x4c(%ebp)
80105c36:	e8 95 c2 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105c3b:	e8 60 d6 ff ff       	call   801032a0 <end_op>
  return -1;
80105c40:	83 c4 10             	add    $0x10,%esp
80105c43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c48:	eb 9c                	jmp    80105be6 <sys_unlink+0x116>
80105c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105c50:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105c53:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105c56:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105c5b:	50                   	push   %eax
80105c5c:	e8 2f bf ff ff       	call   80101b90 <iupdate>
80105c61:	83 c4 10             	add    $0x10,%esp
80105c64:	e9 53 ff ff ff       	jmp    80105bbc <sys_unlink+0xec>
    return -1;
80105c69:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c6e:	e9 73 ff ff ff       	jmp    80105be6 <sys_unlink+0x116>
    end_op();
80105c73:	e8 28 d6 ff ff       	call   801032a0 <end_op>
    return -1;
80105c78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c7d:	e9 64 ff ff ff       	jmp    80105be6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105c82:	83 ec 0c             	sub    $0xc,%esp
80105c85:	68 f4 86 10 80       	push   $0x801086f4
80105c8a:	e8 f1 a6 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105c8f:	83 ec 0c             	sub    $0xc,%esp
80105c92:	68 06 87 10 80       	push   $0x80108706
80105c97:	e8 e4 a6 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105c9c:	83 ec 0c             	sub    $0xc,%esp
80105c9f:	68 e2 86 10 80       	push   $0x801086e2
80105ca4:	e8 d7 a6 ff ff       	call   80100380 <panic>
80105ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105cb0 <sys_open>:

int
sys_open(void)
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	57                   	push   %edi
80105cb4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cb5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105cb8:	53                   	push   %ebx
80105cb9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105cbc:	50                   	push   %eax
80105cbd:	6a 00                	push   $0x0
80105cbf:	e8 dc f7 ff ff       	call   801054a0 <argstr>
80105cc4:	83 c4 10             	add    $0x10,%esp
80105cc7:	85 c0                	test   %eax,%eax
80105cc9:	0f 88 8e 00 00 00    	js     80105d5d <sys_open+0xad>
80105ccf:	83 ec 08             	sub    $0x8,%esp
80105cd2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105cd5:	50                   	push   %eax
80105cd6:	6a 01                	push   $0x1
80105cd8:	e8 03 f7 ff ff       	call   801053e0 <argint>
80105cdd:	83 c4 10             	add    $0x10,%esp
80105ce0:	85 c0                	test   %eax,%eax
80105ce2:	78 79                	js     80105d5d <sys_open+0xad>
    return -1;

  begin_op();
80105ce4:	e8 47 d5 ff ff       	call   80103230 <begin_op>

  if(omode & O_CREATE){
80105ce9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105ced:	75 79                	jne    80105d68 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105cef:	83 ec 0c             	sub    $0xc,%esp
80105cf2:	ff 75 e0             	pushl  -0x20(%ebp)
80105cf5:	e8 66 c8 ff ff       	call   80102560 <namei>
80105cfa:	83 c4 10             	add    $0x10,%esp
80105cfd:	89 c6                	mov    %eax,%esi
80105cff:	85 c0                	test   %eax,%eax
80105d01:	0f 84 7e 00 00 00    	je     80105d85 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105d07:	83 ec 0c             	sub    $0xc,%esp
80105d0a:	50                   	push   %eax
80105d0b:	e8 30 bf ff ff       	call   80101c40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d10:	83 c4 10             	add    $0x10,%esp
80105d13:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d18:	0f 84 c2 00 00 00    	je     80105de0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d1e:	e8 cd b5 ff ff       	call   801012f0 <filealloc>
80105d23:	89 c7                	mov    %eax,%edi
80105d25:	85 c0                	test   %eax,%eax
80105d27:	74 23                	je     80105d4c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105d29:	e8 62 e1 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d2e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d30:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105d34:	85 d2                	test   %edx,%edx
80105d36:	74 60                	je     80105d98 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105d38:	83 c3 01             	add    $0x1,%ebx
80105d3b:	83 fb 10             	cmp    $0x10,%ebx
80105d3e:	75 f0                	jne    80105d30 <sys_open+0x80>
    if(f)
      fileclose(f);
80105d40:	83 ec 0c             	sub    $0xc,%esp
80105d43:	57                   	push   %edi
80105d44:	e8 67 b6 ff ff       	call   801013b0 <fileclose>
80105d49:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105d4c:	83 ec 0c             	sub    $0xc,%esp
80105d4f:	56                   	push   %esi
80105d50:	e8 7b c1 ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105d55:	e8 46 d5 ff ff       	call   801032a0 <end_op>
    return -1;
80105d5a:	83 c4 10             	add    $0x10,%esp
80105d5d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d62:	eb 6d                	jmp    80105dd1 <sys_open+0x121>
80105d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105d68:	83 ec 0c             	sub    $0xc,%esp
80105d6b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d6e:	31 c9                	xor    %ecx,%ecx
80105d70:	ba 02 00 00 00       	mov    $0x2,%edx
80105d75:	6a 00                	push   $0x0
80105d77:	e8 14 f8 ff ff       	call   80105590 <create>
    if(ip == 0){
80105d7c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105d7f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105d81:	85 c0                	test   %eax,%eax
80105d83:	75 99                	jne    80105d1e <sys_open+0x6e>
      end_op();
80105d85:	e8 16 d5 ff ff       	call   801032a0 <end_op>
      return -1;
80105d8a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d8f:	eb 40                	jmp    80105dd1 <sys_open+0x121>
80105d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105d98:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105d9b:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
80105d9f:	56                   	push   %esi
80105da0:	e8 7b bf ff ff       	call   80101d20 <iunlock>
  end_op();
80105da5:	e8 f6 d4 ff ff       	call   801032a0 <end_op>

  f->type = FD_INODE;
80105daa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105db0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105db3:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105db6:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105db9:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105dbb:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105dc2:	f7 d0                	not    %eax
80105dc4:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105dc7:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105dca:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105dcd:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105dd1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dd4:	89 d8                	mov    %ebx,%eax
80105dd6:	5b                   	pop    %ebx
80105dd7:	5e                   	pop    %esi
80105dd8:	5f                   	pop    %edi
80105dd9:	5d                   	pop    %ebp
80105dda:	c3                   	ret    
80105ddb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105ddf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105de0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105de3:	85 c9                	test   %ecx,%ecx
80105de5:	0f 84 33 ff ff ff    	je     80105d1e <sys_open+0x6e>
80105deb:	e9 5c ff ff ff       	jmp    80105d4c <sys_open+0x9c>

80105df0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105df0:	55                   	push   %ebp
80105df1:	89 e5                	mov    %esp,%ebp
80105df3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105df6:	e8 35 d4 ff ff       	call   80103230 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105dfb:	83 ec 08             	sub    $0x8,%esp
80105dfe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e01:	50                   	push   %eax
80105e02:	6a 00                	push   $0x0
80105e04:	e8 97 f6 ff ff       	call   801054a0 <argstr>
80105e09:	83 c4 10             	add    $0x10,%esp
80105e0c:	85 c0                	test   %eax,%eax
80105e0e:	78 30                	js     80105e40 <sys_mkdir+0x50>
80105e10:	83 ec 0c             	sub    $0xc,%esp
80105e13:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e16:	31 c9                	xor    %ecx,%ecx
80105e18:	ba 01 00 00 00       	mov    $0x1,%edx
80105e1d:	6a 00                	push   $0x0
80105e1f:	e8 6c f7 ff ff       	call   80105590 <create>
80105e24:	83 c4 10             	add    $0x10,%esp
80105e27:	85 c0                	test   %eax,%eax
80105e29:	74 15                	je     80105e40 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e2b:	83 ec 0c             	sub    $0xc,%esp
80105e2e:	50                   	push   %eax
80105e2f:	e8 9c c0 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105e34:	e8 67 d4 ff ff       	call   801032a0 <end_op>
  return 0;
80105e39:	83 c4 10             	add    $0x10,%esp
80105e3c:	31 c0                	xor    %eax,%eax
}
80105e3e:	c9                   	leave  
80105e3f:	c3                   	ret    
    end_op();
80105e40:	e8 5b d4 ff ff       	call   801032a0 <end_op>
    return -1;
80105e45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e4a:	c9                   	leave  
80105e4b:	c3                   	ret    
80105e4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e50 <sys_mknod>:

int
sys_mknod(void)
{
80105e50:	55                   	push   %ebp
80105e51:	89 e5                	mov    %esp,%ebp
80105e53:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105e56:	e8 d5 d3 ff ff       	call   80103230 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105e5b:	83 ec 08             	sub    $0x8,%esp
80105e5e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e61:	50                   	push   %eax
80105e62:	6a 00                	push   $0x0
80105e64:	e8 37 f6 ff ff       	call   801054a0 <argstr>
80105e69:	83 c4 10             	add    $0x10,%esp
80105e6c:	85 c0                	test   %eax,%eax
80105e6e:	78 60                	js     80105ed0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105e70:	83 ec 08             	sub    $0x8,%esp
80105e73:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e76:	50                   	push   %eax
80105e77:	6a 01                	push   $0x1
80105e79:	e8 62 f5 ff ff       	call   801053e0 <argint>
  if((argstr(0, &path)) < 0 ||
80105e7e:	83 c4 10             	add    $0x10,%esp
80105e81:	85 c0                	test   %eax,%eax
80105e83:	78 4b                	js     80105ed0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105e85:	83 ec 08             	sub    $0x8,%esp
80105e88:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e8b:	50                   	push   %eax
80105e8c:	6a 02                	push   $0x2
80105e8e:	e8 4d f5 ff ff       	call   801053e0 <argint>
     argint(1, &major) < 0 ||
80105e93:	83 c4 10             	add    $0x10,%esp
80105e96:	85 c0                	test   %eax,%eax
80105e98:	78 36                	js     80105ed0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105e9a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105e9e:	83 ec 0c             	sub    $0xc,%esp
80105ea1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105ea5:	ba 03 00 00 00       	mov    $0x3,%edx
80105eaa:	50                   	push   %eax
80105eab:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105eae:	e8 dd f6 ff ff       	call   80105590 <create>
     argint(2, &minor) < 0 ||
80105eb3:	83 c4 10             	add    $0x10,%esp
80105eb6:	85 c0                	test   %eax,%eax
80105eb8:	74 16                	je     80105ed0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105eba:	83 ec 0c             	sub    $0xc,%esp
80105ebd:	50                   	push   %eax
80105ebe:	e8 0d c0 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105ec3:	e8 d8 d3 ff ff       	call   801032a0 <end_op>
  return 0;
80105ec8:	83 c4 10             	add    $0x10,%esp
80105ecb:	31 c0                	xor    %eax,%eax
}
80105ecd:	c9                   	leave  
80105ece:	c3                   	ret    
80105ecf:	90                   	nop
    end_op();
80105ed0:	e8 cb d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105ed5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105eda:	c9                   	leave  
80105edb:	c3                   	ret    
80105edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ee0 <sys_chdir>:

int
sys_chdir(void)
{
80105ee0:	55                   	push   %ebp
80105ee1:	89 e5                	mov    %esp,%ebp
80105ee3:	56                   	push   %esi
80105ee4:	53                   	push   %ebx
80105ee5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105ee8:	e8 a3 df ff ff       	call   80103e90 <myproc>
80105eed:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105eef:	e8 3c d3 ff ff       	call   80103230 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105ef4:	83 ec 08             	sub    $0x8,%esp
80105ef7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105efa:	50                   	push   %eax
80105efb:	6a 00                	push   $0x0
80105efd:	e8 9e f5 ff ff       	call   801054a0 <argstr>
80105f02:	83 c4 10             	add    $0x10,%esp
80105f05:	85 c0                	test   %eax,%eax
80105f07:	78 77                	js     80105f80 <sys_chdir+0xa0>
80105f09:	83 ec 0c             	sub    $0xc,%esp
80105f0c:	ff 75 f4             	pushl  -0xc(%ebp)
80105f0f:	e8 4c c6 ff ff       	call   80102560 <namei>
80105f14:	83 c4 10             	add    $0x10,%esp
80105f17:	89 c3                	mov    %eax,%ebx
80105f19:	85 c0                	test   %eax,%eax
80105f1b:	74 63                	je     80105f80 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f1d:	83 ec 0c             	sub    $0xc,%esp
80105f20:	50                   	push   %eax
80105f21:	e8 1a bd ff ff       	call   80101c40 <ilock>
  if(ip->type != T_DIR){
80105f26:	83 c4 10             	add    $0x10,%esp
80105f29:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f2e:	75 30                	jne    80105f60 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f30:	83 ec 0c             	sub    $0xc,%esp
80105f33:	53                   	push   %ebx
80105f34:	e8 e7 bd ff ff       	call   80101d20 <iunlock>
  iput(curproc->cwd);
80105f39:	58                   	pop    %eax
80105f3a:	ff 76 6c             	pushl  0x6c(%esi)
80105f3d:	e8 2e be ff ff       	call   80101d70 <iput>
  end_op();
80105f42:	e8 59 d3 ff ff       	call   801032a0 <end_op>
  curproc->cwd = ip;
80105f47:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
80105f4a:	83 c4 10             	add    $0x10,%esp
80105f4d:	31 c0                	xor    %eax,%eax
}
80105f4f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f52:	5b                   	pop    %ebx
80105f53:	5e                   	pop    %esi
80105f54:	5d                   	pop    %ebp
80105f55:	c3                   	ret    
80105f56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f5d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105f60:	83 ec 0c             	sub    $0xc,%esp
80105f63:	53                   	push   %ebx
80105f64:	e8 67 bf ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105f69:	e8 32 d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105f6e:	83 c4 10             	add    $0x10,%esp
80105f71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f76:	eb d7                	jmp    80105f4f <sys_chdir+0x6f>
80105f78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f7f:	90                   	nop
    end_op();
80105f80:	e8 1b d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105f85:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f8a:	eb c3                	jmp    80105f4f <sys_chdir+0x6f>
80105f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f90 <sys_exec>:

int
sys_exec(void)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	57                   	push   %edi
80105f94:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105f95:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105f9b:	53                   	push   %ebx
80105f9c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105fa2:	50                   	push   %eax
80105fa3:	6a 00                	push   $0x0
80105fa5:	e8 f6 f4 ff ff       	call   801054a0 <argstr>
80105faa:	83 c4 10             	add    $0x10,%esp
80105fad:	85 c0                	test   %eax,%eax
80105faf:	0f 88 87 00 00 00    	js     8010603c <sys_exec+0xac>
80105fb5:	83 ec 08             	sub    $0x8,%esp
80105fb8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105fbe:	50                   	push   %eax
80105fbf:	6a 01                	push   $0x1
80105fc1:	e8 1a f4 ff ff       	call   801053e0 <argint>
80105fc6:	83 c4 10             	add    $0x10,%esp
80105fc9:	85 c0                	test   %eax,%eax
80105fcb:	78 6f                	js     8010603c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105fcd:	83 ec 04             	sub    $0x4,%esp
80105fd0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105fd6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105fd8:	68 80 00 00 00       	push   $0x80
80105fdd:	6a 00                	push   $0x0
80105fdf:	56                   	push   %esi
80105fe0:	e8 2b f1 ff ff       	call   80105110 <memset>
80105fe5:	83 c4 10             	add    $0x10,%esp
80105fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fef:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105ff0:	83 ec 08             	sub    $0x8,%esp
80105ff3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105ff9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106000:	50                   	push   %eax
80106001:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106007:	01 f8                	add    %edi,%eax
80106009:	50                   	push   %eax
8010600a:	e8 41 f3 ff ff       	call   80105350 <fetchint>
8010600f:	83 c4 10             	add    $0x10,%esp
80106012:	85 c0                	test   %eax,%eax
80106014:	78 26                	js     8010603c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106016:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010601c:	85 c0                	test   %eax,%eax
8010601e:	74 30                	je     80106050 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106020:	83 ec 08             	sub    $0x8,%esp
80106023:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106026:	52                   	push   %edx
80106027:	50                   	push   %eax
80106028:	e8 63 f3 ff ff       	call   80105390 <fetchstr>
8010602d:	83 c4 10             	add    $0x10,%esp
80106030:	85 c0                	test   %eax,%eax
80106032:	78 08                	js     8010603c <sys_exec+0xac>
  for(i=0;; i++){
80106034:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106037:	83 fb 20             	cmp    $0x20,%ebx
8010603a:	75 b4                	jne    80105ff0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010603c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010603f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106044:	5b                   	pop    %ebx
80106045:	5e                   	pop    %esi
80106046:	5f                   	pop    %edi
80106047:	5d                   	pop    %ebp
80106048:	c3                   	ret    
80106049:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106050:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106057:	00 00 00 00 
  return exec(path, argv);
8010605b:	83 ec 08             	sub    $0x8,%esp
8010605e:	56                   	push   %esi
8010605f:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80106065:	e8 06 af ff ff       	call   80100f70 <exec>
8010606a:	83 c4 10             	add    $0x10,%esp
}
8010606d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106070:	5b                   	pop    %ebx
80106071:	5e                   	pop    %esi
80106072:	5f                   	pop    %edi
80106073:	5d                   	pop    %ebp
80106074:	c3                   	ret    
80106075:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010607c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106080 <sys_pipe>:

int
sys_pipe(void)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106085:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106088:	53                   	push   %ebx
80106089:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010608c:	6a 08                	push   $0x8
8010608e:	50                   	push   %eax
8010608f:	6a 00                	push   $0x0
80106091:	e8 9a f3 ff ff       	call   80105430 <argptr>
80106096:	83 c4 10             	add    $0x10,%esp
80106099:	85 c0                	test   %eax,%eax
8010609b:	78 4a                	js     801060e7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010609d:	83 ec 08             	sub    $0x8,%esp
801060a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801060a3:	50                   	push   %eax
801060a4:	8d 45 e0             	lea    -0x20(%ebp),%eax
801060a7:	50                   	push   %eax
801060a8:	e8 53 d8 ff ff       	call   80103900 <pipealloc>
801060ad:	83 c4 10             	add    $0x10,%esp
801060b0:	85 c0                	test   %eax,%eax
801060b2:	78 33                	js     801060e7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801060b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801060b7:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801060b9:	e8 d2 dd ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801060be:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
801060c0:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
801060c4:	85 f6                	test   %esi,%esi
801060c6:	74 28                	je     801060f0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
801060c8:	83 c3 01             	add    $0x1,%ebx
801060cb:	83 fb 10             	cmp    $0x10,%ebx
801060ce:	75 f0                	jne    801060c0 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801060d0:	83 ec 0c             	sub    $0xc,%esp
801060d3:	ff 75 e0             	pushl  -0x20(%ebp)
801060d6:	e8 d5 b2 ff ff       	call   801013b0 <fileclose>
    fileclose(wf);
801060db:	58                   	pop    %eax
801060dc:	ff 75 e4             	pushl  -0x1c(%ebp)
801060df:	e8 cc b2 ff ff       	call   801013b0 <fileclose>
    return -1;
801060e4:	83 c4 10             	add    $0x10,%esp
801060e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060ec:	eb 53                	jmp    80106141 <sys_pipe+0xc1>
801060ee:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801060f0:	8d 73 08             	lea    0x8(%ebx),%esi
801060f3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801060f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801060fa:	e8 91 dd ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801060ff:	31 d2                	xor    %edx,%edx
80106101:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106108:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
8010610c:	85 c9                	test   %ecx,%ecx
8010610e:	74 20                	je     80106130 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
80106110:	83 c2 01             	add    $0x1,%edx
80106113:	83 fa 10             	cmp    $0x10,%edx
80106116:	75 f0                	jne    80106108 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
80106118:	e8 73 dd ff ff       	call   80103e90 <myproc>
8010611d:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
80106124:	00 
80106125:	eb a9                	jmp    801060d0 <sys_pipe+0x50>
80106127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010612e:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106130:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
  }
  fd[0] = fd0;
80106134:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106137:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106139:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010613c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010613f:	31 c0                	xor    %eax,%eax
}
80106141:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106144:	5b                   	pop    %ebx
80106145:	5e                   	pop    %esi
80106146:	5f                   	pop    %edi
80106147:	5d                   	pop    %ebp
80106148:	c3                   	ret    
80106149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106150 <sys_get_file_sectors>:
int
sys_get_file_sectors(void){
80106150:	55                   	push   %ebp
80106151:	89 e5                	mov    %esp,%ebp
80106153:	57                   	push   %edi
80106154:	56                   	push   %esi
80106155:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106156:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
sys_get_file_sectors(void){
80106159:	83 ec 34             	sub    $0x34,%esp
  if(argint(n, &fd) < 0)
8010615c:	53                   	push   %ebx
8010615d:	6a 00                	push   $0x0
8010615f:	e8 7c f2 ff ff       	call   801053e0 <argint>
80106164:	83 c4 10             	add    $0x10,%esp
80106167:	85 c0                	test   %eax,%eax
80106169:	0f 88 e1 00 00 00    	js     80106250 <sys_get_file_sectors+0x100>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010616f:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80106173:	0f 87 d7 00 00 00    	ja     80106250 <sys_get_file_sectors+0x100>
80106179:	e8 12 dd ff ff       	call   80103e90 <myproc>
8010617e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106181:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
80106185:	89 45 d0             	mov    %eax,-0x30(%ebp)
80106188:	85 c0                	test   %eax,%eax
8010618a:	0f 84 c0 00 00 00    	je     80106250 <sys_get_file_sectors+0x100>
    int fd;

    char* tmp;
    int n;

    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
80106190:	83 ec 08             	sub    $0x8,%esp
80106193:	53                   	push   %ebx
80106194:	6a 02                	push   $0x2
80106196:	e8 45 f2 ff ff       	call   801053e0 <argint>
8010619b:	83 c4 10             	add    $0x10,%esp
8010619e:	85 c0                	test   %eax,%eax
801061a0:	0f 88 aa 00 00 00    	js     80106250 <sys_get_file_sectors+0x100>
801061a6:	83 ec 04             	sub    $0x4,%esp
801061a9:	8d 45 e0             	lea    -0x20(%ebp),%eax
801061ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801061af:	50                   	push   %eax
801061b0:	6a 01                	push   $0x1
801061b2:	e8 79 f2 ff ff       	call   80105430 <argptr>
801061b7:	83 c4 10             	add    $0x10,%esp
801061ba:	85 c0                	test   %eax,%eax
801061bc:	0f 88 8e 00 00 00    	js     80106250 <sys_get_file_sectors+0x100>
        return -1;
    int* sectors = (int*) tmp;
801061c2:	8b 45 e0             	mov    -0x20(%ebp),%eax

    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
801061c5:	31 db                	xor    %ebx,%ebx
    int* sectors = (int*) tmp;
801061c7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
801061ca:	8b 45 d0             	mov    -0x30(%ebp),%eax
801061cd:	8b 40 10             	mov    0x10(%eax),%eax
801061d0:	8b 50 58             	mov    0x58(%eax),%edx
801061d3:	f7 c2 ff 01 00 00    	test   $0x1ff,%edx
801061d9:	0f 95 c3             	setne  %bl
801061dc:	c1 ea 09             	shr    $0x9,%edx
801061df:	01 d3                	add    %edx,%ebx
    int min_end = n < blkcnt ? n : blkcnt;
801061e1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801061e4:	39 d3                	cmp    %edx,%ebx
801061e6:	0f 4f da             	cmovg  %edx,%ebx

    int i;
    for(i=0;i<min_end;i++){
801061e9:	85 db                	test   %ebx,%ebx
801061eb:	7e 3a                	jle    80106227 <sys_get_file_sectors+0xd7>
801061ed:	31 ff                	xor    %edi,%edi
801061ef:	eb 0d                	jmp    801061fe <sys_get_file_sectors+0xae>
801061f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        int sec = getbmap(f->ip, i);
801061f8:	8b 45 d0             	mov    -0x30(%ebp),%eax
801061fb:	8b 40 10             	mov    0x10(%eax),%eax
801061fe:	83 ec 08             	sub    $0x8,%esp
80106201:	57                   	push   %edi
80106202:	50                   	push   %eax
80106203:	e8 98 c3 ff ff       	call   801025a0 <getbmap>
80106208:	89 c6                	mov    %eax,%esi
        cprintf("%d ", sec);
8010620a:	58                   	pop    %eax
8010620b:	5a                   	pop    %edx
8010620c:	56                   	push   %esi
8010620d:	68 15 87 10 80       	push   $0x80108715
80106212:	e8 89 a4 ff ff       	call   801006a0 <cprintf>
        sectors[i] = sec;
80106217:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    for(i=0;i<min_end;i++){
8010621a:	83 c4 10             	add    $0x10,%esp
        sectors[i] = sec;
8010621d:	89 34 b8             	mov    %esi,(%eax,%edi,4)
    for(i=0;i<min_end;i++){
80106220:	83 c7 01             	add    $0x1,%edi
80106223:	39 fb                	cmp    %edi,%ebx
80106225:	75 d1                	jne    801061f8 <sys_get_file_sectors+0xa8>
    }
    cprintf("\n");
80106227:	83 ec 0c             	sub    $0xc,%esp
8010622a:	68 bd 84 10 80       	push   $0x801084bd
8010622f:	e8 6c a4 ff ff       	call   801006a0 <cprintf>
    if (min_end<=n-1)
80106234:	83 c4 10             	add    $0x10,%esp
        sectors[min_end]=-1;
    return 0;
80106237:	31 c0                	xor    %eax,%eax
    if (min_end<=n-1)
80106239:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010623c:	7e 0a                	jle    80106248 <sys_get_file_sectors+0xf8>
        sectors[min_end]=-1;
8010623e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80106241:	c7 04 99 ff ff ff ff 	movl   $0xffffffff,(%ecx,%ebx,4)
80106248:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010624b:	5b                   	pop    %ebx
8010624c:	5e                   	pop    %esi
8010624d:	5f                   	pop    %edi
8010624e:	5d                   	pop    %ebp
8010624f:	c3                   	ret    
        return -1;
80106250:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106255:	eb f1                	jmp    80106248 <sys_get_file_sectors+0xf8>
80106257:	66 90                	xchg   %ax,%ax
80106259:	66 90                	xchg   %ax,%ax
8010625b:	66 90                	xchg   %ax,%ax
8010625d:	66 90                	xchg   %ax,%ax
8010625f:	90                   	nop

80106260 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106260:	e9 eb dd ff ff       	jmp    80104050 <fork>
80106265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106270 <sys_exit>:
}

int
sys_exit(void)
{
80106270:	55                   	push   %ebp
80106271:	89 e5                	mov    %esp,%ebp
80106273:	83 ec 08             	sub    $0x8,%esp
  exit();
80106276:	e8 45 e3 ff ff       	call   801045c0 <exit>
  return 0;  // not reached
}
8010627b:	31 c0                	xor    %eax,%eax
8010627d:	c9                   	leave  
8010627e:	c3                   	ret    
8010627f:	90                   	nop

80106280 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106280:	e9 6b e4 ff ff       	jmp    801046f0 <wait>
80106285:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010628c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106290 <sys_wait_sleeping>:
}

int sys_wait_sleeping(void){
    return wait_sleeping();
80106290:	e9 ab e8 ff ff       	jmp    80104b40 <wait_sleeping>
80106295:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010629c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062a0 <sys_set_proc_tracer>:
}
int sys_set_proc_tracer(void){
    return set_proc_tracer();
801062a0:	e9 7b e9 ff ff       	jmp    80104c20 <set_proc_tracer>
801062a5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801062b0 <sys_kill>:
}

int
sys_kill(void)
{
801062b0:	55                   	push   %ebp
801062b1:	89 e5                	mov    %esp,%ebp
801062b3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801062b6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801062b9:	50                   	push   %eax
801062ba:	6a 00                	push   $0x0
801062bc:	e8 1f f1 ff ff       	call   801053e0 <argint>
801062c1:	83 c4 10             	add    $0x10,%esp
801062c4:	85 c0                	test   %eax,%eax
801062c6:	78 18                	js     801062e0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801062c8:	83 ec 0c             	sub    $0xc,%esp
801062cb:	ff 75 f4             	pushl  -0xc(%ebp)
801062ce:	e8 2d e7 ff ff       	call   80104a00 <kill>
801062d3:	83 c4 10             	add    $0x10,%esp
}
801062d6:	c9                   	leave  
801062d7:	c3                   	ret    
801062d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062df:	90                   	nop
801062e0:	c9                   	leave  
    return -1;
801062e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062e6:	c3                   	ret    
801062e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062ee:	66 90                	xchg   %ax,%ax

801062f0 <sys_calculate_sum_of_digits>:

int sys_calculate_sum_of_digits(void){
801062f0:	55                   	push   %ebp
801062f1:	89 e5                	mov    %esp,%ebp
801062f3:	57                   	push   %edi
801062f4:	56                   	push   %esi
801062f5:	53                   	push   %ebx
801062f6:	83 ec 0c             	sub    $0xc,%esp
  int num = myproc()->tf->edx; //edx or ebx?
801062f9:	e8 92 db ff ff       	call   80103e90 <myproc>
  //cprintf("edx : %d\n", myproc()->tf->edx);
  //cprintf("number : %d\n",number);
  int result = 0;
  int reminder = 10;
  while(num / reminder != 0){
801062fe:	ba 67 66 66 66       	mov    $0x66666667,%edx
  int num = myproc()->tf->edx; //edx or ebx?
80106303:	8b 40 1c             	mov    0x1c(%eax),%eax
80106306:	8b 48 14             	mov    0x14(%eax),%ecx
  while(num / reminder != 0){
80106309:	89 c8                	mov    %ecx,%eax
8010630b:	f7 ea                	imul   %edx
8010630d:	89 c8                	mov    %ecx,%eax
8010630f:	c1 f8 1f             	sar    $0x1f,%eax
80106312:	c1 fa 02             	sar    $0x2,%edx
80106315:	89 d3                	mov    %edx,%ebx
80106317:	29 c3                	sub    %eax,%ebx
80106319:	8d 41 09             	lea    0x9(%ecx),%eax
8010631c:	83 f8 12             	cmp    $0x12,%eax
8010631f:	76 42                	jbe    80106363 <sys_calculate_sum_of_digits+0x73>
  int result = 0;
80106321:	31 f6                	xor    %esi,%esi
    result += (num % reminder);
80106323:	bf 67 66 66 66       	mov    $0x66666667,%edi
80106328:	eb 08                	jmp    80106332 <sys_calculate_sum_of_digits+0x42>
8010632a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(num / reminder != 0){
80106330:	89 d3                	mov    %edx,%ebx
    result += (num % reminder);
80106332:	89 c8                	mov    %ecx,%eax
80106334:	f7 ef                	imul   %edi
80106336:	89 c8                	mov    %ecx,%eax
80106338:	c1 f8 1f             	sar    $0x1f,%eax
8010633b:	c1 fa 02             	sar    $0x2,%edx
8010633e:	29 c2                	sub    %eax,%edx
80106340:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106343:	01 c0                	add    %eax,%eax
80106345:	29 c1                	sub    %eax,%ecx
  while(num / reminder != 0){
80106347:	89 d8                	mov    %ebx,%eax
80106349:	f7 ef                	imul   %edi
8010634b:	89 d8                	mov    %ebx,%eax
    result += (num % reminder);
8010634d:	01 ce                	add    %ecx,%esi
  while(num / reminder != 0){
8010634f:	89 d9                	mov    %ebx,%ecx
80106351:	c1 f8 1f             	sar    $0x1f,%eax
80106354:	c1 fa 02             	sar    $0x2,%edx
80106357:	29 c2                	sub    %eax,%edx
80106359:	8d 43 09             	lea    0x9(%ebx),%eax
8010635c:	83 f8 12             	cmp    $0x12,%eax
8010635f:	77 cf                	ja     80106330 <sys_calculate_sum_of_digits+0x40>
    //cprintf("result : %d\n", result);
    // reminder = reminder * 10;
    num = (num / reminder);
    //cprintf("num : %d\n", num);
  }
  result += num;
80106361:	01 f1                	add    %esi,%ecx
  return result;
}
80106363:	83 c4 0c             	add    $0xc,%esp
80106366:	89 c8                	mov    %ecx,%eax
80106368:	5b                   	pop    %ebx
80106369:	5e                   	pop    %esi
8010636a:	5f                   	pop    %edi
8010636b:	5d                   	pop    %ebp
8010636c:	c3                   	ret    
8010636d:	8d 76 00             	lea    0x0(%esi),%esi

80106370 <sys_getpid>:

int
sys_getpid(void)
{
80106370:	55                   	push   %ebp
80106371:	89 e5                	mov    %esp,%ebp
80106373:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106376:	e8 15 db ff ff       	call   80103e90 <myproc>
8010637b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010637e:	c9                   	leave  
8010637f:	c3                   	ret    

80106380 <sys_sbrk>:

int
sys_sbrk(void)
{
80106380:	55                   	push   %ebp
80106381:	89 e5                	mov    %esp,%ebp
80106383:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106384:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106387:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010638a:	50                   	push   %eax
8010638b:	6a 00                	push   $0x0
8010638d:	e8 4e f0 ff ff       	call   801053e0 <argint>
80106392:	83 c4 10             	add    $0x10,%esp
80106395:	85 c0                	test   %eax,%eax
80106397:	78 27                	js     801063c0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106399:	e8 f2 da ff ff       	call   80103e90 <myproc>
  if(growproc(n) < 0)
8010639e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801063a1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801063a3:	ff 75 f4             	pushl  -0xc(%ebp)
801063a6:	e8 25 dc ff ff       	call   80103fd0 <growproc>
801063ab:	83 c4 10             	add    $0x10,%esp
801063ae:	85 c0                	test   %eax,%eax
801063b0:	78 0e                	js     801063c0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801063b2:	89 d8                	mov    %ebx,%eax
801063b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801063b7:	c9                   	leave  
801063b8:	c3                   	ret    
801063b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801063c0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801063c5:	eb eb                	jmp    801063b2 <sys_sbrk+0x32>
801063c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063ce:	66 90                	xchg   %ax,%ax

801063d0 <sys_sleep>:

int
sys_sleep(void)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801063d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801063d7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801063da:	50                   	push   %eax
801063db:	6a 00                	push   $0x0
801063dd:	e8 fe ef ff ff       	call   801053e0 <argint>
801063e2:	83 c4 10             	add    $0x10,%esp
801063e5:	85 c0                	test   %eax,%eax
801063e7:	0f 88 8a 00 00 00    	js     80106477 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801063ed:	83 ec 0c             	sub    $0xc,%esp
801063f0:	68 a0 53 11 80       	push   $0x801153a0
801063f5:	e8 56 ec ff ff       	call   80105050 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801063fa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801063fd:	8b 1d 80 53 11 80    	mov    0x80115380,%ebx
  while(ticks - ticks0 < n){
80106403:	83 c4 10             	add    $0x10,%esp
80106406:	85 d2                	test   %edx,%edx
80106408:	75 27                	jne    80106431 <sys_sleep+0x61>
8010640a:	eb 54                	jmp    80106460 <sys_sleep+0x90>
8010640c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106410:	83 ec 08             	sub    $0x8,%esp
80106413:	68 a0 53 11 80       	push   $0x801153a0
80106418:	68 80 53 11 80       	push   $0x80115380
8010641d:	e8 be e4 ff ff       	call   801048e0 <sleep>
  while(ticks - ticks0 < n){
80106422:	a1 80 53 11 80       	mov    0x80115380,%eax
80106427:	83 c4 10             	add    $0x10,%esp
8010642a:	29 d8                	sub    %ebx,%eax
8010642c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010642f:	73 2f                	jae    80106460 <sys_sleep+0x90>
    if(myproc()->killed){
80106431:	e8 5a da ff ff       	call   80103e90 <myproc>
80106436:	8b 40 28             	mov    0x28(%eax),%eax
80106439:	85 c0                	test   %eax,%eax
8010643b:	74 d3                	je     80106410 <sys_sleep+0x40>
      release(&tickslock);
8010643d:	83 ec 0c             	sub    $0xc,%esp
80106440:	68 a0 53 11 80       	push   $0x801153a0
80106445:	e8 a6 eb ff ff       	call   80104ff0 <release>
  }
  release(&tickslock);
  return 0;
}
8010644a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010644d:	83 c4 10             	add    $0x10,%esp
80106450:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106455:	c9                   	leave  
80106456:	c3                   	ret    
80106457:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010645e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106460:	83 ec 0c             	sub    $0xc,%esp
80106463:	68 a0 53 11 80       	push   $0x801153a0
80106468:	e8 83 eb ff ff       	call   80104ff0 <release>
  return 0;
8010646d:	83 c4 10             	add    $0x10,%esp
80106470:	31 c0                	xor    %eax,%eax
}
80106472:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106475:	c9                   	leave  
80106476:	c3                   	ret    
    return -1;
80106477:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010647c:	eb f4                	jmp    80106472 <sys_sleep+0xa2>
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	53                   	push   %ebx
80106484:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106487:	68 a0 53 11 80       	push   $0x801153a0
8010648c:	e8 bf eb ff ff       	call   80105050 <acquire>
  xticks = ticks;
80106491:	8b 1d 80 53 11 80    	mov    0x80115380,%ebx
  release(&tickslock);
80106497:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
8010649e:	e8 4d eb ff ff       	call   80104ff0 <release>
  return xticks;
}
801064a3:	89 d8                	mov    %ebx,%eax
801064a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801064a8:	c9                   	leave  
801064a9:	c3                   	ret    
801064aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064b0 <sys_get_parent_pid>:

int
sys_get_parent_pid(void)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	83 ec 08             	sub    $0x8,%esp
	return myproc()->parent->pid;
801064b6:	e8 d5 d9 ff ff       	call   80103e90 <myproc>
801064bb:	8b 40 14             	mov    0x14(%eax),%eax
801064be:	8b 40 10             	mov    0x10(%eax),%eax
}
801064c1:	c9                   	leave  
801064c2:	c3                   	ret    
801064c3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064d0 <sys_get_proc_level>:

int sys_get_proc_level(void){
801064d0:	55                   	push   %ebp
801064d1:	89 e5                	mov    %esp,%ebp
801064d3:	83 ec 20             	sub    $0x20,%esp
    int pid;
    if(argint(0, &pid)<0)
801064d6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064d9:	50                   	push   %eax
801064da:	6a 00                	push   $0x0
801064dc:	e8 ff ee ff ff       	call   801053e0 <argint>
801064e1:	83 c4 10             	add    $0x10,%esp
801064e4:	85 c0                	test   %eax,%eax
801064e6:	78 18                	js     80106500 <sys_get_proc_level+0x30>
        return -1;
    return get_proc_queue_level(pid);
801064e8:	83 ec 0c             	sub    $0xc,%esp
801064eb:	ff 75 f4             	pushl  -0xc(%ebp)
801064ee:	e8 ed e7 ff ff       	call   80104ce0 <get_proc_queue_level>
801064f3:	83 c4 10             	add    $0x10,%esp
}
801064f6:	c9                   	leave  
801064f7:	c3                   	ret    
801064f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064ff:	90                   	nop
80106500:	c9                   	leave  
        return -1;
80106501:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106506:	c3                   	ret    
80106507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010650e:	66 90                	xchg   %ax,%ax

80106510 <sys_set_proc_level>:

int sys_set_proc_level(void){
80106510:	55                   	push   %ebp
80106511:	89 e5                	mov    %esp,%ebp
80106513:	83 ec 20             	sub    $0x20,%esp
    int pid, target_queue;
    if(argint(0, &pid)<0 || pid<0)
80106516:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106519:	50                   	push   %eax
8010651a:	6a 00                	push   $0x0
8010651c:	e8 bf ee ff ff       	call   801053e0 <argint>
80106521:	83 c4 10             	add    $0x10,%esp
80106524:	0b 45 f0             	or     -0x10(%ebp),%eax
80106527:	78 37                	js     80106560 <sys_set_proc_level+0x50>
        return -1;

    if(argint(1, &target_queue)<0 || target_queue<=0 || target_queue>3)
80106529:	83 ec 08             	sub    $0x8,%esp
8010652c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010652f:	50                   	push   %eax
80106530:	6a 01                	push   $0x1
80106532:	e8 a9 ee ff ff       	call   801053e0 <argint>
80106537:	83 c4 10             	add    $0x10,%esp
8010653a:	85 c0                	test   %eax,%eax
8010653c:	78 22                	js     80106560 <sys_set_proc_level+0x50>
8010653e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106541:	8d 50 ff             	lea    -0x1(%eax),%edx
80106544:	83 fa 02             	cmp    $0x2,%edx
80106547:	77 17                	ja     80106560 <sys_set_proc_level+0x50>
        return -1;

    set_proc_queue_level(pid, target_queue);
80106549:	83 ec 08             	sub    $0x8,%esp
8010654c:	50                   	push   %eax
8010654d:	ff 75 f0             	pushl  -0x10(%ebp)
80106550:	e8 cb e7 ff ff       	call   80104d20 <set_proc_queue_level>
    return 0;
80106555:	83 c4 10             	add    $0x10,%esp
80106558:	31 c0                	xor    %eax,%eax
8010655a:	c9                   	leave  
8010655b:	c3                   	ret    
8010655c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106560:	c9                   	leave  
        return -1;
80106561:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106566:	c3                   	ret    

80106567 <alltraps>:
80106567:	1e                   	push   %ds
80106568:	06                   	push   %es
80106569:	0f a0                	push   %fs
8010656b:	0f a8                	push   %gs
8010656d:	60                   	pusha  
8010656e:	66 b8 10 00          	mov    $0x10,%ax
80106572:	8e d8                	mov    %eax,%ds
80106574:	8e c0                	mov    %eax,%es
80106576:	54                   	push   %esp
80106577:	e8 c4 00 00 00       	call   80106640 <trap>
8010657c:	83 c4 04             	add    $0x4,%esp

8010657f <trapret>:
8010657f:	61                   	popa   
80106580:	0f a9                	pop    %gs
80106582:	0f a1                	pop    %fs
80106584:	07                   	pop    %es
80106585:	1f                   	pop    %ds
80106586:	83 c4 08             	add    $0x8,%esp
80106589:	cf                   	iret   
8010658a:	66 90                	xchg   %ax,%ax
8010658c:	66 90                	xchg   %ax,%ax
8010658e:	66 90                	xchg   %ax,%ax

80106590 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106590:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106591:	31 c0                	xor    %eax,%eax
{
80106593:	89 e5                	mov    %esp,%ebp
80106595:	83 ec 08             	sub    $0x8,%esp
80106598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010659f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801065a0:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
801065a7:	c7 04 c5 e2 53 11 80 	movl   $0x8e000008,-0x7feeac1e(,%eax,8)
801065ae:	08 00 00 8e 
801065b2:	66 89 14 c5 e0 53 11 	mov    %dx,-0x7feeac20(,%eax,8)
801065b9:	80 
801065ba:	c1 ea 10             	shr    $0x10,%edx
801065bd:	66 89 14 c5 e6 53 11 	mov    %dx,-0x7feeac1a(,%eax,8)
801065c4:	80 
  for(i = 0; i < 256; i++)
801065c5:	83 c0 01             	add    $0x1,%eax
801065c8:	3d 00 01 00 00       	cmp    $0x100,%eax
801065cd:	75 d1                	jne    801065a0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801065cf:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065d2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
801065d7:	c7 05 e2 55 11 80 08 	movl   $0xef000008,0x801155e2
801065de:	00 00 ef 
  initlock(&tickslock, "time");
801065e1:	68 19 87 10 80       	push   $0x80108719
801065e6:	68 a0 53 11 80       	push   $0x801153a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065eb:	66 a3 e0 55 11 80    	mov    %ax,0x801155e0
801065f1:	c1 e8 10             	shr    $0x10,%eax
801065f4:	66 a3 e6 55 11 80    	mov    %ax,0x801155e6
  initlock(&tickslock, "time");
801065fa:	e8 81 e8 ff ff       	call   80104e80 <initlock>
}
801065ff:	83 c4 10             	add    $0x10,%esp
80106602:	c9                   	leave  
80106603:	c3                   	ret    
80106604:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010660b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010660f:	90                   	nop

80106610 <idtinit>:

void
idtinit(void)
{
80106610:	55                   	push   %ebp
  pd[0] = size-1;
80106611:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106616:	89 e5                	mov    %esp,%ebp
80106618:	83 ec 10             	sub    $0x10,%esp
8010661b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010661f:	b8 e0 53 11 80       	mov    $0x801153e0,%eax
80106624:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106628:	c1 e8 10             	shr    $0x10,%eax
8010662b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010662f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106632:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106635:	c9                   	leave  
80106636:	c3                   	ret    
80106637:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010663e:	66 90                	xchg   %ax,%ax

80106640 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106640:	55                   	push   %ebp
80106641:	89 e5                	mov    %esp,%ebp
80106643:	57                   	push   %edi
80106644:	56                   	push   %esi
80106645:	53                   	push   %ebx
80106646:	83 ec 1c             	sub    $0x1c,%esp
80106649:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010664c:	8b 43 30             	mov    0x30(%ebx),%eax
8010664f:	83 f8 40             	cmp    $0x40,%eax
80106652:	0f 84 68 01 00 00    	je     801067c0 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106658:	83 e8 20             	sub    $0x20,%eax
8010665b:	83 f8 1f             	cmp    $0x1f,%eax
8010665e:	0f 87 8c 00 00 00    	ja     801066f0 <trap+0xb0>
80106664:	ff 24 85 c0 87 10 80 	jmp    *-0x7fef7840(,%eax,4)
8010666b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010666f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106670:	e8 9b c0 ff ff       	call   80102710 <ideintr>
    lapiceoi();
80106675:	e8 66 c7 ff ff       	call   80102de0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010667a:	e8 11 d8 ff ff       	call   80103e90 <myproc>
8010667f:	85 c0                	test   %eax,%eax
80106681:	74 1d                	je     801066a0 <trap+0x60>
80106683:	e8 08 d8 ff ff       	call   80103e90 <myproc>
80106688:	8b 50 28             	mov    0x28(%eax),%edx
8010668b:	85 d2                	test   %edx,%edx
8010668d:	74 11                	je     801066a0 <trap+0x60>
8010668f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106693:	83 e0 03             	and    $0x3,%eax
80106696:	66 83 f8 03          	cmp    $0x3,%ax
8010669a:	0f 84 e8 01 00 00    	je     80106888 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801066a0:	e8 eb d7 ff ff       	call   80103e90 <myproc>
801066a5:	85 c0                	test   %eax,%eax
801066a7:	74 0f                	je     801066b8 <trap+0x78>
801066a9:	e8 e2 d7 ff ff       	call   80103e90 <myproc>
801066ae:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801066b2:	0f 84 b8 00 00 00    	je     80106770 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801066b8:	e8 d3 d7 ff ff       	call   80103e90 <myproc>
801066bd:	85 c0                	test   %eax,%eax
801066bf:	74 1d                	je     801066de <trap+0x9e>
801066c1:	e8 ca d7 ff ff       	call   80103e90 <myproc>
801066c6:	8b 40 28             	mov    0x28(%eax),%eax
801066c9:	85 c0                	test   %eax,%eax
801066cb:	74 11                	je     801066de <trap+0x9e>
801066cd:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801066d1:	83 e0 03             	and    $0x3,%eax
801066d4:	66 83 f8 03          	cmp    $0x3,%ax
801066d8:	0f 84 0f 01 00 00    	je     801067ed <trap+0x1ad>
    exit();
}
801066de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066e1:	5b                   	pop    %ebx
801066e2:	5e                   	pop    %esi
801066e3:	5f                   	pop    %edi
801066e4:	5d                   	pop    %ebp
801066e5:	c3                   	ret    
801066e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066ed:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801066f0:	e8 9b d7 ff ff       	call   80103e90 <myproc>
801066f5:	8b 7b 38             	mov    0x38(%ebx),%edi
801066f8:	85 c0                	test   %eax,%eax
801066fa:	0f 84 a2 01 00 00    	je     801068a2 <trap+0x262>
80106700:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106704:	0f 84 98 01 00 00    	je     801068a2 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
8010670a:	0f 20 d1             	mov    %cr2,%ecx
8010670d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106710:	e8 5b d7 ff ff       	call   80103e70 <cpuid>
80106715:	8b 73 30             	mov    0x30(%ebx),%esi
80106718:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010671b:	8b 43 34             	mov    0x34(%ebx),%eax
8010671e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106721:	e8 6a d7 ff ff       	call   80103e90 <myproc>
80106726:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106729:	e8 62 d7 ff ff       	call   80103e90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010672e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106731:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106734:	51                   	push   %ecx
80106735:	57                   	push   %edi
80106736:	52                   	push   %edx
80106737:	ff 75 e4             	pushl  -0x1c(%ebp)
8010673a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010673b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010673e:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106741:	56                   	push   %esi
80106742:	ff 70 10             	pushl  0x10(%eax)
80106745:	68 7c 87 10 80       	push   $0x8010877c
8010674a:	e8 51 9f ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
8010674f:	83 c4 20             	add    $0x20,%esp
80106752:	e8 39 d7 ff ff       	call   80103e90 <myproc>
80106757:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010675e:	e8 2d d7 ff ff       	call   80103e90 <myproc>
80106763:	85 c0                	test   %eax,%eax
80106765:	0f 85 18 ff ff ff    	jne    80106683 <trap+0x43>
8010676b:	e9 30 ff ff ff       	jmp    801066a0 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106770:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106774:	0f 85 3e ff ff ff    	jne    801066b8 <trap+0x78>
    yield();
8010677a:	e8 a1 e0 ff ff       	call   80104820 <yield>
8010677f:	e9 34 ff ff ff       	jmp    801066b8 <trap+0x78>
80106784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106788:	8b 7b 38             	mov    0x38(%ebx),%edi
8010678b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010678f:	e8 dc d6 ff ff       	call   80103e70 <cpuid>
80106794:	57                   	push   %edi
80106795:	56                   	push   %esi
80106796:	50                   	push   %eax
80106797:	68 24 87 10 80       	push   $0x80108724
8010679c:	e8 ff 9e ff ff       	call   801006a0 <cprintf>
    lapiceoi();
801067a1:	e8 3a c6 ff ff       	call   80102de0 <lapiceoi>
    break;
801067a6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067a9:	e8 e2 d6 ff ff       	call   80103e90 <myproc>
801067ae:	85 c0                	test   %eax,%eax
801067b0:	0f 85 cd fe ff ff    	jne    80106683 <trap+0x43>
801067b6:	e9 e5 fe ff ff       	jmp    801066a0 <trap+0x60>
801067bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801067bf:	90                   	nop
    if(myproc()->killed)
801067c0:	e8 cb d6 ff ff       	call   80103e90 <myproc>
801067c5:	8b 70 28             	mov    0x28(%eax),%esi
801067c8:	85 f6                	test   %esi,%esi
801067ca:	0f 85 c8 00 00 00    	jne    80106898 <trap+0x258>
    myproc()->tf = tf;
801067d0:	e8 bb d6 ff ff       	call   80103e90 <myproc>
801067d5:	89 58 1c             	mov    %ebx,0x1c(%eax)
    syscall();
801067d8:	e8 43 ed ff ff       	call   80105520 <syscall>
    if(myproc()->killed)
801067dd:	e8 ae d6 ff ff       	call   80103e90 <myproc>
801067e2:	8b 48 28             	mov    0x28(%eax),%ecx
801067e5:	85 c9                	test   %ecx,%ecx
801067e7:	0f 84 f1 fe ff ff    	je     801066de <trap+0x9e>
}
801067ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067f0:	5b                   	pop    %ebx
801067f1:	5e                   	pop    %esi
801067f2:	5f                   	pop    %edi
801067f3:	5d                   	pop    %ebp
      exit();
801067f4:	e9 c7 dd ff ff       	jmp    801045c0 <exit>
801067f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106800:	e8 5b 02 00 00       	call   80106a60 <uartintr>
    lapiceoi();
80106805:	e8 d6 c5 ff ff       	call   80102de0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010680a:	e8 81 d6 ff ff       	call   80103e90 <myproc>
8010680f:	85 c0                	test   %eax,%eax
80106811:	0f 85 6c fe ff ff    	jne    80106683 <trap+0x43>
80106817:	e9 84 fe ff ff       	jmp    801066a0 <trap+0x60>
8010681c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106820:	e8 7b c4 ff ff       	call   80102ca0 <kbdintr>
    lapiceoi();
80106825:	e8 b6 c5 ff ff       	call   80102de0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010682a:	e8 61 d6 ff ff       	call   80103e90 <myproc>
8010682f:	85 c0                	test   %eax,%eax
80106831:	0f 85 4c fe ff ff    	jne    80106683 <trap+0x43>
80106837:	e9 64 fe ff ff       	jmp    801066a0 <trap+0x60>
8010683c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106840:	e8 2b d6 ff ff       	call   80103e70 <cpuid>
80106845:	85 c0                	test   %eax,%eax
80106847:	0f 85 28 fe ff ff    	jne    80106675 <trap+0x35>
      acquire(&tickslock);
8010684d:	83 ec 0c             	sub    $0xc,%esp
80106850:	68 a0 53 11 80       	push   $0x801153a0
80106855:	e8 f6 e7 ff ff       	call   80105050 <acquire>
      wakeup(&ticks);
8010685a:	c7 04 24 80 53 11 80 	movl   $0x80115380,(%esp)
      ticks++;
80106861:	83 05 80 53 11 80 01 	addl   $0x1,0x80115380
      wakeup(&ticks);
80106868:	e8 33 e1 ff ff       	call   801049a0 <wakeup>
      release(&tickslock);
8010686d:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
80106874:	e8 77 e7 ff ff       	call   80104ff0 <release>
80106879:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010687c:	e9 f4 fd ff ff       	jmp    80106675 <trap+0x35>
80106881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106888:	e8 33 dd ff ff       	call   801045c0 <exit>
8010688d:	e9 0e fe ff ff       	jmp    801066a0 <trap+0x60>
80106892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106898:	e8 23 dd ff ff       	call   801045c0 <exit>
8010689d:	e9 2e ff ff ff       	jmp    801067d0 <trap+0x190>
801068a2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801068a5:	e8 c6 d5 ff ff       	call   80103e70 <cpuid>
801068aa:	83 ec 0c             	sub    $0xc,%esp
801068ad:	56                   	push   %esi
801068ae:	57                   	push   %edi
801068af:	50                   	push   %eax
801068b0:	ff 73 30             	pushl  0x30(%ebx)
801068b3:	68 48 87 10 80       	push   $0x80108748
801068b8:	e8 e3 9d ff ff       	call   801006a0 <cprintf>
      panic("trap");
801068bd:	83 c4 14             	add    $0x14,%esp
801068c0:	68 1e 87 10 80       	push   $0x8010871e
801068c5:	e8 b6 9a ff ff       	call   80100380 <panic>
801068ca:	66 90                	xchg   %ax,%ax
801068cc:	66 90                	xchg   %ax,%ax
801068ce:	66 90                	xchg   %ax,%ax

801068d0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801068d0:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
801068d5:	85 c0                	test   %eax,%eax
801068d7:	74 17                	je     801068f0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068d9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068de:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801068df:	a8 01                	test   $0x1,%al
801068e1:	74 0d                	je     801068f0 <uartgetc+0x20>
801068e3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068e8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801068e9:	0f b6 c0             	movzbl %al,%eax
801068ec:	c3                   	ret    
801068ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801068f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068f5:	c3                   	ret    
801068f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068fd:	8d 76 00             	lea    0x0(%esi),%esi

80106900 <uartinit>:
{
80106900:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106901:	31 c9                	xor    %ecx,%ecx
80106903:	89 c8                	mov    %ecx,%eax
80106905:	89 e5                	mov    %esp,%ebp
80106907:	57                   	push   %edi
80106908:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010690d:	56                   	push   %esi
8010690e:	89 fa                	mov    %edi,%edx
80106910:	53                   	push   %ebx
80106911:	83 ec 1c             	sub    $0x1c,%esp
80106914:	ee                   	out    %al,(%dx)
80106915:	be fb 03 00 00       	mov    $0x3fb,%esi
8010691a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010691f:	89 f2                	mov    %esi,%edx
80106921:	ee                   	out    %al,(%dx)
80106922:	b8 0c 00 00 00       	mov    $0xc,%eax
80106927:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010692c:	ee                   	out    %al,(%dx)
8010692d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106932:	89 c8                	mov    %ecx,%eax
80106934:	89 da                	mov    %ebx,%edx
80106936:	ee                   	out    %al,(%dx)
80106937:	b8 03 00 00 00       	mov    $0x3,%eax
8010693c:	89 f2                	mov    %esi,%edx
8010693e:	ee                   	out    %al,(%dx)
8010693f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106944:	89 c8                	mov    %ecx,%eax
80106946:	ee                   	out    %al,(%dx)
80106947:	b8 01 00 00 00       	mov    $0x1,%eax
8010694c:	89 da                	mov    %ebx,%edx
8010694e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010694f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106954:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106955:	3c ff                	cmp    $0xff,%al
80106957:	0f 84 93 00 00 00    	je     801069f0 <uartinit+0xf0>
  uart = 1;
8010695d:	c7 05 e0 5b 11 80 01 	movl   $0x1,0x80115be0
80106964:	00 00 00 
80106967:	89 fa                	mov    %edi,%edx
80106969:	ec                   	in     (%dx),%al
8010696a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010696f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106970:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106973:	bf 40 88 10 80       	mov    $0x80108840,%edi
80106978:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010697d:	6a 00                	push   $0x0
8010697f:	6a 04                	push   $0x4
80106981:	e8 ca bf ff ff       	call   80102950 <ioapicenable>
80106986:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
8010698a:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
8010698d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
80106991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106998:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
8010699d:	bb 80 00 00 00       	mov    $0x80,%ebx
801069a2:	85 c0                	test   %eax,%eax
801069a4:	75 1c                	jne    801069c2 <uartinit+0xc2>
801069a6:	eb 2b                	jmp    801069d3 <uartinit+0xd3>
801069a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069af:	90                   	nop
    microdelay(10);
801069b0:	83 ec 0c             	sub    $0xc,%esp
801069b3:	6a 0a                	push   $0xa
801069b5:	e8 46 c4 ff ff       	call   80102e00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069ba:	83 c4 10             	add    $0x10,%esp
801069bd:	83 eb 01             	sub    $0x1,%ebx
801069c0:	74 07                	je     801069c9 <uartinit+0xc9>
801069c2:	89 f2                	mov    %esi,%edx
801069c4:	ec                   	in     (%dx),%al
801069c5:	a8 20                	test   $0x20,%al
801069c7:	74 e7                	je     801069b0 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801069c9:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
801069cd:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069d2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801069d3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801069d7:	83 c7 01             	add    $0x1,%edi
801069da:	84 c0                	test   %al,%al
801069dc:	74 12                	je     801069f0 <uartinit+0xf0>
801069de:	88 45 e6             	mov    %al,-0x1a(%ebp)
801069e1:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801069e5:	88 45 e7             	mov    %al,-0x19(%ebp)
801069e8:	eb ae                	jmp    80106998 <uartinit+0x98>
801069ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
801069f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069f3:	5b                   	pop    %ebx
801069f4:	5e                   	pop    %esi
801069f5:	5f                   	pop    %edi
801069f6:	5d                   	pop    %ebp
801069f7:	c3                   	ret    
801069f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069ff:	90                   	nop

80106a00 <uartputc>:
  if(!uart)
80106a00:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
80106a05:	85 c0                	test   %eax,%eax
80106a07:	74 47                	je     80106a50 <uartputc+0x50>
{
80106a09:	55                   	push   %ebp
80106a0a:	89 e5                	mov    %esp,%ebp
80106a0c:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a0d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106a12:	53                   	push   %ebx
80106a13:	bb 80 00 00 00       	mov    $0x80,%ebx
80106a18:	eb 18                	jmp    80106a32 <uartputc+0x32>
80106a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80106a20:	83 ec 0c             	sub    $0xc,%esp
80106a23:	6a 0a                	push   $0xa
80106a25:	e8 d6 c3 ff ff       	call   80102e00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80106a2a:	83 c4 10             	add    $0x10,%esp
80106a2d:	83 eb 01             	sub    $0x1,%ebx
80106a30:	74 07                	je     80106a39 <uartputc+0x39>
80106a32:	89 f2                	mov    %esi,%edx
80106a34:	ec                   	in     (%dx),%al
80106a35:	a8 20                	test   $0x20,%al
80106a37:	74 e7                	je     80106a20 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a39:	8b 45 08             	mov    0x8(%ebp),%eax
80106a3c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a41:	ee                   	out    %al,(%dx)
}
80106a42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106a45:	5b                   	pop    %ebx
80106a46:	5e                   	pop    %esi
80106a47:	5d                   	pop    %ebp
80106a48:	c3                   	ret    
80106a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a50:	c3                   	ret    
80106a51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a58:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a5f:	90                   	nop

80106a60 <uartintr>:

void
uartintr(void)
{
80106a60:	55                   	push   %ebp
80106a61:	89 e5                	mov    %esp,%ebp
80106a63:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106a66:	68 d0 68 10 80       	push   $0x801068d0
80106a6b:	e8 00 a1 ff ff       	call   80100b70 <consoleintr>
}
80106a70:	83 c4 10             	add    $0x10,%esp
80106a73:	c9                   	leave  
80106a74:	c3                   	ret    

80106a75 <vector0>:
80106a75:	6a 00                	push   $0x0
80106a77:	6a 00                	push   $0x0
80106a79:	e9 e9 fa ff ff       	jmp    80106567 <alltraps>

80106a7e <vector1>:
80106a7e:	6a 00                	push   $0x0
80106a80:	6a 01                	push   $0x1
80106a82:	e9 e0 fa ff ff       	jmp    80106567 <alltraps>

80106a87 <vector2>:
80106a87:	6a 00                	push   $0x0
80106a89:	6a 02                	push   $0x2
80106a8b:	e9 d7 fa ff ff       	jmp    80106567 <alltraps>

80106a90 <vector3>:
80106a90:	6a 00                	push   $0x0
80106a92:	6a 03                	push   $0x3
80106a94:	e9 ce fa ff ff       	jmp    80106567 <alltraps>

80106a99 <vector4>:
80106a99:	6a 00                	push   $0x0
80106a9b:	6a 04                	push   $0x4
80106a9d:	e9 c5 fa ff ff       	jmp    80106567 <alltraps>

80106aa2 <vector5>:
80106aa2:	6a 00                	push   $0x0
80106aa4:	6a 05                	push   $0x5
80106aa6:	e9 bc fa ff ff       	jmp    80106567 <alltraps>

80106aab <vector6>:
80106aab:	6a 00                	push   $0x0
80106aad:	6a 06                	push   $0x6
80106aaf:	e9 b3 fa ff ff       	jmp    80106567 <alltraps>

80106ab4 <vector7>:
80106ab4:	6a 00                	push   $0x0
80106ab6:	6a 07                	push   $0x7
80106ab8:	e9 aa fa ff ff       	jmp    80106567 <alltraps>

80106abd <vector8>:
80106abd:	6a 08                	push   $0x8
80106abf:	e9 a3 fa ff ff       	jmp    80106567 <alltraps>

80106ac4 <vector9>:
80106ac4:	6a 00                	push   $0x0
80106ac6:	6a 09                	push   $0x9
80106ac8:	e9 9a fa ff ff       	jmp    80106567 <alltraps>

80106acd <vector10>:
80106acd:	6a 0a                	push   $0xa
80106acf:	e9 93 fa ff ff       	jmp    80106567 <alltraps>

80106ad4 <vector11>:
80106ad4:	6a 0b                	push   $0xb
80106ad6:	e9 8c fa ff ff       	jmp    80106567 <alltraps>

80106adb <vector12>:
80106adb:	6a 0c                	push   $0xc
80106add:	e9 85 fa ff ff       	jmp    80106567 <alltraps>

80106ae2 <vector13>:
80106ae2:	6a 0d                	push   $0xd
80106ae4:	e9 7e fa ff ff       	jmp    80106567 <alltraps>

80106ae9 <vector14>:
80106ae9:	6a 0e                	push   $0xe
80106aeb:	e9 77 fa ff ff       	jmp    80106567 <alltraps>

80106af0 <vector15>:
80106af0:	6a 00                	push   $0x0
80106af2:	6a 0f                	push   $0xf
80106af4:	e9 6e fa ff ff       	jmp    80106567 <alltraps>

80106af9 <vector16>:
80106af9:	6a 00                	push   $0x0
80106afb:	6a 10                	push   $0x10
80106afd:	e9 65 fa ff ff       	jmp    80106567 <alltraps>

80106b02 <vector17>:
80106b02:	6a 11                	push   $0x11
80106b04:	e9 5e fa ff ff       	jmp    80106567 <alltraps>

80106b09 <vector18>:
80106b09:	6a 00                	push   $0x0
80106b0b:	6a 12                	push   $0x12
80106b0d:	e9 55 fa ff ff       	jmp    80106567 <alltraps>

80106b12 <vector19>:
80106b12:	6a 00                	push   $0x0
80106b14:	6a 13                	push   $0x13
80106b16:	e9 4c fa ff ff       	jmp    80106567 <alltraps>

80106b1b <vector20>:
80106b1b:	6a 00                	push   $0x0
80106b1d:	6a 14                	push   $0x14
80106b1f:	e9 43 fa ff ff       	jmp    80106567 <alltraps>

80106b24 <vector21>:
80106b24:	6a 00                	push   $0x0
80106b26:	6a 15                	push   $0x15
80106b28:	e9 3a fa ff ff       	jmp    80106567 <alltraps>

80106b2d <vector22>:
80106b2d:	6a 00                	push   $0x0
80106b2f:	6a 16                	push   $0x16
80106b31:	e9 31 fa ff ff       	jmp    80106567 <alltraps>

80106b36 <vector23>:
80106b36:	6a 00                	push   $0x0
80106b38:	6a 17                	push   $0x17
80106b3a:	e9 28 fa ff ff       	jmp    80106567 <alltraps>

80106b3f <vector24>:
80106b3f:	6a 00                	push   $0x0
80106b41:	6a 18                	push   $0x18
80106b43:	e9 1f fa ff ff       	jmp    80106567 <alltraps>

80106b48 <vector25>:
80106b48:	6a 00                	push   $0x0
80106b4a:	6a 19                	push   $0x19
80106b4c:	e9 16 fa ff ff       	jmp    80106567 <alltraps>

80106b51 <vector26>:
80106b51:	6a 00                	push   $0x0
80106b53:	6a 1a                	push   $0x1a
80106b55:	e9 0d fa ff ff       	jmp    80106567 <alltraps>

80106b5a <vector27>:
80106b5a:	6a 00                	push   $0x0
80106b5c:	6a 1b                	push   $0x1b
80106b5e:	e9 04 fa ff ff       	jmp    80106567 <alltraps>

80106b63 <vector28>:
80106b63:	6a 00                	push   $0x0
80106b65:	6a 1c                	push   $0x1c
80106b67:	e9 fb f9 ff ff       	jmp    80106567 <alltraps>

80106b6c <vector29>:
80106b6c:	6a 00                	push   $0x0
80106b6e:	6a 1d                	push   $0x1d
80106b70:	e9 f2 f9 ff ff       	jmp    80106567 <alltraps>

80106b75 <vector30>:
80106b75:	6a 00                	push   $0x0
80106b77:	6a 1e                	push   $0x1e
80106b79:	e9 e9 f9 ff ff       	jmp    80106567 <alltraps>

80106b7e <vector31>:
80106b7e:	6a 00                	push   $0x0
80106b80:	6a 1f                	push   $0x1f
80106b82:	e9 e0 f9 ff ff       	jmp    80106567 <alltraps>

80106b87 <vector32>:
80106b87:	6a 00                	push   $0x0
80106b89:	6a 20                	push   $0x20
80106b8b:	e9 d7 f9 ff ff       	jmp    80106567 <alltraps>

80106b90 <vector33>:
80106b90:	6a 00                	push   $0x0
80106b92:	6a 21                	push   $0x21
80106b94:	e9 ce f9 ff ff       	jmp    80106567 <alltraps>

80106b99 <vector34>:
80106b99:	6a 00                	push   $0x0
80106b9b:	6a 22                	push   $0x22
80106b9d:	e9 c5 f9 ff ff       	jmp    80106567 <alltraps>

80106ba2 <vector35>:
80106ba2:	6a 00                	push   $0x0
80106ba4:	6a 23                	push   $0x23
80106ba6:	e9 bc f9 ff ff       	jmp    80106567 <alltraps>

80106bab <vector36>:
80106bab:	6a 00                	push   $0x0
80106bad:	6a 24                	push   $0x24
80106baf:	e9 b3 f9 ff ff       	jmp    80106567 <alltraps>

80106bb4 <vector37>:
80106bb4:	6a 00                	push   $0x0
80106bb6:	6a 25                	push   $0x25
80106bb8:	e9 aa f9 ff ff       	jmp    80106567 <alltraps>

80106bbd <vector38>:
80106bbd:	6a 00                	push   $0x0
80106bbf:	6a 26                	push   $0x26
80106bc1:	e9 a1 f9 ff ff       	jmp    80106567 <alltraps>

80106bc6 <vector39>:
80106bc6:	6a 00                	push   $0x0
80106bc8:	6a 27                	push   $0x27
80106bca:	e9 98 f9 ff ff       	jmp    80106567 <alltraps>

80106bcf <vector40>:
80106bcf:	6a 00                	push   $0x0
80106bd1:	6a 28                	push   $0x28
80106bd3:	e9 8f f9 ff ff       	jmp    80106567 <alltraps>

80106bd8 <vector41>:
80106bd8:	6a 00                	push   $0x0
80106bda:	6a 29                	push   $0x29
80106bdc:	e9 86 f9 ff ff       	jmp    80106567 <alltraps>

80106be1 <vector42>:
80106be1:	6a 00                	push   $0x0
80106be3:	6a 2a                	push   $0x2a
80106be5:	e9 7d f9 ff ff       	jmp    80106567 <alltraps>

80106bea <vector43>:
80106bea:	6a 00                	push   $0x0
80106bec:	6a 2b                	push   $0x2b
80106bee:	e9 74 f9 ff ff       	jmp    80106567 <alltraps>

80106bf3 <vector44>:
80106bf3:	6a 00                	push   $0x0
80106bf5:	6a 2c                	push   $0x2c
80106bf7:	e9 6b f9 ff ff       	jmp    80106567 <alltraps>

80106bfc <vector45>:
80106bfc:	6a 00                	push   $0x0
80106bfe:	6a 2d                	push   $0x2d
80106c00:	e9 62 f9 ff ff       	jmp    80106567 <alltraps>

80106c05 <vector46>:
80106c05:	6a 00                	push   $0x0
80106c07:	6a 2e                	push   $0x2e
80106c09:	e9 59 f9 ff ff       	jmp    80106567 <alltraps>

80106c0e <vector47>:
80106c0e:	6a 00                	push   $0x0
80106c10:	6a 2f                	push   $0x2f
80106c12:	e9 50 f9 ff ff       	jmp    80106567 <alltraps>

80106c17 <vector48>:
80106c17:	6a 00                	push   $0x0
80106c19:	6a 30                	push   $0x30
80106c1b:	e9 47 f9 ff ff       	jmp    80106567 <alltraps>

80106c20 <vector49>:
80106c20:	6a 00                	push   $0x0
80106c22:	6a 31                	push   $0x31
80106c24:	e9 3e f9 ff ff       	jmp    80106567 <alltraps>

80106c29 <vector50>:
80106c29:	6a 00                	push   $0x0
80106c2b:	6a 32                	push   $0x32
80106c2d:	e9 35 f9 ff ff       	jmp    80106567 <alltraps>

80106c32 <vector51>:
80106c32:	6a 00                	push   $0x0
80106c34:	6a 33                	push   $0x33
80106c36:	e9 2c f9 ff ff       	jmp    80106567 <alltraps>

80106c3b <vector52>:
80106c3b:	6a 00                	push   $0x0
80106c3d:	6a 34                	push   $0x34
80106c3f:	e9 23 f9 ff ff       	jmp    80106567 <alltraps>

80106c44 <vector53>:
80106c44:	6a 00                	push   $0x0
80106c46:	6a 35                	push   $0x35
80106c48:	e9 1a f9 ff ff       	jmp    80106567 <alltraps>

80106c4d <vector54>:
80106c4d:	6a 00                	push   $0x0
80106c4f:	6a 36                	push   $0x36
80106c51:	e9 11 f9 ff ff       	jmp    80106567 <alltraps>

80106c56 <vector55>:
80106c56:	6a 00                	push   $0x0
80106c58:	6a 37                	push   $0x37
80106c5a:	e9 08 f9 ff ff       	jmp    80106567 <alltraps>

80106c5f <vector56>:
80106c5f:	6a 00                	push   $0x0
80106c61:	6a 38                	push   $0x38
80106c63:	e9 ff f8 ff ff       	jmp    80106567 <alltraps>

80106c68 <vector57>:
80106c68:	6a 00                	push   $0x0
80106c6a:	6a 39                	push   $0x39
80106c6c:	e9 f6 f8 ff ff       	jmp    80106567 <alltraps>

80106c71 <vector58>:
80106c71:	6a 00                	push   $0x0
80106c73:	6a 3a                	push   $0x3a
80106c75:	e9 ed f8 ff ff       	jmp    80106567 <alltraps>

80106c7a <vector59>:
80106c7a:	6a 00                	push   $0x0
80106c7c:	6a 3b                	push   $0x3b
80106c7e:	e9 e4 f8 ff ff       	jmp    80106567 <alltraps>

80106c83 <vector60>:
80106c83:	6a 00                	push   $0x0
80106c85:	6a 3c                	push   $0x3c
80106c87:	e9 db f8 ff ff       	jmp    80106567 <alltraps>

80106c8c <vector61>:
80106c8c:	6a 00                	push   $0x0
80106c8e:	6a 3d                	push   $0x3d
80106c90:	e9 d2 f8 ff ff       	jmp    80106567 <alltraps>

80106c95 <vector62>:
80106c95:	6a 00                	push   $0x0
80106c97:	6a 3e                	push   $0x3e
80106c99:	e9 c9 f8 ff ff       	jmp    80106567 <alltraps>

80106c9e <vector63>:
80106c9e:	6a 00                	push   $0x0
80106ca0:	6a 3f                	push   $0x3f
80106ca2:	e9 c0 f8 ff ff       	jmp    80106567 <alltraps>

80106ca7 <vector64>:
80106ca7:	6a 00                	push   $0x0
80106ca9:	6a 40                	push   $0x40
80106cab:	e9 b7 f8 ff ff       	jmp    80106567 <alltraps>

80106cb0 <vector65>:
80106cb0:	6a 00                	push   $0x0
80106cb2:	6a 41                	push   $0x41
80106cb4:	e9 ae f8 ff ff       	jmp    80106567 <alltraps>

80106cb9 <vector66>:
80106cb9:	6a 00                	push   $0x0
80106cbb:	6a 42                	push   $0x42
80106cbd:	e9 a5 f8 ff ff       	jmp    80106567 <alltraps>

80106cc2 <vector67>:
80106cc2:	6a 00                	push   $0x0
80106cc4:	6a 43                	push   $0x43
80106cc6:	e9 9c f8 ff ff       	jmp    80106567 <alltraps>

80106ccb <vector68>:
80106ccb:	6a 00                	push   $0x0
80106ccd:	6a 44                	push   $0x44
80106ccf:	e9 93 f8 ff ff       	jmp    80106567 <alltraps>

80106cd4 <vector69>:
80106cd4:	6a 00                	push   $0x0
80106cd6:	6a 45                	push   $0x45
80106cd8:	e9 8a f8 ff ff       	jmp    80106567 <alltraps>

80106cdd <vector70>:
80106cdd:	6a 00                	push   $0x0
80106cdf:	6a 46                	push   $0x46
80106ce1:	e9 81 f8 ff ff       	jmp    80106567 <alltraps>

80106ce6 <vector71>:
80106ce6:	6a 00                	push   $0x0
80106ce8:	6a 47                	push   $0x47
80106cea:	e9 78 f8 ff ff       	jmp    80106567 <alltraps>

80106cef <vector72>:
80106cef:	6a 00                	push   $0x0
80106cf1:	6a 48                	push   $0x48
80106cf3:	e9 6f f8 ff ff       	jmp    80106567 <alltraps>

80106cf8 <vector73>:
80106cf8:	6a 00                	push   $0x0
80106cfa:	6a 49                	push   $0x49
80106cfc:	e9 66 f8 ff ff       	jmp    80106567 <alltraps>

80106d01 <vector74>:
80106d01:	6a 00                	push   $0x0
80106d03:	6a 4a                	push   $0x4a
80106d05:	e9 5d f8 ff ff       	jmp    80106567 <alltraps>

80106d0a <vector75>:
80106d0a:	6a 00                	push   $0x0
80106d0c:	6a 4b                	push   $0x4b
80106d0e:	e9 54 f8 ff ff       	jmp    80106567 <alltraps>

80106d13 <vector76>:
80106d13:	6a 00                	push   $0x0
80106d15:	6a 4c                	push   $0x4c
80106d17:	e9 4b f8 ff ff       	jmp    80106567 <alltraps>

80106d1c <vector77>:
80106d1c:	6a 00                	push   $0x0
80106d1e:	6a 4d                	push   $0x4d
80106d20:	e9 42 f8 ff ff       	jmp    80106567 <alltraps>

80106d25 <vector78>:
80106d25:	6a 00                	push   $0x0
80106d27:	6a 4e                	push   $0x4e
80106d29:	e9 39 f8 ff ff       	jmp    80106567 <alltraps>

80106d2e <vector79>:
80106d2e:	6a 00                	push   $0x0
80106d30:	6a 4f                	push   $0x4f
80106d32:	e9 30 f8 ff ff       	jmp    80106567 <alltraps>

80106d37 <vector80>:
80106d37:	6a 00                	push   $0x0
80106d39:	6a 50                	push   $0x50
80106d3b:	e9 27 f8 ff ff       	jmp    80106567 <alltraps>

80106d40 <vector81>:
80106d40:	6a 00                	push   $0x0
80106d42:	6a 51                	push   $0x51
80106d44:	e9 1e f8 ff ff       	jmp    80106567 <alltraps>

80106d49 <vector82>:
80106d49:	6a 00                	push   $0x0
80106d4b:	6a 52                	push   $0x52
80106d4d:	e9 15 f8 ff ff       	jmp    80106567 <alltraps>

80106d52 <vector83>:
80106d52:	6a 00                	push   $0x0
80106d54:	6a 53                	push   $0x53
80106d56:	e9 0c f8 ff ff       	jmp    80106567 <alltraps>

80106d5b <vector84>:
80106d5b:	6a 00                	push   $0x0
80106d5d:	6a 54                	push   $0x54
80106d5f:	e9 03 f8 ff ff       	jmp    80106567 <alltraps>

80106d64 <vector85>:
80106d64:	6a 00                	push   $0x0
80106d66:	6a 55                	push   $0x55
80106d68:	e9 fa f7 ff ff       	jmp    80106567 <alltraps>

80106d6d <vector86>:
80106d6d:	6a 00                	push   $0x0
80106d6f:	6a 56                	push   $0x56
80106d71:	e9 f1 f7 ff ff       	jmp    80106567 <alltraps>

80106d76 <vector87>:
80106d76:	6a 00                	push   $0x0
80106d78:	6a 57                	push   $0x57
80106d7a:	e9 e8 f7 ff ff       	jmp    80106567 <alltraps>

80106d7f <vector88>:
80106d7f:	6a 00                	push   $0x0
80106d81:	6a 58                	push   $0x58
80106d83:	e9 df f7 ff ff       	jmp    80106567 <alltraps>

80106d88 <vector89>:
80106d88:	6a 00                	push   $0x0
80106d8a:	6a 59                	push   $0x59
80106d8c:	e9 d6 f7 ff ff       	jmp    80106567 <alltraps>

80106d91 <vector90>:
80106d91:	6a 00                	push   $0x0
80106d93:	6a 5a                	push   $0x5a
80106d95:	e9 cd f7 ff ff       	jmp    80106567 <alltraps>

80106d9a <vector91>:
80106d9a:	6a 00                	push   $0x0
80106d9c:	6a 5b                	push   $0x5b
80106d9e:	e9 c4 f7 ff ff       	jmp    80106567 <alltraps>

80106da3 <vector92>:
80106da3:	6a 00                	push   $0x0
80106da5:	6a 5c                	push   $0x5c
80106da7:	e9 bb f7 ff ff       	jmp    80106567 <alltraps>

80106dac <vector93>:
80106dac:	6a 00                	push   $0x0
80106dae:	6a 5d                	push   $0x5d
80106db0:	e9 b2 f7 ff ff       	jmp    80106567 <alltraps>

80106db5 <vector94>:
80106db5:	6a 00                	push   $0x0
80106db7:	6a 5e                	push   $0x5e
80106db9:	e9 a9 f7 ff ff       	jmp    80106567 <alltraps>

80106dbe <vector95>:
80106dbe:	6a 00                	push   $0x0
80106dc0:	6a 5f                	push   $0x5f
80106dc2:	e9 a0 f7 ff ff       	jmp    80106567 <alltraps>

80106dc7 <vector96>:
80106dc7:	6a 00                	push   $0x0
80106dc9:	6a 60                	push   $0x60
80106dcb:	e9 97 f7 ff ff       	jmp    80106567 <alltraps>

80106dd0 <vector97>:
80106dd0:	6a 00                	push   $0x0
80106dd2:	6a 61                	push   $0x61
80106dd4:	e9 8e f7 ff ff       	jmp    80106567 <alltraps>

80106dd9 <vector98>:
80106dd9:	6a 00                	push   $0x0
80106ddb:	6a 62                	push   $0x62
80106ddd:	e9 85 f7 ff ff       	jmp    80106567 <alltraps>

80106de2 <vector99>:
80106de2:	6a 00                	push   $0x0
80106de4:	6a 63                	push   $0x63
80106de6:	e9 7c f7 ff ff       	jmp    80106567 <alltraps>

80106deb <vector100>:
80106deb:	6a 00                	push   $0x0
80106ded:	6a 64                	push   $0x64
80106def:	e9 73 f7 ff ff       	jmp    80106567 <alltraps>

80106df4 <vector101>:
80106df4:	6a 00                	push   $0x0
80106df6:	6a 65                	push   $0x65
80106df8:	e9 6a f7 ff ff       	jmp    80106567 <alltraps>

80106dfd <vector102>:
80106dfd:	6a 00                	push   $0x0
80106dff:	6a 66                	push   $0x66
80106e01:	e9 61 f7 ff ff       	jmp    80106567 <alltraps>

80106e06 <vector103>:
80106e06:	6a 00                	push   $0x0
80106e08:	6a 67                	push   $0x67
80106e0a:	e9 58 f7 ff ff       	jmp    80106567 <alltraps>

80106e0f <vector104>:
80106e0f:	6a 00                	push   $0x0
80106e11:	6a 68                	push   $0x68
80106e13:	e9 4f f7 ff ff       	jmp    80106567 <alltraps>

80106e18 <vector105>:
80106e18:	6a 00                	push   $0x0
80106e1a:	6a 69                	push   $0x69
80106e1c:	e9 46 f7 ff ff       	jmp    80106567 <alltraps>

80106e21 <vector106>:
80106e21:	6a 00                	push   $0x0
80106e23:	6a 6a                	push   $0x6a
80106e25:	e9 3d f7 ff ff       	jmp    80106567 <alltraps>

80106e2a <vector107>:
80106e2a:	6a 00                	push   $0x0
80106e2c:	6a 6b                	push   $0x6b
80106e2e:	e9 34 f7 ff ff       	jmp    80106567 <alltraps>

80106e33 <vector108>:
80106e33:	6a 00                	push   $0x0
80106e35:	6a 6c                	push   $0x6c
80106e37:	e9 2b f7 ff ff       	jmp    80106567 <alltraps>

80106e3c <vector109>:
80106e3c:	6a 00                	push   $0x0
80106e3e:	6a 6d                	push   $0x6d
80106e40:	e9 22 f7 ff ff       	jmp    80106567 <alltraps>

80106e45 <vector110>:
80106e45:	6a 00                	push   $0x0
80106e47:	6a 6e                	push   $0x6e
80106e49:	e9 19 f7 ff ff       	jmp    80106567 <alltraps>

80106e4e <vector111>:
80106e4e:	6a 00                	push   $0x0
80106e50:	6a 6f                	push   $0x6f
80106e52:	e9 10 f7 ff ff       	jmp    80106567 <alltraps>

80106e57 <vector112>:
80106e57:	6a 00                	push   $0x0
80106e59:	6a 70                	push   $0x70
80106e5b:	e9 07 f7 ff ff       	jmp    80106567 <alltraps>

80106e60 <vector113>:
80106e60:	6a 00                	push   $0x0
80106e62:	6a 71                	push   $0x71
80106e64:	e9 fe f6 ff ff       	jmp    80106567 <alltraps>

80106e69 <vector114>:
80106e69:	6a 00                	push   $0x0
80106e6b:	6a 72                	push   $0x72
80106e6d:	e9 f5 f6 ff ff       	jmp    80106567 <alltraps>

80106e72 <vector115>:
80106e72:	6a 00                	push   $0x0
80106e74:	6a 73                	push   $0x73
80106e76:	e9 ec f6 ff ff       	jmp    80106567 <alltraps>

80106e7b <vector116>:
80106e7b:	6a 00                	push   $0x0
80106e7d:	6a 74                	push   $0x74
80106e7f:	e9 e3 f6 ff ff       	jmp    80106567 <alltraps>

80106e84 <vector117>:
80106e84:	6a 00                	push   $0x0
80106e86:	6a 75                	push   $0x75
80106e88:	e9 da f6 ff ff       	jmp    80106567 <alltraps>

80106e8d <vector118>:
80106e8d:	6a 00                	push   $0x0
80106e8f:	6a 76                	push   $0x76
80106e91:	e9 d1 f6 ff ff       	jmp    80106567 <alltraps>

80106e96 <vector119>:
80106e96:	6a 00                	push   $0x0
80106e98:	6a 77                	push   $0x77
80106e9a:	e9 c8 f6 ff ff       	jmp    80106567 <alltraps>

80106e9f <vector120>:
80106e9f:	6a 00                	push   $0x0
80106ea1:	6a 78                	push   $0x78
80106ea3:	e9 bf f6 ff ff       	jmp    80106567 <alltraps>

80106ea8 <vector121>:
80106ea8:	6a 00                	push   $0x0
80106eaa:	6a 79                	push   $0x79
80106eac:	e9 b6 f6 ff ff       	jmp    80106567 <alltraps>

80106eb1 <vector122>:
80106eb1:	6a 00                	push   $0x0
80106eb3:	6a 7a                	push   $0x7a
80106eb5:	e9 ad f6 ff ff       	jmp    80106567 <alltraps>

80106eba <vector123>:
80106eba:	6a 00                	push   $0x0
80106ebc:	6a 7b                	push   $0x7b
80106ebe:	e9 a4 f6 ff ff       	jmp    80106567 <alltraps>

80106ec3 <vector124>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	6a 7c                	push   $0x7c
80106ec7:	e9 9b f6 ff ff       	jmp    80106567 <alltraps>

80106ecc <vector125>:
80106ecc:	6a 00                	push   $0x0
80106ece:	6a 7d                	push   $0x7d
80106ed0:	e9 92 f6 ff ff       	jmp    80106567 <alltraps>

80106ed5 <vector126>:
80106ed5:	6a 00                	push   $0x0
80106ed7:	6a 7e                	push   $0x7e
80106ed9:	e9 89 f6 ff ff       	jmp    80106567 <alltraps>

80106ede <vector127>:
80106ede:	6a 00                	push   $0x0
80106ee0:	6a 7f                	push   $0x7f
80106ee2:	e9 80 f6 ff ff       	jmp    80106567 <alltraps>

80106ee7 <vector128>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 80 00 00 00       	push   $0x80
80106eee:	e9 74 f6 ff ff       	jmp    80106567 <alltraps>

80106ef3 <vector129>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 81 00 00 00       	push   $0x81
80106efa:	e9 68 f6 ff ff       	jmp    80106567 <alltraps>

80106eff <vector130>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 82 00 00 00       	push   $0x82
80106f06:	e9 5c f6 ff ff       	jmp    80106567 <alltraps>

80106f0b <vector131>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 83 00 00 00       	push   $0x83
80106f12:	e9 50 f6 ff ff       	jmp    80106567 <alltraps>

80106f17 <vector132>:
80106f17:	6a 00                	push   $0x0
80106f19:	68 84 00 00 00       	push   $0x84
80106f1e:	e9 44 f6 ff ff       	jmp    80106567 <alltraps>

80106f23 <vector133>:
80106f23:	6a 00                	push   $0x0
80106f25:	68 85 00 00 00       	push   $0x85
80106f2a:	e9 38 f6 ff ff       	jmp    80106567 <alltraps>

80106f2f <vector134>:
80106f2f:	6a 00                	push   $0x0
80106f31:	68 86 00 00 00       	push   $0x86
80106f36:	e9 2c f6 ff ff       	jmp    80106567 <alltraps>

80106f3b <vector135>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	68 87 00 00 00       	push   $0x87
80106f42:	e9 20 f6 ff ff       	jmp    80106567 <alltraps>

80106f47 <vector136>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 88 00 00 00       	push   $0x88
80106f4e:	e9 14 f6 ff ff       	jmp    80106567 <alltraps>

80106f53 <vector137>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 89 00 00 00       	push   $0x89
80106f5a:	e9 08 f6 ff ff       	jmp    80106567 <alltraps>

80106f5f <vector138>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 8a 00 00 00       	push   $0x8a
80106f66:	e9 fc f5 ff ff       	jmp    80106567 <alltraps>

80106f6b <vector139>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 8b 00 00 00       	push   $0x8b
80106f72:	e9 f0 f5 ff ff       	jmp    80106567 <alltraps>

80106f77 <vector140>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 8c 00 00 00       	push   $0x8c
80106f7e:	e9 e4 f5 ff ff       	jmp    80106567 <alltraps>

80106f83 <vector141>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 8d 00 00 00       	push   $0x8d
80106f8a:	e9 d8 f5 ff ff       	jmp    80106567 <alltraps>

80106f8f <vector142>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 8e 00 00 00       	push   $0x8e
80106f96:	e9 cc f5 ff ff       	jmp    80106567 <alltraps>

80106f9b <vector143>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 8f 00 00 00       	push   $0x8f
80106fa2:	e9 c0 f5 ff ff       	jmp    80106567 <alltraps>

80106fa7 <vector144>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 90 00 00 00       	push   $0x90
80106fae:	e9 b4 f5 ff ff       	jmp    80106567 <alltraps>

80106fb3 <vector145>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 91 00 00 00       	push   $0x91
80106fba:	e9 a8 f5 ff ff       	jmp    80106567 <alltraps>

80106fbf <vector146>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 92 00 00 00       	push   $0x92
80106fc6:	e9 9c f5 ff ff       	jmp    80106567 <alltraps>

80106fcb <vector147>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 93 00 00 00       	push   $0x93
80106fd2:	e9 90 f5 ff ff       	jmp    80106567 <alltraps>

80106fd7 <vector148>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 94 00 00 00       	push   $0x94
80106fde:	e9 84 f5 ff ff       	jmp    80106567 <alltraps>

80106fe3 <vector149>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 95 00 00 00       	push   $0x95
80106fea:	e9 78 f5 ff ff       	jmp    80106567 <alltraps>

80106fef <vector150>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 96 00 00 00       	push   $0x96
80106ff6:	e9 6c f5 ff ff       	jmp    80106567 <alltraps>

80106ffb <vector151>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 97 00 00 00       	push   $0x97
80107002:	e9 60 f5 ff ff       	jmp    80106567 <alltraps>

80107007 <vector152>:
80107007:	6a 00                	push   $0x0
80107009:	68 98 00 00 00       	push   $0x98
8010700e:	e9 54 f5 ff ff       	jmp    80106567 <alltraps>

80107013 <vector153>:
80107013:	6a 00                	push   $0x0
80107015:	68 99 00 00 00       	push   $0x99
8010701a:	e9 48 f5 ff ff       	jmp    80106567 <alltraps>

8010701f <vector154>:
8010701f:	6a 00                	push   $0x0
80107021:	68 9a 00 00 00       	push   $0x9a
80107026:	e9 3c f5 ff ff       	jmp    80106567 <alltraps>

8010702b <vector155>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 9b 00 00 00       	push   $0x9b
80107032:	e9 30 f5 ff ff       	jmp    80106567 <alltraps>

80107037 <vector156>:
80107037:	6a 00                	push   $0x0
80107039:	68 9c 00 00 00       	push   $0x9c
8010703e:	e9 24 f5 ff ff       	jmp    80106567 <alltraps>

80107043 <vector157>:
80107043:	6a 00                	push   $0x0
80107045:	68 9d 00 00 00       	push   $0x9d
8010704a:	e9 18 f5 ff ff       	jmp    80106567 <alltraps>

8010704f <vector158>:
8010704f:	6a 00                	push   $0x0
80107051:	68 9e 00 00 00       	push   $0x9e
80107056:	e9 0c f5 ff ff       	jmp    80106567 <alltraps>

8010705b <vector159>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 9f 00 00 00       	push   $0x9f
80107062:	e9 00 f5 ff ff       	jmp    80106567 <alltraps>

80107067 <vector160>:
80107067:	6a 00                	push   $0x0
80107069:	68 a0 00 00 00       	push   $0xa0
8010706e:	e9 f4 f4 ff ff       	jmp    80106567 <alltraps>

80107073 <vector161>:
80107073:	6a 00                	push   $0x0
80107075:	68 a1 00 00 00       	push   $0xa1
8010707a:	e9 e8 f4 ff ff       	jmp    80106567 <alltraps>

8010707f <vector162>:
8010707f:	6a 00                	push   $0x0
80107081:	68 a2 00 00 00       	push   $0xa2
80107086:	e9 dc f4 ff ff       	jmp    80106567 <alltraps>

8010708b <vector163>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 a3 00 00 00       	push   $0xa3
80107092:	e9 d0 f4 ff ff       	jmp    80106567 <alltraps>

80107097 <vector164>:
80107097:	6a 00                	push   $0x0
80107099:	68 a4 00 00 00       	push   $0xa4
8010709e:	e9 c4 f4 ff ff       	jmp    80106567 <alltraps>

801070a3 <vector165>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 a5 00 00 00       	push   $0xa5
801070aa:	e9 b8 f4 ff ff       	jmp    80106567 <alltraps>

801070af <vector166>:
801070af:	6a 00                	push   $0x0
801070b1:	68 a6 00 00 00       	push   $0xa6
801070b6:	e9 ac f4 ff ff       	jmp    80106567 <alltraps>

801070bb <vector167>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 a7 00 00 00       	push   $0xa7
801070c2:	e9 a0 f4 ff ff       	jmp    80106567 <alltraps>

801070c7 <vector168>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 a8 00 00 00       	push   $0xa8
801070ce:	e9 94 f4 ff ff       	jmp    80106567 <alltraps>

801070d3 <vector169>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 a9 00 00 00       	push   $0xa9
801070da:	e9 88 f4 ff ff       	jmp    80106567 <alltraps>

801070df <vector170>:
801070df:	6a 00                	push   $0x0
801070e1:	68 aa 00 00 00       	push   $0xaa
801070e6:	e9 7c f4 ff ff       	jmp    80106567 <alltraps>

801070eb <vector171>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 ab 00 00 00       	push   $0xab
801070f2:	e9 70 f4 ff ff       	jmp    80106567 <alltraps>

801070f7 <vector172>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 ac 00 00 00       	push   $0xac
801070fe:	e9 64 f4 ff ff       	jmp    80106567 <alltraps>

80107103 <vector173>:
80107103:	6a 00                	push   $0x0
80107105:	68 ad 00 00 00       	push   $0xad
8010710a:	e9 58 f4 ff ff       	jmp    80106567 <alltraps>

8010710f <vector174>:
8010710f:	6a 00                	push   $0x0
80107111:	68 ae 00 00 00       	push   $0xae
80107116:	e9 4c f4 ff ff       	jmp    80106567 <alltraps>

8010711b <vector175>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 af 00 00 00       	push   $0xaf
80107122:	e9 40 f4 ff ff       	jmp    80106567 <alltraps>

80107127 <vector176>:
80107127:	6a 00                	push   $0x0
80107129:	68 b0 00 00 00       	push   $0xb0
8010712e:	e9 34 f4 ff ff       	jmp    80106567 <alltraps>

80107133 <vector177>:
80107133:	6a 00                	push   $0x0
80107135:	68 b1 00 00 00       	push   $0xb1
8010713a:	e9 28 f4 ff ff       	jmp    80106567 <alltraps>

8010713f <vector178>:
8010713f:	6a 00                	push   $0x0
80107141:	68 b2 00 00 00       	push   $0xb2
80107146:	e9 1c f4 ff ff       	jmp    80106567 <alltraps>

8010714b <vector179>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 b3 00 00 00       	push   $0xb3
80107152:	e9 10 f4 ff ff       	jmp    80106567 <alltraps>

80107157 <vector180>:
80107157:	6a 00                	push   $0x0
80107159:	68 b4 00 00 00       	push   $0xb4
8010715e:	e9 04 f4 ff ff       	jmp    80106567 <alltraps>

80107163 <vector181>:
80107163:	6a 00                	push   $0x0
80107165:	68 b5 00 00 00       	push   $0xb5
8010716a:	e9 f8 f3 ff ff       	jmp    80106567 <alltraps>

8010716f <vector182>:
8010716f:	6a 00                	push   $0x0
80107171:	68 b6 00 00 00       	push   $0xb6
80107176:	e9 ec f3 ff ff       	jmp    80106567 <alltraps>

8010717b <vector183>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 b7 00 00 00       	push   $0xb7
80107182:	e9 e0 f3 ff ff       	jmp    80106567 <alltraps>

80107187 <vector184>:
80107187:	6a 00                	push   $0x0
80107189:	68 b8 00 00 00       	push   $0xb8
8010718e:	e9 d4 f3 ff ff       	jmp    80106567 <alltraps>

80107193 <vector185>:
80107193:	6a 00                	push   $0x0
80107195:	68 b9 00 00 00       	push   $0xb9
8010719a:	e9 c8 f3 ff ff       	jmp    80106567 <alltraps>

8010719f <vector186>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 ba 00 00 00       	push   $0xba
801071a6:	e9 bc f3 ff ff       	jmp    80106567 <alltraps>

801071ab <vector187>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 bb 00 00 00       	push   $0xbb
801071b2:	e9 b0 f3 ff ff       	jmp    80106567 <alltraps>

801071b7 <vector188>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 bc 00 00 00       	push   $0xbc
801071be:	e9 a4 f3 ff ff       	jmp    80106567 <alltraps>

801071c3 <vector189>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 bd 00 00 00       	push   $0xbd
801071ca:	e9 98 f3 ff ff       	jmp    80106567 <alltraps>

801071cf <vector190>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 be 00 00 00       	push   $0xbe
801071d6:	e9 8c f3 ff ff       	jmp    80106567 <alltraps>

801071db <vector191>:
801071db:	6a 00                	push   $0x0
801071dd:	68 bf 00 00 00       	push   $0xbf
801071e2:	e9 80 f3 ff ff       	jmp    80106567 <alltraps>

801071e7 <vector192>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 c0 00 00 00       	push   $0xc0
801071ee:	e9 74 f3 ff ff       	jmp    80106567 <alltraps>

801071f3 <vector193>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 c1 00 00 00       	push   $0xc1
801071fa:	e9 68 f3 ff ff       	jmp    80106567 <alltraps>

801071ff <vector194>:
801071ff:	6a 00                	push   $0x0
80107201:	68 c2 00 00 00       	push   $0xc2
80107206:	e9 5c f3 ff ff       	jmp    80106567 <alltraps>

8010720b <vector195>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 c3 00 00 00       	push   $0xc3
80107212:	e9 50 f3 ff ff       	jmp    80106567 <alltraps>

80107217 <vector196>:
80107217:	6a 00                	push   $0x0
80107219:	68 c4 00 00 00       	push   $0xc4
8010721e:	e9 44 f3 ff ff       	jmp    80106567 <alltraps>

80107223 <vector197>:
80107223:	6a 00                	push   $0x0
80107225:	68 c5 00 00 00       	push   $0xc5
8010722a:	e9 38 f3 ff ff       	jmp    80106567 <alltraps>

8010722f <vector198>:
8010722f:	6a 00                	push   $0x0
80107231:	68 c6 00 00 00       	push   $0xc6
80107236:	e9 2c f3 ff ff       	jmp    80106567 <alltraps>

8010723b <vector199>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 c7 00 00 00       	push   $0xc7
80107242:	e9 20 f3 ff ff       	jmp    80106567 <alltraps>

80107247 <vector200>:
80107247:	6a 00                	push   $0x0
80107249:	68 c8 00 00 00       	push   $0xc8
8010724e:	e9 14 f3 ff ff       	jmp    80106567 <alltraps>

80107253 <vector201>:
80107253:	6a 00                	push   $0x0
80107255:	68 c9 00 00 00       	push   $0xc9
8010725a:	e9 08 f3 ff ff       	jmp    80106567 <alltraps>

8010725f <vector202>:
8010725f:	6a 00                	push   $0x0
80107261:	68 ca 00 00 00       	push   $0xca
80107266:	e9 fc f2 ff ff       	jmp    80106567 <alltraps>

8010726b <vector203>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 cb 00 00 00       	push   $0xcb
80107272:	e9 f0 f2 ff ff       	jmp    80106567 <alltraps>

80107277 <vector204>:
80107277:	6a 00                	push   $0x0
80107279:	68 cc 00 00 00       	push   $0xcc
8010727e:	e9 e4 f2 ff ff       	jmp    80106567 <alltraps>

80107283 <vector205>:
80107283:	6a 00                	push   $0x0
80107285:	68 cd 00 00 00       	push   $0xcd
8010728a:	e9 d8 f2 ff ff       	jmp    80106567 <alltraps>

8010728f <vector206>:
8010728f:	6a 00                	push   $0x0
80107291:	68 ce 00 00 00       	push   $0xce
80107296:	e9 cc f2 ff ff       	jmp    80106567 <alltraps>

8010729b <vector207>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 cf 00 00 00       	push   $0xcf
801072a2:	e9 c0 f2 ff ff       	jmp    80106567 <alltraps>

801072a7 <vector208>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 d0 00 00 00       	push   $0xd0
801072ae:	e9 b4 f2 ff ff       	jmp    80106567 <alltraps>

801072b3 <vector209>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 d1 00 00 00       	push   $0xd1
801072ba:	e9 a8 f2 ff ff       	jmp    80106567 <alltraps>

801072bf <vector210>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 d2 00 00 00       	push   $0xd2
801072c6:	e9 9c f2 ff ff       	jmp    80106567 <alltraps>

801072cb <vector211>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 d3 00 00 00       	push   $0xd3
801072d2:	e9 90 f2 ff ff       	jmp    80106567 <alltraps>

801072d7 <vector212>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 d4 00 00 00       	push   $0xd4
801072de:	e9 84 f2 ff ff       	jmp    80106567 <alltraps>

801072e3 <vector213>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 d5 00 00 00       	push   $0xd5
801072ea:	e9 78 f2 ff ff       	jmp    80106567 <alltraps>

801072ef <vector214>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 d6 00 00 00       	push   $0xd6
801072f6:	e9 6c f2 ff ff       	jmp    80106567 <alltraps>

801072fb <vector215>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 d7 00 00 00       	push   $0xd7
80107302:	e9 60 f2 ff ff       	jmp    80106567 <alltraps>

80107307 <vector216>:
80107307:	6a 00                	push   $0x0
80107309:	68 d8 00 00 00       	push   $0xd8
8010730e:	e9 54 f2 ff ff       	jmp    80106567 <alltraps>

80107313 <vector217>:
80107313:	6a 00                	push   $0x0
80107315:	68 d9 00 00 00       	push   $0xd9
8010731a:	e9 48 f2 ff ff       	jmp    80106567 <alltraps>

8010731f <vector218>:
8010731f:	6a 00                	push   $0x0
80107321:	68 da 00 00 00       	push   $0xda
80107326:	e9 3c f2 ff ff       	jmp    80106567 <alltraps>

8010732b <vector219>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 db 00 00 00       	push   $0xdb
80107332:	e9 30 f2 ff ff       	jmp    80106567 <alltraps>

80107337 <vector220>:
80107337:	6a 00                	push   $0x0
80107339:	68 dc 00 00 00       	push   $0xdc
8010733e:	e9 24 f2 ff ff       	jmp    80106567 <alltraps>

80107343 <vector221>:
80107343:	6a 00                	push   $0x0
80107345:	68 dd 00 00 00       	push   $0xdd
8010734a:	e9 18 f2 ff ff       	jmp    80106567 <alltraps>

8010734f <vector222>:
8010734f:	6a 00                	push   $0x0
80107351:	68 de 00 00 00       	push   $0xde
80107356:	e9 0c f2 ff ff       	jmp    80106567 <alltraps>

8010735b <vector223>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 df 00 00 00       	push   $0xdf
80107362:	e9 00 f2 ff ff       	jmp    80106567 <alltraps>

80107367 <vector224>:
80107367:	6a 00                	push   $0x0
80107369:	68 e0 00 00 00       	push   $0xe0
8010736e:	e9 f4 f1 ff ff       	jmp    80106567 <alltraps>

80107373 <vector225>:
80107373:	6a 00                	push   $0x0
80107375:	68 e1 00 00 00       	push   $0xe1
8010737a:	e9 e8 f1 ff ff       	jmp    80106567 <alltraps>

8010737f <vector226>:
8010737f:	6a 00                	push   $0x0
80107381:	68 e2 00 00 00       	push   $0xe2
80107386:	e9 dc f1 ff ff       	jmp    80106567 <alltraps>

8010738b <vector227>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 e3 00 00 00       	push   $0xe3
80107392:	e9 d0 f1 ff ff       	jmp    80106567 <alltraps>

80107397 <vector228>:
80107397:	6a 00                	push   $0x0
80107399:	68 e4 00 00 00       	push   $0xe4
8010739e:	e9 c4 f1 ff ff       	jmp    80106567 <alltraps>

801073a3 <vector229>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 e5 00 00 00       	push   $0xe5
801073aa:	e9 b8 f1 ff ff       	jmp    80106567 <alltraps>

801073af <vector230>:
801073af:	6a 00                	push   $0x0
801073b1:	68 e6 00 00 00       	push   $0xe6
801073b6:	e9 ac f1 ff ff       	jmp    80106567 <alltraps>

801073bb <vector231>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 e7 00 00 00       	push   $0xe7
801073c2:	e9 a0 f1 ff ff       	jmp    80106567 <alltraps>

801073c7 <vector232>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 e8 00 00 00       	push   $0xe8
801073ce:	e9 94 f1 ff ff       	jmp    80106567 <alltraps>

801073d3 <vector233>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 e9 00 00 00       	push   $0xe9
801073da:	e9 88 f1 ff ff       	jmp    80106567 <alltraps>

801073df <vector234>:
801073df:	6a 00                	push   $0x0
801073e1:	68 ea 00 00 00       	push   $0xea
801073e6:	e9 7c f1 ff ff       	jmp    80106567 <alltraps>

801073eb <vector235>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 eb 00 00 00       	push   $0xeb
801073f2:	e9 70 f1 ff ff       	jmp    80106567 <alltraps>

801073f7 <vector236>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 ec 00 00 00       	push   $0xec
801073fe:	e9 64 f1 ff ff       	jmp    80106567 <alltraps>

80107403 <vector237>:
80107403:	6a 00                	push   $0x0
80107405:	68 ed 00 00 00       	push   $0xed
8010740a:	e9 58 f1 ff ff       	jmp    80106567 <alltraps>

8010740f <vector238>:
8010740f:	6a 00                	push   $0x0
80107411:	68 ee 00 00 00       	push   $0xee
80107416:	e9 4c f1 ff ff       	jmp    80106567 <alltraps>

8010741b <vector239>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 ef 00 00 00       	push   $0xef
80107422:	e9 40 f1 ff ff       	jmp    80106567 <alltraps>

80107427 <vector240>:
80107427:	6a 00                	push   $0x0
80107429:	68 f0 00 00 00       	push   $0xf0
8010742e:	e9 34 f1 ff ff       	jmp    80106567 <alltraps>

80107433 <vector241>:
80107433:	6a 00                	push   $0x0
80107435:	68 f1 00 00 00       	push   $0xf1
8010743a:	e9 28 f1 ff ff       	jmp    80106567 <alltraps>

8010743f <vector242>:
8010743f:	6a 00                	push   $0x0
80107441:	68 f2 00 00 00       	push   $0xf2
80107446:	e9 1c f1 ff ff       	jmp    80106567 <alltraps>

8010744b <vector243>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 f3 00 00 00       	push   $0xf3
80107452:	e9 10 f1 ff ff       	jmp    80106567 <alltraps>

80107457 <vector244>:
80107457:	6a 00                	push   $0x0
80107459:	68 f4 00 00 00       	push   $0xf4
8010745e:	e9 04 f1 ff ff       	jmp    80106567 <alltraps>

80107463 <vector245>:
80107463:	6a 00                	push   $0x0
80107465:	68 f5 00 00 00       	push   $0xf5
8010746a:	e9 f8 f0 ff ff       	jmp    80106567 <alltraps>

8010746f <vector246>:
8010746f:	6a 00                	push   $0x0
80107471:	68 f6 00 00 00       	push   $0xf6
80107476:	e9 ec f0 ff ff       	jmp    80106567 <alltraps>

8010747b <vector247>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 f7 00 00 00       	push   $0xf7
80107482:	e9 e0 f0 ff ff       	jmp    80106567 <alltraps>

80107487 <vector248>:
80107487:	6a 00                	push   $0x0
80107489:	68 f8 00 00 00       	push   $0xf8
8010748e:	e9 d4 f0 ff ff       	jmp    80106567 <alltraps>

80107493 <vector249>:
80107493:	6a 00                	push   $0x0
80107495:	68 f9 00 00 00       	push   $0xf9
8010749a:	e9 c8 f0 ff ff       	jmp    80106567 <alltraps>

8010749f <vector250>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 fa 00 00 00       	push   $0xfa
801074a6:	e9 bc f0 ff ff       	jmp    80106567 <alltraps>

801074ab <vector251>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 fb 00 00 00       	push   $0xfb
801074b2:	e9 b0 f0 ff ff       	jmp    80106567 <alltraps>

801074b7 <vector252>:
801074b7:	6a 00                	push   $0x0
801074b9:	68 fc 00 00 00       	push   $0xfc
801074be:	e9 a4 f0 ff ff       	jmp    80106567 <alltraps>

801074c3 <vector253>:
801074c3:	6a 00                	push   $0x0
801074c5:	68 fd 00 00 00       	push   $0xfd
801074ca:	e9 98 f0 ff ff       	jmp    80106567 <alltraps>

801074cf <vector254>:
801074cf:	6a 00                	push   $0x0
801074d1:	68 fe 00 00 00       	push   $0xfe
801074d6:	e9 8c f0 ff ff       	jmp    80106567 <alltraps>

801074db <vector255>:
801074db:	6a 00                	push   $0x0
801074dd:	68 ff 00 00 00       	push   $0xff
801074e2:	e9 80 f0 ff ff       	jmp    80106567 <alltraps>
801074e7:	66 90                	xchg   %ax,%ax
801074e9:	66 90                	xchg   %ax,%ax
801074eb:	66 90                	xchg   %ax,%ax
801074ed:	66 90                	xchg   %ax,%ax
801074ef:	90                   	nop

801074f0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074f0:	55                   	push   %ebp
801074f1:	89 e5                	mov    %esp,%ebp
801074f3:	57                   	push   %edi
801074f4:	56                   	push   %esi
801074f5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801074f6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801074fc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107502:	83 ec 1c             	sub    $0x1c,%esp
80107505:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107508:	39 d3                	cmp    %edx,%ebx
8010750a:	73 49                	jae    80107555 <deallocuvm.part.0+0x65>
8010750c:	89 c7                	mov    %eax,%edi
8010750e:	eb 0c                	jmp    8010751c <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107510:	83 c0 01             	add    $0x1,%eax
80107513:	c1 e0 16             	shl    $0x16,%eax
80107516:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107518:	39 da                	cmp    %ebx,%edx
8010751a:	76 39                	jbe    80107555 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
8010751c:	89 d8                	mov    %ebx,%eax
8010751e:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107521:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
80107524:	f6 c1 01             	test   $0x1,%cl
80107527:	74 e7                	je     80107510 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
80107529:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010752b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107531:	c1 ee 0a             	shr    $0xa,%esi
80107534:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010753a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107541:	85 f6                	test   %esi,%esi
80107543:	74 cb                	je     80107510 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107545:	8b 06                	mov    (%esi),%eax
80107547:	a8 01                	test   $0x1,%al
80107549:	75 15                	jne    80107560 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010754b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107551:	39 da                	cmp    %ebx,%edx
80107553:	77 c7                	ja     8010751c <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107555:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107558:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010755b:	5b                   	pop    %ebx
8010755c:	5e                   	pop    %esi
8010755d:	5f                   	pop    %edi
8010755e:	5d                   	pop    %ebp
8010755f:	c3                   	ret    
      if(pa == 0)
80107560:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107565:	74 25                	je     8010758c <deallocuvm.part.0+0x9c>
      kfree(v);
80107567:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010756a:	05 00 00 00 80       	add    $0x80000000,%eax
8010756f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107572:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107578:	50                   	push   %eax
80107579:	e8 12 b4 ff ff       	call   80102990 <kfree>
      *pte = 0;
8010757e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107584:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107587:	83 c4 10             	add    $0x10,%esp
8010758a:	eb 8c                	jmp    80107518 <deallocuvm.part.0+0x28>
        panic("kfree");
8010758c:	83 ec 0c             	sub    $0xc,%esp
8010758f:	68 9e 81 10 80       	push   $0x8010819e
80107594:	e8 e7 8d ff ff       	call   80100380 <panic>
80107599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801075a0 <mappages>:
{
801075a0:	55                   	push   %ebp
801075a1:	89 e5                	mov    %esp,%ebp
801075a3:	57                   	push   %edi
801075a4:	56                   	push   %esi
801075a5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801075a6:	89 d3                	mov    %edx,%ebx
801075a8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
801075ae:	83 ec 1c             	sub    $0x1c,%esp
801075b1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075b4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
801075b8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801075bd:	89 45 dc             	mov    %eax,-0x24(%ebp)
801075c0:	8b 45 08             	mov    0x8(%ebp),%eax
801075c3:	29 d8                	sub    %ebx,%eax
801075c5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801075c8:	eb 3d                	jmp    80107607 <mappages+0x67>
801075ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801075d0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801075d7:	c1 ea 0a             	shr    $0xa,%edx
801075da:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075e0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801075e7:	85 c0                	test   %eax,%eax
801075e9:	74 75                	je     80107660 <mappages+0xc0>
    if(*pte & PTE_P)
801075eb:	f6 00 01             	testb  $0x1,(%eax)
801075ee:	0f 85 86 00 00 00    	jne    8010767a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801075f4:	0b 75 0c             	or     0xc(%ebp),%esi
801075f7:	83 ce 01             	or     $0x1,%esi
801075fa:	89 30                	mov    %esi,(%eax)
    if(a == last)
801075fc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801075ff:	74 6f                	je     80107670 <mappages+0xd0>
    a += PGSIZE;
80107601:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107607:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010760a:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010760d:	8d 34 18             	lea    (%eax,%ebx,1),%esi
80107610:	89 d8                	mov    %ebx,%eax
80107612:	c1 e8 16             	shr    $0x16,%eax
80107615:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107618:	8b 07                	mov    (%edi),%eax
8010761a:	a8 01                	test   $0x1,%al
8010761c:	75 b2                	jne    801075d0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
8010761e:	e8 2d b5 ff ff       	call   80102b50 <kalloc>
80107623:	85 c0                	test   %eax,%eax
80107625:	74 39                	je     80107660 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107627:	83 ec 04             	sub    $0x4,%esp
8010762a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010762d:	68 00 10 00 00       	push   $0x1000
80107632:	6a 00                	push   $0x0
80107634:	50                   	push   %eax
80107635:	e8 d6 da ff ff       	call   80105110 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010763a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010763d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107640:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107646:	83 c8 07             	or     $0x7,%eax
80107649:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010764b:	89 d8                	mov    %ebx,%eax
8010764d:	c1 e8 0a             	shr    $0xa,%eax
80107650:	25 fc 0f 00 00       	and    $0xffc,%eax
80107655:	01 d0                	add    %edx,%eax
80107657:	eb 92                	jmp    801075eb <mappages+0x4b>
80107659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107660:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107663:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107668:	5b                   	pop    %ebx
80107669:	5e                   	pop    %esi
8010766a:	5f                   	pop    %edi
8010766b:	5d                   	pop    %ebp
8010766c:	c3                   	ret    
8010766d:	8d 76 00             	lea    0x0(%esi),%esi
80107670:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107673:	31 c0                	xor    %eax,%eax
}
80107675:	5b                   	pop    %ebx
80107676:	5e                   	pop    %esi
80107677:	5f                   	pop    %edi
80107678:	5d                   	pop    %ebp
80107679:	c3                   	ret    
      panic("remap");
8010767a:	83 ec 0c             	sub    $0xc,%esp
8010767d:	68 48 88 10 80       	push   $0x80108848
80107682:	e8 f9 8c ff ff       	call   80100380 <panic>
80107687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010768e:	66 90                	xchg   %ax,%ax

80107690 <seginit>:
{
80107690:	55                   	push   %ebp
80107691:	89 e5                	mov    %esp,%ebp
80107693:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107696:	e8 d5 c7 ff ff       	call   80103e70 <cpuid>
  pd[0] = size-1;
8010769b:	ba 2f 00 00 00       	mov    $0x2f,%edx
801076a0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801076a6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801076aa:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
801076b1:	ff 00 00 
801076b4:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
801076bb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801076be:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
801076c5:	ff 00 00 
801076c8:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
801076cf:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801076d2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801076d9:	ff 00 00 
801076dc:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801076e3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801076e6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801076ed:	ff 00 00 
801076f0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801076f7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801076fa:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801076ff:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107703:	c1 e8 10             	shr    $0x10,%eax
80107706:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010770a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010770d:	0f 01 10             	lgdtl  (%eax)
}
80107710:	c9                   	leave  
80107711:	c3                   	ret    
80107712:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107720 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107720:	a1 e4 5b 11 80       	mov    0x80115be4,%eax
80107725:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010772a:	0f 22 d8             	mov    %eax,%cr3
}
8010772d:	c3                   	ret    
8010772e:	66 90                	xchg   %ax,%ax

80107730 <switchuvm>:
{
80107730:	55                   	push   %ebp
80107731:	89 e5                	mov    %esp,%ebp
80107733:	57                   	push   %edi
80107734:	56                   	push   %esi
80107735:	53                   	push   %ebx
80107736:	83 ec 1c             	sub    $0x1c,%esp
80107739:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010773c:	85 f6                	test   %esi,%esi
8010773e:	0f 84 cb 00 00 00    	je     8010780f <switchuvm+0xdf>
  if(p->kstack == 0)
80107744:	8b 46 08             	mov    0x8(%esi),%eax
80107747:	85 c0                	test   %eax,%eax
80107749:	0f 84 da 00 00 00    	je     80107829 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010774f:	8b 46 04             	mov    0x4(%esi),%eax
80107752:	85 c0                	test   %eax,%eax
80107754:	0f 84 c2 00 00 00    	je     8010781c <switchuvm+0xec>
  pushcli();
8010775a:	e8 a1 d7 ff ff       	call   80104f00 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010775f:	e8 ac c6 ff ff       	call   80103e10 <mycpu>
80107764:	89 c3                	mov    %eax,%ebx
80107766:	e8 a5 c6 ff ff       	call   80103e10 <mycpu>
8010776b:	89 c7                	mov    %eax,%edi
8010776d:	e8 9e c6 ff ff       	call   80103e10 <mycpu>
80107772:	83 c7 08             	add    $0x8,%edi
80107775:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107778:	e8 93 c6 ff ff       	call   80103e10 <mycpu>
8010777d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107780:	ba 67 00 00 00       	mov    $0x67,%edx
80107785:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010778c:	83 c0 08             	add    $0x8,%eax
8010778f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107796:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010779b:	83 c1 08             	add    $0x8,%ecx
8010779e:	c1 e8 18             	shr    $0x18,%eax
801077a1:	c1 e9 10             	shr    $0x10,%ecx
801077a4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801077aa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801077b0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801077b5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077bc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801077c1:	e8 4a c6 ff ff       	call   80103e10 <mycpu>
801077c6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801077cd:	e8 3e c6 ff ff       	call   80103e10 <mycpu>
801077d2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801077d6:	8b 5e 08             	mov    0x8(%esi),%ebx
801077d9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077df:	e8 2c c6 ff ff       	call   80103e10 <mycpu>
801077e4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801077e7:	e8 24 c6 ff ff       	call   80103e10 <mycpu>
801077ec:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801077f0:	b8 28 00 00 00       	mov    $0x28,%eax
801077f5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801077f8:	8b 46 04             	mov    0x4(%esi),%eax
801077fb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107800:	0f 22 d8             	mov    %eax,%cr3
}
80107803:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107806:	5b                   	pop    %ebx
80107807:	5e                   	pop    %esi
80107808:	5f                   	pop    %edi
80107809:	5d                   	pop    %ebp
  popcli();
8010780a:	e9 41 d7 ff ff       	jmp    80104f50 <popcli>
    panic("switchuvm: no process");
8010780f:	83 ec 0c             	sub    $0xc,%esp
80107812:	68 4e 88 10 80       	push   $0x8010884e
80107817:	e8 64 8b ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
8010781c:	83 ec 0c             	sub    $0xc,%esp
8010781f:	68 79 88 10 80       	push   $0x80108879
80107824:	e8 57 8b ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80107829:	83 ec 0c             	sub    $0xc,%esp
8010782c:	68 64 88 10 80       	push   $0x80108864
80107831:	e8 4a 8b ff ff       	call   80100380 <panic>
80107836:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010783d:	8d 76 00             	lea    0x0(%esi),%esi

80107840 <inituvm>:
{
80107840:	55                   	push   %ebp
80107841:	89 e5                	mov    %esp,%ebp
80107843:	57                   	push   %edi
80107844:	56                   	push   %esi
80107845:	53                   	push   %ebx
80107846:	83 ec 1c             	sub    $0x1c,%esp
80107849:	8b 45 0c             	mov    0xc(%ebp),%eax
8010784c:	8b 75 10             	mov    0x10(%ebp),%esi
8010784f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107852:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107855:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010785b:	77 4b                	ja     801078a8 <inituvm+0x68>
  mem = kalloc();
8010785d:	e8 ee b2 ff ff       	call   80102b50 <kalloc>
  memset(mem, 0, PGSIZE);
80107862:	83 ec 04             	sub    $0x4,%esp
80107865:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010786a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010786c:	6a 00                	push   $0x0
8010786e:	50                   	push   %eax
8010786f:	e8 9c d8 ff ff       	call   80105110 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107874:	58                   	pop    %eax
80107875:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010787b:	5a                   	pop    %edx
8010787c:	6a 06                	push   $0x6
8010787e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107883:	31 d2                	xor    %edx,%edx
80107885:	50                   	push   %eax
80107886:	89 f8                	mov    %edi,%eax
80107888:	e8 13 fd ff ff       	call   801075a0 <mappages>
  memmove(mem, init, sz);
8010788d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107890:	89 75 10             	mov    %esi,0x10(%ebp)
80107893:	83 c4 10             	add    $0x10,%esp
80107896:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107899:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010789c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010789f:	5b                   	pop    %ebx
801078a0:	5e                   	pop    %esi
801078a1:	5f                   	pop    %edi
801078a2:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801078a3:	e9 08 d9 ff ff       	jmp    801051b0 <memmove>
    panic("inituvm: more than a page");
801078a8:	83 ec 0c             	sub    $0xc,%esp
801078ab:	68 8d 88 10 80       	push   $0x8010888d
801078b0:	e8 cb 8a ff ff       	call   80100380 <panic>
801078b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801078c0 <loaduvm>:
{
801078c0:	55                   	push   %ebp
801078c1:	89 e5                	mov    %esp,%ebp
801078c3:	57                   	push   %edi
801078c4:	56                   	push   %esi
801078c5:	53                   	push   %ebx
801078c6:	83 ec 1c             	sub    $0x1c,%esp
801078c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801078cc:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801078cf:	a9 ff 0f 00 00       	test   $0xfff,%eax
801078d4:	0f 85 bb 00 00 00    	jne    80107995 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801078da:	01 f0                	add    %esi,%eax
801078dc:	89 f3                	mov    %esi,%ebx
801078de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078e1:	8b 45 14             	mov    0x14(%ebp),%eax
801078e4:	01 f0                	add    %esi,%eax
801078e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801078e9:	85 f6                	test   %esi,%esi
801078eb:	0f 84 87 00 00 00    	je     80107978 <loaduvm+0xb8>
801078f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801078f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801078fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801078fe:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
80107900:	89 c2                	mov    %eax,%edx
80107902:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107905:	8b 14 91             	mov    (%ecx,%edx,4),%edx
80107908:	f6 c2 01             	test   $0x1,%dl
8010790b:	75 13                	jne    80107920 <loaduvm+0x60>
      panic("loaduvm: address should exist");
8010790d:	83 ec 0c             	sub    $0xc,%esp
80107910:	68 a7 88 10 80       	push   $0x801088a7
80107915:	e8 66 8a ff ff       	call   80100380 <panic>
8010791a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107920:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107923:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107929:	25 fc 0f 00 00       	and    $0xffc,%eax
8010792e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107935:	85 c0                	test   %eax,%eax
80107937:	74 d4                	je     8010790d <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107939:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010793b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010793e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107943:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107948:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010794e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107951:	29 d9                	sub    %ebx,%ecx
80107953:	05 00 00 00 80       	add    $0x80000000,%eax
80107958:	57                   	push   %edi
80107959:	51                   	push   %ecx
8010795a:	50                   	push   %eax
8010795b:	ff 75 10             	pushl  0x10(%ebp)
8010795e:	e8 ed a5 ff ff       	call   80101f50 <readi>
80107963:	83 c4 10             	add    $0x10,%esp
80107966:	39 f8                	cmp    %edi,%eax
80107968:	75 1e                	jne    80107988 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010796a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107970:	89 f0                	mov    %esi,%eax
80107972:	29 d8                	sub    %ebx,%eax
80107974:	39 c6                	cmp    %eax,%esi
80107976:	77 80                	ja     801078f8 <loaduvm+0x38>
}
80107978:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010797b:	31 c0                	xor    %eax,%eax
}
8010797d:	5b                   	pop    %ebx
8010797e:	5e                   	pop    %esi
8010797f:	5f                   	pop    %edi
80107980:	5d                   	pop    %ebp
80107981:	c3                   	ret    
80107982:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107988:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010798b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107990:	5b                   	pop    %ebx
80107991:	5e                   	pop    %esi
80107992:	5f                   	pop    %edi
80107993:	5d                   	pop    %ebp
80107994:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107995:	83 ec 0c             	sub    $0xc,%esp
80107998:	68 48 89 10 80       	push   $0x80108948
8010799d:	e8 de 89 ff ff       	call   80100380 <panic>
801079a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801079b0 <allocuvm>:
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801079b9:	8b 45 10             	mov    0x10(%ebp),%eax
{
801079bc:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801079bf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801079c2:	85 c0                	test   %eax,%eax
801079c4:	0f 88 b6 00 00 00    	js     80107a80 <allocuvm+0xd0>
  if(newsz < oldsz)
801079ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801079cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801079d0:	0f 82 9a 00 00 00    	jb     80107a70 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801079d6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801079dc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801079e2:	39 75 10             	cmp    %esi,0x10(%ebp)
801079e5:	77 44                	ja     80107a2b <allocuvm+0x7b>
801079e7:	e9 87 00 00 00       	jmp    80107a73 <allocuvm+0xc3>
801079ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801079f0:	83 ec 04             	sub    $0x4,%esp
801079f3:	68 00 10 00 00       	push   $0x1000
801079f8:	6a 00                	push   $0x0
801079fa:	50                   	push   %eax
801079fb:	e8 10 d7 ff ff       	call   80105110 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107a00:	58                   	pop    %eax
80107a01:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a07:	5a                   	pop    %edx
80107a08:	6a 06                	push   $0x6
80107a0a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a0f:	89 f2                	mov    %esi,%edx
80107a11:	50                   	push   %eax
80107a12:	89 f8                	mov    %edi,%eax
80107a14:	e8 87 fb ff ff       	call   801075a0 <mappages>
80107a19:	83 c4 10             	add    $0x10,%esp
80107a1c:	85 c0                	test   %eax,%eax
80107a1e:	78 78                	js     80107a98 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107a20:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107a26:	39 75 10             	cmp    %esi,0x10(%ebp)
80107a29:	76 48                	jbe    80107a73 <allocuvm+0xc3>
    mem = kalloc();
80107a2b:	e8 20 b1 ff ff       	call   80102b50 <kalloc>
80107a30:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107a32:	85 c0                	test   %eax,%eax
80107a34:	75 ba                	jne    801079f0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107a36:	83 ec 0c             	sub    $0xc,%esp
80107a39:	68 c5 88 10 80       	push   $0x801088c5
80107a3e:	e8 5d 8c ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107a43:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a46:	83 c4 10             	add    $0x10,%esp
80107a49:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a4c:	74 32                	je     80107a80 <allocuvm+0xd0>
80107a4e:	8b 55 10             	mov    0x10(%ebp),%edx
80107a51:	89 c1                	mov    %eax,%ecx
80107a53:	89 f8                	mov    %edi,%eax
80107a55:	e8 96 fa ff ff       	call   801074f0 <deallocuvm.part.0>
      return 0;
80107a5a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a64:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a67:	5b                   	pop    %ebx
80107a68:	5e                   	pop    %esi
80107a69:	5f                   	pop    %edi
80107a6a:	5d                   	pop    %ebp
80107a6b:	c3                   	ret    
80107a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107a70:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107a73:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a79:	5b                   	pop    %ebx
80107a7a:	5e                   	pop    %esi
80107a7b:	5f                   	pop    %edi
80107a7c:	5d                   	pop    %ebp
80107a7d:	c3                   	ret    
80107a7e:	66 90                	xchg   %ax,%ax
    return 0;
80107a80:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a87:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a8a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a8d:	5b                   	pop    %ebx
80107a8e:	5e                   	pop    %esi
80107a8f:	5f                   	pop    %edi
80107a90:	5d                   	pop    %ebp
80107a91:	c3                   	ret    
80107a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107a98:	83 ec 0c             	sub    $0xc,%esp
80107a9b:	68 dd 88 10 80       	push   $0x801088dd
80107aa0:	e8 fb 8b ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
80107aa8:	83 c4 10             	add    $0x10,%esp
80107aab:	39 45 10             	cmp    %eax,0x10(%ebp)
80107aae:	74 0c                	je     80107abc <allocuvm+0x10c>
80107ab0:	8b 55 10             	mov    0x10(%ebp),%edx
80107ab3:	89 c1                	mov    %eax,%ecx
80107ab5:	89 f8                	mov    %edi,%eax
80107ab7:	e8 34 fa ff ff       	call   801074f0 <deallocuvm.part.0>
      kfree(mem);
80107abc:	83 ec 0c             	sub    $0xc,%esp
80107abf:	53                   	push   %ebx
80107ac0:	e8 cb ae ff ff       	call   80102990 <kfree>
      return 0;
80107ac5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107acc:	83 c4 10             	add    $0x10,%esp
}
80107acf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ad2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ad5:	5b                   	pop    %ebx
80107ad6:	5e                   	pop    %esi
80107ad7:	5f                   	pop    %edi
80107ad8:	5d                   	pop    %ebp
80107ad9:	c3                   	ret    
80107ada:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ae0 <deallocuvm>:
{
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ae6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107aec:	39 d1                	cmp    %edx,%ecx
80107aee:	73 10                	jae    80107b00 <deallocuvm+0x20>
}
80107af0:	5d                   	pop    %ebp
80107af1:	e9 fa f9 ff ff       	jmp    801074f0 <deallocuvm.part.0>
80107af6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107afd:	8d 76 00             	lea    0x0(%esi),%esi
80107b00:	89 d0                	mov    %edx,%eax
80107b02:	5d                   	pop    %ebp
80107b03:	c3                   	ret    
80107b04:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b0b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b0f:	90                   	nop

80107b10 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107b10:	55                   	push   %ebp
80107b11:	89 e5                	mov    %esp,%ebp
80107b13:	57                   	push   %edi
80107b14:	56                   	push   %esi
80107b15:	53                   	push   %ebx
80107b16:	83 ec 0c             	sub    $0xc,%esp
80107b19:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107b1c:	85 f6                	test   %esi,%esi
80107b1e:	74 59                	je     80107b79 <freevm+0x69>
  if(newsz >= oldsz)
80107b20:	31 c9                	xor    %ecx,%ecx
80107b22:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107b27:	89 f0                	mov    %esi,%eax
80107b29:	89 f3                	mov    %esi,%ebx
80107b2b:	e8 c0 f9 ff ff       	call   801074f0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107b30:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107b36:	eb 0f                	jmp    80107b47 <freevm+0x37>
80107b38:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b3f:	90                   	nop
80107b40:	83 c3 04             	add    $0x4,%ebx
80107b43:	39 df                	cmp    %ebx,%edi
80107b45:	74 23                	je     80107b6a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107b47:	8b 03                	mov    (%ebx),%eax
80107b49:	a8 01                	test   $0x1,%al
80107b4b:	74 f3                	je     80107b40 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b4d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107b52:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b55:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b58:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107b5d:	50                   	push   %eax
80107b5e:	e8 2d ae ff ff       	call   80102990 <kfree>
80107b63:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b66:	39 df                	cmp    %ebx,%edi
80107b68:	75 dd                	jne    80107b47 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107b6a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107b6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b70:	5b                   	pop    %ebx
80107b71:	5e                   	pop    %esi
80107b72:	5f                   	pop    %edi
80107b73:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107b74:	e9 17 ae ff ff       	jmp    80102990 <kfree>
    panic("freevm: no pgdir");
80107b79:	83 ec 0c             	sub    $0xc,%esp
80107b7c:	68 f9 88 10 80       	push   $0x801088f9
80107b81:	e8 fa 87 ff ff       	call   80100380 <panic>
80107b86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b8d:	8d 76 00             	lea    0x0(%esi),%esi

80107b90 <setupkvm>:
{
80107b90:	55                   	push   %ebp
80107b91:	89 e5                	mov    %esp,%ebp
80107b93:	56                   	push   %esi
80107b94:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107b95:	e8 b6 af ff ff       	call   80102b50 <kalloc>
80107b9a:	89 c6                	mov    %eax,%esi
80107b9c:	85 c0                	test   %eax,%eax
80107b9e:	74 42                	je     80107be2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107ba0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ba3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107ba8:	68 00 10 00 00       	push   $0x1000
80107bad:	6a 00                	push   $0x0
80107baf:	50                   	push   %eax
80107bb0:	e8 5b d5 ff ff       	call   80105110 <memset>
80107bb5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107bb8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107bbb:	83 ec 08             	sub    $0x8,%esp
80107bbe:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107bc1:	ff 73 0c             	pushl  0xc(%ebx)
80107bc4:	8b 13                	mov    (%ebx),%edx
80107bc6:	50                   	push   %eax
80107bc7:	29 c1                	sub    %eax,%ecx
80107bc9:	89 f0                	mov    %esi,%eax
80107bcb:	e8 d0 f9 ff ff       	call   801075a0 <mappages>
80107bd0:	83 c4 10             	add    $0x10,%esp
80107bd3:	85 c0                	test   %eax,%eax
80107bd5:	78 19                	js     80107bf0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107bd7:	83 c3 10             	add    $0x10,%ebx
80107bda:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107be0:	75 d6                	jne    80107bb8 <setupkvm+0x28>
}
80107be2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107be5:	89 f0                	mov    %esi,%eax
80107be7:	5b                   	pop    %ebx
80107be8:	5e                   	pop    %esi
80107be9:	5d                   	pop    %ebp
80107bea:	c3                   	ret    
80107beb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bef:	90                   	nop
      freevm(pgdir);
80107bf0:	83 ec 0c             	sub    $0xc,%esp
80107bf3:	56                   	push   %esi
      return 0;
80107bf4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107bf6:	e8 15 ff ff ff       	call   80107b10 <freevm>
      return 0;
80107bfb:	83 c4 10             	add    $0x10,%esp
}
80107bfe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c01:	89 f0                	mov    %esi,%eax
80107c03:	5b                   	pop    %ebx
80107c04:	5e                   	pop    %esi
80107c05:	5d                   	pop    %ebp
80107c06:	c3                   	ret    
80107c07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c0e:	66 90                	xchg   %ax,%ax

80107c10 <kvmalloc>:
{
80107c10:	55                   	push   %ebp
80107c11:	89 e5                	mov    %esp,%ebp
80107c13:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c16:	e8 75 ff ff ff       	call   80107b90 <setupkvm>
80107c1b:	a3 e4 5b 11 80       	mov    %eax,0x80115be4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107c20:	05 00 00 00 80       	add    $0x80000000,%eax
80107c25:	0f 22 d8             	mov    %eax,%cr3
}
80107c28:	c9                   	leave  
80107c29:	c3                   	ret    
80107c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c30 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107c30:	55                   	push   %ebp
80107c31:	89 e5                	mov    %esp,%ebp
80107c33:	83 ec 08             	sub    $0x8,%esp
80107c36:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107c39:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107c3c:	89 c1                	mov    %eax,%ecx
80107c3e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107c41:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c44:	f6 c2 01             	test   $0x1,%dl
80107c47:	75 17                	jne    80107c60 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107c49:	83 ec 0c             	sub    $0xc,%esp
80107c4c:	68 0a 89 10 80       	push   $0x8010890a
80107c51:	e8 2a 87 ff ff       	call   80100380 <panic>
80107c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c5d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107c60:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c63:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107c69:	25 fc 0f 00 00       	and    $0xffc,%eax
80107c6e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107c75:	85 c0                	test   %eax,%eax
80107c77:	74 d0                	je     80107c49 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107c79:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107c7c:	c9                   	leave  
80107c7d:	c3                   	ret    
80107c7e:	66 90                	xchg   %ax,%ax

80107c80 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107c80:	55                   	push   %ebp
80107c81:	89 e5                	mov    %esp,%ebp
80107c83:	57                   	push   %edi
80107c84:	56                   	push   %esi
80107c85:	53                   	push   %ebx
80107c86:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107c89:	e8 02 ff ff ff       	call   80107b90 <setupkvm>
80107c8e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c91:	85 c0                	test   %eax,%eax
80107c93:	0f 84 bd 00 00 00    	je     80107d56 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c99:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c9c:	85 c9                	test   %ecx,%ecx
80107c9e:	0f 84 b2 00 00 00    	je     80107d56 <copyuvm+0xd6>
80107ca4:	31 f6                	xor    %esi,%esi
80107ca6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cad:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107cb0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107cb3:	89 f0                	mov    %esi,%eax
80107cb5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107cb8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107cbb:	a8 01                	test   $0x1,%al
80107cbd:	75 11                	jne    80107cd0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107cbf:	83 ec 0c             	sub    $0xc,%esp
80107cc2:	68 14 89 10 80       	push   $0x80108914
80107cc7:	e8 b4 86 ff ff       	call   80100380 <panic>
80107ccc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107cd0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107cd2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107cd7:	c1 ea 0a             	shr    $0xa,%edx
80107cda:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107ce0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107ce7:	85 c0                	test   %eax,%eax
80107ce9:	74 d4                	je     80107cbf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107ceb:	8b 00                	mov    (%eax),%eax
80107ced:	a8 01                	test   $0x1,%al
80107cef:	0f 84 9f 00 00 00    	je     80107d94 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107cf5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107cf7:	25 ff 0f 00 00       	and    $0xfff,%eax
80107cfc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107cff:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107d05:	e8 46 ae ff ff       	call   80102b50 <kalloc>
80107d0a:	89 c3                	mov    %eax,%ebx
80107d0c:	85 c0                	test   %eax,%eax
80107d0e:	74 64                	je     80107d74 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107d10:	83 ec 04             	sub    $0x4,%esp
80107d13:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107d19:	68 00 10 00 00       	push   $0x1000
80107d1e:	57                   	push   %edi
80107d1f:	50                   	push   %eax
80107d20:	e8 8b d4 ff ff       	call   801051b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107d25:	58                   	pop    %eax
80107d26:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107d2c:	5a                   	pop    %edx
80107d2d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d30:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d35:	89 f2                	mov    %esi,%edx
80107d37:	50                   	push   %eax
80107d38:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d3b:	e8 60 f8 ff ff       	call   801075a0 <mappages>
80107d40:	83 c4 10             	add    $0x10,%esp
80107d43:	85 c0                	test   %eax,%eax
80107d45:	78 21                	js     80107d68 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107d47:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107d4d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d50:	0f 87 5a ff ff ff    	ja     80107cb0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107d56:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d59:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d5c:	5b                   	pop    %ebx
80107d5d:	5e                   	pop    %esi
80107d5e:	5f                   	pop    %edi
80107d5f:	5d                   	pop    %ebp
80107d60:	c3                   	ret    
80107d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107d68:	83 ec 0c             	sub    $0xc,%esp
80107d6b:	53                   	push   %ebx
80107d6c:	e8 1f ac ff ff       	call   80102990 <kfree>
      goto bad;
80107d71:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107d74:	83 ec 0c             	sub    $0xc,%esp
80107d77:	ff 75 e0             	pushl  -0x20(%ebp)
80107d7a:	e8 91 fd ff ff       	call   80107b10 <freevm>
  return 0;
80107d7f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d86:	83 c4 10             	add    $0x10,%esp
}
80107d89:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d8c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d8f:	5b                   	pop    %ebx
80107d90:	5e                   	pop    %esi
80107d91:	5f                   	pop    %edi
80107d92:	5d                   	pop    %ebp
80107d93:	c3                   	ret    
      panic("copyuvm: page not present");
80107d94:	83 ec 0c             	sub    $0xc,%esp
80107d97:	68 2e 89 10 80       	push   $0x8010892e
80107d9c:	e8 df 85 ff ff       	call   80100380 <panic>
80107da1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107da8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107daf:	90                   	nop

80107db0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107db0:	55                   	push   %ebp
80107db1:	89 e5                	mov    %esp,%ebp
80107db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107db6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107db9:	89 c1                	mov    %eax,%ecx
80107dbb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107dbe:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107dc1:	f6 c2 01             	test   $0x1,%dl
80107dc4:	0f 84 00 01 00 00    	je     80107eca <uva2ka.cold>
  return &pgtab[PTX(va)];
80107dca:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107dcd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107dd3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107dd4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107dd9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107de0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107de2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107de7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107dea:	05 00 00 00 80       	add    $0x80000000,%eax
80107def:	83 fa 05             	cmp    $0x5,%edx
80107df2:	ba 00 00 00 00       	mov    $0x0,%edx
80107df7:	0f 45 c2             	cmovne %edx,%eax
}
80107dfa:	c3                   	ret    
80107dfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107dff:	90                   	nop

80107e00 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107e00:	55                   	push   %ebp
80107e01:	89 e5                	mov    %esp,%ebp
80107e03:	57                   	push   %edi
80107e04:	56                   	push   %esi
80107e05:	53                   	push   %ebx
80107e06:	83 ec 0c             	sub    $0xc,%esp
80107e09:	8b 75 14             	mov    0x14(%ebp),%esi
80107e0c:	8b 45 0c             	mov    0xc(%ebp),%eax
80107e0f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107e12:	85 f6                	test   %esi,%esi
80107e14:	75 51                	jne    80107e67 <copyout+0x67>
80107e16:	e9 a5 00 00 00       	jmp    80107ec0 <copyout+0xc0>
80107e1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107e1f:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107e20:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107e26:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107e2c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107e32:	74 75                	je     80107ea9 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107e34:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107e36:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107e39:	29 c3                	sub    %eax,%ebx
80107e3b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e41:	39 f3                	cmp    %esi,%ebx
80107e43:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107e46:	29 f8                	sub    %edi,%eax
80107e48:	83 ec 04             	sub    $0x4,%esp
80107e4b:	01 c1                	add    %eax,%ecx
80107e4d:	53                   	push   %ebx
80107e4e:	52                   	push   %edx
80107e4f:	51                   	push   %ecx
80107e50:	e8 5b d3 ff ff       	call   801051b0 <memmove>
    len -= n;
    buf += n;
80107e55:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107e58:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107e5e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107e61:	01 da                	add    %ebx,%edx
  while(len > 0){
80107e63:	29 de                	sub    %ebx,%esi
80107e65:	74 59                	je     80107ec0 <copyout+0xc0>
  if(*pde & PTE_P){
80107e67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107e6a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107e6c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107e6e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107e71:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107e77:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107e7a:	f6 c1 01             	test   $0x1,%cl
80107e7d:	0f 84 4e 00 00 00    	je     80107ed1 <copyout.cold>
  return &pgtab[PTX(va)];
80107e83:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e85:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107e8b:	c1 eb 0c             	shr    $0xc,%ebx
80107e8e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107e94:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107e9b:	89 d9                	mov    %ebx,%ecx
80107e9d:	83 e1 05             	and    $0x5,%ecx
80107ea0:	83 f9 05             	cmp    $0x5,%ecx
80107ea3:	0f 84 77 ff ff ff    	je     80107e20 <copyout+0x20>
  }
  return 0;
}
80107ea9:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107eac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107eb1:	5b                   	pop    %ebx
80107eb2:	5e                   	pop    %esi
80107eb3:	5f                   	pop    %edi
80107eb4:	5d                   	pop    %ebp
80107eb5:	c3                   	ret    
80107eb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107ebd:	8d 76 00             	lea    0x0(%esi),%esi
80107ec0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107ec3:	31 c0                	xor    %eax,%eax
}
80107ec5:	5b                   	pop    %ebx
80107ec6:	5e                   	pop    %esi
80107ec7:	5f                   	pop    %edi
80107ec8:	5d                   	pop    %ebp
80107ec9:	c3                   	ret    

80107eca <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107eca:	a1 00 00 00 00       	mov    0x0,%eax
80107ecf:	0f 0b                	ud2    

80107ed1 <copyout.cold>:
80107ed1:	a1 00 00 00 00       	mov    0x0,%eax
80107ed6:	0f 0b                	ud2    
