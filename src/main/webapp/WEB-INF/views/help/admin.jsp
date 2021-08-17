<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="nv" tagdir="/WEB-INF/tags/board" %>
<%@ taglib prefix="ht" tagdir="/WEB-INF/tags/help" %>


<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>1:1 문의관리ㅣLeeBook</title>

<script>
	$(document).ready(function() {
		$("#list-pagenation1 a").click(function(e) {
			e.preventDefault();

			var actionForm = $("#actionForm");

			actionForm.find("[name=pageNum]").val($(this).attr("href"));

			actionForm.submit();
		});
	});
</script>

</head>
<body>
<pj:navbar />
	
	<div id="div-white" class="container">
		<div id="div-white-wrapper" class="container">
	
			<h4>1:1 문의관리 [${pageMaker.total }]</h4>
				<table class="table table-hover">
				<thead>
					<tr>
						<th>NO.</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list }" var="help" >
						<tr>
							<td>${help.hno }</td>
							<td><c:url value="/help/get" var="getUrl">
									<c:param name="hno" value="${help.hno }" />
									<c:param name="pageNum" value="${pageMaker.cri.pageNum }" />
									<c:param name="amount" value="${pageMaker.cri.amount }" />
									<c:param name="type" value="${pageMaker.cri.type }" />
									<c:param name="keyword" value="${pageMaker.cri.keyword }" />
								</c:url> 
								<a href="${getUrl}"> 
									${help.title } 
									<c:if test="${help.replyCnt > 0 }">
										[${help.replyCnt }] 
									</c:if>
								</a>
								
							</td>
							<td>${help.writerName }</td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${help.regdate }" /></td>
						</tr>
					
					</c:forEach>
				</tbody>
			</table>
		</div>
	
		<div>
			<nav aria-label="Page navigation example">
				<ul id="list-pagenation1" class="pagination justify-content-center">
	
					<c:if test="${pageMaker.prev }">
						<li class="page-item"><a class="page-link"
							href="${pageMaker.startPage - 1 }" tabindex="-1"
							aria-disabled="true">Previous</a></li>
					</c:if>
	
					<c:forEach begin="${pageMaker.startPage }" end="${pageMaker.endPage }" var="num">
						
						<li class="page-item ${num == cri.pageNum ? 'active' : '' }"><a class="page-link" 
						href="${num }">${num }</a></li>
					</c:forEach>
	
					<c:if test="${pageMaker.next }">
						<li class="page-item"><a class="page-link"
							href="${pageMaker.endPage + 1 }">Next</a></li>
					</c:if>
	
				</ul>
			</nav>
		</div>
	</div>
	<!--페이지 링크용 -->
		<div style="display:none">
			<form id="actionForm" action="${appRoot }/help/list" method="get">
				<input name="pageNum" value="${cri.pageNum }" /> 
				<input name="amount" value="${cri.amount }" />
				<input name="type" value="${cri.type }" />
				<input name="keyword" value="${cri.keyword }" />
			</form>
		</div>

	</div>

		<div id="board-modal1" class="modal" tabindex="-1">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title">${messageTitle }</h5>
						<button type="button" class="close" data-dismiss="modal"
							aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
					</div>
					<div class="modal-body">
						<p>${messageBody }</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Close</button>
					</div>
				</div>
			</div>
		</div>

	<ht:helptag /> 
	<pj:footer />
</body>
</html>