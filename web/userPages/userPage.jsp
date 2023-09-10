<!DOCTYPE>
<%@page import="model.UsersDAL"%>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<title>User page</title>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>
<link rel="stylesheet" href="../style.css" type="text/css"/>  
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt"  prefix = "fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn"%>

<%  //
    //
    user = (Users) session.getAttribute("user");

    UsersDAL getDetails = new UsersDAL(Konekcija.createConnection());

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (getDetails.isInRole(user.getUsername()) != "user") {
        response.sendRedirect(request.getContextPath() + "/error.jsp");
    } else if (getDetails.isInRole(user.getUsername()) == "user") {
        Users korisnik = (Users) session.getAttribute("userId");
        request.setAttribute("userDetails", getDetails.getByUserId(korisnik.getId()));

        String roleName = getDetails.updateRole(korisnik.getId());
        request.setAttribute("roleName", roleName);

        RezervationsDAL rez = new RezervationsDAL(Konekcija.createConnection());
        List<Rezervations> listRezervation = rez.getAllRezervationsFromUserId(korisnik.getId());
        request.setAttribute("listaRez", listRezervation);
    }
%>
<div class="container-fluid m-auto w-auto">   
    <%
        String e = (String) request.getAttribute("userId");
        if (e != null) {%>
    <div class="alert border-1 bg-glass rounded-3 container shadow border-success align-items-center col-md-8 mt-5" role="alert">
        <h4 class="text-center text-success">
            <%= request.getAttribute("poruka") != null ? request.getAttribute("poruka") : " "%>
            <button type="button" class="btn-close btn-outline-success offset-2 text-success" data-bs-dismiss="alert" aria-label="Close"/>
        </h4>
    </div>	
    <%}%>

    <div class="row mt-5">      

        <!-- USER DETAILS fixed-top-->
        <div class="col-lg-4 ml-2 w-auto">

            <!-- USER image -->
            <div class="bg-glass mb-4 py-3 text-center">		
                <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava5.webp" alt="avatar" class="rounded-circle img-fluid shadow" style="width: 150px;">
                <h5 class="my-3">${userDetails.firstname} ${userDetails.lastname}</h5>                     
            </div>

            <!-- USER details -->
            <div class="bg-glass px-4 mb-4 mb-lg-0">  

                <h5 class="text-white-50 text-center p-3 mb-0 border-bottom border-info">Details</h5>

                <div class="card-body p-2 text-left mb-4 ml-3">

                    <div class="row py-1">
                        <div class="col">
                            <p class="mb-0 text-white-50">ID</p>                        
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${userDetails.id}</p>                        
                        </div>
                    </div>
                    <div class="row py-31">
                        <div class="col">
                            <p class="mb-0 text-white-50">Username</p>                        
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${userDetails.username}</p>                        
                        </div>
                    </div>
                    <div class="row py-1">
                        <div class="col">
                            <p class="mb-0 text-white-50">Email</p>
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${userDetails.email}</p>
                        </div>
                    </div>
                    <div class="row py-1">
                        <div class="col">
                            <p class="mb-0 text-white-50">Password</p>
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${userDetails.password}</p>
                        </div>
                    </div>
                    <div class="row py-1">
                        <div class="col">
                            <p class="mb-0 text-white-50">Points</p>
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${userDetails.points }</p>
                        </div>
                    </div>
                    <div class="row py-1">
                        <div class="col">
                            <p class="mb-0 text-white-50">Status</p>
                        </div>
                        <div class="col">
                            <p class="text-white-50 mb-0">${roleName}</p>
                        </div>
                    </div>
                </div>         
            </div>
        </div>

        <sql:setDataSource var="booking" driver="com.mysql.cj.jdbc.Driver" url="jdbc:mysql://localhost/booking"  user="root" password=""/>

        <sql:query dataSource="${booking}" sql="SELECT 
                   u.username as 'Username', 
                   h.name as 'Hotel', 
                   r.idRes,
                   r.idGest, 
                   r.dateCheckIn,
                   r.dateCheckOut,
                   DATEDIFF(r.dateCheckOut,r.dateCheckIn) as 'Days'
                   ,r.price,  
                   r.price * DATEDIFF(r.dateCheckOut, r.dateCheckIn) as 'Total',
                   r.canceledRes
                   FROM reservations r
                   JOIN users u on r.idGest = u.id
                   JOIN hotel h on r.idHotel = h.idHotel
                   WHERE u.id=${userDetails.id}"
                   var="result" 
                   />

        <div class="col-lg-7 w-auto mr-0">
            <table class="table table-borderless mt-0 text-small bg-glass table-hover text-center rounded-3">
                <tr class="text-info border-bottom border-info text-center text-small">
                    <th> Hotel	    </th>		
                    <th> Book No.   </th>
                    <th> Check In   </th>
                    <th> Check Out  </th>
                    <th> Days	    </th>
                    <th> Price	    </th>
                    <th> Total	    </th> 
                    <th> Canceled   </th>  
                    <th> Cancel     </th>
                </tr>
                <c:forEach var = "row" items = "${result.rows}">
                    <tr class="text-white-50 text-center p-0 mr-0 text-small">
                        <td class="px-0 text-white-50"> <c:out value = "${row.name} "/></td>
                        <td class="px-0 text-white-50"> <c:out value = "${row.idRes} "/></td>
                        <td class="px-0 text-white-50"> <c:out value = "${row.dateCheckIn} "/></td>
                        <td class="px-0 text-white-50"> <c:out value = "${row.dateCheckOut} "/></td>
                        <td class="text-danger px-0 fw-semibold"> <c:out value = "${row.Days} "/></td>
                        <td class="text-success px-0"> <c:out value = "${row.price} $"/></td>
                        <td class="text-warning px-0"> <c:out value = "${row.Total} $"/></td> 
                        <td>
                            <c:if test="${ row.canceledRes == false }">
                                <span class='badge shadow text-bg-success mt-1 px-3'>Booked</span>		   
                            </c:if>
                            <c:if test="${ row.canceledRes == true}">
                                <span class='badge text-bg-danger mt-1 px-2'>Canceled</span>		   
                            </c:if>
                        </td>		 
                        <td>   
                            <a href="<%=request.getContextPath()%>/userPages/cancelReservations.jsp?idRes=${row.idRes}" title='Delete' class="bi bi-trash shadow ml-2 mt-1" style='color: red;'> </a> 
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>	
    </div>
</div>
<%@ include file="../footer.jsp" %>
<%-- <td> ${i.canceledRes ? true : "Not canceled"}  </td>	  --%>
<%-- SELECT DATEDIFF(r.dateCheckOut,r.dateCheckIn), r.price FROM reservations r; --%>
<%--  SELECT r.idRes,r.idGest, DATEDIFF(r.dateCheckOut,r.dateCheckIn) as 'Days count',r.price,  r.price * DATEDIFF(r.dateCheckOut,r.dateCheckIn) as 'Total price'  FROM reservations r --%>