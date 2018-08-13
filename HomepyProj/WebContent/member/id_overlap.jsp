<%@page import="org.json.simple.JSONObject"%>
<%@page import="homepyT.HomepyMemberDTO"%>
<%@page import="homepyT.HomepyDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
1. 폼값 (userid) 을 받는다.
2. DAO객체를 생성후 아이디중복확인을 위한 메소드를 호출한다.
3. 메소드 호출시 폼값을 전달한다.
4. 검증이 끝난후 해당 아이디가 이미 존재하면 "가입불가"
아이디가 없다면 "가입가능" 메세지를 JSON으로 생성한다.
5.위에서 생성한 JSON데이터를 화면에 출력한다.
*/

//폼값받기
String userid=request.getParameter("userid");
//DAO객체생성
HomepyDAO dao = new HomepyDAO();
//함수호출
HomepyMemberDTO memberInfo = dao.getMemberInfo(userid);

//JSON 생성을 위한 객체생성
JSONObject json = new JSONObject();

if(memberInfo.getName()==null && userid!=null && !userid.equals("")){
	//out.println("회원정보없음. 가입가능");
	json.put("idResult",1);
	json.put("Msg","<span style='color:red'>사용가능한 아이디입니다.</span>");
}
else{
	//out.println("회원정보있음. 가입불가");
	json.put("idResult",0);
	json.put("Msg","<span style='color:blue'>중복된 아이디가 존재하여 가입불가능합니다.</span>");
}
//JSON을 화면에 바로 출력
out.println(json.toJSONString());

%>



