package com.example.boot07.gallery.service;

import java.io.File;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.boot07.gallery.dao.GalleryDao;
import com.example.boot07.gallery.dto.GalleryDto;

@Service
public class GalleryServiceImpl implements GalleryService{

	@Autowired
	private GalleryDao dao;
	
	// 파일 저장로
	@Value("${file.location")
	private String fileLocation;
	
	@Override
	public void getList(HttpServletRequest request) {
		// 한 페이지에 표시될 글
		final int PAGE_ROW_COUNT = 8;
		// 하단 페이지에 표시
		final int PAGE_DISPLAY_COUNT = 5;
		
		// 보여줄 페이지의 번호를 1로 초기값 지정
		int pageNum = 1;
		// 페이지 번호가 파라미터로 전달되는지
		String strPageNum = request.getParameter("pageNum");
		// 페이지 번호가 파라미터로 넘어오는 경우
		if(strPageNum != null) {
			// 숫자로 변환 > 보여줄 페이지 번호로 지정
			pageNum = Integer.parseInt(strPageNum);
		}
		
		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 끝  ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;
		
		// startRowNum, endRowNum > GalleryDto 객체에 담기
		GalleryDto dto = new GalleryDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);
		
		// GalleryDao 객체를 이용해서 회원 목록 얻어오기
		List<GalleryDto> list = dao.getList(dto);
		
		// 하단 페이지 시작 번호
		int startPageNum = 1 + ((pageNum-1)/PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 페이지 끝 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;
		
		// 전체 row의 갯수
		int totalRow = dao.getCount();
		
		// 전체 페이지 갯수
		int totalPageCount = (int)Math.ceil(totalRow / (double)PAGE_ROW_COUNT);
		
		// 끝 페이지 번호가 이미 전체 페이지 갯수보다 큰 경우 보정
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount;
		}
		
		// request 영역에 담기
		// gallery list
		request.setAttribute("list", list);
		// 시작 페이지 번호
		request.setAttribute("startPageNum", startPageNum);
		// 끝 페이지 번호
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("totalPageCount", totalPageCount);
	}

	@Override
	public void saveImage(GalleryDto dto, HttpServletRequest request) {
		// 업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값 얻어오기
		MultipartFile image = dto.getImage();
		// 원본 파일명 > 저장할 파일의 이름을 만들기 위해 사용
		String orgFileName = image.getOriginalFilename();
		// 파일 크기
		long fileSize = image.getSize();
		
		// 저장할 파일 명 uuid 문자열 + 원본 파일명
		String saveFileName = UUID.randomUUID().toString() + orgFileName;
		
		// DB에 저장할 파일의 상세 경로
		String filePath = fileLocation + File.separator + saveFileName;
		
		// 디렉터리를 만들 파일 객체 생성
		File upload = new File(fileLocation);
		if (!upload.exists()) {
			// 디렉터리가 존재하지 않는 경우 폴더 생성
			upload.mkdir();
		}
		
		try {
			// upload 폴더에 파일 저장
			image.transferTo(new File(filePath));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		/*
			dto에 업로드된 파일의 정보 담기
			parameer로 넘어온 dto에는 caption, image가 들어있음
			추가 : writer(id), imagePath
			num, regdate : db에 추가하면서 자동으로 들어감
		*/
		String id = (String)request.getSession().getAttribute("id");
		dto.setWriter(id);
		
		// DB에는 saveFileName만 저자하고 출력 시 자세한 경로 출력
		dto.setImagePath(saveFileName);
		
		// GalleryDao 를 이용해서 DB에 저장
		dao.insert(dto);
	}

	@Override
	public void getDetail(ModelAndView mView, int num) {
		// dao > 해당 게시물 num에 해당하는 데이터(dto) 가져오기
		GalleryDto dto = dao.getData(num);
		// ModelAndView 에 가져온 GalleryDto 담기
		mView.addObject("dto", dto);
	}

}
