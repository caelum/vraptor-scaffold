package app.authz;

import java.util.EnumSet;

import app.models.UserSession;
import br.com.caelum.vraptor.authz.Authorizator;
import br.com.caelum.vraptor.authz.Role;
import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.resource.HttpMethod;

@Component
public class DefaultAuthorizator implements Authorizator {
	
	private final UserSession userSession;
	
	public DefaultAuthorizator(UserSession userSession) {
		this.userSession = userSession;
	}
	
	@Override
	public boolean isAllowed(Role role, String url, EnumSet<HttpMethod> httpMethods) {
		return userSession.isLogged();
		//TODO: verify if user can access the resource.
	}
}