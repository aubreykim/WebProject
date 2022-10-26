package com.mystudy.project.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.project.common.PagingReview;
import com.mystudy.project.dao.DAO;
import com.mystudy.project.vo.CartListVO;
import com.mystudy.project.vo.ReviewVO;


@WebServlet("/ajaxController")
public class ajaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		String type = request.getParameter("type");
		
		if (type.equals("deleteCart")) {
			
			String cartNo = request.getParameter("cartNo");
			DAO.delectCart(cartNo);
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			
			List<CartListVO> list = DAO.getCartList(userId);
			
			String result = makeJson(list);
			
			System.out.println(result);
			
			PrintWriter out = response.getWriter();
			out.print(result); //{"idx":1}
			
		}
		
		if (type.equals("updateQty")) {
			
			String cartNo = request.getParameter("cartNo");
			String qty = request.getParameter("qty");
			System.out.println("cartNo: " + cartNo);
			System.out.println("qty: " + qty);
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			
			DAO.updateQtyCart(qty, cartNo, userId);
			
			
			String result = makeJson(qty, cartNo);
			
			System.out.println(result);
			
			PrintWriter out = response.getWriter();
			out.print(result); //{"idx":1}
			
			
		}
		
		if (type.equals("review")) {
			
			String productNo = request.getParameter("productNo");
			String reviewPage = request.getParameter("reviewPage");		
			
			PagingReview pr = reviewPaging(productNo, request);
			
			request.setAttribute("pr", pr);
			
			List<ReviewVO> list = DAO.getProductReview(productNo, pr.getBegin(), pr.getEnd());
			
			// request.setAttribute("reviewList", list);
			// request.setAttribute("pr", pr);
			
			//JSON 형식 문자열 만들기
			//{"list" : [{}, {}, ..., {}]}
			String result = makeJson(list, pr);
			
			System.out.println(result);
			
			PrintWriter out = response.getWriter();
			out.print(result); //{"idx":1}
			
		}
		
		if (type.equals("deleteCartAll")) {
			
			int result = DAO.deleteCartAll();
			
			String json = "{ \"result\" : " + result + "}";
			PrintWriter out = response.getWriter();
			out.print(json);
			
		}
		
		
		if (type.equals("addLike")) {
			
			String productNo = request.getParameter("productNo");
			String userId = "ff";
			// String userId =  (String) request.getSession().getAttribute("user").userId;
			
			int result = 0;
			
			String from = request.getParameter("from");
			
			
			if (from.equals("productDetail")) {
				
				if (DAO.selectLike(productNo, userId) == null) {
					result = DAO.insertLike(productNo, userId);
					System.out.println("관심목록 추가되었습니다");
				} else {
					DAO.deleteLike(productNo, userId);
					System.out.println("관심목록에서 삭제되었습니다");
				}
				
			} else {
				
				if (DAO.selectLike(productNo, userId) == null) {
					result = DAO.insertLike(productNo, userId);
					System.out.println("관심목록 추가되었습니다");
				}
				
			}
			
			String json = "{ \"result\" : " + result + "}";
			PrintWriter out = response.getWriter();
			out.print(json);
			
		}
	}
	
	
	private String makeJson (String qty, String cartNo) {
		
		StringBuilder result = new StringBuilder();
		int cartPrice = DAO.getCartProductPrice(cartNo);
		int updatedQty = Integer.parseInt(qty);
		
		result.append("{ \"qty\" : " + updatedQty + ", ");
		result.append("\"cartPrice\" : " + cartPrice + "} ");

		return result.toString();
	}
	
	private String makeJson(List<CartListVO> list){
		
		StringBuilder result = new StringBuilder();

		result.append("{ \"list\" : [");
		if (list.size() > 0) {
			for (CartListVO vo : list) {
				result.append("{ \"cartNo\" : \"" + vo.getCartNo() + "\",");
				result.append("\"productName\" : \"" + vo.getProductName() + "\",");
				result.append("\"thumnail\" : \"" + vo.getThumnail() + "\",");
				result.append("\"price\" : " + vo.getPrice() + ",");
				result.append("\"amount\" : " + vo.getAmount() + ",");
				result.append("\"optionSize\" : \"" + vo.getOptionSize() + "\",");
				result.append("\"productNo\" : \"" + vo.getProductNo() + "\"");
				result.append("},");
			}
			result.deleteCharAt(result.length()-1);			
		}
		result.append("] }");

		return result.toString();
	}
	
	private String makeJson(List<ReviewVO> list, PagingReview pr) {
		//JSON 형식 문자열 만들기
		StringBuilder result = new StringBuilder();
		
		result.append("{ \"review\" : {");
		result.append("\"list\" : [ ");
		for (ReviewVO vo : list) {
			result.append("{ \"reviewNo\" : " + vo.getReviewNo() + ",");
			result.append("\"title\" : \"" + vo.getTitle() + "\", ");
			result.append("\"userName\" : \"" + vo.getUserName() + "\",");
			result.append("\"wdate\" : \"" + vo.getWdate().substring(0,10) + "\"");
			//result.append("\"hit\" : " + vo.getWdate().substring(0,10) + "");
			result.append("} ,");			
		}
		//마지막 콤마 지워주는 것
		result.deleteCharAt(result.length()-1);
		result.append("] , ");	
		result.append("\"pr\" : { ");			
		
		result.append(" \"begin\" : " + pr.getBegin() + ",");			
		result.append(" \"end\" : " + pr.getEnd() + ",");			
		result.append(" \"beginPage\" : " + pr.getBeginPage() + ",");			
		result.append(" \"endPage\" : " + pr.getEndPage() + ",");			
		result.append(" \"nowPage\" : " + pr.getNowPage() + ",");			
		result.append(" \"totalPage\" : " + pr.getTotalPage() + "");			

		result.append(" }"); // paging 괄호	
		result.append(" }"); // review 괄호	
		result.append(" }"); // 전체 괄호			

		return result.toString();

	}
	
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
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
