package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.User;

@WebFilter(filterName = "RoleFilter", urlPatterns = {"/*"})
public class RoleFilter implements Filter {

    private static String normalizePath(HttpServletRequest req) {
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.startsWith(contextPath) ? uri.substring(contextPath.length()) : uri;
        int jsessionIdx = path.indexOf(";jsessionid=");
        if (jsessionIdx >= 0) {
            path = path.substring(0, jsessionIdx);
        }
        return path.isBlank() ? "/" : path;
    }

    /**
     * Whitelist theo path:
     * Admin  : toàn quyền
     * Staff  : dashboard, members, equipment, packages, orders
     * Member : dashboard, packages, cart, orders, vnpay-return
     */
    private boolean isAllowed(String role, String path) {
        switch (role) {
            case "Admin":
                return true;

            case "Staff":
                return path.startsWith("/dashboard")
                    || path.startsWith("/members")
                    || path.startsWith("/equipment")
                    || path.startsWith("/packages")
                    || path.startsWith("/orders");

            case "Member":
                return path.startsWith("/dashboard")
                    || path.startsWith("/packages")
                    || path.startsWith("/cart")
                    || path.startsWith("/orders")
                    || path.startsWith("/vnpay-return");

            default:
                return false;
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String contextPath = req.getContextPath();

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            chain.doFilter(request, response);
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = user.getRole();
        String path = normalizePath(req);
        String action = req.getParameter("action");

        // Đã login thì không vào lại trang login (trừ logout)
        if (("/login".equals(path) || "/login.jsp".equals(path)) && !"logout".equals(action)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        // Kiểm tra whitelist
        if (!isAllowed(role, path)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}