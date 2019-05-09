#ifndef TYPES_H
#define TYPES_H

#define uint16_t unsigned short int
#define uint32_t unsigned int
#define byte     unsigned char
#define WORD(A, J, ALU, C, M, B) new_cpu_word(0b##J##A##ALU##C##M##B)

#endif
