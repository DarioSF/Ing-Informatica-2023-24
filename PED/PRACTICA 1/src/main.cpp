#include "tcalendario.h"

using namespace std;

int main(){
	TCalendario c(1,1,2000, NULL);
	cout << c.Dia() << "/" << c.Mes() << "/" << c.Anyo() <<  endl;
	int op_suma = 366;
	cout << "TEST operador + " << op_suma << endl;
	c = c + op_suma;
	cout << c.Dia() << "/" << c.Mes() << "/" << c.Anyo() <<  endl;
	return 0;
}