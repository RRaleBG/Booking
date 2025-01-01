<!DOCTYPE>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<title>Contact</title>
<%@ include file="header.jsp" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/fmt"  prefix = "fmt"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn"%>

<div class="container mb-4 py-3">
    <section class="container-sm mb-3 text-info">

	<sql:setDataSource var = "booking" driver = "com.mysql.cj.jdbc.Driver"  url = "jdbc:mysql://localhost/booking"  user = "root"  password = ""/>

	<sql:query dataSource = "${booking}" sql = "SELECT 
		   u.username as 'Username', 
		   h.name as 'Hotel', r.idRes,
		   r.idGest, 
		   DATEDIFF(r.dateCheckOut,r.dateCheckIn) as 'Days',r.price,  
		   r.price * DATEDIFF(r.dateCheckOut,
		   r.dateCheckIn) as 'Total'  FROM reservations r
		   JOIN users u on r.idGest = u.id
		   JOIN hotel h on r.idHotel = h.idHotel" var = "result" />

	<table class="table table-borderless table-hover">
	    <tr class="text-white border-bottom border-info text-center">
		<th> Username  </th>
		<th> Hotel     </th>
		<th> Guest No. </th>
		<th> Book No.  </th>
		<th> Days      </th>
		<th> Price     </th>
		<th> Total     </th> 
	    </tr>
	    <c:forEach var = "row" items = "${result.rows}">
	       <tr class="text-white text-center">
		   <td> <c:out value = "${row.Username} "/></td>
		   <td> <c:out value = "${row.name} "/></td>
		   <td> <c:out value = "${row.idGest} "/></td>
		   <td> <c:out value = "${row.idRes} "/></td>
		   <td class="text-danger"> <c:out value = "${row.Days} "/></td>
		   <td class="text-success"> <c:out value = "${row.price} $"/></td>
		   <td class="text-warning"> <c:out value = "${row.Total} $"/></td> 
	       </tr>
	    </c:forEach>
	</table>
    </section>
</div>
<%@ include file="footer.jsp" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>	
<script>
   $.getJSON("https://api.ipify.org?format=json", function (data) {
      $("#gfg").html(data.ip);
   });
</script>

<h3 class="text-info text-center">Public IP Address of current user is:</h3>
<p class="text-success fw-bold border-success text-center" id="gfg"></p>


