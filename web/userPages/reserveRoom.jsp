<!DOCTYPE>
<title>Reservation</title>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/> 
<%  //
    user = (Users) session.getAttribute("user");

    UsersDAL autorizacija = new UsersDAL(Konekcija.createConnection());

    if (autorizacija.validate(user) == false) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
    }
    user = (Users) session.getAttribute("userId");

    int idRoom = Integer.parseInt(request.getParameter("idRoom"));
    int idHotel = Integer.parseInt(request.getParameter("idHotel"));

    HotelDAL hotelCnn = new HotelDAL(Konekcija.createConnection());
    RoomsDAL roomCnn = new RoomsDAL(Konekcija.createConnection());
    RezervationsDAL rezCnn = new RezervationsDAL(Konekcija.createConnection());

    Hotel hotel = (Hotel) request.getAttribute("idHotel");
    Rooms room = (Rooms) request.getAttribute("idRoom");
    Rezervations rezervation = new Rezervations();

    roomCnn.getAllRoomsFromHotel(idRoom);

    if (idRoom != 0) {
        request.setAttribute("hotelskaSoba", hotelCnn.getByHotelId(idHotel));
        request.setAttribute("soba", roomCnn.getRoomFromHotel(idHotel, idRoom));
        request.setAttribute("id", user = (Users) session.getAttribute("userId"));
    }
%>
<style>
    body {
        background-image: url(../Slike/Budim.jpg);
        background-size: cover;
        background-repeat: no-repeat;
        height: 100%;
    }

    .container{
        position: relative;
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 1000;
        filter: blur(25%);
    }

    .bg-2 {
        background-attachment: fixed;
        position: relative;
        top: 30vh;
        max-width: 750px;
        padding: 50px;
        box-shadow: 0 10px 20px rgba(236, 221, 221, 0.5);
    }
</style>
<div class="container">
    <div class="bg-glass bg-2 mt-2 shadow shadow-md">
        <%
            String por = (String) request.getAttribute("poruka");
            if (por != null) {
        %>
        <div class="alert border-1 bg-glass rounded-3 container shadow border-danger mt-3 align-items-center col-md-6" role="alert">
            <h4 class="text-center text-success">
                <%= request.getAttribute("poruka") != null ? request.getAttribute("poruka") : " "%>
                <button type="button" class="btn-close btn-outline-danger offset-1 text-danger" data-bs-dismiss="alert" aria-label="Close"/>
            </h4>
        </div>	

        <%
            }
        %>
        <form action="../Rezervation" method="POST">

            <h5 class="text-white">Hotel: ${hotelskaSoba.name}</h5>
            <h5 class="text-white mb-4"> Name: ${id.username}</h5>    
                
                <input type="hidden" name="idGest" value="${id.id}"/>
                <input type="hidden" name="idHotel" value="${hotelskaSoba.idHotel}"/>
                <input type="hidden" name="idRoom" value="${soba.idRoom}"/>
               
                <div class="row no-margin">

                    <div class="col-md-2">
                        <div class="form-group">
                            <span class="form-label">City</span>
                            <%-- <input class="form-control shadow" disabled type="text" placeholder="${hotelskaSoba.city}"> --%>
                            <h4 >${hotelskaSoba.city}</h4>
                        </div>
                    </div>	              

                    <div class="col-md-1 text-center">
                        <span class="form-label">Room</span>
                        <%-- <input class="form-control shadow" disabled type="text" placeholder="${hotelskaSoba.city}"> --%>
                        <h3 class="ml-3">${soba.number}</h3>

                    </div>	
                    <div class="col mr-2">
                        <div class="row">
                            <div class="col">
                                <div class="form-group text-end">
                                    <span class="form-label">Check In</span>
                                    <input class="form-control shadow" type="date" name="dateCheckIn"  required>
                                </div>
                            </div>
                            <div class="col">
                                <div class="form-group text-end">
                                    <span class="form-label">Check out</span>
                                    <input class="form-control shadow text-sm" type="date" name="dateCheckOut" required>
                                </div>
                            </div>	
                            <div class="col mt-4 text-end">		 
                                <input type="submit" value="Book me" class="btn btn-danger shadow-lg"/>
                            </div>
                        </div>
                    </div>		    

                </div>
        </form>
    </div>
</div>
<%@ include file="../footer.jsp" %>
