<%@page import="homepyT.HomepyMemberDTO"%>
<%@page import="homepyT.HomepyDAO"%>
<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" 
	uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/login_check.jsp" %>
<%
//기존의 회원정보 가져오기
HomepyDAO dao = new HomepyDAO();
//세션영역에 저장된 회원 아이디를 가져온다.
String user_id = 
	session.getAttribute("USER_ID").toString();
//dao에 정의한 getMemberInfo 메소드를 호출한다.
HomepyMemberDTO dto = dao.getMemberInfo(user_id);

/*
 JSP에서 선언한 변수를 EL에서 쓰기 위해서는 JSTL의
set태그를 이용하여 변수로 재선언해야 한다. 
 이유는 JSP에서 선언한 변수는 영역에 저장되지 않기 때문
이다. 
 즉 EL에서 사용하는 변수들은 모두 영역(page, request등)에
저장된 속성들을 가져다 쓰는 것이다.
 아래 page영역에 속성을 저장하는 코드와 JSTL의 set코드는
같은 의미이다.
*/
//페이지영역에 dto객체 저장
pageContext.setAttribute("dto", dto);

//전화번호,핸드폰번호,이메일
String[] telArr = dto.getTel().split("-");
String[] mobileArr = dto.getMobile().split("-");
String[] emailArr = dto.getEmail().split("@");
%>
<%-- JSTL의 set태그를 이용하여 dto객체 변수생성 --%>
<%-- 
	<c:set var="dto" value="<%=dto %>" scope="page" />
--%>

<%@ include file="../include/global_head.jsp" %>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
function zipcodeFind(){
    new daum.Postcode({
        oncomplete: function(data) {
            var fn = document.memberFrm;
            fn.zipcode.value = data.zonecode;//우편번호
            fn.addr1.value = data.address;//기본주소
            fn.addr2.focus();//상세주소로 포커스 이동
        }
    }).open();
}

function mValidate(fn){
	//아이디검증
	if(fn.id.value==""){
		alert("아이디를 입력해주세요");
		fn.id.focus();
		return false;
	}
	if(fn.name.value==""){
		alert("이름을 입력해주세요");
		fn.name.focus();
		return false;
	}
	
	var frmArray = ["pass","pass2","tel1","tel2","tel3"];
	var txtArray = ["패스워드","패스워드확인","전화번호1"
					,"전화번호2","전화번호3"];
	for(var i=0 ; i<frmArray.length ; i++)
	{
		if(
			eval("fn."+ frmArray[i] +".type")=="text" ||
			eval("fn."+ frmArray[i] +".type")=="password"
		)
		{			
			if(eval("fn."+ frmArray[i] +".value")=="")
			{
				alert(txtArray[i] +"을(를) 입력하세요");
				eval("fn."+ frmArray[i] +".focus()");
				return false;
			}			
		}		
	}
	
}

function email_input(em, frm){
	//선택한 select의 값이 빈값이 아닐때만 동작
	if(em.value!=""){
		if(em.value=="1"){
			//직접입력 선택한 경우
			//readonly속성 해제
			frm.email_2.readOnly = false;
			//도메인부분 비워주기
			frm.email_2.value = "";
		}
		else{
			//도메인을 선택한 경우
			//선택한 도메인을 입력한다.
			frm.email_2.value = em.value;
			//readonly속성을 활성화한다.
			frm.email_2.readOnly = true;
		}
	}
}
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				
				<form name="memberFrm" 
					action="modify_t_process.jsp" 
					method="post" 
					onsubmit="return mValidate(this);">
				
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td>
						<!-- 이름 -->
						<input type="text" name="name" 
							value="${dto.name }" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="id"  value="${dto.id }" readonly class="join_input" />
						&nbsp;&nbsp;
						<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" /></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="<%=telArr[0] %>" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="<%=telArr[1] %>" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="<%=telArr[2] %>" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="<%=mobileArr[0] %>" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="<%=mobileArr[1] %>" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="<%=mobileArr[2] %>" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>

					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td> 
<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="<%=emailArr[0] %>" /> @ 
<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="<%=emailArr[1] %>" readonly />
<select name="last_email_check2" onChange="email_input(this,this.form);" class="pass" id="last_email_check2" >
	<option selected="" value="">선택해주세요</option>
	<option value="1" >직접입력</option>
	<option value="dreamwiz.com" >dreamwiz.com</option>
	<option value="empal.com" >empal.com</option>
	<option value="empas.com" >empas.com</option>
	<option value="freechal.com" >freechal.com</option>
	<option value="hanafos.com" >hanafos.com</option>
	<option value="hanmail.net" >hanmail.net</option>
	<option value="hotmail.com" >hotmail.com</option>
	<option value="intizen.com" >intizen.com</option>
	<option value="korea.com" >korea.com</option>
	<option value="kornet.net" >kornet.net</option>
	<option value="msn.co.kr" >msn.co.kr</option>
	<option value="nate.com" >nate.com</option>
	<option value="naver.com" >naver.com</option>
	<option value="netian.com" >netian.com</option>
	<option value="orgio.co.kr" >orgio.co.kr</option>
	<option value="paran.com" >paran.com</option>
	<option value="sayclub.com" >sayclub.com</option>
	<option value="yahoo.co.kr" >yahoo.co.kr</option>
	<option value="yahoo.com" >yahoo.com</option>
</select>
	 
						<input type="checkbox" name="open_email" value="1">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<!-- 우편번호 -->
						<input type="text" name="zipcode" value="${dto.zipcode }"  class="join_input" style="width:100px;" />
						
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();" onkeypress="">[우편번호검색]</a>
						<br/>
						<!-- 주소 -->
						<input type="text" name="addr1" value="${dto.addr1 }"  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value="${dto.addr2 }"  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>

				<p style="text-align:center; margin-bottom:20px">
					<input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;
					<a href="#"><img src="../images/btn02.gif" /></a>
				</p>
				
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
