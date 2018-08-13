package community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CommDownload extends HttpServlet {
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//파라미터 받기
		String filename = req.getParameter("filename");
		String idx = req.getParameter("idx");

		//파일 다운로드 로직 호출
		FileUtil.download(req, resp, "/Upload", filename);

		//dataroom 테이블의 downcount +1 증가시키기
		CommunityDAO dao = new CommunityDAO();
		dao.downCountPlus(idx);
		dao.close();
		
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}
}
