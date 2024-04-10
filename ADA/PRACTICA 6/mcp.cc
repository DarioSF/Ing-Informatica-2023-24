// 74392984J Dario Simon Franco

#include <iostream>
#include <vector>
#include <limits>
#include <fstream>
using namespace std;

enum Error{
	ERR_MISS,
	ERR_OPEN,
	ERR_ARGS,
	ERR_OPTI,
};

struct Matrix{
	int rows;
	int columns;
	vector<vector<int>> weights;
};

struct Path{
	int rows;
	int columns;
	vector<vector<char>> path;
};

struct Arguments{
	bool p2d;
	bool t;
	bool naive;
	string fileName;
};

// FUNCIONES
void printError(int error);
void printError(int error, string reason);
void printUsage();
bool processArguments(int argc, char *argv[], Arguments &args);
bool readFile(string fileName, Matrix &mat);
void printMatrix(const Matrix &mat);
long minimum(long x , long y,  long z);
long mcp_naive(const Matrix &mat, int i, int j);
long mcp_memo(const Matrix &mat, int i, int j, vector<vector<long>> &almacen);
void printPath(const vector<vector<char>> &path);
void printAlmacen(const vector<vector<long>> &almacen);
long mcp_it_matrix(const Matrix &matrix);
long mcp_it_vector(const Matrix &matrix);
void mcp_parser(const vector<vector<long>> &mat, const Matrix &matrix);

// MAIN
int main(int argc, char *argv[]){
	Arguments args;
	Matrix mat;
	long naive; 
	long memo;
	long itMat;
	long itVec;
	vector<vector<long>> almacen;
	if(processArguments(argc, argv, args)){
		if(readFile(args.fileName, mat)){
			if(!args.naive){	
				naive = mcp_naive(mat, mat.rows - 1, mat.columns - 1);
				cout << naive;
			}
			else cout << "-";
			almacen = vector<vector<long>>(mat.rows, vector<long>(mat.columns, -1));
			memo = mcp_memo(mat, mat.rows - 1, mat.columns - 1, almacen);
			itMat = mcp_it_matrix(mat);
			itVec = mcp_it_vector(mat);
			cout << " " << memo;
			cout << " " << itMat;
			cout << " " << itVec;
			cout << endl;
			if(args.p2d) mcp_parser(almacen, mat);
			almacen[0][0] = mat.weights[0][0];
			if(args.t) printAlmacen(almacen);
 		}
	}
	return 0;
}

// Funcion para imprimir los distintos errores
void printError(int error){
	switch(error){
		case ERR_MISS: cerr << "ERROR: Missing file.";
		break;
		case ERR_OPEN: cerr << "ERROR: Can't open file: ";
		break;
		case ERR_ARGS: cerr << "ERROR: Missing args.";
		break;
		case ERR_OPTI: cerr << "ERROR: Unkown option: ";
		break;
	}
}

// Sobrecarga para añadir el motivo de los errores que lo necesiten
void printError(int error, string reason){
	printError(error);
	cerr << reason << "." << endl;
	printUsage();
}

// Imprimir la manera de lanzar el programa por consola
void printUsage(){
	cerr << "Usage:" << endl << "mcp [--p2D] [-t] [--ignore-naive] -f file" << endl;
}

void printPath(const vector<vector<char>> &path){
	for(vector<char> row : path){
        for(char c : row)
            cout << c;
        cout << endl;
    }
}

void printAlmacen(const vector<vector<long>> &almacen){
	for(vector<long> row : almacen){
		for(long n : row)
			cout << abs(n) << " ";
		cout << endl;
	}
}

// Procesar los argumentos y lanzar los errores
bool processArguments(int argc, char *argv[], Arguments &args){
	// Flag para parar el bucle
	bool correcto = true;
	// Inicializar el struct para los argumentos
	args.p2d = false;
	args.t = false;
	args.naive = false;
	args.fileName = "";
	// Recorrer los argumentos
	for(int i = 1; i < argc && correcto; i++){
		string arg = argv[i];
		if(arg == "--p2D"){
			args.p2d = true;
		}
		else if(arg == "--ignore-naive"){
			args.naive = true;
		}
		else if(arg == "-t"){
			args.t = true;
		}
		else if(arg == "-f"){
			i++;
			if(i < argc) args.fileName = argv[i];
			// Imprimir error: falta fichero
			else{
				correcto = false;
				printError(ERR_MISS);
				printUsage();
			}
		}
		// Imprimir error: opcion no valida
		else{
			correcto = false;
			printError(ERR_OPTI, arg);
		}
	}	
	return correcto;
}

