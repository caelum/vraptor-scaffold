package app.controllers;

import java.util.List;

import javax.persistence.EntityManager;

import app.models.${class?cap_first};
import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;

@Resource
public class ${class?cap_first}Controller {

	private Result result;
	private EntityManager entityManager;
	
	public ${class?cap_first}Controller(Result result, EntityManager entityManager) {
		this.entityManager = entityManager;
		this.result = result;
	}
	
	@Get
	@Path("${path}")
	public List<${class?cap_first}> index() {
		return entityManager.createQuery("from ${class?cap_first}").getResultList();
	}
}