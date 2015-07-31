/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Rahul
 *
 */
@Service
public class ManageUserDao {

	@Autowired
	DBConnector connector;
	
	public int createNewUser(User user){
		 String SQL = "INSERT INTO librarysystem.borrowers(card_no, fname, lname, address, city, state, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
		 return connector.getJdbcTemplateObject().update( SQL, user.getCardNo(), user.getFname(),user.getLname(),user.getAddress(),user.getCity(),user.getState(),user.getPhone());		
	}
	
	public List<User> searchUser(String cardNo, String name){
		String SQL;
		List<User> users = new ArrayList<User>();
		if(cardNo.isEmpty() && name.isEmpty()){
			SQL = "SELECT * FROM librarysystem.borrowers";
			users = connector.getJdbcTemplateObject().query(SQL, new UserMapper());
		}else if(!cardNo.isEmpty() && name.isEmpty()){
			SQL = "SELECT * FROM librarysystem.borrowers WHERE card_no = ?";
			users = connector.getJdbcTemplateObject().query(SQL,new Object[]{cardNo}, new UserMapper());
		}else if(cardNo.isEmpty() && !name.isEmpty()){
			if(name.split(" ").length == 2){
				String fname = name.split(" ")[0];
				String lname = name.split(" ")[1];
				SQL = "SELECT * FROM librarysystem.borrowers WHERE fname like ? and lname like ?";
				users = connector.getJdbcTemplateObject().query(SQL,new Object[]{fname,lname}, new UserMapper());
			}else{
				String fname = name.split(" ")[0];
				SQL = "SELECT * FROM librarysystem.borrowers WHERE fname like ? or lname like ?";
				users = connector.getJdbcTemplateObject().query(SQL,new Object[]{fname,fname}, new UserMapper());
			}
			
		}else {
			String fname = name.split(" ")[0];
			String lname = name.split(" ")[1];
			SQL = "SELECT * FROM librarysystem.borrowers WHERE card_no = ? and fname like ? and lname like ?";
			users = connector.getJdbcTemplateObject().query(SQL,new Object[]{cardNo,fname,lname }, new UserMapper());
		}		
		return users;
	}
	
	public boolean checkIfUserExists(User user){
		String SQL = "SELECT COUNT(*) FROM librarysystem.borrowers WHERE UPPER(fname) = ? AND UPPER(lname) = ? AND UPPER(address) = ? AND UPPER(city) = ? AND UPPER(state) = ?";
		int result = connector.getJdbcTemplateObject().queryForInt(SQL, user.getFname(),user.getLname(),user.getAddress(),user.getCity(),user.getState());
		return result == 0 ? false : true;
	}
}
