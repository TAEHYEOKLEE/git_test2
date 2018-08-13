package community;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.PagingUtil;


public class CommList extends HttpServlet{

	/*
	리스트의 경우 a태그를 통해 링크를 타고 들어오거나
	검색의 경우도 get방식이기 때문에 doPost()메소드는 
	굳이 필요없다. 
	*/
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		//게시판 리스트 비즈니스 로직 작성
		
		//DB연결을 위한 DAO 호출
		CommunityDAO dao = new CommunityDAO();
		//파라미터 저장을 위한 Map타입의 변수생성
		Map param = new HashMap();
		
		
		//문자열 검색을 위한 변수선언
		String addQueryString = "";

		//검색기능구현
		String searchColumn = req.getParameter("searchColumn");
		String searchWord = req.getParameter("searchWord");
		if(searchColumn!=null)
		{
			addQueryString = String.format("searchColumn=%s"
				+"&searchWord=%s&",
				searchColumn, searchWord);
			
			//맵에 저장
			param.put("Column", searchColumn);
			param.put("Word", searchWord);
		}
		
		//전체 레코드수를 카운트하기
		//1.게시판 테이블의 전체 레코드 갯수 구하기
		int totalRecordCount = 
			dao.getTotalRecordCount(param);
		
		
		//페이지수 계산을 위한 페이지설정값 가져오기
		//2.web.xml에 설정된 페이지사이즈와 블럭페이지 가져오기
		/*
			※영역에서 가져올때는 문자형태이기때문에 사칙연산을
			위해서는 숫자형태로 변경해줘야 한다.
		*/
		/*
		 * 방법1]
		 * 서블릿에서 어플리케이션 영역 접근을 위한 설정 
		 <context-param> 엘리먼트에 저장된 값을 가져온다.
		 */
		/*ServletContext application = 
				this.getServletContext();
		int pageSize = 
			Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
		int blockPage = 
			Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));*/
		/*
		 * 방법2]
		 * 해당 매핑정보가 있는 위치에서 꺼내오기
		 */
		int pageSize = 
			Integer.parseInt(this.getInitParameter("PAGE_SIZE"));
		int blockPage = 
			Integer.parseInt(this.getInitParameter("BLOCK_PAGE"));
		
			
		//3.전체 페이지수 계산하기
		int totalPage = 
			(int)Math.ceil((double)totalRecordCount/pageSize);

		System.out.println("전체레코드수:"+ totalRecordCount);
		System.out.println("전체페이지수:"+ totalPage);
		
		
		/*
		4.페이지번호를 파라미터로 받는다. 단, 최초 접속시에는
		페이지번호가 없으므로 무조건 1페이지로 설정한다.
		*/
		int nowPage = (req.getParameter("nowPage")==null
			|| req.getParameter("nowPage").equals(""))
			?
			1 
			: 
			Integer.parseInt(req.getParameter("nowPage"));

		/*
		5.가져올 레코드의 구간을 결정하기 위한 연산
		*/
		int start = (nowPage-1) * pageSize + 1;
		int end = nowPage * pageSize;

		/*
		6.map에 구간을 추가
		*/
		param.put("start", start);
		param.put("end", end);
		
		/*
		 * 가상번호 계산을 위한 추가
		 */
		param.put("totalPage", totalPage);//전체페이지수
		param.put("nowPage", nowPage);//현재페이지
		param.put("totalCount", totalRecordCount);//전체레코드갯수
		param.put("pageSize", pageSize);//한페이지에 출력할 게시물갯수
		
				
		//DAO호출하여 레코드 가져오기(페이지처리X)
		/*List<CommunityDTO> lists = dao.selectList();*/
		//DAO호출하여 레코드 가져오기(페이지처리O)
		List<CommunityDTO> lists = dao.selectPaging(param);
		
		
		//페이지 처리를 위한 문자열 생성
		String pagingImg = PagingUtil.pagingImgServlet(
			totalRecordCount,pageSize,
			blockPage, nowPage, 
			"../Community/CommList?"+addQueryString);
		
		
		//커넥션풀에 자원반납
		dao.close();
		
		//리퀘스트 영역에 저장하기
		req.setAttribute("lists", lists);//결과 레코드셋
		//페이지번호 출력 문자열 저장
		req.setAttribute("pagingImg", pagingImg);
		req.setAttribute("map", param);//파라미터
		
		
		RequestDispatcher dis = 
		req.getRequestDispatcher("/community/sub01_list.jsp");
		dis.forward(req, resp);
	}
}







