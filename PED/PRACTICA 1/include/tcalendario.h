#ifndef _TCALENDARIO_H_
#define _TCALENDARIO_H_

#include <iostream>
#include <string.h>
#include <cstring>

using namespace std;

class TCalendario{
	/*							FUNCIONES AMIGAS							*/
	/*	Sobrecarga del operador salida										*/
	friend ostream & operator<<(ostream &, const TCalendario &);
	private:
		int dia;
		int mes;
		int	anyo;
		char* mensaje;
	/*							METODOS AUXILIARES							*/	
		bool fechaCorrecta(int, int, int);
		bool esBisiesto(int);
		int numDiasMes(int, int);
		void arreglarFecha(TCalendario &, int);
		bool compararMensaje(char*, char*);
	public:
	/*							FORMA CANONICA								*/
	/*	Constructor por defecto												*/
		TCalendario();
	/*	Constructor con parametros											*/
		TCalendario(int, int, int, char*);
	/*	Constructor copia 													*/
		TCalendario (TCalendario &);
	/*	Destructor 															*/
		~TCalendario();
	/*	Sobrecarga del operador asignación									*/
		TCalendario & operator=(const TCalendario &);
	/*							METODOS										*/
	/*	Sobrecarga del operador: SUMA de fecha + un número de dias;			*/
		TCalendario operator+(int);
	/*	Sobrecarga del operador: RESTA de fecha - un número de dias;		*/
		TCalendario operator-(int);
	/*	Modifica la fecha incrementándola en un dia (con postincremento);	*/
		TCalendario operator++(int);
	/*	Modifica la fecha incrementándola en un dia (con preincremento);	*/
		TCalendario & operator++();
	/*	Modifica la fecha decrementándola en un dia (con postdecremento);	*/
		TCalendario operator--(int);
	/*	Modifica la fecha decrementándola en un día (con predecremento);	*/
		TCalendario & operator--();
	/*	Modifica la fecha 													*/
		bool ModFecha (int, int, int);
	/*	Modifica el mensaje 												*/
		bool ModMensaje(char *);
	/*	Sobrecarga del operador igualdad;									*/
		bool operator==(const TCalendario &);
	/*	Sobrecarga del operador desigualdad;								*/
		bool operator!=(const TCalendario &);
	/*	Sobrecarga del operador >; 											*/
		bool operator>(const TCalendario &);
	/*	Sobrecarga del operador <; 											*/
		bool operator<(const TCalendario &);
	/*	TCalendario vacío													*/
		bool EsVacio();
	/*	Devuelve el día del calendario;										*/
		int Dia();
	/*	Devuelve el mes del calendario;										*/
		int Mes();
	/*	Devuelve el año del calendario;										*/
		int Anyo();
	/*	Devuelve el mensaje del calendario 									*/
		char *Mensaje();	
};

#endif
// comprimir: tar cvzf nombre.tgz *