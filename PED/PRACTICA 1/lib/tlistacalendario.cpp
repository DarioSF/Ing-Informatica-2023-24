#include "tlistacalendario.h"
#include "tvectorcalendario.h"
#include "tcalendario.h"

using namespace std;

/*		TNODOCALENDARIO			*/

//	Constructor por defecto
TNodoCalendario::TNodoCalendario() : c(){
	this->siguiente = NULL;
}

TNodoCalendario::TNodoCalendario(const TNodoCalendario &node){
	this->c = node.c;
	this->siguiente = node.siguiente;
}

TNodoCalendario::~TNodoCalendario(){
	this->c.~TCalendario();
	this->siguiente = NULL;
}

TNodoCalendario& TNodoCalendario::operator=(const TNodoCalendario &node){
	if(this != &node){
		(*this).~TNodoCalendario();
		this->c = node.c;
		this->siguiente = node.siguiente;	
	}
	return *this;
}


/*		TLISTAPOS				*/
TListaPos::TListaPos(){
	this->pos = NULL;
}

TListaPos::TListaPos(const TListaPos &lp){
	this->pos = lp.pos;
}

TListaPos::~TListaPos(){
	delete this->pos;
	this->pos = NULL;
}

TListaPos& TListaPos::operator=(const TListaPos &lp){
	if(this != &lp) this->pos = lp.pos;
	return *this;
}

bool TListaPos::operator==(const TListaPos &lp){
	if(this->pos == lp.pos) return true;
	return false;
}

bool TListaPos::operator!=(const TListaPos &lp){
	return !(*this == lp);
}

TListaPos TListaPos::Siguiente() const{ //revisar
	TListaPos res;
 	if(this->pos->siguiente != NULL){
 		res.pos = this->pos->siguiente;
 	}
 	return res;
}

bool TListaPos::EsVacia() const{
	if(this->pos == NULL) return true;
	return false;
}


/*		TLISTACALENDARIO			*/

TListaCalendario::TListaCalendario(){
	this->primero = NULL;
}

TListaCalendario::TListaCalendario(const TListaCalendario &list){
	this->primero = NULL;
	for(TListaPos pos = list.Primera(); !pos.EsVacia(); pos = pos.Siguiente())
		this->Insertar(pos.pos->c);
}

TListaCalendario::~TListaCalendario(){
	TNodoCalendario *actual = primero;
    TNodoCalendario *siguiente = NULL;

    // Iteramos sobre todos los nodos de la lista
    while (actual != NULL) {
        siguiente = actual->siguiente; // Guardamos el siguiente nodo antes de eliminar el actual
        delete actual; // Liberamos la memoria del nodo actual
        actual = siguiente; // Movemos al siguiente nodo
    }

    primero = NULL; // Marcamos que la lista está vacía
}

TListaCalendario& TListaCalendario::operator=(const TListaCalendario &list){
	if(this != &list){
		(*this).~TListaCalendario();
		this->primero = list.primero;
	}
	return *this;
}

bool TListaCalendario::operator==(TListaCalendario &list){
	if(this->Longitud() != list.Longitud()) return false;
	TListaPos esta = Primera();
	TListaPos comparar = list.Primera();
	while(!esta.EsVacia()){
		if(esta.pos->c != comparar.pos->c) return false;
		esta = esta.Siguiente();
		comparar = comparar.Siguiente();
	}
	return true;
}

TListaCalendario TListaCalendario::operator+(TListaCalendario &list){
	TListaCalendario *res;
	res = new TListaCalendario(*this);
	for(TListaPos pos = list.Primera(); !pos.EsVacia(); pos = pos.Siguiente())
		res->Insertar(pos.pos->c);
	return *res;
}

TListaCalendario TListaCalendario::operator-(TListaCalendario &list){
	TListaCalendario *res;
	res = new TListaCalendario(*this);
	for(TListaPos pos = list.Primera(); !pos.EsVacia(); pos = pos.Siguiente())
		res->Borrar(pos.pos->c);
	return *res;
}

