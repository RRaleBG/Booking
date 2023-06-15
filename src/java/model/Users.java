package model;

public class Users
{
    private int id;
    private String firstname;
    private String lastname;
    private String username;
    private String password;
    private String email;
    private int points;

    public int getId ()
    {
        return id;
    }

    public void setId(int id)
    {
        this.id = id;
    }

    public void setFirstname(String firstname)
    {
        this.firstname = firstname;
    }
    public String getFirstname ()
    {
        return firstname;
    }
    public String getLastname ()
    {
        return lastname;
    }
    public void setLastname (String lastname)
    {
        this.lastname = lastname;
    }
    public String getUsername ()
    {
        return username;
    }
    public void setUsername (String username)
    {
        this.username = username;
    }
    public String getPassword ()
    {
        return password;
    }
    public void setPassword (String password)
    {
        this.password = password;
    }
    public String getEmail ()
    {
        return email;
    }
    public void setEmail (String email)
    {
        this.email = email;
    }

    public int getPoints ()
    {
        return points;
    }
    public void setPoints (int points)
    {
        this.points = points;
    }

    public Users ()
    {
    }

    public Users (int id, String firstname, String lastname, String username, String password, String email, int points)
    {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.points = points;
    }

    public Users (int id, String firstname, String lastname, String username, String email)
    {
        this.id = id;
        this.firstname = firstname;
        this.lastname = lastname;
        this.username = username;
        this.email = email;
    }
}
