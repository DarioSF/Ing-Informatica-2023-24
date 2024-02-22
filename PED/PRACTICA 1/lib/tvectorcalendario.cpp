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
		this->c = new TCalendario[this->tamano];
		for(int i = 0; i < this->tamano; i++)
			this->c[i] = vc.c[i];
	}
	return *this;
}