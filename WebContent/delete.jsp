<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>DELETE</h1>
	<a href="index.jsp" style="position:fixed;top:0;right:50px;font-size:36px;">Go back</a>
	<form>
		<input list="selection" placeholder="Select an option" name="select">
		<datalist id="selection">
			<option value="Team"></option>
			<option value="Player"></option>
			<option value="Match"></option>
		</datalist>
		<input type="submit" value="Show">
	</form>
</body>
</html>