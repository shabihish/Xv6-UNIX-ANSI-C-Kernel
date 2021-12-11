
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
8010004c:	68 c0 7e 10 80       	push   $0x80107ec0
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 f5 4d 00 00       	call   80104e50 <initlock>
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
80100092:	68 c7 7e 10 80       	push   $0x80107ec7
80100097:	50                   	push   %eax
80100098:	e8 83 4c 00 00       	call   80104d20 <initsleeplock>
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
801000e4:	e8 37 4f 00 00       	call   80105020 <acquire>
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
80100162:	e8 59 4e 00 00       	call   80104fc0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ee 4b 00 00       	call   80104d60 <acquiresleep>
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
801001a1:	68 ce 7e 10 80       	push   $0x80107ece
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
801001be:	e8 3d 4c 00 00       	call   80104e00 <holdingsleep>
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
801001dc:	68 df 7e 10 80       	push   $0x80107edf
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
801001ff:	e8 fc 4b 00 00       	call   80104e00 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 66                	je     80100271 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ac 4b 00 00       	call   80104dc0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 00 4e 00 00       	call   80105020 <acquire>
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
8010026c:	e9 4f 4d 00 00       	jmp    80104fc0 <release>
    panic("brelse");
80100271:	83 ec 0c             	sub    $0xc,%esp
80100274:	68 e6 7e 10 80       	push   $0x80107ee6
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
801002a0:	e8 7b 4d 00 00       	call   80105020 <acquire>
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
801002cd:	e8 de 45 00 00       	call   801048b0 <sleep>
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
801002f6:	e8 c5 4c 00 00       	call   80104fc0 <release>
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
8010034c:	e8 6f 4c 00 00       	call   80104fc0 <release>
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
801003a2:	68 ed 7e 10 80       	push   $0x80107eed
801003a7:	e8 f4 02 00 00       	call   801006a0 <cprintf>
    cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	pushl  0x8(%ebp)
801003b0:	e8 eb 02 00 00       	call   801006a0 <cprintf>
    cprintf("\n");
801003b5:	c7 04 24 9d 84 10 80 	movl   $0x8010849d,(%esp)
801003bc:	e8 df 02 00 00       	call   801006a0 <cprintf>
    getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 a3 4a 00 00       	call   80104e70 <getcallerpcs>
    for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
        cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	pushl  (%ebx)
    for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
        cprintf(" %p", pcs[i]);
801003d8:	68 01 7f 10 80       	push   $0x80107f01
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
8010041a:	e8 b1 65 00 00       	call   801069d0 <uartputc>
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
80100505:	e8 c6 64 00 00       	call   801069d0 <uartputc>
8010050a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100511:	e8 ba 64 00 00       	call   801069d0 <uartputc>
80100516:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010051d:	e8 ae 64 00 00       	call   801069d0 <uartputc>
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
80100551:	e8 2a 4c 00 00       	call   80105180 <memmove>
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100556:	b8 80 07 00 00       	mov    $0x780,%eax
8010055b:	83 c4 0c             	add    $0xc,%esp
8010055e:	29 d8                	sub    %ebx,%eax
80100560:	01 c0                	add    %eax,%eax
80100562:	50                   	push   %eax
80100563:	6a 00                	push   $0x0
80100565:	56                   	push   %esi
80100566:	e8 75 4b 00 00       	call   801050e0 <memset>
    outb(CRTPORT+1, pos);
8010056b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010056e:	83 c4 10             	add    $0x10,%esp
80100571:	e9 20 ff ff ff       	jmp    80100496 <consputc.part.0+0x96>
        panic("pos under/overflow");
80100576:	83 ec 0c             	sub    $0xc,%esp
80100579:	68 05 7f 10 80       	push   $0x80107f05
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
801005ab:	e8 70 4a 00 00       	call   80105020 <acquire>
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
801005e4:	e8 d7 49 00 00       	call   80104fc0 <release>
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
80100636:	0f b6 92 88 7f 10 80 	movzbl -0x7fef8078(%edx),%edx
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
801007e8:	e8 33 48 00 00       	call   80105020 <acquire>
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
80100838:	bf 18 7f 10 80       	mov    $0x80107f18,%edi
                for(; *s; s++)
8010083d:	b8 28 00 00 00       	mov    $0x28,%eax
80100842:	e9 19 ff ff ff       	jmp    80100760 <cprintf+0xc0>
80100847:	89 d0                	mov    %edx,%eax
80100849:	e8 b2 fb ff ff       	call   80100400 <consputc.part.0>
8010084e:	e9 c8 fe ff ff       	jmp    8010071b <cprintf+0x7b>
        release(&cons.lock);
80100853:	83 ec 0c             	sub    $0xc,%esp
80100856:	68 20 ff 10 80       	push   $0x8010ff20
8010085b:	e8 60 47 00 00       	call   80104fc0 <release>
80100860:	83 c4 10             	add    $0x10,%esp
}
80100863:	e9 c9 fe ff ff       	jmp    80100731 <cprintf+0x91>
                if((s = (char*)*argp++) == 0)
80100868:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010086b:	e9 ab fe ff ff       	jmp    8010071b <cprintf+0x7b>
        panic("null fmt");
80100870:	83 ec 0c             	sub    $0xc,%esp
80100873:	68 1f 7f 10 80       	push   $0x80107f1f
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
80100b84:	e8 97 44 00 00       	call   80105020 <acquire>
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
80100bb3:	ff 24 85 30 7f 10 80 	jmp    *-0x7fef80d0(,%eax,4)
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
80100c28:	e8 93 43 00 00       	call   80104fc0 <release>
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
80100e9c:	e9 af 3b 00 00       	jmp    80104a50 <procdump>
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
80100ef5:	e8 76 3a 00 00       	call   80104970 <wakeup>
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
80100f26:	68 28 7f 10 80       	push   $0x80107f28
80100f2b:	68 20 ff 10 80       	push   $0x8010ff20
80100f30:	e8 1b 3f 00 00       	call   80104e50 <initlock>

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
80100ff4:	e8 67 6b 00 00       	call   80107b60 <setupkvm>
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
80101063:	e8 18 69 00 00       	call   80107980 <allocuvm>
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
80101099:	e8 f2 67 00 00       	call   80107890 <loaduvm>
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
801010db:	e8 00 6a 00 00       	call   80107ae0 <freevm>
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
80101122:	e8 59 68 00 00       	call   80107980 <allocuvm>
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
80101143:	e8 b8 6a 00 00       	call   80107c00 <clearpteu>
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
80101193:	e8 48 41 00 00       	call   801052e0 <strlen>
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
801011a7:	e8 34 41 00 00       	call   801052e0 <strlen>
801011ac:	83 c0 01             	add    $0x1,%eax
801011af:	50                   	push   %eax
801011b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801011b3:	ff 34 b8             	pushl  (%eax,%edi,4)
801011b6:	53                   	push   %ebx
801011b7:	56                   	push   %esi
801011b8:	e8 13 6c 00 00       	call   80107dd0 <copyout>
801011bd:	83 c4 20             	add    $0x20,%esp
801011c0:	85 c0                	test   %eax,%eax
801011c2:	79 ac                	jns    80101170 <exec+0x200>
801011c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    freevm(pgdir);
801011c8:	83 ec 0c             	sub    $0xc,%esp
801011cb:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011d1:	e8 0a 69 00 00       	call   80107ae0 <freevm>
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
80101223:	e8 a8 6b 00 00       	call   80107dd0 <copyout>
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
80101261:	e8 3a 40 00 00       	call   801052a0 <safestrcpy>
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
8010128d:	e8 6e 64 00 00       	call   80107700 <switchuvm>
  freevm(oldpgdir);
80101292:	89 3c 24             	mov    %edi,(%esp)
80101295:	e8 46 68 00 00       	call   80107ae0 <freevm>
  return 0;
8010129a:	83 c4 10             	add    $0x10,%esp
8010129d:	31 c0                	xor    %eax,%eax
8010129f:	e9 38 fd ff ff       	jmp    80100fdc <exec+0x6c>
    end_op();
801012a4:	e8 f7 1f 00 00       	call   801032a0 <end_op>
    cprintf("exec: fail\n");
801012a9:	83 ec 0c             	sub    $0xc,%esp
801012ac:	68 99 7f 10 80       	push   $0x80107f99
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
801012d6:	68 a5 7f 10 80       	push   $0x80107fa5
801012db:	68 60 ff 10 80       	push   $0x8010ff60
801012e0:	e8 6b 3b 00 00       	call   80104e50 <initlock>
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
80101301:	e8 1a 3d 00 00       	call   80105020 <acquire>
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
80101331:	e8 8a 3c 00 00       	call   80104fc0 <release>
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
8010134a:	e8 71 3c 00 00       	call   80104fc0 <release>
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
8010136f:	e8 ac 3c 00 00       	call   80105020 <acquire>
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
8010138c:	e8 2f 3c 00 00       	call   80104fc0 <release>
  return f;
}
80101391:	89 d8                	mov    %ebx,%eax
80101393:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101396:	c9                   	leave  
80101397:	c3                   	ret    
    panic("filedup");
80101398:	83 ec 0c             	sub    $0xc,%esp
8010139b:	68 ac 7f 10 80       	push   $0x80107fac
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
801013c1:	e8 5a 3c 00 00       	call   80105020 <acquire>
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
801013fc:	e8 bf 3b 00 00       	call   80104fc0 <release>

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
8010142e:	e9 8d 3b 00 00       	jmp    80104fc0 <release>
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
8010147c:	68 b4 7f 10 80       	push   $0x80107fb4
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
80101562:	68 be 7f 10 80       	push   $0x80107fbe
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
80101637:	68 c7 7f 10 80       	push   $0x80107fc7
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
80101671:	68 cd 7f 10 80       	push   $0x80107fcd
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
801016e7:	68 d7 7f 10 80       	push   $0x80107fd7
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
801017a4:	68 ea 7f 10 80       	push   $0x80107fea
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
801017e5:	e8 f6 38 00 00       	call   801050e0 <memset>
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
8010182a:	e8 f1 37 00 00       	call   80105020 <acquire>
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
80101897:	e8 24 37 00 00       	call   80104fc0 <release>

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
801018c5:	e8 f6 36 00 00       	call   80104fc0 <release>
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
801018f8:	68 00 80 10 80       	push   $0x80108000
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
801019d5:	68 10 80 10 80       	push   $0x80108010
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
80101a01:	e8 7a 37 00 00       	call   80105180 <memmove>
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
80101a2c:	68 23 80 10 80       	push   $0x80108023
80101a31:	68 60 09 11 80       	push   $0x80110960
80101a36:	e8 15 34 00 00       	call   80104e50 <initlock>
  for(i = 0; i < NINODE; i++) {
80101a3b:	83 c4 10             	add    $0x10,%esp
80101a3e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101a40:	83 ec 08             	sub    $0x8,%esp
80101a43:	68 2a 80 10 80       	push   $0x8010802a
80101a48:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101a49:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101a4f:	e8 cc 32 00 00       	call   80104d20 <initsleeplock>
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
80101a7c:	e8 ff 36 00 00       	call   80105180 <memmove>
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
80101ab3:	68 90 80 10 80       	push   $0x80108090
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
80101b4e:	e8 8d 35 00 00       	call   801050e0 <memset>
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
80101b83:	68 30 80 10 80       	push   $0x80108030
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
80101bf1:	e8 8a 35 00 00       	call   80105180 <memmove>
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
80101c1f:	e8 fc 33 00 00       	call   80105020 <acquire>
  ip->ref++;
80101c24:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c28:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101c2f:	e8 8c 33 00 00       	call   80104fc0 <release>
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
80101c62:	e8 f9 30 00 00       	call   80104d60 <acquiresleep>
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
80101cd8:	e8 a3 34 00 00       	call   80105180 <memmove>
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
80101cfd:	68 48 80 10 80       	push   $0x80108048
80101d02:	e8 79 e6 ff ff       	call   80100380 <panic>
    panic("ilock");
80101d07:	83 ec 0c             	sub    $0xc,%esp
80101d0a:	68 42 80 10 80       	push   $0x80108042
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
80101d33:	e8 c8 30 00 00       	call   80104e00 <holdingsleep>
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
80101d4f:	e9 6c 30 00 00       	jmp    80104dc0 <releasesleep>
    panic("iunlock");
80101d54:	83 ec 0c             	sub    $0xc,%esp
80101d57:	68 57 80 10 80       	push   $0x80108057
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
80101d80:	e8 db 2f 00 00       	call   80104d60 <acquiresleep>
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
80101d9a:	e8 21 30 00 00       	call   80104dc0 <releasesleep>
  acquire(&icache.lock);
80101d9f:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101da6:	e8 75 32 00 00       	call   80105020 <acquire>
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
80101dc0:	e9 fb 31 00 00       	jmp    80104fc0 <release>
80101dc5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101dc8:	83 ec 0c             	sub    $0xc,%esp
80101dcb:	68 60 09 11 80       	push   $0x80110960
80101dd0:	e8 4b 32 00 00       	call   80105020 <acquire>
    int r = ip->ref;
80101dd5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101dd8:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
80101ddf:	e8 dc 31 00 00       	call   80104fc0 <release>
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
80101ee3:	e8 18 2f 00 00       	call   80104e00 <holdingsleep>
80101ee8:	83 c4 10             	add    $0x10,%esp
80101eeb:	85 c0                	test   %eax,%eax
80101eed:	74 21                	je     80101f10 <iunlockput+0x40>
80101eef:	8b 43 08             	mov    0x8(%ebx),%eax
80101ef2:	85 c0                	test   %eax,%eax
80101ef4:	7e 1a                	jle    80101f10 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101ef6:	83 ec 0c             	sub    $0xc,%esp
80101ef9:	56                   	push   %esi
80101efa:	e8 c1 2e 00 00       	call   80104dc0 <releasesleep>
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
80101f13:	68 57 80 10 80       	push   $0x80108057
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
80101ff7:	e8 84 31 00 00       	call   80105180 <memmove>
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
801020f3:	e8 88 30 00 00       	call   80105180 <memmove>
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
8010218e:	e8 5d 30 00 00       	call   801051f0 <strncmp>
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
801021ed:	e8 fe 2f 00 00       	call   801051f0 <strncmp>
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
80102232:	68 71 80 10 80       	push   $0x80108071
80102237:	e8 44 e1 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
8010223c:	83 ec 0c             	sub    $0xc,%esp
8010223f:	68 5f 80 10 80       	push   $0x8010805f
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
8010227a:	e8 a1 2d 00 00       	call   80105020 <acquire>
  ip->ref++;
8010227f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102283:	c7 04 24 60 09 11 80 	movl   $0x80110960,(%esp)
8010228a:	e8 31 2d 00 00       	call   80104fc0 <release>
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
801022e7:	e8 94 2e 00 00       	call   80105180 <memmove>
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
8010234c:	e8 af 2a 00 00       	call   80104e00 <holdingsleep>
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
8010236e:	e8 4d 2a 00 00       	call   80104dc0 <releasesleep>
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
8010239b:	e8 e0 2d 00 00       	call   80105180 <memmove>
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
801023eb:	e8 10 2a 00 00       	call   80104e00 <holdingsleep>
801023f0:	83 c4 10             	add    $0x10,%esp
801023f3:	85 c0                	test   %eax,%eax
801023f5:	0f 84 91 00 00 00    	je     8010248c <namex+0x23c>
801023fb:	8b 46 08             	mov    0x8(%esi),%eax
801023fe:	85 c0                	test   %eax,%eax
80102400:	0f 8e 86 00 00 00    	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102406:	83 ec 0c             	sub    $0xc,%esp
80102409:	53                   	push   %ebx
8010240a:	e8 b1 29 00 00       	call   80104dc0 <releasesleep>
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
8010242d:	e8 ce 29 00 00       	call   80104e00 <holdingsleep>
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
80102450:	e8 ab 29 00 00       	call   80104e00 <holdingsleep>
80102455:	83 c4 10             	add    $0x10,%esp
80102458:	85 c0                	test   %eax,%eax
8010245a:	74 30                	je     8010248c <namex+0x23c>
8010245c:	8b 7e 08             	mov    0x8(%esi),%edi
8010245f:	85 ff                	test   %edi,%edi
80102461:	7e 29                	jle    8010248c <namex+0x23c>
  releasesleep(&ip->lock);
80102463:	83 ec 0c             	sub    $0xc,%esp
80102466:	53                   	push   %ebx
80102467:	e8 54 29 00 00       	call   80104dc0 <releasesleep>
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
8010248f:	68 57 80 10 80       	push   $0x80108057
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
801024fd:	e8 3e 2d 00 00       	call   80105240 <strncpy>
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
8010253b:	68 80 80 10 80       	push   $0x80108080
80102540:	e8 3b de ff ff       	call   80100380 <panic>
    panic("dirlink");
80102545:	83 ec 0c             	sub    $0xc,%esp
80102548:	68 ba 86 10 80       	push   $0x801086ba
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
8010266b:	68 ec 80 10 80       	push   $0x801080ec
80102670:	e8 0b dd ff ff       	call   80100380 <panic>
    panic("idestart");
80102675:	83 ec 0c             	sub    $0xc,%esp
80102678:	68 e3 80 10 80       	push   $0x801080e3
8010267d:	e8 fe dc ff ff       	call   80100380 <panic>
80102682:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102690 <ideinit>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102696:	68 fe 80 10 80       	push   $0x801080fe
8010269b:	68 00 26 11 80       	push   $0x80112600
801026a0:	e8 ab 27 00 00       	call   80104e50 <initlock>
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
8010271e:	e8 fd 28 00 00       	call   80105020 <acquire>

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
8010277d:	e8 ee 21 00 00       	call   80104970 <wakeup>

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
8010279b:	e8 20 28 00 00       	call   80104fc0 <release>

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
801027be:	e8 3d 26 00 00       	call   80104e00 <holdingsleep>
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
801027f8:	e8 23 28 00 00       	call   80105020 <acquire>

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
80102839:	e8 72 20 00 00       	call   801048b0 <sleep>
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
80102856:	e9 65 27 00 00       	jmp    80104fc0 <release>
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
8010287a:	68 2d 81 10 80       	push   $0x8010812d
8010287f:	e8 fc da ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102884:	83 ec 0c             	sub    $0xc,%esp
80102887:	68 18 81 10 80       	push   $0x80108118
8010288c:	e8 ef da ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102891:	83 ec 0c             	sub    $0xc,%esp
80102894:	68 02 81 10 80       	push   $0x80108102
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
801028ea:	68 4c 81 10 80       	push   $0x8010814c
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
801029c2:	e8 19 27 00 00       	call   801050e0 <memset>

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
801029f8:	e8 23 26 00 00       	call   80105020 <acquire>
801029fd:	83 c4 10             	add    $0x10,%esp
80102a00:	eb d2                	jmp    801029d4 <kfree+0x44>
80102a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102a08:	c7 45 08 40 26 11 80 	movl   $0x80112640,0x8(%ebp)
}
80102a0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a12:	c9                   	leave  
    release(&kmem.lock);
80102a13:	e9 a8 25 00 00       	jmp    80104fc0 <release>
    panic("kfree");
80102a18:	83 ec 0c             	sub    $0xc,%esp
80102a1b:	68 7e 81 10 80       	push   $0x8010817e
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
80102aeb:	68 84 81 10 80       	push   $0x80108184
80102af0:	68 40 26 11 80       	push   $0x80112640
80102af5:	e8 56 23 00 00       	call   80104e50 <initlock>
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
80102b83:	e8 98 24 00 00       	call   80105020 <acquire>
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
80102bb1:	e8 0a 24 00 00       	call   80104fc0 <release>
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
80102bfb:	0f b6 91 c0 82 10 80 	movzbl -0x7fef7d40(%ecx),%edx
  shift ^= togglecode[data];
80102c02:	0f b6 81 c0 81 10 80 	movzbl -0x7fef7e40(%ecx),%eax
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
80102c1b:	8b 04 85 a0 81 10 80 	mov    -0x7fef7e60(,%eax,4),%eax
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
80102c58:	0f b6 81 c0 82 10 80 	movzbl -0x7fef7d40(%ecx),%eax
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
80102fc7:	e8 64 21 00 00       	call   80105130 <memcmp>
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
801030f4:	e8 87 20 00 00       	call   80105180 <memmove>
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
8010319a:	68 c0 83 10 80       	push   $0x801083c0
8010319f:	68 a0 26 11 80       	push   $0x801126a0
801031a4:	e8 a7 1c 00 00       	call   80104e50 <initlock>
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
8010323b:	e8 e0 1d 00 00       	call   80105020 <acquire>
80103240:	83 c4 10             	add    $0x10,%esp
80103243:	eb 18                	jmp    8010325d <begin_op+0x2d>
80103245:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103248:	83 ec 08             	sub    $0x8,%esp
8010324b:	68 a0 26 11 80       	push   $0x801126a0
80103250:	68 a0 26 11 80       	push   $0x801126a0
80103255:	e8 56 16 00 00       	call   801048b0 <sleep>
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
8010328c:	e8 2f 1d 00 00       	call   80104fc0 <release>
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
801032ae:	e8 6d 1d 00 00       	call   80105020 <acquire>
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
801032ec:	e8 cf 1c 00 00       	call   80104fc0 <release>
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
80103306:	e8 15 1d 00 00       	call   80105020 <acquire>
    wakeup(&log);
8010330b:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
    log.committing = 0;
80103312:	c7 05 e0 26 11 80 00 	movl   $0x0,0x801126e0
80103319:	00 00 00 
    wakeup(&log);
8010331c:	e8 4f 16 00 00       	call   80104970 <wakeup>
    release(&log.lock);
80103321:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
80103328:	e8 93 1c 00 00       	call   80104fc0 <release>
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
80103384:	e8 f7 1d 00 00       	call   80105180 <memmove>
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
801033d8:	e8 93 15 00 00       	call   80104970 <wakeup>
  release(&log.lock);
801033dd:	c7 04 24 a0 26 11 80 	movl   $0x801126a0,(%esp)
801033e4:	e8 d7 1b 00 00       	call   80104fc0 <release>
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
801033f7:	68 c4 83 10 80       	push   $0x801083c4
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
80103446:	e8 d5 1b 00 00       	call   80105020 <acquire>
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
80103485:	e9 36 1b 00 00       	jmp    80104fc0 <release>
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
801034b1:	68 d3 83 10 80       	push   $0x801083d3
801034b6:	e8 c5 ce ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
801034bb:	83 ec 0c             	sub    $0xc,%esp
801034be:	68 e9 83 10 80       	push   $0x801083e9
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
801034e8:	68 04 84 10 80       	push   $0x80108404
801034ed:	e8 ae d1 ff ff       	call   801006a0 <cprintf>
  idtinit();       // load idt register
801034f2:	e8 e9 30 00 00       	call   801065e0 <idtinit>
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
8010350a:	e8 f1 0e 00 00       	call   80104400 <scheduler>
8010350f:	90                   	nop

80103510 <mpenter>:
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103516:	e8 d5 41 00 00       	call   801076f0 <switchkvm>
  seginit();
8010351b:	e8 40 41 00 00       	call   80107660 <seginit>
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
80103551:	e8 8a 46 00 00       	call   80107be0 <kvmalloc>
  mpinit();        // detect other processors
80103556:	e8 85 01 00 00       	call   801036e0 <mpinit>
  lapicinit();     // interrupt controller
8010355b:	e8 60 f7 ff ff       	call   80102cc0 <lapicinit>
  seginit();       // segment descriptors
80103560:	e8 fb 40 00 00       	call   80107660 <seginit>
  picinit();       // disable pic
80103565:	e8 76 03 00 00       	call   801038e0 <picinit>
  ioapicinit();    // another interrupt controller
8010356a:	e8 31 f3 ff ff       	call   801028a0 <ioapicinit>
  consoleinit();   // console hardware
8010356f:	e8 ac d9 ff ff       	call   80100f20 <consoleinit>
  uartinit();      // serial port
80103574:	e8 57 33 00 00       	call   801068d0 <uartinit>
  pinit();         // process table
80103579:	e8 72 08 00 00       	call   80103df0 <pinit>
  tvinit();        // trap vectors
8010357e:	e8 dd 2f 00 00       	call   80106560 <tvinit>
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
801035a4:	e8 d7 1b 00 00       	call   80105180 <memmove>

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
8010368e:	68 18 84 10 80       	push   $0x80108418
80103693:	56                   	push   %esi
80103694:	e8 97 1a 00 00       	call   80105130 <memcmp>
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
80103746:	68 1d 84 10 80       	push   $0x8010841d
8010374b:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010374c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
8010374f:	e8 dc 19 00 00       	call   80105130 <memcmp>
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
80103863:	68 22 84 10 80       	push   $0x80108422
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
80103892:	68 18 84 10 80       	push   $0x80108418
80103897:	53                   	push   %ebx
80103898:	e8 93 18 00 00       	call   80105130 <memcmp>
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
801038c8:	68 3c 84 10 80       	push   $0x8010843c
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
80103973:	68 5b 84 10 80       	push   $0x8010845b
80103978:	50                   	push   %eax
80103979:	e8 d2 14 00 00       	call   80104e50 <initlock>
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
80103a0f:	e8 0c 16 00 00       	call   80105020 <acquire>
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
80103a2f:	e8 3c 0f 00 00       	call   80104970 <wakeup>
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
80103a54:	e9 67 15 00 00       	jmp    80104fc0 <release>
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	53                   	push   %ebx
80103a64:	e8 57 15 00 00       	call   80104fc0 <release>
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
80103a94:	e8 d7 0e 00 00       	call   80104970 <wakeup>
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
80103aad:	e8 6e 15 00 00       	call   80105020 <acquire>
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
80103b08:	e8 63 0e 00 00       	call   80104970 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103b0d:	58                   	pop    %eax
80103b0e:	5a                   	pop    %edx
80103b0f:	53                   	push   %ebx
80103b10:	56                   	push   %esi
80103b11:	e8 9a 0d 00 00       	call   801048b0 <sleep>
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
80103b3c:	e8 7f 14 00 00       	call   80104fc0 <release>
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
80103b8a:	e8 e1 0d 00 00       	call   80104970 <wakeup>
  release(&p->lock);
80103b8f:	89 1c 24             	mov    %ebx,(%esp)
80103b92:	e8 29 14 00 00       	call   80104fc0 <release>
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
80103bb6:	e8 65 14 00 00       	call   80105020 <acquire>
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
80103be5:	e8 c6 0c 00 00       	call   801048b0 <sleep>
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
80103c46:	e8 25 0d 00 00       	call   80104970 <wakeup>
  release(&p->lock);
80103c4b:	89 34 24             	mov    %esi,(%esp)
80103c4e:	e8 6d 13 00 00       	call   80104fc0 <release>
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
80103c69:	e8 52 13 00 00       	call   80104fc0 <release>
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
80103c91:	e8 8a 13 00 00       	call   80105020 <acquire>
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
80103d1e:	e8 9d 12 00 00       	call   80104fc0 <release>

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
80103d43:	c7 40 14 4f 65 10 80 	movl   $0x8010654f,0x14(%eax)
  p->context = (struct context*)sp;
80103d4a:	89 43 20             	mov    %eax,0x20(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d4d:	6a 14                	push   $0x14
80103d4f:	6a 00                	push   $0x0
80103d51:	50                   	push   %eax
80103d52:	e8 89 13 00 00       	call   801050e0 <memset>
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
80103d7a:	e8 41 12 00 00       	call   80104fc0 <release>
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
80103dab:	e8 10 12 00 00       	call   80104fc0 <release>

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
80103df6:	68 60 84 10 80       	push   $0x80108460
80103dfb:	68 40 2d 11 80       	push   $0x80112d40
80103e00:	e8 4b 10 00 00       	call   80104e50 <initlock>
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
80103e58:	68 67 84 10 80       	push   $0x80108467
80103e5d:	e8 1e c5 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e62:	83 ec 0c             	sub    $0xc,%esp
80103e65:	68 64 85 10 80       	push   $0x80108564
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
80103e97:	e8 34 10 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80103e9c:	e8 6f ff ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80103ea1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea7:	e8 74 10 00 00       	call   80104f20 <popcli>
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
80103ed3:	e8 88 3c 00 00       	call   80107b60 <setupkvm>
80103ed8:	89 43 04             	mov    %eax,0x4(%ebx)
80103edb:	85 c0                	test   %eax,%eax
80103edd:	0f 84 d6 00 00 00    	je     80103fb9 <userinit+0xf9>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ee3:	83 ec 04             	sub    $0x4,%esp
80103ee6:	68 2c 00 00 00       	push   $0x2c
80103eeb:	68 60 b4 10 80       	push   $0x8010b460
80103ef0:	50                   	push   %eax
80103ef1:	e8 1a 39 00 00       	call   80107810 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ef6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ef9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103eff:	6a 4c                	push   $0x4c
80103f01:	6a 00                	push   $0x0
80103f03:	ff 73 1c             	pushl  0x1c(%ebx)
80103f06:	e8 d5 11 00 00       	call   801050e0 <memset>
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
80103f66:	68 90 84 10 80       	push   $0x80108490
80103f6b:	e8 30 c7 ff ff       	call   801006a0 <cprintf>
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f70:	83 c4 0c             	add    $0xc,%esp
80103f73:	8d 43 70             	lea    0x70(%ebx),%eax
80103f76:	6a 10                	push   $0x10
80103f78:	68 9f 84 10 80       	push   $0x8010849f
80103f7d:	50                   	push   %eax
80103f7e:	e8 1d 13 00 00       	call   801052a0 <safestrcpy>
  p->cwd = namei("/");
80103f83:	c7 04 24 a8 84 10 80 	movl   $0x801084a8,(%esp)
80103f8a:	e8 d1 e5 ff ff       	call   80102560 <namei>
80103f8f:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103f92:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103f99:	e8 82 10 00 00       	call   80105020 <acquire>
  p->state = RUNNABLE;
80103f9e:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fa5:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80103fac:	e8 0f 10 00 00       	call   80104fc0 <release>
}
80103fb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb4:	83 c4 10             	add    $0x10,%esp
80103fb7:	c9                   	leave  
80103fb8:	c3                   	ret    
    panic("userinit: out of memory?");
80103fb9:	83 ec 0c             	sub    $0xc,%esp
80103fbc:	68 77 84 10 80       	push   $0x80108477
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
80103fd8:	e8 f3 0e 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80103fdd:	e8 2e fe ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80103fe2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fe8:	e8 33 0f 00 00       	call   80104f20 <popcli>
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
80103ffb:	e8 00 37 00 00       	call   80107700 <switchuvm>
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
8010401a:	e8 61 39 00 00       	call   80107980 <allocuvm>
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
8010403a:	e8 71 3a 00 00       	call   80107ab0 <deallocuvm>
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
80104059:	e8 72 0e 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
8010405e:	e8 ad fd ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104063:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104069:	e8 b2 0e 00 00       	call   80104f20 <popcli>
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
80104088:	e8 c3 3b 00 00       	call   80107c50 <copyuvm>
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
80104111:	e8 8a 11 00 00       	call   801052a0 <safestrcpy>
  pid = np->pid;
80104116:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104119:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104120:	e8 fb 0e 00 00       	call   80105020 <acquire>
  np->state = RUNNABLE;
80104125:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010412c:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104133:	e8 88 0e 00 00       	call   80104fc0 <release>
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
80104193:	e8 88 0e 00 00       	call   80105020 <acquire>
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
801041c4:	e9 f7 0d 00 00       	jmp    80104fc0 <release>
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
801041e0:	e8 3b 0e 00 00       	call   80105020 <acquire>
  int current = ticks;
801041e5:	8b 35 80 53 11 80    	mov    0x80115380,%esi
  release(&tickslock);
801041eb:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
801041f2:	e8 c9 0d 00 00       	call   80104fc0 <release>
  float waiting_time = (float)(current - p->arrival_time);
801041f7:	89 f0                	mov    %esi,%eax
801041f9:	2b 83 90 00 00 00    	sub    0x90(%ebx),%eax
  cprintf("waiting time : %f\n", waiting_time);
