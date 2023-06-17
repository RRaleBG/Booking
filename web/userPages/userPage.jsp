<!DOCTYPE>
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
<div class="container-fluid py-3 py-5 px-5 w-75">
    <%  String e = (String) request.getAttribute ("poruka");
       if (e != null)
       {
    %>
    <h4 class="alert mt-3 shadow border-1 bg-glass text-center text-success color-success border-success">
	<%= request.getAttribute ("poruka") != null ? request.getAttribute ("poruka") : " "%>
	<button type="button" class="btn-close btn-outline-success offset-1 text-success" data-bs-dismiss="alert" aria-label="Close"/>
    </h4>
    <%}%>

    <!-- USER DETAILS -->
    <div class="row mt-4">

	<!-- USER IMAGE -->
	<div class="col-md-4">

	    <div class="bg-glass mb-4 py-3 rounded-3">
		<div class="text-center ">
		    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava3.webp" alt="avatar" class="rounded-circle img-fluid shadow" style="width: 150px;">
		    <h5 class="my-3">${userDetails.firstname} ${userDetails.lastname}</h5>  
		</div>
	    </div>

	    <!--  User details -->
	    <div class="bg-glass mb-4 mb-lg-0 rounded-3"> 
		<div class="card-body p-3">
		    <p class="col mb-0 text-center text-white-50">
			Details:
		    </p>   
		    <hr class="border-info">
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
			    <c:forEach var="r" items="${listaRez}">
			       ${a +=  userDetails.points }
			    </c:forEach>

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
	<!--  User details -->

	<!-- RESERVATIONS -->
	<div class="col-sm-8">
	    <h3 class="text-center text-info">Reservations</h3>
	    <!-- booking 1 -->
	    <!-- Id ReServations -->
	    <div class="row">	
		<div class="mt-3 text-info">
		    <table class="table table-borderless bg-glass table-hover text-center rounded-3 p-5">

			<thead class="text-info border-bottom w-70 border-info p-4">	
			    <tr>
				<th > Id        </th>
				<th> Hotel  </th>
				<th> Check In </th>  
				<th> Check Out  </th>   
				<th> Points     </th>
				<th> Price  </th>  
				<th> Canceled    </th>  
				<th> Delete </th>
			    </tr>
			</thead>
			<c:forEach var="i" items="${listaRez}">
			   <tbody>
			       <tr class="text-light">        
				   <td> ${i.idRes}        </td>
				   <td> ${i.hotelName}  </td>
				   <td> ${i.dateCheckIn} </td>
				   <td> ${i.dateCheckOut}  </td>
				   <td> ${userDetails.points.toString()}</td>
				   <td> ${i.price}     </td>
				   <td> ${i.canceledRes}  </td>	
				   <td> <a class="bi bi-trash btn-outline-danger" style='color: red;'> </a></td>
			       </tr>
			   </tbody>
			</c:forEach>
		    </table>
		</div>
	    </div>
	</div>
    </div>
</div>
<%@ include file="../footer.jsp" %>