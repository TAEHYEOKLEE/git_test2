<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"	%>      
<%-- PassMessage.jsp --%>
<%--
패스워드 검증을 마친후 결과에 따라 메세지를 띄워주고
	mode값에 따라 수정 혹은 삭제 처리
	mode -> edit 라면 수정페이지로 이동
	mode -> delete 라면 즉시 삭제처리
--%>
<c:choose>
	<c:when test="${param.mode=='edit' }">
		<c:set var="moveUrl" value="../Community/CommEdit?idx=${param.idx }&nowPage=${requestScope.nowPage }" />
	</c:when>
	<c:otherwise>
		<c:set var="moveUrl" value="../Community/CommDelete?idx=${param.idx }&nowPage=${nowPage }" />
	</c:otherwise>
</c:choose>

<script>
<c:choose>
	<c:when test="${PASS_CORRECT }">
		//alert("패스워드 검증완료");
		location.href="<c:url value='${moveUrl}' />";
	</c:when>
	<c:otherwise>
		alert("패스워드 검증실패. 뒤로이동");
		history.back();
		//history.go(-1); 위와 동일
	</c:otherwise>
</c:choose>
</script>









