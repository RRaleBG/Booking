package model;

import baza.Konekcija;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoomsDAL
{

   Connection cnn;

   public RoomsDAL()
   {

   }

   public RoomsDAL(Connection cnn)
   {
      this.cnn = cnn;
   }

   public boolean addRoom(Rooms room)
   {
      boolean obavestenje = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String insert = "INSERT INTO rooms(idHotel, number, bed, balkon, smoking, pets, tv, imgPath) VALUES(?,?,?,?,?,?,?,?)";

         PreparedStatement stmt = this.cnn.prepareCall (insert);

         stmt.setInt (1, (room.getIdHotel ()));
         stmt.setInt (2, (room.getNumber ()));
         stmt.setInt (3, room.getBed ());
         stmt.setInt (4, room.getBalkon ());
         stmt.setInt (5, room.getSmoking ());
         stmt.setInt (6, room.getPets ());
         stmt.setInt (7, room.getTv ());
         stmt.setString (8, room.getImgPath ());

         stmt.execute ();

         obavestenje = true;
      }
      catch (SQLException e)
      {
         e.getMessage();
      }

      return obavestenje;
   }

   public List<Rooms> getAllRooms()
   {
      List<Rooms> rooms = new ArrayList<> ();

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT * FROM rooms");

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int idRoom = rez.getInt ("idRoom");
            int idHotel = rez.getInt ("idHotel");
            int number = rez.getInt ("number");
            int bed = rez.getInt ("bed");
            byte balkon = Byte.parseByte (rez.getString ("balkon"));
            byte smoking = Byte.parseByte (rez.getString ("smoking"));
            byte pets = Byte.parseByte (rez.getString ("pets"));
            byte tv = Byte.parseByte (rez.getString ("tv"));
            String imgPath = rez.getString ("imgPath");

            Rooms room = new Rooms (idRoom, idHotel, number, bed, balkon, smoking, pets, tv, imgPath);

            rooms.add (room);
         }
      }
      catch (NumberFormatException | SQLException e)
      {
         e.printStackTrace ();
      }

      return rooms;
   }

   public void editRoom(Rooms room)
   {
      try
      {
         String update = "UPDATE rooms set number=?, bed=?, balkon=?, smoking=?, pets=?, tv=? ";

         if (!room.getImgPath ().isEmpty ())
         {
            update += ",imgPath=? ";
         }
         update += "WHERE idHotel=? AND idRoom=?";

         PreparedStatement stmt = cnn.prepareStatement (update);

         stmt.setInt (1, (room.getNumber ()));
         stmt.setInt (2, room.getBed ());
         stmt.setInt (3, room.getBalkon ());
         stmt.setInt (4, room.getSmoking ());
         stmt.setInt (5, room.getPets ());
         stmt.setInt (6, room.getTv ());

         if (!room.getImgPath ().isEmpty ())
         {
            stmt.setString (7, room.getImgPath ());
            stmt.setInt (8, room.getIdHotel ());
            stmt.setInt (9, room.getIdRoom ());
         }
         stmt.setInt (7, room.getIdHotel ());
         stmt.setInt (8, room.getIdRoom ());         
         stmt.executeUpdate ();
      }
      catch (SQLException e)
      {
         e.getMessage();
      }
   }

   public Rooms getRoomFromHotel(int idH, int idR)
   {
      Rooms room = null;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String select = "SELECT * FROM `rooms` WHERE idHotel=? AND idRoom=?";

         PreparedStatement stmt = cnn.prepareCall (select);

         stmt.setInt (1, idH);
         stmt.setInt (2, idR);

         ResultSet rez = stmt.executeQuery ();

         if (rez.next ())
         {
            int idRoom = rez.getInt ("idRoom");
            int idHotel = rez.getInt ("idHotel");
            int number = rez.getInt ("number");
            int bed = rez.getInt ("bed");
            byte balkon = Byte.parseByte (rez.getString ("balkon"));
            byte smoking = Byte.parseByte (rez.getString ("smoking"));
            byte pets = Byte.parseByte (rez.getString ("pets"));
            byte tv = Byte.parseByte (rez.getString ("tv"));
            String imgPath = rez.getString ("imgPath");

            room = new Rooms (idRoom, idHotel, number, bed, balkon, smoking, pets, tv, imgPath);
         }
      }
      catch (NumberFormatException | SQLException e)
      {
         e.printStackTrace ();
      }

      return room;
   }

   public void deleteRoom(int id)
   {
      try
      {
         String delete = "DELETE FROM rooms WHERE idRoom=?";
         PreparedStatement stmt = this.cnn.prepareStatement (delete);

         stmt.setInt (1, id);

         stmt.execute ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }
   }

   public List<Rooms> getAllRoomsFromHotel(int id)
   {
      List<Rooms> rooms = new ArrayList<> ();

      try
      {
         String select = "SELECT * FROM rooms WHERE idHotel=?";

         PreparedStatement stmt = cnn.prepareCall (select);

         stmt.setInt (1, id);

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int idRoom = rez.getInt ("idRoom");
            int idHotel = rez.getInt ("idHotel");
            int number = rez.getInt ("number");
            int bed = rez.getInt ("bed");
            byte balkon = rez.getByte ("balkon");
            byte smoking = rez.getByte ("smoking");
            byte pets = rez.getByte ("pets");
            byte tv = rez.getByte ("tv");
            String imgPath = rez.getString ("imgPath");

            Rooms room = new Rooms (idRoom, idHotel, number, bed, balkon, smoking, pets, tv, imgPath);

            rooms.add (room);
         }
      }
      catch (SQLException e)
      {
         e.getMessage();
      }

      return rooms;
   }

}
