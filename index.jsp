<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session" %>
<%@ page import = "java.util.*" %>


<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<link rel="stylesheet" href="sheet.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.10.1.js"></script>
<title>Insert title here</title>

 <script language="JavaScript">
      var day = 1;
      var set = 1;
      var SetTime = 10;      // 최초 설정 시간(기본 : 초)
      var i = 0;
      
      
      function msg_time() { // 1초씩 카운트
  		m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";
  		var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
  		document.all.ViewTimer.innerHTML = msg; // div 영역에 보여줌 
  		SetTime--; // 1초씩 감소
  		if (SetTime < 0) { // 시간이 종료 되었으면..    
  			changeBack();
  			SetTime=10;
  		}}
  	
  	function changeBack(){
  		var back=document.getElementById("messageTextArea");
  		if(day==1){
  			back.style.background = "black";
  			back.style.color="red";
  			day=0;
  			messageTextArea.value += "밤이 되었습니다.\n";
  		}
  		else{
  			back.style.background = "white";
  			back.style.color="black";
  			day=1;
  			messageTextArea.value += "낮이 되었습니다.\n";
  		}
  	}
      //아침
    	function Morning(){
    		e = document.getElementById("messageTextArea");
    		e.style.color="black";
    		e.style.background="white";

    	}
    	//밤
    	function Night(){
    		e = document.getElementById("messageTextArea");
    		e.style.color="red";
    		e.style.background="black";
    	}
    	//직업 정해주기
    	function job(){
    		// 랜덤으로 접속자중 한명에게 코드 1을 부여한다 나머지 0
    		// List값이 1이면 알람띄우기
    		// alert("당신의 직업은 ' ' 입니다.'");
    	}
    	//투표
    	function vote(){
    		// jquary 이용 button 눌리면 1씩늘린다 
    	}
    	//마피아 timer중 밤에 실행
    	function kill(){
    		//코드 1을 가진 접속자가 누른 한명을 채팅불가상태로 바꾼다 
    		
    	}
    	//조건을 만족하면 0 리턴
    	function gameend(){
    		//마피아가 죽거나 마피아랑 시민이 1:1이면 마퍄승
    		//아니면 return 1
    		return 1;
    	}
    	function doRefresh() {
    		parent.FRAME.location.href = 'userframe.jsp';
    		setTimeout("doRefresh()", 500); //5초 
    	}
            
   </script>
    

<script>
	//벨류값 띄우기
    $(document).ready(function () {
        $(".vote").click(function () {
            //$(this).hide();
            alert($(this).val());

        });
    });
   
    //kill (한번만 가능하게 할것)(마피아만 가능하게 할 것)
    $(document).ready(function () {
        $("h1").click(function () {
            $(this).hide();
            alert("죽였습니다.");
        });
    });
    
    var i = 0;
    $("div").click(function () {
        $("button1", this).text("click");
        $("p", this).text(++i);

    })
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
				if (jsonData.message == '공지 : 게임이 시작되었습니다') {
					setInterval('msg_time()',1000);
				}

				messageTextArea.value += jsonData.message + "\n";
			}
		}
		
		//메시지 보내기
		function sendMessage() {
			var Mafiamessage = "아임마피아맨";
			var messageText = document.getElementById("messageText");
			if(messageText.value == Mafiamessage){
				messageText.value = "이건 어떻게 써먹어야할까";
				webSocket.send(messageText.value);
				messageText.value = "";
			}
			else{
				webSocket.send(messageText.value);
				messageText.value = "";
			}
			
		}
	</script>
	<br>
	<hr>
	<iframe width="600" height="300" src="userframe.jsp" name="FRAME"></iframe>
	<div id=ViewTimer></div>
	
	<%
		ArrayList<String> str = user.getUserList();
		int usersize = str.size();
		
	%>
</body>
</html>
