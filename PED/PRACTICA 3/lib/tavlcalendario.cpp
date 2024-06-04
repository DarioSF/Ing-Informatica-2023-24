// 74392984J Dario Simon Franco

#include "tavlcalendario.h"

// TNodoAVL

// Constructor por defecto de TNodoAVL
TNodoAVL::TNodoAVL() : item(), iz(), de(), fe() {}

// Constructor de copia de TNodoAVL
TNodoAVL::TNodoAVL(const TNodoAVL &tnodo) : item(tnodo.item), iz(tnodo.iz), de(tnodo.de), fe(tnodo.fe) {}

// Destructor de TNodoAVL
TNodoAVL::~TNodoAVL() {}

// Sobrecarga del operador de asignación de TNodoAVL
TNodoAVL & TNodoAVL::operator=(const TNodoAVL &nodo){
	// Evitamos autoasignacion
    if(this != &nodo){
        // Liberar la memoria del nodo actual
        this->~TNodoAVL();
        // Copiar los datos del nodo
        this->item = nodo.item;
        this->iz = nodo.iz;
        this->de = nodo.de;
    }
    return *this;
}
// Comprueba si el nodo es hoja
bool TNodoAVL::EsHoja() const {
    // Implementación pendiente
    return false;
}

// TAVLCalendario

// Constructor por defecto de TAVLCalendario
TAVLCalendario::TAVLCalendario() : raiz(NULL) {}

// Constructor de copia de TAVLCalendario
TAVLCalendario::TAVLCalendario(const TAVLCalendario &arbol){
    if(!arbol.EsVacio()){
        this->raiz = new TNodoAVL();
        this->raiz->item = arbol.raiz->item;
        this->raiz->iz = arbol.raiz->iz;
        this->raiz->de = arbol.raiz->de;
    }
    else this->raiz = NULL;
}
// Destructor de TAVLCalendario
TAVLCalendario::~TAVLCalendario() {
    if(raiz != NULL){
        delete raiz;
        raiz = NULL;
    }
}

// Sobrecarga del operador de asignación de TAVLCalendario
TAVLCalendario & TAVLCalendario::operator=(const TAVLCalendario &arbol){
    // Evitamos autoasignacion
    if(this != &arbol){
    	// Eliminamos memoria
        this->~TAVLCalendario();
        // Realizamos la asignacion de datos
        if(!arbol.EsVacio()){
            this->raiz = new TNodoAVL();
            this->raiz->item = arbol.raiz->item;
            this->raiz->iz = arbol.raiz->iz;
            this->raiz->de = arbol.raiz->de;
        }
        else this->raiz = NULL;
    }
    // Devolvemos el objeto al que apunta this
    return *this;
}
// Sobrecarga del operador igualdad de TAVLCalendario
bool TAVLCalendario::operator==(const TAVLCalendario &arbol) const{
	// Check para ver si la raiz es la misma
	if(this->Inorden() != arbol.Inorden()) return false;
	// Si llega aqui son iguales
	return true;
}

// Sobrecarga del operador desigualdad de TAVLCalendario
bool TAVLCalendario::operator!=(const TAVLCalendario &tavl) const{
    // Implementación pendiente
    return !(*this == tavl);
}

// Devuelve TRUE si el árbol está vacío, FALSE en caso contrario
bool TAVLCalendario::EsVacio() const{
	// Check para la raiz
	if(this->raiz == NULL) return true;
	// Si llega hasta aqui el arbol no esta vacio
	return false;
}
// Inserta el elemento en el árbol
bool TAVLCalendario::Insertar(const TCalendario &c){
    return InsertarAux(c, raiz);
}

bool TAVLCalendario::InsertarAux(const TCalendario &c, TNodoAVL *&nodo) {
    bool res = true;

    if (nodo == nullptr) {
        nodo = new TNodoAVL();
        if (!nodo) return false;
        nodo->item = c;
        nodo->fe = 0;
    } else if (nodo->item == c) {
        res = false;
    } else if (nodo->item > c) {
        res = InsertarAux(c, nodo->iz.raiz);
        if (res) nodo->fe--;
    } else {
        res = InsertarAux(c, nodo->de.raiz);
        if (res) nodo->fe++;
    }

    if (nodo != nullptr) {
        Balancear(nodo);
    }

    return res;
}


