//src/kernel/kernel.cpp

#include "stdio.h"
#include "./../fun/brainfuck.h"

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
        printf("\nType in your brainfuck code here NOW OR DIE >:CCC (max 1024 chars)\n",0x05);
        char codelol[1024] = {};
        getInput(codelol);
        brainfuck(codelol);
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
    if (streq(cmd, "BFTEST") == 1){
        brainfuck(">++++++++[<+++++++++>-]<.>++++[<+++++++>-]<+.+++++++..+++.>>++++++[<+++++++>-]<++.------------.>++++++[<+++++++++>-]<+.<.+++.------.--------.>>>++++[<++++++++>-]<+.");
        return;

    }
    printf("\nNot a valid command\n", 0x05);

}


extern "C" void main(){
    clearScreen();
    printf("codename 32bits\nhi :3\n\n", 0x05);
    char command[100] = {};
    while (1){
        putc('>',0x05);
        getInput(command);
        commands(command);
        putc('\n',0);
    }
}
