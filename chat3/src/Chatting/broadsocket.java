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
   //���� ���� ����Ʈ
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
    * �� ������ ���ӵǸ� ��������Ʈ�� ������ �ִ´�.
    * 
    * @param userSession �� ���� ����
    */
   @OnOpen
   public void handleOpen(Session userSession) {
      sessionUsers.add(userSession);
   }

   /**
    * �� �������κ��� �޽����� ���� ȣ���Ѵ�.
    * 
    * @param message     �޽���
    * @param userSession
    * @throws IOException
    * @throws EncodeException 
    */
 
@OnMessage
   public void handleMessage(String message, Session userSession) throws IOException, EncodeException {
      String username = (String) userSession.getUserProperties().get("username");
      
      
      //���� ������Ƽ�� username�� ������ username�� �����ϰ� �ش� ���������� �޽����� ������.(json �����̴�.)
      //���� �޽����� username����
      //System.out.println(message.charAt(0));
      if (username == null) {
         userSession.getUserProperties().put("username", message);
         userSession.getUserProperties().put("job", "civil");
         userSession.getBasicRemote().sendText(buildJsonData2("��" + message + "���� ���ӿ� �����Ͽ����ϴ�."));
         userList.add(message);
         
         if(userList.size()==4) {
            Iterator<Session> iterator;
            
            //�������� ���� �Ҵ�
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
               iterator.next().getBasicRemote().sendText(buildJsonData2("�ܻ����� ���"));
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
               //iterator.next().getBasicRemote().sendText(buildJsonData("���� : " , "������ ���۵Ǿ����ϴ�"));
               iterator.next().getBasicRemote().sendText(buildJsonData2("������ ���۵Ǿ����ϴ�"));
            }

            for(int i=0; i<sessionUsers.size(); i++) {
              	sessionUsers.get(i).getBasicRemote().sendText(buildJsonData2("��"+"����� ������"+(String) sessionUsers.get(i).getUserProperties().get("job")));
              }
         }
         
         return;
      }
      
      //���� �� ������ Vote_Check �迭 �ʱ�ȭ
      if(message.equals("nigthnigthnigthnigthnigth")) {
    	  Vote_Check.clear();

    	  return;
      }
     
      //username�� ������ ��ü���� �޽����� ������.
      
      if(message.charAt(0)=='��') {
    	  //��ǥ�� ���� �ʾ����� Vote_Check �迭�� �ְ� ����Ѵ�.
    	  if(!Vote_Check.contains(userSession.getId()) && !Death_Broadcast.contains((String)userSession.getUserProperties().get("username"))){
    		  Vote_Check.add(userSession.getId());
    		  String new_message = message.substring(1);
        	  Iterator<Session> iterator = sessionUsers.iterator();
              while (iterator.hasNext()) {
                 iterator.next().getBasicRemote().sendText(buildJsonData2(new_message));
              }
    	  }  
      }else if(message.charAt(0)=='��') {
    	  if(message.substring(1).equals("�ƹ��� ������")) {
    		  
    	  }
    	  else if(message.substring(message.length()-8).equals("�� �׾����ϴ�.")) {
    		  

    		  if(!Death_Broadcast.contains(message.substring(1, message.length()-8))) {
    			  Death_Broadcast.add(message.substring(1, message.length()-8));
    		  
    		  for(int i=0; i<sessionUsers.size(); i++) {
      	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1, message.length()-8))){
      	  			//System.out.println(message.substring(1)+"�� ������ " + (String)sessionUsers.get(i).getUserProperties().get("job"));
      	  			if(((String)sessionUsers.get(i).getUserProperties().get("job")).equals("mafia")){
      	  				mafia_team--;
      	  				System.out.println("���Ǿ� �Ѹ� ���� "+ mafia_team + " " + civil_team);
      	  				System.out.println(mafia_team);
      	  				System.out.println(civil_team);
      	  				if(mafia_team<=0 && civil_team >=1) {
      	  					System.out.println("�ù� �¸�");
      	  					Iterator<Session> iterator = sessionUsers.iterator();
      	  					String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
      	  					while (iterator.hasNext()) {
      	  						
      	  						iterator.next().getBasicRemote().sendText(buildJsonData2("��ù� �¸�!!"+p1+p2+p3+p4));
      	  					}
      	  				}
      	  			}else {
      	  				civil_team--;
      	  				System.out.println("�ù� �Ѹ� ���� " + mafia_team + " " + civil_team);
      	  				System.out.println(mafia_team);
      	  				System.out.println(civil_team);
      	  				if(mafia_team==1 && civil_team==1) {
      	  					System.out.println("���Ǿ� �¸�");
      	  					Iterator<Session> iterator = sessionUsers.iterator();
      	  					String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
      	  					while (iterator.hasNext()) {
      	  						iterator.next().getBasicRemote().sendText(buildJsonData2("�㸶�Ǿƽ¸�!!"+p1+p2+p3+p4));
      	  					}
      	  				}
      	  			}
      	  			
      	  			break;
      	  		}
        	  }
    		  }
    	  }
    	
    	  String new_message = message.substring(1);
    	  userSession.getBasicRemote().sendText(buildJsonData2("��ǥ��"+new_message));

    	  
      }else if(message.charAt(0)=='��'){
    	  
    	  
    	  if(message.substring(1).contentEquals("")) {
    		  Iterator<Session> iterator2 = sessionUsers.iterator();
					while (iterator2.hasNext()) {
						iterator2.next().getBasicRemote().sendText(buildJsonData2("�ƹ��� ���� �ʾҽ��ϴ�."));
					}
    	  }
    	  else {
    		  
    		  Iterator<Session> iterator = sessionUsers.iterator();
              while (iterator.hasNext()) {
                 iterator.next().getBasicRemote().sendText(buildJsonData2("�и��Ǿƿ� ���� " + message.substring(1) + "�� �׾����ϴ�."));
              }
              for(int i=0; i<sessionUsers.size(); i++) {
        	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1))){
        	  			//System.out.println(message.substring(1)+"�� ������ " + (String)sessionUsers.get(i).getUserProperties().get("job"));
        	  			if(((String)sessionUsers.get(i).getUserProperties().get("job")).equals("mafia")){
        	  				mafia_team--;
        	  				System.out.println("���Ǿ� �Ѹ� ����");
        	  				System.out.println(mafia_team);
        	  				System.out.println(civil_team);
        	  				if(mafia_team<=0 && civil_team >=1) {
          	  					System.out.println("�ù� �¸�");
          	  					Iterator<Session> iterator2 = sessionUsers.iterator();
          	  				String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
  	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
  	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
  	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
          	  					while (iterator2.hasNext()) {
          	  						iterator2.next().getBasicRemote().sendText(buildJsonData2("��ù� �¸�!!"+p1+p2+p3+p4));
          	  					}
          	  				}
        	  			}else {
        	  				civil_team--;
        	  				System.out.println("�ù� �Ѹ� ����");
        	  				System.out.println(mafia_team);
        	  				System.out.println(civil_team);
        	  				if(mafia_team==1 && civil_team==1) {
          	  					System.out.println("���Ǿ� �¸�");
          	  					Iterator<Session> iterator2 = sessionUsers.iterator();
          	  				String p1= (String)sessionUsers.get(0).getUserProperties().get("username")+"     "+(String)sessionUsers.get(0).getUserProperties().get("job")+"\n";
  	  						String p2= (String)sessionUsers.get(1).getUserProperties().get("username")+"     "+(String)sessionUsers.get(1).getUserProperties().get("job")+"\n";
  	  						String p3= (String)sessionUsers.get(2).getUserProperties().get("username")+"     "+(String)sessionUsers.get(2).getUserProperties().get("job")+"\n";
  	  						String p4= (String)sessionUsers.get(3).getUserProperties().get("username")+"     "+(String)sessionUsers.get(3).getUserProperties().get("job");
          	  					while (iterator2.hasNext()) {
          	  						iterator2.next().getBasicRemote().sendText(buildJsonData2("�㸶�Ǿƽ¸�!!"+p1+p2+p3+p4));
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
      }else if(message.charAt(0)=='��') {
    	  	
    	  	for(int i=0; i<sessionUsers.size(); i++) {
    	  		if(((String)sessionUsers.get(i).getUserProperties().get("username")).equals(message.substring(1))){
    	  			//System.out.println(message.substring(1)+"�� ������ " + (String)sessionUsers.get(i).getUserProperties().get("job"));
    	  			userSession.getBasicRemote().sendText(buildJsonData2('��'+message.substring(1)+"�� ������ " + (String)sessionUsers.get(i).getUserProperties().get("job")));
    	  			break;
    	  		}
    	  	}
    	  	System.out.println(userSession.getUserProperties().get("username"));
    	  	
      }else {//�׳� ���ϴ°�
    	  Iterator<Session> iterator = sessionUsers.iterator();
    	  if(!Death_Broadcast.contains((String)userSession.getUserProperties().get("username"))){
    		  while (iterator.hasNext()) {
        		  iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
        	  }
    	  }
      }
   }


   /**
    * �������� ������ �ش� ������ ��������Ʈ���� ����.
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
    * jsonŸ���� �޽��� �����
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
