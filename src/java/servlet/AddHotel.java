package servlet;

import baza.Konekcija;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import model.Hotel;
import model.HotelDAL;

@MultipartConfig
public class AddHotel extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
   }

   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      String obavestenje = "";

      String name = request.getParameter ("name");
      String city = request.getParameter ("city");
      int roomCount = Integer.parseInt (request.getParameter ("roomCount"));
      int stars = Integer.parseInt (request.getParameter ("stars"));
      int parking = Integer.parseInt (request.getParameter ("parking"));

      if (name.isEmpty ())
      {
         obavestenje = "Name of Hotel missing!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      if (city.isEmpty ())
      {
         obavestenje = "Name of City missing!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      if (stars < 1 || stars > 5)
      {
         obavestenje = "Hotel need to have 1 or 5 stars!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      if (roomCount < 1)
      {
         obavestenje = "Room number need a valid number!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      if (parking < 1 || parking > 150)
      {
         obavestenje = "Parking need to be bigeer than 0 or less then 30!";

         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      Part part = request.getPart ("imagePath");
      String imageName = part.getSubmittedFileName ();

      if (imageName.isEmpty ())
      {
         obavestenje = "Insert image";
         request.setAttribute ("obavestenje", obavestenje);
         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/addHotel.jsp");
         rd.forward (request, response);
      }

      if (stars > 0 || stars < 6)
      {
         try
         {

            String folderSlika = "E:/ITS/3 Godina/6 Semestar/Java/Projekti/Booking/web/Slike/" + imageName;

            FileOutputStream upload = new FileOutputStream (folderSlika);
            InputStream input = part.getInputStream ();

            byte[] data = new byte[input.available ()];
            input.read (data);
            upload.write (data);
            upload.close ();

            Hotel hotel = new Hotel ();
            HotelDAL hotBaza = new HotelDAL (Konekcija.createConnection ());

            hotel.setName (name);
            hotel.setCity (city);
            hotel.setRoomCount (roomCount);
            hotel.setStars (stars);
            hotel.setParking (parking);
            hotel.setImagePath (imageName);

            hotBaza.addHotel (hotel);

            obavestenje = "Successfully added new hotel!";
            request.setAttribute ("obavestenje", obavestenje);
            RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/managerPage.jsp");
            rd.forward (request, response);
         }
         catch (Exception e)
         {
            e.printStackTrace ();
         }

      }
   }

   @Override
   public String getServletInfo()
   {
      return "Short description";
   }

}
