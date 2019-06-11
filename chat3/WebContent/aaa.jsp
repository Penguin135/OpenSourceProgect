<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
background-image:url('https://images3.alphacoders.com/746/thumb-350-746273.png');
background-size:cover;
}
</style>

<style>

</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name ="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<title>MAFIA</title>
</head>
<body> 
	<nav class="navbar navbar-dark bg-dark">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
			aria-expanded="false">
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
			<a class="navbar-brand" href="main.jsp">MAFIA</a>
		</div>
		<div class="collaps navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp">게임설명</a></li>
			<li><a href="bbs.jsp">만든이</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li class="active"><a href="login.jsp">로그인</a></li>
					<li><a href="join.jsp">회원가입</a></li>	
				</ul>
			</li>
		</ul>
	</div>
 </nav>
<div class="container">
 	<div class="col-lg-4"></div>
 	<div class="col-lg-4">
 		<div class="navbar navbar-dark bg-dark" style="padding-top: 20px;">
 			<form method="post" action="loginAction.jsp">
 				<p><h3 style="text-align: center;  font-weight: bold; font-size: 50px;  color:#23527C;">게임 설명</h3></p>
 				<br>
 			<p><div id='item' style="text-align: left; style=font-family:없는글꼴,궁서;  color:#23527C; font-weight: bold; font-size: 20px;" > 1. 회원가입및 로그인을 한다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 2. 로그인을 하면 자동으로 채팅방에 들어간다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 3. 닉네임을 send 한다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 4. 게임이 시작 된다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 5. 자동으로 직업이 부여된다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 6. 낮과 밤이 자동으로 바뀌며 투표를 하라는 메시지가 뜬다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 7. 시민과 경찰(조사기능이 있다)은 마피아를 투표로 찾아낸다.</div></p>
 			<p><div id='item' style="text-align: left; color:#23527C; font-weight: bold; font-size: 20px;" > 8. 마피아를 찾아내면 시민과 경찰의 승리 마피아가 시만을 다 죽이면 마피아이 승리</div></p>
 			 			
 			
 			</form>
 		</div>	
 	</div>
 	<div class="col-lg-4"></div>
 </div>		
<embed src="mafia.mp3" autostart="true" allowscriptaccess="always" enablehtmlaccess="true" allowfullscreen="true" width="0" height="0" ></embed><br><a href="https://bgmstore.net/view/z2R3W" target="_blank"></a>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>