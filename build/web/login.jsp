<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="overflow-hidden">
    <div class="container px-4 py-lg-5 px-lg-5 text-center text-lg-start my-lg-4 mt-lg-5 my-5">
	<div class="row gx-lg-5 align-items-center mb-5">
	    <div class="col-lg-6 mb-lg-0" style="z-index: 10">
		<h1 class="my-2 display-6 fw-bold ls-tight" style="color: hsl(218, 81%, 95%)">
		    The best booking <br />
		    <span style="color: hsl(218, 81%, 75%)">for you and your friends</span>
		</h1>
		<p class="mb-4 opacity-70" style="color: hsl(218, 81%, 85%)">
		    Booking application for all your needs.                  
		</p>
	    </div>
	    <div class="col-lg-6 mb-lg-0 position-relative">
		<div id="radius-shape-1" class="position-absolute shadow-5-strong"></div>
		<div id="radius-shape-2" class="position-absolute shadow-5-strong"></div>
		<div class="card bg-glass">

		    <%   String e = (String) request.getAttribute ("poruka");
                       if (e != null)
                       {
		    %>
		    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
			<%= request.getAttribute ("poruka") != null ? request.getAttribute ("poruka") : " "%>
		    </h2>
		    <%}
                    else
                    {%>
		    <h2 class="card-header border-0 bg-transparent mt-2">Login</h2>
		    <%}%>

		    <div class="card-body px-4 py-4">
			<!-- LOGIN FORMA -->
			<form action="Login" method="POST" class="needs-validation" novalidate>   
			    <!-- Username input -->
			    <div class="form-outline mb-4">
				<label class="form-label" for="form2Example11">Username</label>
				<input name="username" type="text" id="form2Example11" class="form-control fw-semibold" required autofocus/>
				<div class="valid-feedback">
				    Looks good!
				</div>
				<div class="invalid-feedback">
				    Please insert username
				</div>
			    </div>
			    <!-- Password input -->
			    <div class="form-outline mb-5 ">
				<label class="form-label" for="validationCustom02" id="error-label">Password</label>
				<input name="password" type="password" id="validationCustom02" class="form-control fw-semibold shadow" aria-labelledby="passwordHelpInline" required autofocus/>   
				<span class="invalid-feedback" id="passwordHelpInline">
				    Please insert password
				</span>
			    </div>
			    <!-- Button  -->
			    <div class="text-center pt-1 mb-5 pb-1 justify-content-center">
				<button class="btn w-100 btn-primary btn-block fa-lg gradient-custom-2 mb-3" type="submit">Login</button><br>
				<br>
				<a class="text-white" href="#!">Forgot password?</a>
			    </div>
			</form>
			<div class="d-flex align-items-center justify-content-center">
			    <p class="mb-0 me-2">Don't have an account?</p>                        
			    <a class="btn btn-outline-danger fw-bold" href="register.jsp" style="text-decoration: none;">Create new</a>           
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
	 },
		 false)
      })
   })()
</script>
<%@ include file="footer.jsp" %>