package org.team.service.product;

import org.team.domain.product.ProductLikeVO;

public interface ProductLikeService {

	public int like(ProductLikeVO vo);

	public int dislike(ProductLikeVO vo);

	public void plusCnt(ProductLikeVO vo);

	public void minusCnt(ProductLikeVO vo);

	public ProductLikeVO get(String id, String userid);

}
