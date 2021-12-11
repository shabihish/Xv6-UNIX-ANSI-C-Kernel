#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc, char *argv[]){
    int prev_edx, curr_edx, number = atoi(argv[1]);
    //printf(1, "hi\n");
    asm volatile(
        "movl %%edx, %0;" // prev_edx = edx
        "movl %1, %%edx;" // edx = number
        : "=r" (prev_edx)   //output variable
        : "r"(number)       //input variable
        : "%edx"
    );
    int result =  calculate_sum_of_digits();
    printf(1,"Sum of digits is: %d\n" ,result);
    printf(1,"value of register before syscall : %d\n", prev_edx);
    asm volatile(
        "movl %1, %%edx;" // edx = prev_edx
        "movl %%edx, %0;"
        : "=r" (curr_edx)//output register
        : "r"(prev_edx)
        : "%edx"
    ); 
    printf(1,"value of register after syscall : %d\n", curr_edx);
    
    //int src = 1;
    //printf(1, "edx : %d\n", %edx);

    //printf(1, "value of register after syscall : %d\n", myproc()->tf->edx);
    exit();
} 