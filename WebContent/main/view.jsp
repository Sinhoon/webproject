<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>

<%@ page pageEncoding="utf-8"%>
<%@ include file="../inc/header.jsp"%>
<!-- breadcrumb start-->
<nav aria-label="breadcrumb">
	<ol class="breadcrumb">
		<li class="breadcrumb-item"><a href="/index.jsp">HOME</a></li>
		<li class="breadcrumb-item active" aria-current="page">MEMBER</li>
	</ol>
</nav>
<!-- breadcrumb end-->
<%
	String tempPage = request.getParameter("page");
	String tempMail = request.getParameter("email");
	if (tempPage == null || tempPage.length() == 0) {
		tempPage = "1";
	}
	if (tempMail == null || tempMail.length() == 0) {
		response.sendRedirect("list.jsp?page=" + tempPage); // 이전페이지로 되돌리기
		return;
	}

	int cPage = 0;
	String email = null;
	try {
		cPage = Integer.parseInt(tempPage);
	} catch (NumberFormatException e) {
		cPage = 1;
	}
	try {
		email = tempMail;
	} catch (NumberFormatException e) {
		response.sendRedirect("list.jsp?page=" + cPage);
		return;
	}
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = dao.select(email);
	if (dto == null) {
		response.sendRedirect("list.jsp?page=" + cPage);
		return;
	}
	
	String name = dto.getName();
	String password = dto.getPassword();
	String phone = dto.getPhone();
	String regdate = dto.getRegdate();
%>
<!-- main start -->
<div class="container">
	<div class="row">
		<div class="col-lg-12">
			<h3>회원 상세보기</h3>
			<form name="f" method="post" action="save.jsp">
				<div class="form-group row">
					<label for="name" class="col-sm-2 col-form-label">이름</label>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="name" name="name" value="<%=name%>">
						<div id="nameMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="email" class="col-sm-2 col-form-label">이메일</label>
					<div class="col-sm-10">
						<input type="email" class="form-control" id="email" readonly = "readonly" name="email" value="<%=email%>">
						<div id="emailMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="password" class="col-sm-2 col-form-label">비밀번호</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="password"
							name="password" value="<%=password%>">
						<div id="passwordMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="rePassword" class="col-sm-2 col-form-label">비밀번호
						확인</label>
					<div class="col-sm-10">
						<input type="password" class="form-control" id="rePassword"
							name="rePassword" value="">
						<div id="rePasswordMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="phone" class="col-sm-2 col-form-label">휴대폰번호</label>
					<div class="col-sm-10">
						<input type="tel" class="form-control" id="phone" name="phone" value="<%=phone%>">
						<div id="phoneMessage"></div>
					</div>
				</div>
				<div class="form-group row">
					<label for="regdate" class="col-sm-2 col-form-label">가입날짜</label>
					<div class="col-sm-10">
						<input type="date" class="form-control" id="regdate" name="regdate"  readonly="readonly" value="<%=regdate%>">
						<div id="nameMessage"></div>
					</div>
				</div>
				<input type="hidden" name="checkEmail" id="checkEmail" value="no" />
				<input type="hidden" name="page" value="<%=cPage%>" />
				<!-- 해당값이 기본값(no)이면 안보내준다 -->
			</form>
			<div class="text-right">
				<a href="list.jsp" class="btn btn-outline-primary">목록</a>
				<button type="button" id="updateMember" class="btn btn-outline-success">수정</button>
				<button type="button" id="deleteMember" class="btn btn-outline-danger">삭제</button>
			</div>
		</div>
	</div>
</div>
<!-- main end -->
<%@ include file="../inc/footer.jsp"%>
<script>
	$(function() {
		$("#name").focus();
		$("#updateMember").click(function() {
							//자바스크립트 유효성 검사
							if ($("#name").val().length == 0) {
								$("#name").addClass("is-invalid");
								$("#nameMessage").html("<span class ='text-danger'>이름을 입력하세요.</span>");
								$("#name").focus();
								return;
							}

							let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
							// ^: 문자로 시작해라, 특수문자는 _,.,-만 허용한다. + @ + 도메인 1자이상 +.+ 1자이상  ex) 1@a.c

							if (regEmail.test($("#email").val()) == false) {
								$("#email").addClass("is-invalid");
								$("#emailMessage").html("<span class ='text-danger'>올바른 이메일 형식이 아닙니다.</span>");
								$("#email").focus();
								return;
							}
							if ($("#password").val().length == 0) {
								$("#password").addClass("is-invalid");
								$("#passwordMessage").html("<span class ='text-danger'>비밀번호를 입력하세요.</span>");
								$("#password").focus();
								return;
							}
							if ($("#rePassword").val().length == 0) {
								$("#rePassword").addClass("is-invalid");
								$("#rePasswordMessage").html("<span class ='text-danger'>비밀번호 확인을 입력하세요.</span>");
								$("#rePassword").focus();
								return;
							}

							if (($("#password").val() != $("#rePassword").val())) {
								$("#rePassword").addClass("is-invalid");
								$("#rePasswordMessage").html("<span class ='text-danger'>비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.</span>");
								$("#rePassword").val("");
								$("#rePassword").focus();
								return;

							}

							if ($("#phone").val().length == 0) {
								$("#phone").addClass("is-invalid");
								$("#phoneMessage").html("<span class ='text-danger'>휴대폰번호를 입력하세요.</span>");
								$("#phone").focus();
								return;
							}

							if ($("#checkEmail").val() == "no") {
								return;
							}

							f.submit();

						});

							$("#name").keyup(function() {
							$("#name").removeClass("is-invalid");
							$("#nameMessage").html('');
							});
							
							$("#email").keyup(function() {
							$("#email").removeClass("is-invalid");
							$("#emailMessage").html('');

							let regEmail = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

							if (regEmail.test($("#email").val())) {
								$.ajax({
										type : 'GET',
										url : 'check_email_ajax.jsp?email='+ $("#email").val(),
										dataType : 'json',
										error : function() {
										alert('error');},
										success : function(json) {
										//json => {"result" : "ok or fail"}

										//DB에 중복되는 이메일이 없으면 OK로 한다면
										if (json.result == "ok") {
											$("#emailMessage").html("<span class='text-success'>등록 가능한 이메일 입니다.</span>");
											$("#checkEmail").val("yes");
											} else {
												$("#email").addClass("is-invalid");
													$("#emailMessage").html("<span class='text-danger'>이미 등록된 이메일 입니다.</span>"); // danger를 사용하면 자동으로 빨갛게 나온다.
													$("#checkEmail").val("no");
												}
											}
										});
							}
						});
				$("#password").keyup(function() {
				$("#password").removeClass("is-invalid");
				$("#passwordMessage").html('');
				});	
				$("#rePassword").keyup(function() {
				$("#rePassword").removeClass("is-invalid");
				$("#rePasswordMessage").html('');
				});
				$("#phone").keyup(function() {
				$("#phone").removeClass("is-invalid");
				$("#phoneMessage").html('');
				});
			});
			
			$("#deleteMember").click(function() {
				f.action = "delete.jsp";
				f.submit();
			});
</script>

