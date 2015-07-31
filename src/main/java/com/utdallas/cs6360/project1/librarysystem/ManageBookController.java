/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * @author Rahul
 *
 */

@Controller
public class ManageBookController {
	
	@Autowired
	ManageBookService bookService;

	private static final Logger logger = Logger.getLogger(ManageBookController.class);
	
	   @RequestMapping("/app/searchbook")
	   public String searchBook(@RequestParam("book_id") String book_id,
			   @RequestParam("title") String title,
			   @RequestParam("author_name") String author_name,ModelMap model) {
	      List<Book> books = bookService.searchBooks(book_id,title,author_name);
	      model.addAttribute("books", books);
	      model.addAttribute("book_id", book_id);
	      model.addAttribute("title", title);
	      model.addAttribute("author_name", author_name);
	      return "search";
	   }
	   
	   @RequestMapping("/app/checkoutbook")
	   public String checkoutBook(@RequestParam("d_bookId") String book_id,
			   @RequestParam("d_branchId") String branchId,
			   @RequestParam("d_cardNo") String cardNo,
			   @RequestParam("d_dueDate") String dueDate,
			   @RequestParam("d_dateOut") String dateOut,
			   
			   
			   ModelMap model) throws ParseException {
	  
		   SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			  Date dueDate1 = format.parse(dueDate);
			  Date dateOut1 = format.parse(dateOut);
			  int result =0;
		try{
			result = bookService.checkOutBook(book_id,branchId,cardNo,dueDate1,dateOut1);
		}catch(Exception e){
			result =3;
		}
	      
	      logger.debug(book_id + "  " + cardNo);
	      model.addAttribute("result", result);
	      model.addAttribute("book_id", book_id);
	      model.addAttribute("branchId", branchId);
	      model.addAttribute("cardNo", cardNo);
	      
	      List<Book> books = bookService.searchBooks("","","");
	      model.addAttribute("books", books);
	      return "search";
	   }
	   
	   @RequestMapping("/app/searchbookloan")
	   public String searchBookLoan(@RequestParam("book_id") String book_id,
			   @RequestParam("card_no") String card_no,
			   @RequestParam("borrower_name") String borrower_name,ModelMap model) {
		   
		  List<BookLoan> bookLoans = bookService.searchBookLoans(book_id, card_no, borrower_name);
	      model.addAttribute("bookLoans", bookLoans);
	      model.addAttribute("book_id", book_id);
	      model.addAttribute("card_no", card_no);
	      model.addAttribute("borrower_name", borrower_name);
	      logger.debug(book_id + "  " + borrower_name);
	      return "loansearch";
	   }
	   
	   @RequestMapping("/app/bookcheckin")
	   public String bookCheckin(@RequestParam("d_loanId") String loan_id,
			   @RequestParam("dateIn") String dateIn, ModelMap model) throws ParseException {
		  SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		  Date date = format.parse(dateIn);
		  int result = 0;
		  try{
			  result = bookService.checkInBook(loan_id, date);  
		  }catch(Exception e){
			  result = 0;
		  }
		  
		  model.addAttribute("result", result);

		  List<BookLoan> bookLoans = bookService.searchBookLoans("", "", "");
	      model.addAttribute("bookLoans", bookLoans);
		  return "loansearch";
	   }
	   
	   @RequestMapping("/app/managemyfines")
	   public String manageFines(@RequestParam("card_no") String card_no,
			   @RequestParam("borrower_name") String borrower_name,ModelMap model) {
	     
	      List<User> users = bookService.searchUserWithFines(card_no, borrower_name);
	      logger.debug(card_no + "  size = " + users.size());
	      model.addAttribute("message", users.size() + " == Hello 1 MVC Framework!");
	      model.addAttribute("userList", users);
	      return "managefines";
	   }
	   
	   @RequestMapping("/app/updatefines")
	   public String updateFines(ModelMap model) {
	     
	      int result = bookService.updateFines();
	      List<User> users = bookService.searchUserWithFines("", "");
	      model.addAttribute("userList", users);	      
	      model.addAttribute("result", result);
	      return "managefines";
	   }
	   
	   @RequestMapping("/app/payment")
	   public String payment(@RequestParam("d_loanId1") String loan_id,ModelMap model) {
	     
	      int result = bookService.confirmPayment(loan_id);
	      if(result == 1){
	    	  result = 4;
	      }else if(result == 0){
	    	  result = 5;
	      }
	      List<BookLoan> bookLoans = bookService.searchBookLoans("", "", "");
	      model.addAttribute("bookLoans", bookLoans);
	      model.addAttribute("result", result);
	      return "loansearch";
	   }
	   
}
