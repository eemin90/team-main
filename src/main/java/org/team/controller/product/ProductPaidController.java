package org.team.controller.product;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.team.domain.product.ProductPaidVO;
import org.team.service.product.ProductPaidService;

import lombok.AllArgsConstructor;

@RestController
@RequestMapping("/product/paid")
@AllArgsConstructor
public class ProductPaidController {
	
	private ProductPaidService service;
	
	@PostMapping("/buy")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> buy(@RequestBody ProductPaidVO vo) {
		int cnt = service.buy(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
