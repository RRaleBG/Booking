<!DOCTYPE>
<title>O projektu</title>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<div class="container bg-glass mt-3" align="center">
    <div class="row p-3">
	<div class="col-md-12">
	    <h6 class="text-success">INTERNET PROGRAMERSKI ALATI</h6>
	    <h4 class="text-success mt-2">Projektovanje i razvoj Java Web aplikacije za rezervaciju hotelskih soba </h4>
	    <hr class=" border-1 border-bottom border-info">
	    <div class="text-info text-left p-2">
		<p>
		    Projekat se sastoji u izradi Web aplikacije pojednostavljenog modela namenjenog za vođenje poslovanja jednog lanca hotela, korišćenjem Java EE tehnologija:
		</p>
		<p>
		    <strong>
			• Java Servlet
		    </strong>
		</p>
		<p>
		    <strong>
			• JavaServer Pages
		    </strong>
		</p>
		<p>
		    <strong>
			• JavaBeans
		    </strong>
		</p>
		<p>
		    Korisnici aplikacije su: <strong>Klijenti</strong>, <strong>Administrator</strong> i <strong>Menadžer</strong> hotela.
		</p>
		<p>
		    Klijentski deo aplikacije obezbeđuje klijentima mogućnost registracije, logovanja, 
		    pregled svih hotela i pregled hotelskih soba izborom nekog od hotela. 
		</p>
		<p>
		    Rezervacija hotelske sobe u nekom od izabranog hotela i željene sobe, takođe i otkazivanje rezervacija. 
		    Pri svakoj rezervaciji klijenti dobijaju određen broj poena koje kasnije mogu iskoristiti za nove rezervacije.
		</p>
		<p>
		    Menadžeri imaju mogućnost kreiranja, izmene i brisanja hotela, hotelskih soba, tipova hotelskih soba. 
		    Menadžeri hotela su takođe korisnici aplikacije pa samim tim imaju slične mogućnosti u samoj aplikaciji. 
		    Te mogućnosti su logovanje, kreiranje novih hotela, izmenu hotela, kreiranje hotelskih soba, 
		    izmenu soba i njenih dozvoljenih radnji skladno politici hotela.
		<p>
		    Administratori su radnici sistema aplikacije, mogućnosti slične kao i kod klijenta i menadžera pa mu je time omućeno 
		    da se uloguje, pregleda sve hotele, manipulacija nad pravima (rolama) svih korisnika aplikacije, 
		    može da obriše korisnika (kllijenta i menadžera) i/ili da izvrši određenu izmenu nad njima. 
		    Te izmene bi bile izmena prava korisnika i dodela prava pristupa nad aplikacijom, izmena njegovih informacija, 
		    ali ne i email i password jer bi time doveo korisnika u neobičan položaj odnosno nepristupačnost aplikaciji, 
		    ali može da ga obriše jer je korisnik odstupio od pravila ponašanja na aplikaciji. 
		</p>
		<hr class="border-info">
		<div style="float:right;" class="mr-5"><p><strong>Student: Rajčić Radoš 63-20</strong></p><p><strong>Beograd 27.06.2023</strong></p></div>
	    </div>
	</div>
    </div>
</div>
<%@ include file="footer.jsp" %>