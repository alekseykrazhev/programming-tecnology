
#Makefile for TP project

Program: obj/main.o obj/PRODUCT.o
	g++-9 -o bin/Program obj/main.o obj/PRODUCT.o

obj/main.o: src/main.cpp
	g++-9 -o obj/main.o -c src/main.cpp

obj/PRODUCT.o: src/PRODUCT.cpp
	g++-9 -o obj/PRODUCT.o -c src/PRODUCT.cpp

clean:
	rm -rf obj/*.o bin/Program
