
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
	        	No updates in Fines in system.
    			</div>
    		</c:when>
    		<c:when test="${result > 0}">
    			<div class="alert alert-success fade in">
	        	<a href="#" class="close" data-dismiss="alert">&times;</a>
	        	<strong>Success!</strong> Fines updates in System Successfully.
    			</div>
    		</c:when>
    	</c:choose>
    		
		</div>
		<div class="container row">
			<div class="well bs-component">
				<form class="form-horizontal" name="managemyfines"
					action="managemyfines" method="POST">
					<fieldset>
						<legend>
								<span> Fine Management</span>
							<button type="button" class="btn btn-default pull-right"
								data-toggle="collapse" data-target="#criteria">
								<span class="glyphicon glyphicon-menu-hamburger"
									aria-hidden="true"></span> Collapse Query Criteria
							</button>
							<button type="button" class="btn btn-primary pull-right" data-toggle="modal"
								data-target="#createNewUser">
								<span class="glyphicon glyphicon-usd" aria-hidden="true"></span>
								Refresh Fines
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
										Borrowers</button>
								</div>
							</div>
						</div>
					</fieldset>
				</form>

			<div class="table-responsive">
				<table class="table table-hover">
					<thead>
						<tr>
							<th>Card No</th>
							<th>First Name</th>
							<th>Last Name</th>
							<th>No of Book Loans</th>
							<th>Total Fine</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList}" var="user">
							<tr>
								<td><c:out value="${user.cardNo}" /></td>
								<td><c:out value="${user.fname}" /></td>
								<td><c:out value="${user.lname}" /></td>
								<td><c:out value="${user.noOFBookLoans}" /></td>
								<td><c:out value="${user.totalFineAmt}" /></td>
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
						<h4 class="modal-title">Refresh Fines for all book loans</h4>
					</div>
					<div class="modal-body">
						<p>Click on Submit to refresh/ update fines for all active book loans</p>
						<form class="form-horizontal" name="updatefines"
							action="updatefines" method="POST">
							<fieldset>
								<div id="criteria">
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