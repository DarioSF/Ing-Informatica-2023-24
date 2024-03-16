#	74392984J DARIO SIMON FRANCO

OPTS := -Wall -O3 -std=c++0x

#	BUILD COMPLETA
all: pow2 pow2.Steps graphs

#	COMPILACION
pow2: 
	g++ ${OPTS} -o pow2 pow2.cc

#	STATS
pow2.Steps: pow2
	./pow2 > pow2.Steps

#	GNUPLOT
graphs: pow2.gpi pow2.Steps
	gnuplot pow2.gpi

#	LIMPIAR CARPETA
clean: 
	rm -f pow2 pow2.Steps pow2.png

#	COMPRIMIR
tar: pow2.cc pow2.gpi makefile
	tar cvfz 74392984J.tar.gz pow2.cc pow2.gpi makefile
