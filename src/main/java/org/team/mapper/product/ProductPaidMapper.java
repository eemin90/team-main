package org.team.mapper.product;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.team.domain.product.ProductPaidVO;
import org.team.domain.product.ProductVO;

public interface ProductPaidMapper {

	public ProductPaidVO getPaid(@Param("id") String id, @Param("userid") String userid);

	public int buy(ProductPaidVO vo);

	public ProductVO readPrice(ProductPaidVO vo);

	public List<ProductVO> getPaidList(String userid);

	public List<ProductVO> getPaidListWebtoon(String userid);

	public List<ProductVO> getPaidListWebnovel(String userid);

	public List<ProductVO> getPaidListBook(String userid);

}
