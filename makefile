all: main_all main_libadd main_arithmetic

clean:
	rm -f main_* *.so *.o *.a

## compile rules

add.o: add.c
	clang -fPIC -c -o add.o add.c

libadd.so: add.o
	clang -shared -fPIC -o libadd.so add.o

arithmetic.o: arithmetic.c
	clang -c -o arithmetic.o arithmetic.c 

main_arithmetic: main.c arithmetic.o
	clang -o main_arithmetic main.c arithmetic.o

main_libadd: main.c libadd.so
	clang -o main_libadd main.c libadd.so

main_all: main.c libadd.so arithmetic.o
	clang -o main_all main.c libadd.so arithmetic.o

