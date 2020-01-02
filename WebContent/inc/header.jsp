<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@ page pageEncoding="utf-8"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">


<!-- Navbar Start -->
<nav class="navbar navbar-expand-lg navbar-dark"
	style="background-color: #662500">
	<div class="text-center">
		<h2>
			<a class="navbar-brand" href="/index.jsp">시켜만주소</a>
		</h2>
	</div>
	<!-- 최상위 인데스 jsp 호출 -->
	<button class="navbar-toggler" type="button" data-toggle="collapse"
		data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02"
		aria-expanded="false" aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<%
		// /dept/list.jsp,	/emp/list.jsp,	/notice/list.jsp
		String uri = request.getRequestURI();
		String contextPath = request.getContextPath();
	%>
	<div class="collapse navbar-collapse" id="navbarTogglerDemo02">
		<ul class="navbar-nav mr-auto mt-2 mt-lg-0">
			<li class="nav-item <%if (uri.startsWith("/ask")) {%>active<%}%>">
				<a class="nav-link" href="/ask/write.jsp">요청 </a>
			</li>
			<li class="nav-item <%if (uri.startsWith("/help")) {%>active<%}%>">
				<a class="nav-link" href="/help/list.jsp">수락 </a>
			</li>


		</ul>
		<ul class="navbar-nav">
			<%
				MemberDto memberDto = (MemberDto) session.getAttribute("member");
				if (memberDto == null) {
			%>
			<li class="nav-item"><a class="nav-link"
				href="/member/write.jsp">회원가입</a></li>
			<li class="nav-item"><a class="nav-link"
				href="/member/login.jsp">로그인</a></li>
			<%
				} else {
			%>
			<li class="nav-item"><a class="nav-link" href="/mypage/list.jsp">MyPage</a></li>	
			<li class="nav-item"><a class="nav-link"
				href="/member/logout.jsp">로그아웃</a></li>
			<%
				}
			%>
		</ul>
	</div>
</nav>
<!-- Navbar End-->