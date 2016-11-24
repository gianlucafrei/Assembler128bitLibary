testlonglong: testlonglong.o mylongintlib.o
	ld -o ../bin/testlonglong testlonglong.o mylongintlib.o
	mv testlonglong.o ../bin/testlonglong.o
	mv mylongintlib.o ../bin/mylongintlib.o
testlonglong.o: testlonglong.asm
	nasm -f elf64 -g -F stabs testlonglong.asm
mylongintlib.o: mylongintlib.asm
	nasm -f elf64 -g -F stabs mylongintlib.asm
