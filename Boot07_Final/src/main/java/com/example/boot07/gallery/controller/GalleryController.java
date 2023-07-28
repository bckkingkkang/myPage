package com.example.boot07.gallery.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;

import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.boot07.gallery.service.GalleryService;

@Controller
public class GalleryController {
	
	@Autowired
	private GalleryService service;
	
	@Value("${file.location}")
	private String fileLocation;
	
	@GetMapping(value="/gallery/images/{imageName}",
			produces = {MediaType.IMAGE_JPEG_VALUE, MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE})
	@ResponseBody
	public byte[] galleryImage(@PathVariable("imageName") String imageName) throws IOException {
		String absolutePath = fileLocation + File.separator + imageName;
		
		// 파일에서 읽어들일 InputStream
		InputStream is = new FileInputStream(absolutePath);
		
		// 이미지 data(byte)를 읽어서 배열에 담아 클라이언트에게 응답
		return IOUtils.toByteArray(is);
	}
	
	// gallery 게시물의 num이 parameter get 방식으로 넘겨줌
	// detail page
	
}
