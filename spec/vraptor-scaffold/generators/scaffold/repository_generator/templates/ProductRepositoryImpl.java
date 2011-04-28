package app.repositories;

import javax.persistence.EntityManager;

import br.com.caelum.vraptor.ioc.Component;
import app.models.Product;

@Component
public class ProductRepositoryImpl
    extends Repository<Product, Long>
    implements ProductRepository {

	ProductRepositoryImpl(EntityManager entityManager) {
		super(entityManager);
	}
}
