#ifndef TAVLCALENDARIO_H
#define TAVLCALENDARIO_H

#include "tcalendario.h"
#include "tvectorcalendario.h"

class TAVLCalendario;

class TNodoAVL {
    friend class TAVLCalendario;

private:
    TCalendario item;  // El elemento (etiqueta) del nodo
    TAVLCalendario iz; // Subárbol izquierdo 
    TAVLCalendario de;  // Subárbol derecho
    int fe;  // Factor de equilibrio

public:
    TNodoAVL();  // Constructor por defecto
    TNodoAVL(const TNodoAVL &);  // Constructor copia
    ~TNodoAVL();  // Destructor
    TNodoAVL & operator=(const TNodoAVL &);  // Sobrecarga del operador asignación

    bool EsHoja() const;  // Comprueba si el nodo es hoja
};

class TAVLCalendario {
private:
    TNodoAVL *raiz;  // Puntero al nodo raíz

    void InordenAux(const TVectorCalendario &, int &);  // AUXILIAR: devuelve el recorrido en INORDEN
    void PreordenAux(const TVectorCalendario &, int &);  // AUXILIAR: devuelve el recorrido en PREORDEN
    void PostordenAux(const TVectorCalendario &, int &);  // AUXILIAR: devuelve el recorrido en POSTORDEN

    void Copiar(const TAVLCalendario &);  // Método para copiar un árbol AVL
    TNodoAVL* BuscarPunteroNodo(TCalendario, TNodoAVL *);  // Método para buscar un nodo por su valor
    void RotacionSimpleDerecha(TNodoAVL *&);  // Realiza una rotación simple a la derecha
    void RotacionSimpleIzquierda(TNodoAVL *&);  // Realiza una rotación simple a la izquierda
    void RotacionDobleDerecha(TNodoAVL *&);  // Realiza una rotación doble a la derecha
    void RotacionDobleIzquierda(TNodoAVL *&);  // Realiza una rotación doble a la izquierda

public:
    TAVLCalendario();  // Constructor por defecto
    TAVLCalendario(const TAVLCalendario &);  // Constructor de copia
    ~TAVLCalendario();  // Destructor
    TAVLCalendario & operator=(const TAVLCalendario &);  // Sobrecarga del operador asignación

    bool operator==(const TAVLCalendario &) const;  // Sobrecarga del operador igualdad
    bool operator!=(const TAVLCalendario &) const;  // Sobrecarga del operador desigualdad

    bool EsVacio() const;  // Devuelve TRUE si el árbol está vacío, FALSE en caso contrario
    bool Insertar(const TCalendario &);  // Inserta el elemento en el árbol
    bool Buscar(const TCalendario &) const;  // Devuelve TRUE si el elemento está en el árbol, false en caso contrario
    int Altura() const;  // Devuelve la altura del árbol (la altura de un árbol vacío es 0)
    int Nodos() const;  // Devuelve el número de nodos del árbol (un árbol vacío posee 0 nodos)
    int NodosHoja() const;  // Devuelve el número de nodos hoja en el árbol (la raíz puede ser nodo hoja)
    TVectorCalendario Inorden() const;  // Devuelve el recorrido en INORDEN sobre un vector
    TVectorCalendario Preorden() const;  // Devuelve el recorrido en PREORDEN sobre un vector
    TVectorCalendario Postorden() const;  // Devuelve el recorrido en POSTORDEN sobre un vector
    bool Borrar(TCalendario &);  // Borra un TCalendario del árbol AVL
    TCalendario Raiz() const;  // Devuelve el elemento TCalendario raíz del árbol AVL

    friend ostream & operator<<(ostream &, const TAVLCalendario &);  // Sobrecarga del operador salida
};

#endif
