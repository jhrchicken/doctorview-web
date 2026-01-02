package com.edu.springboot.chat;

import java.util.HashMap;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import jakarta.servlet.http.HttpSession;

@RestController
@RequestMapping("/api")
public class ChatController {

    // 사용자 정보와 채팅방 정보를 제공하는 API
    @GetMapping("/chat-info")
    public ResponseEntity<Map<String, String>> getChatInfo(HttpSession session) {
        Map<String, String> chatInfo = new HashMap<>();

        // 실제 비즈니스 로직에 따라 사용자와 채팅방 정보를 가져옴
        String id = (String) session.getAttribute("userId");
        // 여기 이름 추가하기 (닉네임)
        
        String username = id;
        String chatroom = id + "-";

        chatInfo.put("username", username);
        chatInfo.put("chatroom", chatroom);

        // JSON 형태로 리액트에 응답
        return ResponseEntity.ok(chatInfo);
    }
}