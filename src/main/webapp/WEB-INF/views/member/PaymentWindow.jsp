<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>Insert title here</title>

<style>
span {
	width: 60px;
	display: inline-block;
}

textarea {
	width: 40%;
	height: 280px;
}
</style>
</head>
<body>
	<pj:navbar />
	<div class="container">
		<h2>일반 결제</h2>
		
		<form action="inicis">
			<!-- 값 가져오기 -->
			<p> <span>name:</span> <input name="name" > </p>
			<p> <span>이메일:</span> <input name="email"> </p>
			<p> <span>폰넘버:</span> <input type="text" name="phone"> </p>
			<p> <span>주소:</span> <input name="address"> </p>
			<p> <span>총가격:</span> <input name="totalPrice" > </p>
			<input type="submit" value="결제하기" > <input type="reset" value="취소하기">
		</form>

	</div>
	<pj:footer />
</body>
</html>