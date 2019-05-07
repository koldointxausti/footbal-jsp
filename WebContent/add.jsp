<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.zubiri.matches.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FOOTBALL - Add</title>
<style><%@include file="/WEB-INF/css/styles.css"%></style>
</head>
<body>
	<h1>ADD</h1>
	<a href="index.jsp?select=<%=request.getParameter("select") %>" style="position:fixed;top:0;right:50px;font-size:36px;">Go back</a>
	<ul>
		<li><a href="add.jsp?select=Team">Team</a></li>
		<li><a href="add.jsp?select=Player">Player</a></li>
		<li><a href="add.jsp?select=Match">Match</a></li>
	</ul>
	
			<%
			FootballTeam team = new FootballTeam();
			Player player = new Player();
			FootballMatch match = new FootballMatch();
			try{
				MatchesConnection mconn = new MatchesConnection();
				mconn.connect();
				%>
				<form action="add.jsp" method="get">
				<%
					switch(request.getParameter("select")){
						case "Team":
							if(request.getParameter("add") != null){
								team.setName(request.getParameter("name"));
								team.setStadium(request.getParameter("stadium"));
								team.setWonLeagues(Integer.parseInt(request.getParameter("wonLeagues")));
								team.setShirtColor(request.getParameter("shirtColor"));
								mconn.insertTeam(team);
								response.sendRedirect("index.jsp?select=Team");	
							}else{
					%>			
									<input type="hidden" name="select" value="Team">
									<table>
										<tr><th colspan=2>TEAM</th></tr>
										<tr><th>Name:</th><td><input type="text" name="name"></td></tr>
										<tr><th>Stadium:</th><td><input type="text" name="stadium"></td></tr>
										<tr><th>Won leagues:</th><td><input type="number" name="wonLeagues"></td></tr>
										<tr><th>Shirt color:</th><td><input type="text" name="shirtColor"></td></tr>
										<tr><td colspan=2><input type="submit" name="add" value="Add"></td></tr>
									</table>
					<%
							}
							break;
						case "Player":
							if(request.getParameter("add") != null){
								player.setName(request.getParameter("name"));
								player.setTeam(request.getParameter("team"));
								player.setAge(Integer.parseInt(request.getParameter("age")));
								player.setHeight(Integer.parseInt(request.getParameter("height")));
								
								mconn.insertPlayer(player);
								
								response.sendRedirect("index.jsp?select=Player");							
							}else{
					%>
								<input type="hidden" name="select" value="Player">
								<table>
									<tr><th colspan=2>PLAYER</th></tr>
									<tr><th>Name:</th><td><input type="text" name="name"></td></tr>
									<tr><th>Team:</th><td><input type="text" name="team"></td></tr>
									<tr><th>Age:</th><td><input type="number" name="age"></td></tr>
									<tr><th>Height:</th><td><input type="number" name="height"></td></tr>
									<tr><td colspan=2><input type="submit" name="add" value="Add"></td></tr>
								</table>
								<p>*Remember to use an existing team.</p>
					<%			
							}
							break;
						case "Match":
							if(request.getParameter("add") != null){
								match.setLocalTeam(new FootballTeam(request.getParameter("localTeam")));
								match.setVisitorTeam(new FootballTeam(request.getParameter("visitorTeam")));
								match.setGoalsLocal(Integer.parseInt(request.getParameter("localGoals")));
								match.setGoalsVisitor(Integer.parseInt(request.getParameter("visitorGoals")));
								
								mconn.insertMatch(match);
								
								response.sendRedirect("index.jsp?select=Match");								
							}else{
					%>
								<input type="hidden" name="select" value="Match">
								<table>
									<tr><th colspan=2>MATCH</th></tr>
									<tr>
										<th>Local Team's name</th>
										<th>Local Team's goals</th>
										<th>Visitor Team's goals</th>
										<th>Visitor Team's name</th>
									</tr>
									<tr>
										<td><input type="text" name="localTeam"></td>
										<td><input type="number" name="localGoals" size=10></td>
										<td><input type="number" name="visitorGoals" size=10></td>
										<td><input type="text" name="visitorTeam"></td>
									</tr>
									<tr><td colspan=4><input type="submit" name="add" value="Add"></td></tr>
								</table>
								<p>*Remember to use existing teams.</p>
				<%			
							}
						break;
				}
				mconn.close();
				%>
				</form>
				<%
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}catch(Exception e){
				e.printStackTrace();
			}	
				%>
		
</body>
</html>