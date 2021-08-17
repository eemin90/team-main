<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>문의 수정/삭제</title>

<script>
$(document).ready(function() {
	var modifyUrl = "${appRoot }/help/modify";
	var removeUrl = "${appRoot }/help/remove";
	$("#help-remove-btn1").click(function() {
		if (confirm("삭제 하시겠습니까?")) {
			$("#modify-form1").attr("action", removeUrl);
			$("#modify-form1").submit();
		};
	});
});
</script>
</head>
<body>
<pj:navbar></pj:navbar>
<div id="div-white" class="container mb-3">
	<div id="div-white-wrapper" class="container">
		<h4>글 수정/삭제</h4>
		
		<div class="row">
			<div class="col-12">
				<form id="modify-form1" action="${appRoot }/help/modify" method="post" enctype="multipart/form-data">
					<input hidden name="hno" value="${help.hno }" />
					<div class="form-group">
						<label for="input1">제목</label>
						<input id="input1" value="${help.title }" class="form-control" name="title">
					</div>
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea id="textarea1" class="form-control" 
						name="content"><c:out value="${help.content }" /></textarea>
					</div>
					
					<c:if test="${not empty help.fileName }"> 
						<div>
							<img class="img-fluid" 
							src="${imgRoot}${help.hno }/${help.fileName}">
						</div>
					</c:if>
					
					<div class="form-group">
						<label for="input3">파일</label>
						<input id="input3" class="form-control" type="file" name="file" accept="image/*"><br>
						<input id="file-remove-btn1" class="btn btn-danger" type="button" value="파일삭제" />
					</div>
					
					<div class="form-group">
						<label for="input2">작성자</label>
						<input readonly="readonly" value="${help.writerName }" id="input2" class="form-control">
						<input hidden value="${help.writer }" id="input2" class="form-control" name="writer">
					</div>
					<input hidden name="pageNum" value="${cri.pageNum }" />
					<input hidden name="amount" value="${cri.amount }" />
					<input hidden name="type" value="${cri.type }" />
					<input hidden name="keyword" value="${cri.keyword }" />
						
					<input class="btn btn-warning" type="submit" value="수정" />
					<input id="help-remove-btn1" class="btn btn-danger" type="button" value="삭제" />
					
				</form>
			</div>
		</div>
	</div>
</div>
<pj:footer />
</body>
</html>