package cepp.genericos;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Filtro para redirigir ceppuy.org a ceppuy.com
 * @author Patricio
 */
public class DomainRedirectFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No necesita inicialización
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        String host = httpRequest.getHeader("Host");
        String requestURI = httpRequest.getRequestURI();
        String queryString = httpRequest.getQueryString();
        
        // Redirigir si el dominio es ceppuy.org o www.ceppuy.org
        if (host != null && (host.equals("ceppuy.org") || host.equals("www.ceppuy.org"))) {
            // Construir la URL de destino
            String redirectURL = "https://ceppuy.com" + requestURI;
            if (queryString != null && !queryString.isEmpty()) {
                redirectURL += "?" + queryString;
            }
            
            // Redirección permanente (301)
            httpResponse.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
            httpResponse.setHeader("Location", redirectURL);
            return;
        }
        
        // Si no es ceppuy.org, continuar normalmente
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // No necesita limpieza
    }
}

