package org.team.controller.member;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductLikeVO;
import org.team.service.member.MemberService;
import org.team.service.product.ProductLikeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/pay")
@AllArgsConstructor
@Log4j
public class PayController {
	
	private MemberService service;
	
	@PostMapping("/point")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> like(@RequestBody MemberVO vo) {
		log.info("**** point in ****");
		log.info(vo);
		
		int cnt = service.method(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	
}