package com.example.boot07.file.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.example.boot07.exception.NotDeleteException;
import com.example.boot07.file.dao.FileDao;
import com.example.boot07.file.dto.FileDto;

@Service
public class FileServiceImpl implements FileService {

	@Autowired
	private FileDao dao;

	// 다운로드 or 업로드할 파일이 저장된 위치 얻어내기
	@Value("${file.location")
	private String fileLocation;

	@Override
	public void getList(HttpServletRequest request) {
		// 한 페이지에 5개씩 표시
		final int PAGE_ROW_COUNT = 5;
		// 하단 페이지 5개씩 표시
		final int PAGE_DISPLAY_COUNT = 5;

		// 보여줄 페이지의 번호를 1로 초기값 지정
		int pageNum = 1;

		// 페이지 번호가 파라미터로 전달되는지 읽어오기
		String strPageNum = request.getParameter("pageNum");
		// 페이지 번호가 파라미터로 넘어오는 경우
		if (strPageNum != null) {
			// 숫자로 바꿔서 페이지 번호로 지정
			pageNum = Integer.parseInt(strPageNum);
		}

		// 보여줄 페이지의 시작 ROWNUM
		int startRowNum = 1 + (pageNum - 1) * PAGE_ROW_COUNT;
		// 보여줄 페이지의 마지막 ROWNUM
		int endRowNum = pageNum * PAGE_ROW_COUNT;

		/*
		 * 검색 키워드 관련 처리
		 * 
		 * - 검색 키워드가 파라미터로 넘어올 수도 있고 아닐 수도 있다
		 */
		String keyword = request.getParameter("keyword");
		String condition = request.getParameter("condition");

		// 키워드가 넘어오지 않는 경우
		if (keyword == null) {
			// 키워드와 검색 조건에 빈 문자열을 넣는다.
			keyword = "";
			condition = "";
			// 클라이언트 웹 브라우저에 출력 시 "null"을 출력되지 않게 하기 위함
		}

		// 특수 기호를 인코딩한 키워드를 미리 준비
		String encodedK = URLEncoder.encode(keyword);

		// FileDto 객체에 startRowNum, endRowNum 담기
		FileDto dto = new FileDto();
		dto.setStartRowNum(startRowNum);
		dto.setEndRowNum(endRowNum);

		// 검색 키워드가 넘어오는 경우
		if (!keyword.equals("")) {
			// 검색 조건에 따라 분류
			if (condition.equals("title_filename")) {
				dto.setTitle(keyword);
				dto.setOrgFileName(keyword);
			} else if (condition.equals("title")) {
				dto.setTitle(keyword);
			} else if (condition.equals("writer")) {
				dto.setWriter(keyword);
			}
		}

		// 파일 목록 select (검색 키워드가 있는 경우 키워드에 부합하는 전체 글 목록)
		List<FileDto> list = dao.getList(dto);

		// 전체 글의 갯수 (검색 키워드가 있는 경우 키워드에 부합하는 전체 글의 갯수
		int totalRow = dao.getCount(dto);

		// 하단 페이지 시작 번호
		int startPageNum = 1 + ((pageNum - 1) / PAGE_DISPLAY_COUNT) * PAGE_DISPLAY_COUNT;
		// 하단 끝 페이지 번호
		int endPageNum = startPageNum + PAGE_DISPLAY_COUNT - 1;

		// 전체 페이지의 갯수 구하기
		int totalPageCount = (int) Math.ceil(totalRow / (double) PAGE_ROW_COUNT);
		// 끝 페이지 번호가 전체 페이지보다 크게 계산되었을 경우 보정
		if (endPageNum > totalPageCount) {
			endPageNum = totalPageCount;
		}

		// 응답에 필요한 데이터를 view page에 전달하기 위해 request scope에 담기
		request.setAttribute("list", list);
		request.setAttribute("pageNum", pageNum);
		request.setAttribute("startPageNum", startPageNum);
		request.setAttribute("endPageNum", endPageNum);
		request.setAttribute("totalPageCount", totalPageCount);
		request.setAttribute("keyword", keyword);
		request.setAttribute("encodedK", encodedK);
		request.setAttribute("totalRow", totalRow);
		request.setAttribute("condition", condition);
	}

