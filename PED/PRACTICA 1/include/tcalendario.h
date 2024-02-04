#ifndef _TCALENDARIO_H_
#define _TCALENDARIO_H_

#include <iostream>

using namespace std;

class TCalendario{
	/*							FUNCIONES AMIGAS							*/
	/*	Sobrecarga del operador salida										*/
	//friend ostream & operator<<(ostream &, TCalendario &);----
	private:
		int dia;
		int mes;
		int	anyo;
		char* mensaje;
	/*							METODOS AUXILIARES							*/	
		bool fechaCorrecta(int dia, int mes, int anyo);
		bool esBisiesto(int anyo);
		int numDiasMes(int mes);
		void arreglarFecha(TCalendario &res, int dias);
	public:
	/*							FORMA CANONICA								*/
	/*	Constructor por defecto												*/
		TCalendario();
	/*	Constructor con parametros											*/
		TCalendario(int dia, int mes, int anyo, char *mens);
	/*	Constructor copia 													*/
		TCalendario (TCalendario &);
	/*	Destructor 															*/
		~TCalendario();
	/*	Sobrecarga del operador asignación									*/
		//TCalendario & operator=(TCalendario &); ------
	/*							METODOS										*/
	/*	Sobrecarga del operador: SUMA de fecha + un número de dias;			*/
		TCalendario operator+(int dias);
	/*	Sobrecarga del operador: RESTA de fecha - un número de dias;		*/
		//TCalendario operator-(int);
	/*	Modifica la fecha incrementándola en un dia (con postincremento);	*/
		//TCalendario operator++(int);
	/*	Modifica la fecha incrementándola en un dia (con preincremento);	*/
		//TCalendario & operator++();
	/*	Modifica la fecha decrementándola en un dia (con postdecremento);	*/
		//TCalendario operator--(int);
	/*	Modifica la fecha decrementándola en un día (con predecremento);	*/
		//TCalendario & operator--();
	/*	Modifica la fecha 													*/
		bool ModFecha (int dia, int mes, int anyo);
	/*	Modifica el mensaje 												*/
		bool ModMensaje(char *);
	/*	Sobrecarga del operador igualdad;									*/
		//bool operator ==(TCalendario &);
	/*	Sobrecarga del operador desigualdad;								*/
		//bool operator !=(TCalendario &);
	/*	Sobrecarga del operador >; (ver ACLARACIÓN sobre ORDENACIÓN)		*/
		//bool operator>(TCalendario &);
	/*	Sobrecarga del operador <; (ver ACLARACIÓN sobre ORDENACIÓN)		*/
		//bool operator<(TCalendario &);
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