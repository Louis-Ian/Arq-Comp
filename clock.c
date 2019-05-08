#include <stdlib.h>
#include <stdio.h>
#include "types.h"
#include "memory.h"
#include "firmware.h"
#include "registers.h"

byte memory[MEM_LEN];

byte instruction;
// int running_instruction[3];

int clock(int i){
    instruction = get_opcode( memory[i + 23]);
    
    // *running_instruction = get_opcode(instruction);
    // run_opcode(running_instruction);  ???
    
    return i;
}