package filter;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.User;

public class RoleFilter implements Filter {

    private Map<String, List<String>> rolePermissions = new HashMap<>();

    private static String normalizePath(HttpServletRequest req) {
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path = uri.startsWith(contextPath) ? uri.substring(contextPath.length()) : uri;
        int jsessionIdx = path.indexOf(";jsessionid=");
        if (jsessionIdx >= 0) path = path.substring(0, jsessionIdx);
        return path.isBlank() ? "/" : path;
    }

    private boolean isAllowed(String role, String path) {
        List<String> allowedPaths = rolePermissions.get(role);
        if (allowedPaths == null) return true;
        return allowedPaths.stream().anyMatch(path::startsWith);
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

        // /login: cho logout đi qua, chặn nếu đã login và không phải logout
        if ("/login".equals(path) || "/login.jsp".equals(path)) {
            if ("logout".equals(action)) {
                chain.doFilter(request, response);
                return;
            }
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        if (!isAllowed(role, path)) {
            res.sendRedirect(contextPath + "/dashboard");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        for (String role : List.of("Admin", "Staff", "Member")) {
            String value = filterConfig.getInitParameter(role);
            if (value == null) continue;
            rolePermissions.put(role, value.equals("*") ? null : Arrays.asList(value.split(",")));
        }
    }

    @Override
    public void destroy() {}
}