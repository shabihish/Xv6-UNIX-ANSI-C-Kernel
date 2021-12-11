# include "types.h"
# include "stat.h"
# include "user.h"

int main(int argc, char *argv[]) {
    if (argc <= 1){
        printf(1, "Not enough arguments given to get_proc_level\n");
        exit();
    }

    int pid = atoi(argv[1]);
    printf(1, "PID %d's level: %d\n", pid, get_proc_queue_level(pid));
    exit();
}