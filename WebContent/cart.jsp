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

	$(function(){
		
	  	$(".selectAll").change(function(){
	  		
	  		alert("체크중");
	  		if($(".selectAll").is(":checked")){
	  			$(".seleteEach").each(function(){
	  				$(this).prop("checked", true);	
	  				
	  				let sum = parseInt($("#totalProductPrice").val());
					sum += parseInt($(this).parent().parent().find("td:eq(7)").text());
	  	  			$("#totalProductPrice").val(sum);

	  			});
	  		} else {
	  			$(".seleteEach").each(function(){
	  				$(this).prop("checked", false);	
	  				$("#totalProductPrice").val("0");
	  			});	  			
	  		}
	  		
	  	});
	  	
	  	
  		$(".seleteEach").change(function(){
			console.log("eachPrice: " + $(this).parent().parent().find("td:eq(7)").text());
			let sum = parseInt($("#totalProductPrice").val());
  			
			if($(this).is(":checked")){
	  			sum += parseInt($(this).parent().parent().find("td:eq(7)").text());
  			} else {
  			    sum -= parseInt($(this).parent().parent().find("td:eq(7)").text());
	  		}
  			
  			$("#totalProductPrice").val(sum);

  			
  			if (parseInt($("#totalProductPrice").val()) < 70000) {
  				$("#shippingfee").val("3000");
  			} else {
  				$("#shippingfee").val("0");  
  			}
  			
  			$("#totalPrice").val(parseInt($("#totalProductPrice").val())+parseInt($("#shippingfee").val()));
  			
  		});
  		
	});  // document ready의 끝	
	

	
	$(document).on("change", ".qty", function () {
	  		//에이젝스로 장바구니 수령 update처리
	  		//${cart.price * cart.qty }부분 값도 변경 처리
	  		//alert("수량 변경 중!" + $(this).val()+", cartNo: " + $(this).parent().parent().find("td:eq(1)").attr("value"));		
	  		let eachTotalPrice = $(this).parent().next();
	  		
	  		let selectEach = $(this).parent().parent().find("td:eq(0)").find("input:eq(0)");

	  		//alert("eachPrice: " + $(this).parent().next().text());
	  		
			$.ajax("ajaxController", {
				type : "get",
				data : "type=updateQty&cartNo="+$(this).parent().parent().find("td:eq(1)").attr("value")+"&qty="+$(this).val(),
				dataType : "json",
				success : function(data){
					
					//여기에서 function의 파라미터 data는 위의 date랑 다른 것
					alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
					let qty = data.qty;
					let cartPrice = data.cartPrice;
					
					let htmlTag = "";
					htmlTag += data.qty*data.cartPrice;
					alert("계산된 html: " +  htmlTag);
					
					//alert("ajax 안 eachPrice text: " + $(this).parent().next().text());
					
					//console.log(this);
					//console.log($(this).parent().next());
					
					eachTotalPrice.text(htmlTag);
					$(".seleteEach").prop("checked", false);
					$("#totalProductPrice").val("0");
					$("#shippingfee").val("3000");
					$("#totalPrice").val("0");
		
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
					htmlTag += '<td class="align-middle"><input type="checkbox" name="selectProduct" class="seleteEach"></td>'; 
					htmlTag += '<td class="cartNo align-middle" value="'+this.cartNo+'">'+this.cartNo+'</td>'; 
					htmlTag += '<td class="align-middle"><img src="./img/'+this.thumnail+'" alt="img" width="100%"></td>'; 
					htmlTag += '<td class="align-middle"><a href="controller?type=productdetail&productno='+this.productNo+'">'+this.productName+'</a></td>'; 
					htmlTag += '<td class="align-middle"><input type="text" name="optionSize" class="optionSize" value="'+this.optionSize+'" style="width: 100%" readonly></td>'; 
					htmlTag += '<td class="align-middle"><input type="number" name="price" class="price" value="'+this.price+'" style="width: 100%" readonly></td>'; 
					htmlTag += '<td class="align-middle"><input type="number" name="qty" class="qty" value="'+this.amount+'" style="width: 100%" min="1"></td>'; 
					htmlTag += '<td class="eachTotalPrice align-middle">'+(this.price*this.amount)+'</td>'; 
					htmlTag += '<td class="align-middle">'; 
					htmlTag += '<input type="hidden" class="cartNo" value="'+this.cartNo+'">'; 
					htmlTag += '<input type="hidden" class="productNo" value="'+this.productNo+'">'; 
					htmlTag += '<input type="button" class="btn btn btn-sm" onclick="deleteCart('+this.cartNo+')" value="삭제하기">'; 
					htmlTag += '<input type="button" class="btn btn btn-sm" onclick="addLike('+this.productNo+')" value="관심상품등록">'; 
					htmlTag += '</td>'; 
					htmlTag += '</tr>'; 
					
				})
				
				$("#cartListBody").html(htmlTag);
				// document.location.reload();
				// history.go(0);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
			
  	  	}) // ajax의 끝	 
  	  	
	} // delectCart의 끝
	
	function delete_cart_all(){
		
  		$.ajax("ajaxController", {

			type : "get",
			data : "type=deleteCartAll",
			dataType : "json",
			success : function(data){
				
				//여기에서 function의 파라미터 data는 위의 date랑 다른 것
				alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
				let result = data.result;
				
				alert(result + "건의 상품이 삭제되었습니다");
				
				let htmlTag = "";
				
				htmlTag += '<tr><td colspan="9">장바구니가 비어 있습니다</td></tr>'; 
				
				$("#cartListBody").html(htmlTag);
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
			
  	  	}) // ajax의 끝	
		
	}
	
	
	function addLike (productNo) {

  		$.ajax("ajaxController", {

			type : "get",
			data : "type=addLike&productNo="+productNo,
			dataType : "json",
			success : function(data){
				
				//여기에서 function의 파라미터 data는 위의 date랑 다른 것
				alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
				let result = data.result;
				
				if (result == 1) {
					alert("관심상품에 추가되었습니다");
				} else {
					alert("이미 관심상품에 등록되어 있습니다");
				}
			},
			error : function(jqXHR, textStatus, errorThrown){
				alert("Ajax 처리 실패 : \n"
						+ "jqXHR : " + jqXHR.readyState + "\n"
						+ "textStatus : " + textStatus + "\n"
						+ "errorThrown : " + errorThrown);
			}
			
  	  	}) // ajax의 끝	
		
	}
	
	
  	function go_order(frm) {
 
  		alert("주문하기 연결");
		/*
  		$(".seleteEach").each(function(){

  			let cartNo = $(this).parent().siblings("td:eq(7)").find("input:eq(0)").attr("value");
  			let productNo = $(this).parent().siblings("td:eq(7)").find("input:eq(1)").attr("value");
  			let optionSize = $(this).parent().siblings("td:eq(3)").find("input:eq(0)").attr("value");
			let price = $(this).parent().siblings("td:eq(4)").find("input:eq(0)").attr("value");
  			let qty = $(this).parent().siblings("td:eq(5)").find("input:eq(0)").attr("value");

			console.log($(this).parent().siblings("td:eq(7)").find("input:eq(1)").attr("disabled"));
			console.log($(this).parent().siblings("td:eq(7)").find("input:eq(1)").attr("value"));
			
			if ($(this).prop('checked') == false) {
				$(this).parent().siblings("td:eq(7)").find("input:eq(0)").attr("disabled", true);
				$(this).parent().siblings("td:eq(7)").find("input:eq(1)").attr("disabled", true);
				$(this).parent().siblings("td:eq(3)").find("input:eq(0)").attr("disabled", true);
				$(this).parent().siblings("td:eq(4)").find("input:eq(0)").attr("disabled", true);
				$(this).parent().siblings("td:eq(5)").find("input:eq(0)").attr("disabled", true);
			} 		
		*/
		
  		$(".seleteEach").each(function(){

			if ($(this).prop('checked') == false) {
				$(this).parent().siblings("td:eq(7)").find("input:eq(0)").attr("disabled", true);
			} 
			
	  		frm.action = "controller";
			frm.submit();

  		});

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
		<table id="cartList" class="table text-center" width="100%">
		<colgroup>
			<col style="width: 5%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 25%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 10%;">
		</colgroup>
		<thead class="bg-light">
			<tr>
				<th><input type="checkbox" class="selectAll" name="selectProducts"></th>
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
			<c:if test="${empty list }">
				<tr><td colspan="9">장바구니가 비어 있습니다</td></tr>
			</c:if>
			<c:forEach var="cart" items="${list }" >
				<tr>
					<td class="align-middle"><input type="checkbox" class="seleteEach" name="selectProduct"></td>
					<td class="cartNo align-middle" value="${cart.cartNo }">${cart.cartNo }</td>
					<td class="align-middle"><img src="./img/${cart.thumnail }" alt="img" width="100%"></td>
					<td class="align-middle"><a href="controller?type=productdetail&productNo=${cart.productNo }"> ${cart.productName }</a></td>
					<td class="align-middle"><input type="text" name="optionSize" class="optionSize" value="${cart.optionSize }" style="width: 100%" readonly></td>
					<td class="align-middle"><input type="number" name="price" class="price" value="${cart.price }" style="width: 100%" readonly></td>
					<td class="align-middle"><input type="number" name="qty" class="qty" value="${cart.amount }" style="width: 100%" min="1"></td>
					<td class="eachTotalPrice align-middle">${cart.price * cart.amount }</td>
					<td class="align-middle">
						<input type="hidden" name="cartNo" value="${cart.cartNo }">
						<input type="hidden" name="productNo" value="${cart.productNo }">
						<input type="button" class="btn btn-sm" onclick="deleteCart(${cart.cartNo })" value="삭제하기">
						<input type="button" class="btn btn-sm" onclick="addLike(${cart.productNo})" value="관심상품등록">
					</td>
				</tr>
			</c:forEach>
		</tbody>
		<tfoot class="bg-light">
			<tr>
				<td colspan="2">
					<span class="float-left">기본배송</span>
				</td>
				<td class="float-none"></td>
				<td colspan="8" class="text-right">
					<span>
					<span>총상품금액: <strong><input type="text" id="totalProductPrice" name="totalPrice" size="4" value="0" readonly></strong></span>
					<span>배송비: <input type="text" id="shippingfee" name="shippingfee" value="3000" size="3" readonly></span>
					<span>총합계금액: <strong><input type="text" id="totalPrice" name="totalPrice" size="4" value="0" readonly></strong></span>
					</span>
				</td>
			</tr>
			<tr>
				<td colspan="9" class="text-left">
					<input type="button" class="btn btn-outline-light text-dark border btn-sm" onclick="delete_cart_select()" value="선택상품삭제">
					<input type="button" class="btn btn-outline-light text-dark border btn-sm" onclick="delete_cart_all()" value="장바구니비우기">
				</td>
			</tr>
		</tfoot>
		</table>
		<input type="hidden" name="type" value="pay">
		<input type="button" class="btn btn-outline-light text-dark border btn-lg" onclick="go_order(this.form)" value="주 문 하 기">
		</form>
	</div>
</div> <!-- container end -->

	<footer>
		<%@ include file="include/footer.jspf" %>
	</footer>

</body>
</html>