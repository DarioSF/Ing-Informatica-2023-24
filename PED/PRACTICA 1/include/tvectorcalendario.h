#ifndef _TVECTORCALENDARIO_H_
#define _TVECTORCALENDARIO_H_

#include <iostream>

using namespace std;

class TVectorCalendario{

	friend ostream & operator<<(ostream &, TVectorCalendario &);
	private:
		TCalendario *c;
		int tamano;
		TCalendario error;
	public:
		TVectorCalendario();
		TVectorCalendario(int);
		TVectorCalendario(TVectorCalendario &);
		~TVectorCalendario();
		TVectorCalendario & operator=(TVectorCalendario &);
		bool operator==(const TVectorCalendario &);
		bool operator!=(const TVectorCalendario &);
		//TCalendario & operator[](int);
		//TCalendario operator[](int) const;
		int Tamano();
		int Ocupadas();
		bool ExisteCal(const TCalendario &);
		/*void MostrarMensajes(int, int, int);
		/*bool Redimensionar(int);*/
};

#endif