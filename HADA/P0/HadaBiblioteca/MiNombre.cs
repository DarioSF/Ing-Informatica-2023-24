using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace HadaBiblioteca
{
    public class MiNombre
    {
        string Nombre;

        public MiNombre(string nombre)
        {
            this.Nombre = nombre;
        }

        public string GetNombre()
        {
            return Nombre;
        }

        public void Write()
        {
            Console.WriteLine("My name is {0}", GetNombre());
        }

    }
}
