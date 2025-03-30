#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
    int pid = atoi(argv[1]);
    int priority = atoi(argv[2]);
    set_HRRN_process_level(pid, priority);
    exit();
} 
