package app.controllers;

import java.util.List;

import javax.persistence.EntityManager;

import br.com.caelum.vraptor.Delete;
import br.com.caelum.vraptor.Get;
import br.com.caelum.vraptor.Path;
import br.com.caelum.vraptor.Post;
import br.com.caelum.vraptor.Put;
import br.com.caelum.vraptor.Resource;
import br.com.caelum.vraptor.Result;
import br.com.caelum.vraptor.view.Results;

@Resource
public class <@className/> {

	private Result result;
	private EntityManager entityManager;
	
	public <@className/>(Result result, EntityManager entityManager) {
		this.entityManager = entityManager;
		this.result = result;
	}
	
	@Get
	@Path(${pluralClass}})
	public List<${class?cap_first}> index() {
		return entityManager.createQuery("from ${class?cap_first}").getResultList();
	}
}

<#macro className>
${class?cap_first}Controller
</#macro> 