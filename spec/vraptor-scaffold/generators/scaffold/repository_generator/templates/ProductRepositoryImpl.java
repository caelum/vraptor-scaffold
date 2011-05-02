package app.repository;

import javax.persistence.EntityManager;

import br.com.caelum.vraptor.ioc.Component;
import app.model.Product;

@Component
public class ProductRepositoryImpl
    extends Repository<Product, Long>
    implements ProductRepository {

	ProductRepositoryImpl(EntityManager entityManager) {
		super(entityManager);
	}
}
