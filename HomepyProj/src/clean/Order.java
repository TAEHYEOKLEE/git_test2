package clean;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import homepyT.HomepyDAO;

public class Order extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8"); 
		String name = req.getParameter("name");
		String addr = req.getParameter("addr");
		String contactnum = req.getParameter("contactnum1") + "-" + req.getParameter("contactnum2") + "-"
				+ req.getParameter("contactnum3");
		String cellnum = req.getParameter("cellnum1") + "-" + req.getParameter("cellnum2") + "-"
				+ req.getParameter("cellnum3");
		String email = req.getParameter("email1") + "@" + req.getParameter("email2");
		String cleantype = req.getParameter("cleantype");
		String cleansize = req.getParameter("cleansize");
		String cleandate = req.getParameter("cleandate");
		String book = req.getParameter("book");
		String etc = req.getParameter("etc");

		OrderDTO dto = new OrderDTO(name, addr, contactnum, cellnum, email, cleantype, cleansize, cleandate, book, etc);
		HomepyDAO dao = new HomepyDAO();
	
	
		int s = dao.af(dto);
		
		if(s == 1 ) {
			req.setAttribute("DTO", dto);
			req.getRequestDispatcher("/EMailSend/Emailsending.jsp").forward(req, resp);
		}
		else {
			System.out.println("디버깅 필요");
		}
		
	}
	
	
	

	
}
