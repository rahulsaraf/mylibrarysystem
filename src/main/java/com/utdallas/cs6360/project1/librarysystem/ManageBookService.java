/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Rahul
 *
 */
@Service
public class ManageBookService {

	@Autowired
	ManageBookDao bookDao;
	
	static int MAX_LIMIT_ALLOWED = 3;
	
	
	public List<BookLoan> searchBookLoans(String book_id, String card_no, String borrower_name){
		return bookDao.searchBookLoans(book_id,card_no, borrower_name);
	}

	public List<User> searchUserWithFines(String card_no, String borrower_name){
		return bookDao.searchUserWithFines(card_no, borrower_name);
	}
	
	
	public int checkInBook(String loan_id, Date date) {
		return bookDao.checkInBook(loan_id,date);
		
	}


	public List<Book> searchBooks(String book_id, String title,
			String author_name) {
	 return bookDao.searchBooks(book_id,title, author_name);
	}


	public int checkOutBook(String book_id, String branchId, String cardNo, Date dueDate1, Date dateOut1) {
		List<Book> books = bookDao.searchBooks(book_id, "", "");
		
		for (Book book : books) {
			if(book.getBranch_id() == Integer.valueOf(branchId)){
				if(book.getNoOfAvailableCopies() <= 0){
					return 2;
				}
				
			}
		}
		
		if(bookDao.getNoOfBookLoansForCard(cardNo) != MAX_LIMIT_ALLOWED){
			return bookDao.checkOutBook(book_id,branchId, cardNo,dueDate1,dateOut1);
		}else{
			return 0;
		}
	}

	public int updateFines() {
		List<BookLoan> loans = bookDao.searchBookLoans("","","");
		Date today = new Date();double fine=0.0;
		int result = 0;
		
		Calendar cal1 = Calendar.getInstance();
		Calendar cal2 = Calendar.getInstance();
		for (BookLoan bookLoan : loans) {
			if(bookLoan.getDate_in() == null){
				if(bookLoan.getDue_date().before(today)){
					cal1.setTime(today);
					cal2.setTime(bookLoan.getDue_date());
					int diff = cal1.get(Calendar.DAY_OF_YEAR) - cal2.get(Calendar.DAY_OF_YEAR);
					fine = diff* 0.25;
					result = result + bookDao.updatefine(bookLoan.getLoan_id(),fine);
					
					if(bookDao.updatefine(bookLoan.getLoan_id(),fine) == 0){
						result = result + bookDao.insertFine(bookLoan.getLoan_id(),fine);
					}
				}
			}
			else if(bookLoan.getDue_date().before(bookLoan.getDate_in())){
				cal1.setTime(bookLoan.getDate_in());
				cal2.setTime(bookLoan.getDue_date());
				int diff = cal1.get(Calendar.DAY_OF_YEAR) - cal2.get(Calendar.DAY_OF_YEAR);
				fine = diff* 0.25;
				result = result + bookDao.updatefine(bookLoan.getLoan_id(),fine);
				
				if(bookDao.updatefine(bookLoan.getLoan_id(),fine) == 0){
					result = result + bookDao.insertFine(bookLoan.getLoan_id(),fine);
				}			
			}
			
		}
		return result;
	}

	public int confirmPayment(String loan_id) {
		BookLoan loan = bookDao.getBookLoan(loan_id);
		if(null == loan.getDate_in()){
			return 6;
		}
		return bookDao.updatefine(loan_id);
	}
	
}
