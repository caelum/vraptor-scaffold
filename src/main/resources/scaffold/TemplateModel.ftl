package app.models;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class ${class?cap_first} {

	@Id
	private Long id;
	<@generate_attributes />
	
	public void setId(Long id) {
		this.id = id;
	}

	public Long getId() {
		return id;
	}
	
	<@generate_getters_setters/>
}

<#macro generate_attributes>
	<#list attributes as attribute>
  	private ${attribute.type?cap_first} ${attribute.name};
	</#list> 
</#macro>

<#macro generate_getters_setters>
	<#list attributes as attribute>
	public void set${attribute.name?cap_first}(${attribute.type?cap_first} ${attribute.name}) {
		this.${attribute.name} = ${attribute.name};
	}

	public ${attribute.type?cap_first} get${attribute.name?cap_first}() {
		return ${attribute.name};
	}
	</#list>
</#macro>