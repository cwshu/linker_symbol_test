all: main_both main_libadd main_arithmetic

clean:
	rm -f main_* *.so *.o *.a

## run test rules

test_no_libpath: main_both main_libadd main_arithmetic
	-./main_both
	echo ""
	-./main_libadd
	echo ""
	-./main_arithmetic
	echo ""

test_ltrace: main_both main_libadd main_arithmetic
	LD_LIBRARY_PATH=`pwd` ltrace ./main_both
	echo ""
	LD_LIBRARY_PATH=`pwd` ltrace ./main_libadd
	echo ""
	LD_LIBRARY_PATH=`pwd` ltrace ./main_arithmetic
	echo ""

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

main_both: main.c libadd.so arithmetic.o
	clang -o main_both main.c libadd.so arithmetic.o

