package app.repository;

import java.util.List;

import app.model.Product;

public interface ProductRepository {
	/*
	 * Delete the methods you don't want to expose
	 */
	 
	void create(Product entity);
	
	void update(Product entity);
	
	void destroy(Product entity);
	
	Product find(Long id);
	
	List<Product> findAll();

}
