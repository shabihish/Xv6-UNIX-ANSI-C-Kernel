#include "user.h"


int main(){
    int fd = open("file1", 0);
//    printf(1, "%d\n", mmap(0, 100, 0, 0, fd, 0));
//    printf(1, "%d\n", mmap(0, 100, 0, 0, fd, 0));

    int addr = mmap(0, 10, 0, 0, fd, 0);
    printf(1, "%d\n", addr);

    char *a = (char*)addr;
    *a = '1';
//    printf(1, "%s", a);
//    printf(1, "%s", a);
    exit();

}