<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>



<c:url value="/board/register" var="registerUrl">
	<c:if test="${not empty cri.pageNum }">
		<c:param name="pageNum" value="${cri.pageNum }"></c:param>
	</c:if>
	<c:if test="${not empty cri.amount }">
		<c:param name="amount" value="${cri.amount }"></c:param>
	</c:if>
		<c:param name="keyword" value="${cri.keyword }"></c:param>
		<c:param name="type" value="${cri.type }"></c:param>
</c:url>
<div id="div-white" class="container">
<nav class="navbar navbar-expand-lg">
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      
      <li class="nav-item">
        <a class="nav-link" href="${registerUrl }"><i class="fas fa-pen"></i> 글쓰기</a>
      </li>
	  
    </ul>
  </div>
  
  <form action="${listUrl }" method="get" class="form-inline">
  	<select name="type" class="form-control mr-sm-2">
  		<option value="">--</option>
  		<option value="T" ${cri.type == "T" ? 'selected' : '' }>제목</option>
  		<option value="W" ${cri.type == "W" ? 'selected' : '' }>작성자</option>
  		<option value="TW" ${cri.type == "TW" ? 'selected' : '' }>제목 or 작성자</option>
  	</select>
  
    <input name="keyword" value="${cri.keyword }" class="form-control mr-sm-2" type="search" placeholder="검색어 입력" aria-label="Search">
    
    <input type="hidden" name="pageNum" value="1">
    <input type="hidden" name="amount" value="${cri.amount }">
    <button class="btn btn-outline-success my-2 my-sm-0" type="submit">검색</button>
  </form>
</nav>
</div>

















