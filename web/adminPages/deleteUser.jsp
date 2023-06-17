<!DOCTYPE>
<%@page import="baza.Konekcija" %>
<%@page import="java.util.List"%>
<%@page import="model.Users" %>
<%@page import="model.UsersDAL" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%@page isELIgnored="false" %>
<%-- AUTORIZACIJA --%> 
<%   //
   user = (Users) session.getAttribute ("user"); // trenutno ulogovani korisnik ID
   UsersDAL ident = new UsersDAL (Konekcija.createConnection ());
   String poruka = "";

   if (user == null)
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else
   {
      if (ident.isInRole (user.getUsername ()) == "admin")
      {
         int idDelete = Integer.parseInt (request.getParameter ("id")); // Korisnik ID koji treba da se obriše

         if (ident.deleteUser (idDelete))
         {
            poruka = "Uspesno obrisan korisnik!";
            session.setAttribute ("poruka", poruka);
         }
      }
   }
%>
<div class="container w-75">    
    <div class="alert alert-success">
	<a class="btn btn-oubline succes text-center" href="./adminPage.jsp">Return</a>
    </div>
</div>
<%@ include file="../footer.jsp" %>