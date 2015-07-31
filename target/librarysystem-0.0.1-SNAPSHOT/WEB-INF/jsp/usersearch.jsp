
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
<title>Borrower Management</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#navigationBar').load('header.html');
	});
	
	function validate(){
		if($('#fname').val() == null){
			$('#fname').addClass("bg-danger");
		}
	}
</script>

</head>
<body background="/WEB-INF/jsp/images.jpg">
	<div class="container">
		<div class="container" id="navigationBar"></div>
		<div id="errorMessage">
		<c:choose>
			<c:when test="${result == 0}">
			    <div class="alert alert-danger fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Error!</strong> Cardholder ( <c:out value="${lname}"></c:out>, <c:out value="${fname}"></c:out>) already exists in system.
    			</div>
    		</c:when>
    		<c:when test="${result == 1}">
    			<div class="alert alert-success fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Success!</strong> ( <c:out value="${lname}"></c:out>, <c:out value="${fname}"></c:out>) successfully created in system.
    			</div>
    		</c:when>
    	</c:choose>
    		
		</div>
		<div class="container row">
			<div class="well bs-component">
				<form class="form-horizontal" name="searchusers"
					action="searchusers" method="POST">
					<fieldset>
						<legend>
							<button type="button" class="btn btn-default"
								data-toggle="collapse" data-target="#criteria">
								<span class="glyphicon glyphicon-menu-hamburger"
									aria-hidden="true"></span> Collapse Query Criteria
							</button>
							<button type="button" class="btn btn-primary" data-toggle="modal"
								data-target="#createNewUser">
								<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
								Create New User
							</button>

						</legend>




						<div id="criteria">

							<div class="form-group">
								<label for="card_no" class="col-lg-2 control-label">Borrower's
									Card No :</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="card_no"
										name="card_no" placeholder="Borrower Card Number">
								</div>
							</div>
							<div class="form-group">
								<label for="borrower_name" class="col-lg-2 control-label">Borrower's
									Name :</label>
								<div class="col-lg-10">
									<input type="text" class="form-control" id="borrower_name"
										name="borrower_name" placeholder="Name of the Borrower">
								</div>
							</div>
							<div class="form-group">
								<div class="col-lg-10 col-lg-offset-2">
									<button type="reset" class="btn btn-default">Cancel</button>
									<button type="submit" class="btn btn-primary">Search
										Users</button>
								</div>
							</div>
						</div>
					</fieldset>
				</form>

			<div class="table-responsive">
				<table class="table">
					<thead>
						<tr>
							<th>Card No</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>Address</th>
							<th>City</th>
							<th>State</th>
							<th>Phone</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList}" var="user">
							<tr>
								<td><c:out value="${user.cardNo}" /></td>
								<td><c:out value="${user.fname}" /></td>
								<td><c:out value="${user.lname}" /></td>
								<td><c:out value="${user.address}" /></td>
								<td><c:out value="${user.city}" /></td>
								<td><c:out value="${user.state}" /></td>
								<td><c:out value="${user.phone}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>

			</div>
		</div>

		<!-- Modal -->
		<div class="modal fade" id="createNewUser" role="dialog">
			<div class="modal-dialog" role="document">

				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Create New User</h4>
					</div>
					<div class="modal-body">
						<p>Please enter following information in order to create a new
							user</p>
						<form class="form-horizontal" name="createnewuser"
							action="createnewuser" method="POST">
							<fieldset>
								<legend> </legend>
								<div id="criteria">

									<div class="form-group">
										<label for="fname" class="col-lg-3 control-label">First
											Name <span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="fname"
												name="fname" placeholder="Enter First Name" required>
										</div>
									</div>
									<div class="form-group">
										<label for="lname" class="col-lg-3 control-label">Last
											Name <span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="lname"
												name="lname" placeholder="Enter Last Name" required>
										</div>
									</div>
									<div class="form-group">
										<label for="address" class="col-lg-3 control-label">Address
											<span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="address"
												name="address" placeholder="Enter Address" required>
										</div>
									</div>
									<div class="form-group">
										<label for="city" class="col-lg-3 control-label">City
											<span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="city" name="city"
												placeholder="Enter City" required>
										</div>
									</div>
									<div class="form-group">
										<label for="state" class="col-lg-3 control-label">State
											<span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="state"
												name="state" placeholder="Enter State" required>
										</div>
									</div>
									<div class="form-group">
										<label for="phone" class="col-lg-3 control-label">Phone
											No <span class="text-danger">* </span>:</label>
										<div class="col-lg-8">
											<input type="text" class="form-control" id="phone"
												name="phone" placeholder="Enter Phone" required>
										</div>
									</div>
									<div class="modal-footer">
										<button type="Submit" class="btn btn-primary" onclick="validate()">Submit</button>
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