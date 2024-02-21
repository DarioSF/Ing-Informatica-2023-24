// DARIO SIMON FRANCO 74392984J

#include <unistd.h>
#include <iostream>
#include <math.h>

using namespace std;

/****************************************************************************
 *                                                                          *
 * ADA 2023-24                                                              *
 * Práctica 1: "Empirical analysis of Quicksort average-time complexity."   *
 *                                                                          *
 ****************************************************************************/

//  Middle QuickSort
void middle_QuickSort(int * v, long left, long right){

    long i,j;
    int pivot,aux; 
    if (left<right)
    {
        i=left; j=right;
        pivot=v[(i+j)/2];
        do
        {
            while (v[i]<pivot) i++;
            while (v[j]>pivot) j--;
            if (i<=j)
            {
                aux=v[i]; v[i]=v[j]; v[j]=aux;
                i++; j--;
            }
       } while (i<=j);
       if (left<j)  middle_QuickSort(v,left,j);
       if (i<right) middle_QuickSort(v,i,right);
    }
}

int main(void){
    //  Semilla para la funcion rand()
    srand(0);
    //  Para mostrar los datos por terminal ordenados
    cout << "# BubbleSort CPU times in milliseconds:"
        << endl
        << "# Size \t CPU time (ms.)"
        << endl
        << "# ----------------------------"
        << endl;
    //  For para crear vectores de distintos tamaños
    for(int exp = 15; exp < 21; exp++){
        //  Tamaño del vector
        size_t tam = size_t(pow(2,exp));
        //  Crear el vector
        int * vec = new int [tam];
        if(!vec){
            cerr << "Error, not enough memory!" << endl;
            exit (EXIT_FAILURE);  
        }
        //  Tabulaciones y limpiar el buffer
        cout << tam << "\t\t" << std::flush;
        //  Tiempo de CPU
        clock_t sum = 0;
        //  For para repetir el ejercicio 30 veces
        for(int i = 1; i <= 30; i++){
            //  For para generar datos aleatorios
            for (size_t j = 0; j < tam; j++){ 
                v[j] = rand();
            }
            //  Inicio el calculo el tiempo de ejecucion
            auto begin = clock();
            //  Se ordenan los datos
            middle_QuickSort(v, 0, tam-1);
            //  Parar de contar tiempo de CPU
            auto finish = clock();
            //  Ajustar el tiempo en milisegundos
            sum += 1000.0 * (finsh-begin) / CLOCKS_PER_SEC;
            //  Para comprobar el que vector esta ordenado correctamente 
            for (size_t i = 1; i < tam; i++){
                if (vec[i] < v[i-1]){ 
                    //  Mensaje de error
                    cerr << "Panic, array not sorted! " << i << endl; 
                    exit(EXIT_FAILURE);
                }
            }
        }
        //  Mostrar el tiempo promedio
        cout << sum / 30.0  << endl;
        //  Liberar memoria del vector
        delete [] v;
    }
    return 0;
}


