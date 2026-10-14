local startOfIsr = [[
;!!THIS FILE HAS BEEN AUTOGENERARED USING THE root/createIsrAsm.lua FILE!!;

[bits 32]
align   4

%macro isrNoErr 1

global isr%1:
isr%1
    push 0
    push %1
    jmp isr_common
%endmacro


%macro isrErr 1

global isr%1:
isr%1
    push %1
    jmp isr_common
%endmacro
    

]]

local endOfIsr = [[
isrCommon:
    pusha
    xor eax, eax
    mov ax, ds
    push eax
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    push esp
    call isrHandler

    add esp, 4

    pop eax
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    popa
    
    add esp, 8
    iret
]]

local finalFile = startOfIsr

local function createErrorLabels()
    local a = "";
    local i = 0x08
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x0a
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x0b
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x0c
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x0d
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x0e
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x11
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x15
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x1d
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
    i = 0x1e
    a = "\nisrErr " .. tostring(i) 
    finalFile = finalFile .. a
end

local function createLabels()
    local a = "";
    for i = 0, 255 do
        a = ""
        if not (i == 0x08 or i == 0x0a or i == 0x0b or i == 0x0c or i == 0x0d or i == 0x0e or i == 0x11 or i == 0x15 or i == 0x1d or i == 0x1e) then
            a = "\nisrNoErr " .. tostring(i)
        end
        finalFile = finalFile .. a
    end



end





createErrorLabels()

createLabels()

finalFile = finalFile .. endOfIsr

--print(finalFile)  
local file = io.open("src/kernel/isr/isr.asm", 'w');

if not file then warn("file doesnt exist, creating..") end

file:write(finalFile)

file:close()