package com.mystudy.project.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.project.common.Paging;
import com.mystudy.project.common.PagingReview;
import com.mystudy.project.dao.DAO;
import com.mystudy.project.mybatis.DBService;
import com.mystudy.project.vo.CartListVO;
import com.mystudy.project.vo.CartVO;
import com.mystudy.project.vo.LikeVO;
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
			String categoryNo = null;
			String order = request.getParameter("order");


			if (category.equals("BESTITEM")) {
				categoryNo = "0";
				
				List<ProductVO> productList = DAO.getBestitems();

				request.setAttribute("productList", productList);
				
			} else if (category.equals("NEW")) {
				categoryNo = "0";
				
				List<ProductVO> productList = DAO.getNewitems();
				
				request.setAttribute("productList", productList);

			} else { 
				
				categoryNo = DAO.getCategoryNo(category);
				
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
				
			}			
			
			request.getRequestDispatcher("product_list.jsp").forward(request, response);
			
		}
		

		if (type.equals("productdetail")) {
			
			String productNo = request.getParameter("productNo");
			System.out.println("productNo" + productNo);
			
			ProductVO vo = DAO.getProductInfo(productNo);

			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			// session ????????? ????????? ????????? ?????? ????????? ?????? ??? ??? ?????? ??? ??? ??????

			LikeVO likeVO =  DAO.selectLike(productNo, userId);
			request.setAttribute("likeVO", likeVO);
			
			List<SizeVO> sizeList = DAO.getOptionList(productNo);
			
			request.setAttribute("productVO", vo);
			
			request.setAttribute("SizeList", sizeList);

			
			PagingReview pr = reviewPaging(productNo, request);
			request.setAttribute("pr", pr);

			//?????? ????????? ????????????
			List<ReviewVO> reviewList = DAO.getProductReview(productNo, pr.getBegin(), pr.getEnd());
			request.setAttribute("reviewList", reviewList);
			
			
			
			request.getRequestDispatcher("product_detail.jsp").forward(request, response);
		
		}
		
		if (type.equals("pay")) {
			//??????????????? <CartVO>??? ????????????, ?????????????????? <CartNo> List??? ??????
			//CartVO??? ??? list??? CartNo??? ?????? optionNo, userId, amount, price???
			//productNo??? ???????????? ?????? ??????????????? select
			
			String[] cartNo = request.getParameterValues("cartNo");
			
			if (cartNo == null) {

				List<CartVO> list = new ArrayList<CartVO>();
				
				String[] productNo = request.getParameterValues("productNo");
				String[] price = request.getParameterValues("price");
				String[] qty = request.getParameterValues("qty");
				String[] optionSize = request.getParameterValues("optionSize");
				
				System.out.println(optionSize);
				
				String optionNo[] = new String[optionSize.length];
				String userId = "ff";
				// String userId =  (String) request.getSession().getAttribute("user").userId;
				// session ????????? ????????? ????????? ?????? ????????? ?????? ??? ??? ?????? ??? ??? ??????

				for (int i = 0; i < optionSize.length; i++) {
					optionNo[i] = DAO.getOptionNo(productNo[i], optionSize[i]);
				}
				
				for (int i = 0; i < optionSize.length; i++) {
					if (qty[i].equals("0")) continue;				
					list.add(new CartVO(optionNo[i], userId, Integer.valueOf(qty[i]), Integer.valueOf(price[i])));
				}

				request.setAttribute("list", list);
				
			} else {
				
				List<String> list = Arrays.asList(cartNo);
				System.out.println("cart?????? ?????? ????????? : " + list);
				request.setAttribute("list", list);
			}
			
			//?????? ?????? ????????? ?????? List<CartVO> list ?????? (????????? ???????????? ??? ??????)
			
			//payment ????????? ?????? ???
			request.getRequestDispatcher("payment.jsp").forward(request, response);

			
		}
		
		if (type.equals("addCart")) {
			
			List<CartVO> list = new ArrayList<CartVO>();

			String productNo = request.getParameter("productNo");
			String[] price = request.getParameterValues("price");
			
			String[] qty = request.getParameterValues("qty");
			String[] productOption = request.getParameterValues("productOption");
			String optionNo[] = new String[productOption.length];

			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			// session ????????? ????????? ????????? ?????? ????????? ?????? ??? ??? ?????? ??? ??? ??????

			for (int i = 0; i < productOption.length; i++) {
				
				optionNo[i] = DAO.getOptionNo(productNo, productOption[i]);
				
			}
			
			for (int i = 0; i < productOption.length; i++) {
			
				if (qty[i].equals("0")) continue;	
				DAO.insertCart(optionNo[i], userId, qty[i], price[i]);
			
			}
			System.out.println("addCart??? productNo: " + productNo);
			//request.getRequestDispatcher("controller?type=productdetail").forward(request, response);
			response.sendRedirect("controller?type=productdetail&productNo="+productNo);
			
		}
	
		if (type.equals("cartList")) {
			
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			
			List<CartListVO> list = DAO.getCartList(userId);
			
			request.setAttribute("list", list);
			request.getRequestDispatcher("cart.jsp").forward(request, response);
			
		}
		

	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
	}
	
	
	public static Paging paging (String categoryNo, HttpServletRequest request) {
		
		Paging p =  new Paging();
		

		p.setTotalRecord(DAO.getTotalCount(categoryNo));
		
		p.setTotalPage();
		
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
	
	
	
	public static PagingReview reviewPaging (String productNo, HttpServletRequest request) {
		
		PagingReview pr =  new PagingReview();
		
		pr.setTotalRecord(DAO.getTotalReviewCount(productNo));
		pr.setTotalPage();
		
		String cPage = request.getParameter("reviewPage");
		
		if (cPage != null) {
			pr.setNowPage(Integer.valueOf(cPage));
		}
		
		pr.setEnd(pr.getNowPage() * pr.getNumPerPage());
		pr.setBegin(pr.getEnd() - pr.getNumPerPage() + 1);
		
		
		if (pr.getEnd() > pr.getTotalRecord()) {
			pr.setEnd(pr.getTotalRecord());
		}
		
		int nowPage = pr.getNowPage();

		int beginPage =  (nowPage - 1) / pr.getNumPerBlock() * pr.getNumPerBlock() + 1;
		
		pr.setBeginPage(beginPage);
		pr.setEndPage(beginPage + pr.getNumPerBlock() - 1);

		if (pr.getEndPage() > pr.getTotalPage()) {
			pr.setEndPage(pr.getTotalPage());
		}
		
		return pr;
		
	}
	
	
}