801041ff:	c7 04 24 aa 84 10 80 	movl   $0x801084aa,(%esp)
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
8010422f:	d8 0d a4 85 10 80    	fmuls  0x801085a4
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
8010424f:	d9 05 a8 85 10 80    	flds   0x801085a8
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
801043ba:	74 38                	je     801043f4 <aging+0x54>
      if(p -> state == RUNNABLE && p -> level == 2){
801043bc:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801043c0:	75 ee                	jne    801043b0 <aging+0x10>
801043c2:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
801043c9:	75 e5                	jne    801043b0 <aging+0x10>
          if(ticks - p->last_execution >= 8000)
801043cb:	89 ca                	mov    %ecx,%edx
801043cd:	2b 90 94 00 00 00    	sub    0x94(%eax),%edx
801043d3:	81 fa 3f 1f 00 00    	cmp    $0x1f3f,%edx
801043d9:	76 d5                	jbe    801043b0 <aging+0x10>
            p->level = 1;
801043db:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
801043e2:	00 00 00 
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043e5:	05 98 00 00 00       	add    $0x98,%eax
            p->last_execution = ticks;
801043ea:	89 48 fc             	mov    %ecx,-0x4(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043ed:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801043f2:	75 c8                	jne    801043bc <aging+0x1c>
}
801043f4:	c3                   	ret    
801043f5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104400 <scheduler>:
{
80104400:	55                   	push   %ebp
80104401:	89 e5                	mov    %esp,%ebp
80104403:	57                   	push   %edi
80104404:	56                   	push   %esi
80104405:	53                   	push   %ebx
80104406:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104409:	e8 02 fa ff ff       	call   80103e10 <mycpu>
  c->proc = 0;
8010440e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104415:	00 00 00 
  struct cpu *c = mycpu();
80104418:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
8010441a:	8d 70 04             	lea    0x4(%eax),%esi
8010441d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104420:	fb                   	sti    
    acquire(&ptable.lock);
80104421:	83 ec 0c             	sub    $0xc,%esp
80104424:	68 40 2d 11 80       	push   $0x80112d40
80104429:	e8 f2 0b 00 00       	call   80105020 <acquire>
     p = RR();
8010442e:	e8 8d fe ff ff       	call   801042c0 <RR>
     if(p == 0)
80104433:	83 c4 10             	add    $0x10,%esp
     p = RR();
80104436:	89 c7                	mov    %eax,%edi
     if(p == 0)
80104438:	85 c0                	test   %eax,%eax
8010443a:	74 54                	je     80104490 <scheduler+0x90>
    switchuvm(p);
8010443c:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
8010443f:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
    switchuvm(p);
80104445:	57                   	push   %edi
80104446:	e8 b5 32 00 00       	call   80107700 <switchuvm>
    p->last_execution = ticks;
8010444b:	a1 80 53 11 80       	mov    0x80115380,%eax
    p->state = RUNNING;
80104450:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
    p->last_execution = ticks;
80104457:	89 87 94 00 00 00    	mov    %eax,0x94(%edi)
    swtch(&(c->scheduler), p->context);
8010445d:	58                   	pop    %eax
8010445e:	5a                   	pop    %edx
8010445f:	ff 77 20             	pushl  0x20(%edi)
80104462:	56                   	push   %esi
80104463:	e8 9b 0e 00 00       	call   80105303 <swtch>
    switchkvm();
80104468:	e8 83 32 00 00       	call   801076f0 <switchkvm>
    c->proc = 0;
8010446d:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
80104474:	00 00 00 
    release(&ptable.lock);
80104477:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010447e:	e8 3d 0b 00 00       	call   80104fc0 <release>
80104483:	83 c4 10             	add    $0x10,%esp
80104486:	eb 98                	jmp    80104420 <scheduler+0x20>
80104488:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010448f:	90                   	nop
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104490:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104495:	eb 17                	jmp    801044ae <scheduler+0xae>
80104497:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010449e:	66 90                	xchg   %ax,%ax
801044a0:	81 c2 98 00 00 00    	add    $0x98,%edx
801044a6:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
801044ac:	74 32                	je     801044e0 <scheduler+0xe0>
      if(p -> state == RUNNABLE && p -> level == 2){
801044ae:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
801044b2:	75 ec                	jne    801044a0 <scheduler+0xa0>
801044b4:	83 ba 80 00 00 00 02 	cmpl   $0x2,0x80(%edx)
801044bb:	75 e3                	jne    801044a0 <scheduler+0xa0>
          if(latest_p != 0){
801044bd:	85 ff                	test   %edi,%edi
801044bf:	74 4f                	je     80104510 <scheduler+0x110>
              if(p->arrival_time > latest_p->arrival_time)
801044c1:	8b 87 90 00 00 00    	mov    0x90(%edi),%eax
801044c7:	39 82 90 00 00 00    	cmp    %eax,0x90(%edx)
801044cd:	0f 4f fa             	cmovg  %edx,%edi
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801044d0:	81 c2 98 00 00 00    	add    $0x98,%edx
801044d6:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
801044dc:	75 d0                	jne    801044ae <scheduler+0xae>
801044de:	66 90                	xchg   %ax,%ax
     if(p == 0)
801044e0:	85 ff                	test   %edi,%edi
801044e2:	0f 85 54 ff ff ff    	jne    8010443c <scheduler+0x3c>
       p = HRRN();
801044e8:	e8 53 fd ff ff       	call   80104240 <HRRN>
801044ed:	89 c7                	mov    %eax,%edi
     if(p == 0){
801044ef:	85 c0                	test   %eax,%eax
801044f1:	0f 85 45 ff ff ff    	jne    8010443c <scheduler+0x3c>
         release(&ptable.lock);
801044f7:	83 ec 0c             	sub    $0xc,%esp
801044fa:	68 40 2d 11 80       	push   $0x80112d40
801044ff:	e8 bc 0a 00 00       	call   80104fc0 <release>
         continue;
80104504:	83 c4 10             	add    $0x10,%esp
80104507:	e9 14 ff ff ff       	jmp    80104420 <scheduler+0x20>
8010450c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104510:	89 d7                	mov    %edx,%edi
80104512:	eb 8c                	jmp    801044a0 <scheduler+0xa0>
80104514:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010451b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010451f:	90                   	nop

80104520 <sched>:
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	56                   	push   %esi
80104524:	53                   	push   %ebx
  pushcli();
80104525:	e8 a6 09 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
8010452a:	e8 e1 f8 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
8010452f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104535:	e8 e6 09 00 00       	call   80104f20 <popcli>
  if(!holding(&ptable.lock))
8010453a:	83 ec 0c             	sub    $0xc,%esp
8010453d:	68 40 2d 11 80       	push   $0x80112d40
80104542:	e8 39 0a 00 00       	call   80104f80 <holding>
80104547:	83 c4 10             	add    $0x10,%esp
8010454a:	85 c0                	test   %eax,%eax
8010454c:	74 4f                	je     8010459d <sched+0x7d>
  if(mycpu()->ncli != 1)
8010454e:	e8 bd f8 ff ff       	call   80103e10 <mycpu>
80104553:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010455a:	75 68                	jne    801045c4 <sched+0xa4>
  if(p->state == RUNNING)
8010455c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104560:	74 55                	je     801045b7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104562:	9c                   	pushf  
80104563:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104564:	f6 c4 02             	test   $0x2,%ah
80104567:	75 41                	jne    801045aa <sched+0x8a>
  intena = mycpu()->intena;
80104569:	e8 a2 f8 ff ff       	call   80103e10 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
8010456e:	83 c3 20             	add    $0x20,%ebx
  intena = mycpu()->intena;
80104571:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104577:	e8 94 f8 ff ff       	call   80103e10 <mycpu>
8010457c:	83 ec 08             	sub    $0x8,%esp
8010457f:	ff 70 04             	pushl  0x4(%eax)
80104582:	53                   	push   %ebx
80104583:	e8 7b 0d 00 00       	call   80105303 <swtch>
  mycpu()->intena = intena;
80104588:	e8 83 f8 ff ff       	call   80103e10 <mycpu>
}
8010458d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104590:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104596:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104599:	5b                   	pop    %ebx
8010459a:	5e                   	pop    %esi
8010459b:	5d                   	pop    %ebp
8010459c:	c3                   	ret    
    panic("sched ptable.lock");
8010459d:	83 ec 0c             	sub    $0xc,%esp
801045a0:	68 bd 84 10 80       	push   $0x801084bd
801045a5:	e8 d6 bd ff ff       	call   80100380 <panic>
    panic("sched interruptible");
801045aa:	83 ec 0c             	sub    $0xc,%esp
801045ad:	68 e9 84 10 80       	push   $0x801084e9
801045b2:	e8 c9 bd ff ff       	call   80100380 <panic>
    panic("sched running");
801045b7:	83 ec 0c             	sub    $0xc,%esp
801045ba:	68 db 84 10 80       	push   $0x801084db
801045bf:	e8 bc bd ff ff       	call   80100380 <panic>
    panic("sched locks");
801045c4:	83 ec 0c             	sub    $0xc,%esp
801045c7:	68 cf 84 10 80       	push   $0x801084cf
801045cc:	e8 af bd ff ff       	call   80100380 <panic>
801045d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801045df:	90                   	nop

801045e0 <exit>:
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	56                   	push   %esi
801045e5:	53                   	push   %ebx
801045e6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
801045e9:	e8 a2 f8 ff ff       	call   80103e90 <myproc>
  if(curproc == initproc)
801045ee:	39 05 74 53 11 80    	cmp    %eax,0x80115374
801045f4:	0f 84 07 01 00 00    	je     80104701 <exit+0x121>
801045fa:	89 c3                	mov    %eax,%ebx
801045fc:	8d 70 2c             	lea    0x2c(%eax),%esi
801045ff:	8d 78 6c             	lea    0x6c(%eax),%edi
80104602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104608:	8b 06                	mov    (%esi),%eax
8010460a:	85 c0                	test   %eax,%eax
8010460c:	74 12                	je     80104620 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010460e:	83 ec 0c             	sub    $0xc,%esp
80104611:	50                   	push   %eax
80104612:	e8 99 cd ff ff       	call   801013b0 <fileclose>
      curproc->ofile[fd] = 0;
80104617:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010461d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104620:	83 c6 04             	add    $0x4,%esi
80104623:	39 f7                	cmp    %esi,%edi
80104625:	75 e1                	jne    80104608 <exit+0x28>
  begin_op();
80104627:	e8 04 ec ff ff       	call   80103230 <begin_op>
  iput(curproc->cwd);
8010462c:	83 ec 0c             	sub    $0xc,%esp
8010462f:	ff 73 6c             	pushl  0x6c(%ebx)
80104632:	e8 39 d7 ff ff       	call   80101d70 <iput>
  end_op();
80104637:	e8 64 ec ff ff       	call   801032a0 <end_op>
  curproc->cwd = 0;
8010463c:	c7 43 6c 00 00 00 00 	movl   $0x0,0x6c(%ebx)
  acquire(&ptable.lock);
80104643:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010464a:	e8 d1 09 00 00       	call   80105020 <acquire>
  wakeup1(curproc->parent);
8010464f:	8b 53 14             	mov    0x14(%ebx),%edx
80104652:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104655:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010465a:	eb 10                	jmp    8010466c <exit+0x8c>
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104660:	05 98 00 00 00       	add    $0x98,%eax
80104665:	3d 74 53 11 80       	cmp    $0x80115374,%eax
8010466a:	74 1e                	je     8010468a <exit+0xaa>
    if(p->state == SLEEPING && p->chan == chan)
8010466c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104670:	75 ee                	jne    80104660 <exit+0x80>
80104672:	3b 50 24             	cmp    0x24(%eax),%edx
80104675:	75 e9                	jne    80104660 <exit+0x80>
      p->state = RUNNABLE;
80104677:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010467e:	05 98 00 00 00       	add    $0x98,%eax
80104683:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104688:	75 e2                	jne    8010466c <exit+0x8c>
      p->parent = initproc;
8010468a:	8b 0d 74 53 11 80    	mov    0x80115374,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104690:	ba 74 2d 11 80       	mov    $0x80112d74,%edx
80104695:	eb 17                	jmp    801046ae <exit+0xce>
80104697:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010469e:	66 90                	xchg   %ax,%ax
801046a0:	81 c2 98 00 00 00    	add    $0x98,%edx
801046a6:	81 fa 74 53 11 80    	cmp    $0x80115374,%edx
801046ac:	74 3a                	je     801046e8 <exit+0x108>
    if(p->parent == curproc){
801046ae:	39 5a 14             	cmp    %ebx,0x14(%edx)
801046b1:	75 ed                	jne    801046a0 <exit+0xc0>
      if(p->state == ZOMBIE)
801046b3:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801046b7:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801046ba:	75 e4                	jne    801046a0 <exit+0xc0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046bc:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801046c1:	eb 11                	jmp    801046d4 <exit+0xf4>
801046c3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c7:	90                   	nop
801046c8:	05 98 00 00 00       	add    $0x98,%eax
801046cd:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801046d2:	74 cc                	je     801046a0 <exit+0xc0>
    if(p->state == SLEEPING && p->chan == chan)
801046d4:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046d8:	75 ee                	jne    801046c8 <exit+0xe8>
801046da:	3b 48 24             	cmp    0x24(%eax),%ecx
801046dd:	75 e9                	jne    801046c8 <exit+0xe8>
      p->state = RUNNABLE;
801046df:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801046e6:	eb e0                	jmp    801046c8 <exit+0xe8>
  curproc->state = ZOMBIE;
801046e8:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801046ef:	e8 2c fe ff ff       	call   80104520 <sched>
  panic("zombie exit");
801046f4:	83 ec 0c             	sub    $0xc,%esp
801046f7:	68 0a 85 10 80       	push   $0x8010850a
801046fc:	e8 7f bc ff ff       	call   80100380 <panic>
    panic("init exiting");
80104701:	83 ec 0c             	sub    $0xc,%esp
80104704:	68 fd 84 10 80       	push   $0x801084fd
80104709:	e8 72 bc ff ff       	call   80100380 <panic>
8010470e:	66 90                	xchg   %ax,%ax

80104710 <wait>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
  pushcli();
80104715:	e8 b6 07 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
8010471a:	e8 f1 f6 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
8010471f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104725:	e8 f6 07 00 00       	call   80104f20 <popcli>
  acquire(&ptable.lock);
8010472a:	83 ec 0c             	sub    $0xc,%esp
8010472d:	68 40 2d 11 80       	push   $0x80112d40
80104732:	e8 e9 08 00 00       	call   80105020 <acquire>
80104737:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010473a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010473c:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
80104741:	eb 13                	jmp    80104756 <wait+0x46>
80104743:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104747:	90                   	nop
80104748:	81 c3 98 00 00 00    	add    $0x98,%ebx
8010474e:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104754:	74 1e                	je     80104774 <wait+0x64>
      if(p->parent != curproc)
80104756:	39 73 14             	cmp    %esi,0x14(%ebx)
80104759:	75 ed                	jne    80104748 <wait+0x38>
      if(p->state == ZOMBIE){
8010475b:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010475f:	74 5f                	je     801047c0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104761:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
80104767:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010476c:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104772:	75 e2                	jne    80104756 <wait+0x46>
    if(!havekids || curproc->killed){
80104774:	85 c0                	test   %eax,%eax
80104776:	0f 84 9a 00 00 00    	je     80104816 <wait+0x106>
8010477c:	8b 46 28             	mov    0x28(%esi),%eax
8010477f:	85 c0                	test   %eax,%eax
80104781:	0f 85 8f 00 00 00    	jne    80104816 <wait+0x106>
  pushcli();
80104787:	e8 44 07 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
8010478c:	e8 7f f6 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104791:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104797:	e8 84 07 00 00       	call   80104f20 <popcli>
  if(p == 0)
8010479c:	85 db                	test   %ebx,%ebx
8010479e:	0f 84 89 00 00 00    	je     8010482d <wait+0x11d>
  p->chan = chan;
801047a4:	89 73 24             	mov    %esi,0x24(%ebx)
  p->state = SLEEPING;
801047a7:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801047ae:	e8 6d fd ff ff       	call   80104520 <sched>
  p->chan = 0;
801047b3:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
801047ba:	e9 7b ff ff ff       	jmp    8010473a <wait+0x2a>
801047bf:	90                   	nop
        kfree(p->kstack);
801047c0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801047c3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801047c6:	ff 73 08             	pushl  0x8(%ebx)
801047c9:	e8 c2 e1 ff ff       	call   80102990 <kfree>
        p->kstack = 0;
801047ce:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801047d5:	5a                   	pop    %edx
801047d6:	ff 73 04             	pushl  0x4(%ebx)
801047d9:	e8 02 33 00 00       	call   80107ae0 <freevm>
        p->pid = 0;
801047de:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801047e5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801047ec:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
801047f0:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
        p->state = UNUSED;
801047f7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801047fe:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104805:	e8 b6 07 00 00       	call   80104fc0 <release>
        return pid;
8010480a:	83 c4 10             	add    $0x10,%esp
}
8010480d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104810:	89 f0                	mov    %esi,%eax
80104812:	5b                   	pop    %ebx
80104813:	5e                   	pop    %esi
80104814:	5d                   	pop    %ebp
80104815:	c3                   	ret    
      release(&ptable.lock);
80104816:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104819:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010481e:	68 40 2d 11 80       	push   $0x80112d40
80104823:	e8 98 07 00 00       	call   80104fc0 <release>
      return -1;
80104828:	83 c4 10             	add    $0x10,%esp
8010482b:	eb e0                	jmp    8010480d <wait+0xfd>
    panic("sleep");
8010482d:	83 ec 0c             	sub    $0xc,%esp
80104830:	68 16 85 10 80       	push   $0x80108516
80104835:	e8 46 bb ff ff       	call   80100380 <panic>
8010483a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104840 <yield>:
{
80104840:	55                   	push   %ebp
80104841:	89 e5                	mov    %esp,%ebp
80104843:	53                   	push   %ebx
80104844:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104847:	68 40 2d 11 80       	push   $0x80112d40
8010484c:	e8 cf 07 00 00       	call   80105020 <acquire>
  pushcli();
80104851:	e8 7a 06 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80104856:	e8 b5 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
8010485b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104861:	e8 ba 06 00 00       	call   80104f20 <popcli>
  myproc()->state = RUNNABLE;
80104866:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
8010486d:	e8 5e 06 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80104872:	e8 99 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104877:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010487d:	e8 9e 06 00 00       	call   80104f20 <popcli>
  myproc()->exec_cycle += 1;
80104882:	83 83 88 00 00 00 01 	addl   $0x1,0x88(%ebx)
  sched();
80104889:	e8 92 fc ff ff       	call   80104520 <sched>
  release(&ptable.lock);
8010488e:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
80104895:	e8 26 07 00 00       	call   80104fc0 <release>
}
8010489a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010489d:	83 c4 10             	add    $0x10,%esp
801048a0:	c9                   	leave  
801048a1:	c3                   	ret    
801048a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048b0 <sleep>:
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	57                   	push   %edi
801048b4:	56                   	push   %esi
801048b5:	53                   	push   %ebx
801048b6:	83 ec 0c             	sub    $0xc,%esp
801048b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801048bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801048bf:	e8 0c 06 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
801048c4:	e8 47 f5 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
801048c9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048cf:	e8 4c 06 00 00       	call   80104f20 <popcli>
  if(p == 0)
801048d4:	85 db                	test   %ebx,%ebx
801048d6:	0f 84 87 00 00 00    	je     80104963 <sleep+0xb3>
  if(lk == 0)
801048dc:	85 f6                	test   %esi,%esi
801048de:	74 76                	je     80104956 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801048e0:	81 fe 40 2d 11 80    	cmp    $0x80112d40,%esi
801048e6:	74 50                	je     80104938 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	68 40 2d 11 80       	push   $0x80112d40
801048f0:	e8 2b 07 00 00       	call   80105020 <acquire>
    release(lk);
801048f5:	89 34 24             	mov    %esi,(%esp)
801048f8:	e8 c3 06 00 00       	call   80104fc0 <release>
  p->chan = chan;
801048fd:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
80104900:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104907:	e8 14 fc ff ff       	call   80104520 <sched>
  p->chan = 0;
8010490c:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
    release(&ptable.lock);
80104913:	c7 04 24 40 2d 11 80 	movl   $0x80112d40,(%esp)
8010491a:	e8 a1 06 00 00       	call   80104fc0 <release>
    acquire(lk);
8010491f:	89 75 08             	mov    %esi,0x8(%ebp)
80104922:	83 c4 10             	add    $0x10,%esp
}
80104925:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104928:	5b                   	pop    %ebx
80104929:	5e                   	pop    %esi
8010492a:	5f                   	pop    %edi
8010492b:	5d                   	pop    %ebp
    acquire(lk);
8010492c:	e9 ef 06 00 00       	jmp    80105020 <acquire>
80104931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104938:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
8010493b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104942:	e8 d9 fb ff ff       	call   80104520 <sched>
  p->chan = 0;
80104947:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
8010494e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104951:	5b                   	pop    %ebx
80104952:	5e                   	pop    %esi
80104953:	5f                   	pop    %edi
80104954:	5d                   	pop    %ebp
80104955:	c3                   	ret    
    panic("sleep without lk");
80104956:	83 ec 0c             	sub    $0xc,%esp
80104959:	68 1c 85 10 80       	push   $0x8010851c
8010495e:	e8 1d ba ff ff       	call   80100380 <panic>
    panic("sleep");
80104963:	83 ec 0c             	sub    $0xc,%esp
80104966:	68 16 85 10 80       	push   $0x80108516
8010496b:	e8 10 ba ff ff       	call   80100380 <panic>

80104970 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	83 ec 10             	sub    $0x10,%esp
80104977:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010497a:	68 40 2d 11 80       	push   $0x80112d40
8010497f:	e8 9c 06 00 00       	call   80105020 <acquire>
80104984:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104987:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
8010498c:	eb 0e                	jmp    8010499c <wakeup+0x2c>
8010498e:	66 90                	xchg   %ax,%ax
80104990:	05 98 00 00 00       	add    $0x98,%eax
80104995:	3d 74 53 11 80       	cmp    $0x80115374,%eax
8010499a:	74 1e                	je     801049ba <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
8010499c:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801049a0:	75 ee                	jne    80104990 <wakeup+0x20>
801049a2:	3b 58 24             	cmp    0x24(%eax),%ebx
801049a5:	75 e9                	jne    80104990 <wakeup+0x20>
      p->state = RUNNABLE;
801049a7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801049ae:	05 98 00 00 00       	add    $0x98,%eax
801049b3:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801049b8:	75 e2                	jne    8010499c <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801049ba:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
}
801049c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c4:	c9                   	leave  
  release(&ptable.lock);
801049c5:	e9 f6 05 00 00       	jmp    80104fc0 <release>
801049ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801049d0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 10             	sub    $0x10,%esp
801049d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801049da:	68 40 2d 11 80       	push   $0x80112d40
801049df:	e8 3c 06 00 00       	call   80105020 <acquire>
801049e4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049e7:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
801049ec:	eb 0e                	jmp    801049fc <kill+0x2c>
801049ee:	66 90                	xchg   %ax,%ax
801049f0:	05 98 00 00 00       	add    $0x98,%eax
801049f5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
801049fa:	74 34                	je     80104a30 <kill+0x60>
    if(p->pid == pid){
801049fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801049ff:	75 ef                	jne    801049f0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a01:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a05:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      if(p->state == SLEEPING)
80104a0c:	75 07                	jne    80104a15 <kill+0x45>
        p->state = RUNNABLE;
80104a0e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104a15:	83 ec 0c             	sub    $0xc,%esp
80104a18:	68 40 2d 11 80       	push   $0x80112d40
80104a1d:	e8 9e 05 00 00       	call   80104fc0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104a25:	83 c4 10             	add    $0x10,%esp
80104a28:	31 c0                	xor    %eax,%eax
}
80104a2a:	c9                   	leave  
80104a2b:	c3                   	ret    
80104a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104a30:	83 ec 0c             	sub    $0xc,%esp
80104a33:	68 40 2d 11 80       	push   $0x80112d40
80104a38:	e8 83 05 00 00       	call   80104fc0 <release>
}
80104a3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104a40:	83 c4 10             	add    $0x10,%esp
80104a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a48:	c9                   	leave  
80104a49:	c3                   	ret    
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a50 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104a58:	53                   	push   %ebx
80104a59:	bb e4 2d 11 80       	mov    $0x80112de4,%ebx
80104a5e:	83 ec 3c             	sub    $0x3c,%esp
80104a61:	eb 27                	jmp    80104a8a <procdump+0x3a>
80104a63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a67:	90                   	nop
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104a68:	83 ec 0c             	sub    $0xc,%esp
80104a6b:	68 9d 84 10 80       	push   $0x8010849d
80104a70:	e8 2b bc ff ff       	call   801006a0 <cprintf>
80104a75:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a78:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104a7e:	81 fb e4 53 11 80    	cmp    $0x801153e4,%ebx
80104a84:	0f 84 7e 00 00 00    	je     80104b08 <procdump+0xb8>
    if(p->state == UNUSED)
80104a8a:	8b 43 9c             	mov    -0x64(%ebx),%eax
80104a8d:	85 c0                	test   %eax,%eax
80104a8f:	74 e7                	je     80104a78 <procdump+0x28>
      state = "???";
80104a91:	ba 2d 85 10 80       	mov    $0x8010852d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104a96:	83 f8 05             	cmp    $0x5,%eax
80104a99:	77 11                	ja     80104aac <procdump+0x5c>
80104a9b:	8b 14 85 8c 85 10 80 	mov    -0x7fef7a74(,%eax,4),%edx
      state = "???";
80104aa2:	b8 2d 85 10 80       	mov    $0x8010852d,%eax
80104aa7:	85 d2                	test   %edx,%edx
80104aa9:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104aac:	53                   	push   %ebx
80104aad:	52                   	push   %edx
80104aae:	ff 73 a0             	pushl  -0x60(%ebx)
80104ab1:	68 31 85 10 80       	push   $0x80108531
80104ab6:	e8 e5 bb ff ff       	call   801006a0 <cprintf>
    if(p->state == SLEEPING){
80104abb:	83 c4 10             	add    $0x10,%esp
80104abe:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104ac2:	75 a4                	jne    80104a68 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104ac4:	83 ec 08             	sub    $0x8,%esp
80104ac7:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104aca:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104acd:	50                   	push   %eax
80104ace:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104ad1:	8b 40 0c             	mov    0xc(%eax),%eax
80104ad4:	83 c0 08             	add    $0x8,%eax
80104ad7:	50                   	push   %eax
80104ad8:	e8 93 03 00 00       	call   80104e70 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104add:	83 c4 10             	add    $0x10,%esp
80104ae0:	8b 17                	mov    (%edi),%edx
80104ae2:	85 d2                	test   %edx,%edx
80104ae4:	74 82                	je     80104a68 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104ae6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104ae9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
80104aec:	52                   	push   %edx
80104aed:	68 01 7f 10 80       	push   $0x80107f01
80104af2:	e8 a9 bb ff ff       	call   801006a0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104af7:	83 c4 10             	add    $0x10,%esp
80104afa:	39 fe                	cmp    %edi,%esi
80104afc:	75 e2                	jne    80104ae0 <procdump+0x90>
80104afe:	e9 65 ff ff ff       	jmp    80104a68 <procdump+0x18>
80104b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b07:	90                   	nop
  }
}
80104b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b0b:	5b                   	pop    %ebx
80104b0c:	5e                   	pop    %esi
80104b0d:	5f                   	pop    %edi
80104b0e:	5d                   	pop    %ebp
80104b0f:	c3                   	ret    

80104b10 <wait_sleeping>:


int
wait_sleeping(void)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	56                   	push   %esi
80104b14:	53                   	push   %ebx
  pushcli();
80104b15:	e8 b6 03 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80104b1a:	e8 f1 f2 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104b1f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b25:	e8 f6 03 00 00       	call   80104f20 <popcli>
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104b2a:	83 ec 0c             	sub    $0xc,%esp
80104b2d:	68 40 2d 11 80       	push   $0x80112d40
80104b32:	e8 e9 04 00 00       	call   80105020 <acquire>
80104b37:	83 c4 10             	add    $0x10,%esp
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104b3a:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b3c:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
80104b41:	eb 11                	jmp    80104b54 <wait_sleeping+0x44>
80104b43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104b47:	90                   	nop
80104b48:	05 98 00 00 00       	add    $0x98,%eax
80104b4d:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104b52:	74 1c                	je     80104b70 <wait_sleeping+0x60>
            if(p->tracer != curproc)
80104b54:	39 58 18             	cmp    %ebx,0x18(%eax)
80104b57:	75 ef                	jne    80104b48 <wait_sleeping+0x38>
                continue;
            havekids = 1;
            if(p->state == SLEEPING){
80104b59:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104b5d:	74 51                	je     80104bb0 <wait_sleeping+0xa0>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b5f:	05 98 00 00 00       	add    $0x98,%eax
            havekids = 1;
80104b64:	ba 01 00 00 00       	mov    $0x1,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b69:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104b6e:	75 e4                	jne    80104b54 <wait_sleeping+0x44>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104b70:	85 d2                	test   %edx,%edx
80104b72:	74 58                	je     80104bcc <wait_sleeping+0xbc>
80104b74:	8b 43 28             	mov    0x28(%ebx),%eax
80104b77:	85 c0                	test   %eax,%eax
80104b79:	75 51                	jne    80104bcc <wait_sleeping+0xbc>
  pushcli();
80104b7b:	e8 50 03 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80104b80:	e8 8b f2 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104b85:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104b8b:	e8 90 03 00 00       	call   80104f20 <popcli>
  if(p == 0)
80104b90:	85 f6                	test   %esi,%esi
80104b92:	74 4f                	je     80104be3 <wait_sleeping+0xd3>
  p->chan = chan;
80104b94:	89 5e 24             	mov    %ebx,0x24(%esi)
  p->state = SLEEPING;
80104b97:	c7 46 0c 02 00 00 00 	movl   $0x2,0xc(%esi)
  sched();
80104b9e:	e8 7d f9 ff ff       	call   80104520 <sched>
  p->chan = 0;
80104ba3:	c7 46 24 00 00 00 00 	movl   $0x0,0x24(%esi)
}
80104baa:	eb 8e                	jmp    80104b3a <wait_sleeping+0x2a>
80104bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
                release(&ptable.lock);
80104bb0:	83 ec 0c             	sub    $0xc,%esp
                pid = p->pid;
80104bb3:	8b 58 10             	mov    0x10(%eax),%ebx
                release(&ptable.lock);
80104bb6:	68 40 2d 11 80       	push   $0x80112d40
80104bbb:	e8 00 04 00 00       	call   80104fc0 <release>
                return pid;
80104bc0:	83 c4 10             	add    $0x10,%esp
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
    }
}
80104bc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bc6:	89 d8                	mov    %ebx,%eax
80104bc8:	5b                   	pop    %ebx
80104bc9:	5e                   	pop    %esi
80104bca:	5d                   	pop    %ebp
80104bcb:	c3                   	ret    
            release(&ptable.lock);
80104bcc:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104bcf:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
            release(&ptable.lock);
80104bd4:	68 40 2d 11 80       	push   $0x80112d40
80104bd9:	e8 e2 03 00 00       	call   80104fc0 <release>
            return -1;
80104bde:	83 c4 10             	add    $0x10,%esp
80104be1:	eb e0                	jmp    80104bc3 <wait_sleeping+0xb3>
    panic("sleep");
80104be3:	83 ec 0c             	sub    $0xc,%esp
80104be6:	68 16 85 10 80       	push   $0x80108516
80104beb:	e8 90 b7 ff ff       	call   80100380 <panic>

80104bf0 <set_proc_tracer>:

int set_proc_tracer(void){
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
    int pid;
    if(argint(0, &pid)<0)
80104bf5:	8d 45 f4             	lea    -0xc(%ebp),%eax
int set_proc_tracer(void){
80104bf8:	83 ec 18             	sub    $0x18,%esp
    if(argint(0, &pid)<0)
80104bfb:	50                   	push   %eax
80104bfc:	6a 00                	push   $0x0
80104bfe:	e8 ad 07 00 00       	call   801053b0 <argint>
80104c03:	83 c4 10             	add    $0x10,%esp
80104c06:	85 c0                	test   %eax,%eax
80104c08:	0f 88 8e 00 00 00    	js     80104c9c <set_proc_tracer+0xac>
        return -1;

    struct proc* p;
    acquire(&ptable.lock);
80104c0e:	83 ec 0c             	sub    $0xc,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c11:	bb 74 2d 11 80       	mov    $0x80112d74,%ebx
    acquire(&ptable.lock);
80104c16:	68 40 2d 11 80       	push   $0x80112d40
80104c1b:	e8 00 04 00 00       	call   80105020 <acquire>
        if(p->pid != pid)
80104c20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c23:	83 c4 10             	add    $0x10,%esp
80104c26:	eb 16                	jmp    80104c3e <set_proc_tracer+0x4e>
80104c28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c2f:	90                   	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c30:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104c36:	81 fb 74 53 11 80    	cmp    $0x80115374,%ebx
80104c3c:	74 42                	je     80104c80 <set_proc_tracer+0x90>
        if(p->pid != pid)
80104c3e:	39 43 10             	cmp    %eax,0x10(%ebx)
80104c41:	75 ed                	jne    80104c30 <set_proc_tracer+0x40>
            continue;
        if(!p->tracer){
80104c43:	8b 53 18             	mov    0x18(%ebx),%edx
80104c46:	85 d2                	test   %edx,%edx
80104c48:	75 e6                	jne    80104c30 <set_proc_tracer+0x40>
  pushcli();
80104c4a:	e8 81 02 00 00       	call   80104ed0 <pushcli>
  c = mycpu();
80104c4f:	e8 bc f1 ff ff       	call   80103e10 <mycpu>
  p = c->proc;
80104c54:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104c5a:	e8 c1 02 00 00       	call   80104f20 <popcli>
            p->tracer = myproc();
            release(&ptable.lock);
80104c5f:	83 ec 0c             	sub    $0xc,%esp
80104c62:	68 40 2d 11 80       	push   $0x80112d40
            p->tracer = myproc();
80104c67:	89 73 18             	mov    %esi,0x18(%ebx)
            release(&ptable.lock);
80104c6a:	e8 51 03 00 00       	call   80104fc0 <release>
            return pid;
80104c6f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c72:	83 c4 10             	add    $0x10,%esp
        }
    }
    release(&ptable.lock);
    return -1;
}
80104c75:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c78:	5b                   	pop    %ebx
80104c79:	5e                   	pop    %esi
80104c7a:	5d                   	pop    %ebp
80104c7b:	c3                   	ret    
80104c7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104c80:	83 ec 0c             	sub    $0xc,%esp
80104c83:	68 40 2d 11 80       	push   $0x80112d40
80104c88:	e8 33 03 00 00       	call   80104fc0 <release>
    return -1;
80104c8d:	83 c4 10             	add    $0x10,%esp
}
80104c90:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104c93:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c98:	5b                   	pop    %ebx
80104c99:	5e                   	pop    %esi
80104c9a:	5d                   	pop    %ebp
80104c9b:	c3                   	ret    
        return -1;
80104c9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ca1:	eb d2                	jmp    80104c75 <set_proc_tracer+0x85>
80104ca3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104caa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104cb0 <get_proc_queue_level>:

int get_proc_queue_level(int pid){
80104cb0:	55                   	push   %ebp
    struct proc* p;

    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104cb1:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
int get_proc_queue_level(int pid){
80104cb6:	89 e5                	mov    %esp,%ebp
80104cb8:	8b 55 08             	mov    0x8(%ebp),%edx
80104cbb:	eb 0f                	jmp    80104ccc <get_proc_queue_level+0x1c>
80104cbd:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104cc0:	05 98 00 00 00       	add    $0x98,%eax
80104cc5:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104cca:	74 14                	je     80104ce0 <get_proc_queue_level+0x30>
        if(p->pid == pid)
80104ccc:	39 50 10             	cmp    %edx,0x10(%eax)
80104ccf:	75 ef                	jne    80104cc0 <get_proc_queue_level+0x10>
            return p->level;
80104cd1:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax

    return -1;
}
80104cd7:	5d                   	pop    %ebp
80104cd8:	c3                   	ret    
80104cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ce5:	5d                   	pop    %ebp
80104ce6:	c3                   	ret    
80104ce7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104cee:	66 90                	xchg   %ax,%ax

80104cf0 <set_proc_queue_level>:

void set_proc_queue_level(int pid, int target_level){
80104cf0:	55                   	push   %ebp
    struct proc* p;

    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104cf1:	b8 74 2d 11 80       	mov    $0x80112d74,%eax
void set_proc_queue_level(int pid, int target_level){
80104cf6:	89 e5                	mov    %esp,%ebp
80104cf8:	8b 55 08             	mov    0x8(%ebp),%edx
80104cfb:	eb 0f                	jmp    80104d0c <set_proc_queue_level+0x1c>
80104cfd:	8d 76 00             	lea    0x0(%esi),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104d00:	05 98 00 00 00       	add    $0x98,%eax
80104d05:	3d 74 53 11 80       	cmp    $0x80115374,%eax
80104d0a:	74 0e                	je     80104d1a <set_proc_queue_level+0x2a>
        if(p->pid == pid){
80104d0c:	39 50 10             	cmp    %edx,0x10(%eax)
80104d0f:	75 ef                	jne    80104d00 <set_proc_queue_level+0x10>
            p->level = target_level;
80104d11:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d14:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
            return;
        }
}
80104d1a:	5d                   	pop    %ebp
80104d1b:	c3                   	ret    
80104d1c:	66 90                	xchg   %ax,%ax
80104d1e:	66 90                	xchg   %ax,%ax

80104d20 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104d20:	55                   	push   %ebp
80104d21:	89 e5                	mov    %esp,%ebp
80104d23:	53                   	push   %ebx
80104d24:	83 ec 0c             	sub    $0xc,%esp
80104d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104d2a:	68 ac 85 10 80       	push   $0x801085ac
80104d2f:	8d 43 04             	lea    0x4(%ebx),%eax
80104d32:	50                   	push   %eax
80104d33:	e8 18 01 00 00       	call   80104e50 <initlock>
  lk->name = name;
80104d38:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104d3b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104d41:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104d44:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104d4b:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104d4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d51:	c9                   	leave  
80104d52:	c3                   	ret    
80104d53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d60 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104d60:	55                   	push   %ebp
80104d61:	89 e5                	mov    %esp,%ebp
80104d63:	56                   	push   %esi
80104d64:	53                   	push   %ebx
80104d65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104d68:	8d 73 04             	lea    0x4(%ebx),%esi
80104d6b:	83 ec 0c             	sub    $0xc,%esp
80104d6e:	56                   	push   %esi
80104d6f:	e8 ac 02 00 00       	call   80105020 <acquire>
  while (lk->locked) {
80104d74:	8b 13                	mov    (%ebx),%edx
80104d76:	83 c4 10             	add    $0x10,%esp
80104d79:	85 d2                	test   %edx,%edx
80104d7b:	74 16                	je     80104d93 <acquiresleep+0x33>
80104d7d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104d80:	83 ec 08             	sub    $0x8,%esp
80104d83:	56                   	push   %esi
80104d84:	53                   	push   %ebx
80104d85:	e8 26 fb ff ff       	call   801048b0 <sleep>
  while (lk->locked) {
80104d8a:	8b 03                	mov    (%ebx),%eax
80104d8c:	83 c4 10             	add    $0x10,%esp
80104d8f:	85 c0                	test   %eax,%eax
80104d91:	75 ed                	jne    80104d80 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104d93:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104d99:	e8 f2 f0 ff ff       	call   80103e90 <myproc>
80104d9e:	8b 40 10             	mov    0x10(%eax),%eax
80104da1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104da4:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104da7:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104daa:	5b                   	pop    %ebx
80104dab:	5e                   	pop    %esi
80104dac:	5d                   	pop    %ebp
  release(&lk->lk);
80104dad:	e9 0e 02 00 00       	jmp    80104fc0 <release>
80104db2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104db9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104dc0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104dc0:	55                   	push   %ebp
80104dc1:	89 e5                	mov    %esp,%ebp
80104dc3:	56                   	push   %esi
80104dc4:	53                   	push   %ebx
80104dc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104dc8:	8d 73 04             	lea    0x4(%ebx),%esi
80104dcb:	83 ec 0c             	sub    $0xc,%esp
80104dce:	56                   	push   %esi
80104dcf:	e8 4c 02 00 00       	call   80105020 <acquire>
  lk->locked = 0;
80104dd4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104dda:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104de1:	89 1c 24             	mov    %ebx,(%esp)
80104de4:	e8 87 fb ff ff       	call   80104970 <wakeup>
  release(&lk->lk);
80104de9:	89 75 08             	mov    %esi,0x8(%ebp)
80104dec:	83 c4 10             	add    $0x10,%esp
}
80104def:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104df2:	5b                   	pop    %ebx
80104df3:	5e                   	pop    %esi
80104df4:	5d                   	pop    %ebp
  release(&lk->lk);
80104df5:	e9 c6 01 00 00       	jmp    80104fc0 <release>
80104dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e00 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104e00:	55                   	push   %ebp
80104e01:	89 e5                	mov    %esp,%ebp
80104e03:	57                   	push   %edi
80104e04:	31 ff                	xor    %edi,%edi
80104e06:	56                   	push   %esi
80104e07:	53                   	push   %ebx
80104e08:	83 ec 18             	sub    $0x18,%esp
80104e0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104e0e:	8d 73 04             	lea    0x4(%ebx),%esi
80104e11:	56                   	push   %esi
80104e12:	e8 09 02 00 00       	call   80105020 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104e17:	8b 03                	mov    (%ebx),%eax
80104e19:	83 c4 10             	add    $0x10,%esp
80104e1c:	85 c0                	test   %eax,%eax
80104e1e:	75 18                	jne    80104e38 <holdingsleep+0x38>
  release(&lk->lk);
80104e20:	83 ec 0c             	sub    $0xc,%esp
80104e23:	56                   	push   %esi
80104e24:	e8 97 01 00 00       	call   80104fc0 <release>
  return r;
}
80104e29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e2c:	89 f8                	mov    %edi,%eax
80104e2e:	5b                   	pop    %ebx
80104e2f:	5e                   	pop    %esi
80104e30:	5f                   	pop    %edi
80104e31:	5d                   	pop    %ebp
80104e32:	c3                   	ret    
80104e33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e37:	90                   	nop
  r = lk->locked && (lk->pid == myproc()->pid);
80104e38:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104e3b:	e8 50 f0 ff ff       	call   80103e90 <myproc>
80104e40:	39 58 10             	cmp    %ebx,0x10(%eax)
80104e43:	0f 94 c0             	sete   %al
80104e46:	0f b6 c0             	movzbl %al,%eax
80104e49:	89 c7                	mov    %eax,%edi
80104e4b:	eb d3                	jmp    80104e20 <holdingsleep+0x20>
80104e4d:	66 90                	xchg   %ax,%ax
80104e4f:	90                   	nop

80104e50 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104e56:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104e59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104e5f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104e62:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104e69:	5d                   	pop    %ebp
80104e6a:	c3                   	ret    
80104e6b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104e6f:	90                   	nop

80104e70 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104e70:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104e71:	31 d2                	xor    %edx,%edx
{
80104e73:	89 e5                	mov    %esp,%ebp
80104e75:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104e76:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104e79:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104e7c:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104e7f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104e80:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104e86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104e8c:	77 1a                	ja     80104ea8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104e8e:	8b 58 04             	mov    0x4(%eax),%ebx
80104e91:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104e94:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104e97:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104e99:	83 fa 0a             	cmp    $0xa,%edx
80104e9c:	75 e2                	jne    80104e80 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104e9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ea1:	c9                   	leave  
80104ea2:	c3                   	ret    
80104ea3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ea7:	90                   	nop
  for(; i < 10; i++)
80104ea8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104eab:	8d 51 28             	lea    0x28(%ecx),%edx
80104eae:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104eb0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104eb6:	83 c0 04             	add    $0x4,%eax
80104eb9:	39 d0                	cmp    %edx,%eax
80104ebb:	75 f3                	jne    80104eb0 <getcallerpcs+0x40>
}
80104ebd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ec0:	c9                   	leave  
80104ec1:	c3                   	ret    
80104ec2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ed0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	53                   	push   %ebx
80104ed4:	83 ec 04             	sub    $0x4,%esp
80104ed7:	9c                   	pushf  
80104ed8:	5b                   	pop    %ebx
  asm volatile("cli");
80104ed9:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104eda:	e8 31 ef ff ff       	call   80103e10 <mycpu>
80104edf:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104ee5:	85 c0                	test   %eax,%eax
80104ee7:	74 17                	je     80104f00 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104ee9:	e8 22 ef ff ff       	call   80103e10 <mycpu>
80104eee:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104ef5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ef8:	c9                   	leave  
80104ef9:	c3                   	ret    
80104efa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104f00:	e8 0b ef ff ff       	call   80103e10 <mycpu>
80104f05:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104f0b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104f11:	eb d6                	jmp    80104ee9 <pushcli+0x19>
80104f13:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104f20 <popcli>:

void
popcli(void)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104f26:	9c                   	pushf  
80104f27:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104f28:	f6 c4 02             	test   $0x2,%ah
80104f2b:	75 35                	jne    80104f62 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104f2d:	e8 de ee ff ff       	call   80103e10 <mycpu>
80104f32:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104f39:	78 34                	js     80104f6f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104f3b:	e8 d0 ee ff ff       	call   80103e10 <mycpu>
80104f40:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104f46:	85 d2                	test   %edx,%edx
80104f48:	74 06                	je     80104f50 <popcli+0x30>
    sti();
}
80104f4a:	c9                   	leave  
80104f4b:	c3                   	ret    
80104f4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104f50:	e8 bb ee ff ff       	call   80103e10 <mycpu>
80104f55:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104f5b:	85 c0                	test   %eax,%eax
80104f5d:	74 eb                	je     80104f4a <popcli+0x2a>
  asm volatile("sti");
80104f5f:	fb                   	sti    
}
80104f60:	c9                   	leave  
80104f61:	c3                   	ret    
    panic("popcli - interruptible");
