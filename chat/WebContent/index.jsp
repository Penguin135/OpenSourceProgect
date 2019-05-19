<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session" %>
<%@ page import = "java.util.*" %>


<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>
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
		//alert("당신의 직업은 ' ' 입니다.'");
	}
	//투표
	function vote(){
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
	
</script>


 <script language="JavaScript">
      var mafiacord = 0;
      var set = 1;
      var SetTime = 3;      // 최초 설정 시간(기본 : 초)

		System.out.println(mafiacord);
      
      function msg_time() {   // 1초씩 카운트
         m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";
         var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
         document.all.ViewTimer.innerHTML = msg;      // div 영역에 보여줌 
         SetTime--;               // 1초씩 감소
         if (SetTime < 0) {         // 시간이 종료 되었으면..        
            //clearInterval(tid);      // 타이머 해제
         if (set == 1){  
        	//alert("투표를 해주세요");
        	SetTime = 4;
        	vote();
        	set = 2;
        	gameend();
         }
         else if (set == 2)	{
        	 //alert("밤이되었습니다.");
             SetTime = 3;
             Night();
             set = 3;
             gameend();
         }
         else if (set == 3) {
        	 SetTime = 3;
        	 //alert("낮이되었습니다.");
        	 Morning();
        	 set = 1;
         }   
         }}
      window.onload = function TimerStart(){ tid=setInterval('msg_time()',1000) };
     
   </script>


</head>
<body>
	<%
		ArrayList<String> str = user.getUserList();
		int usersize = str.size();
		
	%>
	<!-- 배열test 

		ArrayList<String> mafialist_1 = new ArrayList<String>();
		int [][] array = {{1}, {1, 2}, {1, 2, 3}, {1, 2, 3, 4}};
		String [][] jobs = new String[4][2];
		jobs[0][0]="wswsws";
		jobs[0][1]="agrgfg";
		System.out.println(jobs[0][1]);
		for(int i = 0 ; i < array.length; i++) {
            System.out.print( (i+1) + "번째 줄을 출력합니다>");
            for(int j = 0; j< array[i].length; j++) {
                System.out.print(array[i][j]+" ");
            }
            System.out.println("");
        }
    -->
	

	<!-- 메시지 표시 영역 -->
	<textarea id="messageTextArea" readonly="readonly" rows="25" cols="45"></textarea>
	<br />
	<!-- 송신 메시지 텍스트박스 -->
	<input type="text" id="messageText" size="50" />
	<!-- 송신 버튼 -->
	<input type="button" value="Send" onclick="sendMessage()" />
	<hr>
	<!-- 유저창 -->
	<iframe src = "userframe.jsp" width = "300" height = "200"></iframe>
	
	<script type="text/javascript">
		//웹소켓 초기화
		var webSocket = new WebSocket("ws://localhost:8080/WebSocketEx/broadsocket");
		var messageTextArea = document.getElementById("messageTextArea");
		//메시지가 오면 messageTextArea요소에 메시지를 추가한다.
		webSocket.onmessage = function processMessge(message) {
			//Json 풀기
			var jsonData = JSON.parse(message.data);
			if (jsonData.message != null) {
				messageTextArea.value += jsonData.message + "\n";
			}
		}
		//메시지 보내기
		function sendMessage() {
			var messageText = document.getElementById("messageText");
			webSocket.send(messageText.value);
			messageText.value = "";
		}
		
		
	</script>
	<hr>
	<!-- 
	<script language="javascript"> 
		function doRefresh() { 
			parent.FRAME.location.href='userframe.jsp'; 
			setTimeout("doRefresh()",1000); //5초 
		}
		
		doRefresh(); 
	</script> 
	 -->
	 <!-- 인원수가 3이상이면 start -->
	 <%
	 for(String ob : str){
		 System.out.println(ob);
	 }
	 %>
	 <%
	 if (usersize >= 4){

	 %>
	 <script>
	 
	 alert("게임시작");
	
	 
	 </script>
	 <!--<input type="button" name = "start" value="start" >-->
	 <div id="ViewTimer"></div>
	 <%} %>
	 
</body>
</html>
