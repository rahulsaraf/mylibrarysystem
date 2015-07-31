/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

/**
 * @author Rahul
 *
 */
public class UserMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int arg1) throws SQLException {
		User user = new User();
		user.setCardNo(String.valueOf(rs.getInt("card_no")));
		user.setFname(rs.getString("fname"));
		user.setLname(rs.getString("lname"));
		user.setAddress(rs.getString("address"));
		user.setCity(rs.getString("city"));
		user.setState(rs.getString("state"));
		user.setPhone(rs.getString("phone"));
		return user;
	}

}
