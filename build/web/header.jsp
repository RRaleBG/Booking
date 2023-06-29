<!DOCTYPE>
<%@page import="baza.Konekcija"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
   Users user = (Users) session.getAttribute ("user");
   UsersDAL baza = new UsersDAL (Konekcija.createConnection ());
%>
<html lang="en" data-bs-theme="dark">
    <head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.3.1/css/bootstrap.min.css">   
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
	<link href="https://fonts.googleapis.com/css?family=Poppins:400" rel="stylesheet">
	<link rel="stylesheet" href="style.css" type="text/css"/>      
	<title>Booking</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
    </head>  
    <body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-glass rounded-0 sticky-top">
	    <div class="container-fluid w-75">
		<%
                   out.print ("<a class=\"navbar-brand\" href=\"" + request.getContextPath () + "/index.jsp\">Booking</a>");
		%>
		<button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
		    <span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">		    
		    <div class="navbar-nav">                  
			<%
                           out.print ("<a class=\"nav-item nav-link\" href=\"" + request.getContextPath () + "/about.jsp\">O projektu</a>");
                           // out.print ("<a class=\"nav-item nav-link\" href=\"" + request.getContextPath () + "/contact.jsp\">Contact</a>");

                           if (baza.validate (user))
                           {
                              if (baza.isInRole (user.getUsername ()) == "admin")
                              {
                                 out.print ("<a class=\"nav-item nav-link\" href=\"" + request.getContextPath () + "/adminPages/adminPage.jsp\">Admin panel</a>");
                              }
                              if (baza.isInRole (user.getUsername ()) == "menager")
                              {
			%>
			<ul class="nav nav-pills">                
			    <li class="nav-item dropdown">
				<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#" role="button" aria-expanded="false">Menager panel</a>
				<ul class="dropdown-menu border-0 bg-transparent">
				    <%
                                             out.print ("<li><a class=\"dropdown-item text-center p-2 text-light bg-dark shadow\" href=\"" + request.getContextPath () + "/managerPages/managerPage.jsp\">Manager page</a></li>");
                                             out.print ("<li><a class=\"dropdown-item text-center p-2 text-light bg-dark\" href=\"" + request.getContextPath () + "/managerPages/addRooms.jsp\">New room</a></li>");
                                             out.print ("<li><a class=\"dropdown-item text-center p-2 text-light bg-dark\" href=\"" + request.getContextPath () + "/managerPages/addHotel.jsp\">New hotel</a></li>");
                                          }
                                       }
				    %>    
				</ul>
			    </li>
			</ul>
		    </div>    
		    <div class="navbar-nav">      
			<%
                           if (user == null)
                           {
                              out.print ("<a class=\"nav-item nav-link\" href=\"login.jsp\">Login</a>");
                              out.print ("<a class=\"nav-item nav-link\" href=\"register.jsp\">Register</a>");
                           }
                           else
                           {
                              if ((baza.isInRole (user.getUsername ()) != "admin") && (baza.isInRole (user.getUsername ()) != "menager") && (baza.isInRole (user.getUsername ()) == "user"))
                              {
                                 out.print ("<a href=\"" + request.getContextPath () + "/userPages/userPage.jsp\" class=\"nav-item nav-link\">" + user.getUsername () + "</a>");
                              }

                              out.print ("<a class=\"nav-item nav-link\" href=\"" + request.getContextPath () + "/Logout\">Logout</a>");
                           }
			%>
		    </div>       
		</div>                       
	    </div>
	</nav>