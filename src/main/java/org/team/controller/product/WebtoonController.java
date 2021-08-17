package org.team.controller.product;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductLikeVO;
import org.team.domain.product.ProductPaidVO;
import org.team.domain.product.ProductVO;
import org.team.service.product.ProductLikeService;
import org.team.service.product.ProductPaidService;
import org.team.service.product.WebtoonService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product/webtoon/*")
@AllArgsConstructor
@Log4j
public class WebtoonController {

	private WebtoonService service;
	private ProductLikeService likeService;
	private ProductPaidService paidService;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("***webtoon list method***");
		
		List<ProductVO> list = service.getList();
		List<ProductVO> rank = service.getRank();
		List<ProductVO> today = service.getToday();
		
		model.addAttribute("list", list);
		model.addAttribute("rank", rank);
		model.addAttribute("webtoonCnt", service.getCnt());
		model.addAttribute("webtoonToday", today);
		model.addAttribute("webtoonTodayCnt", service.getTodayCnt());
	}
	
	@GetMapping("/get")
	public void get(@RequestParam Long id, Model model, Principal principal, Authentication authentication, HttpSession session) {
		log.info("***webtoon get method***");
		
		ProductVO vo = service.get(id);
		model.addAttribute("webtoon", vo);
		
		// 로그인 상태가 아니면 아래의 principal.getName()에서 NullPointerException이 발생하므로 로그인 상태인 경우만
		if (principal != null) {
			// 해당 상품을 읽어올 때 현재 사용자가 해당 상품에 좋아요를 눌렀었는지 확인
			ProductLikeVO lvo = likeService.get(id.toString(), principal.getName());
			model.addAttribute("like", lvo);
			
			// 해당 상품을 읽어올 때 현재 사용자가 해당 상품을 구매했었는지 확인
			ProductPaidVO pvo = paidService.getPaid(id.toString(), principal.getName());
			model.addAttribute("paid", pvo);
			
			// 현재 사용자의 잔여캐시를 session에 넣어서 navbar의 내 정보에서도 잔여캐시가 보이게 설정
			MemberVO mvo = paidService.getUserMoney(principal.getName());
			session.setAttribute("userMoney", mvo);
			
			// 정기권 구매자인지 확인을 위해 현재 사용자 권한 정보 넘김(예: [ROLE_ADMIN] )
			model.addAttribute("auth", authentication.getAuthorities());
		}
		
	}
	
	@GetMapping("/detail")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_PASS', 'ROLE_USER')")
	public void detail(@RequestParam Long id, Model model, Principal principal, Authentication authentication) {
		log.info("***book detail method***");
		
		ProductVO vo = service.getFile(id);
		// 작품 보기 시 view_cnt값 1증가(조회수)
		service.plusCnt(id);
		
		model.addAttribute("webtoon", vo);
		
		// 로그인 상태가 아니면 아래의 principal.getName()에서 NullPointerException이 발생하므로 로그인 상태인 경우만
		if (principal != null) {
			// 해당 상품을 읽어올 때 현재 사용자가 해당 상품을 구매했었는지 확인
			ProductPaidVO pvo = paidService.getPaid(id.toString(), principal.getName());
			model.addAttribute("paid", pvo);
			
			// 정기권 구매자인지 확인을 위해 현재 사용자 권한 정보 넘김(예: [ROLE_ADMIN] )
			model.addAttribute("auth", authentication.getAuthorities());
		}
	}
	
	@GetMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void getModify(@RequestParam Long id, Model model) {
		log.info("***webtoon get/modify method***");
		
		ProductVO vo = service.get(id);
		
		model.addAttribute("webtoon", vo);
	}
	
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(ProductVO product, @RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2, RedirectAttributes rttr) {
		log.info("***webtoon register method***");
		
		service.register(product, file1, file2);
		
		rttr.addFlashAttribute("webtoonRegister", product.getProduct_name());
		
		return "redirect:/product/webtoon/list";
	}
	
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(ProductVO product, @RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2, RedirectAttributes rttr) {
		log.info("***webtoon modify method***");
		
		ProductVO vo = service.get(product.getId());
		
		boolean success = service.modify(product, file1, file2);
		
		if (success) {
			rttr.addFlashAttribute("webtoonBeforeModify", vo);
		}
		
		return "redirect:/product/webtoon/list";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam Long id, RedirectAttributes rttr) {
		log.info("***webtoon remove method***");
		
		ProductVO vo = service.get(id);
		
		boolean success = service.remove(id);
		
		if (success) {
			rttr.addFlashAttribute("webtoonRemove", vo.getProduct_name());
		}
		
		return "redirect:/product/webtoon/list";
	}
}
