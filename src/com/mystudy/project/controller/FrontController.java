package com.mystudy.project.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.mystudy.project.common.Paging;
import com.mystudy.project.dao.DAO;
import com.mystudy.project.vo.ProductVO;
import com.mystudy.project.vo.SizeVO;


@WebServlet("/controller")
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String type = request.getParameter("type");
		
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
			ProductVO vo = DAO.getProductInfo(productNo);
			List<SizeVO> list = DAO.getOptionList(productNo);
			System.out.println(list);
			request.setAttribute("productVO", vo);
			request.setAttribute("SizeList", list);
			
			request.getRequestDispatcher("product_detail.jsp").forward(request, response);
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
