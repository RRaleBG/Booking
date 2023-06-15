package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import model.Users;
import model.UsersDAL;

public class Login extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

      //response.sendRedirect (request.getContextPath () + "/managerPages/managerPage.jsp"); //.forward (request, response);
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      String username = request.getParameter ("username");
      String password = request.getParameter ("password");
      String poruka = "";

      if (username.isEmpty () || username == null)
      {
         poruka = "Username required!";
         request.setAttribute ("poruka", poruka);
      }

      if (password.isEmpty () || password == null)
      {
         poruka = "Password is required!";
         request.setAttribute ("poruka", poruka);
      }

      if (!poruka.isEmpty ())
      {
         request.setAttribute ("poruka", poruka);
         RequestDispatcher rd = request.getRequestDispatcher ("login.jsp");
         rd.forward (request, response);
      }

      int id = UsersDAL.getId (username, password);

      if (id > 0)
      {
         HttpSession session = request.getSession ();
         UsersDAL baza = new UsersDAL ();
         Users user = new Users ();
         Users korisnik = baza.getByUserName (username);

         user.setUsername (username);
         user.setPassword (password);

         if ((baza.validate (user) == true) && (baza.isInRole (request.getParameter ("username")) == "user"))
         {
            session.setAttribute ("user", user);
            session.setAttribute ("userId", korisnik);
            RequestDispatcher rd = request.getRequestDispatcher ("/userPages/userPage.jsp");
            rd.forward (request, response);
         }

         if ((baza.validate (user) == true) && (baza.isInRole (user.getUsername ()) == "admin"))
         {
            session.setAttribute ("user", user);
            RequestDispatcher rd = request.getRequestDispatcher ("/adminPages/adminPage.jsp");
            rd.forward (request, response);
         }

         if ((baza.validate (user) == true) && (baza.isInRole (user.getUsername ()) == "menager"))
         {
            session.setAttribute ("user", user);
            response.sendRedirect (request.getContextPath () + "/managerPages/managerPage.jsp");
//            RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/managerPage.jsp");
//            rd.forward (request, response);
         }
      }
      else
      {
         poruka = "Login failed!";
         request.setAttribute ("poruka", poruka);
         RequestDispatcher rd = request.getRequestDispatcher ("login.jsp");
         rd.forward (request, response);
      }
   }

   @Override
   public String getServletInfo()
   {
      return "Short description";
   }
}
