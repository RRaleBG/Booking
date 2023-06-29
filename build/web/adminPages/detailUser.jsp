<!DOCTYPE>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp"%>
<link rel="stylesheet" href="../style.css" type="text/css"/>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%  //
   // autorizacija i detalji...
   int id = Integer.parseInt (request.getParameter ("id"));
   UsersDAL getDetails = new UsersDAL (Konekcija.createConnection ());

   Users userDetails = getDetails.getByUserId (id);
   request.setAttribute ("userDetails", userDetails);

   String idRola = getDetails.updateRole (id);
   request.setAttribute ("rola", idRola);

   String roleName = getDetails.updateRole (userDetails.getId ());
   request.setAttribute ("roleName", roleName);

   RezervationsDAL rez = new RezervationsDAL (Konekcija.createConnection ());
   List<Rezervations> listRezervation = rez.getAllRezervationsFromUserId (id);

   request.setAttribute ("listaRez", listRezervation);
%>
<div class="container-fluid w-75 py-3">   
    <%
       String e = (String) request.getAttribute ("poruka");
       if (e != null)
       {%>
    <div class="alert border-1 bg-glass rounded-3 container shadow border-success align-items-center col-md-8" role="alert">
	<h4 class="text-center text-success">
	    <%= request.getAttribute ("poruka") != null ? request.getAttribute ("poruka") : " "%>
	    <button type="button" class="btn-close btn-outline-success offset-2 text-success" data-bs-dismiss="alert" aria-label="Close"/>
	</h4>
    </div>	
    <%}%>


    <div class="row mt-4">      

	<!-- USER DETAILS fixed-top-->
	<div class="col-lg-4 sticky-top">

	    <!-- USER image -->
	    <div class="bg-glass mb-4 py-3 text-center sticky-top">		
		<img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava2.webp" alt="avatar" class="rounded-circle img-fluid shadow" style="width: 150px;">
		<h5 class="my-3">${userDetails.firstname} ${userDetails.lastname}</h5>                     
	    </div>

	    <!-- USER details -->
	    <div class="bg-glass px-4 mb-4 mb-lg-0">      
		<h5 class="text-white-50 text-center p-3 mb-0 border-bottom border-info">Details</h5>
		<div class="card-body p-2 text-left">

		    <div class="row py-1">

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
			    <p class="text-white-50 mb-0">${userDetails.points }</p>
			</div>
		    </div>
		    <div class="row py-1">
			<div class="col">
			    <p class="mb-0 text-white-50">Status</p>
			</div>
			<div class="col">
			    <p class="text-white-50 mb-0">${roleName}</p>
			</div>
		    </div>
		</div>         
	    </div>

	</div>




	<!-- RESERVATIONS -->
	<div class="col-md mx-auto w-auto">

	    <h3 class="text-center text-info">Reservations</h3>
	    <!-- booking 1 -->   

	    <table class="table table-borderless text-xsmall bg-glass table-hover text-center rounded-3 p-5">
		<thead class="text-center text-info border-bottom border-info">
		    <tr>
			<th> Id         </th>
			<th> Hotel      </th>
			<th> Check In   </th>  
			<th> Check Out  </th> 
			<th> Price      </th>  
			<th> Canceled   </th>  
		    </tr>
		</thead>
		<tbody class="text-light text-center px-3">
		    <c:forEach var="i" items="${listaRez}">
		       <tr>        
			   <td> ${i.idRes}	       </td>
			   <td> ${i.hotelName}	       </td>
			   <td> ${i.dateCheckIn}       </td>
			   <td> ${i.dateCheckOut}      </td>
			   <td> ${i.price}	       </td>				   
			   <td>
			       <c:if test="${ i.canceledRes == 0 }">
				  <span class='badge shadow text-bg-success '>Booked</span>		   
			       </c:if>
			       <c:if test="${ i.canceledRes == 1}">
				  <span class='badge text-bg-danger'>Canceled</span>		   
			       </c:if>
			   </td>			 
		       </tr>
		    </c:forEach>
		</tbody>
	    </table>
	</div>
    </div>
</div>    
<%@ include file="../footer.jsp" %>