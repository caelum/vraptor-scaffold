package app.repository;

import com.googlecode.objectify.Objectify;

import br.com.caelum.vraptor.ioc.Component;
import app.model.Product;

@Component
public class ProductRepositoryImpl
    extends Repository<Product, Long>
    implements ProductRepository {

	ProductRepositoryImpl(Objectify objectify) {
		super(objectify);
	}
}
