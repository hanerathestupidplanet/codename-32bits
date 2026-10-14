cls
rm -rf build
mkdir build



nasm -f bin src/bootloader/boot.asm -o build/boot.bin

nasm -f elf src/kernel/kernelEntry.asm -o build/kernelEntry.o

./crossCompiler/bin/i386-elf-gcc -ffreestanding -m32 -g -c "src/kernel/kernel.cpp" -o "build/Krnl.o"
./crossCompiler/bin/i386-elf-g++ -ffreestanding -m32 -g -c "src/kernel/stdio.cpp" -o "build/stdio.o"
./crossCompiler/bin/i386-elf-g++ -ffreestanding -m32 -g -c "src/fun/brainfuck.cpp" -o "build/brainfuck.o"
./crossCompiler/bin/i386-elf-ld -o "build/kernel.bin" -Ttext 0x1000 "build/kernelEntry.o" "build/Krnl.o" "build/stdio.o" "build/brainfuck.o" --oformat binary
rm -f build/os.bin
cat build/boot.bin build/kernel.bin > build/os.bin

qemu-system-x86_64 build/os.bin
