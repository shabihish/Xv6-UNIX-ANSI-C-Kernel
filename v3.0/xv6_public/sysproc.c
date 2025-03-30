#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int sys_wait_sleeping(void){
    return wait_sleeping();
}
int sys_set_proc_tracer(void){
    return set_proc_tracer();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int sys_calculate_sum_of_digits(void){
  int num = myproc()->tf->edx; //edx or ebx?
  //cprintf("edx : %d\n", myproc()->tf->edx);
  //cprintf("number : %d\n",number);
  int result = 0;
  int reminder = 10;
  while(num / reminder != 0){
    result += (num % reminder);
    //cprintf("num : %d\n", num);
    //cprintf("result : %d\n", result);
    // reminder = reminder * 10;
    num = (num / reminder);
    //cprintf("num : %d\n", num);
  }
  result += num;
  return result;
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_get_parent_pid(void)
{
	return myproc()->parent->pid;
}

int 
sys_get_free_pages_count(void){
  return get_free_pages_count();
}
