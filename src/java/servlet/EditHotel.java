package servlet;

import baza.Konekcija;
import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import model.Hotel;
import model.HotelDAL;

@MultipartConfig
public class EditHotel extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      response.setContentType ("text/html;charset=UTF-8");
   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      processRequest (request, response);
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      String obavestenje = "";

      int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
      String name = request.getParameter ("name");
      String city = request.getParameter ("city");
      int roomCount = Integer.parseInt (request.getParameter ("roomCount"));
      int stars = Integer.parseInt (request.getParameter ("stars"));
      int parking = Integer.parseInt (request.getParameter ("parking"));
      Part part = request.getPart ("imagePath");
      String imagePath = (part == null) ? "" : part.getSubmittedFileName ();

      if (name.isEmpty ())
      {
         obavestenje = "Name of Hotel missing!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editHotel.jsp");
         rd.forward (request, response);
      }

      if (city.isEmpty ())
      {
         obavestenje = "Name of City missing!";
         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editHotel.jsp");
         rd.forward (request, response);
      }

      if (stars < 1 || stars > 5)
      {
         obavestenje = "Hotel need to have 1 or 5 stars!";
         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editHotel.jsp");
         rd.forward (request, response);
      }

      if (roomCount < 1)
      {
         obavestenje = "Room count need a valid number!";
         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editHotel.jsp");
         rd.forward (request, response);
      }

      if (parking < 1 || parking > 150)
      {
         obavestenje = "Parking need to have more than 1 and less then 150!";
         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editHotel.jsp");
         rd.forward (request, response);
      }

      if (idHotel != 0)
      {
         try
         {
            Hotel hotel = new Hotel ();
            HotelDAL hotBaza = new HotelDAL (Konekcija.createConnection ());

            hotel.setIdHotel (idHotel);
            hotel.setName (name);
            hotel.setCity (city);
            hotel.setRoomCount (roomCount);
            hotel.setStars (stars);
            hotel.setParking (parking);
            hotel.setImagePath (imagePath);

            hotBaza.editHotel (hotel);            

            obavestenje = "Successfully updated hotel!";
            request.setAttribute ("obavestenje", obavestenje);

            RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/managerPage.jsp");
            rd.forward (request, response);
         }
         catch (IOException | ServletException e)
         {
            e.getMessage();
         }
      }
   }

   @Override
   public String getServletInfo()
   {
      return "Short description";
   }

}
