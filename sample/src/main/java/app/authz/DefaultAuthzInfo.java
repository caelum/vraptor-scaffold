package app.authz;

import app.controllers.LoginController;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.authz.Authorizable;
import br.com.caelum.vraptor.authz.AuthzInfo;
import br.com.caelum.vraptor.ioc.Component;

@Component
public class DefaultAuthzInfo implements AuthzInfo {
	
	@Override
	public Authorizable getAuthorizable() {
		return new DefaultAuthorizable();
	}

	@Override
	public void handleAuthError(Result result) {
		result.redirectTo(LoginController.class).signin();
	}
}