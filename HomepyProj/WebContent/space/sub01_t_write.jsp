<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/login_check.jsp" %>
<%@ include file="../include/global_head.jsp" %>
<%
//글쓰기 - 멀티 게시판 구형[추가]

String b_flag = request.getParameter("b_flag")==null
   ? "notice" : request.getParameter("b_flag");

%>
<%@ include file="common_space.jsp" %> 
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
               <img src="../images/space/<%=title_image %>" alt="공지사항" class="con_title" />
               <p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;<%=path_str %></p>
            </div>
            <div>

<script>
   function isValidate(fn){
      if(fn.title.value==""){
         alert("제목을 입력해주세요");
         fn.title.focus();
         return false;
      }
      if(fn.content.value==""){
         alert("내용을 입력해주세요");
         fn.content.focus();
         return false;
      }
   }
</script>
<form name="writeFrm" method="post" 
   action="write_proc.jsp" 
   onsubmit="return isValidate(this);">
   
<input type="hid den" name="b_flag" value="<%=b_flag%>"/>
   
<table class="table table-bordered">
<colgroup>
   <col width="20%"/>
   <col width="*"/>
</colgroup>
<tbody>
   <tr>
      <th class="text-center" 
         style="vertical-align:middle;">작성자</th>
      <td>
         <input type="text" class="form-control" 
            style="width:100px;" value="${USER_ID }" 
            disabled />
      </td>
   </tr>
   <tr>
      <th class="text-center" 
         style="vertical-align:middle;">이메일</th>
      <td>
         <input type="text" class="form-control" 
            style="width:400px;" value="${USER_EMAIL }" 
            disabled />
      </td>
   </tr>   
   <tr>
      <th class="text-center" 
         style="vertical-align:middle;">제목</th>
      <td>
         <input type="text" class="form-control" 
            name="title" />
      </td>
   </tr>
   <tr>
      <th class="text-center" 
         style="vertical-align:middle;">내용</th>
      <td>
         <textarea rows="10" class="form-control"
            name="content"></textarea>
      </td>
   </tr>
   <tr>
      <th class="text-center" 
         style="vertical-align:middle;">첨부파일</th>
      <td>
         <input type="file" class="form-control" />
      </td>
   </tr>
</tbody>
</table>

<div class="row text-center" style="">
   <!-- 각종 버튼 부분 -->
   
   <button type="submit" class="btn btn-danger">전송하기</button>
   <button type="reset" class="btn">Reset</button>
   <button type="button" class="btn btn-warning" 
      onclick="location.href='sub01_t_list.jsp';">
      리스트보기</button>
</div>
</form>

            </div>
         </div>
      </div>
      <%@ include file="../include/quick.jsp" %>
   </div>


   <%@ include file="../include/footer.jsp" %>
   </center>
 </body>
</html>