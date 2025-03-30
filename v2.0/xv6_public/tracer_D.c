#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"

int main(int argc, char *argv[]) {
    if (argc <= 1) {
        printf(1, "not enough arguments given to tracer_D\n");
        exit();
    }

    int tracee_pid = atoi(argv[1]);

    set_proc_tracer(tracee_pid);
    int wpid;
    for (int i=0;i<6;i++) {
        sleep(120);
        wpid = wait_sleeping();
        if (wpid >= 0) {
            printf(1, "From tracer: traced pid %d is sleeping\n", wpid);
        }
    }
    exit();
}