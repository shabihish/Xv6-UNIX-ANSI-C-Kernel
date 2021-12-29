
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 80 c6 10 80       	mov    $0x8010c680,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 20 35 10 80       	mov    $0x80103520,%eax
  jmp *%eax
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
80100040:	f3 0f 1e fb          	endbr32 
80100044:	55                   	push   %ebp
80100045:	89 e5                	mov    %esp,%ebp
80100047:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100048:	bb b4 c6 10 80       	mov    $0x8010c6b4,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 00 7c 10 80       	push   $0x80107c00
80100055:	68 80 c6 10 80       	push   $0x8010c680
8010005a:	e8 d1 4c 00 00       	call   80104d30 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 7c 0d 11 80       	mov    $0x80110d7c,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 cc 0d 11 80 7c 	movl   $0x80110d7c,0x80110dcc
8010006e:	0d 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 d0 0d 11 80 7c 	movl   $0x80110d7c,0x80110dd0
80100078:	0d 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
8010007b:	eb 05                	jmp    80100082 <binit+0x42>
8010007d:	8d 76 00             	lea    0x0(%esi),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 0d 11 80 	movl   $0x80110d7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 07 7c 10 80       	push   $0x80107c07
80100097:	50                   	push   %eax
80100098:	e8 53 4b 00 00       	call   80104bf0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 0d 11 80       	mov    0x80110dd0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d d0 0d 11 80    	mov    %ebx,0x80110dd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb 20 0b 11 80    	cmp    $0x80110b20,%ebx
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
801000d0:	f3 0f 1e fb          	endbr32 
801000d4:	55                   	push   %ebp
801000d5:	89 e5                	mov    %esp,%ebp
801000d7:	57                   	push   %edi
801000d8:	56                   	push   %esi
801000d9:	53                   	push   %ebx
801000da:	83 ec 18             	sub    $0x18,%esp
801000dd:	8b 7d 08             	mov    0x8(%ebp),%edi
801000e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&bcache.lock);
801000e3:	68 80 c6 10 80       	push   $0x8010c680
801000e8:	e8 c3 4d 00 00       	call   80104eb0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d d0 0d 11 80    	mov    0x80110dd0,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb 7c 0d 11 80    	cmp    $0x80110d7c,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 0d 11 80    	cmp    $0x80110d7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 7b 04             	cmp    0x4(%ebx),%edi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 73 08             	cmp    0x8(%ebx),%esi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010011f:	90                   	nop
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 0d 11 80    	mov    0x80110dcc,%ebx
80100126:	81 fb 7c 0d 11 80    	cmp    $0x80110d7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 0d 11 80    	cmp    $0x80110d7c,%ebx
80100139:	74 65                	je     801001a0 <bread+0xd0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 7b 04             	mov    %edi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 73 08             	mov    %esi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 c6 10 80       	push   $0x8010c680
80100162:	e8 09 4e 00 00       	call   80104f70 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 be 4a 00 00       	call   80104c30 <acquiresleep>
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
8010018c:	e8 cf 25 00 00       	call   80102760 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret    
8010019e:	66 90                	xchg   %ax,%ax
  panic("bget: no buffers");
801001a0:	83 ec 0c             	sub    $0xc,%esp
801001a3:	68 0e 7c 10 80       	push   $0x80107c0e
801001a8:	e8 e3 01 00 00       	call   80100390 <panic>
801001ad:	8d 76 00             	lea    0x0(%esi),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	f3 0f 1e fb          	endbr32 
801001b4:	55                   	push   %ebp
801001b5:	89 e5                	mov    %esp,%ebp
801001b7:	53                   	push   %ebx
801001b8:	83 ec 10             	sub    $0x10,%esp
801001bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001be:	8d 43 0c             	lea    0xc(%ebx),%eax
801001c1:	50                   	push   %eax
801001c2:	e8 09 4b 00 00       	call   80104cd0 <holdingsleep>
801001c7:	83 c4 10             	add    $0x10,%esp
801001ca:	85 c0                	test   %eax,%eax
801001cc:	74 0f                	je     801001dd <bwrite+0x2d>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ce:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001d1:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d7:	c9                   	leave  
  iderw(b);
801001d8:	e9 83 25 00 00       	jmp    80102760 <iderw>
    panic("bwrite");
801001dd:	83 ec 0c             	sub    $0xc,%esp
801001e0:	68 1f 7c 10 80       	push   $0x80107c1f
801001e5:	e8 a6 01 00 00       	call   80100390 <panic>
801001ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	f3 0f 1e fb          	endbr32 
801001f4:	55                   	push   %ebp
801001f5:	89 e5                	mov    %esp,%ebp
801001f7:	56                   	push   %esi
801001f8:	53                   	push   %ebx
801001f9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001fc:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ff:	83 ec 0c             	sub    $0xc,%esp
80100202:	56                   	push   %esi
80100203:	e8 c8 4a 00 00       	call   80104cd0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 78 4a 00 00       	call   80104c90 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 80 c6 10 80 	movl   $0x8010c680,(%esp)
8010021f:	e8 8c 4c 00 00       	call   80104eb0 <acquire>
  b->refcnt--;
80100224:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100227:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010022a:	83 e8 01             	sub    $0x1,%eax
8010022d:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
80100230:	85 c0                	test   %eax,%eax
80100232:	75 2f                	jne    80100263 <brelse+0x73>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100234:	8b 43 54             	mov    0x54(%ebx),%eax
80100237:	8b 53 50             	mov    0x50(%ebx),%edx
8010023a:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
8010023d:	8b 43 50             	mov    0x50(%ebx),%eax
80100240:	8b 53 54             	mov    0x54(%ebx),%edx
80100243:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100246:	a1 d0 0d 11 80       	mov    0x80110dd0,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 7c 0d 11 80 	movl   $0x80110d7c,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 d0 0d 11 80       	mov    0x80110dd0,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d d0 0d 11 80    	mov    %ebx,0x80110dd0
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 80 c6 10 80 	movl   $0x8010c680,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 fb 4c 00 00       	jmp    80104f70 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 26 7c 10 80       	push   $0x80107c26
8010027d:	e8 0e 01 00 00       	call   80100390 <panic>
80100282:	66 90                	xchg   %ax,%ax
80100284:	66 90                	xchg   %ax,%ax
80100286:	66 90                	xchg   %ax,%ax
80100288:	66 90                	xchg   %ax,%ax
8010028a:	66 90                	xchg   %ax,%ax
8010028c:	66 90                	xchg   %ax,%ax
8010028e:	66 90                	xchg   %ax,%ax

80100290 <consoleread>:
    }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100290:	f3 0f 1e fb          	endbr32 
80100294:	55                   	push   %ebp
80100295:	89 e5                	mov    %esp,%ebp
80100297:	57                   	push   %edi
80100298:	56                   	push   %esi
80100299:	53                   	push   %ebx
8010029a:	83 ec 18             	sub    $0x18,%esp
    uint target;
    int c;

    iunlock(ip);
8010029d:	ff 75 08             	pushl  0x8(%ebp)
{
801002a0:	8b 5d 10             	mov    0x10(%ebp),%ebx
    target = n;
801002a3:	89 de                	mov    %ebx,%esi
    iunlock(ip);
801002a5:	e8 56 1a 00 00       	call   80101d00 <iunlock>
    acquire(&cons.lock);
801002aa:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
801002b1:	e8 fa 4b 00 00       	call   80104eb0 <acquire>
                // caller gets a 0-byte result.
                input.r--;
            }
            break;
        }
        *dst++ = c;
801002b6:	8b 7d 0c             	mov    0xc(%ebp),%edi
    while(n > 0){
801002b9:	83 c4 10             	add    $0x10,%esp
        *dst++ = c;
801002bc:	01 df                	add    %ebx,%edi
    while(n > 0){
801002be:	85 db                	test   %ebx,%ebx
801002c0:	0f 8e 97 00 00 00    	jle    8010035d <consoleread+0xcd>
        while(input.r == input.w){
801002c6:	a1 60 10 11 80       	mov    0x80111060,%eax
801002cb:	3b 05 64 10 11 80    	cmp    0x80111064,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
            sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 60 b5 10 80       	push   $0x8010b560
801002e0:	68 60 10 11 80       	push   $0x80111060
801002e5:	e8 b6 41 00 00       	call   801044a0 <sleep>
        while(input.r == input.w){
801002ea:	a1 60 10 11 80       	mov    0x80111060,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 64 10 11 80    	cmp    0x80111064,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
            if(myproc()->killed){
801002fa:	e8 d1 3b 00 00       	call   80103ed0 <myproc>
801002ff:	8b 48 28             	mov    0x28(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
                release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 60 b5 10 80       	push   $0x8010b560
8010030e:	e8 5d 4c 00 00       	call   80104f70 <release>
                ilock(ip);
80100313:	5a                   	pop    %edx
80100314:	ff 75 08             	pushl  0x8(%ebp)
80100317:	e8 04 19 00 00       	call   80101c20 <ilock>
                return -1;
8010031c:	83 c4 10             	add    $0x10,%esp
    }
    release(&cons.lock);
    ilock(ip);

    return target - n;
}
8010031f:	8d 65 f4             	lea    -0xc(%ebp),%esp
                return -1;
80100322:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100327:	5b                   	pop    %ebx
80100328:	5e                   	pop    %esi
80100329:	5f                   	pop    %edi
8010032a:	5d                   	pop    %ebp
8010032b:	c3                   	ret    
8010032c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        c = input.buf[input.r++ % INPUT_BUF];
80100330:	8d 50 01             	lea    0x1(%eax),%edx
80100333:	89 15 60 10 11 80    	mov    %edx,0x80111060
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a e0 0f 11 80 	movsbl -0x7feef020(%edx),%ecx
        if(c == C('D')){  // EOF
80100345:	80 f9 04             	cmp    $0x4,%cl
80100348:	74 38                	je     80100382 <consoleread+0xf2>
        *dst++ = c;
8010034a:	89 d8                	mov    %ebx,%eax
        --n;
8010034c:	83 eb 01             	sub    $0x1,%ebx
        *dst++ = c;
8010034f:	f7 d8                	neg    %eax
80100351:	88 0c 07             	mov    %cl,(%edi,%eax,1)
        if(c == '\n')
80100354:	83 f9 0a             	cmp    $0xa,%ecx
80100357:	0f 85 61 ff ff ff    	jne    801002be <consoleread+0x2e>
    release(&cons.lock);
8010035d:	83 ec 0c             	sub    $0xc,%esp
80100360:	68 60 b5 10 80       	push   $0x8010b560
80100365:	e8 06 4c 00 00       	call   80104f70 <release>
    ilock(ip);
8010036a:	58                   	pop    %eax
8010036b:	ff 75 08             	pushl  0x8(%ebp)
8010036e:	e8 ad 18 00 00       	call   80101c20 <ilock>
    return target - n;
80100373:	89 f0                	mov    %esi,%eax
80100375:	83 c4 10             	add    $0x10,%esp
}
80100378:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return target - n;
8010037b:	29 d8                	sub    %ebx,%eax
}
8010037d:	5b                   	pop    %ebx
8010037e:	5e                   	pop    %esi
8010037f:	5f                   	pop    %edi
80100380:	5d                   	pop    %ebp
80100381:	c3                   	ret    
            if(n < target){
80100382:	39 f3                	cmp    %esi,%ebx
80100384:	73 d7                	jae    8010035d <consoleread+0xcd>
                input.r--;
80100386:	a3 60 10 11 80       	mov    %eax,0x80111060
8010038b:	eb d0                	jmp    8010035d <consoleread+0xcd>
8010038d:	8d 76 00             	lea    0x0(%esi),%esi

80100390 <panic>:
{
80100390:	f3 0f 1e fb          	endbr32 
80100394:	55                   	push   %ebp
80100395:	89 e5                	mov    %esp,%ebp
80100397:	56                   	push   %esi
80100398:	53                   	push   %ebx
80100399:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
8010039c:	fa                   	cli    
    cons.locking = 0;
8010039d:	c7 05 94 b5 10 80 00 	movl   $0x0,0x8010b594
801003a4:	00 00 00 
    getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
    cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 ce 29 00 00       	call   80102d80 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 2d 7c 10 80       	push   $0x80107c2d
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
    cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
    cprintf("\n");
801003c9:	c7 04 24 cd 81 10 80 	movl   $0x801081cd,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
    getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 6f 49 00 00       	call   80104d50 <getcallerpcs>
    for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
        cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 41 7c 10 80       	push   $0x80107c41
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
    for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
    panicked = 1; // freeze other CPU
801003fd:	c7 05 98 b5 10 80 01 	movl   $0x1,0x8010b598
80100404:	00 00 00 
    for(;;)
80100407:	eb fe                	jmp    80100407 <panic+0x77>
80100409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100410 <consputc.part.0>:
consputc(int c)
80100410:	55                   	push   %ebp
80100411:	89 e5                	mov    %esp,%ebp
80100413:	57                   	push   %edi
80100414:	56                   	push   %esi
80100415:	53                   	push   %ebx
80100416:	89 c3                	mov    %eax,%ebx
80100418:	83 ec 1c             	sub    $0x1c,%esp
    if(c == BACKSPACE){
8010041b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100420:	0f 84 ea 00 00 00    	je     80100510 <consputc.part.0+0x100>
        uartputc(c);
80100426:	83 ec 0c             	sub    $0xc,%esp
80100429:	50                   	push   %eax
8010042a:	e8 d1 63 00 00       	call   80106800 <uartputc>
8010042f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100432:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100437:	b8 0e 00 00 00       	mov    $0xe,%eax
8010043c:	89 fa                	mov    %edi,%edx
8010043e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010043f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100444:	89 ca                	mov    %ecx,%edx
80100446:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100447:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010044a:	89 fa                	mov    %edi,%edx
8010044c:	c1 e0 08             	shl    $0x8,%eax
8010044f:	89 c6                	mov    %eax,%esi
80100451:	b8 0f 00 00 00       	mov    $0xf,%eax
80100456:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100457:	89 ca                	mov    %ecx,%edx
80100459:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
8010045a:	0f b6 c0             	movzbl %al,%eax
8010045d:	09 f0                	or     %esi,%eax
    if(c == '\n')
8010045f:	83 fb 0a             	cmp    $0xa,%ebx
80100462:	0f 84 90 00 00 00    	je     801004f8 <consputc.part.0+0xe8>
    else if(c == BACKSPACE){
80100468:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
8010046e:	74 70                	je     801004e0 <consputc.part.0+0xd0>
        crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100470:	0f b6 db             	movzbl %bl,%ebx
80100473:	8d 70 01             	lea    0x1(%eax),%esi
80100476:	80 cf 07             	or     $0x7,%bh
80100479:	66 89 9c 00 00 80 0b 	mov    %bx,-0x7ff48000(%eax,%eax,1)
80100480:	80 
    if(pos < 0 || pos > 25*80)
80100481:	81 fe d0 07 00 00    	cmp    $0x7d0,%esi
80100487:	0f 8f f9 00 00 00    	jg     80100586 <consputc.part.0+0x176>
    if((pos/80) >= 24){  // Scroll up.
8010048d:	81 fe 7f 07 00 00    	cmp    $0x77f,%esi
80100493:	0f 8f a7 00 00 00    	jg     80100540 <consputc.part.0+0x130>
80100499:	89 f0                	mov    %esi,%eax
8010049b:	8d b4 36 00 80 0b 80 	lea    -0x7ff48000(%esi,%esi,1),%esi
801004a2:	88 45 e7             	mov    %al,-0x19(%ebp)
801004a5:	0f b6 fc             	movzbl %ah,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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
    crt[pos] = ' ' | 0x0700;
801004ce:	b8 20 07 00 00       	mov    $0x720,%eax
801004d3:	66 89 06             	mov    %ax,(%esi)
}
801004d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d9:	5b                   	pop    %ebx
801004da:	5e                   	pop    %esi
801004db:	5f                   	pop    %edi
801004dc:	5d                   	pop    %ebp
801004dd:	c3                   	ret    
801004de:	66 90                	xchg   %ax,%ax
        if(pos > 0) --pos;
801004e0:	8d 70 ff             	lea    -0x1(%eax),%esi
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 9a                	jne    80100481 <consputc.part.0+0x71>
801004e7:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
801004eb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb b4                	jmp    801004a8 <consputc.part.0+0x98>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        pos += 80 - pos%80;
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 70 50             	lea    0x50(%eax),%esi
8010050b:	e9 71 ff ff ff       	jmp    80100481 <consputc.part.0+0x71>
        uartputc('\b'); uartputc(' '); uartputc('\b');
80100510:	83 ec 0c             	sub    $0xc,%esp
80100513:	6a 08                	push   $0x8
80100515:	e8 e6 62 00 00       	call   80106800 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 da 62 00 00       	call   80106800 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 ce 62 00 00       	call   80106800 <uartputc>
80100532:	83 c4 10             	add    $0x10,%esp
80100535:	e9 f8 fe ff ff       	jmp    80100432 <consputc.part.0+0x22>
8010053a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100540:	83 ec 04             	sub    $0x4,%esp
        pos -= 80;
80100543:	8d 5e b0             	lea    -0x50(%esi),%ebx
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100546:	8d b4 36 60 7f 0b 80 	lea    -0x7ff480a0(%esi,%esi,1),%esi
8010054d:	bf 07 00 00 00       	mov    $0x7,%edi
        memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100552:	68 60 0e 00 00       	push   $0xe60
80100557:	68 a0 80 0b 80       	push   $0x800b80a0
8010055c:	68 00 80 0b 80       	push   $0x800b8000
80100561:	e8 fa 4a 00 00       	call   80105060 <memmove>
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 45 4a 00 00       	call   80104fc0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
        panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 45 7c 10 80       	push   $0x80107c45
8010058e:	e8 fd fd ff ff       	call   80100390 <panic>
80100593:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010059a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801005a0 <printint>:
{
801005a0:	55                   	push   %ebp
801005a1:	89 e5                	mov    %esp,%ebp
801005a3:	57                   	push   %edi
801005a4:	56                   	push   %esi
801005a5:	53                   	push   %ebx
801005a6:	83 ec 2c             	sub    $0x2c,%esp
801005a9:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    if(sign && (sign = xx < 0))
801005ac:	85 c9                	test   %ecx,%ecx
801005ae:	74 04                	je     801005b4 <printint+0x14>
801005b0:	85 c0                	test   %eax,%eax
801005b2:	78 6d                	js     80100621 <printint+0x81>
        x = xx;
801005b4:	89 c1                	mov    %eax,%ecx
801005b6:	31 f6                	xor    %esi,%esi
    i = 0;
801005b8:	89 75 cc             	mov    %esi,-0x34(%ebp)
801005bb:	31 db                	xor    %ebx,%ebx
801005bd:	8d 7d d7             	lea    -0x29(%ebp),%edi
        buf[i++] = digits[x % base];
801005c0:	89 c8                	mov    %ecx,%eax
801005c2:	31 d2                	xor    %edx,%edx
801005c4:	89 ce                	mov    %ecx,%esi
801005c6:	f7 75 d4             	divl   -0x2c(%ebp)
801005c9:	0f b6 92 c8 7c 10 80 	movzbl -0x7fef8338(%edx),%edx
801005d0:	89 45 d0             	mov    %eax,-0x30(%ebp)
801005d3:	89 d8                	mov    %ebx,%eax
801005d5:	8d 5b 01             	lea    0x1(%ebx),%ebx
    }while((x /= base) != 0);
801005d8:	8b 4d d0             	mov    -0x30(%ebp),%ecx
801005db:	89 75 d0             	mov    %esi,-0x30(%ebp)
        buf[i++] = digits[x % base];
801005de:	88 14 1f             	mov    %dl,(%edi,%ebx,1)
    }while((x /= base) != 0);
801005e1:	8b 75 d4             	mov    -0x2c(%ebp),%esi
801005e4:	39 75 d0             	cmp    %esi,-0x30(%ebp)
801005e7:	73 d7                	jae    801005c0 <printint+0x20>
801005e9:	8b 75 cc             	mov    -0x34(%ebp),%esi
    if(sign)
801005ec:	85 f6                	test   %esi,%esi
801005ee:	74 0c                	je     801005fc <printint+0x5c>
        buf[i++] = '-';
801005f0:	c6 44 1d d8 2d       	movb   $0x2d,-0x28(%ebp,%ebx,1)
        buf[i++] = digits[x % base];
801005f5:	89 d8                	mov    %ebx,%eax
        buf[i++] = '-';
801005f7:	ba 2d 00 00 00       	mov    $0x2d,%edx
    while(--i >= 0)
801005fc:	8d 5c 05 d7          	lea    -0x29(%ebp,%eax,1),%ebx
80100600:	0f be c2             	movsbl %dl,%eax
    if(panicked){
80100603:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
80100609:	85 d2                	test   %edx,%edx
8010060b:	74 03                	je     80100610 <printint+0x70>
  asm volatile("cli");
8010060d:	fa                   	cli    
        for(;;)
8010060e:	eb fe                	jmp    8010060e <printint+0x6e>
80100610:	e8 fb fd ff ff       	call   80100410 <consputc.part.0>
    while(--i >= 0)
80100615:	39 fb                	cmp    %edi,%ebx
80100617:	74 10                	je     80100629 <printint+0x89>
80100619:	0f be 03             	movsbl (%ebx),%eax
8010061c:	83 eb 01             	sub    $0x1,%ebx
8010061f:	eb e2                	jmp    80100603 <printint+0x63>
        x = -xx;
80100621:	f7 d8                	neg    %eax
80100623:	89 ce                	mov    %ecx,%esi
80100625:	89 c1                	mov    %eax,%ecx
80100627:	eb 8f                	jmp    801005b8 <printint+0x18>
}
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

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100640:	f3 0f 1e fb          	endbr32 
80100644:	55                   	push   %ebp
80100645:	89 e5                	mov    %esp,%ebp
80100647:	57                   	push   %edi
80100648:	56                   	push   %esi
80100649:	53                   	push   %ebx
8010064a:	83 ec 18             	sub    $0x18,%esp
    int i;

    iunlock(ip);
8010064d:	ff 75 08             	pushl  0x8(%ebp)
{
80100650:	8b 5d 10             	mov    0x10(%ebp),%ebx
    iunlock(ip);
80100653:	e8 a8 16 00 00       	call   80101d00 <iunlock>
    acquire(&cons.lock);
80100658:	c7 04 24 60 b5 10 80 	movl   $0x8010b560,(%esp)
8010065f:	e8 4c 48 00 00       	call   80104eb0 <acquire>
    for(i = 0; i < n; i++)
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
    if(panicked){
80100671:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
80100677:	85 d2                	test   %edx,%edx
80100679:	74 05                	je     80100680 <consolewrite+0x40>
8010067b:	fa                   	cli    
        for(;;)
8010067c:	eb fe                	jmp    8010067c <consolewrite+0x3c>
8010067e:	66 90                	xchg   %ax,%ax
        consputc(buf[i] & 0xff);
80100680:	0f b6 07             	movzbl (%edi),%eax
80100683:	83 c7 01             	add    $0x1,%edi
80100686:	e8 85 fd ff ff       	call   80100410 <consputc.part.0>
    for(i = 0; i < n; i++)
8010068b:	39 fe                	cmp    %edi,%esi
8010068d:	75 e2                	jne    80100671 <consolewrite+0x31>
    release(&cons.lock);
8010068f:	83 ec 0c             	sub    $0xc,%esp
80100692:	68 60 b5 10 80       	push   $0x8010b560
80100697:	e8 d4 48 00 00       	call   80104f70 <release>
    ilock(ip);
8010069c:	58                   	pop    %eax
8010069d:	ff 75 08             	pushl  0x8(%ebp)
801006a0:	e8 7b 15 00 00       	call   80101c20 <ilock>

    return n;
}
801006a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006a8:	89 d8                	mov    %ebx,%eax
801006aa:	5b                   	pop    %ebx
801006ab:	5e                   	pop    %esi
801006ac:	5f                   	pop    %edi
801006ad:	5d                   	pop    %ebp
801006ae:	c3                   	ret    
801006af:	90                   	nop

801006b0 <cprintf>:
{
801006b0:	f3 0f 1e fb          	endbr32 
801006b4:	55                   	push   %ebp
801006b5:	89 e5                	mov    %esp,%ebp
801006b7:	57                   	push   %edi
801006b8:	56                   	push   %esi
801006b9:	53                   	push   %ebx
801006ba:	83 ec 1c             	sub    $0x1c,%esp
    locking = cons.locking;
801006bd:	a1 94 b5 10 80       	mov    0x8010b594,%eax
801006c2:	89 45 e0             	mov    %eax,-0x20(%ebp)
    if(locking)
801006c5:	85 c0                	test   %eax,%eax
801006c7:	0f 85 e8 00 00 00    	jne    801007b5 <cprintf+0x105>
    if (fmt == 0)
801006cd:	8b 45 08             	mov    0x8(%ebp),%eax
801006d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801006d3:	85 c0                	test   %eax,%eax
801006d5:	0f 84 5a 01 00 00    	je     80100835 <cprintf+0x185>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006db:	0f b6 00             	movzbl (%eax),%eax
801006de:	85 c0                	test   %eax,%eax
801006e0:	74 36                	je     80100718 <cprintf+0x68>
    argp = (uint*)(void*)(&fmt + 1);
801006e2:	8d 5d 0c             	lea    0xc(%ebp),%ebx
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e5:	31 f6                	xor    %esi,%esi
        if(c != '%'){
801006e7:	83 f8 25             	cmp    $0x25,%eax
801006ea:	74 44                	je     80100730 <cprintf+0x80>
    if(panicked){
801006ec:	8b 0d 98 b5 10 80    	mov    0x8010b598,%ecx
801006f2:	85 c9                	test   %ecx,%ecx
801006f4:	74 0f                	je     80100705 <cprintf+0x55>
801006f6:	fa                   	cli    
        for(;;)
801006f7:	eb fe                	jmp    801006f7 <cprintf+0x47>
801006f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100700:	b8 25 00 00 00       	mov    $0x25,%eax
80100705:	e8 06 fd ff ff       	call   80100410 <consputc.part.0>
    for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010070a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010070d:	83 c6 01             	add    $0x1,%esi
80100710:	0f b6 04 30          	movzbl (%eax,%esi,1),%eax
80100714:	85 c0                	test   %eax,%eax
80100716:	75 cf                	jne    801006e7 <cprintf+0x37>
    if(locking)
80100718:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010071b:	85 c0                	test   %eax,%eax
8010071d:	0f 85 fd 00 00 00    	jne    80100820 <cprintf+0x170>
}
80100723:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100726:	5b                   	pop    %ebx
80100727:	5e                   	pop    %esi
80100728:	5f                   	pop    %edi
80100729:	5d                   	pop    %ebp
8010072a:	c3                   	ret    
8010072b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010072f:	90                   	nop
        c = fmt[++i] & 0xff;
80100730:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100733:	83 c6 01             	add    $0x1,%esi
80100736:	0f b6 3c 30          	movzbl (%eax,%esi,1),%edi
        if(c == 0)
8010073a:	85 ff                	test   %edi,%edi
8010073c:	74 da                	je     80100718 <cprintf+0x68>
        switch(c){
8010073e:	83 ff 70             	cmp    $0x70,%edi
80100741:	74 5a                	je     8010079d <cprintf+0xed>
80100743:	7f 2a                	jg     8010076f <cprintf+0xbf>
80100745:	83 ff 25             	cmp    $0x25,%edi
80100748:	0f 84 92 00 00 00    	je     801007e0 <cprintf+0x130>
8010074e:	83 ff 64             	cmp    $0x64,%edi
80100751:	0f 85 a1 00 00 00    	jne    801007f8 <cprintf+0x148>
                printint(*argp++, 10, 1);
80100757:	8b 03                	mov    (%ebx),%eax
80100759:	8d 7b 04             	lea    0x4(%ebx),%edi
8010075c:	b9 01 00 00 00       	mov    $0x1,%ecx
80100761:	ba 0a 00 00 00       	mov    $0xa,%edx
80100766:	89 fb                	mov    %edi,%ebx
80100768:	e8 33 fe ff ff       	call   801005a0 <printint>
                break;
8010076d:	eb 9b                	jmp    8010070a <cprintf+0x5a>
        switch(c){
8010076f:	83 ff 73             	cmp    $0x73,%edi
80100772:	75 24                	jne    80100798 <cprintf+0xe8>
                if((s = (char*)*argp++) == 0)
80100774:	8d 7b 04             	lea    0x4(%ebx),%edi
80100777:	8b 1b                	mov    (%ebx),%ebx
80100779:	85 db                	test   %ebx,%ebx
8010077b:	75 55                	jne    801007d2 <cprintf+0x122>
                    s = "(null)";
8010077d:	bb 58 7c 10 80       	mov    $0x80107c58,%ebx
                for(; *s; s++)
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
    if(panicked){
80100787:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
8010078d:	85 d2                	test   %edx,%edx
8010078f:	74 39                	je     801007ca <cprintf+0x11a>
80100791:	fa                   	cli    
        for(;;)
80100792:	eb fe                	jmp    80100792 <cprintf+0xe2>
80100794:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        switch(c){
80100798:	83 ff 78             	cmp    $0x78,%edi
8010079b:	75 5b                	jne    801007f8 <cprintf+0x148>
                printint(*argp++, 16, 0);
8010079d:	8b 03                	mov    (%ebx),%eax
8010079f:	8d 7b 04             	lea    0x4(%ebx),%edi
801007a2:	31 c9                	xor    %ecx,%ecx
801007a4:	ba 10 00 00 00       	mov    $0x10,%edx
801007a9:	89 fb                	mov    %edi,%ebx
801007ab:	e8 f0 fd ff ff       	call   801005a0 <printint>
                break;
801007b0:	e9 55 ff ff ff       	jmp    8010070a <cprintf+0x5a>
        acquire(&cons.lock);
801007b5:	83 ec 0c             	sub    $0xc,%esp
801007b8:	68 60 b5 10 80       	push   $0x8010b560
801007bd:	e8 ee 46 00 00       	call   80104eb0 <acquire>
801007c2:	83 c4 10             	add    $0x10,%esp
801007c5:	e9 03 ff ff ff       	jmp    801006cd <cprintf+0x1d>
801007ca:	e8 41 fc ff ff       	call   80100410 <consputc.part.0>
                for(; *s; s++)
801007cf:	83 c3 01             	add    $0x1,%ebx
801007d2:	0f be 03             	movsbl (%ebx),%eax
801007d5:	84 c0                	test   %al,%al
801007d7:	75 ae                	jne    80100787 <cprintf+0xd7>
                if((s = (char*)*argp++) == 0)
801007d9:	89 fb                	mov    %edi,%ebx
801007db:	e9 2a ff ff ff       	jmp    8010070a <cprintf+0x5a>
    if(panicked){
801007e0:	8b 3d 98 b5 10 80    	mov    0x8010b598,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
        for(;;)
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(panicked){
801007f8:	8b 0d 98 b5 10 80    	mov    0x8010b598,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
        for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
    if(panicked){
80100812:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
        for(;;)
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
        release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 60 b5 10 80       	push   $0x8010b560
80100828:	e8 43 47 00 00       	call   80104f70 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
        panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 5f 7c 10 80       	push   $0x80107c5f
8010083d:	e8 4e fb ff ff       	call   80100390 <panic>
80100842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80100848:	89 f8                	mov    %edi,%eax
8010084a:	e8 c1 fb ff ff       	call   80100410 <consputc.part.0>
8010084f:	e9 b6 fe ff ff       	jmp    8010070a <cprintf+0x5a>
80100854:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010085b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010085f:	90                   	nop

80100860 <get_cursor_pos>:
int get_cursor_pos(){
80100860:	f3 0f 1e fb          	endbr32 
80100864:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100865:	b8 0e 00 00 00       	mov    $0xe,%eax
8010086a:	89 e5                	mov    %esp,%ebp
8010086c:	56                   	push   %esi
8010086d:	be d4 03 00 00       	mov    $0x3d4,%esi
80100872:	53                   	push   %ebx
80100873:	89 f2                	mov    %esi,%edx
80100875:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100876:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
8010087b:	89 ca                	mov    %ecx,%edx
8010087d:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
8010087e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100881:	89 f2                	mov    %esi,%edx
80100883:	c1 e0 08             	shl    $0x8,%eax
80100886:	89 c3                	mov    %eax,%ebx
80100888:	b8 0f 00 00 00       	mov    $0xf,%eax
8010088d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010088e:	89 ca                	mov    %ecx,%edx
80100890:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100891:	0f b6 c0             	movzbl %al,%eax
80100894:	09 d8                	or     %ebx,%eax
}
80100896:	5b                   	pop    %ebx
80100897:	5e                   	pop    %esi
80100898:	5d                   	pop    %ebp
80100899:	c3                   	ret    
8010089a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801008a0 <swap_last_two_elements>:
void swap_last_two_elements(){
801008a0:	f3 0f 1e fb          	endbr32 
801008a4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008a5:	b8 0e 00 00 00       	mov    $0xe,%eax
801008aa:	89 e5                	mov    %esp,%ebp
801008ac:	57                   	push   %edi
801008ad:	56                   	push   %esi
801008ae:	be d4 03 00 00       	mov    $0x3d4,%esi
801008b3:	53                   	push   %ebx
801008b4:	89 f2                	mov    %esi,%edx
801008b6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008b7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801008bc:	89 da                	mov    %ebx,%edx
801008be:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
801008bf:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801008c2:	89 f2                	mov    %esi,%edx
801008c4:	b8 0f 00 00 00       	mov    $0xf,%eax
801008c9:	c1 e1 08             	shl    $0x8,%ecx
801008cc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801008cd:	89 da                	mov    %ebx,%edx
801008cf:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
801008d0:	0f b6 c0             	movzbl %al,%eax
801008d3:	09 c1                	or     %eax,%ecx
    if(crt[pos - 3] == ('$' | 0x0700) || crt[pos - 2] == ('$' | 0x0700)) //there arent at least two elements
801008d5:	8d 44 09 fa          	lea    -0x6(%ecx,%ecx,1),%eax
801008d9:	66 81 b8 00 80 0b 80 	cmpw   $0x724,-0x7ff48000(%eax)
801008e0:	24 07 
801008e2:	74 42                	je     80100926 <swap_last_two_elements+0x86>
801008e4:	0f b7 90 02 80 0b 80 	movzwl -0x7ff47ffe(%eax),%edx
801008eb:	66 81 fa 24 07       	cmp    $0x724,%dx
801008f0:	74 34                	je     80100926 <swap_last_two_elements+0x86>
    ushort temp = crt[pos - 1];
801008f2:	0f b7 b8 04 80 0b 80 	movzwl -0x7ff47ffc(%eax),%edi
    crt[pos - 1] = crt[pos - 2];
801008f9:	66 89 90 04 80 0b 80 	mov    %dx,-0x7ff47ffc(%eax)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100900:	89 f2                	mov    %esi,%edx
    ushort temp = crt[pos - 1];
80100902:	66 89 b8 02 80 0b 80 	mov    %di,-0x7ff47ffe(%eax)
80100909:	b8 0e 00 00 00       	mov    $0xe,%eax
8010090e:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
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
}
80100926:	5b                   	pop    %ebx
80100927:	5e                   	pop    %esi
80100928:	5f                   	pop    %edi
80100929:	5d                   	pop    %ebp
8010092a:	c3                   	ret    
8010092b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010092f:	90                   	nop

80100930 <upper_case>:
void upper_case(){
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100947:	bb d5 03 00 00       	mov    $0x3d5,%ebx
8010094c:	89 da                	mov    %ebx,%edx
8010094e:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
8010094f:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100952:	89 fa                	mov    %edi,%edx
80100954:	b8 0f 00 00 00       	mov    $0xf,%eax
80100959:	c1 e1 08             	shl    $0x8,%ecx
8010095c:	89 ce                	mov    %ecx,%esi
8010095e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010095f:	89 da                	mov    %ebx,%edx
80100961:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100962:	0f b6 c8             	movzbl %al,%ecx
80100965:	09 f1                	or     %esi,%ecx
    for(i = pos + 1; crt[i] != (' ' | 0x0700) && crt[i] != ('\n' | 0x0700); i++)
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
        if(crt[i] >= ('a' | 0x0700) && crt[i] <= ('z' | 0x0700))
80100990:	8d 90 9f f8 ff ff    	lea    -0x761(%eax),%edx
80100996:	66 83 fa 19          	cmp    $0x19,%dx
8010099a:	77 06                	ja     801009a2 <upper_case+0x72>
            crt[i] -= 32;
8010099c:	83 e8 20             	sub    $0x20,%eax
8010099f:	66 89 06             	mov    %ax,(%esi)
    for(i = pos + 1; crt[i] != (' ' | 0x0700) && crt[i] != ('\n' | 0x0700); i++)
801009a2:	01 de                	add    %ebx,%esi
801009a4:	0f b7 06             	movzwl (%esi),%eax
801009a7:	66 3d 20 07          	cmp    $0x720,%ax
801009ab:	74 06                	je     801009b3 <upper_case+0x83>
801009ad:	66 3d 0a 07          	cmp    $0x70a,%ax
801009b1:	75 dd                	jne    80100990 <upper_case+0x60>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009b3:	be d4 03 00 00       	mov    $0x3d4,%esi
801009b8:	b8 0e 00 00 00       	mov    $0xe,%eax
801009bd:	89 f2                	mov    %esi,%edx
801009bf:	ee                   	out    %al,(%dx)
801009c0:	bb d5 03 00 00       	mov    $0x3d5,%ebx
    outb(CRTPORT+1, pos>>8);
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
}
801009da:	5b                   	pop    %ebx
801009db:	5e                   	pop    %esi
801009dc:	5f                   	pop    %edi
801009dd:	5d                   	pop    %ebp
801009de:	c3                   	ret    
801009df:	90                   	nop

801009e0 <move_left>:
void move_left(){
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801009f7:	bb d5 03 00 00       	mov    $0x3d5,%ebx
801009fc:	89 da                	mov    %ebx,%edx
801009fe:	ec                   	in     (%dx),%al
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801009ff:	bf 0f 00 00 00       	mov    $0xf,%edi
    pos = inb(CRTPORT+1) << 8;
80100a04:	0f b6 c8             	movzbl %al,%ecx
80100a07:	89 f2                	mov    %esi,%edx
80100a09:	c1 e1 08             	shl    $0x8,%ecx
80100a0c:	89 f8                	mov    %edi,%eax
80100a0e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a0f:	89 da                	mov    %ebx,%edx
80100a11:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100a12:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a15:	89 f2                	mov    %esi,%edx
80100a17:	09 c1                	or     %eax,%ecx
80100a19:	89 f8                	mov    %edi,%eax
    pos--;
80100a1b:	83 e9 01             	sub    $0x1,%ecx
80100a1e:	ee                   	out    %al,(%dx)
80100a1f:	89 c8                	mov    %ecx,%eax
80100a21:	89 da                	mov    %ebx,%edx
80100a23:	ee                   	out    %al,(%dx)
80100a24:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a29:	89 f2                	mov    %esi,%edx
80100a2b:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100a2c:	89 c8                	mov    %ecx,%eax
80100a2e:	89 da                	mov    %ebx,%edx
80100a30:	c1 f8 08             	sar    $0x8,%eax
80100a33:	ee                   	out    %al,(%dx)
}
80100a34:	5b                   	pop    %ebx
80100a35:	5e                   	pop    %esi
80100a36:	5f                   	pop    %edi
80100a37:	5d                   	pop    %ebp
80100a38:	c3                   	ret    
80100a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100a40 <move_right>:
void move_right(){
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a57:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100a5c:	89 da                	mov    %ebx,%edx
80100a5e:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100a5f:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a62:	89 fa                	mov    %edi,%edx
80100a64:	b8 0f 00 00 00       	mov    $0xf,%eax
80100a69:	89 ce                	mov    %ecx,%esi
80100a6b:	c1 e6 08             	shl    $0x8,%esi
80100a6e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100a6f:	89 da                	mov    %ebx,%edx
80100a71:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100a72:	0f b6 c8             	movzbl %al,%ecx
80100a75:	09 f1                	or     %esi,%ecx
    if(crt[pos] != ('\n' | 0x0700)) pos++;
80100a77:	66 81 bc 09 00 80 0b 	cmpw   $0x70a,-0x7ff48000(%ecx,%ecx,1)
80100a7e:	80 0a 07 
80100a81:	74 03                	je     80100a86 <move_right+0x46>
80100a83:	83 c1 01             	add    $0x1,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100a86:	be d4 03 00 00       	mov    $0x3d4,%esi
80100a8b:	b8 0e 00 00 00       	mov    $0xe,%eax
80100a90:	89 f2                	mov    %esi,%edx
80100a92:	ee                   	out    %al,(%dx)
80100a93:	bb d5 03 00 00       	mov    $0x3d5,%ebx
    outb(CRTPORT+1, pos>>8);
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
}
80100aad:	5b                   	pop    %ebx
80100aae:	5e                   	pop    %esi
80100aaf:	5f                   	pop    %edi
80100ab0:	5d                   	pop    %ebp
80100ab1:	c3                   	ret    
80100ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100ac0 <insert_at_the_given_pos>:
void insert_at_the_given_pos(int c, int new_pos){
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ad7:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100adc:	89 ca                	mov    %ecx,%edx
80100ade:	ec                   	in     (%dx),%al
    pos = inb(CRTPORT+1) << 8;
80100adf:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100ae2:	89 fa                	mov    %edi,%edx
80100ae4:	b8 0f 00 00 00       	mov    $0xf,%eax
80100ae9:	89 de                	mov    %ebx,%esi
80100aeb:	c1 e6 08             	shl    $0x8,%esi
80100aee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100aef:	89 ca                	mov    %ecx,%edx
80100af1:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100af2:	0f b6 d8             	movzbl %al,%ebx
    for(int i = pos + new_pos; i >= pos; i--){
80100af5:	8b 45 0c             	mov    0xc(%ebp),%eax
    pos |= inb(CRTPORT+1);
80100af8:	09 f3                	or     %esi,%ebx
    for(int i = pos + new_pos; i >= pos; i--){
80100afa:	01 d8                	add    %ebx,%eax
80100afc:	39 d8                	cmp    %ebx,%eax
80100afe:	7c 1e                	jl     80100b1e <insert_at_the_given_pos+0x5e>
80100b00:	8d 94 00 00 80 0b 80 	lea    -0x7ff48000(%eax,%eax,1),%edx
80100b07:	8d 84 1b fe 7f 0b 80 	lea    -0x7ff48002(%ebx,%ebx,1),%eax
80100b0e:	66 90                	xchg   %ax,%ax
        crt[i+1] = crt[i];
80100b10:	0f b7 0a             	movzwl (%edx),%ecx
80100b13:	83 ea 02             	sub    $0x2,%edx
80100b16:	66 89 4a 04          	mov    %cx,0x4(%edx)
    for(int i = pos + new_pos; i >= pos; i--){
80100b1a:	39 d0                	cmp    %edx,%eax
80100b1c:	75 f2                	jne    80100b10 <insert_at_the_given_pos+0x50>
    crt[pos+1] = (c&0xff) | 0x0700;
80100b1e:	0f b6 45 08          	movzbl 0x8(%ebp),%eax
80100b22:	8d 4b 01             	lea    0x1(%ebx),%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100b25:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100b2a:	89 fa                	mov    %edi,%edx
80100b2c:	80 cc 07             	or     $0x7,%ah
80100b2f:	66 89 84 09 00 80 0b 	mov    %ax,-0x7ff48000(%ecx,%ecx,1)
80100b36:	80 
80100b37:	b8 0e 00 00 00       	mov    $0xe,%eax
80100b3c:	ee                   	out    %al,(%dx)
80100b3d:	be d5 03 00 00       	mov    $0x3d5,%esi
    outb(CRTPORT+1, (pos+1)>>8);
80100b42:	89 c8                	mov    %ecx,%eax
80100b44:	c1 f8 08             	sar    $0x8,%eax
80100b47:	89 f2                	mov    %esi,%edx
80100b49:	ee                   	out    %al,(%dx)
80100b4a:	b8 0f 00 00 00       	mov    $0xf,%eax
80100b4f:	89 fa                	mov    %edi,%edx
80100b51:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos+1);
80100b52:	8d 43 01             	lea    0x1(%ebx),%eax
80100b55:	89 f2                	mov    %esi,%edx
80100b57:	ee                   	out    %al,(%dx)
}
80100b58:	5b                   	pop    %ebx
80100b59:	5e                   	pop    %esi
80100b5a:	5f                   	pop    %edi
80100b5b:	5d                   	pop    %ebp
80100b5c:	c3                   	ret    
80100b5d:	8d 76 00             	lea    0x0(%esi),%esi

80100b60 <consoleintr>:
{
80100b60:	f3 0f 1e fb          	endbr32 
80100b64:	55                   	push   %ebp
80100b65:	89 e5                	mov    %esp,%ebp
80100b67:	57                   	push   %edi
80100b68:	56                   	push   %esi
80100b69:	53                   	push   %ebx
    int c, doprocdump = 0;
80100b6a:	31 db                	xor    %ebx,%ebx
{
80100b6c:	83 ec 28             	sub    $0x28,%esp
80100b6f:	8b 45 08             	mov    0x8(%ebp),%eax
    acquire(&cons.lock);
80100b72:	68 60 b5 10 80       	push   $0x8010b560
{
80100b77:	89 45 d8             	mov    %eax,-0x28(%ebp)
    acquire(&cons.lock);
80100b7a:	e8 31 43 00 00       	call   80104eb0 <acquire>
    while((c = getc()) >= 0){
80100b7f:	83 c4 10             	add    $0x10,%esp
80100b82:	8b 45 d8             	mov    -0x28(%ebp),%eax
80100b85:	ff d0                	call   *%eax
80100b87:	85 c0                	test   %eax,%eax
80100b89:	78 2c                	js     80100bb7 <consoleintr+0x57>
        switch(c){
80100b8b:	83 f8 15             	cmp    $0x15,%eax
80100b8e:	0f 8f ca 01 00 00    	jg     80100d5e <consoleintr+0x1fe>
80100b94:	85 c0                	test   %eax,%eax
80100b96:	74 ea                	je     80100b82 <consoleintr+0x22>
80100b98:	83 f8 15             	cmp    $0x15,%eax
80100b9b:	0f 87 29 02 00 00    	ja     80100dca <consoleintr+0x26a>
80100ba1:	3e ff 24 85 70 7c 10 	notrack jmp *-0x7fef8390(,%eax,4)
80100ba8:	80 
    while((c = getc()) >= 0){
80100ba9:	8b 45 d8             	mov    -0x28(%ebp),%eax
        switch(c){
80100bac:	bb 01 00 00 00       	mov    $0x1,%ebx
    while((c = getc()) >= 0){
80100bb1:	ff d0                	call   *%eax
80100bb3:	85 c0                	test   %eax,%eax
80100bb5:	79 d4                	jns    80100b8b <consoleintr+0x2b>
    release(&cons.lock);
80100bb7:	83 ec 0c             	sub    $0xc,%esp
80100bba:	68 60 b5 10 80       	push   $0x8010b560
80100bbf:	e8 ac 43 00 00       	call   80104f70 <release>
    if(doprocdump) {
80100bc4:	83 c4 10             	add    $0x10,%esp
80100bc7:	85 db                	test   %ebx,%ebx
80100bc9:	0f 85 0f 03 00 00    	jne    80100ede <consoleintr+0x37e>
}
80100bcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100bd2:	5b                   	pop    %ebx
80100bd3:	5e                   	pop    %esi
80100bd4:	5f                   	pop    %edi
80100bd5:	5d                   	pop    %ebp
80100bd6:	c3                   	ret    
80100bd7:	b8 00 01 00 00       	mov    $0x100,%eax
80100bdc:	e8 2f f8 ff ff       	call   80100410 <consputc.part.0>
                while(input.e != input.w &&
80100be1:	a1 68 10 11 80       	mov    0x80111068,%eax
80100be6:	3b 05 64 10 11 80    	cmp    0x80111064,%eax
80100bec:	74 94                	je     80100b82 <consoleintr+0x22>
                      input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100bee:	83 e8 01             	sub    $0x1,%eax
80100bf1:	89 c2                	mov    %eax,%edx
80100bf3:	83 e2 7f             	and    $0x7f,%edx
                while(input.e != input.w &&
80100bf6:	80 ba e0 0f 11 80 0a 	cmpb   $0xa,-0x7feef020(%edx)
80100bfd:	74 83                	je     80100b82 <consoleintr+0x22>
    if(panicked){
80100bff:	8b 3d 98 b5 10 80    	mov    0x8010b598,%edi
                    input.e--;
80100c05:	a3 68 10 11 80       	mov    %eax,0x80111068
    if(panicked){
80100c0a:	85 ff                	test   %edi,%edi
80100c0c:	74 c9                	je     80100bd7 <consoleintr+0x77>
  asm volatile("cli");
80100c0e:	fa                   	cli    
        for(;;)
80100c0f:	eb fe                	jmp    80100c0f <consoleintr+0xaf>
                swap_last_two_elements();
80100c11:	e8 8a fc ff ff       	call   801008a0 <swap_last_two_elements>
                break;
80100c16:	e9 67 ff ff ff       	jmp    80100b82 <consoleintr+0x22>
                upper_case();
80100c1b:	e8 10 fd ff ff       	call   80100930 <upper_case>
                break;
80100c20:	e9 5d ff ff ff       	jmp    80100b82 <consoleintr+0x22>
        switch(c){
80100c25:	83 f8 7f             	cmp    $0x7f,%eax
80100c28:	0f 85 a4 01 00 00    	jne    80100dd2 <consoleintr+0x272>
                if(input.e != input.w){
80100c2e:	a1 68 10 11 80       	mov    0x80111068,%eax
80100c33:	3b 05 64 10 11 80    	cmp    0x80111064,%eax
80100c39:	0f 84 43 ff ff ff    	je     80100b82 <consoleintr+0x22>
    if(panicked){
80100c3f:	8b 35 98 b5 10 80    	mov    0x8010b598,%esi
                    input.e--;
80100c45:	83 e8 01             	sub    $0x1,%eax
80100c48:	a3 68 10 11 80       	mov    %eax,0x80111068
    if(panicked){
80100c4d:	85 f6                	test   %esi,%esi
80100c4f:	0f 84 fc 01 00 00    	je     80100e51 <consoleintr+0x2f1>
80100c55:	fa                   	cli    
        for(;;)
80100c56:	eb fe                	jmp    80100c56 <consoleintr+0xf6>
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100c58:	a1 64 10 11 80       	mov    0x80111064,%eax
80100c5d:	8b 3d 40 b5 10 80    	mov    0x8010b540,%edi
80100c63:	31 c9                	xor    %ecx,%ecx
80100c65:	8b 35 68 10 11 80    	mov    0x80111068,%esi
80100c6b:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100c6e:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100c71:	39 f0                	cmp    %esi,%eax
80100c73:	0f 84 8a 00 00 00    	je     80100d03 <consoleintr+0x1a3>
80100c79:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100c7c:	eb 63                	jmp    80100ce1 <consoleintr+0x181>
                    number_of_left_moves++;
80100c7e:	83 c7 01             	add    $0x1,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c81:	b8 0e 00 00 00       	mov    $0xe,%eax
80100c86:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100c8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100c8c:	bb d5 03 00 00       	mov    $0x3d5,%ebx
80100c91:	89 da                	mov    %ebx,%edx
80100c93:	ec                   	in     (%dx),%al
80100c94:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100c97:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100c9c:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos = inb(CRTPORT+1) << 8;
80100ca1:	c1 e1 08             	shl    $0x8,%ecx
80100ca4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100ca5:	89 da                	mov    %ebx,%edx
80100ca7:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100ca8:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100cab:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100cb0:	09 c1                	or     %eax,%ecx
80100cb2:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos--;
80100cb7:	83 e9 01             	sub    $0x1,%ecx
80100cba:	ee                   	out    %al,(%dx)
80100cbb:	89 c8                	mov    %ecx,%eax
80100cbd:	89 da                	mov    %ebx,%edx
80100cbf:	ee                   	out    %al,(%dx)
80100cc0:	b8 0e 00 00 00       	mov    $0xe,%eax
80100cc5:	ba d4 03 00 00       	mov    $0x3d4,%edx
80100cca:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100ccb:	89 c8                	mov    %ecx,%eax
80100ccd:	89 da                	mov    %ebx,%edx
80100ccf:	c1 f8 08             	sar    $0x8,%eax
80100cd2:	ee                   	out    %al,(%dx)
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100cd3:	b9 01 00 00 00       	mov    $0x1,%ecx
80100cd8:	3b 75 dc             	cmp    -0x24(%ebp),%esi
80100cdb:	0f 84 5f 01 00 00    	je     80100e40 <consoleintr+0x2e0>
80100ce1:	89 f0                	mov    %esi,%eax
80100ce3:	83 ee 01             	sub    $0x1,%esi
80100ce6:	89 f2                	mov    %esi,%edx
80100ce8:	83 e2 7f             	and    $0x7f,%edx
80100ceb:	80 ba e0 0f 11 80 0a 	cmpb   $0xa,-0x7feef020(%edx)
80100cf2:	75 8a                	jne    80100c7e <consoleintr+0x11e>
80100cf4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100cf7:	84 c9                	test   %cl,%cl
80100cf9:	74 08                	je     80100d03 <consoleintr+0x1a3>
80100cfb:	a3 68 10 11 80       	mov    %eax,0x80111068
80100d00:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100d03:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d08:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d0d:	89 fa                	mov    %edi,%edx
80100d0f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d10:	be d5 03 00 00       	mov    $0x3d5,%esi
80100d15:	89 f2                	mov    %esi,%edx
80100d17:	ec                   	in     (%dx),%al
80100d18:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d1b:	89 fa                	mov    %edi,%edx
80100d1d:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos = inb(CRTPORT+1) << 8;
80100d22:	c1 e1 08             	shl    $0x8,%ecx
80100d25:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d26:	89 f2                	mov    %esi,%edx
80100d28:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100d29:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d2c:	89 fa                	mov    %edi,%edx
80100d2e:	09 c1                	or     %eax,%ecx
80100d30:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos--;
80100d35:	83 e9 01             	sub    $0x1,%ecx
80100d38:	ee                   	out    %al,(%dx)
80100d39:	89 c8                	mov    %ecx,%eax
80100d3b:	89 f2                	mov    %esi,%edx
80100d3d:	ee                   	out    %al,(%dx)
80100d3e:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d43:	89 fa                	mov    %edi,%edx
80100d45:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100d46:	89 c8                	mov    %ecx,%eax
80100d48:	89 f2                	mov    %esi,%edx
80100d4a:	c1 f8 08             	sar    $0x8,%eax
80100d4d:	ee                   	out    %al,(%dx)
                number_of_left_moves++;
80100d4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100d51:	83 c0 01             	add    $0x1,%eax
80100d54:	a3 40 b5 10 80       	mov    %eax,0x8010b540
                break;
80100d59:	e9 24 fe ff ff       	jmp    80100b82 <consoleintr+0x22>
        switch(c){
80100d5e:	3d e4 00 00 00       	cmp    $0xe4,%eax
80100d63:	74 15                	je     80100d7a <consoleintr+0x21a>
80100d65:	3d e5 00 00 00       	cmp    $0xe5,%eax
80100d6a:	0f 85 b5 fe ff ff    	jne    80100c25 <consoleintr+0xc5>
                move_right();
80100d70:	e8 cb fc ff ff       	call   80100a40 <move_right>
                break;
80100d75:	e9 08 fe ff ff       	jmp    80100b82 <consoleintr+0x22>
80100d7a:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100d7f:	b8 0e 00 00 00       	mov    $0xe,%eax
80100d84:	89 fa                	mov    %edi,%edx
80100d86:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d87:	be d5 03 00 00       	mov    $0x3d5,%esi
80100d8c:	89 f2                	mov    %esi,%edx
80100d8e:	ec                   	in     (%dx),%al
80100d8f:	0f b6 c8             	movzbl %al,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100d92:	89 fa                	mov    %edi,%edx
80100d94:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos = inb(CRTPORT+1) << 8;
80100d99:	c1 e1 08             	shl    $0x8,%ecx
80100d9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100d9d:	89 f2                	mov    %esi,%edx
80100d9f:	ec                   	in     (%dx),%al
    pos |= inb(CRTPORT+1);
80100da0:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100da3:	89 fa                	mov    %edi,%edx
80100da5:	09 c1                	or     %eax,%ecx
80100da7:	b8 0f 00 00 00       	mov    $0xf,%eax
    pos--;
80100dac:	83 e9 01             	sub    $0x1,%ecx
80100daf:	ee                   	out    %al,(%dx)
80100db0:	89 c8                	mov    %ecx,%eax
80100db2:	89 f2                	mov    %esi,%edx
80100db4:	ee                   	out    %al,(%dx)
80100db5:	b8 0e 00 00 00       	mov    $0xe,%eax
80100dba:	89 fa                	mov    %edi,%edx
80100dbc:	ee                   	out    %al,(%dx)
    outb(CRTPORT+1, pos>>8);
80100dbd:	89 c8                	mov    %ecx,%eax
80100dbf:	89 f2                	mov    %esi,%edx
80100dc1:	c1 f8 08             	sar    $0x8,%eax
80100dc4:	ee                   	out    %al,(%dx)
}
80100dc5:	e9 b8 fd ff ff       	jmp    80100b82 <consoleintr+0x22>
                if(c != 0 && input.e-input.r < INPUT_BUF){
80100dca:	85 c0                	test   %eax,%eax
80100dcc:	0f 84 b0 fd ff ff    	je     80100b82 <consoleintr+0x22>
80100dd2:	8b 15 68 10 11 80    	mov    0x80111068,%edx
80100dd8:	8b 0d 60 10 11 80    	mov    0x80111060,%ecx
80100dde:	89 d6                	mov    %edx,%esi
80100de0:	29 ce                	sub    %ecx,%esi
80100de2:	83 fe 7f             	cmp    $0x7f,%esi
80100de5:	0f 87 97 fd ff ff    	ja     80100b82 <consoleintr+0x22>
                    c = (c == '\r') ? '\n' : c;
80100deb:	83 f8 0d             	cmp    $0xd,%eax
80100dee:	74 70                	je     80100e60 <consoleintr+0x300>
                    if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100df0:	83 f8 0a             	cmp    $0xa,%eax
80100df3:	0f 84 c5 00 00 00    	je     80100ebe <consoleintr+0x35e>
80100df9:	83 f8 04             	cmp    $0x4,%eax
80100dfc:	0f 84 bc 00 00 00    	je     80100ebe <consoleintr+0x35e>
80100e02:	83 e9 80             	sub    $0xffffff80,%ecx
80100e05:	39 ca                	cmp    %ecx,%edx
80100e07:	0f 84 b1 00 00 00    	je     80100ebe <consoleintr+0x35e>
                        if(number_of_left_moves == 0){
80100e0d:	8b 0d 40 b5 10 80    	mov    0x8010b540,%ecx
80100e13:	85 c9                	test   %ecx,%ecx
80100e15:	0f 85 a7 00 00 00    	jne    80100ec2 <consoleintr+0x362>
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
80100e1e:	83 e2 7f             	and    $0x7f,%edx
80100e21:	88 82 e0 0f 11 80    	mov    %al,-0x7feef020(%edx)
    if(panicked){
80100e27:	8b 15 98 b5 10 80    	mov    0x8010b598,%edx
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e2d:	89 0d 68 10 11 80    	mov    %ecx,0x80111068
    if(panicked){
80100e33:	85 d2                	test   %edx,%edx
80100e35:	0f 84 99 00 00 00    	je     80100ed4 <consoleintr+0x374>
  asm volatile("cli");
80100e3b:	fa                   	cli    
        for(;;)
80100e3c:	eb fe                	jmp    80100e3c <consoleintr+0x2dc>
80100e3e:	66 90                	xchg   %ax,%ax
80100e40:	89 35 68 10 11 80    	mov    %esi,0x80111068
80100e46:	8b 5d e0             	mov    -0x20(%ebp),%ebx
                    number_of_left_moves++;
80100e49:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80100e4c:	e9 b2 fe ff ff       	jmp    80100d03 <consoleintr+0x1a3>
80100e51:	b8 00 01 00 00       	mov    $0x100,%eax
80100e56:	e8 b5 f5 ff ff       	call   80100410 <consputc.part.0>
80100e5b:	e9 22 fd ff ff       	jmp    80100b82 <consoleintr+0x22>
80100e60:	b9 0a 00 00 00       	mov    $0xa,%ecx
                    c = (c == '\r') ? '\n' : c;
80100e65:	b8 0a 00 00 00       	mov    $0xa,%eax
                        input.buf[input.e++ % INPUT_BUF] = c;
80100e6a:	8d 72 01             	lea    0x1(%edx),%esi
80100e6d:	83 e2 7f             	and    $0x7f,%edx
80100e70:	88 8a e0 0f 11 80    	mov    %cl,-0x7feef020(%edx)
    if(panicked){
80100e76:	8b 0d 98 b5 10 80    	mov    0x8010b598,%ecx
                        input.buf[input.e++ % INPUT_BUF] = c;
80100e7c:	89 35 68 10 11 80    	mov    %esi,0x80111068
    if(panicked){
80100e82:	85 c9                	test   %ecx,%ecx
80100e84:	74 0a                	je     80100e90 <consoleintr+0x330>
80100e86:	fa                   	cli    
        for(;;)
80100e87:	eb fe                	jmp    80100e87 <consoleintr+0x327>
80100e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100e90:	e8 7b f5 ff ff       	call   80100410 <consputc.part.0>
                        wakeup(&input.r);
80100e95:	83 ec 0c             	sub    $0xc,%esp
                        input.w = input.e;
80100e98:	a1 68 10 11 80       	mov    0x80111068,%eax
                        number_of_left_moves =0;
80100e9d:	c7 05 40 b5 10 80 00 	movl   $0x0,0x8010b540
80100ea4:	00 00 00 
                        wakeup(&input.r);
80100ea7:	68 60 10 11 80       	push   $0x80111060
                        input.w = input.e;
80100eac:	a3 64 10 11 80       	mov    %eax,0x80111064
                        wakeup(&input.r);
80100eb1:	e8 aa 37 00 00       	call   80104660 <wakeup>
80100eb6:	83 c4 10             	add    $0x10,%esp
80100eb9:	e9 c4 fc ff ff       	jmp    80100b82 <consoleintr+0x22>
80100ebe:	89 c1                	mov    %eax,%ecx
80100ec0:	eb a8                	jmp    80100e6a <consoleintr+0x30a>
                            insert_at_the_given_pos(c,number_of_left_moves);
80100ec2:	83 ec 08             	sub    $0x8,%esp
80100ec5:	51                   	push   %ecx
80100ec6:	50                   	push   %eax
80100ec7:	e8 f4 fb ff ff       	call   80100ac0 <insert_at_the_given_pos>
80100ecc:	83 c4 10             	add    $0x10,%esp
80100ecf:	e9 ae fc ff ff       	jmp    80100b82 <consoleintr+0x22>
80100ed4:	e8 37 f5 ff ff       	call   80100410 <consputc.part.0>
80100ed9:	e9 a4 fc ff ff       	jmp    80100b82 <consoleintr+0x22>
}
80100ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ee1:	5b                   	pop    %ebx
80100ee2:	5e                   	pop    %esi
80100ee3:	5f                   	pop    %edi
80100ee4:	5d                   	pop    %ebp
        procdump();  // now call procdump() wo. cons.lock held
80100ee5:	e9 b6 3a 00 00       	jmp    801049a0 <procdump>
80100eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100ef0 <consoleinit>:

void
consoleinit(void)
{
80100ef0:	f3 0f 1e fb          	endbr32 
80100ef4:	55                   	push   %ebp
80100ef5:	89 e5                	mov    %esp,%ebp
80100ef7:	83 ec 10             	sub    $0x10,%esp
    initlock(&cons.lock, "console");
80100efa:	68 68 7c 10 80       	push   $0x80107c68
80100eff:	68 60 b5 10 80       	push   $0x8010b560
80100f04:	e8 27 3e 00 00       	call   80104d30 <initlock>

    devsw[CONSOLE].write = consolewrite;
    devsw[CONSOLE].read = consoleread;
    cons.locking = 1;

    ioapicenable(IRQ_KBD, 0);
80100f09:	58                   	pop    %eax
80100f0a:	5a                   	pop    %edx
80100f0b:	6a 00                	push   $0x0
80100f0d:	6a 01                	push   $0x1
    devsw[CONSOLE].write = consolewrite;
80100f0f:	c7 05 2c 1a 11 80 40 	movl   $0x80100640,0x80111a2c
80100f16:	06 10 80 
    devsw[CONSOLE].read = consoleread;
80100f19:	c7 05 28 1a 11 80 90 	movl   $0x80100290,0x80111a28
80100f20:	02 10 80 
    cons.locking = 1;
80100f23:	c7 05 94 b5 10 80 01 	movl   $0x1,0x8010b594
80100f2a:	00 00 00 
    ioapicenable(IRQ_KBD, 0);
80100f2d:	e8 de 19 00 00       	call   80102910 <ioapicenable>
}
80100f32:	83 c4 10             	add    $0x10,%esp
80100f35:	c9                   	leave  
80100f36:	c3                   	ret    
80100f37:	66 90                	xchg   %ax,%ax
80100f39:	66 90                	xchg   %ax,%ax
80100f3b:	66 90                	xchg   %ax,%ax
80100f3d:	66 90                	xchg   %ax,%ax
80100f3f:	90                   	nop

80100f40 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100f40:	f3 0f 1e fb          	endbr32 
80100f44:	55                   	push   %ebp
80100f45:	89 e5                	mov    %esp,%ebp
80100f47:	57                   	push   %edi
80100f48:	56                   	push   %esi
80100f49:	53                   	push   %ebx
80100f4a:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100f50:	e8 7b 2f 00 00       	call   80103ed0 <myproc>
80100f55:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100f5b:	e8 b0 22 00 00       	call   80103210 <begin_op>

  if((ip = namei(path)) == 0){
80100f60:	83 ec 0c             	sub    $0xc,%esp
80100f63:	ff 75 08             	pushl  0x8(%ebp)
80100f66:	e8 85 15 00 00       	call   801024f0 <namei>
80100f6b:	83 c4 10             	add    $0x10,%esp
80100f6e:	85 c0                	test   %eax,%eax
80100f70:	0f 84 fe 02 00 00    	je     80101274 <exec+0x334>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100f76:	83 ec 0c             	sub    $0xc,%esp
80100f79:	89 c3                	mov    %eax,%ebx
80100f7b:	50                   	push   %eax
80100f7c:	e8 9f 0c 00 00       	call   80101c20 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100f81:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100f87:	6a 34                	push   $0x34
80100f89:	6a 00                	push   $0x0
80100f8b:	50                   	push   %eax
80100f8c:	53                   	push   %ebx
80100f8d:	e8 8e 0f 00 00       	call   80101f20 <readi>
80100f92:	83 c4 20             	add    $0x20,%esp
80100f95:	83 f8 34             	cmp    $0x34,%eax
80100f98:	74 26                	je     80100fc0 <exec+0x80>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100f9a:	83 ec 0c             	sub    $0xc,%esp
80100f9d:	53                   	push   %ebx
80100f9e:	e8 1d 0f 00 00       	call   80101ec0 <iunlockput>
    end_op();
80100fa3:	e8 d8 22 00 00       	call   80103280 <end_op>
80100fa8:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100fab:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100fb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb3:	5b                   	pop    %ebx
80100fb4:	5e                   	pop    %esi
80100fb5:	5f                   	pop    %edi
80100fb6:	5d                   	pop    %ebp
80100fb7:	c3                   	ret    
80100fb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100fbf:	90                   	nop
  if(elf.magic != ELF_MAGIC)
80100fc0:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100fc7:	45 4c 46 
80100fca:	75 ce                	jne    80100f9a <exec+0x5a>
  if((pgdir = setupkvm()) == 0)
80100fcc:	e8 9f 69 00 00       	call   80107970 <setupkvm>
80100fd1:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100fd7:	85 c0                	test   %eax,%eax
80100fd9:	74 bf                	je     80100f9a <exec+0x5a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100fdb:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100fe2:	00 
80100fe3:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100fe9:	0f 84 a4 02 00 00    	je     80101293 <exec+0x353>
  sz = 0;
80100fef:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ff6:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100ff9:	31 ff                	xor    %edi,%edi
80100ffb:	e9 86 00 00 00       	jmp    80101086 <exec+0x146>
    if(ph.type != ELF_PROG_LOAD)
80101000:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80101007:	75 6c                	jne    80101075 <exec+0x135>
    if(ph.memsz < ph.filesz)
80101009:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
8010100f:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80101015:	0f 82 87 00 00 00    	jb     801010a2 <exec+0x162>
    if(ph.vaddr + ph.memsz < ph.vaddr)
8010101b:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80101021:	72 7f                	jb     801010a2 <exec+0x162>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80101023:	83 ec 04             	sub    $0x4,%esp
80101026:	50                   	push   %eax
80101027:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
8010102d:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101033:	e8 58 67 00 00       	call   80107790 <allocuvm>
80101038:	83 c4 10             	add    $0x10,%esp
8010103b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101041:	85 c0                	test   %eax,%eax
80101043:	74 5d                	je     801010a2 <exec+0x162>
    if(ph.vaddr % PGSIZE != 0)
80101045:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
8010104b:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101050:	75 50                	jne    801010a2 <exec+0x162>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80101052:	83 ec 0c             	sub    $0xc,%esp
80101055:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
8010105b:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80101061:	53                   	push   %ebx
80101062:	50                   	push   %eax
80101063:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
80101069:	e8 52 66 00 00       	call   801076c0 <loaduvm>
8010106e:	83 c4 20             	add    $0x20,%esp
80101071:	85 c0                	test   %eax,%eax
80101073:	78 2d                	js     801010a2 <exec+0x162>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101075:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
8010107c:	83 c7 01             	add    $0x1,%edi
8010107f:	83 c6 20             	add    $0x20,%esi
80101082:	39 f8                	cmp    %edi,%eax
80101084:	7e 3a                	jle    801010c0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80101086:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
8010108c:	6a 20                	push   $0x20
8010108e:	56                   	push   %esi
8010108f:	50                   	push   %eax
80101090:	53                   	push   %ebx
80101091:	e8 8a 0e 00 00       	call   80101f20 <readi>
80101096:	83 c4 10             	add    $0x10,%esp
80101099:	83 f8 20             	cmp    $0x20,%eax
8010109c:	0f 84 5e ff ff ff    	je     80101000 <exec+0xc0>
    freevm(pgdir);
801010a2:	83 ec 0c             	sub    $0xc,%esp
801010a5:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801010ab:	e8 40 68 00 00       	call   801078f0 <freevm>
  if(ip){
801010b0:	83 c4 10             	add    $0x10,%esp
801010b3:	e9 e2 fe ff ff       	jmp    80100f9a <exec+0x5a>
801010b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801010bf:	90                   	nop
801010c0:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
801010c6:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
801010cc:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
801010d2:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
801010d8:	83 ec 0c             	sub    $0xc,%esp
801010db:	53                   	push   %ebx
801010dc:	e8 df 0d 00 00       	call   80101ec0 <iunlockput>
  end_op();
801010e1:	e8 9a 21 00 00       	call   80103280 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801010e6:	83 c4 0c             	add    $0xc,%esp
801010e9:	56                   	push   %esi
801010ea:	57                   	push   %edi
801010eb:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
801010f1:	57                   	push   %edi
801010f2:	e8 99 66 00 00       	call   80107790 <allocuvm>
801010f7:	83 c4 10             	add    $0x10,%esp
801010fa:	89 c6                	mov    %eax,%esi
801010fc:	85 c0                	test   %eax,%eax
801010fe:	0f 84 94 00 00 00    	je     80101198 <exec+0x258>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101104:	83 ec 08             	sub    $0x8,%esp
80101107:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  for(argc = 0; argv[argc]; argc++) {
8010110d:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
8010110f:	50                   	push   %eax
80101110:	57                   	push   %edi
  for(argc = 0; argv[argc]; argc++) {
80101111:	31 ff                	xor    %edi,%edi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101113:	e8 f8 68 00 00       	call   80107a10 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
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
    ustack[3+argc] = sp;
80101143:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
8010114a:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
8010114d:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80101153:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80101156:	85 c0                	test   %eax,%eax
80101158:	74 59                	je     801011b3 <exec+0x273>
    if(argc >= MAXARG)
8010115a:	83 ff 20             	cmp    $0x20,%edi
8010115d:	74 39                	je     80101198 <exec+0x258>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
8010115f:	83 ec 0c             	sub    $0xc,%esp
80101162:	50                   	push   %eax
80101163:	e8 58 40 00 00       	call   801051c0 <strlen>
80101168:	f7 d0                	not    %eax
8010116a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010116c:	58                   	pop    %eax
8010116d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101170:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101173:	ff 34 b8             	pushl  (%eax,%edi,4)
80101176:	e8 45 40 00 00       	call   801051c0 <strlen>
8010117b:	83 c0 01             	add    $0x1,%eax
8010117e:	50                   	push   %eax
8010117f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101182:	ff 34 b8             	pushl  (%eax,%edi,4)
80101185:	53                   	push   %ebx
80101186:	56                   	push   %esi
80101187:	e8 e4 69 00 00       	call   80107b70 <copyout>
8010118c:	83 c4 20             	add    $0x20,%esp
8010118f:	85 c0                	test   %eax,%eax
80101191:	79 ad                	jns    80101140 <exec+0x200>
80101193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101197:	90                   	nop
    freevm(pgdir);
80101198:	83 ec 0c             	sub    $0xc,%esp
8010119b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011a1:	e8 4a 67 00 00       	call   801078f0 <freevm>
801011a6:	83 c4 10             	add    $0x10,%esp
  return -1;
801011a9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801011ae:	e9 fd fd ff ff       	jmp    80100fb0 <exec+0x70>
801011b3:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011b9:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
801011c0:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
801011c2:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
801011c9:	00 00 00 00 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011cd:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
801011cf:	83 c0 0c             	add    $0xc,%eax
  ustack[1] = argc;
801011d2:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  sp -= (3+argc+1) * 4;
801011d8:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801011da:	50                   	push   %eax
801011db:	52                   	push   %edx
801011dc:	53                   	push   %ebx
801011dd:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
  ustack[0] = 0xffffffff;  // fake return PC
801011e3:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801011ea:	ff ff ff 
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801011ed:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801011f3:	e8 78 69 00 00       	call   80107b70 <copyout>
801011f8:	83 c4 10             	add    $0x10,%esp
801011fb:	85 c0                	test   %eax,%eax
801011fd:	78 99                	js     80101198 <exec+0x258>
  for(last=s=path; *s; s++)
801011ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101202:	8b 55 08             	mov    0x8(%ebp),%edx
80101205:	0f b6 00             	movzbl (%eax),%eax
80101208:	84 c0                	test   %al,%al
8010120a:	74 13                	je     8010121f <exec+0x2df>
8010120c:	89 d1                	mov    %edx,%ecx
8010120e:	66 90                	xchg   %ax,%ax
    if(*s == '/')
80101210:	83 c1 01             	add    $0x1,%ecx
80101213:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101215:	0f b6 01             	movzbl (%ecx),%eax
    if(*s == '/')
80101218:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010121b:	84 c0                	test   %al,%al
8010121d:	75 f1                	jne    80101210 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010121f:	8b bd ec fe ff ff    	mov    -0x114(%ebp),%edi
80101225:	83 ec 04             	sub    $0x4,%esp
80101228:	6a 10                	push   $0x10
8010122a:	89 f8                	mov    %edi,%eax
8010122c:	52                   	push   %edx
8010122d:	83 c0 70             	add    $0x70,%eax
80101230:	50                   	push   %eax
80101231:	e8 4a 3f 00 00       	call   80105180 <safestrcpy>
  curproc->pgdir = pgdir;
80101236:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010123c:	89 f8                	mov    %edi,%eax
8010123e:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->sz = sz;
80101241:	89 30                	mov    %esi,(%eax)
  curproc->pgdir = pgdir;
80101243:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101246:	89 c1                	mov    %eax,%ecx
80101248:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010124e:	8b 40 1c             	mov    0x1c(%eax),%eax
80101251:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101254:	8b 41 1c             	mov    0x1c(%ecx),%eax
80101257:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
8010125a:	89 0c 24             	mov    %ecx,(%esp)
8010125d:	e8 ce 62 00 00       	call   80107530 <switchuvm>
  freevm(oldpgdir);
80101262:	89 3c 24             	mov    %edi,(%esp)
80101265:	e8 86 66 00 00       	call   801078f0 <freevm>
  return 0;
8010126a:	83 c4 10             	add    $0x10,%esp
8010126d:	31 c0                	xor    %eax,%eax
8010126f:	e9 3c fd ff ff       	jmp    80100fb0 <exec+0x70>
    end_op();
80101274:	e8 07 20 00 00       	call   80103280 <end_op>
    cprintf("exec: fail\n");
80101279:	83 ec 0c             	sub    $0xc,%esp
8010127c:	68 d9 7c 10 80       	push   $0x80107cd9
80101281:	e8 2a f4 ff ff       	call   801006b0 <cprintf>
    return -1;
80101286:	83 c4 10             	add    $0x10,%esp
80101289:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010128e:	e9 1d fd ff ff       	jmp    80100fb0 <exec+0x70>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101293:	31 ff                	xor    %edi,%edi
80101295:	be 00 20 00 00       	mov    $0x2000,%esi
8010129a:	e9 39 fe ff ff       	jmp    801010d8 <exec+0x198>
8010129f:	90                   	nop

801012a0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801012a0:	f3 0f 1e fb          	endbr32 
801012a4:	55                   	push   %ebp
801012a5:	89 e5                	mov    %esp,%ebp
801012a7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801012aa:	68 e5 7c 10 80       	push   $0x80107ce5
801012af:	68 80 10 11 80       	push   $0x80111080
801012b4:	e8 77 3a 00 00       	call   80104d30 <initlock>
}
801012b9:	83 c4 10             	add    $0x10,%esp
801012bc:	c9                   	leave  
801012bd:	c3                   	ret    
801012be:	66 90                	xchg   %ax,%ax

801012c0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801012c0:	f3 0f 1e fb          	endbr32 
801012c4:	55                   	push   %ebp
801012c5:	89 e5                	mov    %esp,%ebp
801012c7:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012c8:	bb b4 10 11 80       	mov    $0x801110b4,%ebx
{
801012cd:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801012d0:	68 80 10 11 80       	push   $0x80111080
801012d5:	e8 d6 3b 00 00       	call   80104eb0 <acquire>
801012da:	83 c4 10             	add    $0x10,%esp
801012dd:	eb 0c                	jmp    801012eb <filealloc+0x2b>
801012df:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012e0:	83 c3 18             	add    $0x18,%ebx
801012e3:	81 fb 14 1a 11 80    	cmp    $0x80111a14,%ebx
801012e9:	74 25                	je     80101310 <filealloc+0x50>
    if(f->ref == 0){
801012eb:	8b 43 04             	mov    0x4(%ebx),%eax
801012ee:	85 c0                	test   %eax,%eax
801012f0:	75 ee                	jne    801012e0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801012f2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801012f5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801012fc:	68 80 10 11 80       	push   $0x80111080
80101301:	e8 6a 3c 00 00       	call   80104f70 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101306:	89 d8                	mov    %ebx,%eax
      return f;
80101308:	83 c4 10             	add    $0x10,%esp
}
8010130b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010130e:	c9                   	leave  
8010130f:	c3                   	ret    
  release(&ftable.lock);
80101310:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101313:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101315:	68 80 10 11 80       	push   $0x80111080
8010131a:	e8 51 3c 00 00       	call   80104f70 <release>
}
8010131f:	89 d8                	mov    %ebx,%eax
  return 0;
80101321:	83 c4 10             	add    $0x10,%esp
}
80101324:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101327:	c9                   	leave  
80101328:	c3                   	ret    
80101329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101330 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101330:	f3 0f 1e fb          	endbr32 
80101334:	55                   	push   %ebp
80101335:	89 e5                	mov    %esp,%ebp
80101337:	53                   	push   %ebx
80101338:	83 ec 10             	sub    $0x10,%esp
8010133b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010133e:	68 80 10 11 80       	push   $0x80111080
80101343:	e8 68 3b 00 00       	call   80104eb0 <acquire>
  if(f->ref < 1)
80101348:	8b 43 04             	mov    0x4(%ebx),%eax
8010134b:	83 c4 10             	add    $0x10,%esp
8010134e:	85 c0                	test   %eax,%eax
80101350:	7e 1a                	jle    8010136c <filedup+0x3c>
    panic("filedup");
  f->ref++;
80101352:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101355:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101358:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
8010135b:	68 80 10 11 80       	push   $0x80111080
80101360:	e8 0b 3c 00 00       	call   80104f70 <release>
  return f;
}
80101365:	89 d8                	mov    %ebx,%eax
80101367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010136a:	c9                   	leave  
8010136b:	c3                   	ret    
    panic("filedup");
8010136c:	83 ec 0c             	sub    $0xc,%esp
8010136f:	68 ec 7c 10 80       	push   $0x80107cec
80101374:	e8 17 f0 ff ff       	call   80100390 <panic>
80101379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101380 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101380:	f3 0f 1e fb          	endbr32 
80101384:	55                   	push   %ebp
80101385:	89 e5                	mov    %esp,%ebp
80101387:	57                   	push   %edi
80101388:	56                   	push   %esi
80101389:	53                   	push   %ebx
8010138a:	83 ec 28             	sub    $0x28,%esp
8010138d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80101390:	68 80 10 11 80       	push   $0x80111080
80101395:	e8 16 3b 00 00       	call   80104eb0 <acquire>
  if(f->ref < 1)
8010139a:	8b 53 04             	mov    0x4(%ebx),%edx
8010139d:	83 c4 10             	add    $0x10,%esp
801013a0:	85 d2                	test   %edx,%edx
801013a2:	0f 8e a1 00 00 00    	jle    80101449 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801013a8:	83 ea 01             	sub    $0x1,%edx
801013ab:	89 53 04             	mov    %edx,0x4(%ebx)
801013ae:	75 40                	jne    801013f0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801013b0:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801013b4:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801013b7:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801013b9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801013bf:	8b 73 0c             	mov    0xc(%ebx),%esi
801013c2:	88 45 e7             	mov    %al,-0x19(%ebp)
801013c5:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
801013c8:	68 80 10 11 80       	push   $0x80111080
  ff = *f;
801013cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801013d0:	e8 9b 3b 00 00       	call   80104f70 <release>

  if(ff.type == FD_PIPE)
801013d5:	83 c4 10             	add    $0x10,%esp
801013d8:	83 ff 01             	cmp    $0x1,%edi
801013db:	74 53                	je     80101430 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801013dd:	83 ff 02             	cmp    $0x2,%edi
801013e0:	74 26                	je     80101408 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801013e2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013e5:	5b                   	pop    %ebx
801013e6:	5e                   	pop    %esi
801013e7:	5f                   	pop    %edi
801013e8:	5d                   	pop    %ebp
801013e9:	c3                   	ret    
801013ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&ftable.lock);
801013f0:	c7 45 08 80 10 11 80 	movl   $0x80111080,0x8(%ebp)
}
801013f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fa:	5b                   	pop    %ebx
801013fb:	5e                   	pop    %esi
801013fc:	5f                   	pop    %edi
801013fd:	5d                   	pop    %ebp
    release(&ftable.lock);
801013fe:	e9 6d 3b 00 00       	jmp    80104f70 <release>
80101403:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101407:	90                   	nop
    begin_op();
80101408:	e8 03 1e 00 00       	call   80103210 <begin_op>
    iput(ff.ip);
8010140d:	83 ec 0c             	sub    $0xc,%esp
80101410:	ff 75 e0             	pushl  -0x20(%ebp)
80101413:	e8 38 09 00 00       	call   80101d50 <iput>
    end_op();
80101418:	83 c4 10             	add    $0x10,%esp
}
8010141b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010141e:	5b                   	pop    %ebx
8010141f:	5e                   	pop    %esi
80101420:	5f                   	pop    %edi
80101421:	5d                   	pop    %ebp
    end_op();
80101422:	e9 59 1e 00 00       	jmp    80103280 <end_op>
80101427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010142e:	66 90                	xchg   %ax,%ax
    pipeclose(ff.pipe, ff.writable);
80101430:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101434:	83 ec 08             	sub    $0x8,%esp
80101437:	53                   	push   %ebx
80101438:	56                   	push   %esi
80101439:	e8 a2 25 00 00       	call   801039e0 <pipeclose>
8010143e:	83 c4 10             	add    $0x10,%esp
}
80101441:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101444:	5b                   	pop    %ebx
80101445:	5e                   	pop    %esi
80101446:	5f                   	pop    %edi
80101447:	5d                   	pop    %ebp
80101448:	c3                   	ret    
    panic("fileclose");
80101449:	83 ec 0c             	sub    $0xc,%esp
8010144c:	68 f4 7c 10 80       	push   $0x80107cf4
80101451:	e8 3a ef ff ff       	call   80100390 <panic>
80101456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010145d:	8d 76 00             	lea    0x0(%esi),%esi

80101460 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101460:	f3 0f 1e fb          	endbr32 
80101464:	55                   	push   %ebp
80101465:	89 e5                	mov    %esp,%ebp
80101467:	53                   	push   %ebx
80101468:	83 ec 04             	sub    $0x4,%esp
8010146b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010146e:	83 3b 02             	cmpl   $0x2,(%ebx)
80101471:	75 2d                	jne    801014a0 <filestat+0x40>
    ilock(f->ip);
80101473:	83 ec 0c             	sub    $0xc,%esp
80101476:	ff 73 10             	pushl  0x10(%ebx)
80101479:	e8 a2 07 00 00       	call   80101c20 <ilock>
    stati(f->ip, st);
8010147e:	58                   	pop    %eax
8010147f:	5a                   	pop    %edx
80101480:	ff 75 0c             	pushl  0xc(%ebp)
80101483:	ff 73 10             	pushl  0x10(%ebx)
80101486:	e8 65 0a 00 00       	call   80101ef0 <stati>
    iunlock(f->ip);
8010148b:	59                   	pop    %ecx
8010148c:	ff 73 10             	pushl  0x10(%ebx)
8010148f:	e8 6c 08 00 00       	call   80101d00 <iunlock>
    return 0;
  }
  return -1;
}
80101494:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101497:	83 c4 10             	add    $0x10,%esp
8010149a:	31 c0                	xor    %eax,%eax
}
8010149c:	c9                   	leave  
8010149d:	c3                   	ret    
8010149e:	66 90                	xchg   %ax,%ax
801014a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801014a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801014a8:	c9                   	leave  
801014a9:	c3                   	ret    
801014aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014b0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->readable == 0)
801014c6:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801014ca:	74 64                	je     80101530 <fileread+0x80>
    return -1;
  if(f->type == FD_PIPE)
801014cc:	8b 03                	mov    (%ebx),%eax
801014ce:	83 f8 01             	cmp    $0x1,%eax
801014d1:	74 45                	je     80101518 <fileread+0x68>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801014d3:	83 f8 02             	cmp    $0x2,%eax
801014d6:	75 5f                	jne    80101537 <fileread+0x87>
    ilock(f->ip);
801014d8:	83 ec 0c             	sub    $0xc,%esp
801014db:	ff 73 10             	pushl  0x10(%ebx)
801014de:	e8 3d 07 00 00       	call   80101c20 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801014e3:	57                   	push   %edi
801014e4:	ff 73 14             	pushl  0x14(%ebx)
801014e7:	56                   	push   %esi
801014e8:	ff 73 10             	pushl  0x10(%ebx)
801014eb:	e8 30 0a 00 00       	call   80101f20 <readi>
801014f0:	83 c4 20             	add    $0x20,%esp
801014f3:	89 c6                	mov    %eax,%esi
801014f5:	85 c0                	test   %eax,%eax
801014f7:	7e 03                	jle    801014fc <fileread+0x4c>
      f->off += r;
801014f9:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801014fc:	83 ec 0c             	sub    $0xc,%esp
801014ff:	ff 73 10             	pushl  0x10(%ebx)
80101502:	e8 f9 07 00 00       	call   80101d00 <iunlock>
    return r;
80101507:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
8010150a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010150d:	89 f0                	mov    %esi,%eax
8010150f:	5b                   	pop    %ebx
80101510:	5e                   	pop    %esi
80101511:	5f                   	pop    %edi
80101512:	5d                   	pop    %ebp
80101513:	c3                   	ret    
80101514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return piperead(f->pipe, addr, n);
80101518:	8b 43 0c             	mov    0xc(%ebx),%eax
8010151b:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010151e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101521:	5b                   	pop    %ebx
80101522:	5e                   	pop    %esi
80101523:	5f                   	pop    %edi
80101524:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80101525:	e9 56 26 00 00       	jmp    80103b80 <piperead>
8010152a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101530:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101535:	eb d3                	jmp    8010150a <fileread+0x5a>
  panic("fileread");
80101537:	83 ec 0c             	sub    $0xc,%esp
8010153a:	68 fe 7c 10 80       	push   $0x80107cfe
8010153f:	e8 4c ee ff ff       	call   80100390 <panic>
80101544:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010154b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010154f:	90                   	nop

80101550 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
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
  int r;

  if(f->writable == 0)
80101569:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
8010156d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
80101570:	0f 84 c1 00 00 00    	je     80101637 <filewrite+0xe7>
    return -1;
  if(f->type == FD_PIPE)
80101576:	8b 06                	mov    (%esi),%eax
80101578:	83 f8 01             	cmp    $0x1,%eax
8010157b:	0f 84 c3 00 00 00    	je     80101644 <filewrite+0xf4>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
80101581:	83 f8 02             	cmp    $0x2,%eax
80101584:	0f 85 cc 00 00 00    	jne    80101656 <filewrite+0x106>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
8010158a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
8010158d:	31 ff                	xor    %edi,%edi
    while(i < n){
8010158f:	85 c0                	test   %eax,%eax
80101591:	7f 34                	jg     801015c7 <filewrite+0x77>
80101593:	e9 98 00 00 00       	jmp    80101630 <filewrite+0xe0>
80101598:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010159f:	90                   	nop
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801015a0:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
801015a3:	83 ec 0c             	sub    $0xc,%esp
801015a6:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
801015a9:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801015ac:	e8 4f 07 00 00       	call   80101d00 <iunlock>
      end_op();
801015b1:	e8 ca 1c 00 00       	call   80103280 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801015b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801015b9:	83 c4 10             	add    $0x10,%esp
801015bc:	39 c3                	cmp    %eax,%ebx
801015be:	75 60                	jne    80101620 <filewrite+0xd0>
        panic("short filewrite");
      i += r;
801015c0:	01 df                	add    %ebx,%edi
    while(i < n){
801015c2:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801015c5:	7e 69                	jle    80101630 <filewrite+0xe0>
      int n1 = n - i;
801015c7:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801015ca:	b8 00 06 00 00       	mov    $0x600,%eax
801015cf:	29 fb                	sub    %edi,%ebx
      if(n1 > max)
801015d1:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
801015d7:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
801015da:	e8 31 1c 00 00       	call   80103210 <begin_op>
      ilock(f->ip);
801015df:	83 ec 0c             	sub    $0xc,%esp
801015e2:	ff 76 10             	pushl  0x10(%esi)
801015e5:	e8 36 06 00 00       	call   80101c20 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
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
      iunlock(f->ip);
80101603:	83 ec 0c             	sub    $0xc,%esp
80101606:	ff 76 10             	pushl  0x10(%esi)
80101609:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010160c:	e8 ef 06 00 00       	call   80101d00 <iunlock>
      end_op();
80101611:	e8 6a 1c 00 00       	call   80103280 <end_op>
      if(r < 0)
80101616:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101619:	83 c4 10             	add    $0x10,%esp
8010161c:	85 c0                	test   %eax,%eax
8010161e:	75 17                	jne    80101637 <filewrite+0xe7>
        panic("short filewrite");
80101620:	83 ec 0c             	sub    $0xc,%esp
80101623:	68 07 7d 10 80       	push   $0x80107d07
80101628:	e8 63 ed ff ff       	call   80100390 <panic>
8010162d:	8d 76 00             	lea    0x0(%esi),%esi
    }
    return i == n ? n : -1;
80101630:	89 f8                	mov    %edi,%eax
80101632:	3b 7d e4             	cmp    -0x1c(%ebp),%edi
80101635:	74 05                	je     8010163c <filewrite+0xec>
80101637:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  panic("filewrite");
}
8010163c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010163f:	5b                   	pop    %ebx
80101640:	5e                   	pop    %esi
80101641:	5f                   	pop    %edi
80101642:	5d                   	pop    %ebp
80101643:	c3                   	ret    
    return pipewrite(f->pipe, addr, n);
80101644:	8b 46 0c             	mov    0xc(%esi),%eax
80101647:	89 45 08             	mov    %eax,0x8(%ebp)
}
8010164a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010164d:	5b                   	pop    %ebx
8010164e:	5e                   	pop    %esi
8010164f:	5f                   	pop    %edi
80101650:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101651:	e9 2a 24 00 00       	jmp    80103a80 <pipewrite>
  panic("filewrite");
80101656:	83 ec 0c             	sub    $0xc,%esp
80101659:	68 0d 7d 10 80       	push   $0x80107d0d
8010165e:	e8 2d ed ff ff       	call   80100390 <panic>
80101663:	66 90                	xchg   %ax,%ax
80101665:	66 90                	xchg   %ax,%ax
80101667:	66 90                	xchg   %ax,%ax
80101669:	66 90                	xchg   %ax,%ax
8010166b:	66 90                	xchg   %ax,%ax
8010166d:	66 90                	xchg   %ax,%ax
8010166f:	90                   	nop

80101670 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
80101670:	55                   	push   %ebp
80101671:	89 c1                	mov    %eax,%ecx
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
80101673:	89 d0                	mov    %edx,%eax
80101675:	c1 e8 0c             	shr    $0xc,%eax
80101678:	03 05 98 1a 11 80    	add    0x80111a98,%eax
{
8010167e:	89 e5                	mov    %esp,%ebp
80101680:	56                   	push   %esi
80101681:	53                   	push   %ebx
80101682:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101684:	83 ec 08             	sub    $0x8,%esp
80101687:	50                   	push   %eax
80101688:	51                   	push   %ecx
80101689:	e8 42 ea ff ff       	call   801000d0 <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
8010168e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101690:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101693:	ba 01 00 00 00       	mov    $0x1,%edx
80101698:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
8010169b:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
801016a1:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
801016a4:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
801016a6:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
801016ab:	85 d1                	test   %edx,%ecx
801016ad:	74 25                	je     801016d4 <bfree+0x64>
    panic("freeing free block");
  bp->data[bi/8] &= ~m;
801016af:	f7 d2                	not    %edx
  log_write(bp);
801016b1:	83 ec 0c             	sub    $0xc,%esp
801016b4:	89 c6                	mov    %eax,%esi
  bp->data[bi/8] &= ~m;
801016b6:	21 ca                	and    %ecx,%edx
801016b8:	88 54 18 5c          	mov    %dl,0x5c(%eax,%ebx,1)
  log_write(bp);
801016bc:	50                   	push   %eax
801016bd:	e8 2e 1d 00 00       	call   801033f0 <log_write>
  brelse(bp);
801016c2:	89 34 24             	mov    %esi,(%esp)
801016c5:	e8 26 eb ff ff       	call   801001f0 <brelse>
}
801016ca:	83 c4 10             	add    $0x10,%esp
801016cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016d0:	5b                   	pop    %ebx
801016d1:	5e                   	pop    %esi
801016d2:	5d                   	pop    %ebp
801016d3:	c3                   	ret    
    panic("freeing free block");
801016d4:	83 ec 0c             	sub    $0xc,%esp
801016d7:	68 17 7d 10 80       	push   $0x80107d17
801016dc:	e8 af ec ff ff       	call   80100390 <panic>
801016e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801016ef:	90                   	nop

801016f0 <balloc>:
{
801016f0:	55                   	push   %ebp
801016f1:	89 e5                	mov    %esp,%ebp
801016f3:	57                   	push   %edi
801016f4:	56                   	push   %esi
801016f5:	53                   	push   %ebx
801016f6:	83 ec 1c             	sub    $0x1c,%esp
  for(b = 0; b < sb.size; b += BPB){
801016f9:	8b 0d 80 1a 11 80    	mov    0x80111a80,%ecx
{
801016ff:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101702:	85 c9                	test   %ecx,%ecx
80101704:	0f 84 87 00 00 00    	je     80101791 <balloc+0xa1>
8010170a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101711:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101714:	83 ec 08             	sub    $0x8,%esp
80101717:	89 f0                	mov    %esi,%eax
80101719:	c1 f8 0c             	sar    $0xc,%eax
8010171c:	03 05 98 1a 11 80    	add    0x80111a98,%eax
80101722:	50                   	push   %eax
80101723:	ff 75 d8             	pushl  -0x28(%ebp)
80101726:	e8 a5 e9 ff ff       	call   801000d0 <bread>
8010172b:	83 c4 10             	add    $0x10,%esp
8010172e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101731:	a1 80 1a 11 80       	mov    0x80111a80,%eax
80101736:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101739:	31 c0                	xor    %eax,%eax
8010173b:	eb 2f                	jmp    8010176c <balloc+0x7c>
8010173d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101740:	89 c1                	mov    %eax,%ecx
80101742:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101747:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
8010174a:	83 e1 07             	and    $0x7,%ecx
8010174d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010174f:	89 c1                	mov    %eax,%ecx
80101751:	c1 f9 03             	sar    $0x3,%ecx
80101754:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101759:	89 fa                	mov    %edi,%edx
8010175b:	85 df                	test   %ebx,%edi
8010175d:	74 41                	je     801017a0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010175f:	83 c0 01             	add    $0x1,%eax
80101762:	83 c6 01             	add    $0x1,%esi
80101765:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010176a:	74 05                	je     80101771 <balloc+0x81>
8010176c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010176f:	77 cf                	ja     80101740 <balloc+0x50>
    brelse(bp);
80101771:	83 ec 0c             	sub    $0xc,%esp
80101774:	ff 75 e4             	pushl  -0x1c(%ebp)
80101777:	e8 74 ea ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010177c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
80101783:	83 c4 10             	add    $0x10,%esp
80101786:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101789:	39 05 80 1a 11 80    	cmp    %eax,0x80111a80
8010178f:	77 80                	ja     80101711 <balloc+0x21>
  panic("balloc: out of blocks");
80101791:	83 ec 0c             	sub    $0xc,%esp
80101794:	68 2a 7d 10 80       	push   $0x80107d2a
80101799:	e8 f2 eb ff ff       	call   80100390 <panic>
8010179e:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801017a0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801017a3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801017a6:	09 da                	or     %ebx,%edx
801017a8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801017ac:	57                   	push   %edi
801017ad:	e8 3e 1c 00 00       	call   801033f0 <log_write>
        brelse(bp);
801017b2:	89 3c 24             	mov    %edi,(%esp)
801017b5:	e8 36 ea ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801017ba:	58                   	pop    %eax
801017bb:	5a                   	pop    %edx
801017bc:	56                   	push   %esi
801017bd:	ff 75 d8             	pushl  -0x28(%ebp)
801017c0:	e8 0b e9 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801017c5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801017c8:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801017ca:	8d 40 5c             	lea    0x5c(%eax),%eax
801017cd:	68 00 02 00 00       	push   $0x200
801017d2:	6a 00                	push   $0x0
801017d4:	50                   	push   %eax
801017d5:	e8 e6 37 00 00       	call   80104fc0 <memset>
  log_write(bp);
801017da:	89 1c 24             	mov    %ebx,(%esp)
801017dd:	e8 0e 1c 00 00       	call   801033f0 <log_write>
  brelse(bp);
801017e2:	89 1c 24             	mov    %ebx,(%esp)
801017e5:	e8 06 ea ff ff       	call   801001f0 <brelse>
}
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
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101800:	55                   	push   %ebp
80101801:	89 e5                	mov    %esp,%ebp
80101803:	57                   	push   %edi
80101804:	89 c7                	mov    %eax,%edi
80101806:	56                   	push   %esi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101807:	31 f6                	xor    %esi,%esi
{
80101809:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010180a:	bb d4 1a 11 80       	mov    $0x80111ad4,%ebx
{
8010180f:	83 ec 28             	sub    $0x28,%esp
80101812:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101815:	68 a0 1a 11 80       	push   $0x80111aa0
8010181a:	e8 91 36 00 00       	call   80104eb0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010181f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101822:	83 c4 10             	add    $0x10,%esp
80101825:	eb 1b                	jmp    80101842 <iget+0x42>
80101827:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010182e:	66 90                	xchg   %ax,%ax
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101830:	39 3b                	cmp    %edi,(%ebx)
80101832:	74 6c                	je     801018a0 <iget+0xa0>
80101834:	81 c3 90 00 00 00    	add    $0x90,%ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010183a:	81 fb f4 36 11 80    	cmp    $0x801136f4,%ebx
80101840:	73 26                	jae    80101868 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101842:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101845:	85 c9                	test   %ecx,%ecx
80101847:	7f e7                	jg     80101830 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101849:	85 f6                	test   %esi,%esi
8010184b:	75 e7                	jne    80101834 <iget+0x34>
8010184d:	89 d8                	mov    %ebx,%eax
8010184f:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101855:	85 c9                	test   %ecx,%ecx
80101857:	75 6e                	jne    801018c7 <iget+0xc7>
80101859:	89 c6                	mov    %eax,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010185b:	81 fb f4 36 11 80    	cmp    $0x801136f4,%ebx
80101861:	72 df                	jb     80101842 <iget+0x42>
80101863:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101867:	90                   	nop
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101868:	85 f6                	test   %esi,%esi
8010186a:	74 73                	je     801018df <iget+0xdf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010186c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010186f:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101871:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
80101874:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
8010187b:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
80101882:	68 a0 1a 11 80       	push   $0x80111aa0
80101887:	e8 e4 36 00 00       	call   80104f70 <release>

  return ip;
8010188c:	83 c4 10             	add    $0x10,%esp
}
8010188f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101892:	89 f0                	mov    %esi,%eax
80101894:	5b                   	pop    %ebx
80101895:	5e                   	pop    %esi
80101896:	5f                   	pop    %edi
80101897:	5d                   	pop    %ebp
80101898:	c3                   	ret    
80101899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018a0:	39 53 04             	cmp    %edx,0x4(%ebx)
801018a3:	75 8f                	jne    80101834 <iget+0x34>
      release(&icache.lock);
801018a5:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801018a8:	83 c1 01             	add    $0x1,%ecx
      return ip;
801018ab:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801018ad:	68 a0 1a 11 80       	push   $0x80111aa0
      ip->ref++;
801018b2:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801018b5:	e8 b6 36 00 00       	call   80104f70 <release>
      return ip;
801018ba:	83 c4 10             	add    $0x10,%esp
}
801018bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801018c0:	89 f0                	mov    %esi,%eax
801018c2:	5b                   	pop    %ebx
801018c3:	5e                   	pop    %esi
801018c4:	5f                   	pop    %edi
801018c5:	5d                   	pop    %ebp
801018c6:	c3                   	ret    
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801018c7:	81 fb f4 36 11 80    	cmp    $0x801136f4,%ebx
801018cd:	73 10                	jae    801018df <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018cf:	8b 4b 08             	mov    0x8(%ebx),%ecx
801018d2:	85 c9                	test   %ecx,%ecx
801018d4:	0f 8f 56 ff ff ff    	jg     80101830 <iget+0x30>
801018da:	e9 6e ff ff ff       	jmp    8010184d <iget+0x4d>
    panic("iget: no inodes");
801018df:	83 ec 0c             	sub    $0xc,%esp
801018e2:	68 40 7d 10 80       	push   $0x80107d40
801018e7:	e8 a4 ea ff ff       	call   80100390 <panic>
801018ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801018f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801018f0:	55                   	push   %ebp
801018f1:	89 e5                	mov    %esp,%ebp
801018f3:	57                   	push   %edi
801018f4:	56                   	push   %esi
801018f5:	89 c6                	mov    %eax,%esi
801018f7:	53                   	push   %ebx
801018f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801018fb:	83 fa 0b             	cmp    $0xb,%edx
801018fe:	0f 86 84 00 00 00    	jbe    80101988 <bmap+0x98>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101904:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101907:	83 fb 7f             	cmp    $0x7f,%ebx
8010190a:	0f 87 98 00 00 00    	ja     801019a8 <bmap+0xb8>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101910:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101916:	8b 16                	mov    (%esi),%edx
80101918:	85 c0                	test   %eax,%eax
8010191a:	74 54                	je     80101970 <bmap+0x80>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010191c:	83 ec 08             	sub    $0x8,%esp
8010191f:	50                   	push   %eax
80101920:	52                   	push   %edx
80101921:	e8 aa e7 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101926:	83 c4 10             	add    $0x10,%esp
80101929:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
    bp = bread(ip->dev, addr);
8010192d:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
8010192f:	8b 1a                	mov    (%edx),%ebx
80101931:	85 db                	test   %ebx,%ebx
80101933:	74 1b                	je     80101950 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101935:	83 ec 0c             	sub    $0xc,%esp
80101938:	57                   	push   %edi
80101939:	e8 b2 e8 ff ff       	call   801001f0 <brelse>
    return addr;
8010193e:	83 c4 10             	add    $0x10,%esp
  }

  panic("bmap: out of range");
}
80101941:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101944:	89 d8                	mov    %ebx,%eax
80101946:	5b                   	pop    %ebx
80101947:	5e                   	pop    %esi
80101948:	5f                   	pop    %edi
80101949:	5d                   	pop    %ebp
8010194a:	c3                   	ret    
8010194b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010194f:	90                   	nop
      a[bn] = addr = balloc(ip->dev);
80101950:	8b 06                	mov    (%esi),%eax
80101952:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101955:	e8 96 fd ff ff       	call   801016f0 <balloc>
8010195a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
8010195d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101960:	89 c3                	mov    %eax,%ebx
80101962:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101964:	57                   	push   %edi
80101965:	e8 86 1a 00 00       	call   801033f0 <log_write>
8010196a:	83 c4 10             	add    $0x10,%esp
8010196d:	eb c6                	jmp    80101935 <bmap+0x45>
8010196f:	90                   	nop
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101970:	89 d0                	mov    %edx,%eax
80101972:	e8 79 fd ff ff       	call   801016f0 <balloc>
80101977:	8b 16                	mov    (%esi),%edx
80101979:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
8010197f:	eb 9b                	jmp    8010191c <bmap+0x2c>
80101981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if((addr = ip->addrs[bn]) == 0)
80101988:	8d 3c 90             	lea    (%eax,%edx,4),%edi
8010198b:	8b 5f 5c             	mov    0x5c(%edi),%ebx
8010198e:	85 db                	test   %ebx,%ebx
80101990:	75 af                	jne    80101941 <bmap+0x51>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101992:	8b 00                	mov    (%eax),%eax
80101994:	e8 57 fd ff ff       	call   801016f0 <balloc>
80101999:	89 47 5c             	mov    %eax,0x5c(%edi)
8010199c:	89 c3                	mov    %eax,%ebx
}
8010199e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019a1:	89 d8                	mov    %ebx,%eax
801019a3:	5b                   	pop    %ebx
801019a4:	5e                   	pop    %esi
801019a5:	5f                   	pop    %edi
801019a6:	5d                   	pop    %ebp
801019a7:	c3                   	ret    
  panic("bmap: out of range");
801019a8:	83 ec 0c             	sub    $0xc,%esp
801019ab:	68 50 7d 10 80       	push   $0x80107d50
801019b0:	e8 db e9 ff ff       	call   80100390 <panic>
801019b5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801019bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801019c0 <readsb>:
{
801019c0:	f3 0f 1e fb          	endbr32 
801019c4:	55                   	push   %ebp
801019c5:	89 e5                	mov    %esp,%ebp
801019c7:	56                   	push   %esi
801019c8:	53                   	push   %ebx
801019c9:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801019cc:	83 ec 08             	sub    $0x8,%esp
801019cf:	6a 01                	push   $0x1
801019d1:	ff 75 08             	pushl  0x8(%ebp)
801019d4:	e8 f7 e6 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801019d9:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801019dc:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801019de:	8d 40 5c             	lea    0x5c(%eax),%eax
801019e1:	6a 1c                	push   $0x1c
801019e3:	50                   	push   %eax
801019e4:	56                   	push   %esi
801019e5:	e8 76 36 00 00       	call   80105060 <memmove>
  brelse(bp);
801019ea:	89 5d 08             	mov    %ebx,0x8(%ebp)
801019ed:	83 c4 10             	add    $0x10,%esp
}
801019f0:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019f3:	5b                   	pop    %ebx
801019f4:	5e                   	pop    %esi
801019f5:	5d                   	pop    %ebp
  brelse(bp);
801019f6:	e9 f5 e7 ff ff       	jmp    801001f0 <brelse>
801019fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801019ff:	90                   	nop

80101a00 <iinit>:
{
80101a00:	f3 0f 1e fb          	endbr32 
80101a04:	55                   	push   %ebp
80101a05:	89 e5                	mov    %esp,%ebp
80101a07:	53                   	push   %ebx
80101a08:	bb e0 1a 11 80       	mov    $0x80111ae0,%ebx
80101a0d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101a10:	68 63 7d 10 80       	push   $0x80107d63
80101a15:	68 a0 1a 11 80       	push   $0x80111aa0
80101a1a:	e8 11 33 00 00       	call   80104d30 <initlock>
  for(i = 0; i < NINODE; i++) {
80101a1f:	83 c4 10             	add    $0x10,%esp
80101a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101a28:	83 ec 08             	sub    $0x8,%esp
80101a2b:	68 6a 7d 10 80       	push   $0x80107d6a
80101a30:	53                   	push   %ebx
80101a31:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a37:	e8 b4 31 00 00       	call   80104bf0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101a3c:	83 c4 10             	add    $0x10,%esp
80101a3f:	81 fb 00 37 11 80    	cmp    $0x80113700,%ebx
80101a45:	75 e1                	jne    80101a28 <iinit+0x28>
  readsb(dev, &sb);
80101a47:	83 ec 08             	sub    $0x8,%esp
80101a4a:	68 80 1a 11 80       	push   $0x80111a80
80101a4f:	ff 75 08             	pushl  0x8(%ebp)
80101a52:	e8 69 ff ff ff       	call   801019c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101a57:	ff 35 98 1a 11 80    	pushl  0x80111a98
80101a5d:	ff 35 94 1a 11 80    	pushl  0x80111a94
80101a63:	ff 35 90 1a 11 80    	pushl  0x80111a90
80101a69:	ff 35 8c 1a 11 80    	pushl  0x80111a8c
80101a6f:	ff 35 88 1a 11 80    	pushl  0x80111a88
80101a75:	ff 35 84 1a 11 80    	pushl  0x80111a84
80101a7b:	ff 35 80 1a 11 80    	pushl  0x80111a80
80101a81:	68 d0 7d 10 80       	push   $0x80107dd0
80101a86:	e8 25 ec ff ff       	call   801006b0 <cprintf>
}
80101a8b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a8e:	83 c4 30             	add    $0x30,%esp
80101a91:	c9                   	leave  
80101a92:	c3                   	ret    
80101a93:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101aa0 <ialloc>:
{
80101aa0:	f3 0f 1e fb          	endbr32 
80101aa4:	55                   	push   %ebp
80101aa5:	89 e5                	mov    %esp,%ebp
80101aa7:	57                   	push   %edi
80101aa8:	56                   	push   %esi
80101aa9:	53                   	push   %ebx
80101aaa:	83 ec 1c             	sub    $0x1c,%esp
80101aad:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
80101ab0:	83 3d 88 1a 11 80 01 	cmpl   $0x1,0x80111a88
{
80101ab7:	8b 75 08             	mov    0x8(%ebp),%esi
80101aba:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101abd:	0f 86 8d 00 00 00    	jbe    80101b50 <ialloc+0xb0>
80101ac3:	bf 01 00 00 00       	mov    $0x1,%edi
80101ac8:	eb 1d                	jmp    80101ae7 <ialloc+0x47>
80101aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    brelse(bp);
80101ad0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101ad3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101ad6:	53                   	push   %ebx
80101ad7:	e8 14 e7 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
80101adc:	83 c4 10             	add    $0x10,%esp
80101adf:	3b 3d 88 1a 11 80    	cmp    0x80111a88,%edi
80101ae5:	73 69                	jae    80101b50 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101ae7:	89 f8                	mov    %edi,%eax
80101ae9:	83 ec 08             	sub    $0x8,%esp
80101aec:	c1 e8 03             	shr    $0x3,%eax
80101aef:	03 05 94 1a 11 80    	add    0x80111a94,%eax
80101af5:	50                   	push   %eax
80101af6:	56                   	push   %esi
80101af7:	e8 d4 e5 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
80101afc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
80101aff:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101b01:	89 f8                	mov    %edi,%eax
80101b03:	83 e0 07             	and    $0x7,%eax
80101b06:	c1 e0 06             	shl    $0x6,%eax
80101b09:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
80101b0d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101b11:	75 bd                	jne    80101ad0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101b13:	83 ec 04             	sub    $0x4,%esp
80101b16:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101b19:	6a 40                	push   $0x40
80101b1b:	6a 00                	push   $0x0
80101b1d:	51                   	push   %ecx
80101b1e:	e8 9d 34 00 00       	call   80104fc0 <memset>
      dip->type = type;
80101b23:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101b27:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101b2a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
80101b2d:	89 1c 24             	mov    %ebx,(%esp)
80101b30:	e8 bb 18 00 00       	call   801033f0 <log_write>
      brelse(bp);
80101b35:	89 1c 24             	mov    %ebx,(%esp)
80101b38:	e8 b3 e6 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
80101b3d:	83 c4 10             	add    $0x10,%esp
}
80101b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101b43:	89 fa                	mov    %edi,%edx
}
80101b45:	5b                   	pop    %ebx
      return iget(dev, inum);
80101b46:	89 f0                	mov    %esi,%eax
}
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
      return iget(dev, inum);
80101b4b:	e9 b0 fc ff ff       	jmp    80101800 <iget>
  panic("ialloc: no inodes");
80101b50:	83 ec 0c             	sub    $0xc,%esp
80101b53:	68 70 7d 10 80       	push   $0x80107d70
80101b58:	e8 33 e8 ff ff       	call   80100390 <panic>
80101b5d:	8d 76 00             	lea    0x0(%esi),%esi

80101b60 <iupdate>:
{
80101b60:	f3 0f 1e fb          	endbr32 
80101b64:	55                   	push   %ebp
80101b65:	89 e5                	mov    %esp,%ebp
80101b67:	56                   	push   %esi
80101b68:	53                   	push   %ebx
80101b69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b6c:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b6f:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b72:	83 ec 08             	sub    $0x8,%esp
80101b75:	c1 e8 03             	shr    $0x3,%eax
80101b78:	03 05 94 1a 11 80    	add    0x80111a94,%eax
80101b7e:	50                   	push   %eax
80101b7f:	ff 73 a4             	pushl  -0x5c(%ebx)
80101b82:	e8 49 e5 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101b87:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101b8b:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101b8e:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101b90:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101b93:	83 e0 07             	and    $0x7,%eax
80101b96:	c1 e0 06             	shl    $0x6,%eax
80101b99:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101b9d:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
80101ba0:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101ba4:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101ba7:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101bab:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101baf:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
80101bb3:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101bb7:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101bbb:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101bbe:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101bc1:	6a 34                	push   $0x34
80101bc3:	53                   	push   %ebx
80101bc4:	50                   	push   %eax
80101bc5:	e8 96 34 00 00       	call   80105060 <memmove>
  log_write(bp);
80101bca:	89 34 24             	mov    %esi,(%esp)
80101bcd:	e8 1e 18 00 00       	call   801033f0 <log_write>
  brelse(bp);
80101bd2:	89 75 08             	mov    %esi,0x8(%ebp)
80101bd5:	83 c4 10             	add    $0x10,%esp
}
80101bd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101bdb:	5b                   	pop    %ebx
80101bdc:	5e                   	pop    %esi
80101bdd:	5d                   	pop    %ebp
  brelse(bp);
80101bde:	e9 0d e6 ff ff       	jmp    801001f0 <brelse>
80101be3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101bf0 <idup>:
{
80101bf0:	f3 0f 1e fb          	endbr32 
80101bf4:	55                   	push   %ebp
80101bf5:	89 e5                	mov    %esp,%ebp
80101bf7:	53                   	push   %ebx
80101bf8:	83 ec 10             	sub    $0x10,%esp
80101bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
80101bfe:	68 a0 1a 11 80       	push   $0x80111aa0
80101c03:	e8 a8 32 00 00       	call   80104eb0 <acquire>
  ip->ref++;
80101c08:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c0c:	c7 04 24 a0 1a 11 80 	movl   $0x80111aa0,(%esp)
80101c13:	e8 58 33 00 00       	call   80104f70 <release>
}
80101c18:	89 d8                	mov    %ebx,%eax
80101c1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c1d:	c9                   	leave  
80101c1e:	c3                   	ret    
80101c1f:	90                   	nop

80101c20 <ilock>:
{
80101c20:	f3 0f 1e fb          	endbr32 
80101c24:	55                   	push   %ebp
80101c25:	89 e5                	mov    %esp,%ebp
80101c27:	56                   	push   %esi
80101c28:	53                   	push   %ebx
80101c29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101c2c:	85 db                	test   %ebx,%ebx
80101c2e:	0f 84 b3 00 00 00    	je     80101ce7 <ilock+0xc7>
80101c34:	8b 53 08             	mov    0x8(%ebx),%edx
80101c37:	85 d2                	test   %edx,%edx
80101c39:	0f 8e a8 00 00 00    	jle    80101ce7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101c3f:	83 ec 0c             	sub    $0xc,%esp
80101c42:	8d 43 0c             	lea    0xc(%ebx),%eax
80101c45:	50                   	push   %eax
80101c46:	e8 e5 2f 00 00       	call   80104c30 <acquiresleep>
  if(ip->valid == 0){
80101c4b:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101c4e:	83 c4 10             	add    $0x10,%esp
80101c51:	85 c0                	test   %eax,%eax
80101c53:	74 0b                	je     80101c60 <ilock+0x40>
}
80101c55:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c58:	5b                   	pop    %ebx
80101c59:	5e                   	pop    %esi
80101c5a:	5d                   	pop    %ebp
80101c5b:	c3                   	ret    
80101c5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c60:	8b 43 04             	mov    0x4(%ebx),%eax
80101c63:	83 ec 08             	sub    $0x8,%esp
80101c66:	c1 e8 03             	shr    $0x3,%eax
80101c69:	03 05 94 1a 11 80    	add    0x80111a94,%eax
80101c6f:	50                   	push   %eax
80101c70:	ff 33                	pushl  (%ebx)
80101c72:	e8 59 e4 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c77:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101c7a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101c7c:	8b 43 04             	mov    0x4(%ebx),%eax
80101c7f:	83 e0 07             	and    $0x7,%eax
80101c82:	c1 e0 06             	shl    $0x6,%eax
80101c85:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101c89:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101c8c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101c8f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101c93:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101c97:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101c9b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101c9f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101ca3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101ca7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101cab:	8b 50 fc             	mov    -0x4(%eax),%edx
80101cae:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101cb1:	6a 34                	push   $0x34
80101cb3:	50                   	push   %eax
80101cb4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101cb7:	50                   	push   %eax
80101cb8:	e8 a3 33 00 00       	call   80105060 <memmove>
    brelse(bp);
80101cbd:	89 34 24             	mov    %esi,(%esp)
80101cc0:	e8 2b e5 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101cc5:	83 c4 10             	add    $0x10,%esp
80101cc8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101ccd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101cd4:	0f 85 7b ff ff ff    	jne    80101c55 <ilock+0x35>
      panic("ilock: no type");
80101cda:	83 ec 0c             	sub    $0xc,%esp
80101cdd:	68 88 7d 10 80       	push   $0x80107d88
80101ce2:	e8 a9 e6 ff ff       	call   80100390 <panic>
    panic("ilock");
80101ce7:	83 ec 0c             	sub    $0xc,%esp
80101cea:	68 82 7d 10 80       	push   $0x80107d82
80101cef:	e8 9c e6 ff ff       	call   80100390 <panic>
80101cf4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cfb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101cff:	90                   	nop

80101d00 <iunlock>:
{
80101d00:	f3 0f 1e fb          	endbr32 
80101d04:	55                   	push   %ebp
80101d05:	89 e5                	mov    %esp,%ebp
80101d07:	56                   	push   %esi
80101d08:	53                   	push   %ebx
80101d09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101d0c:	85 db                	test   %ebx,%ebx
80101d0e:	74 28                	je     80101d38 <iunlock+0x38>
80101d10:	83 ec 0c             	sub    $0xc,%esp
80101d13:	8d 73 0c             	lea    0xc(%ebx),%esi
80101d16:	56                   	push   %esi
80101d17:	e8 b4 2f 00 00       	call   80104cd0 <holdingsleep>
80101d1c:	83 c4 10             	add    $0x10,%esp
80101d1f:	85 c0                	test   %eax,%eax
80101d21:	74 15                	je     80101d38 <iunlock+0x38>
80101d23:	8b 43 08             	mov    0x8(%ebx),%eax
80101d26:	85 c0                	test   %eax,%eax
80101d28:	7e 0e                	jle    80101d38 <iunlock+0x38>
  releasesleep(&ip->lock);
80101d2a:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101d2d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d30:	5b                   	pop    %ebx
80101d31:	5e                   	pop    %esi
80101d32:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101d33:	e9 58 2f 00 00       	jmp    80104c90 <releasesleep>
    panic("iunlock");
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	68 97 7d 10 80       	push   $0x80107d97
80101d40:	e8 4b e6 ff ff       	call   80100390 <panic>
80101d45:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101d4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101d50 <iput>:
{
80101d50:	f3 0f 1e fb          	endbr32 
80101d54:	55                   	push   %ebp
80101d55:	89 e5                	mov    %esp,%ebp
80101d57:	57                   	push   %edi
80101d58:	56                   	push   %esi
80101d59:	53                   	push   %ebx
80101d5a:	83 ec 28             	sub    $0x28,%esp
80101d5d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101d60:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101d63:	57                   	push   %edi
80101d64:	e8 c7 2e 00 00       	call   80104c30 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101d69:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101d6c:	83 c4 10             	add    $0x10,%esp
80101d6f:	85 d2                	test   %edx,%edx
80101d71:	74 07                	je     80101d7a <iput+0x2a>
80101d73:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101d78:	74 36                	je     80101db0 <iput+0x60>
  releasesleep(&ip->lock);
80101d7a:	83 ec 0c             	sub    $0xc,%esp
80101d7d:	57                   	push   %edi
80101d7e:	e8 0d 2f 00 00       	call   80104c90 <releasesleep>
  acquire(&icache.lock);
80101d83:	c7 04 24 a0 1a 11 80 	movl   $0x80111aa0,(%esp)
80101d8a:	e8 21 31 00 00       	call   80104eb0 <acquire>
  ip->ref--;
80101d8f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c7 45 08 a0 1a 11 80 	movl   $0x80111aa0,0x8(%ebp)
}
80101d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da0:	5b                   	pop    %ebx
80101da1:	5e                   	pop    %esi
80101da2:	5f                   	pop    %edi
80101da3:	5d                   	pop    %ebp
  release(&icache.lock);
80101da4:	e9 c7 31 00 00       	jmp    80104f70 <release>
80101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	68 a0 1a 11 80       	push   $0x80111aa0
80101db8:	e8 f3 30 00 00       	call   80104eb0 <acquire>
    int r = ip->ref;
80101dbd:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101dc0:	c7 04 24 a0 1a 11 80 	movl   $0x80111aa0,(%esp)
80101dc7:	e8 a4 31 00 00       	call   80104f70 <release>
    if(r == 1){
80101dcc:	83 c4 10             	add    $0x10,%esp
80101dcf:	83 fe 01             	cmp    $0x1,%esi
80101dd2:	75 a6                	jne    80101d7a <iput+0x2a>
80101dd4:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101dda:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101ddd:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101de0:	89 cf                	mov    %ecx,%edi
80101de2:	eb 0b                	jmp    80101def <iput+0x9f>
80101de4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101de8:	83 c6 04             	add    $0x4,%esi
80101deb:	39 fe                	cmp    %edi,%esi
80101ded:	74 19                	je     80101e08 <iput+0xb8>
    if(ip->addrs[i]){
80101def:	8b 16                	mov    (%esi),%edx
80101df1:	85 d2                	test   %edx,%edx
80101df3:	74 f3                	je     80101de8 <iput+0x98>
      bfree(ip->dev, ip->addrs[i]);
80101df5:	8b 03                	mov    (%ebx),%eax
80101df7:	e8 74 f8 ff ff       	call   80101670 <bfree>
      ip->addrs[i] = 0;
80101dfc:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101e02:	eb e4                	jmp    80101de8 <iput+0x98>
80101e04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101e08:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101e0e:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101e11:	85 c0                	test   %eax,%eax
80101e13:	75 33                	jne    80101e48 <iput+0xf8>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101e15:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101e18:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101e1f:	53                   	push   %ebx
80101e20:	e8 3b fd ff ff       	call   80101b60 <iupdate>
      ip->type = 0;
80101e25:	31 c0                	xor    %eax,%eax
80101e27:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101e2b:	89 1c 24             	mov    %ebx,(%esp)
80101e2e:	e8 2d fd ff ff       	call   80101b60 <iupdate>
      ip->valid = 0;
80101e33:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101e3a:	83 c4 10             	add    $0x10,%esp
80101e3d:	e9 38 ff ff ff       	jmp    80101d7a <iput+0x2a>
80101e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101e48:	83 ec 08             	sub    $0x8,%esp
80101e4b:	50                   	push   %eax
80101e4c:	ff 33                	pushl  (%ebx)
80101e4e:	e8 7d e2 ff ff       	call   801000d0 <bread>
80101e53:	89 7d e0             	mov    %edi,-0x20(%ebp)
80101e56:	83 c4 10             	add    $0x10,%esp
80101e59:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101e5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e62:	8d 70 5c             	lea    0x5c(%eax),%esi
80101e65:	89 cf                	mov    %ecx,%edi
80101e67:	eb 0e                	jmp    80101e77 <iput+0x127>
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e70:	83 c6 04             	add    $0x4,%esi
80101e73:	39 f7                	cmp    %esi,%edi
80101e75:	74 19                	je     80101e90 <iput+0x140>
      if(a[j])
80101e77:	8b 16                	mov    (%esi),%edx
80101e79:	85 d2                	test   %edx,%edx
80101e7b:	74 f3                	je     80101e70 <iput+0x120>
        bfree(ip->dev, a[j]);
80101e7d:	8b 03                	mov    (%ebx),%eax
80101e7f:	e8 ec f7 ff ff       	call   80101670 <bfree>
80101e84:	eb ea                	jmp    80101e70 <iput+0x120>
80101e86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101e8d:	8d 76 00             	lea    0x0(%esi),%esi
    brelse(bp);
80101e90:	83 ec 0c             	sub    $0xc,%esp
80101e93:	ff 75 e4             	pushl  -0x1c(%ebp)
80101e96:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101e99:	e8 52 e3 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e9e:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101ea4:	8b 03                	mov    (%ebx),%eax
80101ea6:	e8 c5 f7 ff ff       	call   80101670 <bfree>
    ip->addrs[NDIRECT] = 0;
80101eab:	83 c4 10             	add    $0x10,%esp
80101eae:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101eb5:	00 00 00 
80101eb8:	e9 58 ff ff ff       	jmp    80101e15 <iput+0xc5>
80101ebd:	8d 76 00             	lea    0x0(%esi),%esi

80101ec0 <iunlockput>:
{
80101ec0:	f3 0f 1e fb          	endbr32 
80101ec4:	55                   	push   %ebp
80101ec5:	89 e5                	mov    %esp,%ebp
80101ec7:	53                   	push   %ebx
80101ec8:	83 ec 10             	sub    $0x10,%esp
80101ecb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
80101ece:	53                   	push   %ebx
80101ecf:	e8 2c fe ff ff       	call   80101d00 <iunlock>
  iput(ip);
80101ed4:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101ed7:	83 c4 10             	add    $0x10,%esp
}
80101eda:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101edd:	c9                   	leave  
  iput(ip);
80101ede:	e9 6d fe ff ff       	jmp    80101d50 <iput>
80101ee3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101eea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ef0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ef0:	f3 0f 1e fb          	endbr32 
80101ef4:	55                   	push   %ebp
80101ef5:	89 e5                	mov    %esp,%ebp
80101ef7:	8b 55 08             	mov    0x8(%ebp),%edx
80101efa:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101efd:	8b 0a                	mov    (%edx),%ecx
80101eff:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101f02:	8b 4a 04             	mov    0x4(%edx),%ecx
80101f05:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101f08:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101f0c:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101f0f:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101f13:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101f17:	8b 52 58             	mov    0x58(%edx),%edx
80101f1a:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f1d:	5d                   	pop    %ebp
80101f1e:	c3                   	ret    
80101f1f:	90                   	nop

80101f20 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
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
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f3c:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101f41:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101f44:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101f47:	0f 84 a3 00 00 00    	je     80101ff0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
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
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101f6f:	89 c1                	mov    %eax,%ecx
80101f71:	29 f1                	sub    %esi,%ecx
80101f73:	39 d0                	cmp    %edx,%eax
80101f75:	0f 43 cb             	cmovae %ebx,%ecx
80101f78:	89 4d e4             	mov    %ecx,-0x1c(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101f7b:	85 c9                	test   %ecx,%ecx
80101f7d:	74 63                	je     80101fe2 <readi+0xc2>
80101f7f:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101f80:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101f83:	89 f2                	mov    %esi,%edx
80101f85:	c1 ea 09             	shr    $0x9,%edx
80101f88:	89 d8                	mov    %ebx,%eax
80101f8a:	e8 61 f9 ff ff       	call   801018f0 <bmap>
80101f8f:	83 ec 08             	sub    $0x8,%esp
80101f92:	50                   	push   %eax
80101f93:	ff 33                	pushl  (%ebx)
80101f95:	e8 36 e1 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101f9a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101f9d:	b9 00 02 00 00       	mov    $0x200,%ecx
80101fa2:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fa5:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101fa7:	89 f0                	mov    %esi,%eax
80101fa9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101fae:	29 fb                	sub    %edi,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101fb0:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101fb3:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101fb5:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101fb9:	39 d9                	cmp    %ebx,%ecx
80101fbb:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101fbe:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fbf:	01 df                	add    %ebx,%edi
80101fc1:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101fc3:	50                   	push   %eax
80101fc4:	ff 75 e0             	pushl  -0x20(%ebp)
80101fc7:	e8 94 30 00 00       	call   80105060 <memmove>
    brelse(bp);
80101fcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101fcf:	89 14 24             	mov    %edx,(%esp)
80101fd2:	e8 19 e2 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fd7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101fda:	83 c4 10             	add    $0x10,%esp
80101fdd:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101fe0:	77 9e                	ja     80101f80 <readi+0x60>
  }
  return n;
80101fe2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101fe5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fe8:	5b                   	pop    %ebx
80101fe9:	5e                   	pop    %esi
80101fea:	5f                   	pop    %edi
80101feb:	5d                   	pop    %ebp
80101fec:	c3                   	ret    
80101fed:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101ff0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101ff4:	66 83 f8 09          	cmp    $0x9,%ax
80101ff8:	77 17                	ja     80102011 <readi+0xf1>
80101ffa:	8b 04 c5 20 1a 11 80 	mov    -0x7feee5e0(,%eax,8),%eax
80102001:	85 c0                	test   %eax,%eax
80102003:	74 0c                	je     80102011 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102005:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102008:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010200b:	5b                   	pop    %ebx
8010200c:	5e                   	pop    %esi
8010200d:	5f                   	pop    %edi
8010200e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010200f:	ff e0                	jmp    *%eax
      return -1;
80102011:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102016:	eb cd                	jmp    80101fe5 <readi+0xc5>
80102018:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010201f:	90                   	nop

80102020 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
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
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102036:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
8010203b:	89 75 dc             	mov    %esi,-0x24(%ebp)
8010203e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102041:	8b 75 10             	mov    0x10(%ebp),%esi
80102044:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80102047:	0f 84 b3 00 00 00    	je     80102100 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
8010204d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102050:	39 70 58             	cmp    %esi,0x58(%eax)
80102053:	0f 82 e3 00 00 00    	jb     8010213c <writei+0x11c>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80102059:	8b 7d e0             	mov    -0x20(%ebp),%edi
8010205c:	89 f8                	mov    %edi,%eax
8010205e:	01 f0                	add    %esi,%eax
80102060:	0f 82 d6 00 00 00    	jb     8010213c <writei+0x11c>
80102066:	3d 00 18 01 00       	cmp    $0x11800,%eax
8010206b:	0f 87 cb 00 00 00    	ja     8010213c <writei+0x11c>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102071:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102078:	85 ff                	test   %edi,%edi
8010207a:	74 75                	je     801020f1 <writei+0xd1>
8010207c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102080:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102083:	89 f2                	mov    %esi,%edx
80102085:	c1 ea 09             	shr    $0x9,%edx
80102088:	89 f8                	mov    %edi,%eax
8010208a:	e8 61 f8 ff ff       	call   801018f0 <bmap>
8010208f:	83 ec 08             	sub    $0x8,%esp
80102092:	50                   	push   %eax
80102093:	ff 37                	pushl  (%edi)
80102095:	e8 36 e0 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010209a:	b9 00 02 00 00       	mov    $0x200,%ecx
8010209f:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801020a2:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801020a5:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
801020a7:	89 f0                	mov    %esi,%eax
801020a9:	83 c4 0c             	add    $0xc,%esp
801020ac:	25 ff 01 00 00       	and    $0x1ff,%eax
801020b1:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
801020b3:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
801020b7:	39 d9                	cmp    %ebx,%ecx
801020b9:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
801020bc:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020bd:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
801020bf:	ff 75 dc             	pushl  -0x24(%ebp)
801020c2:	50                   	push   %eax
801020c3:	e8 98 2f 00 00       	call   80105060 <memmove>
    log_write(bp);
801020c8:	89 3c 24             	mov    %edi,(%esp)
801020cb:	e8 20 13 00 00       	call   801033f0 <log_write>
    brelse(bp);
801020d0:	89 3c 24             	mov    %edi,(%esp)
801020d3:	e8 18 e1 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801020d8:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801020db:	83 c4 10             	add    $0x10,%esp
801020de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801020e1:	01 5d dc             	add    %ebx,-0x24(%ebp)
801020e4:	39 45 e0             	cmp    %eax,-0x20(%ebp)
801020e7:	77 97                	ja     80102080 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
801020e9:	8b 45 d8             	mov    -0x28(%ebp),%eax
801020ec:	3b 70 58             	cmp    0x58(%eax),%esi
801020ef:	77 37                	ja     80102128 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
801020f1:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
801020f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020f7:	5b                   	pop    %ebx
801020f8:	5e                   	pop    %esi
801020f9:	5f                   	pop    %edi
801020fa:	5d                   	pop    %ebp
801020fb:	c3                   	ret    
801020fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102100:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102104:	66 83 f8 09          	cmp    $0x9,%ax
80102108:	77 32                	ja     8010213c <writei+0x11c>
8010210a:	8b 04 c5 24 1a 11 80 	mov    -0x7feee5dc(,%eax,8),%eax
80102111:	85 c0                	test   %eax,%eax
80102113:	74 27                	je     8010213c <writei+0x11c>
    return devsw[ip->major].write(ip, src, n);
80102115:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80102118:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010211b:	5b                   	pop    %ebx
8010211c:	5e                   	pop    %esi
8010211d:	5f                   	pop    %edi
8010211e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
8010211f:	ff e0                	jmp    *%eax
80102121:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80102128:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
8010212b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
8010212e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80102131:	50                   	push   %eax
80102132:	e8 29 fa ff ff       	call   80101b60 <iupdate>
80102137:	83 c4 10             	add    $0x10,%esp
8010213a:	eb b5                	jmp    801020f1 <writei+0xd1>
      return -1;
8010213c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102141:	eb b1                	jmp    801020f4 <writei+0xd4>
80102143:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010214a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102150 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102150:	f3 0f 1e fb          	endbr32 
80102154:	55                   	push   %ebp
80102155:	89 e5                	mov    %esp,%ebp
80102157:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
8010215a:	6a 0e                	push   $0xe
8010215c:	ff 75 0c             	pushl  0xc(%ebp)
8010215f:	ff 75 08             	pushl  0x8(%ebp)
80102162:	e8 69 2f 00 00       	call   801050d0 <strncmp>
}
80102167:	c9                   	leave  
80102168:	c3                   	ret    
80102169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102170 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102170:	f3 0f 1e fb          	endbr32 
80102174:	55                   	push   %ebp
80102175:	89 e5                	mov    %esp,%ebp
80102177:	57                   	push   %edi
80102178:	56                   	push   %esi
80102179:	53                   	push   %ebx
8010217a:	83 ec 1c             	sub    $0x1c,%esp
8010217d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102180:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102185:	0f 85 89 00 00 00    	jne    80102214 <dirlookup+0xa4>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
8010218b:	8b 53 58             	mov    0x58(%ebx),%edx
8010218e:	31 ff                	xor    %edi,%edi
80102190:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102193:	85 d2                	test   %edx,%edx
80102195:	74 42                	je     801021d9 <dirlookup+0x69>
80102197:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010219e:	66 90                	xchg   %ax,%ax
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021a0:	6a 10                	push   $0x10
801021a2:	57                   	push   %edi
801021a3:	56                   	push   %esi
801021a4:	53                   	push   %ebx
801021a5:	e8 76 fd ff ff       	call   80101f20 <readi>
801021aa:	83 c4 10             	add    $0x10,%esp
801021ad:	83 f8 10             	cmp    $0x10,%eax
801021b0:	75 55                	jne    80102207 <dirlookup+0x97>
      panic("dirlookup read");
    if(de.inum == 0)
801021b2:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021b7:	74 18                	je     801021d1 <dirlookup+0x61>
  return strncmp(s, t, DIRSIZ);
801021b9:	83 ec 04             	sub    $0x4,%esp
801021bc:	8d 45 da             	lea    -0x26(%ebp),%eax
801021bf:	6a 0e                	push   $0xe
801021c1:	50                   	push   %eax
801021c2:	ff 75 0c             	pushl  0xc(%ebp)
801021c5:	e8 06 2f 00 00       	call   801050d0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
801021ca:	83 c4 10             	add    $0x10,%esp
801021cd:	85 c0                	test   %eax,%eax
801021cf:	74 17                	je     801021e8 <dirlookup+0x78>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021d1:	83 c7 10             	add    $0x10,%edi
801021d4:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021d7:	72 c7                	jb     801021a0 <dirlookup+0x30>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
801021d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801021dc:	31 c0                	xor    %eax,%eax
}
801021de:	5b                   	pop    %ebx
801021df:	5e                   	pop    %esi
801021e0:	5f                   	pop    %edi
801021e1:	5d                   	pop    %ebp
801021e2:	c3                   	ret    
801021e3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021e7:	90                   	nop
      if(poff)
801021e8:	8b 45 10             	mov    0x10(%ebp),%eax
801021eb:	85 c0                	test   %eax,%eax
801021ed:	74 05                	je     801021f4 <dirlookup+0x84>
        *poff = off;
801021ef:	8b 45 10             	mov    0x10(%ebp),%eax
801021f2:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
801021f4:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
801021f8:	8b 03                	mov    (%ebx),%eax
801021fa:	e8 01 f6 ff ff       	call   80101800 <iget>
}
801021ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102202:	5b                   	pop    %ebx
80102203:	5e                   	pop    %esi
80102204:	5f                   	pop    %edi
80102205:	5d                   	pop    %ebp
80102206:	c3                   	ret    
      panic("dirlookup read");
80102207:	83 ec 0c             	sub    $0xc,%esp
8010220a:	68 b1 7d 10 80       	push   $0x80107db1
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 9f 7d 10 80       	push   $0x80107d9f
8010221c:	e8 6f e1 ff ff       	call   80100390 <panic>
80102221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102228:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010222f:	90                   	nop

80102230 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	57                   	push   %edi
80102234:	56                   	push   %esi
80102235:	53                   	push   %ebx
80102236:	89 c3                	mov    %eax,%ebx
80102238:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010223b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010223e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80102241:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102244:	0f 84 86 01 00 00    	je     801023d0 <namex+0x1a0>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010224a:	e8 81 1c 00 00       	call   80103ed0 <myproc>
  acquire(&icache.lock);
8010224f:	83 ec 0c             	sub    $0xc,%esp
80102252:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102254:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80102257:	68 a0 1a 11 80       	push   $0x80111aa0
8010225c:	e8 4f 2c 00 00       	call   80104eb0 <acquire>
  ip->ref++;
80102261:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102265:	c7 04 24 a0 1a 11 80 	movl   $0x80111aa0,(%esp)
8010226c:	e8 ff 2c 00 00       	call   80104f70 <release>
80102271:	83 c4 10             	add    $0x10,%esp
80102274:	eb 0d                	jmp    80102283 <namex+0x53>
80102276:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010227d:	8d 76 00             	lea    0x0(%esi),%esi
    path++;
80102280:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
80102283:	0f b6 07             	movzbl (%edi),%eax
80102286:	3c 2f                	cmp    $0x2f,%al
80102288:	74 f6                	je     80102280 <namex+0x50>
  if(*path == 0)
8010228a:	84 c0                	test   %al,%al
8010228c:	0f 84 ee 00 00 00    	je     80102380 <namex+0x150>
  while(*path != '/' && *path != 0)
80102292:	0f b6 07             	movzbl (%edi),%eax
80102295:	84 c0                	test   %al,%al
80102297:	0f 84 fb 00 00 00    	je     80102398 <namex+0x168>
8010229d:	89 fb                	mov    %edi,%ebx
8010229f:	3c 2f                	cmp    $0x2f,%al
801022a1:	0f 84 f1 00 00 00    	je     80102398 <namex+0x168>
801022a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801022ae:	66 90                	xchg   %ax,%ax
801022b0:	0f b6 43 01          	movzbl 0x1(%ebx),%eax
    path++;
801022b4:	83 c3 01             	add    $0x1,%ebx
  while(*path != '/' && *path != 0)
801022b7:	3c 2f                	cmp    $0x2f,%al
801022b9:	74 04                	je     801022bf <namex+0x8f>
801022bb:	84 c0                	test   %al,%al
801022bd:	75 f1                	jne    801022b0 <namex+0x80>
  len = path - s;
801022bf:	89 d8                	mov    %ebx,%eax
801022c1:	29 f8                	sub    %edi,%eax
  if(len >= DIRSIZ)
801022c3:	83 f8 0d             	cmp    $0xd,%eax
801022c6:	0f 8e 84 00 00 00    	jle    80102350 <namex+0x120>
    memmove(name, s, DIRSIZ);
801022cc:	83 ec 04             	sub    $0x4,%esp
801022cf:	6a 0e                	push   $0xe
801022d1:	57                   	push   %edi
    path++;
801022d2:	89 df                	mov    %ebx,%edi
    memmove(name, s, DIRSIZ);
801022d4:	ff 75 e4             	pushl  -0x1c(%ebp)
801022d7:	e8 84 2d 00 00       	call   80105060 <memmove>
801022dc:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801022df:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801022e2:	75 0c                	jne    801022f0 <namex+0xc0>
801022e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801022e8:	83 c7 01             	add    $0x1,%edi
  while(*path == '/')
801022eb:	80 3f 2f             	cmpb   $0x2f,(%edi)
801022ee:	74 f8                	je     801022e8 <namex+0xb8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	56                   	push   %esi
801022f4:	e8 27 f9 ff ff       	call   80101c20 <ilock>
    if(ip->type != T_DIR){
801022f9:	83 c4 10             	add    $0x10,%esp
801022fc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102301:	0f 85 a1 00 00 00    	jne    801023a8 <namex+0x178>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102307:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010230a:	85 d2                	test   %edx,%edx
8010230c:	74 09                	je     80102317 <namex+0xe7>
8010230e:	80 3f 00             	cmpb   $0x0,(%edi)
80102311:	0f 84 d9 00 00 00    	je     801023f0 <namex+0x1c0>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102317:	83 ec 04             	sub    $0x4,%esp
8010231a:	6a 00                	push   $0x0
8010231c:	ff 75 e4             	pushl  -0x1c(%ebp)
8010231f:	56                   	push   %esi
80102320:	e8 4b fe ff ff       	call   80102170 <dirlookup>
80102325:	83 c4 10             	add    $0x10,%esp
80102328:	89 c3                	mov    %eax,%ebx
8010232a:	85 c0                	test   %eax,%eax
8010232c:	74 7a                	je     801023a8 <namex+0x178>
  iunlock(ip);
8010232e:	83 ec 0c             	sub    $0xc,%esp
80102331:	56                   	push   %esi
80102332:	e8 c9 f9 ff ff       	call   80101d00 <iunlock>
  iput(ip);
80102337:	89 34 24             	mov    %esi,(%esp)
8010233a:	89 de                	mov    %ebx,%esi
8010233c:	e8 0f fa ff ff       	call   80101d50 <iput>
80102341:	83 c4 10             	add    $0x10,%esp
80102344:	e9 3a ff ff ff       	jmp    80102283 <namex+0x53>
80102349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102350:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102353:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
80102356:	89 4d dc             	mov    %ecx,-0x24(%ebp)
    memmove(name, s, len);
80102359:	83 ec 04             	sub    $0x4,%esp
8010235c:	50                   	push   %eax
8010235d:	57                   	push   %edi
    name[len] = 0;
8010235e:	89 df                	mov    %ebx,%edi
    memmove(name, s, len);
80102360:	ff 75 e4             	pushl  -0x1c(%ebp)
80102363:	e8 f8 2c 00 00       	call   80105060 <memmove>
    name[len] = 0;
80102368:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010236b:	83 c4 10             	add    $0x10,%esp
8010236e:	c6 00 00             	movb   $0x0,(%eax)
80102371:	e9 69 ff ff ff       	jmp    801022df <namex+0xaf>
80102376:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010237d:	8d 76 00             	lea    0x0(%esi),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80102380:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102383:	85 c0                	test   %eax,%eax
80102385:	0f 85 85 00 00 00    	jne    80102410 <namex+0x1e0>
    iput(ip);
    return 0;
  }
  return ip;
}
8010238b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010238e:	89 f0                	mov    %esi,%eax
80102390:	5b                   	pop    %ebx
80102391:	5e                   	pop    %esi
80102392:	5f                   	pop    %edi
80102393:	5d                   	pop    %ebp
80102394:	c3                   	ret    
80102395:	8d 76 00             	lea    0x0(%esi),%esi
  while(*path != '/' && *path != 0)
80102398:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010239b:	89 fb                	mov    %edi,%ebx
8010239d:	89 45 dc             	mov    %eax,-0x24(%ebp)
801023a0:	31 c0                	xor    %eax,%eax
801023a2:	eb b5                	jmp    80102359 <namex+0x129>
801023a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
801023a8:	83 ec 0c             	sub    $0xc,%esp
801023ab:	56                   	push   %esi
801023ac:	e8 4f f9 ff ff       	call   80101d00 <iunlock>
  iput(ip);
801023b1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801023b4:	31 f6                	xor    %esi,%esi
  iput(ip);
801023b6:	e8 95 f9 ff ff       	call   80101d50 <iput>
      return 0;
801023bb:	83 c4 10             	add    $0x10,%esp
}
801023be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023c1:	89 f0                	mov    %esi,%eax
801023c3:	5b                   	pop    %ebx
801023c4:	5e                   	pop    %esi
801023c5:	5f                   	pop    %edi
801023c6:	5d                   	pop    %ebp
801023c7:	c3                   	ret    
801023c8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023cf:	90                   	nop
    ip = iget(ROOTDEV, ROOTINO);
801023d0:	ba 01 00 00 00       	mov    $0x1,%edx
801023d5:	b8 01 00 00 00       	mov    $0x1,%eax
801023da:	89 df                	mov    %ebx,%edi
801023dc:	e8 1f f4 ff ff       	call   80101800 <iget>
801023e1:	89 c6                	mov    %eax,%esi
801023e3:	e9 9b fe ff ff       	jmp    80102283 <namex+0x53>
801023e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801023ef:	90                   	nop
      iunlock(ip);
801023f0:	83 ec 0c             	sub    $0xc,%esp
801023f3:	56                   	push   %esi
801023f4:	e8 07 f9 ff ff       	call   80101d00 <iunlock>
      return ip;
801023f9:	83 c4 10             	add    $0x10,%esp
}
801023fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023ff:	89 f0                	mov    %esi,%eax
80102401:	5b                   	pop    %ebx
80102402:	5e                   	pop    %esi
80102403:	5f                   	pop    %edi
80102404:	5d                   	pop    %ebp
80102405:	c3                   	ret    
80102406:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010240d:	8d 76 00             	lea    0x0(%esi),%esi
    iput(ip);
80102410:	83 ec 0c             	sub    $0xc,%esp
80102413:	56                   	push   %esi
    return 0;
80102414:	31 f6                	xor    %esi,%esi
    iput(ip);
80102416:	e8 35 f9 ff ff       	call   80101d50 <iput>
    return 0;
8010241b:	83 c4 10             	add    $0x10,%esp
8010241e:	e9 68 ff ff ff       	jmp    8010238b <namex+0x15b>
80102423:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010242a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102430 <dirlink>:
{
80102430:	f3 0f 1e fb          	endbr32 
80102434:	55                   	push   %ebp
80102435:	89 e5                	mov    %esp,%ebp
80102437:	57                   	push   %edi
80102438:	56                   	push   %esi
80102439:	53                   	push   %ebx
8010243a:	83 ec 20             	sub    $0x20,%esp
8010243d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102440:	6a 00                	push   $0x0
80102442:	ff 75 0c             	pushl  0xc(%ebp)
80102445:	53                   	push   %ebx
80102446:	e8 25 fd ff ff       	call   80102170 <dirlookup>
8010244b:	83 c4 10             	add    $0x10,%esp
8010244e:	85 c0                	test   %eax,%eax
80102450:	75 6b                	jne    801024bd <dirlink+0x8d>
  for(off = 0; off < dp->size; off += sizeof(de)){
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
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102470:	6a 10                	push   $0x10
80102472:	57                   	push   %edi
80102473:	56                   	push   %esi
80102474:	53                   	push   %ebx
80102475:	e8 a6 fa ff ff       	call   80101f20 <readi>
8010247a:	83 c4 10             	add    $0x10,%esp
8010247d:	83 f8 10             	cmp    $0x10,%eax
80102480:	75 4e                	jne    801024d0 <dirlink+0xa0>
    if(de.inum == 0)
80102482:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102487:	75 df                	jne    80102468 <dirlink+0x38>
  strncpy(de.name, name, DIRSIZ);
80102489:	83 ec 04             	sub    $0x4,%esp
8010248c:	8d 45 da             	lea    -0x26(%ebp),%eax
8010248f:	6a 0e                	push   $0xe
80102491:	ff 75 0c             	pushl  0xc(%ebp)
80102494:	50                   	push   %eax
80102495:	e8 86 2c 00 00       	call   80105120 <strncpy>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010249a:	6a 10                	push   $0x10
  de.inum = inum;
8010249c:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
8010249f:	57                   	push   %edi
801024a0:	56                   	push   %esi
801024a1:	53                   	push   %ebx
  de.inum = inum;
801024a2:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801024a6:	e8 75 fb ff ff       	call   80102020 <writei>
801024ab:	83 c4 20             	add    $0x20,%esp
801024ae:	83 f8 10             	cmp    $0x10,%eax
801024b1:	75 2a                	jne    801024dd <dirlink+0xad>
  return 0;
801024b3:	31 c0                	xor    %eax,%eax
}
801024b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024b8:	5b                   	pop    %ebx
801024b9:	5e                   	pop    %esi
801024ba:	5f                   	pop    %edi
801024bb:	5d                   	pop    %ebp
801024bc:	c3                   	ret    
    iput(ip);
801024bd:	83 ec 0c             	sub    $0xc,%esp
801024c0:	50                   	push   %eax
801024c1:	e8 8a f8 ff ff       	call   80101d50 <iput>
    return -1;
801024c6:	83 c4 10             	add    $0x10,%esp
801024c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801024ce:	eb e5                	jmp    801024b5 <dirlink+0x85>
      panic("dirlink read");
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 c0 7d 10 80       	push   $0x80107dc0
801024d8:	e8 b3 de ff ff       	call   80100390 <panic>
    panic("dirlink");
801024dd:	83 ec 0c             	sub    $0xc,%esp
801024e0:	68 96 84 10 80       	push   $0x80108496
801024e5:	e8 a6 de ff ff       	call   80100390 <panic>
801024ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801024f0 <namei>:

struct inode*
namei(char *path)
{
801024f0:	f3 0f 1e fb          	endbr32 
801024f4:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801024f5:	31 d2                	xor    %edx,%edx
{
801024f7:	89 e5                	mov    %esp,%ebp
801024f9:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801024fc:	8b 45 08             	mov    0x8(%ebp),%eax
801024ff:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102502:	e8 29 fd ff ff       	call   80102230 <namex>
}
80102507:	c9                   	leave  
80102508:	c3                   	ret    
80102509:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102510 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102510:	f3 0f 1e fb          	endbr32 
80102514:	55                   	push   %ebp
  return namex(path, 1, name);
80102515:	ba 01 00 00 00       	mov    $0x1,%edx
{
8010251a:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
8010251c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010251f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102522:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102523:	e9 08 fd ff ff       	jmp    80102230 <namex>
80102528:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010252f:	90                   	nop

80102530 <getbmap>:

int getbmap(struct inode* ip, uint n){
80102530:	f3 0f 1e fb          	endbr32 
80102534:	55                   	push   %ebp
80102535:	89 e5                	mov    %esp,%ebp
    return bmap(ip, n);
80102537:	8b 55 0c             	mov    0xc(%ebp),%edx
8010253a:	8b 45 08             	mov    0x8(%ebp),%eax
8010253d:	5d                   	pop    %ebp
    return bmap(ip, n);
8010253e:	e9 ad f3 ff ff       	jmp    801018f0 <bmap>
80102543:	66 90                	xchg   %ax,%ax
80102545:	66 90                	xchg   %ax,%ax
80102547:	66 90                	xchg   %ax,%ax
80102549:	66 90                	xchg   %ax,%ax
8010254b:	66 90                	xchg   %ax,%ax
8010254d:	66 90                	xchg   %ax,%ax
8010254f:	90                   	nop

80102550 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	57                   	push   %edi
80102554:	56                   	push   %esi
80102555:	53                   	push   %ebx
80102556:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102559:	85 c0                	test   %eax,%eax
8010255b:	0f 84 b4 00 00 00    	je     80102615 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102561:	8b 70 08             	mov    0x8(%eax),%esi
80102564:	89 c3                	mov    %eax,%ebx
80102566:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010256c:	0f 87 96 00 00 00    	ja     80102608 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102572:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010257e:	66 90                	xchg   %ax,%ax
80102580:	89 ca                	mov    %ecx,%edx
80102582:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102583:	83 e0 c0             	and    $0xffffffc0,%eax
80102586:	3c 40                	cmp    $0x40,%al
80102588:	75 f6                	jne    80102580 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801025a7:	89 f0                	mov    %esi,%eax
801025a9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801025ae:	c1 f8 08             	sar    $0x8,%eax
801025b1:	ee                   	out    %al,(%dx)
801025b2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801025b7:	89 f8                	mov    %edi,%eax
801025b9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801025ba:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801025be:	ba f6 01 00 00       	mov    $0x1f6,%edx
801025c3:	c1 e0 04             	shl    $0x4,%eax
801025c6:	83 e0 10             	and    $0x10,%eax
801025c9:	83 c8 e0             	or     $0xffffffe0,%eax
801025cc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801025cd:	f6 03 04             	testb  $0x4,(%ebx)
801025d0:	75 16                	jne    801025e8 <idestart+0x98>
801025d2:	b8 20 00 00 00       	mov    $0x20,%eax
801025d7:	89 ca                	mov    %ecx,%edx
801025d9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
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
  asm volatile("cld; rep outsl" :
801025f0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801025f5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801025f8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801025fd:	fc                   	cld    
801025fe:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102600:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102603:	5b                   	pop    %ebx
80102604:	5e                   	pop    %esi
80102605:	5f                   	pop    %edi
80102606:	5d                   	pop    %ebp
80102607:	c3                   	ret    
    panic("incorrect blockno");
80102608:	83 ec 0c             	sub    $0xc,%esp
8010260b:	68 2c 7e 10 80       	push   $0x80107e2c
80102610:	e8 7b dd ff ff       	call   80100390 <panic>
    panic("idestart");
80102615:	83 ec 0c             	sub    $0xc,%esp
80102618:	68 23 7e 10 80       	push   $0x80107e23
8010261d:	e8 6e dd ff ff       	call   80100390 <panic>
80102622:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102630 <ideinit>:
{
80102630:	f3 0f 1e fb          	endbr32 
80102634:	55                   	push   %ebp
80102635:	89 e5                	mov    %esp,%ebp
80102637:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
8010263a:	68 3e 7e 10 80       	push   $0x80107e3e
8010263f:	68 c0 b5 10 80       	push   $0x8010b5c0
80102644:	e8 e7 26 00 00       	call   80104d30 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102649:	58                   	pop    %eax
8010264a:	a1 c0 3d 11 80       	mov    0x80113dc0,%eax
8010264f:	5a                   	pop    %edx
80102650:	83 e8 01             	sub    $0x1,%eax
80102653:	50                   	push   %eax
80102654:	6a 0e                	push   $0xe
80102656:	e8 b5 02 00 00       	call   80102910 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
8010265b:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010265e:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102663:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102667:	90                   	nop
80102668:	ec                   	in     (%dx),%al
80102669:	83 e0 c0             	and    $0xffffffc0,%eax
8010266c:	3c 40                	cmp    $0x40,%al
8010266e:	75 f8                	jne    80102668 <ideinit+0x38>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102670:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102675:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010267a:	ee                   	out    %al,(%dx)
8010267b:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102680:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102685:	eb 0e                	jmp    80102695 <ideinit+0x65>
80102687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010268e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102690:	83 e9 01             	sub    $0x1,%ecx
80102693:	74 0f                	je     801026a4 <ideinit+0x74>
80102695:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102696:	84 c0                	test   %al,%al
80102698:	74 f6                	je     80102690 <ideinit+0x60>
      havedisk1 = 1;
8010269a:	c7 05 a0 b5 10 80 01 	movl   $0x1,0x8010b5a0
801026a1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801026a4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801026a9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801026ae:	ee                   	out    %al,(%dx)
}
801026af:	c9                   	leave  
801026b0:	c3                   	ret    
801026b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026b8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801026bf:	90                   	nop

801026c0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801026c0:	f3 0f 1e fb          	endbr32 
801026c4:	55                   	push   %ebp
801026c5:	89 e5                	mov    %esp,%ebp
801026c7:	57                   	push   %edi
801026c8:	56                   	push   %esi
801026c9:	53                   	push   %ebx
801026ca:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801026cd:	68 c0 b5 10 80       	push   $0x8010b5c0
801026d2:	e8 d9 27 00 00       	call   80104eb0 <acquire>

  if((b = idequeue) == 0){
801026d7:	8b 1d a4 b5 10 80    	mov    0x8010b5a4,%ebx
801026dd:	83 c4 10             	add    $0x10,%esp
801026e0:	85 db                	test   %ebx,%ebx
801026e2:	74 5f                	je     80102743 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801026e4:	8b 43 58             	mov    0x58(%ebx),%eax
801026e7:	a3 a4 b5 10 80       	mov    %eax,0x8010b5a4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801026ec:	8b 33                	mov    (%ebx),%esi
801026ee:	f7 c6 04 00 00 00    	test   $0x4,%esi
801026f4:	75 2b                	jne    80102721 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801026f6:	ba f7 01 00 00       	mov    $0x1f7,%edx
801026fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026ff:	90                   	nop
80102700:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102701:	89 c1                	mov    %eax,%ecx
80102703:	83 e1 c0             	and    $0xffffffc0,%ecx
80102706:	80 f9 40             	cmp    $0x40,%cl
80102709:	75 f5                	jne    80102700 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010270b:	a8 21                	test   $0x21,%al
8010270d:	75 12                	jne    80102721 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010270f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102712:	b9 80 00 00 00       	mov    $0x80,%ecx
80102717:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010271c:	fc                   	cld    
8010271d:	f3 6d                	rep insl (%dx),%es:(%edi)
8010271f:	8b 33                	mov    (%ebx),%esi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102721:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102724:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102727:	83 ce 02             	or     $0x2,%esi
8010272a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010272c:	53                   	push   %ebx
8010272d:	e8 2e 1f 00 00       	call   80104660 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102732:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
80102737:	83 c4 10             	add    $0x10,%esp
8010273a:	85 c0                	test   %eax,%eax
8010273c:	74 05                	je     80102743 <ideintr+0x83>
    idestart(idequeue);
8010273e:	e8 0d fe ff ff       	call   80102550 <idestart>
    release(&idelock);
80102743:	83 ec 0c             	sub    $0xc,%esp
80102746:	68 c0 b5 10 80       	push   $0x8010b5c0
8010274b:	e8 20 28 00 00       	call   80104f70 <release>

  release(&idelock);
}
80102750:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102753:	5b                   	pop    %ebx
80102754:	5e                   	pop    %esi
80102755:	5f                   	pop    %edi
80102756:	5d                   	pop    %ebp
80102757:	c3                   	ret    
80102758:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010275f:	90                   	nop

80102760 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102760:	f3 0f 1e fb          	endbr32 
80102764:	55                   	push   %ebp
80102765:	89 e5                	mov    %esp,%ebp
80102767:	53                   	push   %ebx
80102768:	83 ec 10             	sub    $0x10,%esp
8010276b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010276e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102771:	50                   	push   %eax
80102772:	e8 59 25 00 00       	call   80104cd0 <holdingsleep>
80102777:	83 c4 10             	add    $0x10,%esp
8010277a:	85 c0                	test   %eax,%eax
8010277c:	0f 84 cf 00 00 00    	je     80102851 <iderw+0xf1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102782:	8b 03                	mov    (%ebx),%eax
80102784:	83 e0 06             	and    $0x6,%eax
80102787:	83 f8 02             	cmp    $0x2,%eax
8010278a:	0f 84 b4 00 00 00    	je     80102844 <iderw+0xe4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
80102790:	8b 53 04             	mov    0x4(%ebx),%edx
80102793:	85 d2                	test   %edx,%edx
80102795:	74 0d                	je     801027a4 <iderw+0x44>
80102797:	a1 a0 b5 10 80       	mov    0x8010b5a0,%eax
8010279c:	85 c0                	test   %eax,%eax
8010279e:	0f 84 93 00 00 00    	je     80102837 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 c0 b5 10 80       	push   $0x8010b5c0
801027ac:	e8 ff 26 00 00       	call   80104eb0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027b1:	a1 a4 b5 10 80       	mov    0x8010b5a4,%eax
  b->qnext = 0;
801027b6:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027bd:	83 c4 10             	add    $0x10,%esp
801027c0:	85 c0                	test   %eax,%eax
801027c2:	74 6c                	je     80102830 <iderw+0xd0>
801027c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801027c8:	89 c2                	mov    %eax,%edx
801027ca:	8b 40 58             	mov    0x58(%eax),%eax
801027cd:	85 c0                	test   %eax,%eax
801027cf:	75 f7                	jne    801027c8 <iderw+0x68>
801027d1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801027d4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801027d6:	39 1d a4 b5 10 80    	cmp    %ebx,0x8010b5a4
801027dc:	74 42                	je     80102820 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027de:	8b 03                	mov    (%ebx),%eax
801027e0:	83 e0 06             	and    $0x6,%eax
801027e3:	83 f8 02             	cmp    $0x2,%eax
801027e6:	74 23                	je     8010280b <iderw+0xab>
801027e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801027ef:	90                   	nop
    sleep(b, &idelock);
801027f0:	83 ec 08             	sub    $0x8,%esp
801027f3:	68 c0 b5 10 80       	push   $0x8010b5c0
801027f8:	53                   	push   %ebx
801027f9:	e8 a2 1c 00 00       	call   801044a0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027fe:	8b 03                	mov    (%ebx),%eax
80102800:	83 c4 10             	add    $0x10,%esp
80102803:	83 e0 06             	and    $0x6,%eax
80102806:	83 f8 02             	cmp    $0x2,%eax
80102809:	75 e5                	jne    801027f0 <iderw+0x90>
  }


  release(&idelock);
8010280b:	c7 45 08 c0 b5 10 80 	movl   $0x8010b5c0,0x8(%ebp)
}
80102812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102815:	c9                   	leave  
  release(&idelock);
80102816:	e9 55 27 00 00       	jmp    80104f70 <release>
8010281b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010281f:	90                   	nop
    idestart(b);
80102820:	89 d8                	mov    %ebx,%eax
80102822:	e8 29 fd ff ff       	call   80102550 <idestart>
80102827:	eb b5                	jmp    801027de <iderw+0x7e>
80102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102830:	ba a4 b5 10 80       	mov    $0x8010b5a4,%edx
80102835:	eb 9d                	jmp    801027d4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102837:	83 ec 0c             	sub    $0xc,%esp
8010283a:	68 6d 7e 10 80       	push   $0x80107e6d
8010283f:	e8 4c db ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102844:	83 ec 0c             	sub    $0xc,%esp
80102847:	68 58 7e 10 80       	push   $0x80107e58
8010284c:	e8 3f db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102851:	83 ec 0c             	sub    $0xc,%esp
80102854:	68 42 7e 10 80       	push   $0x80107e42
80102859:	e8 32 db ff ff       	call   80100390 <panic>
8010285e:	66 90                	xchg   %ax,%ax

80102860 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102860:	f3 0f 1e fb          	endbr32 
80102864:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102865:	c7 05 f4 36 11 80 00 	movl   $0xfec00000,0x801136f4
8010286c:	00 c0 fe 
{
8010286f:	89 e5                	mov    %esp,%ebp
80102871:	56                   	push   %esi
80102872:	53                   	push   %ebx
  ioapic->reg = reg;
80102873:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010287a:	00 00 00 
  return ioapic->data;
8010287d:	8b 15 f4 36 11 80    	mov    0x801136f4,%edx
80102883:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102886:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010288c:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102892:	0f b6 15 20 38 11 80 	movzbl 0x80113820,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102899:	c1 ee 10             	shr    $0x10,%esi
8010289c:	89 f0                	mov    %esi,%eax
8010289e:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801028a1:	8b 41 10             	mov    0x10(%ecx),%eax
  id = ioapicread(REG_ID) >> 24;
801028a4:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801028a7:	39 c2                	cmp    %eax,%edx
801028a9:	74 16                	je     801028c1 <ioapicinit+0x61>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801028ab:	83 ec 0c             	sub    $0xc,%esp
801028ae:	68 8c 7e 10 80       	push   $0x80107e8c
801028b3:	e8 f8 dd ff ff       	call   801006b0 <cprintf>
801028b8:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
801028be:	83 c4 10             	add    $0x10,%esp
801028c1:	83 c6 21             	add    $0x21,%esi
{
801028c4:	ba 10 00 00 00       	mov    $0x10,%edx
801028c9:	b8 20 00 00 00       	mov    $0x20,%eax
801028ce:	66 90                	xchg   %ax,%ax
  ioapic->reg = reg;
801028d0:	89 11                	mov    %edx,(%ecx)

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801028d2:	89 c3                	mov    %eax,%ebx
  ioapic->data = data;
801028d4:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
801028da:	83 c0 01             	add    $0x1,%eax
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801028dd:	81 cb 00 00 01 00    	or     $0x10000,%ebx
  ioapic->data = data;
801028e3:	89 59 10             	mov    %ebx,0x10(%ecx)
  ioapic->reg = reg;
801028e6:	8d 5a 01             	lea    0x1(%edx),%ebx
801028e9:	83 c2 02             	add    $0x2,%edx
801028ec:	89 19                	mov    %ebx,(%ecx)
  ioapic->data = data;
801028ee:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
801028f4:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801028fb:	39 f0                	cmp    %esi,%eax
801028fd:	75 d1                	jne    801028d0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801028ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102902:	5b                   	pop    %ebx
80102903:	5e                   	pop    %esi
80102904:	5d                   	pop    %ebp
80102905:	c3                   	ret    
80102906:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010290d:	8d 76 00             	lea    0x0(%esi),%esi

80102910 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102910:	f3 0f 1e fb          	endbr32 
80102914:	55                   	push   %ebp
  ioapic->reg = reg;
80102915:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
{
8010291b:	89 e5                	mov    %esp,%ebp
8010291d:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102920:	8d 50 20             	lea    0x20(%eax),%edx
80102923:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102927:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102929:	8b 0d f4 36 11 80    	mov    0x801136f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010292f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102932:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102935:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102938:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010293a:	a1 f4 36 11 80       	mov    0x801136f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010293f:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
80102942:	89 50 10             	mov    %edx,0x10(%eax)
}
80102945:	5d                   	pop    %ebp
80102946:	c3                   	ret    
80102947:	66 90                	xchg   %ax,%ax
80102949:	66 90                	xchg   %ax,%ax
8010294b:	66 90                	xchg   %ax,%ax
8010294d:	66 90                	xchg   %ax,%ax
8010294f:	90                   	nop

80102950 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102950:	f3 0f 1e fb          	endbr32 
80102954:	55                   	push   %ebp
80102955:	89 e5                	mov    %esp,%ebp
80102957:	53                   	push   %ebx
80102958:	83 ec 04             	sub    $0x4,%esp
8010295b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010295e:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102964:	75 7a                	jne    801029e0 <kfree+0x90>
80102966:	81 fb 68 66 11 80    	cmp    $0x80116668,%ebx
8010296c:	72 72                	jb     801029e0 <kfree+0x90>
8010296e:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102974:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102979:	77 65                	ja     801029e0 <kfree+0x90>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
8010297b:	83 ec 04             	sub    $0x4,%esp
8010297e:	68 00 10 00 00       	push   $0x1000
80102983:	6a 01                	push   $0x1
80102985:	53                   	push   %ebx
80102986:	e8 35 26 00 00       	call   80104fc0 <memset>

  if(kmem.use_lock)
8010298b:	8b 15 34 37 11 80    	mov    0x80113734,%edx
80102991:	83 c4 10             	add    $0x10,%esp
80102994:	85 d2                	test   %edx,%edx
80102996:	75 20                	jne    801029b8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102998:	a1 38 37 11 80       	mov    0x80113738,%eax
8010299d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010299f:	a1 34 37 11 80       	mov    0x80113734,%eax
  kmem.freelist = r;
801029a4:	89 1d 38 37 11 80    	mov    %ebx,0x80113738
  if(kmem.use_lock)
801029aa:	85 c0                	test   %eax,%eax
801029ac:	75 22                	jne    801029d0 <kfree+0x80>
    release(&kmem.lock);
}
801029ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029b1:	c9                   	leave  
801029b2:	c3                   	ret    
801029b3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801029b7:	90                   	nop
    acquire(&kmem.lock);
801029b8:	83 ec 0c             	sub    $0xc,%esp
801029bb:	68 00 37 11 80       	push   $0x80113700
801029c0:	e8 eb 24 00 00       	call   80104eb0 <acquire>
801029c5:	83 c4 10             	add    $0x10,%esp
801029c8:	eb ce                	jmp    80102998 <kfree+0x48>
801029ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029d0:	c7 45 08 00 37 11 80 	movl   $0x80113700,0x8(%ebp)
}
801029d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029da:	c9                   	leave  
    release(&kmem.lock);
801029db:	e9 90 25 00 00       	jmp    80104f70 <release>
    panic("kfree");
801029e0:	83 ec 0c             	sub    $0xc,%esp
801029e3:	68 be 7e 10 80       	push   $0x80107ebe
801029e8:	e8 a3 d9 ff ff       	call   80100390 <panic>
801029ed:	8d 76 00             	lea    0x0(%esi),%esi

801029f0 <freerange>:
{
801029f0:	f3 0f 1e fb          	endbr32 
801029f4:	55                   	push   %ebp
801029f5:	89 e5                	mov    %esp,%ebp
801029f7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
801029f8:	8b 45 08             	mov    0x8(%ebp),%eax
{
801029fb:	8b 75 0c             	mov    0xc(%ebp),%esi
801029fe:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801029ff:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a05:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a0b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a11:	39 de                	cmp    %ebx,%esi
80102a13:	72 1f                	jb     80102a34 <freerange+0x44>
80102a15:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102a18:	83 ec 0c             	sub    $0xc,%esp
80102a1b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a21:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a27:	50                   	push   %eax
80102a28:	e8 23 ff ff ff       	call   80102950 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a2d:	83 c4 10             	add    $0x10,%esp
80102a30:	39 f3                	cmp    %esi,%ebx
80102a32:	76 e4                	jbe    80102a18 <freerange+0x28>
}
80102a34:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102a37:	5b                   	pop    %ebx
80102a38:	5e                   	pop    %esi
80102a39:	5d                   	pop    %ebp
80102a3a:	c3                   	ret    
80102a3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a3f:	90                   	nop

80102a40 <kinit1>:
{
80102a40:	f3 0f 1e fb          	endbr32 
80102a44:	55                   	push   %ebp
80102a45:	89 e5                	mov    %esp,%ebp
80102a47:	56                   	push   %esi
80102a48:	53                   	push   %ebx
80102a49:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102a4c:	83 ec 08             	sub    $0x8,%esp
80102a4f:	68 c4 7e 10 80       	push   $0x80107ec4
80102a54:	68 00 37 11 80       	push   $0x80113700
80102a59:	e8 d2 22 00 00       	call   80104d30 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a61:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a64:	c7 05 34 37 11 80 00 	movl   $0x0,0x80113734
80102a6b:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
80102a6e:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102a74:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a7a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102a80:	39 de                	cmp    %ebx,%esi
80102a82:	72 20                	jb     80102aa4 <kinit1+0x64>
80102a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102a88:	83 ec 0c             	sub    $0xc,%esp
80102a8b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a91:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102a97:	50                   	push   %eax
80102a98:	e8 b3 fe ff ff       	call   80102950 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a9d:	83 c4 10             	add    $0x10,%esp
80102aa0:	39 de                	cmp    %ebx,%esi
80102aa2:	73 e4                	jae    80102a88 <kinit1+0x48>
}
80102aa4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102aa7:	5b                   	pop    %ebx
80102aa8:	5e                   	pop    %esi
80102aa9:	5d                   	pop    %ebp
80102aaa:	c3                   	ret    
80102aab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102aaf:	90                   	nop

80102ab0 <kinit2>:
{
80102ab0:	f3 0f 1e fb          	endbr32 
80102ab4:	55                   	push   %ebp
80102ab5:	89 e5                	mov    %esp,%ebp
80102ab7:	56                   	push   %esi
  p = (char*)PGROUNDUP((uint)vstart);
80102ab8:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102abb:	8b 75 0c             	mov    0xc(%ebp),%esi
80102abe:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102abf:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ac5:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102acb:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ad1:	39 de                	cmp    %ebx,%esi
80102ad3:	72 1f                	jb     80102af4 <kinit2+0x44>
80102ad5:	8d 76 00             	lea    0x0(%esi),%esi
    kfree(p);
80102ad8:	83 ec 0c             	sub    $0xc,%esp
80102adb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102ae1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102ae7:	50                   	push   %eax
80102ae8:	e8 63 fe ff ff       	call   80102950 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102aed:	83 c4 10             	add    $0x10,%esp
80102af0:	39 de                	cmp    %ebx,%esi
80102af2:	73 e4                	jae    80102ad8 <kinit2+0x28>
  kmem.use_lock = 1;
80102af4:	c7 05 34 37 11 80 01 	movl   $0x1,0x80113734
80102afb:	00 00 00 
}
80102afe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b01:	5b                   	pop    %ebx
80102b02:	5e                   	pop    %esi
80102b03:	5d                   	pop    %ebp
80102b04:	c3                   	ret    
80102b05:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b10 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102b10:	f3 0f 1e fb          	endbr32 
  struct run *r;

  if(kmem.use_lock)
80102b14:	a1 34 37 11 80       	mov    0x80113734,%eax
80102b19:	85 c0                	test   %eax,%eax
80102b1b:	75 1b                	jne    80102b38 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b1d:	a1 38 37 11 80       	mov    0x80113738,%eax
  if(r)
80102b22:	85 c0                	test   %eax,%eax
80102b24:	74 0a                	je     80102b30 <kalloc+0x20>
    kmem.freelist = r->next;
80102b26:	8b 10                	mov    (%eax),%edx
80102b28:	89 15 38 37 11 80    	mov    %edx,0x80113738
  if(kmem.use_lock)
80102b2e:	c3                   	ret    
80102b2f:	90                   	nop
    release(&kmem.lock);
  return (char*)r;
}
80102b30:	c3                   	ret    
80102b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
{
80102b38:	55                   	push   %ebp
80102b39:	89 e5                	mov    %esp,%ebp
80102b3b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
80102b3e:	68 00 37 11 80       	push   $0x80113700
80102b43:	e8 68 23 00 00       	call   80104eb0 <acquire>
  r = kmem.freelist;
80102b48:	a1 38 37 11 80       	mov    0x80113738,%eax
  if(r)
80102b4d:	8b 15 34 37 11 80    	mov    0x80113734,%edx
80102b53:	83 c4 10             	add    $0x10,%esp
80102b56:	85 c0                	test   %eax,%eax
80102b58:	74 08                	je     80102b62 <kalloc+0x52>
    kmem.freelist = r->next;
80102b5a:	8b 08                	mov    (%eax),%ecx
80102b5c:	89 0d 38 37 11 80    	mov    %ecx,0x80113738
  if(kmem.use_lock)
80102b62:	85 d2                	test   %edx,%edx
80102b64:	74 16                	je     80102b7c <kalloc+0x6c>
    release(&kmem.lock);
80102b66:	83 ec 0c             	sub    $0xc,%esp
80102b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b6c:	68 00 37 11 80       	push   $0x80113700
80102b71:	e8 fa 23 00 00       	call   80104f70 <release>
  return (char*)r;
80102b76:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102b79:	83 c4 10             	add    $0x10,%esp
}
80102b7c:	c9                   	leave  
80102b7d:	c3                   	ret    
80102b7e:	66 90                	xchg   %ax,%ax

80102b80 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102b80:	f3 0f 1e fb          	endbr32 
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b84:	ba 64 00 00 00       	mov    $0x64,%edx
80102b89:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102b8a:	a8 01                	test   $0x1,%al
80102b8c:	0f 84 be 00 00 00    	je     80102c50 <kbdgetc+0xd0>
{
80102b92:	55                   	push   %ebp
80102b93:	ba 60 00 00 00       	mov    $0x60,%edx
80102b98:	89 e5                	mov    %esp,%ebp
80102b9a:	53                   	push   %ebx
80102b9b:	ec                   	in     (%dx),%al
  return data;
80102b9c:	8b 1d f4 b5 10 80    	mov    0x8010b5f4,%ebx
    return -1;
  data = inb(KBDATAP);
80102ba2:	0f b6 d0             	movzbl %al,%edx

  if(data == 0xE0){
80102ba5:	3c e0                	cmp    $0xe0,%al
80102ba7:	74 57                	je     80102c00 <kbdgetc+0x80>
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102ba9:	89 d9                	mov    %ebx,%ecx
80102bab:	83 e1 40             	and    $0x40,%ecx
80102bae:	84 c0                	test   %al,%al
80102bb0:	78 5e                	js     80102c10 <kbdgetc+0x90>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102bb2:	85 c9                	test   %ecx,%ecx
80102bb4:	74 09                	je     80102bbf <kbdgetc+0x3f>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102bb6:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
80102bb9:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
80102bbc:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102bbf:	0f b6 8a 00 80 10 80 	movzbl -0x7fef8000(%edx),%ecx
  shift ^= togglecode[data];
80102bc6:	0f b6 82 00 7f 10 80 	movzbl -0x7fef8100(%edx),%eax
  shift |= shiftcode[data];
80102bcd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102bcf:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102bd1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102bd3:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
  c = charcode[shift & (CTL | SHIFT)][data];
80102bd9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102bdc:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102bdf:	8b 04 85 e0 7e 10 80 	mov    -0x7fef8120(,%eax,4),%eax
80102be6:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
80102bea:	74 0b                	je     80102bf7 <kbdgetc+0x77>
    if('a' <= c && c <= 'z')
80102bec:	8d 50 9f             	lea    -0x61(%eax),%edx
80102bef:	83 fa 19             	cmp    $0x19,%edx
80102bf2:	77 44                	ja     80102c38 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102bf4:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102bf7:	5b                   	pop    %ebx
80102bf8:	5d                   	pop    %ebp
80102bf9:	c3                   	ret    
80102bfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    shift |= E0ESC;
80102c00:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102c03:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102c05:	89 1d f4 b5 10 80    	mov    %ebx,0x8010b5f4
}
80102c0b:	5b                   	pop    %ebx
80102c0c:	5d                   	pop    %ebp
80102c0d:	c3                   	ret    
80102c0e:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
80102c10:	83 e0 7f             	and    $0x7f,%eax
80102c13:	85 c9                	test   %ecx,%ecx
80102c15:	0f 44 d0             	cmove  %eax,%edx
    return 0;
80102c18:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
80102c1a:	0f b6 8a 00 80 10 80 	movzbl -0x7fef8000(%edx),%ecx
80102c21:	83 c9 40             	or     $0x40,%ecx
80102c24:	0f b6 c9             	movzbl %cl,%ecx
80102c27:	f7 d1                	not    %ecx
80102c29:	21 d9                	and    %ebx,%ecx
}
80102c2b:	5b                   	pop    %ebx
80102c2c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102c2d:	89 0d f4 b5 10 80    	mov    %ecx,0x8010b5f4
}
80102c33:	c3                   	ret    
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102c38:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102c3b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102c3e:	5b                   	pop    %ebx
80102c3f:	5d                   	pop    %ebp
      c += 'a' - 'A';
80102c40:	83 f9 1a             	cmp    $0x1a,%ecx
80102c43:	0f 42 c2             	cmovb  %edx,%eax
}
80102c46:	c3                   	ret    
80102c47:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c4e:	66 90                	xchg   %ax,%ax
    return -1;
80102c50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102c55:	c3                   	ret    
80102c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c5d:	8d 76 00             	lea    0x0(%esi),%esi

80102c60 <kbdintr>:

void
kbdintr(void)
{
80102c60:	f3 0f 1e fb          	endbr32 
80102c64:	55                   	push   %ebp
80102c65:	89 e5                	mov    %esp,%ebp
80102c67:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102c6a:	68 80 2b 10 80       	push   $0x80102b80
80102c6f:	e8 ec de ff ff       	call   80100b60 <consoleintr>
}
80102c74:	83 c4 10             	add    $0x10,%esp
80102c77:	c9                   	leave  
80102c78:	c3                   	ret    
80102c79:	66 90                	xchg   %ax,%ax
80102c7b:	66 90                	xchg   %ax,%ax
80102c7d:	66 90                	xchg   %ax,%ax
80102c7f:	90                   	nop

80102c80 <lapicinit>:
  lapic[ID];  // wait for write to finish, by reading
}

void
lapicinit(void)
{
80102c80:	f3 0f 1e fb          	endbr32 
  if(!lapic)
80102c84:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80102c89:	85 c0                	test   %eax,%eax
80102c8b:	0f 84 c7 00 00 00    	je     80102d58 <lapicinit+0xd8>
  lapic[index] = value;
80102c91:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102c98:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c9b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c9e:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102ca5:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ca8:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cab:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102cb2:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102cb5:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cb8:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102cbf:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102cc2:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cc5:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102ccc:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102ccf:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cd2:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102cd9:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102cdc:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102cdf:	8b 50 30             	mov    0x30(%eax),%edx
80102ce2:	c1 ea 10             	shr    $0x10,%edx
80102ce5:	81 e2 fc 00 00 00    	and    $0xfc,%edx
80102ceb:	75 73                	jne    80102d60 <lapicinit+0xe0>
  lapic[index] = value;
80102ced:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102cf4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102cf7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102cfa:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d01:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d04:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d07:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102d0e:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d11:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d14:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102d1b:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d21:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102d28:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d2b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102d2e:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102d35:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102d38:	8b 50 20             	mov    0x20(%eax),%edx
80102d3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d3f:	90                   	nop
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102d40:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102d46:	80 e6 10             	and    $0x10,%dh
80102d49:	75 f5                	jne    80102d40 <lapicinit+0xc0>
  lapic[index] = value;
80102d4b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102d52:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102d55:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102d58:	c3                   	ret    
80102d59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102d60:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102d67:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102d6a:	8b 50 20             	mov    0x20(%eax),%edx
}
80102d6d:	e9 7b ff ff ff       	jmp    80102ced <lapicinit+0x6d>
80102d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d80 <lapicid>:

int
lapicid(void)
{
80102d80:	f3 0f 1e fb          	endbr32 
  if (!lapic)
80102d84:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80102d89:	85 c0                	test   %eax,%eax
80102d8b:	74 0b                	je     80102d98 <lapicid+0x18>
    return 0;
  return lapic[ID] >> 24;
80102d8d:	8b 40 20             	mov    0x20(%eax),%eax
80102d90:	c1 e8 18             	shr    $0x18,%eax
80102d93:	c3                   	ret    
80102d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return 0;
80102d98:	31 c0                	xor    %eax,%eax
}
80102d9a:	c3                   	ret    
80102d9b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d9f:	90                   	nop

80102da0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80102da0:	f3 0f 1e fb          	endbr32 
  if(lapic)
80102da4:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80102da9:	85 c0                	test   %eax,%eax
80102dab:	74 0d                	je     80102dba <lapiceoi+0x1a>
  lapic[index] = value;
80102dad:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102db4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102db7:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102dba:	c3                   	ret    
80102dbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102dbf:	90                   	nop

80102dc0 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102dc0:	f3 0f 1e fb          	endbr32 
}
80102dc4:	c3                   	ret    
80102dc5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102dd0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102dd0:	f3 0f 1e fb          	endbr32 
80102dd4:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102df4:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80102df6:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102df9:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102dff:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e01:	c1 e9 0c             	shr    $0xc,%ecx
  lapicw(ICRHI, apicid<<24);
80102e04:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102e06:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102e09:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102e0c:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102e12:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80102e17:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e1d:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e20:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102e27:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e2a:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e2d:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102e34:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102e37:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e3a:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e40:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e43:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e49:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102e4c:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102e52:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102e55:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
    microdelay(200);
  }
}
80102e5b:	5b                   	pop    %ebx
  lapic[ID];  // wait for write to finish, by reading
80102e5c:	8b 40 20             	mov    0x20(%eax),%eax
}
80102e5f:	5d                   	pop    %ebp
80102e60:	c3                   	ret    
80102e61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e6f:	90                   	nop

80102e70 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e88:	ba 71 00 00 00       	mov    $0x71,%edx
80102e8d:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102e8e:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102e91:	bb 70 00 00 00       	mov    $0x70,%ebx
80102e96:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102ea0:	31 c0                	xor    %eax,%eax
80102ea2:	89 da                	mov    %ebx,%edx
80102ea4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ea5:	b9 71 00 00 00       	mov    $0x71,%ecx
80102eaa:	89 ca                	mov    %ecx,%edx
80102eac:	ec                   	in     (%dx),%al
80102ead:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eb0:	89 da                	mov    %ebx,%edx
80102eb2:	b8 02 00 00 00       	mov    $0x2,%eax
80102eb7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eb8:	89 ca                	mov    %ecx,%edx
80102eba:	ec                   	in     (%dx),%al
80102ebb:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ebe:	89 da                	mov    %ebx,%edx
80102ec0:	b8 04 00 00 00       	mov    $0x4,%eax
80102ec5:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ec6:	89 ca                	mov    %ecx,%edx
80102ec8:	ec                   	in     (%dx),%al
80102ec9:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ecc:	89 da                	mov    %ebx,%edx
80102ece:	b8 07 00 00 00       	mov    $0x7,%eax
80102ed3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ed4:	89 ca                	mov    %ecx,%edx
80102ed6:	ec                   	in     (%dx),%al
80102ed7:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eda:	89 da                	mov    %ebx,%edx
80102edc:	b8 08 00 00 00       	mov    $0x8,%eax
80102ee1:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ee2:	89 ca                	mov    %ecx,%edx
80102ee4:	ec                   	in     (%dx),%al
80102ee5:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ee7:	89 da                	mov    %ebx,%edx
80102ee9:	b8 09 00 00 00       	mov    $0x9,%eax
80102eee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102eef:	89 ca                	mov    %ecx,%edx
80102ef1:	ec                   	in     (%dx),%al
80102ef2:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ef4:	89 da                	mov    %ebx,%edx
80102ef6:	b8 0a 00 00 00       	mov    $0xa,%eax
80102efb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102efc:	89 ca                	mov    %ecx,%edx
80102efe:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102eff:	84 c0                	test   %al,%al
80102f01:	78 9d                	js     80102ea0 <cmostime+0x30>
  return inb(CMOS_RETURN);
80102f03:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102f07:	89 fa                	mov    %edi,%edx
80102f09:	0f b6 fa             	movzbl %dl,%edi
80102f0c:	89 f2                	mov    %esi,%edx
80102f0e:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102f11:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102f15:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
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
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f34:	89 ca                	mov    %ecx,%edx
80102f36:	ec                   	in     (%dx),%al
80102f37:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f3a:	89 da                	mov    %ebx,%edx
80102f3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102f3f:	b8 02 00 00 00       	mov    $0x2,%eax
80102f44:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f45:	89 ca                	mov    %ecx,%edx
80102f47:	ec                   	in     (%dx),%al
80102f48:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f4b:	89 da                	mov    %ebx,%edx
80102f4d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102f50:	b8 04 00 00 00       	mov    $0x4,%eax
80102f55:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f56:	89 ca                	mov    %ecx,%edx
80102f58:	ec                   	in     (%dx),%al
80102f59:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f5c:	89 da                	mov    %ebx,%edx
80102f5e:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102f61:	b8 07 00 00 00       	mov    $0x7,%eax
80102f66:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f67:	89 ca                	mov    %ecx,%edx
80102f69:	ec                   	in     (%dx),%al
80102f6a:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f6d:	89 da                	mov    %ebx,%edx
80102f6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102f72:	b8 08 00 00 00       	mov    $0x8,%eax
80102f77:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f78:	89 ca                	mov    %ecx,%edx
80102f7a:	ec                   	in     (%dx),%al
80102f7b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f7e:	89 da                	mov    %ebx,%edx
80102f80:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102f83:	b8 09 00 00 00       	mov    $0x9,%eax
80102f88:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102f89:	89 ca                	mov    %ecx,%edx
80102f8b:	ec                   	in     (%dx),%al
80102f8c:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102f8f:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102f92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102f95:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102f98:	6a 18                	push   $0x18
80102f9a:	50                   	push   %eax
80102f9b:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102f9e:	50                   	push   %eax
80102f9f:	e8 6c 20 00 00       	call   80105010 <memcmp>
80102fa4:	83 c4 10             	add    $0x10,%esp
80102fa7:	85 c0                	test   %eax,%eax
80102fa9:	0f 85 f1 fe ff ff    	jne    80102ea0 <cmostime+0x30>
      break;
  }

  // convert
  if(bcd) {
80102faf:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
80102fb3:	75 78                	jne    8010302d <cmostime+0x1bd>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102fb5:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102fb8:	89 c2                	mov    %eax,%edx
80102fba:	83 e0 0f             	and    $0xf,%eax
80102fbd:	c1 ea 04             	shr    $0x4,%edx
80102fc0:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fc3:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fc6:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102fc9:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102fcc:	89 c2                	mov    %eax,%edx
80102fce:	83 e0 0f             	and    $0xf,%eax
80102fd1:	c1 ea 04             	shr    $0x4,%edx
80102fd4:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fd7:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fda:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102fdd:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102fe0:	89 c2                	mov    %eax,%edx
80102fe2:	83 e0 0f             	and    $0xf,%eax
80102fe5:	c1 ea 04             	shr    $0x4,%edx
80102fe8:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102feb:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102fee:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102ff1:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102ff4:	89 c2                	mov    %eax,%edx
80102ff6:	83 e0 0f             	and    $0xf,%eax
80102ff9:	c1 ea 04             	shr    $0x4,%edx
80102ffc:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102fff:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103002:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103005:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103008:	89 c2                	mov    %eax,%edx
8010300a:	83 e0 0f             	and    $0xf,%eax
8010300d:	c1 ea 04             	shr    $0x4,%edx
80103010:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103013:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103016:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103019:	8b 45 cc             	mov    -0x34(%ebp),%eax
8010301c:	89 c2                	mov    %eax,%edx
8010301e:	83 e0 0f             	and    $0xf,%eax
80103021:	c1 ea 04             	shr    $0x4,%edx
80103024:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103027:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010302a:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
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
  r->year += 2000;
80103053:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
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
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103070:	8b 0d 88 37 11 80    	mov    0x80113788,%ecx
80103076:	85 c9                	test   %ecx,%ecx
80103078:	0f 8e 8a 00 00 00    	jle    80103108 <install_trans+0x98>
{
8010307e:	55                   	push   %ebp
8010307f:	89 e5                	mov    %esp,%ebp
80103081:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80103082:	31 ff                	xor    %edi,%edi
{
80103084:	56                   	push   %esi
80103085:	53                   	push   %ebx
80103086:	83 ec 0c             	sub    $0xc,%esp
80103089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103090:	a1 74 37 11 80       	mov    0x80113774,%eax
80103095:	83 ec 08             	sub    $0x8,%esp
80103098:	01 f8                	add    %edi,%eax
8010309a:	83 c0 01             	add    $0x1,%eax
8010309d:	50                   	push   %eax
8010309e:	ff 35 84 37 11 80    	pushl  0x80113784
801030a4:	e8 27 d0 ff ff       	call   801000d0 <bread>
801030a9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030ab:	58                   	pop    %eax
801030ac:	5a                   	pop    %edx
801030ad:	ff 34 bd 8c 37 11 80 	pushl  -0x7feec874(,%edi,4)
801030b4:	ff 35 84 37 11 80    	pushl  0x80113784
  for (tail = 0; tail < log.lh.n; tail++) {
801030ba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030bd:	e8 0e d0 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030c2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030c5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801030c7:	8d 46 5c             	lea    0x5c(%esi),%eax
801030ca:	68 00 02 00 00       	push   $0x200
801030cf:	50                   	push   %eax
801030d0:	8d 43 5c             	lea    0x5c(%ebx),%eax
801030d3:	50                   	push   %eax
801030d4:	e8 87 1f 00 00       	call   80105060 <memmove>
    bwrite(dbuf);  // write dst to disk
801030d9:	89 1c 24             	mov    %ebx,(%esp)
801030dc:	e8 cf d0 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
801030e1:	89 34 24             	mov    %esi,(%esp)
801030e4:	e8 07 d1 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
801030e9:	89 1c 24             	mov    %ebx,(%esp)
801030ec:	e8 ff d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
801030f1:	83 c4 10             	add    $0x10,%esp
801030f4:	39 3d 88 37 11 80    	cmp    %edi,0x80113788
801030fa:	7f 94                	jg     80103090 <install_trans+0x20>
  }
}
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
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103110:	55                   	push   %ebp
80103111:	89 e5                	mov    %esp,%ebp
80103113:	53                   	push   %ebx
80103114:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103117:	ff 35 74 37 11 80    	pushl  0x80113774
8010311d:	ff 35 84 37 11 80    	pushl  0x80113784
80103123:	e8 a8 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103128:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010312b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010312d:	a1 88 37 11 80       	mov    0x80113788,%eax
80103132:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103135:	85 c0                	test   %eax,%eax
80103137:	7e 19                	jle    80103152 <write_head+0x42>
80103139:	31 d2                	xor    %edx,%edx
8010313b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010313f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103140:	8b 0c 95 8c 37 11 80 	mov    -0x7feec874(,%edx,4),%ecx
80103147:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010314b:	83 c2 01             	add    $0x1,%edx
8010314e:	39 d0                	cmp    %edx,%eax
80103150:	75 ee                	jne    80103140 <write_head+0x30>
  }
  bwrite(buf);
80103152:	83 ec 0c             	sub    $0xc,%esp
80103155:	53                   	push   %ebx
80103156:	e8 55 d0 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
8010315b:	89 1c 24             	mov    %ebx,(%esp)
8010315e:	e8 8d d0 ff ff       	call   801001f0 <brelse>
}
80103163:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103166:	83 c4 10             	add    $0x10,%esp
80103169:	c9                   	leave  
8010316a:	c3                   	ret    
8010316b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010316f:	90                   	nop

80103170 <initlog>:
{
80103170:	f3 0f 1e fb          	endbr32 
80103174:	55                   	push   %ebp
80103175:	89 e5                	mov    %esp,%ebp
80103177:	53                   	push   %ebx
80103178:	83 ec 2c             	sub    $0x2c,%esp
8010317b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
8010317e:	68 00 81 10 80       	push   $0x80108100
80103183:	68 40 37 11 80       	push   $0x80113740
80103188:	e8 a3 1b 00 00       	call   80104d30 <initlock>
  readsb(dev, &sb);
8010318d:	58                   	pop    %eax
8010318e:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103191:	5a                   	pop    %edx
80103192:	50                   	push   %eax
80103193:	53                   	push   %ebx
80103194:	e8 27 e8 ff ff       	call   801019c0 <readsb>
  log.start = sb.logstart;
80103199:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
8010319c:	59                   	pop    %ecx
  log.dev = dev;
8010319d:	89 1d 84 37 11 80    	mov    %ebx,0x80113784
  log.size = sb.nlog;
801031a3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801031a6:	a3 74 37 11 80       	mov    %eax,0x80113774
  log.size = sb.nlog;
801031ab:	89 15 78 37 11 80    	mov    %edx,0x80113778
  struct buf *buf = bread(log.dev, log.start);
801031b1:	5a                   	pop    %edx
801031b2:	50                   	push   %eax
801031b3:	53                   	push   %ebx
801031b4:	e8 17 cf ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801031b9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801031bc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801031bf:	89 0d 88 37 11 80    	mov    %ecx,0x80113788
  for (i = 0; i < log.lh.n; i++) {
801031c5:	85 c9                	test   %ecx,%ecx
801031c7:	7e 19                	jle    801031e2 <initlog+0x72>
801031c9:	31 d2                	xor    %edx,%edx
801031cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031cf:	90                   	nop
    log.lh.block[i] = lh->block[i];
801031d0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801031d4:	89 1c 95 8c 37 11 80 	mov    %ebx,-0x7feec874(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801031db:	83 c2 01             	add    $0x1,%edx
801031de:	39 d1                	cmp    %edx,%ecx
801031e0:	75 ee                	jne    801031d0 <initlog+0x60>
  brelse(buf);
801031e2:	83 ec 0c             	sub    $0xc,%esp
801031e5:	50                   	push   %eax
801031e6:	e8 05 d0 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
801031eb:	e8 80 fe ff ff       	call   80103070 <install_trans>
  log.lh.n = 0;
801031f0:	c7 05 88 37 11 80 00 	movl   $0x0,0x80113788
801031f7:	00 00 00 
  write_head(); // clear the log
801031fa:	e8 11 ff ff ff       	call   80103110 <write_head>
}
801031ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103202:	83 c4 10             	add    $0x10,%esp
80103205:	c9                   	leave  
80103206:	c3                   	ret    
80103207:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010320e:	66 90                	xchg   %ax,%ax

80103210 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103210:	f3 0f 1e fb          	endbr32 
80103214:	55                   	push   %ebp
80103215:	89 e5                	mov    %esp,%ebp
80103217:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
8010321a:	68 40 37 11 80       	push   $0x80113740
8010321f:	e8 8c 1c 00 00       	call   80104eb0 <acquire>
80103224:	83 c4 10             	add    $0x10,%esp
80103227:	eb 1c                	jmp    80103245 <begin_op+0x35>
80103229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103230:	83 ec 08             	sub    $0x8,%esp
80103233:	68 40 37 11 80       	push   $0x80113740
80103238:	68 40 37 11 80       	push   $0x80113740
8010323d:	e8 5e 12 00 00       	call   801044a0 <sleep>
80103242:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103245:	a1 80 37 11 80       	mov    0x80113780,%eax
8010324a:	85 c0                	test   %eax,%eax
8010324c:	75 e2                	jne    80103230 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010324e:	a1 7c 37 11 80       	mov    0x8011377c,%eax
80103253:	8b 15 88 37 11 80    	mov    0x80113788,%edx
80103259:	83 c0 01             	add    $0x1,%eax
8010325c:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
8010325f:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103262:	83 fa 1e             	cmp    $0x1e,%edx
80103265:	7f c9                	jg     80103230 <begin_op+0x20>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103267:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
8010326a:	a3 7c 37 11 80       	mov    %eax,0x8011377c
      release(&log.lock);
8010326f:	68 40 37 11 80       	push   $0x80113740
80103274:	e8 f7 1c 00 00       	call   80104f70 <release>
      break;
    }
  }
}
80103279:	83 c4 10             	add    $0x10,%esp
8010327c:	c9                   	leave  
8010327d:	c3                   	ret    
8010327e:	66 90                	xchg   %ax,%ax

80103280 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103280:	f3 0f 1e fb          	endbr32 
80103284:	55                   	push   %ebp
80103285:	89 e5                	mov    %esp,%ebp
80103287:	57                   	push   %edi
80103288:	56                   	push   %esi
80103289:	53                   	push   %ebx
8010328a:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
8010328d:	68 40 37 11 80       	push   $0x80113740
80103292:	e8 19 1c 00 00       	call   80104eb0 <acquire>
  log.outstanding -= 1;
80103297:	a1 7c 37 11 80       	mov    0x8011377c,%eax
  if(log.committing)
8010329c:	8b 35 80 37 11 80    	mov    0x80113780,%esi
801032a2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801032a5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032a8:	89 1d 7c 37 11 80    	mov    %ebx,0x8011377c
  if(log.committing)
801032ae:	85 f6                	test   %esi,%esi
801032b0:	0f 85 1e 01 00 00    	jne    801033d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801032b6:	85 db                	test   %ebx,%ebx
801032b8:	0f 85 f2 00 00 00    	jne    801033b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801032be:	c7 05 80 37 11 80 01 	movl   $0x1,0x80113780
801032c5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	68 40 37 11 80       	push   $0x80113740
801032d0:	e8 9b 1c 00 00       	call   80104f70 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801032d5:	8b 0d 88 37 11 80    	mov    0x80113788,%ecx
801032db:	83 c4 10             	add    $0x10,%esp
801032de:	85 c9                	test   %ecx,%ecx
801032e0:	7f 3e                	jg     80103320 <end_op+0xa0>
    acquire(&log.lock);
801032e2:	83 ec 0c             	sub    $0xc,%esp
801032e5:	68 40 37 11 80       	push   $0x80113740
801032ea:	e8 c1 1b 00 00       	call   80104eb0 <acquire>
    wakeup(&log);
801032ef:	c7 04 24 40 37 11 80 	movl   $0x80113740,(%esp)
    log.committing = 0;
801032f6:	c7 05 80 37 11 80 00 	movl   $0x0,0x80113780
801032fd:	00 00 00 
    wakeup(&log);
80103300:	e8 5b 13 00 00       	call   80104660 <wakeup>
    release(&log.lock);
80103305:	c7 04 24 40 37 11 80 	movl   $0x80113740,(%esp)
8010330c:	e8 5f 1c 00 00       	call   80104f70 <release>
80103311:	83 c4 10             	add    $0x10,%esp
}
80103314:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103317:	5b                   	pop    %ebx
80103318:	5e                   	pop    %esi
80103319:	5f                   	pop    %edi
8010331a:	5d                   	pop    %ebp
8010331b:	c3                   	ret    
8010331c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103320:	a1 74 37 11 80       	mov    0x80113774,%eax
80103325:	83 ec 08             	sub    $0x8,%esp
80103328:	01 d8                	add    %ebx,%eax
8010332a:	83 c0 01             	add    $0x1,%eax
8010332d:	50                   	push   %eax
8010332e:	ff 35 84 37 11 80    	pushl  0x80113784
80103334:	e8 97 cd ff ff       	call   801000d0 <bread>
80103339:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010333b:	58                   	pop    %eax
8010333c:	5a                   	pop    %edx
8010333d:	ff 34 9d 8c 37 11 80 	pushl  -0x7feec874(,%ebx,4)
80103344:	ff 35 84 37 11 80    	pushl  0x80113784
  for (tail = 0; tail < log.lh.n; tail++) {
8010334a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010334d:	e8 7e cd ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103352:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103355:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103357:	8d 40 5c             	lea    0x5c(%eax),%eax
8010335a:	68 00 02 00 00       	push   $0x200
8010335f:	50                   	push   %eax
80103360:	8d 46 5c             	lea    0x5c(%esi),%eax
80103363:	50                   	push   %eax
80103364:	e8 f7 1c 00 00       	call   80105060 <memmove>
    bwrite(to);  // write the log
80103369:	89 34 24             	mov    %esi,(%esp)
8010336c:	e8 3f ce ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103371:	89 3c 24             	mov    %edi,(%esp)
80103374:	e8 77 ce ff ff       	call   801001f0 <brelse>
    brelse(to);
80103379:	89 34 24             	mov    %esi,(%esp)
8010337c:	e8 6f ce ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103381:	83 c4 10             	add    $0x10,%esp
80103384:	3b 1d 88 37 11 80    	cmp    0x80113788,%ebx
8010338a:	7c 94                	jl     80103320 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010338c:	e8 7f fd ff ff       	call   80103110 <write_head>
    install_trans(); // Now install writes to home locations
80103391:	e8 da fc ff ff       	call   80103070 <install_trans>
    log.lh.n = 0;
80103396:	c7 05 88 37 11 80 00 	movl   $0x0,0x80113788
8010339d:	00 00 00 
    write_head();    // Erase the transaction from the log
801033a0:	e8 6b fd ff ff       	call   80103110 <write_head>
801033a5:	e9 38 ff ff ff       	jmp    801032e2 <end_op+0x62>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801033b0:	83 ec 0c             	sub    $0xc,%esp
801033b3:	68 40 37 11 80       	push   $0x80113740
801033b8:	e8 a3 12 00 00       	call   80104660 <wakeup>
  release(&log.lock);
801033bd:	c7 04 24 40 37 11 80 	movl   $0x80113740,(%esp)
801033c4:	e8 a7 1b 00 00       	call   80104f70 <release>
801033c9:	83 c4 10             	add    $0x10,%esp
}
801033cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033cf:	5b                   	pop    %ebx
801033d0:	5e                   	pop    %esi
801033d1:	5f                   	pop    %edi
801033d2:	5d                   	pop    %ebp
801033d3:	c3                   	ret    
    panic("log.committing");
801033d4:	83 ec 0c             	sub    $0xc,%esp
801033d7:	68 04 81 10 80       	push   $0x80108104
801033dc:	e8 af cf ff ff       	call   80100390 <panic>
801033e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033e8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033ef:	90                   	nop

801033f0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801033f0:	f3 0f 1e fb          	endbr32 
801033f4:	55                   	push   %ebp
801033f5:	89 e5                	mov    %esp,%ebp
801033f7:	53                   	push   %ebx
801033f8:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801033fb:	8b 15 88 37 11 80    	mov    0x80113788,%edx
{
80103401:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103404:	83 fa 1d             	cmp    $0x1d,%edx
80103407:	0f 8f 91 00 00 00    	jg     8010349e <log_write+0xae>
8010340d:	a1 78 37 11 80       	mov    0x80113778,%eax
80103412:	83 e8 01             	sub    $0x1,%eax
80103415:	39 c2                	cmp    %eax,%edx
80103417:	0f 8d 81 00 00 00    	jge    8010349e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010341d:	a1 7c 37 11 80       	mov    0x8011377c,%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	0f 8e 81 00 00 00    	jle    801034ab <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010342a:	83 ec 0c             	sub    $0xc,%esp
8010342d:	68 40 37 11 80       	push   $0x80113740
80103432:	e8 79 1a 00 00       	call   80104eb0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103437:	8b 15 88 37 11 80    	mov    0x80113788,%edx
8010343d:	83 c4 10             	add    $0x10,%esp
80103440:	85 d2                	test   %edx,%edx
80103442:	7e 4e                	jle    80103492 <log_write+0xa2>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103444:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103447:	31 c0                	xor    %eax,%eax
80103449:	eb 0c                	jmp    80103457 <log_write+0x67>
8010344b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010344f:	90                   	nop
80103450:	83 c0 01             	add    $0x1,%eax
80103453:	39 c2                	cmp    %eax,%edx
80103455:	74 29                	je     80103480 <log_write+0x90>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103457:	39 0c 85 8c 37 11 80 	cmp    %ecx,-0x7feec874(,%eax,4)
8010345e:	75 f0                	jne    80103450 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103460:	89 0c 85 8c 37 11 80 	mov    %ecx,-0x7feec874(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103467:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010346a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010346d:	c7 45 08 40 37 11 80 	movl   $0x80113740,0x8(%ebp)
}
80103474:	c9                   	leave  
  release(&log.lock);
80103475:	e9 f6 1a 00 00       	jmp    80104f70 <release>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103480:	89 0c 95 8c 37 11 80 	mov    %ecx,-0x7feec874(,%edx,4)
    log.lh.n++;
80103487:	83 c2 01             	add    $0x1,%edx
8010348a:	89 15 88 37 11 80    	mov    %edx,0x80113788
80103490:	eb d5                	jmp    80103467 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103492:	8b 43 08             	mov    0x8(%ebx),%eax
80103495:	a3 8c 37 11 80       	mov    %eax,0x8011378c
  if (i == log.lh.n)
8010349a:	75 cb                	jne    80103467 <log_write+0x77>
8010349c:	eb e9                	jmp    80103487 <log_write+0x97>
    panic("too big a transaction");
8010349e:	83 ec 0c             	sub    $0xc,%esp
801034a1:	68 13 81 10 80       	push   $0x80108113
801034a6:	e8 e5 ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	68 29 81 10 80       	push   $0x80108129
801034b3:	e8 d8 ce ff ff       	call   80100390 <panic>
801034b8:	66 90                	xchg   %ax,%ax
801034ba:	66 90                	xchg   %ax,%ax
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801034c0:	55                   	push   %ebp
801034c1:	89 e5                	mov    %esp,%ebp
801034c3:	53                   	push   %ebx
801034c4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801034c7:	e8 e4 09 00 00       	call   80103eb0 <cpuid>
801034cc:	89 c3                	mov    %eax,%ebx
801034ce:	e8 dd 09 00 00       	call   80103eb0 <cpuid>
801034d3:	83 ec 04             	sub    $0x4,%esp
801034d6:	53                   	push   %ebx
801034d7:	50                   	push   %eax
801034d8:	68 44 81 10 80       	push   $0x80108144
801034dd:	e8 ce d1 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801034e2:	e8 59 2f 00 00       	call   80106440 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801034e7:	e8 54 09 00 00       	call   80103e40 <mycpu>
801034ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801034ee:	b8 01 00 00 00       	mov    $0x1,%eax
801034f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801034fa:	e8 b1 0c 00 00       	call   801041b0 <scheduler>
801034ff:	90                   	nop

80103500 <mpenter>:
{
80103500:	f3 0f 1e fb          	endbr32 
80103504:	55                   	push   %ebp
80103505:	89 e5                	mov    %esp,%ebp
80103507:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010350a:	e8 01 40 00 00       	call   80107510 <switchkvm>
  seginit();
8010350f:	e8 6c 3f 00 00       	call   80107480 <seginit>
  lapicinit();
80103514:	e8 67 f7 ff ff       	call   80102c80 <lapicinit>
  mpmain();
80103519:	e8 a2 ff ff ff       	call   801034c0 <mpmain>
8010351e:	66 90                	xchg   %ax,%ax

80103520 <main>:
{
80103520:	f3 0f 1e fb          	endbr32 
80103524:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103528:	83 e4 f0             	and    $0xfffffff0,%esp
8010352b:	ff 71 fc             	pushl  -0x4(%ecx)
8010352e:	55                   	push   %ebp
8010352f:	89 e5                	mov    %esp,%ebp
80103531:	53                   	push   %ebx
80103532:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103533:	83 ec 08             	sub    $0x8,%esp
80103536:	68 00 00 40 80       	push   $0x80400000
8010353b:	68 68 66 11 80       	push   $0x80116668
80103540:	e8 fb f4 ff ff       	call   80102a40 <kinit1>
  kvmalloc();      // kernel page table
80103545:	e8 a6 44 00 00       	call   801079f0 <kvmalloc>
  mpinit();        // detect other processors
8010354a:	e8 81 01 00 00       	call   801036d0 <mpinit>
  lapicinit();     // interrupt controller
8010354f:	e8 2c f7 ff ff       	call   80102c80 <lapicinit>
  seginit();       // segment descriptors
80103554:	e8 27 3f 00 00       	call   80107480 <seginit>
  picinit();       // disable pic
80103559:	e8 52 03 00 00       	call   801038b0 <picinit>
  ioapicinit();    // another interrupt controller
8010355e:	e8 fd f2 ff ff       	call   80102860 <ioapicinit>
  consoleinit();   // console hardware
80103563:	e8 88 d9 ff ff       	call   80100ef0 <consoleinit>
  uartinit();      // serial port
80103568:	e8 d3 31 00 00       	call   80106740 <uartinit>
  pinit();         // process table
8010356d:	e8 ae 08 00 00       	call   80103e20 <pinit>
  tvinit();        // trap vectors
80103572:	e8 49 2e 00 00       	call   801063c0 <tvinit>
  binit();         // buffer cache
80103577:	e8 c4 ca ff ff       	call   80100040 <binit>
  fileinit();      // file table
8010357c:	e8 1f dd ff ff       	call   801012a0 <fileinit>
  ideinit();       // disk 
80103581:	e8 aa f0 ff ff       	call   80102630 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103586:	83 c4 0c             	add    $0xc,%esp
80103589:	68 8a 00 00 00       	push   $0x8a
8010358e:	68 ac b4 10 80       	push   $0x8010b4ac
80103593:	68 00 70 00 80       	push   $0x80007000
80103598:	e8 c3 1a 00 00       	call   80105060 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	69 05 c0 3d 11 80 b0 	imul   $0xb0,0x80113dc0,%eax
801035a7:	00 00 00 
801035aa:	05 40 38 11 80       	add    $0x80113840,%eax
801035af:	3d 40 38 11 80       	cmp    $0x80113840,%eax
801035b4:	76 7a                	jbe    80103630 <main+0x110>
801035b6:	bb 40 38 11 80       	mov    $0x80113840,%ebx
801035bb:	eb 1c                	jmp    801035d9 <main+0xb9>
801035bd:	8d 76 00             	lea    0x0(%esi),%esi
801035c0:	69 05 c0 3d 11 80 b0 	imul   $0xb0,0x80113dc0,%eax
801035c7:	00 00 00 
801035ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035d0:	05 40 38 11 80       	add    $0x80113840,%eax
801035d5:	39 c3                	cmp    %eax,%ebx
801035d7:	73 57                	jae    80103630 <main+0x110>
    if(c == mycpu())  // We've started already.
801035d9:	e8 62 08 00 00       	call   80103e40 <mycpu>
801035de:	39 c3                	cmp    %eax,%ebx
801035e0:	74 de                	je     801035c0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801035e2:	e8 29 f5 ff ff       	call   80102b10 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801035e7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801035ea:	c7 05 f8 6f 00 80 00 	movl   $0x80103500,0x80006ff8
801035f1:	35 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801035f4:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
801035fb:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801035fe:	05 00 10 00 00       	add    $0x1000,%eax
80103603:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103608:	0f b6 03             	movzbl (%ebx),%eax
8010360b:	68 00 70 00 00       	push   $0x7000
80103610:	50                   	push   %eax
80103611:	e8 ba f7 ff ff       	call   80102dd0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103616:	83 c4 10             	add    $0x10,%esp
80103619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103620:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103626:	85 c0                	test   %eax,%eax
80103628:	74 f6                	je     80103620 <main+0x100>
8010362a:	eb 94                	jmp    801035c0 <main+0xa0>
8010362c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103630:	83 ec 08             	sub    $0x8,%esp
80103633:	68 00 00 00 8e       	push   $0x8e000000
80103638:	68 00 00 40 80       	push   $0x80400000
8010363d:	e8 6e f4 ff ff       	call   80102ab0 <kinit2>
  userinit();      // first user process
80103642:	e8 b9 08 00 00       	call   80103f00 <userinit>
  mpmain();        // finish this processor's setup
80103647:	e8 74 fe ff ff       	call   801034c0 <mpmain>
8010364c:	66 90                	xchg   %ax,%ax
8010364e:	66 90                	xchg   %ax,%ax

80103650 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103650:	55                   	push   %ebp
80103651:	89 e5                	mov    %esp,%ebp
80103653:	57                   	push   %edi
80103654:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103655:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010365b:	53                   	push   %ebx
  e = addr+len;
8010365c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010365f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103662:	39 de                	cmp    %ebx,%esi
80103664:	72 10                	jb     80103676 <mpsearch1+0x26>
80103666:	eb 50                	jmp    801036b8 <mpsearch1+0x68>
80103668:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010366f:	90                   	nop
80103670:	89 fe                	mov    %edi,%esi
80103672:	39 fb                	cmp    %edi,%ebx
80103674:	76 42                	jbe    801036b8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103676:	83 ec 04             	sub    $0x4,%esp
80103679:	8d 7e 10             	lea    0x10(%esi),%edi
8010367c:	6a 04                	push   $0x4
8010367e:	68 58 81 10 80       	push   $0x80108158
80103683:	56                   	push   %esi
80103684:	e8 87 19 00 00       	call   80105010 <memcmp>
80103689:	83 c4 10             	add    $0x10,%esp
8010368c:	85 c0                	test   %eax,%eax
8010368e:	75 e0                	jne    80103670 <mpsearch1+0x20>
80103690:	89 f2                	mov    %esi,%edx
80103692:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103698:	0f b6 0a             	movzbl (%edx),%ecx
8010369b:	83 c2 01             	add    $0x1,%edx
8010369e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801036a0:	39 fa                	cmp    %edi,%edx
801036a2:	75 f4                	jne    80103698 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801036a4:	84 c0                	test   %al,%al
801036a6:	75 c8                	jne    80103670 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
801036a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036ab:	89 f0                	mov    %esi,%eax
801036ad:	5b                   	pop    %ebx
801036ae:	5e                   	pop    %esi
801036af:	5f                   	pop    %edi
801036b0:	5d                   	pop    %ebp
801036b1:	c3                   	ret    
801036b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801036b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801036bb:	31 f6                	xor    %esi,%esi
}
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
  return conf;
}

void
mpinit(void)
{
801036d0:	f3 0f 1e fb          	endbr32 
801036d4:	55                   	push   %ebp
801036d5:	89 e5                	mov    %esp,%ebp
801036d7:	57                   	push   %edi
801036d8:	56                   	push   %esi
801036d9:	53                   	push   %ebx
801036da:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801036dd:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801036e4:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801036eb:	c1 e0 08             	shl    $0x8,%eax
801036ee:	09 d0                	or     %edx,%eax
801036f0:	c1 e0 04             	shl    $0x4,%eax
801036f3:	75 1b                	jne    80103710 <mpinit+0x40>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801036f5:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801036fc:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103703:	c1 e0 08             	shl    $0x8,%eax
80103706:	09 d0                	or     %edx,%eax
80103708:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
8010370b:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
80103710:	ba 00 04 00 00       	mov    $0x400,%edx
80103715:	e8 36 ff ff ff       	call   80103650 <mpsearch1>
8010371a:	89 c6                	mov    %eax,%esi
8010371c:	85 c0                	test   %eax,%eax
8010371e:	0f 84 4c 01 00 00    	je     80103870 <mpinit+0x1a0>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103724:	8b 5e 04             	mov    0x4(%esi),%ebx
80103727:	85 db                	test   %ebx,%ebx
80103729:	0f 84 61 01 00 00    	je     80103890 <mpinit+0x1c0>
  if(memcmp(conf, "PCMP", 4) != 0)
8010372f:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103732:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
  if(memcmp(conf, "PCMP", 4) != 0)
80103738:	6a 04                	push   $0x4
8010373a:	68 5d 81 10 80       	push   $0x8010815d
8010373f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103743:	e8 c8 18 00 00       	call   80105010 <memcmp>
80103748:	83 c4 10             	add    $0x10,%esp
8010374b:	85 c0                	test   %eax,%eax
8010374d:	0f 85 3d 01 00 00    	jne    80103890 <mpinit+0x1c0>
  if(conf->version != 1 && conf->version != 4)
80103753:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
8010375a:	3c 01                	cmp    $0x1,%al
8010375c:	74 08                	je     80103766 <mpinit+0x96>
8010375e:	3c 04                	cmp    $0x4,%al
80103760:	0f 85 2a 01 00 00    	jne    80103890 <mpinit+0x1c0>
  if(sum((uchar*)conf, conf->length) != 0)
80103766:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  for(i=0; i<len; i++)
8010376d:	66 85 d2             	test   %dx,%dx
80103770:	74 26                	je     80103798 <mpinit+0xc8>
80103772:	8d 3c 1a             	lea    (%edx,%ebx,1),%edi
80103775:	89 d8                	mov    %ebx,%eax
  sum = 0;
80103777:	31 d2                	xor    %edx,%edx
80103779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sum += addr[i];
80103780:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103787:	83 c0 01             	add    $0x1,%eax
8010378a:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
8010378c:	39 f8                	cmp    %edi,%eax
8010378e:	75 f0                	jne    80103780 <mpinit+0xb0>
  if(sum((uchar*)conf, conf->length) != 0)
80103790:	84 d2                	test   %dl,%dl
80103792:	0f 85 f8 00 00 00    	jne    80103890 <mpinit+0x1c0>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103798:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
8010379e:	a3 3c 37 11 80       	mov    %eax,0x8011373c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037a3:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
801037a9:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
  ismp = 1;
801037b0:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037b5:	03 55 e4             	add    -0x1c(%ebp),%edx
801037b8:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801037bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801037bf:	90                   	nop
801037c0:	39 c2                	cmp    %eax,%edx
801037c2:	76 15                	jbe    801037d9 <mpinit+0x109>
    switch(*p){
801037c4:	0f b6 08             	movzbl (%eax),%ecx
801037c7:	80 f9 02             	cmp    $0x2,%cl
801037ca:	74 5c                	je     80103828 <mpinit+0x158>
801037cc:	77 42                	ja     80103810 <mpinit+0x140>
801037ce:	84 c9                	test   %cl,%cl
801037d0:	74 6e                	je     80103840 <mpinit+0x170>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801037d2:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801037d5:	39 c2                	cmp    %eax,%edx
801037d7:	77 eb                	ja     801037c4 <mpinit+0xf4>
801037d9:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801037dc:	85 db                	test   %ebx,%ebx
801037de:	0f 84 b9 00 00 00    	je     8010389d <mpinit+0x1cd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801037e4:	80 7e 0c 00          	cmpb   $0x0,0xc(%esi)
801037e8:	74 15                	je     801037ff <mpinit+0x12f>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037ea:	b8 70 00 00 00       	mov    $0x70,%eax
801037ef:	ba 22 00 00 00       	mov    $0x22,%edx
801037f4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037f5:	ba 23 00 00 00       	mov    $0x23,%edx
801037fa:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801037fb:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037fe:	ee                   	out    %al,(%dx)
  }
}
801037ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103802:	5b                   	pop    %ebx
80103803:	5e                   	pop    %esi
80103804:	5f                   	pop    %edi
80103805:	5d                   	pop    %ebp
80103806:	c3                   	ret    
80103807:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010380e:	66 90                	xchg   %ax,%ax
    switch(*p){
80103810:	83 e9 03             	sub    $0x3,%ecx
80103813:	80 f9 01             	cmp    $0x1,%cl
80103816:	76 ba                	jbe    801037d2 <mpinit+0x102>
80103818:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
8010381f:	eb 9f                	jmp    801037c0 <mpinit+0xf0>
80103821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
80103828:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
8010382c:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
8010382f:	88 0d 20 38 11 80    	mov    %cl,0x80113820
      continue;
80103835:	eb 89                	jmp    801037c0 <mpinit+0xf0>
80103837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010383e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103840:	8b 0d c0 3d 11 80    	mov    0x80113dc0,%ecx
80103846:	83 f9 07             	cmp    $0x7,%ecx
80103849:	7f 19                	jg     80103864 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010384b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103851:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103855:	83 c1 01             	add    $0x1,%ecx
80103858:	89 0d c0 3d 11 80    	mov    %ecx,0x80113dc0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010385e:	88 9f 40 38 11 80    	mov    %bl,-0x7feec7c0(%edi)
      p += sizeof(struct mpproc);
80103864:	83 c0 14             	add    $0x14,%eax
      continue;
80103867:	e9 54 ff ff ff       	jmp    801037c0 <mpinit+0xf0>
8010386c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return mpsearch1(0xF0000, 0x10000);
80103870:	ba 00 00 01 00       	mov    $0x10000,%edx
80103875:	b8 00 00 0f 00       	mov    $0xf0000,%eax
8010387a:	e8 d1 fd ff ff       	call   80103650 <mpsearch1>
8010387f:	89 c6                	mov    %eax,%esi
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103881:	85 c0                	test   %eax,%eax
80103883:	0f 85 9b fe ff ff    	jne    80103724 <mpinit+0x54>
80103889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    panic("Expect to run on an SMP");
80103890:	83 ec 0c             	sub    $0xc,%esp
80103893:	68 62 81 10 80       	push   $0x80108162
80103898:	e8 f3 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010389d:	83 ec 0c             	sub    $0xc,%esp
801038a0:	68 7c 81 10 80       	push   $0x8010817c
801038a5:	e8 e6 ca ff ff       	call   80100390 <panic>
801038aa:	66 90                	xchg   %ax,%ax
801038ac:	66 90                	xchg   %ax,%ax
801038ae:	66 90                	xchg   %ax,%ax

801038b0 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
801038b0:	f3 0f 1e fb          	endbr32 
801038b4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801038b9:	ba 21 00 00 00       	mov    $0x21,%edx
801038be:	ee                   	out    %al,(%dx)
801038bf:	ba a1 00 00 00       	mov    $0xa1,%edx
801038c4:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801038c5:	c3                   	ret    
801038c6:	66 90                	xchg   %ax,%ax
801038c8:	66 90                	xchg   %ax,%ax
801038ca:	66 90                	xchg   %ax,%ax
801038cc:	66 90                	xchg   %ax,%ax
801038ce:	66 90                	xchg   %ax,%ax

801038d0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801038d0:	f3 0f 1e fb          	endbr32 
801038d4:	55                   	push   %ebp
801038d5:	89 e5                	mov    %esp,%ebp
801038d7:	57                   	push   %edi
801038d8:	56                   	push   %esi
801038d9:	53                   	push   %ebx
801038da:	83 ec 0c             	sub    $0xc,%esp
801038dd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038e0:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801038e3:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801038e9:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801038ef:	e8 cc d9 ff ff       	call   801012c0 <filealloc>
801038f4:	89 03                	mov    %eax,(%ebx)
801038f6:	85 c0                	test   %eax,%eax
801038f8:	0f 84 ac 00 00 00    	je     801039aa <pipealloc+0xda>
801038fe:	e8 bd d9 ff ff       	call   801012c0 <filealloc>
80103903:	89 06                	mov    %eax,(%esi)
80103905:	85 c0                	test   %eax,%eax
80103907:	0f 84 8b 00 00 00    	je     80103998 <pipealloc+0xc8>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
8010390d:	e8 fe f1 ff ff       	call   80102b10 <kalloc>
80103912:	89 c7                	mov    %eax,%edi
80103914:	85 c0                	test   %eax,%eax
80103916:	0f 84 b4 00 00 00    	je     801039d0 <pipealloc+0x100>
    goto bad;
  p->readopen = 1;
8010391c:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103923:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103926:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103929:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103930:	00 00 00 
  p->nwrite = 0;
80103933:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010393a:	00 00 00 
  p->nread = 0;
8010393d:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103944:	00 00 00 
  initlock(&p->lock, "pipe");
80103947:	68 9b 81 10 80       	push   $0x8010819b
8010394c:	50                   	push   %eax
8010394d:	e8 de 13 00 00       	call   80104d30 <initlock>
  (*f0)->type = FD_PIPE;
80103952:	8b 03                	mov    (%ebx),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103954:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103957:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
8010395d:	8b 03                	mov    (%ebx),%eax
8010395f:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103963:	8b 03                	mov    (%ebx),%eax
80103965:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103969:	8b 03                	mov    (%ebx),%eax
8010396b:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010396e:	8b 06                	mov    (%esi),%eax
80103970:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103976:	8b 06                	mov    (%esi),%eax
80103978:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
8010397c:	8b 06                	mov    (%esi),%eax
8010397e:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103982:	8b 06                	mov    (%esi),%eax
80103984:	89 78 0c             	mov    %edi,0xc(%eax)
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103987:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010398a:	31 c0                	xor    %eax,%eax
}
8010398c:	5b                   	pop    %ebx
8010398d:	5e                   	pop    %esi
8010398e:	5f                   	pop    %edi
8010398f:	5d                   	pop    %ebp
80103990:	c3                   	ret    
80103991:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
80103998:	8b 03                	mov    (%ebx),%eax
8010399a:	85 c0                	test   %eax,%eax
8010399c:	74 1e                	je     801039bc <pipealloc+0xec>
    fileclose(*f0);
8010399e:	83 ec 0c             	sub    $0xc,%esp
801039a1:	50                   	push   %eax
801039a2:	e8 d9 d9 ff ff       	call   80101380 <fileclose>
801039a7:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801039aa:	8b 06                	mov    (%esi),%eax
801039ac:	85 c0                	test   %eax,%eax
801039ae:	74 0c                	je     801039bc <pipealloc+0xec>
    fileclose(*f1);
801039b0:	83 ec 0c             	sub    $0xc,%esp
801039b3:	50                   	push   %eax
801039b4:	e8 c7 d9 ff ff       	call   80101380 <fileclose>
801039b9:	83 c4 10             	add    $0x10,%esp
}
801039bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801039bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801039c4:	5b                   	pop    %ebx
801039c5:	5e                   	pop    %esi
801039c6:	5f                   	pop    %edi
801039c7:	5d                   	pop    %ebp
801039c8:	c3                   	ret    
801039c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  if(*f0)
801039d0:	8b 03                	mov    (%ebx),%eax
801039d2:	85 c0                	test   %eax,%eax
801039d4:	75 c8                	jne    8010399e <pipealloc+0xce>
801039d6:	eb d2                	jmp    801039aa <pipealloc+0xda>
801039d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039df:	90                   	nop

801039e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801039e0:	f3 0f 1e fb          	endbr32 
801039e4:	55                   	push   %ebp
801039e5:	89 e5                	mov    %esp,%ebp
801039e7:	56                   	push   %esi
801039e8:	53                   	push   %ebx
801039e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801039ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801039ef:	83 ec 0c             	sub    $0xc,%esp
801039f2:	53                   	push   %ebx
801039f3:	e8 b8 14 00 00       	call   80104eb0 <acquire>
  if(writable){
801039f8:	83 c4 10             	add    $0x10,%esp
801039fb:	85 f6                	test   %esi,%esi
801039fd:	74 41                	je     80103a40 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103a08:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103a0f:	00 00 00 
    wakeup(&p->nread);
80103a12:	50                   	push   %eax
80103a13:	e8 48 0c 00 00       	call   80104660 <wakeup>
80103a18:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103a1b:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103a21:	85 d2                	test   %edx,%edx
80103a23:	75 0a                	jne    80103a2f <pipeclose+0x4f>
80103a25:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103a2b:	85 c0                	test   %eax,%eax
80103a2d:	74 31                	je     80103a60 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
80103a2f:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80103a32:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a35:	5b                   	pop    %ebx
80103a36:	5e                   	pop    %esi
80103a37:	5d                   	pop    %ebp
    release(&p->lock);
80103a38:	e9 33 15 00 00       	jmp    80104f70 <release>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103a49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a50:	00 00 00 
    wakeup(&p->nwrite);
80103a53:	50                   	push   %eax
80103a54:	e8 07 0c 00 00       	call   80104660 <wakeup>
80103a59:	83 c4 10             	add    $0x10,%esp
80103a5c:	eb bd                	jmp    80103a1b <pipeclose+0x3b>
80103a5e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	53                   	push   %ebx
80103a64:	e8 07 15 00 00       	call   80104f70 <release>
    kfree((char*)p);
80103a69:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103a6c:	83 c4 10             	add    $0x10,%esp
}
80103a6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103a72:	5b                   	pop    %ebx
80103a73:	5e                   	pop    %esi
80103a74:	5d                   	pop    %ebp
    kfree((char*)p);
80103a75:	e9 d6 ee ff ff       	jmp    80102950 <kfree>
80103a7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103a80 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103a80:	f3 0f 1e fb          	endbr32 
80103a84:	55                   	push   %ebp
80103a85:	89 e5                	mov    %esp,%ebp
80103a87:	57                   	push   %edi
80103a88:	56                   	push   %esi
80103a89:	53                   	push   %ebx
80103a8a:	83 ec 28             	sub    $0x28,%esp
80103a8d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
80103a90:	53                   	push   %ebx
80103a91:	e8 1a 14 00 00       	call   80104eb0 <acquire>
  for(i = 0; i < n; i++){
80103a96:	8b 45 10             	mov    0x10(%ebp),%eax
80103a99:	83 c4 10             	add    $0x10,%esp
80103a9c:	85 c0                	test   %eax,%eax
80103a9e:	0f 8e bc 00 00 00    	jle    80103b60 <pipewrite+0xe0>
80103aa4:	8b 45 0c             	mov    0xc(%ebp),%eax
80103aa7:	8b 8b 38 02 00 00    	mov    0x238(%ebx),%ecx
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103aad:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
80103ab3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ab6:	03 45 10             	add    0x10(%ebp),%eax
80103ab9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103abc:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103ac2:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103ac8:	89 ca                	mov    %ecx,%edx
80103aca:	05 00 02 00 00       	add    $0x200,%eax
80103acf:	39 c1                	cmp    %eax,%ecx
80103ad1:	74 3b                	je     80103b0e <pipewrite+0x8e>
80103ad3:	eb 63                	jmp    80103b38 <pipewrite+0xb8>
80103ad5:	8d 76 00             	lea    0x0(%esi),%esi
      if(p->readopen == 0 || myproc()->killed){
80103ad8:	e8 f3 03 00 00       	call   80103ed0 <myproc>
80103add:	8b 48 28             	mov    0x28(%eax),%ecx
80103ae0:	85 c9                	test   %ecx,%ecx
80103ae2:	75 34                	jne    80103b18 <pipewrite+0x98>
      wakeup(&p->nread);
80103ae4:	83 ec 0c             	sub    $0xc,%esp
80103ae7:	57                   	push   %edi
80103ae8:	e8 73 0b 00 00       	call   80104660 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103aed:	58                   	pop    %eax
80103aee:	5a                   	pop    %edx
80103aef:	53                   	push   %ebx
80103af0:	56                   	push   %esi
80103af1:	e8 aa 09 00 00       	call   801044a0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103af6:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103afc:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103b02:	83 c4 10             	add    $0x10,%esp
80103b05:	05 00 02 00 00       	add    $0x200,%eax
80103b0a:	39 c2                	cmp    %eax,%edx
80103b0c:	75 2a                	jne    80103b38 <pipewrite+0xb8>
      if(p->readopen == 0 || myproc()->killed){
80103b0e:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103b14:	85 c0                	test   %eax,%eax
80103b16:	75 c0                	jne    80103ad8 <pipewrite+0x58>
        release(&p->lock);
80103b18:	83 ec 0c             	sub    $0xc,%esp
80103b1b:	53                   	push   %ebx
80103b1c:	e8 4f 14 00 00       	call   80104f70 <release>
        return -1;
80103b21:	83 c4 10             	add    $0x10,%esp
80103b24:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103b29:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103b2c:	5b                   	pop    %ebx
80103b2d:	5e                   	pop    %esi
80103b2e:	5f                   	pop    %edi
80103b2f:	5d                   	pop    %ebp
80103b30:	c3                   	ret    
80103b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103b38:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80103b3b:	8d 4a 01             	lea    0x1(%edx),%ecx
80103b3e:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103b44:	89 8b 38 02 00 00    	mov    %ecx,0x238(%ebx)
80103b4a:	0f b6 06             	movzbl (%esi),%eax
80103b4d:	83 c6 01             	add    $0x1,%esi
80103b50:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80103b53:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103b57:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80103b5a:	0f 85 5c ff ff ff    	jne    80103abc <pipewrite+0x3c>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
80103b60:	83 ec 0c             	sub    $0xc,%esp
80103b63:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103b69:	50                   	push   %eax
80103b6a:	e8 f1 0a 00 00       	call   80104660 <wakeup>
  release(&p->lock);
80103b6f:	89 1c 24             	mov    %ebx,(%esp)
80103b72:	e8 f9 13 00 00       	call   80104f70 <release>
  return n;
80103b77:	8b 45 10             	mov    0x10(%ebp),%eax
80103b7a:	83 c4 10             	add    $0x10,%esp
80103b7d:	eb aa                	jmp    80103b29 <pipewrite+0xa9>
80103b7f:	90                   	nop

80103b80 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103b80:	f3 0f 1e fb          	endbr32 
80103b84:	55                   	push   %ebp
80103b85:	89 e5                	mov    %esp,%ebp
80103b87:	57                   	push   %edi
80103b88:	56                   	push   %esi
80103b89:	53                   	push   %ebx
80103b8a:	83 ec 18             	sub    $0x18,%esp
80103b8d:	8b 75 08             	mov    0x8(%ebp),%esi
80103b90:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
80103b93:	56                   	push   %esi
80103b94:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103b9a:	e8 11 13 00 00       	call   80104eb0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103b9f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ba5:	83 c4 10             	add    $0x10,%esp
80103ba8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bae:	74 33                	je     80103be3 <piperead+0x63>
80103bb0:	eb 3b                	jmp    80103bed <piperead+0x6d>
80103bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103bb8:	e8 13 03 00 00       	call   80103ed0 <myproc>
80103bbd:	8b 48 28             	mov    0x28(%eax),%ecx
80103bc0:	85 c9                	test   %ecx,%ecx
80103bc2:	0f 85 88 00 00 00    	jne    80103c50 <piperead+0xd0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103bc8:	83 ec 08             	sub    $0x8,%esp
80103bcb:	56                   	push   %esi
80103bcc:	53                   	push   %ebx
80103bcd:	e8 ce 08 00 00       	call   801044a0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103bd2:	8b 86 38 02 00 00    	mov    0x238(%esi),%eax
80103bd8:	83 c4 10             	add    $0x10,%esp
80103bdb:	39 86 34 02 00 00    	cmp    %eax,0x234(%esi)
80103be1:	75 0a                	jne    80103bed <piperead+0x6d>
80103be3:	8b 86 40 02 00 00    	mov    0x240(%esi),%eax
80103be9:	85 c0                	test   %eax,%eax
80103beb:	75 cb                	jne    80103bb8 <piperead+0x38>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103bed:	8b 55 10             	mov    0x10(%ebp),%edx
80103bf0:	31 db                	xor    %ebx,%ebx
80103bf2:	85 d2                	test   %edx,%edx
80103bf4:	7f 28                	jg     80103c1e <piperead+0x9e>
80103bf6:	eb 34                	jmp    80103c2c <piperead+0xac>
80103bf8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103bff:	90                   	nop
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103c00:	8d 48 01             	lea    0x1(%eax),%ecx
80103c03:	25 ff 01 00 00       	and    $0x1ff,%eax
80103c08:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103c0e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103c13:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103c16:	83 c3 01             	add    $0x1,%ebx
80103c19:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103c1c:	74 0e                	je     80103c2c <piperead+0xac>
    if(p->nread == p->nwrite)
80103c1e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103c24:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103c2a:	75 d4                	jne    80103c00 <piperead+0x80>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
80103c2c:	83 ec 0c             	sub    $0xc,%esp
80103c2f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103c35:	50                   	push   %eax
80103c36:	e8 25 0a 00 00       	call   80104660 <wakeup>
  release(&p->lock);
80103c3b:	89 34 24             	mov    %esi,(%esp)
80103c3e:	e8 2d 13 00 00       	call   80104f70 <release>
  return i;
80103c43:	83 c4 10             	add    $0x10,%esp
}
80103c46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c49:	89 d8                	mov    %ebx,%eax
80103c4b:	5b                   	pop    %ebx
80103c4c:	5e                   	pop    %esi
80103c4d:	5f                   	pop    %edi
80103c4e:	5d                   	pop    %ebp
80103c4f:	c3                   	ret    
      release(&p->lock);
80103c50:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103c53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103c58:	56                   	push   %esi
80103c59:	e8 12 13 00 00       	call   80104f70 <release>
      return -1;
80103c5e:	83 c4 10             	add    $0x10,%esp
}
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
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103c70:	55                   	push   %ebp
80103c71:	89 e5                	mov    %esp,%ebp
80103c73:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c74:	bb 14 3e 11 80       	mov    $0x80113e14,%ebx
{
80103c79:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c7c:	68 e0 3d 11 80       	push   $0x80113de0
80103c81:	e8 2a 12 00 00       	call   80104eb0 <acquire>
80103c86:	83 c4 10             	add    $0x10,%esp
80103c89:	eb 10                	jmp    80103c9b <allocproc+0x2b>
80103c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c8f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c90:	83 eb 80             	sub    $0xffffff80,%ebx
80103c93:	81 fb 14 5e 11 80    	cmp    $0x80115e14,%ebx
80103c99:	74 75                	je     80103d10 <allocproc+0xa0>
    if(p->state == UNUSED)
80103c9b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103c9e:	85 c0                	test   %eax,%eax
80103ca0:	75 ee                	jne    80103c90 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103ca2:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
80103ca7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103caa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103cb1:	89 43 10             	mov    %eax,0x10(%ebx)
80103cb4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103cb7:	68 e0 3d 11 80       	push   $0x80113de0
  p->pid = nextpid++;
80103cbc:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103cc2:	e8 a9 12 00 00       	call   80104f70 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103cc7:	e8 44 ee ff ff       	call   80102b10 <kalloc>
80103ccc:	83 c4 10             	add    $0x10,%esp
80103ccf:	89 43 08             	mov    %eax,0x8(%ebx)
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	74 53                	je     80103d29 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103cd6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103cdc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103cdf:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103ce4:	89 53 1c             	mov    %edx,0x1c(%ebx)
  *(uint*)sp = (uint)trapret;
80103ce7:	c7 40 14 af 63 10 80 	movl   $0x801063af,0x14(%eax)
  p->context = (struct context*)sp;
80103cee:	89 43 20             	mov    %eax,0x20(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103cf1:	6a 14                	push   $0x14
80103cf3:	6a 00                	push   $0x0
80103cf5:	50                   	push   %eax
80103cf6:	e8 c5 12 00 00       	call   80104fc0 <memset>
  p->context->eip = (uint)forkret;
80103cfb:	8b 43 20             	mov    0x20(%ebx),%eax

  return p;
80103cfe:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d01:	c7 40 10 40 3d 10 80 	movl   $0x80103d40,0x10(%eax)
}
80103d08:	89 d8                	mov    %ebx,%eax
80103d0a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d0d:	c9                   	leave  
80103d0e:	c3                   	ret    
80103d0f:	90                   	nop
  release(&ptable.lock);
80103d10:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d13:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d15:	68 e0 3d 11 80       	push   $0x80113de0
80103d1a:	e8 51 12 00 00       	call   80104f70 <release>
}
80103d1f:	89 d8                	mov    %ebx,%eax
  return 0;
80103d21:	83 c4 10             	add    $0x10,%esp
}
80103d24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d27:	c9                   	leave  
80103d28:	c3                   	ret    
    p->state = UNUSED;
80103d29:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d30:	31 db                	xor    %ebx,%ebx
}
80103d32:	89 d8                	mov    %ebx,%eax
80103d34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d37:	c9                   	leave  
80103d38:	c3                   	ret    
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103d40:	f3 0f 1e fb          	endbr32 
80103d44:	55                   	push   %ebp
80103d45:	89 e5                	mov    %esp,%ebp
80103d47:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103d4a:	68 e0 3d 11 80       	push   $0x80113de0
80103d4f:	e8 1c 12 00 00       	call   80104f70 <release>

  if (first) {
80103d54:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103d59:	83 c4 10             	add    $0x10,%esp
80103d5c:	85 c0                	test   %eax,%eax
80103d5e:	75 08                	jne    80103d68 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103d60:	c9                   	leave  
80103d61:	c3                   	ret    
80103d62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103d68:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103d6f:	00 00 00 
    iinit(ROOTDEV);
80103d72:	83 ec 0c             	sub    $0xc,%esp
80103d75:	6a 01                	push   $0x1
80103d77:	e8 84 dc ff ff       	call   80101a00 <iinit>
    initlog(ROOTDEV);
80103d7c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103d83:	e8 e8 f3 ff ff       	call   80103170 <initlog>
}
80103d88:	83 c4 10             	add    $0x10,%esp
80103d8b:	c9                   	leave  
80103d8c:	c3                   	ret    
80103d8d:	8d 76 00             	lea    0x0(%esi),%esi

80103d90 <print>:
void print(){
80103d90:	f3 0f 1e fb          	endbr32 
80103d94:	55                   	push   %ebp
80103d95:	89 e5                	mov    %esp,%ebp
80103d97:	53                   	push   %ebx
  for(int i = 0; i < 5; i++){
80103d98:	31 db                	xor    %ebx,%ebx
void print(){
80103d9a:	83 ec 04             	sub    $0x4,%esp
    cprintf("phiosopher %d : ", i + 1);
80103d9d:	83 ec 08             	sub    $0x8,%esp
80103da0:	83 c3 01             	add    $0x1,%ebx
80103da3:	53                   	push   %ebx
80103da4:	68 a0 81 10 80       	push   $0x801081a0
80103da9:	e8 02 c9 ff ff       	call   801006b0 <cprintf>
    if(state[i] == 0)
80103dae:	8b 04 9d 18 b0 10 80 	mov    -0x7fef4fe8(,%ebx,4),%eax
80103db5:	83 c4 10             	add    $0x10,%esp
80103db8:	85 c0                	test   %eax,%eax
80103dba:	74 34                	je     80103df0 <print+0x60>
    else if(state[i] == 1)
80103dbc:	83 f8 01             	cmp    $0x1,%eax
80103dbf:	74 47                	je     80103e08 <print+0x78>
      cprintf("THINKING\n");
80103dc1:	83 ec 0c             	sub    $0xc,%esp
80103dc4:	68 c1 81 10 80       	push   $0x801081c1
80103dc9:	e8 e2 c8 ff ff       	call   801006b0 <cprintf>
80103dce:	83 c4 10             	add    $0x10,%esp
  for(int i = 0; i < 5; i++){
80103dd1:	83 fb 05             	cmp    $0x5,%ebx
80103dd4:	75 c7                	jne    80103d9d <print+0xd>
  cprintf("\n\n\n");
80103dd6:	83 ec 0c             	sub    $0xc,%esp
80103dd9:	68 cb 81 10 80       	push   $0x801081cb
80103dde:	e8 cd c8 ff ff       	call   801006b0 <cprintf>
}
80103de3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103de6:	83 c4 10             	add    $0x10,%esp
80103de9:	c9                   	leave  
80103dea:	c3                   	ret    
80103deb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103def:	90                   	nop
      cprintf("EATING\n");
80103df0:	83 ec 0c             	sub    $0xc,%esp
80103df3:	68 b1 81 10 80       	push   $0x801081b1
80103df8:	e8 b3 c8 ff ff       	call   801006b0 <cprintf>
80103dfd:	83 c4 10             	add    $0x10,%esp
80103e00:	eb cf                	jmp    80103dd1 <print+0x41>
80103e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("HUNGRY\n");
80103e08:	83 ec 0c             	sub    $0xc,%esp
80103e0b:	68 b9 81 10 80       	push   $0x801081b9
80103e10:	e8 9b c8 ff ff       	call   801006b0 <cprintf>
80103e15:	83 c4 10             	add    $0x10,%esp
80103e18:	eb b7                	jmp    80103dd1 <print+0x41>
80103e1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103e20 <pinit>:
{
80103e20:	f3 0f 1e fb          	endbr32 
80103e24:	55                   	push   %ebp
80103e25:	89 e5                	mov    %esp,%ebp
80103e27:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103e2a:	68 cf 81 10 80       	push   $0x801081cf
80103e2f:	68 e0 3d 11 80       	push   $0x80113de0
80103e34:	e8 f7 0e 00 00       	call   80104d30 <initlock>
}
80103e39:	83 c4 10             	add    $0x10,%esp
80103e3c:	c9                   	leave  
80103e3d:	c3                   	ret    
80103e3e:	66 90                	xchg   %ax,%ax

80103e40 <mycpu>:
{
80103e40:	f3 0f 1e fb          	endbr32 
80103e44:	55                   	push   %ebp
80103e45:	89 e5                	mov    %esp,%ebp
80103e47:	56                   	push   %esi
80103e48:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e49:	9c                   	pushf  
80103e4a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e4b:	f6 c4 02             	test   $0x2,%ah
80103e4e:	75 4a                	jne    80103e9a <mycpu+0x5a>
  apicid = lapicid();
80103e50:	e8 2b ef ff ff       	call   80102d80 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e55:	8b 35 c0 3d 11 80    	mov    0x80113dc0,%esi
  apicid = lapicid();
80103e5b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103e5d:	85 f6                	test   %esi,%esi
80103e5f:	7e 2c                	jle    80103e8d <mycpu+0x4d>
80103e61:	31 d2                	xor    %edx,%edx
80103e63:	eb 0a                	jmp    80103e6f <mycpu+0x2f>
80103e65:	8d 76 00             	lea    0x0(%esi),%esi
80103e68:	83 c2 01             	add    $0x1,%edx
80103e6b:	39 f2                	cmp    %esi,%edx
80103e6d:	74 1e                	je     80103e8d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103e6f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103e75:	0f b6 81 40 38 11 80 	movzbl -0x7feec7c0(%ecx),%eax
80103e7c:	39 d8                	cmp    %ebx,%eax
80103e7e:	75 e8                	jne    80103e68 <mycpu+0x28>
}
80103e80:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103e83:	8d 81 40 38 11 80    	lea    -0x7feec7c0(%ecx),%eax
}
80103e89:	5b                   	pop    %ebx
80103e8a:	5e                   	pop    %esi
80103e8b:	5d                   	pop    %ebp
80103e8c:	c3                   	ret    
  panic("unknown apicid\n");
80103e8d:	83 ec 0c             	sub    $0xc,%esp
80103e90:	68 d6 81 10 80       	push   $0x801081d6
80103e95:	e8 f6 c4 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e9a:	83 ec 0c             	sub    $0xc,%esp
80103e9d:	68 04 83 10 80       	push   $0x80108304
80103ea2:	e8 e9 c4 ff ff       	call   80100390 <panic>
80103ea7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eae:	66 90                	xchg   %ax,%ax

80103eb0 <cpuid>:
cpuid() {
80103eb0:	f3 0f 1e fb          	endbr32 
80103eb4:	55                   	push   %ebp
80103eb5:	89 e5                	mov    %esp,%ebp
80103eb7:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103eba:	e8 81 ff ff ff       	call   80103e40 <mycpu>
}
80103ebf:	c9                   	leave  
  return mycpu()-cpus;
80103ec0:	2d 40 38 11 80       	sub    $0x80113840,%eax
80103ec5:	c1 f8 04             	sar    $0x4,%eax
80103ec8:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103ece:	c3                   	ret    
80103ecf:	90                   	nop

80103ed0 <myproc>:
myproc(void) {
80103ed0:	f3 0f 1e fb          	endbr32 
80103ed4:	55                   	push   %ebp
80103ed5:	89 e5                	mov    %esp,%ebp
80103ed7:	53                   	push   %ebx
80103ed8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103edb:	e8 d0 0e 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80103ee0:	e8 5b ff ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80103ee5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103eeb:	e8 10 0f 00 00       	call   80104e00 <popcli>
}
80103ef0:	83 c4 04             	add    $0x4,%esp
80103ef3:	89 d8                	mov    %ebx,%eax
80103ef5:	5b                   	pop    %ebx
80103ef6:	5d                   	pop    %ebp
80103ef7:	c3                   	ret    
80103ef8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103eff:	90                   	nop

80103f00 <userinit>:
{
80103f00:	f3 0f 1e fb          	endbr32 
80103f04:	55                   	push   %ebp
80103f05:	89 e5                	mov    %esp,%ebp
80103f07:	53                   	push   %ebx
80103f08:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103f0b:	e8 60 fd ff ff       	call   80103c70 <allocproc>
80103f10:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103f12:	a3 74 b6 10 80       	mov    %eax,0x8010b674
  if((p->pgdir = setupkvm()) == 0)
80103f17:	e8 54 3a 00 00       	call   80107970 <setupkvm>
80103f1c:	89 43 04             	mov    %eax,0x4(%ebx)
80103f1f:	85 c0                	test   %eax,%eax
80103f21:	0f 84 bd 00 00 00    	je     80103fe4 <userinit+0xe4>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103f27:	83 ec 04             	sub    $0x4,%esp
80103f2a:	68 2c 00 00 00       	push   $0x2c
80103f2f:	68 80 b4 10 80       	push   $0x8010b480
80103f34:	50                   	push   %eax
80103f35:	e8 06 37 00 00       	call   80107640 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103f3a:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103f3d:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103f43:	6a 4c                	push   $0x4c
80103f45:	6a 00                	push   $0x0
80103f47:	ff 73 1c             	pushl  0x1c(%ebx)
80103f4a:	e8 71 10 00 00       	call   80104fc0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f4f:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f52:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f57:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f5a:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f5f:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f63:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f66:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103f6a:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f6d:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f71:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103f75:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f78:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f7c:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103f80:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f83:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103f8a:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f8d:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103f94:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f97:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f9e:	8d 43 70             	lea    0x70(%ebx),%eax
80103fa1:	6a 10                	push   $0x10
80103fa3:	68 ff 81 10 80       	push   $0x801081ff
80103fa8:	50                   	push   %eax
80103fa9:	e8 d2 11 00 00       	call   80105180 <safestrcpy>
  p->cwd = namei("/");
80103fae:	c7 04 24 08 82 10 80 	movl   $0x80108208,(%esp)
80103fb5:	e8 36 e5 ff ff       	call   801024f0 <namei>
80103fba:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103fbd:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
80103fc4:	e8 e7 0e 00 00       	call   80104eb0 <acquire>
  p->state = RUNNABLE;
80103fc9:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fd0:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
80103fd7:	e8 94 0f 00 00       	call   80104f70 <release>
}
80103fdc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fdf:	83 c4 10             	add    $0x10,%esp
80103fe2:	c9                   	leave  
80103fe3:	c3                   	ret    
    panic("userinit: out of memory?");
80103fe4:	83 ec 0c             	sub    $0xc,%esp
80103fe7:	68 e6 81 10 80       	push   $0x801081e6
80103fec:	e8 9f c3 ff ff       	call   80100390 <panic>
80103ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ff8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103fff:	90                   	nop

80104000 <growproc>:
{
80104000:	f3 0f 1e fb          	endbr32 
80104004:	55                   	push   %ebp
80104005:	89 e5                	mov    %esp,%ebp
80104007:	56                   	push   %esi
80104008:	53                   	push   %ebx
80104009:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
8010400c:	e8 9f 0d 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80104011:	e8 2a fe ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104016:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010401c:	e8 df 0d 00 00       	call   80104e00 <popcli>
  sz = curproc->sz;
80104021:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80104023:	85 f6                	test   %esi,%esi
80104025:	7f 19                	jg     80104040 <growproc+0x40>
  } else if(n < 0){
80104027:	75 37                	jne    80104060 <growproc+0x60>
  switchuvm(curproc);
80104029:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
8010402c:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
8010402e:	53                   	push   %ebx
8010402f:	e8 fc 34 00 00       	call   80107530 <switchuvm>
  return 0;
80104034:	83 c4 10             	add    $0x10,%esp
80104037:	31 c0                	xor    %eax,%eax
}
80104039:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010403c:	5b                   	pop    %ebx
8010403d:	5e                   	pop    %esi
8010403e:	5d                   	pop    %ebp
8010403f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104040:	83 ec 04             	sub    $0x4,%esp
80104043:	01 c6                	add    %eax,%esi
80104045:	56                   	push   %esi
80104046:	50                   	push   %eax
80104047:	ff 73 04             	pushl  0x4(%ebx)
8010404a:	e8 41 37 00 00       	call   80107790 <allocuvm>
8010404f:	83 c4 10             	add    $0x10,%esp
80104052:	85 c0                	test   %eax,%eax
80104054:	75 d3                	jne    80104029 <growproc+0x29>
      return -1;
80104056:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010405b:	eb dc                	jmp    80104039 <growproc+0x39>
8010405d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104060:	83 ec 04             	sub    $0x4,%esp
80104063:	01 c6                	add    %eax,%esi
80104065:	56                   	push   %esi
80104066:	50                   	push   %eax
80104067:	ff 73 04             	pushl  0x4(%ebx)
8010406a:	e8 51 38 00 00       	call   801078c0 <deallocuvm>
8010406f:	83 c4 10             	add    $0x10,%esp
80104072:	85 c0                	test   %eax,%eax
80104074:	75 b3                	jne    80104029 <growproc+0x29>
80104076:	eb de                	jmp    80104056 <growproc+0x56>
80104078:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010407f:	90                   	nop

80104080 <fork>:
{
80104080:	f3 0f 1e fb          	endbr32 
80104084:	55                   	push   %ebp
80104085:	89 e5                	mov    %esp,%ebp
80104087:	57                   	push   %edi
80104088:	56                   	push   %esi
80104089:	53                   	push   %ebx
8010408a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
8010408d:	e8 1e 0d 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80104092:	e8 a9 fd ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104097:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010409d:	e8 5e 0d 00 00       	call   80104e00 <popcli>
  if((np = allocproc()) == 0){
801040a2:	e8 c9 fb ff ff       	call   80103c70 <allocproc>
801040a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801040aa:	85 c0                	test   %eax,%eax
801040ac:	0f 84 c3 00 00 00    	je     80104175 <fork+0xf5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
801040b2:	83 ec 08             	sub    $0x8,%esp
801040b5:	ff 33                	pushl  (%ebx)
801040b7:	89 c7                	mov    %eax,%edi
801040b9:	ff 73 04             	pushl  0x4(%ebx)
801040bc:	e8 7f 39 00 00       	call   80107a40 <copyuvm>
801040c1:	83 c4 10             	add    $0x10,%esp
801040c4:	89 47 04             	mov    %eax,0x4(%edi)
801040c7:	85 c0                	test   %eax,%eax
801040c9:	0f 84 ad 00 00 00    	je     8010417c <fork+0xfc>
  np->sz = curproc->sz;
801040cf:	8b 03                	mov    (%ebx),%eax
801040d1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801040d4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801040d6:	8b 79 1c             	mov    0x1c(%ecx),%edi
  np->parent = curproc;
801040d9:	89 c8                	mov    %ecx,%eax
801040db:	89 59 14             	mov    %ebx,0x14(%ecx)
  np->tracer = 0;
801040de:	c7 41 18 00 00 00 00 	movl   $0x0,0x18(%ecx)
  *np->tf = *curproc->tf;
801040e5:	b9 13 00 00 00       	mov    $0x13,%ecx
801040ea:	8b 73 1c             	mov    0x1c(%ebx),%esi
801040ed:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801040ef:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801040f1:	8b 40 1c             	mov    0x1c(%eax),%eax
801040f4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801040fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040ff:	90                   	nop
    if(curproc->ofile[i])
80104100:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
80104104:	85 c0                	test   %eax,%eax
80104106:	74 13                	je     8010411b <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104108:	83 ec 0c             	sub    $0xc,%esp
8010410b:	50                   	push   %eax
8010410c:	e8 1f d2 ff ff       	call   80101330 <filedup>
80104111:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104114:	83 c4 10             	add    $0x10,%esp
80104117:	89 44 b2 2c          	mov    %eax,0x2c(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
8010411b:	83 c6 01             	add    $0x1,%esi
8010411e:	83 fe 10             	cmp    $0x10,%esi
80104121:	75 dd                	jne    80104100 <fork+0x80>
  np->cwd = idup(curproc->cwd);
80104123:	83 ec 0c             	sub    $0xc,%esp
80104126:	ff 73 6c             	pushl  0x6c(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104129:	83 c3 70             	add    $0x70,%ebx
  np->cwd = idup(curproc->cwd);
8010412c:	e8 bf da ff ff       	call   80101bf0 <idup>
80104131:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104134:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80104137:	89 47 6c             	mov    %eax,0x6c(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
8010413a:	8d 47 70             	lea    0x70(%edi),%eax
8010413d:	6a 10                	push   $0x10
8010413f:	53                   	push   %ebx
80104140:	50                   	push   %eax
80104141:	e8 3a 10 00 00       	call   80105180 <safestrcpy>
  pid = np->pid;
80104146:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104149:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
80104150:	e8 5b 0d 00 00       	call   80104eb0 <acquire>
  np->state = RUNNABLE;
80104155:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010415c:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
80104163:	e8 08 0e 00 00       	call   80104f70 <release>
  return pid;
80104168:	83 c4 10             	add    $0x10,%esp
}
8010416b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010416e:	89 d8                	mov    %ebx,%eax
80104170:	5b                   	pop    %ebx
80104171:	5e                   	pop    %esi
80104172:	5f                   	pop    %edi
80104173:	5d                   	pop    %ebp
80104174:	c3                   	ret    
    return -1;
80104175:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010417a:	eb ef                	jmp    8010416b <fork+0xeb>
    kfree(np->kstack);
8010417c:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010417f:	83 ec 0c             	sub    $0xc,%esp
80104182:	ff 73 08             	pushl  0x8(%ebx)
80104185:	e8 c6 e7 ff ff       	call   80102950 <kfree>
    np->kstack = 0;
8010418a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104191:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104194:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
8010419b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801041a0:	eb c9                	jmp    8010416b <fork+0xeb>
801041a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041b0 <scheduler>:
{
801041b0:	f3 0f 1e fb          	endbr32 
801041b4:	55                   	push   %ebp
801041b5:	89 e5                	mov    %esp,%ebp
801041b7:	57                   	push   %edi
801041b8:	56                   	push   %esi
801041b9:	53                   	push   %ebx
801041ba:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
801041bd:	e8 7e fc ff ff       	call   80103e40 <mycpu>
  c->proc = 0;
801041c2:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801041c9:	00 00 00 
  struct cpu *c = mycpu();
801041cc:	89 c6                	mov    %eax,%esi
  c->proc = 0;
801041ce:	8d 78 04             	lea    0x4(%eax),%edi
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
801041d8:	fb                   	sti    
    acquire(&ptable.lock);
801041d9:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801041dc:	bb 14 3e 11 80       	mov    $0x80113e14,%ebx
    acquire(&ptable.lock);
801041e1:	68 e0 3d 11 80       	push   $0x80113de0
801041e6:	e8 c5 0c 00 00       	call   80104eb0 <acquire>
801041eb:	83 c4 10             	add    $0x10,%esp
801041ee:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
801041f0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801041f4:	75 33                	jne    80104229 <scheduler+0x79>
      switchuvm(p);
801041f6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
801041f9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
801041ff:	53                   	push   %ebx
80104200:	e8 2b 33 00 00       	call   80107530 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104205:	58                   	pop    %eax
80104206:	5a                   	pop    %edx
80104207:	ff 73 20             	pushl  0x20(%ebx)
8010420a:	57                   	push   %edi
      p->state = RUNNING;
8010420b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104212:	e8 cc 0f 00 00       	call   801051e3 <swtch>
      switchkvm();
80104217:	e8 f4 32 00 00       	call   80107510 <switchkvm>
      c->proc = 0;
8010421c:	83 c4 10             	add    $0x10,%esp
8010421f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104226:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104229:	83 eb 80             	sub    $0xffffff80,%ebx
8010422c:	81 fb 14 5e 11 80    	cmp    $0x80115e14,%ebx
80104232:	75 bc                	jne    801041f0 <scheduler+0x40>
    release(&ptable.lock);
80104234:	83 ec 0c             	sub    $0xc,%esp
80104237:	68 e0 3d 11 80       	push   $0x80113de0
8010423c:	e8 2f 0d 00 00       	call   80104f70 <release>
    sti();
80104241:	83 c4 10             	add    $0x10,%esp
80104244:	eb 92                	jmp    801041d8 <scheduler+0x28>
80104246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010424d:	8d 76 00             	lea    0x0(%esi),%esi

80104250 <sched>:
{
80104250:	f3 0f 1e fb          	endbr32 
80104254:	55                   	push   %ebp
80104255:	89 e5                	mov    %esp,%ebp
80104257:	56                   	push   %esi
80104258:	53                   	push   %ebx
  pushcli();
80104259:	e8 52 0b 00 00       	call   80104db0 <pushcli>
  c = mycpu();
8010425e:	e8 dd fb ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104263:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104269:	e8 92 0b 00 00       	call   80104e00 <popcli>
  if(!holding(&ptable.lock))
8010426e:	83 ec 0c             	sub    $0xc,%esp
80104271:	68 e0 3d 11 80       	push   $0x80113de0
80104276:	e8 e5 0b 00 00       	call   80104e60 <holding>
8010427b:	83 c4 10             	add    $0x10,%esp
8010427e:	85 c0                	test   %eax,%eax
80104280:	74 4f                	je     801042d1 <sched+0x81>
  if(mycpu()->ncli != 1)
80104282:	e8 b9 fb ff ff       	call   80103e40 <mycpu>
80104287:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010428e:	75 68                	jne    801042f8 <sched+0xa8>
  if(p->state == RUNNING)
80104290:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104294:	74 55                	je     801042eb <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104296:	9c                   	pushf  
80104297:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104298:	f6 c4 02             	test   $0x2,%ah
8010429b:	75 41                	jne    801042de <sched+0x8e>
  intena = mycpu()->intena;
8010429d:	e8 9e fb ff ff       	call   80103e40 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801042a2:	83 c3 20             	add    $0x20,%ebx
  intena = mycpu()->intena;
801042a5:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801042ab:	e8 90 fb ff ff       	call   80103e40 <mycpu>
801042b0:	83 ec 08             	sub    $0x8,%esp
801042b3:	ff 70 04             	pushl  0x4(%eax)
801042b6:	53                   	push   %ebx
801042b7:	e8 27 0f 00 00       	call   801051e3 <swtch>
  mycpu()->intena = intena;
801042bc:	e8 7f fb ff ff       	call   80103e40 <mycpu>
}
801042c1:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801042c4:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801042ca:	8d 65 f8             	lea    -0x8(%ebp),%esp
801042cd:	5b                   	pop    %ebx
801042ce:	5e                   	pop    %esi
801042cf:	5d                   	pop    %ebp
801042d0:	c3                   	ret    
    panic("sched ptable.lock");
801042d1:	83 ec 0c             	sub    $0xc,%esp
801042d4:	68 0a 82 10 80       	push   $0x8010820a
801042d9:	e8 b2 c0 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801042de:	83 ec 0c             	sub    $0xc,%esp
801042e1:	68 36 82 10 80       	push   $0x80108236
801042e6:	e8 a5 c0 ff ff       	call   80100390 <panic>
    panic("sched running");
801042eb:	83 ec 0c             	sub    $0xc,%esp
801042ee:	68 28 82 10 80       	push   $0x80108228
801042f3:	e8 98 c0 ff ff       	call   80100390 <panic>
    panic("sched locks");
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	68 1c 82 10 80       	push   $0x8010821c
80104300:	e8 8b c0 ff ff       	call   80100390 <panic>
80104305:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010430c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104310 <exit>:
{
80104310:	f3 0f 1e fb          	endbr32 
80104314:	55                   	push   %ebp
80104315:	89 e5                	mov    %esp,%ebp
80104317:	57                   	push   %edi
80104318:	56                   	push   %esi
80104319:	53                   	push   %ebx
8010431a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010431d:	e8 8e 0a 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80104322:	e8 19 fb ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104327:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010432d:	e8 ce 0a 00 00       	call   80104e00 <popcli>
  if(curproc == initproc)
80104332:	8d 5e 2c             	lea    0x2c(%esi),%ebx
80104335:	8d 7e 6c             	lea    0x6c(%esi),%edi
80104338:	39 35 74 b6 10 80    	cmp    %esi,0x8010b674
8010433e:	0f 84 f3 00 00 00    	je     80104437 <exit+0x127>
80104344:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104348:	8b 03                	mov    (%ebx),%eax
8010434a:	85 c0                	test   %eax,%eax
8010434c:	74 12                	je     80104360 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010434e:	83 ec 0c             	sub    $0xc,%esp
80104351:	50                   	push   %eax
80104352:	e8 29 d0 ff ff       	call   80101380 <fileclose>
      curproc->ofile[fd] = 0;
80104357:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010435d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104360:	83 c3 04             	add    $0x4,%ebx
80104363:	39 df                	cmp    %ebx,%edi
80104365:	75 e1                	jne    80104348 <exit+0x38>
  begin_op();
80104367:	e8 a4 ee ff ff       	call   80103210 <begin_op>
  iput(curproc->cwd);
8010436c:	83 ec 0c             	sub    $0xc,%esp
8010436f:	ff 76 6c             	pushl  0x6c(%esi)
80104372:	e8 d9 d9 ff ff       	call   80101d50 <iput>
  end_op();
80104377:	e8 04 ef ff ff       	call   80103280 <end_op>
  curproc->cwd = 0;
8010437c:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
  acquire(&ptable.lock);
80104383:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
8010438a:	e8 21 0b 00 00       	call   80104eb0 <acquire>
  wakeup1(curproc->parent);
8010438f:	8b 56 14             	mov    0x14(%esi),%edx
80104392:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104395:	b8 14 3e 11 80       	mov    $0x80113e14,%eax
8010439a:	eb 0e                	jmp    801043aa <exit+0x9a>
8010439c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043a0:	83 e8 80             	sub    $0xffffff80,%eax
801043a3:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
801043a8:	74 1c                	je     801043c6 <exit+0xb6>
    if(p->state == SLEEPING && p->chan == chan)
801043aa:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801043ae:	75 f0                	jne    801043a0 <exit+0x90>
801043b0:	3b 50 24             	cmp    0x24(%eax),%edx
801043b3:	75 eb                	jne    801043a0 <exit+0x90>
      p->state = RUNNABLE;
801043b5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043bc:	83 e8 80             	sub    $0xffffff80,%eax
801043bf:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
801043c4:	75 e4                	jne    801043aa <exit+0x9a>
      p->parent = initproc;
801043c6:	8b 0d 74 b6 10 80    	mov    0x8010b674,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043cc:	ba 14 3e 11 80       	mov    $0x80113e14,%edx
801043d1:	eb 10                	jmp    801043e3 <exit+0xd3>
801043d3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043d7:	90                   	nop
801043d8:	83 ea 80             	sub    $0xffffff80,%edx
801043db:	81 fa 14 5e 11 80    	cmp    $0x80115e14,%edx
801043e1:	74 3b                	je     8010441e <exit+0x10e>
    if(p->parent == curproc){
801043e3:	39 72 14             	cmp    %esi,0x14(%edx)
801043e6:	75 f0                	jne    801043d8 <exit+0xc8>
      if(p->state == ZOMBIE)
801043e8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801043ec:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801043ef:	75 e7                	jne    801043d8 <exit+0xc8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043f1:	b8 14 3e 11 80       	mov    $0x80113e14,%eax
801043f6:	eb 12                	jmp    8010440a <exit+0xfa>
801043f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043ff:	90                   	nop
80104400:	83 e8 80             	sub    $0xffffff80,%eax
80104403:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
80104408:	74 ce                	je     801043d8 <exit+0xc8>
    if(p->state == SLEEPING && p->chan == chan)
8010440a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010440e:	75 f0                	jne    80104400 <exit+0xf0>
80104410:	3b 48 24             	cmp    0x24(%eax),%ecx
80104413:	75 eb                	jne    80104400 <exit+0xf0>
      p->state = RUNNABLE;
80104415:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010441c:	eb e2                	jmp    80104400 <exit+0xf0>
  curproc->state = ZOMBIE;
8010441e:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80104425:	e8 26 fe ff ff       	call   80104250 <sched>
  panic("zombie exit");
8010442a:	83 ec 0c             	sub    $0xc,%esp
8010442d:	68 57 82 10 80       	push   $0x80108257
80104432:	e8 59 bf ff ff       	call   80100390 <panic>
    panic("init exiting");
80104437:	83 ec 0c             	sub    $0xc,%esp
8010443a:	68 4a 82 10 80       	push   $0x8010824a
8010443f:	e8 4c bf ff ff       	call   80100390 <panic>
80104444:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010444b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010444f:	90                   	nop

80104450 <yield>:
{
80104450:	f3 0f 1e fb          	endbr32 
80104454:	55                   	push   %ebp
80104455:	89 e5                	mov    %esp,%ebp
80104457:	53                   	push   %ebx
80104458:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010445b:	68 e0 3d 11 80       	push   $0x80113de0
80104460:	e8 4b 0a 00 00       	call   80104eb0 <acquire>
  pushcli();
80104465:	e8 46 09 00 00       	call   80104db0 <pushcli>
  c = mycpu();
8010446a:	e8 d1 f9 ff ff       	call   80103e40 <mycpu>
  p = c->proc;
8010446f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104475:	e8 86 09 00 00       	call   80104e00 <popcli>
  myproc()->state = RUNNABLE;
8010447a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104481:	e8 ca fd ff ff       	call   80104250 <sched>
  release(&ptable.lock);
80104486:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
8010448d:	e8 de 0a 00 00       	call   80104f70 <release>
}
80104492:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104495:	83 c4 10             	add    $0x10,%esp
80104498:	c9                   	leave  
80104499:	c3                   	ret    
8010449a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801044a0 <sleep>:
{
801044a0:	f3 0f 1e fb          	endbr32 
801044a4:	55                   	push   %ebp
801044a5:	89 e5                	mov    %esp,%ebp
801044a7:	57                   	push   %edi
801044a8:	56                   	push   %esi
801044a9:	53                   	push   %ebx
801044aa:	83 ec 0c             	sub    $0xc,%esp
801044ad:	8b 7d 08             	mov    0x8(%ebp),%edi
801044b0:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801044b3:	e8 f8 08 00 00       	call   80104db0 <pushcli>
  c = mycpu();
801044b8:	e8 83 f9 ff ff       	call   80103e40 <mycpu>
  p = c->proc;
801044bd:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801044c3:	e8 38 09 00 00       	call   80104e00 <popcli>
  if(p == 0)
801044c8:	85 db                	test   %ebx,%ebx
801044ca:	0f 84 83 00 00 00    	je     80104553 <sleep+0xb3>
  if(lk == 0)
801044d0:	85 f6                	test   %esi,%esi
801044d2:	74 72                	je     80104546 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801044d4:	81 fe e0 3d 11 80    	cmp    $0x80113de0,%esi
801044da:	74 4c                	je     80104528 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801044dc:	83 ec 0c             	sub    $0xc,%esp
801044df:	68 e0 3d 11 80       	push   $0x80113de0
801044e4:	e8 c7 09 00 00       	call   80104eb0 <acquire>
    release(lk);
801044e9:	89 34 24             	mov    %esi,(%esp)
801044ec:	e8 7f 0a 00 00       	call   80104f70 <release>
  p->chan = chan;
801044f1:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
801044f4:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801044fb:	e8 50 fd ff ff       	call   80104250 <sched>
  p->chan = 0;
80104500:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
    release(&ptable.lock);
80104507:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
8010450e:	e8 5d 0a 00 00       	call   80104f70 <release>
    acquire(lk);
80104513:	89 75 08             	mov    %esi,0x8(%ebp)
80104516:	83 c4 10             	add    $0x10,%esp
}
80104519:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010451c:	5b                   	pop    %ebx
8010451d:	5e                   	pop    %esi
8010451e:	5f                   	pop    %edi
8010451f:	5d                   	pop    %ebp
    acquire(lk);
80104520:	e9 8b 09 00 00       	jmp    80104eb0 <acquire>
80104525:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
80104528:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
8010452b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104532:	e8 19 fd ff ff       	call   80104250 <sched>
  p->chan = 0;
80104537:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
8010453e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104541:	5b                   	pop    %ebx
80104542:	5e                   	pop    %esi
80104543:	5f                   	pop    %edi
80104544:	5d                   	pop    %ebp
80104545:	c3                   	ret    
    panic("sleep without lk");
80104546:	83 ec 0c             	sub    $0xc,%esp
80104549:	68 69 82 10 80       	push   $0x80108269
8010454e:	e8 3d be ff ff       	call   80100390 <panic>
    panic("sleep");
80104553:	83 ec 0c             	sub    $0xc,%esp
80104556:	68 63 82 10 80       	push   $0x80108263
8010455b:	e8 30 be ff ff       	call   80100390 <panic>

80104560 <wait>:
{
80104560:	f3 0f 1e fb          	endbr32 
80104564:	55                   	push   %ebp
80104565:	89 e5                	mov    %esp,%ebp
80104567:	56                   	push   %esi
80104568:	53                   	push   %ebx
  pushcli();
80104569:	e8 42 08 00 00       	call   80104db0 <pushcli>
  c = mycpu();
8010456e:	e8 cd f8 ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104573:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104579:	e8 82 08 00 00       	call   80104e00 <popcli>
  acquire(&ptable.lock);
8010457e:	83 ec 0c             	sub    $0xc,%esp
80104581:	68 e0 3d 11 80       	push   $0x80113de0
80104586:	e8 25 09 00 00       	call   80104eb0 <acquire>
8010458b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010458e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104590:	bb 14 3e 11 80       	mov    $0x80113e14,%ebx
80104595:	eb 14                	jmp    801045ab <wait+0x4b>
80104597:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010459e:	66 90                	xchg   %ax,%ax
801045a0:	83 eb 80             	sub    $0xffffff80,%ebx
801045a3:	81 fb 14 5e 11 80    	cmp    $0x80115e14,%ebx
801045a9:	74 1b                	je     801045c6 <wait+0x66>
      if(p->parent != curproc)
801045ab:	39 73 14             	cmp    %esi,0x14(%ebx)
801045ae:	75 f0                	jne    801045a0 <wait+0x40>
      if(p->state == ZOMBIE){
801045b0:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801045b4:	74 32                	je     801045e8 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045b6:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
801045b9:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801045be:	81 fb 14 5e 11 80    	cmp    $0x80115e14,%ebx
801045c4:	75 e5                	jne    801045ab <wait+0x4b>
    if(!havekids || curproc->killed){
801045c6:	85 c0                	test   %eax,%eax
801045c8:	74 74                	je     8010463e <wait+0xde>
801045ca:	8b 46 28             	mov    0x28(%esi),%eax
801045cd:	85 c0                	test   %eax,%eax
801045cf:	75 6d                	jne    8010463e <wait+0xde>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
801045d1:	83 ec 08             	sub    $0x8,%esp
801045d4:	68 e0 3d 11 80       	push   $0x80113de0
801045d9:	56                   	push   %esi
801045da:	e8 c1 fe ff ff       	call   801044a0 <sleep>
    havekids = 0;
801045df:	83 c4 10             	add    $0x10,%esp
801045e2:	eb aa                	jmp    8010458e <wait+0x2e>
801045e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        kfree(p->kstack);
801045e8:	83 ec 0c             	sub    $0xc,%esp
801045eb:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
801045ee:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801045f1:	e8 5a e3 ff ff       	call   80102950 <kfree>
        freevm(p->pgdir);
801045f6:	5a                   	pop    %edx
801045f7:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
801045fa:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104601:	e8 ea 32 00 00       	call   801078f0 <freevm>
        release(&ptable.lock);
80104606:	c7 04 24 e0 3d 11 80 	movl   $0x80113de0,(%esp)
        p->pid = 0;
8010460d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104614:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010461b:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
8010461f:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
        p->state = UNUSED;
80104626:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010462d:	e8 3e 09 00 00       	call   80104f70 <release>
        return pid;
80104632:	83 c4 10             	add    $0x10,%esp
}
80104635:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104638:	89 f0                	mov    %esi,%eax
8010463a:	5b                   	pop    %ebx
8010463b:	5e                   	pop    %esi
8010463c:	5d                   	pop    %ebp
8010463d:	c3                   	ret    
      release(&ptable.lock);
8010463e:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104641:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104646:	68 e0 3d 11 80       	push   $0x80113de0
8010464b:	e8 20 09 00 00       	call   80104f70 <release>
      return -1;
80104650:	83 c4 10             	add    $0x10,%esp
80104653:	eb e0                	jmp    80104635 <wait+0xd5>
80104655:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010465c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104660 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104660:	f3 0f 1e fb          	endbr32 
80104664:	55                   	push   %ebp
80104665:	89 e5                	mov    %esp,%ebp
80104667:	53                   	push   %ebx
80104668:	83 ec 10             	sub    $0x10,%esp
8010466b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010466e:	68 e0 3d 11 80       	push   $0x80113de0
80104673:	e8 38 08 00 00       	call   80104eb0 <acquire>
80104678:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010467b:	b8 14 3e 11 80       	mov    $0x80113e14,%eax
80104680:	eb 10                	jmp    80104692 <wakeup+0x32>
80104682:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104688:	83 e8 80             	sub    $0xffffff80,%eax
8010468b:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
80104690:	74 1c                	je     801046ae <wakeup+0x4e>
    if(p->state == SLEEPING && p->chan == chan)
80104692:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104696:	75 f0                	jne    80104688 <wakeup+0x28>
80104698:	3b 58 24             	cmp    0x24(%eax),%ebx
8010469b:	75 eb                	jne    80104688 <wakeup+0x28>
      p->state = RUNNABLE;
8010469d:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046a4:	83 e8 80             	sub    $0xffffff80,%eax
801046a7:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
801046ac:	75 e4                	jne    80104692 <wakeup+0x32>
  wakeup1(chan);
  release(&ptable.lock);
801046ae:	c7 45 08 e0 3d 11 80 	movl   $0x80113de0,0x8(%ebp)
}
801046b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046b8:	c9                   	leave  
  release(&ptable.lock);
801046b9:	e9 b2 08 00 00       	jmp    80104f70 <release>
801046be:	66 90                	xchg   %ax,%ax

801046c0 <test>:
void test(int phnum){
801046c0:	f3 0f 1e fb          	endbr32 
801046c4:	55                   	push   %ebp
801046c5:	89 e5                	mov    %esp,%ebp
801046c7:	57                   	push   %edi
801046c8:	56                   	push   %esi
801046c9:	53                   	push   %ebx
801046ca:	83 ec 0c             	sub    $0xc,%esp
801046cd:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (state[phnum] == HUNGRY
801046d0:	83 3c 9d 1c b0 10 80 	cmpl   $0x1,-0x7fef4fe4(,%ebx,4)
801046d7:	01 
801046d8:	74 0e                	je     801046e8 <test+0x28>
}
801046da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801046dd:	5b                   	pop    %ebx
801046de:	5e                   	pop    %esi
801046df:	5f                   	pop    %edi
801046e0:	5d                   	pop    %ebp
801046e1:	c3                   	ret    
801046e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    int left = (phnum + 4) % 5;
801046e8:	8d 7b 04             	lea    0x4(%ebx),%edi
801046eb:	be 67 66 66 66       	mov    $0x66666667,%esi
801046f0:	89 f8                	mov    %edi,%eax
801046f2:	f7 ee                	imul   %esi
801046f4:	89 f8                	mov    %edi,%eax
801046f6:	c1 f8 1f             	sar    $0x1f,%eax
801046f9:	d1 fa                	sar    %edx
801046fb:	89 d1                	mov    %edx,%ecx
801046fd:	29 c1                	sub    %eax,%ecx
801046ff:	8d 04 89             	lea    (%ecx,%ecx,4),%eax
80104702:	29 c7                	sub    %eax,%edi
80104704:	89 f9                	mov    %edi,%ecx
      && state[left] != EATING
80104706:	8b 3c bd 1c b0 10 80 	mov    -0x7fef4fe4(,%edi,4),%edi
8010470d:	85 ff                	test   %edi,%edi
8010470f:	74 c9                	je     801046da <test+0x1a>
    int right = (phnum + 1) % 5;
80104711:	8d 7b 01             	lea    0x1(%ebx),%edi
80104714:	89 f8                	mov    %edi,%eax
80104716:	f7 ee                	imul   %esi
80104718:	89 f8                	mov    %edi,%eax
8010471a:	89 fe                	mov    %edi,%esi
8010471c:	c1 f8 1f             	sar    $0x1f,%eax
8010471f:	d1 fa                	sar    %edx
80104721:	29 c2                	sub    %eax,%edx
80104723:	8d 04 92             	lea    (%edx,%edx,4),%eax
80104726:	29 c6                	sub    %eax,%esi
      && state[right] != EATING) {
80104728:	8b 34 b5 1c b0 10 80 	mov    -0x7fef4fe4(,%esi,4),%esi
8010472f:	85 f6                	test   %esi,%esi
80104731:	74 a7                	je     801046da <test+0x1a>
      cprintf("Philosopher %d takes fork %d and %d\n",phnum + 1, left + 1, phnum + 1);
80104733:	83 c1 01             	add    $0x1,%ecx
80104736:	57                   	push   %edi
80104737:	51                   	push   %ecx
80104738:	57                   	push   %edi
80104739:	68 2c 83 10 80       	push   $0x8010832c
      state[phnum] = 0;
8010473e:	c7 04 9d 1c b0 10 80 	movl   $0x0,-0x7fef4fe4(,%ebx,4)
80104745:	00 00 00 00 
      cprintf("Philosopher %d takes fork %d and %d\n",phnum + 1, left + 1, phnum + 1);
80104749:	e8 62 bf ff ff       	call   801006b0 <cprintf>
      cprintf("Philosopher %d is Eating\n", phnum + 1);
8010474e:	58                   	pop    %eax
8010474f:	5a                   	pop    %edx
80104750:	57                   	push   %edi
80104751:	68 7a 82 10 80       	push   $0x8010827a
80104756:	e8 55 bf ff ff       	call   801006b0 <cprintf>
      wakeup(&condition);
8010475b:	c7 45 08 40 b6 10 80 	movl   $0x8010b640,0x8(%ebp)
80104762:	83 c4 10             	add    $0x10,%esp
}
80104765:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104768:	5b                   	pop    %ebx
80104769:	5e                   	pop    %esi
8010476a:	5f                   	pop    %edi
8010476b:	5d                   	pop    %ebp
      wakeup(&condition);
8010476c:	e9 ef fe ff ff       	jmp    80104660 <wakeup>
80104771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104778:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010477f:	90                   	nop

80104780 <put_fork>:
void put_fork(int phnum){
80104780:	f3 0f 1e fb          	endbr32 
80104784:	55                   	push   %ebp
80104785:	89 e5                	mov    %esp,%ebp
80104787:	57                   	push   %edi
80104788:	56                   	push   %esi
80104789:	53                   	push   %ebx
  int left = (phnum + 4) % 5;
8010478a:	bb 67 66 66 66       	mov    $0x66666667,%ebx
void put_fork(int phnum){
8010478f:	83 ec 1c             	sub    $0x1c,%esp
80104792:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int left = (phnum + 4) % 5;
80104795:	8d 71 04             	lea    0x4(%ecx),%esi
  int right = (phnum + 1) % 5;
80104798:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  int left = (phnum + 4) % 5;
8010479b:	89 f0                	mov    %esi,%eax
8010479d:	f7 eb                	imul   %ebx
8010479f:	89 f0                	mov    %esi,%eax
801047a1:	c1 f8 1f             	sar    $0x1f,%eax
801047a4:	d1 fa                	sar    %edx
801047a6:	89 d7                	mov    %edx,%edi
801047a8:	29 c7                	sub    %eax,%edi
801047aa:	8d 04 bf             	lea    (%edi,%edi,4),%eax
801047ad:	89 f7                	mov    %esi,%edi
  int right = (phnum + 1) % 5;
801047af:	8d 71 01             	lea    0x1(%ecx),%esi
  int left = (phnum + 4) % 5;
801047b2:	29 c7                	sub    %eax,%edi
  cprintf("Philosopher %d putting fork %d and %d down\n", phnum + 1, left + 1, phnum + 1);
801047b4:	56                   	push   %esi
801047b5:	8d 47 01             	lea    0x1(%edi),%eax
801047b8:	50                   	push   %eax
801047b9:	56                   	push   %esi
801047ba:	68 54 83 10 80       	push   $0x80108354
801047bf:	e8 ec be ff ff       	call   801006b0 <cprintf>
  cprintf("Philosopher %d is thinking\n", phnum + 1);
801047c4:	58                   	pop    %eax
801047c5:	5a                   	pop    %edx
801047c6:	56                   	push   %esi
801047c7:	68 94 82 10 80       	push   $0x80108294
801047cc:	e8 df be ff ff       	call   801006b0 <cprintf>
  state[phnum] = 2;
801047d1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  test(left);
801047d4:	89 3c 24             	mov    %edi,(%esp)
  state[phnum] = 2;
801047d7:	c7 04 8d 1c b0 10 80 	movl   $0x2,-0x7fef4fe4(,%ecx,4)
801047de:	02 00 00 00 
  test(left);
801047e2:	e8 d9 fe ff ff       	call   801046c0 <test>
  int right = (phnum + 1) % 5;
801047e7:	89 f0                	mov    %esi,%eax
  test(right);
801047e9:	83 c4 10             	add    $0x10,%esp
  int right = (phnum + 1) % 5;
801047ec:	f7 eb                	imul   %ebx
801047ee:	89 f0                	mov    %esi,%eax
801047f0:	c1 f8 1f             	sar    $0x1f,%eax
801047f3:	d1 fa                	sar    %edx
801047f5:	29 c2                	sub    %eax,%edx
801047f7:	8d 04 92             	lea    (%edx,%edx,4),%eax
801047fa:	29 c6                	sub    %eax,%esi
  test(right);
801047fc:	89 75 08             	mov    %esi,0x8(%ebp)
}
801047ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104802:	5b                   	pop    %ebx
80104803:	5e                   	pop    %esi
80104804:	5f                   	pop    %edi
80104805:	5d                   	pop    %ebp
  test(right);
80104806:	e9 b5 fe ff ff       	jmp    801046c0 <test>
8010480b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010480f:	90                   	nop

80104810 <dining>:
{
80104810:	f3 0f 1e fb          	endbr32 
80104814:	55                   	push   %ebp
80104815:	89 e5                	mov    %esp,%ebp
80104817:	53                   	push   %ebx
80104818:	83 ec 10             	sub    $0x10,%esp
8010481b:	8b 5d 08             	mov    0x8(%ebp),%ebx
    acquire(&lk);
8010481e:	68 00 b6 10 80       	push   $0x8010b600
80104823:	e8 88 06 00 00       	call   80104eb0 <acquire>
  if(state[phnum] != EATING){
80104828:	8b 0c 9d 1c b0 10 80 	mov    -0x7fef4fe4(,%ebx,4),%ecx
8010482f:	83 c4 10             	add    $0x10,%esp
80104832:	85 c9                	test   %ecx,%ecx
80104834:	75 22                	jne    80104858 <dining+0x48>
    put_fork(index);
80104836:	83 ec 0c             	sub    $0xc,%esp
80104839:	53                   	push   %ebx
8010483a:	e8 41 ff ff ff       	call   80104780 <put_fork>
    release(&lk);
8010483f:	c7 45 08 00 b6 10 80 	movl   $0x8010b600,0x8(%ebp)
}
80104846:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    release(&lk);
80104849:	83 c4 10             	add    $0x10,%esp
}
8010484c:	c9                   	leave  
    release(&lk);
8010484d:	e9 1e 07 00 00       	jmp    80104f70 <release>
80104852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("Philosopher %d is Hungry\n", phnum + 1);
80104858:	83 ec 08             	sub    $0x8,%esp
8010485b:	8d 43 01             	lea    0x1(%ebx),%eax
    state[phnum] = HUNGRY;
8010485e:	c7 04 9d 1c b0 10 80 	movl   $0x1,-0x7fef4fe4(,%ebx,4)
80104865:	01 00 00 00 
    cprintf("Philosopher %d is Hungry\n", phnum + 1);
80104869:	50                   	push   %eax
8010486a:	68 b0 82 10 80       	push   $0x801082b0
8010486f:	e8 3c be ff ff       	call   801006b0 <cprintf>
    test(phnum);
80104874:	89 1c 24             	mov    %ebx,(%esp)
80104877:	e8 44 fe ff ff       	call   801046c0 <test>
    while(state[index] != EATING)
8010487c:	8b 14 9d 1c b0 10 80 	mov    -0x7fef4fe4(,%ebx,4),%edx
80104883:	83 c4 10             	add    $0x10,%esp
80104886:	85 d2                	test   %edx,%edx
80104888:	74 ac                	je     80104836 <dining+0x26>
8010488a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      sleep(&condition, &lk);
80104890:	83 ec 08             	sub    $0x8,%esp
80104893:	68 00 b6 10 80       	push   $0x8010b600
80104898:	68 40 b6 10 80       	push   $0x8010b640
8010489d:	e8 fe fb ff ff       	call   801044a0 <sleep>
    while(state[index] != EATING)
801048a2:	8b 04 9d 1c b0 10 80 	mov    -0x7fef4fe4(,%ebx,4),%eax
801048a9:	83 c4 10             	add    $0x10,%esp
801048ac:	85 c0                	test   %eax,%eax
801048ae:	75 e0                	jne    80104890 <dining+0x80>
801048b0:	eb 84                	jmp    80104836 <dining+0x26>
801048b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801048b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801048c0 <take_fork>:
void take_fork(int phnum){
801048c0:	f3 0f 1e fb          	endbr32 
801048c4:	55                   	push   %ebp
801048c5:	89 e5                	mov    %esp,%ebp
801048c7:	53                   	push   %ebx
801048c8:	83 ec 04             	sub    $0x4,%esp
801048cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(state[phnum] != EATING){
801048ce:	8b 04 9d 1c b0 10 80 	mov    -0x7fef4fe4(,%ebx,4),%eax
801048d5:	85 c0                	test   %eax,%eax
801048d7:	75 07                	jne    801048e0 <take_fork+0x20>
}
801048d9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048dc:	c9                   	leave  
801048dd:	c3                   	ret    
801048de:	66 90                	xchg   %ax,%ax
    cprintf("Philosopher %d is Hungry\n", phnum + 1);
801048e0:	83 ec 08             	sub    $0x8,%esp
801048e3:	8d 43 01             	lea    0x1(%ebx),%eax
    state[phnum] = HUNGRY;
801048e6:	c7 04 9d 1c b0 10 80 	movl   $0x1,-0x7fef4fe4(,%ebx,4)
801048ed:	01 00 00 00 
    cprintf("Philosopher %d is Hungry\n", phnum + 1);
801048f1:	50                   	push   %eax
801048f2:	68 b0 82 10 80       	push   $0x801082b0
801048f7:	e8 b4 bd ff ff       	call   801006b0 <cprintf>
    test(phnum);
801048fc:	89 5d 08             	mov    %ebx,0x8(%ebp)
801048ff:	83 c4 10             	add    $0x10,%esp
}
80104902:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104905:	c9                   	leave  
    test(phnum);
80104906:	e9 b5 fd ff ff       	jmp    801046c0 <test>
8010490b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010490f:	90                   	nop

80104910 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104910:	f3 0f 1e fb          	endbr32 
80104914:	55                   	push   %ebp
80104915:	89 e5                	mov    %esp,%ebp
80104917:	53                   	push   %ebx
80104918:	83 ec 10             	sub    $0x10,%esp
8010491b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010491e:	68 e0 3d 11 80       	push   $0x80113de0
80104923:	e8 88 05 00 00       	call   80104eb0 <acquire>
80104928:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010492b:	b8 14 3e 11 80       	mov    $0x80113e14,%eax
80104930:	eb 10                	jmp    80104942 <kill+0x32>
80104932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104938:	83 e8 80             	sub    $0xffffff80,%eax
8010493b:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
80104940:	74 36                	je     80104978 <kill+0x68>
    if(p->pid == pid){
80104942:	39 58 10             	cmp    %ebx,0x10(%eax)
80104945:	75 f1                	jne    80104938 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104947:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
8010494b:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      if(p->state == SLEEPING)
80104952:	75 07                	jne    8010495b <kill+0x4b>
        p->state = RUNNABLE;
80104954:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
8010495b:	83 ec 0c             	sub    $0xc,%esp
8010495e:	68 e0 3d 11 80       	push   $0x80113de0
80104963:	e8 08 06 00 00       	call   80104f70 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104968:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
8010496b:	83 c4 10             	add    $0x10,%esp
8010496e:	31 c0                	xor    %eax,%eax
}
80104970:	c9                   	leave  
80104971:	c3                   	ret    
80104972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104978:	83 ec 0c             	sub    $0xc,%esp
8010497b:	68 e0 3d 11 80       	push   $0x80113de0
80104980:	e8 eb 05 00 00       	call   80104f70 <release>
}
80104985:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104988:	83 c4 10             	add    $0x10,%esp
8010498b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104990:	c9                   	leave  
80104991:	c3                   	ret    
80104992:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801049a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801049a0:	f3 0f 1e fb          	endbr32 
801049a4:	55                   	push   %ebp
801049a5:	89 e5                	mov    %esp,%ebp
801049a7:	57                   	push   %edi
801049a8:	56                   	push   %esi
801049a9:	8d 75 e8             	lea    -0x18(%ebp),%esi
801049ac:	53                   	push   %ebx
801049ad:	bb 84 3e 11 80       	mov    $0x80113e84,%ebx
801049b2:	83 ec 3c             	sub    $0x3c,%esp
801049b5:	eb 28                	jmp    801049df <procdump+0x3f>
801049b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801049be:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801049c0:	83 ec 0c             	sub    $0xc,%esp
801049c3:	68 cd 81 10 80       	push   $0x801081cd
801049c8:	e8 e3 bc ff ff       	call   801006b0 <cprintf>
801049cd:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801049d0:	83 eb 80             	sub    $0xffffff80,%ebx
801049d3:	81 fb 84 5e 11 80    	cmp    $0x80115e84,%ebx
801049d9:	0f 84 81 00 00 00    	je     80104a60 <procdump+0xc0>
    if(p->state == UNUSED)
801049df:	8b 43 9c             	mov    -0x64(%ebx),%eax
801049e2:	85 c0                	test   %eax,%eax
801049e4:	74 ea                	je     801049d0 <procdump+0x30>
      state = "???";
801049e6:	ba ca 82 10 80       	mov    $0x801082ca,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801049eb:	83 f8 05             	cmp    $0x5,%eax
801049ee:	77 11                	ja     80104a01 <procdump+0x61>
801049f0:	8b 14 85 80 83 10 80 	mov    -0x7fef7c80(,%eax,4),%edx
      state = "???";
801049f7:	b8 ca 82 10 80       	mov    $0x801082ca,%eax
801049fc:	85 d2                	test   %edx,%edx
801049fe:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104a01:	53                   	push   %ebx
80104a02:	52                   	push   %edx
80104a03:	ff 73 a0             	pushl  -0x60(%ebx)
80104a06:	68 ce 82 10 80       	push   $0x801082ce
80104a0b:	e8 a0 bc ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104a10:	83 c4 10             	add    $0x10,%esp
80104a13:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104a17:	75 a7                	jne    801049c0 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104a19:	83 ec 08             	sub    $0x8,%esp
80104a1c:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104a1f:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104a22:	50                   	push   %eax
80104a23:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104a26:	8b 40 0c             	mov    0xc(%eax),%eax
80104a29:	83 c0 08             	add    $0x8,%eax
80104a2c:	50                   	push   %eax
80104a2d:	e8 1e 03 00 00       	call   80104d50 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104a32:	83 c4 10             	add    $0x10,%esp
80104a35:	8d 76 00             	lea    0x0(%esi),%esi
80104a38:	8b 17                	mov    (%edi),%edx
80104a3a:	85 d2                	test   %edx,%edx
80104a3c:	74 82                	je     801049c0 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104a3e:	83 ec 08             	sub    $0x8,%esp
80104a41:	83 c7 04             	add    $0x4,%edi
80104a44:	52                   	push   %edx
80104a45:	68 41 7c 10 80       	push   $0x80107c41
80104a4a:	e8 61 bc ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104a4f:	83 c4 10             	add    $0x10,%esp
80104a52:	39 fe                	cmp    %edi,%esi
80104a54:	75 e2                	jne    80104a38 <procdump+0x98>
80104a56:	e9 65 ff ff ff       	jmp    801049c0 <procdump+0x20>
80104a5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a5f:	90                   	nop
  }
}
80104a60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a63:	5b                   	pop    %ebx
80104a64:	5e                   	pop    %esi
80104a65:	5f                   	pop    %edi
80104a66:	5d                   	pop    %ebp
80104a67:	c3                   	ret    
80104a68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a6f:	90                   	nop

80104a70 <wait_sleeping>:


int
wait_sleeping(void)
{
80104a70:	f3 0f 1e fb          	endbr32 
80104a74:	55                   	push   %ebp
80104a75:	89 e5                	mov    %esp,%ebp
80104a77:	53                   	push   %ebx
80104a78:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104a7b:	e8 30 03 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80104a80:	e8 bb f3 ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104a85:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104a8b:	e8 70 03 00 00       	call   80104e00 <popcli>
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104a90:	83 ec 0c             	sub    $0xc,%esp
80104a93:	68 e0 3d 11 80       	push   $0x80113de0
80104a98:	e8 13 04 00 00       	call   80104eb0 <acquire>
80104a9d:	83 c4 10             	add    $0x10,%esp
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104aa0:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa2:	b8 14 3e 11 80       	mov    $0x80113e14,%eax
80104aa7:	eb 11                	jmp    80104aba <wait_sleeping+0x4a>
80104aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ab0:	83 e8 80             	sub    $0xffffff80,%eax
80104ab3:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
80104ab8:	74 1a                	je     80104ad4 <wait_sleeping+0x64>
            if(p->tracer != curproc)
80104aba:	39 58 18             	cmp    %ebx,0x18(%eax)
80104abd:	75 f1                	jne    80104ab0 <wait_sleeping+0x40>
                continue;
            havekids = 1;
            if(p->state == SLEEPING){
80104abf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104ac3:	74 33                	je     80104af8 <wait_sleeping+0x88>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac5:	83 e8 80             	sub    $0xffffff80,%eax
            havekids = 1;
80104ac8:	ba 01 00 00 00       	mov    $0x1,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104acd:	3d 14 5e 11 80       	cmp    $0x80115e14,%eax
80104ad2:	75 e6                	jne    80104aba <wait_sleeping+0x4a>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104ad4:	85 d2                	test   %edx,%edx
80104ad6:	74 3a                	je     80104b12 <wait_sleeping+0xa2>
80104ad8:	8b 43 28             	mov    0x28(%ebx),%eax
80104adb:	85 c0                	test   %eax,%eax
80104add:	75 33                	jne    80104b12 <wait_sleeping+0xa2>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104adf:	83 ec 08             	sub    $0x8,%esp
80104ae2:	68 e0 3d 11 80       	push   $0x80113de0
80104ae7:	53                   	push   %ebx
80104ae8:	e8 b3 f9 ff ff       	call   801044a0 <sleep>
        havekids = 0;
80104aed:	83 c4 10             	add    $0x10,%esp
80104af0:	eb ae                	jmp    80104aa0 <wait_sleeping+0x30>
80104af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
                release(&ptable.lock);
80104af8:	83 ec 0c             	sub    $0xc,%esp
                pid = p->pid;
80104afb:	8b 58 10             	mov    0x10(%eax),%ebx
                release(&ptable.lock);
80104afe:	68 e0 3d 11 80       	push   $0x80113de0
80104b03:	e8 68 04 00 00       	call   80104f70 <release>
                return pid;
80104b08:	83 c4 10             	add    $0x10,%esp
    }
}
80104b0b:	89 d8                	mov    %ebx,%eax
80104b0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b10:	c9                   	leave  
80104b11:	c3                   	ret    
            release(&ptable.lock);
80104b12:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104b15:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
            release(&ptable.lock);
80104b1a:	68 e0 3d 11 80       	push   $0x80113de0
80104b1f:	e8 4c 04 00 00       	call   80104f70 <release>
            return -1;
80104b24:	83 c4 10             	add    $0x10,%esp
80104b27:	eb e2                	jmp    80104b0b <wait_sleeping+0x9b>
80104b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b30 <set_proc_tracer>:

int set_proc_tracer(void){
80104b30:	f3 0f 1e fb          	endbr32 
80104b34:	55                   	push   %ebp
80104b35:	89 e5                	mov    %esp,%ebp
80104b37:	56                   	push   %esi
80104b38:	53                   	push   %ebx
    int pid;
    if(argint(0, &pid)<0)
80104b39:	8d 45 f4             	lea    -0xc(%ebp),%eax
int set_proc_tracer(void){
80104b3c:	83 ec 18             	sub    $0x18,%esp
    if(argint(0, &pid)<0)
80104b3f:	50                   	push   %eax
80104b40:	6a 00                	push   $0x0
80104b42:	e8 59 07 00 00       	call   801052a0 <argint>
80104b47:	83 c4 10             	add    $0x10,%esp
80104b4a:	85 c0                	test   %eax,%eax
80104b4c:	0f 88 8a 00 00 00    	js     80104bdc <set_proc_tracer+0xac>
        return -1;

    struct proc* p;
    acquire(&ptable.lock);
80104b52:	83 ec 0c             	sub    $0xc,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b55:	bb 14 3e 11 80       	mov    $0x80113e14,%ebx
    acquire(&ptable.lock);
80104b5a:	68 e0 3d 11 80       	push   $0x80113de0
80104b5f:	e8 4c 03 00 00       	call   80104eb0 <acquire>
        if(p->pid != pid)
80104b64:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b67:	83 c4 10             	add    $0x10,%esp
80104b6a:	eb 0f                	jmp    80104b7b <set_proc_tracer+0x4b>
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b70:	83 eb 80             	sub    $0xffffff80,%ebx
80104b73:	81 fb 14 5e 11 80    	cmp    $0x80115e14,%ebx
80104b79:	74 45                	je     80104bc0 <set_proc_tracer+0x90>
        if(p->pid != pid)
80104b7b:	39 43 10             	cmp    %eax,0x10(%ebx)
80104b7e:	75 f0                	jne    80104b70 <set_proc_tracer+0x40>
            continue;
        if(!p->tracer){
80104b80:	8b 53 18             	mov    0x18(%ebx),%edx
80104b83:	85 d2                	test   %edx,%edx
80104b85:	75 e9                	jne    80104b70 <set_proc_tracer+0x40>
  pushcli();
80104b87:	e8 24 02 00 00       	call   80104db0 <pushcli>
  c = mycpu();
80104b8c:	e8 af f2 ff ff       	call   80103e40 <mycpu>
  p = c->proc;
80104b91:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104b97:	e8 64 02 00 00       	call   80104e00 <popcli>
            p->tracer = myproc();
            release(&ptable.lock);
80104b9c:	83 ec 0c             	sub    $0xc,%esp
80104b9f:	68 e0 3d 11 80       	push   $0x80113de0
            p->tracer = myproc();
80104ba4:	89 73 18             	mov    %esi,0x18(%ebx)
            release(&ptable.lock);
80104ba7:	e8 c4 03 00 00       	call   80104f70 <release>
            return pid;
80104bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104baf:	83 c4 10             	add    $0x10,%esp
        }
    }
    release(&ptable.lock);
    return -1;
80104bb2:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104bb5:	5b                   	pop    %ebx
80104bb6:	5e                   	pop    %esi
80104bb7:	5d                   	pop    %ebp
80104bb8:	c3                   	ret    
80104bb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104bc0:	83 ec 0c             	sub    $0xc,%esp
80104bc3:	68 e0 3d 11 80       	push   $0x80113de0
80104bc8:	e8 a3 03 00 00       	call   80104f70 <release>
    return -1;
80104bcd:	83 c4 10             	add    $0x10,%esp
80104bd0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104bd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104bd8:	5b                   	pop    %ebx
80104bd9:	5e                   	pop    %esi
80104bda:	5d                   	pop    %ebp
80104bdb:	c3                   	ret    
        return -1;
80104bdc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104be1:	eb cf                	jmp    80104bb2 <set_proc_tracer+0x82>
80104be3:	66 90                	xchg   %ax,%ax
80104be5:	66 90                	xchg   %ax,%ax
80104be7:	66 90                	xchg   %ax,%ax
80104be9:	66 90                	xchg   %ax,%ax
80104beb:	66 90                	xchg   %ax,%ax
80104bed:	66 90                	xchg   %ax,%ax
80104bef:	90                   	nop

80104bf0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104bf0:	f3 0f 1e fb          	endbr32 
80104bf4:	55                   	push   %ebp
80104bf5:	89 e5                	mov    %esp,%ebp
80104bf7:	53                   	push   %ebx
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104bfe:	68 98 83 10 80       	push   $0x80108398
80104c03:	8d 43 04             	lea    0x4(%ebx),%eax
80104c06:	50                   	push   %eax
80104c07:	e8 24 01 00 00       	call   80104d30 <initlock>
  lk->name = name;
80104c0c:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104c0f:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104c15:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104c18:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104c1f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104c22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c25:	c9                   	leave  
80104c26:	c3                   	ret    
80104c27:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c2e:	66 90                	xchg   %ax,%ax

80104c30 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104c30:	f3 0f 1e fb          	endbr32 
80104c34:	55                   	push   %ebp
80104c35:	89 e5                	mov    %esp,%ebp
80104c37:	56                   	push   %esi
80104c38:	53                   	push   %ebx
80104c39:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104c3c:	8d 73 04             	lea    0x4(%ebx),%esi
80104c3f:	83 ec 0c             	sub    $0xc,%esp
80104c42:	56                   	push   %esi
80104c43:	e8 68 02 00 00       	call   80104eb0 <acquire>
  while (lk->locked) {
80104c48:	8b 13                	mov    (%ebx),%edx
80104c4a:	83 c4 10             	add    $0x10,%esp
80104c4d:	85 d2                	test   %edx,%edx
80104c4f:	74 1a                	je     80104c6b <acquiresleep+0x3b>
80104c51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104c58:	83 ec 08             	sub    $0x8,%esp
80104c5b:	56                   	push   %esi
80104c5c:	53                   	push   %ebx
80104c5d:	e8 3e f8 ff ff       	call   801044a0 <sleep>
  while (lk->locked) {
80104c62:	8b 03                	mov    (%ebx),%eax
80104c64:	83 c4 10             	add    $0x10,%esp
80104c67:	85 c0                	test   %eax,%eax
80104c69:	75 ed                	jne    80104c58 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104c6b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104c71:	e8 5a f2 ff ff       	call   80103ed0 <myproc>
80104c76:	8b 40 10             	mov    0x10(%eax),%eax
80104c79:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104c7c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104c7f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104c82:	5b                   	pop    %ebx
80104c83:	5e                   	pop    %esi
80104c84:	5d                   	pop    %ebp
  release(&lk->lk);
80104c85:	e9 e6 02 00 00       	jmp    80104f70 <release>
80104c8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104c90 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104c90:	f3 0f 1e fb          	endbr32 
80104c94:	55                   	push   %ebp
80104c95:	89 e5                	mov    %esp,%ebp
80104c97:	56                   	push   %esi
80104c98:	53                   	push   %ebx
80104c99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104c9c:	8d 73 04             	lea    0x4(%ebx),%esi
80104c9f:	83 ec 0c             	sub    $0xc,%esp
80104ca2:	56                   	push   %esi
80104ca3:	e8 08 02 00 00       	call   80104eb0 <acquire>
  lk->locked = 0;
80104ca8:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104cae:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104cb5:	89 1c 24             	mov    %ebx,(%esp)
80104cb8:	e8 a3 f9 ff ff       	call   80104660 <wakeup>
  release(&lk->lk);
80104cbd:	89 75 08             	mov    %esi,0x8(%ebp)
80104cc0:	83 c4 10             	add    $0x10,%esp
}
80104cc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104cc6:	5b                   	pop    %ebx
80104cc7:	5e                   	pop    %esi
80104cc8:	5d                   	pop    %ebp
  release(&lk->lk);
80104cc9:	e9 a2 02 00 00       	jmp    80104f70 <release>
80104cce:	66 90                	xchg   %ax,%ax

80104cd0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104cd0:	f3 0f 1e fb          	endbr32 
80104cd4:	55                   	push   %ebp
80104cd5:	89 e5                	mov    %esp,%ebp
80104cd7:	57                   	push   %edi
80104cd8:	31 ff                	xor    %edi,%edi
80104cda:	56                   	push   %esi
80104cdb:	53                   	push   %ebx
80104cdc:	83 ec 18             	sub    $0x18,%esp
80104cdf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ce2:	8d 73 04             	lea    0x4(%ebx),%esi
80104ce5:	56                   	push   %esi
80104ce6:	e8 c5 01 00 00       	call   80104eb0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104ceb:	8b 03                	mov    (%ebx),%eax
80104ced:	83 c4 10             	add    $0x10,%esp
80104cf0:	85 c0                	test   %eax,%eax
80104cf2:	75 1c                	jne    80104d10 <holdingsleep+0x40>
  release(&lk->lk);
80104cf4:	83 ec 0c             	sub    $0xc,%esp
80104cf7:	56                   	push   %esi
80104cf8:	e8 73 02 00 00       	call   80104f70 <release>
  return r;
}
80104cfd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d00:	89 f8                	mov    %edi,%eax
80104d02:	5b                   	pop    %ebx
80104d03:	5e                   	pop    %esi
80104d04:	5f                   	pop    %edi
80104d05:	5d                   	pop    %ebp
80104d06:	c3                   	ret    
80104d07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d0e:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104d10:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104d13:	e8 b8 f1 ff ff       	call   80103ed0 <myproc>
80104d18:	39 58 10             	cmp    %ebx,0x10(%eax)
80104d1b:	0f 94 c0             	sete   %al
80104d1e:	0f b6 c0             	movzbl %al,%eax
80104d21:	89 c7                	mov    %eax,%edi
80104d23:	eb cf                	jmp    80104cf4 <holdingsleep+0x24>
80104d25:	66 90                	xchg   %ax,%ax
80104d27:	66 90                	xchg   %ax,%ax
80104d29:	66 90                	xchg   %ax,%ax
80104d2b:	66 90                	xchg   %ax,%ax
80104d2d:	66 90                	xchg   %ax,%ax
80104d2f:	90                   	nop

80104d30 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104d30:	f3 0f 1e fb          	endbr32 
80104d34:	55                   	push   %ebp
80104d35:	89 e5                	mov    %esp,%ebp
80104d37:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104d3a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104d3d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104d43:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104d46:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104d4d:	5d                   	pop    %ebp
80104d4e:	c3                   	ret    
80104d4f:	90                   	nop

80104d50 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104d50:	f3 0f 1e fb          	endbr32 
80104d54:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104d55:	31 d2                	xor    %edx,%edx
{
80104d57:	89 e5                	mov    %esp,%ebp
80104d59:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104d5a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104d5d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104d60:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104d63:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d67:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104d68:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104d6e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104d74:	77 1a                	ja     80104d90 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104d76:	8b 58 04             	mov    0x4(%eax),%ebx
80104d79:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104d7c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104d7f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104d81:	83 fa 0a             	cmp    $0xa,%edx
80104d84:	75 e2                	jne    80104d68 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104d86:	5b                   	pop    %ebx
80104d87:	5d                   	pop    %ebp
80104d88:	c3                   	ret    
80104d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104d90:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104d93:	8d 51 28             	lea    0x28(%ecx),%edx
80104d96:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d9d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104da0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104da6:	83 c0 04             	add    $0x4,%eax
80104da9:	39 d0                	cmp    %edx,%eax
80104dab:	75 f3                	jne    80104da0 <getcallerpcs+0x50>
}
80104dad:	5b                   	pop    %ebx
80104dae:	5d                   	pop    %ebp
80104daf:	c3                   	ret    

80104db0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104db0:	f3 0f 1e fb          	endbr32 
80104db4:	55                   	push   %ebp
80104db5:	89 e5                	mov    %esp,%ebp
80104db7:	53                   	push   %ebx
80104db8:	83 ec 04             	sub    $0x4,%esp
80104dbb:	9c                   	pushf  
80104dbc:	5b                   	pop    %ebx
  asm volatile("cli");
80104dbd:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104dbe:	e8 7d f0 ff ff       	call   80103e40 <mycpu>
80104dc3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104dc9:	85 c0                	test   %eax,%eax
80104dcb:	74 13                	je     80104de0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104dcd:	e8 6e f0 ff ff       	call   80103e40 <mycpu>
80104dd2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104dd9:	83 c4 04             	add    $0x4,%esp
80104ddc:	5b                   	pop    %ebx
80104ddd:	5d                   	pop    %ebp
80104dde:	c3                   	ret    
80104ddf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104de0:	e8 5b f0 ff ff       	call   80103e40 <mycpu>
80104de5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104deb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104df1:	eb da                	jmp    80104dcd <pushcli+0x1d>
80104df3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104dfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e00 <popcli>:

void
popcli(void)
{
80104e00:	f3 0f 1e fb          	endbr32 
80104e04:	55                   	push   %ebp
80104e05:	89 e5                	mov    %esp,%ebp
80104e07:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104e0a:	9c                   	pushf  
80104e0b:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104e0c:	f6 c4 02             	test   $0x2,%ah
80104e0f:	75 31                	jne    80104e42 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80104e11:	e8 2a f0 ff ff       	call   80103e40 <mycpu>
80104e16:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104e1d:	78 30                	js     80104e4f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104e1f:	e8 1c f0 ff ff       	call   80103e40 <mycpu>
80104e24:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104e2a:	85 d2                	test   %edx,%edx
80104e2c:	74 02                	je     80104e30 <popcli+0x30>
    sti();
}
80104e2e:	c9                   	leave  
80104e2f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104e30:	e8 0b f0 ff ff       	call   80103e40 <mycpu>
80104e35:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104e3b:	85 c0                	test   %eax,%eax
80104e3d:	74 ef                	je     80104e2e <popcli+0x2e>
  asm volatile("sti");
80104e3f:	fb                   	sti    
}
80104e40:	c9                   	leave  
80104e41:	c3                   	ret    
    panic("popcli - interruptible");
80104e42:	83 ec 0c             	sub    $0xc,%esp
80104e45:	68 a3 83 10 80       	push   $0x801083a3
80104e4a:	e8 41 b5 ff ff       	call   80100390 <panic>
    panic("popcli");
80104e4f:	83 ec 0c             	sub    $0xc,%esp
80104e52:	68 ba 83 10 80       	push   $0x801083ba
80104e57:	e8 34 b5 ff ff       	call   80100390 <panic>
80104e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104e60 <holding>:
{
80104e60:	f3 0f 1e fb          	endbr32 
80104e64:	55                   	push   %ebp
80104e65:	89 e5                	mov    %esp,%ebp
80104e67:	56                   	push   %esi
80104e68:	53                   	push   %ebx
80104e69:	8b 75 08             	mov    0x8(%ebp),%esi
80104e6c:	31 db                	xor    %ebx,%ebx
  pushcli();
80104e6e:	e8 3d ff ff ff       	call   80104db0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104e73:	8b 06                	mov    (%esi),%eax
80104e75:	85 c0                	test   %eax,%eax
80104e77:	75 0f                	jne    80104e88 <holding+0x28>
  popcli();
80104e79:	e8 82 ff ff ff       	call   80104e00 <popcli>
}
80104e7e:	89 d8                	mov    %ebx,%eax
80104e80:	5b                   	pop    %ebx
80104e81:	5e                   	pop    %esi
80104e82:	5d                   	pop    %ebp
80104e83:	c3                   	ret    
80104e84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80104e88:	8b 5e 08             	mov    0x8(%esi),%ebx
80104e8b:	e8 b0 ef ff ff       	call   80103e40 <mycpu>
80104e90:	39 c3                	cmp    %eax,%ebx
80104e92:	0f 94 c3             	sete   %bl
  popcli();
80104e95:	e8 66 ff ff ff       	call   80104e00 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104e9a:	0f b6 db             	movzbl %bl,%ebx
}
80104e9d:	89 d8                	mov    %ebx,%eax
80104e9f:	5b                   	pop    %ebx
80104ea0:	5e                   	pop    %esi
80104ea1:	5d                   	pop    %ebp
80104ea2:	c3                   	ret    
80104ea3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104eaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104eb0 <acquire>:
{
80104eb0:	f3 0f 1e fb          	endbr32 
80104eb4:	55                   	push   %ebp
80104eb5:	89 e5                	mov    %esp,%ebp
80104eb7:	56                   	push   %esi
80104eb8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
80104eb9:	e8 f2 fe ff ff       	call   80104db0 <pushcli>
  if(holding(lk))
80104ebe:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ec1:	83 ec 0c             	sub    $0xc,%esp
80104ec4:	53                   	push   %ebx
80104ec5:	e8 96 ff ff ff       	call   80104e60 <holding>
80104eca:	83 c4 10             	add    $0x10,%esp
80104ecd:	85 c0                	test   %eax,%eax
80104ecf:	0f 85 7f 00 00 00    	jne    80104f54 <acquire+0xa4>
80104ed5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104ed7:	ba 01 00 00 00       	mov    $0x1,%edx
80104edc:	eb 05                	jmp    80104ee3 <acquire+0x33>
80104ede:	66 90                	xchg   %ax,%ax
80104ee0:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ee3:	89 d0                	mov    %edx,%eax
80104ee5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104ee8:	85 c0                	test   %eax,%eax
80104eea:	75 f4                	jne    80104ee0 <acquire+0x30>
  __sync_synchronize();
80104eec:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104ef1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104ef4:	e8 47 ef ff ff       	call   80103e40 <mycpu>
80104ef9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
80104efc:	89 e8                	mov    %ebp,%eax
80104efe:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f00:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80104f06:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
80104f0c:	77 22                	ja     80104f30 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104f0e:	8b 50 04             	mov    0x4(%eax),%edx
80104f11:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80104f15:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80104f18:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f1a:	83 fe 0a             	cmp    $0xa,%esi
80104f1d:	75 e1                	jne    80104f00 <acquire+0x50>
}
80104f1f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f22:	5b                   	pop    %ebx
80104f23:	5e                   	pop    %esi
80104f24:	5d                   	pop    %ebp
80104f25:	c3                   	ret    
80104f26:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f2d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80104f30:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80104f34:	83 c3 34             	add    $0x34,%ebx
80104f37:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f3e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104f40:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f46:	83 c0 04             	add    $0x4,%eax
80104f49:	39 d8                	cmp    %ebx,%eax
80104f4b:	75 f3                	jne    80104f40 <acquire+0x90>
}
80104f4d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f50:	5b                   	pop    %ebx
80104f51:	5e                   	pop    %esi
80104f52:	5d                   	pop    %ebp
80104f53:	c3                   	ret    
    panic("acquire");
80104f54:	83 ec 0c             	sub    $0xc,%esp
80104f57:	68 c1 83 10 80       	push   $0x801083c1
80104f5c:	e8 2f b4 ff ff       	call   80100390 <panic>
80104f61:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f68:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f6f:	90                   	nop

80104f70 <release>:
{
80104f70:	f3 0f 1e fb          	endbr32 
80104f74:	55                   	push   %ebp
80104f75:	89 e5                	mov    %esp,%ebp
80104f77:	53                   	push   %ebx
80104f78:	83 ec 10             	sub    $0x10,%esp
80104f7b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
80104f7e:	53                   	push   %ebx
80104f7f:	e8 dc fe ff ff       	call   80104e60 <holding>
80104f84:	83 c4 10             	add    $0x10,%esp
80104f87:	85 c0                	test   %eax,%eax
80104f89:	74 22                	je     80104fad <release+0x3d>
  lk->pcs[0] = 0;
80104f8b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104f92:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104f99:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
80104f9e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104fa4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104fa7:	c9                   	leave  
  popcli();
80104fa8:	e9 53 fe ff ff       	jmp    80104e00 <popcli>
    panic("release");
80104fad:	83 ec 0c             	sub    $0xc,%esp
80104fb0:	68 c9 83 10 80       	push   $0x801083c9
80104fb5:	e8 d6 b3 ff ff       	call   80100390 <panic>
80104fba:	66 90                	xchg   %ax,%ax
80104fbc:	66 90                	xchg   %ax,%ax
80104fbe:	66 90                	xchg   %ax,%ax

80104fc0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104fc0:	f3 0f 1e fb          	endbr32 
80104fc4:	55                   	push   %ebp
80104fc5:	89 e5                	mov    %esp,%ebp
80104fc7:	57                   	push   %edi
80104fc8:	8b 55 08             	mov    0x8(%ebp),%edx
80104fcb:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104fce:	53                   	push   %ebx
80104fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
80104fd2:	89 d7                	mov    %edx,%edi
80104fd4:	09 cf                	or     %ecx,%edi
80104fd6:	83 e7 03             	and    $0x3,%edi
80104fd9:	75 25                	jne    80105000 <memset+0x40>
    c &= 0xFF;
80104fdb:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104fde:	c1 e0 18             	shl    $0x18,%eax
80104fe1:	89 fb                	mov    %edi,%ebx
80104fe3:	c1 e9 02             	shr    $0x2,%ecx
80104fe6:	c1 e3 10             	shl    $0x10,%ebx
80104fe9:	09 d8                	or     %ebx,%eax
80104feb:	09 f8                	or     %edi,%eax
80104fed:	c1 e7 08             	shl    $0x8,%edi
80104ff0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104ff2:	89 d7                	mov    %edx,%edi
80104ff4:	fc                   	cld    
80104ff5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104ff7:	5b                   	pop    %ebx
80104ff8:	89 d0                	mov    %edx,%eax
80104ffa:	5f                   	pop    %edi
80104ffb:	5d                   	pop    %ebp
80104ffc:	c3                   	ret    
80104ffd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
80105000:	89 d7                	mov    %edx,%edi
80105002:	fc                   	cld    
80105003:	f3 aa                	rep stos %al,%es:(%edi)
80105005:	5b                   	pop    %ebx
80105006:	89 d0                	mov    %edx,%eax
80105008:	5f                   	pop    %edi
80105009:	5d                   	pop    %ebp
8010500a:	c3                   	ret    
8010500b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010500f:	90                   	nop

80105010 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105010:	f3 0f 1e fb          	endbr32 
80105014:	55                   	push   %ebp
80105015:	89 e5                	mov    %esp,%ebp
80105017:	56                   	push   %esi
80105018:	8b 75 10             	mov    0x10(%ebp),%esi
8010501b:	8b 55 08             	mov    0x8(%ebp),%edx
8010501e:	53                   	push   %ebx
8010501f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105022:	85 f6                	test   %esi,%esi
80105024:	74 2a                	je     80105050 <memcmp+0x40>
80105026:	01 c6                	add    %eax,%esi
80105028:	eb 10                	jmp    8010503a <memcmp+0x2a>
8010502a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105030:	83 c0 01             	add    $0x1,%eax
80105033:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105036:	39 f0                	cmp    %esi,%eax
80105038:	74 16                	je     80105050 <memcmp+0x40>
    if(*s1 != *s2)
8010503a:	0f b6 0a             	movzbl (%edx),%ecx
8010503d:	0f b6 18             	movzbl (%eax),%ebx
80105040:	38 d9                	cmp    %bl,%cl
80105042:	74 ec                	je     80105030 <memcmp+0x20>
      return *s1 - *s2;
80105044:	0f b6 c1             	movzbl %cl,%eax
80105047:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105049:	5b                   	pop    %ebx
8010504a:	5e                   	pop    %esi
8010504b:	5d                   	pop    %ebp
8010504c:	c3                   	ret    
8010504d:	8d 76 00             	lea    0x0(%esi),%esi
80105050:	5b                   	pop    %ebx
  return 0;
80105051:	31 c0                	xor    %eax,%eax
}
80105053:	5e                   	pop    %esi
80105054:	5d                   	pop    %ebp
80105055:	c3                   	ret    
80105056:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010505d:	8d 76 00             	lea    0x0(%esi),%esi

80105060 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105060:	f3 0f 1e fb          	endbr32 
80105064:	55                   	push   %ebp
80105065:	89 e5                	mov    %esp,%ebp
80105067:	57                   	push   %edi
80105068:	8b 55 08             	mov    0x8(%ebp),%edx
8010506b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010506e:	56                   	push   %esi
8010506f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105072:	39 d6                	cmp    %edx,%esi
80105074:	73 2a                	jae    801050a0 <memmove+0x40>
80105076:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105079:	39 fa                	cmp    %edi,%edx
8010507b:	73 23                	jae    801050a0 <memmove+0x40>
8010507d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105080:	85 c9                	test   %ecx,%ecx
80105082:	74 13                	je     80105097 <memmove+0x37>
80105084:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80105088:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010508c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
8010508f:	83 e8 01             	sub    $0x1,%eax
80105092:	83 f8 ff             	cmp    $0xffffffff,%eax
80105095:	75 f1                	jne    80105088 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105097:	5e                   	pop    %esi
80105098:	89 d0                	mov    %edx,%eax
8010509a:	5f                   	pop    %edi
8010509b:	5d                   	pop    %ebp
8010509c:	c3                   	ret    
8010509d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
801050a0:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
801050a3:	89 d7                	mov    %edx,%edi
801050a5:	85 c9                	test   %ecx,%ecx
801050a7:	74 ee                	je     80105097 <memmove+0x37>
801050a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801050b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801050b1:	39 f0                	cmp    %esi,%eax
801050b3:	75 fb                	jne    801050b0 <memmove+0x50>
}
801050b5:	5e                   	pop    %esi
801050b6:	89 d0                	mov    %edx,%eax
801050b8:	5f                   	pop    %edi
801050b9:	5d                   	pop    %ebp
801050ba:	c3                   	ret    
801050bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801050bf:	90                   	nop

801050c0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801050c0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
801050c4:	eb 9a                	jmp    80105060 <memmove>
801050c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801050cd:	8d 76 00             	lea    0x0(%esi),%esi

801050d0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801050d0:	f3 0f 1e fb          	endbr32 
801050d4:	55                   	push   %ebp
801050d5:	89 e5                	mov    %esp,%ebp
801050d7:	56                   	push   %esi
801050d8:	8b 75 10             	mov    0x10(%ebp),%esi
801050db:	8b 4d 08             	mov    0x8(%ebp),%ecx
801050de:	53                   	push   %ebx
801050df:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801050e2:	85 f6                	test   %esi,%esi
801050e4:	74 32                	je     80105118 <strncmp+0x48>
801050e6:	01 c6                	add    %eax,%esi
801050e8:	eb 14                	jmp    801050fe <strncmp+0x2e>
801050ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050f0:	38 da                	cmp    %bl,%dl
801050f2:	75 14                	jne    80105108 <strncmp+0x38>
    n--, p++, q++;
801050f4:	83 c0 01             	add    $0x1,%eax
801050f7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801050fa:	39 f0                	cmp    %esi,%eax
801050fc:	74 1a                	je     80105118 <strncmp+0x48>
801050fe:	0f b6 11             	movzbl (%ecx),%edx
80105101:	0f b6 18             	movzbl (%eax),%ebx
80105104:	84 d2                	test   %dl,%dl
80105106:	75 e8                	jne    801050f0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80105108:	0f b6 c2             	movzbl %dl,%eax
8010510b:	29 d8                	sub    %ebx,%eax
}
8010510d:	5b                   	pop    %ebx
8010510e:	5e                   	pop    %esi
8010510f:	5d                   	pop    %ebp
80105110:	c3                   	ret    
80105111:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105118:	5b                   	pop    %ebx
    return 0;
80105119:	31 c0                	xor    %eax,%eax
}
8010511b:	5e                   	pop    %esi
8010511c:	5d                   	pop    %ebp
8010511d:	c3                   	ret    
8010511e:	66 90                	xchg   %ax,%ax

80105120 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105120:	f3 0f 1e fb          	endbr32 
80105124:	55                   	push   %ebp
80105125:	89 e5                	mov    %esp,%ebp
80105127:	57                   	push   %edi
80105128:	56                   	push   %esi
80105129:	8b 75 08             	mov    0x8(%ebp),%esi
8010512c:	53                   	push   %ebx
8010512d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105130:	89 f2                	mov    %esi,%edx
80105132:	eb 1b                	jmp    8010514f <strncpy+0x2f>
80105134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105138:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010513c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010513f:	83 c2 01             	add    $0x1,%edx
80105142:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105146:	89 f9                	mov    %edi,%ecx
80105148:	88 4a ff             	mov    %cl,-0x1(%edx)
8010514b:	84 c9                	test   %cl,%cl
8010514d:	74 09                	je     80105158 <strncpy+0x38>
8010514f:	89 c3                	mov    %eax,%ebx
80105151:	83 e8 01             	sub    $0x1,%eax
80105154:	85 db                	test   %ebx,%ebx
80105156:	7f e0                	jg     80105138 <strncpy+0x18>
    ;
  while(n-- > 0)
80105158:	89 d1                	mov    %edx,%ecx
8010515a:	85 c0                	test   %eax,%eax
8010515c:	7e 15                	jle    80105173 <strncpy+0x53>
8010515e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80105160:	83 c1 01             	add    $0x1,%ecx
80105163:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80105167:	89 c8                	mov    %ecx,%eax
80105169:	f7 d0                	not    %eax
8010516b:	01 d0                	add    %edx,%eax
8010516d:	01 d8                	add    %ebx,%eax
8010516f:	85 c0                	test   %eax,%eax
80105171:	7f ed                	jg     80105160 <strncpy+0x40>
  return os;
}
80105173:	5b                   	pop    %ebx
80105174:	89 f0                	mov    %esi,%eax
80105176:	5e                   	pop    %esi
80105177:	5f                   	pop    %edi
80105178:	5d                   	pop    %ebp
80105179:	c3                   	ret    
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105180 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105180:	f3 0f 1e fb          	endbr32 
80105184:	55                   	push   %ebp
80105185:	89 e5                	mov    %esp,%ebp
80105187:	56                   	push   %esi
80105188:	8b 55 10             	mov    0x10(%ebp),%edx
8010518b:	8b 75 08             	mov    0x8(%ebp),%esi
8010518e:	53                   	push   %ebx
8010518f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105192:	85 d2                	test   %edx,%edx
80105194:	7e 21                	jle    801051b7 <safestrcpy+0x37>
80105196:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010519a:	89 f2                	mov    %esi,%edx
8010519c:	eb 12                	jmp    801051b0 <safestrcpy+0x30>
8010519e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801051a0:	0f b6 08             	movzbl (%eax),%ecx
801051a3:	83 c0 01             	add    $0x1,%eax
801051a6:	83 c2 01             	add    $0x1,%edx
801051a9:	88 4a ff             	mov    %cl,-0x1(%edx)
801051ac:	84 c9                	test   %cl,%cl
801051ae:	74 04                	je     801051b4 <safestrcpy+0x34>
801051b0:	39 d8                	cmp    %ebx,%eax
801051b2:	75 ec                	jne    801051a0 <safestrcpy+0x20>
    ;
  *s = 0;
801051b4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801051b7:	89 f0                	mov    %esi,%eax
801051b9:	5b                   	pop    %ebx
801051ba:	5e                   	pop    %esi
801051bb:	5d                   	pop    %ebp
801051bc:	c3                   	ret    
801051bd:	8d 76 00             	lea    0x0(%esi),%esi

801051c0 <strlen>:

int
strlen(const char *s)
{
801051c0:	f3 0f 1e fb          	endbr32 
801051c4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801051c5:	31 c0                	xor    %eax,%eax
{
801051c7:	89 e5                	mov    %esp,%ebp
801051c9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801051cc:	80 3a 00             	cmpb   $0x0,(%edx)
801051cf:	74 10                	je     801051e1 <strlen+0x21>
801051d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801051d8:	83 c0 01             	add    $0x1,%eax
801051db:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801051df:	75 f7                	jne    801051d8 <strlen+0x18>
    ;
  return n;
}
801051e1:	5d                   	pop    %ebp
801051e2:	c3                   	ret    

801051e3 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801051e3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801051e7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801051eb:	55                   	push   %ebp
  pushl %ebx
801051ec:	53                   	push   %ebx
  pushl %esi
801051ed:	56                   	push   %esi
  pushl %edi
801051ee:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801051ef:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801051f1:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801051f3:	5f                   	pop    %edi
  popl %esi
801051f4:	5e                   	pop    %esi
  popl %ebx
801051f5:	5b                   	pop    %ebx
  popl %ebp
801051f6:	5d                   	pop    %ebp
  ret
801051f7:	c3                   	ret    
801051f8:	66 90                	xchg   %ax,%ax
801051fa:	66 90                	xchg   %ax,%ax
801051fc:	66 90                	xchg   %ax,%ax
801051fe:	66 90                	xchg   %ax,%ax

80105200 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105200:	f3 0f 1e fb          	endbr32 
80105204:	55                   	push   %ebp
80105205:	89 e5                	mov    %esp,%ebp
80105207:	53                   	push   %ebx
80105208:	83 ec 04             	sub    $0x4,%esp
8010520b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010520e:	e8 bd ec ff ff       	call   80103ed0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105213:	8b 00                	mov    (%eax),%eax
80105215:	39 d8                	cmp    %ebx,%eax
80105217:	76 17                	jbe    80105230 <fetchint+0x30>
80105219:	8d 53 04             	lea    0x4(%ebx),%edx
8010521c:	39 d0                	cmp    %edx,%eax
8010521e:	72 10                	jb     80105230 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105220:	8b 45 0c             	mov    0xc(%ebp),%eax
80105223:	8b 13                	mov    (%ebx),%edx
80105225:	89 10                	mov    %edx,(%eax)
  return 0;
80105227:	31 c0                	xor    %eax,%eax
}
80105229:	83 c4 04             	add    $0x4,%esp
8010522c:	5b                   	pop    %ebx
8010522d:	5d                   	pop    %ebp
8010522e:	c3                   	ret    
8010522f:	90                   	nop
    return -1;
80105230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105235:	eb f2                	jmp    80105229 <fetchint+0x29>
80105237:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010523e:	66 90                	xchg   %ax,%ax

80105240 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105240:	f3 0f 1e fb          	endbr32 
80105244:	55                   	push   %ebp
80105245:	89 e5                	mov    %esp,%ebp
80105247:	53                   	push   %ebx
80105248:	83 ec 04             	sub    $0x4,%esp
8010524b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010524e:	e8 7d ec ff ff       	call   80103ed0 <myproc>

  if(addr >= curproc->sz)
80105253:	39 18                	cmp    %ebx,(%eax)
80105255:	76 31                	jbe    80105288 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105257:	8b 55 0c             	mov    0xc(%ebp),%edx
8010525a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010525c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010525e:	39 d3                	cmp    %edx,%ebx
80105260:	73 26                	jae    80105288 <fetchstr+0x48>
80105262:	89 d8                	mov    %ebx,%eax
80105264:	eb 11                	jmp    80105277 <fetchstr+0x37>
80105266:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010526d:	8d 76 00             	lea    0x0(%esi),%esi
80105270:	83 c0 01             	add    $0x1,%eax
80105273:	39 c2                	cmp    %eax,%edx
80105275:	76 11                	jbe    80105288 <fetchstr+0x48>
    if(*s == 0)
80105277:	80 38 00             	cmpb   $0x0,(%eax)
8010527a:	75 f4                	jne    80105270 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010527c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010527f:	29 d8                	sub    %ebx,%eax
}
80105281:	5b                   	pop    %ebx
80105282:	5d                   	pop    %ebp
80105283:	c3                   	ret    
80105284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105288:	83 c4 04             	add    $0x4,%esp
    return -1;
8010528b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105290:	5b                   	pop    %ebx
80105291:	5d                   	pop    %ebp
80105292:	c3                   	ret    
80105293:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010529a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801052a0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801052a0:	f3 0f 1e fb          	endbr32 
801052a4:	55                   	push   %ebp
801052a5:	89 e5                	mov    %esp,%ebp
801052a7:	56                   	push   %esi
801052a8:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801052a9:	e8 22 ec ff ff       	call   80103ed0 <myproc>
801052ae:	8b 55 08             	mov    0x8(%ebp),%edx
801052b1:	8b 40 1c             	mov    0x1c(%eax),%eax
801052b4:	8b 40 44             	mov    0x44(%eax),%eax
801052b7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801052ba:	e8 11 ec ff ff       	call   80103ed0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801052bf:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801052c2:	8b 00                	mov    (%eax),%eax
801052c4:	39 c6                	cmp    %eax,%esi
801052c6:	73 18                	jae    801052e0 <argint+0x40>
801052c8:	8d 53 08             	lea    0x8(%ebx),%edx
801052cb:	39 d0                	cmp    %edx,%eax
801052cd:	72 11                	jb     801052e0 <argint+0x40>
  *ip = *(int*)(addr);
801052cf:	8b 45 0c             	mov    0xc(%ebp),%eax
801052d2:	8b 53 04             	mov    0x4(%ebx),%edx
801052d5:	89 10                	mov    %edx,(%eax)
  return 0;
801052d7:	31 c0                	xor    %eax,%eax
}
801052d9:	5b                   	pop    %ebx
801052da:	5e                   	pop    %esi
801052db:	5d                   	pop    %ebp
801052dc:	c3                   	ret    
801052dd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801052e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801052e5:	eb f2                	jmp    801052d9 <argint+0x39>
801052e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052ee:	66 90                	xchg   %ax,%ax

801052f0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801052f0:	f3 0f 1e fb          	endbr32 
801052f4:	55                   	push   %ebp
801052f5:	89 e5                	mov    %esp,%ebp
801052f7:	56                   	push   %esi
801052f8:	53                   	push   %ebx
801052f9:	83 ec 10             	sub    $0x10,%esp
801052fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801052ff:	e8 cc eb ff ff       	call   80103ed0 <myproc>
 
  if(argint(n, &i) < 0)
80105304:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
80105307:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
80105309:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010530c:	50                   	push   %eax
8010530d:	ff 75 08             	pushl  0x8(%ebp)
80105310:	e8 8b ff ff ff       	call   801052a0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105315:	83 c4 10             	add    $0x10,%esp
80105318:	85 c0                	test   %eax,%eax
8010531a:	78 24                	js     80105340 <argptr+0x50>
8010531c:	85 db                	test   %ebx,%ebx
8010531e:	78 20                	js     80105340 <argptr+0x50>
80105320:	8b 16                	mov    (%esi),%edx
80105322:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105325:	39 c2                	cmp    %eax,%edx
80105327:	76 17                	jbe    80105340 <argptr+0x50>
80105329:	01 c3                	add    %eax,%ebx
8010532b:	39 da                	cmp    %ebx,%edx
8010532d:	72 11                	jb     80105340 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010532f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105332:	89 02                	mov    %eax,(%edx)
  return 0;
80105334:	31 c0                	xor    %eax,%eax
}
80105336:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105339:	5b                   	pop    %ebx
8010533a:	5e                   	pop    %esi
8010533b:	5d                   	pop    %ebp
8010533c:	c3                   	ret    
8010533d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105340:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105345:	eb ef                	jmp    80105336 <argptr+0x46>
80105347:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010534e:	66 90                	xchg   %ax,%ax

80105350 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105350:	f3 0f 1e fb          	endbr32 
80105354:	55                   	push   %ebp
80105355:	89 e5                	mov    %esp,%ebp
80105357:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010535a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010535d:	50                   	push   %eax
8010535e:	ff 75 08             	pushl  0x8(%ebp)
80105361:	e8 3a ff ff ff       	call   801052a0 <argint>
80105366:	83 c4 10             	add    $0x10,%esp
80105369:	85 c0                	test   %eax,%eax
8010536b:	78 13                	js     80105380 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010536d:	83 ec 08             	sub    $0x8,%esp
80105370:	ff 75 0c             	pushl  0xc(%ebp)
80105373:	ff 75 f4             	pushl  -0xc(%ebp)
80105376:	e8 c5 fe ff ff       	call   80105240 <fetchstr>
8010537b:	83 c4 10             	add    $0x10,%esp
}
8010537e:	c9                   	leave  
8010537f:	c3                   	ret    
80105380:	c9                   	leave  
    return -1;
80105381:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105386:	c3                   	ret    
80105387:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010538e:	66 90                	xchg   %ax,%ax

80105390 <syscall>:
[SYS_dining] sys_dining,
};

void
syscall(void)
{
80105390:	f3 0f 1e fb          	endbr32 
80105394:	55                   	push   %ebp
80105395:	89 e5                	mov    %esp,%ebp
80105397:	53                   	push   %ebx
80105398:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010539b:	e8 30 eb ff ff       	call   80103ed0 <myproc>
801053a0:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801053a2:	8b 40 1c             	mov    0x1c(%eax),%eax
801053a5:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801053a8:	8d 50 ff             	lea    -0x1(%eax),%edx
801053ab:	83 fa 1a             	cmp    $0x1a,%edx
801053ae:	77 20                	ja     801053d0 <syscall+0x40>
801053b0:	8b 14 85 00 84 10 80 	mov    -0x7fef7c00(,%eax,4),%edx
801053b7:	85 d2                	test   %edx,%edx
801053b9:	74 15                	je     801053d0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801053bb:	ff d2                	call   *%edx
801053bd:	89 c2                	mov    %eax,%edx
801053bf:	8b 43 1c             	mov    0x1c(%ebx),%eax
801053c2:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801053c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053c8:	c9                   	leave  
801053c9:	c3                   	ret    
801053ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801053d0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801053d1:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801053d4:	50                   	push   %eax
801053d5:	ff 73 10             	pushl  0x10(%ebx)
801053d8:	68 d1 83 10 80       	push   $0x801083d1
801053dd:	e8 ce b2 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801053e2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801053e5:	83 c4 10             	add    $0x10,%esp
801053e8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801053ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801053f2:	c9                   	leave  
801053f3:	c3                   	ret    
801053f4:	66 90                	xchg   %ax,%ax
801053f6:	66 90                	xchg   %ax,%ax
801053f8:	66 90                	xchg   %ax,%ax
801053fa:	66 90                	xchg   %ax,%ax
801053fc:	66 90                	xchg   %ax,%ax
801053fe:	66 90                	xchg   %ax,%ax

80105400 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105400:	55                   	push   %ebp
80105401:	89 e5                	mov    %esp,%ebp
80105403:	57                   	push   %edi
80105404:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105405:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105408:	53                   	push   %ebx
80105409:	83 ec 34             	sub    $0x34,%esp
8010540c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010540f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105412:	57                   	push   %edi
80105413:	50                   	push   %eax
{
80105414:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105417:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010541a:	e8 f1 d0 ff ff       	call   80102510 <nameiparent>
8010541f:	83 c4 10             	add    $0x10,%esp
80105422:	85 c0                	test   %eax,%eax
80105424:	0f 84 46 01 00 00    	je     80105570 <create+0x170>
    return 0;
  ilock(dp);
8010542a:	83 ec 0c             	sub    $0xc,%esp
8010542d:	89 c3                	mov    %eax,%ebx
8010542f:	50                   	push   %eax
80105430:	e8 eb c7 ff ff       	call   80101c20 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105435:	83 c4 0c             	add    $0xc,%esp
80105438:	6a 00                	push   $0x0
8010543a:	57                   	push   %edi
8010543b:	53                   	push   %ebx
8010543c:	e8 2f cd ff ff       	call   80102170 <dirlookup>
80105441:	83 c4 10             	add    $0x10,%esp
80105444:	89 c6                	mov    %eax,%esi
80105446:	85 c0                	test   %eax,%eax
80105448:	74 56                	je     801054a0 <create+0xa0>
    iunlockput(dp);
8010544a:	83 ec 0c             	sub    $0xc,%esp
8010544d:	53                   	push   %ebx
8010544e:	e8 6d ca ff ff       	call   80101ec0 <iunlockput>
    ilock(ip);
80105453:	89 34 24             	mov    %esi,(%esp)
80105456:	e8 c5 c7 ff ff       	call   80101c20 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010545b:	83 c4 10             	add    $0x10,%esp
8010545e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105463:	75 1b                	jne    80105480 <create+0x80>
80105465:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010546a:	75 14                	jne    80105480 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010546c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010546f:	89 f0                	mov    %esi,%eax
80105471:	5b                   	pop    %ebx
80105472:	5e                   	pop    %esi
80105473:	5f                   	pop    %edi
80105474:	5d                   	pop    %ebp
80105475:	c3                   	ret    
80105476:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010547d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105480:	83 ec 0c             	sub    $0xc,%esp
80105483:	56                   	push   %esi
    return 0;
80105484:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105486:	e8 35 ca ff ff       	call   80101ec0 <iunlockput>
    return 0;
8010548b:	83 c4 10             	add    $0x10,%esp
}
8010548e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105491:	89 f0                	mov    %esi,%eax
80105493:	5b                   	pop    %ebx
80105494:	5e                   	pop    %esi
80105495:	5f                   	pop    %edi
80105496:	5d                   	pop    %ebp
80105497:	c3                   	ret    
80105498:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010549f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
801054a0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801054a4:	83 ec 08             	sub    $0x8,%esp
801054a7:	50                   	push   %eax
801054a8:	ff 33                	pushl  (%ebx)
801054aa:	e8 f1 c5 ff ff       	call   80101aa0 <ialloc>
801054af:	83 c4 10             	add    $0x10,%esp
801054b2:	89 c6                	mov    %eax,%esi
801054b4:	85 c0                	test   %eax,%eax
801054b6:	0f 84 cd 00 00 00    	je     80105589 <create+0x189>
  ilock(ip);
801054bc:	83 ec 0c             	sub    $0xc,%esp
801054bf:	50                   	push   %eax
801054c0:	e8 5b c7 ff ff       	call   80101c20 <ilock>
  ip->major = major;
801054c5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801054c9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801054cd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801054d1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801054d5:	b8 01 00 00 00       	mov    $0x1,%eax
801054da:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801054de:	89 34 24             	mov    %esi,(%esp)
801054e1:	e8 7a c6 ff ff       	call   80101b60 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801054e6:	83 c4 10             	add    $0x10,%esp
801054e9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801054ee:	74 30                	je     80105520 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801054f0:	83 ec 04             	sub    $0x4,%esp
801054f3:	ff 76 04             	pushl  0x4(%esi)
801054f6:	57                   	push   %edi
801054f7:	53                   	push   %ebx
801054f8:	e8 33 cf ff ff       	call   80102430 <dirlink>
801054fd:	83 c4 10             	add    $0x10,%esp
80105500:	85 c0                	test   %eax,%eax
80105502:	78 78                	js     8010557c <create+0x17c>
  iunlockput(dp);
80105504:	83 ec 0c             	sub    $0xc,%esp
80105507:	53                   	push   %ebx
80105508:	e8 b3 c9 ff ff       	call   80101ec0 <iunlockput>
  return ip;
8010550d:	83 c4 10             	add    $0x10,%esp
}
80105510:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105513:	89 f0                	mov    %esi,%eax
80105515:	5b                   	pop    %ebx
80105516:	5e                   	pop    %esi
80105517:	5f                   	pop    %edi
80105518:	5d                   	pop    %ebp
80105519:	c3                   	ret    
8010551a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105520:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105523:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105528:	53                   	push   %ebx
80105529:	e8 32 c6 ff ff       	call   80101b60 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010552e:	83 c4 0c             	add    $0xc,%esp
80105531:	ff 76 04             	pushl  0x4(%esi)
80105534:	68 8c 84 10 80       	push   $0x8010848c
80105539:	56                   	push   %esi
8010553a:	e8 f1 ce ff ff       	call   80102430 <dirlink>
8010553f:	83 c4 10             	add    $0x10,%esp
80105542:	85 c0                	test   %eax,%eax
80105544:	78 18                	js     8010555e <create+0x15e>
80105546:	83 ec 04             	sub    $0x4,%esp
80105549:	ff 73 04             	pushl  0x4(%ebx)
8010554c:	68 8b 84 10 80       	push   $0x8010848b
80105551:	56                   	push   %esi
80105552:	e8 d9 ce ff ff       	call   80102430 <dirlink>
80105557:	83 c4 10             	add    $0x10,%esp
8010555a:	85 c0                	test   %eax,%eax
8010555c:	79 92                	jns    801054f0 <create+0xf0>
      panic("create dots");
8010555e:	83 ec 0c             	sub    $0xc,%esp
80105561:	68 7f 84 10 80       	push   $0x8010847f
80105566:	e8 25 ae ff ff       	call   80100390 <panic>
8010556b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010556f:	90                   	nop
}
80105570:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105573:	31 f6                	xor    %esi,%esi
}
80105575:	5b                   	pop    %ebx
80105576:	89 f0                	mov    %esi,%eax
80105578:	5e                   	pop    %esi
80105579:	5f                   	pop    %edi
8010557a:	5d                   	pop    %ebp
8010557b:	c3                   	ret    
    panic("create: dirlink");
8010557c:	83 ec 0c             	sub    $0xc,%esp
8010557f:	68 8e 84 10 80       	push   $0x8010848e
80105584:	e8 07 ae ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105589:	83 ec 0c             	sub    $0xc,%esp
8010558c:	68 70 84 10 80       	push   $0x80108470
80105591:	e8 fa ad ff ff       	call   80100390 <panic>
80105596:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010559d:	8d 76 00             	lea    0x0(%esi),%esi

801055a0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	56                   	push   %esi
801055a4:	89 d6                	mov    %edx,%esi
801055a6:	53                   	push   %ebx
801055a7:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
801055a9:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
801055ac:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801055af:	50                   	push   %eax
801055b0:	6a 00                	push   $0x0
801055b2:	e8 e9 fc ff ff       	call   801052a0 <argint>
801055b7:	83 c4 10             	add    $0x10,%esp
801055ba:	85 c0                	test   %eax,%eax
801055bc:	78 2a                	js     801055e8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801055be:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055c2:	77 24                	ja     801055e8 <argfd.constprop.0+0x48>
801055c4:	e8 07 e9 ff ff       	call   80103ed0 <myproc>
801055c9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055cc:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
801055d0:	85 c0                	test   %eax,%eax
801055d2:	74 14                	je     801055e8 <argfd.constprop.0+0x48>
  if(pfd)
801055d4:	85 db                	test   %ebx,%ebx
801055d6:	74 02                	je     801055da <argfd.constprop.0+0x3a>
    *pfd = fd;
801055d8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801055da:	89 06                	mov    %eax,(%esi)
  return 0;
801055dc:	31 c0                	xor    %eax,%eax
}
801055de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055e1:	5b                   	pop    %ebx
801055e2:	5e                   	pop    %esi
801055e3:	5d                   	pop    %ebp
801055e4:	c3                   	ret    
801055e5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801055e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801055ed:	eb ef                	jmp    801055de <argfd.constprop.0+0x3e>
801055ef:	90                   	nop

801055f0 <sys_dup>:
{
801055f0:	f3 0f 1e fb          	endbr32 
801055f4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801055f5:	31 c0                	xor    %eax,%eax
{
801055f7:	89 e5                	mov    %esp,%ebp
801055f9:	56                   	push   %esi
801055fa:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801055fb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801055fe:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
80105601:	e8 9a ff ff ff       	call   801055a0 <argfd.constprop.0>
80105606:	85 c0                	test   %eax,%eax
80105608:	78 1e                	js     80105628 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
8010560a:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
8010560d:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010560f:	e8 bc e8 ff ff       	call   80103ed0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105618:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
8010561c:	85 d2                	test   %edx,%edx
8010561e:	74 20                	je     80105640 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105620:	83 c3 01             	add    $0x1,%ebx
80105623:	83 fb 10             	cmp    $0x10,%ebx
80105626:	75 f0                	jne    80105618 <sys_dup+0x28>
}
80105628:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010562b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105630:	89 d8                	mov    %ebx,%eax
80105632:	5b                   	pop    %ebx
80105633:	5e                   	pop    %esi
80105634:	5d                   	pop    %ebp
80105635:	c3                   	ret    
80105636:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010563d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105640:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80105644:	83 ec 0c             	sub    $0xc,%esp
80105647:	ff 75 f4             	pushl  -0xc(%ebp)
8010564a:	e8 e1 bc ff ff       	call   80101330 <filedup>
  return fd;
8010564f:	83 c4 10             	add    $0x10,%esp
}
80105652:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105655:	89 d8                	mov    %ebx,%eax
80105657:	5b                   	pop    %ebx
80105658:	5e                   	pop    %esi
80105659:	5d                   	pop    %ebp
8010565a:	c3                   	ret    
8010565b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010565f:	90                   	nop

80105660 <sys_read>:
{
80105660:	f3 0f 1e fb          	endbr32 
80105664:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105665:	31 c0                	xor    %eax,%eax
{
80105667:	89 e5                	mov    %esp,%ebp
80105669:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010566c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010566f:	e8 2c ff ff ff       	call   801055a0 <argfd.constprop.0>
80105674:	85 c0                	test   %eax,%eax
80105676:	78 48                	js     801056c0 <sys_read+0x60>
80105678:	83 ec 08             	sub    $0x8,%esp
8010567b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010567e:	50                   	push   %eax
8010567f:	6a 02                	push   $0x2
80105681:	e8 1a fc ff ff       	call   801052a0 <argint>
80105686:	83 c4 10             	add    $0x10,%esp
80105689:	85 c0                	test   %eax,%eax
8010568b:	78 33                	js     801056c0 <sys_read+0x60>
8010568d:	83 ec 04             	sub    $0x4,%esp
80105690:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105693:	ff 75 f0             	pushl  -0x10(%ebp)
80105696:	50                   	push   %eax
80105697:	6a 01                	push   $0x1
80105699:	e8 52 fc ff ff       	call   801052f0 <argptr>
8010569e:	83 c4 10             	add    $0x10,%esp
801056a1:	85 c0                	test   %eax,%eax
801056a3:	78 1b                	js     801056c0 <sys_read+0x60>
  return fileread(f, p, n);
801056a5:	83 ec 04             	sub    $0x4,%esp
801056a8:	ff 75 f0             	pushl  -0x10(%ebp)
801056ab:	ff 75 f4             	pushl  -0xc(%ebp)
801056ae:	ff 75 ec             	pushl  -0x14(%ebp)
801056b1:	e8 fa bd ff ff       	call   801014b0 <fileread>
801056b6:	83 c4 10             	add    $0x10,%esp
}
801056b9:	c9                   	leave  
801056ba:	c3                   	ret    
801056bb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801056bf:	90                   	nop
801056c0:	c9                   	leave  
    return -1;
801056c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801056c6:	c3                   	ret    
801056c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801056ce:	66 90                	xchg   %ax,%ax

801056d0 <sys_write>:
{
801056d0:	f3 0f 1e fb          	endbr32 
801056d4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056d5:	31 c0                	xor    %eax,%eax
{
801056d7:	89 e5                	mov    %esp,%ebp
801056d9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801056dc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801056df:	e8 bc fe ff ff       	call   801055a0 <argfd.constprop.0>
801056e4:	85 c0                	test   %eax,%eax
801056e6:	78 48                	js     80105730 <sys_write+0x60>
801056e8:	83 ec 08             	sub    $0x8,%esp
801056eb:	8d 45 f0             	lea    -0x10(%ebp),%eax
801056ee:	50                   	push   %eax
801056ef:	6a 02                	push   $0x2
801056f1:	e8 aa fb ff ff       	call   801052a0 <argint>
801056f6:	83 c4 10             	add    $0x10,%esp
801056f9:	85 c0                	test   %eax,%eax
801056fb:	78 33                	js     80105730 <sys_write+0x60>
801056fd:	83 ec 04             	sub    $0x4,%esp
80105700:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105703:	ff 75 f0             	pushl  -0x10(%ebp)
80105706:	50                   	push   %eax
80105707:	6a 01                	push   $0x1
80105709:	e8 e2 fb ff ff       	call   801052f0 <argptr>
8010570e:	83 c4 10             	add    $0x10,%esp
80105711:	85 c0                	test   %eax,%eax
80105713:	78 1b                	js     80105730 <sys_write+0x60>
  return filewrite(f, p, n);
80105715:	83 ec 04             	sub    $0x4,%esp
80105718:	ff 75 f0             	pushl  -0x10(%ebp)
8010571b:	ff 75 f4             	pushl  -0xc(%ebp)
8010571e:	ff 75 ec             	pushl  -0x14(%ebp)
80105721:	e8 2a be ff ff       	call   80101550 <filewrite>
80105726:	83 c4 10             	add    $0x10,%esp
}
80105729:	c9                   	leave  
8010572a:	c3                   	ret    
8010572b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010572f:	90                   	nop
80105730:	c9                   	leave  
    return -1;
80105731:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105736:	c3                   	ret    
80105737:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010573e:	66 90                	xchg   %ax,%ax

80105740 <sys_close>:
{
80105740:	f3 0f 1e fb          	endbr32 
80105744:	55                   	push   %ebp
80105745:	89 e5                	mov    %esp,%ebp
80105747:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010574a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010574d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105750:	e8 4b fe ff ff       	call   801055a0 <argfd.constprop.0>
80105755:	85 c0                	test   %eax,%eax
80105757:	78 27                	js     80105780 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105759:	e8 72 e7 ff ff       	call   80103ed0 <myproc>
8010575e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105761:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105764:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
8010576b:	00 
  fileclose(f);
8010576c:	ff 75 f4             	pushl  -0xc(%ebp)
8010576f:	e8 0c bc ff ff       	call   80101380 <fileclose>
  return 0;
80105774:	83 c4 10             	add    $0x10,%esp
80105777:	31 c0                	xor    %eax,%eax
}
80105779:	c9                   	leave  
8010577a:	c3                   	ret    
8010577b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010577f:	90                   	nop
80105780:	c9                   	leave  
    return -1;
80105781:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105786:	c3                   	ret    
80105787:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010578e:	66 90                	xchg   %ax,%ax

80105790 <sys_fstat>:
{
80105790:	f3 0f 1e fb          	endbr32 
80105794:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105795:	31 c0                	xor    %eax,%eax
{
80105797:	89 e5                	mov    %esp,%ebp
80105799:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010579c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010579f:	e8 fc fd ff ff       	call   801055a0 <argfd.constprop.0>
801057a4:	85 c0                	test   %eax,%eax
801057a6:	78 30                	js     801057d8 <sys_fstat+0x48>
801057a8:	83 ec 04             	sub    $0x4,%esp
801057ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057ae:	6a 14                	push   $0x14
801057b0:	50                   	push   %eax
801057b1:	6a 01                	push   $0x1
801057b3:	e8 38 fb ff ff       	call   801052f0 <argptr>
801057b8:	83 c4 10             	add    $0x10,%esp
801057bb:	85 c0                	test   %eax,%eax
801057bd:	78 19                	js     801057d8 <sys_fstat+0x48>
  return filestat(f, st);
801057bf:	83 ec 08             	sub    $0x8,%esp
801057c2:	ff 75 f4             	pushl  -0xc(%ebp)
801057c5:	ff 75 f0             	pushl  -0x10(%ebp)
801057c8:	e8 93 bc ff ff       	call   80101460 <filestat>
801057cd:	83 c4 10             	add    $0x10,%esp
}
801057d0:	c9                   	leave  
801057d1:	c3                   	ret    
801057d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801057d8:	c9                   	leave  
    return -1;
801057d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057de:	c3                   	ret    
801057df:	90                   	nop

801057e0 <sys_link>:
{
801057e0:	f3 0f 1e fb          	endbr32 
801057e4:	55                   	push   %ebp
801057e5:	89 e5                	mov    %esp,%ebp
801057e7:	57                   	push   %edi
801057e8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057e9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801057ec:	53                   	push   %ebx
801057ed:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801057f0:	50                   	push   %eax
801057f1:	6a 00                	push   $0x0
801057f3:	e8 58 fb ff ff       	call   80105350 <argstr>
801057f8:	83 c4 10             	add    $0x10,%esp
801057fb:	85 c0                	test   %eax,%eax
801057fd:	0f 88 ff 00 00 00    	js     80105902 <sys_link+0x122>
80105803:	83 ec 08             	sub    $0x8,%esp
80105806:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105809:	50                   	push   %eax
8010580a:	6a 01                	push   $0x1
8010580c:	e8 3f fb ff ff       	call   80105350 <argstr>
80105811:	83 c4 10             	add    $0x10,%esp
80105814:	85 c0                	test   %eax,%eax
80105816:	0f 88 e6 00 00 00    	js     80105902 <sys_link+0x122>
  begin_op();
8010581c:	e8 ef d9 ff ff       	call   80103210 <begin_op>
  if((ip = namei(old)) == 0){
80105821:	83 ec 0c             	sub    $0xc,%esp
80105824:	ff 75 d4             	pushl  -0x2c(%ebp)
80105827:	e8 c4 cc ff ff       	call   801024f0 <namei>
8010582c:	83 c4 10             	add    $0x10,%esp
8010582f:	89 c3                	mov    %eax,%ebx
80105831:	85 c0                	test   %eax,%eax
80105833:	0f 84 e8 00 00 00    	je     80105921 <sys_link+0x141>
  ilock(ip);
80105839:	83 ec 0c             	sub    $0xc,%esp
8010583c:	50                   	push   %eax
8010583d:	e8 de c3 ff ff       	call   80101c20 <ilock>
  if(ip->type == T_DIR){
80105842:	83 c4 10             	add    $0x10,%esp
80105845:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010584a:	0f 84 b9 00 00 00    	je     80105909 <sys_link+0x129>
  iupdate(ip);
80105850:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105853:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105858:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
8010585b:	53                   	push   %ebx
8010585c:	e8 ff c2 ff ff       	call   80101b60 <iupdate>
  iunlock(ip);
80105861:	89 1c 24             	mov    %ebx,(%esp)
80105864:	e8 97 c4 ff ff       	call   80101d00 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105869:	58                   	pop    %eax
8010586a:	5a                   	pop    %edx
8010586b:	57                   	push   %edi
8010586c:	ff 75 d0             	pushl  -0x30(%ebp)
8010586f:	e8 9c cc ff ff       	call   80102510 <nameiparent>
80105874:	83 c4 10             	add    $0x10,%esp
80105877:	89 c6                	mov    %eax,%esi
80105879:	85 c0                	test   %eax,%eax
8010587b:	74 5f                	je     801058dc <sys_link+0xfc>
  ilock(dp);
8010587d:	83 ec 0c             	sub    $0xc,%esp
80105880:	50                   	push   %eax
80105881:	e8 9a c3 ff ff       	call   80101c20 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105886:	8b 03                	mov    (%ebx),%eax
80105888:	83 c4 10             	add    $0x10,%esp
8010588b:	39 06                	cmp    %eax,(%esi)
8010588d:	75 41                	jne    801058d0 <sys_link+0xf0>
8010588f:	83 ec 04             	sub    $0x4,%esp
80105892:	ff 73 04             	pushl  0x4(%ebx)
80105895:	57                   	push   %edi
80105896:	56                   	push   %esi
80105897:	e8 94 cb ff ff       	call   80102430 <dirlink>
8010589c:	83 c4 10             	add    $0x10,%esp
8010589f:	85 c0                	test   %eax,%eax
801058a1:	78 2d                	js     801058d0 <sys_link+0xf0>
  iunlockput(dp);
801058a3:	83 ec 0c             	sub    $0xc,%esp
801058a6:	56                   	push   %esi
801058a7:	e8 14 c6 ff ff       	call   80101ec0 <iunlockput>
  iput(ip);
801058ac:	89 1c 24             	mov    %ebx,(%esp)
801058af:	e8 9c c4 ff ff       	call   80101d50 <iput>
  end_op();
801058b4:	e8 c7 d9 ff ff       	call   80103280 <end_op>
  return 0;
801058b9:	83 c4 10             	add    $0x10,%esp
801058bc:	31 c0                	xor    %eax,%eax
}
801058be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058c1:	5b                   	pop    %ebx
801058c2:	5e                   	pop    %esi
801058c3:	5f                   	pop    %edi
801058c4:	5d                   	pop    %ebp
801058c5:	c3                   	ret    
801058c6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058cd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
801058d0:	83 ec 0c             	sub    $0xc,%esp
801058d3:	56                   	push   %esi
801058d4:	e8 e7 c5 ff ff       	call   80101ec0 <iunlockput>
    goto bad;
801058d9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801058dc:	83 ec 0c             	sub    $0xc,%esp
801058df:	53                   	push   %ebx
801058e0:	e8 3b c3 ff ff       	call   80101c20 <ilock>
  ip->nlink--;
801058e5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801058ea:	89 1c 24             	mov    %ebx,(%esp)
801058ed:	e8 6e c2 ff ff       	call   80101b60 <iupdate>
  iunlockput(ip);
801058f2:	89 1c 24             	mov    %ebx,(%esp)
801058f5:	e8 c6 c5 ff ff       	call   80101ec0 <iunlockput>
  end_op();
801058fa:	e8 81 d9 ff ff       	call   80103280 <end_op>
  return -1;
801058ff:	83 c4 10             	add    $0x10,%esp
80105902:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105907:	eb b5                	jmp    801058be <sys_link+0xde>
    iunlockput(ip);
80105909:	83 ec 0c             	sub    $0xc,%esp
8010590c:	53                   	push   %ebx
8010590d:	e8 ae c5 ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105912:	e8 69 d9 ff ff       	call   80103280 <end_op>
    return -1;
80105917:	83 c4 10             	add    $0x10,%esp
8010591a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010591f:	eb 9d                	jmp    801058be <sys_link+0xde>
    end_op();
80105921:	e8 5a d9 ff ff       	call   80103280 <end_op>
    return -1;
80105926:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010592b:	eb 91                	jmp    801058be <sys_link+0xde>
8010592d:	8d 76 00             	lea    0x0(%esi),%esi

80105930 <sys_unlink>:
{
80105930:	f3 0f 1e fb          	endbr32 
80105934:	55                   	push   %ebp
80105935:	89 e5                	mov    %esp,%ebp
80105937:	57                   	push   %edi
80105938:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105939:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
8010593c:	53                   	push   %ebx
8010593d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105940:	50                   	push   %eax
80105941:	6a 00                	push   $0x0
80105943:	e8 08 fa ff ff       	call   80105350 <argstr>
80105948:	83 c4 10             	add    $0x10,%esp
8010594b:	85 c0                	test   %eax,%eax
8010594d:	0f 88 7d 01 00 00    	js     80105ad0 <sys_unlink+0x1a0>
  begin_op();
80105953:	e8 b8 d8 ff ff       	call   80103210 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105958:	8d 5d ca             	lea    -0x36(%ebp),%ebx
8010595b:	83 ec 08             	sub    $0x8,%esp
8010595e:	53                   	push   %ebx
8010595f:	ff 75 c0             	pushl  -0x40(%ebp)
80105962:	e8 a9 cb ff ff       	call   80102510 <nameiparent>
80105967:	83 c4 10             	add    $0x10,%esp
8010596a:	89 c6                	mov    %eax,%esi
8010596c:	85 c0                	test   %eax,%eax
8010596e:	0f 84 66 01 00 00    	je     80105ada <sys_unlink+0x1aa>
  ilock(dp);
80105974:	83 ec 0c             	sub    $0xc,%esp
80105977:	50                   	push   %eax
80105978:	e8 a3 c2 ff ff       	call   80101c20 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010597d:	58                   	pop    %eax
8010597e:	5a                   	pop    %edx
8010597f:	68 8c 84 10 80       	push   $0x8010848c
80105984:	53                   	push   %ebx
80105985:	e8 c6 c7 ff ff       	call   80102150 <namecmp>
8010598a:	83 c4 10             	add    $0x10,%esp
8010598d:	85 c0                	test   %eax,%eax
8010598f:	0f 84 03 01 00 00    	je     80105a98 <sys_unlink+0x168>
80105995:	83 ec 08             	sub    $0x8,%esp
80105998:	68 8b 84 10 80       	push   $0x8010848b
8010599d:	53                   	push   %ebx
8010599e:	e8 ad c7 ff ff       	call   80102150 <namecmp>
801059a3:	83 c4 10             	add    $0x10,%esp
801059a6:	85 c0                	test   %eax,%eax
801059a8:	0f 84 ea 00 00 00    	je     80105a98 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
801059ae:	83 ec 04             	sub    $0x4,%esp
801059b1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801059b4:	50                   	push   %eax
801059b5:	53                   	push   %ebx
801059b6:	56                   	push   %esi
801059b7:	e8 b4 c7 ff ff       	call   80102170 <dirlookup>
801059bc:	83 c4 10             	add    $0x10,%esp
801059bf:	89 c3                	mov    %eax,%ebx
801059c1:	85 c0                	test   %eax,%eax
801059c3:	0f 84 cf 00 00 00    	je     80105a98 <sys_unlink+0x168>
  ilock(ip);
801059c9:	83 ec 0c             	sub    $0xc,%esp
801059cc:	50                   	push   %eax
801059cd:	e8 4e c2 ff ff       	call   80101c20 <ilock>
  if(ip->nlink < 1)
801059d2:	83 c4 10             	add    $0x10,%esp
801059d5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801059da:	0f 8e 23 01 00 00    	jle    80105b03 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
801059e0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801059e5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801059e8:	74 66                	je     80105a50 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801059ea:	83 ec 04             	sub    $0x4,%esp
801059ed:	6a 10                	push   $0x10
801059ef:	6a 00                	push   $0x0
801059f1:	57                   	push   %edi
801059f2:	e8 c9 f5 ff ff       	call   80104fc0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801059f7:	6a 10                	push   $0x10
801059f9:	ff 75 c4             	pushl  -0x3c(%ebp)
801059fc:	57                   	push   %edi
801059fd:	56                   	push   %esi
801059fe:	e8 1d c6 ff ff       	call   80102020 <writei>
80105a03:	83 c4 20             	add    $0x20,%esp
80105a06:	83 f8 10             	cmp    $0x10,%eax
80105a09:	0f 85 e7 00 00 00    	jne    80105af6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
80105a0f:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a14:	0f 84 96 00 00 00    	je     80105ab0 <sys_unlink+0x180>
  iunlockput(dp);
80105a1a:	83 ec 0c             	sub    $0xc,%esp
80105a1d:	56                   	push   %esi
80105a1e:	e8 9d c4 ff ff       	call   80101ec0 <iunlockput>
  ip->nlink--;
80105a23:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105a28:	89 1c 24             	mov    %ebx,(%esp)
80105a2b:	e8 30 c1 ff ff       	call   80101b60 <iupdate>
  iunlockput(ip);
80105a30:	89 1c 24             	mov    %ebx,(%esp)
80105a33:	e8 88 c4 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105a38:	e8 43 d8 ff ff       	call   80103280 <end_op>
  return 0;
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	31 c0                	xor    %eax,%eax
}
80105a42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a45:	5b                   	pop    %ebx
80105a46:	5e                   	pop    %esi
80105a47:	5f                   	pop    %edi
80105a48:	5d                   	pop    %ebp
80105a49:	c3                   	ret    
80105a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105a50:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105a54:	76 94                	jbe    801059ea <sys_unlink+0xba>
80105a56:	ba 20 00 00 00       	mov    $0x20,%edx
80105a5b:	eb 0b                	jmp    80105a68 <sys_unlink+0x138>
80105a5d:	8d 76 00             	lea    0x0(%esi),%esi
80105a60:	83 c2 10             	add    $0x10,%edx
80105a63:	39 53 58             	cmp    %edx,0x58(%ebx)
80105a66:	76 82                	jbe    801059ea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105a68:	6a 10                	push   $0x10
80105a6a:	52                   	push   %edx
80105a6b:	57                   	push   %edi
80105a6c:	53                   	push   %ebx
80105a6d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105a70:	e8 ab c4 ff ff       	call   80101f20 <readi>
80105a75:	83 c4 10             	add    $0x10,%esp
80105a78:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105a7b:	83 f8 10             	cmp    $0x10,%eax
80105a7e:	75 69                	jne    80105ae9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105a80:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105a85:	74 d9                	je     80105a60 <sys_unlink+0x130>
    iunlockput(ip);
80105a87:	83 ec 0c             	sub    $0xc,%esp
80105a8a:	53                   	push   %ebx
80105a8b:	e8 30 c4 ff ff       	call   80101ec0 <iunlockput>
    goto bad;
80105a90:	83 c4 10             	add    $0x10,%esp
80105a93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105a97:	90                   	nop
  iunlockput(dp);
80105a98:	83 ec 0c             	sub    $0xc,%esp
80105a9b:	56                   	push   %esi
80105a9c:	e8 1f c4 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105aa1:	e8 da d7 ff ff       	call   80103280 <end_op>
  return -1;
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105aae:	eb 92                	jmp    80105a42 <sys_unlink+0x112>
    iupdate(dp);
80105ab0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105ab3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105ab8:	56                   	push   %esi
80105ab9:	e8 a2 c0 ff ff       	call   80101b60 <iupdate>
80105abe:	83 c4 10             	add    $0x10,%esp
80105ac1:	e9 54 ff ff ff       	jmp    80105a1a <sys_unlink+0xea>
80105ac6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105acd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ad5:	e9 68 ff ff ff       	jmp    80105a42 <sys_unlink+0x112>
    end_op();
80105ada:	e8 a1 d7 ff ff       	call   80103280 <end_op>
    return -1;
80105adf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ae4:	e9 59 ff ff ff       	jmp    80105a42 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105ae9:	83 ec 0c             	sub    $0xc,%esp
80105aec:	68 b0 84 10 80       	push   $0x801084b0
80105af1:	e8 9a a8 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105af6:	83 ec 0c             	sub    $0xc,%esp
80105af9:	68 c2 84 10 80       	push   $0x801084c2
80105afe:	e8 8d a8 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105b03:	83 ec 0c             	sub    $0xc,%esp
80105b06:	68 9e 84 10 80       	push   $0x8010849e
80105b0b:	e8 80 a8 ff ff       	call   80100390 <panic>

80105b10 <sys_open>:

int
sys_open(void)
{
80105b10:	f3 0f 1e fb          	endbr32 
80105b14:	55                   	push   %ebp
80105b15:	89 e5                	mov    %esp,%ebp
80105b17:	57                   	push   %edi
80105b18:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b19:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105b1c:	53                   	push   %ebx
80105b1d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105b20:	50                   	push   %eax
80105b21:	6a 00                	push   $0x0
80105b23:	e8 28 f8 ff ff       	call   80105350 <argstr>
80105b28:	83 c4 10             	add    $0x10,%esp
80105b2b:	85 c0                	test   %eax,%eax
80105b2d:	0f 88 8a 00 00 00    	js     80105bbd <sys_open+0xad>
80105b33:	83 ec 08             	sub    $0x8,%esp
80105b36:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105b39:	50                   	push   %eax
80105b3a:	6a 01                	push   $0x1
80105b3c:	e8 5f f7 ff ff       	call   801052a0 <argint>
80105b41:	83 c4 10             	add    $0x10,%esp
80105b44:	85 c0                	test   %eax,%eax
80105b46:	78 75                	js     80105bbd <sys_open+0xad>
    return -1;

  begin_op();
80105b48:	e8 c3 d6 ff ff       	call   80103210 <begin_op>

  if(omode & O_CREATE){
80105b4d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105b51:	75 75                	jne    80105bc8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105b53:	83 ec 0c             	sub    $0xc,%esp
80105b56:	ff 75 e0             	pushl  -0x20(%ebp)
80105b59:	e8 92 c9 ff ff       	call   801024f0 <namei>
80105b5e:	83 c4 10             	add    $0x10,%esp
80105b61:	89 c6                	mov    %eax,%esi
80105b63:	85 c0                	test   %eax,%eax
80105b65:	74 7e                	je     80105be5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105b67:	83 ec 0c             	sub    $0xc,%esp
80105b6a:	50                   	push   %eax
80105b6b:	e8 b0 c0 ff ff       	call   80101c20 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105b70:	83 c4 10             	add    $0x10,%esp
80105b73:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105b78:	0f 84 c2 00 00 00    	je     80105c40 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105b7e:	e8 3d b7 ff ff       	call   801012c0 <filealloc>
80105b83:	89 c7                	mov    %eax,%edi
80105b85:	85 c0                	test   %eax,%eax
80105b87:	74 23                	je     80105bac <sys_open+0x9c>
  struct proc *curproc = myproc();
80105b89:	e8 42 e3 ff ff       	call   80103ed0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b8e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105b90:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105b94:	85 d2                	test   %edx,%edx
80105b96:	74 60                	je     80105bf8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105b98:	83 c3 01             	add    $0x1,%ebx
80105b9b:	83 fb 10             	cmp    $0x10,%ebx
80105b9e:	75 f0                	jne    80105b90 <sys_open+0x80>
    if(f)
      fileclose(f);
80105ba0:	83 ec 0c             	sub    $0xc,%esp
80105ba3:	57                   	push   %edi
80105ba4:	e8 d7 b7 ff ff       	call   80101380 <fileclose>
80105ba9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105bac:	83 ec 0c             	sub    $0xc,%esp
80105baf:	56                   	push   %esi
80105bb0:	e8 0b c3 ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105bb5:	e8 c6 d6 ff ff       	call   80103280 <end_op>
    return -1;
80105bba:	83 c4 10             	add    $0x10,%esp
80105bbd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105bc2:	eb 6d                	jmp    80105c31 <sys_open+0x121>
80105bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105bc8:	83 ec 0c             	sub    $0xc,%esp
80105bcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105bce:	31 c9                	xor    %ecx,%ecx
80105bd0:	ba 02 00 00 00       	mov    $0x2,%edx
80105bd5:	6a 00                	push   $0x0
80105bd7:	e8 24 f8 ff ff       	call   80105400 <create>
    if(ip == 0){
80105bdc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105bdf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105be1:	85 c0                	test   %eax,%eax
80105be3:	75 99                	jne    80105b7e <sys_open+0x6e>
      end_op();
80105be5:	e8 96 d6 ff ff       	call   80103280 <end_op>
      return -1;
80105bea:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105bef:	eb 40                	jmp    80105c31 <sys_open+0x121>
80105bf1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105bf8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105bfb:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
80105bff:	56                   	push   %esi
80105c00:	e8 fb c0 ff ff       	call   80101d00 <iunlock>
  end_op();
80105c05:	e8 76 d6 ff ff       	call   80103280 <end_op>

  f->type = FD_INODE;
80105c0a:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105c10:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c13:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105c16:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105c19:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105c1b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105c22:	f7 d0                	not    %eax
80105c24:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c27:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105c2a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105c2d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105c31:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c34:	89 d8                	mov    %ebx,%eax
80105c36:	5b                   	pop    %ebx
80105c37:	5e                   	pop    %esi
80105c38:	5f                   	pop    %edi
80105c39:	5d                   	pop    %ebp
80105c3a:	c3                   	ret    
80105c3b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c3f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105c40:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105c43:	85 c9                	test   %ecx,%ecx
80105c45:	0f 84 33 ff ff ff    	je     80105b7e <sys_open+0x6e>
80105c4b:	e9 5c ff ff ff       	jmp    80105bac <sys_open+0x9c>

80105c50 <sys_mkdir>:

int
sys_mkdir(void)
{
80105c50:	f3 0f 1e fb          	endbr32 
80105c54:	55                   	push   %ebp
80105c55:	89 e5                	mov    %esp,%ebp
80105c57:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105c5a:	e8 b1 d5 ff ff       	call   80103210 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105c5f:	83 ec 08             	sub    $0x8,%esp
80105c62:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c65:	50                   	push   %eax
80105c66:	6a 00                	push   $0x0
80105c68:	e8 e3 f6 ff ff       	call   80105350 <argstr>
80105c6d:	83 c4 10             	add    $0x10,%esp
80105c70:	85 c0                	test   %eax,%eax
80105c72:	78 34                	js     80105ca8 <sys_mkdir+0x58>
80105c74:	83 ec 0c             	sub    $0xc,%esp
80105c77:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c7a:	31 c9                	xor    %ecx,%ecx
80105c7c:	ba 01 00 00 00       	mov    $0x1,%edx
80105c81:	6a 00                	push   $0x0
80105c83:	e8 78 f7 ff ff       	call   80105400 <create>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	85 c0                	test   %eax,%eax
80105c8d:	74 19                	je     80105ca8 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105c8f:	83 ec 0c             	sub    $0xc,%esp
80105c92:	50                   	push   %eax
80105c93:	e8 28 c2 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105c98:	e8 e3 d5 ff ff       	call   80103280 <end_op>
  return 0;
80105c9d:	83 c4 10             	add    $0x10,%esp
80105ca0:	31 c0                	xor    %eax,%eax
}
80105ca2:	c9                   	leave  
80105ca3:	c3                   	ret    
80105ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105ca8:	e8 d3 d5 ff ff       	call   80103280 <end_op>
    return -1;
80105cad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105cb2:	c9                   	leave  
80105cb3:	c3                   	ret    
80105cb4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105cbf:	90                   	nop

80105cc0 <sys_mknod>:

int
sys_mknod(void)
{
80105cc0:	f3 0f 1e fb          	endbr32 
80105cc4:	55                   	push   %ebp
80105cc5:	89 e5                	mov    %esp,%ebp
80105cc7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105cca:	e8 41 d5 ff ff       	call   80103210 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105ccf:	83 ec 08             	sub    $0x8,%esp
80105cd2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105cd5:	50                   	push   %eax
80105cd6:	6a 00                	push   $0x0
80105cd8:	e8 73 f6 ff ff       	call   80105350 <argstr>
80105cdd:	83 c4 10             	add    $0x10,%esp
80105ce0:	85 c0                	test   %eax,%eax
80105ce2:	78 64                	js     80105d48 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105ce4:	83 ec 08             	sub    $0x8,%esp
80105ce7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cea:	50                   	push   %eax
80105ceb:	6a 01                	push   $0x1
80105ced:	e8 ae f5 ff ff       	call   801052a0 <argint>
  if((argstr(0, &path)) < 0 ||
80105cf2:	83 c4 10             	add    $0x10,%esp
80105cf5:	85 c0                	test   %eax,%eax
80105cf7:	78 4f                	js     80105d48 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105cf9:	83 ec 08             	sub    $0x8,%esp
80105cfc:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cff:	50                   	push   %eax
80105d00:	6a 02                	push   $0x2
80105d02:	e8 99 f5 ff ff       	call   801052a0 <argint>
     argint(1, &major) < 0 ||
80105d07:	83 c4 10             	add    $0x10,%esp
80105d0a:	85 c0                	test   %eax,%eax
80105d0c:	78 3a                	js     80105d48 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105d0e:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105d12:	83 ec 0c             	sub    $0xc,%esp
80105d15:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105d19:	ba 03 00 00 00       	mov    $0x3,%edx
80105d1e:	50                   	push   %eax
80105d1f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105d22:	e8 d9 f6 ff ff       	call   80105400 <create>
     argint(2, &minor) < 0 ||
80105d27:	83 c4 10             	add    $0x10,%esp
80105d2a:	85 c0                	test   %eax,%eax
80105d2c:	74 1a                	je     80105d48 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105d2e:	83 ec 0c             	sub    $0xc,%esp
80105d31:	50                   	push   %eax
80105d32:	e8 89 c1 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105d37:	e8 44 d5 ff ff       	call   80103280 <end_op>
  return 0;
80105d3c:	83 c4 10             	add    $0x10,%esp
80105d3f:	31 c0                	xor    %eax,%eax
}
80105d41:	c9                   	leave  
80105d42:	c3                   	ret    
80105d43:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d47:	90                   	nop
    end_op();
80105d48:	e8 33 d5 ff ff       	call   80103280 <end_op>
    return -1;
80105d4d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d52:	c9                   	leave  
80105d53:	c3                   	ret    
80105d54:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105d5f:	90                   	nop

80105d60 <sys_chdir>:

int
sys_chdir(void)
{
80105d60:	f3 0f 1e fb          	endbr32 
80105d64:	55                   	push   %ebp
80105d65:	89 e5                	mov    %esp,%ebp
80105d67:	56                   	push   %esi
80105d68:	53                   	push   %ebx
80105d69:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105d6c:	e8 5f e1 ff ff       	call   80103ed0 <myproc>
80105d71:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105d73:	e8 98 d4 ff ff       	call   80103210 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105d78:	83 ec 08             	sub    $0x8,%esp
80105d7b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d7e:	50                   	push   %eax
80105d7f:	6a 00                	push   $0x0
80105d81:	e8 ca f5 ff ff       	call   80105350 <argstr>
80105d86:	83 c4 10             	add    $0x10,%esp
80105d89:	85 c0                	test   %eax,%eax
80105d8b:	78 73                	js     80105e00 <sys_chdir+0xa0>
80105d8d:	83 ec 0c             	sub    $0xc,%esp
80105d90:	ff 75 f4             	pushl  -0xc(%ebp)
80105d93:	e8 58 c7 ff ff       	call   801024f0 <namei>
80105d98:	83 c4 10             	add    $0x10,%esp
80105d9b:	89 c3                	mov    %eax,%ebx
80105d9d:	85 c0                	test   %eax,%eax
80105d9f:	74 5f                	je     80105e00 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105da1:	83 ec 0c             	sub    $0xc,%esp
80105da4:	50                   	push   %eax
80105da5:	e8 76 be ff ff       	call   80101c20 <ilock>
  if(ip->type != T_DIR){
80105daa:	83 c4 10             	add    $0x10,%esp
80105dad:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105db2:	75 2c                	jne    80105de0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105db4:	83 ec 0c             	sub    $0xc,%esp
80105db7:	53                   	push   %ebx
80105db8:	e8 43 bf ff ff       	call   80101d00 <iunlock>
  iput(curproc->cwd);
80105dbd:	58                   	pop    %eax
80105dbe:	ff 76 6c             	pushl  0x6c(%esi)
80105dc1:	e8 8a bf ff ff       	call   80101d50 <iput>
  end_op();
80105dc6:	e8 b5 d4 ff ff       	call   80103280 <end_op>
  curproc->cwd = ip;
80105dcb:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
80105dce:	83 c4 10             	add    $0x10,%esp
80105dd1:	31 c0                	xor    %eax,%eax
}
80105dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105dd6:	5b                   	pop    %ebx
80105dd7:	5e                   	pop    %esi
80105dd8:	5d                   	pop    %ebp
80105dd9:	c3                   	ret    
80105dda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105de0:	83 ec 0c             	sub    $0xc,%esp
80105de3:	53                   	push   %ebx
80105de4:	e8 d7 c0 ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105de9:	e8 92 d4 ff ff       	call   80103280 <end_op>
    return -1;
80105dee:	83 c4 10             	add    $0x10,%esp
80105df1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105df6:	eb db                	jmp    80105dd3 <sys_chdir+0x73>
80105df8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dff:	90                   	nop
    end_op();
80105e00:	e8 7b d4 ff ff       	call   80103280 <end_op>
    return -1;
80105e05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0a:	eb c7                	jmp    80105dd3 <sys_chdir+0x73>
80105e0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105e10 <sys_exec>:

int
sys_exec(void)
{
80105e10:	f3 0f 1e fb          	endbr32 
80105e14:	55                   	push   %ebp
80105e15:	89 e5                	mov    %esp,%ebp
80105e17:	57                   	push   %edi
80105e18:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e19:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
80105e1f:	53                   	push   %ebx
80105e20:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105e26:	50                   	push   %eax
80105e27:	6a 00                	push   $0x0
80105e29:	e8 22 f5 ff ff       	call   80105350 <argstr>
80105e2e:	83 c4 10             	add    $0x10,%esp
80105e31:	85 c0                	test   %eax,%eax
80105e33:	0f 88 8b 00 00 00    	js     80105ec4 <sys_exec+0xb4>
80105e39:	83 ec 08             	sub    $0x8,%esp
80105e3c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105e42:	50                   	push   %eax
80105e43:	6a 01                	push   $0x1
80105e45:	e8 56 f4 ff ff       	call   801052a0 <argint>
80105e4a:	83 c4 10             	add    $0x10,%esp
80105e4d:	85 c0                	test   %eax,%eax
80105e4f:	78 73                	js     80105ec4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80105e51:	83 ec 04             	sub    $0x4,%esp
80105e54:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
80105e5a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105e5c:	68 80 00 00 00       	push   $0x80
80105e61:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80105e67:	6a 00                	push   $0x0
80105e69:	50                   	push   %eax
80105e6a:	e8 51 f1 ff ff       	call   80104fc0 <memset>
80105e6f:	83 c4 10             	add    $0x10,%esp
80105e72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105e78:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105e7e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105e85:	83 ec 08             	sub    $0x8,%esp
80105e88:	57                   	push   %edi
80105e89:	01 f0                	add    %esi,%eax
80105e8b:	50                   	push   %eax
80105e8c:	e8 6f f3 ff ff       	call   80105200 <fetchint>
80105e91:	83 c4 10             	add    $0x10,%esp
80105e94:	85 c0                	test   %eax,%eax
80105e96:	78 2c                	js     80105ec4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80105e98:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105e9e:	85 c0                	test   %eax,%eax
80105ea0:	74 36                	je     80105ed8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105ea2:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80105ea8:	83 ec 08             	sub    $0x8,%esp
80105eab:	8d 14 31             	lea    (%ecx,%esi,1),%edx
80105eae:	52                   	push   %edx
80105eaf:	50                   	push   %eax
80105eb0:	e8 8b f3 ff ff       	call   80105240 <fetchstr>
80105eb5:	83 c4 10             	add    $0x10,%esp
80105eb8:	85 c0                	test   %eax,%eax
80105eba:	78 08                	js     80105ec4 <sys_exec+0xb4>
  for(i=0;; i++){
80105ebc:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105ebf:	83 fb 20             	cmp    $0x20,%ebx
80105ec2:	75 b4                	jne    80105e78 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
80105ec4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
80105ec7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ecc:	5b                   	pop    %ebx
80105ecd:	5e                   	pop    %esi
80105ece:	5f                   	pop    %edi
80105ecf:	5d                   	pop    %ebp
80105ed0:	c3                   	ret    
80105ed1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105ed8:	83 ec 08             	sub    $0x8,%esp
80105edb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
80105ee1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105ee8:	00 00 00 00 
  return exec(path, argv);
80105eec:	50                   	push   %eax
80105eed:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
80105ef3:	e8 48 b0 ff ff       	call   80100f40 <exec>
80105ef8:	83 c4 10             	add    $0x10,%esp
}
80105efb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105efe:	5b                   	pop    %ebx
80105eff:	5e                   	pop    %esi
80105f00:	5f                   	pop    %edi
80105f01:	5d                   	pop    %ebp
80105f02:	c3                   	ret    
80105f03:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105f10 <sys_pipe>:

int
sys_pipe(void)
{
80105f10:	f3 0f 1e fb          	endbr32 
80105f14:	55                   	push   %ebp
80105f15:	89 e5                	mov    %esp,%ebp
80105f17:	57                   	push   %edi
80105f18:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f19:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105f1c:	53                   	push   %ebx
80105f1d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105f20:	6a 08                	push   $0x8
80105f22:	50                   	push   %eax
80105f23:	6a 00                	push   $0x0
80105f25:	e8 c6 f3 ff ff       	call   801052f0 <argptr>
80105f2a:	83 c4 10             	add    $0x10,%esp
80105f2d:	85 c0                	test   %eax,%eax
80105f2f:	78 4e                	js     80105f7f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105f31:	83 ec 08             	sub    $0x8,%esp
80105f34:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105f37:	50                   	push   %eax
80105f38:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105f3b:	50                   	push   %eax
80105f3c:	e8 8f d9 ff ff       	call   801038d0 <pipealloc>
80105f41:	83 c4 10             	add    $0x10,%esp
80105f44:	85 c0                	test   %eax,%eax
80105f46:	78 37                	js     80105f7f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f48:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
80105f4b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
80105f4d:	e8 7e df ff ff       	call   80103ed0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80105f58:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
80105f5c:	85 f6                	test   %esi,%esi
80105f5e:	74 30                	je     80105f90 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80105f60:	83 c3 01             	add    $0x1,%ebx
80105f63:	83 fb 10             	cmp    $0x10,%ebx
80105f66:	75 f0                	jne    80105f58 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80105f68:	83 ec 0c             	sub    $0xc,%esp
80105f6b:	ff 75 e0             	pushl  -0x20(%ebp)
80105f6e:	e8 0d b4 ff ff       	call   80101380 <fileclose>
    fileclose(wf);
80105f73:	58                   	pop    %eax
80105f74:	ff 75 e4             	pushl  -0x1c(%ebp)
80105f77:	e8 04 b4 ff ff       	call   80101380 <fileclose>
    return -1;
80105f7c:	83 c4 10             	add    $0x10,%esp
80105f7f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f84:	eb 5b                	jmp    80105fe1 <sys_pipe+0xd1>
80105f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f8d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105f90:	8d 73 08             	lea    0x8(%ebx),%esi
80105f93:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105f97:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
80105f9a:	e8 31 df ff ff       	call   80103ed0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105f9f:	31 d2                	xor    %edx,%edx
80105fa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105fa8:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
80105fac:	85 c9                	test   %ecx,%ecx
80105fae:	74 20                	je     80105fd0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
80105fb0:	83 c2 01             	add    $0x1,%edx
80105fb3:	83 fa 10             	cmp    $0x10,%edx
80105fb6:	75 f0                	jne    80105fa8 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80105fb8:	e8 13 df ff ff       	call   80103ed0 <myproc>
80105fbd:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
80105fc4:	00 
80105fc5:	eb a1                	jmp    80105f68 <sys_pipe+0x58>
80105fc7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fce:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
80105fd0:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
  }
  fd[0] = fd0;
80105fd4:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105fd7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105fd9:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105fdc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105fdf:	31 c0                	xor    %eax,%eax
}
80105fe1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105fe4:	5b                   	pop    %ebx
80105fe5:	5e                   	pop    %esi
80105fe6:	5f                   	pop    %edi
80105fe7:	5d                   	pop    %ebp
80105fe8:	c3                   	ret    
80105fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ff0 <sys_get_file_sectors>:
int
sys_get_file_sectors(void){
80105ff0:	f3 0f 1e fb          	endbr32 
80105ff4:	55                   	push   %ebp
80105ff5:	89 e5                	mov    %esp,%ebp
80105ff7:	57                   	push   %edi
80105ff8:	56                   	push   %esi
    int fd;

    char* tmp;
    int n;

    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
80105ff9:	8d 55 d8             	lea    -0x28(%ebp),%edx
80105ffc:	8d 45 dc             	lea    -0x24(%ebp),%eax
sys_get_file_sectors(void){
80105fff:	53                   	push   %ebx
80106000:	83 ec 2c             	sub    $0x2c,%esp
    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
80106003:	e8 98 f5 ff ff       	call   801055a0 <argfd.constprop.0>
80106008:	85 c0                	test   %eax,%eax
8010600a:	0f 88 c0 00 00 00    	js     801060d0 <sys_get_file_sectors+0xe0>
80106010:	83 ec 08             	sub    $0x8,%esp
80106013:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106016:	50                   	push   %eax
80106017:	6a 02                	push   $0x2
80106019:	e8 82 f2 ff ff       	call   801052a0 <argint>
8010601e:	83 c4 10             	add    $0x10,%esp
80106021:	85 c0                	test   %eax,%eax
80106023:	0f 88 a7 00 00 00    	js     801060d0 <sys_get_file_sectors+0xe0>
80106029:	83 ec 04             	sub    $0x4,%esp
8010602c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010602f:	ff 75 e4             	pushl  -0x1c(%ebp)
80106032:	50                   	push   %eax
80106033:	6a 01                	push   $0x1
80106035:	e8 b6 f2 ff ff       	call   801052f0 <argptr>
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	85 c0                	test   %eax,%eax
8010603f:	0f 88 8b 00 00 00    	js     801060d0 <sys_get_file_sectors+0xe0>
        return -1;
    int* sectors = (int*) tmp;
80106045:	8b 45 e0             	mov    -0x20(%ebp),%eax

    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
80106048:	31 d2                	xor    %edx,%edx
    int* sectors = (int*) tmp;
8010604a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
8010604d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106050:	8b 40 10             	mov    0x10(%eax),%eax
80106053:	8b 70 58             	mov    0x58(%eax),%esi
80106056:	f7 c6 ff 01 00 00    	test   $0x1ff,%esi
8010605c:	0f 95 c2             	setne  %dl
8010605f:	c1 ee 09             	shr    $0x9,%esi
80106062:	01 d6                	add    %edx,%esi
    int min_end = n < blkcnt ? n : blkcnt;
80106064:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106067:	39 d6                	cmp    %edx,%esi
80106069:	0f 4f f2             	cmovg  %edx,%esi

    int i;
    for(i=0;i<min_end;i++){
8010606c:	85 f6                	test   %esi,%esi
8010606e:	7e 37                	jle    801060a7 <sys_get_file_sectors+0xb7>
80106070:	31 db                	xor    %ebx,%ebx
80106072:	eb 0a                	jmp    8010607e <sys_get_file_sectors+0x8e>
80106074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106078:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010607b:	8b 40 10             	mov    0x10(%eax),%eax
        int sec = getbmap(f->ip, i);
8010607e:	83 ec 08             	sub    $0x8,%esp
80106081:	53                   	push   %ebx
80106082:	50                   	push   %eax
80106083:	e8 a8 c4 ff ff       	call   80102530 <getbmap>
80106088:	89 c7                	mov    %eax,%edi
        cprintf("%d ", sec);
8010608a:	58                   	pop    %eax
8010608b:	5a                   	pop    %edx
8010608c:	57                   	push   %edi
8010608d:	68 d1 84 10 80       	push   $0x801084d1
80106092:	e8 19 a6 ff ff       	call   801006b0 <cprintf>
        sectors[i] = sec;
80106097:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    for(i=0;i<min_end;i++){
8010609a:	83 c4 10             	add    $0x10,%esp
        sectors[i] = sec;
8010609d:	89 3c 98             	mov    %edi,(%eax,%ebx,4)
    for(i=0;i<min_end;i++){
801060a0:	83 c3 01             	add    $0x1,%ebx
801060a3:	39 de                	cmp    %ebx,%esi
801060a5:	75 d1                	jne    80106078 <sys_get_file_sectors+0x88>
    }
    cprintf("\n");
801060a7:	83 ec 0c             	sub    $0xc,%esp
801060aa:	68 cd 81 10 80       	push   $0x801081cd
801060af:	e8 fc a5 ff ff       	call   801006b0 <cprintf>
    if (min_end<=n-1)
801060b4:	83 c4 10             	add    $0x10,%esp
        sectors[min_end]=-1;
    return 0;
801060b7:	31 c0                	xor    %eax,%eax
    if (min_end<=n-1)
801060b9:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801060bc:	7e 0a                	jle    801060c8 <sys_get_file_sectors+0xd8>
        sectors[min_end]=-1;
801060be:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
801060c1:	c7 04 b1 ff ff ff ff 	movl   $0xffffffff,(%ecx,%esi,4)
801060c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060cb:	5b                   	pop    %ebx
801060cc:	5e                   	pop    %esi
801060cd:	5f                   	pop    %edi
801060ce:	5d                   	pop    %ebp
801060cf:	c3                   	ret    
        return -1;
801060d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801060d5:	eb f1                	jmp    801060c8 <sys_get_file_sectors+0xd8>
801060d7:	66 90                	xchg   %ax,%ax
801060d9:	66 90                	xchg   %ax,%ax
801060db:	66 90                	xchg   %ax,%ax
801060dd:	66 90                	xchg   %ax,%ax
801060df:	90                   	nop

801060e0 <sys_fork>:
#include "proc.h"


int
sys_fork(void)
{
801060e0:	f3 0f 1e fb          	endbr32 
  return fork();
801060e4:	e9 97 df ff ff       	jmp    80104080 <fork>
801060e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801060f0 <sys_exit>:
}

int
sys_exit(void)
{
801060f0:	f3 0f 1e fb          	endbr32 
801060f4:	55                   	push   %ebp
801060f5:	89 e5                	mov    %esp,%ebp
801060f7:	83 ec 08             	sub    $0x8,%esp
  exit();
801060fa:	e8 11 e2 ff ff       	call   80104310 <exit>
  return 0;  // not reached
}
801060ff:	31 c0                	xor    %eax,%eax
80106101:	c9                   	leave  
80106102:	c3                   	ret    
80106103:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010610a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106110 <sys_wait>:

int
sys_wait(void)
{
80106110:	f3 0f 1e fb          	endbr32 
  return wait();
80106114:	e9 47 e4 ff ff       	jmp    80104560 <wait>
80106119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106120 <sys_wait_sleeping>:
}

int sys_wait_sleeping(void){
80106120:	f3 0f 1e fb          	endbr32 
    return wait_sleeping();
80106124:	e9 47 e9 ff ff       	jmp    80104a70 <wait_sleeping>
80106129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106130 <sys_set_proc_tracer>:
}
int sys_set_proc_tracer(void){
80106130:	f3 0f 1e fb          	endbr32 
    return set_proc_tracer();
80106134:	e9 f7 e9 ff ff       	jmp    80104b30 <set_proc_tracer>
80106139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106140 <sys_dining>:
}

void
sys_dining(void){
80106140:	f3 0f 1e fb          	endbr32 
80106144:	55                   	push   %ebp
80106145:	89 e5                	mov    %esp,%ebp
80106147:	83 ec 20             	sub    $0x20,%esp
  int phnum;
  argint(0, &phnum);
8010614a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010614d:	50                   	push   %eax
8010614e:	6a 00                	push   $0x0
80106150:	e8 4b f1 ff ff       	call   801052a0 <argint>
  dining(phnum);
80106155:	58                   	pop    %eax
80106156:	ff 75 f4             	pushl  -0xc(%ebp)
80106159:	e8 b2 e6 ff ff       	call   80104810 <dining>
}
8010615e:	83 c4 10             	add    $0x10,%esp
80106161:	c9                   	leave  
80106162:	c3                   	ret    
80106163:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010616a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106170 <sys_kill>:

int
sys_kill(void)
{
80106170:	f3 0f 1e fb          	endbr32 
80106174:	55                   	push   %ebp
80106175:	89 e5                	mov    %esp,%ebp
80106177:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010617a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010617d:	50                   	push   %eax
8010617e:	6a 00                	push   $0x0
80106180:	e8 1b f1 ff ff       	call   801052a0 <argint>
80106185:	83 c4 10             	add    $0x10,%esp
80106188:	85 c0                	test   %eax,%eax
8010618a:	78 14                	js     801061a0 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010618c:	83 ec 0c             	sub    $0xc,%esp
8010618f:	ff 75 f4             	pushl  -0xc(%ebp)
80106192:	e8 79 e7 ff ff       	call   80104910 <kill>
80106197:	83 c4 10             	add    $0x10,%esp
}
8010619a:	c9                   	leave  
8010619b:	c3                   	ret    
8010619c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801061a0:	c9                   	leave  
    return -1;
801061a1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061a6:	c3                   	ret    
801061a7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061ae:	66 90                	xchg   %ax,%ax

801061b0 <sys_calculate_sum_of_digits>:

int sys_calculate_sum_of_digits(void){
801061b0:	f3 0f 1e fb          	endbr32 
801061b4:	55                   	push   %ebp
801061b5:	89 e5                	mov    %esp,%ebp
801061b7:	57                   	push   %edi
801061b8:	56                   	push   %esi
801061b9:	53                   	push   %ebx
801061ba:	83 ec 0c             	sub    $0xc,%esp
  int num = myproc()->tf->edx; //edx or ebx?
801061bd:	e8 0e dd ff ff       	call   80103ed0 <myproc>
  //cprintf("edx : %d\n", myproc()->tf->edx);
  //cprintf("number : %d\n",number);
  int result = 0;
  int reminder = 10;
  while(num / reminder != 0){
801061c2:	ba 67 66 66 66       	mov    $0x66666667,%edx
  int num = myproc()->tf->edx; //edx or ebx?
801061c7:	8b 40 1c             	mov    0x1c(%eax),%eax
801061ca:	8b 48 14             	mov    0x14(%eax),%ecx
  while(num / reminder != 0){
801061cd:	89 c8                	mov    %ecx,%eax
801061cf:	f7 ea                	imul   %edx
801061d1:	89 c8                	mov    %ecx,%eax
801061d3:	c1 f8 1f             	sar    $0x1f,%eax
801061d6:	c1 fa 02             	sar    $0x2,%edx
801061d9:	89 d3                	mov    %edx,%ebx
801061db:	29 c3                	sub    %eax,%ebx
801061dd:	8d 41 09             	lea    0x9(%ecx),%eax
801061e0:	83 f8 12             	cmp    $0x12,%eax
801061e3:	76 3e                	jbe    80106223 <sys_calculate_sum_of_digits+0x73>
  int result = 0;
801061e5:	31 f6                	xor    %esi,%esi
    result += (num % reminder);
801061e7:	bf 67 66 66 66       	mov    $0x66666667,%edi
801061ec:	eb 04                	jmp    801061f2 <sys_calculate_sum_of_digits+0x42>
801061ee:	66 90                	xchg   %ax,%ax
  while(num / reminder != 0){
801061f0:	89 d3                	mov    %edx,%ebx
    result += (num % reminder);
801061f2:	89 c8                	mov    %ecx,%eax
801061f4:	f7 ef                	imul   %edi
801061f6:	89 c8                	mov    %ecx,%eax
801061f8:	c1 f8 1f             	sar    $0x1f,%eax
801061fb:	c1 fa 02             	sar    $0x2,%edx
801061fe:	29 c2                	sub    %eax,%edx
80106200:	8d 04 92             	lea    (%edx,%edx,4),%eax
80106203:	01 c0                	add    %eax,%eax
80106205:	29 c1                	sub    %eax,%ecx
  while(num / reminder != 0){
80106207:	89 d8                	mov    %ebx,%eax
80106209:	f7 ef                	imul   %edi
8010620b:	89 d8                	mov    %ebx,%eax
    result += (num % reminder);
8010620d:	01 ce                	add    %ecx,%esi
  while(num / reminder != 0){
8010620f:	89 d9                	mov    %ebx,%ecx
80106211:	c1 f8 1f             	sar    $0x1f,%eax
80106214:	c1 fa 02             	sar    $0x2,%edx
80106217:	29 c2                	sub    %eax,%edx
80106219:	8d 43 09             	lea    0x9(%ebx),%eax
8010621c:	83 f8 12             	cmp    $0x12,%eax
8010621f:	77 cf                	ja     801061f0 <sys_calculate_sum_of_digits+0x40>
80106221:	01 f1                	add    %esi,%ecx
    num = (num / reminder);
    //cprintf("num : %d\n", num);
  }
  result += num;
  return result;
}
80106223:	83 c4 0c             	add    $0xc,%esp
80106226:	89 c8                	mov    %ecx,%eax
80106228:	5b                   	pop    %ebx
80106229:	5e                   	pop    %esi
8010622a:	5f                   	pop    %edi
8010622b:	5d                   	pop    %ebp
8010622c:	c3                   	ret    
8010622d:	8d 76 00             	lea    0x0(%esi),%esi

80106230 <sys_getpid>:

int
sys_getpid(void)
{
80106230:	f3 0f 1e fb          	endbr32 
80106234:	55                   	push   %ebp
80106235:	89 e5                	mov    %esp,%ebp
80106237:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010623a:	e8 91 dc ff ff       	call   80103ed0 <myproc>
8010623f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106242:	c9                   	leave  
80106243:	c3                   	ret    
80106244:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010624b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010624f:	90                   	nop

80106250 <sys_sbrk>:


int
sys_sbrk(void)
{
80106250:	f3 0f 1e fb          	endbr32 
80106254:	55                   	push   %ebp
80106255:	89 e5                	mov    %esp,%ebp
80106257:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106258:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010625b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010625e:	50                   	push   %eax
8010625f:	6a 00                	push   $0x0
80106261:	e8 3a f0 ff ff       	call   801052a0 <argint>
80106266:	83 c4 10             	add    $0x10,%esp
80106269:	85 c0                	test   %eax,%eax
8010626b:	78 23                	js     80106290 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010626d:	e8 5e dc ff ff       	call   80103ed0 <myproc>
  if(growproc(n) < 0)
80106272:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106275:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106277:	ff 75 f4             	pushl  -0xc(%ebp)
8010627a:	e8 81 dd ff ff       	call   80104000 <growproc>
8010627f:	83 c4 10             	add    $0x10,%esp
80106282:	85 c0                	test   %eax,%eax
80106284:	78 0a                	js     80106290 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106286:	89 d8                	mov    %ebx,%eax
80106288:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010628b:	c9                   	leave  
8010628c:	c3                   	ret    
8010628d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106290:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106295:	eb ef                	jmp    80106286 <sys_sbrk+0x36>
80106297:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010629e:	66 90                	xchg   %ax,%ax

801062a0 <sys_sleep>:

int
sys_sleep(void)
{
801062a0:	f3 0f 1e fb          	endbr32 
801062a4:	55                   	push   %ebp
801062a5:	89 e5                	mov    %esp,%ebp
801062a7:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801062a8:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801062ab:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801062ae:	50                   	push   %eax
801062af:	6a 00                	push   $0x0
801062b1:	e8 ea ef ff ff       	call   801052a0 <argint>
801062b6:	83 c4 10             	add    $0x10,%esp
801062b9:	85 c0                	test   %eax,%eax
801062bb:	0f 88 86 00 00 00    	js     80106347 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801062c1:	83 ec 0c             	sub    $0xc,%esp
801062c4:	68 20 5e 11 80       	push   $0x80115e20
801062c9:	e8 e2 eb ff ff       	call   80104eb0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801062ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801062d1:	8b 1d 60 66 11 80    	mov    0x80116660,%ebx
  while(ticks - ticks0 < n){
801062d7:	83 c4 10             	add    $0x10,%esp
801062da:	85 d2                	test   %edx,%edx
801062dc:	75 23                	jne    80106301 <sys_sleep+0x61>
801062de:	eb 50                	jmp    80106330 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801062e0:	83 ec 08             	sub    $0x8,%esp
801062e3:	68 20 5e 11 80       	push   $0x80115e20
801062e8:	68 60 66 11 80       	push   $0x80116660
801062ed:	e8 ae e1 ff ff       	call   801044a0 <sleep>
  while(ticks - ticks0 < n){
801062f2:	a1 60 66 11 80       	mov    0x80116660,%eax
801062f7:	83 c4 10             	add    $0x10,%esp
801062fa:	29 d8                	sub    %ebx,%eax
801062fc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801062ff:	73 2f                	jae    80106330 <sys_sleep+0x90>
    if(myproc()->killed){
80106301:	e8 ca db ff ff       	call   80103ed0 <myproc>
80106306:	8b 40 28             	mov    0x28(%eax),%eax
80106309:	85 c0                	test   %eax,%eax
8010630b:	74 d3                	je     801062e0 <sys_sleep+0x40>
      release(&tickslock);
8010630d:	83 ec 0c             	sub    $0xc,%esp
80106310:	68 20 5e 11 80       	push   $0x80115e20
80106315:	e8 56 ec ff ff       	call   80104f70 <release>
  }
  release(&tickslock);
  return 0;
}
8010631a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
8010631d:	83 c4 10             	add    $0x10,%esp
80106320:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106325:	c9                   	leave  
80106326:	c3                   	ret    
80106327:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010632e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106330:	83 ec 0c             	sub    $0xc,%esp
80106333:	68 20 5e 11 80       	push   $0x80115e20
80106338:	e8 33 ec ff ff       	call   80104f70 <release>
  return 0;
8010633d:	83 c4 10             	add    $0x10,%esp
80106340:	31 c0                	xor    %eax,%eax
}
80106342:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106345:	c9                   	leave  
80106346:	c3                   	ret    
    return -1;
80106347:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010634c:	eb f4                	jmp    80106342 <sys_sleep+0xa2>
8010634e:	66 90                	xchg   %ax,%ax

80106350 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106350:	f3 0f 1e fb          	endbr32 
80106354:	55                   	push   %ebp
80106355:	89 e5                	mov    %esp,%ebp
80106357:	53                   	push   %ebx
80106358:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010635b:	68 20 5e 11 80       	push   $0x80115e20
80106360:	e8 4b eb ff ff       	call   80104eb0 <acquire>
  xticks = ticks;
80106365:	8b 1d 60 66 11 80    	mov    0x80116660,%ebx
  release(&tickslock);
8010636b:	c7 04 24 20 5e 11 80 	movl   $0x80115e20,(%esp)
80106372:	e8 f9 eb ff ff       	call   80104f70 <release>
  return xticks;
}
80106377:	89 d8                	mov    %ebx,%eax
80106379:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010637c:	c9                   	leave  
8010637d:	c3                   	ret    
8010637e:	66 90                	xchg   %ax,%ax

80106380 <sys_get_parent_pid>:

int
sys_get_parent_pid(void)
{
80106380:	f3 0f 1e fb          	endbr32 
80106384:	55                   	push   %ebp
80106385:	89 e5                	mov    %esp,%ebp
80106387:	83 ec 08             	sub    $0x8,%esp
	return myproc()->parent->pid;
8010638a:	e8 41 db ff ff       	call   80103ed0 <myproc>
8010638f:	8b 40 14             	mov    0x14(%eax),%eax
80106392:	8b 40 10             	mov    0x10(%eax),%eax
80106395:	c9                   	leave  
80106396:	c3                   	ret    

80106397 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106397:	1e                   	push   %ds
  pushl %es
80106398:	06                   	push   %es
  pushl %fs
80106399:	0f a0                	push   %fs
  pushl %gs
8010639b:	0f a8                	push   %gs
  pushal
8010639d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010639e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
801063a2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
801063a4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
801063a6:	54                   	push   %esp
  call trap
801063a7:	e8 c4 00 00 00       	call   80106470 <trap>
  addl $4, %esp
801063ac:	83 c4 04             	add    $0x4,%esp

801063af <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
801063af:	61                   	popa   
  popl %gs
801063b0:	0f a9                	pop    %gs
  popl %fs
801063b2:	0f a1                	pop    %fs
  popl %es
801063b4:	07                   	pop    %es
  popl %ds
801063b5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
801063b6:	83 c4 08             	add    $0x8,%esp
  iret
801063b9:	cf                   	iret   
801063ba:	66 90                	xchg   %ax,%ax
801063bc:	66 90                	xchg   %ax,%ax
801063be:	66 90                	xchg   %ax,%ax

801063c0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
801063c0:	f3 0f 1e fb          	endbr32 
801063c4:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
801063c5:	31 c0                	xor    %eax,%eax
{
801063c7:	89 e5                	mov    %esp,%ebp
801063c9:	83 ec 08             	sub    $0x8,%esp
801063cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
801063d0:	8b 14 85 30 b0 10 80 	mov    -0x7fef4fd0(,%eax,4),%edx
801063d7:	c7 04 c5 62 5e 11 80 	movl   $0x8e000008,-0x7feea19e(,%eax,8)
801063de:	08 00 00 8e 
801063e2:	66 89 14 c5 60 5e 11 	mov    %dx,-0x7feea1a0(,%eax,8)
801063e9:	80 
801063ea:	c1 ea 10             	shr    $0x10,%edx
801063ed:	66 89 14 c5 66 5e 11 	mov    %dx,-0x7feea19a(,%eax,8)
801063f4:	80 
  for(i = 0; i < 256; i++)
801063f5:	83 c0 01             	add    $0x1,%eax
801063f8:	3d 00 01 00 00       	cmp    $0x100,%eax
801063fd:	75 d1                	jne    801063d0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
801063ff:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106402:	a1 30 b1 10 80       	mov    0x8010b130,%eax
80106407:	c7 05 62 60 11 80 08 	movl   $0xef000008,0x80116062
8010640e:	00 00 ef 
  initlock(&tickslock, "time");
80106411:	68 d5 84 10 80       	push   $0x801084d5
80106416:	68 20 5e 11 80       	push   $0x80115e20
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010641b:	66 a3 60 60 11 80    	mov    %ax,0x80116060
80106421:	c1 e8 10             	shr    $0x10,%eax
80106424:	66 a3 66 60 11 80    	mov    %ax,0x80116066
  initlock(&tickslock, "time");
8010642a:	e8 01 e9 ff ff       	call   80104d30 <initlock>
}
8010642f:	83 c4 10             	add    $0x10,%esp
80106432:	c9                   	leave  
80106433:	c3                   	ret    
80106434:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010643b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010643f:	90                   	nop

80106440 <idtinit>:

void
idtinit(void)
{
80106440:	f3 0f 1e fb          	endbr32 
80106444:	55                   	push   %ebp
  pd[0] = size-1;
80106445:	b8 ff 07 00 00       	mov    $0x7ff,%eax
8010644a:	89 e5                	mov    %esp,%ebp
8010644c:	83 ec 10             	sub    $0x10,%esp
8010644f:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106453:	b8 60 5e 11 80       	mov    $0x80115e60,%eax
80106458:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
8010645c:	c1 e8 10             	shr    $0x10,%eax
8010645f:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106463:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106466:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106469:	c9                   	leave  
8010646a:	c3                   	ret    
8010646b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010646f:	90                   	nop

80106470 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106470:	f3 0f 1e fb          	endbr32 
80106474:	55                   	push   %ebp
80106475:	89 e5                	mov    %esp,%ebp
80106477:	57                   	push   %edi
80106478:	56                   	push   %esi
80106479:	53                   	push   %ebx
8010647a:	83 ec 1c             	sub    $0x1c,%esp
8010647d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106480:	8b 43 30             	mov    0x30(%ebx),%eax
80106483:	83 f8 40             	cmp    $0x40,%eax
80106486:	0f 84 bc 01 00 00    	je     80106648 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010648c:	83 e8 20             	sub    $0x20,%eax
8010648f:	83 f8 1f             	cmp    $0x1f,%eax
80106492:	77 08                	ja     8010649c <trap+0x2c>
80106494:	3e ff 24 85 7c 85 10 	notrack jmp *-0x7fef7a84(,%eax,4)
8010649b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010649c:	e8 2f da ff ff       	call   80103ed0 <myproc>
801064a1:	8b 7b 38             	mov    0x38(%ebx),%edi
801064a4:	85 c0                	test   %eax,%eax
801064a6:	0f 84 eb 01 00 00    	je     80106697 <trap+0x227>
801064ac:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
801064b0:	0f 84 e1 01 00 00    	je     80106697 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801064b6:	0f 20 d1             	mov    %cr2,%ecx
801064b9:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064bc:	e8 ef d9 ff ff       	call   80103eb0 <cpuid>
801064c1:	8b 73 30             	mov    0x30(%ebx),%esi
801064c4:	89 45 dc             	mov    %eax,-0x24(%ebp)
801064c7:	8b 43 34             	mov    0x34(%ebx),%eax
801064ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801064cd:	e8 fe d9 ff ff       	call   80103ed0 <myproc>
801064d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
801064d5:	e8 f6 d9 ff ff       	call   80103ed0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064da:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801064dd:	8b 55 dc             	mov    -0x24(%ebp),%edx
801064e0:	51                   	push   %ecx
801064e1:	57                   	push   %edi
801064e2:	52                   	push   %edx
801064e3:	ff 75 e4             	pushl  -0x1c(%ebp)
801064e6:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801064e7:	8b 75 e0             	mov    -0x20(%ebp),%esi
801064ea:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801064ed:	56                   	push   %esi
801064ee:	ff 70 10             	pushl  0x10(%eax)
801064f1:	68 38 85 10 80       	push   $0x80108538
801064f6:	e8 b5 a1 ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
801064fb:	83 c4 20             	add    $0x20,%esp
801064fe:	e8 cd d9 ff ff       	call   80103ed0 <myproc>
80106503:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010650a:	e8 c1 d9 ff ff       	call   80103ed0 <myproc>
8010650f:	85 c0                	test   %eax,%eax
80106511:	74 1d                	je     80106530 <trap+0xc0>
80106513:	e8 b8 d9 ff ff       	call   80103ed0 <myproc>
80106518:	8b 50 28             	mov    0x28(%eax),%edx
8010651b:	85 d2                	test   %edx,%edx
8010651d:	74 11                	je     80106530 <trap+0xc0>
8010651f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106523:	83 e0 03             	and    $0x3,%eax
80106526:	66 83 f8 03          	cmp    $0x3,%ax
8010652a:	0f 84 50 01 00 00    	je     80106680 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106530:	e8 9b d9 ff ff       	call   80103ed0 <myproc>
80106535:	85 c0                	test   %eax,%eax
80106537:	74 0f                	je     80106548 <trap+0xd8>
80106539:	e8 92 d9 ff ff       	call   80103ed0 <myproc>
8010653e:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106542:	0f 84 e8 00 00 00    	je     80106630 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106548:	e8 83 d9 ff ff       	call   80103ed0 <myproc>
8010654d:	85 c0                	test   %eax,%eax
8010654f:	74 1d                	je     8010656e <trap+0xfe>
80106551:	e8 7a d9 ff ff       	call   80103ed0 <myproc>
80106556:	8b 40 28             	mov    0x28(%eax),%eax
80106559:	85 c0                	test   %eax,%eax
8010655b:	74 11                	je     8010656e <trap+0xfe>
8010655d:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106561:	83 e0 03             	and    $0x3,%eax
80106564:	66 83 f8 03          	cmp    $0x3,%ax
80106568:	0f 84 03 01 00 00    	je     80106671 <trap+0x201>
    exit();
}
8010656e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106571:	5b                   	pop    %ebx
80106572:	5e                   	pop    %esi
80106573:	5f                   	pop    %edi
80106574:	5d                   	pop    %ebp
80106575:	c3                   	ret    
    ideintr();
80106576:	e8 45 c1 ff ff       	call   801026c0 <ideintr>
    lapiceoi();
8010657b:	e8 20 c8 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106580:	e8 4b d9 ff ff       	call   80103ed0 <myproc>
80106585:	85 c0                	test   %eax,%eax
80106587:	75 8a                	jne    80106513 <trap+0xa3>
80106589:	eb a5                	jmp    80106530 <trap+0xc0>
    if(cpuid() == 0){
8010658b:	e8 20 d9 ff ff       	call   80103eb0 <cpuid>
80106590:	85 c0                	test   %eax,%eax
80106592:	75 e7                	jne    8010657b <trap+0x10b>
      acquire(&tickslock);
80106594:	83 ec 0c             	sub    $0xc,%esp
80106597:	68 20 5e 11 80       	push   $0x80115e20
8010659c:	e8 0f e9 ff ff       	call   80104eb0 <acquire>
      wakeup(&ticks);
801065a1:	c7 04 24 60 66 11 80 	movl   $0x80116660,(%esp)
      ticks++;
801065a8:	83 05 60 66 11 80 01 	addl   $0x1,0x80116660
      wakeup(&ticks);
801065af:	e8 ac e0 ff ff       	call   80104660 <wakeup>
      release(&tickslock);
801065b4:	c7 04 24 20 5e 11 80 	movl   $0x80115e20,(%esp)
801065bb:	e8 b0 e9 ff ff       	call   80104f70 <release>
801065c0:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801065c3:	eb b6                	jmp    8010657b <trap+0x10b>
    kbdintr();
801065c5:	e8 96 c6 ff ff       	call   80102c60 <kbdintr>
    lapiceoi();
801065ca:	e8 d1 c7 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065cf:	e8 fc d8 ff ff       	call   80103ed0 <myproc>
801065d4:	85 c0                	test   %eax,%eax
801065d6:	0f 85 37 ff ff ff    	jne    80106513 <trap+0xa3>
801065dc:	e9 4f ff ff ff       	jmp    80106530 <trap+0xc0>
    uartintr();
801065e1:	e8 4a 02 00 00       	call   80106830 <uartintr>
    lapiceoi();
801065e6:	e8 b5 c7 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801065eb:	e8 e0 d8 ff ff       	call   80103ed0 <myproc>
801065f0:	85 c0                	test   %eax,%eax
801065f2:	0f 85 1b ff ff ff    	jne    80106513 <trap+0xa3>
801065f8:	e9 33 ff ff ff       	jmp    80106530 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
801065fd:	8b 7b 38             	mov    0x38(%ebx),%edi
80106600:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106604:	e8 a7 d8 ff ff       	call   80103eb0 <cpuid>
80106609:	57                   	push   %edi
8010660a:	56                   	push   %esi
8010660b:	50                   	push   %eax
8010660c:	68 e0 84 10 80       	push   $0x801084e0
80106611:	e8 9a a0 ff ff       	call   801006b0 <cprintf>
    lapiceoi();
80106616:	e8 85 c7 ff ff       	call   80102da0 <lapiceoi>
    break;
8010661b:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010661e:	e8 ad d8 ff ff       	call   80103ed0 <myproc>
80106623:	85 c0                	test   %eax,%eax
80106625:	0f 85 e8 fe ff ff    	jne    80106513 <trap+0xa3>
8010662b:	e9 00 ff ff ff       	jmp    80106530 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
80106630:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106634:	0f 85 0e ff ff ff    	jne    80106548 <trap+0xd8>
    yield();
8010663a:	e8 11 de ff ff       	call   80104450 <yield>
8010663f:	e9 04 ff ff ff       	jmp    80106548 <trap+0xd8>
80106644:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106648:	e8 83 d8 ff ff       	call   80103ed0 <myproc>
8010664d:	8b 70 28             	mov    0x28(%eax),%esi
80106650:	85 f6                	test   %esi,%esi
80106652:	75 3c                	jne    80106690 <trap+0x220>
    myproc()->tf = tf;
80106654:	e8 77 d8 ff ff       	call   80103ed0 <myproc>
80106659:	89 58 1c             	mov    %ebx,0x1c(%eax)
    syscall();
8010665c:	e8 2f ed ff ff       	call   80105390 <syscall>
    if(myproc()->killed)
80106661:	e8 6a d8 ff ff       	call   80103ed0 <myproc>
80106666:	8b 48 28             	mov    0x28(%eax),%ecx
80106669:	85 c9                	test   %ecx,%ecx
8010666b:	0f 84 fd fe ff ff    	je     8010656e <trap+0xfe>
}
80106671:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106674:	5b                   	pop    %ebx
80106675:	5e                   	pop    %esi
80106676:	5f                   	pop    %edi
80106677:	5d                   	pop    %ebp
      exit();
80106678:	e9 93 dc ff ff       	jmp    80104310 <exit>
8010667d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106680:	e8 8b dc ff ff       	call   80104310 <exit>
80106685:	e9 a6 fe ff ff       	jmp    80106530 <trap+0xc0>
8010668a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106690:	e8 7b dc ff ff       	call   80104310 <exit>
80106695:	eb bd                	jmp    80106654 <trap+0x1e4>
80106697:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010669a:	e8 11 d8 ff ff       	call   80103eb0 <cpuid>
8010669f:	83 ec 0c             	sub    $0xc,%esp
801066a2:	56                   	push   %esi
801066a3:	57                   	push   %edi
801066a4:	50                   	push   %eax
801066a5:	ff 73 30             	pushl  0x30(%ebx)
801066a8:	68 04 85 10 80       	push   $0x80108504
801066ad:	e8 fe 9f ff ff       	call   801006b0 <cprintf>
      panic("trap");
801066b2:	83 c4 14             	add    $0x14,%esp
801066b5:	68 da 84 10 80       	push   $0x801084da
801066ba:	e8 d1 9c ff ff       	call   80100390 <panic>
801066bf:	90                   	nop

801066c0 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
801066c0:	f3 0f 1e fb          	endbr32 
  if(!uart)
801066c4:	a1 78 b6 10 80       	mov    0x8010b678,%eax
801066c9:	85 c0                	test   %eax,%eax
801066cb:	74 1b                	je     801066e8 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801066cd:	ba fd 03 00 00       	mov    $0x3fd,%edx
801066d2:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
801066d3:	a8 01                	test   $0x1,%al
801066d5:	74 11                	je     801066e8 <uartgetc+0x28>
801066d7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801066dc:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
801066dd:	0f b6 c0             	movzbl %al,%eax
801066e0:	c3                   	ret    
801066e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801066e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801066ed:	c3                   	ret    
801066ee:	66 90                	xchg   %ax,%ax

801066f0 <uartputc.part.0>:
uartputc(int c)
801066f0:	55                   	push   %ebp
801066f1:	89 e5                	mov    %esp,%ebp
801066f3:	57                   	push   %edi
801066f4:	89 c7                	mov    %eax,%edi
801066f6:	56                   	push   %esi
801066f7:	be fd 03 00 00       	mov    $0x3fd,%esi
801066fc:	53                   	push   %ebx
801066fd:	bb 80 00 00 00       	mov    $0x80,%ebx
80106702:	83 ec 0c             	sub    $0xc,%esp
80106705:	eb 1b                	jmp    80106722 <uartputc.part.0+0x32>
80106707:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010670e:	66 90                	xchg   %ax,%ax
    microdelay(10);
80106710:	83 ec 0c             	sub    $0xc,%esp
80106713:	6a 0a                	push   $0xa
80106715:	e8 a6 c6 ff ff       	call   80102dc0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010671a:	83 c4 10             	add    $0x10,%esp
8010671d:	83 eb 01             	sub    $0x1,%ebx
80106720:	74 07                	je     80106729 <uartputc.part.0+0x39>
80106722:	89 f2                	mov    %esi,%edx
80106724:	ec                   	in     (%dx),%al
80106725:	a8 20                	test   $0x20,%al
80106727:	74 e7                	je     80106710 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106729:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010672e:	89 f8                	mov    %edi,%eax
80106730:	ee                   	out    %al,(%dx)
}
80106731:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106734:	5b                   	pop    %ebx
80106735:	5e                   	pop    %esi
80106736:	5f                   	pop    %edi
80106737:	5d                   	pop    %ebp
80106738:	c3                   	ret    
80106739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106740 <uartinit>:
{
80106740:	f3 0f 1e fb          	endbr32 
80106744:	55                   	push   %ebp
80106745:	31 c9                	xor    %ecx,%ecx
80106747:	89 c8                	mov    %ecx,%eax
80106749:	89 e5                	mov    %esp,%ebp
8010674b:	57                   	push   %edi
8010674c:	56                   	push   %esi
8010674d:	53                   	push   %ebx
8010674e:	bb fa 03 00 00       	mov    $0x3fa,%ebx
80106753:	89 da                	mov    %ebx,%edx
80106755:	83 ec 0c             	sub    $0xc,%esp
80106758:	ee                   	out    %al,(%dx)
80106759:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010675e:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80106763:	89 fa                	mov    %edi,%edx
80106765:	ee                   	out    %al,(%dx)
80106766:	b8 0c 00 00 00       	mov    $0xc,%eax
8010676b:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106770:	ee                   	out    %al,(%dx)
80106771:	be f9 03 00 00       	mov    $0x3f9,%esi
80106776:	89 c8                	mov    %ecx,%eax
80106778:	89 f2                	mov    %esi,%edx
8010677a:	ee                   	out    %al,(%dx)
8010677b:	b8 03 00 00 00       	mov    $0x3,%eax
80106780:	89 fa                	mov    %edi,%edx
80106782:	ee                   	out    %al,(%dx)
80106783:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106788:	89 c8                	mov    %ecx,%eax
8010678a:	ee                   	out    %al,(%dx)
8010678b:	b8 01 00 00 00       	mov    $0x1,%eax
80106790:	89 f2                	mov    %esi,%edx
80106792:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106793:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106798:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106799:	3c ff                	cmp    $0xff,%al
8010679b:	74 52                	je     801067ef <uartinit+0xaf>
  uart = 1;
8010679d:	c7 05 78 b6 10 80 01 	movl   $0x1,0x8010b678
801067a4:	00 00 00 
801067a7:	89 da                	mov    %ebx,%edx
801067a9:	ec                   	in     (%dx),%al
801067aa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801067af:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801067b0:	83 ec 08             	sub    $0x8,%esp
801067b3:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
801067b8:	bb fc 85 10 80       	mov    $0x801085fc,%ebx
  ioapicenable(IRQ_COM1, 0);
801067bd:	6a 00                	push   $0x0
801067bf:	6a 04                	push   $0x4
801067c1:	e8 4a c1 ff ff       	call   80102910 <ioapicenable>
801067c6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801067c9:	b8 78 00 00 00       	mov    $0x78,%eax
801067ce:	eb 04                	jmp    801067d4 <uartinit+0x94>
801067d0:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
801067d4:	8b 15 78 b6 10 80    	mov    0x8010b678,%edx
801067da:	85 d2                	test   %edx,%edx
801067dc:	74 08                	je     801067e6 <uartinit+0xa6>
    uartputc(*p);
801067de:	0f be c0             	movsbl %al,%eax
801067e1:	e8 0a ff ff ff       	call   801066f0 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
801067e6:	89 f0                	mov    %esi,%eax
801067e8:	83 c3 01             	add    $0x1,%ebx
801067eb:	84 c0                	test   %al,%al
801067ed:	75 e1                	jne    801067d0 <uartinit+0x90>
}
801067ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801067f2:	5b                   	pop    %ebx
801067f3:	5e                   	pop    %esi
801067f4:	5f                   	pop    %edi
801067f5:	5d                   	pop    %ebp
801067f6:	c3                   	ret    
801067f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801067fe:	66 90                	xchg   %ax,%ax

80106800 <uartputc>:
{
80106800:	f3 0f 1e fb          	endbr32 
80106804:	55                   	push   %ebp
  if(!uart)
80106805:	8b 15 78 b6 10 80    	mov    0x8010b678,%edx
{
8010680b:	89 e5                	mov    %esp,%ebp
8010680d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106810:	85 d2                	test   %edx,%edx
80106812:	74 0c                	je     80106820 <uartputc+0x20>
}
80106814:	5d                   	pop    %ebp
80106815:	e9 d6 fe ff ff       	jmp    801066f0 <uartputc.part.0>
8010681a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106820:	5d                   	pop    %ebp
80106821:	c3                   	ret    
80106822:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106830 <uartintr>:

void
uartintr(void)
{
80106830:	f3 0f 1e fb          	endbr32 
80106834:	55                   	push   %ebp
80106835:	89 e5                	mov    %esp,%ebp
80106837:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
8010683a:	68 c0 66 10 80       	push   $0x801066c0
8010683f:	e8 1c a3 ff ff       	call   80100b60 <consoleintr>
}
80106844:	83 c4 10             	add    $0x10,%esp
80106847:	c9                   	leave  
80106848:	c3                   	ret    

80106849 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106849:	6a 00                	push   $0x0
  pushl $0
8010684b:	6a 00                	push   $0x0
  jmp alltraps
8010684d:	e9 45 fb ff ff       	jmp    80106397 <alltraps>

80106852 <vector1>:
.globl vector1
vector1:
  pushl $0
80106852:	6a 00                	push   $0x0
  pushl $1
80106854:	6a 01                	push   $0x1
  jmp alltraps
80106856:	e9 3c fb ff ff       	jmp    80106397 <alltraps>

8010685b <vector2>:
.globl vector2
vector2:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $2
8010685d:	6a 02                	push   $0x2
  jmp alltraps
8010685f:	e9 33 fb ff ff       	jmp    80106397 <alltraps>

80106864 <vector3>:
.globl vector3
vector3:
  pushl $0
80106864:	6a 00                	push   $0x0
  pushl $3
80106866:	6a 03                	push   $0x3
  jmp alltraps
80106868:	e9 2a fb ff ff       	jmp    80106397 <alltraps>

8010686d <vector4>:
.globl vector4
vector4:
  pushl $0
8010686d:	6a 00                	push   $0x0
  pushl $4
8010686f:	6a 04                	push   $0x4
  jmp alltraps
80106871:	e9 21 fb ff ff       	jmp    80106397 <alltraps>

80106876 <vector5>:
.globl vector5
vector5:
  pushl $0
80106876:	6a 00                	push   $0x0
  pushl $5
80106878:	6a 05                	push   $0x5
  jmp alltraps
8010687a:	e9 18 fb ff ff       	jmp    80106397 <alltraps>

8010687f <vector6>:
.globl vector6
vector6:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $6
80106881:	6a 06                	push   $0x6
  jmp alltraps
80106883:	e9 0f fb ff ff       	jmp    80106397 <alltraps>

80106888 <vector7>:
.globl vector7
vector7:
  pushl $0
80106888:	6a 00                	push   $0x0
  pushl $7
8010688a:	6a 07                	push   $0x7
  jmp alltraps
8010688c:	e9 06 fb ff ff       	jmp    80106397 <alltraps>

80106891 <vector8>:
.globl vector8
vector8:
  pushl $8
80106891:	6a 08                	push   $0x8
  jmp alltraps
80106893:	e9 ff fa ff ff       	jmp    80106397 <alltraps>

80106898 <vector9>:
.globl vector9
vector9:
  pushl $0
80106898:	6a 00                	push   $0x0
  pushl $9
8010689a:	6a 09                	push   $0x9
  jmp alltraps
8010689c:	e9 f6 fa ff ff       	jmp    80106397 <alltraps>

801068a1 <vector10>:
.globl vector10
vector10:
  pushl $10
801068a1:	6a 0a                	push   $0xa
  jmp alltraps
801068a3:	e9 ef fa ff ff       	jmp    80106397 <alltraps>

801068a8 <vector11>:
.globl vector11
vector11:
  pushl $11
801068a8:	6a 0b                	push   $0xb
  jmp alltraps
801068aa:	e9 e8 fa ff ff       	jmp    80106397 <alltraps>

801068af <vector12>:
.globl vector12
vector12:
  pushl $12
801068af:	6a 0c                	push   $0xc
  jmp alltraps
801068b1:	e9 e1 fa ff ff       	jmp    80106397 <alltraps>

801068b6 <vector13>:
.globl vector13
vector13:
  pushl $13
801068b6:	6a 0d                	push   $0xd
  jmp alltraps
801068b8:	e9 da fa ff ff       	jmp    80106397 <alltraps>

801068bd <vector14>:
.globl vector14
vector14:
  pushl $14
801068bd:	6a 0e                	push   $0xe
  jmp alltraps
801068bf:	e9 d3 fa ff ff       	jmp    80106397 <alltraps>

801068c4 <vector15>:
.globl vector15
vector15:
  pushl $0
801068c4:	6a 00                	push   $0x0
  pushl $15
801068c6:	6a 0f                	push   $0xf
  jmp alltraps
801068c8:	e9 ca fa ff ff       	jmp    80106397 <alltraps>

801068cd <vector16>:
.globl vector16
vector16:
  pushl $0
801068cd:	6a 00                	push   $0x0
  pushl $16
801068cf:	6a 10                	push   $0x10
  jmp alltraps
801068d1:	e9 c1 fa ff ff       	jmp    80106397 <alltraps>

801068d6 <vector17>:
.globl vector17
vector17:
  pushl $17
801068d6:	6a 11                	push   $0x11
  jmp alltraps
801068d8:	e9 ba fa ff ff       	jmp    80106397 <alltraps>

801068dd <vector18>:
.globl vector18
vector18:
  pushl $0
801068dd:	6a 00                	push   $0x0
  pushl $18
801068df:	6a 12                	push   $0x12
  jmp alltraps
801068e1:	e9 b1 fa ff ff       	jmp    80106397 <alltraps>

801068e6 <vector19>:
.globl vector19
vector19:
  pushl $0
801068e6:	6a 00                	push   $0x0
  pushl $19
801068e8:	6a 13                	push   $0x13
  jmp alltraps
801068ea:	e9 a8 fa ff ff       	jmp    80106397 <alltraps>

801068ef <vector20>:
.globl vector20
vector20:
  pushl $0
801068ef:	6a 00                	push   $0x0
  pushl $20
801068f1:	6a 14                	push   $0x14
  jmp alltraps
801068f3:	e9 9f fa ff ff       	jmp    80106397 <alltraps>

801068f8 <vector21>:
.globl vector21
vector21:
  pushl $0
801068f8:	6a 00                	push   $0x0
  pushl $21
801068fa:	6a 15                	push   $0x15
  jmp alltraps
801068fc:	e9 96 fa ff ff       	jmp    80106397 <alltraps>

80106901 <vector22>:
.globl vector22
vector22:
  pushl $0
80106901:	6a 00                	push   $0x0
  pushl $22
80106903:	6a 16                	push   $0x16
  jmp alltraps
80106905:	e9 8d fa ff ff       	jmp    80106397 <alltraps>

8010690a <vector23>:
.globl vector23
vector23:
  pushl $0
8010690a:	6a 00                	push   $0x0
  pushl $23
8010690c:	6a 17                	push   $0x17
  jmp alltraps
8010690e:	e9 84 fa ff ff       	jmp    80106397 <alltraps>

80106913 <vector24>:
.globl vector24
vector24:
  pushl $0
80106913:	6a 00                	push   $0x0
  pushl $24
80106915:	6a 18                	push   $0x18
  jmp alltraps
80106917:	e9 7b fa ff ff       	jmp    80106397 <alltraps>

8010691c <vector25>:
.globl vector25
vector25:
  pushl $0
8010691c:	6a 00                	push   $0x0
  pushl $25
8010691e:	6a 19                	push   $0x19
  jmp alltraps
80106920:	e9 72 fa ff ff       	jmp    80106397 <alltraps>

80106925 <vector26>:
.globl vector26
vector26:
  pushl $0
80106925:	6a 00                	push   $0x0
  pushl $26
80106927:	6a 1a                	push   $0x1a
  jmp alltraps
80106929:	e9 69 fa ff ff       	jmp    80106397 <alltraps>

8010692e <vector27>:
.globl vector27
vector27:
  pushl $0
8010692e:	6a 00                	push   $0x0
  pushl $27
80106930:	6a 1b                	push   $0x1b
  jmp alltraps
80106932:	e9 60 fa ff ff       	jmp    80106397 <alltraps>

80106937 <vector28>:
.globl vector28
vector28:
  pushl $0
80106937:	6a 00                	push   $0x0
  pushl $28
80106939:	6a 1c                	push   $0x1c
  jmp alltraps
8010693b:	e9 57 fa ff ff       	jmp    80106397 <alltraps>

80106940 <vector29>:
.globl vector29
vector29:
  pushl $0
80106940:	6a 00                	push   $0x0
  pushl $29
80106942:	6a 1d                	push   $0x1d
  jmp alltraps
80106944:	e9 4e fa ff ff       	jmp    80106397 <alltraps>

80106949 <vector30>:
.globl vector30
vector30:
  pushl $0
80106949:	6a 00                	push   $0x0
  pushl $30
8010694b:	6a 1e                	push   $0x1e
  jmp alltraps
8010694d:	e9 45 fa ff ff       	jmp    80106397 <alltraps>

80106952 <vector31>:
.globl vector31
vector31:
  pushl $0
80106952:	6a 00                	push   $0x0
  pushl $31
80106954:	6a 1f                	push   $0x1f
  jmp alltraps
80106956:	e9 3c fa ff ff       	jmp    80106397 <alltraps>

8010695b <vector32>:
.globl vector32
vector32:
  pushl $0
8010695b:	6a 00                	push   $0x0
  pushl $32
8010695d:	6a 20                	push   $0x20
  jmp alltraps
8010695f:	e9 33 fa ff ff       	jmp    80106397 <alltraps>

80106964 <vector33>:
.globl vector33
vector33:
  pushl $0
80106964:	6a 00                	push   $0x0
  pushl $33
80106966:	6a 21                	push   $0x21
  jmp alltraps
80106968:	e9 2a fa ff ff       	jmp    80106397 <alltraps>

8010696d <vector34>:
.globl vector34
vector34:
  pushl $0
8010696d:	6a 00                	push   $0x0
  pushl $34
8010696f:	6a 22                	push   $0x22
  jmp alltraps
80106971:	e9 21 fa ff ff       	jmp    80106397 <alltraps>

80106976 <vector35>:
.globl vector35
vector35:
  pushl $0
80106976:	6a 00                	push   $0x0
  pushl $35
80106978:	6a 23                	push   $0x23
  jmp alltraps
8010697a:	e9 18 fa ff ff       	jmp    80106397 <alltraps>

8010697f <vector36>:
.globl vector36
vector36:
  pushl $0
8010697f:	6a 00                	push   $0x0
  pushl $36
80106981:	6a 24                	push   $0x24
  jmp alltraps
80106983:	e9 0f fa ff ff       	jmp    80106397 <alltraps>

80106988 <vector37>:
.globl vector37
vector37:
  pushl $0
80106988:	6a 00                	push   $0x0
  pushl $37
8010698a:	6a 25                	push   $0x25
  jmp alltraps
8010698c:	e9 06 fa ff ff       	jmp    80106397 <alltraps>

80106991 <vector38>:
.globl vector38
vector38:
  pushl $0
80106991:	6a 00                	push   $0x0
  pushl $38
80106993:	6a 26                	push   $0x26
  jmp alltraps
80106995:	e9 fd f9 ff ff       	jmp    80106397 <alltraps>

8010699a <vector39>:
.globl vector39
vector39:
  pushl $0
8010699a:	6a 00                	push   $0x0
  pushl $39
8010699c:	6a 27                	push   $0x27
  jmp alltraps
8010699e:	e9 f4 f9 ff ff       	jmp    80106397 <alltraps>

801069a3 <vector40>:
.globl vector40
vector40:
  pushl $0
801069a3:	6a 00                	push   $0x0
  pushl $40
801069a5:	6a 28                	push   $0x28
  jmp alltraps
801069a7:	e9 eb f9 ff ff       	jmp    80106397 <alltraps>

801069ac <vector41>:
.globl vector41
vector41:
  pushl $0
801069ac:	6a 00                	push   $0x0
  pushl $41
801069ae:	6a 29                	push   $0x29
  jmp alltraps
801069b0:	e9 e2 f9 ff ff       	jmp    80106397 <alltraps>

801069b5 <vector42>:
.globl vector42
vector42:
  pushl $0
801069b5:	6a 00                	push   $0x0
  pushl $42
801069b7:	6a 2a                	push   $0x2a
  jmp alltraps
801069b9:	e9 d9 f9 ff ff       	jmp    80106397 <alltraps>

801069be <vector43>:
.globl vector43
vector43:
  pushl $0
801069be:	6a 00                	push   $0x0
  pushl $43
801069c0:	6a 2b                	push   $0x2b
  jmp alltraps
801069c2:	e9 d0 f9 ff ff       	jmp    80106397 <alltraps>

801069c7 <vector44>:
.globl vector44
vector44:
  pushl $0
801069c7:	6a 00                	push   $0x0
  pushl $44
801069c9:	6a 2c                	push   $0x2c
  jmp alltraps
801069cb:	e9 c7 f9 ff ff       	jmp    80106397 <alltraps>

801069d0 <vector45>:
.globl vector45
vector45:
  pushl $0
801069d0:	6a 00                	push   $0x0
  pushl $45
801069d2:	6a 2d                	push   $0x2d
  jmp alltraps
801069d4:	e9 be f9 ff ff       	jmp    80106397 <alltraps>

801069d9 <vector46>:
.globl vector46
vector46:
  pushl $0
801069d9:	6a 00                	push   $0x0
  pushl $46
801069db:	6a 2e                	push   $0x2e
  jmp alltraps
801069dd:	e9 b5 f9 ff ff       	jmp    80106397 <alltraps>

801069e2 <vector47>:
.globl vector47
vector47:
  pushl $0
801069e2:	6a 00                	push   $0x0
  pushl $47
801069e4:	6a 2f                	push   $0x2f
  jmp alltraps
801069e6:	e9 ac f9 ff ff       	jmp    80106397 <alltraps>

801069eb <vector48>:
.globl vector48
vector48:
  pushl $0
801069eb:	6a 00                	push   $0x0
  pushl $48
801069ed:	6a 30                	push   $0x30
  jmp alltraps
801069ef:	e9 a3 f9 ff ff       	jmp    80106397 <alltraps>

801069f4 <vector49>:
.globl vector49
vector49:
  pushl $0
801069f4:	6a 00                	push   $0x0
  pushl $49
801069f6:	6a 31                	push   $0x31
  jmp alltraps
801069f8:	e9 9a f9 ff ff       	jmp    80106397 <alltraps>

801069fd <vector50>:
.globl vector50
vector50:
  pushl $0
801069fd:	6a 00                	push   $0x0
  pushl $50
801069ff:	6a 32                	push   $0x32
  jmp alltraps
80106a01:	e9 91 f9 ff ff       	jmp    80106397 <alltraps>

80106a06 <vector51>:
.globl vector51
vector51:
  pushl $0
80106a06:	6a 00                	push   $0x0
  pushl $51
80106a08:	6a 33                	push   $0x33
  jmp alltraps
80106a0a:	e9 88 f9 ff ff       	jmp    80106397 <alltraps>

80106a0f <vector52>:
.globl vector52
vector52:
  pushl $0
80106a0f:	6a 00                	push   $0x0
  pushl $52
80106a11:	6a 34                	push   $0x34
  jmp alltraps
80106a13:	e9 7f f9 ff ff       	jmp    80106397 <alltraps>

80106a18 <vector53>:
.globl vector53
vector53:
  pushl $0
80106a18:	6a 00                	push   $0x0
  pushl $53
80106a1a:	6a 35                	push   $0x35
  jmp alltraps
80106a1c:	e9 76 f9 ff ff       	jmp    80106397 <alltraps>

80106a21 <vector54>:
.globl vector54
vector54:
  pushl $0
80106a21:	6a 00                	push   $0x0
  pushl $54
80106a23:	6a 36                	push   $0x36
  jmp alltraps
80106a25:	e9 6d f9 ff ff       	jmp    80106397 <alltraps>

80106a2a <vector55>:
.globl vector55
vector55:
  pushl $0
80106a2a:	6a 00                	push   $0x0
  pushl $55
80106a2c:	6a 37                	push   $0x37
  jmp alltraps
80106a2e:	e9 64 f9 ff ff       	jmp    80106397 <alltraps>

80106a33 <vector56>:
.globl vector56
vector56:
  pushl $0
80106a33:	6a 00                	push   $0x0
  pushl $56
80106a35:	6a 38                	push   $0x38
  jmp alltraps
80106a37:	e9 5b f9 ff ff       	jmp    80106397 <alltraps>

80106a3c <vector57>:
.globl vector57
vector57:
  pushl $0
80106a3c:	6a 00                	push   $0x0
  pushl $57
80106a3e:	6a 39                	push   $0x39
  jmp alltraps
80106a40:	e9 52 f9 ff ff       	jmp    80106397 <alltraps>

80106a45 <vector58>:
.globl vector58
vector58:
  pushl $0
80106a45:	6a 00                	push   $0x0
  pushl $58
80106a47:	6a 3a                	push   $0x3a
  jmp alltraps
80106a49:	e9 49 f9 ff ff       	jmp    80106397 <alltraps>

80106a4e <vector59>:
.globl vector59
vector59:
  pushl $0
80106a4e:	6a 00                	push   $0x0
  pushl $59
80106a50:	6a 3b                	push   $0x3b
  jmp alltraps
80106a52:	e9 40 f9 ff ff       	jmp    80106397 <alltraps>

80106a57 <vector60>:
.globl vector60
vector60:
  pushl $0
80106a57:	6a 00                	push   $0x0
  pushl $60
80106a59:	6a 3c                	push   $0x3c
  jmp alltraps
80106a5b:	e9 37 f9 ff ff       	jmp    80106397 <alltraps>

80106a60 <vector61>:
.globl vector61
vector61:
  pushl $0
80106a60:	6a 00                	push   $0x0
  pushl $61
80106a62:	6a 3d                	push   $0x3d
  jmp alltraps
80106a64:	e9 2e f9 ff ff       	jmp    80106397 <alltraps>

80106a69 <vector62>:
.globl vector62
vector62:
  pushl $0
80106a69:	6a 00                	push   $0x0
  pushl $62
80106a6b:	6a 3e                	push   $0x3e
  jmp alltraps
80106a6d:	e9 25 f9 ff ff       	jmp    80106397 <alltraps>

80106a72 <vector63>:
.globl vector63
vector63:
  pushl $0
80106a72:	6a 00                	push   $0x0
  pushl $63
80106a74:	6a 3f                	push   $0x3f
  jmp alltraps
80106a76:	e9 1c f9 ff ff       	jmp    80106397 <alltraps>

80106a7b <vector64>:
.globl vector64
vector64:
  pushl $0
80106a7b:	6a 00                	push   $0x0
  pushl $64
80106a7d:	6a 40                	push   $0x40
  jmp alltraps
80106a7f:	e9 13 f9 ff ff       	jmp    80106397 <alltraps>

80106a84 <vector65>:
.globl vector65
vector65:
  pushl $0
80106a84:	6a 00                	push   $0x0
  pushl $65
80106a86:	6a 41                	push   $0x41
  jmp alltraps
80106a88:	e9 0a f9 ff ff       	jmp    80106397 <alltraps>

80106a8d <vector66>:
.globl vector66
vector66:
  pushl $0
80106a8d:	6a 00                	push   $0x0
  pushl $66
80106a8f:	6a 42                	push   $0x42
  jmp alltraps
80106a91:	e9 01 f9 ff ff       	jmp    80106397 <alltraps>

80106a96 <vector67>:
.globl vector67
vector67:
  pushl $0
80106a96:	6a 00                	push   $0x0
  pushl $67
80106a98:	6a 43                	push   $0x43
  jmp alltraps
80106a9a:	e9 f8 f8 ff ff       	jmp    80106397 <alltraps>

80106a9f <vector68>:
.globl vector68
vector68:
  pushl $0
80106a9f:	6a 00                	push   $0x0
  pushl $68
80106aa1:	6a 44                	push   $0x44
  jmp alltraps
80106aa3:	e9 ef f8 ff ff       	jmp    80106397 <alltraps>

80106aa8 <vector69>:
.globl vector69
vector69:
  pushl $0
80106aa8:	6a 00                	push   $0x0
  pushl $69
80106aaa:	6a 45                	push   $0x45
  jmp alltraps
80106aac:	e9 e6 f8 ff ff       	jmp    80106397 <alltraps>

80106ab1 <vector70>:
.globl vector70
vector70:
  pushl $0
80106ab1:	6a 00                	push   $0x0
  pushl $70
80106ab3:	6a 46                	push   $0x46
  jmp alltraps
80106ab5:	e9 dd f8 ff ff       	jmp    80106397 <alltraps>

80106aba <vector71>:
.globl vector71
vector71:
  pushl $0
80106aba:	6a 00                	push   $0x0
  pushl $71
80106abc:	6a 47                	push   $0x47
  jmp alltraps
80106abe:	e9 d4 f8 ff ff       	jmp    80106397 <alltraps>

80106ac3 <vector72>:
.globl vector72
vector72:
  pushl $0
80106ac3:	6a 00                	push   $0x0
  pushl $72
80106ac5:	6a 48                	push   $0x48
  jmp alltraps
80106ac7:	e9 cb f8 ff ff       	jmp    80106397 <alltraps>

80106acc <vector73>:
.globl vector73
vector73:
  pushl $0
80106acc:	6a 00                	push   $0x0
  pushl $73
80106ace:	6a 49                	push   $0x49
  jmp alltraps
80106ad0:	e9 c2 f8 ff ff       	jmp    80106397 <alltraps>

80106ad5 <vector74>:
.globl vector74
vector74:
  pushl $0
80106ad5:	6a 00                	push   $0x0
  pushl $74
80106ad7:	6a 4a                	push   $0x4a
  jmp alltraps
80106ad9:	e9 b9 f8 ff ff       	jmp    80106397 <alltraps>

80106ade <vector75>:
.globl vector75
vector75:
  pushl $0
80106ade:	6a 00                	push   $0x0
  pushl $75
80106ae0:	6a 4b                	push   $0x4b
  jmp alltraps
80106ae2:	e9 b0 f8 ff ff       	jmp    80106397 <alltraps>

80106ae7 <vector76>:
.globl vector76
vector76:
  pushl $0
80106ae7:	6a 00                	push   $0x0
  pushl $76
80106ae9:	6a 4c                	push   $0x4c
  jmp alltraps
80106aeb:	e9 a7 f8 ff ff       	jmp    80106397 <alltraps>

80106af0 <vector77>:
.globl vector77
vector77:
  pushl $0
80106af0:	6a 00                	push   $0x0
  pushl $77
80106af2:	6a 4d                	push   $0x4d
  jmp alltraps
80106af4:	e9 9e f8 ff ff       	jmp    80106397 <alltraps>

80106af9 <vector78>:
.globl vector78
vector78:
  pushl $0
80106af9:	6a 00                	push   $0x0
  pushl $78
80106afb:	6a 4e                	push   $0x4e
  jmp alltraps
80106afd:	e9 95 f8 ff ff       	jmp    80106397 <alltraps>

80106b02 <vector79>:
.globl vector79
vector79:
  pushl $0
80106b02:	6a 00                	push   $0x0
  pushl $79
80106b04:	6a 4f                	push   $0x4f
  jmp alltraps
80106b06:	e9 8c f8 ff ff       	jmp    80106397 <alltraps>

80106b0b <vector80>:
.globl vector80
vector80:
  pushl $0
80106b0b:	6a 00                	push   $0x0
  pushl $80
80106b0d:	6a 50                	push   $0x50
  jmp alltraps
80106b0f:	e9 83 f8 ff ff       	jmp    80106397 <alltraps>

80106b14 <vector81>:
.globl vector81
vector81:
  pushl $0
80106b14:	6a 00                	push   $0x0
  pushl $81
80106b16:	6a 51                	push   $0x51
  jmp alltraps
80106b18:	e9 7a f8 ff ff       	jmp    80106397 <alltraps>

80106b1d <vector82>:
.globl vector82
vector82:
  pushl $0
80106b1d:	6a 00                	push   $0x0
  pushl $82
80106b1f:	6a 52                	push   $0x52
  jmp alltraps
80106b21:	e9 71 f8 ff ff       	jmp    80106397 <alltraps>

80106b26 <vector83>:
.globl vector83
vector83:
  pushl $0
80106b26:	6a 00                	push   $0x0
  pushl $83
80106b28:	6a 53                	push   $0x53
  jmp alltraps
80106b2a:	e9 68 f8 ff ff       	jmp    80106397 <alltraps>

80106b2f <vector84>:
.globl vector84
vector84:
  pushl $0
80106b2f:	6a 00                	push   $0x0
  pushl $84
80106b31:	6a 54                	push   $0x54
  jmp alltraps
80106b33:	e9 5f f8 ff ff       	jmp    80106397 <alltraps>

80106b38 <vector85>:
.globl vector85
vector85:
  pushl $0
80106b38:	6a 00                	push   $0x0
  pushl $85
80106b3a:	6a 55                	push   $0x55
  jmp alltraps
80106b3c:	e9 56 f8 ff ff       	jmp    80106397 <alltraps>

80106b41 <vector86>:
.globl vector86
vector86:
  pushl $0
80106b41:	6a 00                	push   $0x0
  pushl $86
80106b43:	6a 56                	push   $0x56
  jmp alltraps
80106b45:	e9 4d f8 ff ff       	jmp    80106397 <alltraps>

80106b4a <vector87>:
.globl vector87
vector87:
  pushl $0
80106b4a:	6a 00                	push   $0x0
  pushl $87
80106b4c:	6a 57                	push   $0x57
  jmp alltraps
80106b4e:	e9 44 f8 ff ff       	jmp    80106397 <alltraps>

80106b53 <vector88>:
.globl vector88
vector88:
  pushl $0
80106b53:	6a 00                	push   $0x0
  pushl $88
80106b55:	6a 58                	push   $0x58
  jmp alltraps
80106b57:	e9 3b f8 ff ff       	jmp    80106397 <alltraps>

80106b5c <vector89>:
.globl vector89
vector89:
  pushl $0
80106b5c:	6a 00                	push   $0x0
  pushl $89
80106b5e:	6a 59                	push   $0x59
  jmp alltraps
80106b60:	e9 32 f8 ff ff       	jmp    80106397 <alltraps>

80106b65 <vector90>:
.globl vector90
vector90:
  pushl $0
80106b65:	6a 00                	push   $0x0
  pushl $90
80106b67:	6a 5a                	push   $0x5a
  jmp alltraps
80106b69:	e9 29 f8 ff ff       	jmp    80106397 <alltraps>

80106b6e <vector91>:
.globl vector91
vector91:
  pushl $0
80106b6e:	6a 00                	push   $0x0
  pushl $91
80106b70:	6a 5b                	push   $0x5b
  jmp alltraps
80106b72:	e9 20 f8 ff ff       	jmp    80106397 <alltraps>

80106b77 <vector92>:
.globl vector92
vector92:
  pushl $0
80106b77:	6a 00                	push   $0x0
  pushl $92
80106b79:	6a 5c                	push   $0x5c
  jmp alltraps
80106b7b:	e9 17 f8 ff ff       	jmp    80106397 <alltraps>

80106b80 <vector93>:
.globl vector93
vector93:
  pushl $0
80106b80:	6a 00                	push   $0x0
  pushl $93
80106b82:	6a 5d                	push   $0x5d
  jmp alltraps
80106b84:	e9 0e f8 ff ff       	jmp    80106397 <alltraps>

80106b89 <vector94>:
.globl vector94
vector94:
  pushl $0
80106b89:	6a 00                	push   $0x0
  pushl $94
80106b8b:	6a 5e                	push   $0x5e
  jmp alltraps
80106b8d:	e9 05 f8 ff ff       	jmp    80106397 <alltraps>

80106b92 <vector95>:
.globl vector95
vector95:
  pushl $0
80106b92:	6a 00                	push   $0x0
  pushl $95
80106b94:	6a 5f                	push   $0x5f
  jmp alltraps
80106b96:	e9 fc f7 ff ff       	jmp    80106397 <alltraps>

80106b9b <vector96>:
.globl vector96
vector96:
  pushl $0
80106b9b:	6a 00                	push   $0x0
  pushl $96
80106b9d:	6a 60                	push   $0x60
  jmp alltraps
80106b9f:	e9 f3 f7 ff ff       	jmp    80106397 <alltraps>

80106ba4 <vector97>:
.globl vector97
vector97:
  pushl $0
80106ba4:	6a 00                	push   $0x0
  pushl $97
80106ba6:	6a 61                	push   $0x61
  jmp alltraps
80106ba8:	e9 ea f7 ff ff       	jmp    80106397 <alltraps>

80106bad <vector98>:
.globl vector98
vector98:
  pushl $0
80106bad:	6a 00                	push   $0x0
  pushl $98
80106baf:	6a 62                	push   $0x62
  jmp alltraps
80106bb1:	e9 e1 f7 ff ff       	jmp    80106397 <alltraps>

80106bb6 <vector99>:
.globl vector99
vector99:
  pushl $0
80106bb6:	6a 00                	push   $0x0
  pushl $99
80106bb8:	6a 63                	push   $0x63
  jmp alltraps
80106bba:	e9 d8 f7 ff ff       	jmp    80106397 <alltraps>

80106bbf <vector100>:
.globl vector100
vector100:
  pushl $0
80106bbf:	6a 00                	push   $0x0
  pushl $100
80106bc1:	6a 64                	push   $0x64
  jmp alltraps
80106bc3:	e9 cf f7 ff ff       	jmp    80106397 <alltraps>

80106bc8 <vector101>:
.globl vector101
vector101:
  pushl $0
80106bc8:	6a 00                	push   $0x0
  pushl $101
80106bca:	6a 65                	push   $0x65
  jmp alltraps
80106bcc:	e9 c6 f7 ff ff       	jmp    80106397 <alltraps>

80106bd1 <vector102>:
.globl vector102
vector102:
  pushl $0
80106bd1:	6a 00                	push   $0x0
  pushl $102
80106bd3:	6a 66                	push   $0x66
  jmp alltraps
80106bd5:	e9 bd f7 ff ff       	jmp    80106397 <alltraps>

80106bda <vector103>:
.globl vector103
vector103:
  pushl $0
80106bda:	6a 00                	push   $0x0
  pushl $103
80106bdc:	6a 67                	push   $0x67
  jmp alltraps
80106bde:	e9 b4 f7 ff ff       	jmp    80106397 <alltraps>

80106be3 <vector104>:
.globl vector104
vector104:
  pushl $0
80106be3:	6a 00                	push   $0x0
  pushl $104
80106be5:	6a 68                	push   $0x68
  jmp alltraps
80106be7:	e9 ab f7 ff ff       	jmp    80106397 <alltraps>

80106bec <vector105>:
.globl vector105
vector105:
  pushl $0
80106bec:	6a 00                	push   $0x0
  pushl $105
80106bee:	6a 69                	push   $0x69
  jmp alltraps
80106bf0:	e9 a2 f7 ff ff       	jmp    80106397 <alltraps>

80106bf5 <vector106>:
.globl vector106
vector106:
  pushl $0
80106bf5:	6a 00                	push   $0x0
  pushl $106
80106bf7:	6a 6a                	push   $0x6a
  jmp alltraps
80106bf9:	e9 99 f7 ff ff       	jmp    80106397 <alltraps>

80106bfe <vector107>:
.globl vector107
vector107:
  pushl $0
80106bfe:	6a 00                	push   $0x0
  pushl $107
80106c00:	6a 6b                	push   $0x6b
  jmp alltraps
80106c02:	e9 90 f7 ff ff       	jmp    80106397 <alltraps>

80106c07 <vector108>:
.globl vector108
vector108:
  pushl $0
80106c07:	6a 00                	push   $0x0
  pushl $108
80106c09:	6a 6c                	push   $0x6c
  jmp alltraps
80106c0b:	e9 87 f7 ff ff       	jmp    80106397 <alltraps>

80106c10 <vector109>:
.globl vector109
vector109:
  pushl $0
80106c10:	6a 00                	push   $0x0
  pushl $109
80106c12:	6a 6d                	push   $0x6d
  jmp alltraps
80106c14:	e9 7e f7 ff ff       	jmp    80106397 <alltraps>

80106c19 <vector110>:
.globl vector110
vector110:
  pushl $0
80106c19:	6a 00                	push   $0x0
  pushl $110
80106c1b:	6a 6e                	push   $0x6e
  jmp alltraps
80106c1d:	e9 75 f7 ff ff       	jmp    80106397 <alltraps>

80106c22 <vector111>:
.globl vector111
vector111:
  pushl $0
80106c22:	6a 00                	push   $0x0
  pushl $111
80106c24:	6a 6f                	push   $0x6f
  jmp alltraps
80106c26:	e9 6c f7 ff ff       	jmp    80106397 <alltraps>

80106c2b <vector112>:
.globl vector112
vector112:
  pushl $0
80106c2b:	6a 00                	push   $0x0
  pushl $112
80106c2d:	6a 70                	push   $0x70
  jmp alltraps
80106c2f:	e9 63 f7 ff ff       	jmp    80106397 <alltraps>

80106c34 <vector113>:
.globl vector113
vector113:
  pushl $0
80106c34:	6a 00                	push   $0x0
  pushl $113
80106c36:	6a 71                	push   $0x71
  jmp alltraps
80106c38:	e9 5a f7 ff ff       	jmp    80106397 <alltraps>

80106c3d <vector114>:
.globl vector114
vector114:
  pushl $0
80106c3d:	6a 00                	push   $0x0
  pushl $114
80106c3f:	6a 72                	push   $0x72
  jmp alltraps
80106c41:	e9 51 f7 ff ff       	jmp    80106397 <alltraps>

80106c46 <vector115>:
.globl vector115
vector115:
  pushl $0
80106c46:	6a 00                	push   $0x0
  pushl $115
80106c48:	6a 73                	push   $0x73
  jmp alltraps
80106c4a:	e9 48 f7 ff ff       	jmp    80106397 <alltraps>

80106c4f <vector116>:
.globl vector116
vector116:
  pushl $0
80106c4f:	6a 00                	push   $0x0
  pushl $116
80106c51:	6a 74                	push   $0x74
  jmp alltraps
80106c53:	e9 3f f7 ff ff       	jmp    80106397 <alltraps>

80106c58 <vector117>:
.globl vector117
vector117:
  pushl $0
80106c58:	6a 00                	push   $0x0
  pushl $117
80106c5a:	6a 75                	push   $0x75
  jmp alltraps
80106c5c:	e9 36 f7 ff ff       	jmp    80106397 <alltraps>

80106c61 <vector118>:
.globl vector118
vector118:
  pushl $0
80106c61:	6a 00                	push   $0x0
  pushl $118
80106c63:	6a 76                	push   $0x76
  jmp alltraps
80106c65:	e9 2d f7 ff ff       	jmp    80106397 <alltraps>

80106c6a <vector119>:
.globl vector119
vector119:
  pushl $0
80106c6a:	6a 00                	push   $0x0
  pushl $119
80106c6c:	6a 77                	push   $0x77
  jmp alltraps
80106c6e:	e9 24 f7 ff ff       	jmp    80106397 <alltraps>

80106c73 <vector120>:
.globl vector120
vector120:
  pushl $0
80106c73:	6a 00                	push   $0x0
  pushl $120
80106c75:	6a 78                	push   $0x78
  jmp alltraps
80106c77:	e9 1b f7 ff ff       	jmp    80106397 <alltraps>

80106c7c <vector121>:
.globl vector121
vector121:
  pushl $0
80106c7c:	6a 00                	push   $0x0
  pushl $121
80106c7e:	6a 79                	push   $0x79
  jmp alltraps
80106c80:	e9 12 f7 ff ff       	jmp    80106397 <alltraps>

80106c85 <vector122>:
.globl vector122
vector122:
  pushl $0
80106c85:	6a 00                	push   $0x0
  pushl $122
80106c87:	6a 7a                	push   $0x7a
  jmp alltraps
80106c89:	e9 09 f7 ff ff       	jmp    80106397 <alltraps>

80106c8e <vector123>:
.globl vector123
vector123:
  pushl $0
80106c8e:	6a 00                	push   $0x0
  pushl $123
80106c90:	6a 7b                	push   $0x7b
  jmp alltraps
80106c92:	e9 00 f7 ff ff       	jmp    80106397 <alltraps>

80106c97 <vector124>:
.globl vector124
vector124:
  pushl $0
80106c97:	6a 00                	push   $0x0
  pushl $124
80106c99:	6a 7c                	push   $0x7c
  jmp alltraps
80106c9b:	e9 f7 f6 ff ff       	jmp    80106397 <alltraps>

80106ca0 <vector125>:
.globl vector125
vector125:
  pushl $0
80106ca0:	6a 00                	push   $0x0
  pushl $125
80106ca2:	6a 7d                	push   $0x7d
  jmp alltraps
80106ca4:	e9 ee f6 ff ff       	jmp    80106397 <alltraps>

80106ca9 <vector126>:
.globl vector126
vector126:
  pushl $0
80106ca9:	6a 00                	push   $0x0
  pushl $126
80106cab:	6a 7e                	push   $0x7e
  jmp alltraps
80106cad:	e9 e5 f6 ff ff       	jmp    80106397 <alltraps>

80106cb2 <vector127>:
.globl vector127
vector127:
  pushl $0
80106cb2:	6a 00                	push   $0x0
  pushl $127
80106cb4:	6a 7f                	push   $0x7f
  jmp alltraps
80106cb6:	e9 dc f6 ff ff       	jmp    80106397 <alltraps>

80106cbb <vector128>:
.globl vector128
vector128:
  pushl $0
80106cbb:	6a 00                	push   $0x0
  pushl $128
80106cbd:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106cc2:	e9 d0 f6 ff ff       	jmp    80106397 <alltraps>

80106cc7 <vector129>:
.globl vector129
vector129:
  pushl $0
80106cc7:	6a 00                	push   $0x0
  pushl $129
80106cc9:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106cce:	e9 c4 f6 ff ff       	jmp    80106397 <alltraps>

80106cd3 <vector130>:
.globl vector130
vector130:
  pushl $0
80106cd3:	6a 00                	push   $0x0
  pushl $130
80106cd5:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106cda:	e9 b8 f6 ff ff       	jmp    80106397 <alltraps>

80106cdf <vector131>:
.globl vector131
vector131:
  pushl $0
80106cdf:	6a 00                	push   $0x0
  pushl $131
80106ce1:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106ce6:	e9 ac f6 ff ff       	jmp    80106397 <alltraps>

80106ceb <vector132>:
.globl vector132
vector132:
  pushl $0
80106ceb:	6a 00                	push   $0x0
  pushl $132
80106ced:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106cf2:	e9 a0 f6 ff ff       	jmp    80106397 <alltraps>

80106cf7 <vector133>:
.globl vector133
vector133:
  pushl $0
80106cf7:	6a 00                	push   $0x0
  pushl $133
80106cf9:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106cfe:	e9 94 f6 ff ff       	jmp    80106397 <alltraps>

80106d03 <vector134>:
.globl vector134
vector134:
  pushl $0
80106d03:	6a 00                	push   $0x0
  pushl $134
80106d05:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106d0a:	e9 88 f6 ff ff       	jmp    80106397 <alltraps>

80106d0f <vector135>:
.globl vector135
vector135:
  pushl $0
80106d0f:	6a 00                	push   $0x0
  pushl $135
80106d11:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106d16:	e9 7c f6 ff ff       	jmp    80106397 <alltraps>

80106d1b <vector136>:
.globl vector136
vector136:
  pushl $0
80106d1b:	6a 00                	push   $0x0
  pushl $136
80106d1d:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106d22:	e9 70 f6 ff ff       	jmp    80106397 <alltraps>

80106d27 <vector137>:
.globl vector137
vector137:
  pushl $0
80106d27:	6a 00                	push   $0x0
  pushl $137
80106d29:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106d2e:	e9 64 f6 ff ff       	jmp    80106397 <alltraps>

80106d33 <vector138>:
.globl vector138
vector138:
  pushl $0
80106d33:	6a 00                	push   $0x0
  pushl $138
80106d35:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106d3a:	e9 58 f6 ff ff       	jmp    80106397 <alltraps>

80106d3f <vector139>:
.globl vector139
vector139:
  pushl $0
80106d3f:	6a 00                	push   $0x0
  pushl $139
80106d41:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106d46:	e9 4c f6 ff ff       	jmp    80106397 <alltraps>

80106d4b <vector140>:
.globl vector140
vector140:
  pushl $0
80106d4b:	6a 00                	push   $0x0
  pushl $140
80106d4d:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106d52:	e9 40 f6 ff ff       	jmp    80106397 <alltraps>

80106d57 <vector141>:
.globl vector141
vector141:
  pushl $0
80106d57:	6a 00                	push   $0x0
  pushl $141
80106d59:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106d5e:	e9 34 f6 ff ff       	jmp    80106397 <alltraps>

80106d63 <vector142>:
.globl vector142
vector142:
  pushl $0
80106d63:	6a 00                	push   $0x0
  pushl $142
80106d65:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106d6a:	e9 28 f6 ff ff       	jmp    80106397 <alltraps>

80106d6f <vector143>:
.globl vector143
vector143:
  pushl $0
80106d6f:	6a 00                	push   $0x0
  pushl $143
80106d71:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106d76:	e9 1c f6 ff ff       	jmp    80106397 <alltraps>

80106d7b <vector144>:
.globl vector144
vector144:
  pushl $0
80106d7b:	6a 00                	push   $0x0
  pushl $144
80106d7d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80106d82:	e9 10 f6 ff ff       	jmp    80106397 <alltraps>

80106d87 <vector145>:
.globl vector145
vector145:
  pushl $0
80106d87:	6a 00                	push   $0x0
  pushl $145
80106d89:	68 91 00 00 00       	push   $0x91
  jmp alltraps
80106d8e:	e9 04 f6 ff ff       	jmp    80106397 <alltraps>

80106d93 <vector146>:
.globl vector146
vector146:
  pushl $0
80106d93:	6a 00                	push   $0x0
  pushl $146
80106d95:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106d9a:	e9 f8 f5 ff ff       	jmp    80106397 <alltraps>

80106d9f <vector147>:
.globl vector147
vector147:
  pushl $0
80106d9f:	6a 00                	push   $0x0
  pushl $147
80106da1:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106da6:	e9 ec f5 ff ff       	jmp    80106397 <alltraps>

80106dab <vector148>:
.globl vector148
vector148:
  pushl $0
80106dab:	6a 00                	push   $0x0
  pushl $148
80106dad:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80106db2:	e9 e0 f5 ff ff       	jmp    80106397 <alltraps>

80106db7 <vector149>:
.globl vector149
vector149:
  pushl $0
80106db7:	6a 00                	push   $0x0
  pushl $149
80106db9:	68 95 00 00 00       	push   $0x95
  jmp alltraps
80106dbe:	e9 d4 f5 ff ff       	jmp    80106397 <alltraps>

80106dc3 <vector150>:
.globl vector150
vector150:
  pushl $0
80106dc3:	6a 00                	push   $0x0
  pushl $150
80106dc5:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106dca:	e9 c8 f5 ff ff       	jmp    80106397 <alltraps>

80106dcf <vector151>:
.globl vector151
vector151:
  pushl $0
80106dcf:	6a 00                	push   $0x0
  pushl $151
80106dd1:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106dd6:	e9 bc f5 ff ff       	jmp    80106397 <alltraps>

80106ddb <vector152>:
.globl vector152
vector152:
  pushl $0
80106ddb:	6a 00                	push   $0x0
  pushl $152
80106ddd:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106de2:	e9 b0 f5 ff ff       	jmp    80106397 <alltraps>

80106de7 <vector153>:
.globl vector153
vector153:
  pushl $0
80106de7:	6a 00                	push   $0x0
  pushl $153
80106de9:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106dee:	e9 a4 f5 ff ff       	jmp    80106397 <alltraps>

80106df3 <vector154>:
.globl vector154
vector154:
  pushl $0
80106df3:	6a 00                	push   $0x0
  pushl $154
80106df5:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106dfa:	e9 98 f5 ff ff       	jmp    80106397 <alltraps>

80106dff <vector155>:
.globl vector155
vector155:
  pushl $0
80106dff:	6a 00                	push   $0x0
  pushl $155
80106e01:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106e06:	e9 8c f5 ff ff       	jmp    80106397 <alltraps>

80106e0b <vector156>:
.globl vector156
vector156:
  pushl $0
80106e0b:	6a 00                	push   $0x0
  pushl $156
80106e0d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106e12:	e9 80 f5 ff ff       	jmp    80106397 <alltraps>

80106e17 <vector157>:
.globl vector157
vector157:
  pushl $0
80106e17:	6a 00                	push   $0x0
  pushl $157
80106e19:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106e1e:	e9 74 f5 ff ff       	jmp    80106397 <alltraps>

80106e23 <vector158>:
.globl vector158
vector158:
  pushl $0
80106e23:	6a 00                	push   $0x0
  pushl $158
80106e25:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106e2a:	e9 68 f5 ff ff       	jmp    80106397 <alltraps>

80106e2f <vector159>:
.globl vector159
vector159:
  pushl $0
80106e2f:	6a 00                	push   $0x0
  pushl $159
80106e31:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106e36:	e9 5c f5 ff ff       	jmp    80106397 <alltraps>

80106e3b <vector160>:
.globl vector160
vector160:
  pushl $0
80106e3b:	6a 00                	push   $0x0
  pushl $160
80106e3d:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106e42:	e9 50 f5 ff ff       	jmp    80106397 <alltraps>

80106e47 <vector161>:
.globl vector161
vector161:
  pushl $0
80106e47:	6a 00                	push   $0x0
  pushl $161
80106e49:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106e4e:	e9 44 f5 ff ff       	jmp    80106397 <alltraps>

80106e53 <vector162>:
.globl vector162
vector162:
  pushl $0
80106e53:	6a 00                	push   $0x0
  pushl $162
80106e55:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106e5a:	e9 38 f5 ff ff       	jmp    80106397 <alltraps>

80106e5f <vector163>:
.globl vector163
vector163:
  pushl $0
80106e5f:	6a 00                	push   $0x0
  pushl $163
80106e61:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106e66:	e9 2c f5 ff ff       	jmp    80106397 <alltraps>

80106e6b <vector164>:
.globl vector164
vector164:
  pushl $0
80106e6b:	6a 00                	push   $0x0
  pushl $164
80106e6d:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106e72:	e9 20 f5 ff ff       	jmp    80106397 <alltraps>

80106e77 <vector165>:
.globl vector165
vector165:
  pushl $0
80106e77:	6a 00                	push   $0x0
  pushl $165
80106e79:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106e7e:	e9 14 f5 ff ff       	jmp    80106397 <alltraps>

80106e83 <vector166>:
.globl vector166
vector166:
  pushl $0
80106e83:	6a 00                	push   $0x0
  pushl $166
80106e85:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106e8a:	e9 08 f5 ff ff       	jmp    80106397 <alltraps>

80106e8f <vector167>:
.globl vector167
vector167:
  pushl $0
80106e8f:	6a 00                	push   $0x0
  pushl $167
80106e91:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106e96:	e9 fc f4 ff ff       	jmp    80106397 <alltraps>

80106e9b <vector168>:
.globl vector168
vector168:
  pushl $0
80106e9b:	6a 00                	push   $0x0
  pushl $168
80106e9d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ea2:	e9 f0 f4 ff ff       	jmp    80106397 <alltraps>

80106ea7 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ea7:	6a 00                	push   $0x0
  pushl $169
80106ea9:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106eae:	e9 e4 f4 ff ff       	jmp    80106397 <alltraps>

80106eb3 <vector170>:
.globl vector170
vector170:
  pushl $0
80106eb3:	6a 00                	push   $0x0
  pushl $170
80106eb5:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106eba:	e9 d8 f4 ff ff       	jmp    80106397 <alltraps>

80106ebf <vector171>:
.globl vector171
vector171:
  pushl $0
80106ebf:	6a 00                	push   $0x0
  pushl $171
80106ec1:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106ec6:	e9 cc f4 ff ff       	jmp    80106397 <alltraps>

80106ecb <vector172>:
.globl vector172
vector172:
  pushl $0
80106ecb:	6a 00                	push   $0x0
  pushl $172
80106ecd:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106ed2:	e9 c0 f4 ff ff       	jmp    80106397 <alltraps>

80106ed7 <vector173>:
.globl vector173
vector173:
  pushl $0
80106ed7:	6a 00                	push   $0x0
  pushl $173
80106ed9:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106ede:	e9 b4 f4 ff ff       	jmp    80106397 <alltraps>

80106ee3 <vector174>:
.globl vector174
vector174:
  pushl $0
80106ee3:	6a 00                	push   $0x0
  pushl $174
80106ee5:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106eea:	e9 a8 f4 ff ff       	jmp    80106397 <alltraps>

80106eef <vector175>:
.globl vector175
vector175:
  pushl $0
80106eef:	6a 00                	push   $0x0
  pushl $175
80106ef1:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106ef6:	e9 9c f4 ff ff       	jmp    80106397 <alltraps>

80106efb <vector176>:
.globl vector176
vector176:
  pushl $0
80106efb:	6a 00                	push   $0x0
  pushl $176
80106efd:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106f02:	e9 90 f4 ff ff       	jmp    80106397 <alltraps>

80106f07 <vector177>:
.globl vector177
vector177:
  pushl $0
80106f07:	6a 00                	push   $0x0
  pushl $177
80106f09:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106f0e:	e9 84 f4 ff ff       	jmp    80106397 <alltraps>

80106f13 <vector178>:
.globl vector178
vector178:
  pushl $0
80106f13:	6a 00                	push   $0x0
  pushl $178
80106f15:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106f1a:	e9 78 f4 ff ff       	jmp    80106397 <alltraps>

80106f1f <vector179>:
.globl vector179
vector179:
  pushl $0
80106f1f:	6a 00                	push   $0x0
  pushl $179
80106f21:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106f26:	e9 6c f4 ff ff       	jmp    80106397 <alltraps>

80106f2b <vector180>:
.globl vector180
vector180:
  pushl $0
80106f2b:	6a 00                	push   $0x0
  pushl $180
80106f2d:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106f32:	e9 60 f4 ff ff       	jmp    80106397 <alltraps>

80106f37 <vector181>:
.globl vector181
vector181:
  pushl $0
80106f37:	6a 00                	push   $0x0
  pushl $181
80106f39:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106f3e:	e9 54 f4 ff ff       	jmp    80106397 <alltraps>

80106f43 <vector182>:
.globl vector182
vector182:
  pushl $0
80106f43:	6a 00                	push   $0x0
  pushl $182
80106f45:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106f4a:	e9 48 f4 ff ff       	jmp    80106397 <alltraps>

80106f4f <vector183>:
.globl vector183
vector183:
  pushl $0
80106f4f:	6a 00                	push   $0x0
  pushl $183
80106f51:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106f56:	e9 3c f4 ff ff       	jmp    80106397 <alltraps>

80106f5b <vector184>:
.globl vector184
vector184:
  pushl $0
80106f5b:	6a 00                	push   $0x0
  pushl $184
80106f5d:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106f62:	e9 30 f4 ff ff       	jmp    80106397 <alltraps>

80106f67 <vector185>:
.globl vector185
vector185:
  pushl $0
80106f67:	6a 00                	push   $0x0
  pushl $185
80106f69:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106f6e:	e9 24 f4 ff ff       	jmp    80106397 <alltraps>

80106f73 <vector186>:
.globl vector186
vector186:
  pushl $0
80106f73:	6a 00                	push   $0x0
  pushl $186
80106f75:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106f7a:	e9 18 f4 ff ff       	jmp    80106397 <alltraps>

80106f7f <vector187>:
.globl vector187
vector187:
  pushl $0
80106f7f:	6a 00                	push   $0x0
  pushl $187
80106f81:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106f86:	e9 0c f4 ff ff       	jmp    80106397 <alltraps>

80106f8b <vector188>:
.globl vector188
vector188:
  pushl $0
80106f8b:	6a 00                	push   $0x0
  pushl $188
80106f8d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106f92:	e9 00 f4 ff ff       	jmp    80106397 <alltraps>

80106f97 <vector189>:
.globl vector189
vector189:
  pushl $0
80106f97:	6a 00                	push   $0x0
  pushl $189
80106f99:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106f9e:	e9 f4 f3 ff ff       	jmp    80106397 <alltraps>

80106fa3 <vector190>:
.globl vector190
vector190:
  pushl $0
80106fa3:	6a 00                	push   $0x0
  pushl $190
80106fa5:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106faa:	e9 e8 f3 ff ff       	jmp    80106397 <alltraps>

80106faf <vector191>:
.globl vector191
vector191:
  pushl $0
80106faf:	6a 00                	push   $0x0
  pushl $191
80106fb1:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106fb6:	e9 dc f3 ff ff       	jmp    80106397 <alltraps>

80106fbb <vector192>:
.globl vector192
vector192:
  pushl $0
80106fbb:	6a 00                	push   $0x0
  pushl $192
80106fbd:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106fc2:	e9 d0 f3 ff ff       	jmp    80106397 <alltraps>

80106fc7 <vector193>:
.globl vector193
vector193:
  pushl $0
80106fc7:	6a 00                	push   $0x0
  pushl $193
80106fc9:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106fce:	e9 c4 f3 ff ff       	jmp    80106397 <alltraps>

80106fd3 <vector194>:
.globl vector194
vector194:
  pushl $0
80106fd3:	6a 00                	push   $0x0
  pushl $194
80106fd5:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106fda:	e9 b8 f3 ff ff       	jmp    80106397 <alltraps>

80106fdf <vector195>:
.globl vector195
vector195:
  pushl $0
80106fdf:	6a 00                	push   $0x0
  pushl $195
80106fe1:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106fe6:	e9 ac f3 ff ff       	jmp    80106397 <alltraps>

80106feb <vector196>:
.globl vector196
vector196:
  pushl $0
80106feb:	6a 00                	push   $0x0
  pushl $196
80106fed:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106ff2:	e9 a0 f3 ff ff       	jmp    80106397 <alltraps>

80106ff7 <vector197>:
.globl vector197
vector197:
  pushl $0
80106ff7:	6a 00                	push   $0x0
  pushl $197
80106ff9:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106ffe:	e9 94 f3 ff ff       	jmp    80106397 <alltraps>

80107003 <vector198>:
.globl vector198
vector198:
  pushl $0
80107003:	6a 00                	push   $0x0
  pushl $198
80107005:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010700a:	e9 88 f3 ff ff       	jmp    80106397 <alltraps>

8010700f <vector199>:
.globl vector199
vector199:
  pushl $0
8010700f:	6a 00                	push   $0x0
  pushl $199
80107011:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107016:	e9 7c f3 ff ff       	jmp    80106397 <alltraps>

8010701b <vector200>:
.globl vector200
vector200:
  pushl $0
8010701b:	6a 00                	push   $0x0
  pushl $200
8010701d:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107022:	e9 70 f3 ff ff       	jmp    80106397 <alltraps>

80107027 <vector201>:
.globl vector201
vector201:
  pushl $0
80107027:	6a 00                	push   $0x0
  pushl $201
80107029:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010702e:	e9 64 f3 ff ff       	jmp    80106397 <alltraps>

80107033 <vector202>:
.globl vector202
vector202:
  pushl $0
80107033:	6a 00                	push   $0x0
  pushl $202
80107035:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
8010703a:	e9 58 f3 ff ff       	jmp    80106397 <alltraps>

8010703f <vector203>:
.globl vector203
vector203:
  pushl $0
8010703f:	6a 00                	push   $0x0
  pushl $203
80107041:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107046:	e9 4c f3 ff ff       	jmp    80106397 <alltraps>

8010704b <vector204>:
.globl vector204
vector204:
  pushl $0
8010704b:	6a 00                	push   $0x0
  pushl $204
8010704d:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107052:	e9 40 f3 ff ff       	jmp    80106397 <alltraps>

80107057 <vector205>:
.globl vector205
vector205:
  pushl $0
80107057:	6a 00                	push   $0x0
  pushl $205
80107059:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010705e:	e9 34 f3 ff ff       	jmp    80106397 <alltraps>

80107063 <vector206>:
.globl vector206
vector206:
  pushl $0
80107063:	6a 00                	push   $0x0
  pushl $206
80107065:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
8010706a:	e9 28 f3 ff ff       	jmp    80106397 <alltraps>

8010706f <vector207>:
.globl vector207
vector207:
  pushl $0
8010706f:	6a 00                	push   $0x0
  pushl $207
80107071:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107076:	e9 1c f3 ff ff       	jmp    80106397 <alltraps>

8010707b <vector208>:
.globl vector208
vector208:
  pushl $0
8010707b:	6a 00                	push   $0x0
  pushl $208
8010707d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107082:	e9 10 f3 ff ff       	jmp    80106397 <alltraps>

80107087 <vector209>:
.globl vector209
vector209:
  pushl $0
80107087:	6a 00                	push   $0x0
  pushl $209
80107089:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010708e:	e9 04 f3 ff ff       	jmp    80106397 <alltraps>

80107093 <vector210>:
.globl vector210
vector210:
  pushl $0
80107093:	6a 00                	push   $0x0
  pushl $210
80107095:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010709a:	e9 f8 f2 ff ff       	jmp    80106397 <alltraps>

8010709f <vector211>:
.globl vector211
vector211:
  pushl $0
8010709f:	6a 00                	push   $0x0
  pushl $211
801070a1:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
801070a6:	e9 ec f2 ff ff       	jmp    80106397 <alltraps>

801070ab <vector212>:
.globl vector212
vector212:
  pushl $0
801070ab:	6a 00                	push   $0x0
  pushl $212
801070ad:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
801070b2:	e9 e0 f2 ff ff       	jmp    80106397 <alltraps>

801070b7 <vector213>:
.globl vector213
vector213:
  pushl $0
801070b7:	6a 00                	push   $0x0
  pushl $213
801070b9:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
801070be:	e9 d4 f2 ff ff       	jmp    80106397 <alltraps>

801070c3 <vector214>:
.globl vector214
vector214:
  pushl $0
801070c3:	6a 00                	push   $0x0
  pushl $214
801070c5:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
801070ca:	e9 c8 f2 ff ff       	jmp    80106397 <alltraps>

801070cf <vector215>:
.globl vector215
vector215:
  pushl $0
801070cf:	6a 00                	push   $0x0
  pushl $215
801070d1:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
801070d6:	e9 bc f2 ff ff       	jmp    80106397 <alltraps>

801070db <vector216>:
.globl vector216
vector216:
  pushl $0
801070db:	6a 00                	push   $0x0
  pushl $216
801070dd:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
801070e2:	e9 b0 f2 ff ff       	jmp    80106397 <alltraps>

801070e7 <vector217>:
.globl vector217
vector217:
  pushl $0
801070e7:	6a 00                	push   $0x0
  pushl $217
801070e9:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801070ee:	e9 a4 f2 ff ff       	jmp    80106397 <alltraps>

801070f3 <vector218>:
.globl vector218
vector218:
  pushl $0
801070f3:	6a 00                	push   $0x0
  pushl $218
801070f5:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801070fa:	e9 98 f2 ff ff       	jmp    80106397 <alltraps>

801070ff <vector219>:
.globl vector219
vector219:
  pushl $0
801070ff:	6a 00                	push   $0x0
  pushl $219
80107101:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107106:	e9 8c f2 ff ff       	jmp    80106397 <alltraps>

8010710b <vector220>:
.globl vector220
vector220:
  pushl $0
8010710b:	6a 00                	push   $0x0
  pushl $220
8010710d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107112:	e9 80 f2 ff ff       	jmp    80106397 <alltraps>

80107117 <vector221>:
.globl vector221
vector221:
  pushl $0
80107117:	6a 00                	push   $0x0
  pushl $221
80107119:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010711e:	e9 74 f2 ff ff       	jmp    80106397 <alltraps>

80107123 <vector222>:
.globl vector222
vector222:
  pushl $0
80107123:	6a 00                	push   $0x0
  pushl $222
80107125:	68 de 00 00 00       	push   $0xde
  jmp alltraps
8010712a:	e9 68 f2 ff ff       	jmp    80106397 <alltraps>

8010712f <vector223>:
.globl vector223
vector223:
  pushl $0
8010712f:	6a 00                	push   $0x0
  pushl $223
80107131:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107136:	e9 5c f2 ff ff       	jmp    80106397 <alltraps>

8010713b <vector224>:
.globl vector224
vector224:
  pushl $0
8010713b:	6a 00                	push   $0x0
  pushl $224
8010713d:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107142:	e9 50 f2 ff ff       	jmp    80106397 <alltraps>

80107147 <vector225>:
.globl vector225
vector225:
  pushl $0
80107147:	6a 00                	push   $0x0
  pushl $225
80107149:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010714e:	e9 44 f2 ff ff       	jmp    80106397 <alltraps>

80107153 <vector226>:
.globl vector226
vector226:
  pushl $0
80107153:	6a 00                	push   $0x0
  pushl $226
80107155:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
8010715a:	e9 38 f2 ff ff       	jmp    80106397 <alltraps>

8010715f <vector227>:
.globl vector227
vector227:
  pushl $0
8010715f:	6a 00                	push   $0x0
  pushl $227
80107161:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107166:	e9 2c f2 ff ff       	jmp    80106397 <alltraps>

8010716b <vector228>:
.globl vector228
vector228:
  pushl $0
8010716b:	6a 00                	push   $0x0
  pushl $228
8010716d:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107172:	e9 20 f2 ff ff       	jmp    80106397 <alltraps>

80107177 <vector229>:
.globl vector229
vector229:
  pushl $0
80107177:	6a 00                	push   $0x0
  pushl $229
80107179:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010717e:	e9 14 f2 ff ff       	jmp    80106397 <alltraps>

80107183 <vector230>:
.globl vector230
vector230:
  pushl $0
80107183:	6a 00                	push   $0x0
  pushl $230
80107185:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010718a:	e9 08 f2 ff ff       	jmp    80106397 <alltraps>

8010718f <vector231>:
.globl vector231
vector231:
  pushl $0
8010718f:	6a 00                	push   $0x0
  pushl $231
80107191:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107196:	e9 fc f1 ff ff       	jmp    80106397 <alltraps>

8010719b <vector232>:
.globl vector232
vector232:
  pushl $0
8010719b:	6a 00                	push   $0x0
  pushl $232
8010719d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801071a2:	e9 f0 f1 ff ff       	jmp    80106397 <alltraps>

801071a7 <vector233>:
.globl vector233
vector233:
  pushl $0
801071a7:	6a 00                	push   $0x0
  pushl $233
801071a9:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
801071ae:	e9 e4 f1 ff ff       	jmp    80106397 <alltraps>

801071b3 <vector234>:
.globl vector234
vector234:
  pushl $0
801071b3:	6a 00                	push   $0x0
  pushl $234
801071b5:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
801071ba:	e9 d8 f1 ff ff       	jmp    80106397 <alltraps>

801071bf <vector235>:
.globl vector235
vector235:
  pushl $0
801071bf:	6a 00                	push   $0x0
  pushl $235
801071c1:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
801071c6:	e9 cc f1 ff ff       	jmp    80106397 <alltraps>

801071cb <vector236>:
.globl vector236
vector236:
  pushl $0
801071cb:	6a 00                	push   $0x0
  pushl $236
801071cd:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
801071d2:	e9 c0 f1 ff ff       	jmp    80106397 <alltraps>

801071d7 <vector237>:
.globl vector237
vector237:
  pushl $0
801071d7:	6a 00                	push   $0x0
  pushl $237
801071d9:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
801071de:	e9 b4 f1 ff ff       	jmp    80106397 <alltraps>

801071e3 <vector238>:
.globl vector238
vector238:
  pushl $0
801071e3:	6a 00                	push   $0x0
  pushl $238
801071e5:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801071ea:	e9 a8 f1 ff ff       	jmp    80106397 <alltraps>

801071ef <vector239>:
.globl vector239
vector239:
  pushl $0
801071ef:	6a 00                	push   $0x0
  pushl $239
801071f1:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801071f6:	e9 9c f1 ff ff       	jmp    80106397 <alltraps>

801071fb <vector240>:
.globl vector240
vector240:
  pushl $0
801071fb:	6a 00                	push   $0x0
  pushl $240
801071fd:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107202:	e9 90 f1 ff ff       	jmp    80106397 <alltraps>

80107207 <vector241>:
.globl vector241
vector241:
  pushl $0
80107207:	6a 00                	push   $0x0
  pushl $241
80107209:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010720e:	e9 84 f1 ff ff       	jmp    80106397 <alltraps>

80107213 <vector242>:
.globl vector242
vector242:
  pushl $0
80107213:	6a 00                	push   $0x0
  pushl $242
80107215:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
8010721a:	e9 78 f1 ff ff       	jmp    80106397 <alltraps>

8010721f <vector243>:
.globl vector243
vector243:
  pushl $0
8010721f:	6a 00                	push   $0x0
  pushl $243
80107221:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107226:	e9 6c f1 ff ff       	jmp    80106397 <alltraps>

8010722b <vector244>:
.globl vector244
vector244:
  pushl $0
8010722b:	6a 00                	push   $0x0
  pushl $244
8010722d:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107232:	e9 60 f1 ff ff       	jmp    80106397 <alltraps>

80107237 <vector245>:
.globl vector245
vector245:
  pushl $0
80107237:	6a 00                	push   $0x0
  pushl $245
80107239:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010723e:	e9 54 f1 ff ff       	jmp    80106397 <alltraps>

80107243 <vector246>:
.globl vector246
vector246:
  pushl $0
80107243:	6a 00                	push   $0x0
  pushl $246
80107245:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
8010724a:	e9 48 f1 ff ff       	jmp    80106397 <alltraps>

8010724f <vector247>:
.globl vector247
vector247:
  pushl $0
8010724f:	6a 00                	push   $0x0
  pushl $247
80107251:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107256:	e9 3c f1 ff ff       	jmp    80106397 <alltraps>

8010725b <vector248>:
.globl vector248
vector248:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $248
8010725d:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107262:	e9 30 f1 ff ff       	jmp    80106397 <alltraps>

80107267 <vector249>:
.globl vector249
vector249:
  pushl $0
80107267:	6a 00                	push   $0x0
  pushl $249
80107269:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010726e:	e9 24 f1 ff ff       	jmp    80106397 <alltraps>

80107273 <vector250>:
.globl vector250
vector250:
  pushl $0
80107273:	6a 00                	push   $0x0
  pushl $250
80107275:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
8010727a:	e9 18 f1 ff ff       	jmp    80106397 <alltraps>

8010727f <vector251>:
.globl vector251
vector251:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $251
80107281:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107286:	e9 0c f1 ff ff       	jmp    80106397 <alltraps>

8010728b <vector252>:
.globl vector252
vector252:
  pushl $0
8010728b:	6a 00                	push   $0x0
  pushl $252
8010728d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107292:	e9 00 f1 ff ff       	jmp    80106397 <alltraps>

80107297 <vector253>:
.globl vector253
vector253:
  pushl $0
80107297:	6a 00                	push   $0x0
  pushl $253
80107299:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010729e:	e9 f4 f0 ff ff       	jmp    80106397 <alltraps>

801072a3 <vector254>:
.globl vector254
vector254:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $254
801072a5:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
801072aa:	e9 e8 f0 ff ff       	jmp    80106397 <alltraps>

801072af <vector255>:
.globl vector255
vector255:
  pushl $0
801072af:	6a 00                	push   $0x0
  pushl $255
801072b1:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
801072b6:	e9 dc f0 ff ff       	jmp    80106397 <alltraps>
801072bb:	66 90                	xchg   %ax,%ax
801072bd:	66 90                	xchg   %ax,%ax
801072bf:	90                   	nop

801072c0 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	57                   	push   %edi
801072c4:	56                   	push   %esi
801072c5:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
801072c7:	c1 ea 16             	shr    $0x16,%edx
{
801072ca:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
801072cb:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
801072ce:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
801072d1:	8b 1f                	mov    (%edi),%ebx
801072d3:	f6 c3 01             	test   $0x1,%bl
801072d6:	74 28                	je     80107300 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801072d8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801072de:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
801072e4:	89 f0                	mov    %esi,%eax
}
801072e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
801072e9:	c1 e8 0a             	shr    $0xa,%eax
801072ec:	25 fc 0f 00 00       	and    $0xffc,%eax
801072f1:	01 d8                	add    %ebx,%eax
}
801072f3:	5b                   	pop    %ebx
801072f4:	5e                   	pop    %esi
801072f5:	5f                   	pop    %edi
801072f6:	5d                   	pop    %ebp
801072f7:	c3                   	ret    
801072f8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801072ff:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107300:	85 c9                	test   %ecx,%ecx
80107302:	74 2c                	je     80107330 <walkpgdir+0x70>
80107304:	e8 07 b8 ff ff       	call   80102b10 <kalloc>
80107309:	89 c3                	mov    %eax,%ebx
8010730b:	85 c0                	test   %eax,%eax
8010730d:	74 21                	je     80107330 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010730f:	83 ec 04             	sub    $0x4,%esp
80107312:	68 00 10 00 00       	push   $0x1000
80107317:	6a 00                	push   $0x0
80107319:	50                   	push   %eax
8010731a:	e8 a1 dc ff ff       	call   80104fc0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
8010731f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107325:	83 c4 10             	add    $0x10,%esp
80107328:	83 c8 07             	or     $0x7,%eax
8010732b:	89 07                	mov    %eax,(%edi)
8010732d:	eb b5                	jmp    801072e4 <walkpgdir+0x24>
8010732f:	90                   	nop
}
80107330:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80107333:	31 c0                	xor    %eax,%eax
}
80107335:	5b                   	pop    %ebx
80107336:	5e                   	pop    %esi
80107337:	5f                   	pop    %edi
80107338:	5d                   	pop    %ebp
80107339:	c3                   	ret    
8010733a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107340 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80107340:	55                   	push   %ebp
80107341:	89 e5                	mov    %esp,%ebp
80107343:	57                   	push   %edi
80107344:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107346:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
8010734a:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010734b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
80107350:	89 d6                	mov    %edx,%esi
{
80107352:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107353:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
80107359:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
8010735c:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010735f:	8b 45 08             	mov    0x8(%ebp),%eax
80107362:	29 f0                	sub    %esi,%eax
80107364:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107367:	eb 1f                	jmp    80107388 <mappages+0x48>
80107369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107370:	f6 00 01             	testb  $0x1,(%eax)
80107373:	75 45                	jne    801073ba <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107375:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107378:	83 cb 01             	or     $0x1,%ebx
8010737b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010737d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107380:	74 2e                	je     801073b0 <mappages+0x70>
      break;
    a += PGSIZE;
80107382:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107388:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010738b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107390:	89 f2                	mov    %esi,%edx
80107392:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107395:	89 f8                	mov    %edi,%eax
80107397:	e8 24 ff ff ff       	call   801072c0 <walkpgdir>
8010739c:	85 c0                	test   %eax,%eax
8010739e:	75 d0                	jne    80107370 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
801073a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073a8:	5b                   	pop    %ebx
801073a9:	5e                   	pop    %esi
801073aa:	5f                   	pop    %edi
801073ab:	5d                   	pop    %ebp
801073ac:	c3                   	ret    
801073ad:	8d 76 00             	lea    0x0(%esi),%esi
801073b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073b3:	31 c0                	xor    %eax,%eax
}
801073b5:	5b                   	pop    %ebx
801073b6:	5e                   	pop    %esi
801073b7:	5f                   	pop    %edi
801073b8:	5d                   	pop    %ebp
801073b9:	c3                   	ret    
      panic("remap");
801073ba:	83 ec 0c             	sub    $0xc,%esp
801073bd:	68 04 86 10 80       	push   $0x80108604
801073c2:	e8 c9 8f ff ff       	call   80100390 <panic>
801073c7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073ce:	66 90                	xchg   %ax,%ax

801073d0 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801073d0:	55                   	push   %ebp
801073d1:	89 e5                	mov    %esp,%ebp
801073d3:	57                   	push   %edi
801073d4:	56                   	push   %esi
801073d5:	89 c6                	mov    %eax,%esi
801073d7:	53                   	push   %ebx
801073d8:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
801073da:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
801073e0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
801073e6:	83 ec 1c             	sub    $0x1c,%esp
801073e9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
801073ec:	39 da                	cmp    %ebx,%edx
801073ee:	73 5b                	jae    8010744b <deallocuvm.part.0+0x7b>
801073f0:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801073f3:	89 d7                	mov    %edx,%edi
801073f5:	eb 14                	jmp    8010740b <deallocuvm.part.0+0x3b>
801073f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801073fe:	66 90                	xchg   %ax,%ax
80107400:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107406:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107409:	76 40                	jbe    8010744b <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010740b:	31 c9                	xor    %ecx,%ecx
8010740d:	89 fa                	mov    %edi,%edx
8010740f:	89 f0                	mov    %esi,%eax
80107411:	e8 aa fe ff ff       	call   801072c0 <walkpgdir>
80107416:	89 c3                	mov    %eax,%ebx
    if(!pte)
80107418:	85 c0                	test   %eax,%eax
8010741a:	74 44                	je     80107460 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
8010741c:	8b 00                	mov    (%eax),%eax
8010741e:	a8 01                	test   $0x1,%al
80107420:	74 de                	je     80107400 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
80107422:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107427:	74 47                	je     80107470 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107429:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010742c:	05 00 00 00 80       	add    $0x80000000,%eax
80107431:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
80107437:	50                   	push   %eax
80107438:	e8 13 b5 ff ff       	call   80102950 <kfree>
      *pte = 0;
8010743d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80107443:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
80107446:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107449:	77 c0                	ja     8010740b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
8010744b:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010744e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107451:	5b                   	pop    %ebx
80107452:	5e                   	pop    %esi
80107453:	5f                   	pop    %edi
80107454:	5d                   	pop    %ebp
80107455:	c3                   	ret    
80107456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010745d:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107460:	89 fa                	mov    %edi,%edx
80107462:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
80107468:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
8010746e:	eb 96                	jmp    80107406 <deallocuvm.part.0+0x36>
        panic("kfree");
80107470:	83 ec 0c             	sub    $0xc,%esp
80107473:	68 be 7e 10 80       	push   $0x80107ebe
80107478:	e8 13 8f ff ff       	call   80100390 <panic>
8010747d:	8d 76 00             	lea    0x0(%esi),%esi

80107480 <seginit>:
{
80107480:	f3 0f 1e fb          	endbr32 
80107484:	55                   	push   %ebp
80107485:	89 e5                	mov    %esp,%ebp
80107487:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010748a:	e8 21 ca ff ff       	call   80103eb0 <cpuid>
  pd[0] = size-1;
8010748f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107494:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010749a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010749e:	c7 80 b8 38 11 80 ff 	movl   $0xffff,-0x7feec748(%eax)
801074a5:	ff 00 00 
801074a8:	c7 80 bc 38 11 80 00 	movl   $0xcf9a00,-0x7feec744(%eax)
801074af:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801074b2:	c7 80 c0 38 11 80 ff 	movl   $0xffff,-0x7feec740(%eax)
801074b9:	ff 00 00 
801074bc:	c7 80 c4 38 11 80 00 	movl   $0xcf9200,-0x7feec73c(%eax)
801074c3:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801074c6:	c7 80 c8 38 11 80 ff 	movl   $0xffff,-0x7feec738(%eax)
801074cd:	ff 00 00 
801074d0:	c7 80 cc 38 11 80 00 	movl   $0xcffa00,-0x7feec734(%eax)
801074d7:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
801074da:	c7 80 d0 38 11 80 ff 	movl   $0xffff,-0x7feec730(%eax)
801074e1:	ff 00 00 
801074e4:	c7 80 d4 38 11 80 00 	movl   $0xcff200,-0x7feec72c(%eax)
801074eb:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
801074ee:	05 b0 38 11 80       	add    $0x801138b0,%eax
  pd[1] = (uint)p;
801074f3:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
801074f7:	c1 e8 10             	shr    $0x10,%eax
801074fa:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801074fe:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107501:	0f 01 10             	lgdtl  (%eax)
}
80107504:	c9                   	leave  
80107505:	c3                   	ret    
80107506:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010750d:	8d 76 00             	lea    0x0(%esi),%esi

80107510 <switchkvm>:
{
80107510:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107514:	a1 64 66 11 80       	mov    0x80116664,%eax
80107519:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010751e:	0f 22 d8             	mov    %eax,%cr3
}
80107521:	c3                   	ret    
80107522:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107530 <switchuvm>:
{
80107530:	f3 0f 1e fb          	endbr32 
80107534:	55                   	push   %ebp
80107535:	89 e5                	mov    %esp,%ebp
80107537:	57                   	push   %edi
80107538:	56                   	push   %esi
80107539:	53                   	push   %ebx
8010753a:	83 ec 1c             	sub    $0x1c,%esp
8010753d:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107540:	85 f6                	test   %esi,%esi
80107542:	0f 84 cb 00 00 00    	je     80107613 <switchuvm+0xe3>
  if(p->kstack == 0)
80107548:	8b 46 08             	mov    0x8(%esi),%eax
8010754b:	85 c0                	test   %eax,%eax
8010754d:	0f 84 da 00 00 00    	je     8010762d <switchuvm+0xfd>
  if(p->pgdir == 0)
80107553:	8b 46 04             	mov    0x4(%esi),%eax
80107556:	85 c0                	test   %eax,%eax
80107558:	0f 84 c2 00 00 00    	je     80107620 <switchuvm+0xf0>
  pushcli();
8010755e:	e8 4d d8 ff ff       	call   80104db0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107563:	e8 d8 c8 ff ff       	call   80103e40 <mycpu>
80107568:	89 c3                	mov    %eax,%ebx
8010756a:	e8 d1 c8 ff ff       	call   80103e40 <mycpu>
8010756f:	89 c7                	mov    %eax,%edi
80107571:	e8 ca c8 ff ff       	call   80103e40 <mycpu>
80107576:	83 c7 08             	add    $0x8,%edi
80107579:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010757c:	e8 bf c8 ff ff       	call   80103e40 <mycpu>
80107581:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107584:	ba 67 00 00 00       	mov    $0x67,%edx
80107589:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107590:	83 c0 08             	add    $0x8,%eax
80107593:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010759a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010759f:	83 c1 08             	add    $0x8,%ecx
801075a2:	c1 e8 18             	shr    $0x18,%eax
801075a5:	c1 e9 10             	shr    $0x10,%ecx
801075a8:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801075ae:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
801075b4:	b9 99 40 00 00       	mov    $0x4099,%ecx
801075b9:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801075c0:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
801075c5:	e8 76 c8 ff ff       	call   80103e40 <mycpu>
801075ca:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801075d1:	e8 6a c8 ff ff       	call   80103e40 <mycpu>
801075d6:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
801075da:	8b 5e 08             	mov    0x8(%esi),%ebx
801075dd:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801075e3:	e8 58 c8 ff ff       	call   80103e40 <mycpu>
801075e8:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801075eb:	e8 50 c8 ff ff       	call   80103e40 <mycpu>
801075f0:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
801075f4:	b8 28 00 00 00       	mov    $0x28,%eax
801075f9:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
801075fc:	8b 46 04             	mov    0x4(%esi),%eax
801075ff:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107604:	0f 22 d8             	mov    %eax,%cr3
}
80107607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010760a:	5b                   	pop    %ebx
8010760b:	5e                   	pop    %esi
8010760c:	5f                   	pop    %edi
8010760d:	5d                   	pop    %ebp
  popcli();
8010760e:	e9 ed d7 ff ff       	jmp    80104e00 <popcli>
    panic("switchuvm: no process");
80107613:	83 ec 0c             	sub    $0xc,%esp
80107616:	68 0a 86 10 80       	push   $0x8010860a
8010761b:	e8 70 8d ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
80107620:	83 ec 0c             	sub    $0xc,%esp
80107623:	68 35 86 10 80       	push   $0x80108635
80107628:	e8 63 8d ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
8010762d:	83 ec 0c             	sub    $0xc,%esp
80107630:	68 20 86 10 80       	push   $0x80108620
80107635:	e8 56 8d ff ff       	call   80100390 <panic>
8010763a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107640 <inituvm>:
{
80107640:	f3 0f 1e fb          	endbr32 
80107644:	55                   	push   %ebp
80107645:	89 e5                	mov    %esp,%ebp
80107647:	57                   	push   %edi
80107648:	56                   	push   %esi
80107649:	53                   	push   %ebx
8010764a:	83 ec 1c             	sub    $0x1c,%esp
8010764d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107650:	8b 75 10             	mov    0x10(%ebp),%esi
80107653:	8b 7d 08             	mov    0x8(%ebp),%edi
80107656:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107659:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010765f:	77 4b                	ja     801076ac <inituvm+0x6c>
  mem = kalloc();
80107661:	e8 aa b4 ff ff       	call   80102b10 <kalloc>
  memset(mem, 0, PGSIZE);
80107666:	83 ec 04             	sub    $0x4,%esp
80107669:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
8010766e:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107670:	6a 00                	push   $0x0
80107672:	50                   	push   %eax
80107673:	e8 48 d9 ff ff       	call   80104fc0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107678:	58                   	pop    %eax
80107679:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010767f:	5a                   	pop    %edx
80107680:	6a 06                	push   $0x6
80107682:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107687:	31 d2                	xor    %edx,%edx
80107689:	50                   	push   %eax
8010768a:	89 f8                	mov    %edi,%eax
8010768c:	e8 af fc ff ff       	call   80107340 <mappages>
  memmove(mem, init, sz);
80107691:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107694:	89 75 10             	mov    %esi,0x10(%ebp)
80107697:	83 c4 10             	add    $0x10,%esp
8010769a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010769d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
801076a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076a3:	5b                   	pop    %ebx
801076a4:	5e                   	pop    %esi
801076a5:	5f                   	pop    %edi
801076a6:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801076a7:	e9 b4 d9 ff ff       	jmp    80105060 <memmove>
    panic("inituvm: more than a page");
801076ac:	83 ec 0c             	sub    $0xc,%esp
801076af:	68 49 86 10 80       	push   $0x80108649
801076b4:	e8 d7 8c ff ff       	call   80100390 <panic>
801076b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801076c0 <loaduvm>:
{
801076c0:	f3 0f 1e fb          	endbr32 
801076c4:	55                   	push   %ebp
801076c5:	89 e5                	mov    %esp,%ebp
801076c7:	57                   	push   %edi
801076c8:	56                   	push   %esi
801076c9:	53                   	push   %ebx
801076ca:	83 ec 1c             	sub    $0x1c,%esp
801076cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801076d0:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
801076d3:	a9 ff 0f 00 00       	test   $0xfff,%eax
801076d8:	0f 85 99 00 00 00    	jne    80107777 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
801076de:	01 f0                	add    %esi,%eax
801076e0:	89 f3                	mov    %esi,%ebx
801076e2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
801076e5:	8b 45 14             	mov    0x14(%ebp),%eax
801076e8:	01 f0                	add    %esi,%eax
801076ea:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
801076ed:	85 f6                	test   %esi,%esi
801076ef:	75 15                	jne    80107706 <loaduvm+0x46>
801076f1:	eb 6d                	jmp    80107760 <loaduvm+0xa0>
801076f3:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801076f7:	90                   	nop
801076f8:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
801076fe:	89 f0                	mov    %esi,%eax
80107700:	29 d8                	sub    %ebx,%eax
80107702:	39 c6                	cmp    %eax,%esi
80107704:	76 5a                	jbe    80107760 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107706:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107709:	8b 45 08             	mov    0x8(%ebp),%eax
8010770c:	31 c9                	xor    %ecx,%ecx
8010770e:	29 da                	sub    %ebx,%edx
80107710:	e8 ab fb ff ff       	call   801072c0 <walkpgdir>
80107715:	85 c0                	test   %eax,%eax
80107717:	74 51                	je     8010776a <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
80107719:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010771b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
8010771e:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107723:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
80107728:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
8010772e:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107731:	29 d9                	sub    %ebx,%ecx
80107733:	05 00 00 00 80       	add    $0x80000000,%eax
80107738:	57                   	push   %edi
80107739:	51                   	push   %ecx
8010773a:	50                   	push   %eax
8010773b:	ff 75 10             	pushl  0x10(%ebp)
8010773e:	e8 dd a7 ff ff       	call   80101f20 <readi>
80107743:	83 c4 10             	add    $0x10,%esp
80107746:	39 f8                	cmp    %edi,%eax
80107748:	74 ae                	je     801076f8 <loaduvm+0x38>
}
8010774a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010774d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107752:	5b                   	pop    %ebx
80107753:	5e                   	pop    %esi
80107754:	5f                   	pop    %edi
80107755:	5d                   	pop    %ebp
80107756:	c3                   	ret    
80107757:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010775e:	66 90                	xchg   %ax,%ax
80107760:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107763:	31 c0                	xor    %eax,%eax
}
80107765:	5b                   	pop    %ebx
80107766:	5e                   	pop    %esi
80107767:	5f                   	pop    %edi
80107768:	5d                   	pop    %ebp
80107769:	c3                   	ret    
      panic("loaduvm: address should exist");
8010776a:	83 ec 0c             	sub    $0xc,%esp
8010776d:	68 63 86 10 80       	push   $0x80108663
80107772:	e8 19 8c ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107777:	83 ec 0c             	sub    $0xc,%esp
8010777a:	68 04 87 10 80       	push   $0x80108704
8010777f:	e8 0c 8c ff ff       	call   80100390 <panic>
80107784:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010778b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010778f:	90                   	nop

80107790 <allocuvm>:
{
80107790:	f3 0f 1e fb          	endbr32 
80107794:	55                   	push   %ebp
80107795:	89 e5                	mov    %esp,%ebp
80107797:	57                   	push   %edi
80107798:	56                   	push   %esi
80107799:	53                   	push   %ebx
8010779a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
8010779d:	8b 45 10             	mov    0x10(%ebp),%eax
{
801077a0:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
801077a3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801077a6:	85 c0                	test   %eax,%eax
801077a8:	0f 88 b2 00 00 00    	js     80107860 <allocuvm+0xd0>
  if(newsz < oldsz)
801077ae:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
801077b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
801077b4:	0f 82 96 00 00 00    	jb     80107850 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801077ba:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
801077c0:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
801077c6:	39 75 10             	cmp    %esi,0x10(%ebp)
801077c9:	77 40                	ja     8010780b <allocuvm+0x7b>
801077cb:	e9 83 00 00 00       	jmp    80107853 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
801077d0:	83 ec 04             	sub    $0x4,%esp
801077d3:	68 00 10 00 00       	push   $0x1000
801077d8:	6a 00                	push   $0x0
801077da:	50                   	push   %eax
801077db:	e8 e0 d7 ff ff       	call   80104fc0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801077e0:	58                   	pop    %eax
801077e1:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801077e7:	5a                   	pop    %edx
801077e8:	6a 06                	push   $0x6
801077ea:	b9 00 10 00 00       	mov    $0x1000,%ecx
801077ef:	89 f2                	mov    %esi,%edx
801077f1:	50                   	push   %eax
801077f2:	89 f8                	mov    %edi,%eax
801077f4:	e8 47 fb ff ff       	call   80107340 <mappages>
801077f9:	83 c4 10             	add    $0x10,%esp
801077fc:	85 c0                	test   %eax,%eax
801077fe:	78 78                	js     80107878 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107800:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107806:	39 75 10             	cmp    %esi,0x10(%ebp)
80107809:	76 48                	jbe    80107853 <allocuvm+0xc3>
    mem = kalloc();
8010780b:	e8 00 b3 ff ff       	call   80102b10 <kalloc>
80107810:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107812:	85 c0                	test   %eax,%eax
80107814:	75 ba                	jne    801077d0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107816:	83 ec 0c             	sub    $0xc,%esp
80107819:	68 81 86 10 80       	push   $0x80108681
8010781e:	e8 8d 8e ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107823:	8b 45 0c             	mov    0xc(%ebp),%eax
80107826:	83 c4 10             	add    $0x10,%esp
80107829:	39 45 10             	cmp    %eax,0x10(%ebp)
8010782c:	74 32                	je     80107860 <allocuvm+0xd0>
8010782e:	8b 55 10             	mov    0x10(%ebp),%edx
80107831:	89 c1                	mov    %eax,%ecx
80107833:	89 f8                	mov    %edi,%eax
80107835:	e8 96 fb ff ff       	call   801073d0 <deallocuvm.part.0>
      return 0;
8010783a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107841:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107844:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107847:	5b                   	pop    %ebx
80107848:	5e                   	pop    %esi
80107849:	5f                   	pop    %edi
8010784a:	5d                   	pop    %ebp
8010784b:	c3                   	ret    
8010784c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107850:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107853:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107856:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107859:	5b                   	pop    %ebx
8010785a:	5e                   	pop    %esi
8010785b:	5f                   	pop    %edi
8010785c:	5d                   	pop    %ebp
8010785d:	c3                   	ret    
8010785e:	66 90                	xchg   %ax,%ax
    return 0;
80107860:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107867:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010786a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010786d:	5b                   	pop    %ebx
8010786e:	5e                   	pop    %esi
8010786f:	5f                   	pop    %edi
80107870:	5d                   	pop    %ebp
80107871:	c3                   	ret    
80107872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107878:	83 ec 0c             	sub    $0xc,%esp
8010787b:	68 99 86 10 80       	push   $0x80108699
80107880:	e8 2b 8e ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107885:	8b 45 0c             	mov    0xc(%ebp),%eax
80107888:	83 c4 10             	add    $0x10,%esp
8010788b:	39 45 10             	cmp    %eax,0x10(%ebp)
8010788e:	74 0c                	je     8010789c <allocuvm+0x10c>
80107890:	8b 55 10             	mov    0x10(%ebp),%edx
80107893:	89 c1                	mov    %eax,%ecx
80107895:	89 f8                	mov    %edi,%eax
80107897:	e8 34 fb ff ff       	call   801073d0 <deallocuvm.part.0>
      kfree(mem);
8010789c:	83 ec 0c             	sub    $0xc,%esp
8010789f:	53                   	push   %ebx
801078a0:	e8 ab b0 ff ff       	call   80102950 <kfree>
      return 0;
801078a5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801078ac:	83 c4 10             	add    $0x10,%esp
}
801078af:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801078b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078b5:	5b                   	pop    %ebx
801078b6:	5e                   	pop    %esi
801078b7:	5f                   	pop    %edi
801078b8:	5d                   	pop    %ebp
801078b9:	c3                   	ret    
801078ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078c0 <deallocuvm>:
{
801078c0:	f3 0f 1e fb          	endbr32 
801078c4:	55                   	push   %ebp
801078c5:	89 e5                	mov    %esp,%ebp
801078c7:	8b 55 0c             	mov    0xc(%ebp),%edx
801078ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
801078cd:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801078d0:	39 d1                	cmp    %edx,%ecx
801078d2:	73 0c                	jae    801078e0 <deallocuvm+0x20>
}
801078d4:	5d                   	pop    %ebp
801078d5:	e9 f6 fa ff ff       	jmp    801073d0 <deallocuvm.part.0>
801078da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801078e0:	89 d0                	mov    %edx,%eax
801078e2:	5d                   	pop    %ebp
801078e3:	c3                   	ret    
801078e4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801078eb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801078ef:	90                   	nop

801078f0 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
801078f0:	f3 0f 1e fb          	endbr32 
801078f4:	55                   	push   %ebp
801078f5:	89 e5                	mov    %esp,%ebp
801078f7:	57                   	push   %edi
801078f8:	56                   	push   %esi
801078f9:	53                   	push   %ebx
801078fa:	83 ec 0c             	sub    $0xc,%esp
801078fd:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107900:	85 f6                	test   %esi,%esi
80107902:	74 55                	je     80107959 <freevm+0x69>
  if(newsz >= oldsz)
80107904:	31 c9                	xor    %ecx,%ecx
80107906:	ba 00 00 00 80       	mov    $0x80000000,%edx
8010790b:	89 f0                	mov    %esi,%eax
8010790d:	89 f3                	mov    %esi,%ebx
8010790f:	e8 bc fa ff ff       	call   801073d0 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107914:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
8010791a:	eb 0b                	jmp    80107927 <freevm+0x37>
8010791c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107920:	83 c3 04             	add    $0x4,%ebx
80107923:	39 df                	cmp    %ebx,%edi
80107925:	74 23                	je     8010794a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107927:	8b 03                	mov    (%ebx),%eax
80107929:	a8 01                	test   $0x1,%al
8010792b:	74 f3                	je     80107920 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010792d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107932:	83 ec 0c             	sub    $0xc,%esp
80107935:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107938:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010793d:	50                   	push   %eax
8010793e:	e8 0d b0 ff ff       	call   80102950 <kfree>
80107943:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107946:	39 df                	cmp    %ebx,%edi
80107948:	75 dd                	jne    80107927 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010794a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010794d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107950:	5b                   	pop    %ebx
80107951:	5e                   	pop    %esi
80107952:	5f                   	pop    %edi
80107953:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107954:	e9 f7 af ff ff       	jmp    80102950 <kfree>
    panic("freevm: no pgdir");
80107959:	83 ec 0c             	sub    $0xc,%esp
8010795c:	68 b5 86 10 80       	push   $0x801086b5
80107961:	e8 2a 8a ff ff       	call   80100390 <panic>
80107966:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010796d:	8d 76 00             	lea    0x0(%esi),%esi

80107970 <setupkvm>:
{
80107970:	f3 0f 1e fb          	endbr32 
80107974:	55                   	push   %ebp
80107975:	89 e5                	mov    %esp,%ebp
80107977:	56                   	push   %esi
80107978:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107979:	e8 92 b1 ff ff       	call   80102b10 <kalloc>
8010797e:	89 c6                	mov    %eax,%esi
80107980:	85 c0                	test   %eax,%eax
80107982:	74 42                	je     801079c6 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107984:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107987:	bb 40 b4 10 80       	mov    $0x8010b440,%ebx
  memset(pgdir, 0, PGSIZE);
8010798c:	68 00 10 00 00       	push   $0x1000
80107991:	6a 00                	push   $0x0
80107993:	50                   	push   %eax
80107994:	e8 27 d6 ff ff       	call   80104fc0 <memset>
80107999:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
8010799c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010799f:	83 ec 08             	sub    $0x8,%esp
801079a2:	8b 4b 08             	mov    0x8(%ebx),%ecx
801079a5:	ff 73 0c             	pushl  0xc(%ebx)
801079a8:	8b 13                	mov    (%ebx),%edx
801079aa:	50                   	push   %eax
801079ab:	29 c1                	sub    %eax,%ecx
801079ad:	89 f0                	mov    %esi,%eax
801079af:	e8 8c f9 ff ff       	call   80107340 <mappages>
801079b4:	83 c4 10             	add    $0x10,%esp
801079b7:	85 c0                	test   %eax,%eax
801079b9:	78 15                	js     801079d0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801079bb:	83 c3 10             	add    $0x10,%ebx
801079be:	81 fb 80 b4 10 80    	cmp    $0x8010b480,%ebx
801079c4:	75 d6                	jne    8010799c <setupkvm+0x2c>
}
801079c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801079c9:	89 f0                	mov    %esi,%eax
801079cb:	5b                   	pop    %ebx
801079cc:	5e                   	pop    %esi
801079cd:	5d                   	pop    %ebp
801079ce:	c3                   	ret    
801079cf:	90                   	nop
      freevm(pgdir);
801079d0:	83 ec 0c             	sub    $0xc,%esp
801079d3:	56                   	push   %esi
      return 0;
801079d4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801079d6:	e8 15 ff ff ff       	call   801078f0 <freevm>
      return 0;
801079db:	83 c4 10             	add    $0x10,%esp
}
801079de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801079e1:	89 f0                	mov    %esi,%eax
801079e3:	5b                   	pop    %ebx
801079e4:	5e                   	pop    %esi
801079e5:	5d                   	pop    %ebp
801079e6:	c3                   	ret    
801079e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079ee:	66 90                	xchg   %ax,%ax

801079f0 <kvmalloc>:
{
801079f0:	f3 0f 1e fb          	endbr32 
801079f4:	55                   	push   %ebp
801079f5:	89 e5                	mov    %esp,%ebp
801079f7:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
801079fa:	e8 71 ff ff ff       	call   80107970 <setupkvm>
801079ff:	a3 64 66 11 80       	mov    %eax,0x80116664
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107a04:	05 00 00 00 80       	add    $0x80000000,%eax
80107a09:	0f 22 d8             	mov    %eax,%cr3
}
80107a0c:	c9                   	leave  
80107a0d:	c3                   	ret    
80107a0e:	66 90                	xchg   %ax,%ax

80107a10 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107a10:	f3 0f 1e fb          	endbr32 
80107a14:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107a15:	31 c9                	xor    %ecx,%ecx
{
80107a17:	89 e5                	mov    %esp,%ebp
80107a19:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107a1c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107a1f:	8b 45 08             	mov    0x8(%ebp),%eax
80107a22:	e8 99 f8 ff ff       	call   801072c0 <walkpgdir>
  if(pte == 0)
80107a27:	85 c0                	test   %eax,%eax
80107a29:	74 05                	je     80107a30 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107a2b:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107a2e:	c9                   	leave  
80107a2f:	c3                   	ret    
    panic("clearpteu");
80107a30:	83 ec 0c             	sub    $0xc,%esp
80107a33:	68 c6 86 10 80       	push   $0x801086c6
80107a38:	e8 53 89 ff ff       	call   80100390 <panic>
80107a3d:	8d 76 00             	lea    0x0(%esi),%esi

80107a40 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107a40:	f3 0f 1e fb          	endbr32 
80107a44:	55                   	push   %ebp
80107a45:	89 e5                	mov    %esp,%ebp
80107a47:	57                   	push   %edi
80107a48:	56                   	push   %esi
80107a49:	53                   	push   %ebx
80107a4a:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107a4d:	e8 1e ff ff ff       	call   80107970 <setupkvm>
80107a52:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107a55:	85 c0                	test   %eax,%eax
80107a57:	0f 84 9b 00 00 00    	je     80107af8 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107a5d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107a60:	85 c9                	test   %ecx,%ecx
80107a62:	0f 84 90 00 00 00    	je     80107af8 <copyuvm+0xb8>
80107a68:	31 f6                	xor    %esi,%esi
80107a6a:	eb 46                	jmp    80107ab2 <copyuvm+0x72>
80107a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107a70:	83 ec 04             	sub    $0x4,%esp
80107a73:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107a79:	68 00 10 00 00       	push   $0x1000
80107a7e:	57                   	push   %edi
80107a7f:	50                   	push   %eax
80107a80:	e8 db d5 ff ff       	call   80105060 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107a85:	58                   	pop    %eax
80107a86:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a8c:	5a                   	pop    %edx
80107a8d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107a90:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a95:	89 f2                	mov    %esi,%edx
80107a97:	50                   	push   %eax
80107a98:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107a9b:	e8 a0 f8 ff ff       	call   80107340 <mappages>
80107aa0:	83 c4 10             	add    $0x10,%esp
80107aa3:	85 c0                	test   %eax,%eax
80107aa5:	78 61                	js     80107b08 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107aa7:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107aad:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107ab0:	76 46                	jbe    80107af8 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107ab2:	8b 45 08             	mov    0x8(%ebp),%eax
80107ab5:	31 c9                	xor    %ecx,%ecx
80107ab7:	89 f2                	mov    %esi,%edx
80107ab9:	e8 02 f8 ff ff       	call   801072c0 <walkpgdir>
80107abe:	85 c0                	test   %eax,%eax
80107ac0:	74 61                	je     80107b23 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107ac2:	8b 00                	mov    (%eax),%eax
80107ac4:	a8 01                	test   $0x1,%al
80107ac6:	74 4e                	je     80107b16 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107ac8:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107aca:	25 ff 0f 00 00       	and    $0xfff,%eax
80107acf:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107ad2:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107ad8:	e8 33 b0 ff ff       	call   80102b10 <kalloc>
80107add:	89 c3                	mov    %eax,%ebx
80107adf:	85 c0                	test   %eax,%eax
80107ae1:	75 8d                	jne    80107a70 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107ae3:	83 ec 0c             	sub    $0xc,%esp
80107ae6:	ff 75 e0             	pushl  -0x20(%ebp)
80107ae9:	e8 02 fe ff ff       	call   801078f0 <freevm>
  return 0;
80107aee:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107af5:	83 c4 10             	add    $0x10,%esp
}
80107af8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107afb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107afe:	5b                   	pop    %ebx
80107aff:	5e                   	pop    %esi
80107b00:	5f                   	pop    %edi
80107b01:	5d                   	pop    %ebp
80107b02:	c3                   	ret    
80107b03:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b07:	90                   	nop
      kfree(mem);
80107b08:	83 ec 0c             	sub    $0xc,%esp
80107b0b:	53                   	push   %ebx
80107b0c:	e8 3f ae ff ff       	call   80102950 <kfree>
      goto bad;
80107b11:	83 c4 10             	add    $0x10,%esp
80107b14:	eb cd                	jmp    80107ae3 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107b16:	83 ec 0c             	sub    $0xc,%esp
80107b19:	68 ea 86 10 80       	push   $0x801086ea
80107b1e:	e8 6d 88 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107b23:	83 ec 0c             	sub    $0xc,%esp
80107b26:	68 d0 86 10 80       	push   $0x801086d0
80107b2b:	e8 60 88 ff ff       	call   80100390 <panic>

80107b30 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107b30:	f3 0f 1e fb          	endbr32 
80107b34:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107b35:	31 c9                	xor    %ecx,%ecx
{
80107b37:	89 e5                	mov    %esp,%ebp
80107b39:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107b3c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b3f:	8b 45 08             	mov    0x8(%ebp),%eax
80107b42:	e8 79 f7 ff ff       	call   801072c0 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107b47:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107b49:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107b4a:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b4c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107b51:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107b54:	05 00 00 00 80       	add    $0x80000000,%eax
80107b59:	83 fa 05             	cmp    $0x5,%edx
80107b5c:	ba 00 00 00 00       	mov    $0x0,%edx
80107b61:	0f 45 c2             	cmovne %edx,%eax
}
80107b64:	c3                   	ret    
80107b65:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107b70 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107b70:	f3 0f 1e fb          	endbr32 
80107b74:	55                   	push   %ebp
80107b75:	89 e5                	mov    %esp,%ebp
80107b77:	57                   	push   %edi
80107b78:	56                   	push   %esi
80107b79:	53                   	push   %ebx
80107b7a:	83 ec 0c             	sub    $0xc,%esp
80107b7d:	8b 75 14             	mov    0x14(%ebp),%esi
80107b80:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107b83:	85 f6                	test   %esi,%esi
80107b85:	75 3c                	jne    80107bc3 <copyout+0x53>
80107b87:	eb 67                	jmp    80107bf0 <copyout+0x80>
80107b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107b90:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b93:	89 fb                	mov    %edi,%ebx
80107b95:	29 d3                	sub    %edx,%ebx
80107b97:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107b9d:	39 f3                	cmp    %esi,%ebx
80107b9f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107ba2:	29 fa                	sub    %edi,%edx
80107ba4:	83 ec 04             	sub    $0x4,%esp
80107ba7:	01 c2                	add    %eax,%edx
80107ba9:	53                   	push   %ebx
80107baa:	ff 75 10             	pushl  0x10(%ebp)
80107bad:	52                   	push   %edx
80107bae:	e8 ad d4 ff ff       	call   80105060 <memmove>
    len -= n;
    buf += n;
80107bb3:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107bb6:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107bbc:	83 c4 10             	add    $0x10,%esp
80107bbf:	29 de                	sub    %ebx,%esi
80107bc1:	74 2d                	je     80107bf0 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107bc3:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107bc5:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107bc8:	89 55 0c             	mov    %edx,0xc(%ebp)
80107bcb:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107bd1:	57                   	push   %edi
80107bd2:	ff 75 08             	pushl  0x8(%ebp)
80107bd5:	e8 56 ff ff ff       	call   80107b30 <uva2ka>
    if(pa0 == 0)
80107bda:	83 c4 10             	add    $0x10,%esp
80107bdd:	85 c0                	test   %eax,%eax
80107bdf:	75 af                	jne    80107b90 <copyout+0x20>
  }
  return 0;
}
80107be1:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107be4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107be9:	5b                   	pop    %ebx
80107bea:	5e                   	pop    %esi
80107beb:	5f                   	pop    %edi
80107bec:	5d                   	pop    %ebp
80107bed:	c3                   	ret    
80107bee:	66 90                	xchg   %ax,%ax
80107bf0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107bf3:	31 c0                	xor    %eax,%eax
}
80107bf5:	5b                   	pop    %ebx
80107bf6:	5e                   	pop    %esi
80107bf7:	5f                   	pop    %edi
80107bf8:	5d                   	pop    %ebp
80107bf9:	c3                   	ret    
