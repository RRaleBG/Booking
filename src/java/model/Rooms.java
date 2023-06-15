package model;

public class Rooms
{

   Hotel hotel;
   private int idRoom;
   private int idHotel;
   private int number;
   private int bed;
   private byte balkon;
   private byte smoking;
   private byte pets;
   private byte tv;
   private String imgPath;

   public Rooms()
   {
   }

   public Rooms(int idHotel, int number, int bed, byte balkon, byte smoking, byte pets, byte tv, String imgPath)
   {
      this.idHotel = idHotel;
      this.number = number;
      this.bed = bed;
      this.balkon = balkon;
      this.smoking = smoking;
      this.pets = pets;
      this.tv = tv;
      this.imgPath = imgPath;
   }

   public Rooms(int idRoom, int idHotel, int number, int bed, byte balkon, byte smoking, byte pets, byte tv, String imgPath)
   {
      this.idRoom = idRoom;
      this.idHotel = idHotel;
      this.number = number;
      this.bed = bed;
      this.balkon = balkon;
      this.smoking = smoking;
      this.pets = pets;
      this.tv = tv;
      this.imgPath = imgPath;
   }

   public Hotel getHotel()
   {
      return hotel;
   }

   public void setHotel(Hotel hotel)
   {
      this.hotel = hotel;
   }

   public int getIdRoom()
   {
      return idRoom;
   }

   public void setIdRoom(int idRoom)
   {
      this.idRoom = idRoom;
   }

   public int getIdHotel()
   {
      return idHotel;
   }

   public void setIdHotel(int idHotel)
   {
      this.idHotel = idHotel;
   }

   public int getNumber()
   {
      return number;
   }

   public void setNumber(int number)
   {
      this.number = number;
   }

   public int getBed()
   {
      return bed;
   }

   public void setBed(int bed)
   {
      this.bed = bed;
   }

   public byte getBalkon()
   {
      return balkon;
   }

   public void setBalkon(byte balkon)
   {
      this.balkon = balkon;
   }

   public byte getSmoking()
   {
      return smoking;
   }

   public void setSmoking(byte smoking)
   {
      this.smoking = smoking;
   }

   public byte getPets()
   {
      return pets;
   }

   public void setPets(byte pets)
   {
      this.pets = pets;
   }

   public byte getTv()
   {
      return tv;
   }

   public void setTv(byte tv)
   {
      this.tv = tv;
   }

   public String getImgPath()
   {
      return imgPath;
   }

   public void setImgPath(String imgPath)
   {
      this.imgPath = imgPath;
   }

}
