package app.repositories;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.List;

import javax.persistence.EntityManager;

public abstract class Repository<T> {
	
	protected EntityManager entityManager;
	
	public Repository(EntityManager entityManager) {
		this.entityManager = entityManager;
	}
	
	public void create(Object entity) {
		entityManager.persist(entity);
	}
	
	public void update(Object entity) {
		entityManager.merge(entity);
	}
	
	public void destroy(Object entity) {
		entityManager.remove(entity);
	}
	
	public T find(Serializable id) {
		return (T) entityManager.find(getParameterizedClass(), id);
	}
	
	@SuppressWarnings("unchecked")
	public List<T> findAll() {
		return entityManager.createQuery("From " + getParameterizedClass().getName()).getResultList();
	}
	
	@SuppressWarnings("unchecked")
	private Class<T> getParameterizedClass() {
		ParameterizedType parameterizedType = (ParameterizedType) getClass().getGenericSuperclass();
		return (Class<T>) parameterizedType.getActualTypeArguments()[0];
	}
}
