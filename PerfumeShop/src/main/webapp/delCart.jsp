<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%
	//카트관련 세션 제거
	request.setCharacterEncoding("UTF-8");
	String id;
	int num;
	
	String userID =null;
	if(session.getAttribute("userID") != null){
		userID =(String)session.getAttribute("userID");
	}
	ArrayList perfumeList = (ArrayList)session.getAttribute("perfumeList");
	if (perfumeList==null) {
		perfumeList = new ArrayList<String>();
		session.setAttribute("perfumeList",perfumeList);
	}
	
	for(int i=0; i<perfumeList.size(); i++){
		id=(String)perfumeList.get(i);
		session.removeAttribute(id);
	}
	perfumeList.clear();
	
	
	response.sendRedirect("cart.jsp");
	
%>
