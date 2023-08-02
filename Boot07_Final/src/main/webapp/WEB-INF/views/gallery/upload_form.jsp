<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/gallery/upload_form.jsp</title>
</head>
<body>
	<div class="container">
		<h1>Image Upload</h1>
		<form action="${pageContext.request.contextPath }/gallery/upload" method="post"
			enctype="multipart/form-data">
			<div>
				<label for="caption">설명</label>
				<input type="text" name="caption" id="caption"/>
			</div>
			<div>
				<label for="image">이미지</label>
				<input type="file" name="image" id="image" accept=".jpg, .jpeg, .png, .JPG, .JPEG"/>
			</div>
			
			<button type="submit">UPLOAD</button>
		</form>
		<br />
		<img alt="이미지 미리보기" id="preview"/>
	</div>
	
	<script>
		document.querySelector("#imgae").addEventListener("change", (e)=> {
			// 선택된 파일 객체 얻어내기
			const files = e.target.files;
			
			// 데이터가 존재하는 경우
			if (files.length > 0) {
				// 파일로부터 데이터를 읽어들일 객체 생성
				const reader = new FileReader();
				// 로딩이 완료된 시점에서 실행할 함수
				reader.onload = (event) => {
					// 읽은 파일의 데이터 얻어내기
					const data = event.target.result;
					// console.log(data);
					// 이미지 요소에 data를 src 속성의 value로 넣기
					document.querySelector("#preview").setAttribute("src", data);
				};
				// 파일을 dataURL 형식의 문자열로 읽어들이기
				reader.readAsDataURL(files[0]);
			}
		});
	</script>
</body>
</html>