<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%

	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String del = request.getParameter("changeNum");
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
	
	
	if (del.equals("del")) {
		perfumeList.remove(id);
		session.removeAttribute(id);
	} else {
		num=Integer.parseInt(del);
		session.setAttribute(id, num);
	}
	
	response.sendRedirect("cart.jsp");
	
%>
