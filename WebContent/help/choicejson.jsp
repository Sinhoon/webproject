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
	String email = request.getParameter("email");
	ListHelpDto ldto = ldao.select(num);
	if (email.equals(ldto.getEmail())) {
		item.put("result", "자신이 등록한 요청입니다.");
		out.print(item);
	} else {
		if (rdao.islist(ldto, email) == 0) {
			Boolean isSuccess = rdao.insert(ldto, email);
			if (isSuccess == true) {
				item.put("result", "성공");
				out.print(item);
			} else {
				item.put("result", "실패");
				out.print(item);
			}
		}
		else{
			item.put("result", "이미 수락한 요청입니다.");
			out.print(item);
		}
	}
%>