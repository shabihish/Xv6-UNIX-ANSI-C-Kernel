#include "types.h"
#include "stat.h"
#include "user.h"

int main() {
    int pid = fork();
    if (pid < 0) {
        printf(1, "init: fork failed\n");
        exit();
    }
    if (pid == 0) {
        sleep(20);
        printf(1, "A pid: %d, A's parent pid: %d\n", getpid(), get_parent_pid());
        sleep(1000);
        printf(1, "A pid: %d, A's parent pid: %d\n", getpid(), get_parent_pid());
    }
    while (wait()>=0)
        ;
    exit();
}