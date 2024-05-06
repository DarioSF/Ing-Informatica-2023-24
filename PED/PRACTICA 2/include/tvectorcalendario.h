//74392984J Dario Simon Franco
#ifndef _TVECTORCALENDARIO_H_
#define _TVECTORCALENDARIO_H_

#include "tcalendario.h"

using namespace std;

	/*							CLASE TVECTORCALENDARIO						*/
class TVectorCalendario{
	/*							FUNCIONES AMIGAS							*/
	friend ostream & operator<<(ostream &, const TVectorCalendario &);
	/*							PARTE PRIVADA								*/
	private:
		TCalendario *c;
		int tamano;
		TCalendario error;
	/*							METODOS AUXILIARES							*/
		bool compararFechas(TCalendario, int, int, int);
	public:
	/*							FORMA CANONICA								*/
	/*	Constructor por defecto												*/
		TVectorCalendario();
	/*	Constructor sobrecargado											*/
		TVectorCalendario(int);
	/*	Constructor copia 													*/
		TVectorCalendario(const TVectorCalendario &);
	/*	Destructor															*/
		~TVectorCalendario();
	/*	Sobrecarga del operador asignacion									*/
		TVectorCalendario & operator=(const TVectorCalendario &);
	/*							METODOS										*/
	/*	Sobrecarga del operador igualdad									*/
		bool operator==(const TVectorCalendario &);
	/*	Sobrecarga del operador desigualdad									*/
		bool operator!=(const TVectorCalendario &);
	/*	Sobrecarga del operador [] escritura								*/
		TCalendario & operator[](int);
	/*	Sobrecarga del operador [] lectura									*/
		TCalendario operator[](int) const;
	/*	Tamaño del vector (posiciones TOTALES)  							*/
		int Tamano() const;
	/*	Cantidad de posiciones OCUPADAS (no vacías) en el vector 			*/
		int Ocupadas();
	/*	Devuelve TRUE si existe el calendario en el vector 					*/
		bool ExisteCal(const TCalendario &);
	/*	Mostrar por pantalla mensajes de TCalendario en el vector, 
		de fecha IGUAL O POSTERIOR a la pasada								*/
		void MostrarMensajes(int, int, int);
	/*	REDIMENSIONAR el vectorde TCalendario 								*/
		bool Redimensionar(int);
};

#endif