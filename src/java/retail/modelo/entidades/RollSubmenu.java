package retail.modelo.entidades;
// Generated 02-18-2019 03:12:08 PM by Hibernate Tools 4.3.1



/**
 * RollSubmenu generated by hbm2java
 */
public class RollSubmenu  implements java.io.Serializable {


     private int rollSubmenuId;
     private Roll roll;
     private SubMenu subMenu;
     private int estado;

    public RollSubmenu() {
    }

	
    public RollSubmenu(int estado) {
        this.estado = estado;
    }
    public RollSubmenu(Roll roll, SubMenu subMenu, int estado) {
       this.roll = roll;
       this.subMenu = subMenu;
       this.estado = estado;
    }
   
    public int getRollSubmenuId() {
        return this.rollSubmenuId;
    }
    
    public void setRollSubmenuId(int rollSubmenuId) {
        this.rollSubmenuId = rollSubmenuId;
    }
    public Roll getRoll() {
        return this.roll;
    }
    
    public void setRoll(Roll roll) {
        this.roll = roll;
    }
    public SubMenu getSubMenu() {
        return this.subMenu;
    }
    
    public void setSubMenu(SubMenu subMenu) {
        this.subMenu = subMenu;
    }
    public int getEstado() {
        return this.estado;
    }
    
    public void setEstado(int estado) {
        this.estado = estado;
    }




}


