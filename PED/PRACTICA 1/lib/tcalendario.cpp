#include <iostream>
#include "tcalendario.h"

using namespace std;

/*		FUNCIONES PRINCIPALES		*/

//	Constructor por defecto
TCalendario::TCalendario(){
	this->dia = 1;
	this->mes = 1;
	this->anyo = 1900;
	this->mensaje = NULL;
}

//	Constructor por defecto
TCalendario::TCalendario(int dia, int mes, int anyo, char *mens){
	if(fechaCorrecta(dia, mes, anyo)){
		this->dia = dia;
		this->mes = mes;
		this->anyo = anyo;
	}else{
		this->dia = 1;
		this->mes = 1;
		this->anyo = 1900;
	}
	//this->mensaje = NULL; //PREGUNTA 1
}
//	Constructor copia
TCalendario::TCalendario(TCalendario &cal){
	this->dia = cal.dia;
	this->mes = cal.dia;
	this->anyo = cal.anyo;
	this->mensaje = cal.mensaje;
}

//	Destructor
TCalendario::~TCalendario(){
	this->dia = 1;
	this->mes = 1;
	this->anyo = 1900;
	this->mensaje = NULL;
}

//	Devuelve TRUE si tiene los valores por defecto, FALSE en caso contrario
bool TCalendario::EsVacio(){
	return (dia == 1 && mes == 1 && anyo == 1900 && mensaje == NULL);
}

//	Devuelve el dia
int TCalendario::Dia(){
	return dia;
}

// Devuelve el mes
int TCalendario::Mes(){
	return mes;
}

//	Devuelve el año
int TCalendario::Anyo(){
	return anyo;
}
//	Devuelve el mensaje
char* TCalendario::Mensaje(){
	return mensaje; //PREGUNTA 2
}

//	Modifica la fecha
bool TCalendario::ModFecha(int dia, int mes, int anyo){
	//	Check para fecha valida, si no es valida no hace cambios y devuelve FALSE
	if(!fechaCorrecta(dia, mes, anyo)){
		return false;
	}
	//	Si pasa la condicion se asignan los valores y devuelve TRUE
	this->dia = dia;
	this->mes = mes;
	this->anyo = anyo;
	return true;
}

// Modifica el mensaje
bool TCalendario::ModMensaje(char *mensaje){ //PREGUNTA 3
	this->mensaje = mensaje;
	return true;
}

/*		OPERADORES SOBRECARGADOS	*/

//	Sobrecarga del operador: SUMA
TCalendario TCalendario::operator + (int dias){
	TCalendario res(*this);
	if(dias > 0) arreglarFecha(res, res.Dia() + dias);
	return res;
}

//PREGUNTA 5

/*		FUNCIONES AMIGAS			*/

//PREGUNTA 6

/*		FUNCIONES AUXILIARES		*/

//	Comprueba que el año sea bisiesto
bool TCalendario::esBisiesto(int anyo){
	return (anyo % 4 == 0 && (anyo % 100 != 0 || anyo % 400 == 0));	
}

//	Devuelve el numero de dias que tiene un mes
int TCalendario::numDiasMes(int mes){
	//	Check para dias en los meses de 31 dias
	if((mes == 1 || mes == 3 || mes == 5 || mes == 7 || mes == 8 || mes == 10 || mes == 12)) return 31;
	//	Check para dias en los meses de 30 dias
	if((mes == 4 || mes == 6 || mes == 9 || mes == 11)) return 30;
	if(mes == 2){
		//	Check para los años bisiestos
		if(esBisiesto(anyo)) return 29;
		else return 28;
	}
	//	Valor predeterminado para evitar warning
	return -1;	//PREGUNTA 4
}

//	Comprueba que la fecha sea correcta
bool TCalendario::fechaCorrecta(int dia, int mes, int anyo){
	//	Check para fechas inferiores
	if(dia < 1 || mes < 1 || anyo < 1900){
		return false;	
	} 
	//	Check para meses superiores
	if(mes > 12){
		 return false;
	}
	int numDias = numDiasMes(mes);
	//	Check para dias validos en los meses de 31 dias
	if(dia > numDias && numDias == 31){
		  return false;
	}
	//	Check para dias validos en los meses de 30 dias
	if(dia > numDias && numDias == 30){
		return false;
	}
	//	Check para los dias validos en febrero
	if(mes == 2){
		//	Check para los años bisiestos
		if(dia > numDias){
			
			return false;
		}
	}
	//	Si pasa todas las condiciones, la fecha es valida
		return true;


}

void TCalendario::arreglarFecha(TCalendario &res, int dias){
    if(dias > res.numDiasMes(res.Mes())){
        dias -= res.numDiasMes(res.Mes());
        res.mes++;
        if(res.Mes() > 12){
        	res.dia = 1;
            res.mes = 1;
            res.anyo++;
        }
        arreglarFecha(res, dias); // Llamada recursiva para seguir ajustando la fecha si es necesario
    }else{
    	res.ModFecha(dias, res.Mes(), res.Anyo());
    }
}

/*		PREGUNTAS		*/
/*	
 *	1) Lo dejo this->mensaje = NULL? 
 * 	2) hace falta comprobar que sea NULL? No deberia devolver NULL si el mensaje es NULL?
 * 	3) Como compruebo los casos que debe dar false?
 * 	4) Es necesario quitar el warning?
 * 	5) Como se sobrecargan los operadores?
 *  6) Como es la sintaxis de las funciones amigas?
 * 
 */