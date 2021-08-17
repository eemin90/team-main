package org.team.controller.member;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/jq")
@AllArgsConstructor
@Log4j
public class PayController2 {
	
	@RequestMapping("/kakaopay")
	@ResponseBody
	public String kakaopay() {
		try {
			URL ae = new URL("https://kapi.kakao.com/v1/payment/ready");	// URL 정의
			HttpURLConnection sc = (HttpURLConnection) ae.openConnection(); // 요청보내고 요청받는곳(kakaoPay)을 연결
			sc.setRequestMethod("POST");                                    // 만들어 둔 서버연결의 통신방식 결정
			sc.setRequestProperty("Authorization", "KakaoAK 7f7a3db05ac89ff129a3c77b81917a58");			// 인증정보
			sc.setRequestProperty("Content-type", "application/x-www-form-urlencoded;charset=utf-8"); 	//컨텐츠 타입 정의
			sc.setDoOutput(true); 																		// 서버에 내보낼게 있어서 트루 
			String parameter = "cid=TC0ONETIME&partner_order_id=partner_order_id&partner_user_id=partner_user_id&item_name=5000won&quantity=1&total_amount=1&tax_free_amount=0&approval_url=http://localhost:8080/team/member/pay&cancel_url=http://localhost:8080/team/member/cancel&fail_url=http://localhost:8080/team/member/fail";
			OutputStream op = sc.getOutputStream(); // data 내보내는거
			DataOutputStream dataop = new DataOutputStream(op); // 형변환
			dataop.writeBytes(parameter);  // 데이터 바이트 변환
//			dataop.flush(); // 데이터 가진것을 비운다 = 연결된 곳에 태워보낸다. close 를 쓰면 자동 사용
			dataop.close();
			
			int result = sc.getResponseCode(); // 정의 한주소로 결과가 잘됬나 결과를 인트로 받음
			
			InputStream ip;
			if(result == 200) {//정상 결과가 200 그 외에는 전부 에러 
				ip = sc.getInputStream();
			}else {
				ip = sc.getErrorStream();
			}
			InputStreamReader rd = new InputStreamReader(ip); //받은 결과를 읽어줌
			BufferedReader tft = new BufferedReader(rd); // 형변환 (근대 진짜 BufferedReader가 형변환은 아니고 과정중 형변환)
			
			 return tft.readLine(); 
			
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return "{\"result\":\"NO\"}";
	}
	
	}

