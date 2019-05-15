<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>dfdf</h1>
	<%
		ArrayList<String> str = user.getUserList();
		
	%>
	<%
		for(String ob : str){
			System.out.print(ob + "");
		}
	%>
	<h1>
		
	</h1>
	<br>
</body>
</html>