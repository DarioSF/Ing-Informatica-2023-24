//74392984J Dario Simon Franco
#include "tabbcalendario.h"

using namespace std;

/* TNodoABB	*/

//	Constructor por defecto
TNodoABB::TNodoABB():item(), de(), iz(){
	// No hace falta mas codigo
}

//	Constructor de copia
TNodoABB::TNodoABB(TNodoABB &nodo):item(nodo.item), iz(nodo.iz), de(nodo.de){
	// No hace falta mas codigo
}

//	Destructor
TNodoABB::~TNodoABB(){
	// No hace falta mas codigo
}

//	Operador de asignacion
TNodoABB& TNodoABB::operator=(const TNodoABB &nodo){
	// Evitamos autoasignacion
    if(this != &nodo){
        // Liberar la memoria del nodo actual
        this->~TNodoABB();
        // Copiar los datos del nodo
        this->item = nodo.item;
        this->iz = nodo.iz;
        this->de = nodo.de;
    }
    return *this;
}

/*	TABBCalendario	*/

//	Constructor por defecto
TABBCalendario::TABBCalendario(){
	this->raiz = NULL;
}

//	Constructor de copia
TABBCalendario::TABBCalendario(const TABBCalendario &arbol){
    if(!arbol.EsVacio()){
        this->raiz = new TNodoABB();
        this->raiz->item = arbol.raiz->item;
        this->raiz->iz = arbol.raiz->iz;
        this->raiz->de = arbol.raiz->de;
    }
    else this->raiz = NULL;
}

// 	Destructor
TABBCalendario::~TABBCalendario(){
	// Llamar a la funcion auxiliar que gestiona la memoria
    VaciarNodo(raiz);
    // Cambiar la raiz a NULL
    //raiz = NULL;
}

//	Operador asignacion
TABBCalendario& TABBCalendario::operator=(const TABBCalendario &arbol){
    // Evitamos autoasignacion
    if(this != &arbol){
    	// Eliminamos memoria
        this->~TABBCalendario();
        // Realizamos la asignacion de datos
        if(!arbol.EsVacio()){
            this->raiz = new TNodoABB();
            this->raiz->item = arbol.raiz->item;
            this->raiz->iz = arbol.raiz->iz;
            this->raiz->de = arbol.raiz->de;
        }
        else this->raiz = NULL;
    }
    // Devolvemos el objeto al que apunta this
    return *this;
}

//	Para comprobar si el arbol esta vacio
bool TABBCalendario::EsVacio() const{
	// Check para la raiz
	if(this->raiz == NULL) return true;
	// Si llega hasta aqui el arbol no esta vacio
	return false;
}


//  Para insertar un TCalendario en el arbol
bool TABBCalendario::Insertar(const TCalendario &cal){
    // Check para ver si el arbol es vacio
    if(EsVacio()){
        // Creamos la raiz
        raiz = new TNodoABB();
        raiz->item = cal;
        // Devolvemos true porque se ha insertado correctamente
        return true;
    }
    else{
        // Buscamos el TCalendaraio
        if(!Buscar(cal)){
            // Si no esta, lo insertamos
            if(this->raiz->item > cal){
                // Subarbol izquierda
                if(raiz->iz.Insertar(cal)) return true;
            }
            else{
                // Subarbol derecha
                if(raiz->de.Insertar(cal)) return true;
            }
        }
    }
    // Si llegamos hasta aqui, no se ha insertado el TCalendario
    return false;
}

//	Para borrar un nodo
bool TABBCalendario::Borrar(const TCalendario &cal) {
    if(!EsVacio() && Buscar(cal)){
        // Buscamos el nodo a borrar
        if(raiz->item > cal) return raiz->iz.Borrar(cal); // Si el elemento está en el subárbol izquierdo
        else if(raiz->item < cal) return raiz->de.Borrar(cal); // Si el elemento está en el subárbol derecho
        else{
            // Nodo encontrado, procedemos a borrarlo
            // Caso 1: nodo hoja, simplemente lo eliminamos
            if(raiz->iz.EsVacio() && raiz->de.EsVacio()){
                delete raiz;
                raiz = NULL;
            }
            // Caso 2: el nodo tiene un hijo derecho, reemplazamos por el hijo derecho
            else if(raiz->iz.EsVacio()){
                TNodoABB *temp = raiz;
                raiz = raiz->de.raiz;
                // Evitamos la eliminación doble
                temp->de.raiz = NULL;
                delete temp;
            }
            // Caso 3: el nodo tiene un hijo izquierdo, reemplazamos por el hijo izquierdo 
            else if(raiz->de.EsVacio()){
                TNodoABB *temp = raiz;
                raiz = raiz->iz.raiz;
                // Evitamos la eliminación doble
                temp->iz.raiz = NULL;
                delete temp;
            } 
            // Caso 4: el nodo tiene ambos hijos
            else{
                TNodoABB *temp = raiz->de.raiz;
                while (!temp->iz.EsVacio()) {
                    temp = temp->iz.raiz;
                }
                raiz->item = temp->item;
                raiz->de.Borrar(temp->item);
            }
            // Si llegamos hasta aqui el nodo se borra correctamente
            return true;
        }
    }
    // Si llegamos hasta aqui el elemento no esta en el arbol
    return false;
}

