package servlet;

import baza.Konekcija;
import java.io.IOException;
import java.sql.Date;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Rezervations;
import model.RezervationsDAL;

public class Rezervation extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
   }

   //
   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

   }

   //
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      Rezervations rez = new Rezervations ();
      RezervationsDAL baza = new RezervationsDAL (Konekcija.createConnection ());
      String poruka = "";

      int idGest = Integer.parseInt (request.getParameter ("idGest"));
      int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
      int idRoom = Integer.parseInt (request.getParameter ("idRoom"));
      Date dateCheckIn = Date.valueOf (request.getParameter ("dateCheckIn"));
      Date dateCheckOut = Date.valueOf (request.getParameter ("dateCheckOut"));
      int price = 200;

      java.sql.Date sqlDate = new java.sql.Date (dateCheckIn.getTime ());
      java.sql.Date sqlDate1 = new java.sql.Date (dateCheckOut.getTime ());

      rez.setIdGest (idGest);
      rez.setIdHotel (idHotel);
      rez.setDateCheckIn (sqlDate);
      rez.setDateCheckOut (sqlDate1);
      rez.setPrice (price);

      if (baza.addReservation (rez))
      {

         poruka = "Congratulations, have a nice holiday!";

         request.setAttribute ("poruka", poruka);
         RequestDispatcher rd = request.getRequestDispatcher ("/userPages/userPage.jsp");
         rd.forward (request, response);
      }
      else
      {
         poruka = "Something went wrong!";

         request.setAttribute ("poruka", poruka);
         response.sendRedirect ("userPages/reserveRoom.jsp?idRoom=" + idRoom + "&idHotel=" + idHotel);

      }
   }

   //
   @Override
   public String getServletInfo()
   {
      return "Short description";
   }

}