80104f62:	83 ec 0c             	sub    $0xc,%esp
80104f65:	68 b7 85 10 80       	push   $0x801085b7
80104f6a:	e8 11 b4 ff ff       	call   80100380 <panic>
    panic("popcli");
80104f6f:	83 ec 0c             	sub    $0xc,%esp
80104f72:	68 ce 85 10 80       	push   $0x801085ce
80104f77:	e8 04 b4 ff ff       	call   80100380 <panic>
80104f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104f80 <holding>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
80104f85:	8b 75 08             	mov    0x8(%ebp),%esi
80104f88:	31 db                	xor    %ebx,%ebx
  pushcli();
80104f8a:	e8 41 ff ff ff       	call   80104ed0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104f8f:	8b 06                	mov    (%esi),%eax
80104f91:	85 c0                	test   %eax,%eax
80104f93:	75 0b                	jne    80104fa0 <holding+0x20>
  popcli();
80104f95:	e8 86 ff ff ff       	call   80104f20 <popcli>
}
80104f9a:	89 d8                	mov    %ebx,%eax
80104f9c:	5b                   	pop    %ebx
80104f9d:	5e                   	pop    %esi
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    
  r = lock->locked && lock->cpu == mycpu();
80104fa0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104fa3:	e8 68 ee ff ff       	call   80103e10 <mycpu>
80104fa8:	39 c3                	cmp    %eax,%ebx
80104faa:	0f 94 c3             	sete   %bl
  popcli();
80104fad:	e8 6e ff ff ff       	call   80104f20 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104fb2:	0f b6 db             	movzbl %bl,%ebx
}
80104fb5:	89 d8                	mov    %ebx,%eax
80104fb7:	5b                   	pop    %ebx
80104fb8:	5e                   	pop    %esi
80104fb9:	5d                   	pop    %ebp
80104fba:	c3                   	ret    
80104fbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104fbf:	90                   	nop

80104fc0 <release>:
{
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	56                   	push   %esi
80104fc4:	53                   	push   %ebx
80104fc5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104fc8:	e8 03 ff ff ff       	call   80104ed0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104fcd:	8b 03                	mov    (%ebx),%eax
80104fcf:	85 c0                	test   %eax,%eax
80104fd1:	75 15                	jne    80104fe8 <release+0x28>
  popcli();
80104fd3:	e8 48 ff ff ff       	call   80104f20 <popcli>
    panic("release");
80104fd8:	83 ec 0c             	sub    $0xc,%esp
80104fdb:	68 d5 85 10 80       	push   $0x801085d5
80104fe0:	e8 9b b3 ff ff       	call   80100380 <panic>
80104fe5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104fe8:	8b 73 08             	mov    0x8(%ebx),%esi
80104feb:	e8 20 ee ff ff       	call   80103e10 <mycpu>
80104ff0:	39 c6                	cmp    %eax,%esi
80104ff2:	75 df                	jne    80104fd3 <release+0x13>
  popcli();
80104ff4:	e8 27 ff ff ff       	call   80104f20 <popcli>
  lk->pcs[0] = 0;
80104ff9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105000:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105007:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010500c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105012:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105015:	5b                   	pop    %ebx
80105016:	5e                   	pop    %esi
80105017:	5d                   	pop    %ebp
  popcli();
80105018:	e9 03 ff ff ff       	jmp    80104f20 <popcli>
8010501d:	8d 76 00             	lea    0x0(%esi),%esi

80105020 <acquire>:
{
80105020:	55                   	push   %ebp
80105021:	89 e5                	mov    %esp,%ebp
80105023:	53                   	push   %ebx
80105024:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105027:	e8 a4 fe ff ff       	call   80104ed0 <pushcli>
  if(holding(lk))
8010502c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010502f:	e8 9c fe ff ff       	call   80104ed0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105034:	8b 03                	mov    (%ebx),%eax
80105036:	85 c0                	test   %eax,%eax
80105038:	75 7e                	jne    801050b8 <acquire+0x98>
  popcli();
8010503a:	e8 e1 fe ff ff       	call   80104f20 <popcli>
  asm volatile("lock; xchgl %0, %1" :
8010503f:	b9 01 00 00 00       	mov    $0x1,%ecx
80105044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(xchg(&lk->locked, 1) != 0)
80105048:	8b 55 08             	mov    0x8(%ebp),%edx
8010504b:	89 c8                	mov    %ecx,%eax
8010504d:	f0 87 02             	lock xchg %eax,(%edx)
80105050:	85 c0                	test   %eax,%eax
80105052:	75 f4                	jne    80105048 <acquire+0x28>
  __sync_synchronize();
80105054:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105059:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010505c:	e8 af ed ff ff       	call   80103e10 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105061:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ebp = (uint*)v - 2;
80105064:	89 ea                	mov    %ebp,%edx
  lk->cpu = mycpu();
80105066:	89 43 08             	mov    %eax,0x8(%ebx)
  for(i = 0; i < 10; i++){
80105069:	31 c0                	xor    %eax,%eax
8010506b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010506f:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105070:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105076:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010507c:	77 1a                	ja     80105098 <acquire+0x78>
    pcs[i] = ebp[1];     // saved %eip
8010507e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105081:	89 5c 81 0c          	mov    %ebx,0xc(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105085:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105088:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
8010508a:	83 f8 0a             	cmp    $0xa,%eax
8010508d:	75 e1                	jne    80105070 <acquire+0x50>
}
8010508f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105092:	c9                   	leave  
80105093:	c3                   	ret    
80105094:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80105098:	8d 44 81 0c          	lea    0xc(%ecx,%eax,4),%eax
8010509c:	8d 51 34             	lea    0x34(%ecx),%edx
8010509f:	90                   	nop
    pcs[i] = 0;
801050a0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801050a6:	83 c0 04             	add    $0x4,%eax
801050a9:	39 c2                	cmp    %eax,%edx
801050ab:	75 f3                	jne    801050a0 <acquire+0x80>
}
801050ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050b0:	c9                   	leave  
801050b1:	c3                   	ret    
801050b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801050b8:	8b 5b 08             	mov    0x8(%ebx),%ebx
801050bb:	e8 50 ed ff ff       	call   80103e10 <mycpu>
801050c0:	39 c3                	cmp    %eax,%ebx
801050c2:	0f 85 72 ff ff ff    	jne    8010503a <acquire+0x1a>
  popcli();
801050c8:	e8 53 fe ff ff       	call   80104f20 <popcli>
    panic("acquire");
801050cd:	83 ec 0c             	sub    $0xc,%esp
801050d0:	68 dd 85 10 80       	push   $0x801085dd
801050d5:	e8 a6 b2 ff ff       	call   80100380 <panic>
801050da:	66 90                	xchg   %ax,%ax
801050dc:	66 90                	xchg   %ax,%ax
801050de:	66 90                	xchg   %ax,%ax

801050e0 <memset>:
801050e0:	f3 0f 1e fb          	endbr32 
801050e4:	55                   	push   %ebp
801050e5:	89 e5                	mov    %esp,%ebp
801050e7:	57                   	push   %edi
801050e8:	8b 55 08             	mov    0x8(%ebp),%edx
801050eb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801050ee:	53                   	push   %ebx
801050ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801050f2:	89 d7                	mov    %edx,%edi
801050f4:	09 cf                	or     %ecx,%edi
801050f6:	83 e7 03             	and    $0x3,%edi
801050f9:	75 25                	jne    80105120 <memset+0x40>
801050fb:	0f b6 f8             	movzbl %al,%edi
801050fe:	c1 e0 18             	shl    $0x18,%eax
80105101:	89 fb                	mov    %edi,%ebx
80105103:	c1 e9 02             	shr    $0x2,%ecx
80105106:	c1 e3 10             	shl    $0x10,%ebx
80105109:	09 d8                	or     %ebx,%eax
8010510b:	09 f8                	or     %edi,%eax
8010510d:	c1 e7 08             	shl    $0x8,%edi
80105110:	09 f8                	or     %edi,%eax
80105112:	89 d7                	mov    %edx,%edi
80105114:	fc                   	cld    
80105115:	f3 ab                	rep stos %eax,%es:(%edi)
80105117:	5b                   	pop    %ebx
80105118:	89 d0                	mov    %edx,%eax
8010511a:	5f                   	pop    %edi
8010511b:	5d                   	pop    %ebp
8010511c:	c3                   	ret    
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
80105120:	89 d7                	mov    %edx,%edi
80105122:	fc                   	cld    
80105123:	f3 aa                	rep stos %al,%es:(%edi)
80105125:	5b                   	pop    %ebx
80105126:	89 d0                	mov    %edx,%eax
80105128:	5f                   	pop    %edi
80105129:	5d                   	pop    %ebp
8010512a:	c3                   	ret    
8010512b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010512f:	90                   	nop

80105130 <memcmp>:
80105130:	f3 0f 1e fb          	endbr32 
80105134:	55                   	push   %ebp
80105135:	89 e5                	mov    %esp,%ebp
80105137:	56                   	push   %esi
80105138:	8b 75 10             	mov    0x10(%ebp),%esi
8010513b:	8b 55 08             	mov    0x8(%ebp),%edx
8010513e:	53                   	push   %ebx
8010513f:	8b 45 0c             	mov    0xc(%ebp),%eax
80105142:	85 f6                	test   %esi,%esi
80105144:	74 2a                	je     80105170 <memcmp+0x40>
80105146:	01 c6                	add    %eax,%esi
80105148:	eb 10                	jmp    8010515a <memcmp+0x2a>
8010514a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105150:	83 c0 01             	add    $0x1,%eax
80105153:	83 c2 01             	add    $0x1,%edx
80105156:	39 f0                	cmp    %esi,%eax
80105158:	74 16                	je     80105170 <memcmp+0x40>
8010515a:	0f b6 0a             	movzbl (%edx),%ecx
8010515d:	0f b6 18             	movzbl (%eax),%ebx
80105160:	38 d9                	cmp    %bl,%cl
80105162:	74 ec                	je     80105150 <memcmp+0x20>
80105164:	0f b6 c1             	movzbl %cl,%eax
80105167:	29 d8                	sub    %ebx,%eax
80105169:	5b                   	pop    %ebx
8010516a:	5e                   	pop    %esi
8010516b:	5d                   	pop    %ebp
8010516c:	c3                   	ret    
8010516d:	8d 76 00             	lea    0x0(%esi),%esi
80105170:	5b                   	pop    %ebx
80105171:	31 c0                	xor    %eax,%eax
80105173:	5e                   	pop    %esi
80105174:	5d                   	pop    %ebp
80105175:	c3                   	ret    
80105176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010517d:	8d 76 00             	lea    0x0(%esi),%esi

80105180 <memmove>:
80105180:	f3 0f 1e fb          	endbr32 
80105184:	55                   	push   %ebp
80105185:	89 e5                	mov    %esp,%ebp
80105187:	57                   	push   %edi
80105188:	8b 55 08             	mov    0x8(%ebp),%edx
8010518b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010518e:	56                   	push   %esi
8010518f:	8b 75 0c             	mov    0xc(%ebp),%esi
80105192:	39 d6                	cmp    %edx,%esi
80105194:	73 2a                	jae    801051c0 <memmove+0x40>
80105196:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105199:	39 fa                	cmp    %edi,%edx
8010519b:	73 23                	jae    801051c0 <memmove+0x40>
8010519d:	8d 41 ff             	lea    -0x1(%ecx),%eax
801051a0:	85 c9                	test   %ecx,%ecx
801051a2:	74 13                	je     801051b7 <memmove+0x37>
801051a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051a8:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801051ac:	88 0c 02             	mov    %cl,(%edx,%eax,1)
801051af:	83 e8 01             	sub    $0x1,%eax
801051b2:	83 f8 ff             	cmp    $0xffffffff,%eax
801051b5:	75 f1                	jne    801051a8 <memmove+0x28>
801051b7:	5e                   	pop    %esi
801051b8:	89 d0                	mov    %edx,%eax
801051ba:	5f                   	pop    %edi
801051bb:	5d                   	pop    %ebp
801051bc:	c3                   	ret    
801051bd:	8d 76 00             	lea    0x0(%esi),%esi
801051c0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801051c3:	89 d7                	mov    %edx,%edi
801051c5:	85 c9                	test   %ecx,%ecx
801051c7:	74 ee                	je     801051b7 <memmove+0x37>
801051c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051d0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
801051d1:	39 f0                	cmp    %esi,%eax
801051d3:	75 fb                	jne    801051d0 <memmove+0x50>
801051d5:	5e                   	pop    %esi
801051d6:	89 d0                	mov    %edx,%eax
801051d8:	5f                   	pop    %edi
801051d9:	5d                   	pop    %ebp
801051da:	c3                   	ret    
801051db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051df:	90                   	nop

801051e0 <memcpy>:
801051e0:	f3 0f 1e fb          	endbr32 
801051e4:	eb 9a                	jmp    80105180 <memmove>
801051e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051ed:	8d 76 00             	lea    0x0(%esi),%esi

801051f0 <strncmp>:
801051f0:	f3 0f 1e fb          	endbr32 
801051f4:	55                   	push   %ebp
801051f5:	89 e5                	mov    %esp,%ebp
801051f7:	56                   	push   %esi
801051f8:	8b 75 10             	mov    0x10(%ebp),%esi
801051fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801051fe:	53                   	push   %ebx
801051ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80105202:	85 f6                	test   %esi,%esi
80105204:	74 32                	je     80105238 <strncmp+0x48>
80105206:	01 c6                	add    %eax,%esi
80105208:	eb 14                	jmp    8010521e <strncmp+0x2e>
8010520a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105210:	38 da                	cmp    %bl,%dl
80105212:	75 14                	jne    80105228 <strncmp+0x38>
80105214:	83 c0 01             	add    $0x1,%eax
80105217:	83 c1 01             	add    $0x1,%ecx
8010521a:	39 f0                	cmp    %esi,%eax
8010521c:	74 1a                	je     80105238 <strncmp+0x48>
8010521e:	0f b6 11             	movzbl (%ecx),%edx
80105221:	0f b6 18             	movzbl (%eax),%ebx
80105224:	84 d2                	test   %dl,%dl
80105226:	75 e8                	jne    80105210 <strncmp+0x20>
80105228:	0f b6 c2             	movzbl %dl,%eax
8010522b:	29 d8                	sub    %ebx,%eax
8010522d:	5b                   	pop    %ebx
8010522e:	5e                   	pop    %esi
8010522f:	5d                   	pop    %ebp
80105230:	c3                   	ret    
80105231:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105238:	5b                   	pop    %ebx
80105239:	31 c0                	xor    %eax,%eax
8010523b:	5e                   	pop    %esi
8010523c:	5d                   	pop    %ebp
8010523d:	c3                   	ret    
8010523e:	66 90                	xchg   %ax,%ax

80105240 <strncpy>:
80105240:	f3 0f 1e fb          	endbr32 
80105244:	55                   	push   %ebp
80105245:	89 e5                	mov    %esp,%ebp
80105247:	57                   	push   %edi
80105248:	56                   	push   %esi
80105249:	8b 75 08             	mov    0x8(%ebp),%esi
8010524c:	53                   	push   %ebx
8010524d:	8b 45 10             	mov    0x10(%ebp),%eax
80105250:	89 f2                	mov    %esi,%edx
80105252:	eb 1b                	jmp    8010526f <strncpy+0x2f>
80105254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105258:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010525c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010525f:	83 c2 01             	add    $0x1,%edx
80105262:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105266:	89 f9                	mov    %edi,%ecx
80105268:	88 4a ff             	mov    %cl,-0x1(%edx)
8010526b:	84 c9                	test   %cl,%cl
8010526d:	74 09                	je     80105278 <strncpy+0x38>
8010526f:	89 c3                	mov    %eax,%ebx
80105271:	83 e8 01             	sub    $0x1,%eax
80105274:	85 db                	test   %ebx,%ebx
80105276:	7f e0                	jg     80105258 <strncpy+0x18>
80105278:	89 d1                	mov    %edx,%ecx
8010527a:	85 c0                	test   %eax,%eax
8010527c:	7e 15                	jle    80105293 <strncpy+0x53>
8010527e:	66 90                	xchg   %ax,%ax
80105280:	83 c1 01             	add    $0x1,%ecx
80105283:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
80105287:	89 c8                	mov    %ecx,%eax
80105289:	f7 d0                	not    %eax
8010528b:	01 d0                	add    %edx,%eax
8010528d:	01 d8                	add    %ebx,%eax
8010528f:	85 c0                	test   %eax,%eax
80105291:	7f ed                	jg     80105280 <strncpy+0x40>
80105293:	5b                   	pop    %ebx
80105294:	89 f0                	mov    %esi,%eax
80105296:	5e                   	pop    %esi
80105297:	5f                   	pop    %edi
80105298:	5d                   	pop    %ebp
80105299:	c3                   	ret    
8010529a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052a0 <safestrcpy>:
801052a0:	f3 0f 1e fb          	endbr32 
801052a4:	55                   	push   %ebp
801052a5:	89 e5                	mov    %esp,%ebp
801052a7:	56                   	push   %esi
801052a8:	8b 55 10             	mov    0x10(%ebp),%edx
801052ab:	8b 75 08             	mov    0x8(%ebp),%esi
801052ae:	53                   	push   %ebx
801052af:	8b 45 0c             	mov    0xc(%ebp),%eax
801052b2:	85 d2                	test   %edx,%edx
801052b4:	7e 21                	jle    801052d7 <safestrcpy+0x37>
801052b6:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801052ba:	89 f2                	mov    %esi,%edx
801052bc:	eb 12                	jmp    801052d0 <safestrcpy+0x30>
801052be:	66 90                	xchg   %ax,%ax
801052c0:	0f b6 08             	movzbl (%eax),%ecx
801052c3:	83 c0 01             	add    $0x1,%eax
801052c6:	83 c2 01             	add    $0x1,%edx
801052c9:	88 4a ff             	mov    %cl,-0x1(%edx)
801052cc:	84 c9                	test   %cl,%cl
801052ce:	74 04                	je     801052d4 <safestrcpy+0x34>
801052d0:	39 d8                	cmp    %ebx,%eax
801052d2:	75 ec                	jne    801052c0 <safestrcpy+0x20>
801052d4:	c6 02 00             	movb   $0x0,(%edx)
801052d7:	89 f0                	mov    %esi,%eax
801052d9:	5b                   	pop    %ebx
801052da:	5e                   	pop    %esi
801052db:	5d                   	pop    %ebp
801052dc:	c3                   	ret    
801052dd:	8d 76 00             	lea    0x0(%esi),%esi

801052e0 <strlen>:
801052e0:	f3 0f 1e fb          	endbr32 
801052e4:	55                   	push   %ebp
801052e5:	31 c0                	xor    %eax,%eax
801052e7:	89 e5                	mov    %esp,%ebp
801052e9:	8b 55 08             	mov    0x8(%ebp),%edx
801052ec:	80 3a 00             	cmpb   $0x0,(%edx)
801052ef:	74 10                	je     80105301 <strlen+0x21>
801052f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052f8:	83 c0 01             	add    $0x1,%eax
801052fb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801052ff:	75 f7                	jne    801052f8 <strlen+0x18>
80105301:	5d                   	pop    %ebp
80105302:	c3                   	ret    

80105303 <swtch>:
80105303:	8b 44 24 04          	mov    0x4(%esp),%eax
80105307:	8b 54 24 08          	mov    0x8(%esp),%edx
8010530b:	55                   	push   %ebp
8010530c:	53                   	push   %ebx
8010530d:	56                   	push   %esi
8010530e:	57                   	push   %edi
8010530f:	89 20                	mov    %esp,(%eax)
80105311:	89 d4                	mov    %edx,%esp
80105313:	5f                   	pop    %edi
80105314:	5e                   	pop    %esi
80105315:	5b                   	pop    %ebx
80105316:	5d                   	pop    %ebp
80105317:	c3                   	ret    
80105318:	66 90                	xchg   %ax,%ax
8010531a:	66 90                	xchg   %ax,%ax
8010531c:	66 90                	xchg   %ax,%ax
8010531e:	66 90                	xchg   %ax,%ax

80105320 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	53                   	push   %ebx
80105324:	83 ec 04             	sub    $0x4,%esp
80105327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010532a:	e8 61 eb ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010532f:	8b 00                	mov    (%eax),%eax
80105331:	39 d8                	cmp    %ebx,%eax
80105333:	76 1b                	jbe    80105350 <fetchint+0x30>
80105335:	8d 53 04             	lea    0x4(%ebx),%edx
80105338:	39 d0                	cmp    %edx,%eax
8010533a:	72 14                	jb     80105350 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010533c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010533f:	8b 13                	mov    (%ebx),%edx
80105341:	89 10                	mov    %edx,(%eax)
  return 0;
80105343:	31 c0                	xor    %eax,%eax
}
80105345:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105348:	c9                   	leave  
80105349:	c3                   	ret    
8010534a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105350:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105355:	eb ee                	jmp    80105345 <fetchint+0x25>
80105357:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010535e:	66 90                	xchg   %ax,%ax

80105360 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	53                   	push   %ebx
80105364:	83 ec 04             	sub    $0x4,%esp
80105367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010536a:	e8 21 eb ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz)
8010536f:	39 18                	cmp    %ebx,(%eax)
80105371:	76 2d                	jbe    801053a0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105373:	8b 55 0c             	mov    0xc(%ebp),%edx
80105376:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105378:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010537a:	39 d3                	cmp    %edx,%ebx
8010537c:	73 22                	jae    801053a0 <fetchstr+0x40>
8010537e:	89 d8                	mov    %ebx,%eax
80105380:	eb 0d                	jmp    8010538f <fetchstr+0x2f>
80105382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105388:	83 c0 01             	add    $0x1,%eax
8010538b:	39 c2                	cmp    %eax,%edx
8010538d:	76 11                	jbe    801053a0 <fetchstr+0x40>
    if(*s == 0)
8010538f:	80 38 00             	cmpb   $0x0,(%eax)
80105392:	75 f4                	jne    80105388 <fetchstr+0x28>
      return s - *pp;
80105394:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105396:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105399:	c9                   	leave  
8010539a:	c3                   	ret    
8010539b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010539f:	90                   	nop
801053a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801053a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801053a8:	c9                   	leave  
801053a9:	c3                   	ret    
801053aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801053b0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801053b0:	55                   	push   %ebp
801053b1:	89 e5                	mov    %esp,%ebp
801053b3:	56                   	push   %esi
801053b4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801053b5:	e8 d6 ea ff ff       	call   80103e90 <myproc>
801053ba:	8b 55 08             	mov    0x8(%ebp),%edx
801053bd:	8b 40 1c             	mov    0x1c(%eax),%eax
801053c0:	8b 40 44             	mov    0x44(%eax),%eax
801053c3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801053c6:	e8 c5 ea ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801053cb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801053ce:	8b 00                	mov    (%eax),%eax
801053d0:	39 c6                	cmp    %eax,%esi
801053d2:	73 1c                	jae    801053f0 <argint+0x40>
801053d4:	8d 53 08             	lea    0x8(%ebx),%edx
801053d7:	39 d0                	cmp    %edx,%eax
801053d9:	72 15                	jb     801053f0 <argint+0x40>
  *ip = *(int*)(addr);
801053db:	8b 45 0c             	mov    0xc(%ebp),%eax
801053de:	8b 53 04             	mov    0x4(%ebx),%edx
801053e1:	89 10                	mov    %edx,(%eax)
  return 0;
801053e3:	31 c0                	xor    %eax,%eax
}
801053e5:	5b                   	pop    %ebx
801053e6:	5e                   	pop    %esi
801053e7:	5d                   	pop    %ebp
801053e8:	c3                   	ret    
801053e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801053f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801053f5:	eb ee                	jmp    801053e5 <argint+0x35>
801053f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053fe:	66 90                	xchg   %ax,%ax

80105400 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
80105405:	53                   	push   %ebx
80105406:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80105409:	e8 82 ea ff ff       	call   80103e90 <myproc>
8010540e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105410:	e8 7b ea ff ff       	call   80103e90 <myproc>
80105415:	8b 55 08             	mov    0x8(%ebp),%edx
80105418:	8b 40 1c             	mov    0x1c(%eax),%eax
8010541b:	8b 40 44             	mov    0x44(%eax),%eax
8010541e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105421:	e8 6a ea ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105426:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105429:	8b 00                	mov    (%eax),%eax
8010542b:	39 c7                	cmp    %eax,%edi
8010542d:	73 31                	jae    80105460 <argptr+0x60>
8010542f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105432:	39 c8                	cmp    %ecx,%eax
80105434:	72 2a                	jb     80105460 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105436:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105439:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010543c:	85 d2                	test   %edx,%edx
8010543e:	78 20                	js     80105460 <argptr+0x60>
80105440:	8b 16                	mov    (%esi),%edx
80105442:	39 c2                	cmp    %eax,%edx
80105444:	76 1a                	jbe    80105460 <argptr+0x60>
80105446:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105449:	01 c3                	add    %eax,%ebx
8010544b:	39 da                	cmp    %ebx,%edx
8010544d:	72 11                	jb     80105460 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010544f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105452:	89 02                	mov    %eax,(%edx)
  return 0;
80105454:	31 c0                	xor    %eax,%eax
}
80105456:	83 c4 0c             	add    $0xc,%esp
80105459:	5b                   	pop    %ebx
8010545a:	5e                   	pop    %esi
8010545b:	5f                   	pop    %edi
8010545c:	5d                   	pop    %ebp
8010545d:	c3                   	ret    
8010545e:	66 90                	xchg   %ax,%ax
    return -1;
80105460:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105465:	eb ef                	jmp    80105456 <argptr+0x56>
80105467:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010546e:	66 90                	xchg   %ax,%ax

80105470 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105470:	55                   	push   %ebp
80105471:	89 e5                	mov    %esp,%ebp
80105473:	56                   	push   %esi
80105474:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105475:	e8 16 ea ff ff       	call   80103e90 <myproc>
8010547a:	8b 55 08             	mov    0x8(%ebp),%edx
8010547d:	8b 40 1c             	mov    0x1c(%eax),%eax
80105480:	8b 40 44             	mov    0x44(%eax),%eax
80105483:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105486:	e8 05 ea ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010548b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010548e:	8b 00                	mov    (%eax),%eax
80105490:	39 c6                	cmp    %eax,%esi
80105492:	73 44                	jae    801054d8 <argstr+0x68>
80105494:	8d 53 08             	lea    0x8(%ebx),%edx
80105497:	39 d0                	cmp    %edx,%eax
80105499:	72 3d                	jb     801054d8 <argstr+0x68>
  *ip = *(int*)(addr);
8010549b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010549e:	e8 ed e9 ff ff       	call   80103e90 <myproc>
  if(addr >= curproc->sz)
801054a3:	3b 18                	cmp    (%eax),%ebx
801054a5:	73 31                	jae    801054d8 <argstr+0x68>
  *pp = (char*)addr;
801054a7:	8b 55 0c             	mov    0xc(%ebp),%edx
801054aa:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801054ac:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801054ae:	39 d3                	cmp    %edx,%ebx
801054b0:	73 26                	jae    801054d8 <argstr+0x68>
801054b2:	89 d8                	mov    %ebx,%eax
801054b4:	eb 11                	jmp    801054c7 <argstr+0x57>
801054b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054bd:	8d 76 00             	lea    0x0(%esi),%esi
801054c0:	83 c0 01             	add    $0x1,%eax
801054c3:	39 c2                	cmp    %eax,%edx
801054c5:	76 11                	jbe    801054d8 <argstr+0x68>
    if(*s == 0)
801054c7:	80 38 00             	cmpb   $0x0,(%eax)
801054ca:	75 f4                	jne    801054c0 <argstr+0x50>
      return s - *pp;
801054cc:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801054ce:	5b                   	pop    %ebx
801054cf:	5e                   	pop    %esi
801054d0:	5d                   	pop    %ebp
801054d1:	c3                   	ret    
801054d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054d8:	5b                   	pop    %ebx
    return -1;
801054d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054de:	5e                   	pop    %esi
801054df:	5d                   	pop    %ebp
801054e0:	c3                   	ret    
801054e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054ef:	90                   	nop

801054f0 <syscall>:
[SYS_set_proc_queue_level] sys_set_proc_level,
};

void
syscall(void)
{
801054f0:	55                   	push   %ebp
801054f1:	89 e5                	mov    %esp,%ebp
801054f3:	53                   	push   %ebx
801054f4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
801054f7:	e8 94 e9 ff ff       	call   80103e90 <myproc>
801054fc:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801054fe:	8b 40 1c             	mov    0x1c(%eax),%eax
80105501:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105504:	8d 50 ff             	lea    -0x1(%eax),%edx
80105507:	83 fa 1b             	cmp    $0x1b,%edx
8010550a:	77 24                	ja     80105530 <syscall+0x40>
8010550c:	8b 14 85 20 86 10 80 	mov    -0x7fef79e0(,%eax,4),%edx
80105513:	85 d2                	test   %edx,%edx
80105515:	74 19                	je     80105530 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80105517:	ff d2                	call   *%edx
80105519:	89 c2                	mov    %eax,%edx
8010551b:	8b 43 1c             	mov    0x1c(%ebx),%eax
8010551e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105524:	c9                   	leave  
80105525:	c3                   	ret    
80105526:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010552d:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80105530:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80105531:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105534:	50                   	push   %eax
80105535:	ff 73 10             	pushl  0x10(%ebx)
80105538:	68 e5 85 10 80       	push   $0x801085e5
8010553d:	e8 5e b1 ff ff       	call   801006a0 <cprintf>
    curproc->tf->eax = -1;
80105542:	8b 43 1c             	mov    0x1c(%ebx),%eax
80105545:	83 c4 10             	add    $0x10,%esp
80105548:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010554f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105552:	c9                   	leave  
80105553:	c3                   	ret    
80105554:	66 90                	xchg   %ax,%ax
80105556:	66 90                	xchg   %ax,%ax
80105558:	66 90                	xchg   %ax,%ax
8010555a:	66 90                	xchg   %ax,%ax
8010555c:	66 90                	xchg   %ax,%ax
8010555e:	66 90                	xchg   %ax,%ax

80105560 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	57                   	push   %edi
80105564:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105565:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105568:	53                   	push   %ebx
80105569:	83 ec 34             	sub    $0x34,%esp
8010556c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010556f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105572:	57                   	push   %edi
80105573:	50                   	push   %eax
{
80105574:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105577:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010557a:	e8 01 d0 ff ff       	call   80102580 <nameiparent>
8010557f:	83 c4 10             	add    $0x10,%esp
80105582:	85 c0                	test   %eax,%eax
80105584:	0f 84 46 01 00 00    	je     801056d0 <create+0x170>
    return 0;
  ilock(dp);
8010558a:	83 ec 0c             	sub    $0xc,%esp
8010558d:	89 c3                	mov    %eax,%ebx
8010558f:	50                   	push   %eax
80105590:	e8 ab c6 ff ff       	call   80101c40 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105595:	83 c4 0c             	add    $0xc,%esp
80105598:	6a 00                	push   $0x0
8010559a:	57                   	push   %edi
8010559b:	53                   	push   %ebx
8010559c:	e8 ff cb ff ff       	call   801021a0 <dirlookup>
801055a1:	83 c4 10             	add    $0x10,%esp
801055a4:	89 c6                	mov    %eax,%esi
801055a6:	85 c0                	test   %eax,%eax
801055a8:	74 56                	je     80105600 <create+0xa0>
    iunlockput(dp);
801055aa:	83 ec 0c             	sub    $0xc,%esp
801055ad:	53                   	push   %ebx
801055ae:	e8 1d c9 ff ff       	call   80101ed0 <iunlockput>
    ilock(ip);
801055b3:	89 34 24             	mov    %esi,(%esp)
801055b6:	e8 85 c6 ff ff       	call   80101c40 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801055bb:	83 c4 10             	add    $0x10,%esp
801055be:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801055c3:	75 1b                	jne    801055e0 <create+0x80>
801055c5:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801055ca:	75 14                	jne    801055e0 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801055cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055cf:	89 f0                	mov    %esi,%eax
801055d1:	5b                   	pop    %ebx
801055d2:	5e                   	pop    %esi
801055d3:	5f                   	pop    %edi
801055d4:	5d                   	pop    %ebp
801055d5:	c3                   	ret    
801055d6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055dd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
801055e0:	83 ec 0c             	sub    $0xc,%esp
801055e3:	56                   	push   %esi
    return 0;
801055e4:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
801055e6:	e8 e5 c8 ff ff       	call   80101ed0 <iunlockput>
    return 0;
801055eb:	83 c4 10             	add    $0x10,%esp
}
801055ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801055f1:	89 f0                	mov    %esi,%eax
801055f3:	5b                   	pop    %ebx
801055f4:	5e                   	pop    %esi
801055f5:	5f                   	pop    %edi
801055f6:	5d                   	pop    %ebp
801055f7:	c3                   	ret    
801055f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801055ff:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105600:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105604:	83 ec 08             	sub    $0x8,%esp
80105607:	50                   	push   %eax
80105608:	ff 33                	pushl  (%ebx)
8010560a:	e8 c1 c4 ff ff       	call   80101ad0 <ialloc>
8010560f:	83 c4 10             	add    $0x10,%esp
80105612:	89 c6                	mov    %eax,%esi
80105614:	85 c0                	test   %eax,%eax
80105616:	0f 84 cd 00 00 00    	je     801056e9 <create+0x189>
  ilock(ip);
8010561c:	83 ec 0c             	sub    $0xc,%esp
8010561f:	50                   	push   %eax
80105620:	e8 1b c6 ff ff       	call   80101c40 <ilock>
  ip->major = major;
80105625:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105629:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
8010562d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105631:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105635:	b8 01 00 00 00       	mov    $0x1,%eax
8010563a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
8010563e:	89 34 24             	mov    %esi,(%esp)
80105641:	e8 4a c5 ff ff       	call   80101b90 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105646:	83 c4 10             	add    $0x10,%esp
80105649:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010564e:	74 30                	je     80105680 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80105650:	83 ec 04             	sub    $0x4,%esp
80105653:	ff 76 04             	pushl  0x4(%esi)
80105656:	57                   	push   %edi
80105657:	53                   	push   %ebx
80105658:	e8 43 ce ff ff       	call   801024a0 <dirlink>
8010565d:	83 c4 10             	add    $0x10,%esp
80105660:	85 c0                	test   %eax,%eax
80105662:	78 78                	js     801056dc <create+0x17c>
  iunlockput(dp);
80105664:	83 ec 0c             	sub    $0xc,%esp
80105667:	53                   	push   %ebx
80105668:	e8 63 c8 ff ff       	call   80101ed0 <iunlockput>
  return ip;
8010566d:	83 c4 10             	add    $0x10,%esp
}
80105670:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105673:	89 f0                	mov    %esi,%eax
80105675:	5b                   	pop    %ebx
80105676:	5e                   	pop    %esi
80105677:	5f                   	pop    %edi
80105678:	5d                   	pop    %ebp
80105679:	c3                   	ret    
8010567a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105680:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105683:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105688:	53                   	push   %ebx
80105689:	e8 02 c5 ff ff       	call   80101b90 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010568e:	83 c4 0c             	add    $0xc,%esp
80105691:	ff 76 04             	pushl  0x4(%esi)
80105694:	68 b0 86 10 80       	push   $0x801086b0
80105699:	56                   	push   %esi
8010569a:	e8 01 ce ff ff       	call   801024a0 <dirlink>
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	85 c0                	test   %eax,%eax
801056a4:	78 18                	js     801056be <create+0x15e>
801056a6:	83 ec 04             	sub    $0x4,%esp
801056a9:	ff 73 04             	pushl  0x4(%ebx)
801056ac:	68 af 86 10 80       	push   $0x801086af
801056b1:	56                   	push   %esi
801056b2:	e8 e9 cd ff ff       	call   801024a0 <dirlink>
801056b7:	83 c4 10             	add    $0x10,%esp
801056ba:	85 c0                	test   %eax,%eax
801056bc:	79 92                	jns    80105650 <create+0xf0>
      panic("create dots");
