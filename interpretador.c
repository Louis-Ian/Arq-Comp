#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <cstdio>
#include <cstdlib>

#define MREAD 2
#define MWRITE 4
#define MFETCH 1

FILE *fp;

typedef unsigned int word;
typedef unsigned char byte;
typedef unsigned long microcode;

microcode rom[512]; //microprograma máximo = 512 microcódigos (512 x 36 bits). Para facilitar manipulação de memória, cada microcódigo é 
                    //armazenado em 64 bits, sendo zerados os 28 bits de alta ordem. Tamanho máximo do microprograma = 512 x 8 bytes = 4 KBytes
microcode workcode = 0;
word mpc = 0;
word next_address = 1;

void address_encode();

void save(){    //grava rom em arquivo
    fp = fopen("microprog.rom","rb+");

    fclose(fp);
}

int PC;                     //contador de programa tem o endereço da próxima intrução
int AC;                     //acumulador, um registrador para aritmética
int instr;                  //intrução atual
int instr_type;             //tipo de intrução (opcode)
int data_loc;               //endereço dos dados (-1 se nenhum)
int data;                   //dado atual
bool run_bit = true;        //bit para desligar a máquina

int get_instr_type(int addr){};
int find_data(int instr, int type){};
void execute(int type, int data){};

void interpret(int memory[], int starting_address){ //função principal do interpretador, recebe o array da memória e o inteiro do ponto endereço incial
    PC = starting_address;
    while(run_bit == true){
        instr = memory[PC];                     //busca a a próxima intrução e armazena em instr
        PC++;                                   //incrementa o PC
        instr_type = get_instr_type(instr);     //determina o tipo da instrução
        data_loc = find_data(instr, instr_type);//localiza a intrução (-1 se nenhuma)

        if (data_loc >= 0){                     //se data_loc for -1, não executa
            data = memory[data_loc];            //busca o dado
        }
        execute(instr_type, data);              //executa a instrução
    }
}

int main(int argc, char const *argv[]){
    unsigned long int mem[512];
    for(int i = 0; i < 512; i++){
        mem[i] = 0;
    }

//    interpret(mem, 0);

//    printf("rodou okay\n");

    return 0;
}