<%-- 
    Document   : editHotel
    Created on : May 12, 2023, 9:55:00 PM
    Author     : rale_
--%>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%  // AUTORIZACIJA 
   user = (Users) session.getAttribute ("user");

   int idHotel = Integer.parseInt (request.getParameter ("idHotel"));

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

      HotelDAL getHotel = new HotelDAL (Konekcija.createConnection ());
      Hotel hotel = getHotel.getByHotelId (idHotel);

      session.setAttribute ("hotel", hotel);
   }
%>
<div class="container mt-3 py-3">

    <%   String e = (String) request.getAttribute ("obavestenje");
       if (e != null)
       {
    %>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
	<%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
    </h2>
    <%}%>
    <div class="card bg-glass border-0 py-3">
	<h2 class="card-header border-0 bg-transparent text-center"> ${hotel.name} </h2>	
	<div class="card-body px-2 py-2">
	    <form action="../EditHotel" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>
		<div class="row">
		    <div class="col-md-4 mt-5">
			<input type="hidden" name="idHotel" value="${hotel.idHotel}"/>
			<!--  NAME input -->
			<div class="col-md-10 mb-3">
			    <div class="form-outline text-center">
				<input type="text" name="name" value="${hotel.name}" id="form3Example1" class="form-control fw-semibold shadow" required autofocus/>
				<label class="form-label" for="form3Example1">Hotel name</label>
			    </div>
			</div>
			<!-- City input -->
			<div class="col-md-10 mb-3">
			    <div class="form-outline text-center">
				<input type="text" name="city" value="${hotel.city}" id="form3Example2" class="form-control fw-semibold shadow" required/>
				<label class="form-label" for="form3Example2">City</label>
			    </div>
			</div>
			<!-- ROOM COUNT-->
			<div class="col-md-10 mb-3">
			    <div class="form-outline text-center mb-3">
				<input type="text" name="roomCount" value="${hotel.roomCount}" id="form3Example5" class="form-control fw-semibold shadow" required />
				<label class="form-label" for="form3Example5">Room count</label>
			    </div>    
			</div>
			<!-- STARS-->
			<div class="col-md-10 mb-3">
			    <div class="form-outline text-center mb-3">
				<input type="text" name="stars" value="${hotel.stars}" id="form3Example5" class="form-control fw-semibold shadow" required />
				<label class="form-label" for="form3Example5">Stars</label>
			    </div>    
			</div>
			<!-- PARKING-->
			<div class="col-md-10 mb-3">
			    <div class="form-outline text-center mb-3">
				<input type="text" name="parking" value="${hotel.parking}" id="form3Example5" class="form-control fw-semibold shadow" required />
				<label class="form-label" for="form3Example5">Parking</label>
			    </div>    
			</div>
			<!-- Button  -->
			<div class="col-md-10 justify-content-center text-center rounded-pill">
			    <button class="btn btn-primary btn-block fa-lg gradient-custom-2 rounded-pill shadow-lg" type="submit">Edit</button>
			</div> 		
		    </div>    
		    <div class="col-md-8 mt-2">
			<!-- IMAGE -->
			<div class="justify-content-center">
			    <!-- Uploaded image area-->
			    <div class="image mt-4 py-2 px-2">
				<img id="blah" src="../Slike/${hotel.imagePath}" alt="image" class="img-thumbnail mx-auto d-block bg-glass border-0" style="height:25em; width: auto;">
			    </div>
			    <!-- Upload image input-->
			    <div class="input-group rounded-pill justify-content-center py-5 px-5 mb-0">
				<input id="imgInp" accept="image/*" name="imagePath" type="file" class="form-control border-0 rounded-pill" >
				<label id="upload-label" for="imgInp" class="font-weight-light text-muted">  </label> 
				<input type="hidden" name="imagePath" value="${hotel.imagePath}" />
			    </div> 	
			</div>
		    </div>
		</div>
	    </form>
	</div>
    </div>
</div>
<script>
   (() => {
      'use strict';

      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      const forms = document.querySelectorAll('.needs-validation');

      // Loop over them and prevent submission
      Array.from(forms).forEach(form => {
	 form.addEventListener('submit', event => {
	    if (!form.checkValidity()) {
	       event.preventDefault();
	       event.stopPropagation();
	    }
	    form.classList.add('was-validated');
	 }, false);
      });
   })();

   imgInp.onchange = evt => {
      const [file] = imgInp.files
      if (file) {
	 blah.src = URL.createObjectURL(file)
      }
   }
</script>
<%@ include file="../footer.jsp" %>