bool TListaCalendario::Insertar(const TCalendario &cal) {
    // Creamos un nuevo nodo con el calendario pasado por parámetro
    TNodoCalendario *nuevoNodo = new TNodoCalendario();
    nuevoNodo->c = cal;
    nuevoNodo->siguiente = NULL;

    // Caso especial: Lista vacía
    if (EsVacia()) {
        primero = nuevoNodo;
        return true;
    }

    TNodoCalendario *anterior = NULL;
    TNodoCalendario *actual = primero;

    // Buscamos el lugar adecuado para insertar el nuevo nodo
    while (actual != NULL && actual->c < cal) {
        anterior = actual;
        actual = actual->siguiente;
    }

    if (anterior == NULL) { // Insertar al principio
 		nuevoNodo->siguiente = primero;
    	primero = nuevoNodo;
    	return true;
	}
	else { // Insertar en medio o al final
    	nuevoNodo->siguiente = actual; // Este enlace debe ser cambiado
    	anterior->siguiente = nuevoNodo;
    	return true;
	}


    return false;
}



bool TListaCalendario::Borrar(const TCalendario &cal){
	TNodoCalendario *aux = primero;
	TNodoCalendario *anterior = NULL;
	while(aux != NULL){
		if(aux->c == cal){
			if(anterior == NULL) primero = aux->siguiente;
			else anterior->siguiente = aux->siguiente;
			delete aux;
			return true;
		}
		anterior = aux;
		aux = aux->siguiente;
	}
	return false;
}

bool TListaCalendario::Borrar(const TListaPos &lp){
	if(!lp.EsVacia()){
		TNodoCalendario *node = lp.pos;
		TCalendario cal = node->c;
		if(Borrar(cal)) return true;
	}
	return false;
}

bool TListaCalendario::Borrar(int dia, int mes, int anyo){
	TNodoCalendario *aux = primero;
	TNodoCalendario *anterior = NULL;
	bool res = false;
	TCalendario limite(dia, mes, anyo, NULL);
	while(aux != NULL){
		if(aux->c < limite){
			if(anterior == NULL) primero = aux->siguiente;
			else anterior->siguiente = aux->siguiente;
			TNodoCalendario *borrar = aux;
			aux = aux->siguiente;
			delete borrar;
			res = true;
		}
		else{
			anterior = aux;
			aux = aux->siguiente;
		}
	}
	return res;
}

bool TListaCalendario::EsVacia() const{
	if(this->primero == NULL) return true;
	return false;
}

TCalendario TListaCalendario::Obtener(TListaPos &lp) const{
	TCalendario res;
	for(TListaPos pos = this->Primera(); !pos.EsVacia(); pos = pos.Siguiente())
		if(pos == lp) return pos.pos->c;
	return res;
}

bool TListaCalendario::Buscar(TCalendario &cal) const{
	for(TListaPos lp = this->Primera(); !lp.EsVacia(); lp = lp.Siguiente())
		if(lp.pos->c == cal) return true;
	return false;
}

int TListaCalendario::Longitud() const{
	int res = 0;
	for(TListaPos pos = this->Primera(); !pos.EsVacia(); pos = pos.Siguiente())
		res++;
	return res;
}

TListaPos TListaCalendario::Primera() const{//revisar
	TListaPos res;
	if(this->EsVacia()) return res;
	else res.pos = this->primero;
	return res;
}

TListaPos TListaCalendario::Ultima() const{
	TListaPos res;
	res = this->Primera();
	for(int i = 1; i < this->Longitud(); i++)
		res = res.Siguiente();
	return res;
}

TListaCalendario TListaCalendario::SumarSubl(int I_L1, int F_L1, TListaCalendario &L2, int I_L2, int F_L2){
	TListaCalendario res;
	return res;
}

TListaCalendario TListaCalendario::ExtraerRango(int n1, int n2){
	TListaCalendario res;
	return res;
}

ostream &operator<<(ostream &os, const TListaCalendario &lista) {
    os << "<";

    if (!lista.EsVacia()) {
        TListaPos pos = lista.Primera();
        os << lista.Obtener(pos);

        while (pos.Siguiente() != TListaPos()) {
            pos = pos.Siguiente();
            os << " " << lista.Obtener(pos);
        }
    }

    os << ">";
    return os;
}
