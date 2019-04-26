#include <stdio.h>
#include <stdlib.h>

int main(int argc, char const *argv[])
{
    
    FILE *file;
    file = fopen("microprog.rom","rb+");
    
    unsigned long teste[512];
    
    //fwrite (address_data,size_data,numbers_data,pointer_to_file);
    for(int i = 0; i < 512; i++)
    {
        teste[i] = fread( (unsigned long*)&(teste), 512*sizeof(unsigned long), 512, file);
        //teste[i] = 0b0;
    }

    //teste[511] = 0b0000000000000000000000000000000000000000000000000000000000100001;

    for(int i = 0; i < 512; i++)
    {
        printf("%d: ", i+1);
        for(int j = 63; j >= 0; j--)
        {
            printf("%lu", ((unsigned long)(teste[i] >> j) & 0b1));
        }
        printf("\n");
    }

    fclose(file);

    return 0;
}