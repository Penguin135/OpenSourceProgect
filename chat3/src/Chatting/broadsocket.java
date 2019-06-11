package Chatting;

import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Iterator;
import java.util.List;
import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;
import javax.websocket.EncodeException;
import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;
import java.util.Random;

@ServerEndpoint("/broadsocket")
public class broadsocket {
   //유저 집합 리스트
	static ArrayList<String> Vote_Check= new ArrayList<String>();
	static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	static ArrayList<String> userList = new ArrayList<String>();
	static ArrayList<String> Death_Broadcast = new ArrayList<String>();
	static ArrayList<String> jobList = new ArrayList<String>();
	static int mafiaIndex=-1;
	static int policeIndex=-1;
	static int mafia_team=1;
	static int civil_team=3;
   /**
    * 웹 소켓이 접속되면 유저리스트에 세션을 넣는다.
    * 
    * @param userSession 웹 소켓 세션
    */
   @OnOpen
   public void handleOpen(Session userSession) {
      sessionUsers.add(userSession);
   }

   /**
    * 웹 소켓으로부터 메시지가 오면 호출한다.
    * 
    * @param message     메시지
    * @param userSession
    * @throws IOException
    * @throws EncodeException 
    */
 
@OnMessage
   public void handleMessage(String message, Session userSession) throws IOException, EncodeException {
      String username = (String) userSession.getUserProperties().get("username");
      
      
      //세션 프로퍼티에 username이 없으면 username을 선언하고 해당 세션을으로 메시지를 보낸다.(json 형식이다.)
      //최초 메시지는 username설정
      //System.out.println(message.charAt(0));
      if (username == null) {
         userSession.getUserProperties().put("username", message);
         userSession.getUserProperties().put("job", "civil");
         userSession.getBasicRemote().sendText(buildJsonData2("【" + message + "으로 게임에 참여하였습니다."));
         userList.add(message);
         
         if(userList.size()==4) {
            Iterator<Session> iterator;
            
            //랜덤으로 직업 할당
            Random random = new Random();
            mafiaIndex=random.nextInt(4);
            policeIndex=random.nextInt(4);
            while(mafiaIndex==policeIndex) {
            	policeIndex=random.nextInt(4);
            }
            sessionUsers.get(mafiaIndex).getUserProperties().put("job", "mafia");
            sessionUsers.get(policeIndex).getUserProperties().put("job", "police");
            
          
            
            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               iterator.next().getBasicRemote().sendText(buildJsonData2("●생존자 목록"));
            }
            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               iterator.next().getBasicRemote().sendText(buildJsonData2(userList.get(0)));
            }
            
            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               iterator.next().getBasicRemote().sendText(buildJsonData2(userList.get(1)));
            }

            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               iterator.next().getBasicRemote().sendText(buildJsonData2(userList.get(2)));
            }

            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               iterator.next().getBasicRemote().sendText(buildJsonData2(userList.get(3)));
            }
            
            iterator = sessionUsers.iterator();
            while (iterator.hasNext()) {
               //iterator.next().getBasicRemote().sendText(buildJsonData("공지 : " , "게임이 시작되었습니다"));
               iterator.next().getBasicRemote().sendText(buildJsonData2("게임이 시작되었습니다"));
            }

            for(int i=0; i<sessionUsers.size(); i++) {
              	sessionUsers.get(i).getBasicRemote().sendText(buildJsonData2("◎"+"당신의 직업은"+(String) sessionUsers.get(i).getUserProperties().get("job")));
              }
         }
         
         return;
      }
      
      //밤이 될 때마나 Vote_Check 배열 초기화
      if(message.equals("nigthnigthnigthnigthnigth")) {
    	  Vote_Check.clear();

    	  return;
      }
     
      //username이 있으면 전체에게 메시지를 보낸다.
      
      if(message.charAt(0)=='§') {
    	  //투표를 하지 않았으면 Vote_Check 배열에 넣고 방송한다.
    	  if(!Vote_Check.contains(userSession.getId()) && !Death_Broadcast.contains((String)userSession.getUserProperties().get("username"))){
    		  Vote_Check.add(userSession.getId());
    		  String new_message = message.substring(1);
        	  Iterator<Session> iterator = sessionUsers.iterator();
              while (iterator.hasNext()) {
                 iterator.next().getBasicRemote().sendText(buildJsonData2(new_message));
              }
    	  }  
      }else if(message.charAt(0)=='★') {
    	  if(message.substring(1).equals("아무도 안죽음")) {
    		  
    	  }
    	  else if(message.substring(message.length()-8).equals("가 죽었습니다.")) {
    		  

    		  if(!Death_Broadcast.contains(message.substring(1, message.length()-8))) {
    			  Death_Broadcast.add(message.substring(1, message.length()-8));
    		  
    		  for(int i=0; i<sessionUsers.size(); i++) {
      	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1, message.length()-8))){
      	  			//System.out.println(message.substring(1)+"의 직업은 " + (String)sessionUsers.get(i).getUserProperties().get("job"));
      	  			if(((String)sessionUsers.get(i).getUserProperties().get("job")).equals("mafia")){
      	  				mafia_team--;
      	  				System.out.println("마피아 한명 줄음 "+ mafia_team + " " + civil_team);
      	  				System.out.println(mafia_team);
      	  				System.out.println(civil_team);
      	  				if(mafia_team<=0 && civil_team >=1) {
      	  					System.out.println("시민 승리");
      	  					Iterator<Session> iterator = sessionUsers.iterator();
      	  					String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
      	  					while (iterator.hasNext()) {
      	  						
      	  						iterator.next().getBasicRemote().sendText(buildJsonData2("ⓦ시민 승리!!"+p1+p2+p3+p4));
      	  					}
      	  				}
      	  			}else {
      	  				civil_team--;
      	  				System.out.println("시민 한명 줄음 " + mafia_team + " " + civil_team);
      	  				System.out.println(mafia_team);
      	  				System.out.println(civil_team);
      	  				if(mafia_team==1 && civil_team==1) {
      	  					System.out.println("마피아 승리");
      	  					Iterator<Session> iterator = sessionUsers.iterator();
      	  					String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
      	  					while (iterator.hasNext()) {
      	  						iterator.next().getBasicRemote().sendText(buildJsonData2("ⓦ마피아승리!!"+p1+p2+p3+p4));
      	  					}
      	  				}
      	  			}
      	  			
      	  			break;
      	  		}
        	  }
    		  }
    	  }
    	
    	  String new_message = message.substring(1);
    	  userSession.getBasicRemote().sendText(buildJsonData2("투표로"+new_message));

    	  
      }else if(message.charAt(0)=='ⓚ'){
    	  
    	  
    	  if(message.substring(1).contentEquals("")) {
    		  Iterator<Session> iterator2 = sessionUsers.iterator();
					while (iterator2.hasNext()) {
						iterator2.next().getBasicRemote().sendText(buildJsonData2("아무도 죽지 않았습니다."));
					}
    	  }
    	  else {
    		  
    		  Iterator<Session> iterator = sessionUsers.iterator();
              while (iterator.hasNext()) {
                 iterator.next().getBasicRemote().sendText(buildJsonData2("ⓓ마피아에 의해 " + message.substring(1) + "이 죽었습니다."));
              }
              for(int i=0; i<sessionUsers.size(); i++) {
        	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1))){
        	  			//System.out.println(message.substring(1)+"의 직업은 " + (String)sessionUsers.get(i).getUserProperties().get("job"));
        	  			if(((String)sessionUsers.get(i).getUserProperties().get("job")).equals("mafia")){
        	  				mafia_team--;
        	  				System.out.println("마피아 한명 줄음");
        	  				System.out.println(mafia_team);
        	  				System.out.println(civil_team);
        	  				if(mafia_team<=0 && civil_team >=1) {
          	  					System.out.println("시민 승리");
          	  					Iterator<Session> iterator2 = sessionUsers.iterator();
          	  				String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
  	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
  	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
  	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
          	  					while (iterator2.hasNext()) {
          	  						iterator2.next().getBasicRemote().sendText(buildJsonData2("ⓦ시민 승리!!"+p1+p2+p3+p4));
          	  					}
          	  				}
        	  			}else {
        	  				civil_team--;
        	  				System.out.println("시민 한명 줄음");
        	  				System.out.println(mafia_team);
        	  				System.out.println(civil_team);
        	  				if(mafia_team==1 && civil_team==1) {
          	  					System.out.println("마피아 승리");
          	  					Iterator<Session> iterator2 = sessionUsers.iterator();
          	  				String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
  	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
  	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
  	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
          	  					while (iterator2.hasNext()) {
          	  						iterator2.next().getBasicRemote().sendText(buildJsonData2("ⓦ마피아승리!!"+p1+p2+p3+p4));
          	  					}
          	  				}
        	  			}
        	  			
        	  			break;
        	  		}
          	  }
    		  if(!Death_Broadcast.contains(message.substring(1))) {
    			  Death_Broadcast.add(message.substring(1));
    		  }
    	  }
    	  
      //sddfdf
      }else if(message.charAt(0)=='ⓘ') {
    	  	
    	  	for(int i=0; i<sessionUsers.size(); i++) {
    	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1))){
    	  			//System.out.println(message.substring(1)+"의 직업은 " + (String)sessionUsers.get(i).getUserProperties().get("job"));
    	  			userSession.getBasicRemote().sendText(buildJsonData2('ⓡ'+message.substring(1)+"의 직업은 " + (String)sessionUsers.get(i).getUserProperties().get("job")));
    	  			break;
    	  		}
    	  	}
    	  	System.out.println(userSession.getUserProperties().get("username"));
    	  	
      }else {//그냥 말하는거
    	  Iterator<Session> iterator = sessionUsers.iterator();
    	  if(!Death_Broadcast.contains((String)userSession.getUserProperties().get("username"))){
    		  while (iterator.hasNext()) {
        		  iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
        	  }
    	  }
      }
   }


   /**
    * 웹소켓을 닫으면 해당 유저를 유저리스트에서 뺀다.
    * 
    * @param userSession
    */
   @OnClose
   public void handleClose(Session userSession) {
	   String username = (String) userSession.getUserProperties().get("username");
	   System.out.print(username);
	   sessionUsers.remove(userSession);
      
      
      userList.remove(username);
      
   }

   /**
    * json타입의 메시지 만들기
    * 
    * @param username
    * @param message
    * @return
    */
   public String buildJsonData(String username, String message) {
      JsonObject jsonObject = Json.createObjectBuilder().add("message", username + " : " + message).build();
      StringWriter stringwriter = new StringWriter();
      try (JsonWriter jsonWriter = Json.createWriter(stringwriter)) {
         jsonWriter.write(jsonObject);
      }
      return stringwriter.toString();
   }
   
   public String buildJsonData2(String message) {
      JsonObject jsonObject = Json.createObjectBuilder().add("message", message).build();
      StringWriter stringwriter = new StringWriter();
      try (JsonWriter jsonWriter = Json.createWriter(stringwriter)) {
         jsonWriter.write(jsonObject);
      }
      return stringwriter.toString();
   }
   
   public void choiceJob() {
	   
   }
   
}
