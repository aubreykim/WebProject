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
import com.mystudy.project.vo.ReviewVO;


@WebServlet("/ajaxController")
public class ajaxController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		
		String productNo = request.getParameter("productNo");
		String reviewPage = request.getParameter("reviewPage");
		System.out.println(productNo + ", " + reviewPage);
		
		PagingReview pr = reviewPaging(productNo, request);
		
		List<ReviewVO> list = DAO.getProductReview(productNo, pr.getBegin(), pr.getEnd());
		request.setAttribute("reviewList", list);
		
		
		//JSON 형식 문자열 만들기
		//{"list" : [{}, {}, ..., {}]}
		String result = makeJson(list, pr.getBeginPage(), pr.getEndPage());
		System.out.println(result);
		PrintWriter out = response.getWriter();
		out.print(result); //{"idx":1}
		
	}
	
	
	private String makeJson(List<ReviewVO> list, int beginPage, int endPage) {
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

		result.append("\"paging\" : { ");			
		result.append(" \"beginPage\" : " + beginPage);			
		result.append(" , \"endPage\" : " + endPage);			
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
