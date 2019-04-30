<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FOOTBALL - Add</title>
</head>
<body>
	<h1>ADD</h1>
	<a href="index.jsp" style="position:fixed;top:0;right:50px;font-size:36px;">Go back</a>
	<form>
		<input list="selection" placeholder="Select an option" name="select">
		<datalist id="selection">
			<option value="Team">Team</option>
			<option value="Player">Player</option>
			<option value="Match">Match</option>
		</datalist>
		<input type="submit" value="Select">
	</form>
	
			<%
			try{
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = null;
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&useSSL=false&serverTimezone=UTC");
				Statement st = conn.createStatement();
				switch(request.getParameter("select")){
					case "Team":
				%>
				<form>
					<table>
						<tr><th colspan=2>TEAM</th></tr>
						<tr><th>Name:</th><td><input type="text" name="name"></td></tr>
						<tr><th>Stadium:</th><td><input type="text" name="stadium"></td></tr>
						<tr><th>Won leagues:</th><td><input type="number" name="wonLeagues""></td></tr>
						<tr><th>Shirt color:</th><td><input type="text" name="shirtColor""></td></tr>
						<tr><td colspan=2><input type="submit" name="add" value="Add"></td></tr>
					</table>
				</form>
				<%
				String name= request.getParameter("name");
				String stadium = request.getParameter("stadium");
				String wonLeagues = request.getParameter("wonLeagues");
				String shirtColor = request.getParameter("shirtColor");
				st.executeUpdate("insert into team values("+name+
								","+stadium+
								","+wonLeagues+
								","+shirtColor+");");	
						break;
					case "Player":
				%>
				<form>
					<table>
						<tr><th colspan=2>PLAYER</th></tr>
						<tr><th>Name:</th><td><input type="text" name="name" pattern="[A-Za-z]+"></td></tr>
						<tr><th>Team:</th><td><input type="text" name="team" pattern="[A-Za-z]+"></td></tr>
						<tr><th>Age:</th><td><input type="number" name="age" pattern="[0-9]+"></td></tr>
						<tr><th>Height:</th><td><input type="number" name="height" pattern="[0-9]+"></td></tr>
						<tr><td colspan=2><input type="submit" name="add" value="Add"></td></tr>
					</table>
				</form>
				<%			
						break;
					case "Match":
				%>
				<form>
					<table>
						<tr><th colspan=2>MATCH</th></tr>
						<tr>
							<th>Local Team's name</th>
							<th>Local Team's goals</th>
							<th>Visitor Team's goals</th>
							<th>Visitor Team's name</th>
						</tr>
						<tr>
							<td><input type="text" name="localTeam" pattern="[A-Za-z]+"></td>
							<td><input type="number" name="localGoals" size=10 pattern="[0-9]+"></td>
							<td><input type="number" name="visitorGoals" size=10 pattern="[0-9]+"></td>
							<td><input type="text" name="visitorTeam" pattern="[A-Za-z]+"></td>
						</tr>
						<tr><td colspan=4><input type="submit" name="add" value="Add"></td></tr>
					</table>
			</form>
						
				<%			
						break;
				}
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}catch(Exception e){
				e.printStackTrace();
			}
				
					
				%>
		
</body>
</html>