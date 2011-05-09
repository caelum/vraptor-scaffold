package app.model;

@javax.persistence.Entity
public class Product extends Entity {
	
	private String name;
	private boolean myFlag;
	
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
