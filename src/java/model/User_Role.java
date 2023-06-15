package model;

public class User_Role
{

    private Users id;
    private Role idRole;

    public Users getId ()
    {
        return id;
    }

    public void setId (Users id)
    {
        this.id = id;
    }

    public Role getIdRole ()
    {
        return idRole;
    }

    public void setIdRole (Role idRole)
    {
        this.idRole = idRole;
    }

    public User_Role ()
    {
    }

    public User_Role (Users id, Role idRole)
    {
        this.id = id;
        this.idRole = idRole;
    }

}
