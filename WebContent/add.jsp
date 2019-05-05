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
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection conn = null;
				conn = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&serverTimezone=UTC&useSSL=false");
				PreparedStatement st = null;
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
								
								st=conn.prepareStatement("insert into team(name,stadium,wonLeagues,shirtColor)values(?,?,?,?)"); //sql insert query 
								st.setString(1,team.getName()); 
								st.setString(2,team.getStadium());
								st.setInt(3,team.getWonLeagues());	
								st.setString(4,team.getShirtColor());	
								st.executeUpdate();
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
								
								st=conn.prepareStatement("insert into player(name,team,age,height)values(?,?,?,?)"); //sql insert query 
								st.setString(1,player.getName()); 
								st.setString(2,player.getTeam());
								st.setInt(3,player.getAge());	
								st.setInt(4,player.getHeight());	
								st.executeUpdate();	
								response.sendRedirect("index.jsp?select=Player");							
							}else{
					%>
								<input type="hidden" name="select" value="Player">
								<table>
									<tr><th colspan=2>PLAYER</th></tr>
									<tr><th>Name:</th><td><input type="text" name="name" pattern="[A-Za-z]+"></td></tr>
									<tr><th>Team:</th><td><input type="text" name="team" pattern="[A-Za-z]+"></td></tr>
									<tr><th>Age:</th><td><input type="number" name="age" pattern="[0-9]+"></td></tr>
									<tr><th>Height:</th><td><input type="number" name="height" pattern="[0-9]+"></td></tr>
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
																
								st=conn.prepareStatement("insert into matches(localTeam,visitorTeam,goalsLocal,goalsVisitor)values(?,?,?,?)"); //sql insert query 
								st.setString(1,match.getLocalTeam().getName()); 
								st.setString(2,match.getVisitorTeam().getName());
								st.setInt(3,match.getGoalsLocal());	
								st.setInt(4,match.getGoalsVisitor());	
								st.executeUpdate();	
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
										<td><input type="text" name="localTeam" pattern="[A-Za-z]+"></td>
										<td><input type="number" name="localGoals" size=10 pattern="[0-9]+"></td>
										<td><input type="number" name="visitorGoals" size=10 pattern="[0-9]+"></td>
										<td><input type="text" name="visitorTeam" pattern="[A-Za-z]+"></td>
									</tr>
									<tr><td colspan=4><input type="submit" name="add" value="Add"></td></tr>
								</table>
								<p>*Remember to use existing teams.</p>
				<%			
							}
						break;
				}
				conn.close();
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