package org.team.service.product;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.team.domain.product.ProductLikeVO;
import org.team.mapper.product.ProductLikeMapper;

import lombok.Setter;

@Service
public class ProductLikeServiceImpl implements ProductLikeService {

	@Setter(onMethod_ = @Autowired)
	private ProductLikeMapper mapper;

	@Override
	public int like(ProductLikeVO vo) {
		return mapper.like(vo);
	}

	@Override
	public int dislike(ProductLikeVO vo) {
		return mapper.dislike(vo);
	}

	@Override
	public void plusCnt(ProductLikeVO vo) {
		mapper.plusCnt(vo);
	}

	@Override
	public void minusCnt(ProductLikeVO vo) {
		mapper.minusCnt(vo);
	}

	@Override
	public ProductLikeVO get(String id, String userid) {
		return mapper.read(id, userid);
	}
	
}
