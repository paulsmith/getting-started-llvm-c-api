CC=clang
CXX=clang++

all: sum

sum.o: sum.c
	$(CC) -g `llvm-config --cflags` -c $<

sum: sum.o
	$(CXX) `llvm-config --cxxflags --ldflags --libs core executionengine jit interpreter analysis native bitwriter --system-libs` $< -o $@

sum.bc: sum
	./sum 0 0

sum.ll: sum.bc
	llvm-dis $<

clean:
	-rm -f sum.o sum sum.bc sum.ll
