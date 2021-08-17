// get.jsp 상품 구매 기능
$(function() {
	// 해당 상품명
	var productName = $('#pname').text();
	
	// 해당 상품 가격
	var productPrice = parseInt($('#pprice').text());
	
	// 현재 사용자 잔여캐시
	var userMoney = parseInt($('#user-money').val());

	// 해당 상품을 구매한 적이 있는지 체크
	var paidCheck = $('#check-paid').val();
	
	// 현재 사용자 권한
	var auth = $('#user-auth').val();
	
	// 'data'로 넘길 값들
	var pid = $('#like-product-id').val();
	var uid = $('#like-user-id').val();
	var price = $('#pprice').text();
	var data = {
		product_id: pid,
		user_id: uid,
		price: price
	};
	
	// 현재 사용자 권한이 [ROLE_ADMIN] 또는 [ROLE_PASS]이거나 해당 상품을 구매한 적이 있으면 작품보기 버튼 표시
	if ((auth == '[ROLE_ADMIN]') || (auth == '[ROLE_PASS]') || (paidCheck == '1')) {
		$('#buy-btn').attr('hidden', 'hidden');
		$('#detail-btn').removeAttr('hidden');
	} else {
		// 현재 사용자 권한이 [ROLE_USER]이면서 해당 상품을 구매한 적이 없는 경우 구매 버튼 표시
		$('#detail-btn').attr('hidden', 'hidden');
		$('#buy-btn').removeAttr('hidden');
	}
	
	// 구매 버튼 클릭시
	$('#buy-btn').click(function() {
		if (confirm('"' + productName + '"' + ' 상품을 구매 하시겠습니까?')) {
		
			$.ajax({
				type: 'post',
				url: appRoot + '/product/paid/buy',
				data: JSON.stringify(data),
				contentType: 'application/json',
				success: function() {
					alert('구매 완료되었습니다.\n현재 잔여캐시는 ' + (userMoney - productPrice) + '원 입니다.\n감사합니다.');
					// 페이지 새로고침
					location.reload(true);
				},
				error: function() {
					alert("캐시가 부족합니다.");
				}
			});
		}
	});
});