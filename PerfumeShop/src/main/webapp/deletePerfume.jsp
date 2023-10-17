<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>
<%
	//에디트화면 향수 삭제 페이지
	String p_id = request.getParameter("id");
	
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String sql = "select * from perfume";
	pstmt = conn.prepareStatement(sql);
	rs = pstmt.executeQuery();
	
	if(rs.next()) {
		sql = "delete from perfume where p_id = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, p_id);
		pstmt.executeUpdate();
	} else
		out.println("Can't find perfume.");
	
	if (rs != null)
		rs.close();
	if (pstmt != null)
		pstmt.close();
	if (conn != null)
		conn.close();
	
	response.sendRedirect("editPerfume.jsp?edit=delete");
	
	
%>