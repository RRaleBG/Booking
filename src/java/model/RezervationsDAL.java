package model;

import baza.Konekcija;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class RezervationsDAL
{

   Connection cnn;

   public RezervationsDAL()
   {

   }

   public RezervationsDAL(Connection cnn)
   {
      this.cnn = cnn;
   }

   public List<Rezervations> getAllRezervations()
   {
      List<Rezervations> rezervation = new ArrayList<Rezervations> ();

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT `hotel`.*, `rooms`.*, `reservations`.* FROM `hotel` LEFT JOIN `rooms` ON `rooms`.`idHotel` = `hotel`.`idHotel` LEFT JOIN `reservations` ON `reservations`.`idHotel` = `hotel`.`idHotel`;");

         ResultSet rez = stmt.executeQuery (); // to radi sve

         while (rez.next ())
         {
            int idRes = rez.getInt ("idRes");
            Date dateCheckIn = rez.getDate ("dateCheckIn");
            Date dateCheckOut = rez.getDate ("dateCheckOut");
            int price = rez.getInt ("price");
            int canceledRes = rez.getInt ("canceledRes");
            int idHotel = rez.getInt ("idHotel");
            int idGest = rez.getInt ("idGest");

            Rezervations r = new Rezervations (idRes, dateCheckIn, dateCheckOut, price, canceledRes, idHotel, idGest);

            rezervation.add (r);
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return rezervation;
   }

   public List<Rezervations> getAllRezervationsFromUserId(int id)
   {
      List<Rezervations> rezervation = new ArrayList<Rezervations> ();

      try
      {
         PreparedStatement stmt = this.cnn.prepareCall ("SELECT `reservations`.*, `users`.*, `hotel`.* FROM `reservations` LEFT JOIN `users` ON `reservations`.`idGest` = `users`.`id` LEFT JOIN `hotel` ON `reservations`.`idHotel` = `hotel`.`idHotel` WHERE users.id=?");

         stmt.setInt (1, id);

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int idRes = rez.getInt ("idRes");
            Date dateCheckIn = rez.getDate ("dateCheckIn");
            Date dateCheckOut = rez.getDate ("dateCheckOut");
            int price = rez.getInt ("price");
            int canceledRes = rez.getInt ("canceledRes");
            int idHotel = rez.getInt ("idHotel");
            int idGest = rez.getInt ("idGest");
            String hotelName = rez.getString ("name");

            Rezervations rr = new Rezervations (idRes, dateCheckIn, dateCheckOut, price, canceledRes, idHotel, idGest, hotelName);

            rezervation.add (rr);
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return rezervation;
   }

   public boolean addReservation(Rezervations reservation)
   {
      boolean obavestenje = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String reserveRoom = "INSERT INTO reservations(idGest, idHotel, dateCheckIn, dateCheckOut, price, canceledRes) VALUES(?,?,?,?,?,?)";

         PreparedStatement stmt = cnn.prepareStatement (reserveRoom);

         stmt.setInt (1, reservation.getIdGest ());
         stmt.setInt (2, reservation.getIdHotel ());
         stmt.setDate (3, (java.sql.Date) reservation.getDateCheckIn ());
         stmt.setDate (4, (java.sql.Date) reservation.getDateCheckOut ());
         stmt.setInt (5, reservation.getPrice ());
         stmt.setInt (6, reservation.getCanceledRes ());

         stmt.execute ();

         obavestenje = true;

         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return obavestenje;
   }

   public boolean cancelReservation(Rezervations reservation)
   {
      boolean obavestenje = false;

      try
      {
         String update = "UPDATE reservations set canceledRes=1 WHERE idRoom=?";

         PreparedStatement stmt = this.cnn.prepareStatement (update);

         stmt.setInt (1, reservation.getIdRes ());

         stmt.executeUpdate ();

         obavestenje = true;

      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return obavestenje;
   }

   public boolean cancelReservation(int id)
   {

      boolean obavestenje = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String update = "UPDATE reservations set canceledRes=1 WHERE idRes=?";

         PreparedStatement stmt = cnn.prepareStatement (update);

         stmt.setInt (1, id);

         stmt.executeUpdate ();

         obavestenje = true;
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return obavestenje;
   }

}

 


// SELECT `reservations`.*, `users`.*, `hotel`.* FROM `reservations` LEFT JOIN `users` ON `reservations`.`idGest` = `users`.`id` LEFT JOIN `hotel` ON `reservations`.`idHotel` = `hotel`.`idHotel` WHERE users.id = 3;
