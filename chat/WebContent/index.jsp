<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session" %>


<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
	function Morning(){
		e = document.getElementById("messageTextArea");
		e.style.color="red";
		e.style.background="blue";

	}
	function refresh() 
	{ 
	    var iframe = document.getElementById('iframe'); 
	    iframe.reload(true); 
	} 

	setTimeout('refresh()', 3000); 
</script>
</head>
<body>
	<!-- 메시지 표시 영역 -->
	<textarea id="messageTextArea" readonly="readonly" rows="10" cols="45"></textarea>
	<br />
	<!-- 송신 메시지 텍스트박스 -->
	<input type="text" id="messageText" size="50" />
	<!-- 송신 버튼 -->
	<input type="button" value="Send" onclick="sendMessage()" />
	
	<input type="button" value="Change" onclick="Morning()"/>
	<a href="userframe.jsp">
	<input type="button" value="유저리스트 출력 확인"/>
	</a>
	
	<script type="text/javascript">
		//웹소켓 초기화
		var webSocket = new WebSocket("ws://localhost:8080/WebSocketEx/broadsocket");
		var messageTextArea = document.getElementById("messageTextArea");
		//메시지가 오면 messageTextArea요소에 메시지를 추가한다.
		webSocket.onmessage = function processMessge(message) {
			//Json 풀기
			var jsonData = JSON.parse(message.data);
			if (jsonData.message != null) {
				messageTextArea.value += jsonData.message + "\n"
			}
		}
		//메시지 보내기
		function sendMessage() {
			var messageText = document.getElementById("messageText");
			webSocket.send(messageText.value);
			messageText.value = "";
		}
	</script>
	<br><hr>
	<iframe width="600" height="300" src="userframe.jsp" name="FRAME"></iframe>
	<script language="javascript"> 

function doRefresh() { 
parent.FRAME.location.href='userframe.jsp'; 
setTimeout("doRefresh()",5000); //5초 
} 
doRefresh(); 

</script> 
	
</body>
</html>
