package app.models;

@javax.persistence.Entity
public class Product extends Entity {
	
	private String name;
	private boolean flag;
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public void setFlag(boolean flag) {
		this.flag = flag;
	}
	
	public boolean isFlag() {
		return flag;
	}
	
}
