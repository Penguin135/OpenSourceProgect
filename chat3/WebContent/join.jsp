<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
body{
background-image:url('https://images5.alphacoders.com/755/thumb-1920-755736.jpg');
background-size:cover;
}
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
			<a class="navbar-brand" href="main.jsp" style="color : red">MAFIA</a>
		</div>
		<div class="collaps navbar-collapse" id="bs-example-navbar-collapse-1">
		<ul class="nav navbar-nav">
			<li><a href="main.jsp" style="color : red">게임설명</a></li>
			<li><a href="bbs.jsp" style="color : red">만든이</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li class="dropdown">
				<a href="#" class="dropdown-toggle"
					data-toggle="dropdown" role="button" aria-haspopup="true"
					aria-expanded="false" style="color : red">접속하기<span class="caret"></span></a>
				<ul class="dropdown-menu">
					<li><a href="login.jsp" style="color : red">로그인</a></li>
					<li class="active"><a href="join.jsp" style="color : red">회원가입</a></li>	
				</ul>
			</li>
		</ul>
	</div>
 </nav>
 <div class="container">
 	<div class="col-lg-4"></div>
 	<div class="col-lg-4">
 		<div class="navbar navbar-dark bg-dark" style="padding-top: 20px;">
 			<form method="post" action="joinAction.jsp">
 				<h3 style="text-align: center; color : red;">회원가입 화면</h3>
 				<div class="form-group"> 
 					<input type="text" class="form-cotrol"  placeholder="아이디" name="userID" maxlength="20">
 				</div>	
 				<div class="form-group">
 					<input type="password" class="form-cotrol"  placeholder="비밀번호" name="userPassword" maxlength="20">  
 				</div>
 				<div class="form-group">
 					<input type="text" class="form-cotrol"  placeholder="이름" name="userName" maxlength="20">  
 				</div>
 				<div class="form-group" style="text-align: center;">
 					<div class="btn-group" data-toggle="buttons">
 						<label class="btn btn-primary active"  style="background-color:transparent; color : red; padding-right:500px; border:none;">
 							<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
 						</label>
 						<label class="btn btn-primary" style="background-color:transparent;color : red; padding-right:500px; border:none;">
 							<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
 						</label>
 					</div>
 				</div>
 				<div class="form-group">
 					<input type="email" class="form-cotrol"   placeholder="이메일" name="userEmail" maxlength="20">  
 				</div>
 				<input type="submit" class="navbar navbar-dark bg-dark"  style="background-color:transparent; color : red;"  value="회원가입">
 			</form>
 		</div>	
 	</div>
 	<div class="col-lg-4"></div>
 </div>		
 	<audio src="mafia.mp3" controls=""  hidden="false" autoplay="autoplay" loop="true" preload="auto"></audio>
 <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
 <script src="js/bootstrap.js"></script>
</body>
</html>