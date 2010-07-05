package app.controllers;

import java.util.List;

import javax.persistence.EntityManager;

import app.models.Product;
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;

@Resource
public class ProductController {

	private Result result;
	private EntityManager entityManager;
	
	public ProductController(Result result, EntityManager entityManager) {
		this.entityManager = entityManager;
		this.result = result;
	}
	
	@Get
	@Path("/products")
	public List<Product> index() {
		return entityManager.createQuery("from Product").getResultList();
	}
	
	@Post
	@Path("/products")
	public void create(Product product) {
		entityManager.persist(product);
		result.use(Results.logic()).redirectTo($ProductController.class).index();  
	}
	
	@Get
	@Path("/products/new")
	public Product newProduct() {
		return new Product();
	}
	
	@Put
	@Path("/products")
	public void update(Product product) {
		entityManager.merge(product);
		result.use(Results.logic()).redirectTo(ProductController.class).index();  
	}
	
	@Get
	@Path("/products/product.id/edit")
	public Product edit(Product product) {
		return entityManager.find(Product.class, product.getId());
	}

	@Get
	@Path("/products/product.id/show")
	public Product show(Product product) {
		return  entityManager.find(Product, product.getId());
	}

	@Delete
	@Path("/products")
	public void destroy(Product product) {
		entityManager.remove(entityManager.find(Product.class, product.getId()));
		result.use(Results.logic()).redirectTo(ProductController.class).index();  
	}
}
