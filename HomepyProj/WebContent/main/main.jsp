<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.Vector"%>
<%@page import="java.util.List"%>
<%@page import="homepy.HomepyDAO"%>
<%@page import="java.util.Calendar"%>
<%@page import="homepyT.HomepyBoardDTO"%>
<%@page import="homepyT.HomepyMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"   %>   
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.security.SecureRandom" %>
<%@ page import="java.math.BigInteger" %>
<script src="../bootstrap3.3.7/jquery/jquery-3.1.1.js"></script>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<%

//한글처리
request.setCharacterEncoding("UTF-8");
//기존방식
HomepyBoardDTO dto = new HomepyBoardDTO();


HomepyDAO dao = new HomepyDAO();
List<HomepyBoardDTO> list = new Vector<HomepyBoardDTO>();
list = dao.selectList();


//매개변수 저장을 위한 컬렉션 생성(DAO로 전달)
Map<String,Object> param = new HashMap<String,Object>();
//문자열 검색 파라미터를 페이지 처리 메소드로
//넘겨주기 위한 변수선언
String queryStr = "";



//클라이언트(웹브라우저)에서 전송한 쿠키 읽기
Cookie[] cookies = request.getCookies();

//아이디저장 쿠키값을 저장하기 위한 변수
String user ="";

if(cookies!=null){
   for(Cookie ck : cookies){
      
      //생성된 쿠키중에 이름이 USER_ID가 있다면
      if(ck.getName().equals("USER_ID")){
         //쿠키에 저장된 사용자 아이디를 변수에 저장한다.
         user = ck.getValue();//값에 대한 설정
      }
   }
}

%>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
</style>
<script>
$(function(){
   //현재월을 출력하는 달력 로드하기
   $('#calendar_view').load('../include/Calendar.jsp');
   
   //이전달
   $('#month_prev').click(function(){
      //히든폼에 입력된 값 가져오기
      var n_year = parseInt($('#now_year').val());
      var n_month = parseInt($('#now_month').val());
      
      //1월의 이전달은 12월이므로 년도-1, 12월로 변경한다.
      if(n_month==0){
         n_year--;
         n_month=11;
      }
      else{
         n_month--;
      }
      
      //계산된 년/월을 히든폼에 입력
      $('#now_year').val(n_year);
      $('#now_month').val(n_month);
      //계산된 년/월을 캘린더 상단에 표현
      $('#calendar_n_view').html(n_year+"년"+(n_month+1)+"월");
      
      //calendar.jsp로 위값을 파라미터로 전달
      //calendar.jsp로 위 값을 파라미터로 전달
        $.get('../include/Calendar.jsp',{y : n_year, m : n_month}, function(d){
           $('#calendar_view').html(d);
        });
     });
   
   //다음달
   /* $('#month_next').click(function(){
      //히든폼에 입력된 값 가져오기
      var n_year = parseInt($('#now_year').val());
      var n_month = parseInt($('#now_month').val());
      
      //1월의 이전달은 12월이므로 년도-1, 12월로 변경한다.
      if(n_month==11){
         n_year++;
         n_month=0;
      }
      else{
         n_month++;
      }
      
      //계산된 년/월을 히든폼에 입력
      $('#now_year').val(n_year);
      $('#now_month').val(n_month);
      //계산된 년/월을 캘린더 상단에 표현
      $('#calendar_n_view').html(n_year+"년"+(n_month+1)+"월");
      
      //calendar.jsp로 위값을 파라미터로 전달
      //calendar.jsp로 위 값을 파라미터로 전달
        $.get('../include/Calendar.jsp',{y : n_year, m : n_month}, function(d){
           $('#calendar_view').html(d);
        });
     }); */
   
   $('#month_next').click(function(){
         var n_year = parseInt($('#now_year').val());
          var n_month = parseInt($('#now_month').val());
          //1월의 이전달은 12월, 년도-1, 12월로 변경한다.
          if(n_month==11){
            n_year++;
            n_month=0;
          }
          else{
            n_month++;
          }
          //계산된 년/월을 히든폼에 입력
          $('#now_year').val(n_year);
          $('#now_month').val(n_month);
          $('#calendar_n_view').html(n_year + "년 " + (n_month + 1) + '월');
         $.ajax({
            url : "../include/Calendar.jsp",
            type : "get",
            data : {
               y:n_year,
               m:n_month
            },
            <%-- ※ 만약, $.ajax()메소드에서 응답데이터의 형식을 json으로 지정하였다면 파싱을 별도로 할 필요가 없다.
               jQuery에서 파싱을 하는 이유는 응답데이터가 text형식인 경우 json형태로 바로 사용할 수 없기 때문이다.--%>
            dataType : "html",
            contentType : "text/html;charset:utf-8;",
            success : function(responseData){
               $('#calendar_view').html(responseData);
            },
            error : function(error){
               alert("안됨");
            }
         });
      });
     
   
  });
