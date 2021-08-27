<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>
<script>
var appRoot = "${appRoot}";
var pid = "${webtoon.id}";
var userid = "${pinfo.member.userid}";
</script>
<script src="${appRoot}/resources/js/productDetailReply.js"></script>

<title>${webtoon.product_name} - 웹툰ㅣLeeBook</title>
</head>
<body>
<pj:navbar1 />
<div class="container">

	<input type="text" id="check-paid" value="${paid.check_paid}" hidden />
	<input type="text" id="user-auth" value="${auth}" hidden />

	<%-- 내용 상세 --%>
	<div id="div-white" class="container mb-3">
		<div id="detail-div">
			<img id="detail-img" src="${imgRoot}webtoon/${webtoon.id}/file/${webtoon.file_name}">
		</div>
	</div>
	
	<%-- 댓글 목록 --%>
	<div id="div-white" class="container p-3">
		<div class="row justify-content-between m-1">
			<span id="reply-lists">
				댓글 <c:if test="${book.reply_cnt > 0}"><small>[</small><small id="replyCntBelow">${book.reply_cnt}</small><small>]</small></c:if>
			</span>
			<sec:authorize access="isAuthenticated()">
				<button type="button" class="btn btn-light" data-toggle="modal" data-target="#reply-insert-modal">댓글 작성</button>
			</sec:authorize>
		</div>
		
		<hr>
		
		<ul class="list-unstyled" id="reply-list-container">
			
		</ul>
	</div>
	
	<%-- modal --%>
	<%-- 댓글 입력 --%>
	<div class="container">
		<div class="modal fade" id="reply-insert-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">새 댓글</h5>
						<button type="button" class="close" data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<form>
							<input type="text" value="${webtoon.id}" id="reply-pid-input1" readonly hidden />
							<div class="form-group">
								<label for="reply-replyer-input1" class="col-form-label">작성자</label>
								<input type="text" class="form-control" value="${pinfo.member.userName}" readonly />
								<input type="text" class="form-control" id="reply-replyer-input1" value="${pinfo.member.userid}" hidden />
							</div>
							<div class="form-group">
								<label for="reply-reply-textarea1" class="col-form-label">댓글</label>
								<textarea class="form-control" id="reply-reply-textarea1"></textarea>
							</div>
						</form>
					</div>
					<div class="modal-footer">
						<button id="reply-insert-btn1" type="button" class="btn btn-primary">댓글 입력</button>
						<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<%-- 댓글 수정, 삭제 --%>
	<div class="modal fade" id="reply-modify-modal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">댓글 수정/삭제</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form>
						<input type="text" value="" id="reply-id-input2" readonly hidden />
						<input type="text" value="${webtoon.id}" id="reply-pid-input2" readonly hidden />
						<div class="form-group">
							<label for="reply-replyer-input1" class="col-form-label">작성자</label>
							<input type="text" class="form-control" id="reply-replyerName-input2" readonly />
							<input type="text" class="form-control" id="reply-replyer-input2" hidden />
						</div>
						<div class="form-group">
							<label for="reply-reply-textarea1" class="col-form-label">댓글</label>
							<textarea class="form-control" id="reply-reply-textarea2" readonly></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<span id="reply-modify-delete-btn-wrapper">
						<button id="reply-modify-btn1" type="button" class="btn btn-primary">댓글 수정</button>
						<button id="reply-delete-btn1" type="button" class="btn btn-danger">댓글 삭제</button>
					</span>
					<button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
				</div>
			</div>
		</div>
	</div>
	
	<%-- modal 알림(댓글 등록/수정/삭제) --%>
	<div class="modal fade" id="reply-modal" tabindex="-1" aria-labelledby="stateModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="stateModalLabel">알림</h5>
					<button type="button" class="close" data-dismiss="modal" aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div id="reply-modal-body" class="modal-body"></div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
				</div>
			</div>
		</div>
	</div>
	
</div>
<pj:footer />
</body>
</html>