package service;

import java.util.List;
import model.Equipment;

public interface IEquipmentService {
    List<Equipment> getAllEquipment();
    Equipment getEquipmentById(int equipmentId);
    boolean addEquipment(Equipment equipment);
    boolean updateEquipment(Equipment equipment);
    boolean deleteEquipment(int equipmentId);
    boolean reportMaintenance(int equipmentId);
    List<Equipment> getMaintenanceEquipment();
}
