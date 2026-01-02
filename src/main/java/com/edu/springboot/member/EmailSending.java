package com.edu.springboot.member;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;

import jakarta.mail.internet.MimeMessage;
import lombok.RequiredArgsConstructor;


@Component
@RequiredArgsConstructor
public class EmailSending {

	private final JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String from;
	
	public void myEmailSender(InfoDTO infoDTO) {
		try {
			// 메일을 보내기 위한 설정을 담당
			MimeMessage m = mailSender.createMimeMessage();
			// 인코딩 설정
			MimeMessageHelper h = new MimeMessageHelper(m, "UTF-8");
			// 보내는 사람
			h.setFrom(from);
			// 받는 사람
			h.setTo(infoDTO.getTo());
			// 메일 제목
			h.setSubject(infoDTO.getSubject());
			// 이메일 발송시의 형식
			if(infoDTO.getFormat().equals("text")) {
				h.setText(infoDTO.getContent());
			}
			
			// 메일 발송
			mailSender.send(m);
			System.out.println("메일 전송 완료..!!");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
}
