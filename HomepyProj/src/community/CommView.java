package community;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServlet;

import community.CommunityDAO;
import community.CommunityDTO;

public class CommView extends HttpServlet {
	/*
	서블릿에서 요청을 받을때 doGet() 혹은 doPost()로
	처리할것을 service()메소드 하나로 대체할수 있다.		
	*/
	@Override
	public void service(ServletRequest req, ServletResponse resp) throws ServletException, IOException {
		
		//idx값 받기
		String idx = req.getParameter("idx");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO dto = dao.selectView(idx);
		
		//조회수 증가시키기
		dao.updateVisitCount(idx);
		
		//줄바꿈처리
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		dao.close();

		//리퀘스트 영역에 저장
		req.setAttribute("dto", dto);		
		
		//상세보기 페이지로 포워드
		RequestDispatcher dis = req.getRequestDispatcher("/community/sub01_view.jsp");
		dis.forward(req, resp);
	}
}
