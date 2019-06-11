<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="javax.websocket.Session"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="user" class="Chatting.broadsocket" scope="application"></jsp:useBean>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script src="http://code.jquery.com/jquery-1.10.1.min.js"></script>
<link href="sheet.css" rel="stylesheet">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
<style>
<!--초기화-->
@import url(//fonts.googleapis.com/earlyaccess/nanumpenscript.css); 
h1{
     font-family: 'Nanum Pen Script', cursive;
}

asdAWERAF{
background-image: url('./img/111111.jpg');
background-size: cover;
background-repeat: no-repeat;
height: 100%;
font-family: 'Numans', sans-serif;
}

body { 
  background: url('./img/111111.jpg') no-repeat center center fixed; 
  -webkit-background-size: cover;
  -moz-background-size: cover;
  -o-background-size: cover;
  background-size: cover;
}


.al{
	
	border: 3px solid #190405;
	opacity:1;
	background-color:#191919;
	color:#ffffff;
	border-radius: 3px;
}

.all{
	width:80px;
	height:70px;
	margin-top:30%;
	background-image:url('./img/businessman.svg');
	background-repeat: no-repeat; background-position: center;
	border: 3px solid #190405;
	opacity:1;
	background-color:#191919;
	color:#ffffff;
	border-radius: 10px;
}

.all2{
	color:#ffffff;
	background-color:#191919;
	border-radius: 10px;
}
.all3{
	opacity:0.8;
	background-color:#191919;
	color:#ff0202;
	border-radius: 10px;
}

textarea {
	background-image:url("./img/namu.jpg");
	color:#ffffff;
    padding: 5px;
    line-height: 3;
    border-radius: 30px;
    border: 3px solid #190405;
    box-shadow: 0px 0px 0px #444;
}

#mTa{
border: 3px solid black;
}

.btn{-webkit-box-shadow:0 .1875rem .1875rem 0 rgba(0,0,0,.1)!important;box-shadow:0 .1875rem .1875rem 0 rgba(0,0,0,.1)!important;padding:1.25rem 2rem;font-family:'Varela Round';font-size:80%;text-transform:uppercase;letter-spacing:.15rem;border:0}
.btn-primary{background-color:lightgray}
.btn-primary:hover{background-color:lightgray}
.btn-primary:focus{background-color:lightgray;color:lightgray}
.btn-primary:active{background-color:lightgray!important}

.leftdiv{
/*border: 0px solid gold;*/
float: left;
width: 100%;
padding:30px;
margin-top:10%;
margin-left:0%;
}
.centerdiv{
/*border: 0px solid gold;*/
float: left;
width: 100%;
padding:50px;
margin-top:10%;
margin-left:0%;

}
.rightdiv{
/*border: 0px solid gold;*/
float: left;
width: 30%;
padding:10px;
margin-top:5%;
}
.updiv{
/*border: 0px solid gold;*/
float: left;
width: 100%;
padding:5px;
margin-top:3%;
}
.downdiv{
/*border: 0px solid gold;*/
float: left;
width: 100%;
padding:5px;
margin-top:3%;
}

.container{
height: 100%;
align-content: center;
}

.chat{
height: 370px;
margin-top: auto;
margin-bottom: auto;
width: 400px;
background-color: rgba(0,0,0,0.5) !important;
}

/* -------------- loader4 -------------- */

.loader4{
    position: relative;
    width: 150px;
    height: 20px;

    top: 45%;
    top: -webkit-calc(50% - 10px);
    top: calc(50% - 10px);
    left: 25%;
    left: -webkit-calc(50% - 75px);
    left: calc(50% - 75px);

    background-color: rgba(255,255,255,0.2);
}

.loader4:before{
    content: "";
    position: absolute;
    background-color: rgba(255,0,0,0.5);
    top: 0px;
    left: 0px;
    height: 20px;
    width: 0px;
    z-index: 0;
    opacity: 1;
    -webkit-transform-origin:  100% 0%;
            transform-origin:  100% 0% ;
    -webkit-animation: loader4 10s ease-in-out infinite;
            animation: loader4 10s ease-in-out infinite;
}

.loader4:after{
    content: "";
    color: #f00;
    font-family:  Lato,"Helvetica Neue" ;
    font-weight: 200;
    font-size: 16px;
    position: absolute;
    width: 100%;
    height: 20px;
    line-height: 20px;
    left: 0;
    top: 0;
}

@-webkit-keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
}

@keyframes loader4{
    0%{width: 0px;}
    70%{width: 100%; opacity: 1;}
    90%{opacity: 0; width: 100%;}
    100%{opacity: 0;width: 0px;}
    
#left {
    background-color: #F3F1E9;
    float: left;
    height: 500px;
    width: 50%;
    position: relative;
}
#right {
    background-color: #F3F1E9;
    float: left;
    height: 500px;
    width: 50%;
    position: relative;
}
div.gamemessage {
	position : fixed;
	left: 220px;
	top: 30px;
}
.intro{
  width:100%;
  height:30px;
}
.intro h1{
  font-family:'Oswald', sans-serif;
  letter-spacing:2px;
  font-weight:normal;
  font-size:14px;
  color:#222;
  text-align:center;
  margin-top:10px;
}
.intro a{
  color:#e74c3c;
  font-weight:bold;
  letter-spacing:0;
}
.intro img{
  width:20px;
  heght:20px;
  margin-left:5px;
  margin-right:5px;
  position:relative;
  top:5px;
}


