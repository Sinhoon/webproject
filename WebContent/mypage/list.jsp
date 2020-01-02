<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<style>
	.border-styles > p{
		margin: 2px 0;
		padding: 1px 3px;
		border-width: 2px;
		border-color: #aaa;
	}
</style>
<script src="../js/jquery-3.4.1.js"></script>
<script>

<%-- /*-------------------- 수락자 인원 확인 -----------------------*/
$(function(){
	$("#ask").click(function(){
    	let num = $(this).closest('tr').find('button:first').attr('id');
    	let email = '<%=memberDto.getEmail()%>';
		$.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : 'helperlist.jsp',
			data : {"start" :0,"length":5,"email":email},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				console.log(obj)
				$(".table>tbody").html("");
				if (obj.length !=0){
				for(let i=0; i<obj.length;i++){
					if(obj[i].iscomplete == 1){iscom="진행중"}
					$(".table>tbody").append("<tr><td>"+obj[i].num+"</td>"
							+"<td><button class='bt' id="+obj[i].num+">"+obj[i].title+"</button></td>"
							+"<td>"+ obj[i].regdate +"</td>" 
							+"<td>"+ iscom +"</td>" 
							+"<td><button class='sbt'>취소</button></td></tr>");
					}
				}
	
			}
		});
	}); --%>

/*--------------------- 카테고리 선택 ------------------------*/ 
$(function(){
	$("#ask").click(function(){
		let email = '<%=memberDto.getEmail()%>';
		let iscom = "대기중"
		$.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : 'asklist.jsp',
			data : {"start" :0,"length":5,"email":email},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				console.log(obj)
				$(".table>tbody").html("");
				if (obj.length !=0){
				for(let i=0; i<obj.length;i++){
					if(obj[i].iscomplete == 1){iscom="진행중"}
					$(".table>tbody").append("<tr><td>"+obj[i].num+"</td>"
							+"<td><button class='bt' id="+obj[i].num+">"+obj[i].title+"</button></td>"
							+"<td>"+ obj[i].regdate +"</td>" 
							+"<td><button class='hbt'>"+obj[i].hmax+"명</td>" 
							+"<td>"+ iscom +"</td>" 
							+"<td><button class='sbt'>취소</button></td></tr>");
					}
				}
				<%
				int start = 0;
				int len = 5;
				int pageLength = 10;
				int totalRows = 0;
				int totalPage = 0;
				int startPage = 0;
				int endPage = 0;
				int pageNum = 0;

				String tempPage = request.getParameter("page");
				//String tempLen = request.getParameter("len");
				int cPage = 0;
				if (tempPage == null || tempPage.length() == 0) {
					cPage = 1;
				}

				try {
					cPage = Integer.parseInt(tempPage);
				} catch (NumberFormatException e) {
					cPage = 1;
				}

				//An = a1 + (n-1)*d : 등차수열
				ListHelpDao dao = ListHelpDao.getInstance();
				totalRows = dao.getTotalRows();
				totalPage = totalRows % len == 0 ? totalRows / len : totalRows / len + 1;
				if (totalPage == 0) {
					totalPage = 1;
				}
				if (cPage > totalPage) {
					totalPage = 1;
				}

				start = (cPage - 1) * len;
				pageNum = totalRows - (cPage - 1) * (len);

				ArrayList<ListHelpDto> list = dao.select(start, len);

				int currentBlock = cPage % pageLength == 0 ? (cPage / pageLength) : (cPage / pageLength + 1);
				int totalBlock = totalPage % pageLength == 0 ? (totalPage / pageLength) : (totalPage / pageLength + 1);

				startPage = 1 + (currentBlock - 1) * pageLength;
				endPage = pageLength + (currentBlock - 1) * pageLength;

				if (currentBlock == totalBlock) {
					endPage = totalPage;
				}
				%>
				
			}
		});
	});

	
/*--------------------- 상세보기------------------------*/ 
      $(document).on("click",".bt",function(event){
        // 동적으로 여러 태그가 생성된 경우라면 이런식으로 클릭된 객체를 this 키워드를 이용해서 잡아올 수 있다.
        let st = $(this).attr('id');
        $.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : '../help/showjson.jsp',
			data : {"num" :st},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				if (obj.length !=0){
					if($("#"+st).parent('td').children('div').text() != ""){
						$("#"+st).parent('td').children('div').remove('div');
					}else{
						$("#"+st).parents('td').append("<div class='form-group shadow-textarea'><textarea class='form-control z-depth-1' readonly='readonly' id='exampleFormControlTextarea6' rows='3' style='background-color: white;'>"
								+ obj.content +"</textarea></div>")
					}
				}
			}
		});
      });


/*--------------------- 수락자 결정  ------------------------*/ 
      $(document).on("click",".hbt",function(event){
    	let num = $(this).closest('tr').find('button:first').attr('id');
  		$.ajax({
  			//type : 'GET',
  			//url : 'emp_json.jsp?start=0&length=10',
  			type : 'POST',
  		    url : 'helperjson.jsp',
  			data : {"num":num},
  			dataType : 'json',//xml, html
  			error : function(){		
  				alert('Json Load Error');
  			},
  			success : function(obj){
  				console.log(obj);
  			}
  		});
  	});

/*--------------------- 취소  ------------------------*/ 
$(document).on("click",".sbt",function(event){
	let num = $(this).closest('tr').find('button:first').attr('id');
		$.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : 'deletejson.jsp',
			data : {"num":num},
			dataType : 'json',//xml, html
			error : function(){		
				alert('Json Load Error');
			},
			success : function(obj){
				$("#ask").click()
			}
		});
	});
});
</script>	

<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
		<li class="breadcrumb-item active" aria-current="page">마이페이지</li>
	</ol>	
</nav>
<!-- breadcrumb end-->

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>
				마이리스트
			</h3>
			<div class="form-group row">
				<div class="col-sm-10">
					<button id="ask"> 요청 </button>
					<button> 수락 </button>
					<div id="categoryMessage"></div>
				</div>
			</div>
			<div class="table-responsive-lg">
				<p id="ct" style='display:none;'></p>
				<h5>
				요청리스트
				</h5>
				<table class="table table-hover">
					<colgroup>
						<col width="10%" />
						<col width="20%" />
						<col width="15%" />
						<col width="20%" />
						<col width="15%" />
						<col width="15%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">남은 수락자수</th>
							<th scope="col">진행여부</th>
							<th scope="col">취소</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
					
				</table>
				<nav aria-label="Page navigation example">
					<ul class="pagination justify-content-center">
						<%
							if (currentBlock == 1) {
						%>
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true">Previous</a></li>
						<%
							} else {
						%>
						<li class="page-item"><a class="page-link"
							href="list.jsp?page=<%=startPage - 1%>">Previous</a></li>
						<%
							}
						%>
						<%
							for (int i = startPage; i <= endPage; i++) {
						%>
						<li class="page-item <%if (cPage == i) {%>active<%}%>"><a
							class="page-link" href="list.jsp?page=<%=i%>"><%=i%></a></li>
						<%
							}
						%>
						<%
							if (currentBlock == totalBlock) {	
						%>
						<li class="page-item disabled"><a class="page-link" href="#"
							tabindex="-1" aria-disabled="true">Next</a></li>
						<%
							} else {
						%>
						<li class="page-item"><a class="page-link"
							href="list.jsp?page=<%=endPage + 1%>">Next</a></li>
						<%
							}
						%>
					</ul>
				</nav>
			</div>
			
		</div>
	</div>
</div>
<!-- main end -->
<%@ include file="../inc/footer.jsp"%>