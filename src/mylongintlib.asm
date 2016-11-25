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

SECTION .data			; Section containing initialised data

SECTION .text			; Section containing code

linefeed equ 10
nochar equ 0

global readlongint
%macro movlonginttomemory 3
  mov [%3], %1
  mov [%3 + 8], %2
%endmacro

;-------------------------------------------------------------------------------
; Reads the next long int from the stdin and writes it to the memory at rdi
; Needs the inout in format fffffffff with a linefeed at the end
;                           ^ the moste signifikant byte
; The input should not be greater than 32 chars. If so, it will be cutted of and
; there may be some errors with the input buffer.
; 
readlongint:
  push rax
  push rbx
  push rcx
  push rsi
  push r8
  push r9
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
  pop r9
  pop r8
  pop rsi
  pop rcx
  pop rbx
  pop rax
  ret
; Decodechar: The char to decode must be stored in al
; It will be added to r8;r9
decodechar:
  ;Transform the char to a number 4 bit 0-15
  ; Asci values 0 = 48
  ;             a = 97
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
