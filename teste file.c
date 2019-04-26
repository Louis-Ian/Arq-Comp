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

    int byte = 1;
    for(int i = 0; i < 512; i++)
    {
        if (byte == 1){
            byte++;
            printf("%d: %lu", (i/8)+1, teste[i]);
        }
        else if( byte == 8){
            byte = 1;
            printf("%lu\n", teste[i]);
        } else {
            byte++;
            printf("%lu", teste[i]);
        }
    }

    fclose(file);

    return 0;
}