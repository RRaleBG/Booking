package servlet;

import baza.Konekcija;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.File;
import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Hotel;
import model.HotelDAL;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

public class EditHotel extends HttpServlet
{

   protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

   }

   @Override
   protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {

   }

   private static final long serialVersionUID = 1;
   @Override
   protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
   {
      response.setContentType ("text/html");
      PrintWriter out = response.getWriter ();

      String file_name = "";

      boolean isMultipartContent = ServletFileUpload.isMultipartContent (request);

      if (!isMultipartContent)
      {
         return;
      }

      FileItemFactory factory = new DiskFileItemFactory ();
      ServletFileUpload upload = new ServletFileUpload (factory);

      try
      {

         List< FileItem> fields = upload.parseRequest (request);

         Iterator<FileItem> it = fields.iterator ();

         if (!it.hasNext ())
         {
            return;
         }


         while (it.hasNext ())
         {
            FileItem fileItem = it.next ();

            boolean isFormField = fileItem.isFormField ();

            if (isFormField)
            {
               if (file_name == null)
               {
                  if (fileItem.getFieldName ().equals ("imagePath"))
                  {
                     file_name = fileItem.getString ();
                  }
               }
            }
            else
            {
               if (fileItem.getSize () > 0)
               {
                  fileItem.write (new File (getServletContext ().getRealPath (file_name) + fileItem.getName ()));

                  Hotel hotel = new Hotel ();

                  HotelDAL hotBaza = new HotelDAL (Konekcija.createConnection ());

                  hotel.setName (request.getParameter ("name"));
                  hotel.setCity (request.getParameter ("city"));
                  hotel.setRoomCount (Integer.parseInt (request.getParameter ("roomCount")));
                  hotel.setStars (Integer.parseInt (request.getParameter ("stars")));
                  hotel.setParking (Integer.parseInt (request.getParameter ("parking")));
                  hotel.setImagePath (request.getParameter ("imagePath" + fileItem.toString ()));

                  hotBaza.editHotel (hotel);
               }
            }
         }
      }
      catch (Exception e)
      {
         e.printStackTrace ();
      }
      finally
      {
         out.println ("<script type='text/javascript'>");
         out.println ("window.location.href='./index.jsp?filename=" + file_name + "'");
         out.println ("</script>");
         out.close ();
      }
   }

   @Override
   public String getServletInfo()
   {
      return "Short description";
   }

}
