all: compile

compile: 	one.o two.o three.o
					gcc one.o two.o three.o

one.o : 	one.c
					gcc -c one.c

two.o : 	two.c
					gcc -c two.c

three.o : three.c
					gcc -c three.c

clean:
					rm *.o
