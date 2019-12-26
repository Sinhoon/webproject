<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
		<li class="breadcrumb-item active" aria-current="page">요청페이지</li>
	</ol>
</nav>
<!-- breadcrumb end-->
<%
	int cPage = 0;
	String tempPage = request.getParameter("page");
	if (tempPage == null || tempPage.length() == 0) {
		cPage = 1;
	}
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
%>
<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>요청등록</h3>
			<form name="f" method="post" action="save.jsp">
				<div class="form-group row">
					<label for="category" class="col-sm-2 col-form-label">카테고리</label>
					<div class="col-sm-10">
						해주소<input type="radio" id="category" name="category" value=1 
						style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						알려주소<input	type="radio" id="category" name="category" value=2
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						가져다주소<input type="radio" id="category" name="category" value=3
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp;&nbsp;
						 기타소<input	type="radio" id="category" name="category" value=4
							style="font-size: 10px; width: 15px; height: 15px">
						<div id="categoryMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="title" class="col-sm-2 col-form-label">제목</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="title" name="title">
						<div id="titleMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="content" class="col-sm-2 col-form-label">세부내용</label>
					<div class="col-sm-10">
						<textarea class="form-control" cols="70" rows="10" id="content" name="content">
						</textarea>
					
						<div id="detailMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="gender" class="col-sm-2 col-form-label">선호성별</label>
					<div class="col-sm-10">
						남자<input type="radio" id="gender" name="gender" value=1
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp; 여자<input
							type="radio" id="gender" name="gender" value=2
							style="font-size: 10px; width: 15px; height: 15px">&nbsp;&nbsp; 
							성별무관<input
							type="radio" id="gender" name="gender" value=3
							style="font-size: 10px; width: 15px; height: 15px">
						<div id="genderMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="helper" class="col-sm-2 col-form-label">모집인원</label>
					<div class="col-sm-10">
					<select id="helper" name="helper" >
 						<%for(int i=1; i<=10; i++){ %>
 						<option value="<%=i%>" selected><%=i%></option>
  						<%}%>
					</select>
					<div id="helperMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="addr" class="col-sm-2 col-form-label">주소</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="addr" name="addr">
						<div id="addrMessage"></div>
					</div>
				</div>
				<input type="hidden" name="checkEmail" id="checkEmail" value="no" />
				<!-- 해당값이 기본값(no)이면 안보내준다 -->
			</form>
			<div class="text-right">
				<button type="button" id="saveAsk" class="btn btn-outline-success">저장</button>
			</div>
		</div>
	</div>
</div>
<!-- main end -->
<%@ include file="../inc/footer.jsp"%>
<script>
	$(function() {
		$("#name").focus();
		$("#saveAsk").click(function() {
							//자바스크립트 유효성 검사
							f.submit();
							if (!$("#category").val()) {
								$("#category").addClass("is-invalid");
								$("#categoryMessage").html("<span class ='text-danger'>카테고리를 선택하세요.</span>");
								$("#category").focus();
								return;
							}

							if ($("#title").val().length == 0) {
								$("#title").addClass("is-invalid");
								$("#titleMessage")
										.html(
												"<span class ='text-danger'>제목을 입력하세요.</span>");
								$("#title").focus();
								return;
							}

							if ($("#detail").val().length == 0) {
								$("#detail").addClass("is-invalid");
								$("#detailMessage")
										.html(
												"<span class ='text-danger'>세부내용을 입력하세요.</span>");
								$("#detail").focus();
								return;
							}

							if (!$("#gender").val()) {
								$("#gender").addClass("is-invalid");
								$("#genderMessage")
										.html(
												"<span class ='text-danger'>선호성별을 선택하세요.</span>");
								$("#gender").focus();
								return;
							}
							
							if ($("#helper").val().length == 0) {
								$("#helper").addClass("is-invalid");
								$("#helperMessage")
										.html(
												"<span class ='text-danger'>모집인원을 선택하세요.</span>");
								$("#helper").focus();
								return;
							}

							if ($("#addr").val().length == 0) {
								$("#addr").addClass("is-invalid");
								$("#addrMessage")
										.html(
												"<span class ='text-danger'>주소를 입력하세요.</span>");
								$("#addr").focus();
								return;
							}
								
						});

		$("#category").keyup(function() {
			$("#category").removeClass("is-invalid");
			$("#categoryMessage").html('');
		});

		$("#title").keyup(function() {
			$("#title").removeClass("is-invalid");
			$("#titleMessage").html('');
		});
		$("#detail").keyup(function() {
			$("#detail").removeClass("is-invalid");
			$("#detailMessage").html('');
		});
		$("#gender").keyup(function() {
			$("#gender").removeClass("is-invalid");
			$("#genderMessage").html('');
		});
		$("#helper").keyup(function() {
			$("#helper").removeClass("is-invalid");
			$("#helperMessage").html('');
		});
		$("#addr").keyup(function() {
			$("#addr").removeClass("is-invalid");
			$("#addrMessage").html('');
		});
	});
</script>

