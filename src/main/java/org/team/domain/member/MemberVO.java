package org.team.domain.member;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String userid;
	private String userpw;
	private String userName;
	private Date regdate;
	private Date updateDate;
	private boolean enabled;
	private String usermail;
	private String tel;
	private String addr;
	private Integer id;
	private List<AuthVO> authList;
	private Long money;
}
