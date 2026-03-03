package service;

import dao.SupplierDAO;
import java.util.List;
import model.Supplier;

public class SupplierService implements ISupplierService {

    private final SupplierDAO supplierDAO = new SupplierDAO();

    @Override
    public List<Supplier> getAllSuppliers() {
        try { return supplierDAO.findAll(); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public Supplier getSupplierById(int supplierId) {
        try { return supplierDAO.findById(supplierId); }
        catch (Exception e) { e.printStackTrace(); return null; }
    }

    @Override
    public boolean addSupplier(Supplier supplier) {
        try { return supplierDAO.insert(supplier); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public boolean updateSupplier(Supplier supplier) {
        try { return supplierDAO.update(supplier); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public boolean deleteSupplier(int supplierId) {
        try { return supplierDAO.delete(supplierId); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public List<Supplier> searchSuppliers(String keyword) {
        try { return supplierDAO.search(keyword); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public List<Supplier> getSuppliersByType(String type) {
        try { return supplierDAO.findBySupplyType(type); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }
}
