<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
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
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		Bbs bbs = new BbsDAO().getBbs(bbsID);
	%>	

	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="#">JSP 게시판 웹 사이트</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarNav">
	      <ul class="navbar-nav">
	        <li class="nav-item">
	          <a class="nav-link" aria-current="page" href="main.jsp">메인</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link active" href="bbs.jsp">게시판</a>
	        </li>
	        
	        <%
	        	if (userID == null) {
	        %>
	        <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	            접속하기
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="login.jsp">로그인</a></li>
	            <li><a class="dropdown-item" href="join.jsp">회원가입</a></li>
	          </ul>
          	</li>
          	
          	<%
	        	} else {
	        %>
	         <li class="nav-item dropdown">
	          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
	           회원관리
	          </a>
	          <ul class="dropdown-menu">
	            <li><a class="dropdown-item" href="logoutAction.jsp">로그아웃</a></li>
	          </ul>
          	</li>
	        
	        
	        <%
	        	}
	        %>
	        
	      </ul>
	    </div>
	  </div>
	</nav>

	<div class="container">
        <div class="row">
            
            
             <table class="table table-striped" style="text-align: center; border: 1px solid #dddddd;">
                 <thead>
                     <tr>
                         <th colspan="3" style="background-color: #eeeeee; text-align: center;">게시판 글 보기</th>
                     </tr>
                 </thead>
                 <tbody>
                     <tr>
                        <td style="width: 20%;">글 제목</td>
                        <td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
                     </tr>
                     <tr>
                        <td>작성자</td>
                        <td colspan="2"><%= bbs.getUserID()%></td>
                     </tr>
                     <tr>
                        <td>작성일자</td>
                        <td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + "시" + bbs.getBbsDate().substring(14, 16) + "분" %></td>
                     </tr>
                      <tr>
                        <td>내용</td>
                        <td colspan="2" style="min-height: 200px; text-align: left;">
                        <%= bbs.getBbsContent().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></td>
                     </tr>
                 </tbody>
             </table>
             <a href="bbs.jsp" class="btn btn-primary" style="width: 100px">목록</a>
             <%
             	if(userID != null && userID.equals(bbs.getUserID())) {
             %>
             
             	<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary" style="width: 100px">수정</a>
             	<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary" style="width: 100px">삭제</a>
             
             <%
             	}
             %>
                
            
        </div>
    </div>

  	
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  	<script src="./js/jquery.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.js"></script>

</body>
</html>