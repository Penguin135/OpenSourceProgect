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
	<%
		ArrayList<String> str = user.getUserList();
		
	%>
	<table>
	<tr>
	
	<%
		for(String ob : str){
	%>
	<td>
	<%=ob %>
	</td>
	
	<%
		}
	%>
	</tr>
	</table>
	<br>
	<hr>
	<a href="index.jsp">
	<input type="button" value="다시 index.jsp 로"/>
	</a>
	
	
</body>
</html>