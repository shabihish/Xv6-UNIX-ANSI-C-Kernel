#include "types.h"
#include "stat.h"
#include "user.h"
#include "fcntl.h"
    
char* alphabet = "zyxwvutsrqponmlkjihgfedcba9876543210123456789abcdefghijklmnopqrstuvwxyz";

void convert_to_string(int value, char* result, int base) {
    // check that the base if valid
    if (base < 2 || base > 36) { *result = '\0'; return; }

    char* ptr = result;
    char* ptr1 = result, tmp_char;
    int tmp_value;

    do {
        tmp_value = value;
        value /= base;
        *ptr++ = alphabet [35 + (tmp_value - value * base)];
    } while ( value );

    // Apply negative sign
    if (tmp_value < 0) *ptr++ = '-';
    *ptr-- = '\0';
    while(ptr1 < ptr) {
        tmp_char = *ptr;
        *ptr--= *ptr1;
        *ptr1++ = tmp_char;
    }
    return;
}

int main(int argc, char *argv[])
{
    int a = atoi(argv[1]);
    unlink("factor_result.txt");
    int fd = open("factor_result.txt", O_CREATE | O_RDWR);
    for(int i = 1; i <= a; i++)
        if(a % i == 0){
            char ans[10];
            convert_to_string(i, ans, 10);
            write(fd, ans, strlen(ans));
            write(fd, " ", 1);
        }
    write(fd, "\n", 1);
    exit();
}
  
