
PLATFORM = win64
EXECUTABLE_NAME = prog
EXECUTABLE_VERSION = 1.0.0
EXECUTABLE_SUFFIX = .exe
EXECUTABLE = $(EXECUTABLE_NAME)-$(EXECUTABLE_VERSION)$(EXECUTABLE_SUFFIX)

CC = gcc
RM = rm -f
RRM = rm -f -r
MAKE = mingw32-make

LIB_DIR = lib
BIN_DIR = bin
SRC_DIR = src
OBJ_DIR = $(BIN_DIR)/build
EXE_DIR = $(BIN_DIR)/$(PLATFORM)

SRC = $(shell find $(SRC_DIR) -type f -name '*.c')
OBJ = $(patsubst $(SRC_DIR)/%, $(OBJ_DIR)/%, $(SRC:%.c=%.o))

# https://en.wikipedia.org/wiki/Microsoft_Windows_library_files
WIN_API = -lopengl32 -lgdi32 -luser32 -lkernel32
INCLUDE = -I$(LIB_DIR)\glad\include -I$(LIB_DIR)\GLFW\include
CFLAGS  = -g -Wall -O3 $(INCLUDE)#Wextra
LDFLAGS = $(LIB_DIR)\glad\gl.o $(LIB_DIR)\GLFW\libglfw3.a $(WIN_API)


.PHONY: all clean

all: dirs libs build

dirs:
	mkdir -p $(SRC_DIR)
	mkdir -p $(LIB_DIR)
	mkdir -p $(OBJ_DIR)
	mkdir -p $(EXE_DIR)

libs:
	cd lib/glad && $(MAKE)


build: $(BIN_DIR)/$(PLATFORM)/$(EXECUTABLE)


$(BIN_DIR)/$(PLATFORM)/$(EXECUTABLE): $(OBJ)
	$(CC) -o $(BIN_DIR)/$(PLATFORM)/$(EXECUTABLE) $^ $(LDFLAGS)


$(OBJ_DIR)%.o: $(SRC_DIR)%.c
	$(CC) -o $@ -c $< $(CFLAGS)


run: all
	.\\$(BIN_DIR)/$(PLATFORM)/$(EXECUTABLE)


clean:
	cd $(LIB_DIR)/glad && $(MAKE) clean
	$(RRM) $(OBJ_DIR)
	$(RM) $(BIN_DIR)/$(PLATFORM)/$(EXECUTABLE)
