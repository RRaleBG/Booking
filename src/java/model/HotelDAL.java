package model;

import baza.Konekcija;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class HotelDAL
{

   Connection cnn;

   public HotelDAL()
   {
   }

   public HotelDAL(Connection cnn)
   {
      this.cnn = cnn;
   }

   public List<Rooms> getRoomsFromHotel(int id)
   {
      //String getRoom = "SELECT `hotel`.*, `reservations`.*, `rooms`.* FROM `hotel` LEFT JOIN `reservations` ON `reservations`.`idHotel` = `hotel`.`idHotel` LEFT JOIN `rooms` ON `rooms`.`idHotel` = `hotel`.`idHotel` WHERE `hotel`.`idHotel`=?";

      String roomFromHotel = "SELECT `hotel`.*, `rooms`.* FROM `hotel` JOIN `rooms` ON `rooms`.`idHotel` = `hotel`.`idHotel` WHERE `hotel`.`idHotel`=?";

      String getRoom = "SELECT * FROM rooms WHERE idHotel =?";

      List<Rooms> rooms = new ArrayList<> ();

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall (roomFromHotel);

         stmt.setInt (1, id);

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            Rooms room = new Rooms ();

            room.setIdRoom (rez.getInt ("idRoom"));
            room.setIdHotel (rez.getInt ("idHotel"));
            room.setBalkon (rez.getByte ("balkon"));
            room.setBed (rez.getInt ("bed"));
            room.setNumber (rez.getInt ("number"));
            room.setPets (rez.getByte ("pets"));
            room.setSmoking (rez.getByte ("smoking"));
            room.setTv (rez.getByte ("tv"));
            room.setImgPath (rez.getString ("imgPath"));

            rooms.add (room);
         }
         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return rooms;
   }

   public boolean addHotel(Hotel hotel)
   {
      boolean obavestenje = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String insert = "INSERT INTO hotel(name, city, roomCount, parking, stars, imagePath) VALUES(?,?,?,?,?,?)";

         PreparedStatement stmt = cnn.prepareStatement (insert);

         stmt.setString (1, hotel.getName ());
         stmt.setString (2, hotel.getCity ());
         stmt.setString (3, Integer.toString (hotel.getRoomCount ()));
         stmt.setString (4, Integer.toString (hotel.getParking ()));
         stmt.setString (5, Integer.toString (hotel.getStars ()));
         stmt.setString (6, hotel.getImagePath ());

         if (stmt.execute () == true)
         {
            obavestenje = true;
         }

         stmt.close ();
         cnn.close ();

      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return obavestenje;
   }

   public List<Hotel> getAllHotels()
   {
      List<Hotel> hoteli = new ArrayList<> ();

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT * FROM hotel ORDER BY stars DESC");

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int idHotel = rez.getInt ("idHotel");
            String name = rez.getString ("name");
            String city = rez.getString ("city");
            int roomCount = Integer.parseInt (rez.getString ("roomCount"));
            int parking = Integer.parseInt (rez.getString ("parking"));
            int stars = Integer.parseInt (rez.getString ("stars"));
            String imagePath = rez.getString ("imagePath");

            Hotel h = new Hotel (idHotel, name, city, roomCount, parking, stars, imagePath);

            hoteli.add (h);
         }
      }
      catch (NumberFormatException | SQLException e)
      {
         e.printStackTrace ();
      }

      return hoteli;
   }

   public void editHotel(Hotel hotel)
   {
      try
      {
         Connection cnn = Konekcija.createConnection ();

         String update = "UPDATE hotel set name=?, city=?, roomCount=?, parking=?, stars=?";

         if (!hotel.getImagePath ().isEmpty ())
         {
            update += ",imagePath=? ";
         }
         update += "WHERE idHotel=?";

         PreparedStatement stmt = cnn.prepareStatement (update);

         stmt.setString (1, hotel.getName ());
         stmt.setString (2, hotel.getCity ());
         stmt.setString (3, Integer.toString (hotel.getRoomCount ()));
         stmt.setString (4, Integer.toString (hotel.getParking ()));
         stmt.setString (5, Integer.toString (hotel.getStars ()));

         if (!hotel.getImagePath ().isEmpty ())
         {
            stmt.setString (6, hotel.getImagePath ());
            stmt.setInt (7, hotel.getIdHotel ());
         }
         stmt.setInt (6, hotel.getIdHotel ());

         stmt.executeUpdate ();

         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }
   }

   public Hotel getByHotelId(int id)
   {
      Hotel hotel = null;

      try
      {
         String select = "SELECT * FROM hotel WHERE idHotel=?";

         PreparedStatement stmt = cnn.prepareStatement (select);

         stmt.setInt (1, id);

         ResultSet rez = stmt.executeQuery ();

         if (rez.next ())
         {
            int idHotel = Integer.parseInt (rez.getString ("idHotel"));
            String name = rez.getString ("name");
            String city = rez.getString ("city");
            int roomCount = Integer.parseInt (rez.getString ("roomCount"));
            int parking = Integer.parseInt (rez.getString ("parking"));
            int stars = Integer.parseInt (rez.getString ("stars"));
            String imagePath = rez.getString ("imagePath");

            hotel = new Hotel (idHotel, name, city, roomCount, parking, stars, imagePath);
         }

         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return hotel;
   }

   public boolean deleteHotel(int id)
   {

      try
      {
         String delete = "DELETE FROM hotel WHERE idHotel=?";

         PreparedStatement stmt = this.cnn.prepareStatement (delete);

         stmt.setInt (1, id);

         stmt.execute ();

         stmt.close ();

         return true;

      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }
      return false;
   }

}
