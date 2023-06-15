<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.HotelDAL" %>
<%@page import="model.Hotel" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%  // autorizacija
   //
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

      HotelDAL hotelPodaci = new HotelDAL (Konekcija.createConnection ());

      List<Hotel> hotel = hotelPodaci.getAllHotels ();
      request.setAttribute ("listaHotela", hotel);
   }
%>
<div class="container-fluid w-75">
    <%
       String por = (String) request.getAttribute ("obavestenje");
       if (por != null)
       {
    %>
    <div class="alert border-1 bg-glass rounded-3 shadow border-danger mt-3 align-items-center" role="alert">
	<h4 class="text-center text-warning">
	    <%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
	    <button type="button" class="btn-close offset-2" data-bs-dismiss="alert" aria-label="Close"/>
	</h4>
    </div>	
    <%}%>
    <c:forEach var="hot" items="${listaHotela}">
       <div class="card card-deck md-1 py-1 bg-glass m-2 rounded-3" style="display:inline-block;">
	   <div class="card-header text-white-50 fw-semibold border-0">
	       ${hot.name}
	       <c:forEach begin="1" step="1"  end="${hot.stars}"> 
		  <% out.print ("<i class=\"bi bi-star-fill mr-2 mt-2 float-md-end shadow outline-warning\" style=\"color:yellow;\"></i>");%>
	       </c:forEach> 
	   </div>
	   <div class="border-0 rounded-2 px-1">
	       <a rel="alternate"  href="<%= request.getContextPath ()%>/userPages/roomsFromHotel.jsp?idHotel=${hot.idHotel}" target="_self">        
		   <img src="<%= request.getContextPath () + "/Slike/"%>${hot.imagePath}" class="img img-thumbnail bg-glass rounded border-0" alt="..." style="height: 14em; width: 21em;">		   
	       </a>
	   </div> 
	   <div class="card-footer border-0 align-items-center ml-3">	       
	       <a class="btn btn-outline-info btn-sm shadow ml-3" href="<%= request.getContextPath ()%>/userPages/roomsFromHotel.jsp?idHotel=${hot.idHotel}">Rooms</a>
	       <a class="btn btn-outline-danger btn-sm shadow ml-3" href="<%= request.getContextPath ()%>/managerPages/deleteHotel.jsp?idHotel=${hot.idHotel}">Delete</a>
	       <a class="btn btn-outline-warning btn-sm shadow ml-3" href="<%= request.getContextPath ()%>/managerPages/editHotel.jsp?idHotel=${hot.idHotel}">Edit hotel</a>
	   </div>
       </div>
    </c:forEach> 
</div>
<%@ include file="../footer.jsp" %> 