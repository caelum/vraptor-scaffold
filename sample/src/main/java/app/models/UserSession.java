package app.models;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.SessionScoped;

@Component
@SessionScoped
public class UserSession {
	
	private User user;

	public User getUser() {
		return user;
	}

	public void singIn(User user) {
		this.user = user;
	}
	
	public void signOut() {
		user = null;
	}
	
	public boolean isLogged() {
		return user != null? true : false;
	}
}
