package model;

/**
 *
 * @author rale_
 */
public class Role
{
   private int idRole;
    private String roleName;

    /**
     *
     * @return
     */
   public int getIdRole()
    {
        return idRole;
    }

    /**
     *
     * @param idRole
     */
    public void setIdRole(Integer idRole)
    {
        this.idRole = idRole;
    }

    /**
     *
     * @return
     */
    public String getRoleName()
    {
        return roleName;
    }

    /**
     *
     * @param roleName
     */
    public void setRoleName(String roleName)
    {
        this.roleName = roleName;
    }

    /**
     *
     */
    public Role()
    {
    }

    /**
     *
     * @param idRole
     */
    public Role(Integer idRole)
    {
        this.idRole = idRole;
    }

    /**
     *
     * @param idRole
     * @param roleName
     */
    public Role(Integer idRole, String roleName)
    {
        this.idRole = idRole;
        this.roleName = roleName;
    }

}
