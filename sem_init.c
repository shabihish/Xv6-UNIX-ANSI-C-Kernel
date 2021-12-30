
#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
    if (argc <= 2){
        printf(1, "not enough arguments\n");
        exit();
    }
    int i = atoi(argv[1]);
    int v = atoi(argv[2]);
    if( i > 5)
    {
        printf(1, "There are only 5 semaphors\n");
        exit();
    }
    sem_init(i-1,v);
    
    exit();
} 