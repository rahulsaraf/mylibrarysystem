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
public class BookLoanMapper implements RowMapper<BookLoan>{

	@Override
	public BookLoan mapRow(ResultSet rs, int arg1) throws SQLException {
		BookLoan bookloan = new BookLoan();
		bookloan.setCard_no(rs.getInt("card_no"));
		bookloan.setLoan_id(rs.getInt("loan_id"));
		bookloan.setBook_id(rs.getString("book_id"));
		bookloan.setBranch_id(rs.getInt("branch_id"));
		bookloan.setBookTitle(rs.getString("title"));
		bookloan.setBranchName(rs.getString("branch_name"));
		if(null != rs.getString("date_in") && !rs.getString("date_in").isEmpty()){
			bookloan.setDate_in(rs.getDate("date_in"));
		}
		bookloan.setDate_out(rs.getDate("date_out"));
		bookloan.setDue_date(rs.getDate("due_date"));
		bookloan.setFine_amt(rs.getDouble("fine_amt"));
		bookloan.setPaid(rs.getBoolean("paid"));
		
		return bookloan;
	}

}
