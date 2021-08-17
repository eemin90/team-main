package org.team.service.member;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team.domain.member.AuthVO;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductVO;
import org.team.mapper.member.MemberMapper;
import org.team.mapper.product.ProductLikeMapper;
import org.team.mapper.product.ProductPaidMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductLikeMapper likeMapper;
	
	@Setter(onMethod_ = @Autowired)
	private ProductPaidMapper paidMapper;
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder encoder;
	
	@Override
	@Transactional
	public boolean insert(MemberVO vo) {

		// 패스워드 암호화
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		int cnt = mapper.insert(vo);
		
		// 권한 입력
		AuthVO avo = new AuthVO();
		avo.setUserid(vo.getUserid());
		avo.setAuth("ROLE_USER");
		mapper.insertAuth(avo);
		
		return cnt == 1;
	}
	
	@Override
	public MemberVO read2(String username, String usermail) {
		return mapper.read2(username, usermail);
	}
	
	@Override
	public MemberVO read3(String userid, String username, String usermail) {
		
		return mapper.read3(userid, username, usermail);
	}
	
	@Override
	public void setPw(String pw, String userid) {
		mapper.setPw(pw, userid);
	}
	
	@Override
	public MemberVO read(String name) {

		return mapper.read(name);
	}
	
	@Override
	public boolean modify(MemberVO vo, String oldPassword) {
		MemberVO old = mapper.read(vo.getUserid());
		
		if(encoder.matches(oldPassword, old.getUserpw())) {
			return modify(vo);
		}
		return false;
	}
	@Override
	public boolean modify(MemberVO vo) {
		
		vo.setUserpw(encoder.encode(vo.getUserpw()));
		
		int cnt = mapper.update(vo);
		
		return cnt == 1;
	}
	@Override
	public boolean remove(MemberVO vo, String oldPassword) {
		MemberVO old = mapper.read(vo.getUserid());
		if(encoder.matches(oldPassword, old.getUserpw())) {
		
			return remove(vo);
		}
		return false;
	}
	
	@Override
	@Transactional
	public boolean remove(MemberVO vo) {
		// 권한삭제tbl_member_auth
		mapper.removeAuth(vo);
		
		// 회원삭제(tbl_member)
		int cnt = mapper.remove(vo);
		return cnt == 1;
	}
	
	// 카카오톡 승인 요청 메소드
	@Override
	public boolean approve(String pgToken) throws Exception {
		
		// 전송 예
		/*
		curl -v -X POST "https://kapi.kakao.com/v1/payment/approve" 
		-H "Authorization:KakaoAK 7f7a3db05ac89ff129a3c77b81917a58" 
		--data-urlencode "cid=TC0ONETIME" 
		--data-urlencode "tid=T2921815292100982120" 
		--data-urlencode "partner_order_id=partner_order_id" 
		--data-urlencode "partner_user_id=partner_user_id" 
		--data-urlencode "pg_token=726dcdd498d65952f132"
		*/
		
		String uri = "https://kapi.kakao.com/v1/payment/approve";
		// request
		HttpPost post = new HttpPost(uri);
		
		// header
		post.addHeader("Authorization", "KakaoAK 7f7a3db05ac89ff129a3c77b81917a58");
		
		// parameter
		List<NameValuePair> urlParameters = new ArrayList<>();
        urlParameters.add(new BasicNameValuePair("pg_token", pgToken));
        urlParameters.add(new BasicNameValuePair("partner_user_id", "partner_user_id"));
        urlParameters.add(new BasicNameValuePair("partner_order_id", "partner_order_id"));
        urlParameters.add(new BasicNameValuePair("tid", "T2921815292100982120"));
        urlParameters.add(new BasicNameValuePair("cid", "TC0ONETIME"));
        
        post.setEntity(new UrlEncodedFormEntity(urlParameters));

        // send request
        CloseableHttpClient httpClient = HttpClients.createDefault();
        CloseableHttpResponse response = httpClient.execute(post);
		
		// handle response
        log.info(response.getStatusLine());
        log.info(EntityUtils.toString(response.getEntity()));
        
        int statusCode = response.getStatusLine().getStatusCode();
        
        if (statusCode / 100 == 2) {
        	return true;
        }
        
		return false;
  }
  
	@Override
	public List<ProductVO> getLikes(String userid) {
		return likeMapper.getLikes(userid);
	}
	
	@Override
	public List<ProductVO> getWebtoonLikes(String userid) {
		return likeMapper.getWebtoonLikes(userid);
	}
	
	@Override
	public List<ProductVO> getWebnovelLikes(String userid) {
		return likeMapper.getWebnovelLikes(userid);
	}
	
	@Override
	public List<ProductVO> getBookLikes(String userid) {
		return likeMapper.getBookLikes(userid);
	}

	@Override
	public int method(MemberVO vo) {
		log.info("*** Service in ckeck ***");
		
		return mapper.insert2(vo);
	}
	@Override
	public List<ProductVO> getPaidList(String userid) {
		return paidMapper.getPaidList(userid);
	}
	
	@Override
	public List<ProductVO> getPaidListWebtoon(String userid) {
		return paidMapper.getPaidListWebtoon(userid);
	}
	
	@Override
	public List<ProductVO> getPaidListWebnovel(String userid) {
		return paidMapper.getPaidListWebnovel(userid);
	}
	
	@Override
	public List<ProductVO> getPaidListBook(String userid) {
		return paidMapper.getPaidListBook(userid);
	}
}
