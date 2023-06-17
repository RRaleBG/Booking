
<!DOCTYPE>
<%@page import="baza.Konekcija"%>
<%@page import="java.util.List"%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="container my-5" align="center">
    <div class="row mt-5">
	<div class="col-md-6">
	    <h3 class="text-danger">
		Dovrsiti:
	    </h3>
	    <br>
	    <div class="text-danger text-left">
		<p>2. Osposobiti reset password-a  </p>
		<p>3. Prilikom registracije, hash-ovati password  </p>
		<p>4. Delete sobe ? </p>
		<p>5. Registracija upozorenje i obavestenje o statusu kreiranja naloga  </p> </p>
		<p>6. Edit Role, spojiti id i idRole </p>
	    </div>
	</div>
	<div class="col-md-6">
	    <h3 class="text-success">
		Uradjeno:
	    </h3><br>
	    <div class="text-success text-left">
		<p>1. Brisanje korisnika</p>
		<p>2. Edit room  </p>
		<p>3. Insert novog hotela sa slikom  </p>
		<p>4. Login failed info  </p>
		<p>5. Brisanje hotela sa porukom uspesnosti </p>
		<p>6. Dodavanje sobe u hotel sa porukom uspesnosti  </p>
	    </div>
	</div>
    </div>
</div>
<%@ include file="footer.jsp" %>

