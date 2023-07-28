<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/cafe/list.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-OERcA2EqjJCMA+/3y+gxIOqMEjwtxJY7qPCqsdltbNJuaOe923+mo//f6V8Qbsw3"
	crossorigin="anonymous"></script>
<link rel="shortcut icon" type="image/x-icon" href="/images/favicon.ico" />
<!--script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.0/jquery.min.js"></script-->
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></script>  

<style>
	#insert {
		text-align : right;
	}
</style>

</head>
<body>
	<link href="http://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.no-icons.min.css" rel="stylesheet">
    <link href="http://netdna.bootstrapcdn.com/font-awesome/3.1.1/css/font-awesome.min.css" rel="stylesheet">
    <link href="http://cdnjs.cloudflare.com/ajax/libs/x-editable/1.4.4/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/resources/css/bootstrap-filterable.css" rel="stylesheet" >

	<div class="container">
		
		<h3>REVIEW</h3>
		
		<label for="condition" id="insert"><a href="${pageContext.request.contextPath }/cafe/insertform">새 글 작성하기</a></label>
		
		<table id="example-table" class="table table-striped table-hover table-condensed">
			<thead class="table-dark">
				<tr>
					<th>NUM</th>
					<th>WRITER</th>
					<th>TITLE</th>
					<th>VIEW</th>
					<th>REGDATE</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tmp" items="${list }">
					<tr>
						<td>${tmp.num }</td>
						<td>${tmp.writer }</td>
						<td><a
							href="detail?num=${tmp.num }&condition=${condition}&keyword=${encodedK}">${tmp.title }</a>
						</td>
						<td>${tmp.viewCount }</td>
						<td>${tmp.regdate }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<nav>
			<ul class="pagination">
				<!-- 
					startPageNum 이 1이 아닌 경우에만 Prev 링크를 제공한다. 
					&condition=${condition}&keyword=${encodedK}
				-->
				<c:if test="${startPageNum ne 1 }">
					<li class="page-item"><a
						href="list?pageNum=${startPageNum-1 }&condition=${condition}&keyword=${encodedK}"
						class="page-link animate_animated">PREV</a></li>
				</c:if>
				<c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
					<li class="page-item ${paramNum eq i ? 'active' : '' }"><a
						class="page-link animate_animated"
						href="list?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
					</li>
				</c:forEach>
				<!-- 
					마지막 페이지 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공한다.
				-->
				<c:if test="${endPageNum lt totalPageCount }">
					<li class="page-item"><a
						href="list?pageNum=${endPageNum+1 }&condition=${condition}&keyword=${encodedK}"
						class="page-link animate_animated">NEXT</a></li>
				</c:if>
			</ul>
		</nav>

		<script>
			document.querySelectorAll(".pagination a").forEach(function(item) {
				// item은 a의 참조값이다. 모든 a 요소에 mouseover 이벤트가 발생했을 때 실행할 함수 등록
				item.addEventListener("mouseover", function(e) {
					// 애니메이션 클래스를 추가해서 애니메이션이 동작하도록 한다.
					e.target.classList.add("animate_swing");
				});

				// item은 a의 참조값이다. 모든 a 요소에 animationend 이벤트가 발생했을 때 실행할 함수 등록
				item.addEventListener("animationend", function(e) {
					// 애니메이션 클래스를 제거해서 다음에 추가되면 다시 애니메이션이 동작되도록 한다.
					e.target.classList.remove("animate_swing");
				});
			});
		</script>

		<!-- 검색 폼 -->
		<form action="list" method="get">
			<label for="condition">검색</label> 
			<select name="condition" id="condition">
				<option
					value="title_content ${condition eq 'title_content' ? 'selected' : '' }">Title
					+ Content</option>
				<option value="title ${condition eq 'title' ? 'selected' : '' }">Title</option>
				<option value="writer ${condition eq 'writer' ? 'selected' : '' }">Writer</option>
			</select> <input type="text" name="keyword" placeholder="keyword..."
				value="${keyword }" />
			<button type="submit">SEARCH</button>
			
		</form>

		<c:if test="${not empty condition }">
			<p>
				<strong>${totalRow }</strong> 건의 자료가 검색되었습니다. <a href="list">RESET</a>
			</p>
		</c:if>
	</div>

</body>
</html>