package org.team.service.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductPaidVO;
import org.team.domain.product.ProductVO;
import org.team.mapper.member.MemberMapper;
import org.team.mapper.product.ProductPaidMapper;

import lombok.Setter;

@Service
public class ProductPaidServiceImpl implements ProductPaidService {

	@Setter(onMethod_ = @Autowired)
	private ProductPaidMapper mapper;
	
	@Setter(onMethod_ = @Autowired)
	private MemberMapper memberMapper;
	
	@Override
	public ProductPaidVO getPaid(String id, String userid) {
		return mapper.getPaid(id, userid);
	}

	@Override
	@Transactional
	public int buy(ProductPaidVO vo) {
		// 현재 사용자의 잔여캐시
		MemberVO mvo = memberMapper.readMoney(vo);
		Long userMoney = mvo.getMoney();
		// 해당 상품의 가격
		ProductVO pvo = mapper.readPrice(vo);
		Long pprice = pvo.getProduct_price();
		
		// 현재 사용자의 잔여캐시가 해당 상품의 가격보다 많거나 같은 경우 구매 실행
		if (userMoney >= pprice) {
			// 사용자의 잔여캐시에서 해당 상품의 가격을 빼고
			memberMapper.buyProduct(vo);
			// 해당 상품을 구매했다는 기록을 남김
			return mapper.buy(vo);
		} else {
			return 0;
		}
	}
	
	@Override
	public MemberVO getUserMoney(String userid) {
		return memberMapper.read(userid);
	}
}
