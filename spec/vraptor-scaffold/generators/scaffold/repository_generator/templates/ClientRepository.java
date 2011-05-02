package app.repository;

import java.util.List;

import app.models.Client;

public interface ClientRepository {
	/*
	 * Delete the methods you don't want to expose
	 */
	 
	void create(Client entity);
	
	Client update(Client entity);
	
	void destroy(Client entity);
	
	Client find(Long id);
	
	List<Client> findAll();

}
