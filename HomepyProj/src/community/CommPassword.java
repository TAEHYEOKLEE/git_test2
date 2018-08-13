package community;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class CommPassword extends HttpServlet {
	//패스워드 입력창 보여주기
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//상세보기에서 수정/삭제를 눌렀을때...
		
		//폼값받기
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String nowPage = req.getParameter("nowPage");
		
		//뷰로 전달할 데이터를 영역에 저장하기
		req.setAttribute("idx", idx);
		req.setAttribute("mode", mode);
		
		//뷰로 포워드
		RequestDispatcher dis = req.getRequestDispatcher("/community/sub01_password.jsp");
		dis.forward(req, resp);		
	}
	
	//입력한 패스워드를 통해 검증후 페이지 이동하기
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		String mode = req.getParameter("mode");
		String pass = req.getParameter("pass");
		String nowPage = req.getParameter("nowPage");
		
		CommunityDAO dao = new CommunityDAO();
		boolean isCorrect = 
			dao.isCorrectPassword(pass,idx);
		dao.close();
		
		//결과값을 리퀘스트 영역에 저장
		req.setAttribute("PASS_CORRECT", isCorrect);
		req.setAttribute("nowPage", nowPage);
		
		/*
		모델에서 처리한 결과에 따라 메세지를 띄워준후
		해당 페이지로 이동 혹은 삭제처리를 위한 
		페이지로 포워드
		 */
		req.getRequestDispatcher("/community/PassMessage.jsp").forward(req, resp);
	}
}
