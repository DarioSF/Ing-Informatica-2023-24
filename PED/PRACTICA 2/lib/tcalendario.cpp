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
		if(mens != NULL){
			this->mensaje = new char[strlen(mens)+1];
			strcpy(this->mensaje, mens);
		}
	}
	else{
		this->dia = 1;
		this->mes = 1;
		this->anyo = 1900;
		this->mensaje = NULL;
	}
}
//	Constructor copia
TCalendario::TCalendario(TCalendario &cal){ //posible test: pasar un null
	this->dia = cal.dia;
	this->mes = cal.mes;
	this->anyo = cal.anyo;
	if(cal.mensaje != NULL){
		this->mensaje = new char[strlen(cal.mensaje)+1];
		strcpy(this->mensaje, cal.mensaje);
	}
	else mensaje = NULL;
}

//	Destructor
TCalendario::~TCalendario(){
	this->dia = 1;
	this->mes = 1;
	this->anyo = 1900;
	if(this->mensaje != NULL){
		delete[] this->mensaje;
	}
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
	return mensaje;
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
bool TCalendario::ModMensaje(char *mensaje){ //PREGUNTA 3 // Reservar memoria para mensaje
	this->mensaje = mensaje;
	return true;
}

/*		OPERADORES SOBRECARGADOS	*/

//	Sobrecarga del operador: ASIGNACION
TCalendario& TCalendario::operator=(const TCalendario &c){
	// Compruebo que son distintos
	if(this != &c){
		// Llamo al destructor
		(*this).~TCalendario();
		// Asigno los valores directos
		dia = c.dia;
		mes = c.mes;
		anyo = c.anyo;
		// Si el mensaje no es NULL reservo memoria y copio el mensaje
		if(c.mensaje != NULL){
			mensaje = new char[strlen(c.mensaje)+1];
			strcpy(mensaje, c.mensaje);
		}
		else mensaje = NULL;
	}
	// Devolver el objeto *this ya modificado
	return *this;
}

//	Sobrecarga del operador: SUMA
TCalendario TCalendario::operator+(int dias) {
	// Crear objeto TCalendario para devolver
    TCalendario resultado(*this);
    // Si los dias son negativos no se modifica la fecha
    if(dias > 0){
	    // Sumar los días al día actual
	    resultado.dia += dias;
	    // Mientras el día resultante sea mayor que el número total de días del mes actual
	    while (resultado.dia > resultado.numDiasMes(resultado.Mes(), resultado.Anyo())) {
	        // Restar el número total de días del mes actual y avanzar al siguiente mes
	        resultado.dia -= resultado.numDiasMes(resultado.Mes(), resultado.Anyo());
	        resultado.mes++;
	        // Si el mes resultante es mayor que 12, ajustar el año y el mes
	        if (resultado.mes > 12) {
	            resultado.mes = 1;
	            resultado.anyo++;
	        }
	    }
	}
    // Devolver el TCalendario con la fecha modificada
    return resultado;
}

//	Sobrecarga del operador: RESTA
TCalendario TCalendario::operator-(int dias){
	// Crear objeto TCalendario para devolver
	TCalendario resultado(*this);
	// Si los dias son negativos no se modifica la fecha
	if(dias > 0){
		// Restar los días al día actual
		resultado.dia -= dias;
		while(resultado.dia < 1){
			// Sumar el número total de dias del mes actual y retroceder al mes anterior
			resultado.dia += resultado.numDiasMes(resultado.Mes(), resultado.Anyo());
			resultado.mes--;
			// Si el mes resultante es menor que 1, ajustar el año y el mes
			if(resultado.mes < 1){
				resultado.mes = 12;
				resultado.anyo--;
			}
		}
	}
	// Si la fecha final no es correcta no realizamos cambios
	if(!fechaCorrecta(resultado.Dia(), resultado.Mes(), resultado.Anyo())){
		resultado.dia = 1;
		resultado.mes = 1;
		resultado.anyo = 1900;
		resultado.mensaje = NULL;
	}
	// Devolver el TCalendario con la fecha modificada
	return resultado;
}

//	Sobrecarga del operador: POSTINCREMENTO
TCalendario TCalendario::operator++(int dummie){
	// Crear objeto TCalendario para devolver por valor
	TCalendario resultado(*this);
	// Realizo el incremento en el objeto *this
	*this = *this + 1;
	// Devolver la copia sin modificar
	return resultado;
}

//	Sobrecarga del operador: PREINCREMENTO
TCalendario& TCalendario::operator++(){
	// Realizo el incremento en el objeto *this
	*this = *this + 1;
	// Devolver la copia modificada 
	return *this;
}

//	Sobrecarga del operador: POSTDECREMENTO
TCalendario TCalendario::operator--(int dummie){
	// Crear objeto TCalendario para devolver por valor
	TCalendario resultado(*this);
	// Realizo el decremento en el objeto *this
	*this = *this - 1;
	// Devolver la copia sin modificar
	return resultado;
}

//	Sobrecarga del operador: PREDECREMENTO
TCalendario & TCalendario::operator--(){
	// Realizo el decremento en el objeto *this
	*this = *this - 1;
	// Devolver la copia modificada
	return *this;
}

//	Sobrecarga del operador: MAYOR QUE
bool TCalendario::operator>(const TCalendario &c){
	// Compara la fecha y devuelve true o false segun resulte la comparacion
	if(this->anyo != c.anyo) return this->anyo > c.anyo;
	if(this->mes != c.mes) return this->mes > c.mes;
	if(this->dia != c.dia) return this->dia > c.dia;
	// Si llegamos hasta aquí, comparamos los mensajes
	return compararMensaje(this->mensaje, c.mensaje);
}

//	Sobrecarga del operador: MENONR QUE
bool TCalendario::operator<(const TCalendario &c){
	return !(*this > c) && *this != c;
}

//	Sobrecarga del operador: IGUAL QUE
bool TCalendario::operator==(const TCalendario &c){
	if(this->anyo != c.anyo || this->mes != c.mes || this->dia != c.dia || compararMensaje(this->mensaje, c.mensaje)) return false;
	return true;
}

//	Sobrecarga del operador: DISTINTO QUE
bool TCalendario::operator!=(const TCalendario &c){
	return !(*this == c);
}

/*		FUNCIONES AMIGAS			*/

//	Sobrecargad el operador: SALIDA
ostream &operator<<(ostream &os, const TCalendario &c){
	if(c.dia < 10) os << "0" << c.dia << "/";
	else os << c.dia << "/";
	if(c.mes < 10) os << "0" << c.mes << "/";
	else os << c.mes << "/"; 
	os << c.anyo << " ";
	if(c.mensaje == NULL) os << "\"\"";
	else os << "\"" << c.mensaje << "\"";
	return os;
}

/*		FUNCIONES AUXILIARES		*/

// Compara dos mensajes
bool TCalendario::compararMensaje(char* m1, char* m2){
	// Si los dos son igual a NULL devolvemos false
	if(m1 == NULL && m2 == NULL) return false;
	// Si el mensaje 1 es NULL, el mensaje 2 es más largo por lo que devolvemos false
	if(m1 == NULL) return false;
	// Si el mensaje 2 es NULL, el mensaje 1 es más largo por lo que devolvemos true
	if(m2 == NULL) return true;
	// Si llegamos hasta aquí devolvemos la comparación de los mensajes
	return strcmp(m1, m2) > 0;
}

//	Comprueba que el año sea bisiesto
bool TCalendario::esBisiesto(int anyo){
	return (anyo % 4 == 0 && (anyo % 100 != 0 || anyo % 400 == 0));	
}

//	Devuelve el numero de dias que tiene un mes
int TCalendario::numDiasMes(int mes, int anyo){
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
	int numDias = numDiasMes(mes, anyo);
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