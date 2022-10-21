package com.mystudy.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.project.common.Paging;
import com.mystudy.project.dao.DAO;
import com.mystudy.project.vo.CartVO;
import com.mystudy.project.vo.ProductVO;
import com.mystudy.project.vo.ReviewVO;
import com.mystudy.project.vo.SizeVO;


@WebServlet("/controller")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		String type = request.getParameter("type");
		System.out.println(type);
		
		if (type.equals("productlist")) {
			
			String category = request.getParameter("category");
			String categoryNo = DAO.getCategoryNo(category);
			String order = request.getParameter("order");
		
			//연결 전이라 처리한 것
			if (category == null) {
				category = "bestitem";
			}
			if (categoryNo == null) {
				System.out.println("연동 전! categoryNo null이라 수정함");
				categoryNo = "1";
			}
			
			
			request.setAttribute("category", category);
			request.setAttribute("categoryNo", categoryNo);
		
			Paging p = paging(categoryNo, request);			
			request.setAttribute("p", p);
			
			
			if (order == null || order.equals("new")) {
				List<ProductVO> productList = DAO.orderNew(Integer.valueOf(categoryNo), p.getBegin(), p.getEnd());
				request.setAttribute("productList", productList);				
			} else if (order.equals("price")) {
				List<ProductVO> productList = DAO.orderPrice(Integer.valueOf(categoryNo), p.getBegin(), p.getEnd());
				request.setAttribute("productList", productList);								
			} else if  (order.equals("name")) {
				List<ProductVO> productList = DAO.orderName(Integer.valueOf(categoryNo), p.getBegin(), p.getEnd());
				request.setAttribute("productList", productList);												
			}
			
			request.getRequestDispatcher("product_list.jsp").forward(request, response);
			
		}

		if (type.equals("productdetail")) {
			
			String productNo = request.getParameter("productno");
			System.out.println("productNo" + productNo);
			ProductVO vo = DAO.getProductInfo(productNo);
			List<SizeVO> sizeList = DAO.getOptionList(productNo);
			
			request.setAttribute("productVO", vo);
			
			request.setAttribute("SizeList", sizeList);
			

			List<ReviewVO> reviewList = DAO.getProductReview(Integer.valueOf(productNo), 1, 3);
			System.out.println(reviewList);
			request.setAttribute("reviewList", reviewList);
			
			request.getRequestDispatcher("product_detail.jsp").forward(request, response);
		}
		
		if (type.equals("pay")) {

			List<CartVO> list = new ArrayList<CartVO>();

			String productNo = request.getParameter("productNo");
			String productOption = request.getParameter("productOption");
			
			System.out.println("productNo: " + productNo);
			System.out.println("productOption: " + productOption);
			
			String optionNo = DAO.getOptionNo(productNo, productOption);

			String qty = request.getParameter("qty");
			
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			// session 연결된 아이디 긁어다 쓰면 되니까 전달 안 해 줘도 될 것 같음
			
			
			CartVO vo = new CartVO("1", optionNo, userId, Integer.valueOf(qty));
			//System.out.println("vo: "+ vo.getQty());
			
			list.add(vo);
			
			request.setAttribute("list", list);
			//단일 상품 결제를 위한 List<CartVO> list 전달 (옵션은 여러개일 수 있음)
			
			//payment 페이지 구현 전
			request.getRequestDispatcher("payment.jsp").forward(request, response);
			
		}
		
		if (type.equals("addCart")) {
			
			String productNo = request.getParameter("productNo");
			String productOption = request.getParameter("productOption");
			String qty = request.getParameter("qty");
			
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;

			String optionNo = DAO.getOptionNo(productNo, productOption);
			System.out.println("optionNo: " + optionNo);
			
			DAO.insertCart(optionNo, userId, qty);

			response.sendRedirect("controller?type=productdetail&productno="+productNo);
		}
		
		
		if (type.equals("addLike")) {
			
			String productNo = request.getParameter("productNo");
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;

			DAO.addLike(productNo, userId);

			response.sendRedirect("controller?type=productdetail&productno="+productNo);
		}

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
	
	
	public static Paging paging (String categoryNo, HttpServletRequest request) {
		
		Paging p =  new Paging();
		p.setTotalRecord(DAO.getTotalCount(Integer.valueOf(categoryNo)));
		p.setTotalPage();
		System.out.println("p.getTotalRecord() : " + p.getTotalRecord());
		System.out.println("p.getTotalPage() : " +  p.getTotalPage());

		String cPage =  request.getParameter("page");
		
		if (cPage != null) {
			p.setNowPage(Integer.valueOf(cPage));
		}
		
		p.setEnd(p.getNowPage() * p.getNumPerPage());
		p.setBegin(p.getEnd() - p.getNumPerPage() + 1);
		
		if (p.getEnd() > p.getTotalRecord()) {
			p.setEnd(p.getTotalRecord());
		}
		
		int nowPage = p.getNowPage();
		int beginPage = (nowPage - 1) / p.getNumPerBlock() * p.getNumPerBlock() + 1;

		p.setBeginPage(beginPage);
		p.setEndPage(beginPage + p.getNumPerBlock() - 1);
		
		if (p.getEndPage() > p.getTotalPage()) {
			p.setEndPage(p.getTotalPage());
		}

		return p;

	}
}
