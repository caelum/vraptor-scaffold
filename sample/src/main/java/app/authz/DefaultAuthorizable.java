package app.authz;

import java.util.HashSet;
import java.util.Set;

import br.com.caelum.vraptor.authz.Authorizable;
import br.com.caelum.vraptor.authz.Role;

public class DefaultAuthorizable implements Authorizable {

	@Override
	public Set<Role> roles() {
		return new HashSet<Role>();
	}
}
