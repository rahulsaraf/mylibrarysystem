
<!DOCTYPE html>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://bootstrapjsp.org/" prefix="b"%>
<%@ include file="header.html"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script
	src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Check-In Books</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#navigationBar').load('header.html');
	});

	function alertme(index) {
		console.log("here11");

		var loan_id = window.document.getElementById("loan_id" + index).textContent;
		var title = window.document.getElementById("bookTitle" + index).textContent;
		var book_id = window.document.getElementById("book_id" + index).textContent;
		var date_out = window.document.getElementById("date_out" + index).textContent;
		var due_date = window.document.getElementById("due_date" + index).textContent;
		var dateIn = new Date();
		
		console.log(title + " " + loan_id + " " + book_id + " " + date_out
				+ " " + due_date);
		
		var datein1 = dateIn.getFullYear()+ '-' + (dateIn.getMonth() + 1) + '-' + dateIn.getDate();
		$('#d_loanId1').val(loan_id);
		$('#d_loanId2').val(loan_id);
		$('#d_title').val(title);
		$('#d_bookId').val(book_id);
		$('#d_dueDate').val(due_date);
		$('#d_dateOut').val(date_out);
		$('#d_dateIn').val(datein1);
	};
	
	function reset() {
		console.log("here11");
		$('#book_id').val("");
		$('#card_no').val("");
		$('#borrower_name').val("");
	}
</script>

</head>
<body>
	<div class="container">
		<div class="container" id="navigationBar"></div>
		<div id="errorMessage">
		<c:choose>
			<c:when test="${result == 0}">
			    <div class="alert alert-danger fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Error!</strong> Problem occurred while check-in the book, please check.
    			</div>
    		</c:when>
    		<c:when test="${result == 1}">
    			<div class="alert alert-success fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Success!</strong> Successful check-in of book.)
    			</div>
    		</c:when>
    	</c:choose>
    		
		</div>
		<div class="container row">
			<div class="well bs-component">
				<form class="form-horizontal" name="searchbookloan"
					action="searchbookloan" method="POST">
					<fieldset>
						<legend>
							<button type="button" class="btn btn-default"
								data-toggle="collapse" data-target="#criteria">
								<span class="glyphicon glyphicon-menu-hamburger"
									aria-hidden="true"></span> Collapse Query Criteria
							</button>
						</legend>
						<div id="criteria">
							<div class="form-group">
								<label for="book_id" class="col-lg-2 control-label">
									Book ID : </label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="book_id"
										name="book_id" placeholder="Book ID" value="${book_id}">
								</div>
							</div>
							<div class="form-group">
								<label for="card_no" class="col-lg-2 control-label">Borrower's
									Card No :</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="card_no"
										name="card_no" placeholder="Borrower Card Number" value="${card_no}">
								</div>
							</div>
							<div class="form-group">
								<label for="borrower_name" class="col-lg-2 control-label">Borrower's
									Name :</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="borrower_name"
										name="borrower_name" placeholder="Name of the Borrower" value="${borrower_name}">
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-10 col-lg-offset-2">
									<button id="cancelbutton" type="reset" class="btn btn-default" value="" onreset="reset()">Cancel</button>
									<button type="submit" class="btn btn-primary" >Search
										Book Loans</button>
								</div>
							</div>
						</div>
					</fieldset>
				</form>

				<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th>Loan ID</th>
							<th>Book ID</th>
							<th>Title</th>
							<th>Branch ID</th>
							<th>Branch Name</th>
							<th>Card No</th>
							<th>Date Out</th>
							<th>Due Date</th>
							<th>Date In</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bookLoans}" var="bookLoan" varStatus="loan">
							<tr>
								<td id="loan_id${loan.index}"><c:out
										value="${bookLoan.loan_id}" /></td>
								<td id="book_id${loan.index}"><c:out
										value="${bookLoan.book_id}" /></td>
								<td id="bookTitle${loan.index}"><c:out
										value="${bookLoan.bookTitle}" /></td>
								<td><c:out value="${bookLoan.branch_id}" /></td>
								<td><c:out value="${bookLoan.branchName}" /></td>
								<td><c:out value="${bookLoan.card_no}" /></td>
								<td id="date_out${loan.index}"><c:out
										value="${bookLoan.date_out}" /></td>
								<td id="due_date${loan.index}"><c:out
										value="${bookLoan.due_date}" /></td>
								<c:if test="${not empty bookLoan.date_in}">
									<td><c:out value="${bookLoan.date_in}" /></td>
								</c:if>
								<c:if test="${empty bookLoan.date_in}">
									<td><button id="checkbutton" type="button"
											class="btn btn-primary btn-xs" data-toggle="modal"
											data-target="#checkin" value="${loan.index}"
											onclick="alertme(${loan.index})">
											<span class="glyphicon glyphicon-check" aria-hidden="true"></span>
										</button></td>

								</c:if>
								<c:set var="selected" value="${loan.index}" />
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="checkin" role="dialog">
			<div class="modal-dialog" role="document">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Check-in Book</h4>
					</div>
					<div class="modal-body">
						<p>Please enter following information in order to Check-in
							below Book</p>
						<form class="form-horizontal" name="bookcheckin"
							action="bookcheckin" method="GET">
							<fieldset>
								<legend> </legend>
								<div id="criteria">

									<div class="form-group">
										<label for="loanId" class="col-lg-3 control-label">Loan
											ID :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_loanId1"
												disabled="disabled" >
												<input type="hidden" class="form-control" id="d_loanId2"
												name="d_loanId" hidden=true >
										</div>
									</div>
									<div class="form-group">
										<label for="bookId" class="col-lg-3 control-label">Book
											ID :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_bookId"
												disabled="disabled">
										</div>
									</div>
									<div class="form-group">
										<label for="title" class="col-lg-3 control-label">Title
											:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_title"
												disabled="disabled">
										</div>
									</div>
									<div class="form-group">
										<label for="dueDate" class="col-lg-3 control-label">Due
											Date :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_dueDate"
												disabled="disabled">
										</div>
									</div>
									<div class="form-group">
										<label for="dateOut" class="col-lg-3 control-label">Date
											Out :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_dateOut"
												disabled="disabled">
										</div>
									</div>
									<div class="form-group">
										<label for="dateIn" class="col-lg-3 control-label">Date
											In :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_dateIn"
												name="dateIn" placeholder="Enter Check-in Date">
										</div>
									</div>
									<div class="modal-footer">
										<button type="Submit" class="btn btn-primary">Submit</button>
										<button type="button" class="btn btn-default"
											data-dismiss="modal">Cancel</button>

									</div>
								</div>
							</fieldset>
						</form>
					</div>

				</div>



			</div>
		</div>

	</div>


</body>
</html>