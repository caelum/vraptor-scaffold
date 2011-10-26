package app.infra;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.ComponentFactory;
import br.com.caelum.vraptor.ioc.RequestScoped;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

@Component
@RequestScoped
public class ObjectifyFactory implements ComponentFactory<Objectify> {

	private Objectify session;
	
	static {
	}

	@PostConstruct
	public void abreSession() {
		session = ObjectifyService.begin();
	}
	
	@PreDestroy
	public void fechaSession() {
		try {
		    session.getTxn().commit();
		} finally {
		    if (session.getTxn().isActive())
		    	session.getTxn().rollback();
		}
	}
	
	@Override
	public Objectify getInstance() {
		return session;
	}
}
