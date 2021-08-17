<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags" %>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp" %>

<title>비밀번호 찾기ㅣLeeBook</title>


</head>
<body>
<pj:navbar />
<div id="div-findpw" class="container mt-5">
    <h2>비밀번호 찾기</h2>

    <br>

		<form action="${appRoot}/member/findpw" method="post">
			<div class="form-group">
				<label for="findid-userid">아이디</label>
				<div class="input-group">
					<input type="text" id="findid-userid" class="form-control" name="userid" />
				</div>
			</div>
			<div class="form-group">
				<label for="findid-username">이름</label>
				<div class="input-group">
					<input type="text" id="findid-username" class="form-control" name="username" />
				</div>
			</div>
			<div class="form-group">
				<label for="findid-usermail">이메일</label>
				<div class="input-group">
					<input type="text" id="findid-usermail" class="form-control" name="usermail" />
				</div>
			</div>
			<input class="btn btn-primary" type="submit" id="gogofindid" value="찾기">
		</form>

		<div id="resultid">
			<h3>${userpw}</h3>
		</div>
	
</div>
<pj:footer />
</body>
</html>