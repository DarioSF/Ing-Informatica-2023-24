#ifndef _TLISTAPOS_H_
#define _TLISTAPOS_H_

#include <iostream>

using namespace std;

class TListaPos{

	private:
		TNodoCalendario *pos;
	public:
		TListaPos();
		TListaPos(TListaPos &);
		~TListaPos();
		TListaPos & operator=(TListaPos &);
		bool operator==(TListaPos &);
		bool operator!=(TListaPos &);
		TListaPos Siguiente();
		bool EsVacia();
};

#endif
