package app.repositories;

import java.util.List;

import app.models.User;

public interface UserRepository {
	/*
	 * Delete the methods you don't want to expose
	 */
	 
	void create(User entity);
	
	void update(User entity);
	
	void destroy(User entity);
	
	User find(Long id);
	
	List<User> findAll();
	
	User login(String email, String password);

}
