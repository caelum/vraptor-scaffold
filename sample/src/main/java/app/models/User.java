package app.models;

import javax.persistence.Column;

import org.hibernate.validator.constraints.Email;

@javax.persistence.Entity
public class User extends Entity {
	
	private String name;
	
	@Email @Column(unique = true)
	private String email;
	
	private String password;
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getName() {
		return name;
	}
	
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	public String getEmail() {
		return email;
	}
}