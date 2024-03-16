//	74392984J DARIO SIMON FRANCO

#include <iostream>

using namespace std;

unsigned long steps1 = 0;
unsigned long steps2 = 0;
unsigned long steps3 = 0;

// Coste: θ(log(n))
unsigned long pow2_1(unsigned exp){
	long res;
	// Si el exponente es 0 el resultado es 1
	if(exp == 0) return 1;
	// Llamada recursiva dividiendo el problema por la mitad
	res = pow2_1(exp / 2);
	steps1++;
	res *= res;
	// En caso de exponente impar añadimos una multiplicacion por 2
	if(exp % 2 != 0) res *= 2;
	return res;
}
  
// Coste Θ(n)
unsigned long pow2_2(unsigned exp){
	long res;
	// Si el exponente es 0 el resutlado es 1
	if(exp == 0) return 1;
	// LLamada recursiva reduciendo el problema a en  1
	res = 2 * pow2_2(exp - 1);
	steps2++;
	return res;
}

// Coste: Θ(2^n)
unsigned long pow2_3(unsigned exp){
	long res;
	// Si el exponente es 0 el resutlado es 1
	if(exp == 0) return 1;
	// Llamada recursiva dividiendo el problema en 2 con un tamaño menor cada una
	res = pow2_3(exp - 1) + pow2_3(exp - 1);
	steps3++;
	return res;
}

int main (){
	// Llamo a las funciones con exponentes de 10 a 29
	for(unsigned i = 10; i < 30; i++){
		pow2_1(i);
		pow2_2(i);
		pow2_3(i);
		// Las salidas se almacenan en el archivo pow2.Steps
		cout << i << " ";
		cout.width(10);
		cout << steps1 * 100 << " "; // Multiplico por 100 para que se aprecie en la grafica
		cout.width(10);
		cout << steps2 * 100 << " "; // Multiplico por 100 para que se aprecie en la grafica
		cout.width(10);
		cout << steps3 / 1000 << " ";// Divido por 1000 para que se aprecie en la grafica
		cout << endl;
	}
}