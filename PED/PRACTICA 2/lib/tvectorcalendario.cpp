#include "tvectorcalendario.h"
#include "tcalendario.h"

using namespace std;

/*		FUNCIONES PRINCIPALES		S*/

//	Constructor por defecto
TVectorCalendario::TVectorCalendario(){
	this->c = NULL;
	this->tamano = 0;
}

//	Constructor sobrecargado
TVectorCalendario::TVectorCalendario(int tamano){
	if(tamano <= 0){
		this->tamano = 0;
		this->c = NULL;
	}
	else{
		this->tamano = tamano;
		this->c = new TCalendario[this->tamano];	
	}
	
}

//	Constructor de copia
TVectorCalendario::TVectorCalendario(TVectorCalendario &vc){
	this->tamano = vc.tamano;
	this->c = new TCalendario[this->tamano];
	for(int i = 1; i <= this->tamano; i++){
		this->c[i] = vc.c[i];
	}
}

//	Destructor
TVectorCalendario::~TVectorCalendario(){
	if(this->c != NULL) delete[] this->c;
	this->c = NULL;
	this->tamano = 0;
}

//	Devuelve el tamaño del vector
int TVectorCalendario::Tamano(){
	return this->tamano;
}

//	Devuelve TRUE si existe el calendario pasador por parametro, FALSE en caso contrario
bool TVectorCalendario::ExisteCal(const TCalendario &cal){
	//	Recorremos el vector comparando con el TCalendario que nos pasan por parametro
	for(int i = 0; i < this->tamano; i++){
		//	Si lo encuentra devuelve TRUE
		if(this->c[i] == cal) return true;
	}
	//	Si llega hasta aqui no lo ha encontrado y devuelve FALSE
	return false;
}

//	Devuelve el numero de calendarios no vacios en el vector
int TVectorCalendario::Ocupadas(){
	int res = 0;
	//	Recorremos el vector comparando con el TCalendario vacio
	for(int i = 0; i < this->tamano; i++){
		//	Si no es vacio incrementamos en 1
		if(this->c[i] != error) res++;
	}
	//	Devolvemos el total de posiciones ocupadas
	return res;
}

//	Muestra los mensajes posteriores a una fecha dada
void TVectorCalendario::MostrarMensajes(int d, int m, int a){
	int veces = -1;
	//	Recorremos el vector para saber cuando dejar de poner la coma
	for(int i = 0; i <= this->tamano; i++){
		if(compararFechas(this->c[i], d, m, a)) veces++;
	}
	cout << "[";
	//	Recorremos el vector
 	for(int i = 1; i <= this->tamano; i++){
 		//	Si la fecha cumple la condicion lo mostramos
 		if(compararFechas(this->c[i], d, m, a)){
 			cout << this->c[i];
 			if(i < veces) cout << ", ";
 		}
 	}
 	cout << "]";
}

//	Cambia el tamaño del vector
bool TVectorCalendario::Redimensionar(int tam){
	//	Check para comprobar si vamos a poder redimensionar
	if(tam <= 0 || tam == this->tamano) return false;
	//	Si pasamos el check anterior reservamos memoria en una variable auxiliar
	TCalendario *copiar = new TCalendario[tam];
	//	Si el vector aumenta rellenamos con los datos del vector original
	if(tam > this->tamano){
		for(int i = 0; i < this->tamano; i++){
			copiar[i] = this->c[i];
		}
		//	El resto de huecos se rellenan con el TCalendario por defecto
	}
	//	Si el vector se reduce, rellenamos con los datos del vector hasta el tamaño dado
	else{
		for(int i = 0; i < tam; i++){
			copiar[i] = this->c[i];
		}
	}
	//	Limpiamos la memoria
	if(this->c != NULL) delete[] this->c;
	//	Asignamos el vector auxiliar y el tamaño a nuestro vector
	this->c = copiar;
	this->tamano = tam;
	//	Si llegamos hasta aqui el vector se ha redimensionado y devolvemos TRUE
	return true;
}

/*		OPERADORES SOBRECARGADOS	*/

// Sobrecarga del operador: ASIGNACION
TVectorCalendario& TVectorCalendario::operator=(TVectorCalendario &vc){
	//	Si es distinto realizamos la operacion
	if(this != &vc){
		//	Liberamos memoria
		(*this).~TVectorCalendario();
		//	Asignamos los datos
		this->tamano = vc.tamano;
		if(this->tamano > 0) this->c = new TCalendario[this->tamano];
		for(int i = 0; i < this->tamano; i++)
			this->c[i] = vc.c[i];
	}
	//	Devolvemos el puntero desreferenciado
	return *this;
}

//	Sobrecarga del operador: IGUAL QUE
bool TVectorCalendario::operator==(const TVectorCalendario &vc){
	//	Check del tamaño
	if(this->tamano != vc.tamano) return false;
	//	Recorremos el vector comparando elemento a elemento
	for(int i = 0; i < this->tamano; i++)
		if(this->c[i] != vc.c[i]) return false;
	//	Si llegamos hasta aquí los vectores son iguales y devolvemos TRUE
	return true;
}

//	Sobrecarga del operador: DISTINTO QUE
bool TVectorCalendario::operator!=(const TVectorCalendario &vc){
	//	Devolvemos el contrario del operador ==
	return !(*this == vc);
}

//	Sobrecarga del operador: [] ESCRITURA
TCalendario & TVectorCalendario::operator[](int i){
	if(i < 1) return error;
	return this->c[i - 1];
}

//	Sobrecarga del operador: [] LECTURA
TCalendario TVectorCalendario::operator[](int i) const{
	if(i < 1){
		TCalendario err;
		return err;
	}
	return this->c[i - 1];
}


/*		FUNCIONES AMIGAS		*/

//	Sobrecarga del operador: SALIDA
ostream &operator<<(ostream &os, TVectorCalendario &v){
	int veces = -1;
	for(int i = 0; i <= v.Tamano(); i++) veces++;
	os << "[";
	for(int i = 1; i <= v.Tamano(); i++){
		os << "(" << i << ") " << v[i];
		if(i < veces) os << ", ";
	}
	os << "]";
	return os;
}

/*		FUNCIONES AUXILIARES	*/

//	Devuelve TRUE si las fechas coinciden, False en caso contrario
bool TVectorCalendario::compararFechas(TCalendario cal, int d, int m, int a){
	//	Si no pasa los checks devuelve FALSE
	if(cal.Anyo() < a) return false;
	if(cal.Mes() < m) return false;
	if(cal.Dia() < d) return false;
	//	Si llega hasta aquí la fecha del calendario es mayor y devuelve TRUE
	return true;
}