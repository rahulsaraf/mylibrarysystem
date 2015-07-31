/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Rahul
 *
 */
@Service
public class ManageUserService {
	
	@Autowired
	ManageUserDao userDao;
	
	public int createNewUser(User user){
		
		if(!userDao.checkIfUserExists(user)){
			return userDao.createNewUser(user);	
		}else{
			return 0;	
		}
		
		 
	}
	
	public List<User> searchUsers(String card_no, String name){
		return userDao.searchUser(card_no, name);
	}

}
