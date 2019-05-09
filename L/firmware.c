#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <assert.h>
#include <unistd.h>
#include "firmware.h"
#include "cpu_word.h"
#include "types.h"

cpu_word_t firmware[FW_LEN];

/* 
cpu_word_t get_opcode(byte opcode) {

    switch(opcode) {
    case NOP:
    return firmware[NOP];
        
    case IADD:
    return firmware[IADD];
        
    case ISUB:
    return firmware[ISUB];
        
    case IAND:
    return firmware[IAND];
        
    case IOR:
    return firmware[IOR];
        
    // case DUP:
    return firmware[DUP];
        
    // case POP:
    return firmware[POP];
        
    // case SWAP:
    return firmware[SWAP];
        
    case BIPUSH:
    return firmware[BIPUSH];
        
    case ILOAD :
    return firmware[ILOAD];
        
    case ISTORE:
    return firmware[ISTORE];
        
    // case WIDE:
    return firmware[WIDE];
        
    // case LDC_W:
    return firmware[LDC_W];
        
    // case IINC :
    return firmware[IINC];
        
    case GOTO    :
    return firmware[GOTO];
        
    // case IFLT :
    return firmware[IFLT];
        
    // case IFEQ :
    return firmware[IFEQ];
        
    case IF_ICMPEQ:
    return firmware[IF_ICMPEQ];
        
    // case INVOKEVIRTUAL:
    return firmware[INVOKEVIRTUAL];
        
    // case IRETURN:
    return firmware[IRETURN];
        
    default:
    printf("Invalid OPCODE = 0x%03X\n", opcode);
    }

} */

int get_opcode(byte opcode) {

    int ret[3];

    switch(opcode) {
        case NOP: 
        ret[0] = 0;
        ret[1] = 0;
        ret[2] = 0;
        return *ret;

        case IADD:

        
        case ISUB:
    
        
        case IAND:
    
        
        case IOR:
    
        
        // case DUP:

        
        // case POP:

        
        // case SWAP:

        
        case BIPUSH:
    
        
        case ILOAD:
    
        
        case ISTORE:
    
        
        // case WIDE:

        
        // case LDC_W:

        
        // case IINC:

        
        case GOTO:
    
        
        // case IFLT:

        
        // case IFEQ:

        
        case IF_ICMPEQ:
    
        
        // case INVOKEVIRTUAL:

        
        // case IRETURN:

        
        default:
        printf("Invalid OPCODE = 0x%03X\n", opcode);
    }
}

void init_firmware(void) {
/*  // NOP | MAIN
    firmware[0x00] = WORD(100, 000000000, 00110101, 000000100, 001, 0001); // PC <- PC + 1; fetch; GOTO MBR;
    // TODO why skip address 0x01?
    // ADD OPC, mem[addr] | OPC <- OPC + mem[addr];
    firmware[0x02] = WORD(000000011, 000, 00110101, 000000100, 001, 0001); // PC <- PC + 1; fetch;
    firmware[0x03] = WORD(000000100, 000, 00010100, 000000001, 010, 0010); // MAR <- MBR; read;
    firmware[0x04] = WORD(000000101, 000, 00010100, 100000000, 000, 0000); // H <- MDR;
    firmware[0x05] = WORD(000000000, 000, 00111100, 010000000, 000, 1000); // OPC <- OPC + H; GOTO MAIN;

    // MOV OPC, mem[addr] | mem[addr] <- OPC;
    firmware[0x06] = WORD(000000111, 000, 00110101, 000000100, 001, 0001); // PC <- PC + 1; fetch;
    firmware[0x07] = WORD(000001000, 000, 00010100, 000000001, 000, 0010); // MAR <- MBR;
    firmware[0x08] = WORD(000000000, 000, 00010100, 000000010, 100, 1000); // MDR <- OPC; write; GOTO MAIN;

    // GOTO byte;
    firmware[0x09] = WORD(000001010, 000, 00110101, 000000100, 001, 0001); // PC <- PC + 1; fetch;
    firmware[0x0A] = WORD(000000000, 100, 00010100, 000000100, 001, 0010); // PC <- MBR; fetch; GOTO MBR;

    // JZ OPC, byte | if OPC = 0 GOTO addr else next_line
    firmware[0x0B] = WORD(000001100, 001, 00010100, 010000000, 000, 1000); // OPC <- OPC; IF ALU = 0 GOTO 268 (100001100) ELSE GOTO 12 (000001100);
    firmware[0x0C] = WORD(000000000, 000, 00110101, 000000100, 000, 0001); // PC <- PC + 1; GOTO MAIN;
    firmware[0x10C] = WORD(100001101, 000, 00110101, 000000100, 001, 0001); // PC <- PC + 1; fetch;
    firmware[0x10D] = WORD(000000000, 100, 00010100, 000000100, 001, 0010); // PC <- MBR; fetch; GOTO MBR;

    // OPC <- OPC - mem[addr];
    firmware[0x0D] = WORD(000, 000001110, 00110101, 000000100, 001, 0001); //PC <- PC + 1; fetch;
    firmware[0x0E] = WORD(000, 000001111, 00010100, 000000001, 010, 0010); //MAR <- MBR; read;
    firmware[0x0F] = WORD(000, 000010000, 00010100, 100000000, 000, 0000); //H <- MDR;
    firmware[0x10] = WORD(000, 000000000, 00111111, 010000000, 000, 1000); //OPC <- OPC - H; GOTO MAIN;
*/
    system("/usr/bin/python3 main.py");

    FILE *file_firmware = fopen("microprog_flipped.rom","rb");
    assert(file_firmware);
    fread( firmware, sizeof(firmware[0]), FW_LEN, file_firmware);
    fclose(file_firmware);
}

void print_firmware(void) {

    printf("\tNEXT_ADDR  JAM    ALU         C      MEM   B  \n");
    for(int i=0; i < FW_LEN; i++) {
        printf("0x%03X   ", i);
        print_cpu_word(firmware[i]);
    }
}