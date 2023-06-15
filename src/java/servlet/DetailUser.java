package servlet;

import baza.Konekcija;
import java.io.*;
import static java.lang.System.out;
import javax.servlet.*;
import javax.servlet.http.*;
import model.RezervationsDAL;
import model.UsersDAL;

public class DetailUser extends HttpServlet
{

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType ("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        doPost (request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        int id = Integer.parseInt (request.getParameter ("id"));

        String firstname = request.getParameter ("firstname");
        String lastname = request.getParameter ("lastname");
        String username = request.getParameter ("username");
        String email = request.getParameter ("email");

        try
        {
            UsersDAL detailUser = new UsersDAL ();

            if (detailUser.getByUserId (id) != null)
            {
                response.sendRedirect (request.getContextPath () + "/adminPages/adminPage.jsp");
            }
            else
            {
                out.print ("Not exist!");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace ();
        }

        try
        {
            RezervationsDAL rez = new RezervationsDAL (Konekcija.createConnection ());

            if (rez.getAllRezervations () != null)
            {
                response.sendRedirect (request.getContextPath () + "/adminPages/adminPage.jsp");
            }
            else
            {
                out.print ("Nothing in the list!");
            }
        }
        catch (Exception e)
        {
            e.printStackTrace ();
        }
    }

    @Override
    public String getServletInfo()
    {
        return "Short description";
    }

}
