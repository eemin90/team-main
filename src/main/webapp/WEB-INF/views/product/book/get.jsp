<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<link href="<c:url value='/resources/css/basic.css'/>" rel="stylesheet" />

<title>book get</title>
</head>
<body>
<pj:navbar1 />
<div hidden="hidden" class="container">
	책 상세 정보 테스트<br>
	id = ${book.id}<br>
	product_category = ${book.product_category}<br>
	product_genre = ${book.product_genre}<br>
	product_name = ${book.product_name}<br>
	writer_name = ${book.writer_name}<br>
	register_date = <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${book.register_date}" /><br>
	update_date = <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${book.update_date}" /><br>
</div>

<div class="container">
	<div id="div-white" class="container mb-3 p-3">
		<div>
			<form class="form-inline">
				<div id="div-get">
					<img id="img-get" src="https://www.freemockupworld.com/wp-content/uploads/2019/12/Free-Book-Cover-Mockup-PSD.jpg">
				</div>
				<div id="div-get-detail" class="ml-3">
					<div id="div-get-detail-pname">
						${book.product_name}
					</div>
					<div id="div-get-detail-likecomment">
						찜 수, 댓글 수 표시
					</div>
					<div class="form-inline">
						<div id="div-get-detail-wname">
							${book.writer_name}
						</div>
						<div id="div-get-detail-btn">
							책 보기 버튼 위치
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<div id="div-white" class="container p-3">
		댓글 area
	</div>
</div>
<pj:footer />
</body>
</html>