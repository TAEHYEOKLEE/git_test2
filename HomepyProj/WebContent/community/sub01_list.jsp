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
				<!-- 내용이 나오는 부분s -->
				<!-- Contents영역 시작-->		
<!-- 검색 -->
<div class="row text-right" style="margin-bottom:20px;
	padding-right:50px;">
<form class="form-inline">
	<div class="form-group">
		<select name="searchColumn" class="form-control">
			<option value="title">제목</option>
			<option value="content">내용</option>
			<option value="name">작성자</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord" class="form-control" />
		<div class="input-group-btn">
			<button type="submit" class="btn btn-info">
				<i class="glyphicon glyphicon-search">
				</i>
			</button>
		</div>				
	</div>
</form>	
</div>

<!-- 게시판 리스트  -->
<!-- table>tr*2>td*6 -->
<table class="table table-bordered table-hover">
<colgroup>
	<col width="80px" />
	<col width="*" />
	<col width="120px" />
	<col width="120px" />
	<col width="80px" />
	<col width="50px" />
</colgroup>
<thead>
	<tr>
		<th class="text-center">번호</th>
		<th class="text-center">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
</thead>
<tbody>
<c:choose>
	<c:when test="${empty lists }">
		<!-- 등록된 게시물이 없을때... -->
		<tr>
			<td colspan="6">
				등록된 글 없씸 ㅜㅜ;
			</td>
		</tr>
	</c:when>
	<c:otherwise>
		<!-- 등록된 글이 있을때 반복하면서 리스트 출력 -->
		<c:forEach items="${lists }" var="row"
			varStatus="loop">
			<tr>
				<td class="text-center">
					${map.totalCount - (((map.nowPage-1) * map.pageSize) + loop.index) }				         
				</td>
				<td class="text-left">
					<a href="../Community/CommView?idx=${row.idx }&nowPage=${param.nowPage }">
						${row.title }
					</a>					
				</td>
				<td class="text-center">${row.name }</td>
				<td class="text-center">${row.postdate }</td>
				<td class="text-center">${row.visitcount }</td>
				<td class="text-center">
					<!-- 첨부파일이 있을때만 글립콘 표시 -->				
					<c:if test="${not empty row.attachedfile }">
						<span class="glyphicon glyphicon-paperclip"></span>					
					</c:if>
				</td>
			</tr>
		</c:forEach>		
	</c:otherwise>	
</c:choose>
</table>

<!-- 각종 버튼 -->
<div class="row text-right" style="padding-right:50px;">
	<button type="button" class="btn btn-primary"
		onclick="location.href='../Community/CommWrite';">
		글쓰기</button>
</div>

<!-- 페이지번호 -->
<div class="row text-center">
	<ul class="pagination">
		${pagingImg }
	</ul>
</div>
				<!-- Contents영역 끝-->
				<!-- 내용이 나오는 부분e -->
				</div>			
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
