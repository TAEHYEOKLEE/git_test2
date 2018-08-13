<%@page import="homepyT.HomepyDAO"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="homepyT.HomepyMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"	%>      
<%
/*
회원정보수정 페이지는 로그인정보가 있어야 진입이 가능하다.
*/
if(session.getAttribute("USER_ID")==null)
{
	JavascriptUtil.jsAlertLocation("로그인 정보가 없습니다.", 
			"../main/main.jsp", out);
	
	/* 위의 JS함수가 동작후 return이 없으면 아래 
	JSP코드가 실행될수 있기때문에 반드시 return으로
	실행을 멈춰줘야 한다.*/
	return;
}

//파일명 : modify_t_process.jsp
//한글처리
request.setCharacterEncoding("UTF-8");

//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");

String tel = request.getParameter("tel1")+"-"
		+request.getParameter("tel2")+"-"
		+request.getParameter("tel3");

String mobile = request.getParameter("mobile1")+"-"
		+request.getParameter("mobile2")+"-"
		+request.getParameter("mobile3");

String email = request.getParameter("email_1")+"@"
		+request.getParameter("email_2") ;

String zipcode = request.getParameter("zipcode");
String addr1 = request.getParameter("addr1");
String addr2 = request.getParameter("addr2");

//인자생성자 이용해서 DTO에 값 세팅하기
HomepyMemberDTO dto = new HomepyMemberDTO(id,pass,name,tel,mobile,
		email,zipcode,addr1,addr2,null);

//DAO객체 생성
HomepyDAO dao = new HomepyDAO();
int af = dao.memberModify(dto);
if(af==1){
	//out.println("수정성공");
	session.setAttribute("USER_NAME", name);
	JavascriptUtil.jsAlertLocation("수정성공.", "../member/login.jsp", out);
}
else{
	//out.println("수정실패");
	JavascriptUtil.jsAlertBack("수정실패. 뒤로이동", out);
}
%>