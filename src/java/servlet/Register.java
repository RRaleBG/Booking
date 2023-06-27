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
      response.setContentType ("text/html;charset=UTF-8");

      Users user = new Users ();
      UsersDAL upit = new UsersDAL ();

      String firstname = request.getParameter ("firstname");
      String poruka = "";

      poruka = "Username required!";
      request.setAttribute ("poruka", poruka);

      user.setFirstname (request.getParameter ("firstname"));
      user.setLastname (request.getParameter ("lastname"));
      user.setUsername (request.getParameter ("username"));
      user.setEmail (request.getParameter ("email"));
      user.setPassword (request.getParameter ("password"));

      if (upit.registerUser (user) == true)
      {
         response.sendRedirect ("./login.jsp");
      }
      else
      {
         response.sendRedirect ("./error.jsp");
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
