package community;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import community.CommunityDAO;
import community.CommunityDTO;
import community.FileUtil;

public class CommWrite extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글쓰기 페이지로 이동(포워드)
		RequestDispatcher dis = 
		req.getRequestDispatcher("/community/sub01_write.jsp");
		dis.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//글쓰기 관련 폼값 받은후 처리
		
		//한글처리
		req.setCharacterEncoding("UTF-8");
		
		//파일업로드를 위한 모델(비즈니스로직) 호출
		MultipartRequest mr = FileUtil.upload(req,
			req.getServletContext().getRealPath("/Upload"));
		
		//파일업로드 성공여부 체크위한 변수
		//DB입력성공시:1, 실패시:0, 파일용량초과시:-1
		int sucOrFail;
		
		if(mr != null){
			//나머지 파라미터를 MultipartRequest객체를 통해받음
			String name = mr.getParameter("name");
			String title = mr.getParameter("title");
			String pass = mr.getParameter("pass");
			String content = mr.getParameter("content");
			String attachedfile = mr.getFilesystemName("attachedfile");
			
			CommunityDTO dto = new CommunityDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setPass(pass);
			
			CommunityDAO dao = new CommunityDAO();
			sucOrFail = dao.insert(dto);
			dao.close();
		}
		else{
			sucOrFail = -1;
		}
		
		if(sucOrFail==1){
			//DB입력성공일때
			//req.getRequestDispatcher("/Community/CommList").forward(req,resp);
			resp.sendRedirect("../Community/CommList");
		}
		else{
			//DB입력실패 혹은 파일업로드 실패시
			req.getRequestDispatcher("/community/sub01_write.jsp").forward(req,resp);
		}
	}
}
