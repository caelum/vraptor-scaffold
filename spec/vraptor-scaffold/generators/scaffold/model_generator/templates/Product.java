package app.model;

@javax.persistence.Entity
public class Product extends Entity {

	private String name;
	private boolean myFlag;
	private Double price;
	private Category category;

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

	public void setPrice(Double price) {
		this.price = price;
	}

	public Double getPrice() {
		return price;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Category getCategory() {
		return category;
	}

}
