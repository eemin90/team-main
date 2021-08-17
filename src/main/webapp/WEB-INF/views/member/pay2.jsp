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
        
        var IMP = window.IMP;
        IMP.init('imp35363577');
        var money = $('input[name="cp_item"]:checked').val();
        console.log(money);

        IMP.request_pay({
            pg: 'html5_inicis',
            merchant_uid: 'merchant_' + new Date().getTime(),
            name: money + '캐시',
            amount: money,
            buyer_email: ${member.usermail },
            buyer_name: ${member.userid },
            buyer_tel: ${member.tel},
            buyer_postcode: '123-456'
        }, function (rsp) {
            console.log(rsp);
            if (rsp.success) {
                var msg = '결제가 완료되었습니다.';
                msg += '고유ID : ' + rsp.imp_uid;
                msg += '상점 거래ID : ' + rsp.merchant_uid;
                msg += '결제 금액 : ' + rsp.paid_amount;
                msg += '카드 승인번호 : ' + rsp.apply_num;
                $.ajax({
                    type: "post", 
                    url: "${appRoot}/pay/point", //충전 금액값을 보낼 url 설정
	                data: JSON.stringify({
                        "money" : money,
                        "userid" : ${member.userid }
                    }),
					contentType: 'application/json',
					success: function() {
						console.log("성공");
					},
					error: function() {
						console.log("실패");
					}

                });
            } else {
                var msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/member/fail";
                alert(msg);
            }
            alert(msg);
            document.location.href="<%=request.getContextPath()%>/main";
        });
    });         
    </script>



</body>
</html>