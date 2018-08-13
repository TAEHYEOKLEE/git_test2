<%@page import="email.SendEmail"%>
<%@page import="email.SendEmail"%>
<%@page import="org.apache.naming.factory.SendMailFactory"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="homepyT.HomepyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8"%>
<%	 request.setCharacterEncoding("UTF-8");
	
	 String name = request.getParameter("name");
	 String id = request.getParameter("id");
	 String email = request.getParameter("email");
	 System.out.println("이름:" + name);
	 System.out.println("아이디:" + id);
	 System.out.println("이메일:" + email);
	 
	 HomepyDAO dao = new HomepyDAO();
	 String user_id = dao.id_search2(name, email);
	
	 
	 try{
		 if (user_id != null) 
		 { //아이디 찾기 성공시
			JavascriptUtil.jsAlertBack("당신의 아이디는 "+user_id+"입니다", out);
		 }
		 else 
		 {
			 JavascriptUtil.jsAlertBack("아이디찾기 실패", out);
		 }
	 }
	 catch(Exception e){
		 
	 }
%>