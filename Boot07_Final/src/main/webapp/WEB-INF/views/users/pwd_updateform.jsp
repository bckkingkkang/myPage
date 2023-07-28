<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/users/pwd_updateform.jsp</title>
</head>
<body>
	<div class="container">
		<h1>Password Update</h1>
		<form action="${pageContext.request.contextPath }/users/pwd_update" method="post" id="myForm">
			<div>
				<label for="pwd">PASSWORD</label>
				<input type="password" name="pwd" id="pwd"/>
			</div>
			<div>
				<label for="newPwd">new PASSWORD</label>
				<input type="password" name="newPwd" id="newPwd"/>
			</div>
			<div>
				<label for="newPwd2">new PASSWORD check</label>
				<input type="password" name="newPwd2" id="newPwd2"/>
			</div>
			
			<button type="submit">UPDATE</button>
			<button type="reset">RESET</button>
		</form>
	</div>
	
	<script>
		/* 폼에 submit 이벤트가 일어났을 때 실행할 함수를 등록 */
		document.querySelector("#myForm").addEventListener("submit", function(e) {
			let pwd1 = document.querySelector("#newPwd").value;
			let pwd2 = documnet.querySelector("#newPwd2").value;
			
			// 새 비밀번호와 비밀번호 확인이 일치하지 않으면 폼 전송을 막는다.
			if (pwd1 != pwd2) {
				alert("비밀번호 확인이 일치하지 않습니다.");
				e.preventDefault();
			}
		});
	</script>
</body>
</html>