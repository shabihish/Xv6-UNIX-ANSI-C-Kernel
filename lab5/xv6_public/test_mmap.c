#include "user.h"


int main(){
    int pid = fork();

    if(pid == 0){
        printf(1, "Child pid: %d\n", getpid());
        int fd = open("file1", 0);
        int addr = mmap(0, 10, 0, 0, fd, 0);
        printf(1, "%d\n", addr);



        char *a = (char*)addr;
        *a = '0';

        sleep(100);
        printf(1, "%s\n", a);
        exit();
    }
    else {
        sleep(4);
        printf(1, "Parent pid: %d\n", getpid());
        int fd = open("file1", 0);
//        int fd = open("file2", 0);
        int addr = mmap(0, 10, 0, 0, fd, 0);
        printf(1, "%d\n", addr);

        char *a = (char*)addr;
        *a = '9';

        sleep(2);
        printf(1, "%s\n", a);
        wait();
        sleep(20);
        printf(1, "AAAAAA\n");
        exit();
    }
}