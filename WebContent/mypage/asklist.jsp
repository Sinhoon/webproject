<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>

<%
	ListHelpDao dao = ListHelpDao.getInstance();
	int start = Integer.parseInt(request.getParameter("start"));
	int length = Integer.parseInt(request.getParameter("length"));
	String email = request.getParameter("email");
	out.print(dao.asking(start, length, email));
%>