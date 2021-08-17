<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="pj" tagdir="/WEB-INF/tags"%>

<!DOCTYPE html>
<html>
<head>

<%@ include file="/WEB-INF/subModules/bootstrapHeader.jsp"%>

<title>회원 가입ㅣLeeBook</title>
<script>
	$(function() {
		var canUseId = false;
		var passwordConfirm = false;

		// 아이디 중복 확인
		$("#id-dup-btn").click(function() {
			var idVal = $("#signup-input1").val();
			var messageElem = $("#id-message");
			messageElem.css("color", "black");
			canUseId = false;
			toggleEnableSubmit();

			if (idVal == "") {
				// 아이디가 입력되지 않았을 때
				messageElem.text("아이디를 입력해주세요.");

			} else {
				// 아이디가 입력되어있을 때
				var data = {
					id : idVal
				};
				$.ajax({
					type : "get",
					url : "${appRoot}/member/dup",
					data : data,
					success : function(data) {
						if (data == "success") {
							console.log("사용 가능한 아이디");
							canUseId = true;
							messageElem.text("사용가능한 아이디 입니다.");
						} else if (data == "exist") {
							console.log("사용 불가능한 아이디");
							messageElem.css("color", "red");
							messageElem.text("이미 있는 아이디 입니다.");
						}

						toggleEnableSubmit();
					},
					error : function() {
						console.log("아이디 중복 체크 실패");
					}

				});
			}
		})

		var authurl = "${appRoot}" + "/member/authNumber";

		$("#mail-regularly")
				.click(
						function() {
							var idE = $("#singup-mail").val();

							$re = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
							if (!$re.test(idE)) {
								alert("정확한 형식의 Email을 입력해 주세요");
								$("#singup-mail").focus();
								return false;
							}

							$.post(authurl, {
								idE : idE
							}, function(data) {
								if (data == 'ok1') {
									$("#singup-mail-e").removeAttr("hidden");
								} else {

								}
							});
						});

		$("#mail-regularly").click(function() {

			$("#singup-mail-btn").click(function() {
				var idI = $("#singup-mail-input").val();
				$.post(authurl, {
					idI : idI
				}, function(data) {
					if (data == 'ok2') {
						console.log("인증번호 맞습니다!");
						alert("인증되었습니다!");
						$("#signup").removeAttr("hidden");
					} else {
						console.log("인증번호 틀립니다");
						alert("틀린 인증번호 입니다.");
						$("#singup-mail-input").focus();
					}
				});
			});
		});

		// 패스워드 확인
		$("#signup-input2, #signup-input4").keyup(function() {
			var pw1 = $("#signup-input2").val();
			var pw2 = $("#signup-input4").val();
			var submitBtn = $("#signup-btn1");
			passwordConfirm = false;

			if (pw1 != pw2) {
				$("#password-message").text("패스워드가 일치하지 않습니다.");
			} else {
				if (pw1 == "") {
					$("#password-message").text("패스워드를 입력해주세요.");
				} else {
					passwordConfirm = true;
					$("#password-message").empty();
				}

			}

			// submit 버튼 disable/enalbe 토글
			toggleEnableSubmit();
		});

		function toggleEnableSubmit() {
			if (passwordConfirm && canUseId) {
				$("#signup-btn1").removeAttr("disabled");
			} else {
				$("#signup-btn1").attr("disabled", "disabled");
			}
		}
	});
</script>


</head>
<body>
<pj:navbar />
	<div id="div-signup" class="container mt-5">
		<c:if test="${not empty param.error }">
			<div id="alert1" class="alert alert-danger" role="alert">회원 가입에
				실패하였습니다.</div>
		</c:if>

		<h2>회원 가입</h2>
		
		<br>
		
		<div class="row">
			<div class="col-12">
				<form method="post" action="${appRoot }/member/signup">
					<div class="form-group">
						<label for="signup-input1">아이디</label>
						<div class="input-group">
							<input type="text" class="form-control" id="signup-input1"
								name="userid">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" type="button"
									id="id-dup-btn">아이디 중복 체크</button>
							</div>
						</div>
						<small id="id-message" class="form-text"></small>

					</div>
					<div class="form-group">
						<label for="signup-input2">패스워드</label> <input type="password"
							class="form-control" id="signup-input2" name="userpw">
					</div>
					<div class="form-group">
						<label for="signup-input4">패스워드 확인</label> <input type="password"
							class="form-control" id="signup-input4"> <small
							id="password-message" class="form-text text-danger"></small>
					</div>
					<div class="form-group">
						<label for="signup-input3">이름</label> <input type="text"
							class="form-control" id="signup-input3" name="userName">
					</div>
					<div class="form-group">
						<label for="signup-input3">전화번호</label> <input type="text"
							class="form-control" id="signup-tel" name="tel">
					</div>
					<div class="form-group">
					<label for="signup-input3">주소</label> <input type="text"
							class="form-control" id="signup-addr" name="addr">
					</div>

					<div class="form-group">
						<label for="singup-mail">이메일</label>
					<div class="input-group">

					<input type="text" class="form-control" id="singup-mail" name="usermail" title="Email">
					<div class="input-group-append">
					<button style="display: inline;" class="btn btn-outline-secondary" id="mail-regularly" type="button">인증메일 발송</button>
							</div>
						</div>

					</div>
					<div hidden class="form-group" id="singup-mail-e">
					<label for="singup-mail-input">인증번호</label>
						<div class="input-group">
							<input type="text" class="form-control" name="inz"
								id="singup-mail-input">
							<div class="input-group-append">
								<button class="btn btn-outline-secondary" id="singup-mail-btn"
									type="button">인증</button>
							</div>
						</div>
					</div>
					<button disabled type="submit" class="btn btn-primary"
						id="signup-btn1">회원 가입</button>
				</form>
			</div>
		</div>
	</div>
<pj:footer />
</body>
</html>