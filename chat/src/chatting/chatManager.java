package chatting;
import java.util.ArrayList;
import java.util.List;
public class chatManager {
	List<chatBean> userlist = new ArrayList<chatBean>();
	
	public void add(chatBean ab) {
		userlist.add(ab);
	}

	public List<chatBean> getUserlist() {
		return userlist;
	}

	public void setUserlist(List<chatBean> userlist) {
		this.userlist = userlist;
	}
	
	public List<chatBean> emptyUserlist(){
		userlist=null;
		return userlist;
	}
}
