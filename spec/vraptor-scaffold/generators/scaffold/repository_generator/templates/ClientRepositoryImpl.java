package app.repositories;

import org.hibernate.Session;

import br.com.caelum.vraptor.ioc.Component;
import app.models.Client;

@Component
public class ClientRepositoryImpl
    extends Repository<Client, Long>
    implements ClientRepository {

	ClientRepositoryImpl(Session session) {
		super(session);
	}
}
