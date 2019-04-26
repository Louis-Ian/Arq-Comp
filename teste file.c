#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[]){
    
    FILE *file;
    file = fopen("microprog.rom","rb+");
    
    unsigned long teste[512];
    
    //fwrite (address_data,size_data,numbers_data,pointer_to_file);
    for(int i = 0; i < 512; i++)
    {
        teste[i] = fread( (unsigned long*)&(teste), 512*sizeof(unsigned long), 512, file);
    }

    for(int i = 0; i < 512; i++)
    {
        printf("%lu", teste[i]);
    }

    fclose(file);

    return 0;
}