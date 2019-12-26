<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@ page pageEncoding="utf-8"%>

<%@ include file="/inc/header.jsp"%>
<%
	request.setCharacterEncoding("utf-8");
	ListHelpDao dao = ListHelpDao.getInstance();
	
	int num = dao.getMaxNextNo();
	int category = Integer.parseInt(request.getParameter("category"));
	String title = request.getParameter("title");
	String content = request.getParameter("content");
	int gender = Integer.parseInt(request.getParameter("gender"));
	int iscomplete = 0;
	int hmax = Integer.parseInt(request.getParameter("helper"));
	String addr = request.getParameter("addr");
	String email = memberDto.getEmail();
	ListHelpDto dto = new ListHelpDto(num, category, title, content, gender, iscomplete, hmax, addr, email, null);
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess){
%>
<script>
	alert('요청이 등록 되었습니다.');
	location.href="../help/list.jsp";
</script>
<%}else{%>
<script>
	alert('DB Error');
	history.back(-1);
</script>
<%}%>