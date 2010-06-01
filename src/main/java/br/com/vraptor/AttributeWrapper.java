package br.com.vraptor;

public class AttributeWrapper {
	
	private String name;
	private String type;

	public AttributeWrapper(String name, String type) {
		this.name = name;
		this.type = type;
	}

	public String getName() {
		return name;
	}

	public String getType() {
		return type;
	}
}