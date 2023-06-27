
<!DOCTYPE>
<%@page contentType="text/html" pageEncoding="utf-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/> 
<%  // AUTORIZACIJA 
   user = (Users) session.getAttribute ("user");

   UsersDAL ident = new UsersDAL (Konekcija.createConnection ());

   if (user == null)
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) != "user")
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) == "user")
   {
      session.setAttribute ("user", user);
   }

   String cancelObavestenje = "";
   int idReservationCancel = Integer.parseInt (request.getParameter ("idRes"));

   if (idReservationCancel != 0)
   {
      RezervationsDAL update = new RezervationsDAL (Konekcija.createConnection ());

      if (update.cancelReservation (idReservationCancel) == true)
      {
         cancelObavestenje = "Reservation canceled successfully!";

         request.setAttribute ("cancelObavestenje", cancelObavestenje);

         RequestDispatcher rd = request.getRequestDispatcher ("/userPages/userPage.jsp");
         rd.forward (request, response);
      }
   }
%>
<div class="container mt-5">


    <div class="container w-75">    
        <div class="alert alert-success mt-5">
            <a class="btn btn-oubline succes text-center" href="./userPage.jsp">Return</a>
        </div>
    </div>

</div>
<%@ include file="../footer.jsp" %>
