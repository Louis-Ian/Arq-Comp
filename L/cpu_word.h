#ifndef CPU_WORD_H
#define CPU_WORD_H

#include "types.h"


typedef struct __attribute__((__packed__)) cpu_word {
    byte     high_addr : 1,
             jamz      : 1,
             jamn      : 1,
             jmpc      : 1,
             unused    : 4;
    byte     next_addr : 8;
    byte     inc       : 1,
             inva      : 1,
             enb       : 1,
             ena       : 1,
             f_1       : 1,
             f_0       : 1,
             sra1      : 1,
             sll8      : 1;
    uint16_t mdr       : 1,
             pc        : 1,
             sparc     : 1,
             lv        : 1,
             cpp       : 1,
             tos       : 1,
             opc       : 1,
             h         : 1,
             bbus      : 4,
             fetch     : 1,
             read      : 1,
             write     : 1,
             mar       : 1;
} cpu_word_t;

void print_byte(byte b, byte from, byte to);
cpu_word_t new_cpu_word(unsigned long bin);
void print_cpu_word(cpu_word_t cpu_w);

#endif
