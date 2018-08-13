<%@page import="util.PagingUtil"%> 
<%@page import="homepyT.HomepyBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="homepyT.HomepyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
//한글처리
request.setCharacterEncoding("UTF-8");

//멀티게시판 처리를 위한 파라미터 받기 밑 경로 설정
String b_flag = request.getParameter("b_flag")==null
   ? "notice" : request.getParameter("b_flag");


//커넥션풀로 변경
HomepyDAO dao = new HomepyDAO();


//매개변수 저장을 위한 컬렉션 생성(DAO로 전달)
Map<String,Object> param = new HashMap<String,Object>();

//DAO로 b_flag를 전달하기 위해 맵에 추가함.
param.put("b_flag", b_flag);

//문자열 검색 파라미터를 페이지 처리 메소드로
//넘겨주기 위한 변수선언
String queryStr = "";



param.put("b_flag", b_flag);

//문자열 검색 파라미터를 페이지 처리 메소드로 넘겨주기 위해
queryStr = "b_flag="+b_flag+"&";


//폼값받기(검색관련)
String searchColumn = 
   request.getParameter("searchColumn");
String searchWord = 
   request.getParameter("searchWord");
if(searchWord!=null){
   //입력한 검색어가 있다면 맵에 추가함
   param.put("Column", searchColumn);
   param.put("Word", searchWord);
   
   //파라미터 추가
   queryStr = String.format("searchColumn=%s"
      +"&searchWord=%s&", searchColumn,
         searchWord);
}


//페이지 처리를 위한 로직 시작
//1.게시판 테이블의 전체 레코드 갯수 구하기
int totalRecordCount =    dao.getTotalRecordCount(param); 

//2.web.xml에 설정된 값 가져오기
int pageSize = Integer.parseInt(
   application.getInitParameter("PAGE_SIZE"));
int blockPage = Integer.parseInt(
   application.getInitParameter("BLOCK_PAGE"));

//3.전체페이지수 계산하기
int totalPage = 
(int)Math.ceil((double)totalRecordCount/pageSize);

//4.페이지번호가 없는경우 무조건 1로 설정
int nowPage = 
  request.getParameter("nowPage")==null
  ? 1 : 
  Integer.parseInt(request.getParameter("nowPage"));

//5.가져올 레코드의 구간을 결정하기 위한 연산
int start = (nowPage-1)*pageSize + 1;
int end = nowPage * pageSize;

//6.파라미터 전달을 위해 map에 추가
param.put("start", start);
param.put("end", end);

/////게시판 페이지 처리 로직 끝

  
/*
게시판에서 레코드를 가져올때는 반드시 "List계열"의 
컬렉션을 사용해야 한다. Set계열의 컬렉션은 저장된 요소의
순서를 보장하지 않기때문에 게시판 목록을 구현할때 문제가 
될수있기 때문이다.
*/
List<HomepyBoardDTO> bbs = dao.selectList(param);

dao.close();

%>
<%@ include file="common_space.jsp" %> 
<body>
   <center>
   <div id="wrap">
      <%@ include file="../include/top.jsp" %>

      <img src="../images/space/sub_image.jpg" id="main_visual" />

      <div class="contents_box">
         <div class="left_contents">
            <%@ include file = "../include/space_leftmenu.jsp" %>
         </div>
         <div class="right_contents">
            <div class="top_title">
               <img src="../images/space/<%=title_image %>" alt="공지사항" class="con_title" />
               <p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=path_str %></p>
            </div>
            <div>

<div class="row text-right" style="margin-bottom:20px;
      padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline">   
<input type="hid den" name="b_flag" value="<%=b_flag%>"/>
<input type="hid den" name="nowPage" value="1"/>
   <div class="form-group">
      <select name="searchColumn" class="form-control">
         <option value="title">제목</option>
         <option value="content">내용</option>
         <option value="both">제목+내용</option>
      </select>
   </div>
   <div class="input-group">
      <input type="text" name="searchWord"  class="form-control"/>
      <div class="input-group-btn">
         <button type="submit" class="btn btn-default">
            <i class="glyphicon glyphicon-search"></i>
         </button>
      </div>
   </div>
