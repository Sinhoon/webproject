<%@page import="kr.co.acorn.dto.MemberDto"%>
<%@page import="kr.co.acorn.dao.MemberDao"%>
<%@ page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String email = request.getParameter("email");
	String name = request.getParameter("name");
	String password = request.getParameter("password");
	String phone = request.getParameter("phone");
	String addr = request.getParameter("addr");
	int gender = Integer.parseInt(request.getParameter("gender"));
	String regdate = request.getParameter("regdate");
	String tempPage = request.getParameter("page");

	MemberDao dao = MemberDao.getInstance();
	MemberDto dto = new MemberDto(email, name, password, phone, addr, gender, null);
	boolean isSuccess = dao.update(dto);
	if (isSuccess) {
%>
<script>
	alert('회원정보가 수정되었습니다.');
	location.href= "view.jsp?page= <%=tempPage%> & email= <%=email%>";
</script>
<%
	} else {
%>
<script>
	alert('DB Error');
	history.back(-1);
</script>
<%
	}
%>

