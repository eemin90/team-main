package org.team.controller.member;

import java.io.IOException;
import java.security.Principal;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.team.SendEmail;
import org.team.domain.member.Criteria;
import org.team.domain.member.MemberVO;
import org.team.domain.product.ProductVO;
import org.team.security.domain.CustomUser;
import org.team.service.member.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/member")
@AllArgsConstructor
@Log4j
public class MemberController {
	

	@Setter(onMethod_ = @Autowired)
	private MemberService service;
	
	@RequestMapping("/pay")
	@PreAuthorize("isAuthenticated()")
	public void pay() {
		
	}
	
//	@RequestMapping(value = "/pay", params = "pg_token")
	public String pay(@RequestParam("pg_token") String pgToken) {
		String failUrl = "/member/fail";
		String successUrl = "/member/success";
		
		try {
			
			if (service.approve(pgToken)) {
				log.info("모두 잘됨!!");
				
				return null;
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.info("뭔가 이상1111!!");
		}
		
		log.info("뭔가 이상2222!!");
		return null;
	}
	
	@RequestMapping("/fail")
	public void fail() {
		
	}
	
	@RequestMapping("/popup1")
	public void popup1() {
		
	}
	
	@RequestMapping("/cancel")
	public void cancel() {
		
	}
	
	@GetMapping("/findid")
	public void findid() {
		log.info("*** findid in ***");
	}
	
	@GetMapping("/findpw")
	public void findpw() {
		log.info("*** findpw in ***");
	}
	
	@GetMapping("/login")
	public void login() {
		log.info("***member login method***");
	}
	
	@GetMapping("/logout")
	public void logout() {
		log.info("***member logout method***");
	}
	
	@GetMapping("/signup")
	public void signup(Criteria cri) {
		log.info("***member signup method***");
	}
	
	@PostMapping("/signup")
	public String signupPost(MemberVO vo, RedirectAttributes rttr) {
		log.info(vo);
		
		boolean ok = service.insert(vo);
		
		if (ok) {
			return "redirect:/main";
		} else {
			return "redirect:/member/signup?error";
		}
	} 
	@GetMapping("/info")
	@PreAuthorize("isAuthenticated()")
	public void info(Criteria cri, Principal principal, Model model) {
		log.info(principal.getName());
	
		MemberVO member = service.read(principal.getName());
		
		model.addAttribute("member",member);
	}
	
	@PostMapping("/modify")
	@PreAuthorize("principal.username == #vo.userid")
	public String modify(MemberVO vo, RedirectAttributes rttr, Authentication auth, String oldPassword) {
		boolean ok = service.modify(vo, oldPassword);
		
		if (ok) {
			rttr.addAttribute("status", "success");
			// session의 authentication 을 수정
			CustomUser user = (CustomUser) auth.getPrincipal();
			user.setMember(vo);
		} else {
			rttr.addAttribute("status", "error");
		}
		return "redirect:/member/info";
	}
	
	@PostMapping("/remove")
	@PreAuthorize("principal.username == #vo.userid")
	public String remove(MemberVO vo, RedirectAttributes rttr, HttpServletRequest req, String oldPassword) throws ServletException {
		boolean ok = service.remove(vo, oldPassword);
		
		if (ok) {
			req.logout();
			return "redirect:/main";
		} else {
			rttr.addAttribute("status", "error");
			return "redirect:/member/info";
		}
	}
	
	@GetMapping("/dup")
	@ResponseBody
	public ResponseEntity<String> duplicate(String id) {
		log.info("duplicate method");
		
		MemberVO vo = service.read(id);
		
		if (vo == null) {
			return new ResponseEntity<>("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<> ("exist", HttpStatus.OK);
		}
		
	}

	@PostMapping("/findid")
	public void findid(@RequestParam("username") String username, @RequestParam("usermail") String usermail, Model model) {
		MemberVO vo = service.read2(username, usermail);
		if(vo != null) {
			
			model.addAttribute("userid", "고객님의 아이디는 " + vo.getUserid() + "입니다.");

		}else {
			
			model.addAttribute("userid", "일치하는 회원정보가 없습니다.");
		}
		
	}
	
	@PostMapping("/findpw")
	public void findpw(@RequestParam("userid") String userid, @RequestParam("username") String username, @RequestParam("usermail") String usermail, Model model) {
		// findpw.jsp의 input 값들 받아와서 service의 read3 메소드 실행(유저 정보 불러오기)
		MemberVO member = service.read3(userid, username, usermail);
		
		int num = (int) (Math.random()*999999);
		String str = String.valueOf(num);

		
		// 유저 정보가 정상적으로 불러와지면(null이 아닌경우) if문 실행
		if (member != null) {
			// 패스워드 암호화
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			// 일단 강제로 패스워드를 랜덤으로 초기화를 위해
			String newPassword = str;
			// 평문 암호값(랜덤)을 암호화 하여
			String pw = encoder.encode(newPassword);
			// 해당 id의 패스워드를 암호화된 랜덤으로 설정
			service.setPw(pw, userid);
			
			// jsp 쪽으로 변경된 암호인 123(평문)을 전송
			model.addAttribute("userpw", "고객님의 임시비밀번호는 \n" + newPassword + " 입니다.");
		} else {
			// 일치하는 유저 정보가 없는 경우
			model.addAttribute("userpw", "일치하는 정보가 없습니다.");
		}
	}
	
	@PostMapping("/authNumber")
	public void authNumber(MemberVO member, RedirectAttributes rttr, HttpServletRequest request, HttpServletResponse response)throws IOException {
		
		HttpSession session = request.getSession();
		
		String idI = request.getParameter("idI");
		String idE = request.getParameter("idE");
		
		log.info(idE);
		
		if(idI == null) {
			
		
			int num = (int) (Math.random()*123);
			
			SendEmail.sendEmail(num, idE);
			
			session.setAttribute("authRandomNumber", num);
			System.out.println(num);
			
			response.getWriter().append("ok1");
			
			
		} else {
			int num = (Integer) session.getAttribute("authRandomNumber");
			int num1 = Integer.parseInt(idI);
			if (num == num1) {
				response.getWriter().append("ok2");
			} else {
				response.getWriter().append("not ok");
			}

		}
	}
	
	@RequestMapping("/likes")
	@PreAuthorize("isAuthenticated()")
	public void likes(String userid, Model model) {
		List<ProductVO> list = service.getLikes(userid);
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping("/likesWebtoon")
	@PreAuthorize("isAuthenticated()")
	public void likesWebtoon(String userid, Model model) {
		List<ProductVO> webtoon = service.getWebtoonLikes(userid);
		
		model.addAttribute("webtoon", webtoon);
	}
	
	@RequestMapping("/likesWebnovel")
	@PreAuthorize("isAuthenticated()")
	public void likesWebnovel(String userid, Model model) {
		List<ProductVO> webnovel = service.getWebnovelLikes(userid);
		
		model.addAttribute("webnovel", webnovel);
	}
	
	@RequestMapping("/likesBook")
	@PreAuthorize("isAuthenticated()")
	public void likesBook(String userid, Model model) {
		List<ProductVO> book = service.getBookLikes(userid);
		
		model.addAttribute("book", book);
	}
	
	@RequestMapping("/paidList")
	@PreAuthorize("isAuthenticated()")
	public void paidList(String userid, Model model) {
		List<ProductVO> list = service.getPaidList(userid);
		
		model.addAttribute("list", list);
	}
	
	@RequestMapping("/paidListWebtoon")
	@PreAuthorize("isAuthenticated()")
	public void paidListWebtoon(String userid, Model model) {
		List<ProductVO> webtoon = service.getPaidListWebtoon(userid);
		
		model.addAttribute("webtoon", webtoon);
	}
	
	@RequestMapping("/paidListWebnovel")
	@PreAuthorize("isAuthenticated()")
	public void paidListWebnovel(String userid, Model model) {
		List<ProductVO> webnovel = service.getPaidListWebnovel(userid);
		
		model.addAttribute("webnovel", webnovel);
	}
	
	@RequestMapping("/paidListBook")
	@PreAuthorize("isAuthenticated()")
	public void paidListBook(String userid, Model model) {
		List<ProductVO> book = service.getPaidListBook(userid);
		
		model.addAttribute("book", book);
	}
	
	@RequestMapping("/PaymentWindow")
	public void PaymentWindow() {
		log.info("*** Check Connection(PaymentWindow) ***");
	}
	
	@RequestMapping("/inicis")
	public void inicis() {
		log.info("*** Check Connection(inicis) ***");
		
	}
	
	@RequestMapping("/pay2")
	@PreAuthorize("isAuthenticated()")
	public void pay2(Criteria cri, Principal principal, Model model) {
		log.info("*** Check Connection(inicis) ***");
		
		if (principal != null) {
			MemberVO member = service.read(principal.getName());
			model.addAttribute("member", member);
		}
		
	}
	
	@PostMapping("/point")
	@ResponseBody
	public void method(@RequestParam MemberVO vo, HttpServletRequest request) {
		log.info("**** point in ****");
		
		log.info(vo);
		
		service.method(vo);
	}
		
		
	}
	

