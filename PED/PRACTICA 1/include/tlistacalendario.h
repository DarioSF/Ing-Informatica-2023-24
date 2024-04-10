#ifndef _TLISTACALENDARIO_H_
#define _TLISTACALENDARIO_H_

#include "tvectorcalendario.h"

using namespace std;

class TNodoCalendario{

	friend class TListaPos;
	friend class TListaCalendario;
	private:
		TCalendario c;
		TNodoCalendario *siguiente;
	public:
		TNodoCalendario();
		TNodoCalendario(const TNodoCalendario &);
		~TNodoCalendario();
		TNodoCalendario & operator=(const TNodoCalendario &);
};

class TListaPos{

	friend class TNodoCalendario;
	friend class TListaCalendario;
	private:
		TNodoCalendario *pos;
	public:
		TListaPos();
		TListaPos(const TListaPos &);
		~TListaPos();
		TListaPos & operator=(const TListaPos &);
		bool operator==(const TListaPos &);
		bool operator!=(const TListaPos &);
		TListaPos Siguiente() const;
		bool EsVacia() const;
};

class TListaCalendario{

	friend class TNodoCalendario;
	friend class TListaPos;
	friend ostream & operator<<(ostream &, const TListaCalendario &);
	private:
		TNodoCalendario *primero;
	public:
		TListaCalendario();
		TListaCalendario(const TListaCalendario &);
		~TListaCalendario();
		TListaCalendario & operator=(const TListaCalendario &);
		bool operator==(TListaCalendario &);
		TListaCalendario operator+(TListaCalendario &);
		TListaCalendario operator-(TListaCalendario &);
		bool Insertar(const TCalendario &);
		bool Borrar(const TCalendario &);
		bool Borrar(const TListaPos &);
		bool Borrar(int, int, int);
		bool EsVacia() const;
		TCalendario Obtener(TListaPos &) const;
		bool Buscar(TCalendario &) const;
		int Longitud() const;
		TListaPos Primera() const;
		TListaPos Ultima() const ;
		TListaCalendario SumarSubl(int I_L1, int F_L1, TListaCalendario & L2, int I_L2, int F_L2);
		TListaCalendario ExtraerRango(int n1, int n2);
};
#endif