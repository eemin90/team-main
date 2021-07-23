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
var pid = "${webnovel.id}";
var userid = "${pinfo.member.userid}";
</script>
<script src="${appRoot}/resources/js/productLike.js"></script>
<script src="${appRoot}/resources/js/productReply.js"></script>

<title>webnovel get</title>
</head>
<body>
<pj:navbar1 />
<div class="container">
	<c:url value="/product/webnovel/modify" var="modifyUrl">
		<c:param name="id" value="${webnovel.id}" />
	</c:url>
	<c:url value="/product/webnovel/detail" var="detailUrl">
		<c:param name="id" value="${webnovel.id}" />
	</c:url>
	
	<%-- 상품 상세 --%>
	<div id="div-white" class="container mb-3 p-3">
		<div>
			<form action="${appRoot}/product/webnovel/detail" method="get" id="webnovel-get-form" class="form-inline">
				<div id="div-get">
					<img id="img-get" src="${imgRoot}webnovel/${webnovel.id}/cover/${webnovel.file_name}">
				</div>
				<div id="div-get-detail" class="ml-3">
					<div id="div-get-detail-pname">
						${webnovel.product_name}
					</div>
					<div id="div-get-detail-likecomment">
						<span id="like-icon">
							<i id="like-i" class="far fa-heart"></i>
							<span id="like-cnt">${webnovel.like_cnt}</span>
						</span>
						<span>조회수, </span>
						<span>
							<i class="fas fa-comment fa-flip-horizontal"></i>
							<span id="replyCntAbove">${webnovel.reply_cnt}</span>
						</span>
						<input type="text" id="like-product-id" value="${webnovel.id}" hidden />
						<input type="text" id="like-user-id" value="${pinfo.member.userid}" hidden />
						<input type="text" id="like-check-like" value="${like.check_like}" hidden />
					</div>
					<div id="div-get-detail-bottom" class="form-inline">
						<div id="div-get-detail-wname">
							${webnovel.writer_name}
						</div>
						<div id="div-get-detail-btn">
							<sec:authorize access="hasRole('ROLE_ADMIN')">
								<a class="btn btn-secondary" href="${modifyUrl}">수정/삭제</a>
							</sec:authorize>
							<a class="btn btn-primary" href="${detailUrl}">작품보기</a>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	
	<%-- 댓글 목록 --%>
	<div id="div-white" class="container p-3">
		<h5>
			댓글 <c:if test="${webnovel.reply_cnt > 0}"><small>[</small><small id="replyCntBelow">${webnovel.reply_cnt}</small><small>]</small></c:if>
		</h5>
		
		<hr>
		<ul class="list-unstyled" id="reply-list-container">
			
		</ul>
		<sec:authorize access="isAuthenticated()">
			<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reply-insert-modal">댓글 작성</button>
		</sec:authorize>
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
							<input type="text" value="${webnovel.id}" id="reply-pid-input1" readonly hidden />
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
						<input type="text" value="${webnovel.id}" id="reply-pid-input2" readonly hidden />
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