// Procesar la entrada del fichero
bool readFile(string fileName, Matrix &mat){
	// Abrimos el fichero
    ifstream file(fileName);
    // Si no se puede abrir emitimos el error y devolvemos FALSE
    if (!file.is_open()){
        printError(ERR_OPEN, fileName);
        return false;
    }
    // Procesamos la entrada
    file >> mat.rows >> mat.columns;
    mat.weights = vector<vector<int>>(mat.rows, vector<int>(mat.columns, 0));
    for (int i = 0; i < mat.rows; ++i){
        for (int j = 0; j < mat.columns; ++j){
            file >> mat.weights[i][j];
        }
    }
    // Cerramos el fichero y devolvemos TRUE
    file.close();
    return true;
}

// Imprimir la matriz
void printMatrix(const Matrix &matrix){
	cout << matrix.rows << " " << matrix.columns << endl;
	for(vector<int> row : matrix.weights){
		for(int w : row) cout << w << " ";
		cout << endl;
	}
}

// Devuelve el minimo de 3 valores
long minimum(long x, long y, long z) { 
    return (x < y) ? ((x < z) ? x : z) : ((y < z) ? y : z);
}

// MCP_NAIVE
long mcp_naive(const Matrix &mat, int i, int j) {
    if (i == 0 && j == 0) return mat.weights[0][0];
    long result = 0;
    if (i == 0) result = mat.weights[i][j] + mcp_naive(mat, i, j - 1);
    else if (j == 0) result = mat.weights[i][j] + mcp_naive(mat, i - 1, j);
    else result = mat.weights[i][j] + minimum(mcp_naive(mat, i - 1, j), mcp_naive(mat, i, j - 1), mcp_naive(mat, i - 1, j - 1));
    return result;
}
// MCP_MEMO
long mcp_memo(const Matrix &mat, int i, int j, vector<vector<long>> &almacen){
	long result;
	if(i == 0 && j == 0){
		return mat.weights[0][0];
	} 
	if(almacen[i][j] == -1){	
		if(i == 0){
			result = mat.weights[i][j] + mcp_memo(mat, i, j - 1, almacen);
		} 

		else if(j == 0) result = mat.weights[i][j] + mcp_memo(mat, i - 1, j, almacen);
		else result = mat.weights[i][j] + minimum(mcp_memo(mat, i - 1, j, almacen), mcp_memo(mat, i, j - 1, almacen), mcp_memo(mat, i - 1, j - 1, almacen));
		almacen[i][j] = result;
	}
	else result = almacen[i][j];
	return result;	
}

long mcp_it_matrix(const Matrix &matrix){
    vector<vector<long>> mat(matrix.rows, vector<long>(matrix.columns, 0));
    mat[0][0] = matrix.weights[0][0];
    for (int j = 1; j < matrix.columns; j++)
        mat[0][j] = matrix.weights[0][j] + mat[0][j - 1];
    for (int i = 1; i < matrix.rows; i++)
        mat[i][0] = matrix.weights[i][0] + mat[i - 1][0];
    for (int i = 1; i < matrix.rows; i++){
        for (int j = 1; j < matrix.columns; j++)
            mat[i][j] = matrix.weights[i][j] + min(mat[i - 1][j], min(mat[i][j - 1], mat[i - 1][j - 1]));
    }
    return mat[matrix.rows - 1][matrix.columns - 1];
}

long mcp_it_vector(const Matrix &matrix){
    vector<long> vec1(matrix.columns);
    vector<long> vec2(matrix.columns);
    for(int j = 0; j < vec1.size(); j++){
        if(j == 0) vec1[0] = matrix.weights[0][0];
        else vec1[j] = matrix.weights[0][j] + vec1[j - 1];
    }
    
    for(int i = 1; i < matrix.rows; i++){
        for(int j = 0; j < matrix.columns; j++){
            if(j == 0) vec2[j] = vec1[j] + matrix.weights[i][j];
            else vec2[j] = matrix.weights[i][j] + min(vec1[j], min(vec1[j-1], vec2[j-1]));
        }
        swap(vec1, vec2);
    }
    return vec1.back();
}

void mcp_parser(const vector<vector<long>> &mat, const Matrix &matrix){
	vector<vector<char>> path(matrix.rows, vector<char>(matrix.columns, '.'));
    int i = matrix.rows - 1;
    int j = matrix.columns - 1;;
    long vec1; 
    long vec2;
    long vec3;
    long res = 0;  
    while(i != 0 || j != 0){
        res += matrix.weights[i][j];
        path[i][j] = 'x';
        if(j == 0) i--;
        else{
            if (i == 0) j--;
            else{
                vec1 = mat[i - 1][j];
                vec2 = mat[i - 1][j - 1];
                vec3 = mat[i][j - 1];
                if(vec1 <= vec2 && vec1 <= vec3) i--;
                else{
                    if(vec2 <= vec1 && vec2 <= vec3){
                    	i--;
                    	j--;
                    }
                    else j--;
                }
            }
        }
    }
    res += matrix.weights[0][0];
    path[0][0] = 'x';
    printPath(path);
    cout << res << endl;
}
