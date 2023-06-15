<%-- 
    Document   : register
    Created on : May 6, 2023, 6:38:10 PM
    Author     : rale_
--%>
<%@page import="model.UsersDAL"%>
<jsp:useBean id="obj" class="model.Users"/>
<jsp:setProperty property="*" name="obj"/>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@page errorPage="error.jsp" %>
<div class="overflow-hidden" style="height: 94vh;">
    <div class="container px-4 py-lg-5 px-lg-5 text-center text-lg-start my-lg-4 mt-lg-5 my-4">
	<div class="row gx-lg-5 align-items-center mb-4">
	    <div class="col-lg-6 mb-lg-0" style="z-index: 10">
		<h1 class="my-0 display-6 fw-bold ls-tight" style="color: hsl(218, 81%, 95%)">
		    The best booking <br />
		    <span style="color: hsl(218, 81%, 75%)">for you and your friends</span>
		</h1>
		<p class="mb-5 opacity-70" style="color: hsl(218, 81%, 85%)">
		    Booking application for all your needs.                  
		</p>
	    </div>
	    <div class="col-lg-6 mb-lg-3 mb-lg-0 position-relative">
		<div id="radius-shape-1" class="position-absolute shadow-5-strong"></div>
		<div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>
		<div class="card bg-glass">


		    <%   String e = (String) request.getAttribute ("poruka");
                       if (e != null)
                       {
		    %>
		    <h3 class="text-center text-danger mt-3">
			<%= request.getAttribute ("poruka") != null ? request.getAttribute ("poruka") : " "%>
		    </h3>
		    <%}%>


		    <h2 class="card-header border-0 bg-transparent mt-2">Register </h2>
		    <div class="card-body px-4 py-4">
			<!-- REGISTRACIJA -->
			<form action="Register" method="POST" class="needs-validation" novalidate>   
			    <!-- FIRST NAME input -->
			    <div class="row">
				<div class="col-md-6 mb-3">
				    <div class="form-outline text-center">
					<label class="form-label" for="validationCustom01">First name</label>
					<input type="text" name="firstname" id="validationCustom01" class="form-control fw-semibold" required autofocus />
					<div class="valid-feedback">
					    Looks good!
					</div>
					<div class="invalid-feedback">
					    Please insert First name.
					</div>
					<div id="errmsg">
					</div>
				    </div>
				</div>
				<!-- LAST NAME input -->
				<div class="col-md-6 mb-3 has-validation">
				    <div class="form-outline text-center">
					<label class="form-label" for="validationCustom02">Last name</label>
					<input type="text" name="lastname" id="validationCustom02" class="form-control bg-ligth-50 fw-semibold"  required/>
					<div class="valid-feedback">
					    Looks good!
					</div>
					<div class="invalid-feedback">
					    Please insert a Last name
					</div>
				    </div>
				</div>
			    </div>
			    <div class="row">
				<!-- USERNAME input -->
				<div class="col-md-6">
				    <div class="form-outline text-center mb-3">
					<label class="form-label" for="validationCustom03">Username</label>
					<input type="text" name="username" id="validationCustom03" class="form-control fw-semibold"  required />   
					<div class="valid-feedback">
					    Looks good!
					</div>
					<div class="invalid-feedback">
					    Please choose a username
					</div>
				    </div>
				</div>
				<!-- EMAIL input -->
				<div class="col-md-6">
				    <div class="form-outline text-center mb-3">
					<label class="form-label" for="validationCustom04">Email address</label>
					<input type="email" name="email" id="validationCustom04" class="form-control fw-semibold" required/>

					<div class="valid-feedback">
					    Looks good!
					</div>
					<div class="invalid-feedback">
					    Please insert a valid email
					</div>
				    </div>
				</div>
			    </div>
			    <!-- PASSWORD input -->
			    <div class="form-outline text-center mb-3">
				<label class="form-label" for="validationCustom05">Password</label>
				<input type="password" name="password" id="validationCustom05" class="form-control fw-semibold" required />
				<div class="valid-feedback">
				    Looks good!
				</div>
				<div class="invalid-feedback">
				    Please choose a username
				</div>
			    </div>
			    <!-- SUBMIT  BUTTON -->       
			    <div class="text-center pt-1 mb-5 pb-1 justify-content-center">
				<button class="btn w-100 btn-primary btn-block fa-lg gradient-custom-2 mb-3" type="submit">Register</button>
			    </div>           
			</form>
			<!-- Back to login page -->   
			<div class="d-flex align-items-center justify-content-center">
			    <p class="mb-0 me-2">Already have an account?</p>
			    <a class="btn btn-outline-danger fw-bold" href="login.jsp" style="text-decoration: none;">Login here</a>
			</div>
		    </div>
		</div>
	    </div>
	</div>
    </div>
</div>
<script>
   (() => {
      'use strict'

      // Fetch all the forms we want to apply custom Bootstrap validation styles to
      const forms = document.querySelectorAll('.needs-validation')

      // Loop over them and prevent submission
      Array.from(forms).forEach(form => {
	 form.addEventListener('submit', event => {
	    if (!form.checkValidity()) {
	       event.preventDefault()
	       event.stopPropagation()
	    }

	    form.classList.add('was-validated')
	 }, false)
      })
   })()



   $(document).ready(function() {
   $("#validationCustom01").keypress(function (e)
   {
   //if the letter is not digit then display error and don't type anything
   if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57))
   {
   //display error message
   $("#errmsg").html("Digits Only").show().fadeOut("slow");
	   return false;
   }
   })
   ;


</script>
<%@ include file="footer.jsp" %>
