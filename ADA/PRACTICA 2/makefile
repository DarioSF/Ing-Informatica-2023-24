#	74392984J DARIO SIMON FRANCO

OPTS = -Wall -O3 -std=c++0x

#	COMPILACION
qs-vs-hs:
	g++ ${OPTS} -o qs-vs-hs qs-vs-hs.cc

#	GUARDAR SALIDA
qs-vs-hs.Msteps: qs-vs-hs
	./qs-vs-hs > qs-vs-hs.Msteps

#	GNUPLOT
graps: qs-vs-hs.Msteps qs-vs-hs.gnuplot
	gnuplot qs-vs-hs.gnuplot

all: qs-vs-hs qs-vs-hs.Msteps graphs
