package chatting;

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

@ServerEndpoint("/broadsocket")
public class broadsocket {
	//���� ���� ����Ʈ
	static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	static List<Session> sessionMafia = Collections.synchronizedList(new ArrayList<>());
	static ArrayList<String> userList = new ArrayList<String>();
	static int time=3;
	
	//MafiaList
	static ArrayList<String> MafiaList = new ArrayList<String>();
	static int citizen = 0;
	static int Mafia = 1;
	/**
	 * �� ������ ���ӵǸ� ��������Ʈ�� ������ �ִ´�.
	 * 
	 * @param userSession �� ���� ����
	 */
	@OnOpen
	public void handleOpen(Session userSession) {
		sessionUsers.add(userSession);
	}
	public void handleOpen2(Session userMafia) {
		sessionUsers.add(userMafia);
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
		if (username == null) {
			userSession.getUserProperties().put("username", message);
			userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as " + message));
			userList.add(message);
			if(userList.size()==3) {
				MafiaList.add("1");
			}
			else {
				MafiaList.add("0");
			}
			
			
			if(userList.size()==3) {
				Iterator<Session> iterator = sessionUsers.iterator();
				while (iterator.hasNext()) {
					iterator.next().getBasicRemote().sendText(buildJsonData("����" , "������ ���۵Ǿ����ϴ�"));
					}
				
				/*while (iterator.hasNext()) {
					int index = 0;
					if(MafiaList.get(index++)=="0") {
						iterator.next().getBasicRemote().sendText("����� �ù��Դϴ�.");
					}
					else if(MafiaList.get(index++)=="1") {
						iterator.next().getBasicRemote().sendText("����� ���Ǿ��Դϴ�.");
					}
					}*/
				
			}
			
		
			return;
		}
		
		//username�� ������ ��ü���� �޽����� ������.
		Iterator<Session> iterator = sessionUsers.iterator();
		while (iterator.hasNext()) {
			iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
		}
	}

	public static int getTime() {
		return time;
	}

	public static void setTime(int time) {
		broadsocket.time = time;
	}

	/**
	 * �������� ������ �ش� ������ ��������Ʈ���� ����.
	 * 
	 * @param userSession
	 */
	@OnClose
	public void handleClose(Session userSession) {
		sessionUsers.remove(userSession);
		String username = (String) userSession.getUserProperties().get("username");
		//System.out.print(username);
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

	public static void setUserList(ArrayList<String> userList) {
		broadsocket.userList = userList;
	}
	public static void setMafiaList(ArrayList MafiaList) {
		broadsocket.MafiaList = MafiaList;
	}
	
	public static ArrayList<String> getUserList() {
		return userList;
	}
	public static ArrayList getMafiaList() {
		return MafiaList;
	}

}

/*if(iterator2.next().equals(1)) {
iterator2.next().getBasicRemote().sendText(buildJsonData("����� " , "���Ǿ��Դϴ�."));
}
else
{
iterator2.next().getBasicRemote().sendText(buildJsonData("����� " , "�ù��Դϴ�."));
}*/
/*int total = MafiaList.size();
for (int index = 0; index < total ; index ++) {
if(MafiaList.get(index)=="0") {
iterator.next().getBasicRemote().sendText("���Ǿư� �����Ǿ����ϴ�.");
};
}*/

//MafiaList Ȯ��
/*if(userList.size()==3) {
int total = MafiaList.size();
for (int index = 0; index < total ; index ++) {
	System.out.println(MafiaList.get(index));
}
}*/
//÷ ������ ���Ǿ�
/*if(userList.size()==1) {
MafiaList.remove(0);
MafiaList.add(1);
}*/  