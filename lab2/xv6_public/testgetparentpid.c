# include "types.h"
# include "stat.h"
# include "user.h"

 //passing command line arguments
    
int main(void)
{
  int pid1;
  pid1 = fork();
  
  if(pid1 == 0)
  {
  	int pid2;
  	pid2 = fork();
  	if(pid2 == 0)
  	{
  		printf(1,"second child pid is: %d\n", getpid());
  		printf(1,"second child Parent pid is: %d\n", getparentpid());
  	}
  	else if(pid2 == -1)
  	{
            printf(1,"forked failed\n last process pid is\n: %d\n", pid1);
            exit();
  	}
  	else
  	{
  		wait();
  		printf(1,"first child pid is: %d\n", getpid());
  		printf(1,"first child Parent pid is: %d\n", getparentpid());
  	}
  }
  else
  {
  	wait();
  	printf(1,"current process pid is: %d\n", getpid());
  	printf(1,"current process Parent pid is: %d\n", getparentpid());
  }
  
  exit();
}
