<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %><!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>문의하기ㅣLeeBook</title>
</head>
<body>
<pj:navbar />
<div id="div-white" class="container mb-3">
	<div id="div-white-wrapper" class="container">
		<h4>문의하기</h4>
		
		<div class="row">
			<div class="col-12">
				<form action="${appRoot }/help/register" method="post" enctype="multipart/form-data">
					<div class="form-group">
						<label for="input1">제목</label>
						<input id="input1" class="form-control" name="title" required>
					</div>
					<div class="form-group">
						<label for="input3">파일</label>
						<input id="input3" class="form-control" type="file" name="file" accept="image/*">
					</div>
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="textarea1" class="form-control" name="content"></textarea>
					</div>
					<div class="form-group">
						<label for="input2">작성자</label>
						<input id="input2" type="hidden" value="${pinfo.member.userid }" readonly class="form-control" name="writer">
						<input value="${pinfo.member.userName }" readonly class="form-control">
					</div>
					<input class="btn btn-primary" type="submit" value="작성" />
				</form>
			</div>
		</div>
	</div>
</div>
<pj:footer />
</body>
</html>