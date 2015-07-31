
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
<title>Check-out Books</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('#navigationBar').load('header.html');
    });
    
    function alertme(index) {
		console.log("here");

		/* var index = $('#checkbutton').val(); */

		var book_id = window.document.getElementById("book_id" + index).textContent;
		var title = window.document.getElementById("title" + index).textContent;
		var branch_id = window.document.getElementById("branch_id" + index).textContent;
		var branchName = window.document.getElementById("branchName" + index).textContent;
		var dateOut = new Date();
		var dueDate = new Date();
		dueDate.setDate(dateOut.getDate() + 14);
		console.log(book_id + " " + title + " " + branch_id + " " + branchName
				);
		console.log(dueDate);
		$('#d_bookId1').val(book_id);
		$('#d_bookId2').val(book_id);
		$('#d_branchId1').val(branch_id);
		$('#d_branchId2').val(branch_id);
		$('#d_branchName').val(branchName);
		$('#d_title').val(title);
		$('#d_dateOut').val(dateOut);
		$('#d_dueDate').val(dueDate);
		
	}
    
</script>
</head>
<body >
	<div class="container">
		<div class="container" id="navigationBar"></div>
		
		<div id="errorMessage">
		<c:choose>
			<c:when test="${result == 0}">
			    <div class="alert alert-danger fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Error!</strong> Cardholder (Card No = <c:out value="${cardNo}"></c:out>) reached maximum checkout limit (3 Books).
    			</div>
    		</c:when>
    		<c:when test="${result == 1}">
    			<div class="alert alert-success fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Success!</strong> Successful checkout of book (ID = <c:out value="${book_id}"></c:out> ) for user (Card No = <c:out value="${cardNo}"></c:out> )
    			</div>
    		</c:when>
    		<c:when test="${result == 2}">
			    <div class="alert alert-danger fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Error!</strong> Book (ID = <c:out value="${book_id}"></c:out>) is not available for checkout.
    			</div>
    		</c:when>
    	</c:choose>
    		
		</div>
		
		
		<div class="container row">
			<div class="well bs-component">
				<form class="form-horizontal" name="searchbook" action="searchbook"
					method="POST">
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
								<label for="title" class="col-lg-2 control-label">Title
									:</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="title" name="title"
										placeholder="Title of the book" value="${title}">
								</div>
							</div>
							<div class="form-group">
								<label for="author_name" class="col-lg-2 control-label">Author
									Name :</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="author_name"
										name="author_name" placeholder="Author of the book" value="${author_name}">
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-10 col-lg-offset-2">
									<button type="reset" class="btn btn-default">Cancel</button>
									<button type="submit" class="btn btn-primary">Search
										Books</button>
								</div>
							</div>
						</div>
					</fieldset>
				</form>
				<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th>Book ID</th>
							<th>Title</th>
							<th>Authors</th>
							<th>Branch ID</th>
							<th>Branch Name</th>
							<th>Total Copies</th>
							<th>Available Copies</th>
							<th>Check-out</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${books}" var="book" varStatus="booksIndex">
							<tr>
								<td id="book_id${booksIndex.index}"><c:out
										value="${book.book_id}" /></td>
								<td id="title${booksIndex.index}"><c:out
										value="${book.bookTitle}" /></td>
								<td><c:out value="${book.authorName}" /></td>
								<td id="branch_id${booksIndex.index}"><c:out
										value="${book.branch_id}" /></td>
								<td id="branchName${booksIndex.index}"><c:out
										value="${book.branchName}" /></td>
								<td><c:out value="${book.noOfCopies}" /></td>
								<td><c:out value="${book.noOfAvailableCopies}" /></td>
								<c:choose>
									<c:when test="${book.noOfAvailableCopies == 0}">
										<td><button type="button" class="btn btn-danger btn-xs"
												onclick="alertme()">
												<span class="glyphicon glyphicon-ban-circle"
													aria-hidden="true"></span>
											</button></td>
									</c:when>
									<c:otherwise>
										<td><button id="checkbutton" type="button"
												class="btn btn-success btn-xs" data-toggle="modal"
												data-target="#checkout" value="${booksIndex.index}"
												onclick="alertme(${booksIndex.index})">
												<span class="glyphicon glyphicon-shopping-cart"
													aria-hidden="true"></span>
											</button></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				</div>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="checkout" role="dialog">
			<div class="modal-dialog" role="document">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Check-Out a Book</h4>
					</div>
					<div class="modal-body">
						<p>Please enter following information in order to check-out
							this book</p>
						<form class="form-horizontal" name="checkoutbook"
							action="checkoutbook" method="GET">
							<fieldset>
								<legend> </legend>
								<div id="criteria">

									<div class="form-group">
										<label for="bookId" class="col-lg-3 control-label">Book
											ID :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_bookId1"
												disabled="disabled"> 
											<input type="hidden"
												class="form-control" id="d_bookId2" name="d_bookId">
										</div>
									</div>
									<div class="form-group">
										<label for="branchId" class="col-lg-3 control-label">Branch
											ID :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_branchId1"
												disabled="disabled"> <input type="hidden"
												class="form-control" id="d_branchId2" name="d_branchId">
										</div>
									</div>
									<div class="form-group">
										<label for="bookId" class="col-lg-3 control-label">Branch
											Name :</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_branchName"
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
										<label for="cardNo" class="col-lg-3 control-label">Card
											No <span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="d_cardNo"
												name="d_cardNo" required>
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