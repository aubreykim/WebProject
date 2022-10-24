<%@page import="com.mystudy.project.vo.CartVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
<%
	List<CartVO> list = (List<CartVO>) request.getAttribute("list");
	System.out.println("payment page list: "+ list);
	System.out.println("payment page list.size(): "+ list.size());
	
	for (CartVO vo : list) {
		System.out.println("payment page vo: "+ vo);
		System.out.println("payment page vo.qty: "+ vo.getQty());
		System.out.println("payment page vo.optionNo: "+ vo.getOptionNo());
	}
%>
	alert("결제 페이지 도착");
</script>
</head>
<body>

</body>
</html>