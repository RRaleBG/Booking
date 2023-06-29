<!DOCTYPE>
<title>Rooms</title>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%    //
   //
   int idHotel = Integer.parseInt (request.getParameter ("idHotel"));
   //int id = Integer.parseInt (request.getParameter ("userId"));

   UsersDAL autorizacija = new UsersDAL (Konekcija.createConnection ());

   user = (Users) session.getAttribute ("user");

   if (user != null)
   {
      Users getUser = autorizacija.getByUserId (user.getId ());
      request.setAttribute ("getUser", getUser);

      HotelDAL hotelPodaci = new HotelDAL (Konekcija.createConnection ());

      List<Rooms> hotelRooms = hotelPodaci.getRoomsFromHotel (idHotel);

      request.setAttribute ("listaSoba", hotelRooms);

      Hotel hotel = hotelPodaci.getByHotelId (idHotel);
      request.setAttribute ("hotel", hotel);
   }
   else
   {
      response.sendRedirect ("../login.jsp");
   }
%>
<div class="container-fluid w-75 mt-3 py-3">
    <%  String e = (String) request.getAttribute ("obavestenje");
       if (e != null)
       {
    %>
    <h4 class="alert shadow border-1 bg-glass text-center text-success color-success border-success">
        <%= request.getAttribute ("obavestenje") != null ? request.getAttribute ("obavestenje") : " "%>
        <button type="button" class="btn-close btn-outline-success offset-1 text-success" data-bs-dismiss="alert" aria-label="Close"/>
    </h4>    
    <%}%>   

    <c:forEach var="soba" items="${listaSoba}">
       <div class="card card-deck bg-glass m-2 rounded-3" style="display:inline-block;">

	   <div class="card-header text-white-50 fw-semibold border-0 mr-0">
	       Room: ${soba.number}
	   </div>

	   <div class="border-0 p-1">	           
	       <img src="<%= request.getContextPath () + "/Slike/Sobe/"%>${soba.imgPath}" class="img img-thumbnail bg-glass rounded border-0" alt="..." style="height: 14em; width: 20em;">	
	   </div> 

	   <div class="card-footer border-0 ml-3">

	       <%-- Balkon --%>	
	       <c:if test="${ soba.balkon == 0}">
		  <span class='badge text-bg-danger mr-4 py-1'>Balkon</span>		   
	       </c:if>
	       <c:if test="${ soba.balkon == 1}">
		  <span class='badge text-bg-success mr-4'>Balkon</span>		   
	       </c:if>

	       <%-- Smoking --%>
	       <c:if test="${ soba.smoking == 0}">
		  <span class='badge text-bg-danger mr-4'>Smoking</span>		   
	       </c:if>
	       <c:if test="${ soba.smoking == 1}">
		  <span class='badge text-bg-success mr-4'>Smoking</span>		   
	       </c:if>

	       <%-- Pets --%>
	       <c:if test="${ soba.pets == 0}">
		  <span class='badge text-bg-danger mr-4'>Pets</span>		   
	       </c:if>
	       <c:if test="${ soba.pets == 1}">
		  <span class='badge text-bg-success mr-4'>Pets</span>		   
	       </c:if>

	       <%-- Tv --%>
	       <c:if test="${ soba.tv == 0}">
		  <span class='badge text-bg-danger mr-3'>Tv</span>		   
	       </c:if>
	       <c:if test="${ soba.tv == 1}">
		  <span class='badge text-bg-success mr-3'>Tv</span>		   
	       </c:if>
	   </div>

	   <%-- Rola-Menager-button: - Edit room -  Rola-User-button: - Reservation  --%>
	   <div class="py-1 mx-4 mb-1">
	       <% if (user != null && autorizacija.isInRole (user.getUsername ()) == "user")
                  { %>             
	       <a class="btn btn-outline-warning btn-sm shadow-md" href="./reserveRoom.jsp?idRoom=${soba.idRoom}&idHotel=${soba.idHotel}&id=${_idUser.id}">Reservation</a>
	       <%}
               else if (user != null && autorizacija.isInRole (user.getUsername ()) == "menager")
               { %>
	       <a class="btn btn-outline-warning btn-sm shadow" href="../managerPages/editRooms.jsp?idHotel=${hotel.idHotel}&idRoom=${soba.idRoom}">Edit room</a>
	       <%}%>
	   </div>

       </div>
    </c:forEach> 

</div>
<%@ include file="../footer.jsp" %>