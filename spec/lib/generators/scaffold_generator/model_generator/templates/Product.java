package app.models;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
public class Product {

	@Id @GeneratedValue
	private Long id;
	
	private String name;
	private boolean flag;
  
	public void setId(Long id) {
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	
	public boolean getFlag() {
		return flag;
	}
	
}
