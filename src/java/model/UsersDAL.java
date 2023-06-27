package model;

import java.sql.*;
import baza.Konekcija;
import java.util.ArrayList;
import java.util.List;

public class UsersDAL
{

   Connection cnn;

   public UsersDAL(Connection cnn)
   {
      this.cnn = cnn;
   }

   public UsersDAL()
   {
   }

   public boolean registerUser(Users u)
   {
      boolean register = false;

      if (u != null)
      {
         String firstname = u.getFirstname ();
         String lastname = u.getLastname ();
         String username = u.getUsername ();
         String password = u.getPassword ();
         String email = u.getEmail ();

         try
         {
            Connection cnn = Konekcija.createConnection ();

            String query = "INSERT INTO users(firstname, lastname, username, password, email) VALUES (?,?,?,?,?)";

            PreparedStatement stmt = cnn.prepareStatement (query);

            stmt.setString (1, firstname);
            stmt.setString (2, lastname);
            stmt.setString (3, username);
            stmt.setString (4, password);
            stmt.setString (5, email);

            int executeUpdate = stmt.executeUpdate ();

            if (executeUpdate != 0)
            {
               register = true;
            }
         }
         catch (SQLException e)
         {
            e.printStackTrace ();
         }
      }

      return register;
   }

   public boolean validate(Users user)
   {
      boolean validated = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String login = "SELECT * FROM users WHERE username=? AND password=?";
         PreparedStatement stmt = cnn.prepareStatement(login);

         if (user != null)
         {
            stmt.setString (1, user.getUsername ());
            stmt.setString (2, user.getPassword ());

            ResultSet rezultat = stmt.executeQuery ();

            if (rezultat.next ())
            {
               int id = rezultat.getInt ("id");
               String username = rezultat.getString ("username");
               String password = rezultat.getString ("password");

               if (username.equals (username) && password.equals (password))
               {
                  validated = true;
               }
            }
         }
         else
         {
            validated = false;
            return validated;
         }

         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return validated;
   }

   public String isInRole(String userName)
   {
      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT role.roleName FROM user_role JOIN role ON user_role.idRole = role.idRole JOIN users ON user_role.id = users.id WHERE users.username=?");
         stmt.setString (1, userName);

         ResultSet rezultat = stmt.executeQuery ();

         if (rezultat.next ())
         {
            userName = rezultat.getString ("roleName");

            if (userName.equals ("user"))
            {
               userName = "user";
            }

            if (userName.equals ("admin"))
            {
               userName = "admin";
            }

            if (userName.equals ("menager"))
            {
               userName = "menager";
            }
         }
         stmt.close ();
         cnn.close ();
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return userName;
   }

   public String updateRole(int id)
   {
      String roleName = "";


      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = this.cnn.prepareCall ("SELECT role.roleName FROM user_role JOIN role ON user_role.idRole = role.idRole JOIN users ON user_role.id = users.id WHERE users.id=?");

         String updateRole = "UPDATE user_role SET idRole=? WHERE user_role.id=? AND user_role.idRole=?";

         stmt.setInt (1, id);


         ResultSet rezultat = stmt.executeQuery ();

         if (rezultat.next ())
         {
            roleName = rezultat.getString ("roleName");

            if (roleName.equals ("user"))
            {
               roleName = "user";
            }

            if (roleName.equals ("admin"))
            {
               roleName = "admin";
            }

            if (roleName.equals ("menager"))
            {
               roleName = "menager";
            }

            stmt.close ();
            cnn.close ();
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return roleName;
   }


   public List<Users> getAllUsers()
   {
      List<Users> useri = new ArrayList<> ();

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT * FROM users");

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int id = rez.getInt ("id");
            String firstname = rez.getString ("firstname");
            String lastname = rez.getString ("lastname");
            String username = rez.getString ("username");
            String password = rez.getString ("password");
            String email = rez.getString ("email");
            int points = rez.getInt ("points");

            Users u = new Users (id, firstname, lastname, username, password, email, points);

            useri.add (u);
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return useri;
   }


   public Users getByUserId(int id)
   {
      Users user = null;

      try
      {
         String select = "SELECT * FROM users WHERE id=?";

         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT * FROM users WHERE id=?");
         stmt.setInt (1, id);

         ResultSet rez = stmt.executeQuery ();

         while (rez.next ())
         {
            int uId = rez.getInt ("id");
            String firstname = rez.getString ("firstname");
            String lastname = rez.getString ("lastname");
            String username = rez.getString ("username");
            String password = rez.getString ("password");
            String email = rez.getString ("email");
            int points = rez.getInt ("points");

            user = new Users (uId, firstname, lastname, username, password, email, points);
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return user;
   }

   public static int getId(String username, String password)
   {

      String login = "SELECT * FROM users where username=? AND password=?";

      Connection cnn = Konekcija.createConnection ();

      try
      {
         PreparedStatement stmt = cnn.prepareCall (login);

         stmt.setString (1, username);
         stmt.setString (2, password);

         ResultSet rez = stmt.executeQuery ();

         if (rez.next ())
         {
            return rez.getInt ("id");
         }
         else
         {
            return 0;
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return 0;
   }

   public boolean editUser(Users user)
   {
      boolean isEdit = false;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         String edit = "UPDATE users SET username=?, firstname=?, lastname=?,email=? WHERE id=?";

         PreparedStatement stmt = cnn.prepareStatement (edit);

         stmt.setString (1, user.getUsername ());
         stmt.setString (2, user.getFirstname ());
         stmt.setString (3, user.getLastname ());
         stmt.setString (4, user.getEmail ());
         stmt.setInt (5, user.getId ());

         if (stmt.executeUpdate () != 0)
         {
            isEdit = true;
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return isEdit;
   }

   public boolean deleteUser(int id)
   {
      boolean isDeleted = false;

      try
      {
         String delete = "DELETE FROM `users` WHERE id=?";

         PreparedStatement stmt = this.cnn.prepareCall (delete);

         stmt.setInt (1, id);

         stmt.executeUpdate ();

         isDeleted = true;

      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }

      return isDeleted;
   }

   public Users getByUserName(String userName)
   {
      Users user = null;

      try
      {
         Connection cnn = Konekcija.createConnection ();

         PreparedStatement stmt = cnn.prepareCall ("SELECT * FROM users WHERE username=?");
         
         stmt.setString (1, userName);

         ResultSet rez = stmt.executeQuery ();

         if (rez.next ())
         {
            int id = rez.getInt ("id");
            String firstname = rez.getString ("firstname");
            String lastname = rez.getString ("lastname");
            String username = rez.getString ("username");
            String password = rez.getString ("password");
            String email = rez.getString ("email");
            int points = rez.getInt ("points");

            user = new Users (id, firstname, lastname, username, password, email, points);
         }
      }
      catch (SQLException e)
      {
         e.printStackTrace ();
      }
      return user;
   }
}
