package community;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class CommReply extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//폼값받기
		String idx = req.getParameter("idx");
		
		//원 게시물 가져오기
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO dto = dao.selectView(idx);
		
		
		//답변글을 위한 추가부분..
		dto.setTitle("[Re]"+dto.getTitle());
		dto.setContent("\r\n\r\n\r\n[원본글입니다]\r\n"
				+dto.getContent());
		
		
		req.setAttribute("dto", dto);
				
		
		RequestDispatcher dis = 
		req.getRequestDispatcher("/community/sub01_reply.jsp");
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
			
			//답변글쓰기를 위한 로직추가
			String bgroup = mr.getParameter("bgroup");
			String bstep = mr.getParameter("bstep");
			String bindent = mr.getParameter("bindent");
			
			CommunityDTO dto = new CommunityDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setPass(pass);
			
			//답변글쓰기 setter추가
			dto.setBgroup(Integer.parseInt(bgroup));
			dto.setBstep(Integer.parseInt(bstep));
			dto.setBindent(Integer.parseInt(bindent));
			
			CommunityDAO dao = new CommunityDAO();
			sucOrFail = dao.reply(dto);
			dao.close();
		}
		else{
			sucOrFail = -1;
		}
		
		if(sucOrFail==1){
			//DB입력성공일때
			//req.getRequestDispatcher("/community/sub01_list.jsp").forward(req,resp);
			resp.sendRedirect("../Community/CommList");
		}
		else{
			//DB입력실패 혹은 파일업로드 실패시
			req.getRequestDispatcher("/community/sub01_reply.jsp").forward(req,resp);
		}
	}
}
