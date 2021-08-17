package org.team.domain.product;

import java.util.Date;

import lombok.Data;

@Data
public class ProductVO {

	private Long id;
	private int product_category;
	private String product_genre;
	private String product_name;
	private String writer_name;
	private Long product_price;
	private Date register_date;
	private Date update_date;
	
	private String file_name;
	
	private Long reply_cnt;
	
	private Long like_cnt;
	
	private Long view_cnt;
	
}
