package com.shsxt.ngspring.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.shsxt.ngspring.model.User;

public interface IUserService {
	//查找所有
	public Map<String,Object> fetchAllUsers();
	//新增用户
	public Map<String,Object> createUser(User user);
	//修改用户
	public Map<String,Object> updateUser(User user );
	//删除用户
	public Map<String,Object> deleteUser(String id);
}
