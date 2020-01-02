<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="kr.co.acorn.dao.RelHelpDao"%>
<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>

<%
	JSONObject item = new JSONObject();
	RelHelpDao rdao = RelHelpDao.getInstance();
	ListHelpDao ldao = ListHelpDao.getInstance();
	int num = Integer.parseInt(request.getParameter("num"));
	boolean isSuccess1 = rdao.deleteJson(num);
	boolean isSuccess2 = ldao.deleteJson(num);
	if (isSuccess1 == true &&  isSuccess2 == true) {
		item.put("result", "성공");
		out.print(item);
	}else{
		item.put("result", "실패");
		out.print(item);
	}
	
%>