package br.com.vraptor;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class TemplateModel {
	
	@Id
	private Long id;

	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}
}