<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/info.jsp</title>
<style>
	/* 프로필 이미지를 작은 원형으로 만든다. */
	#profileImage {
		width : 50px;
		height : 50px;
		border : 1px solid #cecece;
		border-radius : 50%;
	}
</style>
</head>
<body>
	<div class="container">
		<h1>INFO</h1>
		<table>
			<tr>
				<th>ID</th>
				<td>${id }</td>
			</tr>
			<tr>
				<th>Profile Image</th>
				<td>
					<c:choose>
						<c:when test="${empty dto.profile }">
							<svg id="profileImage" xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-circle" viewBox="0 0 16 16">
					  			<path d="M11 6a3 3 0 1 1-6 0 3 3 0 0 1 6 0z"/>
					  			<path fill-rule="evenodd" d="M0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8zm8-7a7 7 0 0 0-5.468 11.37C3.242 11.226 4.805 10 8 10s4.757 1.225 5.468 2.37A7 7 0 0 0 8 1z"/>
							</svg>
						</c:when>
						<c:otherwise>
							<img id="profileImage" src="${pageContext.request.contextPath }${dto.profile }"/>
						</c:otherwise>
					</c:choose>
				</td>
			</tr>
			<tr>
				<th>PASSWORD</th>
				<td><a href="${pageContext.request.contextPath }/users/pwd_updateform">PWD UPDATE</a></td>
			</tr>
			<tr>
				<th>E-MAIL</th>
				<td>${dto.email }</td>
			</tr>
			<tr>
				<th>REGDATE</th>
				<td>${dto.regdate }</td>
			</tr>
		</table>
		
		<a href="${pageContext.request.contextPath }/users/updateform">UPDATE</a>
		<a href="javascript:deleteConfirm()">DELETE</a>
	</div>
	
	<script>
		function deleteConfirm() {
			const isDelete = confirm("${id}님 탈퇴하시겠습니까?");
			if (isDelete) {
				location.href = "${pageContext.request.contextPath }/users/delete";
			}
		}
	</script>
</body>
</html>