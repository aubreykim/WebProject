package com.mystudy.project.vo;

public class CartVO {
	
	String productNo;
	String productOption;
	int qty;
	
	
	
	public CartVO() {
		super();
	}

	public CartVO(String productNo, String productOption, int qty) {
		super();
		this.productNo = productNo;
		this.productOption = productOption;
		this.qty = qty;
	}
	
	public String getProductNo() {
		return productNo;
	}
	public void setProductNo(String productNo) {
		this.productNo = productNo;
	}
	public String getProductOption() {
		return productOption;
	}
	public void setProductOption(String productOption) {
		this.productOption = productOption;
	}
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	
	
	
}