801056be:	83 ec 0c             	sub    $0xc,%esp
801056c1:	68 a3 86 10 80       	push   $0x801086a3
801056c6:	e8 b5 ac ff ff       	call   80100380 <panic>
801056cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056cf:	90                   	nop
}
801056d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801056d3:	31 f6                	xor    %esi,%esi
}
801056d5:	5b                   	pop    %ebx
801056d6:	89 f0                	mov    %esi,%eax
801056d8:	5e                   	pop    %esi
801056d9:	5f                   	pop    %edi
801056da:	5d                   	pop    %ebp
801056db:	c3                   	ret    
    panic("create: dirlink");
801056dc:	83 ec 0c             	sub    $0xc,%esp
801056df:	68 b2 86 10 80       	push   $0x801086b2
801056e4:	e8 97 ac ff ff       	call   80100380 <panic>
    panic("create: ialloc");
801056e9:	83 ec 0c             	sub    $0xc,%esp
801056ec:	68 94 86 10 80       	push   $0x80108694
801056f1:	e8 8a ac ff ff       	call   80100380 <panic>
801056f6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056fd:	8d 76 00             	lea    0x0(%esi),%esi

80105700 <sys_dup>:
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	56                   	push   %esi
80105704:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105705:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105708:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010570b:	50                   	push   %eax
8010570c:	6a 00                	push   $0x0
8010570e:	e8 9d fc ff ff       	call   801053b0 <argint>
80105713:	83 c4 10             	add    $0x10,%esp
80105716:	85 c0                	test   %eax,%eax
80105718:	78 36                	js     80105750 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010571a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010571e:	77 30                	ja     80105750 <sys_dup+0x50>
80105720:	e8 6b e7 ff ff       	call   80103e90 <myproc>
80105725:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105728:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010572c:	85 f6                	test   %esi,%esi
8010572e:	74 20                	je     80105750 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105730:	e8 5b e7 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105735:	31 db                	xor    %ebx,%ebx
80105737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80105740:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105744:	85 d2                	test   %edx,%edx
80105746:	74 18                	je     80105760 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105748:	83 c3 01             	add    $0x1,%ebx
8010574b:	83 fb 10             	cmp    $0x10,%ebx
8010574e:	75 f0                	jne    80105740 <sys_dup+0x40>
}
80105750:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105753:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105758:	89 d8                	mov    %ebx,%eax
8010575a:	5b                   	pop    %ebx
8010575b:	5e                   	pop    %esi
8010575c:	5d                   	pop    %ebp
8010575d:	c3                   	ret    
8010575e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105760:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105763:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80105767:	56                   	push   %esi
80105768:	e8 f3 bb ff ff       	call   80101360 <filedup>
  return fd;
8010576d:	83 c4 10             	add    $0x10,%esp
}
80105770:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105773:	89 d8                	mov    %ebx,%eax
80105775:	5b                   	pop    %ebx
80105776:	5e                   	pop    %esi
80105777:	5d                   	pop    %ebp
80105778:	c3                   	ret    
80105779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105780 <sys_read>:
{
80105780:	55                   	push   %ebp
80105781:	89 e5                	mov    %esp,%ebp
80105783:	56                   	push   %esi
80105784:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105785:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105788:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010578b:	53                   	push   %ebx
8010578c:	6a 00                	push   $0x0
8010578e:	e8 1d fc ff ff       	call   801053b0 <argint>
80105793:	83 c4 10             	add    $0x10,%esp
80105796:	85 c0                	test   %eax,%eax
80105798:	78 5e                	js     801057f8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010579a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010579e:	77 58                	ja     801057f8 <sys_read+0x78>
801057a0:	e8 eb e6 ff ff       	call   80103e90 <myproc>
801057a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057a8:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
801057ac:	85 f6                	test   %esi,%esi
801057ae:	74 48                	je     801057f8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801057b0:	83 ec 08             	sub    $0x8,%esp
801057b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801057b6:	50                   	push   %eax
801057b7:	6a 02                	push   $0x2
801057b9:	e8 f2 fb ff ff       	call   801053b0 <argint>
801057be:	83 c4 10             	add    $0x10,%esp
801057c1:	85 c0                	test   %eax,%eax
801057c3:	78 33                	js     801057f8 <sys_read+0x78>
801057c5:	83 ec 04             	sub    $0x4,%esp
801057c8:	ff 75 f0             	pushl  -0x10(%ebp)
801057cb:	53                   	push   %ebx
801057cc:	6a 01                	push   $0x1
801057ce:	e8 2d fc ff ff       	call   80105400 <argptr>
801057d3:	83 c4 10             	add    $0x10,%esp
801057d6:	85 c0                	test   %eax,%eax
801057d8:	78 1e                	js     801057f8 <sys_read+0x78>
  return fileread(f, p, n);
801057da:	83 ec 04             	sub    $0x4,%esp
801057dd:	ff 75 f0             	pushl  -0x10(%ebp)
801057e0:	ff 75 f4             	pushl  -0xc(%ebp)
801057e3:	56                   	push   %esi
801057e4:	e8 f7 bc ff ff       	call   801014e0 <fileread>
801057e9:	83 c4 10             	add    $0x10,%esp
}
801057ec:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057ef:	5b                   	pop    %ebx
801057f0:	5e                   	pop    %esi
801057f1:	5d                   	pop    %ebp
801057f2:	c3                   	ret    
801057f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801057f7:	90                   	nop
    return -1;
801057f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057fd:	eb ed                	jmp    801057ec <sys_read+0x6c>
801057ff:	90                   	nop

80105800 <sys_write>:
{
80105800:	55                   	push   %ebp
80105801:	89 e5                	mov    %esp,%ebp
80105803:	56                   	push   %esi
80105804:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105805:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105808:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010580b:	53                   	push   %ebx
8010580c:	6a 00                	push   $0x0
8010580e:	e8 9d fb ff ff       	call   801053b0 <argint>
80105813:	83 c4 10             	add    $0x10,%esp
80105816:	85 c0                	test   %eax,%eax
80105818:	78 5e                	js     80105878 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010581a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010581e:	77 58                	ja     80105878 <sys_write+0x78>
80105820:	e8 6b e6 ff ff       	call   80103e90 <myproc>
80105825:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105828:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010582c:	85 f6                	test   %esi,%esi
8010582e:	74 48                	je     80105878 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105830:	83 ec 08             	sub    $0x8,%esp
80105833:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105836:	50                   	push   %eax
80105837:	6a 02                	push   $0x2
80105839:	e8 72 fb ff ff       	call   801053b0 <argint>
8010583e:	83 c4 10             	add    $0x10,%esp
80105841:	85 c0                	test   %eax,%eax
80105843:	78 33                	js     80105878 <sys_write+0x78>
80105845:	83 ec 04             	sub    $0x4,%esp
80105848:	ff 75 f0             	pushl  -0x10(%ebp)
8010584b:	53                   	push   %ebx
8010584c:	6a 01                	push   $0x1
8010584e:	e8 ad fb ff ff       	call   80105400 <argptr>
80105853:	83 c4 10             	add    $0x10,%esp
80105856:	85 c0                	test   %eax,%eax
80105858:	78 1e                	js     80105878 <sys_write+0x78>
  return filewrite(f, p, n);
8010585a:	83 ec 04             	sub    $0x4,%esp
8010585d:	ff 75 f0             	pushl  -0x10(%ebp)
80105860:	ff 75 f4             	pushl  -0xc(%ebp)
80105863:	56                   	push   %esi
80105864:	e8 07 bd ff ff       	call   80101570 <filewrite>
80105869:	83 c4 10             	add    $0x10,%esp
}
8010586c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010586f:	5b                   	pop    %ebx
80105870:	5e                   	pop    %esi
80105871:	5d                   	pop    %ebp
80105872:	c3                   	ret    
80105873:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105877:	90                   	nop
    return -1;
80105878:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010587d:	eb ed                	jmp    8010586c <sys_write+0x6c>
8010587f:	90                   	nop

80105880 <sys_close>:
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	56                   	push   %esi
80105884:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105885:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105888:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010588b:	50                   	push   %eax
8010588c:	6a 00                	push   $0x0
8010588e:	e8 1d fb ff ff       	call   801053b0 <argint>
80105893:	83 c4 10             	add    $0x10,%esp
80105896:	85 c0                	test   %eax,%eax
80105898:	78 3e                	js     801058d8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010589a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010589e:	77 38                	ja     801058d8 <sys_close+0x58>
801058a0:	e8 eb e5 ff ff       	call   80103e90 <myproc>
801058a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801058a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801058ab:	8b 74 98 0c          	mov    0xc(%eax,%ebx,4),%esi
801058af:	85 f6                	test   %esi,%esi
801058b1:	74 25                	je     801058d8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801058b3:	e8 d8 e5 ff ff       	call   80103e90 <myproc>
  fileclose(f);
801058b8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801058bb:	c7 44 98 0c 00 00 00 	movl   $0x0,0xc(%eax,%ebx,4)
801058c2:	00 
  fileclose(f);
801058c3:	56                   	push   %esi
801058c4:	e8 e7 ba ff ff       	call   801013b0 <fileclose>
  return 0;
801058c9:	83 c4 10             	add    $0x10,%esp
801058cc:	31 c0                	xor    %eax,%eax
}
801058ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058d1:	5b                   	pop    %ebx
801058d2:	5e                   	pop    %esi
801058d3:	5d                   	pop    %ebp
801058d4:	c3                   	ret    
801058d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801058d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058dd:	eb ef                	jmp    801058ce <sys_close+0x4e>
801058df:	90                   	nop

801058e0 <sys_fstat>:
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	56                   	push   %esi
801058e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801058e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801058e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801058eb:	53                   	push   %ebx
801058ec:	6a 00                	push   $0x0
801058ee:	e8 bd fa ff ff       	call   801053b0 <argint>
801058f3:	83 c4 10             	add    $0x10,%esp
801058f6:	85 c0                	test   %eax,%eax
801058f8:	78 46                	js     80105940 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801058fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801058fe:	77 40                	ja     80105940 <sys_fstat+0x60>
80105900:	e8 8b e5 ff ff       	call   80103e90 <myproc>
80105905:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105908:	8b 74 90 2c          	mov    0x2c(%eax,%edx,4),%esi
8010590c:	85 f6                	test   %esi,%esi
8010590e:	74 30                	je     80105940 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105910:	83 ec 04             	sub    $0x4,%esp
80105913:	6a 14                	push   $0x14
80105915:	53                   	push   %ebx
80105916:	6a 01                	push   $0x1
80105918:	e8 e3 fa ff ff       	call   80105400 <argptr>
8010591d:	83 c4 10             	add    $0x10,%esp
80105920:	85 c0                	test   %eax,%eax
80105922:	78 1c                	js     80105940 <sys_fstat+0x60>
  return filestat(f, st);
80105924:	83 ec 08             	sub    $0x8,%esp
80105927:	ff 75 f4             	pushl  -0xc(%ebp)
8010592a:	56                   	push   %esi
8010592b:	e8 60 bb ff ff       	call   80101490 <filestat>
80105930:	83 c4 10             	add    $0x10,%esp
}
80105933:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105936:	5b                   	pop    %ebx
80105937:	5e                   	pop    %esi
80105938:	5d                   	pop    %ebp
80105939:	c3                   	ret    
8010593a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105940:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105945:	eb ec                	jmp    80105933 <sys_fstat+0x53>
80105947:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010594e:	66 90                	xchg   %ax,%ax

80105950 <sys_link>:
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
80105954:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105955:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105958:	53                   	push   %ebx
80105959:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010595c:	50                   	push   %eax
8010595d:	6a 00                	push   $0x0
8010595f:	e8 0c fb ff ff       	call   80105470 <argstr>
80105964:	83 c4 10             	add    $0x10,%esp
80105967:	85 c0                	test   %eax,%eax
80105969:	0f 88 fb 00 00 00    	js     80105a6a <sys_link+0x11a>
8010596f:	83 ec 08             	sub    $0x8,%esp
80105972:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105975:	50                   	push   %eax
80105976:	6a 01                	push   $0x1
80105978:	e8 f3 fa ff ff       	call   80105470 <argstr>
8010597d:	83 c4 10             	add    $0x10,%esp
80105980:	85 c0                	test   %eax,%eax
80105982:	0f 88 e2 00 00 00    	js     80105a6a <sys_link+0x11a>
  begin_op();
