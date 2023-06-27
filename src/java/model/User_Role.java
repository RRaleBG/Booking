package model;

public class User_Role
{
    private int id;
    private int idRole;

    public int getId ()
    {
        return id;
    }

    public void setId (int id)
    {
        this.id = id;
    }

    public int getIdRole ()
    {
        return idRole;
    }

    public void setIdRole (int idRole)
    {
        this.idRole = idRole;
    }

    public User_Role ()
    {
    }

  
    public User_Role (int id, int idRole)
    {
        this.id = id;
        this.idRole = idRole;
    }
}