</form>   
</div>
<div class="row">
   <!-- 게시판리스트부분 -->
   <table class="table table-bordered table-hover">
   <colgroup>
      <col width="80px"/>
      <col width="*"/>
      <col width="120px"/>
      <col width="120px"/>
      <col width="80px"/>
      <col width="50px"/>
   </colgroup>
   
   <thead>
   <tr class="success">
      <th class="text-center">번호</th>
      <th class="text-left">제목</th>
      <th class="text-center">작성자</th>
      <th class="text-center">작성일</th>
      <th class="text-center">조회수</th>
      <th class="text-center">첨부</th>
   </tr>
   </thead>
   
   <tbody>
<%
if(bbs.isEmpty()){
   //컬렉션에 저장된 데이터가 없는경우
%>
      <tr>
         <td colspan="5" align="center">
            등록된 게시물이 없습니다^^*
         </td>
      </tr>
<%
}
else
{
   //컬렉션에 저장된 데이터가 있는경우 for-each문을통해
   //내용 출력
   int vNum = 0;
   int countNum = 0;
   for(HomepyBoardDTO dto : bbs)
   {
      //게시물의 번호를 순서대로 출력하기위한
      //가상번호 생성(게시물의 갯수를 기준)
      vNum = totalRecordCount - 
         (((nowPage-1)*pageSize)+countNum++);
      /*
      전체게시물수 : 121개
      현재페이지 : 1
      페이지사이즈 : 10
1페이지일때 
   1번게시물 : 121 - (((1-1)*10) + 0) => 121
   2번게시물 : 121 - (((1-1)*10) + 1) => 120
2페이지일때 
   1번게시물 : 121 - (((2-1)*10) + 0) => 111
   2번게시물 : 121 - (((2-1)*10) + 1) => 110
      */
%>
   <!-- 리스트반복 -->
   <tr>
      <td class="text-center"><%=vNum %></td>
      <td class="text-left">
         <a href="sub01_t_view.jsp?num=<%=dto.getNum()%>&b_flag=<%=b_flag%>&nowPage=<%=nowPage%>">
            <%=dto.getTitle() %>
         </a></td>
      <td class="text-center"><%=dto.getName() %></td>
      <td class="text-center"><%=dto.getPostDate() %></td>
      <td class="text-center"><%=dto.getVisitcount() %></td>
      <td class="text-center">--</td>
   </tr>
   <!-- 리스트반복 -->
<%
   }//for-each문 끝
}//if문 끝
%>
   
   </tbody>
   </table>
</div>
<div class="row text-right" style="padding-right:50px;">
   <!-- 각종 버튼 부분 -->
   <!-- <button type="reset" class="btn">Reset</button> -->
      
   <button type="button" class="btn btn-default" 
      onclick="location.href='sub01_t_write.jsp?b_flag=<%=b_flag%>';">글쓰기</button>
            
   <!-- <button type="button" class="btn btn-primary">수정하기</button>
   <button type="button" class="btn btn-success">삭제하기</button>
   <button type="button" class="btn btn-info">답글쓰기</button>
   <button type="button" class="btn btn-warning">리스트보기</button>
   <button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
   <!-- 페이지번호 부분 -->
   <ul class="pagination">
      <!-- <li><span class="glyphicon glyphicon-fast-backward"></span></li>
      <li><a href="#">1</a></li>      
      <li class="active"><a href="#">2</a></li>
      <li><a href="#">3</a></li>
      <li><a href="#">4</a></li>      
      <li><a href="#">5</a></li>
      <li><span class="glyphicon glyphicon-fast-forward"></span></li>-->
      <%=PagingUtil.pagingHomepy(totalRecordCount,
         pageSize, 
         blockPage,
         nowPage,
         "sub01_t_list.jsp?"+queryStr) %>
   </ul>   
</div>

            </div>
         </div>
      </div>
      <%@ include file="../include/quick.jsp" %>
   </div>


   <%@ include file="../include/footer.jsp" %>
   </center>
 </body>
</html>