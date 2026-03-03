package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.Supplier;
import service.SupplierService;

@WebServlet(name = "SupplierServlet", urlPatterns = {"/suppliers"})
public class SupplierServlet extends HttpServlet {

    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        switch (action) {
            case "create":
                request.getRequestDispatcher("/suppliers/form.jsp").forward(request, response);
                break;
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Supplier supplier = supplierService.getSupplierById(editId);
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/suppliers/form.jsp").forward(request, response);
                break;
            case "delete":
                int deleteId = Integer.parseInt(request.getParameter("id"));
                supplierService.deleteSupplier(deleteId);
                response.sendRedirect(request.getContextPath() + "/suppliers");
                break;
            case "search":
                String keyword = request.getParameter("keyword");
                List<Supplier> results = supplierService.searchSuppliers(keyword);
                request.setAttribute("suppliers", results);
                request.setAttribute("keyword", keyword);
                request.getRequestDispatcher("/suppliers/list.jsp").forward(request, response);
                break;
            default:
                List<Supplier> suppliers = supplierService.getAllSuppliers();
                request.setAttribute("suppliers", suppliers);
                request.getRequestDispatcher("/suppliers/list.jsp").forward(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        if ("create".equals(action)) {
            Supplier s = new Supplier();
            s.setCompanyName(request.getParameter("companyName"));
            s.setPhone(request.getParameter("phone"));
            s.setEmail(request.getParameter("email"));
            s.setSupplyType(request.getParameter("supplyType"));
            s.setAddress(request.getParameter("address"));
            supplierService.addSupplier(s);
        } else if ("update".equals(action)) {
            Supplier s = new Supplier();
            s.setSupplierId(Integer.parseInt(request.getParameter("supplierId")));
            s.setCompanyName(request.getParameter("companyName"));
            s.setPhone(request.getParameter("phone"));
            s.setEmail(request.getParameter("email"));
            s.setSupplyType(request.getParameter("supplyType"));
            s.setAddress(request.getParameter("address"));
            s.setStatus(request.getParameter("status"));
            supplierService.updateSupplier(s);
        }

        response.sendRedirect(request.getContextPath() + "/suppliers");
    }
}
