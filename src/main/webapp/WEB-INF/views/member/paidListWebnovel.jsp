<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>Insert title here</title>
</head>
<body>
<pj:navbar />
<div class="container">
	<%-- 구매 list --%>
	<div id="div-white" class="container">
		<ul class="list-group list-group-horizontal sel">
			<li class="list-group-item col-7">${pinfo.member.userName}님의 구매 목록</li>
			<ul class="list-group list-group-horizontal">
				<form action="${appRoot}/member/paidList" method="post" id="form-paid-list" class="form-inline">
					<input type="text" id="userid" name="userid" value="${pinfo.member.userid}" hidden />
					<li class="list-group-item sel"><button type="submit" class="btn btn-light">전체</button></li>
					<li class="list-group-item sel"><button type="button" id="paid-webtoon-btn" class="btn btn-light">웹툰</button></li>
					<li class="list-group-item sel"><button type="button" id="paid-webnovel-btn" class="btn btn-primary">웹소설</button></li>
					<li class="list-group-item sel"><button type="button" id="paid-book-btn" class="btn btn-light">책</button></li>
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
							<p class="card-text text-dark">${list.product_name}</p>
						</div>
					</div>
				</a>
			</c:forEach>
		</form>
		<c:if test="${empty webnovel}">
			<div class="container">
				<ul class="list-group">
					<li class="list-group-item"><h5>구매 목록이 비어있습니다.</h5></li>
				</ul>
			</div>
		</c:if>
	</div>
</div>
<pj:footer />
</body>
</html>