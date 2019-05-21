<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="java.util.*"%>

<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
	var set = 1;
	var SetTime = 10; // 최초 설정 시간(기본 : 초)

	function Morning() {
		e = document.getElementById("messageTextArea");
		e.style.color = "red";
		e.style.background = "blue";

	}
	function doRefresh() {
		parent.FRAME.location.href = 'userframe.jsp';
		setTimeout("doRefresh()", 500); //5초 
	}

	function msg_time() { // 1초씩 카운트

		m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";
		var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
		document.all.ViewTimer.innerHTML = msg; // div 영역에 보여줌 
		SetTime--; // 1초씩 감소
		if (SetTime < 0) { // 시간이 종료 되었으면..    
			alert("시발");
		//clearInterval(tid);      // 타이머 해제
			SetTime=10;

		}
		//setInterval('msg_time()',1000);
	}
	
	if(SetTime==0)
		alert("시발");
	// function TimerStart(){ tid=setInterval('msg_time()',1000) };
</script>
</head>
<body>

	<!-- 메시지 표시 영역 -->
	<textarea id="messageTextArea" readonly="readonly" rows="25" cols="45"
		style="overflow-y: auto;"></textarea>
	<br />
	<!-- 송신 메시지 텍스트박스 -->
	<input type="text" id="messageText" size="50" />
	<!-- 송신 버튼 -->
	<input type="button" value="Send" onclick="sendMessage()" />
	<h1></h1>
	<input type="button" value="Change" onclick="Morning()" />
	<a href="userframe.jsp"> <input type="button" value="유저리스트 출력 확인" />
	</a>
	<script type="text/javascript">
		//웹소켓 초기화
		var webSocket = new WebSocket(
				"ws://localhost:8080/WebSocketEx/broadsocket");
		var messageTextArea = document.getElementById("messageTextArea");
		//메시지가 오면 messageTextArea요소에 메시지를 추가한다.
		webSocket.onmessage = function processMessge(message) {
			//Json 풀기
			var jsonData = JSON.parse(message.data);
			if (jsonData.message != null) {
				if (jsonData.message == '공지 :  : 게임이 시작되었습니다') {
					//alert("유레카");
					setInterval('msg_time()',1000);
					//TimeStart();
				}
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
	<br>
	<hr>
	<iframe width="600" height="300" src="userframe.jsp" name="FRAME"></iframe>
	<div id=ViewTimer></div>

</body>
</html>
