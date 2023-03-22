package cust.slei.rbac.domain;

import lombok.Data;

@Data
public class User{

	private String username;
	
	private String password;
	
	private String name;

	private String classNumber;

	private String email;

	private String job;

	private String phone;
}
