typedef struct{
    uint32_t ds;
    uint32_t edi;
    uint32_t esi;
    uint32_t ebp;
    uint32_t kern_esp;
    uint32_t ebx;
    uint32_t edx;
    uint32_t ecx;
    uint32_t eax;
    uint32_t int, error;
    uint32_t eip, cs, eflag, esp, ss;
    

}__attribute__((packed)) reg;