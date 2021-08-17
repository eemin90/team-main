package org.team.service.product;

import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductPaidVO;

public interface ProductPaidService {

	public ProductPaidVO getPaid(String id, String userid);

	public int buy(ProductPaidVO vo);

	public MemberVO getUserMoney(String userid);

}
