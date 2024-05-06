#74392984J Dario Simon Franco
.PHONY= doc clean

CC=g++
OPTIONS= -g 
DEBUG= #-D DEBUG
LIBDIR=lib
INCLUDEDIR=include
_OBJ= tcalendario.o tvectorcalendario.o tabbcalendario.o



OBJ = $(patsubst %,$(LIBDIR)/%,$(_OBJ))

tad:    src/main.cpp $(OBJ)
	$(CC) $(OPTIONS) $(DEBUG) -I$(INCLUDEDIR) src/main.cpp $(OBJ) -o tad

$(LIBDIR)/%.o : $(LIBDIR)/%.cpp $(INCLUDEDIR)/%.h
	$(CC) $(OPTIONS) $(DEBUG) -c -I$(INCLUDEDIR) -o $@ $<

doc:
	doxygen

clean:
	rm -f $(OBJ) *tgz

tar:
	tar czvf entrega.tgz lib/tcalendario.cpp lib/tvectorcalendario.cpp lib/tabbcalendario.cpp include/tcalendario.h include/tvectorcalendario.h include/tabbcalendario.h src/main.cpp

test: $(OBJ) 
	./tad > compare.txt

comp:
	cmp compare.txt compare2.txt
