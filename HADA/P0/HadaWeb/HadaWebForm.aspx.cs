using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using HadaBiblioteca;

namespace HadaWeb
{
    public partial class HadaWebForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void bo1_Click(object sender, EventArgs e)
        {
            MiNombre nombre = new MiNombre("HadaWeb");
            String message = "Hello, my name is " + nombre.GetNombre();
            Response.Write(message);
        }
    }
}