#---------------------------------------
# SYSTEMC Makefile
# Write by MS.slump
#---------------------------------------


SYSTEMC		= /usr/local/systemc/systemc-2.2.0
INC_DIRS	= -I$(SYSTEMC)/include 
LIB_DIRS	= -L$(SYSTEMC)/lib-linux

CC		= g++
CFLAGS	= -Wall -g 
CFLAGS += -DROUTER_DEBUG
#CFLAGS += -DCORE_DEBUG -DROUTER_DEBUG
#CFLAGS += -DCORE_DEBUG
#CFLAGS += -DFIFO_DEBUG
#CFLAGS	+= -DCORE_RECEIVE_DEBUG
#CFLAGS	+= -DCORE_TRANSMIT_DEBUG
LIBS 	= -lsystemc


TARGET = onoc

OBJECTS = fifo.o \
		  router.o \
		  core.o \
		  power_model.o \
		  photonic_sw.o \
		  noc.o \
		  top.o

default: $(TARGET)

clean:
	@rm $(OBJECTS) $(TARGET)

$(TARGET): $(OBJECTS)
	@$(CC) $(LIB_DIRS) -o $(TARGET) $(OBJECTS) $(LIBS) 

fifo.o:fifo.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

core.o:core.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

router.o:router.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

photonic_sw.o:photonic_sw.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

power_model.o:power_model.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

noc.o:noc.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

top.o:top.cc
	@$(CC) $(INC_DIRS) -c $(CFLAGS) $< -o $@

