//	74392984J DARIO SIMON FRANCO

/****************************************************************************
 *																			*
 * ADA. 2023-24																*
 * Práctica 2:"Empirical analysis by means of program-steps account of two	*
 * sorting algorithms: Middle-Quicksort and Heapsort."						*
 * 																			*
 ****************************************************************************/

#include <unistd.h>
#include <iostream>
#include <math.h>
#include <iomanip>

using namespace std;

//	Variables para contar los steps
long long quickSteps = 0;
long long heapSteps = 0;
double millon = 1000000.0;

//	Middle Quick Sort
void middle_QuickSort(int * v, long left, long right){
	long i,j;
	int pivot; 
	if (left<right){
		i=left; j=right;
		pivot=v[(i+j)/2];
		do{
			while (v[i]<pivot){
				i++;
				quickSteps++; // Aumentamos los steps
			}
			while (v[j]>pivot){
				j--;
				quickSteps++; // Aumentamos los steps
			}
			if (i<=j){
				swap(v[i], v[j]);
				i++;
				j--;
				quickSteps++; // Aumentamos los steps (solo se hará 1 vez para cuando este al reves)
			}
		}while (i<=j);
		if (left < j)  middle_QuickSort(v,left,j);
		if (i < right) middle_QuickSort(v,i,right);
	}
}
                
//	HEAPSORT
// 	Procedure sink used by Heapsort algorith
// 	Sink an element (indexed by i) in a tree to keep the heap property. n is the size of the heap. 
void sink(int *v, size_t n, size_t i){
	size_t largest;
	size_t l, r; //left and right child

	do{
		heapSteps++; // Aumentamos los steps
		largest = i;  // Initialize largest as root
		l = 2 * i + 1;  // left = 2*i + 1
		r = 2 * i + 2;  // right = 2*i + 2
	    // Is left child larger than root?
	    if (l < n && v[l] > v[largest])	largest = l;
	    // Is right child larger than largest so far
	    if (r < n && v[r] > v[largest])	largest = r;
	    // If largest is still root then the process is done
	    if (largest == i) break;
		// If not, swap new largest with current node i and repeat the process with childs. 
		swap(v[i], v[largest]);
		i = largest;  
   }while(true);
}

// Heapsort algorithm (ascending sorting)
void heapSort(int *v, size_t n){
    // Build a MAX-HEAP with the input array
    for (size_t i = n / 2 - 1; true ; i--){
        sink(v, n, i);
        if (i==0) break; //as size_t is unsigned type
	}
  	// A this point we have a HEAP on the input array, let's take advantage of this to sort the array:
    // One by swap the first element, which is the largest (max-heap), with the last element of the vector and rebuild heap by sinking the new placed element on the begin of vector.  
    for (size_t i=n-1; i>0; i--){
		// Move current root to the end.
        swap(v[0], v[i]);
 		// Now largest element is at the end but do not know if the element just moved to the beginning is well placed, so a sink process is required.
		// Note that, at the same time, the HEAP size is reduced one element by one.
        sink(v, i, 0);
		// The procedure ends when HEAP has only one element, the lower of the input array
    }
}

int main(){

	//en middle_QuickSort() el qs_steps++ en los whiles del pivote

	//	Tabla a mostrar
	cout << "#QUICKSORT VERSOS HEAPSORT" << endl 
		 << "#Average processing Msteps (millions of program steps)" << endl
		 << "#Number of samples (arrays of integer): 30" << endl << endl
		 << "#                 RANDOM ARRAYS       SORTED ARRAYS     REVERSE SORTED ARRAYS" << endl
		 << "#             -------------------  -------------------  ---------------------" << endl
		 << "#    Size     QuickSort  HeapSort  QuickSort  HeapSort   QuickSort  HeapSort" << endl
		 << "=============================================================================" << endl;

	for(int exponente = 15; exponente <= 20; exponente++){
		// Para calcular el tamaño de los vectores
		size_t size = size_t(pow(2, exponente));
		// Crear los vectores vacios
		int* vec1 = new int[size];
		int* vec2 = new int[size];
		// Si no hay memoria suficiente no se crean los vectores
		if(!vec1 || !vec2){
			// Mensaje de ERROR
			cerr << "ERROR: Falta memoria para crear los vectores" << endl;
			// Salimos del programa en caso de error
			exit(EXIT_FAILURE);
		}
		// Tabulacion para el formato
		cout.width(9);
		// Imprimir el tamaño actual
		cout << size;
		// Inicializar los valores de los contadores
		quickSteps = 0;
		heapSteps = 0;
		// Calcular el tiempo medio de ejecucion para las 30 muestras
		for(size_t i = 1; i <= 30; i++){
			for(size_t j = 0; j < size; j++){
				// Para que los dos vectores sean iguales
				vec1[j] = vec2[j] = rand();
			}
			// Llamamos a las funciones de sorting
			// QuickSort
			middle_QuickSort(vec1, 0, size - 1);
			// HeapSort
			heapSort(vec2, size);
		}
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de QuickSort
		cout << std::fixed << std::setprecision(3) << quickSteps / millon;
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de HeapSort
		cout << std::fixed << std::setprecision(3) << heapSteps / millon;
		// Inicializamos los valores de los contadores
		quickSteps = 0;
		heapSteps = 0;
		// Los vectores están ordenados
		middle_QuickSort(vec1, 0, size - 1);
		heapSort(vec2, size);
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de QuickSort
		cout << std::fixed << std::setprecision(3) << quickSteps / millon;
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de HeapSort
		cout << std::fixed << std::setprecision(3) << heapSteps / millon;
		// Generar los vectores al reves
		for(size_t j = 0; j < size; j++){
			vec1[j] *= -1;
			vec2[j] *= -1;
		}
		// Inicializar los valores de los contadores
		quickSteps = 0;
		heapSteps = 0;
		// Llamamos a las funciones de sorting
		// QuickSort
		middle_QuickSort(vec1, 0, size - 1);
		// HeapSort
		heapSort(vec2, size);
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de QuickSort
		cout << std::fixed << std::setprecision(3) << quickSteps / millon;
		// Tabulacion para el formato
		cout.width(11);
		// Mostrar los pasos por millon de HeapSort
		cout << std::fixed << std::setprecision(3) << heapSteps / millon << endl;

		// Limpiar la memoria de los vectores
		delete[] vec1;
		delete[] vec2;
	}
	return 0;
}