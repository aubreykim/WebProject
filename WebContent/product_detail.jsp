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
			htmlTag += "<td>${productVO.productName }/";
			htmlTag += button.value;
			htmlTag += "</td>";
			
			htmlTag += "<td>";
			htmlTag += "<input type='button' onclick='qty_minus(this.form)' value='-'>";
			htmlTag += "<input type='text' name='qty' size='1' value='1'>";
			htmlTag += "<input type='button' onclick='qty_plus(this.form)' value='+'>";
			htmlTag += "<input type='button' onclick='qty_delete(this.form)' value='x'>";
			htmlTag += "</td>";
			
			htmlTag += "<td>";
			htmlTag += "<span><strong>${productVO.price }</strong></span>";
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
		frm.type.value = "pay";
		frm.action = "controller";
		frm.submit();
	}
	
	function add_cart(frm) {
		alert("장바구니에 추가되었습니다");
		frm.type.value = "addCart";
		frm.action = "controller";
		frm.submit();
	}
	
	function add_like(frm) {
		alert("관심 목록에 추가되었습니다");
		frm.type.value = "addLike";
		frm.action = "controller";
		frm.submit();
	}
	
</script>
</head>
<body>
<div class="container align-content-center">

	<%@ include file="include/header.jspf" %>

	<div id="productsummary" class="p-3 border float-left" style="width:100%">

		<div id="productimg" class="border text-center float-left" style="width:50%;">
			<img src="img/${productVO.thumnail }" alt="${productVO.thumnail }" width=80%;>
		</div>
		
		<div id="productselect" class="p-5 border float-left" style="width:50%;">
			<div id="productinfo">
				<table style="width:100%;">
					<colgroup>
						<col style="width: 30%;">
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
				</table>				
				<hr>
				<table style="width:100%;">
				<colgroup>
					<col style="width: 30%;">
				</colgroup>
					<tr>
						<th>Option</th>
						<td>
							<c:forEach var="size" items="${SizeList }">
								<input type="button" class="btn btn-outline-light text-dark" onclick="select_opt(this)" value="${size.optionSize }">
							</c:forEach>
						</td>
					</tr>
				</table>
				<hr>
			</div>
			
			<div>
			<span>(최소주문수량 1개 이상)</span>
			</div>
			<br>
			<p>위 옵션선택 박스를 선택하시면 아래에 상품이 추가됩니다.</p>
			<hr>
			
			<div id="productfrm">
				<form>
					<table style="widht: 100%">
						<colgroup>
						<col style="width: 50%;">
						<col style="width: 40%;">
						</colgroup>
						
						<tr class="d-none">
							<th>상품명</th>
							<th>수량</th>
							<th>가격</th>
						</tr>
						<tr>
						<td colspan="3">
						<input type='hidden' name='productNo' value='${productVO.productNo}'>
						<input type='hidden' name='productOption' value='button.value'>
						<input type='hidden' name='type' value='type'>
						</td>
						</tr>
						<tbody id="optionList">
						
						</tbody>
					</table>
					<hr>
					<div>
						<button class="btn btn-outline-light text-dark" onclick="go_pay(this.form)">바로구매</button>
						<button class="btn btn-outline-light text-dark" onclick="add_cart(this.form)">장바구니</button>
						<button class="btn btn-outline-light text-dark" onclick="add_like(this.form)">관심상품</button>
					</div>
				</form>				
			</div>
			
		</div> <!-- productselect div end -->
		
	</div> <!-- summary div end -->
	
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
	<p class="clear"></p>
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