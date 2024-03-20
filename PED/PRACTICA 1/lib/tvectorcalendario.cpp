#include "tcalendario.h"
#include "tvectorcalendario.h"

using namespace std;

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

// Sobrecarga del operador: ASIGNACION
TVectorCalendario& TVectorCalendario::operator=(TVectorCalendario &vc){
	if(this != &vc){
		(*this).~TVectorCalendario();
		this->tamano = vc.tamano;
		if(this->tamano > 0) this->c = new TCalendario[this->tamano];
		for(int i = 0; i < this->tamano; i++)
			this->c[i] = vc.c[i];
	}
	return *this;
}

//	Sobrecarga del operador: IGUAL QUE
bool TVectorCalendario::operator==(const TVectorCalendario &vc){
	if(this->tamano != vc.tamano) return false;
	for(int i = 0; i < this->tamano; i++)
		if(this->c[i] != vc.c[i]) return false;
	return true;
}

bool TVectorCalendario::operator!=(const TVectorCalendario &vc){
	return !(*this == vc);
}

int TVectorCalendario::Tamano(){
	return this->tamano;
}

bool TVectorCalendario::ExisteCal(const TCalendario &cal){
	for(int i = 0; i < this->tamano; i++){
		if(this->c[i] == cal) return true;
	}
	return false;
}

int TVectorCalendario::Ocupadas(){
	int res = 0;
	for(int i = 0; i < this->tamano; i++){
		if(this->c[i] != error) res++;
	}
	return res;
}

void TVectorCalendario::MostrarMensajes(int d, int m, int a){
	cout << "[";
 	for(int i = 1; i <= this->tamano; i++){
 		if(compararFechas(this->c[i], d, m, a)){
 			cout << this->c[i] << ", "; // doble pasada
 		}
 	}
 	cout << "]";
 }

bool TVectorCalendario::compararFechas(TCalendario cal, int d, int m, int a){
	if(cal.Anyo() < a) return false;
	if(cal.Mes() < m) return false;
	if(cal.Dia() < d) return false;
	return true;
}

bool TVectorCalendario::Redimensionar(int tam){
	if(tam <= 0 || tam == this->tamano) return false;
	TCalendario *copiar = new TCalendario[tam];
	if(tam > this->tamano){
		for(int i = 0; i < this->tamano; i++){
			copiar[i] = this->c[i];
		}
		for(int i = this->tamano; i < tam; i++){
			TCalendario cal;
			copiar[i] = cal;
		}
	}
	else{
		for(int i = 0; i < tam; i++){
			copiar[i] = this->c[i];
		}
	}
	delete[] this->c;
	this->c = copiar;
	this->tamano = tam;
	return true;
}

TCalendario & TVectorCalendario::operator[](int i){
	if(i < 1) return error;
	return this->c[i - 1];
}

TCalendario TVectorCalendario::operator[](int i) const{
	if(i < 1){
		TCalendario err;
		return err;
	}
	return this->c[i - 1];
}

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