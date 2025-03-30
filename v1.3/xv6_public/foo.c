#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

#define NUM_OF_OPT 1e2
#define STEP 0.1
#define VAL1 5.9
#define VAL2 55.99
int main(int argc, char *argv[]) {
  int pid;
  int n;
  int x = 1;
  
    n=5;
  //n = atoi(argv[1]);
  
  for (int j = 0; j < n; j++ ) {
    pid = fork ();
    if ( pid < 0 ) {
      printf(1, "%d failed in fork!\n", getpid());
      exit();
    } 
    else if (pid == 0)
    {
      printf(1, "Child %d created\n",getpid());
      for ( int i = 0; i < NUM_OF_OPT; i += STEP)
            x =  x + VAL1 + VAL2 ;   
      exit();
    }
    for (int i = 0; i < n; i++)
        wait();
  }
  exit();
}
