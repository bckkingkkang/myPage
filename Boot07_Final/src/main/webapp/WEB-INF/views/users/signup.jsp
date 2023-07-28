<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/signup.jsp</title>
</head>
<body>
	<div class="container">
		<p>
			<!-- form 전송되었던 파라미터를 view page에서 사용 가능 -->
			<strong>${param.id }</strong> 님 회원가입되었습니다.
			<a href="${pageContext.request.contextPath }/users/loginform">LOGIN</a>
		</p>
	</div>
</body>
</html>