<!DOCTYPE>
<%-- 
    Document   : editRooms
    Created on : May 12, 2023, 9:55:28 PM
    Author     : rale_
--%>
<%@page import="java.util.List"%>
<style>
    #upload {
       opacity: 0;
    }

    #upload-label {
       position: absolute;
       top: 50%;
       left: 1rem;
       transform: translateY(-50%);
    }

    .image-area {
       border: 2px dashed rgba(255, 255, 255, 0.7);
       padding: 1rem;
       position: relative;
    }

    .image-area::before {
       content: 'Uploaded image result';
       color: #fff;
       font-weight: bold;
       text-transform: uppercase;
       position: absolute;
       top: 50%;
       left: 50%;
       transform: translate(-50%, -50%);
       font-size: 0.8rem;
       z-index: 1;
    }

    .image-area img {
       z-index: 2;
       position: relative;
    }
</style>
<%@ include file="../header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../style.css" type="text/css"/> 
<%  // AUTORIZACIJA 
//
   user = (Users) session.getAttribute ("user");

   int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
   int idRoom = Integer.parseInt (request.getParameter ("idRoom"));

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

      HotelDAL hotelPodaci = new HotelDAL (Konekcija.createConnection ());
      Hotel hotel = hotelPodaci.getByHotelId (idHotel);
      request.setAttribute ("hotel", hotel);

      RoomsDAL getRoom = new RoomsDAL (Konekcija.createConnection ());
      Rooms roomInHotel = getRoom.getRoomFromHotel (idHotel, idRoom);

      request.setAttribute ("room", roomInHotel);
   }
%>
<div class="container mt-3 py-3">  
    <%   String e = (String) request.getAttribute ("obavestenje");
       if (e != null)
       {
    %>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
	<%= request.getAttribute ("obavestenje") == null ? request.getAttribute ("obavestenje") : " "%>
    </h2>
    <%}%>
    <div class="card bg-glass border-0 py-3">
	<form action="../EditRoom" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>
	    <div class="row justify-content-center">
		<!-- Input fields -->
		<div class="row col-md-10 justify-content-center text-center">
		    <!-- Hotel Id -->
		    <div class="form-outline col-md-2 text-center mb-3">
			<input type="text" name="idHotel" value="${hotel.idHotel}" id="form3Example1" class="form-control form-control-sm fw-semibold text-center bg-glass" required autofocus/>
			<label class="form-label text-white-50" for="form3Example1">Hotel ID</label>
		    </div>
		    <!-- Room Id -->
		    <div class="form-outline  col-md-2 text-center mb-3">
			<input type="text" name="idRoom" value="${room.idRoom}" id="form3Example1" class="form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
			<label class="form-label text-white-50 shadow-5-strong" for="form3Example1">Room ID</label>
		    </div>
		    <!-- Room number -->
		    <div class="form-outline col-md-2 text-center mb-3">
			<input type="text" name="number" value="${room.number}" id="form3Example1" class="form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
			<label class="form-label text-white-50" for="form3Example1">Room number</label>
		    </div>
		    <!-- Bed -->
		    <div class="form-outline col-md-2 text-center mb-3">
			<input name="bed" value="${room.bed}"  id="form3Example1" class="form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
			<label class="form-label text-white-50" for="form3Example1">Beds</label>
		    </div>
		</div>

		<!-- CHeck boxes -->
		<div class="row col-md-10 justify-content-center">
		    <!-- SMOKING -->
		    <div class="form-check form-switch text-center mb-3 col-md-2">
			<input <c:if test="${room.smoking == 1}"> checked="checked"</c:if> class="form-check-input col-md-5" type="checkbox" name="smoking" role="switch" id="flexSwitchCheckDefault" >
			   <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">Smoking</label>
			</div>		    
			<!-- BALKON -->	       
			<div class="form-check form-switch text-center mb-3 col-md-2">
			    <input <c:if test="${room.balkon == 1}"> checked="checked" </c:if> name="balkon" class="form-check-input col-md-5" type="checkbox" role="switch" id="flexSwitchCheckDefault" >
			    <label class="form-check-label text-white-50" for="balkon">Balkon</label>
			</div>
			<!-- PETS -->
			<div class="form-check form-switch text-center mb-3 col-md-2">
			    <input <c:if test="${room.pets == 1}"> checked="checked" </c:if> class="form-check-input col-md-5" type="checkbox" name="pets" role="switch" id="flexSwitchCheckDefault" />
			    <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">Pets</label>
			</div>
			<!-- TV -->
			<div class="form-check form-check form-switch text-center mb-3 col-md-2">
			    <input <c:if test="${room.tv == 1}"> checked="checked" </c:if>  class="form-check-input col-md-5" type="checkbox" name="tv" role="switch" id="flexSwitchCheckDefault" />
			    <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">TV</label>
			</div>

		    </div>
		    <!-- IMAGE -->
		    <div class="row col-md-8 justify-content-center">
			<!-- Upload image input-->
			<div class="input-group mb-3 rounded-pill w-75">
			    <input id="imgInp" accept="image/*" name="imgPath" type="file" class="form-control border-0 rounded-pill">
			    <label id="upload-label" for="imgInp" class="font-weight-light text-muted"></label> 
			</div> 	 
			<!-- Uploaded image area-->
			<div class="image mt-4">
			    <img id="blah" src="../Slike/${room.imgPath}" alt="image" class="img-thumbnail mx-auto d-block bg-glass border-0" style="height:25em;">
		    </div>
		</div>
		<!-- Button  -->
		<div class="row col-md-6 justify-content-center text-center pt-1 pb-1 mt-5 rounded-pill w-75">
		    <button class="btn btn-primary btn-block fa-lg gradient-custom-2 rounded-pill shadow-lg" type="submit">Edit</button>
		</div> 
	    </div>  			
	</form>
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