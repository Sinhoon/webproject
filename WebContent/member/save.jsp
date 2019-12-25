<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String phone = request.getParameter("phone");
	
	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = new MemberDto(email, name, password, phone, null);
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess){
%>
<script>
	alert('회원이 등록 되었습니다.');
	location.href="list.jsp?page=1";
</script>
<%}else{%>
<script>
	alert('DB Error');
	history.back(-1);
</script>
<%}%>