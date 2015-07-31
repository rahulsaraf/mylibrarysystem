/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Rahul
 *
 */
@Service
public class ManageBookDao{
	
	@Autowired
	DBConnector connector;
	
	public List<BookLoan> searchBookLoans(String book_id, String cardNo, String borrower_name){
		String SQL;
		SQL = "SELECT A.loan_id, A.book_id, C.branch_id, D.card_no, date_out, due_date, date_in,branch_name,title,fine_amt,paid "
				+ "FROM librarysystem.book_loan A "
				+ "INNER JOIN librarysystem.book B  ON A.BOOK_ID = B.BOOK_ID "
				+ "INNER JOIN librarysystem.library_branch C ON C.BRANCH_ID = A.BRANCH_ID "
				+ "INNER JOIN librarysystem.borrowers D ON D.card_no = A.card_no "
				+ "LEFT JOIN librarysystem.fines E ON E.loan_id = A.loan_id ";
		List<BookLoan> bookLoans = new ArrayList<BookLoan>();
		if(book_id.isEmpty() && cardNo.isEmpty() && borrower_name.isEmpty()){
			SQL = SQL + "ORDER BY A.loan_id;";
			bookLoans = connector.getJdbcTemplateObject().query(SQL, new BookLoanMapper());
		}else {
			List params = new ArrayList();
			SQL = SQL + " WHERE";
			if(!borrower_name.isEmpty()){
				if(borrower_name.trim().split(" ").length == 2){
				 String fname =borrower_name.trim().split(" ")[0];
				 String lname =borrower_name.trim().split(" ")[1];
				 params.add(fname);
				 params.add(lname);
				 SQL = SQL + " (D.fname like ? AND D.lname like ?) ";
				}else{
				 SQL = SQL + " (D.fname like ? OR D.lname like ?) ";
				 params.add(borrower_name);
				 params.add(borrower_name);
				}
			}
			if(!book_id.isEmpty()){
				if(params.size() != 0){
					SQL = SQL + " AND A.book_id = ?";
					params.add(book_id);
				}else{
					SQL = SQL + " A.book_id = ?";
					params.add(book_id);
				}
			}
			
			if(!cardNo.isEmpty()){
				
				if(params.size() == 3){
					SQL = SQL + " AND D.card_no = ? ";
					params.add(cardNo);
				}else if(params.size() == 2){
					SQL = SQL + " AND D.card_no = ? ";
					params.add(cardNo);
				}else if(params.size() == 1){
					SQL = SQL + " AND D.card_no = ? ";
					params.add(cardNo);
				}else{
					SQL = SQL + " D.card_no = ? ";
					params.add(cardNo);
				}
			}
			SQL = SQL + "  ORDER BY A.loan_id";
			 bookLoans = connector.getJdbcTemplateObject().query(SQL,params.toArray(), new BookLoanMapper());
		}
		return bookLoans;
	}

	public List<User> searchUserWithFines(String cardNo, String borrower_name){
		String SQL;
		SQL = "SELECT  D.card_no, D.fname, D.lname,COUNT(1) as no_of_loans,SUM(fine_amt)  as total_fine "
				+ "FROM librarysystem.book_loan A "
				+ "INNER JOIN librarysystem.book B  ON A.BOOK_ID = B.BOOK_ID "
				+ "INNER JOIN librarysystem.library_branch C ON C.BRANCH_ID = A.BRANCH_ID "
				+ "INNER JOIN librarysystem.borrowers D ON D.card_no = A.card_no "
				+ "LEFT JOIN librarysystem.fines E ON E.loan_id = A.loan_id "
				+ "WHERE E.paid = 0 "
				+ "";
		List<User> users = new ArrayList<User>();
		if(cardNo.isEmpty() && borrower_name.isEmpty()){
			SQL = SQL + "GROUP BY D.card_no;";
			users = connector.getJdbcTemplateObject().query(SQL, new FineMapper());
		}else {
			List params = new ArrayList();
			SQL = SQL + " AND ";
			if(!borrower_name.isEmpty()){
				if(borrower_name.trim().split(" ").length == 2){
				 String fname =borrower_name.trim().split(" ")[0];
				 String lname =borrower_name.trim().split(" ")[1];
				 params.add(fname);
				 params.add(lname);
				 SQL = SQL + " (D.fname like ? AND D.lname like ?)";
				}else{
				 SQL = SQL + " (D.fname like ? OR D.lname like ?) ";
				 params.add(borrower_name);
				 params.add(borrower_name);
				}
			}
			if(!cardNo.isEmpty()){
				
				if(params.size() == 2){
					SQL = SQL + " AND D.card_no = ? ";
					params.add(cardNo);
				}else if(params.size() == 1){
					SQL = SQL + " AND D.card_no = ? ";
					params.add(cardNo);
				}else{
					SQL = SQL + " D.card_no = ? ";
					params.add(cardNo);
				}
			}
			SQL = SQL +" GROUP BY D.card_no";
			 users = connector.getJdbcTemplateObject().query(SQL,params.toArray(), new FineMapper());
		}
		return users;
	}

	
	public int checkInBook(String loan_id, Date date) {
		String SQL = "UPDATE librarysystem.book_loan SET date_in = ? WHERE loan_id = ?";
		return connector.getJdbcTemplateObject().update(SQL, date,loan_id);
	}

