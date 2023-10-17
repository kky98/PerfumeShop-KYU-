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
	//파일 경로 설정
	String realPath = request.getServletContext().getRealPath("images");
	String realFolder = realPath + "/perfume";
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
	ResultSet rs = null;
	
	String sql = "select * from perfume where p_id = ?";
	pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, p_id);
	rs = pstmt.executeQuery();
	
	if (rs.next()) {
		if (fileName != null) {
			sql = "update perfume set p_brand=?, p_unitName=?, p_unitPrice=?, p_unitVolume=?, p_unitsInStock=?, p_gender=?, p_note=?, p_topNote=?, p_middleNote=?, p_baseNote=?, p_fileName=?, p_concept=? where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_brand);
			pstmt.setString(2, p_unitName);
			pstmt.setInt(3, price);
			pstmt.setInt(4, volume);
			pstmt.setLong(5,stock);
			pstmt.setString(6,p_gender);
			pstmt.setString(7,p_note);
			pstmt.setString(8,p_topNote);
			pstmt.setString(9,p_middleNote);
			pstmt.setString(10,p_baseNote);
			pstmt.setString(11,fileName);
			pstmt.setString(12,p_concept);
			pstmt.setString(13,p_id);
			pstmt.executeUpdate();
		} else {
			sql = "update perfume set p_brand=?, p_unitName=?, p_unitPrice=?, p_unitVolume=?, p_unitsInStock=?, p_gender=?, p_note=?, p_topNote=?, p_middleNote=?, p_baseNote=?, p_concept=? where p_id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, p_brand);
			pstmt.setString(2, p_unitName);
			pstmt.setInt(3, price);
			pstmt.setInt(4, volume);
			pstmt.setLong(5,stock);
			pstmt.setString(6,p_gender);
			pstmt.setString(7,p_note);
			pstmt.setString(8,p_topNote);
			pstmt.setString(9,p_middleNote);
			pstmt.setString(10,p_baseNote);
			pstmt.setString(11,p_concept);
			pstmt.setString(12,p_id);
			pstmt.executeUpdate();
			
		}
		if (rs != null)
			rs.close();
		if (pstmt != null)
			pstmt.close();
		if ( conn != null)
			conn.close();
		
		response.sendRedirect("editPerfume.jsp");
	}
%>
