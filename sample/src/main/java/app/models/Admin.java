package app.models;

import br.com.caelum.vraptor.authz.Role;

public class Admin implements Role {
	
	@Override
	public String getName() {
		return "admin";
	}
}