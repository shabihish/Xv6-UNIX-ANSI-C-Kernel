# include "types.h"
# include "stat.h"
# include "user.h"

 //passing command line arguments
    
int main(void)
{
  printf(1,"current process parent pid is: %d\n",get_parent_pid());
  exit();
}