<%@page import="com.mystudy.project.vo.ReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="com.mystudy.project.dao.DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:useBean id="cartVO" class="com.mystudy.project.vo.CartVO" scope="request"/>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
<style>
 pre {    
    white-space: pre-wrap;
    word-break: break-all;
    overflow: auto;    
  }
</style>
<script>	

	$(function(){
		
		//기본으로 안 보여 주기		
		$(".optiontbd").hide();

        
		$(".qty").each(function(){
			
			$(this).change(function(){
				
				let originP = parseInt($(this).parent().parent().find("input:eq(3)").val());
				let qty = parseInt($(this).val());
				let eachSum = originP*qty;

				$(this).parent().parent().find("input:eq(2)").val(eachSum);
				
				let totalPrice = 0;
				
		   		$(".eachPrice").each(function(){
	    			
	    			totalPrice += parseInt($(this).val());
	    			$("#totalPrice").text(totalPrice);
	    		});
				
			})

		});
		
		
		$(".deleteOption").each(function(){
			$(this).click(function(){
				$(this).parent().find("input:eq(0)").val("0");
				$(this).parent().parent().parent().hide();
			})
		});
		
		
		$(".pritems").each(function(){
			$(this).click(function(){
				$(this).parent().find("input:eq(0)").val("0");
				$(this).parent().parent().parent().hide();
			})
		});
		

		
	
		 $(document).on("click", ".pritems", function () {

			$.ajax("ajaxController", {
				
				//get타입으로 전달해 주는 것
				type : "get",
				data : "type=review&productNo=${productVO.productNo}&reviewPage="+$(this).attr('value'), //서버쪽으로 전달할 데이터
				//서버쪽으로 전달해 줄 데이터(파라미터) 여기에서는 전부 가져올 거라 안 적어 줘도 됨
				dataType : "json", //응답 받을 데이터 타입
				success : function(data){
					//여기에서 function의 파라미터 data는 위의 date랑 다른 것
					alert("Ajax 처리 성공 - 응답받은 데이터 : " + data);
					let rList = data.review.list; //JSON 객체 속성명 "list"의 값 추출
					let pr = data.review.pr;
					
					//전달받은 JSON 데이터 처리
					let htmlTag = "";
					$.each(rList, function(index, item){ // 아이템이 끝날 때까지
						htmlTag += "<tr>";	
						htmlTag += "<td>"+this.reviewNo+"</td>";	
						htmlTag += "<td>"+this.title+"</td>";	
						htmlTag += "<td>"+this.userName+"</td>";	
						htmlTag += "<td>"+this.wdate+"</td>";	
						<!-- htmlTag += "<td>"+this.hit+"</td>"; -->
						htmlTag += "</tr>";	
					});
					
					$("#productReview").html(htmlTag);
						
					let pagingHtml = "";

					pagingHtml += '<p class="py-5"></p>';
					pagingHtml += '<div>';
					pagingHtml += '<ul id="ReviewPagingButton" class="pagination justify-content-center">';
					
					<%--[1페이지로]에 대한 사용여부 처리 --%>
					if (pr.beginPage == 1 ) {
						pagingHtml += '<li class="page-item disabled"><a class="pritems page-link text-body">**</a></li>';
					} else {
						pagingHtml += '<li class="page-item">';
						pagingHtml += '<a class="pritems page-link text-body" value="1">';
						pagingHtml += '**';
						pagingHtml += '</a>';
						pagingHtml += '</li>';
					}
					<%--[이전으로]에 대한 사용여부 처리 --%>
					if (pr.beginPage == 1) {
						pagingHtml += '<li class="page-item disabled"><a class="pritems page-link text-body">pre</a></li>';	
					} else {
						pagingHtml += '<li class="page-item">';
						pagingHtml += '<a class="pritems page-link text-body" value="'+(pr.beginPage - 1)+'">';	
						pagingHtml += 'pre';
						pagingHtml += '</a>';
						pagingHtml += '</li>'						
					}

					<%-- 블록내에 표시할 페이지 태그 작성(시작페이지~끝페이지) --%>
					for (let i = pr.beginPage; i <= pr.endPage ; i++ ) {
						if (i == pr.nowPage) {
							pagingHtml += '<li class="page-item disabled">';
							pagingHtml += '<a class="pritems page-link text-body font-weight-bold">'+i+'</a></li>';
						} else {
							pagingHtml += '<li class="page-item">';
							pagingHtml += '<a class="pritems page-link text-body" value="'+ i +'">'+i+'</a>';
							pagingHtml += '</li>';
						}
					}
					<%--[다음으로]에 대한 사용여부 처리 --%>
					if (pr.endPage >= pr.totalPage) {
						pagingHtml += '<li class="page-item disabled">';
						pagingHtml += '<a class="pritems page-link text-body">nex</a></li>';
					} else {
						pagingHtml += '<li class="page-item">';
						pagingHtml += '<a class="pritems page-link text-body" value="'+pr.endPage + 1+'">';
						pagingHtml += 'nex';
						pagingHtml += '</a>';
						pagingHtml += '</li>';
					}		
					<%--[마지막으로]에 대한 사용여부 처리 --%>
					if (pr.endPage >= pr.totalPage) {
						pagingHtml += '<li class="page-item disabled">';
						pagingHtml += '<a class="pritems page-link text-body">**</a></li>';							
					} else {
						pagingHtml += '<li class="page-item">';
						pagingHtml += '<a class="pritems page-link text-body" value="'+pr.totalPage+'">';
						pagingHtml += '**';
						pagingHtml += '</a>';
						pagingHtml += '</li>';
					}
					pagingHtml += '</ul>';
					pagingHtml += '</div>';
					pagingHtml += '<p class="py-3"></p>';					    
				  
					$("#pagingReview").html(pagingHtml);


				},
				error : function(jqXHR, textStatus, errorThrown){
					alert("Ajax 처리 실패 : \n"
							+ "jqXHR : " + jqXHR.readyState + "\n"
							+ "textStatus : " + textStatus + "\n"
							+ "errorThrown : " + errorThrown);
				}
			});	
		
		});
		
	});
	

	
	
	function select_opt(num) {
		$(function(){
			$("#opt"+num).show();		
		});
	}
	
	
	function qty_delete(frm) {
		
		alert("선택이 취소됩니다");
		$(frm).hide();

	}
	
	
	

	function go_pay(frm) {
		
		frm.type.value = "pay";
		
		alert("결제 페이지로 이동합니다");
		
		frm.action = "controller";
		frm.submit();
	}
	
	function add_cart(frm) {	
		alert(frm.productOption.value);
		frm.type.value = "addCart";
		alert("장바구니에 추가되었습니다!!");
		frm.action = "controller";
		frm.submit();
	}
	
	function add_like(frm) {
		
		if ("${empty likeVO}") {
			
			alert("관심 목록에 추가되었습니다");	
			
		} else {
			
 			alert("관심 목록에서 삭제되었습니다");
 			
		}
		
		frm.type.value = "addLike";
		frm.action = "controller";
		frm.submit();			
		
	
	}
	
