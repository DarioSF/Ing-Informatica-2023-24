//DARIO SIMON FRANCO 743392984J
#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

// STRUCTS

struct Matrix{
	int rows;
	int cols;
	vector<vector<int>> weights;
};

/* ------ DECLARACIONES ------ */

bool processArguments(int argc, char *argv[], bool &p2d, string &fileName);
bool readFile(const string& fileName, Matrix& mat);
long fromBegining(const Matrix& g, vector<vector<char>>& path);
long fromFinal(const Matrix& g, vector<vector<char>>& path);
void mcp_greedy(const Matrix& g, bool p2d);

/* ------ MAIN ------ */

int main(int argc, char *argv[]){
	bool p2d;
	Matrix mat;
	string fileName;
	bool fine = processArguments(argc, argv, p2d, fileName);
	if(fine){
		fine = readFile(fileName, mat);
		if(fine) mcp_greedy(mat, p2d);
	}
	return 0;
}

/* ------ FUNCIONES ------ */

// Funcion para procesar los argumentos
bool processArguments(int argc, char *argv[], bool &p2d, string &fileName){
    p2d = false;
    fileName.clear();
    for(int i = 1; i < argc; ++i){
        string argument = argv[i];
        if(argument == "--p2D") p2d = true;
        else if(argument == "-f"){
            ++i;
            if(i < argc) fileName = argv[i];
            else{
                cerr << "ERROR: missing filename." << endl;
                return false;
            }
        }
        else{
            cerr << "ERROR: unknown option " << argv[i] << "." << endl;
            return false;
        }
    }
    if(fileName.empty()){
        cerr << "Usage:" << endl;
        cerr << "mcp [--p2D] [-t] [--ignore-naive] -f file" << endl;
        return false;
    }
    return true;
}

// Funcion para leer el fichero
bool readFile(const string& fileName, Matrix& mat){
    ifstream fich(fileName);
    if(fich){
        fich >> mat.rows >> mat.cols;
        mat.weights.clear();
        for(int i = 0; i < mat.rows; ++i){
            vector<int> row;
            for(int j = 0; j < mat.cols; ++j){
                int value;
                fich >> value;
                row.push_back(value);
            }
            mat.weights.push_back(row);
        }
        fich.close();
        return true;
    } 
    else{
        cerr << "ERROR: can't open file: " << fileName << "." << endl;
        cerr << "Usage:" << endl;
        cerr << "mcp [--p2D] [-t] [--ignore-naive] -f file" << endl;
        return false;
    }
}

// Funcion auxiliar para encontrar el camino mas corto de inicio a fin
long fromBegining(const Matrix& g, vector<vector<char>>& path){
    int rows;
    int cols;
    int i;
    int j;
    long coste;
    rows = g.rows;
    cols = g.cols;
    i = 0;
    j = 0;
    coste = 0;
    while(i != rows - 1 || j != cols - 1){
        path[i][j] = 'x';
        coste += g.weights[i][j];
        if(i == rows - 1) ++j;
        else if(j == cols - 1) ++i;
        else{
            int diago = g.weights[i + 1][j + 1];
            int up = g.weights[i + 1][j];
            int side = g.weights[i][j + 1];
            if (diago <= up && diago <= side) {
                ++i;
                ++j;
            }
            else if(side <= diago && side <= up) ++j;
            else ++i;
        }
    }
    path[i][j] = 'x';
    coste += g.weights[i][j];
    return coste;
}

// Funcion auxiliar para encontrar el camino mas corto de fin a inicio
long fromFinal(const Matrix& g, vector<vector<char>>& path){
    int rows;
    int cols;
    int i;
    int j;
    long coste;
    rows = g.rows;
    cols = g.cols;
    i = rows - 1;
    j = cols - 1;
    coste = 0;
    while(i != 0 || j != 0){
        path[i][j] = 'x';
        coste += g.weights[i][j];
        if(i == 0) --j;
        else if(j == 0) --i;
        else{
            int diago = g.weights[i - 1][j - 1];
            int down = g.weights[i - 1][j];
            int side = g.weights[i][j - 1];
            if(diago <= down && diago <= side){
                --i;
                --j;
            } 
           	else if (side <= diago && side <= down) --j;
            else --i;
        }
    }
    path[0][0] = 'x';
    coste += g.weights[0][0];
    return coste;
}

// Funcion principal
void mcp_greedy(const Matrix& g, bool p2d){
    vector<vector<char>> beginEnd(g.rows, vector<char>(g.cols, '.'));
    vector<vector<char>> endBegin(g.rows, vector<char>(g.cols, '.'));
    long desdeInicio = fromBegining(g, beginEnd);
    long desdeFinal = fromFinal(g, endBegin);
    cout << desdeInicio << " " << desdeFinal << endl;
    if(p2d){
        if(desdeFinal <= desdeInicio){
            for(const auto& fila : beginEnd){
                for(char elemento : fila) cout << elemento;
                cout << endl;
            }
            cout << desdeFinal << endl;
        }
        else{
            for(const auto& fila : endBegin){
                for(char elemento : fila) cout << elemento;
                cout << endl;
            }
            cout << desdeInicio << endl;
        }
    }
}