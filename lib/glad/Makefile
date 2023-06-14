
CC = gcc
CFLAGS = -g -Wall -Wextra -O3

.PHONY: all clean

all: gl.o

gl.o: src/gl.c
	$(CC) -c src/gl.c -Iinclude $(CCFLAGS) -o gl.o

clean:
	RM = rm -f gl.o

