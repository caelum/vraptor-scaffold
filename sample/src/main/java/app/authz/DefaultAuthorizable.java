package app.authz;

import java.util.HashSet;
import java.util.Set;

import app.models.Admin;
import br.com.caelum.vraptor.authz.Authorizable;
import br.com.caelum.vraptor.authz.Role;

public class DefaultAuthorizable implements Authorizable {
	
	@Override
	public Set<Role> roles() {
		HashSet<Role> roles = new HashSet<Role>();
		roles.add(new Admin());
		return roles;
	}
}