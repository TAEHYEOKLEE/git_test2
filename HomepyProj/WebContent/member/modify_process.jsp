<%@page import="homepy.HomepyDAO"%>
<%@page import="homepy.HomepyMemberDTO"%>
<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"	%>      
<%
if(session.getAttribute("USER_ID")==null)
{
	JavascriptUtil.jsAlertLocation("로그인 정보가 없습니다.", "../main/main.jsp");
	return;
}

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
//dto.setId(id);//setter를 이용하는 방법

HomepyDAO dao = new HomepyDAO();
int af = dao.memberModify(dto);
if(af==1){
	//out.println("성공");
	session.setAttribute("USER_NAME", name);
	JavascriptUtil.jsAlertLocation("회원정보수정성공", 
			"../main/main.jsp", out);
}
else{
	//out.println("실패");
	JavascriptUtil.jsAlertBack("회원정보수정실패", out);
}

%>