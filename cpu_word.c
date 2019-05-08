#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include "cpu_word.h"


cpu_word_t new_cpu_word(unsigned long bin);
void print_cpu_word(cpu_word_t cpu_w);

// void hex_print(byte *ptr, uint32_t n) {

//     for(int i=0; i < n; i++) {
//         if(i != 0 && i % 16 == 0) printf("\n");

//         printf("%02X  ", ptr[i]);
//     }
//     printf("\n");
// }

void print_byte(byte b, byte from, byte to) {
    for(int i=8-from; i >= 8-to; i--)
        printf("%d", (b >> i) & 0x01);
}

void print_cpu_word(cpu_word_t cpu_w) {

    byte *word = (byte*) &cpu_w;

    print_byte(word[0], 8, 8);
    print_byte(word[1], 1, 8);
    printf("  ");
    print_byte(word[0], 5, 7);
    printf("  ");
    print_byte(word[2], 1, 8);
    printf("  ");
    print_byte(word[3], 1, 8);
    print_byte(word[4], 1, 1);
    printf("  ");
    print_byte(word[4], 2, 4);
    printf("  ");
    print_byte(word[4], 5, 8);
    printf("\n");
}

cpu_word_t new_cpu_word(unsigned long bin) {

    char *w = (char*) calloc(sizeof(cpu_word_t), sizeof(char));
    char *bin_ref = (char*) &bin;

    if(bin)
        for(int i=0; i < 5; i++)
            memcpy(&w[4-i], &bin_ref[i], 1);

    return *(cpu_word_t*) w;
}
