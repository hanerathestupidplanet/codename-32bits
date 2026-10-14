//src/kernel/kernel.cpp

#include "stdio.h"
#include "./../fun/brainfuck.h"
#include "./../idt/idt.h"

// Source - https://stackoverflow.com/q/10419801
// Posted by Svalorzen, modified by community. See post 'Timeline' for change history
// Retrieved 2026-10-14, License - CC BY-SA 4.0

void * __gxx_personality_v0=0; // shut up the compiler
void * _Unwind_Resume =0;




void commands(char* cmd){
    if (streq(cmd, "CLEAR") == 1){
        clearScreen();
        return;
    }
    if (streq(cmd, "MEOW") == 1){
        printf(
        "\n|\\---/|\n"
        "| o_o |  meow\n"
        " \\_^_/ /\n",0x05);
        return;
    }

    if (streq(cmd, "BRAINFUCK") == 1){
        uint8_t memory[1024] = {};
        for (int i = 0; i < 1024; i++){ // resets memory

            memory[i] = 0;
        
        }
        while (true){
            printf("\nbrainfuck > ",0x05);
            char codelol[1024] = {};
            getInput(codelol);
            if (streq(codelol, "EXIT")){
                break;
            }
            brainfuck(codelol, memory);
        }
        return;
    }

    if (streq(cmd, "SHUTDOWNQEMU") == 1){
        printf("\nShutting down!\n", 0x05);
        setPortW(0x604, 0x2000);
        return;
    }
    if (streq(cmd, "SHUTDOWN") == 1){
        printf("\nShutting down!\n", 0x05);
        printf("\nthis isnt implemented yet LMAO\n", 0x05);
        return;

    }
    if (streq(cmd, "HELP") == 1){ 
        printf("\nCLEAR - clears the screen\n",0x05);
        printf("SHUTDOWNQEMU - shuts down QEMU (if youre running this in QEMU)\n",0x05);
        printf("BRAINFUCK - opens a brainfuck command line\n",0x05);
        printf("MEOW - mrrow\n",0x05);
        printf("also the keymap is a little weird because i couldnt use my keypad and i havent  added macros yet LOL\n", 0x05);
        return;

    }
    printf("\nNot a valid command\n", 0x05);

}


extern "C" void main(){
    clearScreen();
    printf("Initializing IDT...", 0x05);
    idtInit();
    clearScreen();
    printf("codename 32bits\ntype in 'help' for a list of commands\n\n", 0x05);
    char command[100] = {};
    while (1){
        putc('>',0x05);
        getInput(command);
        commands(command);
        putc('\n',0);
    }
}
