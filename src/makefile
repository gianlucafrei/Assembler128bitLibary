testlonglong: testlonglong.o mylongintlib.o
	ld -o testlonglong testlonglong.o mylongintlib.o
testlonglong.o: testlonglong.asm
	nasm -f elf64 -g -F stabs testlonglong.asm
mylongintlib.o: mylongintlib.asm
	nasm -f elf64 -g -F stabs mylongintlib.asm
