.PHONY= doc clean

CC=g++
OPTIONS= -g 
DEBUG= #-D DEBUG
LIBDIR=lib
INCLUDEDIR=include
_OBJ= tcalendario.o tvectorcalendario.o tlistacalendario.o



OBJ = $(patsubst %,$(LIBDIR)/%,$(_OBJ))

tad:    src/main.cpp $(OBJ)
	$(CC) $(OPTIONS) $(DEBUG) -I$(INCLUDEDIR) src/main.cpp $(OBJ) -o tad

$(LIBDIR)/%.o : $(LIBDIR)/%.cpp $(INCLUDEDIR)/%.h
	$(CC) $(OPTIONS) $(DEBUG) -c -I$(INCLUDEDIR) -o $@ $<

doc:
	doxygen

clean:
	rm -f $(OBJ) 

tar:
	tar czvf entrega.tgz nombres.txt lib/tcalendario.cpp lib/tvectorcalendario.cpp lib/tlistacalendario.cpp include/tcalendario.h include/tvectorcalendario.h include/tlistacalendario.h src/main.cpp

test: $(OBJ) 
	./tad > compare.txt

comp:
	cmp compare.txt compare2.txt
