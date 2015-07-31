/**
 * 
 */
package com.utdallas.cs6360.project1.librarysystem;

/**
 * @author Rahul
 *
 */
public class User {
	private String cardNo;
	private String fname;
	private String lname;
	private String address;
	private String city;
	private String state;
	private String phone;
	private int noOFBookLoans;
	private double totalFineAmt;
	
	
	
	public int getNoOFBookLoans() {
		return noOFBookLoans;
	}
	public void setNoOFBookLoans(int noOFBookLoans) {
		this.noOFBookLoans = noOFBookLoans;
	}
	public double getTotalFineAmt() {
		return totalFineAmt;
	}
	public void setTotalFineAmt(double totalFineAmt) {
		this.totalFineAmt = totalFineAmt;
	}
	public String getCardNo() {
		return cardNo;
	}
	public void setCardNo(String cardNo) {
		this.cardNo = cardNo;
	}
	public String getFname() {
		return fname;
	}
	public void setFname(String fname) {
		this.fname = fname;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	
}
