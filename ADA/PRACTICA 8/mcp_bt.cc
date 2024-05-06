// Practica 8 ADA
/**
 * 3 1 6
 * 2 7 1
 * 2 1 8
 * 
 * Crear un almacen global de soluciones parciales
 * inicializado en infinito, en el que se van a ir
 * almacenando.
 * 
 * bt(0, 0, 0, 0) (i, j , k, coste acumulado) k = 0, y va incrementando
 * segun vaya recorriendo.
 * 
 * coste de 0,0 es menor que infinito? Si -> puedo seguir
 * avanzando por esta rama.
 * 
 *  8 1 2
 *  7 x 3
 *  6 5 4
 * Prioridad de movimiento.
 * 
 * solución = <3, x, x, x> 
 *
 * 
 * bt(0, 1, 1, 3) -> 3 + 1 < infinito -> coste de 0,1 
 * 
 * solucion <3, 3, x, x> y seguir repitiendo el proceso. 
 * 
 * Contar los nodos no prometedores (cuando dejo de desarrollar una rama)
 * */


// MIRAR DE REDUCIR ARGUMENTOS CON STRUCTS O ALGO
void maze_bt(int i, int j, int k, int coste, const Matrix &matrix, vector<int> &solActual, vector<vector<long>> &mejorEncontrado, long &mejor, vector<int> &msol, int &ksol){
	if(coste + matrix.pesos[i][j] < mejorEncontrado[i][j]){
		mejorEncontrado[i][j] = coste + matrix.pesos[i][j];
		if(i == matrix.filas - 1 && j == matrix.columnas - 1 && coste + matrix.pesos[i][j] < mejor){ // 2 opciones para considerarlos prometedores
			if(mejorEncontrado[i][j] < mejor){
				msol = solActual;
				ksol = k; // para actualizar los caminos
				mejor = mejorEncontrado[i][j]; // coste de llegar aqui
			}
			// else no mejoran la mejor solucion
		}
		else{
			int dirs[8][2] = {-1, 0,   -1, 1,   0, 1,   1, 1,   1, 0,   1, -1,    0, -1,   -1, -1}; // posiciones a las que desplazarse  
			for(int d = 0; d <= 8; i++){
				id = i + dirs[d][0];
				jd = j + dirs[d][1]; // mirar como hacer esto sin numeros magicos
				if(id >= 0 && id < matrix.filas && jd >= 0 && jd < matrix.columnas){
					solActual[k] = d;
					maze_bt(id, jd, k+1, coste + matrix.pesos[i][j], matrix, solActual, mejorEncontrado, mejor, msol, ksol)
				}
				// else no factible
			}
		}
	}
	// else no prometedor
}

int main(){

	vector<vector<int>> mejorEncontrado (matrix.filas, vector<long>(matrix.columnas, numeric_limits<long>::max())); // revisar si esta bien el numeric limits
	// vector msol con la mejor solucion
	// long mejor --> mejor coste encontrado 
	// solActual --> maxima secuencia de decisiones a tomar --> vector(i * j) de tamaño
	// int ksol = 0  cantidad de decisiones tomadas para msol
	if(procesarArgumentos()){ // arreglar
		if(leerFichero()){
			/**
			 * i 				fila donde estoy
			 * j 				columna donde estoy
			 * k   				celdas visitadas
			 * coste 			coste de llegar a la celda (i,j) sin tener en cuenta la celda (i,j)
			 * matrix 			datos del problema
			 * solActual 		secuencia de decisiones que llevo tomadas
			 * mejorEncontrado 	almacen del mejor coste encontrado hasta el momento para alcanzar cada celda
			 * mejor 			el valor de la mejor solucion encontrada hasta el momento
			 * msol 			secuencia de movimientos de la mejor solucion encontrada hasta el momento
			 * ksol  			cantidad de elementos alamacenados en le vector anterior

			maze_bt(0, 0, 0, 0, matrix, mejorEncontrado);
		}
	}
}