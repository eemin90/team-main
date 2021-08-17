package org.team.controller.board;

import java.security.Principal;
import java.util.List;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.team.domain.board.BoardCriteria;
import org.team.domain.board.BoardLikeVO;
import org.team.domain.board.BoardVO;
import org.team.domain.board.PageDTO;
import org.team.service.board.BoardLikeService;
import org.team.service.board.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
@Log4j
public class BoardController {
	
	private BoardService service;
	private BoardLikeService likeService;
	
	@GetMapping("/list")
	public void list(@ModelAttribute("cri") BoardCriteria cri, Model model, BoardLikeVO vo) {
		int total = service.getTotal(cri);
		
		List<BoardVO> list = service.getList(cri);
		
		model.addAttribute("list", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		
		
		 
	}

	
	@PostMapping("/register")
	@PreAuthorize("isAuthenticated()")
	public String register(BoardVO board, 
		@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {	
		
		log.info("register get method");
		
		board.setFileName(file.getOriginalFilename());
		
		
		service.register(board, file); 
		
		rttr.addFlashAttribute("result", board.getBno());
		rttr.addFlashAttribute("messageTitle", "등록 성공.");
		rttr.addFlashAttribute("messageBody", board.getBno() + "번 게시물 등록 되었습니다.");
		
		// /board/list redirect
		return "redirect:/board/list";
	}
	
	
	@GetMapping({"/get", "/modify"})
	public void get(@RequestParam("bno") Long bno, 
			@ModelAttribute("cri") BoardCriteria cri, 
			Model model, Principal principal) {
		log.info("board/get method");
		
		BoardVO vo = service.get(bno);
		
		model.addAttribute("board", vo);
		
		// 해당 상품을 읽어올 때 현재 사용자가 해당 상품에 좋아요, 싫어요를 눌렀었는지 확인
		if (principal != null) { // 로그인 상태가 아니면 아래의 principal.getName()에서 NullPointerException이 발생하므로 로그인 상태인 경우만
			BoardLikeVO lvo = likeService.get(bno.toString(), principal.getName());
			BoardLikeVO lvo1 = likeService.getDislike(bno.toString(), principal.getName());
			model.addAttribute("like", lvo);
			model.addAttribute("dislike", lvo1);
		}
		
	}
	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #board.writer")// 720p
//	@PreAuthorize("authication.name == #board.writer")// spring.io
	public String modify(BoardVO board, BoardCriteria cri,
			@RequestParam("file") MultipartFile file, RedirectAttributes rttr) {
		
		log.info("modify:" + board);
		
		boolean success = service.modify(board, file); // 101줄 if(success) 가능
		
		if (service.modify(board)) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messagTitle", "수정 성공.");
			rttr.addFlashAttribute("messageBody", "수정 되었습니다.");
		}
		
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
	
		return "redirect:/board/list";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #writer")  // 720p
	public String remove(Long bno, BoardCriteria cri, RedirectAttributes rttr, String writer) {
		
		boolean success = service.remove(bno);
		
		if (success) {
			rttr.addFlashAttribute("result", "success");
			rttr.addFlashAttribute("messagTitle", "삭제 성공.");
			rttr.addFlashAttribute("messageBody", "삭제 되었습니다.");
		}
		rttr.addAttribute("pageNum", cri.getPageNum());
		rttr.addAttribute("amount", cri.getAmount());
		rttr.addAttribute("type", cri.getType());
		rttr.addAttribute("keyword", cri.getKeyword());
		
		return "redirect:/board/list";
	}
	
	@GetMapping("/register")
	@PreAuthorize("isAuthenticated()") // 673p
	public void register(@ModelAttribute("cri") BoardCriteria cri) {
		// forward함 WEB-INF/views/board/register.jsp
	}
	
}