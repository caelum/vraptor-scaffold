package app.controllers;

import java.util.List;

import javax.persistence.EntityManager;

import app.models.${model?cap_first};
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;

@Resource
public class ${model?cap_first}Controller {

	private Result result;
	private EntityManager entityManager;
	
	public ${model?cap_first}Controller(Result result, EntityManager entityManager) {
		this.entityManager = entityManager;
		this.result = result;
	}
	
	@Get
	@Path("${path}")
	public List<${model?cap_first}> index() {
		return entityManager.createQuery("from ${model?cap_first}").getResultList();
	}
	
	@Post
	@Path("${path}")
	public void create(${model?cap_first} ${model}) {
		entityManager.persist(${model});
		result.use(Results.logic()).redirectTo(${model?cap_first}Controller.class).index();  
	}
	
	@Get
	@Path("${path}/new")
	public ${model?cap_first} new${model?cap_first}() {
		return new ${model?cap_first}();
	}
	
	@Put
	@Path("${path}")
	public void update(${model?cap_first} ${model}) {
		entityManager.merge(${model});
		result.use(Results.logic()).redirectTo(${model?cap_first}Controller.class).index();  
	}
	
	@Get
	@Path("${path}/{${model}.id}/edit")
	public ${model?cap_first} edit(${model?cap_first} ${model}) {
		return entityManager.find(${model?cap_first}.class, ${model}.getId());
	}

	@Get
	@Path("${path}/{${model}.id}/show")
	public ${model?cap_first} show(${model?cap_first} ${model}) {
		return  entityManager.find(${model?cap_first}.class, ${model}.getId());
	}

	@Delete
	@Path("${path}")
	public void destroy(${model?cap_first} ${model}) {
		entityManager.remove(entityManager.find(${model?cap_first}.class, ${model}.getId()));
		result.use(Results.logic()).redirectTo(${model?cap_first}Controller.class).index();  
	}
}