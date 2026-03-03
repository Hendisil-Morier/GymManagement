package filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebFilter(filterName = "AuthFilter", urlPatterns = {"/*"})
public class AuthFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        String uri = req.getRequestURI();
        String contextPath = req.getContextPath();

        boolean isLoginPage = uri.equals(contextPath + "/login") || uri.equals(contextPath + "/login.jsp");
        boolean isStaticResource = uri.contains(".css") || uri.contains(".js") || uri.contains(".png")
                || uri.contains(".jpg") || uri.contains(".ico");
        boolean isIndexPage = uri.equals(contextPath + "/") || uri.equals(contextPath + "/index.html");

        if (isLoginPage || isStaticResource || isIndexPage) {
            chain.doFilter(request, response);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            res.sendRedirect(contextPath + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void destroy() {}
}
