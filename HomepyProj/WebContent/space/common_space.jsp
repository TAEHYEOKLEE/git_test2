<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String title_image="";
String path_str="";
switch(b_flag){
case "notice":
   title_image = "sub01_title.gif";
   path_str = "공지사항";
   break;
case "program":
   title_image = "sub02_title.gif";
   path_str = "프로그램일정";
   break;
case "free":
   title_image = "sub03_title.gif";
   path_str = "자유게시판";
   break;
case "photo":
   title_image = "sub04_title.gif";
   path_str = "사진게시판";
   break;
case "information":
   title_image = "sub05_title.gif";
   path_str = "정보자료실";
   break;
}
%>
