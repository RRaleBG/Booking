<!DOCTYPE>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%      //
   // autorizacija i detalji...
   int id = Integer.parseInt (request.getParameter ("id"));
   UsersDAL getDetails = new UsersDAL (Konekcija.createConnection ());

   Users userDetails = getDetails.getByUserId (id);
   request.setAttribute ("userDetails", userDetails);

   String idRola = getDetails.updateRole (id);
   request.setAttribute ("rola", idRola);

   RezervationsDAL rez = new RezervationsDAL (Konekcija.createConnection ());
   List<Rezervations> listRezervation = rez.getAllRezervationsFromUserId (id);
   request.setAttribute ("listaRez", listRezervation);
%>
<div class="container py-3">   
    <div class="row mt-4  gap-5 mr-3">      
	<!-- USER DETAILS fixed-top-->
	<div class="col-lg-4">
	    <div class="bg-glass mb-4 py-3">
		<div class="text-center ">
		    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="avatar" class="rounded-circle img-fluid shadow" style="width: 150px;">
		    <h5 class="my-3">${userDetails.firstname} ${userDetails.lastname}</h5>                      
		</div>
	    </div>
	    <div class="bg-glass mb-4 mb-lg-0">               
		<div class="card-body p-3">
		    <div class="row py-1 sticky-top">
			<div class="col">
			    <p class="mb-0 text-white-50">ID</p>                        
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${userDetails.id}</p>                        
			</div>
		    </div>
		    <div class="row py-31">
			<div class="col">
			    <p class="mb-0 text-white-50">Username</p>                        
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${userDetails.username}</p>                        
			</div>
		    </div>
		    <div class="row py-1">
			<div class="col">
			    <p class="mb-0 text-white-50">Email</p>
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${userDetails.email}</p>
			</div>
		    </div>
		    <div class="row py-1">
			<div class="col">
			    <p class="mb-0 text-white-50">Password</p>
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${userDetails.password}</p>
			</div>
		    </div>
		    <div class="row py-1">
			<div class="col">
			    <p class="mb-0 text-white-50">Points</p>
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${userDetails.points}</p>
			</div>
		    </div>
		    <div class="row py-1">
			<div class="col">
			    <p class="mb-0 text-white-50">Status</p>
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${rola}</p>
			</div>
		    </div>
		</div>         
	    </div>
	</div>
	<!-- RESERVATIONS -->
	<div class="col-lg-6 mx-auto py-2">
	    <h3 class="text-center text-info">Reservations</h3>
	    <!-- booking 1 -->   
	    <c:forEach var="i" items="${listaRez}">
	       <div class="card bg-glass">
		   <div class="card-body bg-glass text-white-50">

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">ID Reservations</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="m-0">${i.idRes}</p>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">ID Guest: ${i.idGest}</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="m-0">${userDetails.firstname} ${userDetails.lastname}</p>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">Hotel</p>
			   </div>
			   <div class="col-sm-4">
			       <label class="m-0">${i.hotelName}</label>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">Date Check in</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="m-0">${i.dateCheckIn}</p>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">Date Check out</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="m-0">${i.dateCheckOut}</p>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">Price</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="m-0">${i.price}</p>
			   </div>
		       </div>
		       <hr>

		       <div class="row">
			   <div class="col-sm-6">
			       <p class="m-0">Canceled reservations</p>
			   </div>
			   <div class="col-sm-6">
			       <p class="">${i.canceledRes ? true : "Not canceled"}</p>
			   </div>
		       </div>
		       <hr>
		   </div>
	       </div>
	    </c:forEach>
	</div>
    </div>
</div>                    
<%@ include file="../footer.jsp" %>