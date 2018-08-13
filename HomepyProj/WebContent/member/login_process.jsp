<%@page import="util.JavascriptUtil"%>
<%@page import="java.util.Map"%>
<%@page import="homepyT.HomepyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"	%>      
<%
//폼값받기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
//아이디 쿠키로 저장하기
String id_save = request.getParameter("id_save");

//이전페이지로 돌아가기
String backUrl = request.getParameter("backUrl");



//dao생성
HomepyDAO dao = new HomepyDAO();

//함수호출
Map<String, String> memberInfo = dao.memberLogin(id, pass);

if(memberInfo.get("name")!=null){
	//세션영역에 저장
	session.setAttribute("USER_ID", memberInfo.get("id"));
	session.setAttribute("USER_NAME", memberInfo.get("name"));
	session.setAttribute("USER_EMAIL", memberInfo.get("email"));
	
	//아이디저장 체크여부 판단하기
	if(id_save==null){
		//체크가 해제된경우(쿠키값을 지움)
		
		//쿠키삭제시에는 빈값으로 만들어주면 됨.
		
		//쿠키객체생성
		Cookie ck = new Cookie("USER_ID","");
		//쿠키경로 설정
		ck.setPath(request.getContextPath());
		ck.setMaxAge(0);
		//응답헤더에 쿠키적용
		response.addCookie(ck);
		
	}
	else{
		//체크가 된경우(쿠키를 생성)
		Cookie ck = new Cookie("USER_ID", id);
		
		//쿠키가 적용될 경로지정
		System.out.println(request.getContextPath());
		ck.setPath(request.getContextPath());
		
		//쿠키의 유효기간
		ck.setMaxAge(60*60*24*100);		
		response.addCookie(ck);
	}
	
	if(backUrl==null || backUrl.equals("")){
		response.sendRedirect("../main/main.jsp");
	}
	else{
		response.sendRedirect(backUrl);
	}
}
else{
	JavascriptUtil.jsAlertBack("로그인 실패욤", out);
}
%>



