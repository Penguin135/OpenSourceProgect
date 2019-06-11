<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@ page import="java.io.PrintWriter" %> 
<!DOCTYPE html>
<html>
<head>
<style>
body{
background-image:url('https://images5.alphacoders.com/755/thumb-1920-755736.jpg');background-repeat: no-repeat;
background-size:cover;
}
</style>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>MAFIA</title>
</head>

<body>

	<%
		String userID = null;
	if (session.getAttribute("userID") != null){
		userID =(String) session.getAttribute("userID");
	}
	%>
	<nav class="navbar navbar-dark bg-dark">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
			<a class="navbar-brand" href="main.jsp" style="color : red">MAFIA</a>
		</div>
		<div class="collaps navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li class="ative"><a href="aaa.jsp" style="color : red">게임설명</a></li>
			<li><a href="bbs.jsp" style="color : red">만든이</a></li>
		</ul>
		<%
			if(userID == null) {
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					arias-expanded="false" style="color : red">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp" style="color : red">로그인</a></li>
					<li><a href="join.jsp" style="color : red">회원가입</a></li>	
				</ul>
			</li>
		</ul>
		<%
			} else{
		%>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false" style="color : red">회원관리<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="logoutAction.jsp" style="color : red">로그아웃</a></li>
				</ul>
			</li>
		</ul>
		<%		
			}
		%>
	</div>
	<embed src="mafia.mp3" controls=""  hidden="false" autoplay="autoplay" loop="true" preload="auto"></embed>
 </nav> 
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>