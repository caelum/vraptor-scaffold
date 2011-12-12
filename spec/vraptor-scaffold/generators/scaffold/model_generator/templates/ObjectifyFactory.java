package app.infra;

import javax.annotation.PostConstruct;

import br.com.caelum.vraptor.ioc.Component;
import br.com.caelum.vraptor.ioc.ComponentFactory;
import br.com.caelum.vraptor.ioc.RequestScoped;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

import app.models.Product;

@Component
@RequestScoped
public class ObjectifyFactory implements ComponentFactory<Objectify> {

	private Objectify session;
	
	static {
		ObjectifyService.register(Product.class);
	}

	@PostConstruct
	public void abreSession() {
		session = ObjectifyService.begin();
	}
	
	@Override
	public Objectify getInstance() {
		return session;
	}
}
