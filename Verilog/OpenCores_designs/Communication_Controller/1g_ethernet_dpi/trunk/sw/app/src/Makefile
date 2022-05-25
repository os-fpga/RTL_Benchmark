#
# makefile
#

#
# TBD
#

TARGET = libethlc.a

all: $(TARGET)

CC = g++ -xc
CPP= g++ -xc++
LD = g++
AR = ar cqs
DEFAULT_CP := cp -f
DEFAULT_MKDIR := mkdir -p
DEFAULT_RM := rm -rf

INCDIR := ./ 

INCLUDE := $(addprefix -I, $(INCDIR))
CFLAGS := -g
CFLAGS += $(INCLUDE)

OBJ_DIR := obj
OBJECTS := ethlc.o 
OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(OBJECTS))

$(OBJ_DIR)/%.o: %.cpp
	$(CPP) -c $(CFLAGS) -o $@ $<

$(TARGET): prep $(OBJ_FILES) 
	$(AR) $(TARGET) $(OBJ_FILES)
	@echo DONE: AR

prep: clean
	$(DEFAULT_MKDIR) $(OBJ_DIR)

clean:
	$(DEFAULT_RM) $(OBJ_DIR)
	$(DEFAULT_RM) $(TARGET)
