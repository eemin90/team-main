<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>로그인ㅣLeeBook</title>
</head>
<body>
<pj:navbar />

<div id="div-login" class="container mt-5">

	<h2>로그인</h2>
	
	<br>

	<form action="${appRoot}/login" method="post">
		<div class="form-group">
			<input id="login-input1" class="form-control" name="username" placeholder="아이디" required />
		</div>
		<div class="form-group">
			<input id="login-input2" type="password" class="form-control" name="password" placeholder="비밀번호" required />
		</div>

		<div id="remember-form" class="form-group form-check">
			<input name="remember-me" type="checkbox" class="form-check-input" id="checkbox1">
			<label id="remember-warning" class="form-check-label" for="checkbox1" data-toggle="tooltip" data-placement="right" title="개인정보 보호를 위해&emsp;&emsp;&emsp;&emsp;개인 기기에서만 사용해 주세요.">로그인 상태 유지</label>
		</div>
		
		<input class="btn btn-primary btn-block" type="submit" value="로그인">
	</form>

	<hr>

	<div id="div-login" class="container">
		<div class="row">
			<a href="${appRoot}/member/signup" class="col-3 mr-auto login-left text-muted">회원가입</a>
			<div class="row">
				<a href="${appRoot}/member/findid" class="col login-right-id text-muted">아이디 찾기</a>
				<span id="login-divider" class="text-muted"><small>&nbsp;ㅣ&nbsp;</small></span>
				<a href="${appRoot}/member/findpw" class="col login-right-pw text-muted">비밀번호 찾기</a>
			</div>
		</div>
	</div>

</div>

<pj:footer />
</body>
</html>