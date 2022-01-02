
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
    if (argc <= 1){
        printf(1, "not enough arguments\n");
        exit();
    }
    int i = atoi(argv[1]);
    int result = sem_acquire(i);
    if(result > 0)
        printf(1,"process entered to the critical section\n");
    else if(result == 0)
        printf(1,"this semaphore has not been initialised yet\n");
    else
        printf(1,"process added to waiting queue on semaphore\n");
    exit();
} 