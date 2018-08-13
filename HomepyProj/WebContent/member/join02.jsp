<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
	//중복확인을 거친후 회원가입 가능
	if(document.getElementById("id_overlap_check").value==0){
		alert("ID 중복확인후 회원가입을 진행해주세요.");
		return false;
	}
	
	
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
				
				<form name="memberFrm" action="join02_t_process.jsp" method="post" onsubmit="return mValidate(this);">
				<input type="hid den" id="id_overlap_check" value="1"/>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					
<script>
$(function(){
	$('#idOverlap').click(function(){
		
		//빈값체크
		if(document.getElementById("userid").value==""){
			alert("아이디 입력후 중복확인 하세요");
			document.getElementById("userid").focus();
			return;
		}
		
		//alert
		$.ajax({
			url : "../member/id_overlap.jsp",
			type : "post",
			//전송방식이 post일때 사용하는 컨텐츠타입
			contentType : "application/x-www-form-urlencoded;charset=UTF-8",
			//전송할파라미터(반드시 JSON형식)
			data : {
				userid : $('#userid').val()
			},
			/*
			응답데이터를 json으로 받는 경우에는 순수한 json데이터만
			있어야 오류가 발생하지 않는다. 반드시 디버깅을 위한 문자열 출력
			부분을 제거해야 함을 명심하자.
			*/
			dataType : "text",
			success:function(d){
				//alert(d);
				if(d.idResult==1){
					//가입가능
					$('#id_overlap_check').val(1);
				}
				else{
					//가입불가능
					$('#id_overlap_check').val(0);
				}
				$('#idOverMsg').html(d.Msg);
			},
			error:function(errorData){
				alert("오류발생:"+errorData.status+":"+errorData.statusText);
			}
		});

	});
	
});

</script>					
					
					<tr>
						<th>
							<img src="../images/join_tit002.gif" />
						</th>
						<td>
							<input type="text" name="id" id="userid" value="" class="join_input" />&nbsp;
							<img src="../images/btn_idcheck.gif" alt="중복확인" id="idOverlap" style="cursor:pointer;"/>
							&nbsp;&nbsp;
							<span id="idOverMsg">* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span>
						</td>
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
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" /></td>
					</tr>

					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td> 
<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
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
						<input type="text" name="zipcode" value=""  class="join_input" style="width:100px;" />
						
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();" onkeypress="">[우편번호검색]</a>
						<br/>
						<!-- 주소 -->
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
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
