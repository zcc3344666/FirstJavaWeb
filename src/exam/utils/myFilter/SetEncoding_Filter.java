package exam.utils.myFilter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

import com.sun.xml.internal.ws.api.client.SelectOptimalEncodingFeature;

/**
 * Servlet Filter implementation class SetEncoding_Filter
 */
@WebFilter("/SetEncoding_Filter")
public class SetEncoding_Filter implements Filter {
	protected String encoding = null;
	protected FilterConfig filterConfig = null;
	protected boolean ignore = true;

    /**
     * Default constructor. 
     */
    public SetEncoding_Filter() {
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
		this.encoding = null;
		this.filterConfig = null;
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		if(ignore || (request.getCharacterEncoding()==null)) {
			encoding=this.selectEncoding(request);
			if(encoding != null) {
				request.setCharacterEncoding(encoding);
			}
		}
		chain.doFilter(request, response);
	}

	private String selectEncoding(ServletRequest request) {
		// TODO Auto-generated method stub
		return (this.encoding);
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
		this.filterConfig = fConfig;
		encoding = fConfig.getInitParameter("encoding");
		String value=fConfig.getInitParameter("ignore");
		if(value == null) {
			ignore = true;
		}else if(value.equalsIgnoreCase("true")) {
			ignore = true;
		}else if (value.equalsIgnoreCase("yes")) {
			ignore = true;
		}else {
			ignore = false;
		}
	}

}
