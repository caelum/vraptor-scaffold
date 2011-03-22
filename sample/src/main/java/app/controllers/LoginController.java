package app.controllers;

import app.models.User;
import app.models.UserSession;
import app.repositories.UserRepository;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.authz.annotation.AuthzBypass;

@Resource
@AuthzBypass
public class LoginController {

	private Result result;
	private UserRepository userRepository;
	private UserSession userSession;

	public LoginController(Result result, UserRepository userRepository, UserSession userSession) {
		this.result = result;
		this.userRepository = userRepository;
		this.userSession = userSession;
	}

	@Get("/signin")
	public void signin() {
	}

	@Post("/signin")
	public void signin(User user) {
		user = userRepository.login(user.getEmail(), user.getPassword());
		if (user == null) {
			result.redirectTo(this).signin();
		}
		userSession.singIn(user);
		result.redirectTo(UserController.class).index();
	}

	@Get("/signout")
	public void signout() {
		userSession.signOut();
		result.redirectTo(this).signin();
	}
}