package servlet;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import model.Users;
import model.UsersDAL;

public class Register extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      processRequest (request, response);
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      String firstname = request.getParameter ("firstname");
      String lastname = request.getParameter ("lastname");
      String username = request.getParameter ("username");
      String email = request.getParameter ("email");
      String password = request.getParameter ("password");

      Users user = new Users ();
      UsersDAL upit = new UsersDAL ();

      String poruka = "";

      if (firstname == null || firstname == "")
      {
         poruka = "First name missing";
      }

      if (lastname.isEmpty () || lastname == null)
      {
         poruka = "Last name missing";
      }

      if (username.isEmpty () || username == null)
      {
         poruka = "Username missing";
      }

      if (email.isEmpty () || email == null)
      {
         poruka = "Email missing";
      }

      if (password.isEmpty () || password == null)
      {
         poruka = "Password missing";
      }

      if (password.equals (password))
      {
         user.setFirstname (firstname);
         user.setLastname (lastname);
         user.setUsername (username);
         user.setEmail (email);
         user.setPassword (password);

         if (upit.registerUser (user) == true)
         {
            response.sendRedirect ("./login.jsp");
         }
         else
         {
            response.sendRedirect ("./error.jsp");
         }
      }
      else
      {
         poruka = "Registration failed. Please try again";
         request.setAttribute ("poruka", poruka);

         RequestDispatcher rd = request.getRequestDispatcher ("./register.jsp");
         rd.forward (request, response);
      }

      if (!poruka.isEmpty ())
      {
         request.setAttribute ("poruka", poruka);
         RequestDispatcher rd = request.getRequestDispatcher ("register.jsp");
         rd.forward (request, response);
      }
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      processRequest (request, response);
   }

   @Override
   public String getServletInfo()
   {
      return "Short description";
   }

}
