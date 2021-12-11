# include "types.h"
# include "stat.h"
# include "user.h"

int main(int argc, char *argv[]) {
    if (argc <= 2){
        printf(1, "Not enough arguments given to set_proc_level\n");
        exit();
    }

    int pid = atoi(argv[1]);
    int target_level = atoi(argv[2]);

    if(set_proc_queue_level(pid, target_level) != -1)
        printf(1, "Successfully set PID %d's level to %d.\n", pid, get_proc_queue_level(pid));
    else
        printf(1, "Unsuccessful operation.\n");

    exit();
}