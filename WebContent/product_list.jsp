<%@page import="java.io.File"%>
<%@page import="com.mystudy.project.vo.ProductVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.project.dao.DAO"%>
<%@page import="com.mystudy.project.common.Paging"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
 #footer { font-size: 0.8em; }
</style>
<script>
	
	
	$(function(){
		$("#orderByNew").click(orderByNew);
		$("#orderByName").click(orderByName);
		$("#orderByPrice").click(orderByPrice);
	});
	
	function orderByPrice() {
		alert("가격순 정렬하기");
		location.href="controller?type=productlist&category=${category }&order=price";
	}
	
	function orderByNew() {
		alert("디폴트! 신상품순 정렬하기");
		location.href="controller?type=productlist&category=${category }&order=new";
	}
	
	function orderByName() {
		alert("제품명순으로 정렬하기");
		location.href="controller?type=productlist&category=${category }&order=name";
	}
	
	
</script>
</head>
<body>

<div class="container">

	<%@ include file="include/header.jspf" %>
	
	<div class="text-center">
		<p class="py-3"></p>
		<h2 class="text-center">${category }</h2>
		<p class="py-3"></p>
	</div>
	
	<div>
	  <ul class="nav justify-content-end">
	    <li class="nav-item">
	      <input type="button" id="orderByNew" class="btn btn-outline-light text-dark" value="최신등록순">
	    </li>
	    <li class="nav-item">
	      <input type="button" id="orderByName" class="btn btn-outline-light text-dark" value="제품명">
	    </li>
	    <li class="nav-item">
	      <input type="button" id="orderByPrice" class="btn btn-outline-light text-dark" value="가격순">
	    </li>
	  </ul>
	</div>
	
	<p class="clearfix"></p>

	<div id="productList" style="width:100%; height: auto;">
		
		<c:if test="${empty productList }">
			<p class="py-5"></p>
			<h3 class="text-center">해당 카테고리에 현재 판매중인 상품이 없습니다</h3>
			<p class="py-3"></p>
		</c:if>

		<ul class="nav" style="width:100%;">
		<c:forEach var="productVO" items="${productList }">
			<li class="nav-item float-left text-center p-1" style="width: 33%;">
				<div>
					<a href="controller?type=productdetail&productno=${productVO.productNo }">
					<img src="./img/${productVO.thumnail }" alt="img" width="95%" height="400">
					</a>
				</div>
				<div class="product_title">${productVO.productName }</div>
				<div class="product_price">${productVO.price }</div>
			</li>
		</c:forEach>
		</ul>

	<p class="clearfix"></p>

	</div>



	<p class="clearfix"></p>
	<%
		File f = new File("./WebContent/include/paging.jspf");
		System.out.println(f.getAbsolutePath());
		String file = f.getAbsolutePath();
		request.setAttribute("file", file);
		//절대 경로 삽입법 다시 공부
	%>

	<c:if test="${not empty p}">
		<%@ include file="include/paging.jspf" %>
	</c:if>
	
</div>

<footer>
	<%@ include file="include/footer.jspf" %>
</footer>
</body>
</html>