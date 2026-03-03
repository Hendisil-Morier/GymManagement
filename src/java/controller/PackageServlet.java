package controller;

import dao.PackageDAO;
import dao.ServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;
import model.GymPackage;
import model.Service;

@WebServlet(name = "PackageServlet", urlPatterns = {"/packages"})
public class PackageServlet extends HttpServlet {

    private final PackageDAO packageDAO = new PackageDAO();
    private final ServiceDAO serviceDAO = new ServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "detail":
                    int pkgId = Integer.parseInt(request.getParameter("id"));
                    GymPackage pkg = packageDAO.findById(pkgId);
                    request.setAttribute("pkg", pkg);
                    request.getRequestDispatcher("/packages/detail.jsp").forward(request, response);
                    break;
                case "delete":
                    int delId = Integer.parseInt(request.getParameter("id"));
                    packageDAO.delete(delId);
                    response.sendRedirect(request.getContextPath() + "/packages");
                    break;
                default:
                    List<GymPackage> packages = packageDAO.findAll();
                    List<Service> services = serviceDAO.findAll();
                    request.setAttribute("packages", packages);
                    request.setAttribute("services", services);
                    request.getRequestDispatcher("/packages/list.jsp").forward(request, response);
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/packages");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String action = request.getParameter("action");

        try {
            if ("create".equals(action)) {
                GymPackage p = new GymPackage();
                p.setPackageName(request.getParameter("packageName"));
                p.setPrice(new BigDecimal(request.getParameter("price")));
                p.setDurationMonth(Integer.parseInt(request.getParameter("durationMonth")));
                p.setDescription(request.getParameter("description"));
                packageDAO.insert(p);
            } else if ("update".equals(action)) {
                GymPackage p = new GymPackage();
                p.setPackageId(Integer.parseInt(request.getParameter("packageId")));
                p.setPackageName(request.getParameter("packageName"));
                p.setPrice(new BigDecimal(request.getParameter("price")));
                p.setDurationMonth(Integer.parseInt(request.getParameter("durationMonth")));
                p.setDescription(request.getParameter("description"));
                p.setStatus(request.getParameter("status"));
                packageDAO.update(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/packages");
    }
}
