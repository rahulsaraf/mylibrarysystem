/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

import java.util.Date;

/**
 * @author Rahul
 *
 */
public class Book {

	private String book_id;
	private int branch_id;
	private String bookTitle;
	private String branchName;
	private String authorName;
	private int noOfCopies;
	private int noOfAvailableCopies;
	public String getBook_id() {
		return book_id;
	}
	public void setBook_id(String book_id) {
		this.book_id = book_id;
	}
	public int getBranch_id() {
		return branch_id;
	}
	public void setBranch_id(int branch_id) {
		this.branch_id = branch_id;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	public String getAuthorName() {
		return authorName;
	}
	public void setAuthorName(String authorName) {
		this.authorName = authorName;
	}
	public int getNoOfCopies() {
		return noOfCopies;
	}
	public void setNoOfCopies(int noOfCopies) {
		this.noOfCopies = noOfCopies;
	}
	public int getNoOfAvailableCopies() {
		return noOfAvailableCopies;
	}
	public void setNoOfAvailableCopies(int noOfAvailableCopies) {
		this.noOfAvailableCopies = noOfAvailableCopies;
	}
	
	
}
