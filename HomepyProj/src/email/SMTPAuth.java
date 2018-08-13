package email;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

/*
SMTP
-Simple Mail Transfer Protocol
-일반적으로 전자메일 전송을 위한 표준 프로토콜
-이메일을 송수신하는 서버를 SMTP서버라 한다.
흔히 메일서버 라고 부르기도 한다.

해당 클래스는 사용할 SMTP서버에 인증을 받기 위한 용도로 제작된다.
우리는 메일서버가 없으므로 NAVER에서 제공하는 SMTP를 사용하도록 한다.
*/

public class SMTPAuth extends Authenticator {

	@Override
	protected PasswordAuthentication getPasswordAuthentication() {
		//네이버 아이디/패스워드 정확히 입력
		return new PasswordAuthentication("yoz09@naver.com", "ghkdtp3773");
		
	}

	
}
