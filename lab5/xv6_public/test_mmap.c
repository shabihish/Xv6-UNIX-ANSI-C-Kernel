#include "user.h"


int main(){


    int pid = fork();
    if(pid == 0){
        int fd = open("file1", 0);
        int addr = mmap(0, 9, 0, 0, fd, 0);
        printf(1, "Assigned mmap start address: %d\n", addr);

        char *file_str = (char*)addr;
        printf(1, "File str: %s\n", file_str);

        sleep(8000);
        exit();
    }
    else {
        pid = fork();
        if(pid==0) {
            sleep(300);
            int fd = open("file1", 0);
            int addr = mmap(0, 9, 0, 0, fd, 0);
            printf(1, "Child Assigned mmap start address: %d\n", addr);


            char *file_str = (char *) addr;
            char *new_str = "BBBBBBB";
//            strcpy(file_str, new_str);
//            printf(1, "File str from child: %s\n\n\n", (char *) addr);
        }else{
            sleep(300);
            int fd = open("file1", 0);
            int addr = mmap(0, 9, 0, 0, fd, 0);
            printf(1, "Parent Assigned mmap start address: %d\n", addr);


            char *file_str = (char *) addr;

            char *new_str = "CCCCCCC";
//            strcpy(file_str, new_str);
//            printf(1, "File str from parent: %s\n\n\n", (char *) addr);

            sleep(2);
            wait();
            sleep(20);
            exit();
        }

    }
}