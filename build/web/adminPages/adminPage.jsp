<%-- 
    Document   : adminPage
    Created on : May 12, 2023, 9:59:53 PM
    Author     : rale_
--%>
<%@page import="java.util.List"%>
<%@page import="model.Users" %>
<%@page import="model.UsersDAL" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%-- AUTORIZACIJA --%>
<%   //
   user = (Users) session.getAttribute ("user");
   UsersDAL ident = new UsersDAL (Konekcija.createConnection ());

   if (user == null)
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) != "admin")
   {
      response.sendRedirect (request.getContextPath () + "/error.jsp");
   }
   else if (ident.isInRole (user.getUsername ()) == "admin")
   {
      session.setAttribute ("user", user);

      List<Users> lista = ident.getAllUsers ();
      request.setAttribute ("userLista", lista);
   }
%>
<div class="container">

    <%
       String e = (String) request.getAttribute ("obavestenje");
       if (e != null)
       {
    %>
    <h2 class="alert mt-3 shadow border-1 bg-glass text-center text-success color-success border-success">
	<%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>

    </h2>
    <%}
    else
    {%>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
	<%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
    </h2>
    <%}%>
    <div class="mt-3 text-info">
	<table class="table py-5 px-4 table-borderless bg-glass table-hover text-center">
	    <thead class="text-info border-bottom border-info">
		<tr class="">
		    <th> Id        </th>
		    <th> Username  </th>
		    <th> First name </th>  
		    <th> Last name  </th>   
		    <th> Email     </th>
		    <th> Password  </th>  
		    <th> Points    </th>  
		    <th> Bee smart </th>
		</tr>
	    </thead>
	    <c:forEach var="i" items="${userLista}">
	       <tbody>
		   <tr class="text-light py-3">        
		       <td> ${i.id}        </td>
		       <td> ${i.username}  </td>
		       <td> ${i.firstname} </td>
		       <td> ${i.lastname}  </td>
		       <td> ${i.email}     </td>
		       <td> ${i.password}  </td>
		       <td> ${i.points}    </td>
		       <td>
			   <a href="<%=request.getContextPath ()%>/adminPages/editUser.jsp?id=${i.id}" class="mr-3 bi bi-pen" title="Update" data-toggle="tooltip"></a>
			   <a href="<%=request.getContextPath ()%>/adminPages/detailUser.jsp?id=${i.id}" class="mr-3 bi bi-book" title="Details" style='color:#00ff1f;' data-toggle="tooltip"></a>				   
			   <a href="<%=request.getContextPath ()%>/adminPages/deleteUser.jsp?id=${i.id}" title='Delete' class="bi bi-trash" data-toggle='mymodal' style='color: red;'></a>     
		       </td>
		   </tr>
	       </tbody>
	    </c:forEach>
	</table>
    </div>
</div>
<%-- AJAX za live pretragu --%>
<script src="https://code.jquery.com/jquery-3.5.1.min.js">
   $(document).ready(function ()
   {
      $('.search-box input[type="text"]').on("keyup input", function ()
      {
	 var inputVal = $(this).val();

	 var resultDropdown = $(this).siblings("#result");

	 if (inputVal.length)
	 {
	    $.get("jspf/search.jspf", {term: inputVal})
		    .done(function (data)
		    {
		       resultDropdown.html(data);
		    });
	 } else
	 {
	    resultDropdown.html(data);
	 }
      });

      // Set search input value on click of result item
      $(document).on("click", "#result", function () {
	 $(this).parents(".search-box").find('input[type="text"]').val($(this).text());
	 $(this).parent(".result").empty();
      });
   });
</script>
<%@ include file="../footer.jsp" %>

<%-- <a href="detailUser.jsp?id=${i.id}" class="mr-3" title="Details" data-toggle="tooltip"><span class="bi bi-book" style="color:#00ff1f;"></span></a> --%>