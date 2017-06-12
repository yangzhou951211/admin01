package com.shsxt.ngspring.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicLong;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.shsxt.ngspring.model.User;
import com.shsxt.ngspring.service.IUserService;
@Service("userService")
public class UserServiceImpl implements IUserService {
	@Autowired
	private MongoTemplate mongoTemplate;
	/**
	 * 查找所有
	 */
	@Override
	public Map<String, Object> fetchAllUsers() {
		List<User>	users=mongoTemplate.find(new Query(), User.class);
		Map<String, Object> result = new HashMap<String, Object>();
		if(users == null){
			result.put("resultData", null);
			result.put("resultCode", HttpStatus.NO_CONTENT);
			return result;
		}
		result.put("resultData", users);
		result.put("resultCode", HttpStatus.OK);
		return result;
	}
	/**
	 * 判断用户名是否已存在
	 * @param user
	 * @return
	 */
	public boolean isUserExsit(User user){
		//将所有已存在的记录查询出来，与传过来的用户名称作对比。若存在，则返回false，否则返回true
		List <User> users=mongoTemplate.find(new Query(), User.class);
		for(int i=0;i<users.size();i++){
			if(users.get(i).getUsername().equalsIgnoreCase(user.getUsername())){
				return true;
			}
		}
		/*for(User u:users){
			if(u.getUsername().equalsIgnoreCase(user.getUsername())){
				return true;
			}
		}*/
		return false;
	}
	
	/**
	 * 新增用户
	 */
	@Override
	public Map<String, Object> createUser(User user) {
		Map<String,Object> result = new HashMap<String,Object>();
		if(isUserExsit(user)){
			result.put("resultCode", HttpStatus.CONFLICT);
			result.put("message", "新增的用户名已存在");
			return result;
		}
		//若用"户名不存在，则新增
		mongoTemplate.insert(user);
		result.put("resultCode", HttpStatus.OK);
		result.put("message", "添加成功");
		return result;
	}
	
	/**
	 * 修改用户
	 */
	@Override
	public Map<String, Object> updateUser(User user) {
		Map<String,Object> result = new HashMap<String,Object>();
		//判断修改的用户名是否存在,需要与除本身以外的所有用户名进行相比
		Criteria crite= Criteria.where("id").ne(user.getId());
		Query que=new Query(crite);
		List<User>list=mongoTemplate.find(que, User.class);
		for(int i=0;i<list.size();i++){
			if(list.get(i).getUsername().equalsIgnoreCase(user.getUsername())){
				result.put("resultCode", HttpStatus.CONFLICT);
				result.put("message", "修改的用户名已存在");
				return result;
			}
		}
		//创建条件
		Criteria criteria=Criteria.where("id").is(user.getId());
		//创建标准
		Query query=new Query(criteria);
		//创建修改项
		Update update=Update.update("username", user.getUsername()).set("address", user.getAddress()).set("email", user.getEmail());
		mongoTemplate.updateFirst(query, update, User.class);
		result.put("resultCode", HttpStatus.OK);
		result.put("message", "修改成功");
		return result;
	}
	
	/**
	 * 删除用户
	 */
	@Override
	public Map<String, Object> deleteUser(String id) {
		Map<String,Object> result = new HashMap<String,Object>();
		if(id == null){
			result.put("resultCode", HttpStatus.NOT_FOUND);
			result.put("message", "要删除的用户不存在");
			return result;
		}
		//创建条件
		Criteria criteria=Criteria.where("id").is(id);
		//创建查询标准
		Query query=new Query(criteria);
		mongoTemplate.remove(query, User.class);
		result.put("resultCode", HttpStatus.OK);
		result.put("message", "删除成功");
		return result;
	}
}