</script>
</head>
<body>
<div class="container align-content-center">

	<%@ include file="include/header.jspf" %>
	<p class="py-3"></p>

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
								<c:choose>
									<c:when test="${size.optionCount <= 0}">
										<input type="button" class="btn btn-outline-light text-dark"" value="${size.optionSize }" disabled>
									</c:when>
									<c:otherwise>
										<input type="button" class="btn btn-outline-light text-dark" onclick="select_opt(${size.optionNo})" value="${size.optionSize }">
									</c:otherwise>
								</c:choose>
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
						<c:forEach var="size" items="${SizeList }">
							<tbody class="optiontbd" id="opt${size.optionNo }">
								<tr>
									<td> ${productVO.productName } ${size.optionSize }</td>
									<td>
										<input type="number" name="qty" style="width: 60px" min="0" max="${size.optionCount }" value="0"
											class="qty border-0">
										<input type="button" class="deleteOption btn btn-outline-light text-dark " value="x">				
									</td>
									<td>
										<input type="text" name="eachPrice" value="0" size="3" class="eachPrice border-0 font-weight-bold" readonly/>
										<input type="hidden" name="originPrice" value="${productVO.price }" size="3" disable/>
										<input type="hidden" name="productOption" value='${size.optionSize }'>
									</td>
								</tr>
							</tbody>
						</c:forEach>
						<tr>
							<td class="font-weight-bold">
								totalPrice
							</td>
							<td id="totalPrice" class="totalPrice font-weight-bold" colspan="2">
							0
							</td>
						</tr>
						<tr>
							<td colspan="3">
							<input type='hidden' name='productNo' value='${productVO.productNo}'>
							<input type='hidden' name='type' value='type'>
							</td>
						</tr>
					</table>
					<hr>
					<div class="text-center">
						<button class="btn btn-outline-light text-dark" onclick="go_pay(this.form)">바로구매</button>
						
						<button class="btn btn-outline-light text-dark" onclick="add_cart(this.form)">장바구니</button>
						
						<!-- 관심상품 등록 및 해제 페이지 이동 없이 처리 가능한지 추후 구현 -->
						<c:choose>
							<c:when test="${empty likeVO }">
								<button class="btn btn-outline-light text-dark" onclick="add_like(this.form)">관심상품</button>
							</c:when>
							<c:otherwise>							
								<button class="btn btn-outline-light text-dark btn-dark" onclick="add_like(this.form)">관심상품</button>
							</c:otherwise>
						</c:choose>
					</div>
				</form>				
			</div>
			
		</div> <!-- productselect div end -->
		
	</div> <!-- summary div end -->
	<p class="clearfix">
	
	<p class="py-5"></p>
	
	<%@ include file="include/detailnav.jspf" %>
	<p class="float-none">
	<div class="text-center">
		<pre>
		<!--<%@ include file="include/productinfo_detail.jspf" %>-->
		${productVO.content }
		</pre>
	</div>
	<p class="py-5"></p>
	<%@ include file="include/detailnav.jspf" %>
	<p class="clear"></p>
	<div class="text-center">
		<pre>
			"<%@ include file="include/shippinginfo_detail.jspf" %>
		</pre>
	</div>
	<p class="py-5"></p>
	
	<%@ include file="include/detailnav.jspf" %>
	
	<div id="menu3">
		 <table class="table text-center" style="width:100%">
		 	<colgroup>
				<col style="width: 5%;">
				<col style="width: 40%;">
				<col style="width: 5%;">
				<col style="width: 10%;">
				<col style="width: 5%;">
		 	</colgroup>
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
		 	<tbody id="productReview">
	 		<c:forEach var="reviewVO" items="${reviewList }">
 			<tr>
	 			<td>${reviewVO.reviewNo }</td>
	 			<td>${reviewVO.title }</td>
	 			<td>${reviewVO.userName }</td>
	 			<td>${reviewVO.wdate.substring(0, 10) }</td>
	 			<td>${reviewVO.hit}</td>
	 		</tr>
			</c:forEach>
		 	</tbody>
		 </table>
		 <div class="text-right">
		 	<button class="btn btn-outline-light text-dark">상품리뷰쓰기</button>
		 	<button class="btn btn-outline-light text-dark">모두보기</button>
		 </div>
		 <div id="pagingReview">
			 <%@ include file="include/pagingReview.jspf" %>
		 </div>
	</div>
	<p class="py-5"></p>
	
	<%@ include file="include/detailnav.jspf" %>

	<div id="menu4">
	 	<table class="table text-center">
	 	<caption class="d-none">상품Q&A</caption>
	 	<colgroup>
			<col style="width: 5%;">
			<col style="width: 40%;">
			<col style="width: 5%;">
			<col style="width: 10%;">
			<col style="width: 5%;">
	 	</colgroup>
	 	<thead class="thead-light">
	 		<tr>
	 			<th>번호</th>
	 			<th>제목</th>
	 			<th>작성자</th>
	 			<th>작성일</th>
	 			<th>조회</th>
	 		</tr>
	 	</thead>
	 	<tbody id="productQnA">
 			<tr>
	 			<td>1</td>
	 			<td>테스트</td>
	 			<td>테스터</td>
	 			<td>2022-10-17</td>
	 			<td>0</td>
	 		</tr>
	 	</tbody>
	 </table>
		 <div id="pagingQnA">
		 	<%@ include file="include/pagingReview.jspf" %>
		 </div>
		<div class="text-right">
			<button class="btn btn-outline-light text-dark">상품문의하기</button>
			<button class="btn btn-outline-light text-dark">모두보기</button>
		</div>
	</div>
	<p class="py-5"></p>
</div>
</body>
<footer>
<%@ include file="include/footer.jspf" %>
</footer>
</html>