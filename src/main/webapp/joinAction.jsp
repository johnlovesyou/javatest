<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />

<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="./css/reset.css">
	<link rel="stylesheet" href="./css/bootstrap.min.css">
	<link rel="stylesheet" href="./css/custom.css">
	<link rel="stylesheet" href="./css/app.css">
	
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
	<title>JSP 게시판 웹사이트</title>
</head>
<body>


    <%
	    String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if (userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");
		}
    
		
    	if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || 
    		user.getUserGender() == null || user.getUserEmail() == null ) {
    		PrintWriter script = response.getWriter();
    		script.println("<script>");
    		script.println("alert('입력이 안된 사항이 있습니다.')");
    		script.println("history.back()");
    		script.println("</script>");
    	} else {
    		UserDAO userDAO = new UserDAO();
        	int result = userDAO.join(user);
        	if (result == -1) {
        		PrintWriter script = response.getWriter();
        		script.println("<script>");
        		script.println("alert('이미 존재하는 아이디입니다.')");
        		script.println("history.back()");
        		script.println("</script>");
        	}
        	else {
        		session.setAttribute("userID", user.getUserID());
        		PrintWriter script = response.getWriter();
        		script.println("<script>");
        		script.println("alert('가입이 완료되었습니다.')");
        		script.println("location.href = 'main.jsp'");
        		script.println("</script>");
        	}
    	}
      	
    %>

  	
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  	<script src="./js/jquery.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.js"></script>

</body>
</html>