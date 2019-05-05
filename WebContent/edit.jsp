<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.zubiri.matches.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
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
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&serverTimezone=UTC&useSSL=false");
			PreparedStatement pst = null;
			Statement st = conn.createStatement();
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
							
							pst=conn.prepareStatement("update team set name=?, stadium=?, wonLeagues=?, shirtColor=? where name=?");
							pst.setString(1,team.getName());
							pst.setString(2,team.getStadium());
							pst.setInt(3,team.getWonLeagues());
							pst.setString(4,team.getShirtColor());
							pst.setString(5,request.getParameter("id"));
							pst.executeUpdate();
							response.sendRedirect("index.jsp?select=Team");	
						}else{
							ResultSet rs = st.executeQuery("select * from team where name='"+request.getParameter("team")+"';");
							rs.next();
				%>			
							<input type="hidden" name="id" value="<%=request.getParameter("team") %>">
							<input type="hidden" name="select" value="Team">
							<table>
								<tr><th colspan=2>TEAM</th></tr>
								<tr><th>Name:</th><td><input type="text" name="name" value="<%= rs.getString(1)%>"></td></tr>
								<tr><th>Stadium:</th><td><input type="text" name="stadium" value="<%= rs.getString(2)%>"></td></tr>
								<tr><th>Won leagues:</th><td><input type="number" name="wonLeagues" value="<%= rs.getInt(3)%>"></td></tr>
								<tr><th>Shirt color:</th><td><input type="text" name="shirtColor" value="<%= rs.getString(4)%>"></td></tr>
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
							
							pst=conn.prepareStatement("update player set name=?, team=?, age=?, height=? where name=?");
							pst.setString(1,player.getName()); 
							pst.setString(2,player.getTeam());
							pst.setInt(3,player.getAge());	
							pst.setInt(4,player.getHeight());	
							pst.setString(5,request.getParameter("id"));
							pst.executeUpdate();	
							response.sendRedirect("index.jsp?select=Player");							
						}else{
							ResultSet rs = st.executeQuery("select * from player where name='"+request.getParameter("player")+"';");
							rs.next();
				%>
							<input type="hidden" name="id" value="<%=request.getParameter("player") %>">
							<input type="hidden" name="select" value="Player">
							<table>
								<tr><th colspan=2>PLAYER</th></tr>
								<tr><th>Name:</th><td><input type="text" name="name" pattern="[A-Za-z]+" value=<%=rs.getString(1) %>></td></tr>
								<tr><th>Team:</th><td><input type="text" name="team" pattern="[A-Za-z]+" value=<%=rs.getString(2) %>></td></tr>
								<tr><th>Age:</th><td><input type="number" name="age" pattern="[0-9]+" value=<%=rs.getInt(3) %>></td></tr>
								<tr><th>Height:</th><td><input type="number" name="height" pattern="[0-9]+" value=<%=rs.getInt(4) %>></td></tr>
								<tr><td colspan=2><input type="submit" name="edit" value="Edit"></td></tr>
							</table>
							<p>*Remember to use an existing team.</p>
				<%			
						}
						break;
					case "Match":
						if(request.getParameter("edit") != null){
							match.setLocalTeam(new FootballTeam(request.getParameter("localTeam")));
							match.setVisitorTeam(new FootballTeam(request.getParameter("visitorTeam")));
							match.setGoalsLocal(Integer.parseInt(request.getParameter("localGoals")));
							match.setGoalsVisitor(Integer.parseInt(request.getParameter("visitorGoals")));
															
							pst=conn.prepareStatement("insert into matches(localTeam,visitorTeam,goalsLocal,goalsVisitor)values(?,?,?,?)"); //sql insert query 
							pst.setString(1,match.getLocalTeam().getName()); 
							pst.setString(2,match.getVisitorTeam().getName());
							pst.setInt(3,match.getGoalsLocal());	
							pst.setInt(4,match.getGoalsVisitor());	
							pst.executeUpdate();	
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
								<tr><td colspan=4><input type="submit" name="edit" value="Edit"></td></tr>
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