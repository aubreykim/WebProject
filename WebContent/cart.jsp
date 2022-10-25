<%@page import="com.mystudy.project.dao.DAO"%>
<%@page import="com.mystudy.project.vo.CartListVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
  <script> 
  

  	$(document).on("change", ".qty", function () {
  		//에이젝스로 장바구니 수령 update처리
  		//${cart.price * cart.qty }부분 값도 변경 처리
  		//alert("수량 변경 중!" + $(".qty").val()+", cartNo: " + $("#cartNo").attr("value"));		
  		
		$.ajax("ajaxController", {
			type : "get",
			data : "type=updateQty&cartNo="+$("#cartNo").attr("value")+"&qty="+$(".qty").val(),
			dataType : "json",
			success : function(data){
				
				//여기에서 function의 파라미터 data는 위의 date랑 다른 것
				//alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
				let qty = data.qty;
				let cartPrice = data.cartPrice;
				
				let htmlTag = "";
				htmlTag += data.qty*data.cartPrice;
				
				$("#eachTotalPrice").text(htmlTag);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
			
  		})
  	});
  	
  	function deleteCart(cartNo) {
  		
		alert("클릭됨");
		
  		$.ajax("ajaxController", {

			type : "get",
			data : "type=deleteCart&cartNo="+cartNo,
			dataType : "json",
			success : function(data){
				
				//여기에서 function의 파라미터 data는 위의 date랑 다른 것
				alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
				let clist = data.list;
				
				let htmlTag = "";
				
				$.each(clist, function(index, item){
					
					htmlTag += '<tr>'; 
					htmlTag += '<td><input type="checkbox" name="selectProduct"></td>'; 
					htmlTag += '<td id="cartNo" value="'+this.cartNo+'">'+this.cartNo+'</td>'; 
					htmlTag += '<td><img src="./img/'+this.thumnail+'" alt="img" width="100%"></td>'; 
					htmlTag += '<td><a href="controller?type=productdetail&productno='+this.productNo+'">'+this.productName+'</a></td>'; 
					htmlTag += '<td>'+this.optionSize+'</td>'; 
					htmlTag += '<td>'+this.price+'</td>'; 
					htmlTag += '<td><input type="number" name="qty" class="qty" value="'+this.qty+'" style="width: 60px" min="0"></td>'; 
					htmlTag += '<td>'+(this.price*this.qty)+'</td>'; 
					htmlTag += '<td>'; 
					htmlTag += '<input type="button" class="btn" onclick="deleteCart('+this.cartNo+')" value="삭제하기">'; 
					htmlTag += '</td>'; 
					htmlTag += '</tr>'; 
					
				})
				$("#cartListBody").html(htmlTag);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
			
  	  	}) // ajax의 끝	 
  	  	
	} // delectCart의 끝
		
		
  	function selectAllBox(frm) {
		alert("전체 체크박스 선택 연결");

	}
	
	
  	function go_order() {
		alert("주문하기 연결");

	}
	
  </script>
</head>
<%
	//연결 전이라 처리
	String userId = "ff";
	// String userId =  (String) request.getSession().getAttribute("user").userId;
	
	List<CartListVO> list = DAO.getCartList(userId);
	request.setAttribute("list", list);

%>
<body>
<div class="container">

	<%@ include file="include/header.jspf" %>
	<div>
		<form>
		<input type="button" onclick="selectAllBox(this.form)" value="전체선택">
		<table id="cartList" class="text-center" border>
		<colgroup>
			<col style="width: 5%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 30%;">
			<col style="width: 5%;">
			<col style="width: 5%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
		</colgroup>
		<thead>
			<tr>
				<th></th>
				<th>번호</th>
				<th>이미지</th>
				<th>상품명</th>
				<th>옵션</th>
				<th>판매가</th>
				<th>수량</th>
				<th>합계금액</th>
				<th>삭제하기</th>
			</tr>
		</thead>
		<tbody id="cartListBody">
			<c:forEach var="cart" items="${list }" >
				<tr>
					<td><input type="checkbox" name="selectProduct"></td>
					<td id="cartNo" value="${cart.cartNo }">${cart.cartNo }</td>
					<td><img src="./img/${cart.thumnail }" alt="img" width="100%"></td>
					<td><a href="controller?type=productdetail&productno=${cart.productNo }"> ${cart.productName }</a></td>
					<td>${cart.optionSize }</td>
					<td>${cart.price }</td>
					<td><input type="number" name="qty" class="qty" value="${cart.qty }" style="width: 60px" min="0"></td>
					<td id="eachTotalPrice">${cart.price * cart.qty }</td>
					<td>
						<input type="button" class="btn" onclick="deleteCart(${cart.cartNo })" value="삭제하기">
					</td>
				</tr>
			</c:forEach>
		</tbody>
		</table>
		<input type="button" onclick="go_order()" value="주문하기">
		</form>
	</div>
</div> <!-- container end -->

	<footer>
		<%@ include file="include/footer.jspf" %>
	</footer>

</body>
</html>