package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import model.Equipment;
import model.Supplier;
import service.EquipmentService;
import service.SupplierService;

@WebServlet(name = "EquipmentServlet", urlPatterns = {"/equipment"})
public class EquipmentServlet extends HttpServlet {

    private final EquipmentService equipmentService = new EquipmentService();
    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "maintenance":
                List<Equipment> maintList = equipmentService.getMaintenanceEquipment();
                request.setAttribute("equipmentList", maintList);
                request.setAttribute("suppliers", supplierService.getAllSuppliers());
                request.getRequestDispatcher("/equipment/maintenance.jsp").forward(request, response);
                break;
            case "reportMaintenance":
                try {
                    int repId = Integer.parseInt(request.getParameter("id"));
                    equipmentService.reportMaintenance(repId);
                } catch (NumberFormatException e) { e.printStackTrace(); }
                response.sendRedirect(request.getContextPath() + "/equipment");
                break;
            case "markActive":
                try {
                    int activeId = Integer.parseInt(request.getParameter("id"));
                    new dao.EquipmentDAO().updateStatus(activeId, "Active");
                } catch (Exception e) { e.printStackTrace(); }
                response.sendRedirect(request.getContextPath() + "/equipment?action=maintenance");
                break;
            case "delete":
                try {
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    equipmentService.deleteEquipment(deleteId);
                } catch (NumberFormatException e) { e.printStackTrace(); }
                response.sendRedirect(request.getContextPath() + "/equipment");
                break;
            default:
                List<Equipment> allEquipment = equipmentService.getAllEquipment();
                request.setAttribute("equipmentList", allEquipment);
                request.setAttribute("suppliers", supplierService.getAllSuppliers());
                request.getRequestDispatcher("/equipment/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                Equipment e = new Equipment();
                e.setEquipmentName(request.getParameter("equipmentName"));
                String qty = request.getParameter("quantity");
                e.setQuantity(qty != null && !qty.isEmpty() ? Integer.parseInt(qty) : 1);
                e.setStatus("Active");

                String pd = request.getParameter("purchaseDate");
                if (pd != null && !pd.isEmpty()) {
                    e.setPurchaseDate(new SimpleDateFormat("yyyy-MM-dd").parse(pd));
                }

                String price = request.getParameter("purchasePrice");
                if (price != null && !price.isEmpty()) {
                    e.setPurchasePrice(new BigDecimal(price));
                }

                String suppId = request.getParameter("supplierId");
                if (suppId != null && !suppId.isEmpty()) {
                    e.setSupplierId(Integer.parseInt(suppId));
                }

                equipmentService.addEquipment(e);

            } else if ("update".equals(action)) {
                Equipment e = new Equipment();
                e.setEquipmentId(Integer.parseInt(request.getParameter("equipmentId")));
                e.setEquipmentName(request.getParameter("equipmentName"));
                String qty = request.getParameter("quantity");
                e.setQuantity(qty != null && !qty.isEmpty() ? Integer.parseInt(qty) : 1);
                e.setStatus(request.getParameter("status"));

                String pd = request.getParameter("purchaseDate");
                if (pd != null && !pd.isEmpty()) {
                    e.setPurchaseDate(new SimpleDateFormat("yyyy-MM-dd").parse(pd));
                }

                String price = request.getParameter("purchasePrice");
                if (price != null && !price.isEmpty()) {
                    e.setPurchasePrice(new BigDecimal(price));
                }

                String suppId = request.getParameter("supplierId");
                if (suppId != null && !suppId.isEmpty()) {
                    e.setSupplierId(Integer.parseInt(suppId));
                }

                equipmentService.updateEquipment(e);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/equipment");
    }
}
