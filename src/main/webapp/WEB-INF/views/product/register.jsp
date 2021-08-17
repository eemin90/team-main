<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>작품등록ㅣLeeBook</title>

</head>
<body>
<pj:navbar />
<div id="div-white" class="container mt-3">
	<div id="div-white-wrapper" class="container">
		<h3>작품 등록</h3>
		<hr>
		<div class="row">
			<div class="col-12">
				<form action="" id="product-register-form" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="product-register-input1">카테고리</label>
						<select id="product-register-input1" name="product_category" class="custom-select">
							<option value="0" selected>카테고리 선택</option>
							<option value="1">웹툰</option>
							<option value="2">웹소설</option>
							<option value="3">책</option>
						</select>
					</div>
					<div class="form-group">
						<label for="product-register-input2">장르</label>
						<input id="product-register-input2" name="product_genre" class="form-control" required />
					</div>
					<div class="form-group">
						<label for="product-register-input3">제목</label>
						<input id="product-register-input3" name="product_name" class="form-control" required />
					</div>
					<div class="form-group">
						<label for="product-register-input4">작가</label>
						<input id="product-register-input4" name="writer_name" class="form-control" required />
					</div>
					<div class="form-group">
						<label for="product-register-input5">가격</label>
						<input id="product-register-input5" name="product_price" class="form-control" required />
					</div>
	 				<div class="form-group">
						<label for="product-register-input6">작품 커버</label>
						<input type="file" id="product-register-input6" name="file1" class="form-control" accept="image/*" required />
					</div>
					<div class="form-group">
						<label for="product-register-input7">작품 파일</label>
						<input type="file" id="product-register-input7" name="file2" class="form-control" accept="image/*" required />
					</div>
					<input type="submit" id="product-register-btn" class="btn btn-primary" value="등록" />
				</form>
			</div>
		</div>
	</div>
</div>
<pj:footer />
</body>
</html>