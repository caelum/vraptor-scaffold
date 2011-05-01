package app.repositories;

import java.util.List;

import app.models.Product;

public interface ProductRepository {
	/*
	 * Delete the methods you don't want to expose
	 */
	 
	void create(Product entity);
	
	Product update(Product entity);
	
	void destroy(Product entity);
	
	Product find(Long id);
	
	List<Product> findAll();

}
