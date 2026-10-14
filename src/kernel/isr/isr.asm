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
    


isrErr 8
isrErr 10
isrErr 11
isrErr 12
isrErr 13
isrErr 14
isrErr 17
isrErr 21
isrErr 29
isrErr 30
isrNoErr 0
isrNoErr 1
isrNoErr 2
isrNoErr 3
isrNoErr 4
isrNoErr 5
isrNoErr 6
isrNoErr 7
isrNoErr 9
isrNoErr 15
isrNoErr 16
isrNoErr 18
isrNoErr 19
isrNoErr 20
isrNoErr 22
isrNoErr 23
isrNoErr 24
isrNoErr 25
isrNoErr 26
isrNoErr 27
isrNoErr 28
isrNoErr 31
isrNoErr 32
isrNoErr 33
isrNoErr 34
isrNoErr 35
isrNoErr 36
isrNoErr 37
isrNoErr 38
isrNoErr 39
isrNoErr 40
isrNoErr 41
isrNoErr 42
isrNoErr 43
isrNoErr 44
isrNoErr 45
isrNoErr 46
isrNoErr 47
isrNoErr 48
isrNoErr 49
isrNoErr 50
isrNoErr 51
isrNoErr 52
isrNoErr 53
isrNoErr 54
isrNoErr 55
isrNoErr 56
isrNoErr 57
isrNoErr 58
isrNoErr 59
isrNoErr 60
isrNoErr 61
isrNoErr 62
isrNoErr 63
isrNoErr 64
isrNoErr 65
isrNoErr 66
isrNoErr 67
isrNoErr 68
isrNoErr 69
isrNoErr 70
isrNoErr 71
isrNoErr 72
isrNoErr 73
isrNoErr 74
isrNoErr 75
isrNoErr 76
isrNoErr 77
isrNoErr 78
isrNoErr 79
isrNoErr 80
isrNoErr 81
isrNoErr 82
isrNoErr 83
isrNoErr 84
isrNoErr 85
isrNoErr 86
isrNoErr 87
isrNoErr 88
isrNoErr 89
isrNoErr 90
isrNoErr 91
isrNoErr 92
isrNoErr 93
isrNoErr 94
isrNoErr 95
isrNoErr 96
isrNoErr 97
isrNoErr 98
isrNoErr 99
isrNoErr 100
isrNoErr 101
isrNoErr 102
isrNoErr 103
isrNoErr 104
isrNoErr 105
isrNoErr 106
isrNoErr 107
isrNoErr 108
isrNoErr 109
isrNoErr 110
isrNoErr 111
isrNoErr 112
isrNoErr 113
isrNoErr 114
isrNoErr 115
isrNoErr 116
isrNoErr 117
isrNoErr 118
isrNoErr 119
isrNoErr 120
isrNoErr 121
isrNoErr 122
isrNoErr 123
isrNoErr 124
isrNoErr 125
isrNoErr 126
isrNoErr 127
isrNoErr 128
isrNoErr 129
isrNoErr 130
isrNoErr 131
isrNoErr 132
isrNoErr 133
isrNoErr 134
isrNoErr 135
isrNoErr 136
isrNoErr 137
isrNoErr 138
isrNoErr 139
isrNoErr 140
isrNoErr 141
isrNoErr 142
isrNoErr 143
isrNoErr 144
isrNoErr 145
isrNoErr 146
isrNoErr 147
isrNoErr 148
isrNoErr 149
isrNoErr 150
isrNoErr 151
isrNoErr 152
isrNoErr 153
isrNoErr 154
isrNoErr 155
isrNoErr 156
isrNoErr 157
isrNoErr 158
isrNoErr 159
isrNoErr 160
isrNoErr 161
isrNoErr 162
isrNoErr 163
isrNoErr 164
isrNoErr 165
isrNoErr 166
isrNoErr 167
isrNoErr 168
isrNoErr 169
isrNoErr 170
isrNoErr 171
isrNoErr 172
isrNoErr 173
isrNoErr 174
isrNoErr 175
isrNoErr 176
isrNoErr 177
isrNoErr 178
isrNoErr 179
isrNoErr 180
isrNoErr 181
isrNoErr 182
isrNoErr 183
isrNoErr 184
isrNoErr 185
isrNoErr 186
isrNoErr 187
isrNoErr 188
isrNoErr 189
isrNoErr 190
isrNoErr 191
isrNoErr 192
isrNoErr 193
isrNoErr 194
isrNoErr 195
isrNoErr 196
isrNoErr 197
isrNoErr 198
isrNoErr 199
isrNoErr 200
isrNoErr 201
isrNoErr 202
isrNoErr 203
isrNoErr 204
isrNoErr 205
isrNoErr 206
isrNoErr 207
isrNoErr 208
isrNoErr 209
isrNoErr 210
isrNoErr 211
isrNoErr 212
isrNoErr 213
isrNoErr 214
isrNoErr 215
isrNoErr 216
isrNoErr 217
isrNoErr 218
isrNoErr 219
isrNoErr 220
isrNoErr 221
isrNoErr 222
isrNoErr 223
isrNoErr 224
isrNoErr 225
isrNoErr 226
isrNoErr 227
isrNoErr 228
isrNoErr 229
isrNoErr 230
isrNoErr 231
isrNoErr 232
isrNoErr 233
isrNoErr 234
isrNoErr 235
isrNoErr 236
isrNoErr 237
isrNoErr 238
isrNoErr 239
isrNoErr 240
isrNoErr 241
isrNoErr 242
isrNoErr 243
isrNoErr 244
isrNoErr 245
isrNoErr 246
isrNoErr 247
isrNoErr 248
isrNoErr 249
isrNoErr 250
isrNoErr 251
isrNoErr 252
isrNoErr 253
isrNoErr 254
isrNoErr 255isrCommon:
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
