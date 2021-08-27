<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>찜 목록ㅣLeeBook</title>
</head>
<body>
<pj:navbar />
<div class="container">

	<%-- 찜 list --%>
	<div id="div-white" class="container">
		<ul class="list-group list-group-horizontal sel">
			<li class="list-group-item col-7">${pinfo.member.userName}님의 찜 목록</li>
			<ul class="list-group list-group-horizontal">
				<form action="${appRoot}/member/likes" method="post" id="form-likes-list" class="form-inline">
					<input type="text" id="userid" name="userid" value="${pinfo.member.userid}" hidden />
					<li class="list-group-item sel"><button type="submit" class="btn btn-light">전체</button></li>
					<li class="list-group-item sel"><button type="button" id="likes-webtoon-btn" class="btn btn-light">웹툰</button></li>
					<li class="list-group-item sel"><button type="button" id="likes-webnovel-btn" class="btn btn-primary">웹소설</button></li>
					<li class="list-group-item sel"><button type="button" id="likes-book-btn" class="btn btn-light">책</button></li>
				</form>
			</ul>
		</ul>
		<form class="form-inline">
			<c:forEach items="${webnovel}" var="list">
				<c:url value="/product/webnovel/get" var="getUrl">
					<c:param name="id">${list.id}</c:param>
				</c:url>
				<a href="${getUrl}">
					<div id="product-list-div" class="card mx-2 my-2">
						<img src="${imgRoot}webnovel/${list.id}/cover/${list.file_name}" class="card-img-top">
						<div class="card-body">
							<!-- 제목의 길이가 9 이상이면 8자 까지만 출력하고 뒤에 '...'을 붙인다 -->
							<c:choose>
								<c:when test="${fn:length(list.product_name) >= 9}">
									<p class="card-text text-dark">${fn:substring(list.product_name, 0, 8)}...</p>
								</c:when>
								<c:when test="${fn:length(list.product_name) < 9}">
									<p class="card-text text-dark">${list.product_name}</p>
								</c:when>
							</c:choose>
						</div>
					</div>
				</a>
			</c:forEach>
		</form>
		<c:if test="${empty webnovel}">
			<div class="container">
				<ul class="list-group">
					<li class="list-group-item"><h5>찜 목록이 비어있습니다.</h5></li>
				</ul>
			</div>
		</c:if>
	</div>
</div>
<pj:footer />
</body>
</html>