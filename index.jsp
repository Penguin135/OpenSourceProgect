<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<link href="sheet.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<title>Insert title here</title>

<script>
   var msg_state=0;//0이면 user_list에 추가 안하고, 1이면 user_list에 추가한다.
   var user_list = new Array();//유저 목록
   var vote_list = new Array();//투표 목록(투표 할 때마다 초기화)
   var dead_list = new Array();//0이면 생존, 1이면 죽음
   var dead_name_list = new Array();//죽은 사람 이름 넣는 배열
   var first_check = 0; //이게 처음에 0이고 처음에 밤이 되면, 1이 된다. 이름이 적힌 버튼 생성 용도로 처음에만 쓰임.
   var day=1;
   var set =1;
   var SetTime = 10; //최초 설정 시간(기본 : 초)
   var vote_state=0;//투표를 한번만 가능하게 하는 변수 0이면 투표 불가능, 1이면 투표 가능
   var killer = 0; // 이게 1 이 되면 마피아임
   var police =0;//이게 1이 되면 경찰임
   var Name="";

   
   
   var mafia_list = new Array();
   var kill_name="";
   var invest_name="";
   function msg_time() { // 1초씩 카운트
      m = Math.floor(SetTime / 60) + "분 " + (SetTime % 60) + "초";
      var msg = "현재 남은 시간은 <font color='red'>" + m + "</font> 입니다.";
      document.all.ViewTimer.innerHTML = msg; // div 영역에 보여줌 
      SetTime--; // 1초씩 감소
      if (SetTime < 0) { // 시간이 종료 되었으면..   
         changeBack();
         SetTime=10;
      }
      
      //시간이 5초 남았는데 낮이면 투표 가능.
      if(SetTime==5&&day==1){
         messageTextArea.value +="투표가능.\n";
         vote_state=1;
      }
   }
   
   function changeBack(){
      var back=document.getElementById("messageTextArea");
      if(first_check==0){
         //여기에 버튼 생성 코드 써야함.
         user_list_show();
      }
      if(day==1){
         back.style.color="red";
         day=0;
         messageTextArea.value += "밤이 되었습니다.\n";
         invest_state=1;
         if(first_check==1){
            vote_list_show();
         }
         if(killer==1){
            messageTextArea.value +="죽일사람을 선택해 주세요.\n";
         }
         if(police==1){
            messageTextArea.value +="조사할사람을 선택해주세요.\n";
         }
         setTimeout(scroll, 100);
         webSocket.send("nigthnigthnigthnigthnigth");
         
         //밤이 될 때마다 배열 초기화
         vote_list[0]=0;
         vote_list[1]=0;
         vote_list[2]=0;
         vote_list[3]=0;
         vote_state=0;
      }
      else{
         back.style.color="white";
         day=1;
         messageTextArea.value += "낮이 되었습니다.\n";
         if(killer==1){
            webSocket.send("ⓚ"+kill_name);
            kill_name="";
            
         }
         setTimeout(scroll, 100);
         vote_state=0;
      }
      first_check=1;
   }
   
   function scroll(){
      document.getElementById("messageTextArea").scrollTop = document.getElementById("messageTextArea").scrollHeight;

   }
   
   function user_list_show(){//버튼에 유저 이름들을 넣는다.
      userBTN1.value = user_list[0];
      userBTN2.value = user_list[1];
      userBTN3.value = user_list[2];
      userBTN4.value = user_list[3];
   }
   
   function vote(str, index){
      if(vote_state==1){
         webSocket.send('§'+"투표:"+str);//투표를 할 시간에는 앞에 '§'를 붙여서 투표인지 확인.
      }
      else if(vote_state==0){
         
         if(killer && day==0 && !dead_name_list.includes(Name)){//투표를 못하는 상태인데, 만약에 밤이면 kill 가능
            messageTextArea.value += str + "을 선택하셨습니다.\n";
            kill_name=str;
            return;
         }
         if(police && day==0 && invest_state==1){
            messageTextArea.value += str + "을 선택하셨습니다\n";
            invest_name=str;
            webSocket.send('ⓘ'+ str)
            invest_state=0;
            return;
         }
         if(killer==1){
            messageTextArea.value += "살인이 불가능합니다.\n";
         }else if(police==1){
            messageTextArea.value +="조사가 불가능합니다.\n";
         }else{
            messageTextArea.value += "투표가 불가능합니다.\n";
         }
      }
      
      
      setTimeout(scroll, 50);
   }
   
   function vote_list_show(){
      var first_max;
      var first_max_index;
      var second_max;
      /*
      messageTextArea.value += user_list[0] +"의 투표수는 "+ vote_list[0] + "입니다.\n";
      messageTextArea.value += user_list[1] +"의 투표수는 "+ vote_list[1] + "입니다.\n";
      messageTextArea.value += user_list[2] +"의 투표수는 "+ vote_list[2] + "입니다.\n";
      messageTextArea.value += user_list[3] +"의 투표수는 "+ vote_list[3] + "입니다.\n";
      */
      first_max = Math.max.apply(null, vote_list);//제일 큰 투표수
      first_max_index= vote_list.indexOf(first_max);
      vote_list[vote_list.indexOf(first_max)]=0;
      second_max = Math.max.apply(null, vote_list);//두번째 큰 투표수
      //alert(first_max + " " + second_max);
      
      if(first_max==second_max){
         //webSocket.send('★'+"아무도 안죽음");
      }
      else{
         webSocket.send('★'+ user_list[first_max_index]+"가 죽었습니다.");
         dead_list[first_max_index]=1;
         var new_btn_name = "userBTN" + (first_max_index+1);
         dead_name_list.push(user_list[first_max_index]);
         document.getElementById(new_btn_name).style.visibility='hidden';
         //messageTextArea.value += user_list[user_list.indexOf(first_max)] +"가 죽었습니다.\n";
         
      }
   }
   
   function mafia_kill_btn_hide(name){
      var btn_index = user_list.indexOf(name) + 1;
      var new_mafia_kill_btn_name = "userBTN" + btn_index;
      
      document.getElementById(new_mafia_kill_btn_name).style.visibility='hidden';
   }
   
   
   function winner(str){
      alert(str);
   }
