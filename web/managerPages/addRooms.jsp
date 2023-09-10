<!DOCTYPE>
<%-- 
    Document   : addRooms
    Created on : May 12, 2023, 9:55:42 PM
    Author     : rale_
--%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%  // AUTORIZACIJA 
    user = (Users) session.getAttribute("user");
    UsersDAL ident = new UsersDAL(Konekcija.createConnection());

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (ident.isInRole(user.getUsername()) != "menager") {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (ident.isInRole(user.getUsername()) == "menager") {
        session.setAttribute("user", user);

        HotelDAL hotelPodaci = new HotelDAL(Konekcija.createConnection());
        RoomsDAL roomsPodaci = new RoomsDAL(Konekcija.createConnection());

        List<Hotel> hoteli = hotelPodaci.getAllHotels();
        request.setAttribute("hoteli", hoteli);

        List<Rooms> sobe = roomsPodaci.getAllRooms();
        request.setAttribute("sobe", sobe);
    }
%>
<div class="container mt-3 py-3">
    <%   String e = (String) request.getAttribute("poruka");
        if (e != null) {%>
    <h2 class="card-header border-0 text-danger bg-transparent mt-2">
        <%= request.getAttribute("poruka") != null ? request.getAttribute("poruka") : " "%>
    </h2>
    <%}%>
    <div class="card bg-glass border-0 py-2">
        <h2 class="card-header border-0 bg-transparent text-center"> New room </h2>	
        <div class="card-body py-2">

            <form action="../AddRoom" method="POST" enctype="multipart/form-data" class="needs-validation" novalidate>
                <div class="row m-3">

                    <div class="col-md-4 mt-4">
                        <!--  NAME input --> 
                        <div class="row ml-3">
                            <div class="col-md-12 mb-3 form-outline text-center">
                                <div class="dropdow shadow">
                                    <select id="idHotel" name="idHotel" class="form-control btn-outline-info background-radial-gradient text-center text-white">
                                        <c:forEach var="h" items="${hoteli}">
                                            <option value="${h.idHotel}" name="idHotel" class="dropdown-item background-radial-gradient text-center text-white">${h.name}</option>
                                        </c:forEach>
                                    </select>	    
                                </div>	
                            </div>

                            <!-- NUMBER -->
                            <div class="col-md-6 mt-3">
                                <div class="form-outline text-center">
                                    <input type="number" name="number" id="form3Example2" class="form-control bg-glass form-control-sm fw-semibold shadow" required/>
                                    <label class="form-label" for="form3Example2">Room number</label>
                                </div>
                            </div>
                            <!-- BEDS-->
                            <div class="col-md-6 mt-3">
                                <div class="form-outline text-center mb-3">
                                    <input type="number" name="bed" id="form3Example5" class="form-control bg-glass form-control-sm fw-semibold shadow" required />
                                    <label class="form-label" for="form3Example5">Beds</label>
                                </div>    
                            </div>
                        </div>
                        <!-- CHECK-BOXES -->
                        <div class="row w-100 ml-3">
                            <!-- Balcon -->
                            <div class="col-6 w-25">
                                <div class="form-check form-switch text-center">
                                    <input type="checkbox" id="form3Example5" name="balkon" class="form-check-input col-md-6" role="switch"  />
                                    <label class="form-label" for="form3Example5">Balcon</label>
                                </div>    
                            </div>
                            <!-- SMOKING -->
                            <div class="col-6 w-25">
                                <div class="form-check form-switch text-center">
                                    <input type="checkbox" id="form3Example5" name="smoking" class="form-check-input col-md-5" role="switch"  />
                                    <label class="form-label" for="form3Example5">Smoking</label>
                                </div>    
                            </div>
                        </div>
                        <div class="row ml-2">
                            <!-- PETS -->
                            <div class="col-6">
                                <div class="form-check form-switch text-center">
                                    <input type="checkbox" id="form3Example5" name="pets" class="form-check-input col-md-6" role="switch"  />
                                    <label class="form-label" for="form3Example5">Pets</label>
                                </div>    
                            </div>
                            <!-- TV -->
                            <div class="col-6 w-25 mb-5">
                                <div class="form-check form-switch text-center">
                                    <input type="checkbox" id="form3Example5" name="tv" class="form-check-input" role="switch"  />
                                    <label class="form-label" for="form3Example5">Tv</label>
                                </div>    
                            </div>
                        </div>

                        <!-- Button  -->
                        <div class="col-md-12 ml-2 mt-lg-5 justify-content-centertext-center rounded-pill">
                            <button class="btn btn-sm btn-primary btn-block fa-lg gradient-custom-2 rounded-pill shadow-lg" type="submit">Insert</button>
                        </div> 		
                    </div>    

                    <!-- IMAGE -->
                    <div class="col-md-8 mt-1">

                        <div class="justify-content-center">
                            <!-- Uploaded image area-->
                            <div class="image p-2 mr-4">
                                <img id="blah" src="../Slike/Sobe/${imgPath}" alt="image" class="img-thumbnail mx-auto d-block bg-glass border-0" style="height:20em; width: auto;">
                            </div>
                            <div class="ml-5 pl-5">
                                <!-- Upload image input-->
                                <div class="input-group rounded-pill p-2 w-50 ml-5 pl-5">
                                    <input id="imgInp" accept="image/*" name="imgPath" type="file" class="form-control form-control-sm bg-glass border-0 rounded-pill" required>
                                    <label id="upload-label" for="imgInp" class="bg-dark  text-muted"></label> 
                                </div> 	
                            </div>
                        </div>
                    </div>
                </div>
            </form>
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


// show uploaded image instant
    imgInp.onchange = evt => {
        const [file] = imgInp.files
        if (file) {
            blah.src = URL.createObjectURL(file)
        }
    }
</script>
<%@ include file="../footer.jsp" %>
