<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"
	uri="http://java.sun.com/jsp/jstl/core"	%>       
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub01_title.gif" alt="직원자료실" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;직원자료실<p>
				</div>
				<div>
				<!-- 내용 삽입 s -->
<script>
	function frmValidate(f){
		if(f.pass.value==""){
			alert("비밀번호를 입력하세요");
			f.pass.focus();
			return false;
		}
	}
</script>
<form name="writeFrm" method="post"
 	action="<c:url value="/Community/CommPassword" />"
	onsubmit="return frmValidate(this);">

<input type="hidden" name="idx" value="${idx }" />
<input type="hidden" name="mode" value="${mode }" />
<input type="hidden" name="nowPage"	value="${param.nowPage }" />
	
<table class="table table-bordered table-striped">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="password" class="form-control"
				style="width:200px;" name="pass" />
		</td>
	</tr>
</tbody>
</table>

<!-- 각종 버튼 -->
<div class="row text-center" style="padding-right:50px;">	
	<button type="submit" class="btn btn-default">
		전송하기</button>
	<button type="reset" class="btn">	
		Reset</button>
	<button type="button" class="btn btn-danger"
		onclick="location.href='../Community/CommList';">
		리스트보기</button>
</div>
</form>	
				<!-- 내용 삽입 e -->
				</div>				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
