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
	//유저 집합 리스트
	static List<Session> sessionUsers = Collections.synchronizedList(new ArrayList<>());
	static ArrayList<String> userList = new ArrayList<String>();
	static int time=30;
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
		if (username == null) {
			userSession.getUserProperties().put("username", message);
			userSession.getBasicRemote().sendText(buildJsonData("System", "you are now connected as " + message));
			userList.add(message);
			
			if(userList.size()==2) {
				Iterator<Session> iterator = sessionUsers.iterator();
				while (iterator.hasNext()) {
					iterator.next().getBasicRemote().sendText(buildJsonData("공지 : " , "게임이 시작되었습니다"));
				}
			}
			
			return;
		}
		//username이 있으면 전체에게 메시지를 보낸다.
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
	 * 웹소켓을 닫으면 해당 유저를 유저리스트에서 뺀다.
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

	public static void setUserList(ArrayList<String> userList) {
		broadsocket.userList = userList;
	}
	
	public static ArrayList<String> getUserList() {
		return userList;
	}

}