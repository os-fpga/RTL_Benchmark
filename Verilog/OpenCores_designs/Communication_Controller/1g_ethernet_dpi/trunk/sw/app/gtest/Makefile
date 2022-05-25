#
# makefile
#

TARGET = gtest_vtest

all: $(TARGET)

CC = g++ -xc
CPP= g++ -xc++
LD = g++
OBJDUMP = objdump
DEFAULT_CP := cp -f
DEFAULT_MKDIR := mkdir -p
DEFAULT_RM := rm -rf
LIBRARIES := -lgtest -lpthread -L../src -lethlc

INCDIR := ./ \
 ../src
INCLUDE := $(addprefix -I, $(INCDIR))
CFLAGS += -g
CFLAGS += $(INCLUDE)

OBJ_DIR       = obj
OBJECTS       = gtest_unittest.o \
		gtest_0.o \
		gtest_1.o

OBJ_FILES := $(addprefix $(OBJ_DIR)/, $(OBJECTS))

$(TARGET): prep $(OBJ_FILES) 
	$(LD) $(LFLAGS) -o $(TARGET) $(OBJ_FILES) $(LIBRARIES)
	@echo DONE: app

$(OBJ_DIR)/%.o: %.cpp
	$(CPP) -c $(CFLAGS) -o $@ $<

prep:
	make all -C ../src
	$(DEFAULT_RM) $(OBJ_DIR)
	$(DEFAULT_MKDIR) $(OBJ_DIR)

clean:
	make clean -C ../src
	$(DEFAULT_RM) $(OBJ_DIR)
	$(DEFAULT_RM) $(TARGET)