</script>

<script type="text/javascript">
 var p1=1,p2=1,p3=1,p4=1;
$(function(){
	
	$("#p1").click(function () {
		if(p1==3){$("#p1").css("background-image","url('./img/businessman.svg')");p1=1;}
		else if(p1==2){$("#p1").css("background-image","url('./img/mafia2.png')");p1=3;}
		else if(p1==1){$("#p1").css("background-image","url('./img/policeman.png')");p1=2;}
	});
});
$(function(){
	
	$("#p2").click(function () {
		if(p1==3){$("#p2").css("background-image","url('./img/businessman.svg')");p1=1;}
		else if(p1==2){$("#p2").css("background-image","url('./img/mafia2.png')");p1=3;}
		else if(p1==1){$("#p2").css("background-image","url('./img/policeman.png')");p1=2;}
	});
});
$(function(){
	
	$("#p3").click(function () {
		if(p1==3){$("#p3").css("background-image","url('./img/businessman.svg')");p1=1;}
		else if(p1==2){$("#p3").css("background-image","url('./img/mafia2.png')");p1=3;}
		else if(p1==1){$("#p3").css("background-image","url('./img/policeman.png')");p1=2;}
	});
});
$(function(){
	
	$("#p4").click(function () {
		if(p1==3){$("#p4").css("background-image","url('./img/businessman.svg')");p1=1;}
		else if(p1==2){$("#p4").css("background-image","url('./img/mafia2.png')");p1=3;}
		else if(p1==1){$("#p4").css("background-image","url('./img/policeman.png')");p1=2;}
	});
});
</script>

<style>
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css); 
h1{
     font-family: 'Nanum Pen Script', cursive;
}
</style>
<style>
@import url('https://fonts.googleapis.com/css?family=Dokdo&display=swap');
h6{
   font-family: 'Dokdo', cursive;
}

</style>

