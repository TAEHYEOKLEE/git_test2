package community;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

public class CommEdit extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//수정페이지 띄워주기
		
		String idx = req.getParameter("idx");
		
		CommunityDAO dao = new CommunityDAO();
		CommunityDTO dto = dao.selectView(idx);
		
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("/community/sub01_edit.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
				
		//한글처리
		req.setCharacterEncoding("UTF-8");
		
		//파일업로드를 위한 모델(비즈니스로직) 호출
		MultipartRequest mr = FileUtil.upload(req,
			req.getServletContext().getRealPath("/Upload"));
		
		//파일업로드 성공여부 체크위한 변수
		//DB입력성공시:1, 실패시:0, 파일용량초과시:-1
		int sucOrFail;
		
		if(mr != null){
			//수정처리를 위한 파라미터
			String idx = mr.getParameter("idx");
			String nowPage = mr.getParameter("nowPage");
			String originalfile = 
				mr.getParameter("originalfile");
			
			//수정처리후 상세보기로 이동하므로 idx저장해야함
			req.setAttribute("idx", idx);
			req.setAttribute("nowPage", nowPage);
			
			//나머지 파라미터를 MultipartRequest객체를 통해받음
			String name = mr.getParameter("name");
			String title = mr.getParameter("title");
			String pass = mr.getParameter("pass");
			String content = mr.getParameter("content");
			String attachedfile = mr.getFilesystemName("attachedfile");
			
			//만약 첨부한 파일이 없다면 기존파일 유지
			if(attachedfile==null) {
				attachedfile = originalfile;
			}
			
			CommunityDTO dto = new CommunityDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setName(name);
			dto.setPass(pass);
			//게시물 수정을 위한 idx 세팅
			dto.setIdx(idx);
			
			CommunityDAO dao = new CommunityDAO();
			sucOrFail = dao.update(dto);
			
			//업데이트가 성공이고, 새로운 파일을 업로드 했다면
			if(sucOrFail==1 && 
				mr.getFilesystemName("attachedfile")!=null)
			{
				//기존 업로드된 파일을 삭제처리
				FileUtil.deleteFile(req, "/Upload",
					originalfile);
			}
			
			dao.close();
		}
		else{
			sucOrFail = -1;
		}
		
		//리퀘스트영역에 메세지 출력을 위한 저장
		req.setAttribute("SUC_FAIL", sucOrFail);
		req.setAttribute("WHEREIS", "UPDATE");
				
		
		req.getRequestDispatcher("/community/Message.jsp").forward(req, resp);	
	}
}
