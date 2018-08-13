<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				
				
				
				

<!-- 검색 -->
<div class="row text-right" style="margin-bottom:20px;
	padding-right:50px;">
<form class="form-inline">
	<div class="form-group">
		<select name="" class="form-control">
			<option value="">제목</option>
			<option value="">내용</option>
			<option value="">제목+내용</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="" class="form-control" />
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
<div class="row text-center">		 
<% for(int i=1 ; i<=10 ; i++){ %>	
	<div class="col-md-3">
		<div class="thumbnail">
			<a href="#">
				<img src="../images/product/pro_img01.jpg" alt="겔러리이미지" width="100%">
				<div class="caption">
					<p>게시물제목</p>
				</div>
			</a>
		</div>
	</div>
<% } %>
</div> 

<!-- 각종 버튼 -->
<div class="row text-right" style="padding-right:50px;">
	<button type="button" class="btn btn-primary"
		onclick="location.href='WriteSkin.jsp';">
		글쓰기</button>
	<!-- <button type="button" class="btn btn-success">
		수정하기</button>
	<button type="button" class="btn btn-info">
		삭제하기</button>
	<button type="button" class="btn btn-warning">
		답글쓰기</button>
	<button type="button" class="btn btn-danger">
		리스트보기</button>
	<button type="button" class="btn btn-default">
		전송하기</button>
	<button type="button" class="btn">
		Reset</button> -->
</div>

<!-- 페이지번호 -->
<div class="row text-center">
	<ul class="pagination">
		<li><span class="glyphicon 
			glyphicon-fast-backward"></span></li>
		
		<li class="active"><a href="#">1</a></li>
		<li><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>
		<li><a href="#">5</a></li>
		
		<li><span class="glyphicon 
			glyphicon-fast-forward"></span></li>
	</ul>
</div>


			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
