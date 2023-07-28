<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/file/upload_form.jsp</title>
</head>
<body>
	<div class="container">
		<h3>File Upload</h3>
		<form action="upload" method="post" enctype="multipart/form-data">
			<div>
				<label for="title">Title</label>
				<input type="text" name="title" id="title"/>
			</div>
			<div>
				<label for="myFile">File</label>
				<input type="file" name="myFile" id="myFile"/>
			</div>
			<button type="submit">upload</button>
		</form>
	</div>
</body>
</html>