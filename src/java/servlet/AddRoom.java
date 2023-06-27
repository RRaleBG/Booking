package servlet;

import baza.Konekcija;
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.MultipartConfig;
import model.Rooms;
import model.RoomsDAL;

@MultipartConfig
public class AddRoom extends HttpServlet
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
      String poruka = "";
      String obavestenje = "";

      int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
      int number = Integer.parseInt (request.getParameter ("number"));
      int bed = Integer.parseInt (request.getParameter ("bed"));
      int tv = (request.getParameter ("tv") != null && request.getParameter ("tv") != "checked" ? 1 : 0);
      int smoking = (request.getParameter ("smoking") != null && request.getParameter ("smoking") != "checked" ? 1 : 0);
      int balkon = (request.getParameter ("balkon") != null && request.getParameter ("balkon") != "checked" ? 1 : 0);
      int pets = (request.getParameter ("pets") != null && request.getParameter ("pets") != "checked" ? 1 : 0);
      Part part = request.getPart ("imgPath");

      try
      {
         String imageName = part.getSubmittedFileName ();

         String folderSlika = "E:/ITS/3 Godina/6 Semestar/Java/Projekti/Booking/web/Slike/Sobe/" + imageName;

         FileOutputStream upload = new FileOutputStream (folderSlika);
         InputStream input = part.getInputStream ();

         byte[] data = new byte[input.available ()];
         input.read (data);
         upload.write (data);
         upload.close ();

         RoomsDAL addRoom = new RoomsDAL (Konekcija.createConnection ());
         Rooms room = new Rooms ();

         room.setIdHotel (idHotel);
         room.setNumber (number);
         room.setBed (bed);
         room.setTv ((byte) tv);
         room.setBalkon ((byte) balkon);
         room.setSmoking ((byte) smoking);
         room.setPets ((byte) pets);
         room.setImgPath (imageName);

         addRoom.addRoom (room);

         poruka = "Successfully added room!";
         obavestenje = "Successfully added room!";
         request.setAttribute ("poruka", poruka);
         request.setAttribute ("obavestenje", obavestenje);

         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/managerPage.jsp");
         rd.forward (request, response);
      }
      catch (IOException | ServletException e)
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
