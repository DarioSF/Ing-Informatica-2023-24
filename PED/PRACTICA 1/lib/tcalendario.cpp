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
TCalendario TCalendario::operator+(int dias) {
    TCalendario resultado(*this);
    
    // Sumar los días al día actual
    resultado.dia += dias;

    // Mientras el día resultante sea mayor que el número total de días del mes actual
    while (resultado.dia > resultado.numDiasMes(resultado.Mes())) {
        // Restar el número total de días del mes actual y avanzar al siguiente mes
        resultado.dia -= resultado.numDiasMes(resultado.Mes());
        resultado.mes++;

        // Si el mes resultante es mayor que 12, ajustar el año y el mes
        if (resultado.mes > 12) {
            resultado.mes = 1;
            resultado.anyo++;
        }
    }

    // Ajustar la fecha si el día resultante es menor o igual a cero
    if (resultado.dia <= 0) {
        resultado.mes--;
        if (resultado.mes == 0) {
            resultado.mes = 12;
            resultado.anyo--;
        }
        resultado.dia = resultado.numDiasMes(resultado.Mes()) + resultado.dia;
    }
    
    return resultado;
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
	if(dia < 1 || mes < 1 || anyo < 1900) return false;
	//	Check para meses superiores
	if(mes > 12) return false;
	int numDias = numDiasMes(mes);
	//	Check para dias validos en los meses de 31 dias
	if(dia > numDias && numDias == 31) return false;
	//	Check para dias validos en los meses de 30 dias
	if(dia > numDias && numDias == 30) return false;
	//	Check para los dias validos en febrero
	if(mes == 2){
		//	Check para los años bisiestos
		if(dia > numDias) return false;
	}
	//	Si pasa todas las condiciones, la fecha es valida
		return true;


}

void TCalendario::arreglarFecha(TCalendario &res, int dias) {
    cerr << "llamada a arreglar Fecha" << endl;
    
    // Sumar los días restantes al día actual
    res.dia += dias;

    // Mientras el día resultante sea mayor que el número total de días del mes actual
    while (res.dia > res.numDiasMes(res.Mes())) {
        cerr << "dias mayor que tamaño mes (" << res.dia << ")" << endl;
        // Restar el número total de días del mes actual
        int diasMesActual = res.numDiasMes(res.Mes());
        res.dia -= diasMesActual;
        cerr << "dias despues de restar el mes (" << res.dia << ")" << endl;
        // Si el día resultante es mayor que el número total de días del mes actual, incrementar el mes
        if (res.dia > diasMesActual) { // Cambio: Verificar si el día resultante sigue siendo mayor que el número total de días del mes actual
            res.mes++;
            // Si el mes resultante es mayor que 12, ajustar el año y el mes
            if (res.mes > 12) {
                cerr << "mes mayor que 12" << endl;
                res.mes = 1;
                res.anyo++;
            }
            cerr << "llamada recursiva" << endl;
        }
    }
    
    cerr << "terminamos de arreglar fecha" << endl;
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