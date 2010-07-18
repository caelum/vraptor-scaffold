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
import br.com.caelum.vraptor.Validator;

@Resource
public class ProductController {

	private final Result result;
	private final EntityManager entityManager;
	private final Validator validator;
	
	public ProductController(Result result, EntityManager entityManager, Validator validator) {
		this.entityManager = entityManager;
		this.result = result;
		this.validator = validator;
	}
	
	@Get
	@Path("/products")
	public List<Product> index() {
		return entityManager.createQuery("from Product").getResultList();
	}
	
	@Post
	@Path("/products")
	public void create(Product product) {
		validator.validate(product);
		validator.onErrorForwardTo(this).form(product);
		entityManager.persist(product);
		result.redirectTo(this).index();
	}
	
	@Get
	@Path("/products/new")
	public void newProduct() {
		result.forwardTo(this).form(new Product());
	}
	
	@Put
	@Path("/products")
	public void update(Product product) {
		validator.validate(product);
		validator.onErrorForwardTo(this).form(product);
		entityManager.merge(product);
		result.redirectTo(this).index();
	}
	
	@Get
	@Path("/products/{product.id}/edit")
	public void edit(Product product) {
		result.forwardTo(this).form(entityManager.find(Product.class, product.getId()));
	}

	@Get
	@Path("/products/{product.id}/show")
	public Product show(Product product) {
		return entityManager.find(Product.class, product.getId());
	}

	@Delete
	@Path("/products")
	public void destroy(Product product) {
		entityManager.remove(entityManager.find(Product.class, product.getId()));
		result.redirectTo(this).index();  
	}
	
	public Product form(Product product) {
		return product;
	}
}
