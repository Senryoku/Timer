CXX = g++
OBJ = obj/
SRC = src/
BIN = bin/
BINARY = Main
TESTS = tests/
POINTC = $(wildcard $(SRC)*/*.c) $(wildcard $(SRC)*.c) 
POINTCPP = $(wildcard $(SRC)*/*.cpp) $(wildcard $(SRC)*.cpp) 
POINTOP := $(POINTC:.c=.o) $(POINTCPP:.cpp=.o)
POINTO = $(patsubst $(SRC)%,$(OBJ)%,$(POINTOP))

OPT := -std=c++11 -Wall -I "$(SRC)"

ifeq ($(SHELL), sh.exe) 
OS := Win
else
OS := $(shell uname)
endif

ifeq ($(OS), Linux)
RM = rm
LIBS := 
endif
ifeq ($(OS), Darwin)
RM = rm
LIBS := 
endif
ifeq ($(OS), Win)
RM = del
LIBS := 
endif

all : run

.PHONY : dirs

windirs :
	mkdir bin
	mkdir obj
	mkdir doc
.PHONY : windirs

$(OBJ)%.o : $(SRC)%.cpp
	@echo --------------------------------------------------------------------------------
	@echo  [ Compilation of $^ ]
	@$(CXX) $(OPT) $^ -c -o $@
	@echo --------------------------------------------------------------------------------
	

run : $(BINARY)
ifeq ($(OS), Win)
	$(BIN)$(BINARY)
else
	./$(BIN)$(BINARY)
endif
.PHONY : run

$(BINARY) : $(POINTO)
	@echo --------------------------------------------------------------------------------
	@echo  [ Linking $@ ]
	$(CXX) $(OPT) $^ -o $(BIN)$@ $(LIBS)
	@echo --------------------------------------------------------------------------------
	
valgrind : $(BINARY)
	valgrind --leak-check=full --tool=memcheck ./$(BIN)$(BINARY)
.PHONY : valgrind


clean:
	$(RM) $(POINTO) $(BIN)$(BINARY)
.PHONY : clean

doc:
	doxygen Doxyfile
.PHONY : doc

