package app.model;

import java.math.BigDecimal;
import javax.persistence.ManyToOne;

@javax.persistence.Entity
public class Product extends Entity {
	
	private String name;
	private boolean myFlag;
	private BigDecimal price;
	@ManyToOne
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
	
	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	public BigDecimal getPrice() {
		return price;
	}
	
	public void setCategory(Category category) {
		this.category = category;
	}
	
	public Category getCategory() {
		return category;
	}
	
}
