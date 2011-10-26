package app.models;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class Product {

	@Id
	private Long id;
	private String name;
	private boolean myFlag;
	
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
	
	public void setMyFlag(boolean myFlag) {
		this.myFlag = myFlag;
	}
	
	public boolean isMyFlag() {
		return myFlag;
	}
	
}