	@Override
	public void saveFile(FileDto dto, ModelAndView mView, HttpServletRequest request) {
		// 업로드된 파일의 정보를 가지고 있는 MultipartFile 객체의 참조값
		MultipartFile myFile = dto.getMyFile();
		// 원본 파일명
		String orgFileName = myFile.getOriginalFilename();
		// 파일 크기
		long fileSize = myFile.getSize();

		// 저장할 파일명 얻어내기
		String saveFileName = UUID.randomUUID().toString();

		// 저장할 파일의 상세 경로
		String filePath = fileLocation + File.pathSeparator + saveFileName;

		// 디렉터리를 만들 파일 객체 생성
		File upload = new File(filePath);
		if (!upload.exists()) {
			// 디렉토리가 존재하지 않는 경우 디렉터리 생성
			upload.mkdir();
		}

		try {
			// upload 폴더에 파일 저장
			myFile.transferTo(new File(filePath));
		} catch (Exception e) {
			e.printStackTrace();
		}

		// dto에 업로드된 파일의 정보 담기
		String id = (String) request.getSession().getAttribute("id");
		// 세션에서 읽어낸 파일 업로더의 아이디
		dto.setWriter(id);
		dto.setOrgFileName(orgFileName);
		dto.setSaveFileName(saveFileName);
		dto.setFileSize(fileSize);
		// fileDao -> DB에 저장
		dao.insert(dto);
		// view page에서 사용할 모델 담기
		mView.addObject("dto", dto);
	}

	@Override
	public ResponseEntity<InputStreamResource> getFileData(int num)
			throws UnsupportedEncodingException, FileNotFoundException {
		// 다운로드할 파일의 정보를 DB에서 읽어온다.
		FileDto dto = dao.getData(num);
		
		// 다운로드 시켜줄 원본 파일 명
		String encodedName = URLEncoder.encode(dto.getOrgFileName(), "utf-8");
		// 파일명에 공백이 있는경우
		encodedName = encodedName.replace("\\+", " ");
		
		// 응답 헤더 정보(스프링 프레임워크에서 제공해주는 클래스) 구성  *웹 브라우저에 알릴 정보
		HttpHeaders headers = new HttpHeaders();
		// 파일을 다운로드 시키는 정보
		headers.add(HttpHeaders.CONTENT_TYPE, "application/octet-stream");
		// 파일의 이름 정보 (웹 브라우저가 해당 정보를 이용해서 파일 생성)
		headers.add(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename="+encodedName);
		// 파일의 크기 정보 담기
		headers.setContentLength(dto.getFileSize());
		
		// 읽어들일 파일의 경로 구성
		String filePath = fileLocation + File.separator + dto.getSaveFileName();
		// 파일에서 읽어들일 스트림 객체
		InputStream is = new FileInputStream(filePath);
		// InputStreamResource 객체의 참조값
		InputStreamResource isr = new InputStreamResource(is);
		
		// ResponseEntity 객체의 참조값
		ResponseEntity<InputStreamResource> resEn = ResponseEntity.ok()
				.headers(headers)
				.body(isr);
		return resEn;
	}

	@Override
	public void deleteFile(int num, HttpServletRequest request) {
		// 삭제할 파일의 정보 얻어오기
		FileDto dto = dao.getData(num);
		// 글 작성자와 로그인된 아이디가 일치하는지 확인해서 일치하면 수정
		// 일치하지 않는 경우 예외 발생
		String id = (String) request.getSession().getAttribute("id");
		if (!dto.getWriter().equals(id)) {
			// 예외를 발생시키면 해당 예외를 처리하는 곳으로 흐름이 넘어감
			throw new NotDeleteException("본인의 파일만 삭제 가능합니다.");
		}
		// 파일 시스템에서 삭제
		String saveFileName = dto.getSaveFileName();
		// 필드에 있는 파일이 있는 위치를 이용해서 경로 구성
		String path = fileLocation+File.separator+saveFileName;
		// 삭제
		new File(path).delete();
		// DB에서 파일 정보 삭제
		dao.delete(num);
	}

}
