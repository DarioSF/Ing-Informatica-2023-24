#ifndef _TLISTACALENDARIO_H_
#define _TLISTACALENDARIO_H_

#include <iostream>

using namespace std;

class TNodoCalendario{

	friend ostream & operator<<(ostream *, TListaCalendario &);
	private:
		TNodoCalendario *primero;
	public:
		TListaCalendario();
		TListaCalendario(TListaCalendario &);
		~TListaCalendario();
		TListaCalendario & operator=(TListaCalendario &);
		bool operator==(TListaCalendario &);
		TListaCalendario operator+ (TListaCalendario &);
		TListaCalendario operator- (TListaCalendario &);
		bool Insertar(TCalendario &);
		bool Borrar(TCalendario &);
		bool Borrar(TListaPos &);
		bool Borrar(int, int, int);
		bool EsVacia();
		TCalendario Obtener(TListaPos &);
		bool Buscar(TCalendario &);
		int Longitud();
		TListaPos Primera();
		TListaPos Ultima();
		TListaCalendario SumarSubl(int I_L1, int F_L1, TListaCalendario & L2, int I_L2, int F_L2);
		TListaCalendario ExtraerRango(int n1, int n2);
};
#endif