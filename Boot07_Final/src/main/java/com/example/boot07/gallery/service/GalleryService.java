package com.example.boot07.gallery.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.servlet.ModelAndView;

import com.example.boot07.gallery.dto.GalleryDto;

public interface GalleryService {
	// gallery list
	public void getList(HttpServletRequest request);
	// 갤러리에 사진 upload, DB 저장
	public void saveImage(GalleryDto dto, HttpServletRequest request);
	
	// gallery detail page > data > ModelAndView
	public void getDetail(ModelAndView mView, int num);
}
