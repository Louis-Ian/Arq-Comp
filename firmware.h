#ifndef FIRMWARE_H
#define FIRMWARE_H

#include "cpu_word.h"

#define FW_LEN          0x200
#define NOP             0x000
#define IADD            0x002
#define ISUB            0x005
#define IAND            0x008
#define IOR             0x00B
//#define DUP             0x00E
//#define POP             0x010
//#define SWAP            0x013
#define BIPUSH          0x019
#define ILOAD           0x01C
#define ISTORE          0x022
//#define WIDE            0x028
//#define LDC_W           0x032
//#define IINC            0x036
#define GOTO            0x03C
//#define IFLT            0x043
//#define IFEQ            0x047
#define IF_ICMPEQ       0x04B
//#define INVOKEVIRTUAL   0x055
//#define IRETURN         0x06B

void init_firmware(void);
// cpu_word_t get_opcode(byte opcode);
int get_opcode(byte opcode);
void print_firmware(void);

#endif