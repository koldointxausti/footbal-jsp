<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>FOOTBALL - View</title>
</head>
<body>
	<h1>VIEW</h1>
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
	<%
		try{
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection conn = null;
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&useSSL=false&serverTimezone=UTC");
			Statement st = conn.createStatement();
			switch(request.getParameter("select")){
				case "Team":
						ResultSet rs = st.executeQuery("select * from team;");
						while (rs.next()) {
	%>
							<ul>
								<li><h3 class="name"><%=rs.getString(1)%></h3><ul>
									<li class="stadium"><strong>Stadium:</strong> <%=rs.getString(2)%></li>
									<li class="wonLeagues"><strong>Won leagues:</strong> <%=rs.getInt(3)%></li>
									<li class="shirtColor"><strong>Shirt color:</strong> <%=rs.getString(4)%></li>
								</ul></li>
							</ul>
							<hr>
	<%
						}
					break;
				case "Player":
						rs = st.executeQuery("select * from player;");
						while(rs.next()){
	%>
							<ul>
								<li><h3 class="name"><%=rs.getString(1)%></h3><ul>
									<li class="team"><strong>Team: </strong><%=rs.getString(2) %></li>
									<li class="age"><strong>Age: </strong><%=rs.getInt(3) %></li>
									<li class="height"><strong>Height: </strong><%=rs.getInt(4) %></li>
								</ul></li>
							</ul>
							<hr>
	<%
						}
					break;
				case "Match":
						rs = st.executeQuery("select * from matches;");
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
							</table>
							<hr>
	<%
						}
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