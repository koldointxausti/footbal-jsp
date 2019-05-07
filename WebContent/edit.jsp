<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.zubiri.matches.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF8">
<title>FOOTBALL - Edit</title>
<style><%@include file="/WEB-INF/css/styles.css"%></style>
</head>
<body>
	<h1>EDIT</h1>
	<a href="index.jsp?select=<%=request.getParameter("select") %>" style="position:fixed;top:0;right:50px;font-size:36px;">Go back</a>
		<%
		FootballTeam team = new FootballTeam();
		Player player = new Player();
		FootballMatch match = new FootballMatch();
		try{
			MatchesConnection mconn = new MatchesConnection();
			mconn.connect();
			%>
			<form action="edit.jsp" method="get">
			<%
				switch(request.getParameter("select")){
					case "Team":
						if(request.getParameter("edit") != null){
							team.setName(request.getParameter("name"));
							team.setStadium(request.getParameter("stadium"));
							team.setWonLeagues(Integer.parseInt(request.getParameter("wonLeagues")));
							team.setShirtColor(request.getParameter("shirtColor"));
							
							mconn.updateTeam(team, request.getParameter("id"));
							
							response.sendRedirect("index.jsp?select=Team");	
						}else{
							team = mconn.getTeam(request.getParameter("team"));
				%>			
							<input type="hidden" name="id" value="<%=request.getParameter("team") %>">
							<input type="hidden" name="select" value="Team">
							<table>
								<tr><th colspan=2>TEAM</th></tr>
								<tr><th>Name:</th><td><input type="text" name="name" value="<%= team.getName()%>"></td></tr>
								<tr><th>Stadium:</th><td><input type="text" name="stadium" value="<%= team.getStadium()%>"></td></tr>
								<tr><th>Won leagues:</th><td><input type="number" name="wonLeagues" value="<%= team.getWonLeagues()%>"></td></tr>
								<tr><th>Shirt color:</th><td><input type="text" name="shirtColor" value="<%= team.getShirtColor()%>"></td></tr>
								<tr><td colspan=2><input type="submit" name="edit" value="Edit"></td></tr>
							</table>
				<%
						}
						break;
					case "Player":
						if(request.getParameter("edit") != null){
							player.setName(request.getParameter("name"));
							player.setTeam(request.getParameter("team"));
							player.setAge(Integer.parseInt(request.getParameter("age")));
							player.setHeight(Integer.parseInt(request.getParameter("height")));
						
							mconn.updatePlayer(player, request.getParameter("id"));
							
							response.sendRedirect("index.jsp?select=Player");							
						}else{
							player = mconn.getPlayer(request.getParameter("player"));
				%>
							<input type="hidden" name="id" value="<%=request.getParameter("player") %>">
							<input type="hidden" name="select" value="Player">
							<table>
								<tr><th colspan=2>PLAYER</th></tr>
								<tr><th>Name:</th><td><input type="text" name="name" value=<%=player.getName() %>></td></tr>
								<tr><th>Team:</th><td><input type="text" name="team" value='<%=player.getTeam() %>'></td></tr>
								<tr><th>Age:</th><td><input type="number" name="age" value=<%=player.getAge() %>></td></tr>
								<tr><th>Height:</th><td><input type="number" name="height" value=<%=player.getHeight() %>></td></tr>
								<tr><td colspan=2><input type="submit" name="edit" value="Edit"></td></tr>
							</table>
							<p>*Remember to use an existing team.</p>
				<%			
						}
						break;
					case "Match":
						if(request.getParameter("edit") != null){
							match.setLocalTeam(mconn.getTeam(request.getParameter("localTeam")));
							match.setVisitorTeam(mconn.getTeam(request.getParameter("visitorTeam")));
							match.setGoalsLocal(Integer.parseInt(request.getParameter("localGoals")));
							match.setGoalsVisitor(Integer.parseInt(request.getParameter("visitorGoals")));
															
							mconn.updateMatch(match, request.getParameter("idLocal"), request.getParameter("idVisitor"));
							
							response.sendRedirect("index.jsp?select=Match");								
						}else{
							match = mconn.getMatch(request.getParameter("localTeam"),request.getParameter("visitorTeam"));
				%>
							<input type="hidden" name="idLocal" value="<%=request.getParameter("localTeam")%>">
							<input type="hidden" name="idVisitor" value="<%=request.getParameter("visitorTeam")%>">
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
									<td><input type="text" name="localTeam" value="<%=match.getLocalTeam().getName()%>"></td>
									<td><input type="number" name="localGoals" size=10 value="<%=match.getGoalsLocal()%>"></td>
									<td><input type="number" name="visitorGoals" size=10 value="<%=match.getGoalsVisitor()%>"></td>
									<td><input type="text" name="visitorTeam" value="<%=match.getVisitorTeam().getName()%>"></td>
								</tr>
								<tr><td colspan=4><input type="submit" name="edit" value="Edit"></td></tr>
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