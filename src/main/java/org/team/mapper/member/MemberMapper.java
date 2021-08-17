package org.team.mapper.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.team.domain.member.AuthVO;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductPaidVO;


public interface MemberMapper {
	
	public int insert(MemberVO vo);
	
	public int insertAuth(AuthVO vo);
	
	public MemberVO read(String userid);
	
	public int update(MemberVO vo);

	public int remove(MemberVO vo);
	
	public int removeAuth(MemberVO vo);

	public MemberVO read2(@Param("username") String username, @Param("usermail") String usermail);

	public MemberVO read3(@Param("userid") String userid, @Param("username") String username, @Param("usermail") String usermail);

	public void setPw(@Param("pw") String pw, @Param("userid") String userid);

	public int insert2(MemberVO vo);
  
	public MemberVO readMoney(ProductPaidVO vo);

	public void buyProduct(ProductPaidVO vo);

}
