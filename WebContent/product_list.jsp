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
 #header image { width: 100px }
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
<div class="container align-content-center">
	<!-- <jsp:include page="include/header.jsp"/> -->
	<%@ include file="include/header.jspf" %>
	<div>
		<h2 class="text-center">${category }</h2>
		<div class="container">
		  <ul class="nav justify-content-end">
		    <li class="nav-item">
		      <input type="button" id="orderByNew" value="최신등록순">
		    </li>
		    <li class="nav-item">
		      <input type="button" id="orderByName" value="제품명">
		    </li>
		    <li class="nav-item">
		      <input type="button" id="orderByPrice" value="가격순">
		    </li>
		  </ul>
		</div>
	</div>
	<p class="clearfix"></p>
	<div id="productList" class="w-100 p-3">
		<c:if test="${empty productList }">
			<h3>해당 카테고리에 현재 판매중인 상품이 없습니다</h3>
		</c:if>
		<c:forEach var="productVO" items="${productList }">
			<div class="float-left" style="width: 33%;">
				<div>
				<a href="controller?type=productdetail&productno=${productVO.productNo }">
					<img src="img/${productVO.thumnail }" alt="img" width="90%" height="350px">
				</a>
				</div>
				<div class="product_title">${productVO.productName }</div>
				<div class="product_price">${productVO.price }</div>
			</div>
		</c:forEach>
	</div>
	
	<p class="clearfix"></p>
	<%@ include file="include/paging.jspf" %>
</div>
<footer>
	<%@ include file="include/footer.jspf" %>
</footer>
</body>
</html>