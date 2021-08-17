package org.team.service.member;

import java.util.List;
import java.util.Map;

import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductVO;

public interface MemberService {

	boolean insert(MemberVO vo);

	MemberVO read(String name);
	
	boolean modify(MemberVO vo);

	boolean remove(MemberVO vo);

	boolean remove(MemberVO vo, String oldPassword);

	boolean modify(MemberVO vo, String oldPassword);
	
	public MemberVO read2(String username, String usermail);
	
	public MemberVO read3(String userid, String username, String usermail);

	boolean approve(String pgToken) throws Exception;

	public List<ProductVO> getLikes(String userid);
	
	public List<ProductVO> getWebtoonLikes(String userid);
	
	public List<ProductVO> getWebnovelLikes(String userid);
	
	public List<ProductVO> getBookLikes(String userid);

	public void setPw(String pw, String userid);

	public int method(MemberVO vo);

}
