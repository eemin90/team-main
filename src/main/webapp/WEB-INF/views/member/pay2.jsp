<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>


</head>
<body>

 <div class="card-body bg-white mt-0 shadow">
                <p style="font-weight: bold">일반 결제</p>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="5000"><span>5,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="10000"><span>10,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="15000"><span>15,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="20000"><span>20,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="25000"><span>25,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="30000"><span>30,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="35000"><span>35,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="40000"><span>40,000원</span></label>
                <label class="box-radio-input"><input type="radio" name="cp_item" value="50000"><span>50,000원</span></label>
                <p  style="color: #ac2925; margin-top: 30px">일반결제의 최소 충전금액은 5,000원이며 <br/>최대 충전금액은 50,000원 입니다.</p>
                <button type="button" class="btn btn-lg btn-block  btn-custom" id="charge_kakao">충 전 하 기</button>
 </div>


<script>
    $('#charge_kakao').click(function () {
        // getter
        
        var IMP = window.IMP;
        IMP.init('imp35363577');
        var money = $('input[name="cp_item"]:checked').val();
        console.log(money);

        IMP.request_pay({
            pg: 'html5_inicis',
            merchant_uid: 'merchant_' + new Date().getTime(),

            name: money + '캐쉬',
            amount: money,
            buyer_email: ${member.usermail },
            buyer_name: ${member.userid },
            buyer_postcode: '123-456'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
				let purchaseVo = {
						m_email: ${member.usermail },
						s_name: ${member.username },
						s_addr: ${member.addr},
						s_phone: ${member.tel},
						s_msg: s_msg,
						s_zipNo: s_zipNo,
						o_shipno: rsp.merchant_uid,
						o_paidAmount: rsp.paid_amount,
						o_paytype: rsp.pay_method
						}
					// 컨트롤러에 데이터를 전달하여 DB에 입력하는 로직
	                		// 결제내역을 사용자에게 보여주기 위해 필요함.
	               			$.ajax({
						url : "placeorder.do",
						type : "get",
						data : purchaseVo,
						dataType : "text",
						success : function(result){
							if(result == "y") {
								alert(msg);
								location.href = "orderComplete.do"; 
							}else{
								alert("디비입력실패");
								return false;
							}
						},
						error : function(a,b,c){}
					});
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
            }
            alert(msg);
            document.location.href="<%=request.getContextPath()%>/member/fail"; //alert창 확인 후 이동할 url 설정
        });
    });
</script>



</body>
</html>