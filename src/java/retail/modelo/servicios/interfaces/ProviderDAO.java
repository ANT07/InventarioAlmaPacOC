/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package retail.modelo.servicios.interfaces;

import java.util.List;
import retail.modelo.entidades.Provider;

/**
 *
 * @author anthony
 */
public interface ProviderDAO {
    public void insertProvider(Provider provider) throws Exception;
    public void deleteProvider(Provider provider) throws Exception;
    public void updateProvider(Provider provider) throws Exception;
    public Provider getProviderById(int providerId) throws Exception;
    public List<Provider> getProviders() throws Exception;
}