// Devuelve TRUE si el elemento está en el árbol, false en caso contrario
bool TAVLCalendario::Buscar(const TCalendario &cal) const{
	//	Si no esta vacio continuamos
    if(!EsVacio()){
    	// El elemento está en el nodo actual
        if(raiz->item == cal) return true;
        // Buscamos en los subarboles
        else return raiz->iz.Buscar(cal) || raiz->de.Buscar(cal);
    }
    // Si llegamos hasta aqui, el arbol esta vacio
    return false;
}

// Devuelve la altura del árbol (la altura de un árbol vacío es 0)
int TAVLCalendario::Altura() const{
	// Si es vacio la altura es 0
    if(this->EsVacio()) return 0;
    // Recorremos el arbol sumando 1 cada vez que aumente la altura
    else{
        int alturaIZ = this->raiz->iz.Altura();
        int alturaDE = this->raiz->de.Altura();
        return 1 + (alturaIZ > alturaDE ? alturaIZ : alturaDE);
    }
}

// Devuelve el número de nodos del árbol (un árbol vacío posee 0 nodos)
int TAVLCalendario::Nodos() const{
	// Si es vacio la cantidad es 0
    if(EsVacio()) return 0;
    // Recorremos el arbol sumando los nodos
    else{
        int nodosIZ = raiz->iz.Nodos();
        int nodosDE = raiz->de.Nodos();
        return 1 + nodosIZ + nodosDE;
    }
}

// Devuelve el número de nodos hoja en el árbol (la raíz puede ser nodo hoja)
int TAVLCalendario::NodosHoja() const {
	// Si es vacio la cantidad es 0
    if(EsVacio()) return 0;
    // Si no tiene hijos es un nodo hoja
  	else if(raiz->iz.EsVacio() && raiz->de.EsVacio()) return 1;
    // Si no tiene hijos, sumamos los de los subárboles
    return raiz->iz.NodosHoja() + raiz->de.NodosHoja();
}

// Devuelve el recorrido en INORDEN sobre un vector
TVectorCalendario TAVLCalendario::Inorden() const {
	int pos;
	// Creamos un vector con el tamaño necesario
    TVectorCalendario res(Nodos());
    // Inicializamos la posicion
    pos = 1;
    // Llamamos a la funcion auxilair
    InordenAux(res, pos);
    // Devolvemos el vector resultado
    return res;
}

// Devuelve el recorrido en PREORDEN sobre un vector
TVectorCalendario TAVLCalendario::Preorden() const{
	int pos;
	// Creamos un vector con el tamaño necesario
    TVectorCalendario res(Nodos());
    // Inicializamos la posicion
    pos = 1;
    // Llamamos a la funcion auxilair
    PreordenAux(res, pos);
    // Devolvemos el vector resultado
    return res;
}

// Devuelve el recorrido en POSTORDEN sobre un vector
TVectorCalendario TAVLCalendario::Postorden() const{
	int pos;
	// Creamos un vector con el tamaño necesario
    TVectorCalendario res(Nodos());
    // Inicializamos la posicion
    pos = 1;
    // Llamamos a la funcion auxilair
    PostordenAux(res, pos);
    // Devolvemos el vector resultado
    return res;
}

// Borra un TCalendario del árbol AVL
bool TAVLCalendario::Borrar(TCalendario &cal) {
    return BorrarAux(cal, raiz);
}

bool TAVLCalendario::BorrarAux(TCalendario &cal, TNodoAVL *&nodo) {
    if (nodo == NULL) {
        return false;  // El elemento no se encuentra en el árbol
    }

    bool res;
    if (cal < nodo->item) {
        res = BorrarAux(cal, nodo->iz.raiz);
    } else if (cal > nodo->item) {
        res = BorrarAux(cal, nodo->de.raiz);
    } else {
        // Nodo encontrado
        res = true;
        if (nodo->iz.EsVacio() && nodo->de.EsVacio()) {
            // Caso 1: Nodo a borrar es una hoja
            delete nodo;
            nodo = NULL;
        } else if (nodo->iz.EsVacio() || nodo->de.EsVacio()) {
            // Caso 2: Nodo a borrar tiene un solo hijo
            TNodoAVL *hijo = (nodo->iz.EsVacio()) ? nodo->de.raiz : nodo->iz.raiz;
            TNodoAVL *temp = nodo;
            nodo = hijo;
            delete temp;
        } else {
            // Caso 3: Nodo a borrar tiene dos hijos
            TNodoAVL *sustituto = nodo->de.raiz;
            while (sustituto->iz.raiz != NULL) {
                sustituto = sustituto->iz.raiz;
            }
            nodo->item = sustituto->item;
            BorrarAux(sustituto->item, nodo->de.raiz);
        }
    }

    if (nodo != NULL) {
        Balancear(nodo);
    }

    return res;
}

