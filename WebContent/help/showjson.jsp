<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>

<%
	ListHelpDao dao = ListHelpDao.getInstance();
	int num = Integer.parseInt(request.getParameter("num"));
	out.print(dao.contentJson(num));
%>