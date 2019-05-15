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

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;


@ServerEndpoint("/broadsocket")
public class broadsocket {
	//���� ���� ����Ʈ
	static ArrayList<String> userList = new ArrayList<String>();
	
	static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	public ArrayList<String> getUserList() {
		return userList;
	}

	public void setUserList(ArrayList<String> userList) {
		this.userList = userList;
	}

	
	int num;
	/**
	* �� ������ ���ӵǸ� ��������Ʈ�� ������ �ִ´�.
	* @param userSession �� ���� ����
	*/
	@OnOpen
	public void handleOpen(Session userSession) {
		sessionUsers.add(userSession);
	}

	/**
	* �� �������κ��� �޽����� ���� ȣ���Ѵ�.
	* @param message �޽���
	* @param userSession
	* @throws IOException
	*/
	@OnMessage
	public void handleMessage(String message, Session userSession) throws IOException {
		String username = (String) userSession.getUserProperties().get("username");
		//���� ������Ƽ�� username�� ������ username�� �����ϰ� �ش� ���������� �޽����� ������.(json �����̴�.)
		//���� �޽����� username����
		if (username == null) {
			userSession.getUserProperties().put("username", message);
			userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as " + message));
			//System.out.println(username);
			userList.add(message);
			System.out.println(message);
			return;
		}
		//username�� ������ ��ü���� �޽����� ������.
		
		Iterator<Session> iterator = sessionUsers.iterator();
		while (iterator.hasNext()) {
			iterator.next().getBasicRemote().sendText(buildJsonData(username, message));
		}
	}

	/**
	* �������� ������ �ش� ������ ��������Ʈ���� ����.
	* @param userSession
	*/
	@OnClose
	public void handleClose(Session userSession) {
		sessionUsers.remove(userSession);
	}

	/**
	* jsonŸ���� �޽��� �����
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

	public static List<Session> getSessionUsers() {
		return sessionUsers;
	}

	public static void setSessionUsers(List<Session> sessionUsers) {
		broadsocket.sessionUsers = sessionUsers;
	}

	public int getNum(int n) {
		num=n;
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
}