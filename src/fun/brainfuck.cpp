#include "./../kernel/stdio.h"


void brainfuck(const char* code, int* memory){ // runs brainfuck code!!!
    putc('\n',0);
    int brackets = 0;
    int memoryPointer = 0;

    int i = 0;

    while (code[i] != '\0'){ // the thingy

        switch(code[i]){

            case '>':{
                memoryPointer++;
                break;}
            case '<':{
                memoryPointer--;
                break;}
            case '+':{
                memory[memoryPointer]++;
                break;}
            case '-':{
                memory[memoryPointer]--;
                break;}
            case '[':{
                if (memory[memoryPointer] == 0){
                    brackets++;
                    while (code[i + 1] != '\0' && brackets != 0){
                        i++;
                        if (code[i] == '['){
                            brackets++;    
                        
                        }else{if(code[i] == ']'){
                            brackets--;
                        
                        }}
                    
                    }


                }
                break;
            
            
            }
            case ']':{
                if (memory[memoryPointer] != 0){
                    brackets++;
                    while (i > 0 && brackets != 0){
                        i--;
                        if (code[i] == ']'){
                        brackets++;    
                            
                        }else{if(code[i] == '['){
                            brackets--;
                            
                        }}
                    
                    }
                }
                break;
            }
            case '.':{
                int c = memory[memoryPointer];
                char actualc = c;
                putc(c, 0x05);
                break;
            }
            case ',':{
                char input = getKey();
                putc(input, 0x0f);
                putc('\n',0);
                memory[memoryPointer] = input;
                break;
            }
        }
        i++;

    }


}