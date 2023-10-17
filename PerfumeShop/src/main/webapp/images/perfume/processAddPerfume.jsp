<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*" %>
<%@ include file="dbconn.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");

	String filename = "";
	String realFolder = "c:/upload";
	int maxSize = 5 * 1024 * 1024;
	String encType = "utf-8";
	
	MultipartRequest multi = new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());

	String p_id = multi.getParameter("p_id");
	String p_brand = multi.getParameter("p_brand");
	String p_unitName = multi.getParameter("p_unitName");
	String p_unitPrice = multi.getParameter("p_unitPrice");
	String p_unitVolume = multi.getParameter("p_unitVolume");
	String p_unitsInStock = multi.getParameter("p_unitsInStock");
	String p_gender = multi.getParameter("p_gender");
	String p_note = multi.getParameter("p_note");
	String p_topNote = multi.getParameter("p_topNote");
	String p_middleNote = multi.getParameter("p_middleNote");
	String p_baseNote = multi.getParameter("p_baseNote");
	String p_concept = multi.getParameter("p_concept");
	
	Integer price, volume;
	
	if (p_unitPrice.isEmpty())
		price = 0;
	else
		price = Integer.valueOf(p_unitPrice);
	if(p_unitVolume.isEmpty())
		volume = 0;
	else
		volume = Integer.valueOf(p_unitVolume);
	
	long stock;
	
	if (p_unitsInStock.isEmpty())
		stock = 0;
	else
		stock = Long.valueOf(p_unitsInStock);
	
	
	Enumeration files = multi.getFileNames();
	String fname = (String) files.nextElement();
	String fileName = multi.getFilesystemName(fname);
	
	PreparedStatement pstmt = null;
	
	String sql = "insert into perfume values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, p_id);
	pstmt.setString(2, p_brand);
	pstmt.setString(3, p_unitName);
	pstmt.setInt(4, price);
	pstmt.setInt(5, volume);
	pstmt.setLong(6, stock);
	pstmt.setString(7, p_gender);
	pstmt.setString(8, p_note);
	pstmt.setString(9, p_topNote);
	pstmt.setString(10, p_middleNote);
	pstmt.setString(11, p_baseNote);
	pstmt.setString(12, fileName);
	pstmt.setString(13, p_concept);
	pstmt.executeUpdate();
	
	if(pstmt != null)
		pstmt.close();
	if(conn != null)
		conn.close();
	
	response.sendRedirect("products.jsp");	
%>