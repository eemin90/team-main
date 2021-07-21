package org.team.controller.product;

import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.team.domain.product.ProductVO;
import org.team.service.product.WebnovelService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/product/webnovel/*")
@AllArgsConstructor
@Log4j
public class WebnovelController {

	private WebnovelService service;
	
	@GetMapping("/list")
	public void list(Model model) {
		log.info("***webnovel list method***");
		
		List<ProductVO> list = service.getList();
		
		model.addAttribute("list", list);
	}
	
	@GetMapping("/get")
	public void get(@RequestParam Long id, Model model) {
		log.info("***webnovel get method***");
		
		ProductVO vo = service.get(id);
		
		model.addAttribute("webnovel", vo);
	}
	
	@GetMapping("/detail")
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_USER')")
	public void detail(@RequestParam Long id, Model model) {
		log.info("***book detail method***");
		
		ProductVO vo = service.getFile(id);
		
		model.addAttribute("webnovel", vo);
	}
	
	@GetMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public void getModify(@RequestParam Long id, Model model) {
		log.info("***webnovel get/modify method***");
		
		ProductVO vo = service.get(id);
		
		model.addAttribute("webnovel", vo);
	}
	
	@PostMapping("/register")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String register(ProductVO product, @RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2, RedirectAttributes rttr) {
		log.info("***webnovel register method***");
		
		service.register(product, file1, file2);
		
		rttr.addFlashAttribute("webnovelRegister", product.getProduct_name());
		
		return "redirect:/product/webnovel/list";
	}
	
	@PostMapping("/modify")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String modify(ProductVO product, @RequestParam("file1") MultipartFile file1, @RequestParam("file2") MultipartFile file2, RedirectAttributes rttr) {
		log.info("***webnovel modify method***");
		
		ProductVO vo = service.get(product.getId());
		
		boolean success = service.modify(product, file1, file2);
		
		if (success) {
			rttr.addFlashAttribute("webnovelBeforeModify", vo);
		}
		
		return "redirect:/product/webnovel/list";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("hasRole('ROLE_ADMIN')")
	public String remove(@RequestParam Long id, RedirectAttributes rttr) {
		log.info("***webnovel remove method***");
		
		ProductVO vo = service.get(id);
		
		boolean success = service.remove(id);
		
		if (success) {
			rttr.addFlashAttribute("webnovelRemove", vo.getProduct_name());
		}
		
		return "redirect:/product/webnovel/list";
	}
}
