<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/delete.jsp</title>
</head>
<body>
	<div class="container">
		<h1>ALERT</h1>
		<p>
			<strong>${requestScope.id }</strong>님 탈퇴되었습니다.
			<a href="${pageContext.request.contextPath }/">HOME</a>
		</p>
	</div>
</body>
</html>