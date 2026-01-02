package com.edu.springboot.emoji;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface IEmojiService {
	
	// 상점 이모지 목록 
	public List<StoreDTO> listStore();
	
	// 보유한 이모지 목록 
	public List<EmojiDTO> listMyEmoji(String user_ref);
	
	// 회원의 활성화된 이모지 정보 업데이트
	public int updateEmoji(String id, String emoji);
	
	// 회원 이모지 구매
	public int buyEmoji(EmojiDTO emojiDTO);
}