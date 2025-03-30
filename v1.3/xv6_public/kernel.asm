
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
80100028:	bc f0 c5 10 80       	mov    $0x8010c5f0,%esp

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
80100048:	bb 34 c6 10 80       	mov    $0x8010c634,%ebx
{
8010004d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
80100050:	68 a0 7e 10 80       	push   $0x80107ea0
80100055:	68 00 c6 10 80       	push   $0x8010c600
8010005a:	e8 c1 4e 00 00       	call   80104f20 <initlock>
  bcache.head.next = &bcache.head;
8010005f:	83 c4 10             	add    $0x10,%esp
80100062:	b8 fc 0c 11 80       	mov    $0x80110cfc,%eax
  bcache.head.prev = &bcache.head;
80100067:	c7 05 4c 0d 11 80 fc 	movl   $0x80110cfc,0x80110d4c
8010006e:	0c 11 80 
  bcache.head.next = &bcache.head;
80100071:	c7 05 50 0d 11 80 fc 	movl   $0x80110cfc,0x80110d50
80100078:	0c 11 80 
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
8010008b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 a7 7e 10 80       	push   $0x80107ea7
80100097:	50                   	push   %eax
80100098:	e8 43 4d 00 00       	call   80104de0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 50 0d 11 80       	mov    0x80110d50,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb a0 0a 11 80    	cmp    $0x80110aa0,%ebx
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
801000e3:	68 00 c6 10 80       	push   $0x8010c600
801000e8:	e8 b3 4f 00 00       	call   801050a0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000ed:	8b 1d 50 0d 11 80    	mov    0x80110d50,%ebx
801000f3:	83 c4 10             	add    $0x10,%esp
801000f6:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
801000fc:	75 0d                	jne    8010010b <bread+0x3b>
801000fe:	eb 20                	jmp    80100120 <bread+0x50>
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
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
80100120:	8b 1d 4c 0d 11 80    	mov    0x80110d4c,%ebx
80100126:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 70                	jmp    801001a0 <bread+0xd0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb fc 0c 11 80    	cmp    $0x80110cfc,%ebx
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
8010015d:	68 00 c6 10 80       	push   $0x8010c600
80100162:	e8 f9 4f 00 00       	call   80105160 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ae 4c 00 00       	call   80104e20 <acquiresleep>
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
801001a3:	68 ae 7e 10 80       	push   $0x80107eae
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
801001c2:	e8 f9 4c 00 00       	call   80104ec0 <holdingsleep>
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
801001e0:	68 bf 7e 10 80       	push   $0x80107ebf
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
80100203:	e8 b8 4c 00 00       	call   80104ec0 <holdingsleep>
80100208:	83 c4 10             	add    $0x10,%esp
8010020b:	85 c0                	test   %eax,%eax
8010020d:	74 66                	je     80100275 <brelse+0x85>
    panic("brelse");

  releasesleep(&b->lock);
8010020f:	83 ec 0c             	sub    $0xc,%esp
80100212:	56                   	push   %esi
80100213:	e8 68 4c 00 00       	call   80104e80 <releasesleep>

  acquire(&bcache.lock);
80100218:	c7 04 24 00 c6 10 80 	movl   $0x8010c600,(%esp)
8010021f:	e8 7c 4e 00 00       	call   801050a0 <acquire>
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
80100246:	a1 50 0d 11 80       	mov    0x80110d50,%eax
    b->prev = &bcache.head;
8010024b:	c7 43 50 fc 0c 11 80 	movl   $0x80110cfc,0x50(%ebx)
    b->next = bcache.head.next;
80100252:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100255:	a1 50 0d 11 80       	mov    0x80110d50,%eax
8010025a:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
8010025d:	89 1d 50 0d 11 80    	mov    %ebx,0x80110d50
  }
  
  release(&bcache.lock);
80100263:	c7 45 08 00 c6 10 80 	movl   $0x8010c600,0x8(%ebp)
}
8010026a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010026d:	5b                   	pop    %ebx
8010026e:	5e                   	pop    %esi
8010026f:	5d                   	pop    %ebp
  release(&bcache.lock);
80100270:	e9 eb 4e 00 00       	jmp    80105160 <release>
    panic("brelse");
80100275:	83 ec 0c             	sub    $0xc,%esp
80100278:	68 c6 7e 10 80       	push   $0x80107ec6
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
801002aa:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
801002b1:	e8 ea 4d 00 00       	call   801050a0 <acquire>
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
801002c6:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002cb:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002d1:	74 27                	je     801002fa <consoleread+0x6a>
801002d3:	eb 5b                	jmp    80100330 <consoleread+0xa0>
801002d5:	8d 76 00             	lea    0x0(%esi),%esi
            sleep(&input.r, &cons.lock);
801002d8:	83 ec 08             	sub    $0x8,%esp
801002db:	68 40 b5 10 80       	push   $0x8010b540
801002e0:	68 e0 0f 11 80       	push   $0x80110fe0
801002e5:	e8 46 45 00 00       	call   80104830 <sleep>
        while(input.r == input.w){
801002ea:	a1 e0 0f 11 80       	mov    0x80110fe0,%eax
801002ef:	83 c4 10             	add    $0x10,%esp
801002f2:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
801002f8:	75 36                	jne    80100330 <consoleread+0xa0>
            if(myproc()->killed){
801002fa:	e8 91 3b 00 00       	call   80103e90 <myproc>
801002ff:	8b 48 28             	mov    0x28(%eax),%ecx
80100302:	85 c9                	test   %ecx,%ecx
80100304:	74 d2                	je     801002d8 <consoleread+0x48>
                release(&cons.lock);
80100306:	83 ec 0c             	sub    $0xc,%esp
80100309:	68 40 b5 10 80       	push   $0x8010b540
8010030e:	e8 4d 4e 00 00       	call   80105160 <release>
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
80100333:	89 15 e0 0f 11 80    	mov    %edx,0x80110fe0
80100339:	89 c2                	mov    %eax,%edx
8010033b:	83 e2 7f             	and    $0x7f,%edx
8010033e:	0f be 8a 60 0f 11 80 	movsbl -0x7feef0a0(%edx),%ecx
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
80100360:	68 40 b5 10 80       	push   $0x8010b540
80100365:	e8 f6 4d 00 00       	call   80105160 <release>
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
80100386:	a3 e0 0f 11 80       	mov    %eax,0x80110fe0
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
8010039d:	c7 05 74 b5 10 80 00 	movl   $0x0,0x8010b574
801003a4:	00 00 00 
    getcallerpcs(&s, pcs);
801003a7:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003aa:	8d 75 f8             	lea    -0x8(%ebp),%esi
    cprintf("lapicid %d: panic: ", lapicid());
801003ad:	e8 ce 29 00 00       	call   80102d80 <lapicid>
801003b2:	83 ec 08             	sub    $0x8,%esp
801003b5:	50                   	push   %eax
801003b6:	68 cd 7e 10 80       	push   $0x80107ecd
801003bb:	e8 f0 02 00 00       	call   801006b0 <cprintf>
    cprintf(s);
801003c0:	58                   	pop    %eax
801003c1:	ff 75 08             	pushl  0x8(%ebp)
801003c4:	e8 e7 02 00 00       	call   801006b0 <cprintf>
    cprintf("\n");
801003c9:	c7 04 24 7d 84 10 80 	movl   $0x8010847d,(%esp)
801003d0:	e8 db 02 00 00       	call   801006b0 <cprintf>
    getcallerpcs(&s, pcs);
801003d5:	8d 45 08             	lea    0x8(%ebp),%eax
801003d8:	5a                   	pop    %edx
801003d9:	59                   	pop    %ecx
801003da:	53                   	push   %ebx
801003db:	50                   	push   %eax
801003dc:	e8 5f 4b 00 00       	call   80104f40 <getcallerpcs>
    for(i=0; i<10; i++)
801003e1:	83 c4 10             	add    $0x10,%esp
        cprintf(" %p", pcs[i]);
801003e4:	83 ec 08             	sub    $0x8,%esp
801003e7:	ff 33                	pushl  (%ebx)
801003e9:	83 c3 04             	add    $0x4,%ebx
801003ec:	68 e1 7e 10 80       	push   $0x80107ee1
801003f1:	e8 ba 02 00 00       	call   801006b0 <cprintf>
    for(i=0; i<10; i++)
801003f6:	83 c4 10             	add    $0x10,%esp
801003f9:	39 f3                	cmp    %esi,%ebx
801003fb:	75 e7                	jne    801003e4 <panic+0x54>
    panicked = 1; // freeze other CPU
801003fd:	c7 05 78 b5 10 80 01 	movl   $0x1,0x8010b578
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
8010042a:	e8 61 66 00 00       	call   80106a90 <uartputc>
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
80100515:	e8 76 65 00 00       	call   80106a90 <uartputc>
8010051a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100521:	e8 6a 65 00 00       	call   80106a90 <uartputc>
80100526:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
8010052d:	e8 5e 65 00 00       	call   80106a90 <uartputc>
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
80100561:	e8 ea 4c 00 00       	call   80105250 <memmove>
        memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100566:	b8 80 07 00 00       	mov    $0x780,%eax
8010056b:	83 c4 0c             	add    $0xc,%esp
8010056e:	29 d8                	sub    %ebx,%eax
80100570:	01 c0                	add    %eax,%eax
80100572:	50                   	push   %eax
80100573:	6a 00                	push   $0x0
80100575:	56                   	push   %esi
80100576:	e8 35 4c 00 00       	call   801051b0 <memset>
8010057b:	88 5d e7             	mov    %bl,-0x19(%ebp)
8010057e:	83 c4 10             	add    $0x10,%esp
80100581:	e9 22 ff ff ff       	jmp    801004a8 <consputc.part.0+0x98>
        panic("pos under/overflow");
80100586:	83 ec 0c             	sub    $0xc,%esp
80100589:	68 e5 7e 10 80       	push   $0x80107ee5
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
801005c9:	0f b6 92 68 7f 10 80 	movzbl -0x7fef8098(%edx),%edx
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
80100603:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
80100658:	c7 04 24 40 b5 10 80 	movl   $0x8010b540,(%esp)
8010065f:	e8 3c 4a 00 00       	call   801050a0 <acquire>
    for(i = 0; i < n; i++)
80100664:	83 c4 10             	add    $0x10,%esp
80100667:	85 db                	test   %ebx,%ebx
80100669:	7e 24                	jle    8010068f <consolewrite+0x4f>
8010066b:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010066e:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
    if(panicked){
80100671:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
80100692:	68 40 b5 10 80       	push   $0x8010b540
80100697:	e8 c4 4a 00 00       	call   80105160 <release>
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
801006bd:	a1 74 b5 10 80       	mov    0x8010b574,%eax
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
801006ec:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
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
8010077d:	bb f8 7e 10 80       	mov    $0x80107ef8,%ebx
                for(; *s; s++)
80100782:	b8 28 00 00 00       	mov    $0x28,%eax
    if(panicked){
80100787:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
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
801007b8:	68 40 b5 10 80       	push   $0x8010b540
801007bd:	e8 de 48 00 00       	call   801050a0 <acquire>
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
801007e0:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
801007e6:	85 ff                	test   %edi,%edi
801007e8:	0f 84 12 ff ff ff    	je     80100700 <cprintf+0x50>
801007ee:	fa                   	cli    
        for(;;)
801007ef:	eb fe                	jmp    801007ef <cprintf+0x13f>
801007f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(panicked){
801007f8:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
801007fe:	85 c9                	test   %ecx,%ecx
80100800:	74 06                	je     80100808 <cprintf+0x158>
80100802:	fa                   	cli    
        for(;;)
80100803:	eb fe                	jmp    80100803 <cprintf+0x153>
80100805:	8d 76 00             	lea    0x0(%esi),%esi
80100808:	b8 25 00 00 00       	mov    $0x25,%eax
8010080d:	e8 fe fb ff ff       	call   80100410 <consputc.part.0>
    if(panicked){
80100812:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
80100818:	85 d2                	test   %edx,%edx
8010081a:	74 2c                	je     80100848 <cprintf+0x198>
8010081c:	fa                   	cli    
        for(;;)
8010081d:	eb fe                	jmp    8010081d <cprintf+0x16d>
8010081f:	90                   	nop
        release(&cons.lock);
80100820:	83 ec 0c             	sub    $0xc,%esp
80100823:	68 40 b5 10 80       	push   $0x8010b540
80100828:	e8 33 49 00 00       	call   80105160 <release>
8010082d:	83 c4 10             	add    $0x10,%esp
}
80100830:	e9 ee fe ff ff       	jmp    80100723 <cprintf+0x73>
        panic("null fmt");
80100835:	83 ec 0c             	sub    $0xc,%esp
80100838:	68 ff 7e 10 80       	push   $0x80107eff
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
80100b72:	68 40 b5 10 80       	push   $0x8010b540
{
80100b77:	89 45 d8             	mov    %eax,-0x28(%ebp)
    acquire(&cons.lock);
80100b7a:	e8 21 45 00 00       	call   801050a0 <acquire>
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
80100ba1:	3e ff 24 85 10 7f 10 	notrack jmp *-0x7fef80f0(,%eax,4)
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
80100bba:	68 40 b5 10 80       	push   $0x8010b540
80100bbf:	e8 9c 45 00 00       	call   80105160 <release>
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
80100be1:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100be6:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100bec:	74 94                	je     80100b82 <consoleintr+0x22>
                      input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100bee:	83 e8 01             	sub    $0x1,%eax
80100bf1:	89 c2                	mov    %eax,%edx
80100bf3:	83 e2 7f             	and    $0x7f,%edx
                while(input.e != input.w &&
80100bf6:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
80100bfd:	74 83                	je     80100b82 <consoleintr+0x22>
    if(panicked){
80100bff:	8b 3d 78 b5 10 80    	mov    0x8010b578,%edi
                    input.e--;
80100c05:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
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
80100c2e:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
80100c33:	3b 05 e4 0f 11 80    	cmp    0x80110fe4,%eax
80100c39:	0f 84 43 ff ff ff    	je     80100b82 <consoleintr+0x22>
    if(panicked){
80100c3f:	8b 35 78 b5 10 80    	mov    0x8010b578,%esi
                    input.e--;
80100c45:	83 e8 01             	sub    $0x1,%eax
80100c48:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
    if(panicked){
80100c4d:	85 f6                	test   %esi,%esi
80100c4f:	0f 84 fc 01 00 00    	je     80100e51 <consoleintr+0x2f1>
80100c55:	fa                   	cli    
        for(;;)
80100c56:	eb fe                	jmp    80100c56 <consoleintr+0xf6>
                while( input.e != input.w &&input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100c58:	a1 e4 0f 11 80       	mov    0x80110fe4,%eax
80100c5d:	8b 3d 20 b5 10 80    	mov    0x8010b520,%edi
80100c63:	31 c9                	xor    %ecx,%ecx
80100c65:	8b 35 e8 0f 11 80    	mov    0x80110fe8,%esi
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
80100ceb:	80 ba 60 0f 11 80 0a 	cmpb   $0xa,-0x7feef0a0(%edx)
80100cf2:	75 8a                	jne    80100c7e <consoleintr+0x11e>
80100cf4:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100cf7:	84 c9                	test   %cl,%cl
80100cf9:	74 08                	je     80100d03 <consoleintr+0x1a3>
80100cfb:	a3 e8 0f 11 80       	mov    %eax,0x80110fe8
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
80100d54:	a3 20 b5 10 80       	mov    %eax,0x8010b520
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
80100dd2:	8b 15 e8 0f 11 80    	mov    0x80110fe8,%edx
80100dd8:	8b 0d e0 0f 11 80    	mov    0x80110fe0,%ecx
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
80100e0d:	8b 0d 20 b5 10 80    	mov    0x8010b520,%ecx
80100e13:	85 c9                	test   %ecx,%ecx
80100e15:	0f 85 a7 00 00 00    	jne    80100ec2 <consoleintr+0x362>
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e1b:	8d 4a 01             	lea    0x1(%edx),%ecx
80100e1e:	83 e2 7f             	and    $0x7f,%edx
80100e21:	88 82 60 0f 11 80    	mov    %al,-0x7feef0a0(%edx)
    if(panicked){
80100e27:	8b 15 78 b5 10 80    	mov    0x8010b578,%edx
                            input.buf[input.e++ % INPUT_BUF] = c;
80100e2d:	89 0d e8 0f 11 80    	mov    %ecx,0x80110fe8
    if(panicked){
80100e33:	85 d2                	test   %edx,%edx
80100e35:	0f 84 99 00 00 00    	je     80100ed4 <consoleintr+0x374>
  asm volatile("cli");
80100e3b:	fa                   	cli    
        for(;;)
80100e3c:	eb fe                	jmp    80100e3c <consoleintr+0x2dc>
80100e3e:	66 90                	xchg   %ax,%ax
80100e40:	89 35 e8 0f 11 80    	mov    %esi,0x80110fe8
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
80100e70:	88 8a 60 0f 11 80    	mov    %cl,-0x7feef0a0(%edx)
    if(panicked){
80100e76:	8b 0d 78 b5 10 80    	mov    0x8010b578,%ecx
                        input.buf[input.e++ % INPUT_BUF] = c;
80100e7c:	89 35 e8 0f 11 80    	mov    %esi,0x80110fe8
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
80100e98:	a1 e8 0f 11 80       	mov    0x80110fe8,%eax
                        number_of_left_moves =0;
80100e9d:	c7 05 20 b5 10 80 00 	movl   $0x0,0x8010b520
80100ea4:	00 00 00 
                        wakeup(&input.r);
80100ea7:	68 e0 0f 11 80       	push   $0x80110fe0
                        input.w = input.e;
80100eac:	a3 e4 0f 11 80       	mov    %eax,0x80110fe4
                        wakeup(&input.r);
80100eb1:	e8 3a 3b 00 00       	call   801049f0 <wakeup>
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
80100ee5:	e9 06 3c 00 00       	jmp    80104af0 <procdump>
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
80100efa:	68 08 7f 10 80       	push   $0x80107f08
80100eff:	68 40 b5 10 80       	push   $0x8010b540
80100f04:	e8 17 40 00 00       	call   80104f20 <initlock>

    devsw[CONSOLE].write = consolewrite;
    devsw[CONSOLE].read = consoleread;
    cons.locking = 1;

    ioapicenable(IRQ_KBD, 0);
80100f09:	58                   	pop    %eax
80100f0a:	5a                   	pop    %edx
80100f0b:	6a 00                	push   $0x0
80100f0d:	6a 01                	push   $0x1
    devsw[CONSOLE].write = consolewrite;
80100f0f:	c7 05 ac 19 11 80 40 	movl   $0x80100640,0x801119ac
80100f16:	06 10 80 
    devsw[CONSOLE].read = consoleread;
80100f19:	c7 05 a8 19 11 80 90 	movl   $0x80100290,0x801119a8
80100f20:	02 10 80 
    cons.locking = 1;
80100f23:	c7 05 74 b5 10 80 01 	movl   $0x1,0x8010b574
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
80100f50:	e8 3b 2f 00 00       	call   80103e90 <myproc>
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
80100fcc:	e8 2f 6c 00 00       	call   80107c00 <setupkvm>
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
80101033:	e8 e8 69 00 00       	call   80107a20 <allocuvm>
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
80101069:	e8 e2 68 00 00       	call   80107950 <loaduvm>
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
801010ab:	e8 d0 6a 00 00       	call   80107b80 <freevm>
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
801010f2:	e8 29 69 00 00       	call   80107a20 <allocuvm>
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
80101113:	e8 88 6b 00 00       	call   80107ca0 <clearpteu>
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
80101163:	e8 48 42 00 00       	call   801053b0 <strlen>
80101168:	f7 d0                	not    %eax
8010116a:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010116c:	58                   	pop    %eax
8010116d:	8b 45 0c             	mov    0xc(%ebp),%eax
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101170:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101173:	ff 34 b8             	pushl  (%eax,%edi,4)
80101176:	e8 35 42 00 00       	call   801053b0 <strlen>
8010117b:	83 c0 01             	add    $0x1,%eax
8010117e:	50                   	push   %eax
8010117f:	8b 45 0c             	mov    0xc(%ebp),%eax
80101182:	ff 34 b8             	pushl  (%eax,%edi,4)
80101185:	53                   	push   %ebx
80101186:	56                   	push   %esi
80101187:	e8 74 6c 00 00       	call   80107e00 <copyout>
8010118c:	83 c4 20             	add    $0x20,%esp
8010118f:	85 c0                	test   %eax,%eax
80101191:	79 ad                	jns    80101140 <exec+0x200>
80101193:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101197:	90                   	nop
    freevm(pgdir);
80101198:	83 ec 0c             	sub    $0xc,%esp
8010119b:	ff b5 f4 fe ff ff    	pushl  -0x10c(%ebp)
801011a1:	e8 da 69 00 00       	call   80107b80 <freevm>
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
801011f3:	e8 08 6c 00 00       	call   80107e00 <copyout>
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
80101231:	e8 3a 41 00 00       	call   80105370 <safestrcpy>
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
8010125d:	e8 5e 65 00 00       	call   801077c0 <switchuvm>
  freevm(oldpgdir);
80101262:	89 3c 24             	mov    %edi,(%esp)
80101265:	e8 16 69 00 00       	call   80107b80 <freevm>
  return 0;
8010126a:	83 c4 10             	add    $0x10,%esp
8010126d:	31 c0                	xor    %eax,%eax
8010126f:	e9 3c fd ff ff       	jmp    80100fb0 <exec+0x70>
    end_op();
80101274:	e8 07 20 00 00       	call   80103280 <end_op>
    cprintf("exec: fail\n");
80101279:	83 ec 0c             	sub    $0xc,%esp
8010127c:	68 79 7f 10 80       	push   $0x80107f79
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
801012aa:	68 85 7f 10 80       	push   $0x80107f85
801012af:	68 00 10 11 80       	push   $0x80111000
801012b4:	e8 67 3c 00 00       	call   80104f20 <initlock>
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
801012c8:	bb 34 10 11 80       	mov    $0x80111034,%ebx
{
801012cd:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801012d0:	68 00 10 11 80       	push   $0x80111000
801012d5:	e8 c6 3d 00 00       	call   801050a0 <acquire>
801012da:	83 c4 10             	add    $0x10,%esp
801012dd:	eb 0c                	jmp    801012eb <filealloc+0x2b>
801012df:	90                   	nop
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801012e0:	83 c3 18             	add    $0x18,%ebx
801012e3:	81 fb 94 19 11 80    	cmp    $0x80111994,%ebx
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
801012fc:	68 00 10 11 80       	push   $0x80111000
80101301:	e8 5a 3e 00 00       	call   80105160 <release>
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
80101315:	68 00 10 11 80       	push   $0x80111000
8010131a:	e8 41 3e 00 00       	call   80105160 <release>
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
8010133e:	68 00 10 11 80       	push   $0x80111000
80101343:	e8 58 3d 00 00       	call   801050a0 <acquire>
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
8010135b:	68 00 10 11 80       	push   $0x80111000
80101360:	e8 fb 3d 00 00       	call   80105160 <release>
  return f;
}
80101365:	89 d8                	mov    %ebx,%eax
80101367:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010136a:	c9                   	leave  
8010136b:	c3                   	ret    
    panic("filedup");
8010136c:	83 ec 0c             	sub    $0xc,%esp
8010136f:	68 8c 7f 10 80       	push   $0x80107f8c
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
80101390:	68 00 10 11 80       	push   $0x80111000
80101395:	e8 06 3d 00 00       	call   801050a0 <acquire>
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
801013c8:	68 00 10 11 80       	push   $0x80111000
  ff = *f;
801013cd:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801013d0:	e8 8b 3d 00 00       	call   80105160 <release>

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
801013f0:	c7 45 08 00 10 11 80 	movl   $0x80111000,0x8(%ebp)
}
801013f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013fa:	5b                   	pop    %ebx
801013fb:	5e                   	pop    %esi
801013fc:	5f                   	pop    %edi
801013fd:	5d                   	pop    %ebp
    release(&ftable.lock);
801013fe:	e9 5d 3d 00 00       	jmp    80105160 <release>
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
8010144c:	68 94 7f 10 80       	push   $0x80107f94
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
8010153a:	68 9e 7f 10 80       	push   $0x80107f9e
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
80101623:	68 a7 7f 10 80       	push   $0x80107fa7
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
80101659:	68 ad 7f 10 80       	push   $0x80107fad
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
80101678:	03 05 18 1a 11 80    	add    0x80111a18,%eax
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
801016d7:	68 b7 7f 10 80       	push   $0x80107fb7
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
801016f9:	8b 0d 00 1a 11 80    	mov    0x80111a00,%ecx
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
8010171c:	03 05 18 1a 11 80    	add    0x80111a18,%eax
80101722:	50                   	push   %eax
80101723:	ff 75 d8             	pushl  -0x28(%ebp)
80101726:	e8 a5 e9 ff ff       	call   801000d0 <bread>
8010172b:	83 c4 10             	add    $0x10,%esp
8010172e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101731:	a1 00 1a 11 80       	mov    0x80111a00,%eax
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
80101789:	39 05 00 1a 11 80    	cmp    %eax,0x80111a00
8010178f:	77 80                	ja     80101711 <balloc+0x21>
  panic("balloc: out of blocks");
80101791:	83 ec 0c             	sub    $0xc,%esp
80101794:	68 ca 7f 10 80       	push   $0x80107fca
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
801017d5:	e8 d6 39 00 00       	call   801051b0 <memset>
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
8010180a:	bb 54 1a 11 80       	mov    $0x80111a54,%ebx
{
8010180f:	83 ec 28             	sub    $0x28,%esp
80101812:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101815:	68 20 1a 11 80       	push   $0x80111a20
8010181a:	e8 81 38 00 00       	call   801050a0 <acquire>
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
8010183a:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
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
8010185b:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
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
80101882:	68 20 1a 11 80       	push   $0x80111a20
80101887:	e8 d4 38 00 00       	call   80105160 <release>

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
801018ad:	68 20 1a 11 80       	push   $0x80111a20
      ip->ref++;
801018b2:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801018b5:	e8 a6 38 00 00       	call   80105160 <release>
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
801018c7:	81 fb 74 36 11 80    	cmp    $0x80113674,%ebx
801018cd:	73 10                	jae    801018df <iget+0xdf>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801018cf:	8b 4b 08             	mov    0x8(%ebx),%ecx
801018d2:	85 c9                	test   %ecx,%ecx
801018d4:	0f 8f 56 ff ff ff    	jg     80101830 <iget+0x30>
801018da:	e9 6e ff ff ff       	jmp    8010184d <iget+0x4d>
    panic("iget: no inodes");
801018df:	83 ec 0c             	sub    $0xc,%esp
801018e2:	68 e0 7f 10 80       	push   $0x80107fe0
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
801019ab:	68 f0 7f 10 80       	push   $0x80107ff0
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
801019e5:	e8 66 38 00 00       	call   80105250 <memmove>
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
80101a08:	bb 60 1a 11 80       	mov    $0x80111a60,%ebx
80101a0d:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
80101a10:	68 03 80 10 80       	push   $0x80108003
80101a15:	68 20 1a 11 80       	push   $0x80111a20
80101a1a:	e8 01 35 00 00       	call   80104f20 <initlock>
  for(i = 0; i < NINODE; i++) {
80101a1f:	83 c4 10             	add    $0x10,%esp
80101a22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101a28:	83 ec 08             	sub    $0x8,%esp
80101a2b:	68 0a 80 10 80       	push   $0x8010800a
80101a30:	53                   	push   %ebx
80101a31:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101a37:	e8 a4 33 00 00       	call   80104de0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101a3c:	83 c4 10             	add    $0x10,%esp
80101a3f:	81 fb 80 36 11 80    	cmp    $0x80113680,%ebx
80101a45:	75 e1                	jne    80101a28 <iinit+0x28>
  readsb(dev, &sb);
80101a47:	83 ec 08             	sub    $0x8,%esp
80101a4a:	68 00 1a 11 80       	push   $0x80111a00
80101a4f:	ff 75 08             	pushl  0x8(%ebp)
80101a52:	e8 69 ff ff ff       	call   801019c0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101a57:	ff 35 18 1a 11 80    	pushl  0x80111a18
80101a5d:	ff 35 14 1a 11 80    	pushl  0x80111a14
80101a63:	ff 35 10 1a 11 80    	pushl  0x80111a10
80101a69:	ff 35 0c 1a 11 80    	pushl  0x80111a0c
80101a6f:	ff 35 08 1a 11 80    	pushl  0x80111a08
80101a75:	ff 35 04 1a 11 80    	pushl  0x80111a04
80101a7b:	ff 35 00 1a 11 80    	pushl  0x80111a00
80101a81:	68 70 80 10 80       	push   $0x80108070
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
80101ab0:	83 3d 08 1a 11 80 01 	cmpl   $0x1,0x80111a08
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
80101adf:	3b 3d 08 1a 11 80    	cmp    0x80111a08,%edi
80101ae5:	73 69                	jae    80101b50 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101ae7:	89 f8                	mov    %edi,%eax
80101ae9:	83 ec 08             	sub    $0x8,%esp
80101aec:	c1 e8 03             	shr    $0x3,%eax
80101aef:	03 05 14 1a 11 80    	add    0x80111a14,%eax
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
80101b1e:	e8 8d 36 00 00       	call   801051b0 <memset>
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
80101b53:	68 10 80 10 80       	push   $0x80108010
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
80101b78:	03 05 14 1a 11 80    	add    0x80111a14,%eax
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
80101bc5:	e8 86 36 00 00       	call   80105250 <memmove>
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
80101bfe:	68 20 1a 11 80       	push   $0x80111a20
80101c03:	e8 98 34 00 00       	call   801050a0 <acquire>
  ip->ref++;
80101c08:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101c0c:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101c13:	e8 48 35 00 00       	call   80105160 <release>
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
80101c46:	e8 d5 31 00 00       	call   80104e20 <acquiresleep>
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
80101c69:	03 05 14 1a 11 80    	add    0x80111a14,%eax
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
80101cb8:	e8 93 35 00 00       	call   80105250 <memmove>
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
80101cdd:	68 28 80 10 80       	push   $0x80108028
80101ce2:	e8 a9 e6 ff ff       	call   80100390 <panic>
    panic("ilock");
80101ce7:	83 ec 0c             	sub    $0xc,%esp
80101cea:	68 22 80 10 80       	push   $0x80108022
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
80101d17:	e8 a4 31 00 00       	call   80104ec0 <holdingsleep>
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
80101d33:	e9 48 31 00 00       	jmp    80104e80 <releasesleep>
    panic("iunlock");
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	68 37 80 10 80       	push   $0x80108037
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
80101d64:	e8 b7 30 00 00       	call   80104e20 <acquiresleep>
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
80101d7e:	e8 fd 30 00 00       	call   80104e80 <releasesleep>
  acquire(&icache.lock);
80101d83:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101d8a:	e8 11 33 00 00       	call   801050a0 <acquire>
  ip->ref--;
80101d8f:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101d93:	83 c4 10             	add    $0x10,%esp
80101d96:	c7 45 08 20 1a 11 80 	movl   $0x80111a20,0x8(%ebp)
}
80101d9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101da0:	5b                   	pop    %ebx
80101da1:	5e                   	pop    %esi
80101da2:	5f                   	pop    %edi
80101da3:	5d                   	pop    %ebp
  release(&icache.lock);
80101da4:	e9 b7 33 00 00       	jmp    80105160 <release>
80101da9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&icache.lock);
80101db0:	83 ec 0c             	sub    $0xc,%esp
80101db3:	68 20 1a 11 80       	push   $0x80111a20
80101db8:	e8 e3 32 00 00       	call   801050a0 <acquire>
    int r = ip->ref;
80101dbd:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101dc0:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
80101dc7:	e8 94 33 00 00       	call   80105160 <release>
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
80101fc7:	e8 84 32 00 00       	call   80105250 <memmove>
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
80101ffa:	8b 04 c5 a0 19 11 80 	mov    -0x7feee660(,%eax,8),%eax
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
801020c3:	e8 88 31 00 00       	call   80105250 <memmove>
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
8010210a:	8b 04 c5 a4 19 11 80 	mov    -0x7feee65c(,%eax,8),%eax
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
80102162:	e8 59 31 00 00       	call   801052c0 <strncmp>
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
801021c5:	e8 f6 30 00 00       	call   801052c0 <strncmp>
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
8010220a:	68 51 80 10 80       	push   $0x80108051
8010220f:	e8 7c e1 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80102214:	83 ec 0c             	sub    $0xc,%esp
80102217:	68 3f 80 10 80       	push   $0x8010803f
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
8010224a:	e8 41 1c 00 00       	call   80103e90 <myproc>
  acquire(&icache.lock);
8010224f:	83 ec 0c             	sub    $0xc,%esp
80102252:	89 df                	mov    %ebx,%edi
    ip = idup(myproc()->cwd);
80102254:	8b 70 6c             	mov    0x6c(%eax),%esi
  acquire(&icache.lock);
80102257:	68 20 1a 11 80       	push   $0x80111a20
8010225c:	e8 3f 2e 00 00       	call   801050a0 <acquire>
  ip->ref++;
80102261:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102265:	c7 04 24 20 1a 11 80 	movl   $0x80111a20,(%esp)
8010226c:	e8 ef 2e 00 00       	call   80105160 <release>
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
801022d7:	e8 74 2f 00 00       	call   80105250 <memmove>
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
80102363:	e8 e8 2e 00 00       	call   80105250 <memmove>
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
80102495:	e8 76 2e 00 00       	call   80105310 <strncpy>
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
801024d3:	68 60 80 10 80       	push   $0x80108060
801024d8:	e8 b3 de ff ff       	call   80100390 <panic>
    panic("dirlink");
801024dd:	83 ec 0c             	sub    $0xc,%esp
801024e0:	68 a2 86 10 80       	push   $0x801086a2
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
8010260b:	68 cc 80 10 80       	push   $0x801080cc
80102610:	e8 7b dd ff ff       	call   80100390 <panic>
    panic("idestart");
80102615:	83 ec 0c             	sub    $0xc,%esp
80102618:	68 c3 80 10 80       	push   $0x801080c3
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
8010263a:	68 de 80 10 80       	push   $0x801080de
8010263f:	68 a0 b5 10 80       	push   $0x8010b5a0
80102644:	e8 d7 28 00 00       	call   80104f20 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102649:	58                   	pop    %eax
8010264a:	a1 40 3d 11 80       	mov    0x80113d40,%eax
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
8010269a:	c7 05 80 b5 10 80 01 	movl   $0x1,0x8010b580
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
801026cd:	68 a0 b5 10 80       	push   $0x8010b5a0
801026d2:	e8 c9 29 00 00       	call   801050a0 <acquire>

  if((b = idequeue) == 0){
801026d7:	8b 1d 84 b5 10 80    	mov    0x8010b584,%ebx
801026dd:	83 c4 10             	add    $0x10,%esp
801026e0:	85 db                	test   %ebx,%ebx
801026e2:	74 5f                	je     80102743 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801026e4:	8b 43 58             	mov    0x58(%ebx),%eax
801026e7:	a3 84 b5 10 80       	mov    %eax,0x8010b584

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
8010272d:	e8 be 22 00 00       	call   801049f0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102732:	a1 84 b5 10 80       	mov    0x8010b584,%eax
80102737:	83 c4 10             	add    $0x10,%esp
8010273a:	85 c0                	test   %eax,%eax
8010273c:	74 05                	je     80102743 <ideintr+0x83>
    idestart(idequeue);
8010273e:	e8 0d fe ff ff       	call   80102550 <idestart>
    release(&idelock);
80102743:	83 ec 0c             	sub    $0xc,%esp
80102746:	68 a0 b5 10 80       	push   $0x8010b5a0
8010274b:	e8 10 2a 00 00       	call   80105160 <release>

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
80102772:	e8 49 27 00 00       	call   80104ec0 <holdingsleep>
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
80102797:	a1 80 b5 10 80       	mov    0x8010b580,%eax
8010279c:	85 c0                	test   %eax,%eax
8010279e:	0f 84 93 00 00 00    	je     80102837 <iderw+0xd7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801027a4:	83 ec 0c             	sub    $0xc,%esp
801027a7:	68 a0 b5 10 80       	push   $0x8010b5a0
801027ac:	e8 ef 28 00 00       	call   801050a0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801027b1:	a1 84 b5 10 80       	mov    0x8010b584,%eax
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
801027d6:	39 1d 84 b5 10 80    	cmp    %ebx,0x8010b584
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
801027f3:	68 a0 b5 10 80       	push   $0x8010b5a0
801027f8:	53                   	push   %ebx
801027f9:	e8 32 20 00 00       	call   80104830 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801027fe:	8b 03                	mov    (%ebx),%eax
80102800:	83 c4 10             	add    $0x10,%esp
80102803:	83 e0 06             	and    $0x6,%eax
80102806:	83 f8 02             	cmp    $0x2,%eax
80102809:	75 e5                	jne    801027f0 <iderw+0x90>
  }


  release(&idelock);
8010280b:	c7 45 08 a0 b5 10 80 	movl   $0x8010b5a0,0x8(%ebp)
}
80102812:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102815:	c9                   	leave  
  release(&idelock);
80102816:	e9 45 29 00 00       	jmp    80105160 <release>
8010281b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010281f:	90                   	nop
    idestart(b);
80102820:	89 d8                	mov    %ebx,%eax
80102822:	e8 29 fd ff ff       	call   80102550 <idestart>
80102827:	eb b5                	jmp    801027de <iderw+0x7e>
80102829:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102830:	ba 84 b5 10 80       	mov    $0x8010b584,%edx
80102835:	eb 9d                	jmp    801027d4 <iderw+0x74>
    panic("iderw: ide disk 1 not present");
80102837:	83 ec 0c             	sub    $0xc,%esp
8010283a:	68 0d 81 10 80       	push   $0x8010810d
8010283f:	e8 4c db ff ff       	call   80100390 <panic>
    panic("iderw: nothing to do");
80102844:	83 ec 0c             	sub    $0xc,%esp
80102847:	68 f8 80 10 80       	push   $0x801080f8
8010284c:	e8 3f db ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102851:	83 ec 0c             	sub    $0xc,%esp
80102854:	68 e2 80 10 80       	push   $0x801080e2
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
80102865:	c7 05 74 36 11 80 00 	movl   $0xfec00000,0x80113674
8010286c:	00 c0 fe 
{
8010286f:	89 e5                	mov    %esp,%ebp
80102871:	56                   	push   %esi
80102872:	53                   	push   %ebx
  ioapic->reg = reg;
80102873:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
8010287a:	00 00 00 
  return ioapic->data;
8010287d:	8b 15 74 36 11 80    	mov    0x80113674,%edx
80102883:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102886:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
8010288c:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
80102892:	0f b6 15 a0 37 11 80 	movzbl 0x801137a0,%edx
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
801028ae:	68 2c 81 10 80       	push   $0x8010812c
801028b3:	e8 f8 dd ff ff       	call   801006b0 <cprintf>
801028b8:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
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
801028d4:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
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
801028ee:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
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
80102915:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
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
80102929:	8b 0d 74 36 11 80    	mov    0x80113674,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010292f:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
80102932:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102935:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102938:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
8010293a:	a1 74 36 11 80       	mov    0x80113674,%eax
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
80102966:	81 fb e8 6b 11 80    	cmp    $0x80116be8,%ebx
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
80102986:	e8 25 28 00 00       	call   801051b0 <memset>

  if(kmem.use_lock)
8010298b:	8b 15 b4 36 11 80    	mov    0x801136b4,%edx
80102991:	83 c4 10             	add    $0x10,%esp
80102994:	85 d2                	test   %edx,%edx
80102996:	75 20                	jne    801029b8 <kfree+0x68>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102998:	a1 b8 36 11 80       	mov    0x801136b8,%eax
8010299d:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010299f:	a1 b4 36 11 80       	mov    0x801136b4,%eax
  kmem.freelist = r;
801029a4:	89 1d b8 36 11 80    	mov    %ebx,0x801136b8
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
801029bb:	68 80 36 11 80       	push   $0x80113680
801029c0:	e8 db 26 00 00       	call   801050a0 <acquire>
801029c5:	83 c4 10             	add    $0x10,%esp
801029c8:	eb ce                	jmp    80102998 <kfree+0x48>
801029ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801029d0:	c7 45 08 80 36 11 80 	movl   $0x80113680,0x8(%ebp)
}
801029d7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029da:	c9                   	leave  
    release(&kmem.lock);
801029db:	e9 80 27 00 00       	jmp    80105160 <release>
    panic("kfree");
801029e0:	83 ec 0c             	sub    $0xc,%esp
801029e3:	68 5e 81 10 80       	push   $0x8010815e
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
80102a4f:	68 64 81 10 80       	push   $0x80108164
80102a54:	68 80 36 11 80       	push   $0x80113680
80102a59:	e8 c2 24 00 00       	call   80104f20 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
80102a5e:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102a61:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102a64:	c7 05 b4 36 11 80 00 	movl   $0x0,0x801136b4
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
80102af4:	c7 05 b4 36 11 80 01 	movl   $0x1,0x801136b4
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
80102b14:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102b19:	85 c0                	test   %eax,%eax
80102b1b:	75 1b                	jne    80102b38 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102b1d:	a1 b8 36 11 80       	mov    0x801136b8,%eax
  if(r)
80102b22:	85 c0                	test   %eax,%eax
80102b24:	74 0a                	je     80102b30 <kalloc+0x20>
    kmem.freelist = r->next;
80102b26:	8b 10                	mov    (%eax),%edx
80102b28:	89 15 b8 36 11 80    	mov    %edx,0x801136b8
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
80102b3e:	68 80 36 11 80       	push   $0x80113680
80102b43:	e8 58 25 00 00       	call   801050a0 <acquire>
  r = kmem.freelist;
80102b48:	a1 b8 36 11 80       	mov    0x801136b8,%eax
  if(r)
80102b4d:	8b 15 b4 36 11 80    	mov    0x801136b4,%edx
80102b53:	83 c4 10             	add    $0x10,%esp
80102b56:	85 c0                	test   %eax,%eax
80102b58:	74 08                	je     80102b62 <kalloc+0x52>
    kmem.freelist = r->next;
80102b5a:	8b 08                	mov    (%eax),%ecx
80102b5c:	89 0d b8 36 11 80    	mov    %ecx,0x801136b8
  if(kmem.use_lock)
80102b62:	85 d2                	test   %edx,%edx
80102b64:	74 16                	je     80102b7c <kalloc+0x6c>
    release(&kmem.lock);
80102b66:	83 ec 0c             	sub    $0xc,%esp
80102b69:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102b6c:	68 80 36 11 80       	push   $0x80113680
80102b71:	e8 ea 25 00 00       	call   80105160 <release>
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
80102b9c:	8b 1d d4 b5 10 80    	mov    0x8010b5d4,%ebx
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
80102bbf:	0f b6 8a a0 82 10 80 	movzbl -0x7fef7d60(%edx),%ecx
  shift ^= togglecode[data];
80102bc6:	0f b6 82 a0 81 10 80 	movzbl -0x7fef7e60(%edx),%eax
  shift |= shiftcode[data];
80102bcd:	09 d9                	or     %ebx,%ecx
  shift ^= togglecode[data];
80102bcf:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102bd1:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
80102bd3:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
  c = charcode[shift & (CTL | SHIFT)][data];
80102bd9:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102bdc:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
80102bdf:	8b 04 85 80 81 10 80 	mov    -0x7fef7e80(,%eax,4),%eax
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
80102c05:	89 1d d4 b5 10 80    	mov    %ebx,0x8010b5d4
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
80102c1a:	0f b6 8a a0 82 10 80 	movzbl -0x7fef7d60(%edx),%ecx
80102c21:	83 c9 40             	or     $0x40,%ecx
80102c24:	0f b6 c9             	movzbl %cl,%ecx
80102c27:	f7 d1                	not    %ecx
80102c29:	21 d9                	and    %ebx,%ecx
}
80102c2b:	5b                   	pop    %ebx
80102c2c:	5d                   	pop    %ebp
    shift &= ~(shiftcode[data] | E0ESC);
80102c2d:	89 0d d4 b5 10 80    	mov    %ecx,0x8010b5d4
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
80102c84:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102d84:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102da4:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102e12:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102f9f:	e8 5c 22 00 00       	call   80105200 <memcmp>
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
80103070:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
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
80103090:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80103095:	83 ec 08             	sub    $0x8,%esp
80103098:	01 f8                	add    %edi,%eax
8010309a:	83 c0 01             	add    $0x1,%eax
8010309d:	50                   	push   %eax
8010309e:	ff 35 04 37 11 80    	pushl  0x80113704
801030a4:	e8 27 d0 ff ff       	call   801000d0 <bread>
801030a9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801030ab:	58                   	pop    %eax
801030ac:	5a                   	pop    %edx
801030ad:	ff 34 bd 0c 37 11 80 	pushl  -0x7feec8f4(,%edi,4)
801030b4:	ff 35 04 37 11 80    	pushl  0x80113704
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
801030d4:	e8 77 21 00 00       	call   80105250 <memmove>
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
801030f4:	39 3d 08 37 11 80    	cmp    %edi,0x80113708
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
80103117:	ff 35 f4 36 11 80    	pushl  0x801136f4
8010311d:	ff 35 04 37 11 80    	pushl  0x80113704
80103123:	e8 a8 cf ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103128:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
8010312b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
8010312d:	a1 08 37 11 80       	mov    0x80113708,%eax
80103132:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103135:	85 c0                	test   %eax,%eax
80103137:	7e 19                	jle    80103152 <write_head+0x42>
80103139:	31 d2                	xor    %edx,%edx
8010313b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010313f:	90                   	nop
    hb->block[i] = log.lh.block[i];
80103140:	8b 0c 95 0c 37 11 80 	mov    -0x7feec8f4(,%edx,4),%ecx
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
8010317e:	68 a0 83 10 80       	push   $0x801083a0
80103183:	68 c0 36 11 80       	push   $0x801136c0
80103188:	e8 93 1d 00 00       	call   80104f20 <initlock>
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
8010319d:	89 1d 04 37 11 80    	mov    %ebx,0x80113704
  log.size = sb.nlog;
801031a3:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
801031a6:	a3 f4 36 11 80       	mov    %eax,0x801136f4
  log.size = sb.nlog;
801031ab:	89 15 f8 36 11 80    	mov    %edx,0x801136f8
  struct buf *buf = bread(log.dev, log.start);
801031b1:	5a                   	pop    %edx
801031b2:	50                   	push   %eax
801031b3:	53                   	push   %ebx
801031b4:	e8 17 cf ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
801031b9:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
801031bc:	8b 48 5c             	mov    0x5c(%eax),%ecx
801031bf:	89 0d 08 37 11 80    	mov    %ecx,0x80113708
  for (i = 0; i < log.lh.n; i++) {
801031c5:	85 c9                	test   %ecx,%ecx
801031c7:	7e 19                	jle    801031e2 <initlog+0x72>
801031c9:	31 d2                	xor    %edx,%edx
801031cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801031cf:	90                   	nop
    log.lh.block[i] = lh->block[i];
801031d0:	8b 5c 90 60          	mov    0x60(%eax,%edx,4),%ebx
801031d4:	89 1c 95 0c 37 11 80 	mov    %ebx,-0x7feec8f4(,%edx,4)
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
801031f0:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
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
8010321a:	68 c0 36 11 80       	push   $0x801136c0
8010321f:	e8 7c 1e 00 00       	call   801050a0 <acquire>
80103224:	83 c4 10             	add    $0x10,%esp
80103227:	eb 1c                	jmp    80103245 <begin_op+0x35>
80103229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103230:	83 ec 08             	sub    $0x8,%esp
80103233:	68 c0 36 11 80       	push   $0x801136c0
80103238:	68 c0 36 11 80       	push   $0x801136c0
8010323d:	e8 ee 15 00 00       	call   80104830 <sleep>
80103242:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103245:	a1 00 37 11 80       	mov    0x80113700,%eax
8010324a:	85 c0                	test   %eax,%eax
8010324c:	75 e2                	jne    80103230 <begin_op+0x20>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
8010324e:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103253:	8b 15 08 37 11 80    	mov    0x80113708,%edx
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
8010326a:	a3 fc 36 11 80       	mov    %eax,0x801136fc
      release(&log.lock);
8010326f:	68 c0 36 11 80       	push   $0x801136c0
80103274:	e8 e7 1e 00 00       	call   80105160 <release>
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
8010328d:	68 c0 36 11 80       	push   $0x801136c0
80103292:	e8 09 1e 00 00       	call   801050a0 <acquire>
  log.outstanding -= 1;
80103297:	a1 fc 36 11 80       	mov    0x801136fc,%eax
  if(log.committing)
8010329c:	8b 35 00 37 11 80    	mov    0x80113700,%esi
801032a2:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801032a5:	8d 58 ff             	lea    -0x1(%eax),%ebx
801032a8:	89 1d fc 36 11 80    	mov    %ebx,0x801136fc
  if(log.committing)
801032ae:	85 f6                	test   %esi,%esi
801032b0:	0f 85 1e 01 00 00    	jne    801033d4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
801032b6:	85 db                	test   %ebx,%ebx
801032b8:	0f 85 f2 00 00 00    	jne    801033b0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
801032be:	c7 05 00 37 11 80 01 	movl   $0x1,0x80113700
801032c5:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
801032c8:	83 ec 0c             	sub    $0xc,%esp
801032cb:	68 c0 36 11 80       	push   $0x801136c0
801032d0:	e8 8b 1e 00 00       	call   80105160 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
801032d5:	8b 0d 08 37 11 80    	mov    0x80113708,%ecx
801032db:	83 c4 10             	add    $0x10,%esp
801032de:	85 c9                	test   %ecx,%ecx
801032e0:	7f 3e                	jg     80103320 <end_op+0xa0>
    acquire(&log.lock);
801032e2:	83 ec 0c             	sub    $0xc,%esp
801032e5:	68 c0 36 11 80       	push   $0x801136c0
801032ea:	e8 b1 1d 00 00       	call   801050a0 <acquire>
    wakeup(&log);
801032ef:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
    log.committing = 0;
801032f6:	c7 05 00 37 11 80 00 	movl   $0x0,0x80113700
801032fd:	00 00 00 
    wakeup(&log);
80103300:	e8 eb 16 00 00       	call   801049f0 <wakeup>
    release(&log.lock);
80103305:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
8010330c:	e8 4f 1e 00 00       	call   80105160 <release>
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
80103320:	a1 f4 36 11 80       	mov    0x801136f4,%eax
80103325:	83 ec 08             	sub    $0x8,%esp
80103328:	01 d8                	add    %ebx,%eax
8010332a:	83 c0 01             	add    $0x1,%eax
8010332d:	50                   	push   %eax
8010332e:	ff 35 04 37 11 80    	pushl  0x80113704
80103334:	e8 97 cd ff ff       	call   801000d0 <bread>
80103339:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010333b:	58                   	pop    %eax
8010333c:	5a                   	pop    %edx
8010333d:	ff 34 9d 0c 37 11 80 	pushl  -0x7feec8f4(,%ebx,4)
80103344:	ff 35 04 37 11 80    	pushl  0x80113704
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
80103364:	e8 e7 1e 00 00       	call   80105250 <memmove>
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
80103384:	3b 1d 08 37 11 80    	cmp    0x80113708,%ebx
8010338a:	7c 94                	jl     80103320 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010338c:	e8 7f fd ff ff       	call   80103110 <write_head>
    install_trans(); // Now install writes to home locations
80103391:	e8 da fc ff ff       	call   80103070 <install_trans>
    log.lh.n = 0;
80103396:	c7 05 08 37 11 80 00 	movl   $0x0,0x80113708
8010339d:	00 00 00 
    write_head();    // Erase the transaction from the log
801033a0:	e8 6b fd ff ff       	call   80103110 <write_head>
801033a5:	e9 38 ff ff ff       	jmp    801032e2 <end_op+0x62>
801033aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801033b0:	83 ec 0c             	sub    $0xc,%esp
801033b3:	68 c0 36 11 80       	push   $0x801136c0
801033b8:	e8 33 16 00 00       	call   801049f0 <wakeup>
  release(&log.lock);
801033bd:	c7 04 24 c0 36 11 80 	movl   $0x801136c0,(%esp)
801033c4:	e8 97 1d 00 00       	call   80105160 <release>
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
801033d7:	68 a4 83 10 80       	push   $0x801083a4
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
801033fb:	8b 15 08 37 11 80    	mov    0x80113708,%edx
{
80103401:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103404:	83 fa 1d             	cmp    $0x1d,%edx
80103407:	0f 8f 91 00 00 00    	jg     8010349e <log_write+0xae>
8010340d:	a1 f8 36 11 80       	mov    0x801136f8,%eax
80103412:	83 e8 01             	sub    $0x1,%eax
80103415:	39 c2                	cmp    %eax,%edx
80103417:	0f 8d 81 00 00 00    	jge    8010349e <log_write+0xae>
    panic("too big a transaction");
  if (log.outstanding < 1)
8010341d:	a1 fc 36 11 80       	mov    0x801136fc,%eax
80103422:	85 c0                	test   %eax,%eax
80103424:	0f 8e 81 00 00 00    	jle    801034ab <log_write+0xbb>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010342a:	83 ec 0c             	sub    $0xc,%esp
8010342d:	68 c0 36 11 80       	push   $0x801136c0
80103432:	e8 69 1c 00 00       	call   801050a0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80103437:	8b 15 08 37 11 80    	mov    0x80113708,%edx
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
80103457:	39 0c 85 0c 37 11 80 	cmp    %ecx,-0x7feec8f4(,%eax,4)
8010345e:	75 f0                	jne    80103450 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80103460:	89 0c 85 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103467:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010346a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
8010346d:	c7 45 08 c0 36 11 80 	movl   $0x801136c0,0x8(%ebp)
}
80103474:	c9                   	leave  
  release(&log.lock);
80103475:	e9 e6 1c 00 00       	jmp    80105160 <release>
8010347a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80103480:	89 0c 95 0c 37 11 80 	mov    %ecx,-0x7feec8f4(,%edx,4)
    log.lh.n++;
80103487:	83 c2 01             	add    $0x1,%edx
8010348a:	89 15 08 37 11 80    	mov    %edx,0x80113708
80103490:	eb d5                	jmp    80103467 <log_write+0x77>
  log.lh.block[i] = b->blockno;
80103492:	8b 43 08             	mov    0x8(%ebx),%eax
80103495:	a3 0c 37 11 80       	mov    %eax,0x8011370c
  if (i == log.lh.n)
8010349a:	75 cb                	jne    80103467 <log_write+0x77>
8010349c:	eb e9                	jmp    80103487 <log_write+0x97>
    panic("too big a transaction");
8010349e:	83 ec 0c             	sub    $0xc,%esp
801034a1:	68 b3 83 10 80       	push   $0x801083b3
801034a6:	e8 e5 ce ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	68 c9 83 10 80       	push   $0x801083c9
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
801034c7:	e8 a4 09 00 00       	call   80103e70 <cpuid>
801034cc:	89 c3                	mov    %eax,%ebx
801034ce:	e8 9d 09 00 00       	call   80103e70 <cpuid>
801034d3:	83 ec 04             	sub    $0x4,%esp
801034d6:	53                   	push   %ebx
801034d7:	50                   	push   %eax
801034d8:	68 e4 83 10 80       	push   $0x801083e4
801034dd:	e8 ce d1 ff ff       	call   801006b0 <cprintf>
  idtinit();       // load idt register
801034e2:	e8 e9 31 00 00       	call   801066d0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801034e7:	e8 14 09 00 00       	call   80103e00 <mycpu>
801034ec:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801034ee:	b8 01 00 00 00       	mov    $0x1,%eax
801034f3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801034fa:	e8 61 0f 00 00       	call   80104460 <scheduler>
801034ff:	90                   	nop

80103500 <mpenter>:
{
80103500:	f3 0f 1e fb          	endbr32 
80103504:	55                   	push   %ebp
80103505:	89 e5                	mov    %esp,%ebp
80103507:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
8010350a:	e8 91 42 00 00       	call   801077a0 <switchkvm>
  seginit();
8010350f:	e8 fc 41 00 00       	call   80107710 <seginit>
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
8010353b:	68 e8 6b 11 80       	push   $0x80116be8
80103540:	e8 fb f4 ff ff       	call   80102a40 <kinit1>
  kvmalloc();      // kernel page table
80103545:	e8 36 47 00 00       	call   80107c80 <kvmalloc>
  mpinit();        // detect other processors
8010354a:	e8 81 01 00 00       	call   801036d0 <mpinit>
  lapicinit();     // interrupt controller
8010354f:	e8 2c f7 ff ff       	call   80102c80 <lapicinit>
  seginit();       // segment descriptors
80103554:	e8 b7 41 00 00       	call   80107710 <seginit>
  picinit();       // disable pic
80103559:	e8 52 03 00 00       	call   801038b0 <picinit>
  ioapicinit();    // another interrupt controller
8010355e:	e8 fd f2 ff ff       	call   80102860 <ioapicinit>
  consoleinit();   // console hardware
80103563:	e8 88 d9 ff ff       	call   80100ef0 <consoleinit>
  uartinit();      // serial port
80103568:	e8 63 34 00 00       	call   801069d0 <uartinit>
  pinit();         // process table
8010356d:	e8 6e 08 00 00       	call   80103de0 <pinit>
  tvinit();        // trap vectors
80103572:	e8 d9 30 00 00       	call   80106650 <tvinit>
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
8010358e:	68 8c b4 10 80       	push   $0x8010b48c
80103593:	68 00 70 00 80       	push   $0x80007000
80103598:	e8 b3 1c 00 00       	call   80105250 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
8010359d:	83 c4 10             	add    $0x10,%esp
801035a0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801035a7:	00 00 00 
801035aa:	05 c0 37 11 80       	add    $0x801137c0,%eax
801035af:	3d c0 37 11 80       	cmp    $0x801137c0,%eax
801035b4:	76 7a                	jbe    80103630 <main+0x110>
801035b6:	bb c0 37 11 80       	mov    $0x801137c0,%ebx
801035bb:	eb 1c                	jmp    801035d9 <main+0xb9>
801035bd:	8d 76 00             	lea    0x0(%esi),%esi
801035c0:	69 05 40 3d 11 80 b0 	imul   $0xb0,0x80113d40,%eax
801035c7:	00 00 00 
801035ca:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801035d0:	05 c0 37 11 80       	add    $0x801137c0,%eax
801035d5:	39 c3                	cmp    %eax,%ebx
801035d7:	73 57                	jae    80103630 <main+0x110>
    if(c == mycpu())  // We've started already.
801035d9:	e8 22 08 00 00       	call   80103e00 <mycpu>
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
80103642:	e8 79 08 00 00       	call   80103ec0 <userinit>
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
8010367e:	68 f8 83 10 80       	push   $0x801083f8
80103683:	56                   	push   %esi
80103684:	e8 77 1b 00 00       	call   80105200 <memcmp>
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
8010373a:	68 fd 83 10 80       	push   $0x801083fd
8010373f:	50                   	push   %eax
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103743:	e8 b8 1a 00 00       	call   80105200 <memcmp>
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
8010379e:	a3 bc 36 11 80       	mov    %eax,0x801136bc
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
8010382f:	88 0d a0 37 11 80    	mov    %cl,0x801137a0
      continue;
80103835:	eb 89                	jmp    801037c0 <mpinit+0xf0>
80103837:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010383e:	66 90                	xchg   %ax,%ax
      if(ncpu < NCPU) {
80103840:	8b 0d 40 3d 11 80    	mov    0x80113d40,%ecx
80103846:	83 f9 07             	cmp    $0x7,%ecx
80103849:	7f 19                	jg     80103864 <mpinit+0x194>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010384b:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
80103851:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103855:	83 c1 01             	add    $0x1,%ecx
80103858:	89 0d 40 3d 11 80    	mov    %ecx,0x80113d40
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010385e:	88 9f c0 37 11 80    	mov    %bl,-0x7feec840(%edi)
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
80103893:	68 02 84 10 80       	push   $0x80108402
80103898:	e8 f3 ca ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010389d:	83 ec 0c             	sub    $0xc,%esp
801038a0:	68 1c 84 10 80       	push   $0x8010841c
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
80103947:	68 3b 84 10 80       	push   $0x8010843b
8010394c:	50                   	push   %eax
8010394d:	e8 ce 15 00 00       	call   80104f20 <initlock>
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
801039f3:	e8 a8 16 00 00       	call   801050a0 <acquire>
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
80103a13:	e8 d8 0f 00 00       	call   801049f0 <wakeup>
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
80103a38:	e9 23 17 00 00       	jmp    80105160 <release>
80103a3d:	8d 76 00             	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103a40:	83 ec 0c             	sub    $0xc,%esp
80103a43:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103a49:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103a50:	00 00 00 
    wakeup(&p->nwrite);
80103a53:	50                   	push   %eax
80103a54:	e8 97 0f 00 00       	call   801049f0 <wakeup>
80103a59:	83 c4 10             	add    $0x10,%esp
80103a5c:	eb bd                	jmp    80103a1b <pipeclose+0x3b>
80103a5e:	66 90                	xchg   %ax,%ax
    release(&p->lock);
80103a60:	83 ec 0c             	sub    $0xc,%esp
80103a63:	53                   	push   %ebx
80103a64:	e8 f7 16 00 00       	call   80105160 <release>
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
80103a91:	e8 0a 16 00 00       	call   801050a0 <acquire>
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
80103ad8:	e8 b3 03 00 00       	call   80103e90 <myproc>
80103add:	8b 48 28             	mov    0x28(%eax),%ecx
80103ae0:	85 c9                	test   %ecx,%ecx
80103ae2:	75 34                	jne    80103b18 <pipewrite+0x98>
      wakeup(&p->nread);
80103ae4:	83 ec 0c             	sub    $0xc,%esp
80103ae7:	57                   	push   %edi
80103ae8:	e8 03 0f 00 00       	call   801049f0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103aed:	58                   	pop    %eax
80103aee:	5a                   	pop    %edx
80103aef:	53                   	push   %ebx
80103af0:	56                   	push   %esi
80103af1:	e8 3a 0d 00 00       	call   80104830 <sleep>
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
80103b1c:	e8 3f 16 00 00       	call   80105160 <release>
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
80103b6a:	e8 81 0e 00 00       	call   801049f0 <wakeup>
  release(&p->lock);
80103b6f:	89 1c 24             	mov    %ebx,(%esp)
80103b72:	e8 e9 15 00 00       	call   80105160 <release>
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
80103b9a:	e8 01 15 00 00       	call   801050a0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103b9f:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103ba5:	83 c4 10             	add    $0x10,%esp
80103ba8:	39 86 38 02 00 00    	cmp    %eax,0x238(%esi)
80103bae:	74 33                	je     80103be3 <piperead+0x63>
80103bb0:	eb 3b                	jmp    80103bed <piperead+0x6d>
80103bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(myproc()->killed){
80103bb8:	e8 d3 02 00 00       	call   80103e90 <myproc>
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
80103bcd:	e8 5e 0c 00 00       	call   80104830 <sleep>
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
80103c36:	e8 b5 0d 00 00       	call   801049f0 <wakeup>
  release(&p->lock);
80103c3b:	89 34 24             	mov    %esi,(%esp)
80103c3e:	e8 1d 15 00 00       	call   80105160 <release>
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
80103c59:	e8 02 15 00 00       	call   80105160 <release>
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
// Otherwise return 0.

int first_time = 1;
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
80103c74:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
{
80103c79:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103c7c:	68 60 3d 11 80       	push   $0x80113d60
80103c81:	e8 1a 14 00 00       	call   801050a0 <acquire>
80103c86:	83 c4 10             	add    $0x10,%esp
80103c89:	eb 17                	jmp    80103ca2 <allocproc+0x32>
80103c8b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103c8f:	90                   	nop
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103c90:	81 c3 98 00 00 00    	add    $0x98,%ebx
80103c96:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
80103c9c:	0f 84 be 00 00 00    	je     80103d60 <allocproc+0xf0>
    if(p->state == UNUSED)
80103ca2:	8b 43 0c             	mov    0xc(%ebx),%eax
80103ca5:	85 c0                	test   %eax,%eax
80103ca7:	75 e7                	jne    80103c90 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103ca9:	a1 08 b0 10 80       	mov    0x8010b008,%eax

  // RR queue initialization
  p->RR_priority = next_RR_priority;
  next_RR_priority++;

  release(&ptable.lock);
80103cae:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103cb1:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->level = 2;   // Default scheduling queue (LCFS)
80103cb8:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103cbf:	00 00 00 
  p->pid = nextpid++;
80103cc2:	8d 50 01             	lea    0x1(%eax),%edx
80103cc5:	89 43 10             	mov    %eax,0x10(%ebx)
  p->arrival_time = ticks;
80103cc8:	a1 e0 6b 11 80       	mov    0x80116be0,%eax
  p->exec_cycle = 1;
80103ccd:	c7 83 88 00 00 00 01 	movl   $0x1,0x88(%ebx)
80103cd4:	00 00 00 
  p->arrival_time = ticks;
80103cd7:	89 83 90 00 00 00    	mov    %eax,0x90(%ebx)
  p->HRRN_priority = ticks * 100; // default unique priority (will change in relevant syscall)
80103cdd:	6b c0 64             	imul   $0x64,%eax,%eax
  p->last_execution = 0;
80103ce0:	c7 83 94 00 00 00 00 	movl   $0x0,0x94(%ebx)
80103ce7:	00 00 00 
  p->pid = nextpid++;
80103cea:	89 15 08 b0 10 80    	mov    %edx,0x8010b008
  p->HRRN_priority = ticks * 100; // default unique priority (will change in relevant syscall)
80103cf0:	89 83 84 00 00 00    	mov    %eax,0x84(%ebx)
  p->RR_priority = next_RR_priority;
80103cf6:	a1 d8 b5 10 80       	mov    0x8010b5d8,%eax
80103cfb:	89 83 8c 00 00 00    	mov    %eax,0x8c(%ebx)
  next_RR_priority++;
80103d01:	83 c0 01             	add    $0x1,%eax
  release(&ptable.lock);
80103d04:	68 60 3d 11 80       	push   $0x80113d60
  next_RR_priority++;
80103d09:	a3 d8 b5 10 80       	mov    %eax,0x8010b5d8
  release(&ptable.lock);
80103d0e:	e8 4d 14 00 00       	call   80105160 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103d13:	e8 f8 ed ff ff       	call   80102b10 <kalloc>
80103d18:	83 c4 10             	add    $0x10,%esp
80103d1b:	89 43 08             	mov    %eax,0x8(%ebx)
80103d1e:	85 c0                	test   %eax,%eax
80103d20:	74 57                	je     80103d79 <allocproc+0x109>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103d22:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103d28:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103d2b:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103d30:	89 53 1c             	mov    %edx,0x1c(%ebx)
  *(uint*)sp = (uint)trapret;
80103d33:	c7 40 14 3f 66 10 80 	movl   $0x8010663f,0x14(%eax)
  p->context = (struct context*)sp;
80103d3a:	89 43 20             	mov    %eax,0x20(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103d3d:	6a 14                	push   $0x14
80103d3f:	6a 00                	push   $0x0
80103d41:	50                   	push   %eax
80103d42:	e8 69 14 00 00       	call   801051b0 <memset>
  p->context->eip = (uint)forkret;
80103d47:	8b 43 20             	mov    0x20(%ebx),%eax

  return p;
80103d4a:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103d4d:	c7 40 10 90 3d 10 80 	movl   $0x80103d90,0x10(%eax)
}
80103d54:	89 d8                	mov    %ebx,%eax
80103d56:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d59:	c9                   	leave  
80103d5a:	c3                   	ret    
80103d5b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103d5f:	90                   	nop
  release(&ptable.lock);
80103d60:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103d63:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103d65:	68 60 3d 11 80       	push   $0x80113d60
80103d6a:	e8 f1 13 00 00       	call   80105160 <release>
}
80103d6f:	89 d8                	mov    %ebx,%eax
  return 0;
80103d71:	83 c4 10             	add    $0x10,%esp
}
80103d74:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d77:	c9                   	leave  
80103d78:	c3                   	ret    
    p->state = UNUSED;
80103d79:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103d80:	31 db                	xor    %ebx,%ebx
}
80103d82:	89 d8                	mov    %ebx,%eax
80103d84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103d87:	c9                   	leave  
80103d88:	c3                   	ret    
80103d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d90 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103d90:	f3 0f 1e fb          	endbr32 
80103d94:	55                   	push   %ebp
80103d95:	89 e5                	mov    %esp,%ebp
80103d97:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103d9a:	68 60 3d 11 80       	push   $0x80113d60
80103d9f:	e8 bc 13 00 00       	call   80105160 <release>

  if (first) {
80103da4:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103da9:	83 c4 10             	add    $0x10,%esp
80103dac:	85 c0                	test   %eax,%eax
80103dae:	75 08                	jne    80103db8 <forkret+0x28>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103db0:	c9                   	leave  
80103db1:	c3                   	ret    
80103db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    first = 0;
80103db8:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80103dbf:	00 00 00 
    iinit(ROOTDEV);
80103dc2:	83 ec 0c             	sub    $0xc,%esp
80103dc5:	6a 01                	push   $0x1
80103dc7:	e8 34 dc ff ff       	call   80101a00 <iinit>
    initlog(ROOTDEV);
80103dcc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103dd3:	e8 98 f3 ff ff       	call   80103170 <initlog>
}
80103dd8:	83 c4 10             	add    $0x10,%esp
80103ddb:	c9                   	leave  
80103ddc:	c3                   	ret    
80103ddd:	8d 76 00             	lea    0x0(%esi),%esi

80103de0 <pinit>:
{
80103de0:	f3 0f 1e fb          	endbr32 
80103de4:	55                   	push   %ebp
80103de5:	89 e5                	mov    %esp,%ebp
80103de7:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103dea:	68 40 84 10 80       	push   $0x80108440
80103def:	68 60 3d 11 80       	push   $0x80113d60
80103df4:	e8 27 11 00 00       	call   80104f20 <initlock>
}
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	c9                   	leave  
80103dfd:	c3                   	ret    
80103dfe:	66 90                	xchg   %ax,%ax

80103e00 <mycpu>:
{
80103e00:	f3 0f 1e fb          	endbr32 
80103e04:	55                   	push   %ebp
80103e05:	89 e5                	mov    %esp,%ebp
80103e07:	56                   	push   %esi
80103e08:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103e09:	9c                   	pushf  
80103e0a:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103e0b:	f6 c4 02             	test   $0x2,%ah
80103e0e:	75 4a                	jne    80103e5a <mycpu+0x5a>
  apicid = lapicid();
80103e10:	e8 6b ef ff ff       	call   80102d80 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103e15:	8b 35 40 3d 11 80    	mov    0x80113d40,%esi
  apicid = lapicid();
80103e1b:	89 c3                	mov    %eax,%ebx
  for (i = 0; i < ncpu; ++i) {
80103e1d:	85 f6                	test   %esi,%esi
80103e1f:	7e 2c                	jle    80103e4d <mycpu+0x4d>
80103e21:	31 d2                	xor    %edx,%edx
80103e23:	eb 0a                	jmp    80103e2f <mycpu+0x2f>
80103e25:	8d 76 00             	lea    0x0(%esi),%esi
80103e28:	83 c2 01             	add    $0x1,%edx
80103e2b:	39 f2                	cmp    %esi,%edx
80103e2d:	74 1e                	je     80103e4d <mycpu+0x4d>
    if (cpus[i].apicid == apicid)
80103e2f:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103e35:	0f b6 81 c0 37 11 80 	movzbl -0x7feec840(%ecx),%eax
80103e3c:	39 d8                	cmp    %ebx,%eax
80103e3e:	75 e8                	jne    80103e28 <mycpu+0x28>
}
80103e40:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103e43:	8d 81 c0 37 11 80    	lea    -0x7feec840(%ecx),%eax
}
80103e49:	5b                   	pop    %ebx
80103e4a:	5e                   	pop    %esi
80103e4b:	5d                   	pop    %ebp
80103e4c:	c3                   	ret    
  panic("unknown apicid\n");
80103e4d:	83 ec 0c             	sub    $0xc,%esp
80103e50:	68 47 84 10 80       	push   $0x80108447
80103e55:	e8 36 c5 ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
80103e5a:	83 ec 0c             	sub    $0xc,%esp
80103e5d:	68 44 85 10 80       	push   $0x80108544
80103e62:	e8 29 c5 ff ff       	call   80100390 <panic>
80103e67:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103e6e:	66 90                	xchg   %ax,%ax

80103e70 <cpuid>:
cpuid() {
80103e70:	f3 0f 1e fb          	endbr32 
80103e74:	55                   	push   %ebp
80103e75:	89 e5                	mov    %esp,%ebp
80103e77:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103e7a:	e8 81 ff ff ff       	call   80103e00 <mycpu>
}
80103e7f:	c9                   	leave  
  return mycpu()-cpus;
80103e80:	2d c0 37 11 80       	sub    $0x801137c0,%eax
80103e85:	c1 f8 04             	sar    $0x4,%eax
80103e88:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103e8e:	c3                   	ret    
80103e8f:	90                   	nop

80103e90 <myproc>:
myproc(void) {
80103e90:	f3 0f 1e fb          	endbr32 
80103e94:	55                   	push   %ebp
80103e95:	89 e5                	mov    %esp,%ebp
80103e97:	53                   	push   %ebx
80103e98:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103e9b:	e8 00 11 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80103ea0:	e8 5b ff ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80103ea5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103eab:	e8 40 11 00 00       	call   80104ff0 <popcli>
}
80103eb0:	83 c4 04             	add    $0x4,%esp
80103eb3:	89 d8                	mov    %ebx,%eax
80103eb5:	5b                   	pop    %ebx
80103eb6:	5d                   	pop    %ebp
80103eb7:	c3                   	ret    
80103eb8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ebf:	90                   	nop

80103ec0 <userinit>:
{
80103ec0:	f3 0f 1e fb          	endbr32 
80103ec4:	55                   	push   %ebp
80103ec5:	89 e5                	mov    %esp,%ebp
80103ec7:	53                   	push   %ebx
80103ec8:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103ecb:	e8 a0 fd ff ff       	call   80103c70 <allocproc>
80103ed0:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103ed2:	a3 dc b5 10 80       	mov    %eax,0x8010b5dc
  if((p->pgdir = setupkvm()) == 0)
80103ed7:	e8 24 3d 00 00       	call   80107c00 <setupkvm>
80103edc:	89 43 04             	mov    %eax,0x4(%ebx)
80103edf:	85 c0                	test   %eax,%eax
80103ee1:	0f 84 d6 00 00 00    	je     80103fbd <userinit+0xfd>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103ee7:	83 ec 04             	sub    $0x4,%esp
80103eea:	68 2c 00 00 00       	push   $0x2c
80103eef:	68 60 b4 10 80       	push   $0x8010b460
80103ef4:	50                   	push   %eax
80103ef5:	e8 d6 39 00 00       	call   801078d0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103efa:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103efd:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103f03:	6a 4c                	push   $0x4c
80103f05:	6a 00                	push   $0x0
80103f07:	ff 73 1c             	pushl  0x1c(%ebx)
80103f0a:	e8 a1 12 00 00       	call   801051b0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f0f:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f12:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f17:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103f1c:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103f20:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f23:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103f27:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f2a:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f2e:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103f32:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f35:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103f39:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103f3d:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f40:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103f47:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f4a:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103f51:	8b 43 1c             	mov    0x1c(%ebx),%eax
80103f54:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  p->level = 2;
80103f5b:	c7 83 80 00 00 00 02 	movl   $0x2,0x80(%ebx)
80103f62:	00 00 00 
    cprintf("init PID: %d \n", p->pid);
80103f65:	58                   	pop    %eax
80103f66:	5a                   	pop    %edx
80103f67:	ff 73 10             	pushl  0x10(%ebx)
80103f6a:	68 70 84 10 80       	push   $0x80108470
80103f6f:	e8 3c c7 ff ff       	call   801006b0 <cprintf>
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103f74:	83 c4 0c             	add    $0xc,%esp
80103f77:	8d 43 70             	lea    0x70(%ebx),%eax
80103f7a:	6a 10                	push   $0x10
80103f7c:	68 7f 84 10 80       	push   $0x8010847f
80103f81:	50                   	push   %eax
80103f82:	e8 e9 13 00 00       	call   80105370 <safestrcpy>
  p->cwd = namei("/");
80103f87:	c7 04 24 88 84 10 80 	movl   $0x80108488,(%esp)
80103f8e:	e8 5d e5 ff ff       	call   801024f0 <namei>
80103f93:	89 43 6c             	mov    %eax,0x6c(%ebx)
  acquire(&ptable.lock);
80103f96:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
80103f9d:	e8 fe 10 00 00       	call   801050a0 <acquire>
  p->state = RUNNABLE;
80103fa2:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103fa9:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
80103fb0:	e8 ab 11 00 00       	call   80105160 <release>
}
80103fb5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fb8:	83 c4 10             	add    $0x10,%esp
80103fbb:	c9                   	leave  
80103fbc:	c3                   	ret    
    panic("userinit: out of memory?");
80103fbd:	83 ec 0c             	sub    $0xc,%esp
80103fc0:	68 57 84 10 80       	push   $0x80108457
80103fc5:	e8 c6 c3 ff ff       	call   80100390 <panic>
80103fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103fd0 <growproc>:
{
80103fd0:	f3 0f 1e fb          	endbr32 
80103fd4:	55                   	push   %ebp
80103fd5:	89 e5                	mov    %esp,%ebp
80103fd7:	56                   	push   %esi
80103fd8:	53                   	push   %ebx
80103fd9:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103fdc:	e8 bf 0f 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80103fe1:	e8 1a fe ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80103fe6:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fec:	e8 ff 0f 00 00       	call   80104ff0 <popcli>
  sz = curproc->sz;
80103ff1:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ff3:	85 f6                	test   %esi,%esi
80103ff5:	7f 19                	jg     80104010 <growproc+0x40>
  } else if(n < 0){
80103ff7:	75 37                	jne    80104030 <growproc+0x60>
  switchuvm(curproc);
80103ff9:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ffc:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103ffe:	53                   	push   %ebx
80103fff:	e8 bc 37 00 00       	call   801077c0 <switchuvm>
  return 0;
80104004:	83 c4 10             	add    $0x10,%esp
80104007:	31 c0                	xor    %eax,%eax
}
80104009:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010400c:	5b                   	pop    %ebx
8010400d:	5e                   	pop    %esi
8010400e:	5d                   	pop    %ebp
8010400f:	c3                   	ret    
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104010:	83 ec 04             	sub    $0x4,%esp
80104013:	01 c6                	add    %eax,%esi
80104015:	56                   	push   %esi
80104016:	50                   	push   %eax
80104017:	ff 73 04             	pushl  0x4(%ebx)
8010401a:	e8 01 3a 00 00       	call   80107a20 <allocuvm>
8010401f:	83 c4 10             	add    $0x10,%esp
80104022:	85 c0                	test   %eax,%eax
80104024:	75 d3                	jne    80103ff9 <growproc+0x29>
      return -1;
80104026:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010402b:	eb dc                	jmp    80104009 <growproc+0x39>
8010402d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104030:	83 ec 04             	sub    $0x4,%esp
80104033:	01 c6                	add    %eax,%esi
80104035:	56                   	push   %esi
80104036:	50                   	push   %eax
80104037:	ff 73 04             	pushl  0x4(%ebx)
8010403a:	e8 11 3b 00 00       	call   80107b50 <deallocuvm>
8010403f:	83 c4 10             	add    $0x10,%esp
80104042:	85 c0                	test   %eax,%eax
80104044:	75 b3                	jne    80103ff9 <growproc+0x29>
80104046:	eb de                	jmp    80104026 <growproc+0x56>
80104048:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010404f:	90                   	nop

80104050 <fork>:
{
80104050:	f3 0f 1e fb          	endbr32 
80104054:	55                   	push   %ebp
80104055:	89 e5                	mov    %esp,%ebp
80104057:	57                   	push   %edi
80104058:	56                   	push   %esi
80104059:	53                   	push   %ebx
8010405a:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
8010405d:	e8 3e 0f 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104062:	e8 99 fd ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104067:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010406d:	e8 7e 0f 00 00       	call   80104ff0 <popcli>
  if((np = allocproc()) == 0){
80104072:	e8 f9 fb ff ff       	call   80103c70 <allocproc>
80104077:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010407a:	85 c0                	test   %eax,%eax
8010407c:	0f 84 c3 00 00 00    	je     80104145 <fork+0xf5>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80104082:	83 ec 08             	sub    $0x8,%esp
80104085:	ff 33                	pushl  (%ebx)
80104087:	89 c7                	mov    %eax,%edi
80104089:	ff 73 04             	pushl  0x4(%ebx)
8010408c:	e8 3f 3c 00 00       	call   80107cd0 <copyuvm>
80104091:	83 c4 10             	add    $0x10,%esp
80104094:	89 47 04             	mov    %eax,0x4(%edi)
80104097:	85 c0                	test   %eax,%eax
80104099:	0f 84 ad 00 00 00    	je     8010414c <fork+0xfc>
  np->sz = curproc->sz;
8010409f:	8b 03                	mov    (%ebx),%eax
801040a1:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801040a4:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
801040a6:	8b 79 1c             	mov    0x1c(%ecx),%edi
  np->parent = curproc;
801040a9:	89 c8                	mov    %ecx,%eax
801040ab:	89 59 14             	mov    %ebx,0x14(%ecx)
  np->tracer = 0;
801040ae:	c7 41 18 00 00 00 00 	movl   $0x0,0x18(%ecx)
  *np->tf = *curproc->tf;
801040b5:	b9 13 00 00 00       	mov    $0x13,%ecx
801040ba:	8b 73 1c             	mov    0x1c(%ebx),%esi
801040bd:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801040bf:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801040c1:	8b 40 1c             	mov    0x1c(%eax),%eax
801040c4:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
  for(i = 0; i < NOFILE; i++)
801040cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040cf:	90                   	nop
    if(curproc->ofile[i])
801040d0:	8b 44 b3 2c          	mov    0x2c(%ebx,%esi,4),%eax
801040d4:	85 c0                	test   %eax,%eax
801040d6:	74 13                	je     801040eb <fork+0x9b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801040d8:	83 ec 0c             	sub    $0xc,%esp
801040db:	50                   	push   %eax
801040dc:	e8 4f d2 ff ff       	call   80101330 <filedup>
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
801040fc:	e8 ef da ff ff       	call   80101bf0 <idup>
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
80104111:	e8 5a 12 00 00       	call   80105370 <safestrcpy>
  pid = np->pid;
80104116:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80104119:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
80104120:	e8 7b 0f 00 00       	call   801050a0 <acquire>
  np->state = RUNNABLE;
80104125:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
8010412c:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
80104133:	e8 28 10 00 00       	call   80105160 <release>
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
80104155:	e8 f6 e7 ff ff       	call   80102950 <kfree>
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
80104180:	f3 0f 1e fb          	endbr32 
80104184:	55                   	push   %ebp
80104185:	89 e5                	mov    %esp,%ebp
80104187:	56                   	push   %esi
80104188:	53                   	push   %ebx
80104189:	8b 75 0c             	mov    0xc(%ebp),%esi
8010418c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010418f:	83 ec 0c             	sub    $0xc,%esp
80104192:	68 60 3d 11 80       	push   $0x80113d60
80104197:	e8 04 0f 00 00       	call   801050a0 <acquire>
8010419c:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010419f:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
801041a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->pid == pid){
801041a8:	39 58 10             	cmp    %ebx,0x10(%eax)
801041ab:	75 06                	jne    801041b3 <set_HRRN_process_level+0x33>
      p->HRRN_priority = priority;
801041ad:	89 b0 84 00 00 00    	mov    %esi,0x84(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801041b3:	05 98 00 00 00       	add    $0x98,%eax
801041b8:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801041bd:	75 e9                	jne    801041a8 <set_HRRN_process_level+0x28>
  release(&ptable.lock);
801041bf:	c7 45 08 60 3d 11 80 	movl   $0x80113d60,0x8(%ebp)
}
801041c6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041c9:	5b                   	pop    %ebx
801041ca:	5e                   	pop    %esi
801041cb:	5d                   	pop    %ebp
  release(&ptable.lock);
801041cc:	e9 8f 0f 00 00       	jmp    80105160 <release>
801041d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041d8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801041df:	90                   	nop

801041e0 <set_HRRN_system_level>:
void set_HRRN_system_level(int priority){
801041e0:	f3 0f 1e fb          	endbr32 
801041e4:	55                   	push   %ebp
801041e5:	89 e5                	mov    %esp,%ebp
801041e7:	53                   	push   %ebx
801041e8:	83 ec 10             	sub    $0x10,%esp
801041eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ee:	68 60 3d 11 80       	push   $0x80113d60
801041f3:	e8 a8 0e 00 00       	call   801050a0 <acquire>
801041f8:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801041fb:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
    p->HRRN_priority = priority;
80104200:	89 98 84 00 00 00    	mov    %ebx,0x84(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104206:	05 98 00 00 00       	add    $0x98,%eax
8010420b:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104210:	75 ee                	jne    80104200 <set_HRRN_system_level+0x20>
  release(&ptable.lock);
80104212:	c7 45 08 60 3d 11 80 	movl   $0x80113d60,0x8(%ebp)
}
80104219:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010421c:	c9                   	leave  
  release(&ptable.lock);
8010421d:	e9 3e 0f 00 00       	jmp    80105160 <release>
80104222:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104230 <get_HRRN_priority>:
float get_HRRN_priority(struct proc* p){
80104230:	f3 0f 1e fb          	endbr32 
80104234:	55                   	push   %ebp
80104235:	89 e5                	mov    %esp,%ebp
80104237:	56                   	push   %esi
80104238:	53                   	push   %ebx
80104239:	83 ec 1c             	sub    $0x1c,%esp
8010423c:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&tickslock);
8010423f:	68 a0 63 11 80       	push   $0x801163a0
80104244:	e8 57 0e 00 00       	call   801050a0 <acquire>
  int current = ticks;
80104249:	8b 1d e0 6b 11 80    	mov    0x80116be0,%ebx
  release(&tickslock);
8010424f:	c7 04 24 a0 63 11 80 	movl   $0x801163a0,(%esp)
80104256:	e8 05 0f 00 00       	call   80105160 <release>
  float waiting_time = (float)(current - p->arrival_time);
8010425b:	89 d8                	mov    %ebx,%eax
8010425d:	2b 86 90 00 00 00    	sub    0x90(%esi),%eax
  cprintf("waiting time : %f\n", waiting_time);
80104263:	c7 04 24 8a 84 10 80 	movl   $0x8010848a,(%esp)
  float waiting_time = (float)(current - p->arrival_time);
8010426a:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010426d:	db 45 f4             	fildl  -0xc(%ebp)
  cprintf("waiting time : %f\n", waiting_time);
80104270:	d9 c0                	fld    %st(0)
80104272:	d9 5d f4             	fstps  -0xc(%ebp)
80104275:	dd 5c 24 04          	fstpl  0x4(%esp)
80104279:	e8 32 c4 ff ff       	call   801006b0 <cprintf>
  float HRRN = (waiting_time + p->exec_cycle) / p->exec_cycle;
8010427e:	db 86 88 00 00 00    	fildl  0x88(%esi)
  return (HRRN + p->HRRN_priority) / 2;
80104284:	db 86 84 00 00 00    	fildl  0x84(%esi)
  float HRRN = (waiting_time + p->exec_cycle) / p->exec_cycle;
8010428a:	d9 45 f4             	flds   -0xc(%ebp)
8010428d:	d8 c2                	fadd   %st(2),%st
8010428f:	de f2                	fdivp  %st,%st(2)
  return (HRRN + p->HRRN_priority) / 2;
80104291:	de c1                	faddp  %st,%st(1)
80104293:	d8 0d 84 85 10 80    	fmuls  0x80108584
}
80104299:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010429c:	5b                   	pop    %ebx
8010429d:	5e                   	pop    %esi
8010429e:	5d                   	pop    %ebp
8010429f:	c3                   	ret    

801042a0 <HRRN>:
struct proc* HRRN(){
801042a0:	f3 0f 1e fb          	endbr32 
801042a4:	55                   	push   %ebp
801042a5:	89 e5                	mov    %esp,%ebp
801042a7:	56                   	push   %esi
    struct proc* p,* min_p = 0;
801042a8:	31 f6                	xor    %esi,%esi
struct proc* HRRN(){
801042aa:	53                   	push   %ebx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042ab:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
struct proc* HRRN(){
801042b0:	83 ec 10             	sub    $0x10,%esp
    float min_priority = 9999999;
801042b3:	d9 05 88 85 10 80    	flds   0x80108588
801042b9:	d9 5d f4             	fstps  -0xc(%ebp)
801042bc:	eb 10                	jmp    801042ce <HRRN+0x2e>
801042be:	66 90                	xchg   %ax,%ax
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042c0:	81 c3 98 00 00 00    	add    $0x98,%ebx
801042c6:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
801042cc:	74 43                	je     80104311 <HRRN+0x71>
      if(p -> state == RUNNABLE && p -> level == 3){
801042ce:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801042d2:	75 ec                	jne    801042c0 <HRRN+0x20>
801042d4:	83 bb 80 00 00 00 03 	cmpl   $0x3,0x80(%ebx)
801042db:	75 e3                	jne    801042c0 <HRRN+0x20>
        if(get_HRRN_priority(p) < min_priority){
801042dd:	83 ec 0c             	sub    $0xc,%esp
801042e0:	53                   	push   %ebx
801042e1:	e8 4a ff ff ff       	call   80104230 <get_HRRN_priority>
801042e6:	d9 45 f4             	flds   -0xc(%ebp)
801042e9:	83 c4 10             	add    $0x10,%esp
801042ec:	df f1                	fcomip %st(1),%st
801042ee:	dd d8                	fstp   %st(0)
801042f0:	76 ce                	jbe    801042c0 <HRRN+0x20>
          min_priority = get_HRRN_priority(p);
801042f2:	83 ec 0c             	sub    $0xc,%esp
801042f5:	89 de                	mov    %ebx,%esi
801042f7:	53                   	push   %ebx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801042f8:	81 c3 98 00 00 00    	add    $0x98,%ebx
          min_priority = get_HRRN_priority(p);
801042fe:	e8 2d ff ff ff       	call   80104230 <get_HRRN_priority>
80104303:	83 c4 10             	add    $0x10,%esp
80104306:	d9 5d f4             	fstps  -0xc(%ebp)
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104309:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
8010430f:	75 bd                	jne    801042ce <HRRN+0x2e>
}
80104311:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104314:	89 f0                	mov    %esi,%eax
80104316:	5b                   	pop    %ebx
80104317:	5e                   	pop    %esi
80104318:	5d                   	pop    %ebp
80104319:	c3                   	ret    
8010431a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104320 <RR>:
struct proc* RR(){
80104320:	f3 0f 1e fb          	endbr32 
80104324:	55                   	push   %ebp
    int min_priority = 9999999, max_priority = -1;
80104325:	b9 ff ff ff ff       	mov    $0xffffffff,%ecx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010432a:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
struct proc* RR(){
8010432f:	89 e5                	mov    %esp,%ebp
80104331:	56                   	push   %esi
    struct proc* p,*min_p = 0;
80104332:	31 f6                	xor    %esi,%esi
struct proc* RR(){
80104334:	53                   	push   %ebx
    int min_priority = 9999999, max_priority = -1;
80104335:	bb 7f 96 98 00       	mov    $0x98967f,%ebx
8010433a:	eb 10                	jmp    8010434c <RR+0x2c>
8010433c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104340:	05 98 00 00 00       	add    $0x98,%eax
80104345:	3d 94 63 11 80       	cmp    $0x80116394,%eax
8010434a:	74 34                	je     80104380 <RR+0x60>
        if(p -> state == RUNNABLE && p -> level == 1){
8010434c:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104350:	75 ee                	jne    80104340 <RR+0x20>
80104352:	83 b8 80 00 00 00 01 	cmpl   $0x1,0x80(%eax)
80104359:	75 e5                	jne    80104340 <RR+0x20>
            if(p->RR_priority < min_priority){
8010435b:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80104361:	39 da                	cmp    %ebx,%edx
80104363:	7d 04                	jge    80104369 <RR+0x49>
80104365:	89 d3                	mov    %edx,%ebx
80104367:	89 c6                	mov    %eax,%esi
            if(p->RR_priority > max_priority){
80104369:	39 d1                	cmp    %edx,%ecx
8010436b:	0f 4c ca             	cmovl  %edx,%ecx
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010436e:	05 98 00 00 00       	add    $0x98,%eax
80104373:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104378:	75 d2                	jne    8010434c <RR+0x2c>
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(min_p)
80104380:	85 f6                	test   %esi,%esi
80104382:	74 09                	je     8010438d <RR+0x6d>
        min_p->RR_priority = max_priority + 1;
80104384:	83 c1 01             	add    $0x1,%ecx
80104387:	89 8e 8c 00 00 00    	mov    %ecx,0x8c(%esi)
}
8010438d:	89 f0                	mov    %esi,%eax
8010438f:	5b                   	pop    %ebx
80104390:	5e                   	pop    %esi
80104391:	5d                   	pop    %ebp
80104392:	c3                   	ret    
80104393:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043a0 <LCFS>:
struct proc* LCFS(){
801043a0:	f3 0f 1e fb          	endbr32 
  struct proc* p = 0 ,* latest_p = 0;
801043a4:	31 d2                	xor    %edx,%edx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043a6:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
801043ab:	eb 0f                	jmp    801043bc <LCFS+0x1c>
801043ad:	8d 76 00             	lea    0x0(%esi),%esi
801043b0:	05 98 00 00 00       	add    $0x98,%eax
801043b5:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801043ba:	74 2e                	je     801043ea <LCFS+0x4a>
      if(p -> state == RUNNABLE && p -> level == 2){
801043bc:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801043c0:	75 ee                	jne    801043b0 <LCFS+0x10>
801043c2:	83 b8 80 00 00 00 02 	cmpl   $0x2,0x80(%eax)
801043c9:	75 e5                	jne    801043b0 <LCFS+0x10>
          if(latest_p != 0){
801043cb:	85 d2                	test   %edx,%edx
801043cd:	74 21                	je     801043f0 <LCFS+0x50>
              if(p->arrival_time > latest_p->arrival_time)
801043cf:	8b 8a 90 00 00 00    	mov    0x90(%edx),%ecx
801043d5:	39 88 90 00 00 00    	cmp    %ecx,0x90(%eax)
801043db:	0f 4f d0             	cmovg  %eax,%edx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801043de:	05 98 00 00 00       	add    $0x98,%eax
801043e3:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801043e8:	75 d2                	jne    801043bc <LCFS+0x1c>
}
801043ea:	89 d0                	mov    %edx,%eax
801043ec:	c3                   	ret    
801043ed:	8d 76 00             	lea    0x0(%esi),%esi
801043f0:	89 c2                	mov    %eax,%edx
801043f2:	eb bc                	jmp    801043b0 <LCFS+0x10>
801043f4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801043fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801043ff:	90                   	nop

80104400 <aging>:
{
80104400:	f3 0f 1e fb          	endbr32 
          if(ticks - p->last_execution >= 8000)
80104404:	8b 0d e0 6b 11 80    	mov    0x80116be0,%ecx
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010440a:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
8010440f:	eb 13                	jmp    80104424 <aging+0x24>
80104411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104418:	05 98 00 00 00       	add    $0x98,%eax
8010441d:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104422:	74 2f                	je     80104453 <aging+0x53>
      if(p -> state == RUNNABLE /*&& p -> level == 2*/){
80104424:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
80104428:	75 ee                	jne    80104418 <aging+0x18>
          if(ticks - p->last_execution >= 8000)
8010442a:	89 ca                	mov    %ecx,%edx
8010442c:	2b 90 94 00 00 00    	sub    0x94(%eax),%edx
80104432:	81 fa 3f 1f 00 00    	cmp    $0x1f3f,%edx
80104438:	76 de                	jbe    80104418 <aging+0x18>
            p->level = 1;
8010443a:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
80104441:	00 00 00 
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104444:	05 98 00 00 00       	add    $0x98,%eax
            p->last_execution = ticks;
80104449:	89 48 fc             	mov    %ecx,-0x4(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
8010444c:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104451:	75 d1                	jne    80104424 <aging+0x24>
}
80104453:	c3                   	ret    
80104454:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010445b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010445f:	90                   	nop

80104460 <scheduler>:
{
80104460:	f3 0f 1e fb          	endbr32 
80104464:	55                   	push   %ebp
80104465:	89 e5                	mov    %esp,%ebp
80104467:	57                   	push   %edi
80104468:	56                   	push   %esi
80104469:	53                   	push   %ebx
8010446a:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
8010446d:	e8 8e f9 ff ff       	call   80103e00 <mycpu>
  c->proc = 0;
80104472:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104479:	00 00 00 
  struct cpu *c = mycpu();
8010447c:	89 c3                	mov    %eax,%ebx
  c->proc = 0;
8010447e:	8d 70 04             	lea    0x4(%eax),%esi
80104481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  asm volatile("sti");
80104488:	fb                   	sti    
    acquire(&ptable.lock);
80104489:	83 ec 0c             	sub    $0xc,%esp
8010448c:	68 60 3d 11 80       	push   $0x80113d60
80104491:	e8 0a 0c 00 00       	call   801050a0 <acquire>
     p = RR();
80104496:	e8 85 fe ff ff       	call   80104320 <RR>
     if(p == 0)
8010449b:	83 c4 10             	add    $0x10,%esp
     p = RR();
8010449e:	89 c7                	mov    %eax,%edi
     if(p == 0)
801044a0:	85 c0                	test   %eax,%eax
801044a2:	74 4c                	je     801044f0 <scheduler+0x90>
    switchuvm(p);
801044a4:	83 ec 0c             	sub    $0xc,%esp
    c->proc = p;
801044a7:	89 bb ac 00 00 00    	mov    %edi,0xac(%ebx)
    switchuvm(p);
801044ad:	57                   	push   %edi
801044ae:	e8 0d 33 00 00       	call   801077c0 <switchuvm>
    p->last_execution = ticks;
801044b3:	a1 e0 6b 11 80       	mov    0x80116be0,%eax
    p->state = RUNNING;
801044b8:	c7 47 0c 04 00 00 00 	movl   $0x4,0xc(%edi)
    p->last_execution = ticks;
801044bf:	89 87 94 00 00 00    	mov    %eax,0x94(%edi)
    swtch(&(c->scheduler), p->context);
801044c5:	58                   	pop    %eax
801044c6:	5a                   	pop    %edx
801044c7:	ff 77 20             	pushl  0x20(%edi)
801044ca:	56                   	push   %esi
801044cb:	e8 03 0f 00 00       	call   801053d3 <swtch>
    switchkvm();
801044d0:	e8 cb 32 00 00       	call   801077a0 <switchkvm>
    c->proc = 0;
801044d5:	c7 83 ac 00 00 00 00 	movl   $0x0,0xac(%ebx)
801044dc:	00 00 00 
    release(&ptable.lock);
801044df:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
801044e6:	e8 75 0c 00 00       	call   80105160 <release>
801044eb:	83 c4 10             	add    $0x10,%esp
801044ee:	eb 98                	jmp    80104488 <scheduler+0x28>
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801044f0:	ba 94 3d 11 80       	mov    $0x80113d94,%edx
801044f5:	eb 17                	jmp    8010450e <scheduler+0xae>
801044f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801044fe:	66 90                	xchg   %ax,%ax
80104500:	81 c2 98 00 00 00    	add    $0x98,%edx
80104506:	81 fa 94 63 11 80    	cmp    $0x80116394,%edx
8010450c:	74 32                	je     80104540 <scheduler+0xe0>
      if(p -> state == RUNNABLE && p -> level == 2){
8010450e:	83 7a 0c 03          	cmpl   $0x3,0xc(%edx)
80104512:	75 ec                	jne    80104500 <scheduler+0xa0>
80104514:	83 ba 80 00 00 00 02 	cmpl   $0x2,0x80(%edx)
8010451b:	75 e3                	jne    80104500 <scheduler+0xa0>
          if(latest_p != 0){
8010451d:	85 ff                	test   %edi,%edi
8010451f:	74 3f                	je     80104560 <scheduler+0x100>
              if(p->arrival_time > latest_p->arrival_time)
80104521:	8b 87 90 00 00 00    	mov    0x90(%edi),%eax
80104527:	39 82 90 00 00 00    	cmp    %eax,0x90(%edx)
8010452d:	0f 4f fa             	cmovg  %edx,%edi
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104530:	81 c2 98 00 00 00    	add    $0x98,%edx
80104536:	81 fa 94 63 11 80    	cmp    $0x80116394,%edx
8010453c:	75 d0                	jne    8010450e <scheduler+0xae>
8010453e:	66 90                	xchg   %ax,%ax
     if(p == 0){
80104540:	85 ff                	test   %edi,%edi
80104542:	0f 85 5c ff ff ff    	jne    801044a4 <scheduler+0x44>
         release(&ptable.lock);
80104548:	83 ec 0c             	sub    $0xc,%esp
8010454b:	68 60 3d 11 80       	push   $0x80113d60
80104550:	e8 0b 0c 00 00       	call   80105160 <release>
          continue;}
80104555:	83 c4 10             	add    $0x10,%esp
80104558:	e9 2b ff ff ff       	jmp    80104488 <scheduler+0x28>
8010455d:	8d 76 00             	lea    0x0(%esi),%esi
80104560:	89 d7                	mov    %edx,%edi
80104562:	eb 9c                	jmp    80104500 <scheduler+0xa0>
80104564:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010456b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010456f:	90                   	nop

80104570 <sched>:
{
80104570:	f3 0f 1e fb          	endbr32 
80104574:	55                   	push   %ebp
80104575:	89 e5                	mov    %esp,%ebp
80104577:	56                   	push   %esi
80104578:	53                   	push   %ebx
  pushcli();
80104579:	e8 22 0a 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
8010457e:	e8 7d f8 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104583:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104589:	e8 62 0a 00 00       	call   80104ff0 <popcli>
  if(!holding(&ptable.lock))
8010458e:	83 ec 0c             	sub    $0xc,%esp
80104591:	68 60 3d 11 80       	push   $0x80113d60
80104596:	e8 b5 0a 00 00       	call   80105050 <holding>
8010459b:	83 c4 10             	add    $0x10,%esp
8010459e:	85 c0                	test   %eax,%eax
801045a0:	74 4f                	je     801045f1 <sched+0x81>
  if(mycpu()->ncli != 1)
801045a2:	e8 59 f8 ff ff       	call   80103e00 <mycpu>
801045a7:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
801045ae:	75 68                	jne    80104618 <sched+0xa8>
  if(p->state == RUNNING)
801045b0:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
801045b4:	74 55                	je     8010460b <sched+0x9b>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801045b6:	9c                   	pushf  
801045b7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801045b8:	f6 c4 02             	test   $0x2,%ah
801045bb:	75 41                	jne    801045fe <sched+0x8e>
  intena = mycpu()->intena;
801045bd:	e8 3e f8 ff ff       	call   80103e00 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
801045c2:	83 c3 20             	add    $0x20,%ebx
  intena = mycpu()->intena;
801045c5:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
801045cb:	e8 30 f8 ff ff       	call   80103e00 <mycpu>
801045d0:	83 ec 08             	sub    $0x8,%esp
801045d3:	ff 70 04             	pushl  0x4(%eax)
801045d6:	53                   	push   %ebx
801045d7:	e8 f7 0d 00 00       	call   801053d3 <swtch>
  mycpu()->intena = intena;
801045dc:	e8 1f f8 ff ff       	call   80103e00 <mycpu>
}
801045e1:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801045e4:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
801045ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045ed:	5b                   	pop    %ebx
801045ee:	5e                   	pop    %esi
801045ef:	5d                   	pop    %ebp
801045f0:	c3                   	ret    
    panic("sched ptable.lock");
801045f1:	83 ec 0c             	sub    $0xc,%esp
801045f4:	68 9d 84 10 80       	push   $0x8010849d
801045f9:	e8 92 bd ff ff       	call   80100390 <panic>
    panic("sched interruptible");
801045fe:	83 ec 0c             	sub    $0xc,%esp
80104601:	68 c9 84 10 80       	push   $0x801084c9
80104606:	e8 85 bd ff ff       	call   80100390 <panic>
    panic("sched running");
8010460b:	83 ec 0c             	sub    $0xc,%esp
8010460e:	68 bb 84 10 80       	push   $0x801084bb
80104613:	e8 78 bd ff ff       	call   80100390 <panic>
    panic("sched locks");
80104618:	83 ec 0c             	sub    $0xc,%esp
8010461b:	68 af 84 10 80       	push   $0x801084af
80104620:	e8 6b bd ff ff       	call   80100390 <panic>
80104625:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010462c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104630 <exit>:
{
80104630:	f3 0f 1e fb          	endbr32 
80104634:	55                   	push   %ebp
80104635:	89 e5                	mov    %esp,%ebp
80104637:	57                   	push   %edi
80104638:	56                   	push   %esi
80104639:	53                   	push   %ebx
8010463a:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
8010463d:	e8 5e 09 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104642:	e8 b9 f7 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104647:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
8010464d:	e8 9e 09 00 00       	call   80104ff0 <popcli>
  if(curproc == initproc)
80104652:	8d 5e 2c             	lea    0x2c(%esi),%ebx
80104655:	8d 7e 6c             	lea    0x6c(%esi),%edi
80104658:	39 35 dc b5 10 80    	cmp    %esi,0x8010b5dc
8010465e:	0f 84 fd 00 00 00    	je     80104761 <exit+0x131>
80104664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80104668:	8b 03                	mov    (%ebx),%eax
8010466a:	85 c0                	test   %eax,%eax
8010466c:	74 12                	je     80104680 <exit+0x50>
      fileclose(curproc->ofile[fd]);
8010466e:	83 ec 0c             	sub    $0xc,%esp
80104671:	50                   	push   %eax
80104672:	e8 09 cd ff ff       	call   80101380 <fileclose>
      curproc->ofile[fd] = 0;
80104677:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
8010467d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104680:	83 c3 04             	add    $0x4,%ebx
80104683:	39 df                	cmp    %ebx,%edi
80104685:	75 e1                	jne    80104668 <exit+0x38>
  begin_op();
80104687:	e8 84 eb ff ff       	call   80103210 <begin_op>
  iput(curproc->cwd);
8010468c:	83 ec 0c             	sub    $0xc,%esp
8010468f:	ff 76 6c             	pushl  0x6c(%esi)
80104692:	e8 b9 d6 ff ff       	call   80101d50 <iput>
  end_op();
80104697:	e8 e4 eb ff ff       	call   80103280 <end_op>
  curproc->cwd = 0;
8010469c:	c7 46 6c 00 00 00 00 	movl   $0x0,0x6c(%esi)
  acquire(&ptable.lock);
801046a3:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
801046aa:	e8 f1 09 00 00       	call   801050a0 <acquire>
  wakeup1(curproc->parent);
801046af:	8b 56 14             	mov    0x14(%esi),%edx
801046b2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046b5:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
801046ba:	eb 10                	jmp    801046cc <exit+0x9c>
801046bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801046c0:	05 98 00 00 00       	add    $0x98,%eax
801046c5:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801046ca:	74 1e                	je     801046ea <exit+0xba>
    if(p->state == SLEEPING && p->chan == chan)
801046cc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046d0:	75 ee                	jne    801046c0 <exit+0x90>
801046d2:	3b 50 24             	cmp    0x24(%eax),%edx
801046d5:	75 e9                	jne    801046c0 <exit+0x90>
      p->state = RUNNABLE;
801046d7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801046de:	05 98 00 00 00       	add    $0x98,%eax
801046e3:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801046e8:	75 e2                	jne    801046cc <exit+0x9c>
      p->parent = initproc;
801046ea:	8b 0d dc b5 10 80    	mov    0x8010b5dc,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801046f0:	ba 94 3d 11 80       	mov    $0x80113d94,%edx
801046f5:	eb 17                	jmp    8010470e <exit+0xde>
801046f7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801046fe:	66 90                	xchg   %ax,%ax
80104700:	81 c2 98 00 00 00    	add    $0x98,%edx
80104706:	81 fa 94 63 11 80    	cmp    $0x80116394,%edx
8010470c:	74 3a                	je     80104748 <exit+0x118>
    if(p->parent == curproc){
8010470e:	39 72 14             	cmp    %esi,0x14(%edx)
80104711:	75 ed                	jne    80104700 <exit+0xd0>
      if(p->state == ZOMBIE)
80104713:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104717:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010471a:	75 e4                	jne    80104700 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010471c:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
80104721:	eb 11                	jmp    80104734 <exit+0x104>
80104723:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104727:	90                   	nop
80104728:	05 98 00 00 00       	add    $0x98,%eax
8010472d:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104732:	74 cc                	je     80104700 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80104734:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104738:	75 ee                	jne    80104728 <exit+0xf8>
8010473a:	3b 48 24             	cmp    0x24(%eax),%ecx
8010473d:	75 e9                	jne    80104728 <exit+0xf8>
      p->state = RUNNABLE;
8010473f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104746:	eb e0                	jmp    80104728 <exit+0xf8>
  curproc->state = ZOMBIE;
80104748:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
8010474f:	e8 1c fe ff ff       	call   80104570 <sched>
  panic("zombie exit");
80104754:	83 ec 0c             	sub    $0xc,%esp
80104757:	68 ea 84 10 80       	push   $0x801084ea
8010475c:	e8 2f bc ff ff       	call   80100390 <panic>
    panic("init exiting");
80104761:	83 ec 0c             	sub    $0xc,%esp
80104764:	68 dd 84 10 80       	push   $0x801084dd
80104769:	e8 22 bc ff ff       	call   80100390 <panic>
8010476e:	66 90                	xchg   %ax,%ax

80104770 <yield>:
{
80104770:	f3 0f 1e fb          	endbr32 
80104774:	55                   	push   %ebp
80104775:	89 e5                	mov    %esp,%ebp
80104777:	53                   	push   %ebx
80104778:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
8010477b:	68 60 3d 11 80       	push   $0x80113d60
80104780:	e8 1b 09 00 00       	call   801050a0 <acquire>
  pushcli();
80104785:	e8 16 08 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
8010478a:	e8 71 f6 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
8010478f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104795:	e8 56 08 00 00       	call   80104ff0 <popcli>
  myproc()->state = RUNNABLE;
8010479a:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  pushcli();
801047a1:	e8 fa 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801047a6:	e8 55 f6 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
801047ab:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047b1:	e8 3a 08 00 00       	call   80104ff0 <popcli>
          if(ticks - p->last_execution >= 8000)
801047b6:	8b 0d e0 6b 11 80    	mov    0x80116be0,%ecx
801047bc:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801047bf:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
  myproc()->exec_cycle += 1;
801047c4:	83 83 88 00 00 00 01 	addl   $0x1,0x88(%ebx)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801047cb:	eb 0f                	jmp    801047dc <yield+0x6c>
801047cd:	8d 76 00             	lea    0x0(%esi),%esi
801047d0:	05 98 00 00 00       	add    $0x98,%eax
801047d5:	3d 94 63 11 80       	cmp    $0x80116394,%eax
801047da:	74 2f                	je     8010480b <yield+0x9b>
      if(p -> state == RUNNABLE /*&& p -> level == 2*/){
801047dc:	83 78 0c 03          	cmpl   $0x3,0xc(%eax)
801047e0:	75 ee                	jne    801047d0 <yield+0x60>
          if(ticks - p->last_execution >= 8000)
801047e2:	89 ca                	mov    %ecx,%edx
801047e4:	2b 90 94 00 00 00    	sub    0x94(%eax),%edx
801047ea:	81 fa 3f 1f 00 00    	cmp    $0x1f3f,%edx
801047f0:	76 de                	jbe    801047d0 <yield+0x60>
            p->level = 1;
801047f2:	c7 80 80 00 00 00 01 	movl   $0x1,0x80(%eax)
801047f9:	00 00 00 
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
801047fc:	05 98 00 00 00       	add    $0x98,%eax
            p->last_execution = ticks;
80104801:	89 48 fc             	mov    %ecx,-0x4(%eax)
  for(p = ptable.proc; p != &ptable.proc[NPROC]; p++){
80104804:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104809:	75 d1                	jne    801047dc <yield+0x6c>
  sched();
8010480b:	e8 60 fd ff ff       	call   80104570 <sched>
  release(&ptable.lock);
80104810:	83 ec 0c             	sub    $0xc,%esp
80104813:	68 60 3d 11 80       	push   $0x80113d60
80104818:	e8 43 09 00 00       	call   80105160 <release>
}
8010481d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104820:	83 c4 10             	add    $0x10,%esp
80104823:	c9                   	leave  
80104824:	c3                   	ret    
80104825:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010482c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104830 <sleep>:
{
80104830:	f3 0f 1e fb          	endbr32 
80104834:	55                   	push   %ebp
80104835:	89 e5                	mov    %esp,%ebp
80104837:	57                   	push   %edi
80104838:	56                   	push   %esi
80104839:	53                   	push   %ebx
8010483a:	83 ec 0c             	sub    $0xc,%esp
8010483d:	8b 7d 08             	mov    0x8(%ebp),%edi
80104840:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104843:	e8 58 07 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104848:	e8 b3 f5 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
8010484d:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104853:	e8 98 07 00 00       	call   80104ff0 <popcli>
  if(p == 0)
80104858:	85 db                	test   %ebx,%ebx
8010485a:	0f 84 83 00 00 00    	je     801048e3 <sleep+0xb3>
  if(lk == 0)
80104860:	85 f6                	test   %esi,%esi
80104862:	74 72                	je     801048d6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104864:	81 fe 60 3d 11 80    	cmp    $0x80113d60,%esi
8010486a:	74 4c                	je     801048b8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
8010486c:	83 ec 0c             	sub    $0xc,%esp
8010486f:	68 60 3d 11 80       	push   $0x80113d60
80104874:	e8 27 08 00 00       	call   801050a0 <acquire>
    release(lk);
80104879:	89 34 24             	mov    %esi,(%esp)
8010487c:	e8 df 08 00 00       	call   80105160 <release>
  p->chan = chan;
80104881:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
80104884:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
8010488b:	e8 e0 fc ff ff       	call   80104570 <sched>
  p->chan = 0;
80104890:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
    release(&ptable.lock);
80104897:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
8010489e:	e8 bd 08 00 00       	call   80105160 <release>
    acquire(lk);
801048a3:	89 75 08             	mov    %esi,0x8(%ebp)
801048a6:	83 c4 10             	add    $0x10,%esp
}
801048a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048ac:	5b                   	pop    %ebx
801048ad:	5e                   	pop    %esi
801048ae:	5f                   	pop    %edi
801048af:	5d                   	pop    %ebp
    acquire(lk);
801048b0:	e9 eb 07 00 00       	jmp    801050a0 <acquire>
801048b5:	8d 76 00             	lea    0x0(%esi),%esi
  p->chan = chan;
801048b8:	89 7b 24             	mov    %edi,0x24(%ebx)
  p->state = SLEEPING;
801048bb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801048c2:	e8 a9 fc ff ff       	call   80104570 <sched>
  p->chan = 0;
801048c7:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
}
801048ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048d1:	5b                   	pop    %ebx
801048d2:	5e                   	pop    %esi
801048d3:	5f                   	pop    %edi
801048d4:	5d                   	pop    %ebp
801048d5:	c3                   	ret    
    panic("sleep without lk");
801048d6:	83 ec 0c             	sub    $0xc,%esp
801048d9:	68 fc 84 10 80       	push   $0x801084fc
801048de:	e8 ad ba ff ff       	call   80100390 <panic>
    panic("sleep");
801048e3:	83 ec 0c             	sub    $0xc,%esp
801048e6:	68 f6 84 10 80       	push   $0x801084f6
801048eb:	e8 a0 ba ff ff       	call   80100390 <panic>

801048f0 <wait>:
{
801048f0:	f3 0f 1e fb          	endbr32 
801048f4:	55                   	push   %ebp
801048f5:	89 e5                	mov    %esp,%ebp
801048f7:	56                   	push   %esi
801048f8:	53                   	push   %ebx
  pushcli();
801048f9:	e8 a2 06 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
801048fe:	e8 fd f4 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104903:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104909:	e8 e2 06 00 00       	call   80104ff0 <popcli>
  acquire(&ptable.lock);
8010490e:	83 ec 0c             	sub    $0xc,%esp
80104911:	68 60 3d 11 80       	push   $0x80113d60
80104916:	e8 85 07 00 00       	call   801050a0 <acquire>
8010491b:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010491e:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104920:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
80104925:	eb 17                	jmp    8010493e <wait+0x4e>
80104927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010492e:	66 90                	xchg   %ax,%ax
80104930:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104936:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
8010493c:	74 1e                	je     8010495c <wait+0x6c>
      if(p->parent != curproc)
8010493e:	39 73 14             	cmp    %esi,0x14(%ebx)
80104941:	75 ed                	jne    80104930 <wait+0x40>
      if(p->state == ZOMBIE){
80104943:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104947:	74 37                	je     80104980 <wait+0x90>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104949:	81 c3 98 00 00 00    	add    $0x98,%ebx
      havekids = 1;
8010494f:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104954:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
8010495a:	75 e2                	jne    8010493e <wait+0x4e>
    if(!havekids || curproc->killed){
8010495c:	85 c0                	test   %eax,%eax
8010495e:	74 76                	je     801049d6 <wait+0xe6>
80104960:	8b 46 28             	mov    0x28(%esi),%eax
80104963:	85 c0                	test   %eax,%eax
80104965:	75 6f                	jne    801049d6 <wait+0xe6>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104967:	83 ec 08             	sub    $0x8,%esp
8010496a:	68 60 3d 11 80       	push   $0x80113d60
8010496f:	56                   	push   %esi
80104970:	e8 bb fe ff ff       	call   80104830 <sleep>
    havekids = 0;
80104975:	83 c4 10             	add    $0x10,%esp
80104978:	eb a4                	jmp    8010491e <wait+0x2e>
8010497a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104980:	83 ec 0c             	sub    $0xc,%esp
80104983:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
80104986:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104989:	e8 c2 df ff ff       	call   80102950 <kfree>
        freevm(p->pgdir);
8010498e:	5a                   	pop    %edx
8010498f:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
80104992:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104999:	e8 e2 31 00 00       	call   80107b80 <freevm>
        release(&ptable.lock);
8010499e:	c7 04 24 60 3d 11 80 	movl   $0x80113d60,(%esp)
        p->pid = 0;
801049a5:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801049ac:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801049b3:	c6 43 70 00          	movb   $0x0,0x70(%ebx)
        p->killed = 0;
801049b7:	c7 43 28 00 00 00 00 	movl   $0x0,0x28(%ebx)
        p->state = UNUSED;
801049be:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
801049c5:	e8 96 07 00 00       	call   80105160 <release>
        return pid;
801049ca:	83 c4 10             	add    $0x10,%esp
}
801049cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801049d0:	89 f0                	mov    %esi,%eax
801049d2:	5b                   	pop    %ebx
801049d3:	5e                   	pop    %esi
801049d4:	5d                   	pop    %ebp
801049d5:	c3                   	ret    
      release(&ptable.lock);
801049d6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801049d9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
801049de:	68 60 3d 11 80       	push   $0x80113d60
801049e3:	e8 78 07 00 00       	call   80105160 <release>
      return -1;
801049e8:	83 c4 10             	add    $0x10,%esp
801049eb:	eb e0                	jmp    801049cd <wait+0xdd>
801049ed:	8d 76 00             	lea    0x0(%esi),%esi

801049f0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801049f0:	f3 0f 1e fb          	endbr32 
801049f4:	55                   	push   %ebp
801049f5:	89 e5                	mov    %esp,%ebp
801049f7:	53                   	push   %ebx
801049f8:	83 ec 10             	sub    $0x10,%esp
801049fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801049fe:	68 60 3d 11 80       	push   $0x80113d60
80104a03:	e8 98 06 00 00       	call   801050a0 <acquire>
80104a08:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a0b:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
80104a10:	eb 12                	jmp    80104a24 <wakeup+0x34>
80104a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a18:	05 98 00 00 00       	add    $0x98,%eax
80104a1d:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104a22:	74 1e                	je     80104a42 <wakeup+0x52>
    if(p->state == SLEEPING && p->chan == chan)
80104a24:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a28:	75 ee                	jne    80104a18 <wakeup+0x28>
80104a2a:	3b 58 24             	cmp    0x24(%eax),%ebx
80104a2d:	75 e9                	jne    80104a18 <wakeup+0x28>
      p->state = RUNNABLE;
80104a2f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104a36:	05 98 00 00 00       	add    $0x98,%eax
80104a3b:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104a40:	75 e2                	jne    80104a24 <wakeup+0x34>
  wakeup1(chan);
  release(&ptable.lock);
80104a42:	c7 45 08 60 3d 11 80 	movl   $0x80113d60,0x8(%ebp)
}
80104a49:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a4c:	c9                   	leave  
  release(&ptable.lock);
80104a4d:	e9 0e 07 00 00       	jmp    80105160 <release>
80104a52:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104a60 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104a60:	f3 0f 1e fb          	endbr32 
80104a64:	55                   	push   %ebp
80104a65:	89 e5                	mov    %esp,%ebp
80104a67:	53                   	push   %ebx
80104a68:	83 ec 10             	sub    $0x10,%esp
80104a6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104a6e:	68 60 3d 11 80       	push   $0x80113d60
80104a73:	e8 28 06 00 00       	call   801050a0 <acquire>
80104a78:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a7b:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
80104a80:	eb 12                	jmp    80104a94 <kill+0x34>
80104a82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a88:	05 98 00 00 00       	add    $0x98,%eax
80104a8d:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104a92:	74 34                	je     80104ac8 <kill+0x68>
    if(p->pid == pid){
80104a94:	39 58 10             	cmp    %ebx,0x10(%eax)
80104a97:	75 ef                	jne    80104a88 <kill+0x28>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104a99:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104a9d:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
      if(p->state == SLEEPING)
80104aa4:	75 07                	jne    80104aad <kill+0x4d>
        p->state = RUNNABLE;
80104aa6:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104aad:	83 ec 0c             	sub    $0xc,%esp
80104ab0:	68 60 3d 11 80       	push   $0x80113d60
80104ab5:	e8 a6 06 00 00       	call   80105160 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104aba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104abd:	83 c4 10             	add    $0x10,%esp
80104ac0:	31 c0                	xor    %eax,%eax
}
80104ac2:	c9                   	leave  
80104ac3:	c3                   	ret    
80104ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104ac8:	83 ec 0c             	sub    $0xc,%esp
80104acb:	68 60 3d 11 80       	push   $0x80113d60
80104ad0:	e8 8b 06 00 00       	call   80105160 <release>
}
80104ad5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ad8:	83 c4 10             	add    $0x10,%esp
80104adb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ae0:	c9                   	leave  
80104ae1:	c3                   	ret    
80104ae2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104af0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104af0:	f3 0f 1e fb          	endbr32 
80104af4:	55                   	push   %ebp
80104af5:	89 e5                	mov    %esp,%ebp
80104af7:	57                   	push   %edi
80104af8:	56                   	push   %esi
80104af9:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104afc:	53                   	push   %ebx
80104afd:	bb 04 3e 11 80       	mov    $0x80113e04,%ebx
80104b02:	83 ec 3c             	sub    $0x3c,%esp
80104b05:	eb 2b                	jmp    80104b32 <procdump+0x42>
80104b07:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b0e:	66 90                	xchg   %ax,%ax
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104b10:	83 ec 0c             	sub    $0xc,%esp
80104b13:	68 7d 84 10 80       	push   $0x8010847d
80104b18:	e8 93 bb ff ff       	call   801006b0 <cprintf>
80104b1d:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104b20:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104b26:	81 fb 04 64 11 80    	cmp    $0x80116404,%ebx
80104b2c:	0f 84 8e 00 00 00    	je     80104bc0 <procdump+0xd0>
    if(p->state == UNUSED)
80104b32:	8b 43 9c             	mov    -0x64(%ebx),%eax
80104b35:	85 c0                	test   %eax,%eax
80104b37:	74 e7                	je     80104b20 <procdump+0x30>
      state = "???";
80104b39:	ba 0d 85 10 80       	mov    $0x8010850d,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104b3e:	83 f8 05             	cmp    $0x5,%eax
80104b41:	77 11                	ja     80104b54 <procdump+0x64>
80104b43:	8b 14 85 6c 85 10 80 	mov    -0x7fef7a94(,%eax,4),%edx
      state = "???";
80104b4a:	b8 0d 85 10 80       	mov    $0x8010850d,%eax
80104b4f:	85 d2                	test   %edx,%edx
80104b51:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104b54:	53                   	push   %ebx
80104b55:	52                   	push   %edx
80104b56:	ff 73 a0             	pushl  -0x60(%ebx)
80104b59:	68 11 85 10 80       	push   $0x80108511
80104b5e:	e8 4d bb ff ff       	call   801006b0 <cprintf>
    if(p->state == SLEEPING){
80104b63:	83 c4 10             	add    $0x10,%esp
80104b66:	83 7b 9c 02          	cmpl   $0x2,-0x64(%ebx)
80104b6a:	75 a4                	jne    80104b10 <procdump+0x20>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104b6c:	83 ec 08             	sub    $0x8,%esp
80104b6f:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104b72:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104b75:	50                   	push   %eax
80104b76:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104b79:	8b 40 0c             	mov    0xc(%eax),%eax
80104b7c:	83 c0 08             	add    $0x8,%eax
80104b7f:	50                   	push   %eax
80104b80:	e8 bb 03 00 00       	call   80104f40 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
80104b85:	83 c4 10             	add    $0x10,%esp
80104b88:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b8f:	90                   	nop
80104b90:	8b 17                	mov    (%edi),%edx
80104b92:	85 d2                	test   %edx,%edx
80104b94:	0f 84 76 ff ff ff    	je     80104b10 <procdump+0x20>
        cprintf(" %p", pc[i]);
80104b9a:	83 ec 08             	sub    $0x8,%esp
80104b9d:	83 c7 04             	add    $0x4,%edi
80104ba0:	52                   	push   %edx
80104ba1:	68 e1 7e 10 80       	push   $0x80107ee1
80104ba6:	e8 05 bb ff ff       	call   801006b0 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104bab:	83 c4 10             	add    $0x10,%esp
80104bae:	39 fe                	cmp    %edi,%esi
80104bb0:	75 de                	jne    80104b90 <procdump+0xa0>
80104bb2:	e9 59 ff ff ff       	jmp    80104b10 <procdump+0x20>
80104bb7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bbe:	66 90                	xchg   %ax,%ax
  }
}
80104bc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104bc3:	5b                   	pop    %ebx
80104bc4:	5e                   	pop    %esi
80104bc5:	5f                   	pop    %edi
80104bc6:	5d                   	pop    %ebp
80104bc7:	c3                   	ret    
80104bc8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104bcf:	90                   	nop

80104bd0 <wait_sleeping>:


int
wait_sleeping(void)
{
80104bd0:	f3 0f 1e fb          	endbr32 
80104bd4:	55                   	push   %ebp
80104bd5:	89 e5                	mov    %esp,%ebp
80104bd7:	53                   	push   %ebx
80104bd8:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104bdb:	e8 c0 03 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104be0:	e8 1b f2 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104be5:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104beb:	e8 00 04 00 00       	call   80104ff0 <popcli>
    struct proc *p;
    int havekids, pid;
    struct proc *curproc = myproc();

    acquire(&ptable.lock);
80104bf0:	83 ec 0c             	sub    $0xc,%esp
80104bf3:	68 60 3d 11 80       	push   $0x80113d60
80104bf8:	e8 a3 04 00 00       	call   801050a0 <acquire>
80104bfd:	83 c4 10             	add    $0x10,%esp
    for(;;){
        // Scan through table looking for exited children.
        havekids = 0;
80104c00:	31 d2                	xor    %edx,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c02:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
80104c07:	eb 13                	jmp    80104c1c <wait_sleeping+0x4c>
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c10:	05 98 00 00 00       	add    $0x98,%eax
80104c15:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104c1a:	74 1c                	je     80104c38 <wait_sleeping+0x68>
            if(p->tracer != curproc)
80104c1c:	39 58 18             	cmp    %ebx,0x18(%eax)
80104c1f:	75 ef                	jne    80104c10 <wait_sleeping+0x40>
                continue;
            havekids = 1;
            if(p->state == SLEEPING){
80104c21:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c25:	74 39                	je     80104c60 <wait_sleeping+0x90>
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c27:	05 98 00 00 00       	add    $0x98,%eax
            havekids = 1;
80104c2c:	ba 01 00 00 00       	mov    $0x1,%edx
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c31:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104c36:	75 e4                	jne    80104c1c <wait_sleeping+0x4c>
                return pid;
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || curproc->killed){
80104c38:	85 d2                	test   %edx,%edx
80104c3a:	74 3e                	je     80104c7a <wait_sleeping+0xaa>
80104c3c:	8b 43 28             	mov    0x28(%ebx),%eax
80104c3f:	85 c0                	test   %eax,%eax
80104c41:	75 37                	jne    80104c7a <wait_sleeping+0xaa>
            release(&ptable.lock);
            return -1;
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(curproc, &ptable.lock);  //DOC: wait-sleep
80104c43:	83 ec 08             	sub    $0x8,%esp
80104c46:	68 60 3d 11 80       	push   $0x80113d60
80104c4b:	53                   	push   %ebx
80104c4c:	e8 df fb ff ff       	call   80104830 <sleep>
        havekids = 0;
80104c51:	83 c4 10             	add    $0x10,%esp
80104c54:	eb aa                	jmp    80104c00 <wait_sleeping+0x30>
80104c56:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c5d:	8d 76 00             	lea    0x0(%esi),%esi
                release(&ptable.lock);
80104c60:	83 ec 0c             	sub    $0xc,%esp
                pid = p->pid;
80104c63:	8b 58 10             	mov    0x10(%eax),%ebx
                release(&ptable.lock);
80104c66:	68 60 3d 11 80       	push   $0x80113d60
80104c6b:	e8 f0 04 00 00       	call   80105160 <release>
                return pid;
80104c70:	83 c4 10             	add    $0x10,%esp
    }
}
80104c73:	89 d8                	mov    %ebx,%eax
80104c75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104c78:	c9                   	leave  
80104c79:	c3                   	ret    
            release(&ptable.lock);
80104c7a:	83 ec 0c             	sub    $0xc,%esp
            return -1;
80104c7d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
            release(&ptable.lock);
80104c82:	68 60 3d 11 80       	push   $0x80113d60
80104c87:	e8 d4 04 00 00       	call   80105160 <release>
            return -1;
80104c8c:	83 c4 10             	add    $0x10,%esp
80104c8f:	eb e2                	jmp    80104c73 <wait_sleeping+0xa3>
80104c91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c98:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104c9f:	90                   	nop

80104ca0 <set_proc_tracer>:

int set_proc_tracer(void){
80104ca0:	f3 0f 1e fb          	endbr32 
80104ca4:	55                   	push   %ebp
80104ca5:	89 e5                	mov    %esp,%ebp
80104ca7:	56                   	push   %esi
80104ca8:	53                   	push   %ebx
    int pid;
    if(argint(0, &pid)<0)
80104ca9:	8d 45 f4             	lea    -0xc(%ebp),%eax
int set_proc_tracer(void){
80104cac:	83 ec 18             	sub    $0x18,%esp
    if(argint(0, &pid)<0)
80104caf:	50                   	push   %eax
80104cb0:	6a 00                	push   $0x0
80104cb2:	e8 d9 07 00 00       	call   80105490 <argint>
80104cb7:	83 c4 10             	add    $0x10,%esp
80104cba:	85 c0                	test   %eax,%eax
80104cbc:	0f 88 8a 00 00 00    	js     80104d4c <set_proc_tracer+0xac>
        return -1;

    struct proc* p;
    acquire(&ptable.lock);
80104cc2:	83 ec 0c             	sub    $0xc,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cc5:	bb 94 3d 11 80       	mov    $0x80113d94,%ebx
    acquire(&ptable.lock);
80104cca:	68 60 3d 11 80       	push   $0x80113d60
80104ccf:	e8 cc 03 00 00       	call   801050a0 <acquire>
        if(p->pid != pid)
80104cd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cd7:	83 c4 10             	add    $0x10,%esp
80104cda:	eb 12                	jmp    80104cee <set_proc_tracer+0x4e>
80104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ce0:	81 c3 98 00 00 00    	add    $0x98,%ebx
80104ce6:	81 fb 94 63 11 80    	cmp    $0x80116394,%ebx
80104cec:	74 42                	je     80104d30 <set_proc_tracer+0x90>
        if(p->pid != pid)
80104cee:	39 43 10             	cmp    %eax,0x10(%ebx)
80104cf1:	75 ed                	jne    80104ce0 <set_proc_tracer+0x40>
            continue;
        if(!p->tracer){
80104cf3:	8b 53 18             	mov    0x18(%ebx),%edx
80104cf6:	85 d2                	test   %edx,%edx
80104cf8:	75 e6                	jne    80104ce0 <set_proc_tracer+0x40>
  pushcli();
80104cfa:	e8 a1 02 00 00       	call   80104fa0 <pushcli>
  c = mycpu();
80104cff:	e8 fc f0 ff ff       	call   80103e00 <mycpu>
  p = c->proc;
80104d04:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104d0a:	e8 e1 02 00 00       	call   80104ff0 <popcli>
            p->tracer = myproc();
            release(&ptable.lock);
80104d0f:	83 ec 0c             	sub    $0xc,%esp
80104d12:	68 60 3d 11 80       	push   $0x80113d60
            p->tracer = myproc();
80104d17:	89 73 18             	mov    %esi,0x18(%ebx)
            release(&ptable.lock);
80104d1a:	e8 41 04 00 00       	call   80105160 <release>
            return pid;
80104d1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d22:	83 c4 10             	add    $0x10,%esp
        }
    }
    release(&ptable.lock);
    return -1;
}
80104d25:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d28:	5b                   	pop    %ebx
80104d29:	5e                   	pop    %esi
80104d2a:	5d                   	pop    %ebp
80104d2b:	c3                   	ret    
80104d2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    release(&ptable.lock);
80104d30:	83 ec 0c             	sub    $0xc,%esp
80104d33:	68 60 3d 11 80       	push   $0x80113d60
80104d38:	e8 23 04 00 00       	call   80105160 <release>
    return -1;
80104d3d:	83 c4 10             	add    $0x10,%esp
}
80104d40:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104d43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d48:	5b                   	pop    %ebx
80104d49:	5e                   	pop    %esi
80104d4a:	5d                   	pop    %ebp
80104d4b:	c3                   	ret    
        return -1;
80104d4c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d51:	eb d2                	jmp    80104d25 <set_proc_tracer+0x85>
80104d53:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104d5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104d60 <get_proc_queue_level>:

int get_proc_queue_level(int pid){
80104d60:	f3 0f 1e fb          	endbr32 
80104d64:	55                   	push   %ebp
    struct proc* p;

//    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
//        cprintf("PID %d's level: %d\n", p->pid, p->level);
//    }
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
80104d65:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
int get_proc_queue_level(int pid){
80104d6a:	89 e5                	mov    %esp,%ebp
80104d6c:	8b 55 08             	mov    0x8(%ebp),%edx
80104d6f:	eb 13                	jmp    80104d84 <get_proc_queue_level+0x24>
80104d71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++) {
80104d78:	05 98 00 00 00       	add    $0x98,%eax
80104d7d:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104d82:	74 14                	je     80104d98 <get_proc_queue_level+0x38>
        if (p->pid == pid)
80104d84:	39 50 10             	cmp    %edx,0x10(%eax)
80104d87:	75 ef                	jne    80104d78 <get_proc_queue_level+0x18>
            return p->level;
80104d89:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
    }
    return -1;
}
80104d8f:	5d                   	pop    %ebp
80104d90:	c3                   	ret    
80104d91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104d9d:	5d                   	pop    %ebp
80104d9e:	c3                   	ret    
80104d9f:	90                   	nop

80104da0 <set_proc_queue_level>:

void set_proc_queue_level(int pid, int target_level){
80104da0:	f3 0f 1e fb          	endbr32 
80104da4:	55                   	push   %ebp
    struct proc* p;

    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104da5:	b8 94 3d 11 80       	mov    $0x80113d94,%eax
void set_proc_queue_level(int pid, int target_level){
80104daa:	89 e5                	mov    %esp,%ebp
80104dac:	8b 55 08             	mov    0x8(%ebp),%edx
80104daf:	eb 13                	jmp    80104dc4 <set_proc_queue_level+0x24>
80104db1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p != &ptable.proc[NPROC]; p++)
80104db8:	05 98 00 00 00       	add    $0x98,%eax
80104dbd:	3d 94 63 11 80       	cmp    $0x80116394,%eax
80104dc2:	74 0e                	je     80104dd2 <set_proc_queue_level+0x32>
        if(p->pid == pid){
80104dc4:	39 50 10             	cmp    %edx,0x10(%eax)
80104dc7:	75 ef                	jne    80104db8 <set_proc_queue_level+0x18>
            p->level = target_level;
80104dc9:	8b 55 0c             	mov    0xc(%ebp),%edx
80104dcc:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
            return;
        }
}
80104dd2:	5d                   	pop    %ebp
80104dd3:	c3                   	ret    
80104dd4:	66 90                	xchg   %ax,%ax
80104dd6:	66 90                	xchg   %ax,%ax
80104dd8:	66 90                	xchg   %ax,%ax
80104dda:	66 90                	xchg   %ax,%ax
80104ddc:	66 90                	xchg   %ax,%ax
80104dde:	66 90                	xchg   %ax,%ax

80104de0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104de0:	f3 0f 1e fb          	endbr32 
80104de4:	55                   	push   %ebp
80104de5:	89 e5                	mov    %esp,%ebp
80104de7:	53                   	push   %ebx
80104de8:	83 ec 0c             	sub    $0xc,%esp
80104deb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
80104dee:	68 8c 85 10 80       	push   $0x8010858c
80104df3:	8d 43 04             	lea    0x4(%ebx),%eax
80104df6:	50                   	push   %eax
80104df7:	e8 24 01 00 00       	call   80104f20 <initlock>
  lk->name = name;
80104dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
80104dff:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104e05:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104e08:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
80104e0f:	89 43 38             	mov    %eax,0x38(%ebx)
}
80104e12:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e15:	c9                   	leave  
80104e16:	c3                   	ret    
80104e17:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104e1e:	66 90                	xchg   %ax,%ax

80104e20 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104e20:	f3 0f 1e fb          	endbr32 
80104e24:	55                   	push   %ebp
80104e25:	89 e5                	mov    %esp,%ebp
80104e27:	56                   	push   %esi
80104e28:	53                   	push   %ebx
80104e29:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e2c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e2f:	83 ec 0c             	sub    $0xc,%esp
80104e32:	56                   	push   %esi
80104e33:	e8 68 02 00 00       	call   801050a0 <acquire>
  while (lk->locked) {
80104e38:	8b 13                	mov    (%ebx),%edx
80104e3a:	83 c4 10             	add    $0x10,%esp
80104e3d:	85 d2                	test   %edx,%edx
80104e3f:	74 1a                	je     80104e5b <acquiresleep+0x3b>
80104e41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(lk, &lk->lk);
80104e48:	83 ec 08             	sub    $0x8,%esp
80104e4b:	56                   	push   %esi
80104e4c:	53                   	push   %ebx
80104e4d:	e8 de f9 ff ff       	call   80104830 <sleep>
  while (lk->locked) {
80104e52:	8b 03                	mov    (%ebx),%eax
80104e54:	83 c4 10             	add    $0x10,%esp
80104e57:	85 c0                	test   %eax,%eax
80104e59:	75 ed                	jne    80104e48 <acquiresleep+0x28>
  }
  lk->locked = 1;
80104e5b:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104e61:	e8 2a f0 ff ff       	call   80103e90 <myproc>
80104e66:	8b 40 10             	mov    0x10(%eax),%eax
80104e69:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104e6c:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104e6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e72:	5b                   	pop    %ebx
80104e73:	5e                   	pop    %esi
80104e74:	5d                   	pop    %ebp
  release(&lk->lk);
80104e75:	e9 e6 02 00 00       	jmp    80105160 <release>
80104e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e80 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104e80:	f3 0f 1e fb          	endbr32 
80104e84:	55                   	push   %ebp
80104e85:	89 e5                	mov    %esp,%ebp
80104e87:	56                   	push   %esi
80104e88:	53                   	push   %ebx
80104e89:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104e8c:	8d 73 04             	lea    0x4(%ebx),%esi
80104e8f:	83 ec 0c             	sub    $0xc,%esp
80104e92:	56                   	push   %esi
80104e93:	e8 08 02 00 00       	call   801050a0 <acquire>
  lk->locked = 0;
80104e98:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
80104e9e:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104ea5:	89 1c 24             	mov    %ebx,(%esp)
80104ea8:	e8 43 fb ff ff       	call   801049f0 <wakeup>
  release(&lk->lk);
80104ead:	89 75 08             	mov    %esi,0x8(%ebp)
80104eb0:	83 c4 10             	add    $0x10,%esp
}
80104eb3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104eb6:	5b                   	pop    %ebx
80104eb7:	5e                   	pop    %esi
80104eb8:	5d                   	pop    %ebp
  release(&lk->lk);
80104eb9:	e9 a2 02 00 00       	jmp    80105160 <release>
80104ebe:	66 90                	xchg   %ax,%ax

80104ec0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104ec0:	f3 0f 1e fb          	endbr32 
80104ec4:	55                   	push   %ebp
80104ec5:	89 e5                	mov    %esp,%ebp
80104ec7:	57                   	push   %edi
80104ec8:	31 ff                	xor    %edi,%edi
80104eca:	56                   	push   %esi
80104ecb:	53                   	push   %ebx
80104ecc:	83 ec 18             	sub    $0x18,%esp
80104ecf:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
80104ed2:	8d 73 04             	lea    0x4(%ebx),%esi
80104ed5:	56                   	push   %esi
80104ed6:	e8 c5 01 00 00       	call   801050a0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104edb:	8b 03                	mov    (%ebx),%eax
80104edd:	83 c4 10             	add    $0x10,%esp
80104ee0:	85 c0                	test   %eax,%eax
80104ee2:	75 1c                	jne    80104f00 <holdingsleep+0x40>
  release(&lk->lk);
80104ee4:	83 ec 0c             	sub    $0xc,%esp
80104ee7:	56                   	push   %esi
80104ee8:	e8 73 02 00 00       	call   80105160 <release>
  return r;
}
80104eed:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ef0:	89 f8                	mov    %edi,%eax
80104ef2:	5b                   	pop    %ebx
80104ef3:	5e                   	pop    %esi
80104ef4:	5f                   	pop    %edi
80104ef5:	5d                   	pop    %ebp
80104ef6:	c3                   	ret    
80104ef7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104efe:	66 90                	xchg   %ax,%ax
  r = lk->locked && (lk->pid == myproc()->pid);
80104f00:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104f03:	e8 88 ef ff ff       	call   80103e90 <myproc>
80104f08:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f0b:	0f 94 c0             	sete   %al
80104f0e:	0f b6 c0             	movzbl %al,%eax
80104f11:	89 c7                	mov    %eax,%edi
80104f13:	eb cf                	jmp    80104ee4 <holdingsleep+0x24>
80104f15:	66 90                	xchg   %ax,%ax
80104f17:	66 90                	xchg   %ax,%ax
80104f19:	66 90                	xchg   %ax,%ax
80104f1b:	66 90                	xchg   %ax,%ax
80104f1d:	66 90                	xchg   %ax,%ax
80104f1f:	90                   	nop

80104f20 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104f20:	f3 0f 1e fb          	endbr32 
80104f24:	55                   	push   %ebp
80104f25:	89 e5                	mov    %esp,%ebp
80104f27:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104f2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104f2d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
80104f33:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104f36:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104f3d:	5d                   	pop    %ebp
80104f3e:	c3                   	ret    
80104f3f:	90                   	nop

80104f40 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104f40:	f3 0f 1e fb          	endbr32 
80104f44:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
80104f45:	31 d2                	xor    %edx,%edx
{
80104f47:	89 e5                	mov    %esp,%ebp
80104f49:	53                   	push   %ebx
  ebp = (uint*)v - 2;
80104f4a:	8b 45 08             	mov    0x8(%ebp),%eax
{
80104f4d:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
80104f50:	83 e8 08             	sub    $0x8,%eax
  for(i = 0; i < 10; i++){
80104f53:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104f57:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104f58:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104f5e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104f64:	77 1a                	ja     80104f80 <getcallerpcs+0x40>
      break;
    pcs[i] = ebp[1];     // saved %eip
80104f66:	8b 58 04             	mov    0x4(%eax),%ebx
80104f69:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
80104f6c:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104f6f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104f71:	83 fa 0a             	cmp    $0xa,%edx
80104f74:	75 e2                	jne    80104f58 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
80104f76:	5b                   	pop    %ebx
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret    
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(; i < 10; i++)
80104f80:	8d 04 91             	lea    (%ecx,%edx,4),%eax
80104f83:	8d 51 28             	lea    0x28(%ecx),%edx
80104f86:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104f8d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104f90:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104f96:	83 c0 04             	add    $0x4,%eax
80104f99:	39 d0                	cmp    %edx,%eax
80104f9b:	75 f3                	jne    80104f90 <getcallerpcs+0x50>
}
80104f9d:	5b                   	pop    %ebx
80104f9e:	5d                   	pop    %ebp
80104f9f:	c3                   	ret    

80104fa0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104fa0:	f3 0f 1e fb          	endbr32 
80104fa4:	55                   	push   %ebp
80104fa5:	89 e5                	mov    %esp,%ebp
80104fa7:	53                   	push   %ebx
80104fa8:	83 ec 04             	sub    $0x4,%esp
80104fab:	9c                   	pushf  
80104fac:	5b                   	pop    %ebx
  asm volatile("cli");
80104fad:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
80104fae:	e8 4d ee ff ff       	call   80103e00 <mycpu>
80104fb3:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104fb9:	85 c0                	test   %eax,%eax
80104fbb:	74 13                	je     80104fd0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104fbd:	e8 3e ee ff ff       	call   80103e00 <mycpu>
80104fc2:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104fc9:	83 c4 04             	add    $0x4,%esp
80104fcc:	5b                   	pop    %ebx
80104fcd:	5d                   	pop    %ebp
80104fce:	c3                   	ret    
80104fcf:	90                   	nop
    mycpu()->intena = eflags & FL_IF;
80104fd0:	e8 2b ee ff ff       	call   80103e00 <mycpu>
80104fd5:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104fdb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104fe1:	eb da                	jmp    80104fbd <pushcli+0x1d>
80104fe3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104ff0 <popcli>:

void
popcli(void)
{
80104ff0:	f3 0f 1e fb          	endbr32 
80104ff4:	55                   	push   %ebp
80104ff5:	89 e5                	mov    %esp,%ebp
80104ff7:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104ffa:	9c                   	pushf  
80104ffb:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104ffc:	f6 c4 02             	test   $0x2,%ah
80104fff:	75 31                	jne    80105032 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
80105001:	e8 fa ed ff ff       	call   80103e00 <mycpu>
80105006:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
8010500d:	78 30                	js     8010503f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010500f:	e8 ec ed ff ff       	call   80103e00 <mycpu>
80105014:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010501a:	85 d2                	test   %edx,%edx
8010501c:	74 02                	je     80105020 <popcli+0x30>
    sti();
}
8010501e:	c9                   	leave  
8010501f:	c3                   	ret    
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105020:	e8 db ed ff ff       	call   80103e00 <mycpu>
80105025:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010502b:	85 c0                	test   %eax,%eax
8010502d:	74 ef                	je     8010501e <popcli+0x2e>
  asm volatile("sti");
8010502f:	fb                   	sti    
}
80105030:	c9                   	leave  
80105031:	c3                   	ret    
    panic("popcli - interruptible");
80105032:	83 ec 0c             	sub    $0xc,%esp
80105035:	68 97 85 10 80       	push   $0x80108597
8010503a:	e8 51 b3 ff ff       	call   80100390 <panic>
    panic("popcli");
8010503f:	83 ec 0c             	sub    $0xc,%esp
80105042:	68 ae 85 10 80       	push   $0x801085ae
80105047:	e8 44 b3 ff ff       	call   80100390 <panic>
8010504c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105050 <holding>:
{
80105050:	f3 0f 1e fb          	endbr32 
80105054:	55                   	push   %ebp
80105055:	89 e5                	mov    %esp,%ebp
80105057:	56                   	push   %esi
80105058:	53                   	push   %ebx
80105059:	8b 75 08             	mov    0x8(%ebp),%esi
8010505c:	31 db                	xor    %ebx,%ebx
  pushcli();
8010505e:	e8 3d ff ff ff       	call   80104fa0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80105063:	8b 06                	mov    (%esi),%eax
80105065:	85 c0                	test   %eax,%eax
80105067:	75 0f                	jne    80105078 <holding+0x28>
  popcli();
80105069:	e8 82 ff ff ff       	call   80104ff0 <popcli>
}
8010506e:	89 d8                	mov    %ebx,%eax
80105070:	5b                   	pop    %ebx
80105071:	5e                   	pop    %esi
80105072:	5d                   	pop    %ebp
80105073:	c3                   	ret    
80105074:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  r = lock->locked && lock->cpu == mycpu();
80105078:	8b 5e 08             	mov    0x8(%esi),%ebx
8010507b:	e8 80 ed ff ff       	call   80103e00 <mycpu>
80105080:	39 c3                	cmp    %eax,%ebx
80105082:	0f 94 c3             	sete   %bl
  popcli();
80105085:	e8 66 ff ff ff       	call   80104ff0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
8010508a:	0f b6 db             	movzbl %bl,%ebx
}
8010508d:	89 d8                	mov    %ebx,%eax
8010508f:	5b                   	pop    %ebx
80105090:	5e                   	pop    %esi
80105091:	5d                   	pop    %ebp
80105092:	c3                   	ret    
80105093:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801050a0 <acquire>:
{
801050a0:	f3 0f 1e fb          	endbr32 
801050a4:	55                   	push   %ebp
801050a5:	89 e5                	mov    %esp,%ebp
801050a7:	56                   	push   %esi
801050a8:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801050a9:	e8 f2 fe ff ff       	call   80104fa0 <pushcli>
  if(holding(lk))
801050ae:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050b1:	83 ec 0c             	sub    $0xc,%esp
801050b4:	53                   	push   %ebx
801050b5:	e8 96 ff ff ff       	call   80105050 <holding>
801050ba:	83 c4 10             	add    $0x10,%esp
801050bd:	85 c0                	test   %eax,%eax
801050bf:	0f 85 7f 00 00 00    	jne    80105144 <acquire+0xa4>
801050c5:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
801050c7:	ba 01 00 00 00       	mov    $0x1,%edx
801050cc:	eb 05                	jmp    801050d3 <acquire+0x33>
801050ce:	66 90                	xchg   %ax,%ax
801050d0:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050d3:	89 d0                	mov    %edx,%eax
801050d5:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
801050d8:	85 c0                	test   %eax,%eax
801050da:	75 f4                	jne    801050d0 <acquire+0x30>
  __sync_synchronize();
801050dc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801050e1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801050e4:	e8 17 ed ff ff       	call   80103e00 <mycpu>
801050e9:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
801050ec:	89 e8                	mov    %ebp,%eax
801050ee:	66 90                	xchg   %ax,%ax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801050f0:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801050f6:	81 fa fe ff ff 7f    	cmp    $0x7ffffffe,%edx
801050fc:	77 22                	ja     80105120 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
801050fe:	8b 50 04             	mov    0x4(%eax),%edx
80105101:	89 54 b3 0c          	mov    %edx,0xc(%ebx,%esi,4)
  for(i = 0; i < 10; i++){
80105105:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
80105108:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
8010510a:	83 fe 0a             	cmp    $0xa,%esi
8010510d:	75 e1                	jne    801050f0 <acquire+0x50>
}
8010510f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105112:	5b                   	pop    %ebx
80105113:	5e                   	pop    %esi
80105114:	5d                   	pop    %ebp
80105115:	c3                   	ret    
80105116:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
  for(; i < 10; i++)
80105120:	8d 44 b3 0c          	lea    0xc(%ebx,%esi,4),%eax
80105124:	83 c3 34             	add    $0x34,%ebx
80105127:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010512e:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80105130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105136:	83 c0 04             	add    $0x4,%eax
80105139:	39 d8                	cmp    %ebx,%eax
8010513b:	75 f3                	jne    80105130 <acquire+0x90>
}
8010513d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105140:	5b                   	pop    %ebx
80105141:	5e                   	pop    %esi
80105142:	5d                   	pop    %ebp
80105143:	c3                   	ret    
    panic("acquire");
80105144:	83 ec 0c             	sub    $0xc,%esp
80105147:	68 b5 85 10 80       	push   $0x801085b5
8010514c:	e8 3f b2 ff ff       	call   80100390 <panic>
80105151:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105158:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010515f:	90                   	nop

80105160 <release>:
{
80105160:	f3 0f 1e fb          	endbr32 
80105164:	55                   	push   %ebp
80105165:	89 e5                	mov    %esp,%ebp
80105167:	53                   	push   %ebx
80105168:	83 ec 10             	sub    $0x10,%esp
8010516b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
8010516e:	53                   	push   %ebx
8010516f:	e8 dc fe ff ff       	call   80105050 <holding>
80105174:	83 c4 10             	add    $0x10,%esp
80105177:	85 c0                	test   %eax,%eax
80105179:	74 22                	je     8010519d <release+0x3d>
  lk->pcs[0] = 0;
8010517b:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80105182:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80105189:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010518e:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80105194:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105197:	c9                   	leave  
  popcli();
80105198:	e9 53 fe ff ff       	jmp    80104ff0 <popcli>
    panic("release");
8010519d:	83 ec 0c             	sub    $0xc,%esp
801051a0:	68 bd 85 10 80       	push   $0x801085bd
801051a5:	e8 e6 b1 ff ff       	call   80100390 <panic>
801051aa:	66 90                	xchg   %ax,%ax
801051ac:	66 90                	xchg   %ax,%ax
801051ae:	66 90                	xchg   %ax,%ax

801051b0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801051b0:	f3 0f 1e fb          	endbr32 
801051b4:	55                   	push   %ebp
801051b5:	89 e5                	mov    %esp,%ebp
801051b7:	57                   	push   %edi
801051b8:	8b 55 08             	mov    0x8(%ebp),%edx
801051bb:	8b 4d 10             	mov    0x10(%ebp),%ecx
801051be:	53                   	push   %ebx
801051bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  if ((int)dst%4 == 0 && n%4 == 0){
801051c2:	89 d7                	mov    %edx,%edi
801051c4:	09 cf                	or     %ecx,%edi
801051c6:	83 e7 03             	and    $0x3,%edi
801051c9:	75 25                	jne    801051f0 <memset+0x40>
    c &= 0xFF;
801051cb:	0f b6 f8             	movzbl %al,%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801051ce:	c1 e0 18             	shl    $0x18,%eax
801051d1:	89 fb                	mov    %edi,%ebx
801051d3:	c1 e9 02             	shr    $0x2,%ecx
801051d6:	c1 e3 10             	shl    $0x10,%ebx
801051d9:	09 d8                	or     %ebx,%eax
801051db:	09 f8                	or     %edi,%eax
801051dd:	c1 e7 08             	shl    $0x8,%edi
801051e0:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
801051e2:	89 d7                	mov    %edx,%edi
801051e4:	fc                   	cld    
801051e5:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801051e7:	5b                   	pop    %ebx
801051e8:	89 d0                	mov    %edx,%eax
801051ea:	5f                   	pop    %edi
801051eb:	5d                   	pop    %ebp
801051ec:	c3                   	ret    
801051ed:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("cld; rep stosb" :
801051f0:	89 d7                	mov    %edx,%edi
801051f2:	fc                   	cld    
801051f3:	f3 aa                	rep stos %al,%es:(%edi)
801051f5:	5b                   	pop    %ebx
801051f6:	89 d0                	mov    %edx,%eax
801051f8:	5f                   	pop    %edi
801051f9:	5d                   	pop    %ebp
801051fa:	c3                   	ret    
801051fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801051ff:	90                   	nop

80105200 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105200:	f3 0f 1e fb          	endbr32 
80105204:	55                   	push   %ebp
80105205:	89 e5                	mov    %esp,%ebp
80105207:	56                   	push   %esi
80105208:	8b 75 10             	mov    0x10(%ebp),%esi
8010520b:	8b 55 08             	mov    0x8(%ebp),%edx
8010520e:	53                   	push   %ebx
8010520f:	8b 45 0c             	mov    0xc(%ebp),%eax
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80105212:	85 f6                	test   %esi,%esi
80105214:	74 2a                	je     80105240 <memcmp+0x40>
80105216:	01 c6                	add    %eax,%esi
80105218:	eb 10                	jmp    8010522a <memcmp+0x2a>
8010521a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105220:	83 c0 01             	add    $0x1,%eax
80105223:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105226:	39 f0                	cmp    %esi,%eax
80105228:	74 16                	je     80105240 <memcmp+0x40>
    if(*s1 != *s2)
8010522a:	0f b6 0a             	movzbl (%edx),%ecx
8010522d:	0f b6 18             	movzbl (%eax),%ebx
80105230:	38 d9                	cmp    %bl,%cl
80105232:	74 ec                	je     80105220 <memcmp+0x20>
      return *s1 - *s2;
80105234:	0f b6 c1             	movzbl %cl,%eax
80105237:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105239:	5b                   	pop    %ebx
8010523a:	5e                   	pop    %esi
8010523b:	5d                   	pop    %ebp
8010523c:	c3                   	ret    
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
80105240:	5b                   	pop    %ebx
  return 0;
80105241:	31 c0                	xor    %eax,%eax
}
80105243:	5e                   	pop    %esi
80105244:	5d                   	pop    %ebp
80105245:	c3                   	ret    
80105246:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010524d:	8d 76 00             	lea    0x0(%esi),%esi

80105250 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105250:	f3 0f 1e fb          	endbr32 
80105254:	55                   	push   %ebp
80105255:	89 e5                	mov    %esp,%ebp
80105257:	57                   	push   %edi
80105258:	8b 55 08             	mov    0x8(%ebp),%edx
8010525b:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010525e:	56                   	push   %esi
8010525f:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80105262:	39 d6                	cmp    %edx,%esi
80105264:	73 2a                	jae    80105290 <memmove+0x40>
80105266:	8d 3c 0e             	lea    (%esi,%ecx,1),%edi
80105269:	39 fa                	cmp    %edi,%edx
8010526b:	73 23                	jae    80105290 <memmove+0x40>
8010526d:	8d 41 ff             	lea    -0x1(%ecx),%eax
    s += n;
    d += n;
    while(n-- > 0)
80105270:	85 c9                	test   %ecx,%ecx
80105272:	74 13                	je     80105287 <memmove+0x37>
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      *--d = *--s;
80105278:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
8010527c:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
8010527f:	83 e8 01             	sub    $0x1,%eax
80105282:	83 f8 ff             	cmp    $0xffffffff,%eax
80105285:	75 f1                	jne    80105278 <memmove+0x28>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80105287:	5e                   	pop    %esi
80105288:	89 d0                	mov    %edx,%eax
8010528a:	5f                   	pop    %edi
8010528b:	5d                   	pop    %ebp
8010528c:	c3                   	ret    
8010528d:	8d 76 00             	lea    0x0(%esi),%esi
    while(n-- > 0)
80105290:	8d 04 0e             	lea    (%esi,%ecx,1),%eax
80105293:	89 d7                	mov    %edx,%edi
80105295:	85 c9                	test   %ecx,%ecx
80105297:	74 ee                	je     80105287 <memmove+0x37>
80105299:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801052a0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801052a1:	39 f0                	cmp    %esi,%eax
801052a3:	75 fb                	jne    801052a0 <memmove+0x50>
}
801052a5:	5e                   	pop    %esi
801052a6:	89 d0                	mov    %edx,%eax
801052a8:	5f                   	pop    %edi
801052a9:	5d                   	pop    %ebp
801052aa:	c3                   	ret    
801052ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801052af:	90                   	nop

801052b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801052b0:	f3 0f 1e fb          	endbr32 
  return memmove(dst, src, n);
801052b4:	eb 9a                	jmp    80105250 <memmove>
801052b6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801052bd:	8d 76 00             	lea    0x0(%esi),%esi

801052c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801052c0:	f3 0f 1e fb          	endbr32 
801052c4:	55                   	push   %ebp
801052c5:	89 e5                	mov    %esp,%ebp
801052c7:	56                   	push   %esi
801052c8:	8b 75 10             	mov    0x10(%ebp),%esi
801052cb:	8b 4d 08             	mov    0x8(%ebp),%ecx
801052ce:	53                   	push   %ebx
801052cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  while(n > 0 && *p && *p == *q)
801052d2:	85 f6                	test   %esi,%esi
801052d4:	74 32                	je     80105308 <strncmp+0x48>
801052d6:	01 c6                	add    %eax,%esi
801052d8:	eb 14                	jmp    801052ee <strncmp+0x2e>
801052da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801052e0:	38 da                	cmp    %bl,%dl
801052e2:	75 14                	jne    801052f8 <strncmp+0x38>
    n--, p++, q++;
801052e4:	83 c0 01             	add    $0x1,%eax
801052e7:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801052ea:	39 f0                	cmp    %esi,%eax
801052ec:	74 1a                	je     80105308 <strncmp+0x48>
801052ee:	0f b6 11             	movzbl (%ecx),%edx
801052f1:	0f b6 18             	movzbl (%eax),%ebx
801052f4:	84 d2                	test   %dl,%dl
801052f6:	75 e8                	jne    801052e0 <strncmp+0x20>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801052f8:	0f b6 c2             	movzbl %dl,%eax
801052fb:	29 d8                	sub    %ebx,%eax
}
801052fd:	5b                   	pop    %ebx
801052fe:	5e                   	pop    %esi
801052ff:	5d                   	pop    %ebp
80105300:	c3                   	ret    
80105301:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105308:	5b                   	pop    %ebx
    return 0;
80105309:	31 c0                	xor    %eax,%eax
}
8010530b:	5e                   	pop    %esi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret    
8010530e:	66 90                	xchg   %ax,%ax

80105310 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105310:	f3 0f 1e fb          	endbr32 
80105314:	55                   	push   %ebp
80105315:	89 e5                	mov    %esp,%ebp
80105317:	57                   	push   %edi
80105318:	56                   	push   %esi
80105319:	8b 75 08             	mov    0x8(%ebp),%esi
8010531c:	53                   	push   %ebx
8010531d:	8b 45 10             	mov    0x10(%ebp),%eax
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80105320:	89 f2                	mov    %esi,%edx
80105322:	eb 1b                	jmp    8010533f <strncpy+0x2f>
80105324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105328:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
8010532c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010532f:	83 c2 01             	add    $0x1,%edx
80105332:	0f b6 7f ff          	movzbl -0x1(%edi),%edi
80105336:	89 f9                	mov    %edi,%ecx
80105338:	88 4a ff             	mov    %cl,-0x1(%edx)
8010533b:	84 c9                	test   %cl,%cl
8010533d:	74 09                	je     80105348 <strncpy+0x38>
8010533f:	89 c3                	mov    %eax,%ebx
80105341:	83 e8 01             	sub    $0x1,%eax
80105344:	85 db                	test   %ebx,%ebx
80105346:	7f e0                	jg     80105328 <strncpy+0x18>
    ;
  while(n-- > 0)
80105348:	89 d1                	mov    %edx,%ecx
8010534a:	85 c0                	test   %eax,%eax
8010534c:	7e 15                	jle    80105363 <strncpy+0x53>
8010534e:	66 90                	xchg   %ax,%ax
    *s++ = 0;
80105350:	83 c1 01             	add    $0x1,%ecx
80105353:	c6 41 ff 00          	movb   $0x0,-0x1(%ecx)
  while(n-- > 0)
80105357:	89 c8                	mov    %ecx,%eax
80105359:	f7 d0                	not    %eax
8010535b:	01 d0                	add    %edx,%eax
8010535d:	01 d8                	add    %ebx,%eax
8010535f:	85 c0                	test   %eax,%eax
80105361:	7f ed                	jg     80105350 <strncpy+0x40>
  return os;
}
80105363:	5b                   	pop    %ebx
80105364:	89 f0                	mov    %esi,%eax
80105366:	5e                   	pop    %esi
80105367:	5f                   	pop    %edi
80105368:	5d                   	pop    %ebp
80105369:	c3                   	ret    
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105370 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105370:	f3 0f 1e fb          	endbr32 
80105374:	55                   	push   %ebp
80105375:	89 e5                	mov    %esp,%ebp
80105377:	56                   	push   %esi
80105378:	8b 55 10             	mov    0x10(%ebp),%edx
8010537b:	8b 75 08             	mov    0x8(%ebp),%esi
8010537e:	53                   	push   %ebx
8010537f:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80105382:	85 d2                	test   %edx,%edx
80105384:	7e 21                	jle    801053a7 <safestrcpy+0x37>
80105386:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
8010538a:	89 f2                	mov    %esi,%edx
8010538c:	eb 12                	jmp    801053a0 <safestrcpy+0x30>
8010538e:	66 90                	xchg   %ax,%ax
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105390:	0f b6 08             	movzbl (%eax),%ecx
80105393:	83 c0 01             	add    $0x1,%eax
80105396:	83 c2 01             	add    $0x1,%edx
80105399:	88 4a ff             	mov    %cl,-0x1(%edx)
8010539c:	84 c9                	test   %cl,%cl
8010539e:	74 04                	je     801053a4 <safestrcpy+0x34>
801053a0:	39 d8                	cmp    %ebx,%eax
801053a2:	75 ec                	jne    80105390 <safestrcpy+0x20>
    ;
  *s = 0;
801053a4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801053a7:	89 f0                	mov    %esi,%eax
801053a9:	5b                   	pop    %ebx
801053aa:	5e                   	pop    %esi
801053ab:	5d                   	pop    %ebp
801053ac:	c3                   	ret    
801053ad:	8d 76 00             	lea    0x0(%esi),%esi

801053b0 <strlen>:

int
strlen(const char *s)
{
801053b0:	f3 0f 1e fb          	endbr32 
801053b4:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801053b5:	31 c0                	xor    %eax,%eax
{
801053b7:	89 e5                	mov    %esp,%ebp
801053b9:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801053bc:	80 3a 00             	cmpb   $0x0,(%edx)
801053bf:	74 10                	je     801053d1 <strlen+0x21>
801053c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801053c8:	83 c0 01             	add    $0x1,%eax
801053cb:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801053cf:	75 f7                	jne    801053c8 <strlen+0x18>
    ;
  return n;
}
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret    

801053d3 <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801053d3:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801053d7:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801053db:	55                   	push   %ebp
  pushl %ebx
801053dc:	53                   	push   %ebx
  pushl %esi
801053dd:	56                   	push   %esi
  pushl %edi
801053de:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801053df:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801053e1:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801053e3:	5f                   	pop    %edi
  popl %esi
801053e4:	5e                   	pop    %esi
  popl %ebx
801053e5:	5b                   	pop    %ebx
  popl %ebp
801053e6:	5d                   	pop    %ebp
  ret
801053e7:	c3                   	ret    
801053e8:	66 90                	xchg   %ax,%ax
801053ea:	66 90                	xchg   %ax,%ax
801053ec:	66 90                	xchg   %ax,%ax
801053ee:	66 90                	xchg   %ax,%ax

801053f0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801053f0:	f3 0f 1e fb          	endbr32 
801053f4:	55                   	push   %ebp
801053f5:	89 e5                	mov    %esp,%ebp
801053f7:	53                   	push   %ebx
801053f8:	83 ec 04             	sub    $0x4,%esp
801053fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801053fe:	e8 8d ea ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105403:	8b 00                	mov    (%eax),%eax
80105405:	39 d8                	cmp    %ebx,%eax
80105407:	76 17                	jbe    80105420 <fetchint+0x30>
80105409:	8d 53 04             	lea    0x4(%ebx),%edx
8010540c:	39 d0                	cmp    %edx,%eax
8010540e:	72 10                	jb     80105420 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80105410:	8b 45 0c             	mov    0xc(%ebp),%eax
80105413:	8b 13                	mov    (%ebx),%edx
80105415:	89 10                	mov    %edx,(%eax)
  return 0;
80105417:	31 c0                	xor    %eax,%eax
}
80105419:	83 c4 04             	add    $0x4,%esp
8010541c:	5b                   	pop    %ebx
8010541d:	5d                   	pop    %ebp
8010541e:	c3                   	ret    
8010541f:	90                   	nop
    return -1;
80105420:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105425:	eb f2                	jmp    80105419 <fetchint+0x29>
80105427:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010542e:	66 90                	xchg   %ax,%ax

80105430 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105430:	f3 0f 1e fb          	endbr32 
80105434:	55                   	push   %ebp
80105435:	89 e5                	mov    %esp,%ebp
80105437:	53                   	push   %ebx
80105438:	83 ec 04             	sub    $0x4,%esp
8010543b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010543e:	e8 4d ea ff ff       	call   80103e90 <myproc>

  if(addr >= curproc->sz)
80105443:	39 18                	cmp    %ebx,(%eax)
80105445:	76 31                	jbe    80105478 <fetchstr+0x48>
    return -1;
  *pp = (char*)addr;
80105447:	8b 55 0c             	mov    0xc(%ebp),%edx
8010544a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010544c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010544e:	39 d3                	cmp    %edx,%ebx
80105450:	73 26                	jae    80105478 <fetchstr+0x48>
80105452:	89 d8                	mov    %ebx,%eax
80105454:	eb 11                	jmp    80105467 <fetchstr+0x37>
80105456:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010545d:	8d 76 00             	lea    0x0(%esi),%esi
80105460:	83 c0 01             	add    $0x1,%eax
80105463:	39 c2                	cmp    %eax,%edx
80105465:	76 11                	jbe    80105478 <fetchstr+0x48>
    if(*s == 0)
80105467:	80 38 00             	cmpb   $0x0,(%eax)
8010546a:	75 f4                	jne    80105460 <fetchstr+0x30>
      return s - *pp;
  }
  return -1;
}
8010546c:	83 c4 04             	add    $0x4,%esp
      return s - *pp;
8010546f:	29 d8                	sub    %ebx,%eax
}
80105471:	5b                   	pop    %ebx
80105472:	5d                   	pop    %ebp
80105473:	c3                   	ret    
80105474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105478:	83 c4 04             	add    $0x4,%esp
    return -1;
8010547b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105480:	5b                   	pop    %ebx
80105481:	5d                   	pop    %ebp
80105482:	c3                   	ret    
80105483:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010548a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105490 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105490:	f3 0f 1e fb          	endbr32 
80105494:	55                   	push   %ebp
80105495:	89 e5                	mov    %esp,%ebp
80105497:	56                   	push   %esi
80105498:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105499:	e8 f2 e9 ff ff       	call   80103e90 <myproc>
8010549e:	8b 55 08             	mov    0x8(%ebp),%edx
801054a1:	8b 40 1c             	mov    0x1c(%eax),%eax
801054a4:	8b 40 44             	mov    0x44(%eax),%eax
801054a7:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801054aa:	e8 e1 e9 ff ff       	call   80103e90 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054af:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801054b2:	8b 00                	mov    (%eax),%eax
801054b4:	39 c6                	cmp    %eax,%esi
801054b6:	73 18                	jae    801054d0 <argint+0x40>
801054b8:	8d 53 08             	lea    0x8(%ebx),%edx
801054bb:	39 d0                	cmp    %edx,%eax
801054bd:	72 11                	jb     801054d0 <argint+0x40>
  *ip = *(int*)(addr);
801054bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801054c2:	8b 53 04             	mov    0x4(%ebx),%edx
801054c5:	89 10                	mov    %edx,(%eax)
  return 0;
801054c7:	31 c0                	xor    %eax,%eax
}
801054c9:	5b                   	pop    %ebx
801054ca:	5e                   	pop    %esi
801054cb:	5d                   	pop    %ebp
801054cc:	c3                   	ret    
801054cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801054d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801054d5:	eb f2                	jmp    801054c9 <argint+0x39>
801054d7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801054de:	66 90                	xchg   %ax,%ax

801054e0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801054e0:	f3 0f 1e fb          	endbr32 
801054e4:	55                   	push   %ebp
801054e5:	89 e5                	mov    %esp,%ebp
801054e7:	56                   	push   %esi
801054e8:	53                   	push   %ebx
801054e9:	83 ec 10             	sub    $0x10,%esp
801054ec:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
801054ef:	e8 9c e9 ff ff       	call   80103e90 <myproc>
 
  if(argint(n, &i) < 0)
801054f4:	83 ec 08             	sub    $0x8,%esp
  struct proc *curproc = myproc();
801054f7:	89 c6                	mov    %eax,%esi
  if(argint(n, &i) < 0)
801054f9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054fc:	50                   	push   %eax
801054fd:	ff 75 08             	pushl  0x8(%ebp)
80105500:	e8 8b ff ff ff       	call   80105490 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105505:	83 c4 10             	add    $0x10,%esp
80105508:	85 c0                	test   %eax,%eax
8010550a:	78 24                	js     80105530 <argptr+0x50>
8010550c:	85 db                	test   %ebx,%ebx
8010550e:	78 20                	js     80105530 <argptr+0x50>
80105510:	8b 16                	mov    (%esi),%edx
80105512:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105515:	39 c2                	cmp    %eax,%edx
80105517:	76 17                	jbe    80105530 <argptr+0x50>
80105519:	01 c3                	add    %eax,%ebx
8010551b:	39 da                	cmp    %ebx,%edx
8010551d:	72 11                	jb     80105530 <argptr+0x50>
    return -1;
  *pp = (char*)i;
8010551f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105522:	89 02                	mov    %eax,(%edx)
  return 0;
80105524:	31 c0                	xor    %eax,%eax
}
80105526:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105529:	5b                   	pop    %ebx
8010552a:	5e                   	pop    %esi
8010552b:	5d                   	pop    %ebp
8010552c:	c3                   	ret    
8010552d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105530:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105535:	eb ef                	jmp    80105526 <argptr+0x46>
80105537:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010553e:	66 90                	xchg   %ax,%ax

80105540 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105540:	f3 0f 1e fb          	endbr32 
80105544:	55                   	push   %ebp
80105545:	89 e5                	mov    %esp,%ebp
80105547:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
8010554a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010554d:	50                   	push   %eax
8010554e:	ff 75 08             	pushl  0x8(%ebp)
80105551:	e8 3a ff ff ff       	call   80105490 <argint>
80105556:	83 c4 10             	add    $0x10,%esp
80105559:	85 c0                	test   %eax,%eax
8010555b:	78 13                	js     80105570 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
8010555d:	83 ec 08             	sub    $0x8,%esp
80105560:	ff 75 0c             	pushl  0xc(%ebp)
80105563:	ff 75 f4             	pushl  -0xc(%ebp)
80105566:	e8 c5 fe ff ff       	call   80105430 <fetchstr>
8010556b:	83 c4 10             	add    $0x10,%esp
}
8010556e:	c9                   	leave  
8010556f:	c3                   	ret    
80105570:	c9                   	leave  
    return -1;
80105571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105576:	c3                   	ret    
80105577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010557e:	66 90                	xchg   %ax,%ax

80105580 <syscall>:
[SYS_set_HRRN_system_level] sys_set_HRRN_system_level,
};

void
syscall(void)
{
80105580:	f3 0f 1e fb          	endbr32 
80105584:	55                   	push   %ebp
80105585:	89 e5                	mov    %esp,%ebp
80105587:	53                   	push   %ebx
80105588:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
8010558b:	e8 00 e9 ff ff       	call   80103e90 <myproc>
80105590:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80105592:	8b 40 1c             	mov    0x1c(%eax),%eax
80105595:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80105598:	8d 50 ff             	lea    -0x1(%eax),%edx
8010559b:	83 fa 1d             	cmp    $0x1d,%edx
8010559e:	77 20                	ja     801055c0 <syscall+0x40>
801055a0:	8b 14 85 00 86 10 80 	mov    -0x7fef7a00(,%eax,4),%edx
801055a7:	85 d2                	test   %edx,%edx
801055a9:	74 15                	je     801055c0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
801055ab:	ff d2                	call   *%edx
801055ad:	89 c2                	mov    %eax,%edx
801055af:	8b 43 1c             	mov    0x1c(%ebx),%eax
801055b2:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801055b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055b8:	c9                   	leave  
801055b9:	c3                   	ret    
801055ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801055c0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801055c1:	8d 43 70             	lea    0x70(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801055c4:	50                   	push   %eax
801055c5:	ff 73 10             	pushl  0x10(%ebx)
801055c8:	68 c5 85 10 80       	push   $0x801085c5
801055cd:	e8 de b0 ff ff       	call   801006b0 <cprintf>
    curproc->tf->eax = -1;
801055d2:	8b 43 1c             	mov    0x1c(%ebx),%eax
801055d5:	83 c4 10             	add    $0x10,%esp
801055d8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
801055df:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055e2:	c9                   	leave  
801055e3:	c3                   	ret    
801055e4:	66 90                	xchg   %ax,%ax
801055e6:	66 90                	xchg   %ax,%ax
801055e8:	66 90                	xchg   %ax,%ax
801055ea:	66 90                	xchg   %ax,%ax
801055ec:	66 90                	xchg   %ax,%ax
801055ee:	66 90                	xchg   %ax,%ax

801055f0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	57                   	push   %edi
801055f4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
801055f5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
801055f8:	53                   	push   %ebx
801055f9:	83 ec 34             	sub    $0x34,%esp
801055fc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
801055ff:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80105602:	57                   	push   %edi
80105603:	50                   	push   %eax
{
80105604:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105607:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
8010560a:	e8 01 cf ff ff       	call   80102510 <nameiparent>
8010560f:	83 c4 10             	add    $0x10,%esp
80105612:	85 c0                	test   %eax,%eax
80105614:	0f 84 46 01 00 00    	je     80105760 <create+0x170>
    return 0;
  ilock(dp);
8010561a:	83 ec 0c             	sub    $0xc,%esp
8010561d:	89 c3                	mov    %eax,%ebx
8010561f:	50                   	push   %eax
80105620:	e8 fb c5 ff ff       	call   80101c20 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105625:	83 c4 0c             	add    $0xc,%esp
80105628:	6a 00                	push   $0x0
8010562a:	57                   	push   %edi
8010562b:	53                   	push   %ebx
8010562c:	e8 3f cb ff ff       	call   80102170 <dirlookup>
80105631:	83 c4 10             	add    $0x10,%esp
80105634:	89 c6                	mov    %eax,%esi
80105636:	85 c0                	test   %eax,%eax
80105638:	74 56                	je     80105690 <create+0xa0>
    iunlockput(dp);
8010563a:	83 ec 0c             	sub    $0xc,%esp
8010563d:	53                   	push   %ebx
8010563e:	e8 7d c8 ff ff       	call   80101ec0 <iunlockput>
    ilock(ip);
80105643:	89 34 24             	mov    %esi,(%esp)
80105646:	e8 d5 c5 ff ff       	call   80101c20 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
8010564b:	83 c4 10             	add    $0x10,%esp
8010564e:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80105653:	75 1b                	jne    80105670 <create+0x80>
80105655:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
8010565a:	75 14                	jne    80105670 <create+0x80>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
8010565c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010565f:	89 f0                	mov    %esi,%eax
80105661:	5b                   	pop    %ebx
80105662:	5e                   	pop    %esi
80105663:	5f                   	pop    %edi
80105664:	5d                   	pop    %ebp
80105665:	c3                   	ret    
80105666:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010566d:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(ip);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	56                   	push   %esi
    return 0;
80105674:	31 f6                	xor    %esi,%esi
    iunlockput(ip);
80105676:	e8 45 c8 ff ff       	call   80101ec0 <iunlockput>
    return 0;
8010567b:	83 c4 10             	add    $0x10,%esp
}
8010567e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105681:	89 f0                	mov    %esi,%eax
80105683:	5b                   	pop    %ebx
80105684:	5e                   	pop    %esi
80105685:	5f                   	pop    %edi
80105686:	5d                   	pop    %ebp
80105687:	c3                   	ret    
80105688:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010568f:	90                   	nop
  if((ip = ialloc(dp->dev, type)) == 0)
80105690:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105694:	83 ec 08             	sub    $0x8,%esp
80105697:	50                   	push   %eax
80105698:	ff 33                	pushl  (%ebx)
8010569a:	e8 01 c4 ff ff       	call   80101aa0 <ialloc>
8010569f:	83 c4 10             	add    $0x10,%esp
801056a2:	89 c6                	mov    %eax,%esi
801056a4:	85 c0                	test   %eax,%eax
801056a6:	0f 84 cd 00 00 00    	je     80105779 <create+0x189>
  ilock(ip);
801056ac:	83 ec 0c             	sub    $0xc,%esp
801056af:	50                   	push   %eax
801056b0:	e8 6b c5 ff ff       	call   80101c20 <ilock>
  ip->major = major;
801056b5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801056b9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801056bd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801056c1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801056c5:	b8 01 00 00 00       	mov    $0x1,%eax
801056ca:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801056ce:	89 34 24             	mov    %esi,(%esp)
801056d1:	e8 8a c4 ff ff       	call   80101b60 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801056d6:	83 c4 10             	add    $0x10,%esp
801056d9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801056de:	74 30                	je     80105710 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
801056e0:	83 ec 04             	sub    $0x4,%esp
801056e3:	ff 76 04             	pushl  0x4(%esi)
801056e6:	57                   	push   %edi
801056e7:	53                   	push   %ebx
801056e8:	e8 43 cd ff ff       	call   80102430 <dirlink>
801056ed:	83 c4 10             	add    $0x10,%esp
801056f0:	85 c0                	test   %eax,%eax
801056f2:	78 78                	js     8010576c <create+0x17c>
  iunlockput(dp);
801056f4:	83 ec 0c             	sub    $0xc,%esp
801056f7:	53                   	push   %ebx
801056f8:	e8 c3 c7 ff ff       	call   80101ec0 <iunlockput>
  return ip;
801056fd:	83 c4 10             	add    $0x10,%esp
}
80105700:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105703:	89 f0                	mov    %esi,%eax
80105705:	5b                   	pop    %ebx
80105706:	5e                   	pop    %esi
80105707:	5f                   	pop    %edi
80105708:	5d                   	pop    %ebp
80105709:	c3                   	ret    
8010570a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105710:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105713:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105718:	53                   	push   %ebx
80105719:	e8 42 c4 ff ff       	call   80101b60 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
8010571e:	83 c4 0c             	add    $0xc,%esp
80105721:	ff 76 04             	pushl  0x4(%esi)
80105724:	68 98 86 10 80       	push   $0x80108698
80105729:	56                   	push   %esi
8010572a:	e8 01 cd ff ff       	call   80102430 <dirlink>
8010572f:	83 c4 10             	add    $0x10,%esp
80105732:	85 c0                	test   %eax,%eax
80105734:	78 18                	js     8010574e <create+0x15e>
80105736:	83 ec 04             	sub    $0x4,%esp
80105739:	ff 73 04             	pushl  0x4(%ebx)
8010573c:	68 97 86 10 80       	push   $0x80108697
80105741:	56                   	push   %esi
80105742:	e8 e9 cc ff ff       	call   80102430 <dirlink>
80105747:	83 c4 10             	add    $0x10,%esp
8010574a:	85 c0                	test   %eax,%eax
8010574c:	79 92                	jns    801056e0 <create+0xf0>
      panic("create dots");
8010574e:	83 ec 0c             	sub    $0xc,%esp
80105751:	68 8b 86 10 80       	push   $0x8010868b
80105756:	e8 35 ac ff ff       	call   80100390 <panic>
8010575b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010575f:	90                   	nop
}
80105760:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80105763:	31 f6                	xor    %esi,%esi
}
80105765:	5b                   	pop    %ebx
80105766:	89 f0                	mov    %esi,%eax
80105768:	5e                   	pop    %esi
80105769:	5f                   	pop    %edi
8010576a:	5d                   	pop    %ebp
8010576b:	c3                   	ret    
    panic("create: dirlink");
8010576c:	83 ec 0c             	sub    $0xc,%esp
8010576f:	68 9a 86 10 80       	push   $0x8010869a
80105774:	e8 17 ac ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80105779:	83 ec 0c             	sub    $0xc,%esp
8010577c:	68 7c 86 10 80       	push   $0x8010867c
80105781:	e8 0a ac ff ff       	call   80100390 <panic>
80105786:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010578d:	8d 76 00             	lea    0x0(%esi),%esi

80105790 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	56                   	push   %esi
80105794:	89 d6                	mov    %edx,%esi
80105796:	53                   	push   %ebx
80105797:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80105799:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
8010579c:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010579f:	50                   	push   %eax
801057a0:	6a 00                	push   $0x0
801057a2:	e8 e9 fc ff ff       	call   80105490 <argint>
801057a7:	83 c4 10             	add    $0x10,%esp
801057aa:	85 c0                	test   %eax,%eax
801057ac:	78 2a                	js     801057d8 <argfd.constprop.0+0x48>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801057ae:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801057b2:	77 24                	ja     801057d8 <argfd.constprop.0+0x48>
801057b4:	e8 d7 e6 ff ff       	call   80103e90 <myproc>
801057b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801057bc:	8b 44 90 2c          	mov    0x2c(%eax,%edx,4),%eax
801057c0:	85 c0                	test   %eax,%eax
801057c2:	74 14                	je     801057d8 <argfd.constprop.0+0x48>
  if(pfd)
801057c4:	85 db                	test   %ebx,%ebx
801057c6:	74 02                	je     801057ca <argfd.constprop.0+0x3a>
    *pfd = fd;
801057c8:	89 13                	mov    %edx,(%ebx)
    *pf = f;
801057ca:	89 06                	mov    %eax,(%esi)
  return 0;
801057cc:	31 c0                	xor    %eax,%eax
}
801057ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801057d1:	5b                   	pop    %ebx
801057d2:	5e                   	pop    %esi
801057d3:	5d                   	pop    %ebp
801057d4:	c3                   	ret    
801057d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801057d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801057dd:	eb ef                	jmp    801057ce <argfd.constprop.0+0x3e>
801057df:	90                   	nop

801057e0 <sys_dup>:
{
801057e0:	f3 0f 1e fb          	endbr32 
801057e4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
801057e5:	31 c0                	xor    %eax,%eax
{
801057e7:	89 e5                	mov    %esp,%ebp
801057e9:	56                   	push   %esi
801057ea:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
801057eb:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
801057ee:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
801057f1:	e8 9a ff ff ff       	call   80105790 <argfd.constprop.0>
801057f6:	85 c0                	test   %eax,%eax
801057f8:	78 1e                	js     80105818 <sys_dup+0x38>
  if((fd=fdalloc(f)) < 0)
801057fa:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057fd:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057ff:	e8 8c e6 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105804:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105808:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
8010580c:	85 d2                	test   %edx,%edx
8010580e:	74 20                	je     80105830 <sys_dup+0x50>
  for(fd = 0; fd < NOFILE; fd++){
80105810:	83 c3 01             	add    $0x1,%ebx
80105813:	83 fb 10             	cmp    $0x10,%ebx
80105816:	75 f0                	jne    80105808 <sys_dup+0x28>
}
80105818:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
8010581b:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105820:	89 d8                	mov    %ebx,%eax
80105822:	5b                   	pop    %ebx
80105823:	5e                   	pop    %esi
80105824:	5d                   	pop    %ebp
80105825:	c3                   	ret    
80105826:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010582d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80105830:	89 74 98 2c          	mov    %esi,0x2c(%eax,%ebx,4)
  filedup(f);
80105834:	83 ec 0c             	sub    $0xc,%esp
80105837:	ff 75 f4             	pushl  -0xc(%ebp)
8010583a:	e8 f1 ba ff ff       	call   80101330 <filedup>
  return fd;
8010583f:	83 c4 10             	add    $0x10,%esp
}
80105842:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105845:	89 d8                	mov    %ebx,%eax
80105847:	5b                   	pop    %ebx
80105848:	5e                   	pop    %esi
80105849:	5d                   	pop    %ebp
8010584a:	c3                   	ret    
8010584b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010584f:	90                   	nop

80105850 <sys_read>:
{
80105850:	f3 0f 1e fb          	endbr32 
80105854:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105855:	31 c0                	xor    %eax,%eax
{
80105857:	89 e5                	mov    %esp,%ebp
80105859:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
8010585c:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010585f:	e8 2c ff ff ff       	call   80105790 <argfd.constprop.0>
80105864:	85 c0                	test   %eax,%eax
80105866:	78 48                	js     801058b0 <sys_read+0x60>
80105868:	83 ec 08             	sub    $0x8,%esp
8010586b:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010586e:	50                   	push   %eax
8010586f:	6a 02                	push   $0x2
80105871:	e8 1a fc ff ff       	call   80105490 <argint>
80105876:	83 c4 10             	add    $0x10,%esp
80105879:	85 c0                	test   %eax,%eax
8010587b:	78 33                	js     801058b0 <sys_read+0x60>
8010587d:	83 ec 04             	sub    $0x4,%esp
80105880:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105883:	ff 75 f0             	pushl  -0x10(%ebp)
80105886:	50                   	push   %eax
80105887:	6a 01                	push   $0x1
80105889:	e8 52 fc ff ff       	call   801054e0 <argptr>
8010588e:	83 c4 10             	add    $0x10,%esp
80105891:	85 c0                	test   %eax,%eax
80105893:	78 1b                	js     801058b0 <sys_read+0x60>
  return fileread(f, p, n);
80105895:	83 ec 04             	sub    $0x4,%esp
80105898:	ff 75 f0             	pushl  -0x10(%ebp)
8010589b:	ff 75 f4             	pushl  -0xc(%ebp)
8010589e:	ff 75 ec             	pushl  -0x14(%ebp)
801058a1:	e8 0a bc ff ff       	call   801014b0 <fileread>
801058a6:	83 c4 10             	add    $0x10,%esp
}
801058a9:	c9                   	leave  
801058aa:	c3                   	ret    
801058ab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801058af:	90                   	nop
801058b0:	c9                   	leave  
    return -1;
801058b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058b6:	c3                   	ret    
801058b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801058be:	66 90                	xchg   %ax,%ax

801058c0 <sys_write>:
{
801058c0:	f3 0f 1e fb          	endbr32 
801058c4:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058c5:	31 c0                	xor    %eax,%eax
{
801058c7:	89 e5                	mov    %esp,%ebp
801058c9:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801058cc:	8d 55 ec             	lea    -0x14(%ebp),%edx
801058cf:	e8 bc fe ff ff       	call   80105790 <argfd.constprop.0>
801058d4:	85 c0                	test   %eax,%eax
801058d6:	78 48                	js     80105920 <sys_write+0x60>
801058d8:	83 ec 08             	sub    $0x8,%esp
801058db:	8d 45 f0             	lea    -0x10(%ebp),%eax
801058de:	50                   	push   %eax
801058df:	6a 02                	push   $0x2
801058e1:	e8 aa fb ff ff       	call   80105490 <argint>
801058e6:	83 c4 10             	add    $0x10,%esp
801058e9:	85 c0                	test   %eax,%eax
801058eb:	78 33                	js     80105920 <sys_write+0x60>
801058ed:	83 ec 04             	sub    $0x4,%esp
801058f0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058f3:	ff 75 f0             	pushl  -0x10(%ebp)
801058f6:	50                   	push   %eax
801058f7:	6a 01                	push   $0x1
801058f9:	e8 e2 fb ff ff       	call   801054e0 <argptr>
801058fe:	83 c4 10             	add    $0x10,%esp
80105901:	85 c0                	test   %eax,%eax
80105903:	78 1b                	js     80105920 <sys_write+0x60>
  return filewrite(f, p, n);
80105905:	83 ec 04             	sub    $0x4,%esp
80105908:	ff 75 f0             	pushl  -0x10(%ebp)
8010590b:	ff 75 f4             	pushl  -0xc(%ebp)
8010590e:	ff 75 ec             	pushl  -0x14(%ebp)
80105911:	e8 3a bc ff ff       	call   80101550 <filewrite>
80105916:	83 c4 10             	add    $0x10,%esp
}
80105919:	c9                   	leave  
8010591a:	c3                   	ret    
8010591b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010591f:	90                   	nop
80105920:	c9                   	leave  
    return -1;
80105921:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105926:	c3                   	ret    
80105927:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010592e:	66 90                	xchg   %ax,%ax

80105930 <sys_close>:
{
80105930:	f3 0f 1e fb          	endbr32 
80105934:	55                   	push   %ebp
80105935:	89 e5                	mov    %esp,%ebp
80105937:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
8010593a:	8d 55 f4             	lea    -0xc(%ebp),%edx
8010593d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105940:	e8 4b fe ff ff       	call   80105790 <argfd.constprop.0>
80105945:	85 c0                	test   %eax,%eax
80105947:	78 27                	js     80105970 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
80105949:	e8 42 e5 ff ff       	call   80103e90 <myproc>
8010594e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
80105951:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105954:	c7 44 90 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edx,4)
8010595b:	00 
  fileclose(f);
8010595c:	ff 75 f4             	pushl  -0xc(%ebp)
8010595f:	e8 1c ba ff ff       	call   80101380 <fileclose>
  return 0;
80105964:	83 c4 10             	add    $0x10,%esp
80105967:	31 c0                	xor    %eax,%eax
}
80105969:	c9                   	leave  
8010596a:	c3                   	ret    
8010596b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010596f:	90                   	nop
80105970:	c9                   	leave  
    return -1;
80105971:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105976:	c3                   	ret    
80105977:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010597e:	66 90                	xchg   %ax,%ax

80105980 <sys_fstat>:
{
80105980:	f3 0f 1e fb          	endbr32 
80105984:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105985:	31 c0                	xor    %eax,%eax
{
80105987:	89 e5                	mov    %esp,%ebp
80105989:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010598c:	8d 55 f0             	lea    -0x10(%ebp),%edx
8010598f:	e8 fc fd ff ff       	call   80105790 <argfd.constprop.0>
80105994:	85 c0                	test   %eax,%eax
80105996:	78 30                	js     801059c8 <sys_fstat+0x48>
80105998:	83 ec 04             	sub    $0x4,%esp
8010599b:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010599e:	6a 14                	push   $0x14
801059a0:	50                   	push   %eax
801059a1:	6a 01                	push   $0x1
801059a3:	e8 38 fb ff ff       	call   801054e0 <argptr>
801059a8:	83 c4 10             	add    $0x10,%esp
801059ab:	85 c0                	test   %eax,%eax
801059ad:	78 19                	js     801059c8 <sys_fstat+0x48>
  return filestat(f, st);
801059af:	83 ec 08             	sub    $0x8,%esp
801059b2:	ff 75 f4             	pushl  -0xc(%ebp)
801059b5:	ff 75 f0             	pushl  -0x10(%ebp)
801059b8:	e8 a3 ba ff ff       	call   80101460 <filestat>
801059bd:	83 c4 10             	add    $0x10,%esp
}
801059c0:	c9                   	leave  
801059c1:	c3                   	ret    
801059c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801059c8:	c9                   	leave  
    return -1;
801059c9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059ce:	c3                   	ret    
801059cf:	90                   	nop

801059d0 <sys_link>:
{
801059d0:	f3 0f 1e fb          	endbr32 
801059d4:	55                   	push   %ebp
801059d5:	89 e5                	mov    %esp,%ebp
801059d7:	57                   	push   %edi
801059d8:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059d9:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801059dc:	53                   	push   %ebx
801059dd:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801059e0:	50                   	push   %eax
801059e1:	6a 00                	push   $0x0
801059e3:	e8 58 fb ff ff       	call   80105540 <argstr>
801059e8:	83 c4 10             	add    $0x10,%esp
801059eb:	85 c0                	test   %eax,%eax
801059ed:	0f 88 ff 00 00 00    	js     80105af2 <sys_link+0x122>
801059f3:	83 ec 08             	sub    $0x8,%esp
801059f6:	8d 45 d0             	lea    -0x30(%ebp),%eax
801059f9:	50                   	push   %eax
801059fa:	6a 01                	push   $0x1
801059fc:	e8 3f fb ff ff       	call   80105540 <argstr>
80105a01:	83 c4 10             	add    $0x10,%esp
80105a04:	85 c0                	test   %eax,%eax
80105a06:	0f 88 e6 00 00 00    	js     80105af2 <sys_link+0x122>
  begin_op();
80105a0c:	e8 ff d7 ff ff       	call   80103210 <begin_op>
  if((ip = namei(old)) == 0){
80105a11:	83 ec 0c             	sub    $0xc,%esp
80105a14:	ff 75 d4             	pushl  -0x2c(%ebp)
80105a17:	e8 d4 ca ff ff       	call   801024f0 <namei>
80105a1c:	83 c4 10             	add    $0x10,%esp
80105a1f:	89 c3                	mov    %eax,%ebx
80105a21:	85 c0                	test   %eax,%eax
80105a23:	0f 84 e8 00 00 00    	je     80105b11 <sys_link+0x141>
  ilock(ip);
80105a29:	83 ec 0c             	sub    $0xc,%esp
80105a2c:	50                   	push   %eax
80105a2d:	e8 ee c1 ff ff       	call   80101c20 <ilock>
  if(ip->type == T_DIR){
80105a32:	83 c4 10             	add    $0x10,%esp
80105a35:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105a3a:	0f 84 b9 00 00 00    	je     80105af9 <sys_link+0x129>
  iupdate(ip);
80105a40:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105a43:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105a48:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105a4b:	53                   	push   %ebx
80105a4c:	e8 0f c1 ff ff       	call   80101b60 <iupdate>
  iunlock(ip);
80105a51:	89 1c 24             	mov    %ebx,(%esp)
80105a54:	e8 a7 c2 ff ff       	call   80101d00 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105a59:	58                   	pop    %eax
80105a5a:	5a                   	pop    %edx
80105a5b:	57                   	push   %edi
80105a5c:	ff 75 d0             	pushl  -0x30(%ebp)
80105a5f:	e8 ac ca ff ff       	call   80102510 <nameiparent>
80105a64:	83 c4 10             	add    $0x10,%esp
80105a67:	89 c6                	mov    %eax,%esi
80105a69:	85 c0                	test   %eax,%eax
80105a6b:	74 5f                	je     80105acc <sys_link+0xfc>
  ilock(dp);
80105a6d:	83 ec 0c             	sub    $0xc,%esp
80105a70:	50                   	push   %eax
80105a71:	e8 aa c1 ff ff       	call   80101c20 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105a76:	8b 03                	mov    (%ebx),%eax
80105a78:	83 c4 10             	add    $0x10,%esp
80105a7b:	39 06                	cmp    %eax,(%esi)
80105a7d:	75 41                	jne    80105ac0 <sys_link+0xf0>
80105a7f:	83 ec 04             	sub    $0x4,%esp
80105a82:	ff 73 04             	pushl  0x4(%ebx)
80105a85:	57                   	push   %edi
80105a86:	56                   	push   %esi
80105a87:	e8 a4 c9 ff ff       	call   80102430 <dirlink>
80105a8c:	83 c4 10             	add    $0x10,%esp
80105a8f:	85 c0                	test   %eax,%eax
80105a91:	78 2d                	js     80105ac0 <sys_link+0xf0>
  iunlockput(dp);
80105a93:	83 ec 0c             	sub    $0xc,%esp
80105a96:	56                   	push   %esi
80105a97:	e8 24 c4 ff ff       	call   80101ec0 <iunlockput>
  iput(ip);
80105a9c:	89 1c 24             	mov    %ebx,(%esp)
80105a9f:	e8 ac c2 ff ff       	call   80101d50 <iput>
  end_op();
80105aa4:	e8 d7 d7 ff ff       	call   80103280 <end_op>
  return 0;
80105aa9:	83 c4 10             	add    $0x10,%esp
80105aac:	31 c0                	xor    %eax,%eax
}
80105aae:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab1:	5b                   	pop    %ebx
80105ab2:	5e                   	pop    %esi
80105ab3:	5f                   	pop    %edi
80105ab4:	5d                   	pop    %ebp
80105ab5:	c3                   	ret    
80105ab6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105abd:	8d 76 00             	lea    0x0(%esi),%esi
    iunlockput(dp);
80105ac0:	83 ec 0c             	sub    $0xc,%esp
80105ac3:	56                   	push   %esi
80105ac4:	e8 f7 c3 ff ff       	call   80101ec0 <iunlockput>
    goto bad;
80105ac9:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105acc:	83 ec 0c             	sub    $0xc,%esp
80105acf:	53                   	push   %ebx
80105ad0:	e8 4b c1 ff ff       	call   80101c20 <ilock>
  ip->nlink--;
80105ad5:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105ada:	89 1c 24             	mov    %ebx,(%esp)
80105add:	e8 7e c0 ff ff       	call   80101b60 <iupdate>
  iunlockput(ip);
80105ae2:	89 1c 24             	mov    %ebx,(%esp)
80105ae5:	e8 d6 c3 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105aea:	e8 91 d7 ff ff       	call   80103280 <end_op>
  return -1;
80105aef:	83 c4 10             	add    $0x10,%esp
80105af2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105af7:	eb b5                	jmp    80105aae <sys_link+0xde>
    iunlockput(ip);
80105af9:	83 ec 0c             	sub    $0xc,%esp
80105afc:	53                   	push   %ebx
80105afd:	e8 be c3 ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105b02:	e8 79 d7 ff ff       	call   80103280 <end_op>
    return -1;
80105b07:	83 c4 10             	add    $0x10,%esp
80105b0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b0f:	eb 9d                	jmp    80105aae <sys_link+0xde>
    end_op();
80105b11:	e8 6a d7 ff ff       	call   80103280 <end_op>
    return -1;
80105b16:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b1b:	eb 91                	jmp    80105aae <sys_link+0xde>
80105b1d:	8d 76 00             	lea    0x0(%esi),%esi

80105b20 <sys_unlink>:
{
80105b20:	f3 0f 1e fb          	endbr32 
80105b24:	55                   	push   %ebp
80105b25:	89 e5                	mov    %esp,%ebp
80105b27:	57                   	push   %edi
80105b28:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105b29:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105b2c:	53                   	push   %ebx
80105b2d:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105b30:	50                   	push   %eax
80105b31:	6a 00                	push   $0x0
80105b33:	e8 08 fa ff ff       	call   80105540 <argstr>
80105b38:	83 c4 10             	add    $0x10,%esp
80105b3b:	85 c0                	test   %eax,%eax
80105b3d:	0f 88 7d 01 00 00    	js     80105cc0 <sys_unlink+0x1a0>
  begin_op();
80105b43:	e8 c8 d6 ff ff       	call   80103210 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105b48:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105b4b:	83 ec 08             	sub    $0x8,%esp
80105b4e:	53                   	push   %ebx
80105b4f:	ff 75 c0             	pushl  -0x40(%ebp)
80105b52:	e8 b9 c9 ff ff       	call   80102510 <nameiparent>
80105b57:	83 c4 10             	add    $0x10,%esp
80105b5a:	89 c6                	mov    %eax,%esi
80105b5c:	85 c0                	test   %eax,%eax
80105b5e:	0f 84 66 01 00 00    	je     80105cca <sys_unlink+0x1aa>
  ilock(dp);
80105b64:	83 ec 0c             	sub    $0xc,%esp
80105b67:	50                   	push   %eax
80105b68:	e8 b3 c0 ff ff       	call   80101c20 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105b6d:	58                   	pop    %eax
80105b6e:	5a                   	pop    %edx
80105b6f:	68 98 86 10 80       	push   $0x80108698
80105b74:	53                   	push   %ebx
80105b75:	e8 d6 c5 ff ff       	call   80102150 <namecmp>
80105b7a:	83 c4 10             	add    $0x10,%esp
80105b7d:	85 c0                	test   %eax,%eax
80105b7f:	0f 84 03 01 00 00    	je     80105c88 <sys_unlink+0x168>
80105b85:	83 ec 08             	sub    $0x8,%esp
80105b88:	68 97 86 10 80       	push   $0x80108697
80105b8d:	53                   	push   %ebx
80105b8e:	e8 bd c5 ff ff       	call   80102150 <namecmp>
80105b93:	83 c4 10             	add    $0x10,%esp
80105b96:	85 c0                	test   %eax,%eax
80105b98:	0f 84 ea 00 00 00    	je     80105c88 <sys_unlink+0x168>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105b9e:	83 ec 04             	sub    $0x4,%esp
80105ba1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105ba4:	50                   	push   %eax
80105ba5:	53                   	push   %ebx
80105ba6:	56                   	push   %esi
80105ba7:	e8 c4 c5 ff ff       	call   80102170 <dirlookup>
80105bac:	83 c4 10             	add    $0x10,%esp
80105baf:	89 c3                	mov    %eax,%ebx
80105bb1:	85 c0                	test   %eax,%eax
80105bb3:	0f 84 cf 00 00 00    	je     80105c88 <sys_unlink+0x168>
  ilock(ip);
80105bb9:	83 ec 0c             	sub    $0xc,%esp
80105bbc:	50                   	push   %eax
80105bbd:	e8 5e c0 ff ff       	call   80101c20 <ilock>
  if(ip->nlink < 1)
80105bc2:	83 c4 10             	add    $0x10,%esp
80105bc5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105bca:	0f 8e 23 01 00 00    	jle    80105cf3 <sys_unlink+0x1d3>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105bd0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105bd5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105bd8:	74 66                	je     80105c40 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105bda:	83 ec 04             	sub    $0x4,%esp
80105bdd:	6a 10                	push   $0x10
80105bdf:	6a 00                	push   $0x0
80105be1:	57                   	push   %edi
80105be2:	e8 c9 f5 ff ff       	call   801051b0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105be7:	6a 10                	push   $0x10
80105be9:	ff 75 c4             	pushl  -0x3c(%ebp)
80105bec:	57                   	push   %edi
80105bed:	56                   	push   %esi
80105bee:	e8 2d c4 ff ff       	call   80102020 <writei>
80105bf3:	83 c4 20             	add    $0x20,%esp
80105bf6:	83 f8 10             	cmp    $0x10,%eax
80105bf9:	0f 85 e7 00 00 00    	jne    80105ce6 <sys_unlink+0x1c6>
  if(ip->type == T_DIR){
80105bff:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105c04:	0f 84 96 00 00 00    	je     80105ca0 <sys_unlink+0x180>
  iunlockput(dp);
80105c0a:	83 ec 0c             	sub    $0xc,%esp
80105c0d:	56                   	push   %esi
80105c0e:	e8 ad c2 ff ff       	call   80101ec0 <iunlockput>
  ip->nlink--;
80105c13:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105c18:	89 1c 24             	mov    %ebx,(%esp)
80105c1b:	e8 40 bf ff ff       	call   80101b60 <iupdate>
  iunlockput(ip);
80105c20:	89 1c 24             	mov    %ebx,(%esp)
80105c23:	e8 98 c2 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105c28:	e8 53 d6 ff ff       	call   80103280 <end_op>
  return 0;
80105c2d:	83 c4 10             	add    $0x10,%esp
80105c30:	31 c0                	xor    %eax,%eax
}
80105c32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c35:	5b                   	pop    %ebx
80105c36:	5e                   	pop    %esi
80105c37:	5f                   	pop    %edi
80105c38:	5d                   	pop    %ebp
80105c39:	c3                   	ret    
80105c3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105c40:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105c44:	76 94                	jbe    80105bda <sys_unlink+0xba>
80105c46:	ba 20 00 00 00       	mov    $0x20,%edx
80105c4b:	eb 0b                	jmp    80105c58 <sys_unlink+0x138>
80105c4d:	8d 76 00             	lea    0x0(%esi),%esi
80105c50:	83 c2 10             	add    $0x10,%edx
80105c53:	39 53 58             	cmp    %edx,0x58(%ebx)
80105c56:	76 82                	jbe    80105bda <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105c58:	6a 10                	push   $0x10
80105c5a:	52                   	push   %edx
80105c5b:	57                   	push   %edi
80105c5c:	53                   	push   %ebx
80105c5d:	89 55 b4             	mov    %edx,-0x4c(%ebp)
80105c60:	e8 bb c2 ff ff       	call   80101f20 <readi>
80105c65:	83 c4 10             	add    $0x10,%esp
80105c68:	8b 55 b4             	mov    -0x4c(%ebp),%edx
80105c6b:	83 f8 10             	cmp    $0x10,%eax
80105c6e:	75 69                	jne    80105cd9 <sys_unlink+0x1b9>
    if(de.inum != 0)
80105c70:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105c75:	74 d9                	je     80105c50 <sys_unlink+0x130>
    iunlockput(ip);
80105c77:	83 ec 0c             	sub    $0xc,%esp
80105c7a:	53                   	push   %ebx
80105c7b:	e8 40 c2 ff ff       	call   80101ec0 <iunlockput>
    goto bad;
80105c80:	83 c4 10             	add    $0x10,%esp
80105c83:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c87:	90                   	nop
  iunlockput(dp);
80105c88:	83 ec 0c             	sub    $0xc,%esp
80105c8b:	56                   	push   %esi
80105c8c:	e8 2f c2 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105c91:	e8 ea d5 ff ff       	call   80103280 <end_op>
  return -1;
80105c96:	83 c4 10             	add    $0x10,%esp
80105c99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9e:	eb 92                	jmp    80105c32 <sys_unlink+0x112>
    iupdate(dp);
80105ca0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105ca3:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105ca8:	56                   	push   %esi
80105ca9:	e8 b2 be ff ff       	call   80101b60 <iupdate>
80105cae:	83 c4 10             	add    $0x10,%esp
80105cb1:	e9 54 ff ff ff       	jmp    80105c0a <sys_unlink+0xea>
80105cb6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105cbd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105cc0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cc5:	e9 68 ff ff ff       	jmp    80105c32 <sys_unlink+0x112>
    end_op();
80105cca:	e8 b1 d5 ff ff       	call   80103280 <end_op>
    return -1;
80105ccf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cd4:	e9 59 ff ff ff       	jmp    80105c32 <sys_unlink+0x112>
      panic("isdirempty: readi");
80105cd9:	83 ec 0c             	sub    $0xc,%esp
80105cdc:	68 bc 86 10 80       	push   $0x801086bc
80105ce1:	e8 aa a6 ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105ce6:	83 ec 0c             	sub    $0xc,%esp
80105ce9:	68 ce 86 10 80       	push   $0x801086ce
80105cee:	e8 9d a6 ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
80105cf3:	83 ec 0c             	sub    $0xc,%esp
80105cf6:	68 aa 86 10 80       	push   $0x801086aa
80105cfb:	e8 90 a6 ff ff       	call   80100390 <panic>

80105d00 <sys_open>:

int
sys_open(void)
{
80105d00:	f3 0f 1e fb          	endbr32 
80105d04:	55                   	push   %ebp
80105d05:	89 e5                	mov    %esp,%ebp
80105d07:	57                   	push   %edi
80105d08:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d09:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105d0c:	53                   	push   %ebx
80105d0d:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105d10:	50                   	push   %eax
80105d11:	6a 00                	push   $0x0
80105d13:	e8 28 f8 ff ff       	call   80105540 <argstr>
80105d18:	83 c4 10             	add    $0x10,%esp
80105d1b:	85 c0                	test   %eax,%eax
80105d1d:	0f 88 8a 00 00 00    	js     80105dad <sys_open+0xad>
80105d23:	83 ec 08             	sub    $0x8,%esp
80105d26:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105d29:	50                   	push   %eax
80105d2a:	6a 01                	push   $0x1
80105d2c:	e8 5f f7 ff ff       	call   80105490 <argint>
80105d31:	83 c4 10             	add    $0x10,%esp
80105d34:	85 c0                	test   %eax,%eax
80105d36:	78 75                	js     80105dad <sys_open+0xad>
    return -1;

  begin_op();
80105d38:	e8 d3 d4 ff ff       	call   80103210 <begin_op>

  if(omode & O_CREATE){
80105d3d:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105d41:	75 75                	jne    80105db8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
80105d43:	83 ec 0c             	sub    $0xc,%esp
80105d46:	ff 75 e0             	pushl  -0x20(%ebp)
80105d49:	e8 a2 c7 ff ff       	call   801024f0 <namei>
80105d4e:	83 c4 10             	add    $0x10,%esp
80105d51:	89 c6                	mov    %eax,%esi
80105d53:	85 c0                	test   %eax,%eax
80105d55:	74 7e                	je     80105dd5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105d57:	83 ec 0c             	sub    $0xc,%esp
80105d5a:	50                   	push   %eax
80105d5b:	e8 c0 be ff ff       	call   80101c20 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105d60:	83 c4 10             	add    $0x10,%esp
80105d63:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105d68:	0f 84 c2 00 00 00    	je     80105e30 <sys_open+0x130>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
80105d6e:	e8 4d b5 ff ff       	call   801012c0 <filealloc>
80105d73:	89 c7                	mov    %eax,%edi
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 23                	je     80105d9c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105d79:	e8 12 e1 ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105d7e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105d80:	8b 54 98 2c          	mov    0x2c(%eax,%ebx,4),%edx
80105d84:	85 d2                	test   %edx,%edx
80105d86:	74 60                	je     80105de8 <sys_open+0xe8>
  for(fd = 0; fd < NOFILE; fd++){
80105d88:	83 c3 01             	add    $0x1,%ebx
80105d8b:	83 fb 10             	cmp    $0x10,%ebx
80105d8e:	75 f0                	jne    80105d80 <sys_open+0x80>
    if(f)
      fileclose(f);
80105d90:	83 ec 0c             	sub    $0xc,%esp
80105d93:	57                   	push   %edi
80105d94:	e8 e7 b5 ff ff       	call   80101380 <fileclose>
80105d99:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80105d9c:	83 ec 0c             	sub    $0xc,%esp
80105d9f:	56                   	push   %esi
80105da0:	e8 1b c1 ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105da5:	e8 d6 d4 ff ff       	call   80103280 <end_op>
    return -1;
80105daa:	83 c4 10             	add    $0x10,%esp
80105dad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105db2:	eb 6d                	jmp    80105e21 <sys_open+0x121>
80105db4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105db8:	83 ec 0c             	sub    $0xc,%esp
80105dbb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105dbe:	31 c9                	xor    %ecx,%ecx
80105dc0:	ba 02 00 00 00       	mov    $0x2,%edx
80105dc5:	6a 00                	push   $0x0
80105dc7:	e8 24 f8 ff ff       	call   801055f0 <create>
    if(ip == 0){
80105dcc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
80105dcf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105dd1:	85 c0                	test   %eax,%eax
80105dd3:	75 99                	jne    80105d6e <sys_open+0x6e>
      end_op();
80105dd5:	e8 a6 d4 ff ff       	call   80103280 <end_op>
      return -1;
80105dda:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105ddf:	eb 40                	jmp    80105e21 <sys_open+0x121>
80105de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105de8:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105deb:	89 7c 98 2c          	mov    %edi,0x2c(%eax,%ebx,4)
  iunlock(ip);
80105def:	56                   	push   %esi
80105df0:	e8 0b bf ff ff       	call   80101d00 <iunlock>
  end_op();
80105df5:	e8 86 d4 ff ff       	call   80103280 <end_op>

  f->type = FD_INODE;
80105dfa:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105e00:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e03:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105e06:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105e09:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105e0b:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
80105e12:	f7 d0                	not    %eax
80105e14:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e17:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105e1a:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105e1d:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e24:	89 d8                	mov    %ebx,%eax
80105e26:	5b                   	pop    %ebx
80105e27:	5e                   	pop    %esi
80105e28:	5f                   	pop    %edi
80105e29:	5d                   	pop    %ebp
80105e2a:	c3                   	ret    
80105e2b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105e2f:	90                   	nop
    if(ip->type == T_DIR && omode != O_RDONLY){
80105e30:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105e33:	85 c9                	test   %ecx,%ecx
80105e35:	0f 84 33 ff ff ff    	je     80105d6e <sys_open+0x6e>
80105e3b:	e9 5c ff ff ff       	jmp    80105d9c <sys_open+0x9c>

80105e40 <sys_mkdir>:

int
sys_mkdir(void)
{
80105e40:	f3 0f 1e fb          	endbr32 
80105e44:	55                   	push   %ebp
80105e45:	89 e5                	mov    %esp,%ebp
80105e47:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105e4a:	e8 c1 d3 ff ff       	call   80103210 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
80105e4f:	83 ec 08             	sub    $0x8,%esp
80105e52:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105e55:	50                   	push   %eax
80105e56:	6a 00                	push   $0x0
80105e58:	e8 e3 f6 ff ff       	call   80105540 <argstr>
80105e5d:	83 c4 10             	add    $0x10,%esp
80105e60:	85 c0                	test   %eax,%eax
80105e62:	78 34                	js     80105e98 <sys_mkdir+0x58>
80105e64:	83 ec 0c             	sub    $0xc,%esp
80105e67:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e6a:	31 c9                	xor    %ecx,%ecx
80105e6c:	ba 01 00 00 00       	mov    $0x1,%edx
80105e71:	6a 00                	push   $0x0
80105e73:	e8 78 f7 ff ff       	call   801055f0 <create>
80105e78:	83 c4 10             	add    $0x10,%esp
80105e7b:	85 c0                	test   %eax,%eax
80105e7d:	74 19                	je     80105e98 <sys_mkdir+0x58>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105e7f:	83 ec 0c             	sub    $0xc,%esp
80105e82:	50                   	push   %eax
80105e83:	e8 38 c0 ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105e88:	e8 f3 d3 ff ff       	call   80103280 <end_op>
  return 0;
80105e8d:	83 c4 10             	add    $0x10,%esp
80105e90:	31 c0                	xor    %eax,%eax
}
80105e92:	c9                   	leave  
80105e93:	c3                   	ret    
80105e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105e98:	e8 e3 d3 ff ff       	call   80103280 <end_op>
    return -1;
80105e9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ea2:	c9                   	leave  
80105ea3:	c3                   	ret    
80105ea4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eab:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105eaf:	90                   	nop

80105eb0 <sys_mknod>:

int
sys_mknod(void)
{
80105eb0:	f3 0f 1e fb          	endbr32 
80105eb4:	55                   	push   %ebp
80105eb5:	89 e5                	mov    %esp,%ebp
80105eb7:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105eba:	e8 51 d3 ff ff       	call   80103210 <begin_op>
  if((argstr(0, &path)) < 0 ||
80105ebf:	83 ec 08             	sub    $0x8,%esp
80105ec2:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105ec5:	50                   	push   %eax
80105ec6:	6a 00                	push   $0x0
80105ec8:	e8 73 f6 ff ff       	call   80105540 <argstr>
80105ecd:	83 c4 10             	add    $0x10,%esp
80105ed0:	85 c0                	test   %eax,%eax
80105ed2:	78 64                	js     80105f38 <sys_mknod+0x88>
     argint(1, &major) < 0 ||
80105ed4:	83 ec 08             	sub    $0x8,%esp
80105ed7:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105eda:	50                   	push   %eax
80105edb:	6a 01                	push   $0x1
80105edd:	e8 ae f5 ff ff       	call   80105490 <argint>
  if((argstr(0, &path)) < 0 ||
80105ee2:	83 c4 10             	add    $0x10,%esp
80105ee5:	85 c0                	test   %eax,%eax
80105ee7:	78 4f                	js     80105f38 <sys_mknod+0x88>
     argint(2, &minor) < 0 ||
80105ee9:	83 ec 08             	sub    $0x8,%esp
80105eec:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105eef:	50                   	push   %eax
80105ef0:	6a 02                	push   $0x2
80105ef2:	e8 99 f5 ff ff       	call   80105490 <argint>
     argint(1, &major) < 0 ||
80105ef7:	83 c4 10             	add    $0x10,%esp
80105efa:	85 c0                	test   %eax,%eax
80105efc:	78 3a                	js     80105f38 <sys_mknod+0x88>
     (ip = create(path, T_DEV, major, minor)) == 0){
80105efe:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105f02:	83 ec 0c             	sub    $0xc,%esp
80105f05:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105f09:	ba 03 00 00 00       	mov    $0x3,%edx
80105f0e:	50                   	push   %eax
80105f0f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105f12:	e8 d9 f6 ff ff       	call   801055f0 <create>
     argint(2, &minor) < 0 ||
80105f17:	83 c4 10             	add    $0x10,%esp
80105f1a:	85 c0                	test   %eax,%eax
80105f1c:	74 1a                	je     80105f38 <sys_mknod+0x88>
    end_op();
    return -1;
  }
  iunlockput(ip);
80105f1e:	83 ec 0c             	sub    $0xc,%esp
80105f21:	50                   	push   %eax
80105f22:	e8 99 bf ff ff       	call   80101ec0 <iunlockput>
  end_op();
80105f27:	e8 54 d3 ff ff       	call   80103280 <end_op>
  return 0;
80105f2c:	83 c4 10             	add    $0x10,%esp
80105f2f:	31 c0                	xor    %eax,%eax
}
80105f31:	c9                   	leave  
80105f32:	c3                   	ret    
80105f33:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f37:	90                   	nop
    end_op();
80105f38:	e8 43 d3 ff ff       	call   80103280 <end_op>
    return -1;
80105f3d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f42:	c9                   	leave  
80105f43:	c3                   	ret    
80105f44:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f4b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105f4f:	90                   	nop

80105f50 <sys_chdir>:

int
sys_chdir(void)
{
80105f50:	f3 0f 1e fb          	endbr32 
80105f54:	55                   	push   %ebp
80105f55:	89 e5                	mov    %esp,%ebp
80105f57:	56                   	push   %esi
80105f58:	53                   	push   %ebx
80105f59:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105f5c:	e8 2f df ff ff       	call   80103e90 <myproc>
80105f61:	89 c6                	mov    %eax,%esi
  
  begin_op();
80105f63:	e8 a8 d2 ff ff       	call   80103210 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105f68:	83 ec 08             	sub    $0x8,%esp
80105f6b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f6e:	50                   	push   %eax
80105f6f:	6a 00                	push   $0x0
80105f71:	e8 ca f5 ff ff       	call   80105540 <argstr>
80105f76:	83 c4 10             	add    $0x10,%esp
80105f79:	85 c0                	test   %eax,%eax
80105f7b:	78 73                	js     80105ff0 <sys_chdir+0xa0>
80105f7d:	83 ec 0c             	sub    $0xc,%esp
80105f80:	ff 75 f4             	pushl  -0xc(%ebp)
80105f83:	e8 68 c5 ff ff       	call   801024f0 <namei>
80105f88:	83 c4 10             	add    $0x10,%esp
80105f8b:	89 c3                	mov    %eax,%ebx
80105f8d:	85 c0                	test   %eax,%eax
80105f8f:	74 5f                	je     80105ff0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
80105f91:	83 ec 0c             	sub    $0xc,%esp
80105f94:	50                   	push   %eax
80105f95:	e8 86 bc ff ff       	call   80101c20 <ilock>
  if(ip->type != T_DIR){
80105f9a:	83 c4 10             	add    $0x10,%esp
80105f9d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105fa2:	75 2c                	jne    80105fd0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105fa4:	83 ec 0c             	sub    $0xc,%esp
80105fa7:	53                   	push   %ebx
80105fa8:	e8 53 bd ff ff       	call   80101d00 <iunlock>
  iput(curproc->cwd);
80105fad:	58                   	pop    %eax
80105fae:	ff 76 6c             	pushl  0x6c(%esi)
80105fb1:	e8 9a bd ff ff       	call   80101d50 <iput>
  end_op();
80105fb6:	e8 c5 d2 ff ff       	call   80103280 <end_op>
  curproc->cwd = ip;
80105fbb:	89 5e 6c             	mov    %ebx,0x6c(%esi)
  return 0;
80105fbe:	83 c4 10             	add    $0x10,%esp
80105fc1:	31 c0                	xor    %eax,%eax
}
80105fc3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105fc6:	5b                   	pop    %ebx
80105fc7:	5e                   	pop    %esi
80105fc8:	5d                   	pop    %ebp
80105fc9:	c3                   	ret    
80105fca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105fd0:	83 ec 0c             	sub    $0xc,%esp
80105fd3:	53                   	push   %ebx
80105fd4:	e8 e7 be ff ff       	call   80101ec0 <iunlockput>
    end_op();
80105fd9:	e8 a2 d2 ff ff       	call   80103280 <end_op>
    return -1;
80105fde:	83 c4 10             	add    $0x10,%esp
80105fe1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fe6:	eb db                	jmp    80105fc3 <sys_chdir+0x73>
80105fe8:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fef:	90                   	nop
    end_op();
80105ff0:	e8 8b d2 ff ff       	call   80103280 <end_op>
    return -1;
80105ff5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ffa:	eb c7                	jmp    80105fc3 <sys_chdir+0x73>
80105ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106000 <sys_exec>:

int
sys_exec(void)
{
80106000:	f3 0f 1e fb          	endbr32 
80106004:	55                   	push   %ebp
80106005:	89 e5                	mov    %esp,%ebp
80106007:	57                   	push   %edi
80106008:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106009:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010600f:	53                   	push   %ebx
80106010:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106016:	50                   	push   %eax
80106017:	6a 00                	push   $0x0
80106019:	e8 22 f5 ff ff       	call   80105540 <argstr>
8010601e:	83 c4 10             	add    $0x10,%esp
80106021:	85 c0                	test   %eax,%eax
80106023:	0f 88 8b 00 00 00    	js     801060b4 <sys_exec+0xb4>
80106029:	83 ec 08             	sub    $0x8,%esp
8010602c:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80106032:	50                   	push   %eax
80106033:	6a 01                	push   $0x1
80106035:	e8 56 f4 ff ff       	call   80105490 <argint>
8010603a:	83 c4 10             	add    $0x10,%esp
8010603d:	85 c0                	test   %eax,%eax
8010603f:	78 73                	js     801060b4 <sys_exec+0xb4>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
80106041:	83 ec 04             	sub    $0x4,%esp
80106044:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
  for(i=0;; i++){
8010604a:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
8010604c:	68 80 00 00 00       	push   $0x80
80106051:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
80106057:	6a 00                	push   $0x0
80106059:	50                   	push   %eax
8010605a:	e8 51 f1 ff ff       	call   801051b0 <memset>
8010605f:	83 c4 10             	add    $0x10,%esp
80106062:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106068:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
8010606e:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80106075:	83 ec 08             	sub    $0x8,%esp
80106078:	57                   	push   %edi
80106079:	01 f0                	add    %esi,%eax
8010607b:	50                   	push   %eax
8010607c:	e8 6f f3 ff ff       	call   801053f0 <fetchint>
80106081:	83 c4 10             	add    $0x10,%esp
80106084:	85 c0                	test   %eax,%eax
80106086:	78 2c                	js     801060b4 <sys_exec+0xb4>
      return -1;
    if(uarg == 0){
80106088:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010608e:	85 c0                	test   %eax,%eax
80106090:	74 36                	je     801060c8 <sys_exec+0xc8>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106092:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
80106098:	83 ec 08             	sub    $0x8,%esp
8010609b:	8d 14 31             	lea    (%ecx,%esi,1),%edx
8010609e:	52                   	push   %edx
8010609f:	50                   	push   %eax
801060a0:	e8 8b f3 ff ff       	call   80105430 <fetchstr>
801060a5:	83 c4 10             	add    $0x10,%esp
801060a8:	85 c0                	test   %eax,%eax
801060aa:	78 08                	js     801060b4 <sys_exec+0xb4>
  for(i=0;; i++){
801060ac:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801060af:	83 fb 20             	cmp    $0x20,%ebx
801060b2:	75 b4                	jne    80106068 <sys_exec+0x68>
      return -1;
  }
  return exec(path, argv);
}
801060b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801060b7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801060bc:	5b                   	pop    %ebx
801060bd:	5e                   	pop    %esi
801060be:	5f                   	pop    %edi
801060bf:	5d                   	pop    %ebp
801060c0:	c3                   	ret    
801060c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
801060c8:	83 ec 08             	sub    $0x8,%esp
801060cb:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
      argv[i] = 0;
801060d1:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801060d8:	00 00 00 00 
  return exec(path, argv);
801060dc:	50                   	push   %eax
801060dd:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
801060e3:	e8 58 ae ff ff       	call   80100f40 <exec>
801060e8:	83 c4 10             	add    $0x10,%esp
}
801060eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801060ee:	5b                   	pop    %ebx
801060ef:	5e                   	pop    %esi
801060f0:	5f                   	pop    %edi
801060f1:	5d                   	pop    %ebp
801060f2:	c3                   	ret    
801060f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801060fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106100 <sys_pipe>:

int
sys_pipe(void)
{
80106100:	f3 0f 1e fb          	endbr32 
80106104:	55                   	push   %ebp
80106105:	89 e5                	mov    %esp,%ebp
80106107:	57                   	push   %edi
80106108:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106109:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
8010610c:	53                   	push   %ebx
8010610d:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106110:	6a 08                	push   $0x8
80106112:	50                   	push   %eax
80106113:	6a 00                	push   $0x0
80106115:	e8 c6 f3 ff ff       	call   801054e0 <argptr>
8010611a:	83 c4 10             	add    $0x10,%esp
8010611d:	85 c0                	test   %eax,%eax
8010611f:	78 4e                	js     8010616f <sys_pipe+0x6f>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106121:	83 ec 08             	sub    $0x8,%esp
80106124:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106127:	50                   	push   %eax
80106128:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010612b:	50                   	push   %eax
8010612c:	e8 9f d7 ff ff       	call   801038d0 <pipealloc>
80106131:	83 c4 10             	add    $0x10,%esp
80106134:	85 c0                	test   %eax,%eax
80106136:	78 37                	js     8010616f <sys_pipe+0x6f>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106138:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010613b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010613d:	e8 4e dd ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80106142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd] == 0){
80106148:	8b 74 98 2c          	mov    0x2c(%eax,%ebx,4),%esi
8010614c:	85 f6                	test   %esi,%esi
8010614e:	74 30                	je     80106180 <sys_pipe+0x80>
  for(fd = 0; fd < NOFILE; fd++){
80106150:	83 c3 01             	add    $0x1,%ebx
80106153:	83 fb 10             	cmp    $0x10,%ebx
80106156:	75 f0                	jne    80106148 <sys_pipe+0x48>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
80106158:	83 ec 0c             	sub    $0xc,%esp
8010615b:	ff 75 e0             	pushl  -0x20(%ebp)
8010615e:	e8 1d b2 ff ff       	call   80101380 <fileclose>
    fileclose(wf);
80106163:	58                   	pop    %eax
80106164:	ff 75 e4             	pushl  -0x1c(%ebp)
80106167:	e8 14 b2 ff ff       	call   80101380 <fileclose>
    return -1;
8010616c:	83 c4 10             	add    $0x10,%esp
8010616f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106174:	eb 5b                	jmp    801061d1 <sys_pipe+0xd1>
80106176:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010617d:	8d 76 00             	lea    0x0(%esi),%esi
      curproc->ofile[fd] = f;
80106180:	8d 73 08             	lea    0x8(%ebx),%esi
80106183:	89 7c b0 0c          	mov    %edi,0xc(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106187:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010618a:	e8 01 dd ff ff       	call   80103e90 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010618f:	31 d2                	xor    %edx,%edx
80106191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106198:	8b 4c 90 2c          	mov    0x2c(%eax,%edx,4),%ecx
8010619c:	85 c9                	test   %ecx,%ecx
8010619e:	74 20                	je     801061c0 <sys_pipe+0xc0>
  for(fd = 0; fd < NOFILE; fd++){
801061a0:	83 c2 01             	add    $0x1,%edx
801061a3:	83 fa 10             	cmp    $0x10,%edx
801061a6:	75 f0                	jne    80106198 <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
801061a8:	e8 e3 dc ff ff       	call   80103e90 <myproc>
801061ad:	c7 44 b0 0c 00 00 00 	movl   $0x0,0xc(%eax,%esi,4)
801061b4:	00 
801061b5:	eb a1                	jmp    80106158 <sys_pipe+0x58>
801061b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801061be:	66 90                	xchg   %ax,%ax
      curproc->ofile[fd] = f;
801061c0:	89 7c 90 2c          	mov    %edi,0x2c(%eax,%edx,4)
  }
  fd[0] = fd0;
801061c4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061c7:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801061c9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801061cc:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801061cf:	31 c0                	xor    %eax,%eax
}
801061d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061d4:	5b                   	pop    %ebx
801061d5:	5e                   	pop    %esi
801061d6:	5f                   	pop    %edi
801061d7:	5d                   	pop    %ebp
801061d8:	c3                   	ret    
801061d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801061e0 <sys_get_file_sectors>:
int
sys_get_file_sectors(void){
801061e0:	f3 0f 1e fb          	endbr32 
801061e4:	55                   	push   %ebp
801061e5:	89 e5                	mov    %esp,%ebp
801061e7:	57                   	push   %edi
801061e8:	56                   	push   %esi
    int fd;

    char* tmp;
    int n;

    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
801061e9:	8d 55 d8             	lea    -0x28(%ebp),%edx
801061ec:	8d 45 dc             	lea    -0x24(%ebp),%eax
sys_get_file_sectors(void){
801061ef:	53                   	push   %ebx
801061f0:	83 ec 2c             	sub    $0x2c,%esp
    if(argfd(0, &fd, &f) < 0 || argint(2, &n)<0|| argptr(1, &tmp, n)<0)
801061f3:	e8 98 f5 ff ff       	call   80105790 <argfd.constprop.0>
801061f8:	85 c0                	test   %eax,%eax
801061fa:	0f 88 c0 00 00 00    	js     801062c0 <sys_get_file_sectors+0xe0>
80106200:	83 ec 08             	sub    $0x8,%esp
80106203:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106206:	50                   	push   %eax
80106207:	6a 02                	push   $0x2
80106209:	e8 82 f2 ff ff       	call   80105490 <argint>
8010620e:	83 c4 10             	add    $0x10,%esp
80106211:	85 c0                	test   %eax,%eax
80106213:	0f 88 a7 00 00 00    	js     801062c0 <sys_get_file_sectors+0xe0>
80106219:	83 ec 04             	sub    $0x4,%esp
8010621c:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010621f:	ff 75 e4             	pushl  -0x1c(%ebp)
80106222:	50                   	push   %eax
80106223:	6a 01                	push   $0x1
80106225:	e8 b6 f2 ff ff       	call   801054e0 <argptr>
8010622a:	83 c4 10             	add    $0x10,%esp
8010622d:	85 c0                	test   %eax,%eax
8010622f:	0f 88 8b 00 00 00    	js     801062c0 <sys_get_file_sectors+0xe0>
        return -1;
    int* sectors = (int*) tmp;
80106235:	8b 45 e0             	mov    -0x20(%ebp),%eax

    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
80106238:	31 d2                	xor    %edx,%edx
    int* sectors = (int*) tmp;
8010623a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    int blkcnt = f->ip->size/BSIZE + (f->ip->size%BSIZE ? 1 : 0);
8010623d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80106240:	8b 40 10             	mov    0x10(%eax),%eax
80106243:	8b 70 58             	mov    0x58(%eax),%esi
80106246:	f7 c6 ff 01 00 00    	test   $0x1ff,%esi
8010624c:	0f 95 c2             	setne  %dl
8010624f:	c1 ee 09             	shr    $0x9,%esi
80106252:	01 d6                	add    %edx,%esi
    int min_end = n < blkcnt ? n : blkcnt;
80106254:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80106257:	39 d6                	cmp    %edx,%esi
80106259:	0f 4f f2             	cmovg  %edx,%esi

    int i;
    for(i=0;i<min_end;i++){
8010625c:	85 f6                	test   %esi,%esi
8010625e:	7e 37                	jle    80106297 <sys_get_file_sectors+0xb7>
80106260:	31 db                	xor    %ebx,%ebx
80106262:	eb 0a                	jmp    8010626e <sys_get_file_sectors+0x8e>
80106264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106268:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010626b:	8b 40 10             	mov    0x10(%eax),%eax
        int sec = getbmap(f->ip, i);
8010626e:	83 ec 08             	sub    $0x8,%esp
80106271:	53                   	push   %ebx
80106272:	50                   	push   %eax
80106273:	e8 b8 c2 ff ff       	call   80102530 <getbmap>
80106278:	89 c7                	mov    %eax,%edi
        cprintf("%d ", sec);
8010627a:	58                   	pop    %eax
8010627b:	5a                   	pop    %edx
8010627c:	57                   	push   %edi
8010627d:	68 dd 86 10 80       	push   $0x801086dd
80106282:	e8 29 a4 ff ff       	call   801006b0 <cprintf>
        sectors[i] = sec;
80106287:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    for(i=0;i<min_end;i++){
8010628a:	83 c4 10             	add    $0x10,%esp
        sectors[i] = sec;
8010628d:	89 3c 98             	mov    %edi,(%eax,%ebx,4)
    for(i=0;i<min_end;i++){
80106290:	83 c3 01             	add    $0x1,%ebx
80106293:	39 de                	cmp    %ebx,%esi
80106295:	75 d1                	jne    80106268 <sys_get_file_sectors+0x88>
    }
    cprintf("\n");
80106297:	83 ec 0c             	sub    $0xc,%esp
8010629a:	68 7d 84 10 80       	push   $0x8010847d
8010629f:	e8 0c a4 ff ff       	call   801006b0 <cprintf>
    if (min_end<=n-1)
801062a4:	83 c4 10             	add    $0x10,%esp
        sectors[min_end]=-1;
    return 0;
801062a7:	31 c0                	xor    %eax,%eax
    if (min_end<=n-1)
801062a9:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801062ac:	7e 0a                	jle    801062b8 <sys_get_file_sectors+0xd8>
        sectors[min_end]=-1;
801062ae:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
801062b1:	c7 04 b1 ff ff ff ff 	movl   $0xffffffff,(%ecx,%esi,4)
801062b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801062bb:	5b                   	pop    %ebx
801062bc:	5e                   	pop    %esi
801062bd:	5f                   	pop    %edi
801062be:	5d                   	pop    %ebp
801062bf:	c3                   	ret    
        return -1;
801062c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c5:	eb f1                	jmp    801062b8 <sys_get_file_sectors+0xd8>
801062c7:	66 90                	xchg   %ax,%ax
801062c9:	66 90                	xchg   %ax,%ax
801062cb:	66 90                	xchg   %ax,%ax
801062cd:	66 90                	xchg   %ax,%ax
801062cf:	90                   	nop

801062d0 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
801062d0:	f3 0f 1e fb          	endbr32 
  return fork();
801062d4:	e9 77 dd ff ff       	jmp    80104050 <fork>
801062d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801062e0 <sys_exit>:
}

int
sys_exit(void)
{
801062e0:	f3 0f 1e fb          	endbr32 
801062e4:	55                   	push   %ebp
801062e5:	89 e5                	mov    %esp,%ebp
801062e7:	83 ec 08             	sub    $0x8,%esp
  exit();
801062ea:	e8 41 e3 ff ff       	call   80104630 <exit>
  return 0;  // not reached
}
801062ef:	31 c0                	xor    %eax,%eax
801062f1:	c9                   	leave  
801062f2:	c3                   	ret    
801062f3:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801062fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106300 <sys_wait>:

int
sys_wait(void)
{
80106300:	f3 0f 1e fb          	endbr32 
  return wait();
80106304:	e9 e7 e5 ff ff       	jmp    801048f0 <wait>
80106309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106310 <sys_wait_sleeping>:
}

int sys_wait_sleeping(void){
80106310:	f3 0f 1e fb          	endbr32 
    return wait_sleeping();
80106314:	e9 b7 e8 ff ff       	jmp    80104bd0 <wait_sleeping>
80106319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106320 <sys_set_proc_tracer>:
}
int sys_set_proc_tracer(void){
80106320:	f3 0f 1e fb          	endbr32 
    return set_proc_tracer();
80106324:	e9 77 e9 ff ff       	jmp    80104ca0 <set_proc_tracer>
80106329:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106330 <sys_kill>:
}

int
sys_kill(void)
{
80106330:	f3 0f 1e fb          	endbr32 
80106334:	55                   	push   %ebp
80106335:	89 e5                	mov    %esp,%ebp
80106337:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
8010633a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010633d:	50                   	push   %eax
8010633e:	6a 00                	push   $0x0
80106340:	e8 4b f1 ff ff       	call   80105490 <argint>
80106345:	83 c4 10             	add    $0x10,%esp
80106348:	85 c0                	test   %eax,%eax
8010634a:	78 14                	js     80106360 <sys_kill+0x30>
    return -1;
  return kill(pid);
8010634c:	83 ec 0c             	sub    $0xc,%esp
8010634f:	ff 75 f4             	pushl  -0xc(%ebp)
80106352:	e8 09 e7 ff ff       	call   80104a60 <kill>
80106357:	83 c4 10             	add    $0x10,%esp
}
8010635a:	c9                   	leave  
8010635b:	c3                   	ret    
8010635c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106360:	c9                   	leave  
    return -1;
80106361:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106366:	c3                   	ret    
80106367:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010636e:	66 90                	xchg   %ax,%ax

80106370 <sys_calculate_sum_of_digits>:

int sys_calculate_sum_of_digits(void){
80106370:	f3 0f 1e fb          	endbr32 
80106374:	55                   	push   %ebp
80106375:	89 e5                	mov    %esp,%ebp
80106377:	57                   	push   %edi
80106378:	56                   	push   %esi
80106379:	53                   	push   %ebx
8010637a:	83 ec 0c             	sub    $0xc,%esp
  int num = myproc()->tf->edx; //edx or ebx?
8010637d:	e8 0e db ff ff       	call   80103e90 <myproc>
  //cprintf("edx : %d\n", myproc()->tf->edx);
  //cprintf("number : %d\n",number);
  int result = 0;
  int reminder = 10;
  while(num / reminder != 0){
80106382:	ba 67 66 66 66       	mov    $0x66666667,%edx
  int num = myproc()->tf->edx; //edx or ebx?
80106387:	8b 40 1c             	mov    0x1c(%eax),%eax
8010638a:	8b 48 14             	mov    0x14(%eax),%ecx
  while(num / reminder != 0){
8010638d:	89 c8                	mov    %ecx,%eax
8010638f:	f7 ea                	imul   %edx
80106391:	89 c8                	mov    %ecx,%eax
80106393:	c1 f8 1f             	sar    $0x1f,%eax
80106396:	c1 fa 02             	sar    $0x2,%edx
80106399:	89 d3                	mov    %edx,%ebx
8010639b:	29 c3                	sub    %eax,%ebx
8010639d:	8d 41 09             	lea    0x9(%ecx),%eax
801063a0:	83 f8 12             	cmp    $0x12,%eax
801063a3:	76 3e                	jbe    801063e3 <sys_calculate_sum_of_digits+0x73>
  int result = 0;
801063a5:	31 f6                	xor    %esi,%esi
    result += (num % reminder);
801063a7:	bf 67 66 66 66       	mov    $0x66666667,%edi
801063ac:	eb 04                	jmp    801063b2 <sys_calculate_sum_of_digits+0x42>
801063ae:	66 90                	xchg   %ax,%ax
  while(num / reminder != 0){
801063b0:	89 d3                	mov    %edx,%ebx
    result += (num % reminder);
801063b2:	89 c8                	mov    %ecx,%eax
801063b4:	f7 ef                	imul   %edi
801063b6:	89 c8                	mov    %ecx,%eax
801063b8:	c1 f8 1f             	sar    $0x1f,%eax
801063bb:	c1 fa 02             	sar    $0x2,%edx
801063be:	29 c2                	sub    %eax,%edx
801063c0:	8d 04 92             	lea    (%edx,%edx,4),%eax
801063c3:	01 c0                	add    %eax,%eax
801063c5:	29 c1                	sub    %eax,%ecx
  while(num / reminder != 0){
801063c7:	89 d8                	mov    %ebx,%eax
801063c9:	f7 ef                	imul   %edi
801063cb:	89 d8                	mov    %ebx,%eax
    result += (num % reminder);
801063cd:	01 ce                	add    %ecx,%esi
  while(num / reminder != 0){
801063cf:	89 d9                	mov    %ebx,%ecx
801063d1:	c1 f8 1f             	sar    $0x1f,%eax
801063d4:	c1 fa 02             	sar    $0x2,%edx
801063d7:	29 c2                	sub    %eax,%edx
801063d9:	8d 43 09             	lea    0x9(%ebx),%eax
801063dc:	83 f8 12             	cmp    $0x12,%eax
801063df:	77 cf                	ja     801063b0 <sys_calculate_sum_of_digits+0x40>
801063e1:	01 f1                	add    %esi,%ecx
    num = (num / reminder);
    //cprintf("num : %d\n", num);
  }
  result += num;
  return result;
}
801063e3:	83 c4 0c             	add    $0xc,%esp
801063e6:	89 c8                	mov    %ecx,%eax
801063e8:	5b                   	pop    %ebx
801063e9:	5e                   	pop    %esi
801063ea:	5f                   	pop    %edi
801063eb:	5d                   	pop    %ebp
801063ec:	c3                   	ret    
801063ed:	8d 76 00             	lea    0x0(%esi),%esi

801063f0 <sys_set_HRRN_process_level>:

void 
sys_set_HRRN_process_level(int pid, int priority){
801063f0:	f3 0f 1e fb          	endbr32 
  set_HRRN_process_level(pid, priority);
801063f4:	e9 87 dd ff ff       	jmp    80104180 <set_HRRN_process_level>
801063f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106400 <sys_set_HRRN_system_level>:
}

void 
sys_set_HRRN_system_level(int priority){
80106400:	f3 0f 1e fb          	endbr32 
  set_HRRN_system_level(priority);
80106404:	e9 d7 dd ff ff       	jmp    801041e0 <set_HRRN_system_level>
80106409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106410 <sys_getpid>:
}

int
sys_getpid(void)
{
80106410:	f3 0f 1e fb          	endbr32 
80106414:	55                   	push   %ebp
80106415:	89 e5                	mov    %esp,%ebp
80106417:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
8010641a:	e8 71 da ff ff       	call   80103e90 <myproc>
8010641f:	8b 40 10             	mov    0x10(%eax),%eax
}
80106422:	c9                   	leave  
80106423:	c3                   	ret    
80106424:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010642b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
8010642f:	90                   	nop

80106430 <sys_sbrk>:

int
sys_sbrk(void)
{
80106430:	f3 0f 1e fb          	endbr32 
80106434:	55                   	push   %ebp
80106435:	89 e5                	mov    %esp,%ebp
80106437:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106438:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010643b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010643e:	50                   	push   %eax
8010643f:	6a 00                	push   $0x0
80106441:	e8 4a f0 ff ff       	call   80105490 <argint>
80106446:	83 c4 10             	add    $0x10,%esp
80106449:	85 c0                	test   %eax,%eax
8010644b:	78 23                	js     80106470 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
8010644d:	e8 3e da ff ff       	call   80103e90 <myproc>
  if(growproc(n) < 0)
80106452:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106455:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106457:	ff 75 f4             	pushl  -0xc(%ebp)
8010645a:	e8 71 db ff ff       	call   80103fd0 <growproc>
8010645f:	83 c4 10             	add    $0x10,%esp
80106462:	85 c0                	test   %eax,%eax
80106464:	78 0a                	js     80106470 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106466:	89 d8                	mov    %ebx,%eax
80106468:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010646b:	c9                   	leave  
8010646c:	c3                   	ret    
8010646d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80106470:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106475:	eb ef                	jmp    80106466 <sys_sbrk+0x36>
80106477:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010647e:	66 90                	xchg   %ax,%ax

80106480 <sys_sleep>:

int
sys_sleep(void)
{
80106480:	f3 0f 1e fb          	endbr32 
80106484:	55                   	push   %ebp
80106485:	89 e5                	mov    %esp,%ebp
80106487:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106488:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
8010648b:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010648e:	50                   	push   %eax
8010648f:	6a 00                	push   $0x0
80106491:	e8 fa ef ff ff       	call   80105490 <argint>
80106496:	83 c4 10             	add    $0x10,%esp
80106499:	85 c0                	test   %eax,%eax
8010649b:	0f 88 86 00 00 00    	js     80106527 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
801064a1:	83 ec 0c             	sub    $0xc,%esp
801064a4:	68 a0 63 11 80       	push   $0x801163a0
801064a9:	e8 f2 eb ff ff       	call   801050a0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
801064ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
801064b1:	8b 1d e0 6b 11 80    	mov    0x80116be0,%ebx
  while(ticks - ticks0 < n){
801064b7:	83 c4 10             	add    $0x10,%esp
801064ba:	85 d2                	test   %edx,%edx
801064bc:	75 23                	jne    801064e1 <sys_sleep+0x61>
801064be:	eb 50                	jmp    80106510 <sys_sleep+0x90>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
801064c0:	83 ec 08             	sub    $0x8,%esp
801064c3:	68 a0 63 11 80       	push   $0x801163a0
801064c8:	68 e0 6b 11 80       	push   $0x80116be0
801064cd:	e8 5e e3 ff ff       	call   80104830 <sleep>
  while(ticks - ticks0 < n){
801064d2:	a1 e0 6b 11 80       	mov    0x80116be0,%eax
801064d7:	83 c4 10             	add    $0x10,%esp
801064da:	29 d8                	sub    %ebx,%eax
801064dc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
801064df:	73 2f                	jae    80106510 <sys_sleep+0x90>
    if(myproc()->killed){
801064e1:	e8 aa d9 ff ff       	call   80103e90 <myproc>
801064e6:	8b 40 28             	mov    0x28(%eax),%eax
801064e9:	85 c0                	test   %eax,%eax
801064eb:	74 d3                	je     801064c0 <sys_sleep+0x40>
      release(&tickslock);
801064ed:	83 ec 0c             	sub    $0xc,%esp
801064f0:	68 a0 63 11 80       	push   $0x801163a0
801064f5:	e8 66 ec ff ff       	call   80105160 <release>
  }
  release(&tickslock);
  return 0;
}
801064fa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return -1;
801064fd:	83 c4 10             	add    $0x10,%esp
80106500:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106505:	c9                   	leave  
80106506:	c3                   	ret    
80106507:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010650e:	66 90                	xchg   %ax,%ax
  release(&tickslock);
80106510:	83 ec 0c             	sub    $0xc,%esp
80106513:	68 a0 63 11 80       	push   $0x801163a0
80106518:	e8 43 ec ff ff       	call   80105160 <release>
  return 0;
8010651d:	83 c4 10             	add    $0x10,%esp
80106520:	31 c0                	xor    %eax,%eax
}
80106522:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106525:	c9                   	leave  
80106526:	c3                   	ret    
    return -1;
80106527:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010652c:	eb f4                	jmp    80106522 <sys_sleep+0xa2>
8010652e:	66 90                	xchg   %ax,%ax

80106530 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106530:	f3 0f 1e fb          	endbr32 
80106534:	55                   	push   %ebp
80106535:	89 e5                	mov    %esp,%ebp
80106537:	53                   	push   %ebx
80106538:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
8010653b:	68 a0 63 11 80       	push   $0x801163a0
80106540:	e8 5b eb ff ff       	call   801050a0 <acquire>
  xticks = ticks;
80106545:	8b 1d e0 6b 11 80    	mov    0x80116be0,%ebx
  release(&tickslock);
8010654b:	c7 04 24 a0 63 11 80 	movl   $0x801163a0,(%esp)
80106552:	e8 09 ec ff ff       	call   80105160 <release>
  return xticks;
}
80106557:	89 d8                	mov    %ebx,%eax
80106559:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010655c:	c9                   	leave  
8010655d:	c3                   	ret    
8010655e:	66 90                	xchg   %ax,%ax

80106560 <sys_get_parent_pid>:

int
sys_get_parent_pid(void)
{
80106560:	f3 0f 1e fb          	endbr32 
80106564:	55                   	push   %ebp
80106565:	89 e5                	mov    %esp,%ebp
80106567:	83 ec 08             	sub    $0x8,%esp
	return myproc()->parent->pid;
8010656a:	e8 21 d9 ff ff       	call   80103e90 <myproc>
8010656f:	8b 40 14             	mov    0x14(%eax),%eax
80106572:	8b 40 10             	mov    0x10(%eax),%eax
}
80106575:	c9                   	leave  
80106576:	c3                   	ret    
80106577:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010657e:	66 90                	xchg   %ax,%ax

80106580 <sys_get_proc_level>:

int sys_get_proc_level(void){
80106580:	f3 0f 1e fb          	endbr32 
80106584:	55                   	push   %ebp
80106585:	89 e5                	mov    %esp,%ebp
80106587:	83 ec 20             	sub    $0x20,%esp
    int pid;
    if(argint(0, &pid)<0)
8010658a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010658d:	50                   	push   %eax
8010658e:	6a 00                	push   $0x0
80106590:	e8 fb ee ff ff       	call   80105490 <argint>
80106595:	83 c4 10             	add    $0x10,%esp
80106598:	85 c0                	test   %eax,%eax
8010659a:	78 14                	js     801065b0 <sys_get_proc_level+0x30>
        return -1;
    return get_proc_queue_level(pid);
8010659c:	83 ec 0c             	sub    $0xc,%esp
8010659f:	ff 75 f4             	pushl  -0xc(%ebp)
801065a2:	e8 b9 e7 ff ff       	call   80104d60 <get_proc_queue_level>
801065a7:	83 c4 10             	add    $0x10,%esp
}
801065aa:	c9                   	leave  
801065ab:	c3                   	ret    
801065ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801065b0:	c9                   	leave  
        return -1;
801065b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065b6:	c3                   	ret    
801065b7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801065be:	66 90                	xchg   %ax,%ax

801065c0 <sys_set_proc_level>:

int sys_set_proc_level(void){
801065c0:	f3 0f 1e fb          	endbr32 
801065c4:	55                   	push   %ebp
801065c5:	89 e5                	mov    %esp,%ebp
801065c7:	83 ec 20             	sub    $0x20,%esp
    int pid, target_queue;
    if(argint(0, &pid)<0 || pid<0)
801065ca:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065cd:	50                   	push   %eax
801065ce:	6a 00                	push   $0x0
801065d0:	e8 bb ee ff ff       	call   80105490 <argint>
801065d5:	83 c4 10             	add    $0x10,%esp
801065d8:	85 c0                	test   %eax,%eax
801065da:	78 44                	js     80106620 <sys_set_proc_level+0x60>
801065dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065df:	85 c0                	test   %eax,%eax
801065e1:	78 3d                	js     80106620 <sys_set_proc_level+0x60>
        return -1;

    if(argint(1, &target_queue)<0 || target_queue<=0 || target_queue>3)
801065e3:	83 ec 08             	sub    $0x8,%esp
801065e6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801065e9:	50                   	push   %eax
801065ea:	6a 01                	push   $0x1
801065ec:	e8 9f ee ff ff       	call   80105490 <argint>
801065f1:	83 c4 10             	add    $0x10,%esp
801065f4:	85 c0                	test   %eax,%eax
801065f6:	78 28                	js     80106620 <sys_set_proc_level+0x60>
801065f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065fb:	8d 50 ff             	lea    -0x1(%eax),%edx
801065fe:	83 fa 02             	cmp    $0x2,%edx
80106601:	77 1d                	ja     80106620 <sys_set_proc_level+0x60>
        return -1;

    set_proc_queue_level(pid, target_queue);
80106603:	83 ec 08             	sub    $0x8,%esp
80106606:	50                   	push   %eax
80106607:	ff 75 f0             	pushl  -0x10(%ebp)
8010660a:	e8 91 e7 ff ff       	call   80104da0 <set_proc_queue_level>
    return 0;
8010660f:	83 c4 10             	add    $0x10,%esp
80106612:	31 c0                	xor    %eax,%eax
}
80106614:	c9                   	leave  
80106615:	c3                   	ret    
80106616:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010661d:	8d 76 00             	lea    0x0(%esi),%esi
80106620:	c9                   	leave  
        return -1;
80106621:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106626:	c3                   	ret    

80106627 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106627:	1e                   	push   %ds
  pushl %es
80106628:	06                   	push   %es
  pushl %fs
80106629:	0f a0                	push   %fs
  pushl %gs
8010662b:	0f a8                	push   %gs
  pushal
8010662d:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
8010662e:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106632:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106634:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106636:	54                   	push   %esp
  call trap
80106637:	e8 c4 00 00 00       	call   80106700 <trap>
  addl $4, %esp
8010663c:	83 c4 04             	add    $0x4,%esp

8010663f <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
8010663f:	61                   	popa   
  popl %gs
80106640:	0f a9                	pop    %gs
  popl %fs
80106642:	0f a1                	pop    %fs
  popl %es
80106644:	07                   	pop    %es
  popl %ds
80106645:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106646:	83 c4 08             	add    $0x8,%esp
  iret
80106649:	cf                   	iret   
8010664a:	66 90                	xchg   %ax,%ax
8010664c:	66 90                	xchg   %ax,%ax
8010664e:	66 90                	xchg   %ax,%ax

80106650 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106650:	f3 0f 1e fb          	endbr32 
80106654:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106655:	31 c0                	xor    %eax,%eax
{
80106657:	89 e5                	mov    %esp,%ebp
80106659:	83 ec 08             	sub    $0x8,%esp
8010665c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106660:	8b 14 85 0c b0 10 80 	mov    -0x7fef4ff4(,%eax,4),%edx
80106667:	c7 04 c5 e2 63 11 80 	movl   $0x8e000008,-0x7fee9c1e(,%eax,8)
8010666e:	08 00 00 8e 
80106672:	66 89 14 c5 e0 63 11 	mov    %dx,-0x7fee9c20(,%eax,8)
80106679:	80 
8010667a:	c1 ea 10             	shr    $0x10,%edx
8010667d:	66 89 14 c5 e6 63 11 	mov    %dx,-0x7fee9c1a(,%eax,8)
80106684:	80 
  for(i = 0; i < 256; i++)
80106685:	83 c0 01             	add    $0x1,%eax
80106688:	3d 00 01 00 00       	cmp    $0x100,%eax
8010668d:	75 d1                	jne    80106660 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010668f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106692:	a1 0c b1 10 80       	mov    0x8010b10c,%eax
80106697:	c7 05 e2 65 11 80 08 	movl   $0xef000008,0x801165e2
8010669e:	00 00 ef 
  initlock(&tickslock, "time");
801066a1:	68 e1 86 10 80       	push   $0x801086e1
801066a6:	68 a0 63 11 80       	push   $0x801163a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801066ab:	66 a3 e0 65 11 80    	mov    %ax,0x801165e0
801066b1:	c1 e8 10             	shr    $0x10,%eax
801066b4:	66 a3 e6 65 11 80    	mov    %ax,0x801165e6
  initlock(&tickslock, "time");
801066ba:	e8 61 e8 ff ff       	call   80104f20 <initlock>
}
801066bf:	83 c4 10             	add    $0x10,%esp
801066c2:	c9                   	leave  
801066c3:	c3                   	ret    
801066c4:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801066cb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801066cf:	90                   	nop

801066d0 <idtinit>:

void
idtinit(void)
{
801066d0:	f3 0f 1e fb          	endbr32 
801066d4:	55                   	push   %ebp
  pd[0] = size-1;
801066d5:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801066da:	89 e5                	mov    %esp,%ebp
801066dc:	83 ec 10             	sub    $0x10,%esp
801066df:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801066e3:	b8 e0 63 11 80       	mov    $0x801163e0,%eax
801066e8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801066ec:	c1 e8 10             	shr    $0x10,%eax
801066ef:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801066f3:	8d 45 fa             	lea    -0x6(%ebp),%eax
801066f6:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801066f9:	c9                   	leave  
801066fa:	c3                   	ret    
801066fb:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801066ff:	90                   	nop

80106700 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106700:	f3 0f 1e fb          	endbr32 
80106704:	55                   	push   %ebp
80106705:	89 e5                	mov    %esp,%ebp
80106707:	57                   	push   %edi
80106708:	56                   	push   %esi
80106709:	53                   	push   %ebx
8010670a:	83 ec 1c             	sub    $0x1c,%esp
8010670d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106710:	8b 43 30             	mov    0x30(%ebx),%eax
80106713:	83 f8 40             	cmp    $0x40,%eax
80106716:	0f 84 bc 01 00 00    	je     801068d8 <trap+0x1d8>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
8010671c:	83 e8 20             	sub    $0x20,%eax
8010671f:	83 f8 1f             	cmp    $0x1f,%eax
80106722:	77 08                	ja     8010672c <trap+0x2c>
80106724:	3e ff 24 85 88 87 10 	notrack jmp *-0x7fef7878(,%eax,4)
8010672b:	80 
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
8010672c:	e8 5f d7 ff ff       	call   80103e90 <myproc>
80106731:	8b 7b 38             	mov    0x38(%ebx),%edi
80106734:	85 c0                	test   %eax,%eax
80106736:	0f 84 eb 01 00 00    	je     80106927 <trap+0x227>
8010673c:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106740:	0f 84 e1 01 00 00    	je     80106927 <trap+0x227>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106746:	0f 20 d1             	mov    %cr2,%ecx
80106749:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010674c:	e8 1f d7 ff ff       	call   80103e70 <cpuid>
80106751:	8b 73 30             	mov    0x30(%ebx),%esi
80106754:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106757:	8b 43 34             	mov    0x34(%ebx),%eax
8010675a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
8010675d:	e8 2e d7 ff ff       	call   80103e90 <myproc>
80106762:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106765:	e8 26 d7 ff ff       	call   80103e90 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010676a:	8b 4d d8             	mov    -0x28(%ebp),%ecx
8010676d:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106770:	51                   	push   %ecx
80106771:	57                   	push   %edi
80106772:	52                   	push   %edx
80106773:	ff 75 e4             	pushl  -0x1c(%ebp)
80106776:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106777:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010677a:	83 c6 70             	add    $0x70,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
8010677d:	56                   	push   %esi
8010677e:	ff 70 10             	pushl  0x10(%eax)
80106781:	68 44 87 10 80       	push   $0x80108744
80106786:	e8 25 9f ff ff       	call   801006b0 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
8010678b:	83 c4 20             	add    $0x20,%esp
8010678e:	e8 fd d6 ff ff       	call   80103e90 <myproc>
80106793:	c7 40 28 01 00 00 00 	movl   $0x1,0x28(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010679a:	e8 f1 d6 ff ff       	call   80103e90 <myproc>
8010679f:	85 c0                	test   %eax,%eax
801067a1:	74 1d                	je     801067c0 <trap+0xc0>
801067a3:	e8 e8 d6 ff ff       	call   80103e90 <myproc>
801067a8:	8b 50 28             	mov    0x28(%eax),%edx
801067ab:	85 d2                	test   %edx,%edx
801067ad:	74 11                	je     801067c0 <trap+0xc0>
801067af:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801067b3:	83 e0 03             	and    $0x3,%eax
801067b6:	66 83 f8 03          	cmp    $0x3,%ax
801067ba:	0f 84 50 01 00 00    	je     80106910 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
801067c0:	e8 cb d6 ff ff       	call   80103e90 <myproc>
801067c5:	85 c0                	test   %eax,%eax
801067c7:	74 0f                	je     801067d8 <trap+0xd8>
801067c9:	e8 c2 d6 ff ff       	call   80103e90 <myproc>
801067ce:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
801067d2:	0f 84 e8 00 00 00    	je     801068c0 <trap+0x1c0>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801067d8:	e8 b3 d6 ff ff       	call   80103e90 <myproc>
801067dd:	85 c0                	test   %eax,%eax
801067df:	74 1d                	je     801067fe <trap+0xfe>
801067e1:	e8 aa d6 ff ff       	call   80103e90 <myproc>
801067e6:	8b 40 28             	mov    0x28(%eax),%eax
801067e9:	85 c0                	test   %eax,%eax
801067eb:	74 11                	je     801067fe <trap+0xfe>
801067ed:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801067f1:	83 e0 03             	and    $0x3,%eax
801067f4:	66 83 f8 03          	cmp    $0x3,%ax
801067f8:	0f 84 03 01 00 00    	je     80106901 <trap+0x201>
    exit();
}
801067fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106801:	5b                   	pop    %ebx
80106802:	5e                   	pop    %esi
80106803:	5f                   	pop    %edi
80106804:	5d                   	pop    %ebp
80106805:	c3                   	ret    
    ideintr();
80106806:	e8 b5 be ff ff       	call   801026c0 <ideintr>
    lapiceoi();
8010680b:	e8 90 c5 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106810:	e8 7b d6 ff ff       	call   80103e90 <myproc>
80106815:	85 c0                	test   %eax,%eax
80106817:	75 8a                	jne    801067a3 <trap+0xa3>
80106819:	eb a5                	jmp    801067c0 <trap+0xc0>
    if(cpuid() == 0){
8010681b:	e8 50 d6 ff ff       	call   80103e70 <cpuid>
80106820:	85 c0                	test   %eax,%eax
80106822:	75 e7                	jne    8010680b <trap+0x10b>
      acquire(&tickslock);
80106824:	83 ec 0c             	sub    $0xc,%esp
80106827:	68 a0 63 11 80       	push   $0x801163a0
8010682c:	e8 6f e8 ff ff       	call   801050a0 <acquire>
      wakeup(&ticks);
80106831:	c7 04 24 e0 6b 11 80 	movl   $0x80116be0,(%esp)
      ticks++;
80106838:	83 05 e0 6b 11 80 01 	addl   $0x1,0x80116be0
      wakeup(&ticks);
8010683f:	e8 ac e1 ff ff       	call   801049f0 <wakeup>
      release(&tickslock);
80106844:	c7 04 24 a0 63 11 80 	movl   $0x801163a0,(%esp)
8010684b:	e8 10 e9 ff ff       	call   80105160 <release>
80106850:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106853:	eb b6                	jmp    8010680b <trap+0x10b>
    kbdintr();
80106855:	e8 06 c4 ff ff       	call   80102c60 <kbdintr>
    lapiceoi();
8010685a:	e8 41 c5 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010685f:	e8 2c d6 ff ff       	call   80103e90 <myproc>
80106864:	85 c0                	test   %eax,%eax
80106866:	0f 85 37 ff ff ff    	jne    801067a3 <trap+0xa3>
8010686c:	e9 4f ff ff ff       	jmp    801067c0 <trap+0xc0>
    uartintr();
80106871:	e8 4a 02 00 00       	call   80106ac0 <uartintr>
    lapiceoi();
80106876:	e8 25 c5 ff ff       	call   80102da0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010687b:	e8 10 d6 ff ff       	call   80103e90 <myproc>
80106880:	85 c0                	test   %eax,%eax
80106882:	0f 85 1b ff ff ff    	jne    801067a3 <trap+0xa3>
80106888:	e9 33 ff ff ff       	jmp    801067c0 <trap+0xc0>
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
8010688d:	8b 7b 38             	mov    0x38(%ebx),%edi
80106890:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106894:	e8 d7 d5 ff ff       	call   80103e70 <cpuid>
80106899:	57                   	push   %edi
8010689a:	56                   	push   %esi
8010689b:	50                   	push   %eax
8010689c:	68 ec 86 10 80       	push   $0x801086ec
801068a1:	e8 0a 9e ff ff       	call   801006b0 <cprintf>
    lapiceoi();
801068a6:	e8 f5 c4 ff ff       	call   80102da0 <lapiceoi>
    break;
801068ab:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801068ae:	e8 dd d5 ff ff       	call   80103e90 <myproc>
801068b3:	85 c0                	test   %eax,%eax
801068b5:	0f 85 e8 fe ff ff    	jne    801067a3 <trap+0xa3>
801068bb:	e9 00 ff ff ff       	jmp    801067c0 <trap+0xc0>
  if(myproc() && myproc()->state == RUNNING &&
801068c0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801068c4:	0f 85 0e ff ff ff    	jne    801067d8 <trap+0xd8>
    yield();
801068ca:	e8 a1 de ff ff       	call   80104770 <yield>
801068cf:	e9 04 ff ff ff       	jmp    801067d8 <trap+0xd8>
801068d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
801068d8:	e8 b3 d5 ff ff       	call   80103e90 <myproc>
801068dd:	8b 70 28             	mov    0x28(%eax),%esi
801068e0:	85 f6                	test   %esi,%esi
801068e2:	75 3c                	jne    80106920 <trap+0x220>
    myproc()->tf = tf;
801068e4:	e8 a7 d5 ff ff       	call   80103e90 <myproc>
801068e9:	89 58 1c             	mov    %ebx,0x1c(%eax)
    syscall();
801068ec:	e8 8f ec ff ff       	call   80105580 <syscall>
    if(myproc()->killed)
801068f1:	e8 9a d5 ff ff       	call   80103e90 <myproc>
801068f6:	8b 48 28             	mov    0x28(%eax),%ecx
801068f9:	85 c9                	test   %ecx,%ecx
801068fb:	0f 84 fd fe ff ff    	je     801067fe <trap+0xfe>
}
80106901:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106904:	5b                   	pop    %ebx
80106905:	5e                   	pop    %esi
80106906:	5f                   	pop    %edi
80106907:	5d                   	pop    %ebp
      exit();
80106908:	e9 23 dd ff ff       	jmp    80104630 <exit>
8010690d:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
80106910:	e8 1b dd ff ff       	call   80104630 <exit>
80106915:	e9 a6 fe ff ff       	jmp    801067c0 <trap+0xc0>
8010691a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106920:	e8 0b dd ff ff       	call   80104630 <exit>
80106925:	eb bd                	jmp    801068e4 <trap+0x1e4>
80106927:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
8010692a:	e8 41 d5 ff ff       	call   80103e70 <cpuid>
8010692f:	83 ec 0c             	sub    $0xc,%esp
80106932:	56                   	push   %esi
80106933:	57                   	push   %edi
80106934:	50                   	push   %eax
80106935:	ff 73 30             	pushl  0x30(%ebx)
80106938:	68 10 87 10 80       	push   $0x80108710
8010693d:	e8 6e 9d ff ff       	call   801006b0 <cprintf>
      panic("trap");
80106942:	83 c4 14             	add    $0x14,%esp
80106945:	68 e6 86 10 80       	push   $0x801086e6
8010694a:	e8 41 9a ff ff       	call   80100390 <panic>
8010694f:	90                   	nop

80106950 <uartgetc>:
  outb(COM1+0, c);
}

static int
uartgetc(void)
{
80106950:	f3 0f 1e fb          	endbr32 
  if(!uart)
80106954:	a1 e0 b5 10 80       	mov    0x8010b5e0,%eax
80106959:	85 c0                	test   %eax,%eax
8010695b:	74 1b                	je     80106978 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010695d:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106962:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106963:	a8 01                	test   $0x1,%al
80106965:	74 11                	je     80106978 <uartgetc+0x28>
80106967:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010696c:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010696d:	0f b6 c0             	movzbl %al,%eax
80106970:	c3                   	ret    
80106971:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106978:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010697d:	c3                   	ret    
8010697e:	66 90                	xchg   %ax,%ax

80106980 <uartputc.part.0>:
uartputc(int c)
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	89 c7                	mov    %eax,%edi
80106986:	56                   	push   %esi
80106987:	be fd 03 00 00       	mov    $0x3fd,%esi
8010698c:	53                   	push   %ebx
8010698d:	bb 80 00 00 00       	mov    $0x80,%ebx
80106992:	83 ec 0c             	sub    $0xc,%esp
80106995:	eb 1b                	jmp    801069b2 <uartputc.part.0+0x32>
80106997:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010699e:	66 90                	xchg   %ax,%ax
    microdelay(10);
801069a0:	83 ec 0c             	sub    $0xc,%esp
801069a3:	6a 0a                	push   $0xa
801069a5:	e8 16 c4 ff ff       	call   80102dc0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801069aa:	83 c4 10             	add    $0x10,%esp
801069ad:	83 eb 01             	sub    $0x1,%ebx
801069b0:	74 07                	je     801069b9 <uartputc.part.0+0x39>
801069b2:	89 f2                	mov    %esi,%edx
801069b4:	ec                   	in     (%dx),%al
801069b5:	a8 20                	test   $0x20,%al
801069b7:	74 e7                	je     801069a0 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801069b9:	ba f8 03 00 00       	mov    $0x3f8,%edx
801069be:	89 f8                	mov    %edi,%eax
801069c0:	ee                   	out    %al,(%dx)
}
801069c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069c4:	5b                   	pop    %ebx
801069c5:	5e                   	pop    %esi
801069c6:	5f                   	pop    %edi
801069c7:	5d                   	pop    %ebp
801069c8:	c3                   	ret    
801069c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801069d0 <uartinit>:
{
801069d0:	f3 0f 1e fb          	endbr32 
801069d4:	55                   	push   %ebp
801069d5:	31 c9                	xor    %ecx,%ecx
801069d7:	89 c8                	mov    %ecx,%eax
801069d9:	89 e5                	mov    %esp,%ebp
801069db:	57                   	push   %edi
801069dc:	56                   	push   %esi
801069dd:	53                   	push   %ebx
801069de:	bb fa 03 00 00       	mov    $0x3fa,%ebx
801069e3:	89 da                	mov    %ebx,%edx
801069e5:	83 ec 0c             	sub    $0xc,%esp
801069e8:	ee                   	out    %al,(%dx)
801069e9:	bf fb 03 00 00       	mov    $0x3fb,%edi
801069ee:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
801069f3:	89 fa                	mov    %edi,%edx
801069f5:	ee                   	out    %al,(%dx)
801069f6:	b8 0c 00 00 00       	mov    $0xc,%eax
801069fb:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a00:	ee                   	out    %al,(%dx)
80106a01:	be f9 03 00 00       	mov    $0x3f9,%esi
80106a06:	89 c8                	mov    %ecx,%eax
80106a08:	89 f2                	mov    %esi,%edx
80106a0a:	ee                   	out    %al,(%dx)
80106a0b:	b8 03 00 00 00       	mov    $0x3,%eax
80106a10:	89 fa                	mov    %edi,%edx
80106a12:	ee                   	out    %al,(%dx)
80106a13:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106a18:	89 c8                	mov    %ecx,%eax
80106a1a:	ee                   	out    %al,(%dx)
80106a1b:	b8 01 00 00 00       	mov    $0x1,%eax
80106a20:	89 f2                	mov    %esi,%edx
80106a22:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80106a23:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106a28:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80106a29:	3c ff                	cmp    $0xff,%al
80106a2b:	74 52                	je     80106a7f <uartinit+0xaf>
  uart = 1;
80106a2d:	c7 05 e0 b5 10 80 01 	movl   $0x1,0x8010b5e0
80106a34:	00 00 00 
80106a37:	89 da                	mov    %ebx,%edx
80106a39:	ec                   	in     (%dx),%al
80106a3a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106a3f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80106a40:	83 ec 08             	sub    $0x8,%esp
80106a43:	be 76 00 00 00       	mov    $0x76,%esi
  for(p="xv6...\n"; *p; p++)
80106a48:	bb 08 88 10 80       	mov    $0x80108808,%ebx
  ioapicenable(IRQ_COM1, 0);
80106a4d:	6a 00                	push   $0x0
80106a4f:	6a 04                	push   $0x4
80106a51:	e8 ba be ff ff       	call   80102910 <ioapicenable>
80106a56:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106a59:	b8 78 00 00 00       	mov    $0x78,%eax
80106a5e:	eb 04                	jmp    80106a64 <uartinit+0x94>
80106a60:	0f b6 73 01          	movzbl 0x1(%ebx),%esi
  if(!uart)
80106a64:	8b 15 e0 b5 10 80    	mov    0x8010b5e0,%edx
80106a6a:	85 d2                	test   %edx,%edx
80106a6c:	74 08                	je     80106a76 <uartinit+0xa6>
    uartputc(*p);
80106a6e:	0f be c0             	movsbl %al,%eax
80106a71:	e8 0a ff ff ff       	call   80106980 <uartputc.part.0>
  for(p="xv6...\n"; *p; p++)
80106a76:	89 f0                	mov    %esi,%eax
80106a78:	83 c3 01             	add    $0x1,%ebx
80106a7b:	84 c0                	test   %al,%al
80106a7d:	75 e1                	jne    80106a60 <uartinit+0x90>
}
80106a7f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a82:	5b                   	pop    %ebx
80106a83:	5e                   	pop    %esi
80106a84:	5f                   	pop    %edi
80106a85:	5d                   	pop    %ebp
80106a86:	c3                   	ret    
80106a87:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106a8e:	66 90                	xchg   %ax,%ax

80106a90 <uartputc>:
{
80106a90:	f3 0f 1e fb          	endbr32 
80106a94:	55                   	push   %ebp
  if(!uart)
80106a95:	8b 15 e0 b5 10 80    	mov    0x8010b5e0,%edx
{
80106a9b:	89 e5                	mov    %esp,%ebp
80106a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
80106aa0:	85 d2                	test   %edx,%edx
80106aa2:	74 0c                	je     80106ab0 <uartputc+0x20>
}
80106aa4:	5d                   	pop    %ebp
80106aa5:	e9 d6 fe ff ff       	jmp    80106980 <uartputc.part.0>
80106aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106ab0:	5d                   	pop    %ebp
80106ab1:	c3                   	ret    
80106ab2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106ac0 <uartintr>:

void
uartintr(void)
{
80106ac0:	f3 0f 1e fb          	endbr32 
80106ac4:	55                   	push   %ebp
80106ac5:	89 e5                	mov    %esp,%ebp
80106ac7:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106aca:	68 50 69 10 80       	push   $0x80106950
80106acf:	e8 8c a0 ff ff       	call   80100b60 <consoleintr>
}
80106ad4:	83 c4 10             	add    $0x10,%esp
80106ad7:	c9                   	leave  
80106ad8:	c3                   	ret    

80106ad9 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106ad9:	6a 00                	push   $0x0
  pushl $0
80106adb:	6a 00                	push   $0x0
  jmp alltraps
80106add:	e9 45 fb ff ff       	jmp    80106627 <alltraps>

80106ae2 <vector1>:
.globl vector1
vector1:
  pushl $0
80106ae2:	6a 00                	push   $0x0
  pushl $1
80106ae4:	6a 01                	push   $0x1
  jmp alltraps
80106ae6:	e9 3c fb ff ff       	jmp    80106627 <alltraps>

80106aeb <vector2>:
.globl vector2
vector2:
  pushl $0
80106aeb:	6a 00                	push   $0x0
  pushl $2
80106aed:	6a 02                	push   $0x2
  jmp alltraps
80106aef:	e9 33 fb ff ff       	jmp    80106627 <alltraps>

80106af4 <vector3>:
.globl vector3
vector3:
  pushl $0
80106af4:	6a 00                	push   $0x0
  pushl $3
80106af6:	6a 03                	push   $0x3
  jmp alltraps
80106af8:	e9 2a fb ff ff       	jmp    80106627 <alltraps>

80106afd <vector4>:
.globl vector4
vector4:
  pushl $0
80106afd:	6a 00                	push   $0x0
  pushl $4
80106aff:	6a 04                	push   $0x4
  jmp alltraps
80106b01:	e9 21 fb ff ff       	jmp    80106627 <alltraps>

80106b06 <vector5>:
.globl vector5
vector5:
  pushl $0
80106b06:	6a 00                	push   $0x0
  pushl $5
80106b08:	6a 05                	push   $0x5
  jmp alltraps
80106b0a:	e9 18 fb ff ff       	jmp    80106627 <alltraps>

80106b0f <vector6>:
.globl vector6
vector6:
  pushl $0
80106b0f:	6a 00                	push   $0x0
  pushl $6
80106b11:	6a 06                	push   $0x6
  jmp alltraps
80106b13:	e9 0f fb ff ff       	jmp    80106627 <alltraps>

80106b18 <vector7>:
.globl vector7
vector7:
  pushl $0
80106b18:	6a 00                	push   $0x0
  pushl $7
80106b1a:	6a 07                	push   $0x7
  jmp alltraps
80106b1c:	e9 06 fb ff ff       	jmp    80106627 <alltraps>

80106b21 <vector8>:
.globl vector8
vector8:
  pushl $8
80106b21:	6a 08                	push   $0x8
  jmp alltraps
80106b23:	e9 ff fa ff ff       	jmp    80106627 <alltraps>

80106b28 <vector9>:
.globl vector9
vector9:
  pushl $0
80106b28:	6a 00                	push   $0x0
  pushl $9
80106b2a:	6a 09                	push   $0x9
  jmp alltraps
80106b2c:	e9 f6 fa ff ff       	jmp    80106627 <alltraps>

80106b31 <vector10>:
.globl vector10
vector10:
  pushl $10
80106b31:	6a 0a                	push   $0xa
  jmp alltraps
80106b33:	e9 ef fa ff ff       	jmp    80106627 <alltraps>

80106b38 <vector11>:
.globl vector11
vector11:
  pushl $11
80106b38:	6a 0b                	push   $0xb
  jmp alltraps
80106b3a:	e9 e8 fa ff ff       	jmp    80106627 <alltraps>

80106b3f <vector12>:
.globl vector12
vector12:
  pushl $12
80106b3f:	6a 0c                	push   $0xc
  jmp alltraps
80106b41:	e9 e1 fa ff ff       	jmp    80106627 <alltraps>

80106b46 <vector13>:
.globl vector13
vector13:
  pushl $13
80106b46:	6a 0d                	push   $0xd
  jmp alltraps
80106b48:	e9 da fa ff ff       	jmp    80106627 <alltraps>

80106b4d <vector14>:
.globl vector14
vector14:
  pushl $14
80106b4d:	6a 0e                	push   $0xe
  jmp alltraps
80106b4f:	e9 d3 fa ff ff       	jmp    80106627 <alltraps>

80106b54 <vector15>:
.globl vector15
vector15:
  pushl $0
80106b54:	6a 00                	push   $0x0
  pushl $15
80106b56:	6a 0f                	push   $0xf
  jmp alltraps
80106b58:	e9 ca fa ff ff       	jmp    80106627 <alltraps>

80106b5d <vector16>:
.globl vector16
vector16:
  pushl $0
80106b5d:	6a 00                	push   $0x0
  pushl $16
80106b5f:	6a 10                	push   $0x10
  jmp alltraps
80106b61:	e9 c1 fa ff ff       	jmp    80106627 <alltraps>

80106b66 <vector17>:
.globl vector17
vector17:
  pushl $17
80106b66:	6a 11                	push   $0x11
  jmp alltraps
80106b68:	e9 ba fa ff ff       	jmp    80106627 <alltraps>

80106b6d <vector18>:
.globl vector18
vector18:
  pushl $0
80106b6d:	6a 00                	push   $0x0
  pushl $18
80106b6f:	6a 12                	push   $0x12
  jmp alltraps
80106b71:	e9 b1 fa ff ff       	jmp    80106627 <alltraps>

80106b76 <vector19>:
.globl vector19
vector19:
  pushl $0
80106b76:	6a 00                	push   $0x0
  pushl $19
80106b78:	6a 13                	push   $0x13
  jmp alltraps
80106b7a:	e9 a8 fa ff ff       	jmp    80106627 <alltraps>

80106b7f <vector20>:
.globl vector20
vector20:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $20
80106b81:	6a 14                	push   $0x14
  jmp alltraps
80106b83:	e9 9f fa ff ff       	jmp    80106627 <alltraps>

80106b88 <vector21>:
.globl vector21
vector21:
  pushl $0
80106b88:	6a 00                	push   $0x0
  pushl $21
80106b8a:	6a 15                	push   $0x15
  jmp alltraps
80106b8c:	e9 96 fa ff ff       	jmp    80106627 <alltraps>

80106b91 <vector22>:
.globl vector22
vector22:
  pushl $0
80106b91:	6a 00                	push   $0x0
  pushl $22
80106b93:	6a 16                	push   $0x16
  jmp alltraps
80106b95:	e9 8d fa ff ff       	jmp    80106627 <alltraps>

80106b9a <vector23>:
.globl vector23
vector23:
  pushl $0
80106b9a:	6a 00                	push   $0x0
  pushl $23
80106b9c:	6a 17                	push   $0x17
  jmp alltraps
80106b9e:	e9 84 fa ff ff       	jmp    80106627 <alltraps>

80106ba3 <vector24>:
.globl vector24
vector24:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $24
80106ba5:	6a 18                	push   $0x18
  jmp alltraps
80106ba7:	e9 7b fa ff ff       	jmp    80106627 <alltraps>

80106bac <vector25>:
.globl vector25
vector25:
  pushl $0
80106bac:	6a 00                	push   $0x0
  pushl $25
80106bae:	6a 19                	push   $0x19
  jmp alltraps
80106bb0:	e9 72 fa ff ff       	jmp    80106627 <alltraps>

80106bb5 <vector26>:
.globl vector26
vector26:
  pushl $0
80106bb5:	6a 00                	push   $0x0
  pushl $26
80106bb7:	6a 1a                	push   $0x1a
  jmp alltraps
80106bb9:	e9 69 fa ff ff       	jmp    80106627 <alltraps>

80106bbe <vector27>:
.globl vector27
vector27:
  pushl $0
80106bbe:	6a 00                	push   $0x0
  pushl $27
80106bc0:	6a 1b                	push   $0x1b
  jmp alltraps
80106bc2:	e9 60 fa ff ff       	jmp    80106627 <alltraps>

80106bc7 <vector28>:
.globl vector28
vector28:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $28
80106bc9:	6a 1c                	push   $0x1c
  jmp alltraps
80106bcb:	e9 57 fa ff ff       	jmp    80106627 <alltraps>

80106bd0 <vector29>:
.globl vector29
vector29:
  pushl $0
80106bd0:	6a 00                	push   $0x0
  pushl $29
80106bd2:	6a 1d                	push   $0x1d
  jmp alltraps
80106bd4:	e9 4e fa ff ff       	jmp    80106627 <alltraps>

80106bd9 <vector30>:
.globl vector30
vector30:
  pushl $0
80106bd9:	6a 00                	push   $0x0
  pushl $30
80106bdb:	6a 1e                	push   $0x1e
  jmp alltraps
80106bdd:	e9 45 fa ff ff       	jmp    80106627 <alltraps>

80106be2 <vector31>:
.globl vector31
vector31:
  pushl $0
80106be2:	6a 00                	push   $0x0
  pushl $31
80106be4:	6a 1f                	push   $0x1f
  jmp alltraps
80106be6:	e9 3c fa ff ff       	jmp    80106627 <alltraps>

80106beb <vector32>:
.globl vector32
vector32:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $32
80106bed:	6a 20                	push   $0x20
  jmp alltraps
80106bef:	e9 33 fa ff ff       	jmp    80106627 <alltraps>

80106bf4 <vector33>:
.globl vector33
vector33:
  pushl $0
80106bf4:	6a 00                	push   $0x0
  pushl $33
80106bf6:	6a 21                	push   $0x21
  jmp alltraps
80106bf8:	e9 2a fa ff ff       	jmp    80106627 <alltraps>

80106bfd <vector34>:
.globl vector34
vector34:
  pushl $0
80106bfd:	6a 00                	push   $0x0
  pushl $34
80106bff:	6a 22                	push   $0x22
  jmp alltraps
80106c01:	e9 21 fa ff ff       	jmp    80106627 <alltraps>

80106c06 <vector35>:
.globl vector35
vector35:
  pushl $0
80106c06:	6a 00                	push   $0x0
  pushl $35
80106c08:	6a 23                	push   $0x23
  jmp alltraps
80106c0a:	e9 18 fa ff ff       	jmp    80106627 <alltraps>

80106c0f <vector36>:
.globl vector36
vector36:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $36
80106c11:	6a 24                	push   $0x24
  jmp alltraps
80106c13:	e9 0f fa ff ff       	jmp    80106627 <alltraps>

80106c18 <vector37>:
.globl vector37
vector37:
  pushl $0
80106c18:	6a 00                	push   $0x0
  pushl $37
80106c1a:	6a 25                	push   $0x25
  jmp alltraps
80106c1c:	e9 06 fa ff ff       	jmp    80106627 <alltraps>

80106c21 <vector38>:
.globl vector38
vector38:
  pushl $0
80106c21:	6a 00                	push   $0x0
  pushl $38
80106c23:	6a 26                	push   $0x26
  jmp alltraps
80106c25:	e9 fd f9 ff ff       	jmp    80106627 <alltraps>

80106c2a <vector39>:
.globl vector39
vector39:
  pushl $0
80106c2a:	6a 00                	push   $0x0
  pushl $39
80106c2c:	6a 27                	push   $0x27
  jmp alltraps
80106c2e:	e9 f4 f9 ff ff       	jmp    80106627 <alltraps>

80106c33 <vector40>:
.globl vector40
vector40:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $40
80106c35:	6a 28                	push   $0x28
  jmp alltraps
80106c37:	e9 eb f9 ff ff       	jmp    80106627 <alltraps>

80106c3c <vector41>:
.globl vector41
vector41:
  pushl $0
80106c3c:	6a 00                	push   $0x0
  pushl $41
80106c3e:	6a 29                	push   $0x29
  jmp alltraps
80106c40:	e9 e2 f9 ff ff       	jmp    80106627 <alltraps>

80106c45 <vector42>:
.globl vector42
vector42:
  pushl $0
80106c45:	6a 00                	push   $0x0
  pushl $42
80106c47:	6a 2a                	push   $0x2a
  jmp alltraps
80106c49:	e9 d9 f9 ff ff       	jmp    80106627 <alltraps>

80106c4e <vector43>:
.globl vector43
vector43:
  pushl $0
80106c4e:	6a 00                	push   $0x0
  pushl $43
80106c50:	6a 2b                	push   $0x2b
  jmp alltraps
80106c52:	e9 d0 f9 ff ff       	jmp    80106627 <alltraps>

80106c57 <vector44>:
.globl vector44
vector44:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $44
80106c59:	6a 2c                	push   $0x2c
  jmp alltraps
80106c5b:	e9 c7 f9 ff ff       	jmp    80106627 <alltraps>

80106c60 <vector45>:
.globl vector45
vector45:
  pushl $0
80106c60:	6a 00                	push   $0x0
  pushl $45
80106c62:	6a 2d                	push   $0x2d
  jmp alltraps
80106c64:	e9 be f9 ff ff       	jmp    80106627 <alltraps>

80106c69 <vector46>:
.globl vector46
vector46:
  pushl $0
80106c69:	6a 00                	push   $0x0
  pushl $46
80106c6b:	6a 2e                	push   $0x2e
  jmp alltraps
80106c6d:	e9 b5 f9 ff ff       	jmp    80106627 <alltraps>

80106c72 <vector47>:
.globl vector47
vector47:
  pushl $0
80106c72:	6a 00                	push   $0x0
  pushl $47
80106c74:	6a 2f                	push   $0x2f
  jmp alltraps
80106c76:	e9 ac f9 ff ff       	jmp    80106627 <alltraps>

80106c7b <vector48>:
.globl vector48
vector48:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $48
80106c7d:	6a 30                	push   $0x30
  jmp alltraps
80106c7f:	e9 a3 f9 ff ff       	jmp    80106627 <alltraps>

80106c84 <vector49>:
.globl vector49
vector49:
  pushl $0
80106c84:	6a 00                	push   $0x0
  pushl $49
80106c86:	6a 31                	push   $0x31
  jmp alltraps
80106c88:	e9 9a f9 ff ff       	jmp    80106627 <alltraps>

80106c8d <vector50>:
.globl vector50
vector50:
  pushl $0
80106c8d:	6a 00                	push   $0x0
  pushl $50
80106c8f:	6a 32                	push   $0x32
  jmp alltraps
80106c91:	e9 91 f9 ff ff       	jmp    80106627 <alltraps>

80106c96 <vector51>:
.globl vector51
vector51:
  pushl $0
80106c96:	6a 00                	push   $0x0
  pushl $51
80106c98:	6a 33                	push   $0x33
  jmp alltraps
80106c9a:	e9 88 f9 ff ff       	jmp    80106627 <alltraps>

80106c9f <vector52>:
.globl vector52
vector52:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $52
80106ca1:	6a 34                	push   $0x34
  jmp alltraps
80106ca3:	e9 7f f9 ff ff       	jmp    80106627 <alltraps>

80106ca8 <vector53>:
.globl vector53
vector53:
  pushl $0
80106ca8:	6a 00                	push   $0x0
  pushl $53
80106caa:	6a 35                	push   $0x35
  jmp alltraps
80106cac:	e9 76 f9 ff ff       	jmp    80106627 <alltraps>

80106cb1 <vector54>:
.globl vector54
vector54:
  pushl $0
80106cb1:	6a 00                	push   $0x0
  pushl $54
80106cb3:	6a 36                	push   $0x36
  jmp alltraps
80106cb5:	e9 6d f9 ff ff       	jmp    80106627 <alltraps>

80106cba <vector55>:
.globl vector55
vector55:
  pushl $0
80106cba:	6a 00                	push   $0x0
  pushl $55
80106cbc:	6a 37                	push   $0x37
  jmp alltraps
80106cbe:	e9 64 f9 ff ff       	jmp    80106627 <alltraps>

80106cc3 <vector56>:
.globl vector56
vector56:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $56
80106cc5:	6a 38                	push   $0x38
  jmp alltraps
80106cc7:	e9 5b f9 ff ff       	jmp    80106627 <alltraps>

80106ccc <vector57>:
.globl vector57
vector57:
  pushl $0
80106ccc:	6a 00                	push   $0x0
  pushl $57
80106cce:	6a 39                	push   $0x39
  jmp alltraps
80106cd0:	e9 52 f9 ff ff       	jmp    80106627 <alltraps>

80106cd5 <vector58>:
.globl vector58
vector58:
  pushl $0
80106cd5:	6a 00                	push   $0x0
  pushl $58
80106cd7:	6a 3a                	push   $0x3a
  jmp alltraps
80106cd9:	e9 49 f9 ff ff       	jmp    80106627 <alltraps>

80106cde <vector59>:
.globl vector59
vector59:
  pushl $0
80106cde:	6a 00                	push   $0x0
  pushl $59
80106ce0:	6a 3b                	push   $0x3b
  jmp alltraps
80106ce2:	e9 40 f9 ff ff       	jmp    80106627 <alltraps>

80106ce7 <vector60>:
.globl vector60
vector60:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $60
80106ce9:	6a 3c                	push   $0x3c
  jmp alltraps
80106ceb:	e9 37 f9 ff ff       	jmp    80106627 <alltraps>

80106cf0 <vector61>:
.globl vector61
vector61:
  pushl $0
80106cf0:	6a 00                	push   $0x0
  pushl $61
80106cf2:	6a 3d                	push   $0x3d
  jmp alltraps
80106cf4:	e9 2e f9 ff ff       	jmp    80106627 <alltraps>

80106cf9 <vector62>:
.globl vector62
vector62:
  pushl $0
80106cf9:	6a 00                	push   $0x0
  pushl $62
80106cfb:	6a 3e                	push   $0x3e
  jmp alltraps
80106cfd:	e9 25 f9 ff ff       	jmp    80106627 <alltraps>

80106d02 <vector63>:
.globl vector63
vector63:
  pushl $0
80106d02:	6a 00                	push   $0x0
  pushl $63
80106d04:	6a 3f                	push   $0x3f
  jmp alltraps
80106d06:	e9 1c f9 ff ff       	jmp    80106627 <alltraps>

80106d0b <vector64>:
.globl vector64
vector64:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $64
80106d0d:	6a 40                	push   $0x40
  jmp alltraps
80106d0f:	e9 13 f9 ff ff       	jmp    80106627 <alltraps>

80106d14 <vector65>:
.globl vector65
vector65:
  pushl $0
80106d14:	6a 00                	push   $0x0
  pushl $65
80106d16:	6a 41                	push   $0x41
  jmp alltraps
80106d18:	e9 0a f9 ff ff       	jmp    80106627 <alltraps>

80106d1d <vector66>:
.globl vector66
vector66:
  pushl $0
80106d1d:	6a 00                	push   $0x0
  pushl $66
80106d1f:	6a 42                	push   $0x42
  jmp alltraps
80106d21:	e9 01 f9 ff ff       	jmp    80106627 <alltraps>

80106d26 <vector67>:
.globl vector67
vector67:
  pushl $0
80106d26:	6a 00                	push   $0x0
  pushl $67
80106d28:	6a 43                	push   $0x43
  jmp alltraps
80106d2a:	e9 f8 f8 ff ff       	jmp    80106627 <alltraps>

80106d2f <vector68>:
.globl vector68
vector68:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $68
80106d31:	6a 44                	push   $0x44
  jmp alltraps
80106d33:	e9 ef f8 ff ff       	jmp    80106627 <alltraps>

80106d38 <vector69>:
.globl vector69
vector69:
  pushl $0
80106d38:	6a 00                	push   $0x0
  pushl $69
80106d3a:	6a 45                	push   $0x45
  jmp alltraps
80106d3c:	e9 e6 f8 ff ff       	jmp    80106627 <alltraps>

80106d41 <vector70>:
.globl vector70
vector70:
  pushl $0
80106d41:	6a 00                	push   $0x0
  pushl $70
80106d43:	6a 46                	push   $0x46
  jmp alltraps
80106d45:	e9 dd f8 ff ff       	jmp    80106627 <alltraps>

80106d4a <vector71>:
.globl vector71
vector71:
  pushl $0
80106d4a:	6a 00                	push   $0x0
  pushl $71
80106d4c:	6a 47                	push   $0x47
  jmp alltraps
80106d4e:	e9 d4 f8 ff ff       	jmp    80106627 <alltraps>

80106d53 <vector72>:
.globl vector72
vector72:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $72
80106d55:	6a 48                	push   $0x48
  jmp alltraps
80106d57:	e9 cb f8 ff ff       	jmp    80106627 <alltraps>

80106d5c <vector73>:
.globl vector73
vector73:
  pushl $0
80106d5c:	6a 00                	push   $0x0
  pushl $73
80106d5e:	6a 49                	push   $0x49
  jmp alltraps
80106d60:	e9 c2 f8 ff ff       	jmp    80106627 <alltraps>

80106d65 <vector74>:
.globl vector74
vector74:
  pushl $0
80106d65:	6a 00                	push   $0x0
  pushl $74
80106d67:	6a 4a                	push   $0x4a
  jmp alltraps
80106d69:	e9 b9 f8 ff ff       	jmp    80106627 <alltraps>

80106d6e <vector75>:
.globl vector75
vector75:
  pushl $0
80106d6e:	6a 00                	push   $0x0
  pushl $75
80106d70:	6a 4b                	push   $0x4b
  jmp alltraps
80106d72:	e9 b0 f8 ff ff       	jmp    80106627 <alltraps>

80106d77 <vector76>:
.globl vector76
vector76:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $76
80106d79:	6a 4c                	push   $0x4c
  jmp alltraps
80106d7b:	e9 a7 f8 ff ff       	jmp    80106627 <alltraps>

80106d80 <vector77>:
.globl vector77
vector77:
  pushl $0
80106d80:	6a 00                	push   $0x0
  pushl $77
80106d82:	6a 4d                	push   $0x4d
  jmp alltraps
80106d84:	e9 9e f8 ff ff       	jmp    80106627 <alltraps>

80106d89 <vector78>:
.globl vector78
vector78:
  pushl $0
80106d89:	6a 00                	push   $0x0
  pushl $78
80106d8b:	6a 4e                	push   $0x4e
  jmp alltraps
80106d8d:	e9 95 f8 ff ff       	jmp    80106627 <alltraps>

80106d92 <vector79>:
.globl vector79
vector79:
  pushl $0
80106d92:	6a 00                	push   $0x0
  pushl $79
80106d94:	6a 4f                	push   $0x4f
  jmp alltraps
80106d96:	e9 8c f8 ff ff       	jmp    80106627 <alltraps>

80106d9b <vector80>:
.globl vector80
vector80:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $80
80106d9d:	6a 50                	push   $0x50
  jmp alltraps
80106d9f:	e9 83 f8 ff ff       	jmp    80106627 <alltraps>

80106da4 <vector81>:
.globl vector81
vector81:
  pushl $0
80106da4:	6a 00                	push   $0x0
  pushl $81
80106da6:	6a 51                	push   $0x51
  jmp alltraps
80106da8:	e9 7a f8 ff ff       	jmp    80106627 <alltraps>

80106dad <vector82>:
.globl vector82
vector82:
  pushl $0
80106dad:	6a 00                	push   $0x0
  pushl $82
80106daf:	6a 52                	push   $0x52
  jmp alltraps
80106db1:	e9 71 f8 ff ff       	jmp    80106627 <alltraps>

80106db6 <vector83>:
.globl vector83
vector83:
  pushl $0
80106db6:	6a 00                	push   $0x0
  pushl $83
80106db8:	6a 53                	push   $0x53
  jmp alltraps
80106dba:	e9 68 f8 ff ff       	jmp    80106627 <alltraps>

80106dbf <vector84>:
.globl vector84
vector84:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $84
80106dc1:	6a 54                	push   $0x54
  jmp alltraps
80106dc3:	e9 5f f8 ff ff       	jmp    80106627 <alltraps>

80106dc8 <vector85>:
.globl vector85
vector85:
  pushl $0
80106dc8:	6a 00                	push   $0x0
  pushl $85
80106dca:	6a 55                	push   $0x55
  jmp alltraps
80106dcc:	e9 56 f8 ff ff       	jmp    80106627 <alltraps>

80106dd1 <vector86>:
.globl vector86
vector86:
  pushl $0
80106dd1:	6a 00                	push   $0x0
  pushl $86
80106dd3:	6a 56                	push   $0x56
  jmp alltraps
80106dd5:	e9 4d f8 ff ff       	jmp    80106627 <alltraps>

80106dda <vector87>:
.globl vector87
vector87:
  pushl $0
80106dda:	6a 00                	push   $0x0
  pushl $87
80106ddc:	6a 57                	push   $0x57
  jmp alltraps
80106dde:	e9 44 f8 ff ff       	jmp    80106627 <alltraps>

80106de3 <vector88>:
.globl vector88
vector88:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $88
80106de5:	6a 58                	push   $0x58
  jmp alltraps
80106de7:	e9 3b f8 ff ff       	jmp    80106627 <alltraps>

80106dec <vector89>:
.globl vector89
vector89:
  pushl $0
80106dec:	6a 00                	push   $0x0
  pushl $89
80106dee:	6a 59                	push   $0x59
  jmp alltraps
80106df0:	e9 32 f8 ff ff       	jmp    80106627 <alltraps>

80106df5 <vector90>:
.globl vector90
vector90:
  pushl $0
80106df5:	6a 00                	push   $0x0
  pushl $90
80106df7:	6a 5a                	push   $0x5a
  jmp alltraps
80106df9:	e9 29 f8 ff ff       	jmp    80106627 <alltraps>

80106dfe <vector91>:
.globl vector91
vector91:
  pushl $0
80106dfe:	6a 00                	push   $0x0
  pushl $91
80106e00:	6a 5b                	push   $0x5b
  jmp alltraps
80106e02:	e9 20 f8 ff ff       	jmp    80106627 <alltraps>

80106e07 <vector92>:
.globl vector92
vector92:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $92
80106e09:	6a 5c                	push   $0x5c
  jmp alltraps
80106e0b:	e9 17 f8 ff ff       	jmp    80106627 <alltraps>

80106e10 <vector93>:
.globl vector93
vector93:
  pushl $0
80106e10:	6a 00                	push   $0x0
  pushl $93
80106e12:	6a 5d                	push   $0x5d
  jmp alltraps
80106e14:	e9 0e f8 ff ff       	jmp    80106627 <alltraps>

80106e19 <vector94>:
.globl vector94
vector94:
  pushl $0
80106e19:	6a 00                	push   $0x0
  pushl $94
80106e1b:	6a 5e                	push   $0x5e
  jmp alltraps
80106e1d:	e9 05 f8 ff ff       	jmp    80106627 <alltraps>

80106e22 <vector95>:
.globl vector95
vector95:
  pushl $0
80106e22:	6a 00                	push   $0x0
  pushl $95
80106e24:	6a 5f                	push   $0x5f
  jmp alltraps
80106e26:	e9 fc f7 ff ff       	jmp    80106627 <alltraps>

80106e2b <vector96>:
.globl vector96
vector96:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $96
80106e2d:	6a 60                	push   $0x60
  jmp alltraps
80106e2f:	e9 f3 f7 ff ff       	jmp    80106627 <alltraps>

80106e34 <vector97>:
.globl vector97
vector97:
  pushl $0
80106e34:	6a 00                	push   $0x0
  pushl $97
80106e36:	6a 61                	push   $0x61
  jmp alltraps
80106e38:	e9 ea f7 ff ff       	jmp    80106627 <alltraps>

80106e3d <vector98>:
.globl vector98
vector98:
  pushl $0
80106e3d:	6a 00                	push   $0x0
  pushl $98
80106e3f:	6a 62                	push   $0x62
  jmp alltraps
80106e41:	e9 e1 f7 ff ff       	jmp    80106627 <alltraps>

80106e46 <vector99>:
.globl vector99
vector99:
  pushl $0
80106e46:	6a 00                	push   $0x0
  pushl $99
80106e48:	6a 63                	push   $0x63
  jmp alltraps
80106e4a:	e9 d8 f7 ff ff       	jmp    80106627 <alltraps>

80106e4f <vector100>:
.globl vector100
vector100:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $100
80106e51:	6a 64                	push   $0x64
  jmp alltraps
80106e53:	e9 cf f7 ff ff       	jmp    80106627 <alltraps>

80106e58 <vector101>:
.globl vector101
vector101:
  pushl $0
80106e58:	6a 00                	push   $0x0
  pushl $101
80106e5a:	6a 65                	push   $0x65
  jmp alltraps
80106e5c:	e9 c6 f7 ff ff       	jmp    80106627 <alltraps>

80106e61 <vector102>:
.globl vector102
vector102:
  pushl $0
80106e61:	6a 00                	push   $0x0
  pushl $102
80106e63:	6a 66                	push   $0x66
  jmp alltraps
80106e65:	e9 bd f7 ff ff       	jmp    80106627 <alltraps>

80106e6a <vector103>:
.globl vector103
vector103:
  pushl $0
80106e6a:	6a 00                	push   $0x0
  pushl $103
80106e6c:	6a 67                	push   $0x67
  jmp alltraps
80106e6e:	e9 b4 f7 ff ff       	jmp    80106627 <alltraps>

80106e73 <vector104>:
.globl vector104
vector104:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $104
80106e75:	6a 68                	push   $0x68
  jmp alltraps
80106e77:	e9 ab f7 ff ff       	jmp    80106627 <alltraps>

80106e7c <vector105>:
.globl vector105
vector105:
  pushl $0
80106e7c:	6a 00                	push   $0x0
  pushl $105
80106e7e:	6a 69                	push   $0x69
  jmp alltraps
80106e80:	e9 a2 f7 ff ff       	jmp    80106627 <alltraps>

80106e85 <vector106>:
.globl vector106
vector106:
  pushl $0
80106e85:	6a 00                	push   $0x0
  pushl $106
80106e87:	6a 6a                	push   $0x6a
  jmp alltraps
80106e89:	e9 99 f7 ff ff       	jmp    80106627 <alltraps>

80106e8e <vector107>:
.globl vector107
vector107:
  pushl $0
80106e8e:	6a 00                	push   $0x0
  pushl $107
80106e90:	6a 6b                	push   $0x6b
  jmp alltraps
80106e92:	e9 90 f7 ff ff       	jmp    80106627 <alltraps>

80106e97 <vector108>:
.globl vector108
vector108:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $108
80106e99:	6a 6c                	push   $0x6c
  jmp alltraps
80106e9b:	e9 87 f7 ff ff       	jmp    80106627 <alltraps>

80106ea0 <vector109>:
.globl vector109
vector109:
  pushl $0
80106ea0:	6a 00                	push   $0x0
  pushl $109
80106ea2:	6a 6d                	push   $0x6d
  jmp alltraps
80106ea4:	e9 7e f7 ff ff       	jmp    80106627 <alltraps>

80106ea9 <vector110>:
.globl vector110
vector110:
  pushl $0
80106ea9:	6a 00                	push   $0x0
  pushl $110
80106eab:	6a 6e                	push   $0x6e
  jmp alltraps
80106ead:	e9 75 f7 ff ff       	jmp    80106627 <alltraps>

80106eb2 <vector111>:
.globl vector111
vector111:
  pushl $0
80106eb2:	6a 00                	push   $0x0
  pushl $111
80106eb4:	6a 6f                	push   $0x6f
  jmp alltraps
80106eb6:	e9 6c f7 ff ff       	jmp    80106627 <alltraps>

80106ebb <vector112>:
.globl vector112
vector112:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $112
80106ebd:	6a 70                	push   $0x70
  jmp alltraps
80106ebf:	e9 63 f7 ff ff       	jmp    80106627 <alltraps>

80106ec4 <vector113>:
.globl vector113
vector113:
  pushl $0
80106ec4:	6a 00                	push   $0x0
  pushl $113
80106ec6:	6a 71                	push   $0x71
  jmp alltraps
80106ec8:	e9 5a f7 ff ff       	jmp    80106627 <alltraps>

80106ecd <vector114>:
.globl vector114
vector114:
  pushl $0
80106ecd:	6a 00                	push   $0x0
  pushl $114
80106ecf:	6a 72                	push   $0x72
  jmp alltraps
80106ed1:	e9 51 f7 ff ff       	jmp    80106627 <alltraps>

80106ed6 <vector115>:
.globl vector115
vector115:
  pushl $0
80106ed6:	6a 00                	push   $0x0
  pushl $115
80106ed8:	6a 73                	push   $0x73
  jmp alltraps
80106eda:	e9 48 f7 ff ff       	jmp    80106627 <alltraps>

80106edf <vector116>:
.globl vector116
vector116:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $116
80106ee1:	6a 74                	push   $0x74
  jmp alltraps
80106ee3:	e9 3f f7 ff ff       	jmp    80106627 <alltraps>

80106ee8 <vector117>:
.globl vector117
vector117:
  pushl $0
80106ee8:	6a 00                	push   $0x0
  pushl $117
80106eea:	6a 75                	push   $0x75
  jmp alltraps
80106eec:	e9 36 f7 ff ff       	jmp    80106627 <alltraps>

80106ef1 <vector118>:
.globl vector118
vector118:
  pushl $0
80106ef1:	6a 00                	push   $0x0
  pushl $118
80106ef3:	6a 76                	push   $0x76
  jmp alltraps
80106ef5:	e9 2d f7 ff ff       	jmp    80106627 <alltraps>

80106efa <vector119>:
.globl vector119
vector119:
  pushl $0
80106efa:	6a 00                	push   $0x0
  pushl $119
80106efc:	6a 77                	push   $0x77
  jmp alltraps
80106efe:	e9 24 f7 ff ff       	jmp    80106627 <alltraps>

80106f03 <vector120>:
.globl vector120
vector120:
  pushl $0
80106f03:	6a 00                	push   $0x0
  pushl $120
80106f05:	6a 78                	push   $0x78
  jmp alltraps
80106f07:	e9 1b f7 ff ff       	jmp    80106627 <alltraps>

80106f0c <vector121>:
.globl vector121
vector121:
  pushl $0
80106f0c:	6a 00                	push   $0x0
  pushl $121
80106f0e:	6a 79                	push   $0x79
  jmp alltraps
80106f10:	e9 12 f7 ff ff       	jmp    80106627 <alltraps>

80106f15 <vector122>:
.globl vector122
vector122:
  pushl $0
80106f15:	6a 00                	push   $0x0
  pushl $122
80106f17:	6a 7a                	push   $0x7a
  jmp alltraps
80106f19:	e9 09 f7 ff ff       	jmp    80106627 <alltraps>

80106f1e <vector123>:
.globl vector123
vector123:
  pushl $0
80106f1e:	6a 00                	push   $0x0
  pushl $123
80106f20:	6a 7b                	push   $0x7b
  jmp alltraps
80106f22:	e9 00 f7 ff ff       	jmp    80106627 <alltraps>

80106f27 <vector124>:
.globl vector124
vector124:
  pushl $0
80106f27:	6a 00                	push   $0x0
  pushl $124
80106f29:	6a 7c                	push   $0x7c
  jmp alltraps
80106f2b:	e9 f7 f6 ff ff       	jmp    80106627 <alltraps>

80106f30 <vector125>:
.globl vector125
vector125:
  pushl $0
80106f30:	6a 00                	push   $0x0
  pushl $125
80106f32:	6a 7d                	push   $0x7d
  jmp alltraps
80106f34:	e9 ee f6 ff ff       	jmp    80106627 <alltraps>

80106f39 <vector126>:
.globl vector126
vector126:
  pushl $0
80106f39:	6a 00                	push   $0x0
  pushl $126
80106f3b:	6a 7e                	push   $0x7e
  jmp alltraps
80106f3d:	e9 e5 f6 ff ff       	jmp    80106627 <alltraps>

80106f42 <vector127>:
.globl vector127
vector127:
  pushl $0
80106f42:	6a 00                	push   $0x0
  pushl $127
80106f44:	6a 7f                	push   $0x7f
  jmp alltraps
80106f46:	e9 dc f6 ff ff       	jmp    80106627 <alltraps>

80106f4b <vector128>:
.globl vector128
vector128:
  pushl $0
80106f4b:	6a 00                	push   $0x0
  pushl $128
80106f4d:	68 80 00 00 00       	push   $0x80
  jmp alltraps
80106f52:	e9 d0 f6 ff ff       	jmp    80106627 <alltraps>

80106f57 <vector129>:
.globl vector129
vector129:
  pushl $0
80106f57:	6a 00                	push   $0x0
  pushl $129
80106f59:	68 81 00 00 00       	push   $0x81
  jmp alltraps
80106f5e:	e9 c4 f6 ff ff       	jmp    80106627 <alltraps>

80106f63 <vector130>:
.globl vector130
vector130:
  pushl $0
80106f63:	6a 00                	push   $0x0
  pushl $130
80106f65:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106f6a:	e9 b8 f6 ff ff       	jmp    80106627 <alltraps>

80106f6f <vector131>:
.globl vector131
vector131:
  pushl $0
80106f6f:	6a 00                	push   $0x0
  pushl $131
80106f71:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106f76:	e9 ac f6 ff ff       	jmp    80106627 <alltraps>

80106f7b <vector132>:
.globl vector132
vector132:
  pushl $0
80106f7b:	6a 00                	push   $0x0
  pushl $132
80106f7d:	68 84 00 00 00       	push   $0x84
  jmp alltraps
80106f82:	e9 a0 f6 ff ff       	jmp    80106627 <alltraps>

80106f87 <vector133>:
.globl vector133
vector133:
  pushl $0
80106f87:	6a 00                	push   $0x0
  pushl $133
80106f89:	68 85 00 00 00       	push   $0x85
  jmp alltraps
80106f8e:	e9 94 f6 ff ff       	jmp    80106627 <alltraps>

80106f93 <vector134>:
.globl vector134
vector134:
  pushl $0
80106f93:	6a 00                	push   $0x0
  pushl $134
80106f95:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106f9a:	e9 88 f6 ff ff       	jmp    80106627 <alltraps>

80106f9f <vector135>:
.globl vector135
vector135:
  pushl $0
80106f9f:	6a 00                	push   $0x0
  pushl $135
80106fa1:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106fa6:	e9 7c f6 ff ff       	jmp    80106627 <alltraps>

80106fab <vector136>:
.globl vector136
vector136:
  pushl $0
80106fab:	6a 00                	push   $0x0
  pushl $136
80106fad:	68 88 00 00 00       	push   $0x88
  jmp alltraps
80106fb2:	e9 70 f6 ff ff       	jmp    80106627 <alltraps>

80106fb7 <vector137>:
.globl vector137
vector137:
  pushl $0
80106fb7:	6a 00                	push   $0x0
  pushl $137
80106fb9:	68 89 00 00 00       	push   $0x89
  jmp alltraps
80106fbe:	e9 64 f6 ff ff       	jmp    80106627 <alltraps>

80106fc3 <vector138>:
.globl vector138
vector138:
  pushl $0
80106fc3:	6a 00                	push   $0x0
  pushl $138
80106fc5:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106fca:	e9 58 f6 ff ff       	jmp    80106627 <alltraps>

80106fcf <vector139>:
.globl vector139
vector139:
  pushl $0
80106fcf:	6a 00                	push   $0x0
  pushl $139
80106fd1:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106fd6:	e9 4c f6 ff ff       	jmp    80106627 <alltraps>

80106fdb <vector140>:
.globl vector140
vector140:
  pushl $0
80106fdb:	6a 00                	push   $0x0
  pushl $140
80106fdd:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
80106fe2:	e9 40 f6 ff ff       	jmp    80106627 <alltraps>

80106fe7 <vector141>:
.globl vector141
vector141:
  pushl $0
80106fe7:	6a 00                	push   $0x0
  pushl $141
80106fe9:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
80106fee:	e9 34 f6 ff ff       	jmp    80106627 <alltraps>

80106ff3 <vector142>:
.globl vector142
vector142:
  pushl $0
80106ff3:	6a 00                	push   $0x0
  pushl $142
80106ff5:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106ffa:	e9 28 f6 ff ff       	jmp    80106627 <alltraps>

80106fff <vector143>:
.globl vector143
vector143:
  pushl $0
80106fff:	6a 00                	push   $0x0
  pushl $143
80107001:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80107006:	e9 1c f6 ff ff       	jmp    80106627 <alltraps>

8010700b <vector144>:
.globl vector144
vector144:
  pushl $0
8010700b:	6a 00                	push   $0x0
  pushl $144
8010700d:	68 90 00 00 00       	push   $0x90
  jmp alltraps
80107012:	e9 10 f6 ff ff       	jmp    80106627 <alltraps>

80107017 <vector145>:
.globl vector145
vector145:
  pushl $0
80107017:	6a 00                	push   $0x0
  pushl $145
80107019:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010701e:	e9 04 f6 ff ff       	jmp    80106627 <alltraps>

80107023 <vector146>:
.globl vector146
vector146:
  pushl $0
80107023:	6a 00                	push   $0x0
  pushl $146
80107025:	68 92 00 00 00       	push   $0x92
  jmp alltraps
8010702a:	e9 f8 f5 ff ff       	jmp    80106627 <alltraps>

8010702f <vector147>:
.globl vector147
vector147:
  pushl $0
8010702f:	6a 00                	push   $0x0
  pushl $147
80107031:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107036:	e9 ec f5 ff ff       	jmp    80106627 <alltraps>

8010703b <vector148>:
.globl vector148
vector148:
  pushl $0
8010703b:	6a 00                	push   $0x0
  pushl $148
8010703d:	68 94 00 00 00       	push   $0x94
  jmp alltraps
80107042:	e9 e0 f5 ff ff       	jmp    80106627 <alltraps>

80107047 <vector149>:
.globl vector149
vector149:
  pushl $0
80107047:	6a 00                	push   $0x0
  pushl $149
80107049:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010704e:	e9 d4 f5 ff ff       	jmp    80106627 <alltraps>

80107053 <vector150>:
.globl vector150
vector150:
  pushl $0
80107053:	6a 00                	push   $0x0
  pushl $150
80107055:	68 96 00 00 00       	push   $0x96
  jmp alltraps
8010705a:	e9 c8 f5 ff ff       	jmp    80106627 <alltraps>

8010705f <vector151>:
.globl vector151
vector151:
  pushl $0
8010705f:	6a 00                	push   $0x0
  pushl $151
80107061:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107066:	e9 bc f5 ff ff       	jmp    80106627 <alltraps>

8010706b <vector152>:
.globl vector152
vector152:
  pushl $0
8010706b:	6a 00                	push   $0x0
  pushl $152
8010706d:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80107072:	e9 b0 f5 ff ff       	jmp    80106627 <alltraps>

80107077 <vector153>:
.globl vector153
vector153:
  pushl $0
80107077:	6a 00                	push   $0x0
  pushl $153
80107079:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010707e:	e9 a4 f5 ff ff       	jmp    80106627 <alltraps>

80107083 <vector154>:
.globl vector154
vector154:
  pushl $0
80107083:	6a 00                	push   $0x0
  pushl $154
80107085:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
8010708a:	e9 98 f5 ff ff       	jmp    80106627 <alltraps>

8010708f <vector155>:
.globl vector155
vector155:
  pushl $0
8010708f:	6a 00                	push   $0x0
  pushl $155
80107091:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107096:	e9 8c f5 ff ff       	jmp    80106627 <alltraps>

8010709b <vector156>:
.globl vector156
vector156:
  pushl $0
8010709b:	6a 00                	push   $0x0
  pushl $156
8010709d:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801070a2:	e9 80 f5 ff ff       	jmp    80106627 <alltraps>

801070a7 <vector157>:
.globl vector157
vector157:
  pushl $0
801070a7:	6a 00                	push   $0x0
  pushl $157
801070a9:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801070ae:	e9 74 f5 ff ff       	jmp    80106627 <alltraps>

801070b3 <vector158>:
.globl vector158
vector158:
  pushl $0
801070b3:	6a 00                	push   $0x0
  pushl $158
801070b5:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801070ba:	e9 68 f5 ff ff       	jmp    80106627 <alltraps>

801070bf <vector159>:
.globl vector159
vector159:
  pushl $0
801070bf:	6a 00                	push   $0x0
  pushl $159
801070c1:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801070c6:	e9 5c f5 ff ff       	jmp    80106627 <alltraps>

801070cb <vector160>:
.globl vector160
vector160:
  pushl $0
801070cb:	6a 00                	push   $0x0
  pushl $160
801070cd:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801070d2:	e9 50 f5 ff ff       	jmp    80106627 <alltraps>

801070d7 <vector161>:
.globl vector161
vector161:
  pushl $0
801070d7:	6a 00                	push   $0x0
  pushl $161
801070d9:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801070de:	e9 44 f5 ff ff       	jmp    80106627 <alltraps>

801070e3 <vector162>:
.globl vector162
vector162:
  pushl $0
801070e3:	6a 00                	push   $0x0
  pushl $162
801070e5:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801070ea:	e9 38 f5 ff ff       	jmp    80106627 <alltraps>

801070ef <vector163>:
.globl vector163
vector163:
  pushl $0
801070ef:	6a 00                	push   $0x0
  pushl $163
801070f1:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801070f6:	e9 2c f5 ff ff       	jmp    80106627 <alltraps>

801070fb <vector164>:
.globl vector164
vector164:
  pushl $0
801070fb:	6a 00                	push   $0x0
  pushl $164
801070fd:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80107102:	e9 20 f5 ff ff       	jmp    80106627 <alltraps>

80107107 <vector165>:
.globl vector165
vector165:
  pushl $0
80107107:	6a 00                	push   $0x0
  pushl $165
80107109:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010710e:	e9 14 f5 ff ff       	jmp    80106627 <alltraps>

80107113 <vector166>:
.globl vector166
vector166:
  pushl $0
80107113:	6a 00                	push   $0x0
  pushl $166
80107115:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
8010711a:	e9 08 f5 ff ff       	jmp    80106627 <alltraps>

8010711f <vector167>:
.globl vector167
vector167:
  pushl $0
8010711f:	6a 00                	push   $0x0
  pushl $167
80107121:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107126:	e9 fc f4 ff ff       	jmp    80106627 <alltraps>

8010712b <vector168>:
.globl vector168
vector168:
  pushl $0
8010712b:	6a 00                	push   $0x0
  pushl $168
8010712d:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80107132:	e9 f0 f4 ff ff       	jmp    80106627 <alltraps>

80107137 <vector169>:
.globl vector169
vector169:
  pushl $0
80107137:	6a 00                	push   $0x0
  pushl $169
80107139:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010713e:	e9 e4 f4 ff ff       	jmp    80106627 <alltraps>

80107143 <vector170>:
.globl vector170
vector170:
  pushl $0
80107143:	6a 00                	push   $0x0
  pushl $170
80107145:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
8010714a:	e9 d8 f4 ff ff       	jmp    80106627 <alltraps>

8010714f <vector171>:
.globl vector171
vector171:
  pushl $0
8010714f:	6a 00                	push   $0x0
  pushl $171
80107151:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107156:	e9 cc f4 ff ff       	jmp    80106627 <alltraps>

8010715b <vector172>:
.globl vector172
vector172:
  pushl $0
8010715b:	6a 00                	push   $0x0
  pushl $172
8010715d:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80107162:	e9 c0 f4 ff ff       	jmp    80106627 <alltraps>

80107167 <vector173>:
.globl vector173
vector173:
  pushl $0
80107167:	6a 00                	push   $0x0
  pushl $173
80107169:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010716e:	e9 b4 f4 ff ff       	jmp    80106627 <alltraps>

80107173 <vector174>:
.globl vector174
vector174:
  pushl $0
80107173:	6a 00                	push   $0x0
  pushl $174
80107175:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
8010717a:	e9 a8 f4 ff ff       	jmp    80106627 <alltraps>

8010717f <vector175>:
.globl vector175
vector175:
  pushl $0
8010717f:	6a 00                	push   $0x0
  pushl $175
80107181:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107186:	e9 9c f4 ff ff       	jmp    80106627 <alltraps>

8010718b <vector176>:
.globl vector176
vector176:
  pushl $0
8010718b:	6a 00                	push   $0x0
  pushl $176
8010718d:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80107192:	e9 90 f4 ff ff       	jmp    80106627 <alltraps>

80107197 <vector177>:
.globl vector177
vector177:
  pushl $0
80107197:	6a 00                	push   $0x0
  pushl $177
80107199:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010719e:	e9 84 f4 ff ff       	jmp    80106627 <alltraps>

801071a3 <vector178>:
.globl vector178
vector178:
  pushl $0
801071a3:	6a 00                	push   $0x0
  pushl $178
801071a5:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801071aa:	e9 78 f4 ff ff       	jmp    80106627 <alltraps>

801071af <vector179>:
.globl vector179
vector179:
  pushl $0
801071af:	6a 00                	push   $0x0
  pushl $179
801071b1:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801071b6:	e9 6c f4 ff ff       	jmp    80106627 <alltraps>

801071bb <vector180>:
.globl vector180
vector180:
  pushl $0
801071bb:	6a 00                	push   $0x0
  pushl $180
801071bd:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801071c2:	e9 60 f4 ff ff       	jmp    80106627 <alltraps>

801071c7 <vector181>:
.globl vector181
vector181:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $181
801071c9:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801071ce:	e9 54 f4 ff ff       	jmp    80106627 <alltraps>

801071d3 <vector182>:
.globl vector182
vector182:
  pushl $0
801071d3:	6a 00                	push   $0x0
  pushl $182
801071d5:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801071da:	e9 48 f4 ff ff       	jmp    80106627 <alltraps>

801071df <vector183>:
.globl vector183
vector183:
  pushl $0
801071df:	6a 00                	push   $0x0
  pushl $183
801071e1:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801071e6:	e9 3c f4 ff ff       	jmp    80106627 <alltraps>

801071eb <vector184>:
.globl vector184
vector184:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $184
801071ed:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801071f2:	e9 30 f4 ff ff       	jmp    80106627 <alltraps>

801071f7 <vector185>:
.globl vector185
vector185:
  pushl $0
801071f7:	6a 00                	push   $0x0
  pushl $185
801071f9:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801071fe:	e9 24 f4 ff ff       	jmp    80106627 <alltraps>

80107203 <vector186>:
.globl vector186
vector186:
  pushl $0
80107203:	6a 00                	push   $0x0
  pushl $186
80107205:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
8010720a:	e9 18 f4 ff ff       	jmp    80106627 <alltraps>

8010720f <vector187>:
.globl vector187
vector187:
  pushl $0
8010720f:	6a 00                	push   $0x0
  pushl $187
80107211:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80107216:	e9 0c f4 ff ff       	jmp    80106627 <alltraps>

8010721b <vector188>:
.globl vector188
vector188:
  pushl $0
8010721b:	6a 00                	push   $0x0
  pushl $188
8010721d:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80107222:	e9 00 f4 ff ff       	jmp    80106627 <alltraps>

80107227 <vector189>:
.globl vector189
vector189:
  pushl $0
80107227:	6a 00                	push   $0x0
  pushl $189
80107229:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010722e:	e9 f4 f3 ff ff       	jmp    80106627 <alltraps>

80107233 <vector190>:
.globl vector190
vector190:
  pushl $0
80107233:	6a 00                	push   $0x0
  pushl $190
80107235:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
8010723a:	e9 e8 f3 ff ff       	jmp    80106627 <alltraps>

8010723f <vector191>:
.globl vector191
vector191:
  pushl $0
8010723f:	6a 00                	push   $0x0
  pushl $191
80107241:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107246:	e9 dc f3 ff ff       	jmp    80106627 <alltraps>

8010724b <vector192>:
.globl vector192
vector192:
  pushl $0
8010724b:	6a 00                	push   $0x0
  pushl $192
8010724d:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107252:	e9 d0 f3 ff ff       	jmp    80106627 <alltraps>

80107257 <vector193>:
.globl vector193
vector193:
  pushl $0
80107257:	6a 00                	push   $0x0
  pushl $193
80107259:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010725e:	e9 c4 f3 ff ff       	jmp    80106627 <alltraps>

80107263 <vector194>:
.globl vector194
vector194:
  pushl $0
80107263:	6a 00                	push   $0x0
  pushl $194
80107265:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
8010726a:	e9 b8 f3 ff ff       	jmp    80106627 <alltraps>

8010726f <vector195>:
.globl vector195
vector195:
  pushl $0
8010726f:	6a 00                	push   $0x0
  pushl $195
80107271:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107276:	e9 ac f3 ff ff       	jmp    80106627 <alltraps>

8010727b <vector196>:
.globl vector196
vector196:
  pushl $0
8010727b:	6a 00                	push   $0x0
  pushl $196
8010727d:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107282:	e9 a0 f3 ff ff       	jmp    80106627 <alltraps>

80107287 <vector197>:
.globl vector197
vector197:
  pushl $0
80107287:	6a 00                	push   $0x0
  pushl $197
80107289:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010728e:	e9 94 f3 ff ff       	jmp    80106627 <alltraps>

80107293 <vector198>:
.globl vector198
vector198:
  pushl $0
80107293:	6a 00                	push   $0x0
  pushl $198
80107295:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
8010729a:	e9 88 f3 ff ff       	jmp    80106627 <alltraps>

8010729f <vector199>:
.globl vector199
vector199:
  pushl $0
8010729f:	6a 00                	push   $0x0
  pushl $199
801072a1:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801072a6:	e9 7c f3 ff ff       	jmp    80106627 <alltraps>

801072ab <vector200>:
.globl vector200
vector200:
  pushl $0
801072ab:	6a 00                	push   $0x0
  pushl $200
801072ad:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801072b2:	e9 70 f3 ff ff       	jmp    80106627 <alltraps>

801072b7 <vector201>:
.globl vector201
vector201:
  pushl $0
801072b7:	6a 00                	push   $0x0
  pushl $201
801072b9:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801072be:	e9 64 f3 ff ff       	jmp    80106627 <alltraps>

801072c3 <vector202>:
.globl vector202
vector202:
  pushl $0
801072c3:	6a 00                	push   $0x0
  pushl $202
801072c5:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801072ca:	e9 58 f3 ff ff       	jmp    80106627 <alltraps>

801072cf <vector203>:
.globl vector203
vector203:
  pushl $0
801072cf:	6a 00                	push   $0x0
  pushl $203
801072d1:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801072d6:	e9 4c f3 ff ff       	jmp    80106627 <alltraps>

801072db <vector204>:
.globl vector204
vector204:
  pushl $0
801072db:	6a 00                	push   $0x0
  pushl $204
801072dd:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801072e2:	e9 40 f3 ff ff       	jmp    80106627 <alltraps>

801072e7 <vector205>:
.globl vector205
vector205:
  pushl $0
801072e7:	6a 00                	push   $0x0
  pushl $205
801072e9:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801072ee:	e9 34 f3 ff ff       	jmp    80106627 <alltraps>

801072f3 <vector206>:
.globl vector206
vector206:
  pushl $0
801072f3:	6a 00                	push   $0x0
  pushl $206
801072f5:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801072fa:	e9 28 f3 ff ff       	jmp    80106627 <alltraps>

801072ff <vector207>:
.globl vector207
vector207:
  pushl $0
801072ff:	6a 00                	push   $0x0
  pushl $207
80107301:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107306:	e9 1c f3 ff ff       	jmp    80106627 <alltraps>

8010730b <vector208>:
.globl vector208
vector208:
  pushl $0
8010730b:	6a 00                	push   $0x0
  pushl $208
8010730d:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107312:	e9 10 f3 ff ff       	jmp    80106627 <alltraps>

80107317 <vector209>:
.globl vector209
vector209:
  pushl $0
80107317:	6a 00                	push   $0x0
  pushl $209
80107319:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010731e:	e9 04 f3 ff ff       	jmp    80106627 <alltraps>

80107323 <vector210>:
.globl vector210
vector210:
  pushl $0
80107323:	6a 00                	push   $0x0
  pushl $210
80107325:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
8010732a:	e9 f8 f2 ff ff       	jmp    80106627 <alltraps>

8010732f <vector211>:
.globl vector211
vector211:
  pushl $0
8010732f:	6a 00                	push   $0x0
  pushl $211
80107331:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107336:	e9 ec f2 ff ff       	jmp    80106627 <alltraps>

8010733b <vector212>:
.globl vector212
vector212:
  pushl $0
8010733b:	6a 00                	push   $0x0
  pushl $212
8010733d:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107342:	e9 e0 f2 ff ff       	jmp    80106627 <alltraps>

80107347 <vector213>:
.globl vector213
vector213:
  pushl $0
80107347:	6a 00                	push   $0x0
  pushl $213
80107349:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010734e:	e9 d4 f2 ff ff       	jmp    80106627 <alltraps>

80107353 <vector214>:
.globl vector214
vector214:
  pushl $0
80107353:	6a 00                	push   $0x0
  pushl $214
80107355:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
8010735a:	e9 c8 f2 ff ff       	jmp    80106627 <alltraps>

8010735f <vector215>:
.globl vector215
vector215:
  pushl $0
8010735f:	6a 00                	push   $0x0
  pushl $215
80107361:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107366:	e9 bc f2 ff ff       	jmp    80106627 <alltraps>

8010736b <vector216>:
.globl vector216
vector216:
  pushl $0
8010736b:	6a 00                	push   $0x0
  pushl $216
8010736d:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107372:	e9 b0 f2 ff ff       	jmp    80106627 <alltraps>

80107377 <vector217>:
.globl vector217
vector217:
  pushl $0
80107377:	6a 00                	push   $0x0
  pushl $217
80107379:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010737e:	e9 a4 f2 ff ff       	jmp    80106627 <alltraps>

80107383 <vector218>:
.globl vector218
vector218:
  pushl $0
80107383:	6a 00                	push   $0x0
  pushl $218
80107385:	68 da 00 00 00       	push   $0xda
  jmp alltraps
8010738a:	e9 98 f2 ff ff       	jmp    80106627 <alltraps>

8010738f <vector219>:
.globl vector219
vector219:
  pushl $0
8010738f:	6a 00                	push   $0x0
  pushl $219
80107391:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107396:	e9 8c f2 ff ff       	jmp    80106627 <alltraps>

8010739b <vector220>:
.globl vector220
vector220:
  pushl $0
8010739b:	6a 00                	push   $0x0
  pushl $220
8010739d:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801073a2:	e9 80 f2 ff ff       	jmp    80106627 <alltraps>

801073a7 <vector221>:
.globl vector221
vector221:
  pushl $0
801073a7:	6a 00                	push   $0x0
  pushl $221
801073a9:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801073ae:	e9 74 f2 ff ff       	jmp    80106627 <alltraps>

801073b3 <vector222>:
.globl vector222
vector222:
  pushl $0
801073b3:	6a 00                	push   $0x0
  pushl $222
801073b5:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801073ba:	e9 68 f2 ff ff       	jmp    80106627 <alltraps>

801073bf <vector223>:
.globl vector223
vector223:
  pushl $0
801073bf:	6a 00                	push   $0x0
  pushl $223
801073c1:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801073c6:	e9 5c f2 ff ff       	jmp    80106627 <alltraps>

801073cb <vector224>:
.globl vector224
vector224:
  pushl $0
801073cb:	6a 00                	push   $0x0
  pushl $224
801073cd:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801073d2:	e9 50 f2 ff ff       	jmp    80106627 <alltraps>

801073d7 <vector225>:
.globl vector225
vector225:
  pushl $0
801073d7:	6a 00                	push   $0x0
  pushl $225
801073d9:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801073de:	e9 44 f2 ff ff       	jmp    80106627 <alltraps>

801073e3 <vector226>:
.globl vector226
vector226:
  pushl $0
801073e3:	6a 00                	push   $0x0
  pushl $226
801073e5:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801073ea:	e9 38 f2 ff ff       	jmp    80106627 <alltraps>

801073ef <vector227>:
.globl vector227
vector227:
  pushl $0
801073ef:	6a 00                	push   $0x0
  pushl $227
801073f1:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801073f6:	e9 2c f2 ff ff       	jmp    80106627 <alltraps>

801073fb <vector228>:
.globl vector228
vector228:
  pushl $0
801073fb:	6a 00                	push   $0x0
  pushl $228
801073fd:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107402:	e9 20 f2 ff ff       	jmp    80106627 <alltraps>

80107407 <vector229>:
.globl vector229
vector229:
  pushl $0
80107407:	6a 00                	push   $0x0
  pushl $229
80107409:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010740e:	e9 14 f2 ff ff       	jmp    80106627 <alltraps>

80107413 <vector230>:
.globl vector230
vector230:
  pushl $0
80107413:	6a 00                	push   $0x0
  pushl $230
80107415:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
8010741a:	e9 08 f2 ff ff       	jmp    80106627 <alltraps>

8010741f <vector231>:
.globl vector231
vector231:
  pushl $0
8010741f:	6a 00                	push   $0x0
  pushl $231
80107421:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107426:	e9 fc f1 ff ff       	jmp    80106627 <alltraps>

8010742b <vector232>:
.globl vector232
vector232:
  pushl $0
8010742b:	6a 00                	push   $0x0
  pushl $232
8010742d:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107432:	e9 f0 f1 ff ff       	jmp    80106627 <alltraps>

80107437 <vector233>:
.globl vector233
vector233:
  pushl $0
80107437:	6a 00                	push   $0x0
  pushl $233
80107439:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010743e:	e9 e4 f1 ff ff       	jmp    80106627 <alltraps>

80107443 <vector234>:
.globl vector234
vector234:
  pushl $0
80107443:	6a 00                	push   $0x0
  pushl $234
80107445:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
8010744a:	e9 d8 f1 ff ff       	jmp    80106627 <alltraps>

8010744f <vector235>:
.globl vector235
vector235:
  pushl $0
8010744f:	6a 00                	push   $0x0
  pushl $235
80107451:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107456:	e9 cc f1 ff ff       	jmp    80106627 <alltraps>

8010745b <vector236>:
.globl vector236
vector236:
  pushl $0
8010745b:	6a 00                	push   $0x0
  pushl $236
8010745d:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107462:	e9 c0 f1 ff ff       	jmp    80106627 <alltraps>

80107467 <vector237>:
.globl vector237
vector237:
  pushl $0
80107467:	6a 00                	push   $0x0
  pushl $237
80107469:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010746e:	e9 b4 f1 ff ff       	jmp    80106627 <alltraps>

80107473 <vector238>:
.globl vector238
vector238:
  pushl $0
80107473:	6a 00                	push   $0x0
  pushl $238
80107475:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
8010747a:	e9 a8 f1 ff ff       	jmp    80106627 <alltraps>

8010747f <vector239>:
.globl vector239
vector239:
  pushl $0
8010747f:	6a 00                	push   $0x0
  pushl $239
80107481:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107486:	e9 9c f1 ff ff       	jmp    80106627 <alltraps>

8010748b <vector240>:
.globl vector240
vector240:
  pushl $0
8010748b:	6a 00                	push   $0x0
  pushl $240
8010748d:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107492:	e9 90 f1 ff ff       	jmp    80106627 <alltraps>

80107497 <vector241>:
.globl vector241
vector241:
  pushl $0
80107497:	6a 00                	push   $0x0
  pushl $241
80107499:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010749e:	e9 84 f1 ff ff       	jmp    80106627 <alltraps>

801074a3 <vector242>:
.globl vector242
vector242:
  pushl $0
801074a3:	6a 00                	push   $0x0
  pushl $242
801074a5:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801074aa:	e9 78 f1 ff ff       	jmp    80106627 <alltraps>

801074af <vector243>:
.globl vector243
vector243:
  pushl $0
801074af:	6a 00                	push   $0x0
  pushl $243
801074b1:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801074b6:	e9 6c f1 ff ff       	jmp    80106627 <alltraps>

801074bb <vector244>:
.globl vector244
vector244:
  pushl $0
801074bb:	6a 00                	push   $0x0
  pushl $244
801074bd:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801074c2:	e9 60 f1 ff ff       	jmp    80106627 <alltraps>

801074c7 <vector245>:
.globl vector245
vector245:
  pushl $0
801074c7:	6a 00                	push   $0x0
  pushl $245
801074c9:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801074ce:	e9 54 f1 ff ff       	jmp    80106627 <alltraps>

801074d3 <vector246>:
.globl vector246
vector246:
  pushl $0
801074d3:	6a 00                	push   $0x0
  pushl $246
801074d5:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801074da:	e9 48 f1 ff ff       	jmp    80106627 <alltraps>

801074df <vector247>:
.globl vector247
vector247:
  pushl $0
801074df:	6a 00                	push   $0x0
  pushl $247
801074e1:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801074e6:	e9 3c f1 ff ff       	jmp    80106627 <alltraps>

801074eb <vector248>:
.globl vector248
vector248:
  pushl $0
801074eb:	6a 00                	push   $0x0
  pushl $248
801074ed:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801074f2:	e9 30 f1 ff ff       	jmp    80106627 <alltraps>

801074f7 <vector249>:
.globl vector249
vector249:
  pushl $0
801074f7:	6a 00                	push   $0x0
  pushl $249
801074f9:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801074fe:	e9 24 f1 ff ff       	jmp    80106627 <alltraps>

80107503 <vector250>:
.globl vector250
vector250:
  pushl $0
80107503:	6a 00                	push   $0x0
  pushl $250
80107505:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
8010750a:	e9 18 f1 ff ff       	jmp    80106627 <alltraps>

8010750f <vector251>:
.globl vector251
vector251:
  pushl $0
8010750f:	6a 00                	push   $0x0
  pushl $251
80107511:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107516:	e9 0c f1 ff ff       	jmp    80106627 <alltraps>

8010751b <vector252>:
.globl vector252
vector252:
  pushl $0
8010751b:	6a 00                	push   $0x0
  pushl $252
8010751d:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107522:	e9 00 f1 ff ff       	jmp    80106627 <alltraps>

80107527 <vector253>:
.globl vector253
vector253:
  pushl $0
80107527:	6a 00                	push   $0x0
  pushl $253
80107529:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010752e:	e9 f4 f0 ff ff       	jmp    80106627 <alltraps>

80107533 <vector254>:
.globl vector254
vector254:
  pushl $0
80107533:	6a 00                	push   $0x0
  pushl $254
80107535:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
8010753a:	e9 e8 f0 ff ff       	jmp    80106627 <alltraps>

8010753f <vector255>:
.globl vector255
vector255:
  pushl $0
8010753f:	6a 00                	push   $0x0
  pushl $255
80107541:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107546:	e9 dc f0 ff ff       	jmp    80106627 <alltraps>
8010754b:	66 90                	xchg   %ax,%ax
8010754d:	66 90                	xchg   %ax,%ax
8010754f:	90                   	nop

80107550 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80107550:	55                   	push   %ebp
80107551:	89 e5                	mov    %esp,%ebp
80107553:	57                   	push   %edi
80107554:	56                   	push   %esi
80107555:	89 d6                	mov    %edx,%esi
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80107557:	c1 ea 16             	shr    $0x16,%edx
{
8010755a:	53                   	push   %ebx
  pde = &pgdir[PDX(va)];
8010755b:	8d 3c 90             	lea    (%eax,%edx,4),%edi
{
8010755e:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80107561:	8b 1f                	mov    (%edi),%ebx
80107563:	f6 c3 01             	test   $0x1,%bl
80107566:	74 28                	je     80107590 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107568:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
8010756e:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80107574:	89 f0                	mov    %esi,%eax
}
80107576:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80107579:	c1 e8 0a             	shr    $0xa,%eax
8010757c:	25 fc 0f 00 00       	and    $0xffc,%eax
80107581:	01 d8                	add    %ebx,%eax
}
80107583:	5b                   	pop    %ebx
80107584:	5e                   	pop    %esi
80107585:	5f                   	pop    %edi
80107586:	5d                   	pop    %ebp
80107587:	c3                   	ret    
80107588:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010758f:	90                   	nop
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107590:	85 c9                	test   %ecx,%ecx
80107592:	74 2c                	je     801075c0 <walkpgdir+0x70>
80107594:	e8 77 b5 ff ff       	call   80102b10 <kalloc>
80107599:	89 c3                	mov    %eax,%ebx
8010759b:	85 c0                	test   %eax,%eax
8010759d:	74 21                	je     801075c0 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
8010759f:	83 ec 04             	sub    $0x4,%esp
801075a2:	68 00 10 00 00       	push   $0x1000
801075a7:	6a 00                	push   $0x0
801075a9:	50                   	push   %eax
801075aa:	e8 01 dc ff ff       	call   801051b0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801075af:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801075b5:	83 c4 10             	add    $0x10,%esp
801075b8:	83 c8 07             	or     $0x7,%eax
801075bb:	89 07                	mov    %eax,(%edi)
801075bd:	eb b5                	jmp    80107574 <walkpgdir+0x24>
801075bf:	90                   	nop
}
801075c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
801075c3:	31 c0                	xor    %eax,%eax
}
801075c5:	5b                   	pop    %ebx
801075c6:	5e                   	pop    %esi
801075c7:	5f                   	pop    %edi
801075c8:	5d                   	pop    %ebp
801075c9:	c3                   	ret    
801075ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801075d0 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
801075d0:	55                   	push   %ebp
801075d1:	89 e5                	mov    %esp,%ebp
801075d3:	57                   	push   %edi
801075d4:	89 c7                	mov    %eax,%edi
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075d6:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
{
801075da:	56                   	push   %esi
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  a = (char*)PGROUNDDOWN((uint)va);
801075e0:	89 d6                	mov    %edx,%esi
{
801075e2:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
801075e3:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
{
801075e9:	83 ec 1c             	sub    $0x1c,%esp
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
801075ec:	89 45 e0             	mov    %eax,-0x20(%ebp)
801075ef:	8b 45 08             	mov    0x8(%ebp),%eax
801075f2:	29 f0                	sub    %esi,%eax
801075f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801075f7:	eb 1f                	jmp    80107618 <mappages+0x48>
801075f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
80107600:	f6 00 01             	testb  $0x1,(%eax)
80107603:	75 45                	jne    8010764a <mappages+0x7a>
      panic("remap");
    *pte = pa | perm | PTE_P;
80107605:	0b 5d 0c             	or     0xc(%ebp),%ebx
80107608:	83 cb 01             	or     $0x1,%ebx
8010760b:	89 18                	mov    %ebx,(%eax)
    if(a == last)
8010760d:	3b 75 e0             	cmp    -0x20(%ebp),%esi
80107610:	74 2e                	je     80107640 <mappages+0x70>
      break;
    a += PGSIZE;
80107612:	81 c6 00 10 00 00    	add    $0x1000,%esi
  for(;;){
80107618:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
8010761b:	b9 01 00 00 00       	mov    $0x1,%ecx
80107620:	89 f2                	mov    %esi,%edx
80107622:	8d 1c 06             	lea    (%esi,%eax,1),%ebx
80107625:	89 f8                	mov    %edi,%eax
80107627:	e8 24 ff ff ff       	call   80107550 <walkpgdir>
8010762c:	85 c0                	test   %eax,%eax
8010762e:	75 d0                	jne    80107600 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
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
8010764d:	68 10 88 10 80       	push   $0x80108810
80107652:	e8 39 8d ff ff       	call   80100390 <panic>
80107657:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010765e:	66 90                	xchg   %ax,%ax

80107660 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	57                   	push   %edi
80107664:	56                   	push   %esi
80107665:	89 c6                	mov    %eax,%esi
80107667:	53                   	push   %ebx
80107668:	89 d3                	mov    %edx,%ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
8010766a:	8d 91 ff 0f 00 00    	lea    0xfff(%ecx),%edx
80107670:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107676:	83 ec 1c             	sub    $0x1c,%esp
80107679:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010767c:	39 da                	cmp    %ebx,%edx
8010767e:	73 5b                	jae    801076db <deallocuvm.part.0+0x7b>
80107680:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80107683:	89 d7                	mov    %edx,%edi
80107685:	eb 14                	jmp    8010769b <deallocuvm.part.0+0x3b>
80107687:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010768e:	66 90                	xchg   %ax,%ax
80107690:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107696:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80107699:	76 40                	jbe    801076db <deallocuvm.part.0+0x7b>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010769b:	31 c9                	xor    %ecx,%ecx
8010769d:	89 fa                	mov    %edi,%edx
8010769f:	89 f0                	mov    %esi,%eax
801076a1:	e8 aa fe ff ff       	call   80107550 <walkpgdir>
801076a6:	89 c3                	mov    %eax,%ebx
    if(!pte)
801076a8:	85 c0                	test   %eax,%eax
801076aa:	74 44                	je     801076f0 <deallocuvm.part.0+0x90>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
801076ac:	8b 00                	mov    (%eax),%eax
801076ae:	a8 01                	test   $0x1,%al
801076b0:	74 de                	je     80107690 <deallocuvm.part.0+0x30>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
801076b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801076b7:	74 47                	je     80107700 <deallocuvm.part.0+0xa0>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
801076b9:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801076bc:	05 00 00 00 80       	add    $0x80000000,%eax
801076c1:	81 c7 00 10 00 00    	add    $0x1000,%edi
      kfree(v);
801076c7:	50                   	push   %eax
801076c8:	e8 83 b2 ff ff       	call   80102950 <kfree>
      *pte = 0;
801076cd:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801076d3:	83 c4 10             	add    $0x10,%esp
  for(; a  < oldsz; a += PGSIZE){
801076d6:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801076d9:	77 c0                	ja     8010769b <deallocuvm.part.0+0x3b>
    }
  }
  return newsz;
}
801076db:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801076e1:	5b                   	pop    %ebx
801076e2:	5e                   	pop    %esi
801076e3:	5f                   	pop    %edi
801076e4:	5d                   	pop    %ebp
801076e5:	c3                   	ret    
801076e6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801076ed:	8d 76 00             	lea    0x0(%esi),%esi
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801076f0:	89 fa                	mov    %edi,%edx
801076f2:	81 e2 00 00 c0 ff    	and    $0xffc00000,%edx
801076f8:	8d ba 00 00 40 00    	lea    0x400000(%edx),%edi
801076fe:	eb 96                	jmp    80107696 <deallocuvm.part.0+0x36>
        panic("kfree");
80107700:	83 ec 0c             	sub    $0xc,%esp
80107703:	68 5e 81 10 80       	push   $0x8010815e
80107708:	e8 83 8c ff ff       	call   80100390 <panic>
8010770d:	8d 76 00             	lea    0x0(%esi),%esi

80107710 <seginit>:
{
80107710:	f3 0f 1e fb          	endbr32 
80107714:	55                   	push   %ebp
80107715:	89 e5                	mov    %esp,%ebp
80107717:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
8010771a:	e8 51 c7 ff ff       	call   80103e70 <cpuid>
  pd[0] = size-1;
8010771f:	ba 2f 00 00 00       	mov    $0x2f,%edx
80107724:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010772a:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010772e:	c7 80 38 38 11 80 ff 	movl   $0xffff,-0x7feec7c8(%eax)
80107735:	ff 00 00 
80107738:	c7 80 3c 38 11 80 00 	movl   $0xcf9a00,-0x7feec7c4(%eax)
8010773f:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107742:	c7 80 40 38 11 80 ff 	movl   $0xffff,-0x7feec7c0(%eax)
80107749:	ff 00 00 
8010774c:	c7 80 44 38 11 80 00 	movl   $0xcf9200,-0x7feec7bc(%eax)
80107753:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107756:	c7 80 48 38 11 80 ff 	movl   $0xffff,-0x7feec7b8(%eax)
8010775d:	ff 00 00 
80107760:	c7 80 4c 38 11 80 00 	movl   $0xcffa00,-0x7feec7b4(%eax)
80107767:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
8010776a:	c7 80 50 38 11 80 ff 	movl   $0xffff,-0x7feec7b0(%eax)
80107771:	ff 00 00 
80107774:	c7 80 54 38 11 80 00 	movl   $0xcff200,-0x7feec7ac(%eax)
8010777b:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010777e:	05 30 38 11 80       	add    $0x80113830,%eax
  pd[1] = (uint)p;
80107783:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107787:	c1 e8 10             	shr    $0x10,%eax
8010778a:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010778e:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107791:	0f 01 10             	lgdtl  (%eax)
}
80107794:	c9                   	leave  
80107795:	c3                   	ret    
80107796:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
8010779d:	8d 76 00             	lea    0x0(%esi),%esi

801077a0 <switchkvm>:
{
801077a0:	f3 0f 1e fb          	endbr32 
  lcr3(V2P(kpgdir));   // switch to the kernel page table
801077a4:	a1 e4 6b 11 80       	mov    0x80116be4,%eax
801077a9:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
801077ae:	0f 22 d8             	mov    %eax,%cr3
}
801077b1:	c3                   	ret    
801077b2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801077b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801077c0 <switchuvm>:
{
801077c0:	f3 0f 1e fb          	endbr32 
801077c4:	55                   	push   %ebp
801077c5:	89 e5                	mov    %esp,%ebp
801077c7:	57                   	push   %edi
801077c8:	56                   	push   %esi
801077c9:	53                   	push   %ebx
801077ca:	83 ec 1c             	sub    $0x1c,%esp
801077cd:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
801077d0:	85 f6                	test   %esi,%esi
801077d2:	0f 84 cb 00 00 00    	je     801078a3 <switchuvm+0xe3>
  if(p->kstack == 0)
801077d8:	8b 46 08             	mov    0x8(%esi),%eax
801077db:	85 c0                	test   %eax,%eax
801077dd:	0f 84 da 00 00 00    	je     801078bd <switchuvm+0xfd>
  if(p->pgdir == 0)
801077e3:	8b 46 04             	mov    0x4(%esi),%eax
801077e6:	85 c0                	test   %eax,%eax
801077e8:	0f 84 c2 00 00 00    	je     801078b0 <switchuvm+0xf0>
  pushcli();
801077ee:	e8 ad d7 ff ff       	call   80104fa0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801077f3:	e8 08 c6 ff ff       	call   80103e00 <mycpu>
801077f8:	89 c3                	mov    %eax,%ebx
801077fa:	e8 01 c6 ff ff       	call   80103e00 <mycpu>
801077ff:	89 c7                	mov    %eax,%edi
80107801:	e8 fa c5 ff ff       	call   80103e00 <mycpu>
80107806:	83 c7 08             	add    $0x8,%edi
80107809:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010780c:	e8 ef c5 ff ff       	call   80103e00 <mycpu>
80107811:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107814:	ba 67 00 00 00       	mov    $0x67,%edx
80107819:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107820:	83 c0 08             	add    $0x8,%eax
80107823:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010782a:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010782f:	83 c1 08             	add    $0x8,%ecx
80107832:	c1 e8 18             	shr    $0x18,%eax
80107835:	c1 e9 10             	shr    $0x10,%ecx
80107838:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
8010783e:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107844:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107849:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107850:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107855:	e8 a6 c5 ff ff       	call   80103e00 <mycpu>
8010785a:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107861:	e8 9a c5 ff ff       	call   80103e00 <mycpu>
80107866:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
8010786a:	8b 5e 08             	mov    0x8(%esi),%ebx
8010786d:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107873:	e8 88 c5 ff ff       	call   80103e00 <mycpu>
80107878:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
8010787b:	e8 80 c5 ff ff       	call   80103e00 <mycpu>
80107880:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107884:	b8 28 00 00 00       	mov    $0x28,%eax
80107889:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
8010788c:	8b 46 04             	mov    0x4(%esi),%eax
8010788f:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107894:	0f 22 d8             	mov    %eax,%cr3
}
80107897:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010789a:	5b                   	pop    %ebx
8010789b:	5e                   	pop    %esi
8010789c:	5f                   	pop    %edi
8010789d:	5d                   	pop    %ebp
  popcli();
8010789e:	e9 4d d7 ff ff       	jmp    80104ff0 <popcli>
    panic("switchuvm: no process");
801078a3:	83 ec 0c             	sub    $0xc,%esp
801078a6:	68 16 88 10 80       	push   $0x80108816
801078ab:	e8 e0 8a ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
801078b0:	83 ec 0c             	sub    $0xc,%esp
801078b3:	68 41 88 10 80       	push   $0x80108841
801078b8:	e8 d3 8a ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
801078bd:	83 ec 0c             	sub    $0xc,%esp
801078c0:	68 2c 88 10 80       	push   $0x8010882c
801078c5:	e8 c6 8a ff ff       	call   80100390 <panic>
801078ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078d0 <inituvm>:
{
801078d0:	f3 0f 1e fb          	endbr32 
801078d4:	55                   	push   %ebp
801078d5:	89 e5                	mov    %esp,%ebp
801078d7:	57                   	push   %edi
801078d8:	56                   	push   %esi
801078d9:	53                   	push   %ebx
801078da:	83 ec 1c             	sub    $0x1c,%esp
801078dd:	8b 45 0c             	mov    0xc(%ebp),%eax
801078e0:	8b 75 10             	mov    0x10(%ebp),%esi
801078e3:	8b 7d 08             	mov    0x8(%ebp),%edi
801078e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
801078e9:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801078ef:	77 4b                	ja     8010793c <inituvm+0x6c>
  mem = kalloc();
801078f1:	e8 1a b2 ff ff       	call   80102b10 <kalloc>
  memset(mem, 0, PGSIZE);
801078f6:	83 ec 04             	sub    $0x4,%esp
801078f9:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801078fe:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107900:	6a 00                	push   $0x0
80107902:	50                   	push   %eax
80107903:	e8 a8 d8 ff ff       	call   801051b0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107908:	58                   	pop    %eax
80107909:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010790f:	5a                   	pop    %edx
80107910:	6a 06                	push   $0x6
80107912:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107917:	31 d2                	xor    %edx,%edx
80107919:	50                   	push   %eax
8010791a:	89 f8                	mov    %edi,%eax
8010791c:	e8 af fc ff ff       	call   801075d0 <mappages>
  memmove(mem, init, sz);
80107921:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107924:	89 75 10             	mov    %esi,0x10(%ebp)
80107927:	83 c4 10             	add    $0x10,%esp
8010792a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010792d:	89 45 0c             	mov    %eax,0xc(%ebp)
}
80107930:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107933:	5b                   	pop    %ebx
80107934:	5e                   	pop    %esi
80107935:	5f                   	pop    %edi
80107936:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107937:	e9 14 d9 ff ff       	jmp    80105250 <memmove>
    panic("inituvm: more than a page");
8010793c:	83 ec 0c             	sub    $0xc,%esp
8010793f:	68 55 88 10 80       	push   $0x80108855
80107944:	e8 47 8a ff ff       	call   80100390 <panic>
80107949:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107950 <loaduvm>:
{
80107950:	f3 0f 1e fb          	endbr32 
80107954:	55                   	push   %ebp
80107955:	89 e5                	mov    %esp,%ebp
80107957:	57                   	push   %edi
80107958:	56                   	push   %esi
80107959:	53                   	push   %ebx
8010795a:	83 ec 1c             	sub    $0x1c,%esp
8010795d:	8b 45 0c             	mov    0xc(%ebp),%eax
80107960:	8b 75 18             	mov    0x18(%ebp),%esi
  if((uint) addr % PGSIZE != 0)
80107963:	a9 ff 0f 00 00       	test   $0xfff,%eax
80107968:	0f 85 99 00 00 00    	jne    80107a07 <loaduvm+0xb7>
  for(i = 0; i < sz; i += PGSIZE){
8010796e:	01 f0                	add    %esi,%eax
80107970:	89 f3                	mov    %esi,%ebx
80107972:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107975:	8b 45 14             	mov    0x14(%ebp),%eax
80107978:	01 f0                	add    %esi,%eax
8010797a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(i = 0; i < sz; i += PGSIZE){
8010797d:	85 f6                	test   %esi,%esi
8010797f:	75 15                	jne    80107996 <loaduvm+0x46>
80107981:	eb 6d                	jmp    801079f0 <loaduvm+0xa0>
80107983:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107987:	90                   	nop
80107988:	81 eb 00 10 00 00    	sub    $0x1000,%ebx
8010798e:	89 f0                	mov    %esi,%eax
80107990:	29 d8                	sub    %ebx,%eax
80107992:	39 c6                	cmp    %eax,%esi
80107994:	76 5a                	jbe    801079f0 <loaduvm+0xa0>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107996:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80107999:	8b 45 08             	mov    0x8(%ebp),%eax
8010799c:	31 c9                	xor    %ecx,%ecx
8010799e:	29 da                	sub    %ebx,%edx
801079a0:	e8 ab fb ff ff       	call   80107550 <walkpgdir>
801079a5:	85 c0                	test   %eax,%eax
801079a7:	74 51                	je     801079fa <loaduvm+0xaa>
    pa = PTE_ADDR(*pte);
801079a9:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
801079ab:	8b 4d e0             	mov    -0x20(%ebp),%ecx
    if(sz - i < PGSIZE)
801079ae:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
801079b3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
801079b8:	81 fb ff 0f 00 00    	cmp    $0xfff,%ebx
801079be:	0f 46 fb             	cmovbe %ebx,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
801079c1:	29 d9                	sub    %ebx,%ecx
801079c3:	05 00 00 00 80       	add    $0x80000000,%eax
801079c8:	57                   	push   %edi
801079c9:	51                   	push   %ecx
801079ca:	50                   	push   %eax
801079cb:	ff 75 10             	pushl  0x10(%ebp)
801079ce:	e8 4d a5 ff ff       	call   80101f20 <readi>
801079d3:	83 c4 10             	add    $0x10,%esp
801079d6:	39 f8                	cmp    %edi,%eax
801079d8:	74 ae                	je     80107988 <loaduvm+0x38>
}
801079da:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801079dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801079e2:	5b                   	pop    %ebx
801079e3:	5e                   	pop    %esi
801079e4:	5f                   	pop    %edi
801079e5:	5d                   	pop    %ebp
801079e6:	c3                   	ret    
801079e7:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079ee:	66 90                	xchg   %ax,%ax
801079f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801079f3:	31 c0                	xor    %eax,%eax
}
801079f5:	5b                   	pop    %ebx
801079f6:	5e                   	pop    %esi
801079f7:	5f                   	pop    %edi
801079f8:	5d                   	pop    %ebp
801079f9:	c3                   	ret    
      panic("loaduvm: address should exist");
801079fa:	83 ec 0c             	sub    $0xc,%esp
801079fd:	68 6f 88 10 80       	push   $0x8010886f
80107a02:	e8 89 89 ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107a07:	83 ec 0c             	sub    $0xc,%esp
80107a0a:	68 10 89 10 80       	push   $0x80108910
80107a0f:	e8 7c 89 ff ff       	call   80100390 <panic>
80107a14:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107a1b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107a1f:	90                   	nop

80107a20 <allocuvm>:
{
80107a20:	f3 0f 1e fb          	endbr32 
80107a24:	55                   	push   %ebp
80107a25:	89 e5                	mov    %esp,%ebp
80107a27:	57                   	push   %edi
80107a28:	56                   	push   %esi
80107a29:	53                   	push   %ebx
80107a2a:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
80107a2d:	8b 45 10             	mov    0x10(%ebp),%eax
{
80107a30:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(newsz >= KERNBASE)
80107a33:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107a36:	85 c0                	test   %eax,%eax
80107a38:	0f 88 b2 00 00 00    	js     80107af0 <allocuvm+0xd0>
  if(newsz < oldsz)
80107a3e:	3b 45 0c             	cmp    0xc(%ebp),%eax
    return oldsz;
80107a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(newsz < oldsz)
80107a44:	0f 82 96 00 00 00    	jb     80107ae0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80107a4a:	8d b0 ff 0f 00 00    	lea    0xfff(%eax),%esi
80107a50:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  for(; a < newsz; a += PGSIZE){
80107a56:	39 75 10             	cmp    %esi,0x10(%ebp)
80107a59:	77 40                	ja     80107a9b <allocuvm+0x7b>
80107a5b:	e9 83 00 00 00       	jmp    80107ae3 <allocuvm+0xc3>
    memset(mem, 0, PGSIZE);
80107a60:	83 ec 04             	sub    $0x4,%esp
80107a63:	68 00 10 00 00       	push   $0x1000
80107a68:	6a 00                	push   $0x0
80107a6a:	50                   	push   %eax
80107a6b:	e8 40 d7 ff ff       	call   801051b0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107a70:	58                   	pop    %eax
80107a71:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107a77:	5a                   	pop    %edx
80107a78:	6a 06                	push   $0x6
80107a7a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107a7f:	89 f2                	mov    %esi,%edx
80107a81:	50                   	push   %eax
80107a82:	89 f8                	mov    %edi,%eax
80107a84:	e8 47 fb ff ff       	call   801075d0 <mappages>
80107a89:	83 c4 10             	add    $0x10,%esp
80107a8c:	85 c0                	test   %eax,%eax
80107a8e:	78 78                	js     80107b08 <allocuvm+0xe8>
  for(; a < newsz; a += PGSIZE){
80107a90:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107a96:	39 75 10             	cmp    %esi,0x10(%ebp)
80107a99:	76 48                	jbe    80107ae3 <allocuvm+0xc3>
    mem = kalloc();
80107a9b:	e8 70 b0 ff ff       	call   80102b10 <kalloc>
80107aa0:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80107aa2:	85 c0                	test   %eax,%eax
80107aa4:	75 ba                	jne    80107a60 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80107aa6:	83 ec 0c             	sub    $0xc,%esp
80107aa9:	68 8d 88 10 80       	push   $0x8010888d
80107aae:	e8 fd 8b ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
80107ab6:	83 c4 10             	add    $0x10,%esp
80107ab9:	39 45 10             	cmp    %eax,0x10(%ebp)
80107abc:	74 32                	je     80107af0 <allocuvm+0xd0>
80107abe:	8b 55 10             	mov    0x10(%ebp),%edx
80107ac1:	89 c1                	mov    %eax,%ecx
80107ac3:	89 f8                	mov    %edi,%eax
80107ac5:	e8 96 fb ff ff       	call   80107660 <deallocuvm.part.0>
      return 0;
80107aca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107ad1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ad4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ad7:	5b                   	pop    %ebx
80107ad8:	5e                   	pop    %esi
80107ad9:	5f                   	pop    %edi
80107ada:	5d                   	pop    %ebp
80107adb:	c3                   	ret    
80107adc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return oldsz;
80107ae0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
}
80107ae3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107ae6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ae9:	5b                   	pop    %ebx
80107aea:	5e                   	pop    %esi
80107aeb:	5f                   	pop    %edi
80107aec:	5d                   	pop    %ebp
80107aed:	c3                   	ret    
80107aee:	66 90                	xchg   %ax,%ax
    return 0;
80107af0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
}
80107af7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107afa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107afd:	5b                   	pop    %ebx
80107afe:	5e                   	pop    %esi
80107aff:	5f                   	pop    %edi
80107b00:	5d                   	pop    %ebp
80107b01:	c3                   	ret    
80107b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107b08:	83 ec 0c             	sub    $0xc,%esp
80107b0b:	68 a5 88 10 80       	push   $0x801088a5
80107b10:	e8 9b 8b ff ff       	call   801006b0 <cprintf>
  if(newsz >= oldsz)
80107b15:	8b 45 0c             	mov    0xc(%ebp),%eax
80107b18:	83 c4 10             	add    $0x10,%esp
80107b1b:	39 45 10             	cmp    %eax,0x10(%ebp)
80107b1e:	74 0c                	je     80107b2c <allocuvm+0x10c>
80107b20:	8b 55 10             	mov    0x10(%ebp),%edx
80107b23:	89 c1                	mov    %eax,%ecx
80107b25:	89 f8                	mov    %edi,%eax
80107b27:	e8 34 fb ff ff       	call   80107660 <deallocuvm.part.0>
      kfree(mem);
80107b2c:	83 ec 0c             	sub    $0xc,%esp
80107b2f:	53                   	push   %ebx
80107b30:	e8 1b ae ff ff       	call   80102950 <kfree>
      return 0;
80107b35:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80107b3c:	83 c4 10             	add    $0x10,%esp
}
80107b3f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107b42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b45:	5b                   	pop    %ebx
80107b46:	5e                   	pop    %esi
80107b47:	5f                   	pop    %edi
80107b48:	5d                   	pop    %ebp
80107b49:	c3                   	ret    
80107b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107b50 <deallocuvm>:
{
80107b50:	f3 0f 1e fb          	endbr32 
80107b54:	55                   	push   %ebp
80107b55:	89 e5                	mov    %esp,%ebp
80107b57:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b5a:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107b5d:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80107b60:	39 d1                	cmp    %edx,%ecx
80107b62:	73 0c                	jae    80107b70 <deallocuvm+0x20>
}
80107b64:	5d                   	pop    %ebp
80107b65:	e9 f6 fa ff ff       	jmp    80107660 <deallocuvm.part.0>
80107b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107b70:	89 d0                	mov    %edx,%eax
80107b72:	5d                   	pop    %ebp
80107b73:	c3                   	ret    
80107b74:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107b7b:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107b7f:	90                   	nop

80107b80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107b80:	f3 0f 1e fb          	endbr32 
80107b84:	55                   	push   %ebp
80107b85:	89 e5                	mov    %esp,%ebp
80107b87:	57                   	push   %edi
80107b88:	56                   	push   %esi
80107b89:	53                   	push   %ebx
80107b8a:	83 ec 0c             	sub    $0xc,%esp
80107b8d:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80107b90:	85 f6                	test   %esi,%esi
80107b92:	74 55                	je     80107be9 <freevm+0x69>
  if(newsz >= oldsz)
80107b94:	31 c9                	xor    %ecx,%ecx
80107b96:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107b9b:	89 f0                	mov    %esi,%eax
80107b9d:	89 f3                	mov    %esi,%ebx
80107b9f:	e8 bc fa ff ff       	call   80107660 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107ba4:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107baa:	eb 0b                	jmp    80107bb7 <freevm+0x37>
80107bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107bb0:	83 c3 04             	add    $0x4,%ebx
80107bb3:	39 df                	cmp    %ebx,%edi
80107bb5:	74 23                	je     80107bda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107bb7:	8b 03                	mov    (%ebx),%eax
80107bb9:	a8 01                	test   $0x1,%al
80107bbb:	74 f3                	je     80107bb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107bbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107bc2:	83 ec 0c             	sub    $0xc,%esp
80107bc5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107bc8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80107bcd:	50                   	push   %eax
80107bce:	e8 7d ad ff ff       	call   80102950 <kfree>
80107bd3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107bd6:	39 df                	cmp    %ebx,%edi
80107bd8:	75 dd                	jne    80107bb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80107bda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80107bdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107be0:	5b                   	pop    %ebx
80107be1:	5e                   	pop    %esi
80107be2:	5f                   	pop    %edi
80107be3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107be4:	e9 67 ad ff ff       	jmp    80102950 <kfree>
    panic("freevm: no pgdir");
80107be9:	83 ec 0c             	sub    $0xc,%esp
80107bec:	68 c1 88 10 80       	push   $0x801088c1
80107bf1:	e8 9a 87 ff ff       	call   80100390 <panic>
80107bf6:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107bfd:	8d 76 00             	lea    0x0(%esi),%esi

80107c00 <setupkvm>:
{
80107c00:	f3 0f 1e fb          	endbr32 
80107c04:	55                   	push   %ebp
80107c05:	89 e5                	mov    %esp,%ebp
80107c07:	56                   	push   %esi
80107c08:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107c09:	e8 02 af ff ff       	call   80102b10 <kalloc>
80107c0e:	89 c6                	mov    %eax,%esi
80107c10:	85 c0                	test   %eax,%eax
80107c12:	74 42                	je     80107c56 <setupkvm+0x56>
  memset(pgdir, 0, PGSIZE);
80107c14:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c17:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
  memset(pgdir, 0, PGSIZE);
80107c1c:	68 00 10 00 00       	push   $0x1000
80107c21:	6a 00                	push   $0x0
80107c23:	50                   	push   %eax
80107c24:	e8 87 d5 ff ff       	call   801051b0 <memset>
80107c29:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107c2c:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80107c2f:	83 ec 08             	sub    $0x8,%esp
80107c32:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107c35:	ff 73 0c             	pushl  0xc(%ebx)
80107c38:	8b 13                	mov    (%ebx),%edx
80107c3a:	50                   	push   %eax
80107c3b:	29 c1                	sub    %eax,%ecx
80107c3d:	89 f0                	mov    %esi,%eax
80107c3f:	e8 8c f9 ff ff       	call   801075d0 <mappages>
80107c44:	83 c4 10             	add    $0x10,%esp
80107c47:	85 c0                	test   %eax,%eax
80107c49:	78 15                	js     80107c60 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107c4b:	83 c3 10             	add    $0x10,%ebx
80107c4e:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107c54:	75 d6                	jne    80107c2c <setupkvm+0x2c>
}
80107c56:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c59:	89 f0                	mov    %esi,%eax
80107c5b:	5b                   	pop    %ebx
80107c5c:	5e                   	pop    %esi
80107c5d:	5d                   	pop    %ebp
80107c5e:	c3                   	ret    
80107c5f:	90                   	nop
      freevm(pgdir);
80107c60:	83 ec 0c             	sub    $0xc,%esp
80107c63:	56                   	push   %esi
      return 0;
80107c64:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
80107c66:	e8 15 ff ff ff       	call   80107b80 <freevm>
      return 0;
80107c6b:	83 c4 10             	add    $0x10,%esp
}
80107c6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c71:	89 f0                	mov    %esi,%eax
80107c73:	5b                   	pop    %ebx
80107c74:	5e                   	pop    %esi
80107c75:	5d                   	pop    %ebp
80107c76:	c3                   	ret    
80107c77:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107c7e:	66 90                	xchg   %ax,%ax

80107c80 <kvmalloc>:
{
80107c80:	f3 0f 1e fb          	endbr32 
80107c84:	55                   	push   %ebp
80107c85:	89 e5                	mov    %esp,%ebp
80107c87:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107c8a:	e8 71 ff ff ff       	call   80107c00 <setupkvm>
80107c8f:	a3 e4 6b 11 80       	mov    %eax,0x80116be4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107c94:	05 00 00 00 80       	add    $0x80000000,%eax
80107c99:	0f 22 d8             	mov    %eax,%cr3
}
80107c9c:	c9                   	leave  
80107c9d:	c3                   	ret    
80107c9e:	66 90                	xchg   %ax,%ax

80107ca0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107ca0:	f3 0f 1e fb          	endbr32 
80107ca4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107ca5:	31 c9                	xor    %ecx,%ecx
{
80107ca7:	89 e5                	mov    %esp,%ebp
80107ca9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107cac:	8b 55 0c             	mov    0xc(%ebp),%edx
80107caf:	8b 45 08             	mov    0x8(%ebp),%eax
80107cb2:	e8 99 f8 ff ff       	call   80107550 <walkpgdir>
  if(pte == 0)
80107cb7:	85 c0                	test   %eax,%eax
80107cb9:	74 05                	je     80107cc0 <clearpteu+0x20>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107cbb:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80107cbe:	c9                   	leave  
80107cbf:	c3                   	ret    
    panic("clearpteu");
80107cc0:	83 ec 0c             	sub    $0xc,%esp
80107cc3:	68 d2 88 10 80       	push   $0x801088d2
80107cc8:	e8 c3 86 ff ff       	call   80100390 <panic>
80107ccd:	8d 76 00             	lea    0x0(%esi),%esi

80107cd0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107cd0:	f3 0f 1e fb          	endbr32 
80107cd4:	55                   	push   %ebp
80107cd5:	89 e5                	mov    %esp,%ebp
80107cd7:	57                   	push   %edi
80107cd8:	56                   	push   %esi
80107cd9:	53                   	push   %ebx
80107cda:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107cdd:	e8 1e ff ff ff       	call   80107c00 <setupkvm>
80107ce2:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107ce5:	85 c0                	test   %eax,%eax
80107ce7:	0f 84 9b 00 00 00    	je     80107d88 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107ced:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107cf0:	85 c9                	test   %ecx,%ecx
80107cf2:	0f 84 90 00 00 00    	je     80107d88 <copyuvm+0xb8>
80107cf8:	31 f6                	xor    %esi,%esi
80107cfa:	eb 46                	jmp    80107d42 <copyuvm+0x72>
80107cfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107d00:	83 ec 04             	sub    $0x4,%esp
80107d03:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107d09:	68 00 10 00 00       	push   $0x1000
80107d0e:	57                   	push   %edi
80107d0f:	50                   	push   %eax
80107d10:	e8 3b d5 ff ff       	call   80105250 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107d15:	58                   	pop    %eax
80107d16:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107d1c:	5a                   	pop    %edx
80107d1d:	ff 75 e4             	pushl  -0x1c(%ebp)
80107d20:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107d25:	89 f2                	mov    %esi,%edx
80107d27:	50                   	push   %eax
80107d28:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d2b:	e8 a0 f8 ff ff       	call   801075d0 <mappages>
80107d30:	83 c4 10             	add    $0x10,%esp
80107d33:	85 c0                	test   %eax,%eax
80107d35:	78 61                	js     80107d98 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
80107d37:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107d3d:	39 75 0c             	cmp    %esi,0xc(%ebp)
80107d40:	76 46                	jbe    80107d88 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107d42:	8b 45 08             	mov    0x8(%ebp),%eax
80107d45:	31 c9                	xor    %ecx,%ecx
80107d47:	89 f2                	mov    %esi,%edx
80107d49:	e8 02 f8 ff ff       	call   80107550 <walkpgdir>
80107d4e:	85 c0                	test   %eax,%eax
80107d50:	74 61                	je     80107db3 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
80107d52:	8b 00                	mov    (%eax),%eax
80107d54:	a8 01                	test   $0x1,%al
80107d56:	74 4e                	je     80107da6 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
80107d58:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107d5a:	25 ff 0f 00 00       	and    $0xfff,%eax
80107d5f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
80107d62:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107d68:	e8 a3 ad ff ff       	call   80102b10 <kalloc>
80107d6d:	89 c3                	mov    %eax,%ebx
80107d6f:	85 c0                	test   %eax,%eax
80107d71:	75 8d                	jne    80107d00 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107d73:	83 ec 0c             	sub    $0xc,%esp
80107d76:	ff 75 e0             	pushl  -0x20(%ebp)
80107d79:	e8 02 fe ff ff       	call   80107b80 <freevm>
  return 0;
80107d7e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80107d85:	83 c4 10             	add    $0x10,%esp
}
80107d88:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107d8b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d8e:	5b                   	pop    %ebx
80107d8f:	5e                   	pop    %esi
80107d90:	5f                   	pop    %edi
80107d91:	5d                   	pop    %ebp
80107d92:	c3                   	ret    
80107d93:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80107d97:	90                   	nop
      kfree(mem);
80107d98:	83 ec 0c             	sub    $0xc,%esp
80107d9b:	53                   	push   %ebx
80107d9c:	e8 af ab ff ff       	call   80102950 <kfree>
      goto bad;
80107da1:	83 c4 10             	add    $0x10,%esp
80107da4:	eb cd                	jmp    80107d73 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107da6:	83 ec 0c             	sub    $0xc,%esp
80107da9:	68 f6 88 10 80       	push   $0x801088f6
80107dae:	e8 dd 85 ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107db3:	83 ec 0c             	sub    $0xc,%esp
80107db6:	68 dc 88 10 80       	push   $0x801088dc
80107dbb:	e8 d0 85 ff ff       	call   80100390 <panic>

80107dc0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107dc0:	f3 0f 1e fb          	endbr32 
80107dc4:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107dc5:	31 c9                	xor    %ecx,%ecx
{
80107dc7:	89 e5                	mov    %esp,%ebp
80107dc9:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107dcc:	8b 55 0c             	mov    0xc(%ebp),%edx
80107dcf:	8b 45 08             	mov    0x8(%ebp),%eax
80107dd2:	e8 79 f7 ff ff       	call   80107550 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107dd7:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107dd9:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107dda:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107ddc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
80107de1:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107de4:	05 00 00 00 80       	add    $0x80000000,%eax
80107de9:	83 fa 05             	cmp    $0x5,%edx
80107dec:	ba 00 00 00 00       	mov    $0x0,%edx
80107df1:	0f 45 c2             	cmovne %edx,%eax
}
80107df4:	c3                   	ret    
80107df5:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107dfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107e00 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107e00:	f3 0f 1e fb          	endbr32 
80107e04:	55                   	push   %ebp
80107e05:	89 e5                	mov    %esp,%ebp
80107e07:	57                   	push   %edi
80107e08:	56                   	push   %esi
80107e09:	53                   	push   %ebx
80107e0a:	83 ec 0c             	sub    $0xc,%esp
80107e0d:	8b 75 14             	mov    0x14(%ebp),%esi
80107e10:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107e13:	85 f6                	test   %esi,%esi
80107e15:	75 3c                	jne    80107e53 <copyout+0x53>
80107e17:	eb 67                	jmp    80107e80 <copyout+0x80>
80107e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
80107e20:	8b 55 0c             	mov    0xc(%ebp),%edx
80107e23:	89 fb                	mov    %edi,%ebx
80107e25:	29 d3                	sub    %edx,%ebx
80107e27:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
80107e2d:	39 f3                	cmp    %esi,%ebx
80107e2f:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107e32:	29 fa                	sub    %edi,%edx
80107e34:	83 ec 04             	sub    $0x4,%esp
80107e37:	01 c2                	add    %eax,%edx
80107e39:	53                   	push   %ebx
80107e3a:	ff 75 10             	pushl  0x10(%ebp)
80107e3d:	52                   	push   %edx
80107e3e:	e8 0d d4 ff ff       	call   80105250 <memmove>
    len -= n;
    buf += n;
80107e43:	01 5d 10             	add    %ebx,0x10(%ebp)
    va = va0 + PGSIZE;
80107e46:	8d 97 00 10 00 00    	lea    0x1000(%edi),%edx
  while(len > 0){
80107e4c:	83 c4 10             	add    $0x10,%esp
80107e4f:	29 de                	sub    %ebx,%esi
80107e51:	74 2d                	je     80107e80 <copyout+0x80>
    va0 = (uint)PGROUNDDOWN(va);
80107e53:	89 d7                	mov    %edx,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e55:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
80107e58:	89 55 0c             	mov    %edx,0xc(%ebp)
80107e5b:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    pa0 = uva2ka(pgdir, (char*)va0);
80107e61:	57                   	push   %edi
80107e62:	ff 75 08             	pushl  0x8(%ebp)
80107e65:	e8 56 ff ff ff       	call   80107dc0 <uva2ka>
    if(pa0 == 0)
80107e6a:	83 c4 10             	add    $0x10,%esp
80107e6d:	85 c0                	test   %eax,%eax
80107e6f:	75 af                	jne    80107e20 <copyout+0x20>
  }
  return 0;
}
80107e71:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107e74:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107e79:	5b                   	pop    %ebx
80107e7a:	5e                   	pop    %esi
80107e7b:	5f                   	pop    %edi
80107e7c:	5d                   	pop    %ebp
80107e7d:	c3                   	ret    
80107e7e:	66 90                	xchg   %ax,%ax
80107e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107e83:	31 c0                	xor    %eax,%eax
}
80107e85:	5b                   	pop    %ebx
80107e86:	5e                   	pop    %esi
80107e87:	5f                   	pop    %edi
80107e88:	5d                   	pop    %ebp
80107e89:	c3                   	ret    
