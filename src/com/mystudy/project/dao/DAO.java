package com.mystudy.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.project.mybatis.DBService;
import com.mystudy.project.vo.CartVO;
import com.mystudy.project.vo.ProductVO;
import com.mystudy.project.vo.ReviewVO;
import com.mystudy.project.vo.SizeVO;

public class DAO {

	public static String getCategoryNo(String category) {
		SqlSession ss = DBService.getFactory().openSession(true);
		String categoryNo = ss.selectOne("project.selectCategoryNo", category);
		ss.close();
		return categoryNo;		
	}

	public static int getTotalCount(int categoryNo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int totalCount = ss.selectOne("project.selectTotalCount", categoryNo);
		ss.close();
		return totalCount;
	}
	
	public static List<ProductVO> orderNew (int categoryNo, int begin, int end) {
		Map <String, Integer> map = new HashMap<>();
		// key값 category에 categoryNum, begin(key)에 begin값, end(key)에 end값(string)
		map.put("categoryNo", categoryNo);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ProductVO> selectedList = ss.selectList("project.selectListNew", map);
		return selectedList;
	}
	
	public static List<ProductVO> orderName (int categoryNo, int begin, int end) {
		Map <String, Integer> map = new HashMap<>();
		// key값 category에 categoryNum, begin(key)에 begin값, end(key)에 end값(string)
		map.put("categoryNo", categoryNo);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ProductVO> selectedList = ss.selectList("project.selectListName", map);
		return selectedList;
	}
	
	public static List<ProductVO> orderPrice (int categoryNo, int begin, int end) {
		Map <String, Integer> map = new HashMap<>();
		map.put("categoryNo", categoryNo);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ProductVO> selectedList = ss.selectList("project.selectListPrice", map);
		return selectedList;
	}
	
	public static ProductVO getProductInfo (String productNo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		ProductVO vo = ss.selectOne("project.selectProductVO", productNo);
		return vo;
	}
	
	public static List<SizeVO> getOptionList (String productNo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<SizeVO> list = ss.selectList("project.selectProductOption", productNo);
		return list;
	}
	
	public static List<ReviewVO> getProductReview (int productNo, int begin, int end) {
		Map<String, Integer> map = new HashMap<>();
		
		map.put("productNo", productNo);
		map.put("begin", begin);
		map.put("end", end);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		List<ReviewVO> list = ss.selectList("project.selectReview", map);
		return list;
	}
	
	
	public static int insertCart(String optionNo, String userId, String qty) {
		
		Map<String, String> map = new HashMap<>();
		map.put("optionNo", optionNo);
		map.put("userId", userId);
		map.put("qty", qty);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		
		return ss.insert("project.insertCart", map);
	}

	public static String getOptionNo (String productNo, String productOption) {
		
		Map<String, String> map = new HashMap<>();
		
		map.put("productNo", productNo);
		map.put("productOption", productOption);
		
		System.out.println(map.keySet());
		System.out.println(map.values());
		
		SqlSession ss = DBService.getFactory().openSession(true);
		String optionNo = ss.selectOne("project.selectOptionNo", map);
		
		System.out.println("optionNo: " + optionNo);
		return optionNo;
	}
	
	public static int addLike (String productNo, String userId) {
		Map<String, String> map = new HashMap<>();
		map.put("productNo", productNo);
		map.put("userId", userId);
		
		SqlSession ss = DBService.getFactory().openSession(true);
		return ss.insert("project.inserLikeProduct", map);
	}
	
}
