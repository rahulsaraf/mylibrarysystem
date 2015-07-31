package com.utdallas.cs6360.project1.librarysystem;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

public class BookMapper implements RowMapper<Book>{

	@Override
	public Book mapRow(ResultSet rs, int arg1) throws SQLException {
		Book book = new Book();
		book.setBook_id(rs.getString("book_id"));
		book.setBranch_id(rs.getInt("branch_id"));
		book.setBookTitle(rs.getString("title"));
		book.setBranchName(rs.getString("branch_name"));
		book.setAuthorName(rs.getString("author"));
		book.setNoOfCopies(rs.getInt("no_of_copies"));
		book.setNoOfAvailableCopies(rs.getInt("available_copies"));
		return book;
	}
}
