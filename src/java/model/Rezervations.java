package model;

import java.util.Date;

public class Rezervations {

   private int idRes;
   private int idRoom;
   private Date dateCheckIn;
   private Date dateCheckOut;
   private int price;
   private int canceledRes;
   private int idHotel;
   private int idGest;
   private String hotelName;

   public Rezervations(int idRes, Date dateCheckIn, Date dateCheckOut, int price, int canceledRes, int idHotel, int idGest, String hotelName)
   {
      this.idRes = idRes;
      this.idRoom = idRoom;
      this.dateCheckIn = dateCheckIn;
      this.dateCheckOut = dateCheckOut;
      this.price = price;
      this.canceledRes = canceledRes;
      this.idHotel = idHotel;
      this.idGest = idGest;
      this.hotelName = hotelName;
   }

   public Rezervations(int idRes, Date dateCheckIn, Date dateCheckOut, int price, int canceledRes, int idHotel, int idGest)
   {
      this.idRes = idRes;
      this.dateCheckIn = dateCheckIn;
      this.dateCheckOut = dateCheckOut;
      this.price = price;
      this.canceledRes = canceledRes;
      this.idHotel = idHotel;
      this.idGest = idGest;
   }

   public String getHotelName() {
      return hotelName;
   }

   public void setHotel(String hotelName) {
      this.hotelName = hotelName;
   }

   public int getIdRoom() {
      return idRoom;
   }

   public void setIdRoom(int idRoom) {
      this.idRoom = idRoom;
   }

   public int getIdRes() {
      return idRes;
   }

   public Date getDateCheckIn() {
      return dateCheckIn;
   }

   public void setDateCheckIn(Date dateCheckIn) {
      this.dateCheckIn = dateCheckIn;
   }

   public Date getDateCheckOut() {
      return dateCheckOut;
   }

   public void setDateCheckOut(Date dateCheckOut) {
      this.dateCheckOut = dateCheckOut;
   }

   public int getPrice() {
      return price;
   }

   public void setPrice(int price) {
      this.price = price;
   }

   public int getCanceledRes()
   {
      return canceledRes;
   }

   public void setCanceledRes(int canceledRes)
   {
      this.canceledRes = canceledRes;
   }

   public int getIdHotel() {
      return idHotel;
   }

   public void setIdHotel(int idHotel) {
      this.idHotel = idHotel;
   }

   public int getIdGest() {
      return idGest;
   }

   public void setIdGest(int idGest) {
      this.idGest = idGest;
   }

   public Rezervations()
   {
   }
}