#container{
  width:715px;
  height:230px;
  margin:50px auto;
}
.button-1{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 0;
}
.button-1 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-1{
  width:140px;
  height:50px;
  top:-2px;
  right:-140px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-1:hover .eff-1{
  right:0;
}
.button-1:hover a{
  color:#fff;
}

.button-2{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-2 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-2{
  width:140px;
  height:50px;
  top:-50px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-2:hover .eff-2{
  top:0;
}
.button-2:hover a{
  color:#fff;
}

.button-3{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-3 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-3{
  width:140px;
  height:50px;
  bottom:-50px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-3:hover .eff-3{
  bottom:0;
}
.button-3:hover a{
  color:#fff;
}

.button-4{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-4 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-4{
  width:140px;
  height:50px;
  left:-140px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-4:hover .eff-4{
  left:0;
}
.button-4:hover a{
  color:#fff;
}

.button-5{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 0;
}
.button-5 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-5{
  width:140px;
  height:50px;
  left:-140px;
  top:-50px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-5:hover .eff-5{
  left:0;top:0;
}
.button-5:hover a{
  color:#fff;
}
.button-6{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-6 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-6{
  width:140px;
  height:50px;
  right:-140px;
  bottom:-50px;
  background:#34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
}
.button-6:hover .eff-6{
  right:0;bottom:0;
}
.button-6:hover a{
  color:#fff;
}

.button-7{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-7 a{
  font-family:arial;
  font-size:16px;
  color:#34495e;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-7{
  width:140px;
  height:50px;
  border:0px solid #34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
  box-sizing:border-box;
}
.button-7:hover .eff-7{
  border:70px solid #34495e;
}
.button-7:hover a{
  color:#fff;
}

.button-8{
  width:140px;
  height:50px;
  border:2px solid #34495e;
  float:left;
  text-align:center;
  cursor:pointer;
  position:relative;
  box-sizing:border-box;
  overflow:hidden;
  margin:0 0 40px 50px;
}
.button-8 a{
  font-family:arial;
  font-size:16px;
  color:#fff;
  text-decoration:none;
  line-height:50px;
  transition:all .5s ease;
  z-index:2;
  position:relative;
}
.eff-8{
  width:140px;
  height:50px;
  border:70px solid #34495e;
  position:absolute;
  transition:all .5s ease;
  z-index:1;
  box-sizing:border-box;
}
.button-8:hover .eff-8{
  border:0px solid #34495e;
}
.button-8:hover a{
  color:#34495e;
}

h1{
  font-family: 'Oswald', sans-serif;
  font-weight:normal;
  font-size:24px;
  color:#34495e;
  text-align:center;
  margin:0 auto 40px 0;
}
h1:first-letter{
  color:#e74c3c;
  border-bottom:1px solid #e74c3c;
}
footer{
  position:absolute;
  width:100%;
  height:30px;
  border-top:1px solid #34495e;
  bottom:0;
  display:none;
}
footer h1{
  font-family: 'Oswald', sans-serif;
  font-weight:normal;
  font-size:14px;
  color:#34495e;
  text-align:left;
  margin-left:5%;
}
footer a{
  font-family: 'Oswald', sans-serif;
  font-weight:normal;
  font-size:14px;
  color:#34495e;
}


</style>
<script>
	var shot = new Audio("shot.mp3");
	
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
	      swal(str.substring(0,7), str.substring(7))
	      .then((value)=>{
	         location.reload();
	      });
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


</head>
<body>

	<div id="batang" align="center">

   <!-- 타이머 출력 -->
   <div id=ViewTimer></div>
   
    <div class="updiv">
   <h1 style="font-size:80px"><center style="font-family: 'Nanum Pen Script', cursive; color:#190405; text-shadow: -1px 0 #f00, 0 1px #f00, 1px 0 #f00, 0 -1px #f00;">Mafia</center></h1>
   </div>
    <div class="leftdiv" style="min-width:300px;">
    <!-- 메시지 표시 영역 -->
    <textarea id="messageTextArea" readonly="readonly" rows="13" cols="40"
      style="overflow-y: auto;"></textarea>
    <br />
    <table>
    <!-- 송신 메시지 텍스트박스 -->
    <td><input type="text" class="all2" id="messageText" size="30" /></td>
    <!-- 송신 버튼 -->
    <td><input type="button" class="all3" value="Send" onclick="sendMessage()" /></td>
    </table>
    </div>
    <div class="centerdiv">
    <table>
    
    <tr>
    <td><input type="button" class="all" id="p1"></td>
    <td><input type="button" style="margin-left:30%;" class="all" id="p2"></td>
    </tr>
    <tr>
    <td><input type="button" class="al" style="width:80px;height:40px;" id="userBTN1" value="" onclick="vote(value, 0)"></td>
    <td><input type="button" class="al" style="width:80px;height:40px;margin-left:30%;" id="userBTN2" value="" onclick="vote(value, 1)"></td>
    </tr>
    <tr>
    <td><input type="button" class="all" id="p3"></td>
    <td><input type="button" style="margin-left:30%;" class="all" id="p4"></td>
    </tr>
    <tr>
    <td><input type="button" class="al" style="width:80px;height:40px;" id="userBTN3" value="" onclick="vote(value, 2)"></td>
    <td><input type="button" class="al" style="width:80px;height:40px;margin-left:30%;" id="userBTN4" value="" onclick="vote(value, 3)"></td>
    </tr>
    </table>
    </div>
    
   

   <script type="text/javascript">
      //웹소켓 초기화
      var webSocket = new WebSocket(
            "ws://localhost:8080/chat3/broadsocket");
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
            shot.play();
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
</div>
       
</body>
</html>