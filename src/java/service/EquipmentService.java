package service;

import dao.EquipmentDAO;
import java.util.List;
import model.Equipment;

public class EquipmentService implements IEquipmentService {

    private final EquipmentDAO equipmentDAO = new EquipmentDAO();

    @Override
    public List<Equipment> getAllEquipment() {
        try { return equipmentDAO.findAll(); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }

    @Override
    public Equipment getEquipmentById(int equipmentId) {
        try { return equipmentDAO.findById(equipmentId); }
        catch (Exception e) { e.printStackTrace(); return null; }
    }

    @Override
    public boolean addEquipment(Equipment equipment) {
        try { return equipmentDAO.insert(equipment); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public boolean updateEquipment(Equipment equipment) {
        try { return equipmentDAO.update(equipment); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public boolean deleteEquipment(int equipmentId) {
        try { return equipmentDAO.delete(equipmentId); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public boolean reportMaintenance(int equipmentId) {
        try { return equipmentDAO.updateStatus(equipmentId, "Maintenance"); }
        catch (Exception e) { e.printStackTrace(); return false; }
    }

    @Override
    public List<Equipment> getMaintenanceEquipment() {
        try { return equipmentDAO.findByStatus("Maintenance"); }
        catch (Exception e) { e.printStackTrace(); return List.of(); }
    }
}
