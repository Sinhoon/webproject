<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="java.util.ArrayList"%>
<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>

<%-- <%
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
%> --%>
<script src="../js/jquery-3.4.1.js"></script>
<script>
$(function(){
	$("#all").click(function(){
		$.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : 'helpjson.jsp',
			data : {"start" :0,"length":5},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
				if (obj.length !=0){
					for(let i=0; i<obj.length;i++){
						$("#tbo"+i).html("<tr><td>"+JSON.stringify(obj[i].num)+"</td>"
								+"<td><button id='a'>"+JSON.stringify(obj[i].title)+"</a></td>"
								+"<td>"+JSON.stringify(obj[i].regdate)+"</td>"
								+"<td><button>수락</button></td></tr>");
						console.log(i);
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
				
			<%-- 	if (obj.size() !=0){
					for(let i=0; i<obj.size();i++){
						$("#test").html("<tr> <td>"<%=pageNum-- %>"</td>"
						"<td><a href='view.jsp?page="<%=cPage%>"&email="<%=dto.getTitle()%>"'>"<%=dto.getTitle() %></a></td>
						"<td>"+obj+"</td>"
						"<td>"<%=dto.getIscomplete() %>"</td>"
					"</tr>");
					}
					
				}
				else{
				"<tr><td colspan='6'>"데이터가 존재하지 않습니다."</td></tr>"
				} --%>
				
				
			}
		});
	});
	
	
	
	
});
</script>

<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
		<li class="breadcrumb-item active" aria-current="page">요청페이지</li>
	</ol>
</nav>
<!-- breadcrumb end-->

<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>
				요청리스트(<%=totalRows%>)
			</h3>
			<form name="f" method="post" action="save.jsp">
				<div class="form-group row">
					<label for="category" class="col-sm-2 col-form-label">카테고리</label>
					<div class="col-sm-10">
						전체<input type="radio" id="all" name="all"
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						해주소<input type="radio" id="category" name="category" value=1
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						알려주소<input type="radio" id="category" name="category" value=2
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						가져다주소<input type="radio" id="category" name="category" value=3
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						기타소<input type="radio" id="category" name="category" value=4
							style="font-size: 10px; width: 15px; height: 15px">
						<div id="categoryMessage"></div>
					</div>
				</div>
			</form>
			<div class="table-responsive-lg">
				<table class="table table-hover">
					<colgroup>
						<col width="10%" />
						<col width="40%" />
						<col width="25%" />
						<col width="25%" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">#</th>
							<th scope="col">제목</th>
							<th scope="col">날짜</th>
							<th scope="col">수락</th>
						</tr>
					</thead>
					<tbody id="tbo1">


						<%-- <%if(list.size() != 0){%>
						<%for(ListHelpDto dto : list){ %>
						<tr>
							<td><%=pageNum-- %></td>
							<td><a href="view.jsp?page=<%=cPage%>&email=<%=dto.getTitle()%>"><%=dto.getTitle() %></a></td>
							<td><%=dto.getRegdate() %></td>
							<td><%=dto.getIscomplete() %></td>
						</tr>
						<%} %>
						<%}else{ %>
						<tr>
							<td colspan="6">데이터가 존재하지 않습니다.</td>
						</tr>
						<%} %> --%>
					</tbody>
					
					<tbody id="tbo2">


						<%-- <%if(list.size() != 0){%>
						<%for(ListHelpDto dto : list){ %>
						<tr>
							<td><%=pageNum-- %></td>
							<td><a href="view.jsp?page=<%=cPage%>&email=<%=dto.getTitle()%>"><%=dto.getTitle() %></a></td>
							<td><%=dto.getRegdate() %></td>
							<td><%=dto.getIscomplete() %></td>
						</tr>
						<%} %>
						<%}else{ %>
						<tr>
							<td colspan="6">데이터가 존재하지 않습니다.</td>
						</tr>
						<%} %> --%>
					</tbody>
					<tbody id="tbo3">
					</tbody>
					<tbody id="tbo4">
					</tbody>
					<tbody id="tbo5">
					</tbody>
					<tbody id="tbo6">
					</tbody>
					
				</table>
				<div id="test"></div>
				<script>
$(function(){
	$("#a").click(function(){
		$.ajax({
			//type : 'GET',
			//url : 'emp_json.jsp?start=0&length=10',
			type : 'POST',
		    url : 'helpjson.jsp',
			data : {"start" :0,"length":5},
			dataType : 'json',//xml, html
			error : function(){
				alert('Json Load Error');
			},
			success : function(obj){
						console.log("ss");
						$("#test").html(JSON.stringify(obj[i].content));
				}
				
			});
	});
	</script>
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