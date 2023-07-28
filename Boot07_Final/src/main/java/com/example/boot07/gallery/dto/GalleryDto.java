package com.example.boot07.gallery.dto;

import org.apache.ibatis.type.Alias;
import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

// lombok 을 이용해서 Dto 만들기
@Alias("galleryDto")
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GalleryDto {
	private int num;
	private String writer;
	private String caption;
	private String imagePath;
	private String regdate;
	private int startRowNum;
	private int endRowNum;
	// 이전 글 번호
	private int prevNum;
	// 다음 글 번호
	private int nextNum;
	// 이미지 파일 업로드 처리를 위한 필드
	private MultipartFile image;
}
