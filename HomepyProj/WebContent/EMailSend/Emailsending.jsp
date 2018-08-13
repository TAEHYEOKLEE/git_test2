<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="clean.OrderDTO"%>
<%@page import="email.SMTPAuth"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="javax.mail.Transport"%>
<%@page import="javax.mail.Session"%>
<%@page import="javax.mail.Message"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.Address"%>
<%@page import="javax.mail.Authenticator"%>
<%@page import="java.util.Properties"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>email_sending.jsp</title>
</head>
<body>

<%

OrderDTO dto = (OrderDTO)request.getAttribute("DTO");
String from = "yoz09@naver.com";
String to = "npnorladb@gmail.com";
String subject = "[KOSMO]고객님이 문의하신 비밀번호입니다.";//request.getParameter("subject");
String content = "";//request.getParameter("content");
 
/*
메일폼 파일의 내용을 읽어서 변수에 저장후 메일에 발송한다.
JAVA IO를 이용하면 html파일의 내용을 쉽게 읽을 수 있다.
*/
String dirPath="";//메일폼이 있는 디렉토리
String filePath="";//메일폼 파일명
String sLine = "";//html문서를 한줄씩 읽을때 사용
try {
	  //서버의 물리적인 경로 가져오기
	  dirPath = application.getRealPath("/EMailSend/");
	  //물리적경로 + 파일명 => 파일의 실제경로
	  filePath = dirPath + "MailForm.html";
	  
	  //파일읽기
	  FileReader fr = new FileReader(filePath);
	  BufferedReader br = new BufferedReader(fr);
	  
	  while((sLine=br.readLine())!=null)
	  {
		  //더이상 읽을 내용이 없을때까지 반복
		  content += sLine + "\n";
	  }
}
catch(Exception e){
	  e.printStackTrace();
	  
}

//html문서내의 __XX__부분 문자열 변경
content = content.replace("__name__", "홍길동");
content = content.replace("__id__", "hong");
content = content.replace("__pass__", "9876");



Properties p = new Properties(); // 정보를 담을 객체
 
// SMTP 서버에 접속하기 위한 정보들
p.put("mail.smtp.host","smtp.naver.com"); // 네이버 SMTP	 
p.put("mail.smtp.port", "465");
p.put("mail.smtp.starttls.enable", "true");
p.put("mail.smtp.auth", "true");
p.put("mail.smtp.debug", "true");
p.put("mail.smtp.socketFactory.port", "465");
p.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
p.put("mail.smtp.socketFactory.fallback", "false");

  
try{
    Authenticator auth = new SMTPAuth();
    Session ses = Session.getInstance(p, auth);
     
    ses.setDebug(true);
     
    MimeMessage msg = new MimeMessage(ses); // 메일의 내용을 담을 객체
    msg.setSubject(subject); // 제목
     
    Address fromAddr = new InternetAddress(from);
    msg.setFrom(fromAddr); // 보내는 사람
     
    Address toAddr = new InternetAddress(to);
    msg.addRecipient(Message.RecipientType.TO, toAddr); // 받는 사람
     
    //블루클리닝 내용 DTO에서 받아온 정보들
    msg.setText(content = "고객명:"+dto.getName()+"\r\n"+"주소:"+dto.getAddr()+"\r\n"+ "연락처:"+dto.getContactnum()+"\r\n"+ "휴대전화:"+dto.getCellnum()+"\r\n"+ "이메일:"+dto.getEmail()+"\r\n"+"청소종류:"+dto.getCleantype()+"\r\n"+
            "평수:"+dto.getCleansize()+"\r\n"+
            "희망날짜:"+dto.getCleandate()+"\r\n"+
            "구분:"+dto.getBook()+"\r\n"+
            "특이사항:"+dto.getEtc()+"\r\n"); // 내용과 인코딩 // 내용과 인코딩
     
    Transport.send(msg);  // 전송
} 
catch(Exception e){
    e.printStackTrace();
    out.println("<script>alert('메일전송에 실패했습니다.ㅜㅜ;');history.back();</script>");	    
    return;
}

// 성공 시 
JavascriptUtil.jsAlertLocation("고객님의 메일로 전송했습니다.", "../main/main.jsp", out); 

%>



</body>
</html>