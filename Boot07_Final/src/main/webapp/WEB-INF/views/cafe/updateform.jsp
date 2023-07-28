<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/cafe/updateform.jsp
</title>
</head>
<body>
	<div class="container">
		<h1>글 수정</h1>
		<form action="update" method="post">
			<input type="hidden" name="num" value="${dto.num }"/>
			<div>
				<label for="writer">WRITER</label>
				<input type="text" name="writer" value="${dto.writer }" disabled/>
			</div>
			<div>
				<label for="title">TITLE</label>
				<input type="text" name="title" id="title" value="${dto.title }"/>
			</div>
			<div>
				<label for="content">CONTENT</label>
				<textarea name="content" id="content">${dto.content }</textarea>
			</div>
			<button type="submit" onClick="submitContents(this);">UPDATE</button>
			<button type="reset">RESET</button>
		</form>
	</div>
	
	<!-- SmartEditor 에서 필요한 javascript 로딩 -->
	<script src="${pageContext.request.contextPath }/resources/SmartEditor/js/HuskyEZCreator.js"></script>
	<script>
		var oEditors = [];
		
		// 추가 글꼴 목록
		// var aAdditionalFontSet = [["MS UI Gothic", "MS UI Gothic"], ["Comic Sans MS", "Comic Sanc MS"], ["TEST", "TEST"]];
		
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "content",
			sSkinURI : "${pageContext.request.contextPath }/resources/SmartEditor/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,
				bUserVerticalResizer : true,
				bUseModeChanger : true,
				fOnBeforeUnload : function() {
					
				}
			},
			fOnAppLoad : function() {
				
			},
			fCreator : "createSEditor2";
		});
		
		function pasteHTML() {
			var sHTML = "<span style ='color:#FF0000;'>이미지도 같은 방식으로 삽입합니다.</span>";
		}
		
		function showHTML() {
			var sHTML = oEditors.getById["content"].getIR();
			alert(sHTML);
		}
		
		function submitContents(elClickedObj) {
			oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
			
			try {
				elClickedObj.form.submit();
			} catch (e) {}
		}
		
		function setDefaultFont() {
			var sDefaultFont = '궁서';
			var nFontSize = 24;
			oEditors.getById["content"].setDefaultFont(sDefaultFont, nFontSize);
		}
	</script>
</body>
</html>