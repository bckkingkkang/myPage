<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/users/signup_form.jsp</title>
</head>
<body>
	<div class="container">
		<h1>SIGNUP</h1>
		<form action="${pageContext.request.contextPath }/users/signup" method="post" id="myForm">
			<div>
				<label for="id" class="control-label">ID</label>
				<input type="text" class="form-control" name="id" id="id"/>
			</div>
			<div>
				<label for="pwd" class="control-label">PASSWORD</label>
				<input type="password" class="form-control" name="pwd" id="pwd"/>
			</div>
			<div>
				<label for="pwd2" class="control-label">PASSWORD check</label>
				<input type="password" class="form-control" name="pwd2" id="pwd2"/>
			</div>
			<div>
				<label for="email" class="control-label">E-Mail</label>
				<input type="text" class="form-control" name="email" id="email"/>
			</div>
			<button class="btn btn-primary" type="submit">SIGNUP</button>
		</form>
	</div>
</body>
</html>