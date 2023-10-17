<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//id의 파라미터가 주어지지 않았을 경우
	String p_id = request.getParameter("id");
	if (p_id == null || p_id.trim().equals("")) {
		response.sendRedirect("perfumes.jsp");
		return;
	}
	//세션에 배열을 이용해서 물품 추가
	ArrayList<String> perfumeList = (ArrayList)session.getAttribute("perfumeList");
	if(perfumeList==null){
		perfumeList = new ArrayList<String>();
		session.setAttribute("perfumeList",perfumeList);
	}
	//상품의 id를 이용하여 세션 해당상품의 개수 설정
	if(perfumeList.contains(p_id)) {
		int num=(Integer)session.getAttribute(p_id)+1;
		session.setAttribute(p_id, num);
	} else{
		perfumeList.add(p_id);
		session.setAttribute(p_id, 1);
	}
	
	response.sendRedirect("perfume.jsp?id="+p_id);
%>