<%@ page pageEncoding="utf-8"%>
<%
	/* 
	HttpSession 객체를 종료하는 방법
	1. 브라우저를 종료했을 경우,
	2. 해당페이지의 시간이 세션 만료시간을 경과했을 경우
	3. invalidate() 메서드를 호출하는 경우
	세션이 만료되었단 것은 세션객체와 연결을 끊어 garbage collector로 가 날라가게되고, 다른 세션객체로 연결된다.
	 */
	//session.removeAttribute("member"); //세션객체만 유지하고 정보만 날릴 경우(장바구니 비우는 기능)
	session.invalidate();
	response.sendRedirect("/index.jsp");
%>

