package exam.utils.myFilter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet Filter implementation class Login_Filter
 */
@WebFilter("/Login_Filter")
public class Login_Filter implements Filter {

	/**
	 * Default constructor.
	 */
	public Login_Filter() {
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see Filter#destroy()
	 */
	public void destroy() {
		// TODO Auto-generated method stub
	}

	/**
	 * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
	 */
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		// TODO Auto-generated method stub
		// place your code here

		HttpServletRequest servletRequest = (HttpServletRequest) request;
		HttpServletResponse servletResponse = (HttpServletResponse) response;
		HttpSession session = servletRequest.getSession();

		// 获得用户请求的URL
		String path = servletRequest.getRequestURI();

		// 从session里取登录者信息
		String fadmin = (String) session.getAttribute("admin");
		String fteacher = (String) session.getAttribute("teacher");
		String fstudent = (String) session.getAttribute("student");

		// 登陆界面无需过滤
		if (path.indexOf("/index.jsp") > -1) {
			chain.doFilter(servletRequest, servletResponse);
			return;
		}

		// 判断如果没有取到登录者信息，就跳转到登录界面
		if ((fadmin == null || fadmin.equals("")) && (fteacher == null || fteacher.equals("")) && (fstudent == null
				|| fstudent.equals(""))) {
			servletResponse.sendRedirect(servletRequest.getContextPath() + "/index.jsp");
			return;
		} else {
			chain.doFilter(request, response);
		}
	}

	/**
	 * @see Filter#init(FilterConfig)
	 */
	public void init(FilterConfig fConfig) throws ServletException {
		// TODO Auto-generated method stub
	}

}
