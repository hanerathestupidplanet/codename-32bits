# paths
bld = build
src = src
krnlPath = $(src)/kernel
krnlIdt = $(krnlPath)/idt
krnlMain = $(krnlPath)/main
krnlIsr = $(krnlPath)/isr
krnlFun = $(krnlPath)/fun

comp = ../crossCompiler/bin/i386-elf-g++
link = ../crossCompiler/bin/i386-elf-ld 
asm = nasm

# flags
asmBoot = -f bin -o 
asmKrnl = -f elf -o 
compFlag = -ffreestanding -m32 -g -c -o
linkFlag = -Ttext 0x1000 --oformat binary -o


# boot asm file
boot = $(src)/bootloader/boot.asm

# kernel shit
idtAsm = $(krnlIdt)/idt.asm
idtCpp = $(krnlIdt)/idt.cpp

bfCpp = $(krnlFun)/brainfuck.cpp

krnlEntry = $(krnlMain)/kernelEntry.asm
krnlStdio = $(krnlMain)/stdio.cpp
krnlMainCpp = $(krnlMain)/main.cpp

# build filenames
bootBuilt = $(bld)/boot/boot.bin

krnlEntryBuilt = $(bld)/kernel/main/entry.o
krnlMainBuilt = $(bld)/kernel/main/main.o
krnlStdioBuilt = $(bld)/kernel/main/stdio.o
idtAsmBuilt = $(bld)/kernel/idt/idtAsm.o
idtCppBuilt = $(bld)/kernel/idt/idtC.o

bfCppBuilt = $(bld)/kernel/fun/bf.o

fullKrnl = $(bld)/fullKrnl.bin
os = $(bld)/os.bin



clean:
	rm -rf $(bld)
	mkdir $(bld)
	mkdir $(bld)/boot
	mkdir $(bld)/kernel
	mkdir $(bld)/kernel/main/
	mkdir $(bld)/kernel/idt/
	mkdir $(bld)/kernel/isr/
	mkdir $(bld)/kernel/fun/

#assembly files being built
	$(asm) $(asmBoot) $(bootBuilt) $(boot)
	$(asm) $(asmKrnl) $(krnlEntryBuilt) $(krnlEntry)
	$(asm) $(asmKrnl) $(idtAsmBuilt) $(idtAsm) 

#kernel files being build
	$(comp) $(compFlag) $(krnlMainBuilt) $(krnlMainCpp)
	$(comp) $(compFlag) $(krnlStdioBuilt) $(krnlStdio)
	$(comp) $(compFlag) $(idtCppBuilt) $(idtCpp)
	$(comp) $(compFlag) $(bfCppBuilt) $(bfCpp)
	$(link) $(linkFlag) $(fullKrnl) $(krnlEntryBuilt) $(krnlMainBuilt) $(krnlStdioBuilt) $(idtCppBuilt) $(idtAsmBuilt) $(bfCppBuilt)

# finally put the OS binary together
	cat $(bootBuilt) $(fullKrnl) > $(os)
	
