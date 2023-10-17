<%@page import="java.io.PrintWriter"%>
<%@page import="user.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userTel" />
<jsp:setProperty name="user" property="userSex" />
<jsp:setProperty name="user" property="userAge" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입 과정</title>
</head>
<body>
   <%
      if(user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null ||
         user.getUserEmail() == null || user.getUserTel() == null || user.getUserSex() == null || user.getUserAge() == null){
         PrintWriter script = response.getWriter();
         
         script.println("<script>");
         script.println("alert('입력이 안 된 사항이 있습니다')");
         script.println("history.back()");
         script.println("</script>");
         
      }else{
         UserDAO userDAO = new UserDAO();
         int result = userDAO.join(user);
         
         if(user.getUserID().equals("admin")){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('해당 아이디로는 회원가입이 불가능합니다.')");
            script.println("history.back()");
            script.println("</script>");
         }

         if(result == -1){
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('이미 존재하는 아이디입니다')");
            script.println("history.back()");
            script.println("</script>");
         }else {
            session.setAttribute("userID",user.getUserID());
            PrintWriter script = response.getWriter();
            script.println("<script>");
            script.println("alert('회원가입 성공')");
            script.println("location.href='main.jsp'");
            script.println("</script>");
         }
      }
   %>
</body>
</html>