#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
  int result = get_free_pages_count();
  printf(1, "Num of free pages : %d\n", result);
  exit();
} 
