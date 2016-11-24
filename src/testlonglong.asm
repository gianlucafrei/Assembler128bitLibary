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

SECTION .data			; Section containing initialised data

SECTION .text			; Section containing code

global 	_start			; Linker needs this to find the entry point!

_start:

	nop



; All done! Let's end this party:
Done:
	mov eax,1		; Code for Exit Syscall
	mov ebx,0		; Return a code of zero
	int 80H			; Make kernel call
