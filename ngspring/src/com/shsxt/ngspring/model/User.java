package com.shsxt.ngspring.model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collection="user")
public class User {
	@Id
	private String id;
	
	private String username;
	
	private String address;
	
	private String email;
	
	public User() {
		// TODO Auto-generated constructor stub
	}
	public User(String id, String username, String address, String email) {
		super();
		this.id = id;
		this.username = username;
		this.address = address;
		this.email = email;
	}
	

	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	
}
