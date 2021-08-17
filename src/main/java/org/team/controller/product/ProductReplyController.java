package org.team.controller.product;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.team.domain.product.ProductReplyVO;
import org.team.service.product.ProductReplyService;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/product/replies")
@AllArgsConstructor
public class ProductReplyController {

	private ProductReplyService service;
	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> register(@RequestBody ProductReplyVO vo) {
		int cnt = service.register(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@PostMapping("/detail/register")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> registerDetail(@RequestBody ProductReplyVO vo) {
		int cnt = service.registerDetail(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@GetMapping("/pages/{product_id}")
	public List<ProductReplyVO> list(@PathVariable Long product_id) {
		return service.getList(product_id);
	}
	
	@GetMapping("/detail/pages/{product_id}")
	public List<ProductReplyVO> listDetail(@PathVariable Long product_id) {
		return service.getListDetail(product_id);
	}
	
	@GetMapping("/{id}")
	public ProductReplyVO get(@PathVariable Long id) {
		return service.get(id);
	}
	
	@GetMapping("/detail/{id}")
	public ProductReplyVO getDetail(@PathVariable Long id) {
		return service.getDetail(id);
	}
	
	@RequestMapping(value = "/{id}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody ProductReplyVO vo, @PathVariable Long id) {
		int cnt = service.modify(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@RequestMapping(value = "/detail/{id}", method = {RequestMethod.PUT, RequestMethod.PATCH})
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modifyDetail(@RequestBody ProductReplyVO vo, @PathVariable Long id) {
		int cnt = service.modifyDetail(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
	@DeleteMapping("/{id}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> remove(@RequestBody ProductReplyVO vo, @PathVariable Long id) {
		int cnt = service.remove(id);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	@DeleteMapping("/detail/{id}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> removeDetail(@RequestBody ProductReplyVO vo, @PathVariable Long id) {
		int cnt = service.removeDetail(id);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
