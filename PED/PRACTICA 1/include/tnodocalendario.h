#ifndef _TNODOCALENDARIO_H_
#define _TNODOCALENDARIO_H_

#include <iostream>

using namespace std;

class TNodoCalendario{

	private:
		TCalendario c;
		TNodoCalendario *siguiente;
	public:
		TNodoCalendario();
		TNodoCalendario(TNodoCalendario &);
		~TNodoCalendario();
		TNodoCalendario & operator=(TNodoCalendario &);
};

#endif