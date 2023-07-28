package com.example.boot07.gallery.dao;

import java.util.List;

import com.example.boot07.gallery.dto.GalleryDto;

public interface GalleryDao {
	// gallery 리스트 가져오기
	public List<GalleryDto> getList(GalleryDto dto);
	// 모든 Row 갯수
	public int getCount();
	// gallery 사진 저장하기
	public void insert(GalleryDto dto);
	// pk num에 해당하는 DB에서 gallery 게시글 하나의 data 가져오기
	public GalleryDto getData(int num);
}
