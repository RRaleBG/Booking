package model;

import baza.Konekcija;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RoleDAL {

    Connection cnn;

    public RoleDAL(Connection cnn) 
    {
        this.cnn = cnn;
    }

    public RoleDAL() {
    }

    public boolean updateUserRole(int id, int idRole) {

        User_Role ur = new User_Role(id, idRole);  
        
        boolean updateovan = false;

        try 
        {
            Connection cnn = Konekcija.createConnection();

            String updateUser = "UPDATE user_role SET idRole=? WHERE user_role.id=?";
            
            PreparedStatement stmt = cnn.prepareStatement(updateUser);
            
            stmt.setInt(1, ur.getIdRole());
            stmt.setInt(2, ur.getId());
            
           stmt.executeUpdate();
           
           return updateovan = true;   
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }

        return updateovan;
    }

    public List<Role> getAllRoles() 
    {
        List<Role> role = new ArrayList<Role>();

        try {
            Connection cnn = Konekcija.createConnection();

            PreparedStatement stmt = cnn.prepareCall("SELECT * FROM role");

            ResultSet rez = stmt.executeQuery();

            while (rez.next()) 
            {
                int idRole = rez.getInt("idRole");
                String roleName = rez.getString("roleName");

                Role r = new Role(idRole, roleName);

                role.add(r);
            }
        } 
        catch (SQLException e) 
        {
            e.printStackTrace();
        }
        return role;
    }
}
