<%-- 
    Document   : deleteHotel
    Created on : May 15, 2023, 12:11:43 AM
    Author     : rale_
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%  // AUTORIZACIJA 
   user = (Users) session.getAttribute ("user");

   UsersDAL ident = new UsersDAL (Konekcija.createConnection ());

   if (user == null)
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) != "menager")
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) == "menager")
   {
      session.setAttribute ("user", user);
   }

   String obavestenje = "";
   int idHotelDelete = Integer.parseInt (request.getParameter ("idHotel"));

   if (idHotelDelete != 0)
   {
      HotelDAL del = new HotelDAL (Konekcija.createConnection ());

      if (del.deleteHotel (idHotelDelete) == true)
      {
         obavestenje = "Hotel deleted successfully!";

         request.setAttribute ("obavestenje", obavestenje);

         RequestDispatcher rd = request.getRequestDispatcher ("/managerPages/managerPage.jsp");
         rd.forward (request, response);
      }
   }

%>
<div class="container">

    <div class="container w-75">    
	<div class="alert alert-success">
	    <a class="btn btn-oubline succes text-center" href="./managerPage.jsp">Return</a>
	</div>
    </div>

</div>
<%@ include file="../footer.jsp" %>
