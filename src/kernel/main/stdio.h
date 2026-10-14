typedef unsigned char      uint8_t;

typedef unsigned short     uint16_t;

typedef unsigned int       uint32_t;

typedef unsigned long long uint64_t;

void putc(char c, int color); // puts a character

void printf(const char *s, int color); // prints a string with a colour, im too lazy to actually implement printf so yeah

void setPort(uint8_t port,uint8_t value); // outb

void setPortW(uint16_t port, uint16_t value); // outw

static inline uint8_t readPort(uint8_t port); //inb

char getKey(void); // waits for key

void getInput(char* buf); // gets user input

void clearScreen(void);  //..pretty self explanatory

int streq(const char* s, const char* s2); // checks if 2 strings are equal, returns 1 if yes and 0 if no

void setCursor(int x, int y); // sets the cursor

void tostring(int n, char* str);