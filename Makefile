.PHONY: build test runmain_rpath runmain1 runmain1_ld_library_path clean

test: runmain_rpath runmain1 runmain1_ld_library_path

runmain_rpath: build
	./main
	@echo "------"

runmain1: build
	./main1
	@echo "------"

runmain1_ld_library_path: build
	LD_LIBRARY_PATH=. ./main1
	@echo "------"

build: impl.so main main1

main: main.o intf.a
	gcc -Wl,-rpath=${CURDIR} $^ -o $@

main1: main.o intf.a
	gcc $^ -o $@

main.o: main.c
	gcc -c -ggdb -o $@ $^

intf.a: intf.o
	ar rcs $@ $^

intf.o: intf.c intf.h
	gcc -c $< -ggdb -o $@

impl.so: impl.o
	gcc -shared -o $@ -Wl,-soname,$@ $^

impl.o: impl.c impl.h
	gcc -fPIC -ggdb -c $< -o $@

clean:
	rm -f *.o intf.a impl.so main main1
