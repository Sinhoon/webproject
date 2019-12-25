<%@page import="kr.co.acorn.dto.EmpDto"%>
<%@page import="kr.co.acorn.dao.EmpDao"%>
<%@ page import="kr.co.acorn.dao.DeptDao" %>
<%@ page import="kr.co.acorn.dto.DeptDto" %>
<%@ page pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
	int no = 0;
	String name = request.getParameter("name");
	String job = request.getParameter("job");
	int mgr = Integer.parseInt(request.getParameter("mgr"));
	int sal = Integer.parseInt(request.getParameter("sal"));
	int comm = Integer.parseInt(request.getParameter("comm"));
	int deptNo = Integer.parseInt(request.getParameter("deptNo"));
	
	DeptDto deptDto= new DeptDto();
	deptDto.setNo(deptNo); //deptNo 불러오기
	
	EmpDao dao = EmpDao.getInstance();
	no = dao.getMaxNextNo(); //사원번호 최대값 +1 만들기
	
	
	EmpDto dto = new EmpDto(no, name, job, mgr, null, sal, comm, deptDto);
	boolean isSuccess = dao.insert(dto);
	
	if(isSuccess){
%>
<script>
	alert('사원이 등록 되었습니다.');
	location.href="list.jsp?page=1";
</script>
<%}else{%>
<script>
	alert('DB Error');
	history.back(-1);
</script>
<%}%>