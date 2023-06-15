package model;

public class Hotel
{

   private int idHotel;
   private String name;
   private String city;
   private int roomCount;
   private int parking;
   private int stars;
   private String imagePath;
   Rooms room;

   public Hotel()
   {
   }

   public Hotel(String name, String city, int roomCount, int parking, int stars, String imagePath, Rooms room)
   {
      this.name = name;
      this.city = city;
      this.roomCount = roomCount;
      this.parking = parking;
      this.stars = stars;
      this.imagePath = imagePath;
      this.room = room;
   }

   public Hotel(int idHotel, String name, String city, int roomCount, int parking, int stars, String imagePath)
   {
      this.idHotel = idHotel;
      this.name = name;
      this.city = city;
      this.roomCount = roomCount;
      this.parking = parking;
      this.stars = stars;
      this.imagePath = imagePath;
   }

   public Rooms getRoom()
   {
      return room;
   }

   public void setRoom(Rooms room)
   {
      this.room = room;
   }

   public int getIdHotel()
   {
      return idHotel;
   }

   public String getName()
   {
      return name;
   }

   public void setName(String name)
   {
      this.name = name;
   }

   public String getCity()
   {
      return city;
   }

   public void setCity(String city)
   {
      this.city = city;
   }

   public int getRoomCount()
   {
      return roomCount;
   }

   public void setRoomCount(int roomCount)
   {
      this.roomCount = roomCount;
   }

   public int getParking()
   {
      return parking;
   }

   public void setParking(int parking)
   {
      this.parking = parking;
   }

   public int getStars()
   {
      return stars;
   }

   public void setStars(int stars)
   {
      this.stars = stars;
   }

   public String getImagePath()
   {
      return imagePath;
   }

   public void setImagePath(String imagePath)
   {
      this.imagePath = imagePath;
   }

}
