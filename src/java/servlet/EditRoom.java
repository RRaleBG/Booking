package servlet;

import baza.Konekcija;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.*;
import model.RoomsDAL;
import model.Rooms;

@MultipartConfig
public class EditRoom extends HttpServlet
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
      HttpSession session = request.getSession ();
      String obavestenje = "";

      int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
      int idRoom = Integer.parseInt (request.getParameter ("idRoom"));
      int number = Integer.parseInt (request.getParameter ("number"));
      int bed = Integer.parseInt (request.getParameter ("bed"));
      int tv = (request.getParameter ("tv") != null && request.getParameter ("tv") != "checked" ? 1 : 0);
      int smoking = (request.getParameter ("smoking") != null && request.getParameter ("smoking") != "checked" ? 1 : 0);
      int balkon = (request.getParameter ("balkon") != null && request.getParameter ("balkon") != "checked" ? 1 : 0);
      int pets = (request.getParameter ("pets") != null && request.getParameter ("pets") != "checked" ? 1 : 0);

      Part part = request.getPart ("imgPath");
      String fileName = (part == null) ? "" : part.getSubmittedFileName ();


      try
      {
         RoomsDAL editRoom = new RoomsDAL (Konekcija.createConnection ());
         Rooms room = new Rooms ();

         room.setIdRoom (idRoom);
         room.setIdHotel (idHotel);
         room.setNumber (number);
         room.setBed (bed);
         room.setTv ((byte) tv);
         room.setBalkon ((byte) balkon);
         room.setSmoking ((byte) smoking);
         room.setPets ((byte) pets);
         room.setImgPath (fileName);

         editRoom.editRoom (room);

         obavestenje = "Successfully updated room!";
         session.setAttribute ("obavestenje", obavestenje);

         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/editRooms.jsp?idHotel=" + idHotel + "&idRoom=" + idRoom);
         rd.forward (request, response);
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
