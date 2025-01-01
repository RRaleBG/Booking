<!DOCTYPE>
<%-- 
    Document   : editRooms
    Created on : May 12, 2023, 9:55:28 PM
    Author     : rale_
--%>
<%@page import="java.util.List"%>

<style>

    #upload
    {
        opacity: 0;
    }

    #upload-label
    {
        position: absolute;
        top: 50%;
        left: 1rem;
        transform: translateY(-50%);
    }

    .image-area
    {
        border: 2px dashed rgba(255, 255, 255, 0.7);
        padding: 1rem;
        position: relative;
    }

    .image-area::before
    {
        content: 'Uploaded image result';
        color: #fff;
        font-weight: bold;
        text-transform: uppercase;
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        font-size: 0.8rem;
        z-index: 1;
    }

    .image-area img {
        z-index: 2;
        position: relative;
    }

</style>

<%@ include file="../header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="../style.css" type="text/css"  /> 

<%  // AUTORIZACIJA 
    //
    user = (Users) session.getAttribute("user");

    int idHotel = Integer.parseInt(request.getParameter("idHotel"));
    int idRoom = Integer.parseInt(request.getParameter("idRoom"));

    UsersDAL ident = new UsersDAL(Konekcija.createConnection());

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (ident.isInRole(user.getUsername()) != "menager") {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (ident.isInRole(user.getUsername()) == "menager") {
        session.setAttribute("user", user);

        HotelDAL hotelPodaci = new HotelDAL(Konekcija.createConnection());
        Hotel hotel = hotelPodaci.getByHotelId(idHotel);
        request.setAttribute("hotel", hotel);

        RoomsDAL getRoom = new RoomsDAL(Konekcija.createConnection());
        Rooms roomInHotel = getRoom.getRoomFromHotel(idHotel, idRoom);

        request.setAttribute("room", roomInHotel);
    }
%>

<div class="container text-center mt-md-2 p-2">
    <%
        String por = (String) request.getAttribute("obavestenje");
        if (por != null) {
    %>
    <div class="alert border-1 bg-glass rounded-3 container shadow border-success align-items-center col-md-6" role="alert">
        <h4 class="text-center text-success">
            <%= request.getAttribute("obavestenje") != null ? request.getAttribute("obavestenje") : " "%>
            <button type="button" class="btn-close btn-outline-success offset-2 text-success" data-bs-dismiss="alert" aria-label="Close"/>
        </h4>
    </div>	
    <%}%>

    <div class="container mt-md-3 py-3">
        <div class="card bg-glass border-0 py-2">
            <div class="card-body p-2">

                <!-- Hotel Name -->
                <h5 class="col-md-2 text-white-50"> ${hotel.name} </h5>

                <form action="../EditRoom" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate >

                    <div class="row justify-content-center m-3">

                        <!-- Input fields -->
                        <div class="col-md-2 ml-3 p-2">

                            <!-- Hotel Id -->
                            <div style="display:none;">
                                <input type="hidden" name="idHotel" value="${hotel.idHotel}" id="form3Example1" >
                            </div>

                            <!-- Hotel Name -->
                            <input value="${hotel.idHotel}" type="text" readonly id="form3Example1" class="mt-3 rounded-5 form-control form-control-sm bg-glass bg-transparent text-white-50 fw-semibold text-center " required autofocus/>
                            <label class="text-white-50" for="form3Example1">Hotel room</label>

                            <!-- Room Id -->
                            <input name="idRoom" value="${room.idRoom}" type="text" id="form3Example1" class="mt-3 form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
                            <label class="  text-white-50 shadow-5-strong" for="form3Example1">Id room</label>

                            <!-- Room number -->
                            <input name="number" value="${room.number}" type="text"  id="form3Example1" class="mt-3 form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
                            <label class="  text-white-50" for="form3Example1">Room number</label>

                            <!-- Bed -->
                            <input name="bed" value="${room.bed}" id="form3Example1" class="mt-3 form-control form-control-sm bg-glass fw-semibold text-center " required autofocus/>
                            <label class="  text-white-50" for="form3Example1">Beds</label>

                            <!-- Button  -->
                            <div class="text-center pt-2 rounded-pill">
                                <button class="btn btn-sm btn-primary btn-block fa-lg gradient-custom-2 rounded-pill shadow mt-5" type="submit">Edit</button>
                            </div>
                        </div>

                        <!-- Check box fields -->
                        <div class="col-md-2 ml-5 mb-3 mt-md-5">

                            <!-- Balkon -->
                            <div class="mt-3 form-check form-switch text-center col-md-4 mb-4">
                                <input <c:if test="${room.balkon == 1}"> checked="checked" </c:if> name="balkon" class="form-check-input col-md-8" type="checkbox" role="switch" id="flexSwitchCheckDefault" >
                                <label class="form-check-label text-white-50" for="balkon">Balkon</label>
                            </div>

                            <!-- Smoking -->
                            <div class="mt-3 form-check form-switch text-center col-md-4 mb-4">
                                <input <c:if test="${room.smoking == 1}"> checked="checked"</c:if> name="smoking" class="form-check-input col-md-8" type="checkbox" role="switch" id="flexSwitchCheckDefault" />
                                <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">Smoking</label>
                            </div>		

                            <!-- PETS -->
                            <div class="mt-3 form-check form-switch text-center col-md-4 mb-4">
                                <input <c:if test="${room.pets == 1}"> checked="checked" </c:if> name="pets" class="form-check-input col-md-8" type="checkbox" role="switch" id="flexSwitchCheckDefault" />
                                <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">Pets</label>
                            </div>

                            <!-- TV -->
                            <div class="mt-3 form-check form-check form-switch text-center col-md-4 mb-4">
                                <input <c:if test="${room.tv == 1}"> checked="checked" </c:if> name="tv" class="form-check-input col-md-8" type="checkbox" role="switch" id="flexSwitchCheckDefault" />
                                <label class="form-check-label text-white-50" for="flexSwitchCheckDefault">Tv</label>
                            </div>
                        </div>

                        <!-- IMAGE -->
                        <div class="col">
                            <div class="justify-content-center">
                                <!-- Uploaded image area -->
                                <div class="image mt-2 p-2">
                                    <img id="blah" src="../Slike/Sobe/${room.imgPath}" alt="image" class="img-thumbnail mx-auto d-block bg-glass border-0" style="height:25em;">		
                                </div>

                                <!-- Upload image input -->
                                <div class="input-group mb-2 rounded-pill mt-3 bg-glass">
                                    <input id="imgInp" accept="image/*" name="imgPath" type="file" class="form-control form-control-sm border-0 rounded-pill bg-glass" >
                                    <label id="upload-label" for="imgInp" class="font-weight-light text-muted bg-glass"></label> 
                                </div>
                            </div>
                        </div> 
                    </form>
                </div>
            </div>
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