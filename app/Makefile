CC=$(CROSS_COMPILE)g++

top_srcdir=$(SRC_DIR)/cpp/src/

INCLUDES:= -I $(top_srcdir) -I $(top_srcdir)command_classes -I $(top_srcdir)platform -I $(top_srcdir)value_classes
LIBS:= -lopenzwave -lpthread -ludev
LDFLAGS += -L$(SRC_DIR) -Wl,-R$(SRC_DIR) '-Wl,-R$$ORIGIN'

all:	ozw

ozw: Main.cpp
	$(CC) $(INCLUDES) -c Main.cpp -o ozw-power-on-off.o
	$(CC) $(LIBS) $(LDFLAGS) ozw-power-on-off.o -o ozw-power-on-off.out

clean:
	rm -rf *.o *.out
