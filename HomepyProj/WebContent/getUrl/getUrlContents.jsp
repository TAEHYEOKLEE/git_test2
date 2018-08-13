<%@page import="java.io.BufferedReader"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.net.URL"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>웹크롤링</title>
<link rel="stylesheet" href="../common/bootstrap3.3.7/css/bootstrap.min.css"/>
<script src="../common/bootstrap3.3.7/jquery/jquery-3.2.1.min.js"></script>
</head>
<body>
	<h2>KBO기록실에서 데이터 가져오기</h2>
<%
//크롤링 할 URL 입력
URL url = new URL("https://www.koreabaseball.com/Record/Player/HitterBasic/Basic1.aspx");



//입력스트림 생성
InputStreamReader reader = new InputStreamReader(url.openStream());
BufferedReader br = new BufferedReader(reader);
String inLine = null;
StringBuffer contents = new StringBuffer();

//URL을 통해 가져온 내용을 라인단위로 읽기
while((inLine=br.readLine()) != null)
{
	contents.append(inLine);
	
}

//모든 내용을 읽어들인후 스트림 소멸
br.close();


//내용 출력
//out.println(contents);


//선수 테이블 가져오기
String[] halfArr = contents.toString().split("<div class=\"record_result\">");
halfArr = halfArr[1].split("<tbody>");
halfArr = halfArr[1].split("</tbody>");
//전체내용에서 선수테이블만 가져와서 출력하기
//out.println(halfArr[0]);

//각 선수별로 잘라내기
String playerTable = halfArr[0];
String data = "";
String[] tmpArr = null;

String[] playerArr = playerTable.split("playerId=");
for(int i=1 ; i<playerArr.length ; i++)
{
	//선수별 loop
	
	//탭(tab) 제거하기
	playerArr[i] = playerArr[i].replace("	","");
	tmpArr = playerArr[i].split("</td>");
	
	
	String b0 = tmpArr[0];
	String[] b0Arr = b0.split("\">");
	String data1 = b0Arr[0];
	String data2 = b0Arr[1].replace("</a>","");
	out.println("선수id값:"+ data1 +"<br/>");
	out.println("이름:"+ data2 + "<br/>");
	
	
	String b1 = tmpArr[1];
    String data3 = b1.replace("<td>",""); out.print(data3+"-");
          
    String b2 = tmpArr[2];
    String data4 = b2.replace("<td data-id=\"HRA_RT\">",""); out.print(data4+"-");
          
    String b3 = tmpArr[3];
    String data5 = b3.replace("<td data-id=\"GAME_CN\">",""); out.print(data5+"-");
    
    String b4 = tmpArr[4];
    String data6 = b4.replace("<td data-id=\"PA_CN\">",""); out.print(data6+"-");
    
    String b5 = tmpArr[5];
    String data7 = b5.replace("<td data-id=\"AB_CN\">",""); out.print(data7+"-");
    
    String b6 = tmpArr[6];
    String data8 = b6.replace("<td data-id=\"RUN_CN\">",""); out.print(data8+"-");
    
    String b7 = tmpArr[7];
    String data9 = b7.replace("<td data-id=\"HIT_CN\">",""); out.print(data9+"-");
    
    String b8 = tmpArr[8];
    String data10= b8.replace("<td data-id=\"H2_CN\">",""); out.print(data10+"-");
    
    String b9 = tmpArr[9];
    String data11= b9.replace("<td data-id=\"H3_CN\">",""); out.print(data11+"-");
    
    String b10= tmpArr[10];
    String data12= b10.replace("<td data-id=\"HR_CN\">",""); out.print(data12+"-");
    
    String b11= tmpArr[11];
    String data13= b11.replace("<td data-id=\"TB_CN\">",""); out.print(data13+"-");
    
    String b12= tmpArr[12];
    String data14= b12.replace("<td data-id=\"RBI_CN\">",""); out.print(data14+"-");
    
    String b13= tmpArr[13];
    String data15= b13.replace("<td data-id=\"SH_CN\">",""); out.print(data15+"-");
    
    String b14= tmpArr[14];
    String data16= b14.replace("<td data-id=\"SF_CN\">",""); out.print(data16+"-");
    
    out.println("<br/>");
}

	













%>


















</body>
</html>