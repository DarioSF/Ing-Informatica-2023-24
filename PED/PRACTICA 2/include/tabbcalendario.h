//74392984J Dario Simon Franco
#ifndef _TABBCALENDARIO_H_
#define _TABBCALENDARIO_H_

#include <queue>
#include "tvectorcalendario.h"

using namespace std;

class TNodoABB;

class TABBCalendario{

	friend class TNodoABB;
	friend ostream & operator<<(ostream &, const TABBCalendario &);

	private:
		TNodoABB *raiz;
		//funciones auxiliares
		void InordenAux(TVectorCalendario &, int &) const;
		void PreordenAux(TVectorCalendario &, int &) const;
		void PostordenAux(TVectorCalendario &, int &) const;
		void VaciarNodo(TNodoABB *nodo);

	public:
		//forma canocnica
		TABBCalendario();
		TABBCalendario(const TABBCalendario &);
		~TABBCalendario();
		TABBCalendario & operator=(const TABBCalendario &);
		//metodos
		bool EsVacio() const;
		bool Insertar(const TCalendario &);
		bool Borrar(const TCalendario &);
		bool Buscar(const TCalendario &) const;
		TCalendario Raiz() const;
		int Altura() const;
		int Nodos() const;
		int NodosHoja() const;
		TVectorCalendario Inorden() const;
		TVectorCalendario Preorden() const;
		TVectorCalendario Postorden() const;
		TVectorCalendario Niveles() const;
		//operadores
		bool operator==(const TABBCalendario &);
		TABBCalendario operator+(const TABBCalendario &) const;
		TABBCalendario operator-(const TABBCalendario &) const;
};

class TNodoABB{
	friend class TABBCalendario;
	private:
		TCalendario item;
		TABBCalendario iz;
		TABBCalendario de;
	public:
		// forma canonica
		TNodoABB();
		TNodoABB(TNodoABB &);
		~TNodoABB();
		TNodoABB & operator=(const TNodoABB &);
};
#endif