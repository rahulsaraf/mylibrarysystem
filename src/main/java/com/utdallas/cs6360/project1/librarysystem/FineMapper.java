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
public class FineMapper implements RowMapper<User>{

	@Override
	public User mapRow(ResultSet rs, int arg1) throws SQLException {
		User user = new User();
		user.setCardNo(String.valueOf(rs.getInt("card_no")));
		user.setFname(rs.getString("fname"));
		user.setLname(rs.getString("lname"));
		user.setNoOFBookLoans(rs.getInt("no_of_loans"));
		user.setTotalFineAmt(rs.getDouble("total_fine"));
		return user;
	}

}
