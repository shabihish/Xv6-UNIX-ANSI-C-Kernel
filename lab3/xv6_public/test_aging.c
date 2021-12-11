# include "types.h"
# include "stat.h"
# include "user.h"

int main(int argc, char *argv[]) {

    int pid = fork();
    if (pid < 0) {
        printf(1, "init: fork failed\n");
        exit();
    }
    if (pid == 0) {
        printf(1, "New pid: %d\n", getpid());
        for(;;);
    }else {
        if (set_proc_queue_level(pid, 3) != -1)
            printf(1, "Successfully set PID %d's level to %d.\n", pid, get_proc_queue_level(pid));
        else
            printf(1, "Unsuccessful operation.\n");
    }
    exit();
}