80105988:	e8 a3 d8 ff ff       	call   80103230 <begin_op>
  if((ip = namei(old)) == 0){
8010598d:	83 ec 0c             	sub    $0xc,%esp
80105990:	ff 75 d4             	pushl  -0x2c(%ebp)
80105993:	e8 c8 cb ff ff       	call   80102560 <namei>
80105998:	83 c4 10             	add    $0x10,%esp
8010599b:	89 c3                	mov    %eax,%ebx
8010599d:	85 c0                	test   %eax,%eax
8010599f:	0f 84 e4 00 00 00    	je     80105a89 <sys_link+0x139>
  ilock(ip);
801059a5:	83 ec 0c             	sub    $0xc,%esp
801059a8:	50                   	push   %eax
801059a9:	e8 92 c2 ff ff       	call   80101c40 <ilock>
  if(ip->type == T_DIR){
801059ae:	83 c4 10             	add    $0x10,%esp
801059b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059b6:	0f 84 b5 00 00 00    	je     80105a71 <sys_link+0x121>
  iupdate(ip);
801059bc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801059bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801059c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801059c7:	53                   	push   %ebx
801059c8:	e8 c3 c1 ff ff       	call   80101b90 <iupdate>
  iunlock(ip);
801059cd:	89 1c 24             	mov    %ebx,(%esp)
801059d0:	e8 4b c3 ff ff       	call   80101d20 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801059d5:	58                   	pop    %eax
801059d6:	5a                   	pop    %edx
801059d7:	57                   	push   %edi
801059d8:	ff 75 d0             	pushl  -0x30(%ebp)
801059db:	e8 a0 cb ff ff       	call   80102580 <nameiparent>
801059e0:	83 c4 10             	add    $0x10,%esp
801059e3:	89 c6                	mov    %eax,%esi
801059e5:	85 c0                	test   %eax,%eax
801059e7:	74 5b                	je     80105a44 <sys_link+0xf4>
  ilock(dp);
801059e9:	83 ec 0c             	sub    $0xc,%esp
801059ec:	50                   	push   %eax
801059ed:	e8 4e c2 ff ff       	call   80101c40 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801059f2:	8b 03                	mov    (%ebx),%eax
801059f4:	83 c4 10             	add    $0x10,%esp
801059f7:	39 06                	cmp    %eax,(%esi)
801059f9:	75 3d                	jne    80105a38 <sys_link+0xe8>
801059fb:	83 ec 04             	sub    $0x4,%esp
801059fe:	ff 73 04             	pushl  0x4(%ebx)
80105a01:	57                   	push   %edi
80105a02:	56                   	push   %esi
80105a03:	e8 98 ca ff ff       	call   801024a0 <dirlink>
80105a08:	83 c4 10             	add    $0x10,%esp
80105a0b:	85 c0                	test   %eax,%eax
80105a0d:	78 29                	js     80105a38 <sys_link+0xe8>
  iunlockput(dp);
80105a0f:	83 ec 0c             	sub    $0xc,%esp
80105a12:	56                   	push   %esi
80105a13:	e8 b8 c4 ff ff       	call   80101ed0 <iunlockput>
  iput(ip);
80105a18:	89 1c 24             	mov    %ebx,(%esp)
80105a1b:	e8 50 c3 ff ff       	call   80101d70 <iput>
  end_op();
80105a20:	e8 7b d8 ff ff       	call   801032a0 <end_op>
  return 0;
80105a25:	83 c4 10             	add    $0x10,%esp
80105a28:	31 c0                	xor    %eax,%eax
}
80105a2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a2d:	5b                   	pop    %ebx
80105a2e:	5e                   	pop    %esi
80105a2f:	5f                   	pop    %edi
80105a30:	5d                   	pop    %ebp
80105a31:	c3                   	ret    
80105a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105a38:	83 ec 0c             	sub    $0xc,%esp
80105a3b:	56                   	push   %esi
80105a3c:	e8 8f c4 ff ff       	call   80101ed0 <iunlockput>
    goto bad;
80105a41:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105a44:	83 ec 0c             	sub    $0xc,%esp
80105a47:	53                   	push   %ebx
80105a48:	e8 f3 c1 ff ff       	call   80101c40 <ilock>
  ip->nlink--;
80105a4d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a52:	89 1c 24             	mov    %ebx,(%esp)
80105a55:	e8 36 c1 ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105a5a:	89 1c 24             	mov    %ebx,(%esp)
80105a5d:	e8 6e c4 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105a62:	e8 39 d8 ff ff       	call   801032a0 <end_op>
  return -1;
80105a67:	83 c4 10             	add    $0x10,%esp
80105a6a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a6f:	eb b9                	jmp    80105a2a <sys_link+0xda>
    iunlockput(ip);
80105a71:	83 ec 0c             	sub    $0xc,%esp
80105a74:	53                   	push   %ebx
80105a75:	e8 56 c4 ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105a7a:	e8 21 d8 ff ff       	call   801032a0 <end_op>
    return -1;
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a87:	eb a1                	jmp    80105a2a <sys_link+0xda>
    end_op();
80105a89:	e8 12 d8 ff ff       	call   801032a0 <end_op>
    return -1;
80105a8e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a93:	eb 95                	jmp    80105a2a <sys_link+0xda>
80105a95:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105a9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105aa0 <sys_unlink>:
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	57                   	push   %edi
80105aa4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105aa5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105aa8:	53                   	push   %ebx
80105aa9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105aac:	50                   	push   %eax
80105aad:	6a 00                	push   $0x0
80105aaf:	e8 bc f9 ff ff       	call   80105470 <argstr>
80105ab4:	83 c4 10             	add    $0x10,%esp
80105ab7:	85 c0                	test   %eax,%eax
80105ab9:	0f 88 7a 01 00 00    	js     80105c39 <sys_unlink+0x199>
  begin_op();
80105abf:	e8 6c d7 ff ff       	call   80103230 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105ac4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105ac7:	83 ec 08             	sub    $0x8,%esp
80105aca:	53                   	push   %ebx
80105acb:	ff 75 c0             	pushl  -0x40(%ebp)
80105ace:	e8 ad ca ff ff       	call   80102580 <nameiparent>
80105ad3:	83 c4 10             	add    $0x10,%esp
80105ad6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105ad9:	85 c0                	test   %eax,%eax
80105adb:	0f 84 62 01 00 00    	je     80105c43 <sys_unlink+0x1a3>
  ilock(dp);
80105ae1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105ae4:	83 ec 0c             	sub    $0xc,%esp
80105ae7:	57                   	push   %edi
80105ae8:	e8 53 c1 ff ff       	call   80101c40 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105aed:	58                   	pop    %eax
80105aee:	5a                   	pop    %edx
80105aef:	68 b0 86 10 80       	push   $0x801086b0
80105af4:	53                   	push   %ebx
80105af5:	e8 86 c6 ff ff       	call   80102180 <namecmp>
80105afa:	83 c4 10             	add    $0x10,%esp
80105afd:	85 c0                	test   %eax,%eax
80105aff:	0f 84 fb 00 00 00    	je     80105c00 <sys_unlink+0x160>
80105b05:	83 ec 08             	sub    $0x8,%esp
80105b08:	68 af 86 10 80       	push   $0x801086af
80105b0d:	53                   	push   %ebx
80105b0e:	e8 6d c6 ff ff       	call   80102180 <namecmp>
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	85 c0                	test   %eax,%eax
80105b18:	0f 84 e2 00 00 00    	je     80105c00 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b1e:	83 ec 04             	sub    $0x4,%esp
80105b21:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105b24:	50                   	push   %eax
80105b25:	53                   	push   %ebx
80105b26:	57                   	push   %edi
80105b27:	e8 74 c6 ff ff       	call   801021a0 <dirlookup>
80105b2c:	83 c4 10             	add    $0x10,%esp
80105b2f:	89 c3                	mov    %eax,%ebx
80105b31:	85 c0                	test   %eax,%eax
80105b33:	0f 84 c7 00 00 00    	je     80105c00 <sys_unlink+0x160>
  ilock(ip);
80105b39:	83 ec 0c             	sub    $0xc,%esp
80105b3c:	50                   	push   %eax
80105b3d:	e8 fe c0 ff ff       	call   80101c40 <ilock>
  if(ip->nlink < 1)
80105b42:	83 c4 10             	add    $0x10,%esp
80105b45:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105b4a:	0f 8e 1c 01 00 00    	jle    80105c6c <sys_unlink+0x1cc>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105b50:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b55:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105b58:	74 66                	je     80105bc0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105b5a:	83 ec 04             	sub    $0x4,%esp
80105b5d:	6a 10                	push   $0x10
80105b5f:	6a 00                	push   $0x0
80105b61:	57                   	push   %edi
80105b62:	e8 79 f5 ff ff       	call   801050e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105b67:	6a 10                	push   $0x10
80105b69:	ff 75 c4             	pushl  -0x3c(%ebp)
80105b6c:	57                   	push   %edi
80105b6d:	ff 75 b4             	pushl  -0x4c(%ebp)
80105b70:	e8 db c4 ff ff       	call   80102050 <writei>
80105b75:	83 c4 20             	add    $0x20,%esp
80105b78:	83 f8 10             	cmp    $0x10,%eax
80105b7b:	0f 85 de 00 00 00    	jne    80105c5f <sys_unlink+0x1bf>
  if(ip->type == T_DIR){
80105b81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105b86:	0f 84 94 00 00 00    	je     80105c20 <sys_unlink+0x180>
  iunlockput(dp);
80105b8c:	83 ec 0c             	sub    $0xc,%esp
80105b8f:	ff 75 b4             	pushl  -0x4c(%ebp)
80105b92:	e8 39 c3 ff ff       	call   80101ed0 <iunlockput>
  ip->nlink--;
80105b97:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105b9c:	89 1c 24             	mov    %ebx,(%esp)
80105b9f:	e8 ec bf ff ff       	call   80101b90 <iupdate>
  iunlockput(ip);
80105ba4:	89 1c 24             	mov    %ebx,(%esp)
80105ba7:	e8 24 c3 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105bac:	e8 ef d6 ff ff       	call   801032a0 <end_op>
  return 0;
80105bb1:	83 c4 10             	add    $0x10,%esp
80105bb4:	31 c0                	xor    %eax,%eax
}
80105bb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105bb9:	5b                   	pop    %ebx
80105bba:	5e                   	pop    %esi
80105bbb:	5f                   	pop    %edi
80105bbc:	5d                   	pop    %ebp
80105bbd:	c3                   	ret    
80105bbe:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105bc0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105bc4:	76 94                	jbe    80105b5a <sys_unlink+0xba>
80105bc6:	be 20 00 00 00       	mov    $0x20,%esi
80105bcb:	eb 0b                	jmp    80105bd8 <sys_unlink+0x138>
80105bcd:	8d 76 00             	lea    0x0(%esi),%esi
80105bd0:	83 c6 10             	add    $0x10,%esi
80105bd3:	3b 73 58             	cmp    0x58(%ebx),%esi
80105bd6:	73 82                	jae    80105b5a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105bd8:	6a 10                	push   $0x10
80105bda:	56                   	push   %esi
80105bdb:	57                   	push   %edi
80105bdc:	53                   	push   %ebx
80105bdd:	e8 6e c3 ff ff       	call   80101f50 <readi>
80105be2:	83 c4 10             	add    $0x10,%esp
80105be5:	83 f8 10             	cmp    $0x10,%eax
80105be8:	75 68                	jne    80105c52 <sys_unlink+0x1b2>
    if(de.inum != 0)
80105bea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105bef:	74 df                	je     80105bd0 <sys_unlink+0x130>
    iunlockput(ip);
80105bf1:	83 ec 0c             	sub    $0xc,%esp
80105bf4:	53                   	push   %ebx
80105bf5:	e8 d6 c2 ff ff       	call   80101ed0 <iunlockput>
    goto bad;
80105bfa:	83 c4 10             	add    $0x10,%esp
80105bfd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105c00:	83 ec 0c             	sub    $0xc,%esp
80105c03:	ff 75 b4             	pushl  -0x4c(%ebp)
80105c06:	e8 c5 c2 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105c0b:	e8 90 d6 ff ff       	call   801032a0 <end_op>
  return -1;
80105c10:	83 c4 10             	add    $0x10,%esp
80105c13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c18:	eb 9c                	jmp    80105bb6 <sys_unlink+0x116>
80105c1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105c20:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105c23:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105c26:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105c2b:	50                   	push   %eax
80105c2c:	e8 5f bf ff ff       	call   80101b90 <iupdate>
80105c31:	83 c4 10             	add    $0x10,%esp
80105c34:	e9 53 ff ff ff       	jmp    80105b8c <sys_unlink+0xec>
    return -1;
80105c39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c3e:	e9 73 ff ff ff       	jmp    80105bb6 <sys_unlink+0x116>
    end_op();
80105c43:	e8 58 d6 ff ff       	call   801032a0 <end_op>
    return -1;
80105c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c4d:	e9 64 ff ff ff       	jmp    80105bb6 <sys_unlink+0x116>
      panic("isdirempty: readi");
80105c52:	83 ec 0c             	sub    $0xc,%esp
80105c55:	68 d4 86 10 80       	push   $0x801086d4
80105c5a:	e8 21 a7 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
80105c5f:	83 ec 0c             	sub    $0xc,%esp
80105c62:	68 e6 86 10 80       	push   $0x801086e6
80105c67:	e8 14 a7 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
80105c6c:	83 ec 0c             	sub    $0xc,%esp
80105c6f:	68 c2 86 10 80       	push   $0x801086c2
80105c74:	e8 07 a7 ff ff       	call   80100380 <panic>
80105c79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105c80 <sys_open>:

int
sys_open(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	57                   	push   %edi
80105c84:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105c85:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105c88:	53                   	push   %ebx
80105c89:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105c8c:	50                   	push   %eax
80105c8d:	6a 00                	push   $0x0
80105c8f:	e8 dc f7 ff ff       	call   80105470 <argstr>
80105c94:	83 c4 10             	add    $0x10,%esp
80105c97:	85 c0                	test   %eax,%eax
80105c99:	0f 88 8e 00 00 00    	js     80105d2d <sys_open+0xad>
80105c9f:	83 ec 08             	sub    $0x8,%esp
80105ca2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105ca5:	50                   	push   %eax
80105ca6:	6a 01                	push   $0x1
80105ca8:	e8 03 f7 ff ff       	call   801053b0 <argint>
80105cad:	83 c4 10             	add    $0x10,%esp
80105cb0:	85 c0                	test   %eax,%eax
80105cb2:	78 79                	js     80105d2d <sys_open+0xad>
    return -1;

  begin_op();
80105cb4:	e8 77 d5 ff ff       	call   80103230 <begin_op>

  if(omode & O_CREATE){
80105cb9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105cbd:	75 79                	jne    80105d38 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105cbf:	83 ec 0c             	sub    $0xc,%esp
80105cc2:	ff 75 e0             	pushl  -0x20(%ebp)
80105cc5:	e8 96 c8 ff ff       	call   80102560 <namei>
80105cca:	83 c4 10             	add    $0x10,%esp
80105ccd:	89 c6                	mov    %eax,%esi
80105ccf:	85 c0                	test   %eax,%eax
80105cd1:	0f 84 7e 00 00 00    	je     80105d55 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105cd7:	83 ec 0c             	sub    $0xc,%esp
80105cda:	50                   	push   %eax
80105cdb:	e8 60 bf ff ff       	call   80101c40 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105ce0:	83 c4 10             	add    $0x10,%esp
80105ce3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105ce8:	0f 84 c2 00 00 00    	je     80105db0 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105cee:	e8 fd b5 ff ff       	call   801012f0 <filealloc>
80105cf3:	89 c7                	mov    %eax,%edi
80105cf5:	85 c0                	test   %eax,%eax
80105cf7:	74 23                	je     80105d1c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105cf9:	e8 92 e1 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105cfe:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d00:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105d04:	85 d2                	test   %edx,%edx
80105d06:	74 60                	je     80105d68 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105d08:	83 c3 01             	add    $0x1,%ebx
80105d0b:	83 fb 10             	cmp    $0x10,%ebx
80105d0e:	75 f0                	jne    80105d00 <sys_open+0x80>
    if(f)
      fileclose(f);
80105d10:	83 ec 0c             	sub    $0xc,%esp
80105d13:	57                   	push   %edi
80105d14:	e8 97 b6 ff ff       	call   801013b0 <fileclose>
80105d19:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105d1c:	83 ec 0c             	sub    $0xc,%esp
80105d1f:	56                   	push   %esi
80105d20:	e8 ab c1 ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105d25:	e8 76 d5 ff ff       	call   801032a0 <end_op>
    return -1;
80105d2a:	83 c4 10             	add    $0x10,%esp
80105d2d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d32:	eb 6d                	jmp    80105da1 <sys_open+0x121>
80105d34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105d38:	83 ec 0c             	sub    $0xc,%esp
80105d3b:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105d3e:	31 c9                	xor    %ecx,%ecx
80105d40:	ba 02 00 00 00       	mov    $0x2,%edx
80105d45:	6a 00                	push   $0x0
80105d47:	e8 14 f8 ff ff       	call   80105560 <create>
    if(ip == 0){
80105d4c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105d4f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105d51:	85 c0                	test   %eax,%eax
80105d53:	75 99                	jne    80105cee <sys_open+0x6e>
      end_op();
80105d55:	e8 46 d5 ff ff       	call   801032a0 <end_op>
      return -1;
80105d5a:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105d5f:	eb 40                	jmp    80105da1 <sys_open+0x121>
80105d61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105d68:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105d6b:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
80105d6f:	56                   	push   %esi
80105d70:	e8 ab bf ff ff       	call   80101d20 <iunlock>
  end_op();
80105d75:	e8 26 d5 ff ff       	call   801032a0 <end_op>

  f->type = FD_INODE;
80105d7a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105d80:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d83:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105d86:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105d89:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105d8b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105d92:	f7 d0                	not    %eax
80105d94:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d97:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105d9a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105d9d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105da1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105da4:	89 d8                	mov    %ebx,%eax
80105da6:	5b                   	pop    %ebx
80105da7:	5e                   	pop    %esi
80105da8:	5f                   	pop    %edi
80105da9:	5d                   	pop    %ebp
80105daa:	c3                   	ret    
80105dab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105daf:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105db0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105db3:	85 c9                	test   %ecx,%ecx
80105db5:	0f 84 33 ff ff ff    	je     80105cee <sys_open+0x6e>
80105dbb:	e9 5c ff ff ff       	jmp    80105d1c <sys_open+0x9c>

80105dc0 <sys_mkdir>:

int
sys_mkdir(void)
{
80105dc0:	55                   	push   %ebp
80105dc1:	89 e5                	mov    %esp,%ebp
80105dc3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105dc6:	e8 65 d4 ff ff       	call   80103230 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105dcb:	83 ec 08             	sub    $0x8,%esp
80105dce:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105dd1:	50                   	push   %eax
80105dd2:	6a 00                	push   $0x0
80105dd4:	e8 97 f6 ff ff       	call   80105470 <argstr>
80105dd9:	83 c4 10             	add    $0x10,%esp
80105ddc:	85 c0                	test   %eax,%eax
80105dde:	78 30                	js     80105e10 <sys_mkdir+0x50>
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de6:	31 c9                	xor    %ecx,%ecx
80105de8:	ba 01 00 00 00       	mov    $0x1,%edx
80105ded:	6a 00                	push   $0x0
80105def:	e8 6c f7 ff ff       	call   80105560 <create>
80105df4:	83 c4 10             	add    $0x10,%esp
80105df7:	85 c0                	test   %eax,%eax
80105df9:	74 15                	je     80105e10 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105dfb:	83 ec 0c             	sub    $0xc,%esp
80105dfe:	50                   	push   %eax
80105dff:	e8 cc c0 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105e04:	e8 97 d4 ff ff       	call   801032a0 <end_op>
  return 0;
80105e09:	83 c4 10             	add    $0x10,%esp
80105e0c:	31 c0                	xor    %eax,%eax
}
80105e0e:	c9                   	leave  
80105e0f:	c3                   	ret    
    end_op();
80105e10:	e8 8b d4 ff ff       	call   801032a0 <end_op>
    return -1;
80105e15:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e1a:	c9                   	leave  
80105e1b:	c3                   	ret    
80105e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e20 <sys_mknod>:

int
sys_mknod(void)
{
80105e20:	55                   	push   %ebp
80105e21:	89 e5                	mov    %esp,%ebp
80105e23:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105e26:	e8 05 d4 ff ff       	call   80103230 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105e2b:	83 ec 08             	sub    $0x8,%esp
80105e2e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105e31:	50                   	push   %eax
80105e32:	6a 00                	push   $0x0
80105e34:	e8 37 f6 ff ff       	call   80105470 <argstr>
80105e39:	83 c4 10             	add    $0x10,%esp
80105e3c:	85 c0                	test   %eax,%eax
80105e3e:	78 60                	js     80105ea0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105e40:	83 ec 08             	sub    $0x8,%esp
80105e43:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105e46:	50                   	push   %eax
80105e47:	6a 01                	push   $0x1
80105e49:	e8 62 f5 ff ff       	call   801053b0 <argint>
  if((argstr(0, &path)) < 0 ||
80105e4e:	83 c4 10             	add    $0x10,%esp
80105e51:	85 c0                	test   %eax,%eax
80105e53:	78 4b                	js     80105ea0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105e55:	83 ec 08             	sub    $0x8,%esp
80105e58:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e5b:	50                   	push   %eax
80105e5c:	6a 02                	push   $0x2
80105e5e:	e8 4d f5 ff ff       	call   801053b0 <argint>
     argint(1, &major) < 0 ||
80105e63:	83 c4 10             	add    $0x10,%esp
80105e66:	85 c0                	test   %eax,%eax
80105e68:	78 36                	js     80105ea0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105e6a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105e6e:	83 ec 0c             	sub    $0xc,%esp
80105e71:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105e75:	ba 03 00 00 00       	mov    $0x3,%edx
80105e7a:	50                   	push   %eax
80105e7b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105e7e:	e8 dd f6 ff ff       	call   80105560 <create>
     argint(2, &minor) < 0 ||
80105e83:	83 c4 10             	add    $0x10,%esp
80105e86:	85 c0                	test   %eax,%eax
80105e88:	74 16                	je     80105ea0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e8a:	83 ec 0c             	sub    $0xc,%esp
80105e8d:	50                   	push   %eax
80105e8e:	e8 3d c0 ff ff       	call   80101ed0 <iunlockput>
  end_op();
80105e93:	e8 08 d4 ff ff       	call   801032a0 <end_op>
  return 0;
80105e98:	83 c4 10             	add    $0x10,%esp
80105e9b:	31 c0                	xor    %eax,%eax
}
80105e9d:	c9                   	leave  
80105e9e:	c3                   	ret    
80105e9f:	90                   	nop
    end_op();
80105ea0:	e8 fb d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105ea5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105eaa:	c9                   	leave  
80105eab:	c3                   	ret    
80105eac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105eb0 <sys_chdir>:

int
sys_chdir(void)
{
80105eb0:	55                   	push   %ebp
80105eb1:	89 e5                	mov    %esp,%ebp
80105eb3:	56                   	push   %esi
80105eb4:	53                   	push   %ebx
80105eb5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105eb8:	e8 d3 df ff ff       	call   80103e90 <myproc>
80105ebd:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105ebf:	e8 6c d3 ff ff       	call   80103230 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105ec4:	83 ec 08             	sub    $0x8,%esp
80105ec7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eca:	50                   	push   %eax
80105ecb:	6a 00                	push   $0x0
80105ecd:	e8 9e f5 ff ff       	call   80105470 <argstr>
80105ed2:	83 c4 10             	add    $0x10,%esp
80105ed5:	85 c0                	test   %eax,%eax
80105ed7:	78 77                	js     80105f50 <sys_chdir+0xa0>
80105ed9:	83 ec 0c             	sub    $0xc,%esp
80105edc:	ff 75 f4             	pushl  -0xc(%ebp)
80105edf:	e8 7c c6 ff ff       	call   80102560 <namei>
80105ee4:	83 c4 10             	add    $0x10,%esp
80105ee7:	89 c3                	mov    %eax,%ebx
80105ee9:	85 c0                	test   %eax,%eax
80105eeb:	74 63                	je     80105f50 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105eed:	83 ec 0c             	sub    $0xc,%esp
80105ef0:	50                   	push   %eax
80105ef1:	e8 4a bd ff ff       	call   80101c40 <ilock>
  if(ip->type != T_DIR){
80105ef6:	83 c4 10             	add    $0x10,%esp
80105ef9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105efe:	75 30                	jne    80105f30 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105f00:	83 ec 0c             	sub    $0xc,%esp
80105f03:	53                   	push   %ebx
80105f04:	e8 17 be ff ff       	call   80101d20 <iunlock>
  iput(curproc->cwd);
80105f09:	58                   	pop    %eax
80105f0a:	ff 76 6c             	pushl  0x6c(%esi)
80105f0d:	e8 5e be ff ff       	call   80101d70 <iput>
  end_op();
80105f12:	e8 89 d3 ff ff       	call   801032a0 <end_op>
  curproc->cwd = ip;
80105f17:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
80105f1a:	83 c4 10             	add    $0x10,%esp
80105f1d:	31 c0                	xor    %eax,%eax
}
80105f1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f22:	5b                   	pop    %ebx
80105f23:	5e                   	pop    %esi
80105f24:	5d                   	pop    %ebp
80105f25:	c3                   	ret    
80105f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f2d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105f30:	83 ec 0c             	sub    $0xc,%esp
80105f33:	53                   	push   %ebx
80105f34:	e8 97 bf ff ff       	call   80101ed0 <iunlockput>
    end_op();
80105f39:	e8 62 d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105f3e:	83 c4 10             	add    $0x10,%esp
80105f41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f46:	eb d7                	jmp    80105f1f <sys_chdir+0x6f>
80105f48:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4f:	90                   	nop
    end_op();
80105f50:	e8 4b d3 ff ff       	call   801032a0 <end_op>
    return -1;
80105f55:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f5a:	eb c3                	jmp    80105f1f <sys_chdir+0x6f>
80105f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f60 <sys_exec>:

int
sys_exec(void)
{
80105f60:	55                   	push   %ebp
80105f61:	89 e5                	mov    %esp,%ebp
80105f63:	57                   	push   %edi
80105f64:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105f65:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105f6b:	53                   	push   %ebx
80105f6c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105f72:	50                   	push   %eax
80105f73:	6a 00                	push   $0x0
80105f75:	e8 f6 f4 ff ff       	call   80105470 <argstr>
80105f7a:	83 c4 10             	add    $0x10,%esp
80105f7d:	85 c0                	test   %eax,%eax
80105f7f:	0f 88 87 00 00 00    	js     8010600c <sys_exec+0xac>
80105f85:	83 ec 08             	sub    $0x8,%esp
80105f88:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105f8e:	50                   	push   %eax
80105f8f:	6a 01                	push   $0x1
80105f91:	e8 1a f4 ff ff       	call   801053b0 <argint>
80105f96:	83 c4 10             	add    $0x10,%esp
80105f99:	85 c0                	test   %eax,%eax
80105f9b:	78 6f                	js     8010600c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105f9d:	83 ec 04             	sub    $0x4,%esp
80105fa0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105fa6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105fa8:	68 80 00 00 00       	push   $0x80
80105fad:	6a 00                	push   $0x0
80105faf:	56                   	push   %esi
80105fb0:	e8 2b f1 ff ff       	call   801050e0 <memset>
80105fb5:	83 c4 10             	add    $0x10,%esp
80105fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fbf:	90                   	nop
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105fc0:	83 ec 08             	sub    $0x8,%esp
80105fc3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105fc9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105fd0:	50                   	push   %eax
80105fd1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105fd7:	01 f8                	add    %edi,%eax
80105fd9:	50                   	push   %eax
80105fda:	e8 41 f3 ff ff       	call   80105320 <fetchint>
80105fdf:	83 c4 10             	add    $0x10,%esp
80105fe2:	85 c0                	test   %eax,%eax
80105fe4:	78 26                	js     8010600c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105fe6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105fec:	85 c0                	test   %eax,%eax
80105fee:	74 30                	je     80106020 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105ff0:	83 ec 08             	sub    $0x8,%esp
80105ff3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105ff6:	52                   	push   %edx
80105ff7:	50                   	push   %eax
80105ff8:	e8 63 f3 ff ff       	call   80105360 <fetchstr>
80105ffd:	83 c4 10             	add    $0x10,%esp
80106000:	85 c0                	test   %eax,%eax
80106002:	78 08                	js     8010600c <sys_exec+0xac>
  for(i=0;; i++){
80106004:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106007:	83 fb 20             	cmp    $0x20,%ebx
8010600a:	75 b4                	jne    80105fc0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010600c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010600f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106014:	5b                   	pop    %ebx
80106015:	5e                   	pop    %esi
80106016:	5f                   	pop    %edi
80106017:	5d                   	pop    %ebp
80106018:	c3                   	ret    
80106019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80106020:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80106027:	00 00 00 00 
  return exec(path, argv);
8010602b:	83 ec 08             	sub    $0x8,%esp
8010602e:	56                   	push   %esi
8010602f:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80106035:	e8 36 af ff ff       	call   80100f70 <exec>
8010603a:	83 c4 10             	add    $0x10,%esp
}
8010603d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106040:	5b                   	pop    %ebx
80106041:	5e                   	pop    %esi
80106042:	5f                   	pop    %edi
80106043:	5d                   	pop    %ebp
80106044:	c3                   	ret    
80106045:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010604c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106050 <sys_pipe>:

int
sys_pipe(void)
{
80106050:	55                   	push   %ebp
80106051:	89 e5                	mov    %esp,%ebp
80106053:	57                   	push   %edi
80106054:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106055:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106058:	53                   	push   %ebx
80106059:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010605c:	6a 08                	push   $0x8
8010605e:	50                   	push   %eax
8010605f:	6a 00                	push   $0x0
80106061:	e8 9a f3 ff ff       	call   80105400 <argptr>
80106066:	83 c4 10             	add    $0x10,%esp
80106069:	85 c0                	test   %eax,%eax
8010606b:	78 4a                	js     801060b7 <sys_pipe+0x67>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
8010606d:	83 ec 08             	sub    $0x8,%esp
80106070:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106073:	50                   	push   %eax
80106074:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106077:	50                   	push   %eax
80106078:	e8 83 d8 ff ff       	call   80103900 <pipealloc>
8010607d:	83 c4 10             	add    $0x10,%esp
80106080:	85 c0                	test   %eax,%eax
80106082:	78 33                	js     801060b7 <sys_pipe+0x67>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106084:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80106087:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80106089:	e8 02 de ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010608e:	66 90                	xchg   %ax,%ax
    if(curproc->ofile[fd] == 0){
80106090:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
80106094:	85 f6                	test   %esi,%esi
80106096:	74 28                	je     801060c0 <sys_pipe+0x70>
  for(fd = 0; fd < NOFILE; fd++){
80106098:	83 c3 01             	add    $0x1,%ebx
8010609b:	83 fb 10             	cmp    $0x10,%ebx
8010609e:	75 f0                	jne    80106090 <sys_pipe+0x40>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
801060a0:	83 ec 0c             	sub    $0xc,%esp
801060a3:	ff 75 e0             	pushl  -0x20(%ebp)
801060a6:	e8 05 b3 ff ff       	call   801013b0 <fileclose>
    fileclose(wf);
801060ab:	58                   	pop    %eax
801060ac:	ff 75 e4             	pushl  -0x1c(%ebp)
801060af:	e8 fc b2 ff ff       	call   801013b0 <fileclose>
    return -1;
801060b4:	83 c4 10             	add    $0x10,%esp
801060b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060bc:	eb 53                	jmp    80106111 <sys_pipe+0xc1>
801060be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801060c0:	8d 73 08             	lea    0x8(%ebx),%esi
801060c3:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801060c7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801060ca:	e8 c1 dd ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801060cf:	31 d2                	xor    %edx,%edx
801060d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801060d8:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
801060dc:	85 c9                	test   %ecx,%ecx
801060de:	74 20                	je     80106100 <sys_pipe+0xb0>
  for(fd = 0; fd < NOFILE; fd++){
801060e0:	83 c2 01             	add    $0x1,%edx
801060e3:	83 fa 10             	cmp    $0x10,%edx
801060e6:	75 f0                	jne    801060d8 <sys_pipe+0x88>
      myproc()->ofile[fd0] = 0;
801060e8:	e8 a3 dd ff ff       	call   80103e90 <myproc>
801060ed:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801060f4:	00 
801060f5:	eb a9                	jmp    801060a0 <sys_pipe+0x50>
801060f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060fe:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80106100:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
  }
  fd[0] = fd0;
80106104:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106107:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106109:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010610c:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
8010610f:	31 c0                	xor    %eax,%eax
}
80106111:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106114:	5b                   	pop    %ebx
80106115:	5e                   	pop    %esi
80106116:	5f                   	pop    %edi
80106117:	5d                   	pop    %ebp
80106118:	c3                   	ret    
80106119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106120 <sys_get_file_sectors>:
int
sys_get_file_sectors(void){
80106120:	55                   	push   %ebp
80106121:	89 e5                	mov    %esp,%ebp
80106123:	57                   	push   %edi
80106124:	56                   	push   %esi
80106125:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80106126:	8d 5d e4             	lea    -0x1c(%ebp),%ebx
sys_get_file_sectors(void){
80106129:	83 ec 34             	sub    $0x34,%esp
  if(argint(n, &fd) < 0)
8010612c:	53                   	push   %ebx
8010612d:	6a 00                	push   $0x0
8010612f:	e8 7c f2 ff ff       	call   801053b0 <argint>
80106134:	83 c4 10             	add    $0x10,%esp
80106137:	85 c0                	test   %eax,%eax
80106139:	0f 88 e1 00 00 00    	js     80106220 <sys_get_file_sectors+0x100>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010613f:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80106143:	0f 87 d7 00 00 00    	ja     80106220 <sys_get_file_sectors+0x100>
80106149:	e8 42 dd ff ff       	call   80103e90 <myproc>
8010614e:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106151:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
80106155:	89 45 d0             	mov    %eax,-0x30(%ebp)
80106158:	85 c0                	test   %eax,%eax
8010615a:	0f 84 c0 00 00 00    	je     80106220 <sys_get_file_sectors+0x100>
    int fd;

    char* tmp;
    int n;

    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
80106160:	83 ec 08             	sub    $0x8,%esp
80106163:	53                   	push   %ebx
80106164:	6a 02                	push   $0x2
80106166:	e8 45 f2 ff ff       	call   801053b0 <argint>
8010616b:	83 c4 10             	add    $0x10,%esp
8010616e:	85 c0                	test   %eax,%eax
80106170:	0f 88 aa 00 00 00    	js     80106220 <sys_get_file_sectors+0x100>
80106176:	83 ec 04             	sub    $0x4,%esp
80106179:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010617c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010617f:	50                   	push   %eax
80106180:	6a 01                	push   $0x1
80106182:	e8 79 f2 ff ff       	call   80105400 <argptr>
80106187:	83 c4 10             	add    $0x10,%esp
8010618a:	85 c0                	test   %eax,%eax
8010618c:	0f 88 8e 00 00 00    	js     80106220 <sys_get_file_sectors+0x100>
        return -1;
    int* sectors = (int*) tmp;
80106192:	8b 45 e0             	mov    -0x20(%ebp),%eax

    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
80106195:	31 db                	xor    %ebx,%ebx
    int* sectors = (int*) tmp;
80106197:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
8010619a:	8b 45 d0             	mov    -0x30(%ebp),%eax
8010619d:	8b 40 10             	mov    0x10(%eax),%eax
801061a0:	8b 50 58             	mov    0x58(%eax),%edx
801061a3:	f7 c2 ff 01 00 00    	test   $0x1ff,%edx
801061a9:	0f 95 c3             	setne  %bl
801061ac:	c1 ea 09             	shr    $0x9,%edx
801061af:	01 d3                	add    %edx,%ebx
    int min_end = n < blkcnt ? n : blkcnt;
801061b1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801061b4:	39 d3                	cmp    %edx,%ebx
801061b6:	0f 4f da             	cmovg  %edx,%ebx

    int i;
    for(i=0;i<min_end;i++){
801061b9:	85 db                	test   %ebx,%ebx
801061bb:	7e 3a                	jle    801061f7 <sys_get_file_sectors+0xd7>
801061bd:	31 ff                	xor    %edi,%edi
801061bf:	eb 0d                	jmp    801061ce <sys_get_file_sectors+0xae>
801061c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        int sec = getbmap(f->ip, i);
801061c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
801061cb:	8b 40 10             	mov    0x10(%eax),%eax
801061ce:	83 ec 08             	sub    $0x8,%esp
801061d1:	57                   	push   %edi
801061d2:	50                   	push   %eax
801061d3:	e8 c8 c3 ff ff       	call   801025a0 <getbmap>
801061d8:	89 c6                	mov    %eax,%esi
        cprintf("%d ", sec);
801061da:	58                   	pop    %eax
801061db:	5a                   	pop    %edx
801061dc:	56                   	push   %esi
801061dd:	68 f5 86 10 80       	push   $0x801086f5
801061e2:	e8 b9 a4 ff ff       	call   801006a0 <cprintf>
        sectors[i] = sec;
801061e7:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    for(i=0;i<min_end;i++){
801061ea:	83 c4 10             	add    $0x10,%esp
        sectors[i] = sec;
801061ed:	89 34 b8             	mov    %esi,(%eax,%edi,4)
    for(i=0;i<min_end;i++){
801061f0:	83 c7 01             	add    $0x1,%edi
801061f3:	39 fb                	cmp    %edi,%ebx
801061f5:	75 d1                	jne    801061c8 <sys_get_file_sectors+0xa8>
    }
    cprintf("\n");
801061f7:	83 ec 0c             	sub    $0xc,%esp
801061fa:	68 9d 84 10 80       	push   $0x8010849d
801061ff:	e8 9c a4 ff ff       	call   801006a0 <cprintf>
    if (min_end<=n-1)
80106204:	83 c4 10             	add    $0x10,%esp
        sectors[min_end]=-1;
    return 0;
80106207:	31 c0                	xor    %eax,%eax
    if (min_end<=n-1)
80106209:	39 5d e4             	cmp    %ebx,-0x1c(%ebp)
8010620c:	7e 0a                	jle    80106218 <sys_get_file_sectors+0xf8>
        sectors[min_end]=-1;
8010620e:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
80106211:	c7 04 99 ff ff ff ff 	movl   $0xffffffff,(%ecx,%ebx,4)
80106218:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010621b:	5b                   	pop    %ebx
8010621c:	5e                   	pop    %esi
8010621d:	5f                   	pop    %edi
8010621e:	5d                   	pop    %ebp
8010621f:	c3                   	ret    
        return -1;
80106220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106225:	eb f1                	jmp    80106218 <sys_get_file_sectors+0xf8>
80106227:	66 90                	xchg   %ax,%ax
80106229:	66 90                	xchg   %ax,%ax
8010622b:	66 90                	xchg   %ax,%ax
8010622d:	66 90                	xchg   %ax,%ax
8010622f:	90                   	nop

80106230 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106230:	e9 1b de ff ff       	jmp    80104050 <fork>
80106235:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010623c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106240 <sys_exit>:
}

int
sys_exit(void)
{
80106240:	55                   	push   %ebp
80106241:	89 e5                	mov    %esp,%ebp
80106243:	83 ec 08             	sub    $0x8,%esp
  exit();
80106246:	e8 95 e3 ff ff       	call   801045e0 <exit>
  return 0;  // not reached
}
8010624b:	31 c0                	xor    %eax,%eax
8010624d:	c9                   	leave  
8010624e:	c3                   	ret    
8010624f:	90                   	nop

80106250 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106250:	e9 bb e4 ff ff       	jmp    80104710 <wait>
80106255:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010625c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106260 <sys_wait_sleeping>:
}

int sys_wait_sleeping(void){
    return wait_sleeping();
80106260:	e9 ab e8 ff ff       	jmp    80104b10 <wait_sleeping>
80106265:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106270 <sys_set_proc_tracer>:
}
int sys_set_proc_tracer(void){
    return set_proc_tracer();
80106270:	e9 7b e9 ff ff       	jmp    80104bf0 <set_proc_tracer>
80106275:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010627c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106280 <sys_kill>:
}

int
sys_kill(void)
{
80106280:	55                   	push   %ebp
80106281:	89 e5                	mov    %esp,%ebp
80106283:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106286:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106289:	50                   	push   %eax
8010628a:	6a 00                	push   $0x0
8010628c:	e8 1f f1 ff ff       	call   801053b0 <argint>
80106291:	83 c4 10             	add    $0x10,%esp
80106294:	85 c0                	test   %eax,%eax
80106296:	78 18                	js     801062b0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106298:	83 ec 0c             	sub    $0xc,%esp
8010629b:	ff 75 f4             	pushl  -0xc(%ebp)
8010629e:	e8 2d e7 ff ff       	call   801049d0 <kill>
801062a3:	83 c4 10             	add    $0x10,%esp
}
801062a6:	c9                   	leave  
801062a7:	c3                   	ret    
801062a8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062af:	90                   	nop
801062b0:	c9                   	leave  
    return -1;
801062b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801062b6:	c3                   	ret    
801062b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062be:	66 90                	xchg   %ax,%ax

801062c0 <sys_calculate_sum_of_digits>:

int sys_calculate_sum_of_digits(void){
801062c0:	55                   	push   %ebp
801062c1:	89 e5                	mov    %esp,%ebp
801062c3:	57                   	push   %edi
801062c4:	56                   	push   %esi
801062c5:	53                   	push   %ebx
801062c6:	83 ec 0c             	sub    $0xc,%esp
  int num = myproc()->tf->edx; //edx or ebx?
801062c9:	e8 c2 db ff ff       	call   80103e90 <myproc>
  //cprintf("edx : %d\n", myproc()->tf->edx);
  //cprintf("number : %d\n",number);
  int result = 0;
  int reminder = 10;
  while(num / reminder != 0){
801062ce:	ba 67 66 66 66       	mov    $0x66666667,%edx
  int num = myproc()->tf->edx; //edx or ebx?
801062d3:	8b 40 1c             	mov    0x1c(%eax),%eax
801062d6:	8b 48 14             	mov    0x14(%eax),%ecx
  while(num / reminder != 0){
801062d9:	89 c8                	mov    %ecx,%eax
801062db:	f7 ea                	imul   %edx
801062dd:	89 c8                	mov    %ecx,%eax
801062df:	c1 f8 1f             	sar    $0x1f,%eax
801062e2:	c1 fa 02             	sar    $0x2,%edx
801062e5:	89 d3                	mov    %edx,%ebx
801062e7:	29 c3                	sub    %eax,%ebx
801062e9:	8d 41 09             	lea    0x9(%ecx),%eax
801062ec:	83 f8 12             	cmp    $0x12,%eax
801062ef:	76 42                	jbe    80106333 <sys_calculate_sum_of_digits+0x73>
  int result = 0;
801062f1:	31 f6                	xor    %esi,%esi
    result += (num % reminder);
801062f3:	bf 67 66 66 66       	mov    $0x66666667,%edi
801062f8:	eb 08                	jmp    80106302 <sys_calculate_sum_of_digits+0x42>
801062fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  while(num / reminder != 0){
80106300:	89 d3                	mov    %edx,%ebx
    result += (num % reminder);
80106302:	89 c8                	mov    %ecx,%eax
80106304:	f7 ef                	imul   %edi
80106306:	89 c8                	mov    %ecx,%eax
80106308:	c1 f8 1f             	sar    $0x1f,%eax
8010630b:	c1 fa 02             	sar    $0x2,%edx
8010630e:	29 c2                	sub    %eax,%edx
80106310:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106313:	01 c0                	add    %eax,%eax
80106315:	29 c1                	sub    %eax,%ecx
  while(num / reminder != 0){
80106317:	89 d8                	mov    %ebx,%eax
80106319:	f7 ef                	imul   %edi
8010631b:	89 d8                	mov    %ebx,%eax
    result += (num % reminder);
8010631d:	01 ce                	add    %ecx,%esi
  while(num / reminder != 0){
8010631f:	89 d9                	mov    %ebx,%ecx
80106321:	c1 f8 1f             	sar    $0x1f,%eax
80106324:	c1 fa 02             	sar    $0x2,%edx
80106327:	29 c2                	sub    %eax,%edx
80106329:	8d 43 09             	lea    0x9(%ebx),%eax
8010632c:	83 f8 12             	cmp    $0x12,%eax
8010632f:	77 cf                	ja     80106300 <sys_calculate_sum_of_digits+0x40>
    //cprintf("result : %d\n", result);
    // reminder = reminder * 10;
    num = (num / reminder);
    //cprintf("num : %d\n", num);
  }
  result += num;
80106331:	01 f1                	add    %esi,%ecx
  return result;
}
80106333:	83 c4 0c             	add    $0xc,%esp
80106336:	89 c8                	mov    %ecx,%eax
80106338:	5b                   	pop    %ebx
80106339:	5e                   	pop    %esi
8010633a:	5f                   	pop    %edi
8010633b:	5d                   	pop    %ebp
8010633c:	c3                   	ret    
8010633d:	8d 76 00             	lea    0x0(%esi),%esi

80106340 <sys_getpid>:

int
sys_getpid(void)
{
80106340:	55                   	push   %ebp
80106341:	89 e5                	mov    %esp,%ebp
80106343:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106346:	e8 45 db ff ff       	call   80103e90 <myproc>
8010634b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010634e:	c9                   	leave  
8010634f:	c3                   	ret    

80106350 <sys_sbrk>:

int
sys_sbrk(void)
{
80106350:	55                   	push   %ebp
80106351:	89 e5                	mov    %esp,%ebp
80106353:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106354:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106357:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010635a:	50                   	push   %eax
8010635b:	6a 00                	push   $0x0
8010635d:	e8 4e f0 ff ff       	call   801053b0 <argint>
80106362:	83 c4 10             	add    $0x10,%esp
80106365:	85 c0                	test   %eax,%eax
80106367:	78 27                	js     80106390 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106369:	e8 22 db ff ff       	call   80103e90 <myproc>
  if(growproc(n) < 0)
8010636e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106371:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106373:	ff 75 f4             	pushl  -0xc(%ebp)
80106376:	e8 55 dc ff ff       	call   80103fd0 <growproc>
8010637b:	83 c4 10             	add    $0x10,%esp
8010637e:	85 c0                	test   %eax,%eax
80106380:	78 0e                	js     80106390 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106382:	89 d8                	mov    %ebx,%eax
80106384:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106387:	c9                   	leave  
80106388:	c3                   	ret    
80106389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106390:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106395:	eb eb                	jmp    80106382 <sys_sbrk+0x32>
80106397:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010639e:	66 90                	xchg   %ax,%ax

801063a0 <sys_sleep>:

int
sys_sleep(void)
{
801063a0:	55                   	push   %ebp
801063a1:	89 e5                	mov    %esp,%ebp
801063a3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801063a4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801063a7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801063aa:	50                   	push   %eax
801063ab:	6a 00                	push   $0x0
801063ad:	e8 fe ef ff ff       	call   801053b0 <argint>
801063b2:	83 c4 10             	add    $0x10,%esp
801063b5:	85 c0                	test   %eax,%eax
801063b7:	0f 88 8a 00 00 00    	js     80106447 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801063bd:	83 ec 0c             	sub    $0xc,%esp
801063c0:	68 a0 53 11 80       	push   $0x801153a0
801063c5:	e8 56 ec ff ff       	call   80105020 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801063ca:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801063cd:	8b 1d 80 53 11 80    	mov    0x80115380,%ebx
  while(ticks - ticks0 < n){
801063d3:	83 c4 10             	add    $0x10,%esp
801063d6:	85 d2                	test   %edx,%edx
801063d8:	75 27                	jne    80106401 <sys_sleep+0x61>
801063da:	eb 54                	jmp    80106430 <sys_sleep+0x90>
801063dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801063e0:	83 ec 08             	sub    $0x8,%esp
801063e3:	68 a0 53 11 80       	push   $0x801153a0
801063e8:	68 80 53 11 80       	push   $0x80115380
801063ed:	e8 be e4 ff ff       	call   801048b0 <sleep>
  while(ticks - ticks0 < n){
801063f2:	a1 80 53 11 80       	mov    0x80115380,%eax
801063f7:	83 c4 10             	add    $0x10,%esp
801063fa:	29 d8                	sub    %ebx,%eax
801063fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801063ff:	73 2f                	jae    80106430 <sys_sleep+0x90>
    if(myproc()->killed){
80106401:	e8 8a da ff ff       	call   80103e90 <myproc>
80106406:	8b 40 28             	mov    0x28(%eax),%eax
80106409:	85 c0                	test   %eax,%eax
8010640b:	74 d3                	je     801063e0 <sys_sleep+0x40>
      release(&tickslock);
8010640d:	83 ec 0c             	sub    $0xc,%esp
80106410:	68 a0 53 11 80       	push   $0x801153a0
80106415:	e8 a6 eb ff ff       	call   80104fc0 <release>
  }
  release(&tickslock);
  return 0;
}
8010641a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010641d:	83 c4 10             	add    $0x10,%esp
80106420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106425:	c9                   	leave  
80106426:	c3                   	ret    
80106427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010642e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106430:	83 ec 0c             	sub    $0xc,%esp
80106433:	68 a0 53 11 80       	push   $0x801153a0
80106438:	e8 83 eb ff ff       	call   80104fc0 <release>
  return 0;
8010643d:	83 c4 10             	add    $0x10,%esp
80106440:	31 c0                	xor    %eax,%eax
}
80106442:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106445:	c9                   	leave  
80106446:	c3                   	ret    
    return -1;
80106447:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010644c:	eb f4                	jmp    80106442 <sys_sleep+0xa2>
8010644e:	66 90                	xchg   %ax,%ax

80106450 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106450:	55                   	push   %ebp
80106451:	89 e5                	mov    %esp,%ebp
80106453:	53                   	push   %ebx
80106454:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106457:	68 a0 53 11 80       	push   $0x801153a0
8010645c:	e8 bf eb ff ff       	call   80105020 <acquire>
  xticks = ticks;
80106461:	8b 1d 80 53 11 80    	mov    0x80115380,%ebx
  release(&tickslock);
80106467:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
8010646e:	e8 4d eb ff ff       	call   80104fc0 <release>
  return xticks;
}
80106473:	89 d8                	mov    %ebx,%eax
80106475:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106478:	c9                   	leave  
80106479:	c3                   	ret    
8010647a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106480 <sys_get_parent_pid>:

int
sys_get_parent_pid(void)
{
80106480:	55                   	push   %ebp
80106481:	89 e5                	mov    %esp,%ebp
80106483:	83 ec 08             	sub    $0x8,%esp
	return myproc()->parent->pid;
80106486:	e8 05 da ff ff       	call   80103e90 <myproc>
8010648b:	8b 40 14             	mov    0x14(%eax),%eax
8010648e:	8b 40 10             	mov    0x10(%eax),%eax
}
80106491:	c9                   	leave  
80106492:	c3                   	ret    
80106493:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010649a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801064a0 <sys_get_proc_level>:

int sys_get_proc_level(void){
801064a0:	55                   	push   %ebp
801064a1:	89 e5                	mov    %esp,%ebp
801064a3:	83 ec 20             	sub    $0x20,%esp
    int pid;
    if(argint(0, &pid)<0)
801064a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064a9:	50                   	push   %eax
801064aa:	6a 00                	push   $0x0
801064ac:	e8 ff ee ff ff       	call   801053b0 <argint>
801064b1:	83 c4 10             	add    $0x10,%esp
801064b4:	85 c0                	test   %eax,%eax
801064b6:	78 18                	js     801064d0 <sys_get_proc_level+0x30>
        return -1;
    return get_proc_queue_level(pid);
801064b8:	83 ec 0c             	sub    $0xc,%esp
801064bb:	ff 75 f4             	pushl  -0xc(%ebp)
801064be:	e8 ed e7 ff ff       	call   80104cb0 <get_proc_queue_level>
801064c3:	83 c4 10             	add    $0x10,%esp
}
801064c6:	c9                   	leave  
801064c7:	c3                   	ret    
801064c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064cf:	90                   	nop
801064d0:	c9                   	leave  
        return -1;
801064d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801064d6:	c3                   	ret    
801064d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801064de:	66 90                	xchg   %ax,%ax

801064e0 <sys_set_proc_level>:

int sys_set_proc_level(void){
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	83 ec 20             	sub    $0x20,%esp
    int pid, target_queue;
    if(argint(0, &pid)<0 || pid<0)
801064e6:	8d 45 f0             	lea    -0x10(%ebp),%eax
801064e9:	50                   	push   %eax
801064ea:	6a 00                	push   $0x0
801064ec:	e8 bf ee ff ff       	call   801053b0 <argint>
801064f1:	83 c4 10             	add    $0x10,%esp
801064f4:	0b 45 f0             	or     -0x10(%ebp),%eax
801064f7:	78 37                	js     80106530 <sys_set_proc_level+0x50>
        return -1;

    if(argint(1, &target_queue)<0 || target_queue<=0 || target_queue>3)
801064f9:	83 ec 08             	sub    $0x8,%esp
801064fc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801064ff:	50                   	push   %eax
80106500:	6a 01                	push   $0x1
80106502:	e8 a9 ee ff ff       	call   801053b0 <argint>
80106507:	83 c4 10             	add    $0x10,%esp
8010650a:	85 c0                	test   %eax,%eax
8010650c:	78 22                	js     80106530 <sys_set_proc_level+0x50>
8010650e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106511:	8d 50 ff             	lea    -0x1(%eax),%edx
80106514:	83 fa 02             	cmp    $0x2,%edx
80106517:	77 17                	ja     80106530 <sys_set_proc_level+0x50>
        return -1;

    set_proc_queue_level(pid, target_queue);
80106519:	83 ec 08             	sub    $0x8,%esp
8010651c:	50                   	push   %eax
8010651d:	ff 75 f0             	pushl  -0x10(%ebp)
80106520:	e8 cb e7 ff ff       	call   80104cf0 <set_proc_queue_level>
    return 0;
80106525:	83 c4 10             	add    $0x10,%esp
80106528:	31 c0                	xor    %eax,%eax
8010652a:	c9                   	leave  
8010652b:	c3                   	ret    
8010652c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106530:	c9                   	leave  
        return -1;
80106531:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106536:	c3                   	ret    

80106537 <alltraps>:
80106537:	1e                   	push   %ds
80106538:	06                   	push   %es
80106539:	0f a0                	push   %fs
8010653b:	0f a8                	push   %gs
8010653d:	60                   	pusha  
8010653e:	66 b8 10 00          	mov    $0x10,%ax
80106542:	8e d8                	mov    %eax,%ds
80106544:	8e c0                	mov    %eax,%es
80106546:	54                   	push   %esp
80106547:	e8 c4 00 00 00       	call   80106610 <trap>
8010654c:	83 c4 04             	add    $0x4,%esp

8010654f <trapret>:
8010654f:	61                   	popa   
80106550:	0f a9                	pop    %gs
80106552:	0f a1                	pop    %fs
80106554:	07                   	pop    %es
80106555:	1f                   	pop    %ds
80106556:	83 c4 08             	add    $0x8,%esp
80106559:	cf                   	iret   
8010655a:	66 90                	xchg   %ax,%ax
8010655c:	66 90                	xchg   %ax,%ax
8010655e:	66 90                	xchg   %ax,%ax

80106560 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106560:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106561:	31 c0                	xor    %eax,%eax
{
80106563:	89 e5                	mov    %esp,%ebp
80106565:	83 ec 08             	sub    $0x8,%esp
80106568:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010656f:	90                   	nop
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106570:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106577:	c7 04 c5 e2 53 11 80 	movl   $0x8e000008,-0x7feeac1e(,%eax,8)
8010657e:	08 00 00 8e 
80106582:	66 89 14 c5 e0 53 11 	mov    %dx,-0x7feeac20(,%eax,8)
80106589:	80 
8010658a:	c1 ea 10             	shr    $0x10,%edx
8010658d:	66 89 14 c5 e6 53 11 	mov    %dx,-0x7feeac1a(,%eax,8)
80106594:	80 
  for(i = 0; i < 256; i++)
80106595:	83 c0 01             	add    $0x1,%eax
80106598:	3d 00 01 00 00       	cmp    $0x100,%eax
8010659d:	75 d1                	jne    80106570 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010659f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065a2:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
801065a7:	c7 05 e2 55 11 80 08 	movl   $0xef000008,0x801155e2
801065ae:	00 00 ef 
  initlock(&tickslock, "time");
801065b1:	68 f9 86 10 80       	push   $0x801086f9
801065b6:	68 a0 53 11 80       	push   $0x801153a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801065bb:	66 a3 e0 55 11 80    	mov    %ax,0x801155e0
801065c1:	c1 e8 10             	shr    $0x10,%eax
801065c4:	66 a3 e6 55 11 80    	mov    %ax,0x801155e6
  initlock(&tickslock, "time");
801065ca:	e8 81 e8 ff ff       	call   80104e50 <initlock>
}
801065cf:	83 c4 10             	add    $0x10,%esp
801065d2:	c9                   	leave  
801065d3:	c3                   	ret    
801065d4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065db:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065df:	90                   	nop

801065e0 <idtinit>:

void
idtinit(void)
{
801065e0:	55                   	push   %ebp
  pd[0] = size-1;
801065e1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801065e6:	89 e5                	mov    %esp,%ebp
801065e8:	83 ec 10             	sub    $0x10,%esp
801065eb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801065ef:	b8 e0 53 11 80       	mov    $0x801153e0,%eax
801065f4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801065f8:	c1 e8 10             	shr    $0x10,%eax
801065fb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801065ff:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106602:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106605:	c9                   	leave  
80106606:	c3                   	ret    
80106607:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010660e:	66 90                	xchg   %ax,%ax

80106610 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106610:	55                   	push   %ebp
80106611:	89 e5                	mov    %esp,%ebp
80106613:	57                   	push   %edi
80106614:	56                   	push   %esi
80106615:	53                   	push   %ebx
80106616:	83 ec 1c             	sub    $0x1c,%esp
80106619:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
8010661c:	8b 43 30             	mov    0x30(%ebx),%eax
8010661f:	83 f8 40             	cmp    $0x40,%eax
80106622:	0f 84 68 01 00 00    	je     80106790 <trap+0x180>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106628:	83 e8 20             	sub    $0x20,%eax
8010662b:	83 f8 1f             	cmp    $0x1f,%eax
8010662e:	0f 87 8c 00 00 00    	ja     801066c0 <trap+0xb0>
80106634:	ff 24 85 a0 87 10 80 	jmp    *-0x7fef7860(,%eax,4)
8010663b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010663f:	90                   	nop
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106640:	e8 cb c0 ff ff       	call   80102710 <ideintr>
    lapiceoi();
80106645:	e8 96 c7 ff ff       	call   80102de0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010664a:	e8 41 d8 ff ff       	call   80103e90 <myproc>
8010664f:	85 c0                	test   %eax,%eax
80106651:	74 1d                	je     80106670 <trap+0x60>
80106653:	e8 38 d8 ff ff       	call   80103e90 <myproc>
80106658:	8b 50 28             	mov    0x28(%eax),%edx
8010665b:	85 d2                	test   %edx,%edx
8010665d:	74 11                	je     80106670 <trap+0x60>
8010665f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106663:	83 e0 03             	and    $0x3,%eax
80106666:	66 83 f8 03          	cmp    $0x3,%ax
8010666a:	0f 84 e8 01 00 00    	je     80106858 <trap+0x248>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106670:	e8 1b d8 ff ff       	call   80103e90 <myproc>
80106675:	85 c0                	test   %eax,%eax
80106677:	74 0f                	je     80106688 <trap+0x78>
80106679:	e8 12 d8 ff ff       	call   80103e90 <myproc>
8010667e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106682:	0f 84 b8 00 00 00    	je     80106740 <trap+0x130>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106688:	e8 03 d8 ff ff       	call   80103e90 <myproc>
8010668d:	85 c0                	test   %eax,%eax
8010668f:	74 1d                	je     801066ae <trap+0x9e>
80106691:	e8 fa d7 ff ff       	call   80103e90 <myproc>
80106696:	8b 40 28             	mov    0x28(%eax),%eax
80106699:	85 c0                	test   %eax,%eax
8010669b:	74 11                	je     801066ae <trap+0x9e>
8010669d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801066a1:	83 e0 03             	and    $0x3,%eax
801066a4:	66 83 f8 03          	cmp    $0x3,%ax
801066a8:	0f 84 0f 01 00 00    	je     801067bd <trap+0x1ad>
    exit();
}
801066ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801066b1:	5b                   	pop    %ebx
801066b2:	5e                   	pop    %esi
801066b3:	5f                   	pop    %edi
801066b4:	5d                   	pop    %ebp
801066b5:	c3                   	ret    
801066b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066bd:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc() == 0 || (tf->cs&3) == 0){
801066c0:	e8 cb d7 ff ff       	call   80103e90 <myproc>
801066c5:	8b 7b 38             	mov    0x38(%ebx),%edi
801066c8:	85 c0                	test   %eax,%eax
801066ca:	0f 84 a2 01 00 00    	je     80106872 <trap+0x262>
801066d0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801066d4:	0f 84 98 01 00 00    	je     80106872 <trap+0x262>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801066da:	0f 20 d1             	mov    %cr2,%ecx
801066dd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066e0:	e8 8b d7 ff ff       	call   80103e70 <cpuid>
801066e5:	8b 73 30             	mov    0x30(%ebx),%esi
801066e8:	89 45 dc             	mov    %eax,-0x24(%ebp)
801066eb:	8b 43 34             	mov    0x34(%ebx),%eax
801066ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
801066f1:	e8 9a d7 ff ff       	call   80103e90 <myproc>
801066f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801066f9:	e8 92 d7 ff ff       	call   80103e90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801066fe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106701:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106704:	51                   	push   %ecx
80106705:	57                   	push   %edi
80106706:	52                   	push   %edx
80106707:	ff 75 e4             	pushl  -0x1c(%ebp)
8010670a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
8010670b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010670e:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106711:	56                   	push   %esi
80106712:	ff 70 10             	pushl  0x10(%eax)
80106715:	68 5c 87 10 80       	push   $0x8010875c
8010671a:	e8 81 9f ff ff       	call   801006a0 <cprintf>
    myproc()->killed = 1;
8010671f:	83 c4 20             	add    $0x20,%esp
80106722:	e8 69 d7 ff ff       	call   80103e90 <myproc>
80106727:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010672e:	e8 5d d7 ff ff       	call   80103e90 <myproc>
80106733:	85 c0                	test   %eax,%eax
80106735:	0f 85 18 ff ff ff    	jne    80106653 <trap+0x43>
8010673b:	e9 30 ff ff ff       	jmp    80106670 <trap+0x60>
  if(myproc() && myproc()->state == RUNNING &&
80106740:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106744:	0f 85 3e ff ff ff    	jne    80106688 <trap+0x78>
    yield();
8010674a:	e8 f1 e0 ff ff       	call   80104840 <yield>
8010674f:	e9 34 ff ff ff       	jmp    80106688 <trap+0x78>
80106754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106758:	8b 7b 38             	mov    0x38(%ebx),%edi
8010675b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
8010675f:	e8 0c d7 ff ff       	call   80103e70 <cpuid>
80106764:	57                   	push   %edi
80106765:	56                   	push   %esi
80106766:	50                   	push   %eax
80106767:	68 04 87 10 80       	push   $0x80108704
8010676c:	e8 2f 9f ff ff       	call   801006a0 <cprintf>
    lapiceoi();
80106771:	e8 6a c6 ff ff       	call   80102de0 <lapiceoi>
    break;
80106776:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106779:	e8 12 d7 ff ff       	call   80103e90 <myproc>
8010677e:	85 c0                	test   %eax,%eax
80106780:	0f 85 cd fe ff ff    	jne    80106653 <trap+0x43>
80106786:	e9 e5 fe ff ff       	jmp    80106670 <trap+0x60>
8010678b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010678f:	90                   	nop
    if(myproc()->killed)
80106790:	e8 fb d6 ff ff       	call   80103e90 <myproc>
80106795:	8b 70 28             	mov    0x28(%eax),%esi
80106798:	85 f6                	test   %esi,%esi
8010679a:	0f 85 c8 00 00 00    	jne    80106868 <trap+0x258>
    myproc()->tf = tf;
801067a0:	e8 eb d6 ff ff       	call   80103e90 <myproc>
801067a5:	89 58 1c             	mov    %ebx,0x1c(%eax)
    syscall();
801067a8:	e8 43 ed ff ff       	call   801054f0 <syscall>
    if(myproc()->killed)
801067ad:	e8 de d6 ff ff       	call   80103e90 <myproc>
801067b2:	8b 48 28             	mov    0x28(%eax),%ecx
801067b5:	85 c9                	test   %ecx,%ecx
801067b7:	0f 84 f1 fe ff ff    	je     801066ae <trap+0x9e>
}
801067bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067c0:	5b                   	pop    %ebx
801067c1:	5e                   	pop    %esi
801067c2:	5f                   	pop    %edi
801067c3:	5d                   	pop    %ebp
      exit();
801067c4:	e9 17 de ff ff       	jmp    801045e0 <exit>
801067c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
801067d0:	e8 5b 02 00 00       	call   80106a30 <uartintr>
    lapiceoi();
801067d5:	e8 06 c6 ff ff       	call   80102de0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067da:	e8 b1 d6 ff ff       	call   80103e90 <myproc>
801067df:	85 c0                	test   %eax,%eax
801067e1:	0f 85 6c fe ff ff    	jne    80106653 <trap+0x43>
801067e7:	e9 84 fe ff ff       	jmp    80106670 <trap+0x60>
801067ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801067f0:	e8 ab c4 ff ff       	call   80102ca0 <kbdintr>
    lapiceoi();
801067f5:	e8 e6 c5 ff ff       	call   80102de0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067fa:	e8 91 d6 ff ff       	call   80103e90 <myproc>
801067ff:	85 c0                	test   %eax,%eax
80106801:	0f 85 4c fe ff ff    	jne    80106653 <trap+0x43>
80106807:	e9 64 fe ff ff       	jmp    80106670 <trap+0x60>
8010680c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106810:	e8 5b d6 ff ff       	call   80103e70 <cpuid>
80106815:	85 c0                	test   %eax,%eax
80106817:	0f 85 28 fe ff ff    	jne    80106645 <trap+0x35>
      acquire(&tickslock);
8010681d:	83 ec 0c             	sub    $0xc,%esp
80106820:	68 a0 53 11 80       	push   $0x801153a0
80106825:	e8 f6 e7 ff ff       	call   80105020 <acquire>
      wakeup(&ticks);
8010682a:	c7 04 24 80 53 11 80 	movl   $0x80115380,(%esp)
      ticks++;
80106831:	83 05 80 53 11 80 01 	addl   $0x1,0x80115380
      wakeup(&ticks);
80106838:	e8 33 e1 ff ff       	call   80104970 <wakeup>
      release(&tickslock);
8010683d:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
80106844:	e8 77 e7 ff ff       	call   80104fc0 <release>
80106849:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
8010684c:	e9 f4 fd ff ff       	jmp    80106645 <trap+0x35>
80106851:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106858:	e8 83 dd ff ff       	call   801045e0 <exit>
8010685d:	e9 0e fe ff ff       	jmp    80106670 <trap+0x60>
80106862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106868:	e8 73 dd ff ff       	call   801045e0 <exit>
8010686d:	e9 2e ff ff ff       	jmp    801067a0 <trap+0x190>
80106872:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106875:	e8 f6 d5 ff ff       	call   80103e70 <cpuid>
8010687a:	83 ec 0c             	sub    $0xc,%esp
8010687d:	56                   	push   %esi
8010687e:	57                   	push   %edi
8010687f:	50                   	push   %eax
80106880:	ff 73 30             	pushl  0x30(%ebx)
80106883:	68 28 87 10 80       	push   $0x80108728
80106888:	e8 13 9e ff ff       	call   801006a0 <cprintf>
      panic("trap");
8010688d:	83 c4 14             	add    $0x14,%esp
80106890:	68 fe 86 10 80       	push   $0x801086fe
80106895:	e8 e6 9a ff ff       	call   80100380 <panic>
8010689a:	66 90                	xchg   %ax,%ax
8010689c:	66 90                	xchg   %ax,%ax
8010689e:	66 90                	xchg   %ax,%ax

801068a0 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
801068a0:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
801068a5:	85 c0                	test   %eax,%eax
801068a7:	74 17                	je     801068c0 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801068a9:	ba fd 03 00 00       	mov    $0x3fd,%edx
801068ae:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801068af:	a8 01                	test   $0x1,%al
801068b1:	74 0d                	je     801068c0 <uartgetc+0x20>
801068b3:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068b8:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801068b9:	0f b6 c0             	movzbl %al,%eax
801068bc:	c3                   	ret    
801068bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801068c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801068c5:	c3                   	ret    
801068c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801068cd:	8d 76 00             	lea    0x0(%esi),%esi

801068d0 <uartinit>:
{
801068d0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801068d1:	31 c9                	xor    %ecx,%ecx
801068d3:	89 c8                	mov    %ecx,%eax
801068d5:	89 e5                	mov    %esp,%ebp
801068d7:	57                   	push   %edi
801068d8:	bf fa 03 00 00       	mov    $0x3fa,%edi
801068dd:	56                   	push   %esi
801068de:	89 fa                	mov    %edi,%edx
801068e0:	53                   	push   %ebx
801068e1:	83 ec 1c             	sub    $0x1c,%esp
801068e4:	ee                   	out    %al,(%dx)
801068e5:	be fb 03 00 00       	mov    $0x3fb,%esi
801068ea:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801068ef:	89 f2                	mov    %esi,%edx
801068f1:	ee                   	out    %al,(%dx)
801068f2:	b8 0c 00 00 00       	mov    $0xc,%eax
801068f7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801068fc:	ee                   	out    %al,(%dx)
801068fd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106902:	89 c8                	mov    %ecx,%eax
80106904:	89 da                	mov    %ebx,%edx
80106906:	ee                   	out    %al,(%dx)
80106907:	b8 03 00 00 00       	mov    $0x3,%eax
8010690c:	89 f2                	mov    %esi,%edx
8010690e:	ee                   	out    %al,(%dx)
8010690f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106914:	89 c8                	mov    %ecx,%eax
80106916:	ee                   	out    %al,(%dx)
80106917:	b8 01 00 00 00       	mov    $0x1,%eax
8010691c:	89 da                	mov    %ebx,%edx
8010691e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010691f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106924:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106925:	3c ff                	cmp    $0xff,%al
80106927:	0f 84 93 00 00 00    	je     801069c0 <uartinit+0xf0>
  uart = 1;
8010692d:	c7 05 e0 5b 11 80 01 	movl   $0x1,0x80115be0
80106934:	00 00 00 
80106937:	89 fa                	mov    %edi,%edx
80106939:	ec                   	in     (%dx),%al
8010693a:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010693f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106940:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80106943:	bf 20 88 10 80       	mov    $0x80108820,%edi
80106948:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
8010694d:	6a 00                	push   $0x0
8010694f:	6a 04                	push   $0x4
80106951:	e8 fa bf ff ff       	call   80102950 <ioapicenable>
80106956:	c6 45 e7 76          	movb   $0x76,-0x19(%ebp)
8010695a:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
8010695d:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
80106961:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(!uart)
80106968:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
8010696d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106972:	85 c0                	test   %eax,%eax
80106974:	75 1c                	jne    80106992 <uartinit+0xc2>
80106976:	eb 2b                	jmp    801069a3 <uartinit+0xd3>
80106978:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010697f:	90                   	nop
    microdelay(10);
80106980:	83 ec 0c             	sub    $0xc,%esp
80106983:	6a 0a                	push   $0xa
80106985:	e8 76 c4 ff ff       	call   80102e00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010698a:	83 c4 10             	add    $0x10,%esp
8010698d:	83 eb 01             	sub    $0x1,%ebx
80106990:	74 07                	je     80106999 <uartinit+0xc9>
80106992:	89 f2                	mov    %esi,%edx
80106994:	ec                   	in     (%dx),%al
80106995:	a8 20                	test   $0x20,%al
80106997:	74 e7                	je     80106980 <uartinit+0xb0>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106999:	0f b6 45 e6          	movzbl -0x1a(%ebp),%eax
8010699d:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069a2:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
801069a3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
801069a7:	83 c7 01             	add    $0x1,%edi
801069aa:	84 c0                	test   %al,%al
801069ac:	74 12                	je     801069c0 <uartinit+0xf0>
801069ae:	88 45 e6             	mov    %al,-0x1a(%ebp)
801069b1:	0f b6 47 01          	movzbl 0x1(%edi),%eax
801069b5:	88 45 e7             	mov    %al,-0x19(%ebp)
801069b8:	eb ae                	jmp    80106968 <uartinit+0x98>
801069ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
}
801069c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069c3:	5b                   	pop    %ebx
801069c4:	5e                   	pop    %esi
801069c5:	5f                   	pop    %edi
801069c6:	5d                   	pop    %ebp
801069c7:	c3                   	ret    
801069c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801069cf:	90                   	nop

801069d0 <uartputc>:
  if(!uart)
801069d0:	a1 e0 5b 11 80       	mov    0x80115be0,%eax
801069d5:	85 c0                	test   %eax,%eax
801069d7:	74 47                	je     80106a20 <uartputc+0x50>
{
801069d9:	55                   	push   %ebp
801069da:	89 e5                	mov    %esp,%ebp
801069dc:	56                   	push   %esi
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801069dd:	be fd 03 00 00       	mov    $0x3fd,%esi
801069e2:	53                   	push   %ebx
801069e3:	bb 80 00 00 00       	mov    $0x80,%ebx
801069e8:	eb 18                	jmp    80106a02 <uartputc+0x32>
801069ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
801069f0:	83 ec 0c             	sub    $0xc,%esp
801069f3:	6a 0a                	push   $0xa
801069f5:	e8 06 c4 ff ff       	call   80102e00 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069fa:	83 c4 10             	add    $0x10,%esp
801069fd:	83 eb 01             	sub    $0x1,%ebx
80106a00:	74 07                	je     80106a09 <uartputc+0x39>
80106a02:	89 f2                	mov    %esi,%edx
80106a04:	ec                   	in     (%dx),%al
80106a05:	a8 20                	test   $0x20,%al
80106a07:	74 e7                	je     801069f0 <uartputc+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106a09:	8b 45 08             	mov    0x8(%ebp),%eax
80106a0c:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a11:	ee                   	out    %al,(%dx)
}
80106a12:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106a15:	5b                   	pop    %ebx
80106a16:	5e                   	pop    %esi
80106a17:	5d                   	pop    %ebp
80106a18:	c3                   	ret    
80106a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a20:	c3                   	ret    
80106a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a28:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a2f:	90                   	nop

80106a30 <uartintr>:

void
uartintr(void)
{
80106a30:	55                   	push   %ebp
80106a31:	89 e5                	mov    %esp,%ebp
80106a33:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106a36:	68 a0 68 10 80       	push   $0x801068a0
80106a3b:	e8 30 a1 ff ff       	call   80100b70 <consoleintr>
}
80106a40:	83 c4 10             	add    $0x10,%esp
80106a43:	c9                   	leave  
80106a44:	c3                   	ret    

80106a45 <vector0>:
80106a45:	6a 00                	push   $0x0
80106a47:	6a 00                	push   $0x0
80106a49:	e9 e9 fa ff ff       	jmp    80106537 <alltraps>

80106a4e <vector1>:
80106a4e:	6a 00                	push   $0x0
80106a50:	6a 01                	push   $0x1
80106a52:	e9 e0 fa ff ff       	jmp    80106537 <alltraps>

80106a57 <vector2>:
80106a57:	6a 00                	push   $0x0
80106a59:	6a 02                	push   $0x2
80106a5b:	e9 d7 fa ff ff       	jmp    80106537 <alltraps>

80106a60 <vector3>:
80106a60:	6a 00                	push   $0x0
80106a62:	6a 03                	push   $0x3
80106a64:	e9 ce fa ff ff       	jmp    80106537 <alltraps>

80106a69 <vector4>:
80106a69:	6a 00                	push   $0x0
80106a6b:	6a 04                	push   $0x4
80106a6d:	e9 c5 fa ff ff       	jmp    80106537 <alltraps>

80106a72 <vector5>:
80106a72:	6a 00                	push   $0x0
80106a74:	6a 05                	push   $0x5
80106a76:	e9 bc fa ff ff       	jmp    80106537 <alltraps>

80106a7b <vector6>:
80106a7b:	6a 00                	push   $0x0
80106a7d:	6a 06                	push   $0x6
80106a7f:	e9 b3 fa ff ff       	jmp    80106537 <alltraps>

80106a84 <vector7>:
80106a84:	6a 00                	push   $0x0
80106a86:	6a 07                	push   $0x7
80106a88:	e9 aa fa ff ff       	jmp    80106537 <alltraps>

80106a8d <vector8>:
80106a8d:	6a 08                	push   $0x8
80106a8f:	e9 a3 fa ff ff       	jmp    80106537 <alltraps>

80106a94 <vector9>:
80106a94:	6a 00                	push   $0x0
80106a96:	6a 09                	push   $0x9
80106a98:	e9 9a fa ff ff       	jmp    80106537 <alltraps>

80106a9d <vector10>:
80106a9d:	6a 0a                	push   $0xa
80106a9f:	e9 93 fa ff ff       	jmp    80106537 <alltraps>

80106aa4 <vector11>:
80106aa4:	6a 0b                	push   $0xb
80106aa6:	e9 8c fa ff ff       	jmp    80106537 <alltraps>

80106aab <vector12>:
80106aab:	6a 0c                	push   $0xc
80106aad:	e9 85 fa ff ff       	jmp    80106537 <alltraps>

80106ab2 <vector13>:
80106ab2:	6a 0d                	push   $0xd
80106ab4:	e9 7e fa ff ff       	jmp    80106537 <alltraps>

80106ab9 <vector14>:
80106ab9:	6a 0e                	push   $0xe
80106abb:	e9 77 fa ff ff       	jmp    80106537 <alltraps>

80106ac0 <vector15>:
80106ac0:	6a 00                	push   $0x0
80106ac2:	6a 0f                	push   $0xf
80106ac4:	e9 6e fa ff ff       	jmp    80106537 <alltraps>

80106ac9 <vector16>:
80106ac9:	6a 00                	push   $0x0
80106acb:	6a 10                	push   $0x10
80106acd:	e9 65 fa ff ff       	jmp    80106537 <alltraps>

80106ad2 <vector17>:
80106ad2:	6a 11                	push   $0x11
80106ad4:	e9 5e fa ff ff       	jmp    80106537 <alltraps>

80106ad9 <vector18>:
80106ad9:	6a 00                	push   $0x0
80106adb:	6a 12                	push   $0x12
80106add:	e9 55 fa ff ff       	jmp    80106537 <alltraps>

80106ae2 <vector19>:
80106ae2:	6a 00                	push   $0x0
80106ae4:	6a 13                	push   $0x13
80106ae6:	e9 4c fa ff ff       	jmp    80106537 <alltraps>

80106aeb <vector20>:
80106aeb:	6a 00                	push   $0x0
80106aed:	6a 14                	push   $0x14
80106aef:	e9 43 fa ff ff       	jmp    80106537 <alltraps>

80106af4 <vector21>:
80106af4:	6a 00                	push   $0x0
80106af6:	6a 15                	push   $0x15
80106af8:	e9 3a fa ff ff       	jmp    80106537 <alltraps>

80106afd <vector22>:
80106afd:	6a 00                	push   $0x0
80106aff:	6a 16                	push   $0x16
80106b01:	e9 31 fa ff ff       	jmp    80106537 <alltraps>

80106b06 <vector23>:
80106b06:	6a 00                	push   $0x0
80106b08:	6a 17                	push   $0x17
80106b0a:	e9 28 fa ff ff       	jmp    80106537 <alltraps>

80106b0f <vector24>:
80106b0f:	6a 00                	push   $0x0
80106b11:	6a 18                	push   $0x18
80106b13:	e9 1f fa ff ff       	jmp    80106537 <alltraps>

80106b18 <vector25>:
80106b18:	6a 00                	push   $0x0
80106b1a:	6a 19                	push   $0x19
80106b1c:	e9 16 fa ff ff       	jmp    80106537 <alltraps>

80106b21 <vector26>:
80106b21:	6a 00                	push   $0x0
80106b23:	6a 1a                	push   $0x1a
80106b25:	e9 0d fa ff ff       	jmp    80106537 <alltraps>

80106b2a <vector27>:
80106b2a:	6a 00                	push   $0x0
80106b2c:	6a 1b                	push   $0x1b
80106b2e:	e9 04 fa ff ff       	jmp    80106537 <alltraps>

80106b33 <vector28>:
80106b33:	6a 00                	push   $0x0
80106b35:	6a 1c                	push   $0x1c
80106b37:	e9 fb f9 ff ff       	jmp    80106537 <alltraps>

80106b3c <vector29>:
80106b3c:	6a 00                	push   $0x0
80106b3e:	6a 1d                	push   $0x1d
80106b40:	e9 f2 f9 ff ff       	jmp    80106537 <alltraps>

80106b45 <vector30>:
80106b45:	6a 00                	push   $0x0
80106b47:	6a 1e                	push   $0x1e
80106b49:	e9 e9 f9 ff ff       	jmp    80106537 <alltraps>

80106b4e <vector31>:
80106b4e:	6a 00                	push   $0x0
80106b50:	6a 1f                	push   $0x1f
80106b52:	e9 e0 f9 ff ff       	jmp    80106537 <alltraps>

80106b57 <vector32>:
80106b57:	6a 00                	push   $0x0
80106b59:	6a 20                	push   $0x20
80106b5b:	e9 d7 f9 ff ff       	jmp    80106537 <alltraps>

80106b60 <vector33>:
80106b60:	6a 00                	push   $0x0
80106b62:	6a 21                	push   $0x21
80106b64:	e9 ce f9 ff ff       	jmp    80106537 <alltraps>

80106b69 <vector34>:
80106b69:	6a 00                	push   $0x0
80106b6b:	6a 22                	push   $0x22
80106b6d:	e9 c5 f9 ff ff       	jmp    80106537 <alltraps>

80106b72 <vector35>:
80106b72:	6a 00                	push   $0x0
80106b74:	6a 23                	push   $0x23
80106b76:	e9 bc f9 ff ff       	jmp    80106537 <alltraps>

80106b7b <vector36>:
80106b7b:	6a 00                	push   $0x0
80106b7d:	6a 24                	push   $0x24
80106b7f:	e9 b3 f9 ff ff       	jmp    80106537 <alltraps>

80106b84 <vector37>:
80106b84:	6a 00                	push   $0x0
80106b86:	6a 25                	push   $0x25
80106b88:	e9 aa f9 ff ff       	jmp    80106537 <alltraps>

80106b8d <vector38>:
80106b8d:	6a 00                	push   $0x0
80106b8f:	6a 26                	push   $0x26
80106b91:	e9 a1 f9 ff ff       	jmp    80106537 <alltraps>

80106b96 <vector39>:
80106b96:	6a 00                	push   $0x0
80106b98:	6a 27                	push   $0x27
80106b9a:	e9 98 f9 ff ff       	jmp    80106537 <alltraps>

80106b9f <vector40>:
80106b9f:	6a 00                	push   $0x0
80106ba1:	6a 28                	push   $0x28
80106ba3:	e9 8f f9 ff ff       	jmp    80106537 <alltraps>

80106ba8 <vector41>:
80106ba8:	6a 00                	push   $0x0
80106baa:	6a 29                	push   $0x29
80106bac:	e9 86 f9 ff ff       	jmp    80106537 <alltraps>

80106bb1 <vector42>:
80106bb1:	6a 00                	push   $0x0
80106bb3:	6a 2a                	push   $0x2a
80106bb5:	e9 7d f9 ff ff       	jmp    80106537 <alltraps>

80106bba <vector43>:
80106bba:	6a 00                	push   $0x0
80106bbc:	6a 2b                	push   $0x2b
80106bbe:	e9 74 f9 ff ff       	jmp    80106537 <alltraps>

80106bc3 <vector44>:
80106bc3:	6a 00                	push   $0x0
80106bc5:	6a 2c                	push   $0x2c
80106bc7:	e9 6b f9 ff ff       	jmp    80106537 <alltraps>

80106bcc <vector45>:
80106bcc:	6a 00                	push   $0x0
80106bce:	6a 2d                	push   $0x2d
80106bd0:	e9 62 f9 ff ff       	jmp    80106537 <alltraps>

80106bd5 <vector46>:
80106bd5:	6a 00                	push   $0x0
80106bd7:	6a 2e                	push   $0x2e
80106bd9:	e9 59 f9 ff ff       	jmp    80106537 <alltraps>

80106bde <vector47>:
80106bde:	6a 00                	push   $0x0
80106be0:	6a 2f                	push   $0x2f
80106be2:	e9 50 f9 ff ff       	jmp    80106537 <alltraps>

80106be7 <vector48>:
80106be7:	6a 00                	push   $0x0
80106be9:	6a 30                	push   $0x30
80106beb:	e9 47 f9 ff ff       	jmp    80106537 <alltraps>

80106bf0 <vector49>:
80106bf0:	6a 00                	push   $0x0
80106bf2:	6a 31                	push   $0x31
80106bf4:	e9 3e f9 ff ff       	jmp    80106537 <alltraps>

80106bf9 <vector50>:
80106bf9:	6a 00                	push   $0x0
80106bfb:	6a 32                	push   $0x32
80106bfd:	e9 35 f9 ff ff       	jmp    80106537 <alltraps>

80106c02 <vector51>:
80106c02:	6a 00                	push   $0x0
80106c04:	6a 33                	push   $0x33
80106c06:	e9 2c f9 ff ff       	jmp    80106537 <alltraps>

80106c0b <vector52>:
80106c0b:	6a 00                	push   $0x0
80106c0d:	6a 34                	push   $0x34
80106c0f:	e9 23 f9 ff ff       	jmp    80106537 <alltraps>

80106c14 <vector53>:
80106c14:	6a 00                	push   $0x0
80106c16:	6a 35                	push   $0x35
80106c18:	e9 1a f9 ff ff       	jmp    80106537 <alltraps>

80106c1d <vector54>:
80106c1d:	6a 00                	push   $0x0
80106c1f:	6a 36                	push   $0x36
80106c21:	e9 11 f9 ff ff       	jmp    80106537 <alltraps>

80106c26 <vector55>:
80106c26:	6a 00                	push   $0x0
80106c28:	6a 37                	push   $0x37
80106c2a:	e9 08 f9 ff ff       	jmp    80106537 <alltraps>

80106c2f <vector56>:
80106c2f:	6a 00                	push   $0x0
80106c31:	6a 38                	push   $0x38
80106c33:	e9 ff f8 ff ff       	jmp    80106537 <alltraps>

80106c38 <vector57>:
80106c38:	6a 00                	push   $0x0
80106c3a:	6a 39                	push   $0x39
80106c3c:	e9 f6 f8 ff ff       	jmp    80106537 <alltraps>

80106c41 <vector58>:
80106c41:	6a 00                	push   $0x0
80106c43:	6a 3a                	push   $0x3a
80106c45:	e9 ed f8 ff ff       	jmp    80106537 <alltraps>

80106c4a <vector59>:
80106c4a:	6a 00                	push   $0x0
80106c4c:	6a 3b                	push   $0x3b
80106c4e:	e9 e4 f8 ff ff       	jmp    80106537 <alltraps>

80106c53 <vector60>:
80106c53:	6a 00                	push   $0x0
80106c55:	6a 3c                	push   $0x3c
80106c57:	e9 db f8 ff ff       	jmp    80106537 <alltraps>

80106c5c <vector61>:
80106c5c:	6a 00                	push   $0x0
80106c5e:	6a 3d                	push   $0x3d
80106c60:	e9 d2 f8 ff ff       	jmp    80106537 <alltraps>

80106c65 <vector62>:
80106c65:	6a 00                	push   $0x0
80106c67:	6a 3e                	push   $0x3e
80106c69:	e9 c9 f8 ff ff       	jmp    80106537 <alltraps>

80106c6e <vector63>:
80106c6e:	6a 00                	push   $0x0
80106c70:	6a 3f                	push   $0x3f
80106c72:	e9 c0 f8 ff ff       	jmp    80106537 <alltraps>

80106c77 <vector64>:
80106c77:	6a 00                	push   $0x0
80106c79:	6a 40                	push   $0x40
80106c7b:	e9 b7 f8 ff ff       	jmp    80106537 <alltraps>

80106c80 <vector65>:
80106c80:	6a 00                	push   $0x0
80106c82:	6a 41                	push   $0x41
80106c84:	e9 ae f8 ff ff       	jmp    80106537 <alltraps>

80106c89 <vector66>:
80106c89:	6a 00                	push   $0x0
80106c8b:	6a 42                	push   $0x42
80106c8d:	e9 a5 f8 ff ff       	jmp    80106537 <alltraps>

80106c92 <vector67>:
80106c92:	6a 00                	push   $0x0
80106c94:	6a 43                	push   $0x43
80106c96:	e9 9c f8 ff ff       	jmp    80106537 <alltraps>

80106c9b <vector68>:
80106c9b:	6a 00                	push   $0x0
80106c9d:	6a 44                	push   $0x44
80106c9f:	e9 93 f8 ff ff       	jmp    80106537 <alltraps>

80106ca4 <vector69>:
80106ca4:	6a 00                	push   $0x0
80106ca6:	6a 45                	push   $0x45
80106ca8:	e9 8a f8 ff ff       	jmp    80106537 <alltraps>

80106cad <vector70>:
80106cad:	6a 00                	push   $0x0
80106caf:	6a 46                	push   $0x46
80106cb1:	e9 81 f8 ff ff       	jmp    80106537 <alltraps>

80106cb6 <vector71>:
80106cb6:	6a 00                	push   $0x0
80106cb8:	6a 47                	push   $0x47
80106cba:	e9 78 f8 ff ff       	jmp    80106537 <alltraps>

80106cbf <vector72>:
80106cbf:	6a 00                	push   $0x0
80106cc1:	6a 48                	push   $0x48
80106cc3:	e9 6f f8 ff ff       	jmp    80106537 <alltraps>

80106cc8 <vector73>:
80106cc8:	6a 00                	push   $0x0
80106cca:	6a 49                	push   $0x49
80106ccc:	e9 66 f8 ff ff       	jmp    80106537 <alltraps>

80106cd1 <vector74>:
80106cd1:	6a 00                	push   $0x0
80106cd3:	6a 4a                	push   $0x4a
80106cd5:	e9 5d f8 ff ff       	jmp    80106537 <alltraps>

80106cda <vector75>:
80106cda:	6a 00                	push   $0x0
80106cdc:	6a 4b                	push   $0x4b
80106cde:	e9 54 f8 ff ff       	jmp    80106537 <alltraps>

80106ce3 <vector76>:
80106ce3:	6a 00                	push   $0x0
80106ce5:	6a 4c                	push   $0x4c
80106ce7:	e9 4b f8 ff ff       	jmp    80106537 <alltraps>

80106cec <vector77>:
80106cec:	6a 00                	push   $0x0
80106cee:	6a 4d                	push   $0x4d
80106cf0:	e9 42 f8 ff ff       	jmp    80106537 <alltraps>

80106cf5 <vector78>:
80106cf5:	6a 00                	push   $0x0
80106cf7:	6a 4e                	push   $0x4e
80106cf9:	e9 39 f8 ff ff       	jmp    80106537 <alltraps>

80106cfe <vector79>:
80106cfe:	6a 00                	push   $0x0
80106d00:	6a 4f                	push   $0x4f
80106d02:	e9 30 f8 ff ff       	jmp    80106537 <alltraps>

80106d07 <vector80>:
80106d07:	6a 00                	push   $0x0
80106d09:	6a 50                	push   $0x50
80106d0b:	e9 27 f8 ff ff       	jmp    80106537 <alltraps>

80106d10 <vector81>:
80106d10:	6a 00                	push   $0x0
80106d12:	6a 51                	push   $0x51
80106d14:	e9 1e f8 ff ff       	jmp    80106537 <alltraps>

80106d19 <vector82>:
80106d19:	6a 00                	push   $0x0
80106d1b:	6a 52                	push   $0x52
80106d1d:	e9 15 f8 ff ff       	jmp    80106537 <alltraps>

80106d22 <vector83>:
80106d22:	6a 00                	push   $0x0
80106d24:	6a 53                	push   $0x53
80106d26:	e9 0c f8 ff ff       	jmp    80106537 <alltraps>

80106d2b <vector84>:
80106d2b:	6a 00                	push   $0x0
80106d2d:	6a 54                	push   $0x54
80106d2f:	e9 03 f8 ff ff       	jmp    80106537 <alltraps>

80106d34 <vector85>:
80106d34:	6a 00                	push   $0x0
80106d36:	6a 55                	push   $0x55
80106d38:	e9 fa f7 ff ff       	jmp    80106537 <alltraps>

80106d3d <vector86>:
80106d3d:	6a 00                	push   $0x0
80106d3f:	6a 56                	push   $0x56
80106d41:	e9 f1 f7 ff ff       	jmp    80106537 <alltraps>

80106d46 <vector87>:
80106d46:	6a 00                	push   $0x0
80106d48:	6a 57                	push   $0x57
80106d4a:	e9 e8 f7 ff ff       	jmp    80106537 <alltraps>

80106d4f <vector88>:
80106d4f:	6a 00                	push   $0x0
80106d51:	6a 58                	push   $0x58
80106d53:	e9 df f7 ff ff       	jmp    80106537 <alltraps>

80106d58 <vector89>:
80106d58:	6a 00                	push   $0x0
80106d5a:	6a 59                	push   $0x59
80106d5c:	e9 d6 f7 ff ff       	jmp    80106537 <alltraps>

80106d61 <vector90>:
80106d61:	6a 00                	push   $0x0
80106d63:	6a 5a                	push   $0x5a
80106d65:	e9 cd f7 ff ff       	jmp    80106537 <alltraps>

80106d6a <vector91>:
80106d6a:	6a 00                	push   $0x0
80106d6c:	6a 5b                	push   $0x5b
80106d6e:	e9 c4 f7 ff ff       	jmp    80106537 <alltraps>

80106d73 <vector92>:
80106d73:	6a 00                	push   $0x0
80106d75:	6a 5c                	push   $0x5c
80106d77:	e9 bb f7 ff ff       	jmp    80106537 <alltraps>

80106d7c <vector93>:
80106d7c:	6a 00                	push   $0x0
80106d7e:	6a 5d                	push   $0x5d
80106d80:	e9 b2 f7 ff ff       	jmp    80106537 <alltraps>

80106d85 <vector94>:
80106d85:	6a 00                	push   $0x0
80106d87:	6a 5e                	push   $0x5e
80106d89:	e9 a9 f7 ff ff       	jmp    80106537 <alltraps>

80106d8e <vector95>:
80106d8e:	6a 00                	push   $0x0
80106d90:	6a 5f                	push   $0x5f
80106d92:	e9 a0 f7 ff ff       	jmp    80106537 <alltraps>

80106d97 <vector96>:
80106d97:	6a 00                	push   $0x0
80106d99:	6a 60                	push   $0x60
80106d9b:	e9 97 f7 ff ff       	jmp    80106537 <alltraps>

80106da0 <vector97>:
80106da0:	6a 00                	push   $0x0
80106da2:	6a 61                	push   $0x61
80106da4:	e9 8e f7 ff ff       	jmp    80106537 <alltraps>

80106da9 <vector98>:
80106da9:	6a 00                	push   $0x0
80106dab:	6a 62                	push   $0x62
80106dad:	e9 85 f7 ff ff       	jmp    80106537 <alltraps>

80106db2 <vector99>:
80106db2:	6a 00                	push   $0x0
80106db4:	6a 63                	push   $0x63
80106db6:	e9 7c f7 ff ff       	jmp    80106537 <alltraps>

80106dbb <vector100>:
80106dbb:	6a 00                	push   $0x0
80106dbd:	6a 64                	push   $0x64
80106dbf:	e9 73 f7 ff ff       	jmp    80106537 <alltraps>

80106dc4 <vector101>:
80106dc4:	6a 00                	push   $0x0
80106dc6:	6a 65                	push   $0x65
80106dc8:	e9 6a f7 ff ff       	jmp    80106537 <alltraps>

80106dcd <vector102>:
80106dcd:	6a 00                	push   $0x0
80106dcf:	6a 66                	push   $0x66
80106dd1:	e9 61 f7 ff ff       	jmp    80106537 <alltraps>

80106dd6 <vector103>:
80106dd6:	6a 00                	push   $0x0
80106dd8:	6a 67                	push   $0x67
80106dda:	e9 58 f7 ff ff       	jmp    80106537 <alltraps>

80106ddf <vector104>:
80106ddf:	6a 00                	push   $0x0
80106de1:	6a 68                	push   $0x68
80106de3:	e9 4f f7 ff ff       	jmp    80106537 <alltraps>

80106de8 <vector105>:
80106de8:	6a 00                	push   $0x0
80106dea:	6a 69                	push   $0x69
80106dec:	e9 46 f7 ff ff       	jmp    80106537 <alltraps>

80106df1 <vector106>:
80106df1:	6a 00                	push   $0x0
80106df3:	6a 6a                	push   $0x6a
80106df5:	e9 3d f7 ff ff       	jmp    80106537 <alltraps>

80106dfa <vector107>:
80106dfa:	6a 00                	push   $0x0
80106dfc:	6a 6b                	push   $0x6b
80106dfe:	e9 34 f7 ff ff       	jmp    80106537 <alltraps>

80106e03 <vector108>:
80106e03:	6a 00                	push   $0x0
80106e05:	6a 6c                	push   $0x6c
80106e07:	e9 2b f7 ff ff       	jmp    80106537 <alltraps>

80106e0c <vector109>:
80106e0c:	6a 00                	push   $0x0
80106e0e:	6a 6d                	push   $0x6d
80106e10:	e9 22 f7 ff ff       	jmp    80106537 <alltraps>

80106e15 <vector110>:
80106e15:	6a 00                	push   $0x0
80106e17:	6a 6e                	push   $0x6e
80106e19:	e9 19 f7 ff ff       	jmp    80106537 <alltraps>

80106e1e <vector111>:
80106e1e:	6a 00                	push   $0x0
80106e20:	6a 6f                	push   $0x6f
80106e22:	e9 10 f7 ff ff       	jmp    80106537 <alltraps>

80106e27 <vector112>:
80106e27:	6a 00                	push   $0x0
80106e29:	6a 70                	push   $0x70
80106e2b:	e9 07 f7 ff ff       	jmp    80106537 <alltraps>

80106e30 <vector113>:
80106e30:	6a 00                	push   $0x0
80106e32:	6a 71                	push   $0x71
80106e34:	e9 fe f6 ff ff       	jmp    80106537 <alltraps>

80106e39 <vector114>:
80106e39:	6a 00                	push   $0x0
80106e3b:	6a 72                	push   $0x72
80106e3d:	e9 f5 f6 ff ff       	jmp    80106537 <alltraps>

80106e42 <vector115>:
80106e42:	6a 00                	push   $0x0
80106e44:	6a 73                	push   $0x73
80106e46:	e9 ec f6 ff ff       	jmp    80106537 <alltraps>

80106e4b <vector116>:
80106e4b:	6a 00                	push   $0x0
80106e4d:	6a 74                	push   $0x74
80106e4f:	e9 e3 f6 ff ff       	jmp    80106537 <alltraps>

80106e54 <vector117>:
80106e54:	6a 00                	push   $0x0
80106e56:	6a 75                	push   $0x75
80106e58:	e9 da f6 ff ff       	jmp    80106537 <alltraps>

80106e5d <vector118>:
80106e5d:	6a 00                	push   $0x0
80106e5f:	6a 76                	push   $0x76
80106e61:	e9 d1 f6 ff ff       	jmp    80106537 <alltraps>

80106e66 <vector119>:
80106e66:	6a 00                	push   $0x0
80106e68:	6a 77                	push   $0x77
80106e6a:	e9 c8 f6 ff ff       	jmp    80106537 <alltraps>

80106e6f <vector120>:
80106e6f:	6a 00                	push   $0x0
80106e71:	6a 78                	push   $0x78
80106e73:	e9 bf f6 ff ff       	jmp    80106537 <alltraps>

80106e78 <vector121>:
80106e78:	6a 00                	push   $0x0
80106e7a:	6a 79                	push   $0x79
80106e7c:	e9 b6 f6 ff ff       	jmp    80106537 <alltraps>

80106e81 <vector122>:
80106e81:	6a 00                	push   $0x0
80106e83:	6a 7a                	push   $0x7a
80106e85:	e9 ad f6 ff ff       	jmp    80106537 <alltraps>

80106e8a <vector123>:
80106e8a:	6a 00                	push   $0x0
80106e8c:	6a 7b                	push   $0x7b
80106e8e:	e9 a4 f6 ff ff       	jmp    80106537 <alltraps>

80106e93 <vector124>:
80106e93:	6a 00                	push   $0x0
80106e95:	6a 7c                	push   $0x7c
80106e97:	e9 9b f6 ff ff       	jmp    80106537 <alltraps>

80106e9c <vector125>:
80106e9c:	6a 00                	push   $0x0
80106e9e:	6a 7d                	push   $0x7d
80106ea0:	e9 92 f6 ff ff       	jmp    80106537 <alltraps>

80106ea5 <vector126>:
80106ea5:	6a 00                	push   $0x0
80106ea7:	6a 7e                	push   $0x7e
80106ea9:	e9 89 f6 ff ff       	jmp    80106537 <alltraps>

80106eae <vector127>:
80106eae:	6a 00                	push   $0x0
80106eb0:	6a 7f                	push   $0x7f
80106eb2:	e9 80 f6 ff ff       	jmp    80106537 <alltraps>

80106eb7 <vector128>:
80106eb7:	6a 00                	push   $0x0
80106eb9:	68 80 00 00 00       	push   $0x80
80106ebe:	e9 74 f6 ff ff       	jmp    80106537 <alltraps>

80106ec3 <vector129>:
80106ec3:	6a 00                	push   $0x0
80106ec5:	68 81 00 00 00       	push   $0x81
80106eca:	e9 68 f6 ff ff       	jmp    80106537 <alltraps>

80106ecf <vector130>:
80106ecf:	6a 00                	push   $0x0
80106ed1:	68 82 00 00 00       	push   $0x82
80106ed6:	e9 5c f6 ff ff       	jmp    80106537 <alltraps>

80106edb <vector131>:
80106edb:	6a 00                	push   $0x0
80106edd:	68 83 00 00 00       	push   $0x83
80106ee2:	e9 50 f6 ff ff       	jmp    80106537 <alltraps>

80106ee7 <vector132>:
80106ee7:	6a 00                	push   $0x0
80106ee9:	68 84 00 00 00       	push   $0x84
80106eee:	e9 44 f6 ff ff       	jmp    80106537 <alltraps>

80106ef3 <vector133>:
80106ef3:	6a 00                	push   $0x0
80106ef5:	68 85 00 00 00       	push   $0x85
80106efa:	e9 38 f6 ff ff       	jmp    80106537 <alltraps>

80106eff <vector134>:
80106eff:	6a 00                	push   $0x0
80106f01:	68 86 00 00 00       	push   $0x86
80106f06:	e9 2c f6 ff ff       	jmp    80106537 <alltraps>

80106f0b <vector135>:
80106f0b:	6a 00                	push   $0x0
80106f0d:	68 87 00 00 00       	push   $0x87
80106f12:	e9 20 f6 ff ff       	jmp    80106537 <alltraps>

80106f17 <vector136>:
80106f17:	6a 00                	push   $0x0
80106f19:	68 88 00 00 00       	push   $0x88
80106f1e:	e9 14 f6 ff ff       	jmp    80106537 <alltraps>

80106f23 <vector137>:
80106f23:	6a 00                	push   $0x0
80106f25:	68 89 00 00 00       	push   $0x89
80106f2a:	e9 08 f6 ff ff       	jmp    80106537 <alltraps>

80106f2f <vector138>:
80106f2f:	6a 00                	push   $0x0
80106f31:	68 8a 00 00 00       	push   $0x8a
80106f36:	e9 fc f5 ff ff       	jmp    80106537 <alltraps>

80106f3b <vector139>:
80106f3b:	6a 00                	push   $0x0
80106f3d:	68 8b 00 00 00       	push   $0x8b
80106f42:	e9 f0 f5 ff ff       	jmp    80106537 <alltraps>

80106f47 <vector140>:
80106f47:	6a 00                	push   $0x0
80106f49:	68 8c 00 00 00       	push   $0x8c
80106f4e:	e9 e4 f5 ff ff       	jmp    80106537 <alltraps>

80106f53 <vector141>:
80106f53:	6a 00                	push   $0x0
80106f55:	68 8d 00 00 00       	push   $0x8d
80106f5a:	e9 d8 f5 ff ff       	jmp    80106537 <alltraps>

80106f5f <vector142>:
80106f5f:	6a 00                	push   $0x0
80106f61:	68 8e 00 00 00       	push   $0x8e
80106f66:	e9 cc f5 ff ff       	jmp    80106537 <alltraps>

80106f6b <vector143>:
80106f6b:	6a 00                	push   $0x0
80106f6d:	68 8f 00 00 00       	push   $0x8f
80106f72:	e9 c0 f5 ff ff       	jmp    80106537 <alltraps>

80106f77 <vector144>:
80106f77:	6a 00                	push   $0x0
80106f79:	68 90 00 00 00       	push   $0x90
80106f7e:	e9 b4 f5 ff ff       	jmp    80106537 <alltraps>

80106f83 <vector145>:
80106f83:	6a 00                	push   $0x0
80106f85:	68 91 00 00 00       	push   $0x91
80106f8a:	e9 a8 f5 ff ff       	jmp    80106537 <alltraps>

80106f8f <vector146>:
80106f8f:	6a 00                	push   $0x0
80106f91:	68 92 00 00 00       	push   $0x92
80106f96:	e9 9c f5 ff ff       	jmp    80106537 <alltraps>

80106f9b <vector147>:
80106f9b:	6a 00                	push   $0x0
80106f9d:	68 93 00 00 00       	push   $0x93
80106fa2:	e9 90 f5 ff ff       	jmp    80106537 <alltraps>

80106fa7 <vector148>:
80106fa7:	6a 00                	push   $0x0
80106fa9:	68 94 00 00 00       	push   $0x94
80106fae:	e9 84 f5 ff ff       	jmp    80106537 <alltraps>

80106fb3 <vector149>:
80106fb3:	6a 00                	push   $0x0
80106fb5:	68 95 00 00 00       	push   $0x95
80106fba:	e9 78 f5 ff ff       	jmp    80106537 <alltraps>

80106fbf <vector150>:
80106fbf:	6a 00                	push   $0x0
80106fc1:	68 96 00 00 00       	push   $0x96
80106fc6:	e9 6c f5 ff ff       	jmp    80106537 <alltraps>

80106fcb <vector151>:
80106fcb:	6a 00                	push   $0x0
80106fcd:	68 97 00 00 00       	push   $0x97
80106fd2:	e9 60 f5 ff ff       	jmp    80106537 <alltraps>

80106fd7 <vector152>:
80106fd7:	6a 00                	push   $0x0
80106fd9:	68 98 00 00 00       	push   $0x98
80106fde:	e9 54 f5 ff ff       	jmp    80106537 <alltraps>

80106fe3 <vector153>:
80106fe3:	6a 00                	push   $0x0
80106fe5:	68 99 00 00 00       	push   $0x99
80106fea:	e9 48 f5 ff ff       	jmp    80106537 <alltraps>

80106fef <vector154>:
80106fef:	6a 00                	push   $0x0
80106ff1:	68 9a 00 00 00       	push   $0x9a
80106ff6:	e9 3c f5 ff ff       	jmp    80106537 <alltraps>

80106ffb <vector155>:
80106ffb:	6a 00                	push   $0x0
80106ffd:	68 9b 00 00 00       	push   $0x9b
80107002:	e9 30 f5 ff ff       	jmp    80106537 <alltraps>

80107007 <vector156>:
80107007:	6a 00                	push   $0x0
80107009:	68 9c 00 00 00       	push   $0x9c
8010700e:	e9 24 f5 ff ff       	jmp    80106537 <alltraps>

80107013 <vector157>:
80107013:	6a 00                	push   $0x0
80107015:	68 9d 00 00 00       	push   $0x9d
8010701a:	e9 18 f5 ff ff       	jmp    80106537 <alltraps>

8010701f <vector158>:
8010701f:	6a 00                	push   $0x0
80107021:	68 9e 00 00 00       	push   $0x9e
80107026:	e9 0c f5 ff ff       	jmp    80106537 <alltraps>

8010702b <vector159>:
8010702b:	6a 00                	push   $0x0
8010702d:	68 9f 00 00 00       	push   $0x9f
80107032:	e9 00 f5 ff ff       	jmp    80106537 <alltraps>

80107037 <vector160>:
80107037:	6a 00                	push   $0x0
80107039:	68 a0 00 00 00       	push   $0xa0
8010703e:	e9 f4 f4 ff ff       	jmp    80106537 <alltraps>

80107043 <vector161>:
80107043:	6a 00                	push   $0x0
80107045:	68 a1 00 00 00       	push   $0xa1
8010704a:	e9 e8 f4 ff ff       	jmp    80106537 <alltraps>

8010704f <vector162>:
8010704f:	6a 00                	push   $0x0
80107051:	68 a2 00 00 00       	push   $0xa2
80107056:	e9 dc f4 ff ff       	jmp    80106537 <alltraps>

8010705b <vector163>:
8010705b:	6a 00                	push   $0x0
8010705d:	68 a3 00 00 00       	push   $0xa3
80107062:	e9 d0 f4 ff ff       	jmp    80106537 <alltraps>

80107067 <vector164>:
80107067:	6a 00                	push   $0x0
80107069:	68 a4 00 00 00       	push   $0xa4
8010706e:	e9 c4 f4 ff ff       	jmp    80106537 <alltraps>

80107073 <vector165>:
80107073:	6a 00                	push   $0x0
80107075:	68 a5 00 00 00       	push   $0xa5
8010707a:	e9 b8 f4 ff ff       	jmp    80106537 <alltraps>

8010707f <vector166>:
8010707f:	6a 00                	push   $0x0
80107081:	68 a6 00 00 00       	push   $0xa6
80107086:	e9 ac f4 ff ff       	jmp    80106537 <alltraps>

8010708b <vector167>:
8010708b:	6a 00                	push   $0x0
8010708d:	68 a7 00 00 00       	push   $0xa7
80107092:	e9 a0 f4 ff ff       	jmp    80106537 <alltraps>

80107097 <vector168>:
80107097:	6a 00                	push   $0x0
80107099:	68 a8 00 00 00       	push   $0xa8
8010709e:	e9 94 f4 ff ff       	jmp    80106537 <alltraps>

801070a3 <vector169>:
801070a3:	6a 00                	push   $0x0
801070a5:	68 a9 00 00 00       	push   $0xa9
801070aa:	e9 88 f4 ff ff       	jmp    80106537 <alltraps>

801070af <vector170>:
801070af:	6a 00                	push   $0x0
801070b1:	68 aa 00 00 00       	push   $0xaa
801070b6:	e9 7c f4 ff ff       	jmp    80106537 <alltraps>

801070bb <vector171>:
801070bb:	6a 00                	push   $0x0
801070bd:	68 ab 00 00 00       	push   $0xab
801070c2:	e9 70 f4 ff ff       	jmp    80106537 <alltraps>

801070c7 <vector172>:
801070c7:	6a 00                	push   $0x0
801070c9:	68 ac 00 00 00       	push   $0xac
801070ce:	e9 64 f4 ff ff       	jmp    80106537 <alltraps>

801070d3 <vector173>:
801070d3:	6a 00                	push   $0x0
801070d5:	68 ad 00 00 00       	push   $0xad
801070da:	e9 58 f4 ff ff       	jmp    80106537 <alltraps>

801070df <vector174>:
801070df:	6a 00                	push   $0x0
801070e1:	68 ae 00 00 00       	push   $0xae
801070e6:	e9 4c f4 ff ff       	jmp    80106537 <alltraps>

801070eb <vector175>:
801070eb:	6a 00                	push   $0x0
801070ed:	68 af 00 00 00       	push   $0xaf
801070f2:	e9 40 f4 ff ff       	jmp    80106537 <alltraps>

801070f7 <vector176>:
801070f7:	6a 00                	push   $0x0
801070f9:	68 b0 00 00 00       	push   $0xb0
801070fe:	e9 34 f4 ff ff       	jmp    80106537 <alltraps>

80107103 <vector177>:
80107103:	6a 00                	push   $0x0
80107105:	68 b1 00 00 00       	push   $0xb1
8010710a:	e9 28 f4 ff ff       	jmp    80106537 <alltraps>

8010710f <vector178>:
8010710f:	6a 00                	push   $0x0
80107111:	68 b2 00 00 00       	push   $0xb2
80107116:	e9 1c f4 ff ff       	jmp    80106537 <alltraps>

8010711b <vector179>:
8010711b:	6a 00                	push   $0x0
8010711d:	68 b3 00 00 00       	push   $0xb3
80107122:	e9 10 f4 ff ff       	jmp    80106537 <alltraps>

80107127 <vector180>:
80107127:	6a 00                	push   $0x0
80107129:	68 b4 00 00 00       	push   $0xb4
8010712e:	e9 04 f4 ff ff       	jmp    80106537 <alltraps>

80107133 <vector181>:
80107133:	6a 00                	push   $0x0
80107135:	68 b5 00 00 00       	push   $0xb5
8010713a:	e9 f8 f3 ff ff       	jmp    80106537 <alltraps>

8010713f <vector182>:
8010713f:	6a 00                	push   $0x0
80107141:	68 b6 00 00 00       	push   $0xb6
80107146:	e9 ec f3 ff ff       	jmp    80106537 <alltraps>

8010714b <vector183>:
8010714b:	6a 00                	push   $0x0
8010714d:	68 b7 00 00 00       	push   $0xb7
80107152:	e9 e0 f3 ff ff       	jmp    80106537 <alltraps>

80107157 <vector184>:
80107157:	6a 00                	push   $0x0
80107159:	68 b8 00 00 00       	push   $0xb8
8010715e:	e9 d4 f3 ff ff       	jmp    80106537 <alltraps>

80107163 <vector185>:
80107163:	6a 00                	push   $0x0
80107165:	68 b9 00 00 00       	push   $0xb9
8010716a:	e9 c8 f3 ff ff       	jmp    80106537 <alltraps>

8010716f <vector186>:
8010716f:	6a 00                	push   $0x0
80107171:	68 ba 00 00 00       	push   $0xba
80107176:	e9 bc f3 ff ff       	jmp    80106537 <alltraps>

8010717b <vector187>:
8010717b:	6a 00                	push   $0x0
8010717d:	68 bb 00 00 00       	push   $0xbb
80107182:	e9 b0 f3 ff ff       	jmp    80106537 <alltraps>

80107187 <vector188>:
80107187:	6a 00                	push   $0x0
80107189:	68 bc 00 00 00       	push   $0xbc
8010718e:	e9 a4 f3 ff ff       	jmp    80106537 <alltraps>

80107193 <vector189>:
80107193:	6a 00                	push   $0x0
80107195:	68 bd 00 00 00       	push   $0xbd
8010719a:	e9 98 f3 ff ff       	jmp    80106537 <alltraps>

8010719f <vector190>:
8010719f:	6a 00                	push   $0x0
801071a1:	68 be 00 00 00       	push   $0xbe
801071a6:	e9 8c f3 ff ff       	jmp    80106537 <alltraps>

801071ab <vector191>:
801071ab:	6a 00                	push   $0x0
801071ad:	68 bf 00 00 00       	push   $0xbf
801071b2:	e9 80 f3 ff ff       	jmp    80106537 <alltraps>

801071b7 <vector192>:
801071b7:	6a 00                	push   $0x0
801071b9:	68 c0 00 00 00       	push   $0xc0
801071be:	e9 74 f3 ff ff       	jmp    80106537 <alltraps>

801071c3 <vector193>:
801071c3:	6a 00                	push   $0x0
801071c5:	68 c1 00 00 00       	push   $0xc1
801071ca:	e9 68 f3 ff ff       	jmp    80106537 <alltraps>

801071cf <vector194>:
801071cf:	6a 00                	push   $0x0
801071d1:	68 c2 00 00 00       	push   $0xc2
801071d6:	e9 5c f3 ff ff       	jmp    80106537 <alltraps>

801071db <vector195>:
801071db:	6a 00                	push   $0x0
801071dd:	68 c3 00 00 00       	push   $0xc3
801071e2:	e9 50 f3 ff ff       	jmp    80106537 <alltraps>

801071e7 <vector196>:
801071e7:	6a 00                	push   $0x0
801071e9:	68 c4 00 00 00       	push   $0xc4
801071ee:	e9 44 f3 ff ff       	jmp    80106537 <alltraps>

801071f3 <vector197>:
801071f3:	6a 00                	push   $0x0
801071f5:	68 c5 00 00 00       	push   $0xc5
801071fa:	e9 38 f3 ff ff       	jmp    80106537 <alltraps>

801071ff <vector198>:
801071ff:	6a 00                	push   $0x0
80107201:	68 c6 00 00 00       	push   $0xc6
80107206:	e9 2c f3 ff ff       	jmp    80106537 <alltraps>

8010720b <vector199>:
8010720b:	6a 00                	push   $0x0
8010720d:	68 c7 00 00 00       	push   $0xc7
80107212:	e9 20 f3 ff ff       	jmp    80106537 <alltraps>

80107217 <vector200>:
80107217:	6a 00                	push   $0x0
80107219:	68 c8 00 00 00       	push   $0xc8
8010721e:	e9 14 f3 ff ff       	jmp    80106537 <alltraps>

80107223 <vector201>:
80107223:	6a 00                	push   $0x0
80107225:	68 c9 00 00 00       	push   $0xc9
8010722a:	e9 08 f3 ff ff       	jmp    80106537 <alltraps>

8010722f <vector202>:
8010722f:	6a 00                	push   $0x0
80107231:	68 ca 00 00 00       	push   $0xca
80107236:	e9 fc f2 ff ff       	jmp    80106537 <alltraps>

8010723b <vector203>:
8010723b:	6a 00                	push   $0x0
8010723d:	68 cb 00 00 00       	push   $0xcb
80107242:	e9 f0 f2 ff ff       	jmp    80106537 <alltraps>

80107247 <vector204>:
80107247:	6a 00                	push   $0x0
80107249:	68 cc 00 00 00       	push   $0xcc
8010724e:	e9 e4 f2 ff ff       	jmp    80106537 <alltraps>

80107253 <vector205>:
80107253:	6a 00                	push   $0x0
80107255:	68 cd 00 00 00       	push   $0xcd
8010725a:	e9 d8 f2 ff ff       	jmp    80106537 <alltraps>

8010725f <vector206>:
8010725f:	6a 00                	push   $0x0
80107261:	68 ce 00 00 00       	push   $0xce
80107266:	e9 cc f2 ff ff       	jmp    80106537 <alltraps>

8010726b <vector207>:
8010726b:	6a 00                	push   $0x0
8010726d:	68 cf 00 00 00       	push   $0xcf
80107272:	e9 c0 f2 ff ff       	jmp    80106537 <alltraps>

80107277 <vector208>:
80107277:	6a 00                	push   $0x0
80107279:	68 d0 00 00 00       	push   $0xd0
8010727e:	e9 b4 f2 ff ff       	jmp    80106537 <alltraps>

80107283 <vector209>:
80107283:	6a 00                	push   $0x0
80107285:	68 d1 00 00 00       	push   $0xd1
8010728a:	e9 a8 f2 ff ff       	jmp    80106537 <alltraps>

8010728f <vector210>:
8010728f:	6a 00                	push   $0x0
80107291:	68 d2 00 00 00       	push   $0xd2
80107296:	e9 9c f2 ff ff       	jmp    80106537 <alltraps>

8010729b <vector211>:
8010729b:	6a 00                	push   $0x0
8010729d:	68 d3 00 00 00       	push   $0xd3
801072a2:	e9 90 f2 ff ff       	jmp    80106537 <alltraps>

801072a7 <vector212>:
801072a7:	6a 00                	push   $0x0
801072a9:	68 d4 00 00 00       	push   $0xd4
801072ae:	e9 84 f2 ff ff       	jmp    80106537 <alltraps>

801072b3 <vector213>:
801072b3:	6a 00                	push   $0x0
801072b5:	68 d5 00 00 00       	push   $0xd5
801072ba:	e9 78 f2 ff ff       	jmp    80106537 <alltraps>

801072bf <vector214>:
801072bf:	6a 00                	push   $0x0
801072c1:	68 d6 00 00 00       	push   $0xd6
801072c6:	e9 6c f2 ff ff       	jmp    80106537 <alltraps>

801072cb <vector215>:
801072cb:	6a 00                	push   $0x0
801072cd:	68 d7 00 00 00       	push   $0xd7
801072d2:	e9 60 f2 ff ff       	jmp    80106537 <alltraps>

801072d7 <vector216>:
801072d7:	6a 00                	push   $0x0
801072d9:	68 d8 00 00 00       	push   $0xd8
801072de:	e9 54 f2 ff ff       	jmp    80106537 <alltraps>

801072e3 <vector217>:
801072e3:	6a 00                	push   $0x0
801072e5:	68 d9 00 00 00       	push   $0xd9
801072ea:	e9 48 f2 ff ff       	jmp    80106537 <alltraps>

801072ef <vector218>:
801072ef:	6a 00                	push   $0x0
801072f1:	68 da 00 00 00       	push   $0xda
801072f6:	e9 3c f2 ff ff       	jmp    80106537 <alltraps>

801072fb <vector219>:
801072fb:	6a 00                	push   $0x0
801072fd:	68 db 00 00 00       	push   $0xdb
80107302:	e9 30 f2 ff ff       	jmp    80106537 <alltraps>

80107307 <vector220>:
80107307:	6a 00                	push   $0x0
80107309:	68 dc 00 00 00       	push   $0xdc
8010730e:	e9 24 f2 ff ff       	jmp    80106537 <alltraps>

80107313 <vector221>:
80107313:	6a 00                	push   $0x0
80107315:	68 dd 00 00 00       	push   $0xdd
8010731a:	e9 18 f2 ff ff       	jmp    80106537 <alltraps>

8010731f <vector222>:
8010731f:	6a 00                	push   $0x0
80107321:	68 de 00 00 00       	push   $0xde
80107326:	e9 0c f2 ff ff       	jmp    80106537 <alltraps>

8010732b <vector223>:
8010732b:	6a 00                	push   $0x0
8010732d:	68 df 00 00 00       	push   $0xdf
80107332:	e9 00 f2 ff ff       	jmp    80106537 <alltraps>

80107337 <vector224>:
80107337:	6a 00                	push   $0x0
80107339:	68 e0 00 00 00       	push   $0xe0
8010733e:	e9 f4 f1 ff ff       	jmp    80106537 <alltraps>

80107343 <vector225>:
80107343:	6a 00                	push   $0x0
80107345:	68 e1 00 00 00       	push   $0xe1
8010734a:	e9 e8 f1 ff ff       	jmp    80106537 <alltraps>

8010734f <vector226>:
8010734f:	6a 00                	push   $0x0
80107351:	68 e2 00 00 00       	push   $0xe2
80107356:	e9 dc f1 ff ff       	jmp    80106537 <alltraps>

8010735b <vector227>:
8010735b:	6a 00                	push   $0x0
8010735d:	68 e3 00 00 00       	push   $0xe3
80107362:	e9 d0 f1 ff ff       	jmp    80106537 <alltraps>

80107367 <vector228>:
80107367:	6a 00                	push   $0x0
80107369:	68 e4 00 00 00       	push   $0xe4
8010736e:	e9 c4 f1 ff ff       	jmp    80106537 <alltraps>

80107373 <vector229>:
80107373:	6a 00                	push   $0x0
80107375:	68 e5 00 00 00       	push   $0xe5
8010737a:	e9 b8 f1 ff ff       	jmp    80106537 <alltraps>

8010737f <vector230>:
8010737f:	6a 00                	push   $0x0
80107381:	68 e6 00 00 00       	push   $0xe6
80107386:	e9 ac f1 ff ff       	jmp    80106537 <alltraps>

8010738b <vector231>:
8010738b:	6a 00                	push   $0x0
8010738d:	68 e7 00 00 00       	push   $0xe7
80107392:	e9 a0 f1 ff ff       	jmp    80106537 <alltraps>

80107397 <vector232>:
80107397:	6a 00                	push   $0x0
80107399:	68 e8 00 00 00       	push   $0xe8
8010739e:	e9 94 f1 ff ff       	jmp    80106537 <alltraps>

801073a3 <vector233>:
801073a3:	6a 00                	push   $0x0
801073a5:	68 e9 00 00 00       	push   $0xe9
801073aa:	e9 88 f1 ff ff       	jmp    80106537 <alltraps>

801073af <vector234>:
801073af:	6a 00                	push   $0x0
801073b1:	68 ea 00 00 00       	push   $0xea
801073b6:	e9 7c f1 ff ff       	jmp    80106537 <alltraps>

801073bb <vector235>:
801073bb:	6a 00                	push   $0x0
801073bd:	68 eb 00 00 00       	push   $0xeb
801073c2:	e9 70 f1 ff ff       	jmp    80106537 <alltraps>

801073c7 <vector236>:
801073c7:	6a 00                	push   $0x0
801073c9:	68 ec 00 00 00       	push   $0xec
801073ce:	e9 64 f1 ff ff       	jmp    80106537 <alltraps>

801073d3 <vector237>:
801073d3:	6a 00                	push   $0x0
801073d5:	68 ed 00 00 00       	push   $0xed
801073da:	e9 58 f1 ff ff       	jmp    80106537 <alltraps>

801073df <vector238>:
801073df:	6a 00                	push   $0x0
801073e1:	68 ee 00 00 00       	push   $0xee
801073e6:	e9 4c f1 ff ff       	jmp    80106537 <alltraps>

801073eb <vector239>:
801073eb:	6a 00                	push   $0x0
801073ed:	68 ef 00 00 00       	push   $0xef
801073f2:	e9 40 f1 ff ff       	jmp    80106537 <alltraps>

801073f7 <vector240>:
801073f7:	6a 00                	push   $0x0
801073f9:	68 f0 00 00 00       	push   $0xf0
801073fe:	e9 34 f1 ff ff       	jmp    80106537 <alltraps>

80107403 <vector241>:
80107403:	6a 00                	push   $0x0
80107405:	68 f1 00 00 00       	push   $0xf1
8010740a:	e9 28 f1 ff ff       	jmp    80106537 <alltraps>

8010740f <vector242>:
8010740f:	6a 00                	push   $0x0
80107411:	68 f2 00 00 00       	push   $0xf2
80107416:	e9 1c f1 ff ff       	jmp    80106537 <alltraps>

8010741b <vector243>:
8010741b:	6a 00                	push   $0x0
8010741d:	68 f3 00 00 00       	push   $0xf3
80107422:	e9 10 f1 ff ff       	jmp    80106537 <alltraps>

80107427 <vector244>:
80107427:	6a 00                	push   $0x0
80107429:	68 f4 00 00 00       	push   $0xf4
8010742e:	e9 04 f1 ff ff       	jmp    80106537 <alltraps>

80107433 <vector245>:
80107433:	6a 00                	push   $0x0
80107435:	68 f5 00 00 00       	push   $0xf5
8010743a:	e9 f8 f0 ff ff       	jmp    80106537 <alltraps>

8010743f <vector246>:
8010743f:	6a 00                	push   $0x0
80107441:	68 f6 00 00 00       	push   $0xf6
80107446:	e9 ec f0 ff ff       	jmp    80106537 <alltraps>

8010744b <vector247>:
8010744b:	6a 00                	push   $0x0
8010744d:	68 f7 00 00 00       	push   $0xf7
80107452:	e9 e0 f0 ff ff       	jmp    80106537 <alltraps>

80107457 <vector248>:
80107457:	6a 00                	push   $0x0
80107459:	68 f8 00 00 00       	push   $0xf8
8010745e:	e9 d4 f0 ff ff       	jmp    80106537 <alltraps>

80107463 <vector249>:
80107463:	6a 00                	push   $0x0
80107465:	68 f9 00 00 00       	push   $0xf9
8010746a:	e9 c8 f0 ff ff       	jmp    80106537 <alltraps>

8010746f <vector250>:
8010746f:	6a 00                	push   $0x0
80107471:	68 fa 00 00 00       	push   $0xfa
80107476:	e9 bc f0 ff ff       	jmp    80106537 <alltraps>

8010747b <vector251>:
8010747b:	6a 00                	push   $0x0
8010747d:	68 fb 00 00 00       	push   $0xfb
80107482:	e9 b0 f0 ff ff       	jmp    80106537 <alltraps>

80107487 <vector252>:
80107487:	6a 00                	push   $0x0
80107489:	68 fc 00 00 00       	push   $0xfc
8010748e:	e9 a4 f0 ff ff       	jmp    80106537 <alltraps>

80107493 <vector253>:
80107493:	6a 00                	push   $0x0
80107495:	68 fd 00 00 00       	push   $0xfd
8010749a:	e9 98 f0 ff ff       	jmp    80106537 <alltraps>

8010749f <vector254>:
8010749f:	6a 00                	push   $0x0
801074a1:	68 fe 00 00 00       	push   $0xfe
801074a6:	e9 8c f0 ff ff       	jmp    80106537 <alltraps>

801074ab <vector255>:
801074ab:	6a 00                	push   $0x0
801074ad:	68 ff 00 00 00       	push   $0xff
801074b2:	e9 80 f0 ff ff       	jmp    80106537 <alltraps>
801074b7:	66 90                	xchg   %ax,%ax
801074b9:	66 90                	xchg   %ax,%ax
801074bb:	66 90                	xchg   %ax,%ax
801074bd:	66 90                	xchg   %ax,%ax
801074bf:	90                   	nop

801074c0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074c0:	55                   	push   %ebp
801074c1:	89 e5                	mov    %esp,%ebp
801074c3:	57                   	push   %edi
801074c4:	56                   	push   %esi
801074c5:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801074c6:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
801074cc:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801074d2:	83 ec 1c             	sub    $0x1c,%esp
801074d5:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801074d8:	39 d3                	cmp    %edx,%ebx
801074da:	73 49                	jae    80107525 <deallocuvm.part.0+0x65>
801074dc:	89 c7                	mov    %eax,%edi
801074de:	eb 0c                	jmp    801074ec <deallocuvm.part.0+0x2c>
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801074e0:	83 c0 01             	add    $0x1,%eax
801074e3:	c1 e0 16             	shl    $0x16,%eax
801074e6:	89 c3                	mov    %eax,%ebx
  for(; a  < oldsz; a += PGSIZE){
801074e8:	39 da                	cmp    %ebx,%edx
801074ea:	76 39                	jbe    80107525 <deallocuvm.part.0+0x65>
  pde = &pgdir[PDX(va)];
801074ec:	89 d8                	mov    %ebx,%eax
801074ee:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801074f1:	8b 0c 87             	mov    (%edi,%eax,4),%ecx
801074f4:	f6 c1 01             	test   $0x1,%cl
801074f7:	74 e7                	je     801074e0 <deallocuvm.part.0+0x20>
  return &pgtab[PTX(va)];
801074f9:	89 de                	mov    %ebx,%esi
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801074fb:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107501:	c1 ee 0a             	shr    $0xa,%esi
80107504:	81 e6 fc 0f 00 00    	and    $0xffc,%esi
8010750a:	8d b4 31 00 00 00 80 	lea    -0x80000000(%ecx,%esi,1),%esi
    if(!pte)
80107511:	85 f6                	test   %esi,%esi
80107513:	74 cb                	je     801074e0 <deallocuvm.part.0+0x20>
    else if((*pte & PTE_P) != 0){
80107515:	8b 06                	mov    (%esi),%eax
80107517:	a8 01                	test   $0x1,%al
80107519:	75 15                	jne    80107530 <deallocuvm.part.0+0x70>
  for(; a  < oldsz; a += PGSIZE){
8010751b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107521:	39 da                	cmp    %ebx,%edx
80107523:	77 c7                	ja     801074ec <deallocuvm.part.0+0x2c>
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107525:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107528:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010752b:	5b                   	pop    %ebx
8010752c:	5e                   	pop    %esi
8010752d:	5f                   	pop    %edi
8010752e:	5d                   	pop    %ebp
8010752f:	c3                   	ret    
      if(pa == 0)
80107530:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107535:	74 25                	je     8010755c <deallocuvm.part.0+0x9c>
      kfree(v);
80107537:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010753a:	05 00 00 00 80       	add    $0x80000000,%eax
8010753f:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107542:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107548:	50                   	push   %eax
80107549:	e8 42 b4 ff ff       	call   80102990 <kfree>
      *pte = 0;
8010754e:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  for(; a  < oldsz; a += PGSIZE){
80107554:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107557:	83 c4 10             	add    $0x10,%esp
8010755a:	eb 8c                	jmp    801074e8 <deallocuvm.part.0+0x28>
        panic("kfree");
8010755c:	83 ec 0c             	sub    $0xc,%esp
8010755f:	68 7e 81 10 80       	push   $0x8010817e
80107564:	e8 17 8e ff ff       	call   80100380 <panic>
80107569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107570 <mappages>:
{
80107570:	55                   	push   %ebp
80107571:	89 e5                	mov    %esp,%ebp
80107573:	57                   	push   %edi
80107574:	56                   	push   %esi
80107575:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107576:	89 d3                	mov    %edx,%ebx
80107578:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010757e:	83 ec 1c             	sub    $0x1c,%esp
80107581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107584:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107588:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010758d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107590:	8b 45 08             	mov    0x8(%ebp),%eax
80107593:	29 d8                	sub    %ebx,%eax
80107595:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107598:	eb 3d                	jmp    801075d7 <mappages+0x67>
8010759a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801075a0:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801075a2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801075a7:	c1 ea 0a             	shr    $0xa,%edx
801075aa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801075b0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
801075b7:	85 c0                	test   %eax,%eax
801075b9:	74 75                	je     80107630 <mappages+0xc0>
    if(*pte & PTE_P)
801075bb:	f6 00 01             	testb  $0x1,(%eax)
801075be:	0f 85 86 00 00 00    	jne    8010764a <mappages+0xda>
    *pte = pa | perm | PTE_P;
801075c4:	0b 75 0c             	or     0xc(%ebp),%esi
801075c7:	83 ce 01             	or     $0x1,%esi
801075ca:	89 30                	mov    %esi,(%eax)
    if(a == last)
801075cc:	3b 5d dc             	cmp    -0x24(%ebp),%ebx
801075cf:	74 6f                	je     80107640 <mappages+0xd0>
    a += PGSIZE;
801075d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
801075d7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  pde = &pgdir[PDX(va)];
801075da:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801075dd:	8d 34 18             	lea    (%eax,%ebx,1),%esi
801075e0:	89 d8                	mov    %ebx,%eax
801075e2:	c1 e8 16             	shr    $0x16,%eax
801075e5:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801075e8:	8b 07                	mov    (%edi),%eax
801075ea:	a8 01                	test   $0x1,%al
801075ec:	75 b2                	jne    801075a0 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801075ee:	e8 5d b5 ff ff       	call   80102b50 <kalloc>
801075f3:	85 c0                	test   %eax,%eax
801075f5:	74 39                	je     80107630 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801075f7:	83 ec 04             	sub    $0x4,%esp
801075fa:	89 45 d8             	mov    %eax,-0x28(%ebp)
801075fd:	68 00 10 00 00       	push   $0x1000
80107602:	6a 00                	push   $0x0
80107604:	50                   	push   %eax
80107605:	e8 d6 da ff ff       	call   801050e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010760a:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
8010760d:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107610:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107616:	83 c8 07             	or     $0x7,%eax
80107619:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
8010761b:	89 d8                	mov    %ebx,%eax
8010761d:	c1 e8 0a             	shr    $0xa,%eax
80107620:	25 fc 0f 00 00       	and    $0xffc,%eax
80107625:	01 d0                	add    %edx,%eax
80107627:	eb 92                	jmp    801075bb <mappages+0x4b>
80107629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
80107630:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107633:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107638:	5b                   	pop    %ebx
80107639:	5e                   	pop    %esi
8010763a:	5f                   	pop    %edi
8010763b:	5d                   	pop    %ebp
8010763c:	c3                   	ret    
8010763d:	8d 76 00             	lea    0x0(%esi),%esi
80107640:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107643:	31 c0                	xor    %eax,%eax
}
80107645:	5b                   	pop    %ebx
80107646:	5e                   	pop    %esi
80107647:	5f                   	pop    %edi
80107648:	5d                   	pop    %ebp
80107649:	c3                   	ret    
      panic("remap");
8010764a:	83 ec 0c             	sub    $0xc,%esp
8010764d:	68 28 88 10 80       	push   $0x80108828
80107652:	e8 29 8d ff ff       	call   80100380 <panic>
80107657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765e:	66 90                	xchg   %ax,%ax

80107660 <seginit>:
{
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107666:	e8 05 c8 ff ff       	call   80103e70 <cpuid>
  pd[0] = size-1;
8010766b:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107670:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107676:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010767a:	c7 80 18 28 11 80 ff 	movl   $0xffff,-0x7feed7e8(%eax)
80107681:	ff 00 00 
80107684:	c7 80 1c 28 11 80 00 	movl   $0xcf9a00,-0x7feed7e4(%eax)
8010768b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
8010768e:	c7 80 20 28 11 80 ff 	movl   $0xffff,-0x7feed7e0(%eax)
80107695:	ff 00 00 
80107698:	c7 80 24 28 11 80 00 	movl   $0xcf9200,-0x7feed7dc(%eax)
8010769f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801076a2:	c7 80 28 28 11 80 ff 	movl   $0xffff,-0x7feed7d8(%eax)
801076a9:	ff 00 00 
801076ac:	c7 80 2c 28 11 80 00 	movl   $0xcffa00,-0x7feed7d4(%eax)
801076b3:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801076b6:	c7 80 30 28 11 80 ff 	movl   $0xffff,-0x7feed7d0(%eax)
801076bd:	ff 00 00 
801076c0:	c7 80 34 28 11 80 00 	movl   $0xcff200,-0x7feed7cc(%eax)
801076c7:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801076ca:	05 10 28 11 80       	add    $0x80112810,%eax
  pd[1] = (uint)p;
801076cf:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801076d3:	c1 e8 10             	shr    $0x10,%eax
801076d6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801076da:	8d 45 f2             	lea    -0xe(%ebp),%eax
801076dd:	0f 01 10             	lgdtl  (%eax)
}
801076e0:	c9                   	leave  
801076e1:	c3                   	ret    
801076e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801076f0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801076f0:	a1 e4 5b 11 80       	mov    0x80115be4,%eax
801076f5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801076fa:	0f 22 d8             	mov    %eax,%cr3
}
801076fd:	c3                   	ret    
801076fe:	66 90                	xchg   %ax,%ax

80107700 <switchuvm>:
{
80107700:	55                   	push   %ebp
80107701:	89 e5                	mov    %esp,%ebp
80107703:	57                   	push   %edi
80107704:	56                   	push   %esi
80107705:	53                   	push   %ebx
80107706:	83 ec 1c             	sub    $0x1c,%esp
80107709:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
8010770c:	85 f6                	test   %esi,%esi
8010770e:	0f 84 cb 00 00 00    	je     801077df <switchuvm+0xdf>
  if(p->kstack == 0)
80107714:	8b 46 08             	mov    0x8(%esi),%eax
80107717:	85 c0                	test   %eax,%eax
80107719:	0f 84 da 00 00 00    	je     801077f9 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010771f:	8b 46 04             	mov    0x4(%esi),%eax
80107722:	85 c0                	test   %eax,%eax
80107724:	0f 84 c2 00 00 00    	je     801077ec <switchuvm+0xec>
  pushcli();
8010772a:	e8 a1 d7 ff ff       	call   80104ed0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010772f:	e8 dc c6 ff ff       	call   80103e10 <mycpu>
80107734:	89 c3                	mov    %eax,%ebx
80107736:	e8 d5 c6 ff ff       	call   80103e10 <mycpu>
8010773b:	89 c7                	mov    %eax,%edi
8010773d:	e8 ce c6 ff ff       	call   80103e10 <mycpu>
80107742:	83 c7 08             	add    $0x8,%edi
80107745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107748:	e8 c3 c6 ff ff       	call   80103e10 <mycpu>
8010774d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107750:	ba 67 00 00 00       	mov    $0x67,%edx
80107755:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
8010775c:	83 c0 08             	add    $0x8,%eax
8010775f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107766:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010776b:	83 c1 08             	add    $0x8,%ecx
8010776e:	c1 e8 18             	shr    $0x18,%eax
80107771:	c1 e9 10             	shr    $0x10,%ecx
80107774:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010777a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107780:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107785:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010778c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107791:	e8 7a c6 ff ff       	call   80103e10 <mycpu>
80107796:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010779d:	e8 6e c6 ff ff       	call   80103e10 <mycpu>
801077a2:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801077a6:	8b 5e 08             	mov    0x8(%esi),%ebx
801077a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801077af:	e8 5c c6 ff ff       	call   80103e10 <mycpu>
801077b4:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801077b7:	e8 54 c6 ff ff       	call   80103e10 <mycpu>
801077bc:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801077c0:	b8 28 00 00 00       	mov    $0x28,%eax
801077c5:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801077c8:	8b 46 04             	mov    0x4(%esi),%eax
801077cb:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077d0:	0f 22 d8             	mov    %eax,%cr3
}
801077d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801077d6:	5b                   	pop    %ebx
801077d7:	5e                   	pop    %esi
801077d8:	5f                   	pop    %edi
801077d9:	5d                   	pop    %ebp
  popcli();
801077da:	e9 41 d7 ff ff       	jmp    80104f20 <popcli>
    panic("switchuvm: no process");
801077df:	83 ec 0c             	sub    $0xc,%esp
801077e2:	68 2e 88 10 80       	push   $0x8010882e
801077e7:	e8 94 8b ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
801077ec:	83 ec 0c             	sub    $0xc,%esp
801077ef:	68 59 88 10 80       	push   $0x80108859
801077f4:	e8 87 8b ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
801077f9:	83 ec 0c             	sub    $0xc,%esp
801077fc:	68 44 88 10 80       	push   $0x80108844
80107801:	e8 7a 8b ff ff       	call   80100380 <panic>
80107806:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010780d:	8d 76 00             	lea    0x0(%esi),%esi

80107810 <inituvm>:
{
80107810:	55                   	push   %ebp
80107811:	89 e5                	mov    %esp,%ebp
80107813:	57                   	push   %edi
80107814:	56                   	push   %esi
80107815:	53                   	push   %ebx
80107816:	83 ec 1c             	sub    $0x1c,%esp
80107819:	8b 45 0c             	mov    0xc(%ebp),%eax
8010781c:	8b 75 10             	mov    0x10(%ebp),%esi
8010781f:	8b 7d 08             	mov    0x8(%ebp),%edi
80107822:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107825:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010782b:	77 4b                	ja     80107878 <inituvm+0x68>
  mem = kalloc();
8010782d:	e8 1e b3 ff ff       	call   80102b50 <kalloc>
  memset(mem, 0, PGSIZE);
80107832:	83 ec 04             	sub    $0x4,%esp
80107835:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010783a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
8010783c:	6a 00                	push   $0x0
8010783e:	50                   	push   %eax
8010783f:	e8 9c d8 ff ff       	call   801050e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107844:	58                   	pop    %eax
80107845:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010784b:	5a                   	pop    %edx
8010784c:	6a 06                	push   $0x6
8010784e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107853:	31 d2                	xor    %edx,%edx
80107855:	50                   	push   %eax
80107856:	89 f8                	mov    %edi,%eax
80107858:	e8 13 fd ff ff       	call   80107570 <mappages>
  memmove(mem, init, sz);
8010785d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107860:	89 75 10             	mov    %esi,0x10(%ebp)
80107863:	83 c4 10             	add    $0x10,%esp
80107866:	89 5d 08             	mov    %ebx,0x8(%ebp)
80107869:	89 45 0c             	mov    %eax,0xc(%ebp)
}
8010786c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010786f:	5b                   	pop    %ebx
80107870:	5e                   	pop    %esi
80107871:	5f                   	pop    %edi
80107872:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107873:	e9 08 d9 ff ff       	jmp    80105180 <memmove>
    panic("inituvm: more than a page");
80107878:	83 ec 0c             	sub    $0xc,%esp
8010787b:	68 6d 88 10 80       	push   $0x8010886d
80107880:	e8 fb 8a ff ff       	call   80100380 <panic>
80107885:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010788c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107890 <loaduvm>:
{
80107890:	55                   	push   %ebp
80107891:	89 e5                	mov    %esp,%ebp
80107893:	57                   	push   %edi
80107894:	56                   	push   %esi
80107895:	53                   	push   %ebx
80107896:	83 ec 1c             	sub    $0x1c,%esp
80107899:	8b 45 0c             	mov    0xc(%ebp),%eax
8010789c:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
8010789f:	a9 ff 0f 00 00       	test   $0xfff,%eax
801078a4:	0f 85 bb 00 00 00    	jne    80107965 <loaduvm+0xd5>
  for(i = 0; i < sz; i += PGSIZE){
801078aa:	01 f0                	add    %esi,%eax
801078ac:	89 f3                	mov    %esi,%ebx
801078ae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801078b1:	8b 45 14             	mov    0x14(%ebp),%eax
801078b4:	01 f0                	add    %esi,%eax
801078b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801078b9:	85 f6                	test   %esi,%esi
801078bb:	0f 84 87 00 00 00    	je     80107948 <loaduvm+0xb8>
801078c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  pde = &pgdir[PDX(va)];
801078c8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  if(*pde & PTE_P){
801078cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801078ce:	29 d8                	sub    %ebx,%eax
  pde = &pgdir[PDX(va)];
801078d0:	89 c2                	mov    %eax,%edx
801078d2:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801078d5:	8b 14 91             	mov    (%ecx,%edx,4),%edx
801078d8:	f6 c2 01             	test   $0x1,%dl
801078db:	75 13                	jne    801078f0 <loaduvm+0x60>
      panic("loaduvm: address should exist");
801078dd:	83 ec 0c             	sub    $0xc,%esp
801078e0:	68 87 88 10 80       	push   $0x80108887
801078e5:	e8 96 8a ff ff       	call   80100380 <panic>
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
801078f0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801078f3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801078f9:	25 fc 0f 00 00       	and    $0xffc,%eax
801078fe:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107905:	85 c0                	test   %eax,%eax
80107907:	74 d4                	je     801078dd <loaduvm+0x4d>
    pa = PTE_ADDR(*pte);
80107909:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010790b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010790e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107913:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107918:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010791e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107921:	29 d9                	sub    %ebx,%ecx
80107923:	05 00 00 00 80       	add    $0x80000000,%eax
80107928:	57                   	push   %edi
80107929:	51                   	push   %ecx
8010792a:	50                   	push   %eax
8010792b:	ff 75 10             	pushl  0x10(%ebp)
8010792e:	e8 1d a6 ff ff       	call   80101f50 <readi>
80107933:	83 c4 10             	add    $0x10,%esp
80107936:	39 f8                	cmp    %edi,%eax
80107938:	75 1e                	jne    80107958 <loaduvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
8010793a:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
80107940:	89 f0                	mov    %esi,%eax
80107942:	29 d8                	sub    %ebx,%eax
80107944:	39 c6                	cmp    %eax,%esi
80107946:	77 80                	ja     801078c8 <loaduvm+0x38>
}
80107948:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010794b:	31 c0                	xor    %eax,%eax
}
8010794d:	5b                   	pop    %ebx
8010794e:	5e                   	pop    %esi
8010794f:	5f                   	pop    %edi
80107950:	5d                   	pop    %ebp
80107951:	c3                   	ret    
80107952:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107958:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010795b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107960:	5b                   	pop    %ebx
80107961:	5e                   	pop    %esi
80107962:	5f                   	pop    %edi
80107963:	5d                   	pop    %ebp
80107964:	c3                   	ret    
    panic("loaduvm: addr must be page aligned");
80107965:	83 ec 0c             	sub    $0xc,%esp
80107968:	68 28 89 10 80       	push   $0x80108928
8010796d:	e8 0e 8a ff ff       	call   80100380 <panic>
80107972:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107979:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107980 <allocuvm>:
{
80107980:	55                   	push   %ebp
80107981:	89 e5                	mov    %esp,%ebp
80107983:	57                   	push   %edi
80107984:	56                   	push   %esi
80107985:	53                   	push   %ebx
80107986:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107989:	8b 45 10             	mov    0x10(%ebp),%eax
{
8010798c:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
8010798f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107992:	85 c0                	test   %eax,%eax
80107994:	0f 88 b6 00 00 00    	js     80107a50 <allocuvm+0xd0>
  if(newsz < oldsz)
8010799a:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
8010799d:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801079a0:	0f 82 9a 00 00 00    	jb     80107a40 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801079a6:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801079ac:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801079b2:	39 75 10             	cmp    %esi,0x10(%ebp)
801079b5:	77 44                	ja     801079fb <allocuvm+0x7b>
801079b7:	e9 87 00 00 00       	jmp    80107a43 <allocuvm+0xc3>
801079bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
801079c0:	83 ec 04             	sub    $0x4,%esp
801079c3:	68 00 10 00 00       	push   $0x1000
801079c8:	6a 00                	push   $0x0
801079ca:	50                   	push   %eax
801079cb:	e8 10 d7 ff ff       	call   801050e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801079d0:	58                   	pop    %eax
801079d1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801079d7:	5a                   	pop    %edx
801079d8:	6a 06                	push   $0x6
801079da:	b9 00 10 00 00       	mov    $0x1000,%ecx
801079df:	89 f2                	mov    %esi,%edx
801079e1:	50                   	push   %eax
801079e2:	89 f8                	mov    %edi,%eax
801079e4:	e8 87 fb ff ff       	call   80107570 <mappages>
801079e9:	83 c4 10             	add    $0x10,%esp
801079ec:	85 c0                	test   %eax,%eax
801079ee:	78 78                	js     80107a68 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
801079f0:	81 c6 00 10 00 00    	add    $0x1000,%esi
801079f6:	39 75 10             	cmp    %esi,0x10(%ebp)
801079f9:	76 48                	jbe    80107a43 <allocuvm+0xc3>
    mem = kalloc();
801079fb:	e8 50 b1 ff ff       	call   80102b50 <kalloc>
80107a00:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107a02:	85 c0                	test   %eax,%eax
80107a04:	75 ba                	jne    801079c0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107a06:	83 ec 0c             	sub    $0xc,%esp
80107a09:	68 a5 88 10 80       	push   $0x801088a5
80107a0e:	e8 8d 8c ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107a13:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a16:	83 c4 10             	add    $0x10,%esp
80107a19:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a1c:	74 32                	je     80107a50 <allocuvm+0xd0>
80107a1e:	8b 55 10             	mov    0x10(%ebp),%edx
80107a21:	89 c1                	mov    %eax,%ecx
80107a23:	89 f8                	mov    %edi,%eax
80107a25:	e8 96 fa ff ff       	call   801074c0 <deallocuvm.part.0>
      return 0;
80107a2a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a34:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a37:	5b                   	pop    %ebx
80107a38:	5e                   	pop    %esi
80107a39:	5f                   	pop    %edi
80107a3a:	5d                   	pop    %ebp
80107a3b:	c3                   	ret    
80107a3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107a40:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107a43:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a49:	5b                   	pop    %ebx
80107a4a:	5e                   	pop    %esi
80107a4b:	5f                   	pop    %edi
80107a4c:	5d                   	pop    %ebp
80107a4d:	c3                   	ret    
80107a4e:	66 90                	xchg   %ax,%ax
    return 0;
80107a50:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107a57:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107a5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a5d:	5b                   	pop    %ebx
80107a5e:	5e                   	pop    %esi
80107a5f:	5f                   	pop    %edi
80107a60:	5d                   	pop    %ebp
80107a61:	c3                   	ret    
80107a62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107a68:	83 ec 0c             	sub    $0xc,%esp
80107a6b:	68 bd 88 10 80       	push   $0x801088bd
80107a70:	e8 2b 8c ff ff       	call   801006a0 <cprintf>
  if(newsz >= oldsz)
80107a75:	8b 45 0c             	mov    0xc(%ebp),%eax
80107a78:	83 c4 10             	add    $0x10,%esp
80107a7b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107a7e:	74 0c                	je     80107a8c <allocuvm+0x10c>
80107a80:	8b 55 10             	mov    0x10(%ebp),%edx
80107a83:	89 c1                	mov    %eax,%ecx
80107a85:	89 f8                	mov    %edi,%eax
80107a87:	e8 34 fa ff ff       	call   801074c0 <deallocuvm.part.0>
      kfree(mem);
80107a8c:	83 ec 0c             	sub    $0xc,%esp
80107a8f:	53                   	push   %ebx
80107a90:	e8 fb ae ff ff       	call   80102990 <kfree>
      return 0;
80107a95:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107a9c:	83 c4 10             	add    $0x10,%esp
}
80107a9f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107aa2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107aa5:	5b                   	pop    %ebx
80107aa6:	5e                   	pop    %esi
80107aa7:	5f                   	pop    %edi
80107aa8:	5d                   	pop    %ebp
80107aa9:	c3                   	ret    
80107aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107ab0 <deallocuvm>:
{
80107ab0:	55                   	push   %ebp
80107ab1:	89 e5                	mov    %esp,%ebp
80107ab3:	8b 55 0c             	mov    0xc(%ebp),%edx
80107ab6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107abc:	39 d1                	cmp    %edx,%ecx
80107abe:	73 10                	jae    80107ad0 <deallocuvm+0x20>
}
80107ac0:	5d                   	pop    %ebp
80107ac1:	e9 fa f9 ff ff       	jmp    801074c0 <deallocuvm.part.0>
80107ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107acd:	8d 76 00             	lea    0x0(%esi),%esi
80107ad0:	89 d0                	mov    %edx,%eax
80107ad2:	5d                   	pop    %ebp
80107ad3:	c3                   	ret    
80107ad4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107adb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107adf:	90                   	nop

80107ae0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107ae0:	55                   	push   %ebp
80107ae1:	89 e5                	mov    %esp,%ebp
80107ae3:	57                   	push   %edi
80107ae4:	56                   	push   %esi
80107ae5:	53                   	push   %ebx
80107ae6:	83 ec 0c             	sub    $0xc,%esp
80107ae9:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107aec:	85 f6                	test   %esi,%esi
80107aee:	74 59                	je     80107b49 <freevm+0x69>
  if(newsz >= oldsz)
80107af0:	31 c9                	xor    %ecx,%ecx
80107af2:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107af7:	89 f0                	mov    %esi,%eax
80107af9:	89 f3                	mov    %esi,%ebx
80107afb:	e8 c0 f9 ff ff       	call   801074c0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107b00:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107b06:	eb 0f                	jmp    80107b17 <freevm+0x37>
80107b08:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b0f:	90                   	nop
80107b10:	83 c3 04             	add    $0x4,%ebx
80107b13:	39 df                	cmp    %ebx,%edi
80107b15:	74 23                	je     80107b3a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107b17:	8b 03                	mov    (%ebx),%eax
80107b19:	a8 01                	test   $0x1,%al
80107b1b:	74 f3                	je     80107b10 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b1d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107b22:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b25:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107b28:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107b2d:	50                   	push   %eax
80107b2e:	e8 5d ae ff ff       	call   80102990 <kfree>
80107b33:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107b36:	39 df                	cmp    %ebx,%edi
80107b38:	75 dd                	jne    80107b17 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107b3a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b40:	5b                   	pop    %ebx
80107b41:	5e                   	pop    %esi
80107b42:	5f                   	pop    %edi
80107b43:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107b44:	e9 47 ae ff ff       	jmp    80102990 <kfree>
    panic("freevm: no pgdir");
80107b49:	83 ec 0c             	sub    $0xc,%esp
80107b4c:	68 d9 88 10 80       	push   $0x801088d9
80107b51:	e8 2a 88 ff ff       	call   80100380 <panic>
80107b56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b5d:	8d 76 00             	lea    0x0(%esi),%esi

80107b60 <setupkvm>:
{
80107b60:	55                   	push   %ebp
80107b61:	89 e5                	mov    %esp,%ebp
80107b63:	56                   	push   %esi
80107b64:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107b65:	e8 e6 af ff ff       	call   80102b50 <kalloc>
80107b6a:	89 c6                	mov    %eax,%esi
80107b6c:	85 c0                	test   %eax,%eax
80107b6e:	74 42                	je     80107bb2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
80107b70:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107b73:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107b78:	68 00 10 00 00       	push   $0x1000
80107b7d:	6a 00                	push   $0x0
80107b7f:	50                   	push   %eax
80107b80:	e8 5b d5 ff ff       	call   801050e0 <memset>
80107b85:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107b88:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107b8b:	83 ec 08             	sub    $0x8,%esp
80107b8e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107b91:	ff 73 0c             	pushl  0xc(%ebx)
80107b94:	8b 13                	mov    (%ebx),%edx
80107b96:	50                   	push   %eax
80107b97:	29 c1                	sub    %eax,%ecx
80107b99:	89 f0                	mov    %esi,%eax
80107b9b:	e8 d0 f9 ff ff       	call   80107570 <mappages>
80107ba0:	83 c4 10             	add    $0x10,%esp
80107ba3:	85 c0                	test   %eax,%eax
80107ba5:	78 19                	js     80107bc0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107ba7:	83 c3 10             	add    $0x10,%ebx
80107baa:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107bb0:	75 d6                	jne    80107b88 <setupkvm+0x28>
}
80107bb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bb5:	89 f0                	mov    %esi,%eax
80107bb7:	5b                   	pop    %ebx
80107bb8:	5e                   	pop    %esi
80107bb9:	5d                   	pop    %ebp
80107bba:	c3                   	ret    
80107bbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bbf:	90                   	nop
      freevm(pgdir);
80107bc0:	83 ec 0c             	sub    $0xc,%esp
80107bc3:	56                   	push   %esi
      return 0;
80107bc4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107bc6:	e8 15 ff ff ff       	call   80107ae0 <freevm>
      return 0;
80107bcb:	83 c4 10             	add    $0x10,%esp
}
80107bce:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107bd1:	89 f0                	mov    %esi,%eax
80107bd3:	5b                   	pop    %ebx
80107bd4:	5e                   	pop    %esi
80107bd5:	5d                   	pop    %ebp
80107bd6:	c3                   	ret    
80107bd7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bde:	66 90                	xchg   %ax,%ax

80107be0 <kvmalloc>:
{
80107be0:	55                   	push   %ebp
80107be1:	89 e5                	mov    %esp,%ebp
80107be3:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107be6:	e8 75 ff ff ff       	call   80107b60 <setupkvm>
80107beb:	a3 e4 5b 11 80       	mov    %eax,0x80115be4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107bf0:	05 00 00 00 80       	add    $0x80000000,%eax
80107bf5:	0f 22 d8             	mov    %eax,%cr3
}
80107bf8:	c9                   	leave  
80107bf9:	c3                   	ret    
80107bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107c00 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107c00:	55                   	push   %ebp
80107c01:	89 e5                	mov    %esp,%ebp
80107c03:	83 ec 08             	sub    $0x8,%esp
80107c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107c09:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107c0c:	89 c1                	mov    %eax,%ecx
80107c0e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107c11:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107c14:	f6 c2 01             	test   $0x1,%dl
80107c17:	75 17                	jne    80107c30 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107c19:	83 ec 0c             	sub    $0xc,%esp
80107c1c:	68 ea 88 10 80       	push   $0x801088ea
80107c21:	e8 5a 87 ff ff       	call   80100380 <panic>
80107c26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c2d:	8d 76 00             	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107c30:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c33:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107c39:	25 fc 0f 00 00       	and    $0xffc,%eax
80107c3e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107c45:	85 c0                	test   %eax,%eax
80107c47:	74 d0                	je     80107c19 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107c49:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107c4c:	c9                   	leave  
80107c4d:	c3                   	ret    
80107c4e:	66 90                	xchg   %ax,%ax

80107c50 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107c50:	55                   	push   %ebp
80107c51:	89 e5                	mov    %esp,%ebp
80107c53:	57                   	push   %edi
80107c54:	56                   	push   %esi
80107c55:	53                   	push   %ebx
80107c56:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107c59:	e8 02 ff ff ff       	call   80107b60 <setupkvm>
80107c5e:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107c61:	85 c0                	test   %eax,%eax
80107c63:	0f 84 bd 00 00 00    	je     80107d26 <copyuvm+0xd6>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107c69:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107c6c:	85 c9                	test   %ecx,%ecx
80107c6e:	0f 84 b2 00 00 00    	je     80107d26 <copyuvm+0xd6>
80107c74:	31 f6                	xor    %esi,%esi
80107c76:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c7d:	8d 76 00             	lea    0x0(%esi),%esi
  if(*pde & PTE_P){
80107c80:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107c83:	89 f0                	mov    %esi,%eax
80107c85:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107c88:	8b 04 81             	mov    (%ecx,%eax,4),%eax
80107c8b:	a8 01                	test   $0x1,%al
80107c8d:	75 11                	jne    80107ca0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
80107c8f:	83 ec 0c             	sub    $0xc,%esp
80107c92:	68 f4 88 10 80       	push   $0x801088f4
80107c97:	e8 e4 86 ff ff       	call   80100380 <panic>
80107c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107ca0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107ca2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107ca7:	c1 ea 0a             	shr    $0xa,%edx
80107caa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107cb0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107cb7:	85 c0                	test   %eax,%eax
80107cb9:	74 d4                	je     80107c8f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
80107cbb:	8b 00                	mov    (%eax),%eax
80107cbd:	a8 01                	test   $0x1,%al
80107cbf:	0f 84 9f 00 00 00    	je     80107d64 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107cc5:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107cc7:	25 ff 0f 00 00       	and    $0xfff,%eax
80107ccc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107ccf:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107cd5:	e8 76 ae ff ff       	call   80102b50 <kalloc>
80107cda:	89 c3                	mov    %eax,%ebx
80107cdc:	85 c0                	test   %eax,%eax
80107cde:	74 64                	je     80107d44 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107ce0:	83 ec 04             	sub    $0x4,%esp
80107ce3:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107ce9:	68 00 10 00 00       	push   $0x1000
80107cee:	57                   	push   %edi
80107cef:	50                   	push   %eax
80107cf0:	e8 8b d4 ff ff       	call   80105180 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107cf5:	58                   	pop    %eax
80107cf6:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107cfc:	5a                   	pop    %edx
80107cfd:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d00:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d05:	89 f2                	mov    %esi,%edx
80107d07:	50                   	push   %eax
80107d08:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d0b:	e8 60 f8 ff ff       	call   80107570 <mappages>
80107d10:	83 c4 10             	add    $0x10,%esp
80107d13:	85 c0                	test   %eax,%eax
80107d15:	78 21                	js     80107d38 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107d17:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107d1d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d20:	0f 87 5a ff ff ff    	ja     80107c80 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107d26:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d2c:	5b                   	pop    %ebx
80107d2d:	5e                   	pop    %esi
80107d2e:	5f                   	pop    %edi
80107d2f:	5d                   	pop    %ebp
80107d30:	c3                   	ret    
80107d31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107d38:	83 ec 0c             	sub    $0xc,%esp
80107d3b:	53                   	push   %ebx
80107d3c:	e8 4f ac ff ff       	call   80102990 <kfree>
      goto bad;
80107d41:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107d44:	83 ec 0c             	sub    $0xc,%esp
80107d47:	ff 75 e0             	pushl  -0x20(%ebp)
80107d4a:	e8 91 fd ff ff       	call   80107ae0 <freevm>
  return 0;
80107d4f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d56:	83 c4 10             	add    $0x10,%esp
}
80107d59:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d5c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d5f:	5b                   	pop    %ebx
80107d60:	5e                   	pop    %esi
80107d61:	5f                   	pop    %edi
80107d62:	5d                   	pop    %ebp
80107d63:	c3                   	ret    
      panic("copyuvm: page not present");
80107d64:	83 ec 0c             	sub    $0xc,%esp
80107d67:	68 0e 89 10 80       	push   $0x8010890e
80107d6c:	e8 0f 86 ff ff       	call   80100380 <panic>
80107d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d78:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107d7f:	90                   	nop

80107d80 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107d80:	55                   	push   %ebp
80107d81:	89 e5                	mov    %esp,%ebp
80107d83:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107d86:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107d89:	89 c1                	mov    %eax,%ecx
80107d8b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107d8e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107d91:	f6 c2 01             	test   $0x1,%dl
80107d94:	0f 84 00 01 00 00    	je     80107e9a <uva2ka.cold>
  return &pgtab[PTX(va)];
80107d9a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d9d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107da3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107da4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107da9:	8b 84 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%eax
  if((*pte & PTE_U) == 0)
80107db0:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107db2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107db7:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107dba:	05 00 00 00 80       	add    $0x80000000,%eax
80107dbf:	83 fa 05             	cmp    $0x5,%edx
80107dc2:	ba 00 00 00 00       	mov    $0x0,%edx
80107dc7:	0f 45 c2             	cmovne %edx,%eax
}
80107dca:	c3                   	ret    
80107dcb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107dcf:	90                   	nop

80107dd0 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
80107dd3:	57                   	push   %edi
80107dd4:	56                   	push   %esi
80107dd5:	53                   	push   %ebx
80107dd6:	83 ec 0c             	sub    $0xc,%esp
80107dd9:	8b 75 14             	mov    0x14(%ebp),%esi
80107ddc:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ddf:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107de2:	85 f6                	test   %esi,%esi
80107de4:	75 51                	jne    80107e37 <copyout+0x67>
80107de6:	e9 a5 00 00 00       	jmp    80107e90 <copyout+0xc0>
80107deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107def:	90                   	nop
  return (char*)P2V(PTE_ADDR(*pte));
80107df0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107df6:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
80107dfc:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107e02:	74 75                	je     80107e79 <copyout+0xa9>
      return -1;
    n = PGSIZE - (va - va0);
80107e04:	89 fb                	mov    %edi,%ebx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107e06:	89 55 10             	mov    %edx,0x10(%ebp)
    n = PGSIZE - (va - va0);
80107e09:	29 c3                	sub    %eax,%ebx
80107e0b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107e11:	39 f3                	cmp    %esi,%ebx
80107e13:	0f 47 de             	cmova  %esi,%ebx
    memmove(pa0 + (va - va0), buf, n);
80107e16:	29 f8                	sub    %edi,%eax
80107e18:	83 ec 04             	sub    $0x4,%esp
80107e1b:	01 c1                	add    %eax,%ecx
80107e1d:	53                   	push   %ebx
80107e1e:	52                   	push   %edx
80107e1f:	51                   	push   %ecx
80107e20:	e8 5b d3 ff ff       	call   80105180 <memmove>
    len -= n;
    buf += n;
80107e25:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107e28:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
80107e2e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107e31:	01 da                	add    %ebx,%edx
  while(len > 0){
80107e33:	29 de                	sub    %ebx,%esi
80107e35:	74 59                	je     80107e90 <copyout+0xc0>
  if(*pde & PTE_P){
80107e37:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
80107e3a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107e3c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
80107e3e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107e41:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107e47:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
80107e4a:	f6 c1 01             	test   $0x1,%cl
80107e4d:	0f 84 4e 00 00 00    	je     80107ea1 <copyout.cold>
  return &pgtab[PTX(va)];
80107e53:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e55:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80107e5b:	c1 eb 0c             	shr    $0xc,%ebx
80107e5e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107e64:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
80107e6b:	89 d9                	mov    %ebx,%ecx
80107e6d:	83 e1 05             	and    $0x5,%ecx
80107e70:	83 f9 05             	cmp    $0x5,%ecx
80107e73:	0f 84 77 ff ff ff    	je     80107df0 <copyout+0x20>
  }
  return 0;
}
80107e79:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107e7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107e81:	5b                   	pop    %ebx
80107e82:	5e                   	pop    %esi
80107e83:	5f                   	pop    %edi
80107e84:	5d                   	pop    %ebp
80107e85:	c3                   	ret    
80107e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107e8d:	8d 76 00             	lea    0x0(%esi),%esi
80107e90:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107e93:	31 c0                	xor    %eax,%eax
}
80107e95:	5b                   	pop    %ebx
80107e96:	5e                   	pop    %esi
80107e97:	5f                   	pop    %edi
80107e98:	5d                   	pop    %ebp
80107e99:	c3                   	ret    

80107e9a <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107e9a:	a1 00 00 00 00       	mov    0x0,%eax
80107e9f:	0f 0b                	ud2    

80107ea1 <copyout.cold>:
80107ea1:	a1 00 00 00 00       	mov    0x0,%eax
80107ea6:	0f 0b                	ud2    
