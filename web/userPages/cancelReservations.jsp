<%-- 
    Document   : cancelReservations
    Created on : May 12, 2023, 10:32:07 PM
    Author     : rale_
--%>
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
%>
<div class="container">

    <h1 class="text-center text-danger">User section</h1>
    <h3 class="text-center text-danger">Cancel reservation</h3>
</div>
<%@ include file="../footer.jsp" %>
