
#Makefile task 4

Program: obj/main.o obj/Product.o obj
	g++-9 -o bin/Program obj/main.o obj/Product.o

obj/main.o: src/main.cpp
	g++-9 -o obj/main.o -c src/main.cpp

obj/Product.o:
	g++-9 -o obj/Product.o -c src/Product.cpp

clean:
	rm -rf obj/*.o bin/Program
