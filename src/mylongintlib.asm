;  Executable name : mylongintlib.o
;  Version         : 0.1
;  Created date    : 24.11.2016
;  Last update     : -
;  Author          : Gian-Luca Frei
;  Description     : A libary whitch provides basic function
;                    for 128bit integer arithmetics.
;
;  Build using these commands:
;    nasm -f elf64 -g -F stabs name.asm
;


SECTION .bss			; Section containing uninitialized data

inputbufflen equ 32
inputbuff: resb inputbufflen
outputbufflen equ 33
outputbuff: resb outputbufflen

SECTION .data			; Section containing initialised data

charencoding: db "0123456789abcdef"

SECTION .text			; Section containing code

linefeed equ 10
nochar equ 0
longlonglen equ 15

global readlonglong
global writelonglong

; Moves a long int from registers to  memory
; 1) low 64 bit 2) height 64bit 3) destination adress
%macro movlonginttomemory 3
  mov [%3], %1
  mov [%3 + 8], %2
%endmacro

; Moves a long int from memory in two registers
; 1) low 64 bit 2) height 64bit 3) destination adress
%macro movelonginttoregister 3
  mov %1, [%3]
  mov %2, [%3 + 8]
%endmacro

; Pushes some registers
%macro pushabcs89 0
push rax
push rbx
push rcx
push rsi
push r8
push r9
%endmacro

; pops the same registers
%macro popabcs89 0
pop r9
pop r8
pop rsi
pop rcx
pop rbx
pop rax
%endmacro
;-------------------------------------------------------------------------------
; writes a long int to the standart output stream
; in rdi must the adress of the number be saved
; it removes the trivial zeros befor a number
;
;
writelonglong:
pushabcs89
;some cleanup
xor rdx, rdx
xor r8, r8
xor r9, r9
; New go now from the most segnificent byte downwards and print each byte
; I dont like to have some zeros before the number, so i wont print them uninitialized
; the counter reached the first byte whitch isn't zero
; In rdx its stored if a 'not zero' is reached, 1 for true
mov rcx, longlonglen ;Move 15 to the counter
.numberlenghtloop:
mov r8b, byte [rdi + rcx] ;move the current byte in al
test r8b, r8b
jnz .bufferloop
loop .numberlenghtloop ;Decrement rcx and jump not zero
.bufferloop:
 ; now we have saved in rcx the position of the first non zero byte
 ; We should print the digits know
 ; copy the byte, then put the height 4 bits in r9, the others in r8
 mov r8b, byte [rdi + rcx]; move the char to r8b
 mov r9b, r8b  ;Copy the byte
 and r8b, 0fH
 shr r9b, 4
 ; put more signifikant 4 bit as a char in the output buffer
 add r9, charencoding ;calculate the adress
 mov r9b, [r9] ;get the char
 mov [outputbuff + rdx], r9b
 and r9, 00000000000000ffh
 inc rdx ;count of bytes in the output buffer
 ; put less signifikant 4 bit as a char in the output buffer
 add r8, charencoding ;calculate the adress
 mov r8b, [r8] ;get the char
 mov [outputbuff + rdx], r8b
 and r8, 00000000000000ffh
 inc rdx ;count of bytes in the output buffer
 dec rcx
 cmp rcx, 0
jnl .bufferloop
;add a linefeed to the buffer
mov [outputbuff + rdx], byte linefeed
;make syscall
inc rdx              ; lenght of the string
mov rax, 1           ; Sys write
mov rdi, 1           ; file descriptor standart-outpu
mov rsi, outputbuff  ; adress of the buffer
syscall
popabcs89
ret
;-------------------------------------------------------------------------------
; Reads the next long int from the stdin and writes it to the memory at rdi
; Needs the inout in format fffffffff with a linefeed at the end
;                           ^ the moste signifikant byte
; The input should not be greater than 32 chars. If so, it will be cutted of and
; there may be some errors with the input buffer.
;
readlonglong:
  pushabcs89
  ; Save the rdi register, for the syscall we need to override this.
  push rdi
  ; Reads the input with syscall
  mov rax, 0
  mov rdi, 0
  mov rsi, inputbuff
  mov rdx, inputbufflen
  syscall
  ; Get the length of the input by searching for a invalid char linefeed (10)
  mov rcx, 0 ; Loop counter
.loop:
  ;Calculate the adress of the current char
  mov rsi, inputbuff
  add rsi, rcx
  mov al, byte[rsi]
  mov bl, linefeed
  cmp al, bl  ;Check if the char is 10
  je .endfound
  call decodechar
  inc rcx     ;increment the counter
  ;Check loop condition
  cmp rcx, inputbufflen
  jne .loop   ;Loop end
.endfound:
  ;Save r8:r9 in memory and Return
  pop rdi ; <- in rdi we stored the destinantion index
  movlonginttomemory r8, r9, rdi
  popabcs89
  ret
; Decodechar: The char to decode must be stored in al
; It will be added to r8;r9
decodechar:
  ;Transform the char to a number 4 bit 0-15
  ; Asci values 0 = 48, a = 97
  sub al, 48 ;transform char to byte
  cmp al, 9  ;Check if its over 9
  jna .valid
  sub al, 39 ;correct a-f
.valid:
  ;The number value is know stored in al
  ;shift r8:r9 4 times, then insert al
  shl r8, 1
  rcl r9, 1
  shl r8, 1
  rcl r9, 1
  shl r8, 1
  rcl r9, 1
  shl r8, 1
  rcl r9, 1
  and al, 0fH
  add r8b, al
  ret
