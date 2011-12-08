package app.controller;

import java.util.List;

import app.model.Product;
import app.repository.ProductRepository;
import app.repositories.CategoryRepository;		
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.Validator;

@Resource
public class ProductController {

	private final Result result;
	private final ProductRepository repository;
	private final CategoryRepository categoryRepository;		
	
	private final Validator validator;
	
	public ProductController(Result result, ProductRepository repository, 
	CategoryRepository categoryRepository,	Validator validator) {
		this.result = result;
		this.repository = repository;
		this.categoryRepository = categoryRepository;	
		this.validator = validator;
	}
	
	@Get("/products")
	public List<Product> index() {
		return repository.findAll();
	}
	
	@Post("/products")
	public void create(Product product) {
		validator.validate(product);
		validator.onErrorUsePageOf(this).newProduct();
		repository.create(product);
		result.redirectTo(this).index();
	}
	
	@Get("/products/new")
	public Product newProduct() {
		result.include("categoryList", categoryRepository.findAll());		
		return new Product();
	}
	
	@Put("/products")
	public void update(Product product) {
		validator.validate(product);
		validator.onErrorUsePageOf(this).edit(product);
		repository.update(product);
		result.redirectTo(this).index();
	}
	
	@Get("/products/{product.id}/edit")
	public Product edit(Product product) {
		result.include("categoryList", categoryRepository.findAll());		
		
		return repository.find(product.getId());
	}

	@Get("/products/{product.id}")
	public Product show(Product product) {
		return repository.find(product.getId());
	}

	@Delete("/products/{product.id}")
	public void destroy(Product product) {
		repository.destroy(repository.find(product.getId()));
		result.redirectTo(this).index();  
	}
}