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
		e.style.color="black";
		e.style.background="white";

	}
	function Night(){
		e = document.getElementById("messageTextArea");
		e.style.color="red";
		e.style.background="black";
	}
	
	
	
</script>

 <script language="JavaScript">
      var set = 1;
      var SetTime = 3;      // 최초 설정 시간(기본 : 초)
      function msg_time() {   // 1초씩 카운트
         m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";   // 남은 시간 계산
         var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
         document.all.ViewTimer.innerHTML = msg;      // div 영역에 보여줌 
         SetTime--;               // 1초씩 감소
         if (SetTime < 0) {         // 시간이 종료 되었으면..        
            //clearInterval(tid);      // 타이머 해제
         if (set == 1){          
            SetTime = 3;
            alert("밤이되었습니다.");
            Night();
            set = 0;
            }
         else {
        	 SetTime = 3;
        	 alert("낮이되었습니다.");
        	 set = 1;
        	 Morning();
         }   
         }}
      window.onload = function TimerStart(){ tid=setInterval('msg_time()',1000) };
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
