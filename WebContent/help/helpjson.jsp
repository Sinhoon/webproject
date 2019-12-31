<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>

<%
	ListHelpDao dao = ListHelpDao.getInstance();
	int start = Integer.parseInt(request.getParameter("start"));
	int length = Integer.parseInt(request.getParameter("length"));
	String st =  request.getParameter("ct");
	if (st.equals("0")){
	out.print(dao.selectJson(start, length));
	}else {
	out.print(dao.CselectJson(start, length ,Integer.parseInt(st)));	
	}
%>