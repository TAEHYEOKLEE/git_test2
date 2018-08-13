<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp"%>


<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/member/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">
					<%@ include file="../include/member_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/member/id_pw_title.gif" alt=""
							class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기
						<p>
					</div>
					<div class="idpw_box">
						<div class="id_box">
							<form action="id_searchCtl.jsp" name="idcheck" method="post">
								<ul>
									<li><input type="text" name="name" value="이도훈" class="login_input01" /></li>
									<li><input type="text" name="email" value="yoz09@naver.com" class="login_input01" /></li>
								</ul>
								<button>
									<img src="../images/member/id_btn01.gif" class="id_btn" onClick="id_search2()" />
								</button>
								<a href="../member/join01.jsp"><img
									src="../images/login_btn03.gif" class="id_btn02" /></a>
							</form>
							<a href=""><img src="../images/login_btn03.gif"
								class="id_btn02" onClick="id_searchCtl.jsp" /></a>
						</div>


						<div class="pw_box">
							<form action="id_searchCtl2.jsp" name="pw_box">
							<input type="hid den" name="mode" value="pw_find" />
								<ul>
									<li><input type="text" name="id" value="npnorladb"
										class="login_input01" /></li>
									<li><input type="text" name="name" value="이도훈"
										class="login_input01" /></li>
									<li><input type="text" name="email" value="yoz09@naver.com"
										class="login_input01" /></li>
								</ul>
								<button>
									<img src="../images/member/id_btn01.gif" class="pw_btn"
										onClick="id_searchCtl2.jsp" />
								</button>
							</form>
						</div>
					</div>



				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
