package org.team.controller.help;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.team.domain.help.HReplyVO;
import org.team.service.help.HReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@RequestMapping("/hreplies/*")
@Log4j
@AllArgsConstructor 
public class HReplyController {
	
	private HReplyService service;
	
//	@Autowired
//	public ReplyController(ReplyService service) {
//		this.service = service;
//	} 위 @AllArgsConstructor와 같음
	
	@PostMapping("/new")
	@PreAuthorize("isAuthenticated()")
	public ResponseEntity<String> create(@RequestBody HReplyVO vo) {
		
		int cnt = service.register(vo);
		
		if (cnt == 1 ) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String> (HttpStatus.INTERNAL_SERVER_ERROR);
		}
	} // 알면 좋은데 그닥 쓸모는 없음 그냥 seccess하면 ok고 아니면 error
	
	@GetMapping("/pages/{hno}")
	public List<HReplyVO> getList(@PathVariable("hno") Long hno) {
		
		return service.getList(hno);
	}
	
	@GetMapping("/{hrno}")
	public HReplyVO get(@PathVariable Long hrno) {
		
		return service.get(hrno);
	}
	
//	@RequestMapping(value = "/{rno}, method = RequestMethod.DELETE)
	@DeleteMapping("/{hrno}")
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> remove(@PathVariable Long hrno, @RequestBody HReplyVO vo ) {
							//				rno의 경로를 사용하기 위해서 라고 보면됨
		int cnt = service.remove(hrno);
		
		if (cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
	 
	@RequestMapping(value="/{hrno}", method = {RequestMethod.PUT, RequestMethod.PATCH})
//	@PutMapping
	@PreAuthorize("principal.username == #vo.replyer")
	public ResponseEntity<String> modify(@RequestBody HReplyVO vo, @PathVariable Long hrno) {
		int cnt = service.modify(vo);
		
		if (cnt == 1) {
			return new ResponseEntity<String> ("success", HttpStatus.OK);
		} else {
			return new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}
}
