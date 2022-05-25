#
# makefile
#

#
# TBD
#

TARGET_NAME = test_bfm

all: clean $(TARGET_NAME)

CC = g++ -xc
CPP= g++ -xc++
LD = g++
OBJDUMP = objdump 
DEFAULT_CP := cp -f
DEFAULT_MKDIR := mkdir -p
DEFAULT_RM := rm -rf

MSIM_INCLUDES ?= /opt/modelsim/modeltech/include

INCDIR := ./ \
 $(MSIM_INCLUDES) \
 ./dpi \
 ./ether 

INCLUDE := $(addprefix -I, $(INCDIR))
CFLAGS := -DMSIM 
CFLAGS := -g
CFLAGS += $(INCLUDE)

C_SRCS := $(wildcard *.c)
C_SRCS += $(wildcard ./ether/*.c)

OBJFILE_C := $(patsubst %.c,%.o, $(C_SRCS))

$(TARGET_NAME): $(OBJFILE_C)
	echo $(MSIM_INCLUDES)
	@echo C_SRCS: $(C_SRCS)
	$(LD) -shared -o $(TARGET_NAME).so $(notdir $^) $(LFLAGS) $(LIBRARIES)
	$(OBJDUMP) -S -d $(TARGET_NAME).so > $(TARGET_NAME).objdump
	rm -f *.o *~ core
	rm -f *.d *~ core
	@echo DONE: DPI-C so-lib

%.o: %.c
	@echo Compiling $<:
	$(CC) $(CFLAGS) $(LIBRARIES) -fPIC -c $<

clean:
	@echo clean:
	$(DEFAULT_RM) *.o *~ core
	$(DEFAULT_RM) *.d *~ core
	$(DEFAULT_RM) *.objdump
	$(DEFAULT_RM) *.pcap
	$(DEFAULT_RM) $(TARGET_NAME).so
