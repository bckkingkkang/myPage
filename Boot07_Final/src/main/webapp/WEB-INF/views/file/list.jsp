<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>/views/file/list.jsp</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="container">
		<a href="${pageContext.request.contextPath }/file/upload_form">upload</a>
		<h3>Reference</h3>
		<table class="table tablef-striped">
			<thead class="table-dark">
				<tr>
					<th>번호</th>
					<th>작성자</th>
					<th>제목</th>
					<th>파일명</th>
					<th>크기</th>
					<th>등록일자</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="tmp" items="${list }">
					<tr>
						<td>${tmp.num }</td>
						<td>${tmp.writer }</td>
						<td>${tmp.title }</td>
						<td>
							<a href="download?num=${tmp.num }">${tmp.orgFileName }</a>
						</td>
						<td>${tmp.fileSize }</td>
						<td>${tmp.regdate }</td>
						<td>
							<c:if test="${tmp.writer eq sessionScope.id }">
								<a href="javascript:deleteConfirm(${tmp.num })">삭제</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<nav>
			<ul class="pagination">
				<!-- 
					startPageNum 이 1이 아닌 경우만 Prev 링크 제공
					&condition=${condition}&keyword=${encodedK}
				 -->
				 <c:if test="${startPageNum ne 1 }">
				 	<li class="page-item">
				 		<a href="list?pageNum=${startPageNum -1 }&condition=${condition}&keyword=${encodedK}" class="page-link">Prev</a>
				 	</li>
				 </c:if>
				 <c:forEach var="i" begin="${startPageNum }" end="${endPageNum }">
				 	<li class="page-item ${pageNum eq i ? 'active' : '' }" >
				 		<a class="page-link" href="list?pageNum=${i }&condition=${condition}&keyword=${encodedK}">${i }</a>
				 	</li>
				 </c:forEach>
				 <!-- 
				 	페이지 마지막 번호가 전체 페이지의 갯수보다 작으면 Next 링크를 제공
				  -->
				  <c:if test="${endPageNum lt totalPageCount }">
				  	<li class="page-item">
				  		<a class="page-link" href="list?pageNum=${endPageNum+1 }&condition=${condition}&keyword=${encodedK}">Next</a>
				  	</li>
				  </c:if>
			</ul>
		</nav>
		
		<!-- 검색 폼 -->
		<form action="list" method="get">
			<label for="condition">keyword</label>
			<select name="condition" id="condition">
				<option value="title_filename" ${condition eq 'title_filename' ? 'selected' : '' }>title + file name</option>
				<option value="title" ${condition eq 'title' ? 'selected' : '' }>title</option>
				<option value="writer" ${condition eq 'writer' ? 'selected' : '' }>writer</option>
			</select>
			<input type="text" name="keyword" placeholder="keyword..." value="${keyword }"/>
			<button type="submit">Search</button>
		</form>
		
		<c:if test="${not empty condition }">
			<p>
				<strong>${totalRow }</strong>개의 자료가 검색되었습니다.
				<a href="list">reset</a>
			</p>
		</c:if>
		</div>
		
		<script>
			function deleteConfirm(num) {
				let isDelete = confirm("삭제하시겠습니까?");
				if (isDelete) {
					location.href = "delete?num="+num;
				}
			}
		</script>
	
</body>
</html>