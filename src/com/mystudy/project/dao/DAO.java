package com.mystudy.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import com.mystudy.project.mybatis.DBService;
import com.mystudy.project.vo.ProductVO;
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
		ProductVO vo = ss.selectOne("project.selectProjectVO", productNo);
		return vo;
	}
	
	public static List<SizeVO> getOptionList (String productNo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		List<SizeVO> list = ss.selectList("project.selectProductOption", productNo);
		return list;
	}

}
