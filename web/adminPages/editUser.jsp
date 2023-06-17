<%-- 
    Document   : editUser
    Created on : May 12, 2023, 9:56:38 PM
    Author     : rale_
--%>
<!DOCTYPE>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>
<%    //
   int id = Integer.parseInt (request.getParameter ("id"));
   UsersDAL userPodaci = new UsersDAL (Konekcija.createConnection ());

   Users editUser = userPodaci.getByUserId (id);
   request.setAttribute ("editUser", editUser);

   String idRola = userPodaci.updateRole (id);
   request.setAttribute ("rola", idRola);
%>
<div class="container fw-bold" style=" max-width: 600px;">


    <%
       String e = (String) request.getAttribute ("obavestenje");
       if (e != null)
       {
    %>
    <h2 class="alert mt-3 shadow shadow-lg border-1 bg-glass text-center text-success color-success border-success">
	<%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
    </h2>
    <%}
    else
    {%>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
	<%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
    </h2>
    <%}%>
    <div class="card bg-glass mt-5">
	<h2 class="card-header border-0 bg-transparent mt-3 text-center">Edit:  ${editUser.firstname} </h2>
	<div class="card-body px-4 py-4">

	    <form action="../EditUser" method="POST">

		<input type="hidden" name="id" value="${editUser.id}"/>

		<!-- ID user input -->
		<div class="form-outline mb-4">
		    <label class="form-label "  for="form3Example3">ID: ${editUser.id}</label>
		</div>          
		<!-- FIRST NAME input -->
		<div class="row">
		    <div class="col-md-6 mb-4">
			<div class="form-outline text-center">
			    <input type="text" name="firstname" value="${editUser.firstname}" id="form3Example1" class="form-control fw-semibold shadow" required autofocus/>
			    <label class="form-label" for="form3Example1">First name</label>
			</div>
		    </div>
		    <!-- LAST NAME input -->
		    <div class="col-md-6 mb-4">
			<div class="form-outline text-center">
			    <input type="text" name="lastname" value="${editUser.lastname}" id="form3Example2" class="form-control fw-semibold shadow" required/>
			    <label class="form-label" for="form3Example2">Last name</label>
			</div>
		    </div>
		    <!-- USERNAME input -->
		    <div class="col-md-6 mb-4">
			<div class="form-outline text-center mb-3">
			    <input type="text" name="username" value="${editUser.username}" id="form3Example5" class="form-control fw-semibold shadow" required />
			    <label class="form-label" for="form3Example5">Username</label>
			</div>    
		    </div>
		    <!-- ROLE input -->
		    <div class="col-md-6 mb-4">
			<div class="form-outline text-center mb-3">			    
			    <select id="idRola" class="form-control text-center  fw-semibold shadow" name="rola">
				<option class="form-control text-center text-white-50 fw-semibold" value="${idRola}"><%=idRola%></option>  
			    </select>
			    <label class="form-label" for="form3Example5">Rola</label>
			</div>
		    </div>

		    <!-- EMAIL input -->
		    <div class="form-outline text-center mb-4">
			<input type="email" name="email" value="${editUser.email}" id="form3Example3" class="form-control fw-semibold shadow" required/>
			<label class="form-label" for="form3Example3">Email address</label>
		    </div>
		</div>
		<!-- SUBMIT  BUTTON -->       
		<div class="text-center pt-1 mb-4 pb-1">
		    <button class="btn w-100 btn-primary btn-block fa-lg gradient-custom-2 mb-1 shadow" type="submit">Update</button><br>  
		</div>  
	    </form>
	</div>
    </div>
</div>
<%@ include file="../footer.jsp" %>