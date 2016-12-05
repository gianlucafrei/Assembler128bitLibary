;  Executable name : testlonglong.o
;  Version         : 0.1
;  Created date    : 24.11.2016
;  Last update     : -
;  Author          : Gian-Luca Frei
;  Description     : This program executes some tests of the
;                    mylongintlib-libary
;
;  Run it this way:
;    name < (input file)
;
;
SECTION .bss			; Section containing uninitialized data

X: resb 16
Y: resb 16
Z: resb 16
R: resb 16
S: resb 16
T: resb 16

SECTION .data			; Section containing initialised data

MsgX: db "X: "
MsgY: db "Y: "
MsgZ: db "Z: "
MsgR: db "R: "
MsgS: db "S: "
MsgT: db "T: "
MsgLen equ 3

MsgAddXY: db "*** X = X + Y",10
MsgAddXYLen equ $-MsgAddXY
MsgSubXY: db "*** X = X - Y",10
MsgSubXYLen equ $-MsgSubXY
MsgSubRS: db "*** R = R - S",10
MsgSubRSLen equ $-MsgSubRS
MsgMulTZ: db "*** T = T * Z",10
MsgMulTZLen equ $-MsgMulTZ

SECTION .text			; Section containing code

extern readlonglong
extern writelonglong
extern copylonglong
extern addition
extern subtraction
extern multiplication

global 	_start			; Linker needs this to find the entry point!

;This macro prints a string 
%macro printstr 2
push rdx
push rax
push rdi
push rsi
mov rdx, %2          ; lenght of the string
mov rax, 1           ; Sys write
mov rdi, 1           ; file descriptor standart-output
mov rsi, %1  		 ; adress of the buffer
syscall
pop rsi
pop rdi
pop rax
pop rdx
%endmacro

%macro callsub 2
	mov rdi, %1
	mov rsi, %2
	call subtraction
%endmacro
%macro calladd 2
	mov rdi, %1
	mov rsi, %2
	call addition
%endmacro
%macro callcp 2
	mov rdi, %1
	mov rsi, %2
	call copylonglong
%endmacro
%macro callwrite 1
	mov rdi, %1
	call writelonglong
%endmacro
%macro callmul 2
	mov rdi, %1
	mov rsi, %2
	call multiplication
%endmacro

%macro debug 0
;DEBUG: Print R
	mov rdi, R
	call writelonglong
	;DEBUG: Print S
	mov rdi, S
	call writelonglong
	;DEBUG: Print T
	mov rdi, T
	call writelonglong
%endmacro
_start:
	nop

	;Ask for X
	printstr MsgX, MsgLen
	mov rdi, X
	call readlonglong
	;Ask for Y
	printstr MsgY, MsgLen
	mov rdi, Y
	call readlonglong
	;Ask for Z
	printstr MsgZ, MsgLen
	mov rdi, Z
	call readlonglong

	; Copy X to R
	callcp X, R
	; Copy Y to S
	callcp Y, S
	; Copy Z to T
	callcp Z, T
	

	; X = X + Y
	calladd X, Y
	printstr MsgAddXY, MsgAddXYLen
	printstr MsgX, MsgLen
	callwrite X
	printstr MsgY, MsgLen
	callwrite Y
	; X = X - Y
	callsub X, Y
	printstr MsgSubXY, MsgSubXYLen
	printstr MsgX, MsgLen
	callwrite X
	printstr MsgY, MsgLen
	callwrite Y
	; R = R - S
	callsub R, S
	printstr MsgSubRS, MsgSubRSLen
	printstr MsgR, MsgLen
	callwrite R
	printstr MsgS, MsgLen
	callwrite S
	; T = T * Z
	callmul T, Z
	printstr MsgMulTZ, MsgMulTZLen
	printstr MsgT, MsgLen
	callwrite T
	printstr MsgZ, MsgLen
	callwrite Z

	nop
; All done! Let's end this party:
Done:
	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero
	int 80H			; Make kernel call
