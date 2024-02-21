#include <iostream>

using namespace std;

//	Constructor por defecto
TVectorCalendario::TVectorCalendario(){
	this->c = new TCalendario[0];
	this->tamano = 0;
	this->error = new TCalendario;
}

TVectorCalendario::TVectorCalendario(int tamano){
	if(tamano < 0){
		this->tamano = 0;
	}
	this->c = NULL;
	this->tamano = tamano;
	this->error = NULL;
}