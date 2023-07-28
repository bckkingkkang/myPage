<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src="/static/js/bootstrap.bundle.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<title>/views/home.jsp</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark"
		aria-label="Ninth navbar example">
		<div class="container-xl">
			<a class="navbar-brand" href="/boot07/">COLOR</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarsExample07XL"
				aria-controls="navbarsExample07XL" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
				<div class="collapse navbar-collapse" id="navbarsExample07XL">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="/boot07/">ABOUT</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="#">RESERVE</a>
						</li>
						<li class="nav-item">
							<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/cafe/list">REVIEW</a>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="true" href=""> INFO </a>
							<ul class="dropdown-menu">
								<li>
									<a class="dropdown-item" href="#">Q&A</a>
								</li>
								<li>
									<a class="dropdown-item" href="#">FAQ</a>
								</li>
								<li>
									<a class="dropdown-item" href="${pageContext.request.contextPath }/gallery/list">Gallery</a>
								</li>
								<li>
									<a class="dropdown-item" href="${pageContext.request.contextPath }/file/list">Reference</a>
								</li>
							</ul>
						</li>
						<li class="nav-item dropdown">
							<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/cafe/list">NOTICE</a>
						</li>
					</ul>
					<c:choose>
						<c:when test="${empty sessionScope.id }">
							<ul class="navbar-nav me-auto mb-2 mb-lg-0">
								<li class="nav-item"><a class="nav-link active" aria-current="page"
									href="${pageContext.request.contextPath }/users/loginform">LOGIN</a></li>
								<li class="nav-item"><a class="nav-link active" aria-current="page"
									href="${pageContext.request.contextPath }/users/signup_form">SIGNUP</a></li>
							</ul>
						</c:when>
						<c:otherwise>
							<ul class="navbar-nav me-auto mb-2 mb-lg-0">
								<li class="nav-item">
									<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/users/info">MyInfo</a>
								</li>
								<li class="nav-item">
									<a class="nav-link active" aria-current="page" href="${pageContext.request.contextPath }/users/logout">LOGOUT</a>
								</li>
							</ul>
						</c:otherwise>
					</c:choose>


					<form role="search">
						<input class="form-control" type="search" placeholder="Search" aria-label="Search">
					</form>
				</div>
		</div>
	</nav>
</body>
</html>