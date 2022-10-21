package com.mystudy.project.vo;

public class CartVO {
	
	String cartNo;
	String optionNo;
	String userId;
	int qty;
	
	
	
	public CartVO() {
		super();
	}

	public CartVO(String cartNo, String optionNo, String userId, int qty) {
		super();
		this.cartNo = cartNo;
		this.optionNo = optionNo;
		this.userId = userId;
		this.qty = qty;
	}

	
	public String getCartNo() {
		return cartNo;
	}

	public void setCartNo(String cartNo) {
		this.cartNo = cartNo;
	}

	public String getOptionNo() {
		return optionNo;
	}

	public void setOptionNo(String optionNo) {
		this.optionNo = optionNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getQty() {
		return qty;
	}

	public void setQty(int qty) {
		this.qty = qty;
	}
	
	
	
	
	
}
