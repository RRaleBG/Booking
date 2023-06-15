package servlet;

import baza.Konekcija;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import model.Users;
import model.UsersDAL;

public class Admin extends HttpServlet
{
    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        response.setContentType ("text/html;charset=UTF-8");
   }

    @Override
    protected void doGet (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        processRequest (request, response);
    }

    @Override
    protected void doPost (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        processRequest (request, response);
    }

    @Override
    public String getServletInfo ()
    {
        return "Short description";
    }
}
