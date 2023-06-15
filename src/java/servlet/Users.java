package servlet;

import baza.Konekcija;
import java.io.*;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import model.Rezervations;
import model.RezervationsDAL;
import model.UsersDAL;

public class Users extends HttpServlet
{
    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType ("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter ())
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
                    response.sendRedirect (request.getContextPath () + "/userPages/userPage.jsp");
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

                List<Rezervations> listaRez = rez.getAllRezervationsFromUserId (id);

                if (!listaRez.isEmpty ())
                {
                    response.sendRedirect (request.getContextPath () + "/userPages/userPage.jsp");
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
    }

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        int userId = Integer.parseInt (request.getParameter ("userId"));

        String firstname = request.getParameter ("firstname");
        String lastname = request.getParameter ("lastname");
        String username = request.getParameter ("username");
        String email = request.getParameter ("email");

        try
        {
            UsersDAL detailUser = new UsersDAL ();

            if (detailUser.getByUserId (userId) != null)
            {
                response.sendRedirect (request.getContextPath () + "/userPages/userPage.jsp");
            }
            else
            {
                response.sendError (userId);
            }
        }
        catch (Exception e)
        {
            e.printStackTrace ();
        }

        try
        {
            RezervationsDAL rez = new RezervationsDAL (Konekcija.createConnection ());

            List<Rezervations> listaRez = rez.getAllRezervationsFromUserId (userId);

            if (!listaRez.isEmpty ())
            {
                response.sendRedirect (request.getContextPath () + "/userPages/userPage.jsp");
            }
            else
            {
                response.sendError (userId);
            }
        }
        catch (Exception e)
        {
            response.sendError (userId);
        }
    }


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        processRequest (request, response);
    }

    @Override
    public String getServletInfo ()
    {
        return "Short description";
    }
}