void TAVLCalendario::Balancear(TNodoAVL *&nodo) {
    nodo->fe = (nodo->de.raiz ? nodo->de.Altura() : 0) - (nodo->iz.raiz ? nodo->iz.Altura() : 0);
    if (nodo->fe == -2) {
        if (nodo->iz.raiz->fe <= 0) {
            RotDerecha(nodo);
        } else {
            Rot2Derecha(nodo);
        }
    } else if (nodo->fe == 2) {
        if (nodo->de.raiz->fe >= 0) {
            RotIzquierda(nodo);
        } else {
            Rot2Izquierda(nodo);
        }
    }
}

// Devuelve el elemento TCalendario raíz del árbol AVL
TCalendario TAVLCalendario::Raiz() const{
	return this->raiz->item;
}

// AUXILIAR: devuelve el recorrido en INORDEN
void TAVLCalendario::InordenAux(TVectorCalendario &vec, int &pos) const {
    if(!EsVacio()){
    	// Recorremos el subarbol izquierdo
        raiz->iz.InordenAux(vec, pos);
        // Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
        // Recorremos el subarbol derecho
        raiz->de.InordenAux(vec, pos);
    }
}

// AUXILIAR: devuelve el recorrido en PREORDEN
void TAVLCalendario::PreordenAux(TVectorCalendario &vec, int &pos) const{
	if(!EsVacio()){
		// Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
        // Recorremos el subárbol izquierdo
        raiz->iz.PreordenAux(vec, pos);
        // Recorremos el subárbol derecho
        raiz->de.PreordenAux(vec, pos);
    }
}

// AUXILIAR: devuelve el recorrido en POSTORDEN
void TAVLCalendario::PostordenAux(TVectorCalendario &vec, int &pos) const {
    if(!EsVacio()){
    	// Recorremos el subárbol izquierdo
        raiz->iz.PostordenAux(vec, pos);
        // Recorremos el subárbol derecho
        raiz->de.PostordenAux(vec, pos);
        // Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
    }
}

// Realiza una rotación simple a la derecha
void TAVLCalendario::RotDerecha(TNodoAVL *&nodo) {
    TNodoAVL *aux = nodo->iz.raiz;
    nodo->iz.raiz = aux->de.raiz;
    aux->de.raiz = nodo;

    // Actualizamos factores de equilibrio
    nodo->fe = nodo->de.Altura() - nodo->iz.Altura();
    aux->fe = aux->de.Altura() - aux->iz.Altura();

    nodo = aux;
}

// Realiza una rotación simple a la izquierda
void TAVLCalendario::RotIzquierda(TNodoAVL *&nodo) {
    TNodoAVL *aux = nodo->de.raiz;
    nodo->de.raiz = aux->iz.raiz;
    aux->iz.raiz = nodo;

    // Actualizamos factores de equilibrio
    nodo->fe = nodo->de.Altura() - nodo->iz.Altura();
    aux->fe = aux->de.Altura() - aux->iz.Altura();

    nodo = aux;
}

// Realiza una rotación doble a la derecha
void TAVLCalendario::Rot2Derecha(TNodoAVL *&nodo) {
    RotIzquierda(nodo->iz.raiz);
    RotDerecha(nodo);
}

// Realiza una rotación doble a la izquierda
void TAVLCalendario::Rot2Izquierda(TNodoAVL *&nodo) {
    RotDerecha(nodo->de.raiz);
    RotIzquierda(nodo);
}

// Sobrecarga del operador salida
ostream & operator<<(ostream &os, const TAVLCalendario &tavl) {
    os << tavl.Inorden();
    return os;
}
