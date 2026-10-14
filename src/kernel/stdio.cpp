// src/kernel/stdio.cpp
int textX = 0;
int textY = 0;
int cursorX = 0;
int cursorY = 0;
typedef unsigned char      uint8_t;
typedef unsigned short     uint16_t;
typedef unsigned int       uint32_t;
typedef unsigned long long uint64_t;
volatile char* video = (volatile char*)0xb8000;

static inline uint16_t readPort(uint16_t port){
    uint16_t value;
    asm volatile ( "inb %1, %0"
        :"=a" (value)
        :"Nd" (port));
    return value;
}
void setPort(uint16_t port, uint8_t value){
    asm volatile ( "outb %0, %1"
        :
        :"a" (value), "Nd" (port));
}
void setPortW(uint16_t port, uint16_t value){
    asm volatile ( "outw %0, %1"
        :
        :"a" (value), "Nd" (port));
}


const char keymap[79] = {
    0,0,'1','2','3','4','5','6','7','8','9','0',
    '-','=','\b','\t','Q','W','E','R','T','Y','U',
    'I','O','P','[',']','\r',0,'A','S','D','F','G',
    'H','J','K','L',';','\'','`',0,'\\','Z','X','C',
    'V','B','N','M',',','.','/',0,'*',0,' ',0x3a,1,2,
    3,4,5,6,7,'<','>','+',0,0,'7','8','9','-','4','5','6','+'
};

void clearScreen(){
    textX = 0;
    textY = 0;
    cursorX = 0;
    cursorY = 0;
    for(int i = 0; i < (80*2)*25; i+=2){
        video[i] = 0;
        video[i+1] = 0x0f;

    }

}

void setVideo(int x, int y, char c){

    video[((80*2)*y)+x] = c;

}

void setCursor(int x, int y)//from osdev wiki
{
	uint16_t pos = y * 80 + x;

	setPort(0x3D4, 0x0F);
	setPort(0x3D5, (uint8_t) (pos & 0xFF));
	setPort(0x3D4, 0x0E);
	setPort(0x3D5, (uint8_t) ((pos >> 8) & 0xFF));
}



void putc(char c, int color){
    if (c == '\n' || c == '\r'){
        textY++;
        textX = 0;
        cursorY++;
        cursorX = 0;
    }else{
        video[((80*2)*textY)+textX] = c;
        video[(((80*2)*textY)+textX)+1] = color;
        textX++;
        textX++;
        cursorX++;
    }
    
    if (textX >= 80*2){
        textY++;
        cursorY++;
        textX = 0;
        cursorX = 0;
    }
    if (textY >= 25){
        clearScreen();
    }
    setCursor(cursorX, cursorY);
}

void printf(const char *s, int color){
    int i = 0;
    while (s[i] != '\0'){
        putc(s[i], color);
        i++;
    }
}



char getKey(){
    while(1){
        if ((readPort(0x64) & 1) == 0) {
            continue; 
        }
        uint16_t scancode = readPort(0x60);
        if (scancode & 0x80){
             continue; 
        }
        char c = keymap[scancode];
        if (c != 0){

            return c;

        }

    }
}


void getInput(char* buf){   
    int idx = 0;
    //putc('>',0x05);
    while (1){
        char c = getKey();
        if (c == '\r'){
            buf[idx] = '\0';
            //putc('\n',0x05);
            return;
        }else{
            if (c == '\b'){
                if (idx > 0){
                    idx--;
                    buf[idx] = 0;
                    textX -= 2;
                    cursorX--;
                    if (textX <= -1){
                        textY--;
                        textX = 80*2;
                        cursorY--;
                        cursorX = 81;
                    }
                    setVideo(textX,textY,' ');
                }
            }else{
                buf[idx] = c;
                putc(c, 0x0f);
                idx++;
            }
        }
    }

}

int streq(const char* s, const char* s2){
    for (int i = 0; sizeof(s); i++){
        if (s[i] != s2[i]){
            return 0;
        }
        if (s[i] == '\0'){
            return 1;
        }
    } 
    return 1;

}