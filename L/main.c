#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include "types.h"
#include "registers.h"
#include "cpu_word.h"
#include "firmware.h"
#include "memory.h"
#include "clock.h"

bool key_stroke(char key){
    bool run;
    if (key == '\n'){
        run = true;
    } else {
        run = false;
    }

    return run;
}

int main(int argc, char **argv) {

    init_firmware();
    // print_firmware();
    init_memory();
    print_memory_until_byte(30);

    byte file_size = size_of_file();
    // printf("File size: %u\n", file_size);
    
    char key;
    while (true) {   //While ENTER
        for (size_t i = 0; i < file_size; i++) {
            if (key_stroke(key = getchar())){   //Only go into the clock if ENTER was pressed
                i = clock(i);
            } else {
                break;
            }
        }

        if (key_stroke(key = getchar())){   //Keep doing nothing as long as ENTER is pressed
        } else {
            break;
        }
    }       

    return EXIT_SUCCESS;
}
