<!DOCTYPE>
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
%>
<div class="container mt-3 py-3">
    <%
       String por = (String) request.getAttribute ("obavestenje");
       if (por != null)
       {%>
    <div class="alert alert-danger">
	<h3 class="text-center text-white">
	    <%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
	</h3>
    </div>	<%}%>
    <div class="card bg-glass border-0 py-2">

        <h2 class="card-header border-0 bg-transparent text-center">  New hotel  </h2>

        <div class="card-body p-2">

            <form action="../AddHotel" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>

                <div class="row m-3">

                    <div class="col-md-4 mt-1">

                        <!-- NAME input -->
                        <div class="col-md-10">
                            <div class="form-outline text-center">
                                <input type="text" name="name" id="form3Example1" class="form-control fw-semibold shadow" required autofocus/>
                                <label class="form-label" for="form3Example1">Hotel name</label>
                            </div>
                        </div>

                        <!-- City input -->
                        <div class="col-md-10">
                            <div class="form-outline text-center">
                                <input type="text" name="city" id="form3Example2" class="form-control fw-semibold shadow" required/>
                                <label class="form-label" for="form3Example2">City</label>
                            </div>
                        </div>

                        <!-- ROOM COUNT-->
                        <div class="col-md-10">
                            <div class="form-outline text-center">
                                <input type="text" name="roomCount" id="form3Example5" class="form-control fw-semibold shadow"  required/>
                                <label class="form-label" for="form3Example5">Room count</label>
                            </div>    
                        </div>

                        <!-- STARS-->
                        <div class="col-md-10">
                            <div class="form-outline text-center">
                                <input type="text" name="stars" id="form3Example5" class="form-control fw-semibold shadow" required />
                                <label class="form-label" for="form3Example5">Stars</label>
                            </div>    
                        </div>

                        <!-- PARKING-->
                        <div class="col-md-10">
                            <div class="form-outline text-center">
                                <input type="text" name="parking" id="form3Example5" class="form-control fw-semibold shadow"  required/>
                                <label class="form-label" for="form3Example5">Parking</label>
                            </div>    
                        </div>

                        <!-- Button  -->
                        <div class="col-md-10 justify-content-center text-center rounded-pill">
                            <button class="btn btn-primary btn-block fa-lg gradient-custom-2 rounded-pill shadow-lg" type="submit">Insert</button>
                        </div> 		

                    </div>    


		    <!-- IMAGE -->
                    <div class="col-md-8">                        
                        <div class="justify-content-center">

                            <!-- Uploaded image area-->
                            <div class="image p-2">
                                <img id="blah" src="../Slike/Hoteli/${hotel.imagePath}" alt="image" class="img-thumbnail mx-auto d-block bg-glass border-0" style="height:20em; width: auto;">

				<!-- Upload image input-->
				<div class="input-group rounded-pill justify-content-center p-2 mt-3">
				    <input id="imgInp" accept="image/*" name="imagePath" type="file" class="form-control border-0 rounded-pill" required>
				    <label id="upload-label" for="imgInp" class="font-weight-light text-muted"></label> 
				</div> 	
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