</script>
<%
Calendar nowDay = Calendar.getInstance();
int now_year = nowDay.get(Calendar.YEAR);
int now_month = nowDay.get(Calendar.MONTH);
%>
<input type="hidden" id="now_year" value="<%=now_year%>"/>
<input type="hidden" id="now_month" value="<%=now_month%>"/>

</head>
<body>
<center>
   <div id="wrap">
      <%@ include file="../include/top.jsp"%>
      
      <div id="main_visual">
      <a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
      </div>

      <div class="main_contents">
         <div class="main_con_left">
            <p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
            <div class="login_box" style="height:110px;">            
<!-- 로그인폼 -->   
<%
//세션영역에 회원정보가 없다면...로그인 전 화면 출력
if(session.getAttribute("USER_ID")==null)
{
%>
<script>

   
   function loginValidate(fn){
      if(fn.id.value==""){
         alert("아이디를 입력하세요");
         fn.id.focus();
         return false;
      }
      if(fn.pass.value==""){
         alert("패스워드를 입력하세요");
         fn.pass.focus();
         return false;
      }
      
   }

</script>

<form action="../member/login_process.jsp" method="post" 
   name="loginFrm" onsubmit="return loginValidate(this);">
<%-- <input type="hid-den" name="backUrl" value="${param.backUrl }"/> --%>               
<table cellpadding="0" cellspacing="0" border="0">
   <colgroup>
      <col width="45px" />
      <col width="120px" />
      <col width="55px" />
   </colgroup>
   <tr>
      <th><img src="../images/login_tit01.gif" alt="아이디" /></th>
      <td>
<input type="text" name="id" tabindex="1" class="login_input" value="<%= user==null ? "" : user %>" /></td>
      <td rowspan="2">
<input type="image"  tabindex="3" src="../images/login_btn01.gif" alt="로그인" /></td>
   </tr>
   <tr>
      <th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
      <td>
<input type="password" name="pass" tabindex="2" value="" class="login_input" /></td>
   </tr>
</table>


<p>
   <input type="checkbox" name="id_save" value="Y" <%if(user.length()!=0){ %> checked="checked" <% } %>    />
      <img src="../images/login_tit03.gif" alt="저장" /> 
   <a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
   <a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
</p>


</form>
 
<% }else{ %>

<!-- 로그인 후 -->
<p style="padding:10px 0px 10px 10px">
<span style="font-weight:bold; color:#333;">
${USER_NAME }님,</span> 반갑습니다.
<br />로그인 하셨습니다.
</p>
<p style="text-align:right; padding-right:10px;">
   <a href="../member/modify_t.jsp">
      <img src="../images/login_btn04.gif" /></a>
   <a href="../member/logout.jsp">
      <img src="../images/login_btn05.gif" /></a>
</p>

<% } %>
          
            </div>
         </div>
         <div class="main_con_center">
            <p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="/space/sub01_list.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
            <ul class="main_board_list">
               <!-- 공지사항 시작 -->
               
               <% for(HomepyBoardDTO a : list){ %>
                  <li>
                  <a href="../space/sub01_t_view.jsp?num=<%=a.getNum()%>"><%=a.getTitle()%></a>
                  <span><%=a.getPostDate( ) %></span>
                  </li>
               <% } %>
               </ul>
                     <!-- 공지사항 끝 -->
            </ul>
         </div>
         <div class="main_con_right">
            <p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="/space/sub03.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
            <ul class="main_board_list">
               <li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
               <li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
               <li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
               <li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
            </ul>
         </div>
      </div>

      <div class="main_contents">
         <div class="main_con_left">
            <p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
            <img src="../images/main_tel.gif" />
         </div>
         <div class="main_con_center">
            <p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
            <div class="cal_top">
               <table cellpadding="0" cellspacing="0" border="0">
                  <colgroup>
                     <col width="13px;" />
                     <col width="*" />
                     <col width="13px;" />
                  </colgroup>
                  <tr>
                     <td><img src="../images/cal_a01.gif" style="margin-top:3px;cursor:pointer;" id="month_prev" /></td>
                     <td style="font-weight:bold;font-size:14px;" id="calendar_n_view"><%=now_year %>년<%=(now_month+1) %>월</td>
                     <td><img src="../images/cal_a02.gif" style="margin-top:3px;cursor:pointer;" id="month_next" /></td>
                  </tr>
               </table>
            </div>

            
            <div class="cal_bottom" id="calendar_view">
            
               <%-- <table cellpadding="0" cellspacing="0" border="0" class="calendar">
                  <colgroup>
                     <col width="14%" />
                     <col width="14%" />
                     <col width="14%" />
                     <col width="14%" />
                     <col width="14%" />
                     <col width="14%" />
                     <col width="*" />
                  </colgroup>
                  <tr>
                     <th><img src="../images/day01.gif" alt="S" /></th>
                     <th><img src="../images/day02.gif" alt="M" /></th>
                     <th><img src="../images/day03.gif" alt="T" /></th>
                     <th><img src="../images/day04.gif" alt="W" /></th>
                     <th><img src="../images/day05.gif" alt="T" /></th>
                     <th><img src="../images/day06.gif" alt="F" /></th>
                     <th><img src="../images/day07.gif" alt="S" /></th>
                  </tr>
                  <tr>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">1</a></td>
                     <td><a href="">2</a></td>
                     <td><a href="">3</a></td>
                  </tr>
                  <tr>
                     <td><a href="">4</a></td>
                     <td><a href="">5</a></td>
                     <td><a href="">6</a></td>
                     <td><a href="">7</a></td>
                     <td><a href="">8</a></td>
                     <td><a href="">9</a></td>
                     <td><a href="">10</a></td>
                  </tr>
                  <tr>
                     <td><a href="">11</a></td>
                     <td><a href="">12</a></td>
                     <td><a href="">13</a></td>
                     <td><a href="">14</a></td>
                     <td><a href="">15</a></td>
                     <td><a href="">16</a></td>
                     <td><a href="">17</a></td>
                  </tr>
                  <tr>
                     <td><a href="">18</a></td>
                     <td><a href="">19</a></td>
                     <td><a href="">20</a></td>
                     <td><a href="">21</a></td>
                     <td><a href="">22</a></td>
                     <td><a href="">23</a></td>
                     <td><a href="">24</a></td>
                  </tr>
                  <tr>
                     <td><a href="">25</a></td>
                     <td><a href="">26</a></td>
                     <td><a href="">27</a></td>
                     <td><a href="">28</a></td>
                     <td><a href="">29</a></td>
                     <td><a href="">30</a></td>
                     <td><a href="">31</a></td>
                  </tr>
                  <tr>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                     <td><a href="">&nbsp;</a></td>
                  </tr>
               </table> --%>
               
            </div>
         </div>
         <div class="main_con_right">
            <p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="/space/sub04.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
            <ul class="main_photo_list">
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
               <li>
                  <dl>
                     <dt><a href=""><img src="../images/g_img.gif" /></a></dt>
                     <dd><a href="">마포 구립 장애인...</a></dd>
                  </dl>
               </li>
            </ul>
         </div>
      </div>
      <%@ include file="../include/quick.jsp"%>
   </div>

   <%@ include file="../include/footer.jsp"%>
   
</center>
</body>
</html>