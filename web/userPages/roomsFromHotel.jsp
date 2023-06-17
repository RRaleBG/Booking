<!DOCTYPE>
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
<div class="container mb-2 py-3">
    <c:forEach var="soba" items="${listaSoba}">
       <div class="container p-3 border-0" style="max-width:800px;" >
	   <div class="card bg-glass border-0 p-3">
	       <h4 class="card-header text-white border-info bg-transparent"> Room number: ${soba.number}    </h4>
	       <table>
		   <tr class=" p-3 text-white-50">
		       <td>                  
			   Hotel name    <br>
			   Id room:      <br/>   
			   Id hotel:     <br/>    
			   Room number:  <br/>  
			   Beds:         <br/> 
			   Balkon        <br/>  
			   Smoking       <br/> 
			   Pets          <br/>
			   Tv            <br/>
		       </td>     
		       <td class="text-left fw-semibold text-white">        
			   ${ hotel.name } <br>
			   ${ soba.idRoom }     <br/>  
			   ${ soba.idHotel }     <br/>    
			   ${ soba.number }      <br/>  
			   ${ soba.bed }         <br/> 
			   ${ soba.balkon }      <br/>  
			   ${ soba.smoking }     <br/> 
			   ${ soba.pets }        <br/>              
			   ${ soba.tv }          <br/>
		       </td>
		       <td class="p-3"> 
			   <div class="col">
			       <div class="row">
				   <div class="p-1">
				       <img src="../Slike/${soba.imgPath}" class="img img-thumbnail bg-glass rounded border-0" alt="..." style="height: 16em; width: 25em;" align="right">         
				   </div>                          
			       </div>             
			   </div>
		       </td>  
		   </tr>             
		   <tr>
		       <td>
			   <div align="left">
			       <% if (user != null && autorizacija.isInRole (user.getUsername ()) == "user")
                                  {%>             
			       <a class="btn btn-outline-warning btn-sm shadow" href="./reserveRoom.jsp?idRoom=${soba.idRoom}&idHotel=${soba.idHotel}&id=${_idUser.id}">Reservation</a>
			       <%}
                               else if (user != null && autorizacija.isInRole (user.getUsername ()) == "menager")
                               {%>
			       <a class="btn btn-outline-warning btn-sm shadow" href="../managerPages/editRooms.jsp?idHotel=${hotel.idHotel}&idRoom=${soba.idRoom}">Edit room</a>
			       <%}%>
			   </div>
		       </td>
		   </tr>
	       </table>   
	   </div>  
       </div>
    </c:forEach> 
</div>
<%@ include file="../footer.jsp" %>