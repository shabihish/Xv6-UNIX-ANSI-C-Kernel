#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
    for (int i = 0; i <= 4 ; i++)
    {
        int pid = fork();
        if (pid == 0) {
            dining(i);
            exit();
        }
    }

    while(wait() != -1);

    exit();
} 