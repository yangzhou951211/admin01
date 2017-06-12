package com.shsxt.ngspring.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.shsxt.ngspring.model.User;
import com.shsxt.ngspring.service.IUserService;

@RestController
@RequestMapping("user")
public class UserController {
	@Autowired
	private IUserService userService;
	
	/**
	 * 查找所有
	 */
	@RequestMapping(value = "fetchAllUsers" , method = RequestMethod.GET)
	public ResponseEntity<Map<String,Object>> fetchAllUsers(){
		Map<String,Object> result = userService.fetchAllUsers();
		HttpStatus httpStatus = (HttpStatus)result.get("resultCode");
		return new ResponseEntity<Map<String,Object>>(result,httpStatus);
	}
	
	/**
	 * 新增用户
	 * @RequestBody请求体  代表接收过来的数据是json格式的字符串，其会动态绑定到第一个对应的属性值 上   
	 * @ResponseBody 响应体   只返回数据，不跳转页面。会返回一个json格式的字符串
	 */
	@RequestMapping(value = "add" , method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> createUser(@RequestBody User user){
		Map<String,Object> result = userService.createUser(user);
		HttpStatus httpStatus = (HttpStatus)result.get("resultCode");
		return new ResponseEntity<Map<String,Object>>(result,httpStatus);
	}
	
	/**
	 * 修改用户
	 */
	@RequestMapping(value = "update" , method = RequestMethod.POST)
	public ResponseEntity<Map<String,Object>> updateUser(@RequestBody User user){
		Map<String,Object> result = userService.updateUser(user);
		HttpStatus httpStatus = (HttpStatus)result.get("resultCode");
		return new ResponseEntity<Map<String,Object>>(result,httpStatus);
	}
	
	/**
	 * 删除用户
	 */
	@RequestMapping(value = "delete/{id}" , method = RequestMethod.DELETE)
	public ResponseEntity<Map<String,Object>> deleteUser(@PathVariable("id") String id){
		Map<String,Object> result = userService.deleteUser(id);
		HttpStatus httpStatus = (HttpStatus)result.get("resultCode");
		return new ResponseEntity<Map<String,Object>>(result,httpStatus);
	} 
}
