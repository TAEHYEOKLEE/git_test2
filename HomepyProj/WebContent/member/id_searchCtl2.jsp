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
	 String pass = dao.id_search3(id, name, email);
	 SendEmail mail = new SendEmail();
	 boolean mailOk = mail.SendEmail(id, pass, email);
	 
	 try{
		 if (mailOk==true) 
		 { 
			 JavascriptUtil.jsAlertBack("메일발송 완료", out);	 
		 }
		 else 
		 {
			 JavascriptUtil.jsAlertBack("메일발송 실패", out);
		 }
	 }
	 catch(Exception e){
		 
	 }
%>