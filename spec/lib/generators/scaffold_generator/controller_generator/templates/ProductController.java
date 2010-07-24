package app.controllers;

import java.util.List;

import app.models.Product;
import app.repositories.ProductRepository;
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
	private final ProductRepository repository;
	private final Validator validator;
	
	public ProductController(Result result, ProductRepository repository, Validator validator) {
		this.result = result;
		this.repository = repository;
		this.validator = validator;
	}
	
	@Get
	@Path("/products")
	public List<Product> index() {
		return repository.findAll();
	}
	
	@Post
	@Path("/products")
	public void create(Product product) {
		validator.validate(product);
		validator.onErrorForwardTo(this).form(product);
		repository.create(product);
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
		repository.update(product);
		result.redirectTo(this).index();
	}
	
	@Get
	@Path("/products/{product.id}/edit")
	public void edit(Product product) {
		result.forwardTo(this).form(repository.find(product.getId()));
	}

	@Get
	@Path("/products/{product.id}/show")
	public Product show(Product product) {
		return repository.find(product.getId());
	}

	@Delete
	@Path("/products")
	public void destroy(Product product) {
		repository.destroy(repository.find(product.getId()));
		result.redirectTo(this).index();  
	}
	
	public Product form(Product product) {
		return product;
	}
}
