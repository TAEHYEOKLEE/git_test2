<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
   uri="http://java.sun.com/jsp/jstl/core"   %>     
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
     

<c:choose>
   <c:when test="${MODE=='idSearch' }">
      <c:set var="sucmsg" value="아이디는 ${SUC_IDPW }입니다.." />
      <c:set var="failmsg" value="잘못된 정보입니다." />
      <c:set var="sucurl" 
      value="../member/id_pw.jsp" />
   </c:when>
   <c:when test="${MODE=='pwSearch' }">
      <c:set var="sucmsg" value="비밀번호를 이메일로 발송하였습니다." />
      <c:set var="failmsg" value="잘못된 정보입니다." />
      <c:set var="sucurl" 
      value="../Main/MainSpaceList" />   
   </c:when>
   
</c:choose>

<script>

<c:choose>
   <c:when test="${SUC_IDPW!=''}">
      alert("${sucmsg }");
      location.href="<c:url value='${sucurl }' />";
   </c:when>
   <c:when test="${AF==1}">
   alert("${sucmsg }");
   location.href="<c:url value='${sucurl }' />";
   </c:when>
   <c:otherwise>
      alert("${failmsg }");
      history.back();
   </c:otherwise>
</c:choose>

</script>



</body>
</html>