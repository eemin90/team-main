<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<c:url value="/search" var="listUrl">
	<c:param name="keyword" value="${cri.keyword}" />
</c:url>

<div id="team-header" class="d-flex flex-column sticky-top pt-3 mb-3">
	<div id="team-header-above" class="mx-auto">
		<nav class="navbar navbar-light">
			<a class="navbar-brand" href="${appRoot}/main"><img id="main-logo" src="${imgRoot}leebook-logo.png"></a>
			<ul class="nav justify-content-end">
				<li id="navbar-search" class="nav-item mr-3">
					<form action="${listUrl}" method="get" id="search-form" class="form-inline">
						<div class="input-group mr-sm-2">
							<input type="text" id="navbar-search-input" name="keyword" class="form-control" value="${cri.keyword}" autocomplete="off" required>
							<div id="search-rank" hidden="hidden">
								<div id="search-rank-list"><strong class="nav-link">- 검색 TOP 5 -</strong></div>
								<c:forEach items="${searchRank}" var="rank" varStatus="status">
									<div id="search-rank-list">
										<a id="search-rank-list-keyword${status.count}" class="nav-link" href="">${rank.keyword}</a>
									</div>
								</c:forEach>
							</div>
							<div class="input-group-prepend">
								<div id="navbar-search-icon" class="input-group-text">
									<span id="search-icon"><i class="fas fa-search"></i></span>
								</div>
							</div>
						</div>
					</form>
				</li>
				<sec:authorize access="!isAuthenticated()">
					<li id="charge-btn" class="nav-item">
						<a href="${appRoot}/member/pay2" id="charge-btn-link">캐시충전</a>
					</li>
					<li id="nav-divider" class="nav-item">
						<span><small>&nbsp;ㅣ&nbsp;</small></span>
					</li>
					<li id="login-btn" class="nav-item">
						<a href="${appRoot}/member/login" id="login-btn-link">로그인</a>
					</li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
					<li class="nav-item">
						<div class="dropdown">
							<span id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i id="dropdownMenuIcon" class="far fa-user"></i></span>

							<div id="dropdown-menu" class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
								<sec:authorize access="hasRole('ROLE_ADMIN')">
									<a class="dropdown-item" href="${appRoot}/product/register">작품 등록</a>
									<div class="dropdown-divider"></div>
								</sec:authorize>
								<sec:authorize access="!hasRole('ROLE_ADMIN')">
									<a class="dropdown-item"><small>내 캐시</small><br><span><fmt:formatNumber value="${userMoney.money}" /></span>원</a>
									<div class="dropdown-divider"></div>
									<a class="dropdown-item" href="${appRoot}/member/info">회원 정보</a>
									<form action="${appRoot}/member/likes" method="post" id="form-dropdown" class="form-inline">
										<input type="text" id="userid" name="userid" value="${pinfo.member.userid}" hidden />
										<button class="dropdown-item">찜 목록</button>
										<button id="dropdown-paid" class="dropdown-item">구매 목록</button>
									</form>
									<a class="dropdown-item" href="${appRoot}/member/pay2">캐시 충전</a>
									<div class="dropdown-divider"></div>
								</sec:authorize>
								<a class="dropdown-item" href="${appRoot}/logout">로그아웃</a>
							</div>
						</div>
					</li>
				</sec:authorize>
			</ul>
		</nav>
	</div>
	<div id="team-header-below" class="mx-auto mt-2 pb-2">
		<ul class="nav nav-fill">
			<li class="nav-item">
				<a id="nav-home" class="nav-link text-dark" href="${appRoot}/main">홈</a>
				<span id="nav-home-underline" class=""></span>
			</li>
			<li class="nav-item">
				<a id="nav-webtoon" class="nav-link text-dark" href="${appRoot}/product/webtoon/list">웹툰</a>
				<span id="nav-webtoon-underline" class=""></span>
			</li>
			<li class="nav-item">
				<a id="nav-webnovel" class="nav-link text-dark" href="${appRoot}/product/webnovel/list">웹소설</a>
				<span id="nav-webnovel-underline" class=""></span>
			</li>
			<li class="nav-item">
				<a id="nav-book" class="nav-link text-dark" href="${appRoot}/product/book/list">책</a> 
				<span id="nav-book-underline" class=""></span>
			</li>
			<li class="nav-item">
				<a id="nav-board" class="nav-link text-dark" href="${appRoot}/board/list">게시판</a> 
				<span id="nav-board-underline" class=""></span>
			</li>
			<%--
			<li class="nav-item">
				<a id="nav-help" class="nav-link text-dark" href="${appRoot}/help/main">고객센터</a>
				<span id="nav-help-underline" class=""></span>
			</li>
			--%>
			<li class="nav-item">
				<a id="dropdownMenuLink" class="nav-link text-dark" href="" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">고객센터</a>
				<span id="nav-help-underline" class=""></span>
				
				<div id="dropdown-menu" class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenuLink">
					<sec:authorize access="!isAuthenticated()">
						<a class="dropdown-item" href="${appRoot}/help/map">찾아오시는 길</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_USER')">
						<a class="dropdown-item" href="${appRoot}/help/list">1:1 문의하기</a>
						<div class="dropdown-divider"></div>
						<a class="dropdown-item" href="${appRoot}/help/map">찾아오시는 길</a>
					</sec:authorize>
					<sec:authorize access="hasRole('ROLE_ADMIN')">
						<a class="dropdown-item" href="${appRoot}/help/admin">1:1 문의관리</a>
					</sec:authorize>
				</div>
			</li>
		</ul>
	</div>
</div>