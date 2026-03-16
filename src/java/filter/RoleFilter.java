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

        // Nếu đã đăng nhập thì không nên ở trang login (trừ khi đang logout)
        if (("/login".equals(path) || "/login.jsp".equals(path)) && !"logout".equals(action)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        if (path.startsWith("/suppliers") && !"Admin".equals(role)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        if (path.startsWith("/subscriptions") && !"Admin".equals(role)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        if ((path.startsWith("/members") || path.startsWith("/equipment")) 
                && "Member".equals(role)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        if ((path.startsWith("/cart") || path.startsWith("/packages")) 
                && path.contains("action=addPackage") && !"Member".equals(role)) {
            // Only members can add to cart
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
