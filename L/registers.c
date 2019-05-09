#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "types.h"
#include "registers.h"


uint32_t registers[N_REGS];
int num_vars;

void write_reg(int reg, uint32_t value) {

    switch(reg) {
        case MAR: registers[MAR] = value; break;
        case MDR: registers[MDR] = value; break;
        case PC : registers[PC]  = value; break;
        case SP : registers[SP]  = value; break;
        case LV : registers[LV]  = value; break;
        case CPP: registers[CPP] = value; break;
        case TOS: registers[TOS] = value; break;
        case OPC: registers[OPC] = value; break;
        case H  : registers[H]   = value; break;
        default : printf("Unabled to write in %d\n", reg); break;
    }
}

int load_reg_in_bbus(int reg) {

    switch(reg) {
        case MDR : return registers[MDR];
        case PC  : return registers[PC];
        case MBR : return registers[MBR];
        case MBRU: return registers[MBRU];
        case SP  : return registers[SP];
        case LV  : return registers[LV];
        case CPP : return registers[CPP];
        case TOS : return registers[TOS];
        case OPC : return registers[OPC];
        default  : printf("Unabled to load from %d\n", reg); break;
    }
}

void init_regs(byte* mem){
    uint32_t aux;
    memcpy(&aux, &(mem[8]), sizeof(uint32_t));
    write_reg(CPP, aux);
    printf("%u\n", registers[CPP]);
    memcpy(&aux, &(mem[12]), sizeof(uint32_t));
    write_reg(LV, aux);
    printf("%u\n", registers[LV]);
    memcpy(&aux, &(mem[16]), sizeof(uint32_t));
    write_reg(PC, aux);
    printf("%u\n", registers[PC]);
    memcpy(&aux, &(mem[20]), sizeof(uint32_t));
    write_reg(SP, aux);
    printf("%u\n\n", registers[SP]);

    num_vars = load_reg_in_bbus(SP) - load_reg_in_bbus(LV) - 1;
    printf("%u\n\n", num_vars);
    int *vars = malloc((num_vars + 1)*sizeof(int));
}