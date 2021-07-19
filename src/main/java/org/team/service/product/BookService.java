package org.team.service.product;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;
import org.team.domain.product.ProductVO;

public interface BookService {

	public List<ProductVO> getList();
	
	public ProductVO get(Long id);

	public void register(ProductVO product, MultipartFile file1, MultipartFile file2);

	public boolean modify(ProductVO product, MultipartFile file1, MultipartFile file2);

	public boolean remove(Long id);

}
