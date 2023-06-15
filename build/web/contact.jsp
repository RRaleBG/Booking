<%-- 
    Document   : contact
    Created on : May 8, 2023, 11:20:45 AM
    Author     : rale_
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="container mb-4 py-3">
    <section class="container-sm mb-3 text-info">
	<h2 class="h1-responsive font-weight-bold text-center my-3">Contact us</h2>
	<p class="font-weight-bold text-center w-responsive mx-auto mb-5">If you like to ask something... </p>         
	<div class="row justify-content-center">
	    <!--Grid column-->
	    <div class="col-md-10 mb-5">
		<form id="contact-form" name="contact-form" action="mail" method="POST">
		    <!--Grid row-->
		    <div class="row justify-content-center">
			<!--Grid column-->
			<div class="col-md-8">
			    <div class="md-form mb-4">
				<label for="name" class="">Your name</label>
				<input type="text" id="name"  name="name" class="form-control form-control-sm bg-transparent border-info text-white-50" required />
			    </div>
			</div>
			<!--Grid column-->
			<!--Grid column-->
			<div class="col-md-8">
			    <div class="md-form mb-4">
				<label for="email" class="">Your email</label>
				<input type="email" id="email" name="email" class="form-control form-control-sm bg-transparent border-info text-white-50" required />
			    </div>
			</div>
		    </div>
		    <!--Grid row-->
		    <!--Grid row-->
		    <div class="row justify-content-center">
			<div class="col-md-8">
			    <div class="md-form mb-4">
				<label for="subject" class="">Subject</label>
				<input type="text" id="subject" name="subject" class="form-control form-control-sm bg-transparent border-info text-white-50" required />
			    </div>
			</div>
		    </div>
		    <!--Grid row-->
		    <!--Grid row-->
		    <div class="row justify-content-center">
			<!--Grid column-->
			<div class="col-md-8">
			    <div class="md-form">
				<label for="message">Question</label>
				<textarea rows="5" id="message" name="message" class="form-control md-textarea form-control-sm bg-transparent border-bottom border-info text-white-50" required></textarea>
			    </div>
			</div>
			<!--Grid row-->
			<div class="col-md-8 mt-3">
			    <a class="btn btn-outline-danger shadow font-weight-bold text-info" onclick="document.getElementById('contact-form').submit();">Send</a>
			</div>                
		    </div>
		</form>
		<div class="status"></div>
	    </div>
	    <!--Grid column-->
    </section>
</div>
<%@ include file="footer.jsp" %>

