<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>글 보기ㅣLeeBook</title>
<script>
var appRoot = "${appRoot}";
var boardBno = "${board.bno}";
var userid = "${pinfo.member.userid}";
</script>
<script src="${appRoot }/resources/js/get.js"></script>
<script src="${appRoot }/resources/js/boardLike.js"></script>


</head>
<body>
<pj:navbar></pj:navbar>

<div id="div-white" class="container mb-3">
	<div id="div-white-wrapper" class="container">
	<c:if test="${not empty messageBody}">
		<div id="alert1" class="alert alert-primary fade" role="alert">
		  
		</div>
	</c:if>
		<h4>글 보기</h4>
		<p><i class="far fa-thumbs-up"></i><span id="like-cnt">${board.like_cnt}</span>&nbsp;&nbsp;<i class="far fa-thumbs-down"></i><span id="dislike-cnt">${board.dislike_cnt}</span></p>
		
		<div class="row">
			<div class="col-12">
			<input type="text" id="like-bno" value="${board.bno}" hidden />
			<input type="text" id="like-user-id" value="${pinfo.member.userid}" hidden />
			<input type="text" id="like-check-like" value="${like.check_like}" hidden />
			<input type="text" id="like-check-dislike" value="${dislike.check_dislike}" hidden />
				<form>
					<div class="form-group">
						<label for="input1">제목</label>
						<input readonly="readonly" id="input1" class="form-control" name="title" value="${board.title }">
					</div>
					<div class="form-group">
						<label for="textarea1">내용</label>
						<textarea readonly="readonly" id="textarea1" class="form-control" 
						name="content"><c:out value="${board.content }" /></textarea>
					</div>
					<c:if test="${not empty board.fileName }"> 
						<div>
							<img class="img-fluid" 
							src="${imgRoot}board/${board.bno }/${board.fileName}">
						</div>
						<br>
					</c:if> 
					<div class="form-group">
						<label for="input2">작성자</label>
						<input type="hidden" readonly="readonly" id="input2" class="form-control" name="writer" value="${board.writer }">
						<input readonly="readonly" class="form-control" value="${board.writerName }">
					</div>
					
					<c:url value="/board/modify" var="modifyUrl">
						<c:param name="bno" value="${board.bno }"/>
						<c:param name="pageNum" value="${cri.pageNum }"/>
						<c:param name="amount" value="${cri.amount }"/>
						<c:param name="type" value="${cri.type }" />
						<c:param name="keyword" value="${cri.keyword }" />
					</c:url>
					
					<c:if test="${pinfo.member.userid eq board.writer }" >
						<a class="btn btn-secondary" href="${modifyUrl }">수정/삭제</a><br><br>	
					</c:if>
					
					<sec:authorize access="isAuthenticated()">
						<button type="button" id="like-btn" class="btn btn-primary"><i class="far fa-thumbs-up"></i>&nbsp;좋아요</button>
						<button type="button" id="dislike-btn" class="btn btn-danger"><i class="far fa-thumbs-down"></i>&nbsp;싫어요</button>
					</sec:authorize>
					
				</form>
			</div>
		</div>
	</div>
</div>

<div id="div-white" class="container p-3">
	<div class="row">
		<div class="col-12">
			<div class="row justify-content-between m-1">
				<span style="font-size: 25px;">댓글</span>
				<sec:authorize access="isAuthenticated()">
					<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#reply-insert-modal">댓글 작성</button>
				</sec:authorize>
			</div>
			<br>
			
			<ul class="list-unstyled" id="reply-list-container">
			</ul>
		</div>
	</div>
</div>
	
<!-- 댓글 입력 모달  -->
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
          <input type="text" value="${board.bno }" readonly hidden id="reply-bno-input1">	
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input type="text" readonly value="${pinfo.member.userName }" class="form-control" />
            <input type="hidden" value="${pinfo.member.userid }" class="form-control" id="reply-replyer-input1">
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">댓글</label>
            <textarea class="form-control" id="reply-reply-textarea1"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button id="reply-insert-btn1" type="button" class="btn btn-primary">댓글 입력</button>
      </div>
    </div>
  </div>
</div>

<%--댓글 수정, 삭제 모달 --%>
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
          <input type="text" value="" readonly hidden id="reply-rno-input2">
          <input type="text" value="${board.bno }" readonly hidden id="reply-bno-input2">	
          <div class="form-group">
            <label for="recipient-name" class="col-form-label">작성자</label>
            <input id="reply-replyerName-input2" class="form-control" readonly type="text" />
            <input type="hidden" class="form-control" id="reply-replyer-input2" readonly>
          </div>
          <div class="form-group">
            <label for="message-text" class="col-form-label">댓글</label>
            <textarea class="form-control" id="reply-reply-textarea2"></textarea>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <span id="reply-modify-delete-btn-wrapper">
        <button id="reply-modify-btn1" type="button" class="btn btn-primary">댓글 수정</button>
        <button id="reply-delete-btn1" type="button" class="btn btn-danger">댓글 삭제</button>
        </span>
      </div>
    </div>
  </div>
</div>
<pj:footer />
</body>
</html>