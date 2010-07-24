package app.repositories;

import javax.persistence.EntityManager;

import br.com.caelum.vraptor.ioc.Component;
import app.models.Product;

@Component
public class ProductRepository extends Repository<Product> {

	public ProductRepository(EntityManager entityManager) {
		super(entityManager);
	}
}
