#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

typedef unsigned long microcode;

int main_file_io_test(int argc, char const *argv[])
{
    microcode teste[512];
    for(int i = 0; i < 512; i++)
    teste[i] = 0b0000000000000000000000000000000000000000000000000000000000000000;

    FILE *file1 = fopen("microprog.rom","wb");
    assert(file1);
    fwrite( teste, sizeof(teste[0]), 512, file1);
    fclose(file1);

    FILE *file2 = fopen("microprog.rom","rb");
    assert(file2);
    fread( teste, sizeof(teste[0]), 512, file2);
    fclose(file2);

    for(int i = 0; i < 512; i++)
    {
        printf("%d: ", i+1);
        for(int j = 63; j >= 0; j--)
        {
            printf("%lu", ((microcode)(teste[i] >> j) & 0b1));
        }
        printf("\n");
    };

    return 0;
}