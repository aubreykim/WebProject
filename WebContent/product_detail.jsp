<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
<style>
 #footer { font-size: 0.8em; }
 pre {    
    white-space: pre-wrap;
    word-break: break-all;
    overflow: auto;    
  }
</style>
<script>

	function select_opt(button) {
		$(function(){
			alert("클릭됨");
			
			let htmlTag = "";
			
			htmlTag += "<tr>";
			htmlTag += "<td>${productVO.productName }/</td>";
			htmlTag += "<td>"+button.value+"</td>";
			htmlTag += "<td class='float-left'>";
			htmlTag += "<tr>";
			htmlTag += "<td>";
			htmlTag += "<input type='button' onclick='qty_minus(this.form)' value='-'>";
			htmlTag += "<input type='text' name='qty' size='1' value='1'>";
			htmlTag += "<input type='button' onclick='qty_plus(this.form)' value='+'>";
			htmlTag += "<input type='button' onclick='qty_delete(this.form)' value='x'>";
			htmlTag += "<input type='hidden' name='productNo' value='${productVO.productNo}'>";
			htmlTag += "<input type='hidden' name='productOption' value="+button.value+">";
			htmlTag += "</td>";
			htmlTag += "<td>";
			htmlTag += "<div>";
			htmlTag += "<span><strong>${productVO.price }</strong></span>";
			htmlTag += "</div>";
			htmlTag += "</td>";
			htmlTag += "</tr>";
			
			$("#optionList").after(htmlTag);
		});
		
	}
	
	function qty_minus(frm) {
		let qty = parseInt(frm.qty.value);
		if (qty > 1) {
			frm.qty.value = qty - 1;
		}
	}
	
	function qty_plus(frm) {
		let qty = parseInt(frm.qty.value);
		frm.qty.value = qty + 1;
	}
	
	function qty_delete(frm) {
		$(function(){
			alert("취소됨");
		});
		
	}
	
	function go_pay(frm) {
		alert("결제 페이지로 이동");
		frm.action = "controller?type=pay";
		frm.submit();
	}
	
	function add_cart(frm) {
		alert("장바구니에 추가되었습니다");
		frm.action = "controller?type=addCart";
		frm.submit();
	}
	
	function add_like(frm) {
		alert("관심 목록에 추가되었습니다");
		frm.action = "controller?type=addLike";
		frm.submit();
	}
	
</script>
</head>
<body>
<div class="container align-content-center">
	<div>
	<!-- <jsp:include page="include/header.jsp"/> --> 
	<%@ include file="include/header.jspf" %>
	<div class="float-left w-40" style="height:  600px;">
		<img src="img/${productVO.thumnail }" alt="img/${productVO.thumnail }" width="auto" height="90%">
	</div>
	<div class="p-5 float-left w-50" style="">
		<div>
			<table>
				<colgroup>
					<col style="width: 25%;">
				</colgroup>
				<tr>
					<th>상품명</th>
					<td>${productVO.productName }</td>
				<tr>
					<th>판매가</th>
					<td>${productVO.price }원</td>
				</tr>
				<tr>
					<th>배송비</th>
					<td>3,000원 (70,000원 이상 구매 시 무료)</td>
				</tr>
				<tr>
					<th>Option</th>
					<td>
						<c:forEach var="size" items="${SizeList }">
							<input type="button" class="btn btn-outline-light text-dark" onclick="select_opt(this)" value="${size.optionSize }">
						</c:forEach>
					</td>
				</tr>
			</table>
		</div>
		<hr>
		<div>
		<span>(최소주문수량 1개 이상)</span>
		</div>
		<hr>
		<div>
			<p>위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</p>
			<hr>
			<hr>
			<div>
				<form>
					<table>
						<colgroup>
						<col style="width: 30%;">
						<col style="width: 10%;">
						<col style="width: 40%;">
						</colgroup>
						<tr class="d-none">
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
						</tr>
						<div  id="optionList">
						</div>
					</table>
				<hr>
				<hr>
				<div>
					<button class="btn btn-outline-light text-dark" onclick="go_pay(this.form)">바로구매</button>
					<button class="btn btn-outline-light text-dark" onclick="add_cart(this.form)">장바구니</button>
					<button class="btn btn-outline-light text-dark" onclick="add_like(this.form)">관심상품</button>
				</div>
				</form>
			</div>
		</div>
	</div>
	<p class="clearfix">
	<%@ include file="include/detailnav.jspf" %>
	<p class="float-none">
	<div class="text-center">
		<pre>
		<!--<%@ include file="include/productinfo_detail.jspf" %>-->
		${productVO.content }
		</pre>
	</div>
	<%@ include file="include/detailnav.jspf" %>
	<p class="clear">
	<div class="text-center">
		<pre>
			<%@ include file="include/shippinginfo_detail.jspf" %>
		</pre>
	</div>
	<%@ include file="include/detailnav.jspf" %>
	<div id="menu3">
		 <table class="table">
		 	<caption class="d-none">상품리뷰</caption>
		 	<thead class="thead-light">
		 		<tr>
		 			<th>번호</th>
		 			<th>제목</th>
		 			<th>작성자</th>
		 			<th>작성일</th>
		 			<th>조회</th>
		 		</tr>
		 	</thead>
		 	<tbody>
	 	 			<td>1</td>
	 	 			<td>테스트</td>
	 	 			<td>테스터</td>
	 	 			<td>2022-10-17</td>
	 	 			<td>0</td>
		 	</tbody>
		 </table>
		 <div class="text-right">
		 	<button class="btn btn-outline-light text-dark">상품리뷰쓰기</button>
		 	<button class="btn btn-outline-light text-dark">모두보기</button>
		 </div>
	</div>
	<%@ include file="include/detailnav.jspf" %>
	<div id="menu4">
	 	<table class="table">
	 	<caption class="d-none">상품Q&A</caption>
	 	<thead class="thead-light">
	 		<tr>
	 			<th>번호</th>
	 			<th>제목</th>
	 			<th>작성자</th>
	 			<th>작성일</th>
	 			<th>조회</th>
	 		</tr>
	 	</thead>
	 	<tbody>
 	 			<td>1</td>
 	 			<td>테스트</td>
 	 			<td>테스터</td>
 	 			<td>2022-10-17</td>
 	 			<td>0</td>
	 	</tbody>
	 </table>
		<div class="text-right">
			<button class="btn btn-outline-light text-dark">상품문의하기</button>
			<button class="btn btn-outline-light text-dark">모두보기</button>
		</div>
	</div>
</div>
</body>
<footer>
<%@ include file="include/footer.jspf" %>
</footer>
</html>