	public List<Book> searchBooks(String book_id, String title,
			String author_name) {
		String SQL;
		SQL = "SELECT A.book_id,title,author,C.branch_id,branch_name,no_of_copies, "
				+ "CASE "
				+ "WHEN count IS NOT NULL "
				+ "THEN no_of_copies - count "
				+ "ELSE no_of_copies "
				+ "END available_copies FROM librarysystem.book A "
				+ "INNER JOIN librarysystem.books_authors B ON A.book_id = B.book_id "
				+ "INNER JOIN librarysystem.book_copies C ON A.book_id = C.book_id "
				+ "INNER JOIN librarysystem.library_branch D ON D.branch_id = C.branch_id "
				+ "LEFT JOIN (SELECT book_id,branch_id,count(*) as count FROM librarysystem.book_loan WHERE date_in is null GROUP BY book_id,branch_id) TEMP "
				+ "ON TEMP.book_id = A.book_id AND TEMP.branch_id = C.branch_id";
		List<Book> books = new ArrayList<Book>();
		if(book_id.isEmpty() && title.isEmpty() && author_name.isEmpty()){
			SQL = SQL + ";";
			books = connector.getJdbcTemplateObject().query(SQL, new BookMapper());
		}else {
			SQL = SQL + " WHERE ";
			List params = new ArrayList();
			if(!book_id.isEmpty()){
				SQL = SQL + " A.book_id = ? ";
				params.add(book_id);
			}
			if(!title.isEmpty()){
				if(params.size() == 1){
					SQL = SQL + " AND A.title like ? ";
				}else{
					SQL = SQL + " A.title like ? ";
				}
				params.add(title);
			}
			if(!author_name.isEmpty()){
				if(params.size() == 1 || params.size() == 2){
					SQL = SQL + " AND B.author like ? ";
				}else{
					SQL = SQL + " B.author like ? ";
				}
				params.add(author_name);
			}
			
			books = connector.getJdbcTemplateObject().query(SQL,params.toArray(), new BookMapper());
		}		
		return books;
	}

	public int getNoOfBookLoansForCard(String cardNo) {
		String SQL;
		SQL = "SELECT count(*) as count FROM librarysystem.book_loan WHERE card_no = ? and date_in is null;";
		return connector.getJdbcTemplateObject().queryForInt(SQL, cardNo);
	}

	public int checkOutBook(String book_id, String branchId, String cardNo, Date dueDate1, Date dateOut1) {
		String SQL;
		SQL = "INSERT INTO librarysystem.book_loan(book_id, branch_id, card_no, date_out, due_date) VALUES (?, ?, ?, ?, ?)";
		return connector.getJdbcTemplateObject().update( SQL, book_id,branchId,cardNo,dateOut1, dueDate1);
	}

	public int updatefine(int loan_id, double fine) {
		String SQL = "UPDATE librarysystem.fines SET fine_amt = ? WHERE loan_id = ?";
		return connector.getJdbcTemplateObject().update(SQL, fine,loan_id);
	}

	public int insertFine(int loan_id, double fine) {
		String SQL = "INSERT INTO librarysystem.fines(loan_id, fine_amt, paid) VALUES (?, ?, ?)";
		return connector.getJdbcTemplateObject().update(SQL, loan_id,fine,0);
	}

	public int updatefine(String loan_id) {
		String SQL = "UPDATE librarysystem.fines SET paid = ? WHERE loan_id = ?";
		return connector.getJdbcTemplateObject().update(SQL, 1,loan_id);
	}

	public BookLoan getBookLoan(String loan_id) {
		String SQL = "SELECT A.loan_id, A.book_id, C.branch_id, D.card_no, date_out, due_date, date_in,branch_name,title,fine_amt,paid "
				+ "FROM librarysystem.book_loan A "
				+ "INNER JOIN librarysystem.book B  ON A.BOOK_ID = B.BOOK_ID "
				+ "INNER JOIN librarysystem.library_branch C ON C.BRANCH_ID = A.BRANCH_ID "
				+ "INNER JOIN librarysystem.borrowers D ON D.card_no = A.card_no "
				+ "LEFT JOIN librarysystem.fines E ON E.loan_id = A.loan_id WHERE A.loan_id = ?"; 
		List<BookLoan> loan = connector.getJdbcTemplateObject().query(SQL,new Object[]{loan_id}, new BookLoanMapper());
		return loan.get(0);
	}

}
