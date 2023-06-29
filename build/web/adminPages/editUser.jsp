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
    int id = Integer.parseInt(request.getParameter("id"));
    UsersDAL userPodaci = new UsersDAL(Konekcija.createConnection());

    Users editUser = userPodaci.getByUserId(id);
    request.setAttribute("editUser", editUser);

    //String idRola = userPodaci.updateRole(id);
    //request.setAttribute("rola", idRola);
    RoleDAL rd = new RoleDAL(Konekcija.createConnection());

    List<Role> userRoles = rd.getAllRoles();
    request.setAttribute("userRoles", userRoles);
%>
<div class="container fw-bold" style=" max-width: 500px;">

    <% String e = (String) request.getAttribute("obavestenje");
        if (e != null) {
    %>
    <h2 class="alert mt-3 shadow shadow-lg border-1 bg-glass text-center text-success color-success border-success">
        <%= request.getAttribute("obavestenje") != null ? request.getAttribute("obavestenje") : " "%>
    </h2>
    <%}
        String err = (String) request.getAttribute("err");
        if (err != null) {%>
    <h2 class="alert mt-3 shadow shadow-lg border-1 bg-glass text-center text-danger color-success border-danger">
        <%= request.getAttribute("err") != null ? request.getAttribute("err") : " "%>
    </h2>
    <%}%>
    <div class="card bg-glass mt-4">
        <h2 class="card-header border-0 bg-transparent text-center">Edit:  ${editUser.firstname} </h2>
        <div class="card-body py-4">
            <form action="../EditUser" method="POST">

                <input style="display:none;" type="hidden" name="id" value="${editUser.id}"/>

                <!-- ID user input -->
                <div class="form-outline mb-2">
                    <label class="form-label"  for="form3Example3">ID: ${editUser.id}</label>
                </div>          
                <!-- FIRST NAME input -->
                <div class="row">
                    <div class="col-md-6 mb-2">
                        <div class="form-outline text-center">
                            <input type="text" name="firstname" value="${editUser.firstname}" id="form3Example1" class="form-control fw-semibold shadow" required autofocus/>
                            <label class="form-label" for="form3Example1">First name</label>
                        </div>
                    </div>
                    <!-- LAST NAME input -->
                    <div class="col-md-6 mb-2">
                        <div class="form-outline text-center">
                            <input type="text" name="lastname" value="${editUser.lastname}" id="form3Example2" class="form-control fw-semibold shadow" required/>
                            <label class="form-label" for="form3Example2">Last name</label>
                        </div>
                    </div>
                    <!-- USERNAME input -->
                    <div class="col-md-6 mb-3">
                        <div class="form-outline text-center">
                            <input type="text" name="username" value="${editUser.username}" id="form3Example5" class="form-control fw-semibold shadow" required />
                            <label class="form-label" for="form3Example5">Username</label>
                        </div>    
                    </div>

                    <!-- ROLE Edit list -->
                    <div class="col-md-6 mb-2">
                        <div class="form-outline text-center mb-2">			    
                            <select id="idRole" name="idRole" class="form-control text-center  fw-semibold shadow">
                                <c:forEach var="s" items="${userRoles}">
                                    <option name="idRole" value="${s.idRole}" class="form-control text-center text-white-50 bg-dark fw-semibold">${s.roleName}</option>
                                </c:forEach>
                            </select>
                            <label class="form-label" for="form3Example5">Sve role</label>
                        </div>
                    </div>



                    <!-- EMAIL input -->
                    <div class="form-outline text-center mb-2">
                        <input type="email" name="email" value="${editUser.email}" id="form3Example3" class="form-control fw-semibold shadow" required/>
                        <label class="form-label" for="form3Example3">Email address</label>
                    </div>
                </div>
                <!-- SUBMIT  BUTTON -->       
                <div class="text-center pt-1 pb-1">
                    <button class="btn w-100 btn-primary btn-block fa-lg gradient-custom-2 mb-1 shadow" type="submit">Update</button><br>  
                </div>  
            </form>
        </div>
    </div>
</div>
<%@ include file="../footer.jsp" %>