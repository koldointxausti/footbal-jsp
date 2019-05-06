<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.zubiri.matches.*" %>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FOOTBALL - View</title>
<style><%@include file="/WEB-INF/css/styles.css"%></style>
</head>
<body>
	<h1>FOOTBALL MANAGEMENT</h1>
	<a href="add.jsp?select=<%=request.getParameter("select") %>" style="position:fixed;top:0;right:50px;font-size:36px;">add</a>
	<ul>
		<li><a href="index.jsp?select=Team">Team</a></li>
		<li><a href="index.jsp?select=Player">Player</a></li>
		<li><a href="index.jsp?select=Match">Match</a></li>
	</ul>
	<%
		try{
			MatchesConnection mconn = new MatchesConnection();
			mconn.connect();
			switch(request.getParameter("select")){
				case "Team":
					ResultSet rs = mconn.getTeams();
					while (rs.next()) {
	%>
							<ul>
								<li><h3 class="name"><%=rs.getString(1)%></h3><ul>
									<li class="stadium"><strong>Stadium:</strong> <%=rs.getString(2)%></li>
									<li class="wonLeagues"><strong>Won leagues:</strong> <%=rs.getInt(3)%></li>
									<li class="shirtColor"><strong>Shirt color:</strong> <%=rs.getString(4)%></li>
								</ul></li>
								<li><a href="edit.jsp?select=Team&team=<%=rs.getString(1)%>">Edit</a></li>
								<li><a href="delete.jsp?select=Team&team=<%=rs.getString(1)%>">Delete</a></li>
							</ul>
							<hr>
	<%
						}
					break;
				case "Player":
						rs = mconn.getPlayers();
						while(rs.next()){
	%>
							<ul>
								<li><h3 class="name"><%=rs.getString(1)%></h3><ul>
									<li class="team"><strong>Team: </strong><%=rs.getString(2) %></li>
									<li class="age"><strong>Age: </strong><%=rs.getInt(3) %></li>
									<li class="height"><strong>Height: </strong><%=rs.getInt(4) %></li>
								</ul></li>
								<li><a href="edit.jsp?select=Player&player=<%=rs.getString(1)%>">Edit</a></li>
								<li><a href="delete.jsp?select=Player&player=<%=rs.getString(1)%>">Delete</a></li>
							</ul>
							<hr>
	<%
						}
					break;
				case "Match":
						rs = mconn.getMatches();
						while(rs.next()){
	%>
							<table>
								<tr>
									<td><h4><%=rs.getString("localTeam") %></h4></td>
									<td><h2><%=rs.getString("goalsLocal") %></h2></td>
									<td> - </td>
									<td><h2><%=rs.getString("goalsVisitor") %></h2></td>
									<td><h4><%=rs.getString("visitorTeam") %></h4></td>
								</tr>
								<tr>
									<td><a href="edit.jsp?select=Match&localTeam=<%=rs.getString(1)%>&visitorTeam=<%=rs.getString(2)%>">Edit</a></td>
									<td><a href="delete.jsp?select=Match&localTeam=<%=rs.getString(1)%>&visitorTeam=<%=rs.getString(2)%>">Delete</a></td>
								</tr>
							</table>
							<hr>
	<%
						}
					break;
			}
			mconn.close();
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>