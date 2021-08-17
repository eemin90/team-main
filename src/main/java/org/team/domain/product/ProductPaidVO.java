package org.team.domain.product;

import java.util.Date;

import lombok.Data;

@Data
public class ProductPaidVO {

	private Long id;
	private Long product_id;
	private String user_id;
	private int check_paid;
	private Date paid_date;
	
	private Long price;
}
