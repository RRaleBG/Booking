package baza;

import java.sql.*;

public class Konekcija
{

    public static Connection createConnection()
    {
        Connection cnn = null;

        String baza = "jdbc:mysql://localhost:3306/booking";
        String user = "root";
        String pass = "";

        try
        {
            try
            {
                Class.forName ("com.mysql.cj.jdbc.Driver");
            }
            catch (ClassNotFoundException ex)
            {
                ex.printStackTrace ();
            }

            cnn = DriverManager.getConnection (baza, user, pass);
        }
        catch (Exception e)
        {
            e.printStackTrace ();
        }

        return cnn;
    }

}
