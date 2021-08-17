$(function() {
	/*
	// 마우스 우클릭, 드래그 차단
	$(document).on("contextmenu dragstart selectstart", function(e){
        return false;
    });
	*/
	
	// login.jsp 로그인 상태 유지 label에 마우스 enter, leave 일때 tooltip 
	$('#remember-warning').on({
		mouseenter: function() {
			$('#remember-warning').tooltip('show');
		},
		mouseleave: function() {
			$('#remember-warning').tooltip('hide');
		}
	});
	
	// navbar 검색창의 검색 아이콘 클릭해도 submit 시키기
	$('#search-icon').click(function() {
		$('#search-form').submit();
	});
	
	// navbar 검색창 focus in, out
	$('#navbar-search-input').on({
		focus: function() {
			$('#navbar-search-input').css('border-radius', '15px 0 0 0');
			$('#navbar-search-icon').css('border-radius', '0 15px 0 0');
			$('#search-rank').removeAttr('hidden');
		},
		blur: function() {
			$('#navbar-search-input').css('border-radius', '25px 0 0 25px');
			$('#navbar-search-icon').css('border-radius', '0 25px 25px 0');
			$('#search-rank').attr('hidden', 'hidden');
		}
	});
	
	// navbar 검색 TOP 5 항목에 마우스 올리거나 내리면 색상 변경, 선택한 keyword로 검색하기
	$('#search-rank-list-keyword1, #search-rank-list-keyword2, #search-rank-list-keyword3, #search-rank-list-keyword4').on({
		mouseenter: function() {
			$(this).css('background-color', 'rgb(233, 236, 239)');
		},
		mouseleave: function() {
			$(this).css('background-color', 'white');
		},
		mousedown: function(e) {
			e.preventDefault();
			var keyword = $(this).text();
			$('#navbar-search-input').val(keyword);
			$('#search-form').submit();
		}
	});
	
	// navbar 검색 TOP 5 항목에 마우스 올리거나 내리면 색상 변경, 선택한 keyword로 검색하기(제일 아래 키워드 mouseenter시 검색창 하단 형태가 변형되는 문제 때문에 따로 border-radius 적용)
	$('#search-rank-list-keyword5').on({
		mouseenter: function() {
			$(this).css('background-color', 'rgb(233, 236, 239)');
			$(this).css('border-radius', '0 0 15px 15px');
		},
		mouseleave: function() {
			$(this).css('background-color', 'white');
		},
		mousedown: function(e) {
			e.preventDefault();
			var keyword = $(this).text();
			$('#navbar-search-input').val(keyword);
			$('#search-form').submit();
		}
	});
	
	// navbar에서 선택한 category를 active 상태로 변경하여 navbar에 현재 category 표시
	var currentUrl = document.location.href.split('http://13.125.228.102/');
	var splitUrl = currentUrl[1];
	
	switch (splitUrl) {
		case 'team/main':
			$(function() {
				$('#nav-home-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/product/webtoon/list':
			$(function() {
				$('#nav-webtoon-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/product/webnovel/list':
			$(function() {
				$('#nav-webnovel-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/product/book/list':
			$(function() {
				$('#nav-book-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/board/list':
			$(function() {
				$('#nav-board-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/help/main':
			$(function() {
				$('#nav-help-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/help/list':
			$(function() {
				$('#nav-help-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
		case 'team/help/map':
			$(function() {
				$('#nav-help-underline').addClass('active').animate({width: '100%'}, 600);
			});
			break;
	}
	
	// 찜 목록에서 카테고리 이동
	$('#likes-webtoon-btn').click(function() {
		$('#form-likes-list')
		.attr('action', getContextPath() + "/member/likesWebtoon")
		.submit();
	});
	$('#likes-webnovel-btn').click(function() {
		$('#form-likes-list')
		.attr('action', getContextPath() + "/member/likesWebnovel")
		.submit();
	});
	$('#likes-book-btn').click(function() {
		$('#form-likes-list')
		.attr('action', getContextPath() + "/member/likesBook")
		.submit();
	});
	
	// navbar dropdown 구매 목록 버튼 실행
	$('#dropdown-paid').click(function() {
		$('#form-dropdown')
		.attr('action', getContextPath() + "/member/paidList")
		.submit();
	});
	
	// 구매 목록에서 카테고리 이동
	$('#paid-webtoon-btn').click(function() {
		$('#form-paid-list')
		.attr('action', getContextPath() + "/member/paidListWebtoon")
		.submit();
	});
	$('#paid-webnovel-btn').click(function() {
		$('#form-paid-list')
		.attr('action', getContextPath() + "/member/paidListWebnovel")
		.submit();
	});
	$('#paid-book-btn').click(function() {
		$('#form-paid-list')
		.attr('action', getContextPath() + "/member/paidListBook")
		.submit();
	});
	
	// get.jsp에서 detail.jsp로 URL 조작하여 이동 방지(해당 상품 구매X, 정기권X 인 경우에도 URL만 수정하여 접근 가능한 부분이 있어서 접근 불가하게)
	var checkUrl = splitUrl.split('?')[0];
	var paidCheck = $('#check-paid').val(); // 해당 상품을 구매한 적이 있는지 체크
	var auth = $('#user-auth').val();		// 현재 사용자 권한
	
	if ((checkUrl == 'team/product/webtoon/detail') || (checkUrl == 'team/product/webnovel/detail') || (checkUrl == 'team/product/book/detail')) {
		// 해당 URL에 접근했을 때 정기권을 구매하지 않았고([ROLE_USER]), 해당 상품을 구매한적이 없으면(paidCheck != '1') alert 발생하고 페이지 뒤로가기 실행
		if ((auth == '[ROLE_USER]') && (paidCheck != '1')) {
			alert('해당 방식의 접근은 불가합니다.\n해당 상품을 구매하거나, 정기권을 구매하여 이용해주세요.');
			history.back();
		}
	}
	
	// 각 상품의 get.jsp에서 로그인이 되어있지 않은 경우 작품보기 버튼에 마우스 올리면 로그인 해주세요 표시
	$('#not-logined').on({
		mouseenter: function() {
			$('#not-logined').tooltip('show');
		},
		mouseleave: function() {
			$('#not-logined').tooltip('hide');
		}
	});
	
	// 현재 각 상품 detail 페이지인 경우만 navbar1에서 product_name 표시
	var splitUrl1 = splitUrl.split('?');
	var splitUrl2 = splitUrl1[0];
	
	if ((splitUrl2 == 'team/product/webtoon/get') || (splitUrl2 == 'team/product/webnovel/get') || (splitUrl2 == 'team/product/book/get')) {
		$('#navbar-product').attr('hidden', 'hidden');
	} else {
		$('#navbar-product').removeAttr('hidden');
	}
	
	// top 5 carousel의 첫번째 항목의 class에 active를 추가함(active가 딱 1개인 경우만 carousel이 동작하는데, carousel을 c:forEach로 생성시켰기 때문에 active를 1개만 줄 수 없어서 작성함)
	$('.carousel-inner div').filter(':first').addClass('active');
	
	// contextPath 구하기
	function getContextPath(){
	    var hostIndex = location.href.indexOf( location.host ) + location.host.length;
	    var contextPath = location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
	    return contextPath;
	}
	
	// 상태 modal
	if (history.state == null) {
		$('#stateModal').modal('show');
		history.replaceState({}, null);
	}
	
	// 뒤로가기 버튼
	$('#back-btn').click(function() {
		history.back();
	});
	
	// ADMIN 작품 등록
	$('#product-register-btn').click(function(e) {
		e.preventDefault();
		
		var category = $('#product-register-input1').val();
		var genre = $('#product-register-input2').val();
		var title = $('#product-register-input3').val();
		var writer = $('#product-register-input4').val();
		var price = $('#product-register-input5').val();
		var cover = $('#product-register-input6').val();
		var file = $('#product-register-input7').val();
		
		if ((genre != '') && (title != '') && (writer != '') && (price != '') && (cover != '') && (file != '')) {
			if (category == '1') {
				$("#product-register-form")
				.attr("action", getContextPath() + "/product/webtoon/register")
				.submit();
			} else if (category == '2') {
				$("#product-register-form")
				.attr("action", getContextPath() + "/product/webnovel/register")
				.submit();
			} else if (category == '3') {
				$("#product-register-form")
				.attr("action", getContextPath() + "/product/book/register")
				.submit();
			} else {
				alert('카테고리를 선택해주세요!');
			}
		} else {
			alert('입력란을 작성해주세요!');
		}
	});
	
	// ADMIN 웹툰 삭제
	$('#webtoon-remove-btn').click(function(){
		if (confirm("삭제 하시겠습니까?")) {
			$('#webtoon-modify-form')
			.attr('action', getContextPath() + "/product/webtoon/remove")
			.submit();
		}
	});
	
	// ADMIN 웹소설 삭제
	$('#webnovel-remove-btn').click(function(){
		if (confirm("삭제 하시겠습니까?")) {
			$('#webnovel-modify-form')
			.attr('action', getContextPath() + "/product/webnovel/remove")
			.submit();
		}
	});
	
	// ADMIN 책 삭제
	$('#book-remove-btn').click(function(){
		if (confirm("삭제 하시겠습니까?")) {
			$('#book-modify-form')
			.attr('action', getContextPath() + "/product/book/remove")
			.submit();
		}
	});
	
});