/**
 * 
 */
 /**
 * 
 */
 $(function() {
	function showModifyModal(hrno) {
		$.ajax({
			type: "get",
			url: appRoot + "/replies/" + hrno,
			success: function (reply) {
				$("#reply-hrno-input2").val(reply.hrno);
				$("#reply-replyer-input2").val(reply.replyer);
				$("#reply-replyerName-input2").val(reply.replyerName);
				$("#reply-reply-textarea2").text(reply.reply);
				
				// 댓글 작성자와 로그인 유저가 같지 않으면
				// 수정/삭제 버튼 none
				if (userid != reply.replyer) {
					$("#reply-modify-modal")
						.find("#reply-modify-delete-btn-wrapper")
						.hide();
					
					$("#reply-reply-textarea2").attr("readonly", "readonly");	
				} else {
					$("#reply-modify-modal")
						.find("#reply-modify-delete-btn-wrapper")
						.show();
						
					$("#reply-reply-textarea2").removeAttr("readonly");			
				}
				
				$("#reply-modify-modal").modal("show");
			},
			error: function () {
				console.log("댓글 가져오기 실패")
			}
		})
	}
	
	function showReplyList(list) {
		var container = $("#reply-list-container").empty();
		
		for (var reply of list) {
			var replyHTML = `
				<li class="media" id="reply${reply.hrno}" data-hrno="${reply.hrno}">
					<div class="media-body">
						<div class="d-flex justify-content-between">
							<strong class="flex-grow-1 bd-highlight">${reply.replyerName}</strong>
							<small class="bd-highlight text-muted">${new Date(reply.replyDate).toISOString().split("T")[0]}</small><br>
						</div>
						<small>${reply.reply}</small><hr>
					</div>
				</li>
			`;
			var replyComponent = $(replyHTML).click(function() {
				showModifyModal($(this).attr("data-hrno"));
			});
			container.append(replyComponent);
		}			
		/*
		for (var reply of list) {
			var newItem = $("<li>").addClass("media")
									.attr("id", "reply" + reply.hrno)
									.attr("data-hrno", reply.hrno);
			var mediaBody = $("<div>").addClass("media-body");
			newItem.append(mediaBody);
			
			newItem.click(function() {
				showModifyModal($(this).attr("data-hrno"));
			});
			mediaBody.append("<h5 class='my-4'>" + reply.replyer + "</h5>") 
				   .append("<p>" + reply.reply + "</p>")  
//				   .append("<small>" + reply.replyDate + "</small>");
			       .append("<small>" + new Date(reply.replyDate).toISOString().split("T")[0] + "</small>");
			container.append(newItem);
		}
		*/
	}
	/* 댓글 목록 가져오기 */
	function getReplyList() {
		$.ajax({
			type: "get",
			url: appRoot + "/replies/pages/" + helpHno,
			success: function(list) {
				console.log(list);
				showReplyList(list);
			},
			error : function() {
				console.log("댓글 가져오는 중 에러.");
			}
		});
	}
	// 페이지 로딩 후 댓글 목록 가져오는 함수 실행
	getReplyList();
	
	/* 댓글 입력 버튼 처리 */
	$("#reply-insert-btn1").click(function() {
		var hno = $("#reply-hno-input1").val();
		var replyer = $("#reply-replyer-input1").val();
		var reply = $("#reply-reply-textarea1").val();
		
		var data = {
			hno: hno,
			replyer: replyer,
			reply: reply
		};
		
		$.ajax({
			type: "post",
			url: appRoot + "/replies/new",
			data: JSON.stringify(data),
			contentType: "application/json",
			success: function() {
				console.log("입력 성공");
				// 모달창 닫고
				$("#reply-insert-modal").modal('hide');
				// 댓글리스트 가져오고
				getReplyList();
				// 안내 메세지 보여주기
				$("#alert1").text("새 댓글 입력하였습니다.").addClass("show");
			},
			error: function() {
				console.log("입력 실패");
			}
		});
	});
	
	/* 수정 submit 버튼 클릭시 */
	$("#reply-modify-btn1").click(function() {
		var hrno = $("#reply-hrno-input2").val();
		var hno = $("#reply-hno-input2").val();
		var reply = $("#reply-reply-textarea2").val();
		var replyer = $("#reply-replyer-input2").val();
		
		var data = {
			hrno : hrno,
			hno : hno,
			reply: reply,
			replyer: replyer
		}
		
		$.ajax({
			type: "put",
			url: appRoot + "/replies/" + hrno,
			data: JSON.stringify(data),
			contentType : "application/json",
			success: function() {
				console.log("수정 성공");
				// 모달창 닫고
				$("#reply-modify-modal").modal('hide');
				// 댓글리스트 가져오고
				getReplyList();
				
				// 안내 메세지 보여주기
				$("#alert1").text("댓글 수정하였습니다.").addClass("show");
			},
			error: function() {
				console.log("수정 실패");
			}
		})
	});
	
	  /*삭제 버튼 클릭시 */ 
	$("#reply-delete-btn1").click(function() {
		var check = confirm("삭제 하시겠습니까?");
		
		if (check) {
			var hrno = $("#reply-hrno-input2").val();
			var replyer = $("#reply-replyer-input2").val();
		
		var data = {
			hrno : hrno,
			replyer: replyer
		}

			$.ajax({
				type: "delete",
				url: appRoot + "/replies/" + hrno,
				data : JSON.stringify(data),
				contentType : "application/json",
				success: function() {
					console.log("삭제 성공");
					// 모달창 닫고
					$("#reply-modify-modal").modal('hide');
					// 댓글리스트 가져오고
					getReplyList();
					
					// 안내 메세지 보여주기
					$("#alert1").text("댓글 삭제하였습니다.").addClass("show");
				},
				error: function() {
					console.log("삭제 실패");
				}
			})
		}
	});
})