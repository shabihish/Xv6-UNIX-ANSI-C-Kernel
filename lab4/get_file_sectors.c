#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]) {
    if (argc <= 1){
        printf(1, "not enough arguments given to gfsec\n");
        exit();
    }

    int fd;
    if ((fd = open(argv[1], 0)) < 0) {
        printf(1, "gfsec: cannot open %s\n", argv[1]);
        exit();
    }

    int *sectors = malloc(200*sizeof(int));
    get_file_sectors(fd, sectors, 200);

    printf(1, "Returned to user:\n");
    for(int i=0; i<200 && sectors[i]!=-1;i++){
        printf(1, "%d ", sectors[i]);
    }
    printf(1, "\n");
    exit();
}