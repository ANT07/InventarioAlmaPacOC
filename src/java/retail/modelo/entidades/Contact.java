package retail.modelo.entidades;
// Generated 02-18-2019 03:12:08 PM by Hibernate Tools 4.3.1

import java.util.HashSet;
import java.util.Set;




/**
 * Contact generated by hbm2java
 */
public class Contact  implements java.io.Serializable {


     private int contactid;
     private int providerid;
     private String contactname;
     private int contactstate;
     private String phone;
     private Set providers = new HashSet(0);

    public Contact() {
    }

	
    public Contact(int contactid, int providerid, int contactstate) {
        this.contactid = contactid;
        this.providerid = providerid;
        this.contactstate = contactstate;
    }
    public Contact(int contactid, int providerid, String contactname, int contactstate, String phone) {
       this.contactid = contactid;
       this.providerid = providerid;
       this.contactname = contactname;
       this.contactstate = contactstate;
       this.phone = phone;
    }
   
    public int getContactid() {
        return this.contactid;
    }
    
    public void setContactid(int contactid) {
        this.contactid = contactid;
    }
    public int getProviderid() {
        return this.providerid;
    }
    
    public void setProviderid(int providerid) {
        this.providerid = providerid;
    }
    public String getContactname() {
        return this.contactname;
    }
    
    public void setContactname(String contactname) {
        this.contactname = contactname;
    }
    public int getContactstate() {
        return this.contactstate;
    }
    
    public void setContactstate(int contactstate) {
        this.contactstate = contactstate;
    }
    public String getPhone() {
        return this.phone;
    }
    
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Set getProviders() {
        return providers;
    }

    public void setProviders(Set providers) {
        this.providers = providers;
    }




}

