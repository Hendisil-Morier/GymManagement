package service;

import java.util.List;
import model.Supplier;

public interface ISupplierService {
    List<Supplier> getAllSuppliers();
    Supplier getSupplierById(int supplierId);
    boolean addSupplier(Supplier supplier);
    boolean updateSupplier(Supplier supplier);
    boolean deleteSupplier(int supplierId);
    List<Supplier> searchSuppliers(String keyword);
    List<Supplier> getSuppliersByType(String type);
}
