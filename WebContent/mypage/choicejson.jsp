<%@page import="kr.co.acorn.dto.ListHelpDto"%>
<%@page import="kr.co.acorn.dao.RelHelpDao"%>
<%@page import="kr.co.acorn.dao.ListHelpDao"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page contentType="application/json;charset=utf-8"%>

<%
	JSONObject item = new JSONObject();
	RelHelpDao rdao = RelHelpDao.getInstance();
	int num = Integer.parseInt(request.getParameter("num"));
	String choice = request.getParameter("choice");
	String email = request.getParameter("email");
	boolean isSuccess1 = false;
	boolean isSuccess2 = false;
	boolean isSuccess3 = false;
	if(choice.equals("선택")){
		isSuccess1 = rdao.downhmax(num);
		isSuccess2 = rdao.changechoice(num,email,1);
		isSuccess3 = rdao.changeiscom(num,1);
	}
	else{
		isSuccess1 = rdao.uphmax(num);
		isSuccess2 = rdao.changechoice(num,email,0);
		isSuccess3 = rdao.changeiscomed(num,0);
	}
	
	if (isSuccess1 == true &&  isSuccess2 == true) {
		item.put("result", "성공");
		out.print(item);
	}else{
		item.put("result", "실패");
		out.print(item);
	}
	
%>