//	Para buscar un nodo
bool TABBCalendario::Buscar(const TCalendario &cal) const{
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


// 	Para devolver la raiz del arbol
TCalendario TABBCalendario::Raiz() const{
	return this->raiz->item;
}

//	Para calcular la altura del arbol
int TABBCalendario::Altura() const{
	// Si es vacio la altura es 0
    if(this->EsVacio()) return 0;
    // Recorremos el arbol sumando 1 cada vez que aumente la altura
    else{
        int alturaIZ = this->raiz->iz.Altura();
        int alturaDE = this->raiz->de.Altura();
        return 1 + (alturaIZ > alturaDE ? alturaIZ : alturaDE);
    }
}

//	Para calcular la cantidad de nodos
int TABBCalendario::Nodos() const{
	// Si es vacio la cantidad es 0
    if(EsVacio()) return 0;
    // Recorremos el arbol sumando los nodos
    else{
        int nodosIZ = raiz->iz.Nodos();
        int nodosDE = raiz->de.Nodos();
        return 1 + nodosIZ + nodosDE;
    }
}

//	Para calcular la cantidad de nodos hoja
int TABBCalendario::NodosHoja() const {
	// Si es vacio la cantidad es 0
    if(EsVacio()) return 0;
    // Si no tiene hijos es un nodo hoja
  	else if(raiz->iz.EsVacio() && raiz->de.EsVacio()) return 1;
    // Si no tiene hijos, sumamos los de los subárboles
    return raiz->iz.NodosHoja() + raiz->de.NodosHoja();
}

//	Para calcular el recorrido Inorden
TVectorCalendario TABBCalendario::Inorden() const {
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

//	Para calcular el recorrido Preorden
TVectorCalendario TABBCalendario::Preorden() const{
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

//	Para calcular el recorrido Postorden
TVectorCalendario TABBCalendario::Postorden() const{
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

//	Para realizar el recorrido por niveles
TVectorCalendario TABBCalendario::Niveles() const{
	// Creamos un vector con el tamaño de los nodos
    TVectorCalendario vec(Nodos());
    int i;
    // Si esta vacio, devolvemos un vector vacio
    if(EsVacio()) return vec;
    // Usamos una cola de punteros a nodos
    queue<const TNodoABB*> q;
    q.push(raiz);
    i = 1;
    // Iteramos hasta acabar con la cola
    while(!q.empty()){
        const TNodoABB* nodoActual = q.front();
        q.pop();
        vec[i] = nodoActual->item;
        // Procesamos los datos
        if(nodoActual->iz.raiz != NULL) q.push(nodoActual->iz.raiz);
        if(nodoActual->de.raiz != NULL) q.push(nodoActual->de.raiz);
        i++;
    }
    return vec;
}

//	Operador igual que
bool TABBCalendario::operator==(const TABBCalendario &arbol){
	// Check para ver si la raiz es la misma
	if(this->Inorden() != arbol.Inorden()) return false;
	// Si llega aqui son iguales
	return true;
}

//	Sobrecarga del operador suma
TABBCalendario TABBCalendario::operator+ (const TABBCalendario &arbol) const{
    // Creamos una copia del primer árbol
    TABBCalendario result(*this);
    // Obtenemos los nodos del segundo arbol en un vector
    TVectorCalendario listaNodos = arbol.Inorden();
    // Insertamos cada nodo del segundo arbol en el primer arbol
    for(int i = 1; i <= listaNodos.Tamano(); i++) result.Insertar(listaNodos[i]);
  	// Devolvemos el resultado
    return result;
}

//	Sobrecarga del operador resta
TABBCalendario TABBCalendario::operator- (const TABBCalendario &arbol) const{
	// Creamos los nodos del segundo arbol en un vector
    TVectorCalendario listaNodos = Inorden();
    // Arbol resultado
    TABBCalendario res;
    // Recorremos la lista de nodos
    for(int i = 1; i <= listaNodos.Tamano(); i++) {
        TCalendario cal = listaNodos[i];
        // Insergamos cada nodo en el arbol resultado
        if(!arbol.Buscar(cal)) res.Insertar(cal);
    }
    // Devolvemos el resultado
    return res;
}


// AUX

//	Para gestionar la liberacion de memoria
void TABBCalendario::VaciarNodo(TNodoABB *nodo){
	// Para guardar la raiz
    TNodoABB *borrar = new TNodoABB();
    // Mientras no sea vacio vamos borrando nodos
    while(!EsVacio()){
        borrar = this->raiz;   
        this->raiz->iz.~TABBCalendario();
        this->raiz->de.~TABBCalendario();
        delete this->raiz;
        this->raiz = NULL;
    }
}

//	Funcion auxiliar para calcular Inorden
void TABBCalendario::InordenAux(TVectorCalendario &vec, int &pos) const {
    if(!EsVacio()){
    	// Recorremos el subarbol izquierdo
        raiz->iz.InordenAux(vec, pos);
        // Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
        // Recorremos el subarbol derecho
        raiz->de.InordenAux(vec, pos);
    }
}

//	Funcion auxiliar para calcular Preorden
void TABBCalendario::PreordenAux(TVectorCalendario &vec, int &pos) const{
	if(!EsVacio()){
		// Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
        // Recorremos el subárbol izquierdo
        raiz->iz.PreordenAux(vec, pos);
        // Recorremos el subárbol derecho
        raiz->de.PreordenAux(vec, pos);
    }
}

//	Funcion auxiliar para calcular Postorden
void TABBCalendario::PostordenAux(TVectorCalendario &vec, int &pos) const {
    if(!EsVacio()){
    	// Recorremos el subárbol izquierdo
        raiz->iz.PostordenAux(vec, pos);
        // Recorremos el subárbol derecho
        raiz->de.PostordenAux(vec, pos);
        // Almacenamos el elemento actual en el vector y aumentamos la posición
        vec[pos++] = raiz->item;
    }
}

// FRIEND
ostream& operator<<(ostream &os, const TABBCalendario &obj){
    TABBCalendario abb(obj);
    os << abb.Niveles();
    return os;
}