</head>
<body>


   <!-- 타이머 출력 -->
   
   
    <div class="updiv">
	<h1 style="font-size:120px"><center style=" color:#190405; text-shadow: -1px 0 #f00, 0 1px #f00, 1px 0 #f00, 0 -1px #f00;">Mafia</center></h1>
	<center><div id=ViewTimer></div></center>
	</div>
    <div class="leftdiv" style="min-width:300px;">
    <center>
    <!-- 메시지 표시 영역 -->
    <textarea id="messageTextArea" readonly="readonly" rows="20" cols="38"
      style="overflow-y: auto;"></textarea>
    <br />
    <table>
    <!-- 송신 메시지 텍스트박스 -->
    <td><input type="text" class="all2" id="messageText" size="32" /></td>
    <!-- 송신 버튼 -->
    <td><input type="button" class="all3" value="Send" onclick="sendMessage()" /></td>
    </table>
    </center>
    </div>
    <div class="centerdiv">
    <center>
    <table>
    <th style="color:#ff2020;" colspan="2">
    <h6>Suvivor</h6>
    </br>
    <h5>
    prediction : image click!
    </br>
    Vote : Username click!
    </h5>
    </th>
    <tr>
    <td><input type="button" class="all" id="p1"></td>
    <td><input type="button" style="margin-left:40%;" class="all" id="p2"></td>
    </tr>
    <tr>
    <td><input type="button" class="al" style="width:80px;height:40px;" id="userBTN1" value="" onclick="vote(value, 0)"></td>
    <td><input type="button" class="al" style="width:80px;height:40px;margin-left:40%;" id="userBTN2" value="" onclick="vote(value, 1)"></td>
    </tr>
    <tr>
    <td><input type="button" class="all" id="p3"></td>
    <td><input type="button" style="margin-left:40%;" class="all" id="p4"></td>
    </tr>
    <tr>
    <td><input type="button" class="al" style="width:80px;height:40px;" id="userBTN3" value="" onclick="vote(value, 2)"></td>
    <td><input type="button" class="al" style="width:80px;height:40px;margin-left:40%;" id="userBTN4" value="" onclick="vote(value, 3)"></td>
    </tr>
    </table>
    </center>
    </div>
    
   

   <script type="text/javascript">
      //웹소켓 초기화
      var webSocket = new WebSocket(
            "ws://localhost:8080/WebSocketEx/broadsocket");
      var messageTextArea = document.getElementById("messageTextArea");
      //메시지가 오면 messageTextArea요소에 메시지를 추가한다.
      webSocket.onmessage = function processMessge(message) {
         //Json 풀기
         var jsonData = JSON.parse(message.data);
         if(jsonData.message=='게임이 시작되었습니다'){
            msg_state=0;
            changeBack();
            
         }
         
         if(jsonData.message.charAt(0)=="ⓦ"){
            winner(jsonData.message.substring(1));
            return;
         }
         
         if(jsonData.message.charAt(0)=="ⓡ"){
            messageTextArea.value+=jsonData.message.substring(1)+"\n";
            return;
         }
         
         if(jsonData.message.charAt(0)=="【"){
            
            Name=jsonData.message.substring(1,jsonData.message.length-15);
            messageTextArea.value += jsonData.message.substring(1) + "\n";
            return;
         }
         
         if(jsonData.message.substring(0,3)=="투표:" &&user_list.indexOf(jsonData.message.substring(3))!=-1){
            //alert(jsonData.message.substring(3));
            vote_list[user_list.indexOf(jsonData.message.substring(3))]+=1;
            //vote_state=0;
         }
         
         if(jsonData.message.charAt(0)=="＃"){
            messageTextArea.value += jsonData.message.substring(1) + "\n";
            return;
         }
         
         if(jsonData.message.charAt(0)=="◎"){
            messageTextArea.value += jsonData.message.substring(1) + "\n";
            if(jsonData.message.substring(8)=="mafia"){
               messageTextArea.value += "죽일 사람을 선택해 주세요.\n";
               killer=1;
               
            }
            if(jsonData.message.substring(8)=="police"){
               messageTextArea.value += "조사할 사람을 선택해 주세요.\n";
               police=1;
            }
            return;
         }   
         
         if(jsonData.message.charAt(0)=="ⓓ"){
            var name = jsonData.message.substring(9, (jsonData.message.length)-8);
            
            mafia_kill_btn_hide(name);
            
            dead_name_list.push(name);
            messageTextArea.value += jsonData.message.substring(1) + "\n";
            return;
         }
         
         if(msg_state==1){
            user_list.push(jsonData.message);
            vote_list.push(0);
            dead_list.push(0);
         }
         if (jsonData.message != null) {
            if (jsonData.message == '●생존자 목록') {
               msg_state=1;
               setInterval('msg_time()', 1000);
               messageTextArea.value += jsonData.message.substring(1) + "\n";
               return;
            }
            messageTextArea.value += jsonData.message + "\n";
         }
      }
      //메시지 보내기
      function sendMessage() {
         var messageText = document.getElementById("messageText");
         if(day==1 && messageText.value!=""){
            webSocket.send(messageText.value);
         }
         messageText.value = "";
         
         setTimeout(scroll, 100);
      }
   </script>
   <br>
   <hr>

       
</body>
</html>