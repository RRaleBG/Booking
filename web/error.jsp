<%-- 
    Document   : error
    Created on : May 6, 2023, 6:27:02 PM
    Author     : rale_
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page isErrorPage="true" %> 
<%@ include file="header.jsp" %>
<%@ page isErrorPage="true" %>
<%@ page session="true" %>
<div class="container mb-4 py-3 mt-lg-5">

    <div class="border-1 bg-glass py-lg-5 mt-5 border border-info">

	<h1 class="text-danger text-center">Error Page</h1>


	<%
           String ex = (String) request.getAttribute ("exception");

           if (exception != null)
           {
              out.print ("<h2 class=\"text-danger text-center\">" + exception + "</h2>");
           }
	%>	



	<%
           String poruka = (String) request.getAttribute ("message");
           if (poruka != null)
           {
              out.print ("<h2 class=\"text-danger text-center\">" + poruka + " </h2>");
           }
	%>

	<a class="text-primary text-center" href="index.jsp">
	    <h4>Return to main page  ---></h4>
	</a>

    </div>

</div>
<%@ include file="footer.jsp" %>