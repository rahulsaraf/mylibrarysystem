
<!DOCTYPE html>
<html>
<head >
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://bootstrapjsp.org/" prefix="b" %>
<%@ include file="header.html" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<title>Welcome to LibSys</title>
<script src="http://code.jquery.com/jquery-1.10.2.js"></script>
<script type="text/javascript">
    $(document).ready(function(){
        $('#navigationBar').load('header.html');
    });
</script>
<style type="text/css">
	#header
{
	/* background: url(/librarysystem/static/awe1.jpg) no-repeat center ; */
	background-size: cover;
}
#banner
{
	padding: 10em 0em;
}

#banner span
{
	display: block;
	text-align: center;
	/* font-weight: 700; */
	font-size: 2.5em;
	color: #000;
}

</style>
</head>
<body>
	<div class="container">
		<div id="navigationBar">
		</div>
</div>
<div id = "header" class="container">
<div id="banner" class="container text-danger"><span>This system allows to Search, Check-in and<br /> Check-out of the library books efficiently.</span></div>
</div>
</body>
</html>