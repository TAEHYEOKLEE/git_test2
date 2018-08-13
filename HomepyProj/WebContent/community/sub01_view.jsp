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
				<!-- 내용이 들어가는 부분s -->
<table class="table table-bordered table-striped">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>${dto.name }</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>${dto.postdate }</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">다운로드수</th>
		<td>${dto.downcount }</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>${dto.visitcount }</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			${dto.title }
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">내용</th>
		<td colspan="3" style="height:150px;">
			${dto.content }
		</td>
	</tr>
	<tr>
		<th class="text-center"
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
<!-- 첨부파일이 있을때만 화면 보임 -->		
<c:if test="${not empty dto.attachedfile }">
	${dto.attachedfile }
	&nbsp;
	<a href="Download?filename=${dto.attachedfile }
				&idx=${dto.idx }">
		<span class="glyphicon glyphicon-paperclip"></span>
	</a>
</c:if>
		</td>
	</tr>
</tbody>
</table>

<!-- 각종 버튼 -->
<div class="row text-center" style="padding-right:50px;">
	<button type="button" class="btn btn-success"
onclick="location.href='./CommPassword?idx=${param.idx}&mode=edit&nowPage=${param.nowPage }';">
		수정하기</button>

	<button type="button" class="btn btn-info"
onclick="location.href='../Community/CommPassword?idx=${dto.idx}&mode=delete&nowPage=${param.nowPage }';">
		삭제하기</button>

	<button type="button" class="btn btn-warning"
onclick="location.href='../Community/CommReply?idx=${dto.idx}&nowPage=${param.nowPage }';">
		답글쓰기</button>
		
	<button type="button" class="btn btn-danger"
onclick="location.href='./CommList?nowPage=${param.nowPage}';">
		리스트보기</button>
</div>		
				<!-- 내용이 들어가는 부분e -->
				</div>				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
