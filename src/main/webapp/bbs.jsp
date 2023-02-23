<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
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
	<style type="text/css">
        a {
            color: #000000;
            text-decoration: none;
        }
        a:hover {
           color: #dddddd;
        }
        
    </style>
</head>
<body>

	<%
	    String userID = null;
		if (session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
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
                        <th style="background-color: #eeeeee; text-align: center;">번호</th>
                        <th style="background-color: #eeeeee; text-align: center;">제목</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성자</th>
                        <th style="background-color: #eeeeee; text-align: center;">작성일</th>
                    </tr>
                </thead>
                <tbody>
                	<%
                		BbsDAO bbsDAO = new BbsDAO();
                		ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
                		for (int i = 0; i < list.size(); i++) {
                	%>
                	
                	  <tr>
                        <td><%= list.get(i).getBbsID() %></td>
                        <td><a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>"><%= list.get(i).getBbsTitle().replaceAll(" ", "&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>") %></a></td>
                        <td><%= list.get(i).getUserID() %></td>
                        <td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
                        
                      </tr>
                		
                	<%
                		}
                	%>
                  
                </tbody>
            </table>
            
            <%
            	
              if (pageNumber != 1) {
            
            %>
            	<a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arraw-left" style="width: 120px">이전</a>
            <%
              } if (bbsDAO.nextPage(pageNumber + 1)) {
            %>
            	<a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arraw-left" style="width: 120px">다음</a>
            <%
              }
            %>
            
            <a href="write.jsp" class="btn btn-primary" style="width: 120px">글쓰기</a>
        </div>
    </div>

  	
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.3/jquery.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js" integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN" crossorigin="anonymous"></script>
  	<script src="./js/jquery.js"></script>
	<script src="./js/pooper.js"></script>
	<script src="./js/bootstrap.js"></script>

</body>
</html>