<%-- 
    Document   : userPage
    Created on : May 12, 2023, 10:31:40 PM
    Author     : rale_
--%>
<%@page import="model.UsersDAL"%>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%  //
   //
   user = (Users) session.getAttribute ("user");

   UsersDAL getDetails = new UsersDAL (Konekcija.createConnection ());

   if (user == null)
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (getDetails.isInRole (user.getUsername ()) != "user")
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (getDetails.isInRole (user.getUsername ()) == "user")
   {
      Users korisnik = (Users) session.getAttribute ("userId");
      request.setAttribute ("userDetails", getDetails.getByUserId (korisnik.getId ()));

      String roleName = getDetails.updateRole (korisnik.getId ());
      request.setAttribute ("roleName", roleName);

      RezervationsDAL rez = new RezervationsDAL (Konekcija.createConnection ());
      List<Rezervations> listRezervation = rez.getAllRezervationsFromUserId (korisnik.getId ());
      request.setAttribute ("listaRez", listRezervation);
   }
%>
<div class="container py-3">
    <%   String e = (String) request.getAttribute ("poruka");
       if (e != null)
       {
    %>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
	<%= request.getAttribute ("poruka") != null ? request.getAttribute ("poruka") : " "%>
    </h2>
    <%}%>

    <!-- USER DETAILS -->
    <div class="row mt-4">
	<div class="col-lg-4">
	    <div class="bg-glass mb-4 py-3">
		<div class="text-center ">
		    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="avatar" class="rounded-circle img-fluid shadow" style="width: 150px;">
		    <h5 class="my-3">${userDetails.firstname} ${userDetails.lastname}</h5>  
		</div>
	    </div>
	    <div class="bg-glass mb-4 mb-lg-0">
		<div class="card-body p-3">
		    <div class="row">
			<div class="col">
			    <p class="mb-0">ID</p>                        
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${userDetails.id}</p>                        
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <p class="mb-0">Username</p>                        
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${userDetails.username}</p>                        
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <p class="mb-0">Email</p>
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${userDetails.email}</p>
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <p class="mb-0">Password</p>
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${userDetails.password}</p>
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <p class="mb-0">Points</p>
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${userDetails.points.toString()}</p>
			</div>
		    </div>
		    <div class="row">
			<div class="col">
			    <p class="mb-0">Status: </p>
			</div>
			<div class="col">
			    <p class="text-muted mb-0">${roleName}</p>
			</div>
		    </div>
		</div>
	    </div>
	</div>
	<div class="col-sm-1">
	</div>
	<!-- RESERVATIONS -->
	<div class="col-lg-6">
	    <h3 class="text-center text-info">Reservations</h3>
	    <!-- booking 1 -->
	    <c:forEach var="i" items="${listaRez}"> 
	       <div class="card bg-glass">
		   <div class="card-body">
		       <!-- Id Rezervations -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Reservation</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.idRes}</p>
			   </div>
		       </div>
		       <hr>
		       <!-- Id Guest 
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0"></p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0"></p>
			   </div>
		       </div>
		       <hr>
		       -->
		       <!-- Id Hotel -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Hotel</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.hotelName}</p>
			   </div>
		       </div>
		       <hr>
		       <!-- Date CheckIn -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Date Check in</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.dateCheckIn}</p>
			   </div>
		       </div>
		       <hr>
		       <!-- Date CheckOut -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Date Checkout</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.dateCheckOut}</p>
			   </div>
		       </div>
		       <hr>
		       <!-- Price -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Price</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.price}</p>
			   </div>
		       </div>
		       <hr>
		       <!-- Canceled reservations -->
		       <div class="row">
			   <div class="col-sm-5">
			       <p class="mb-0">Canceled reservations</p>
			   </div>
			   <div class="col-sm-7">
			       <p class="text-muted mb-0">${i.canceledRes}</p>
			   </div>
		       </div>
		       <hr>
		   </div>
	       </div>
	       <br>
	    </c:forEach>
	</div>
    </div>
</div>
<%@ include file="../footer.jsp" %>