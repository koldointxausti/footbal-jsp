<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="com.zubiri.matches.*" %>
<%@ page import="com.mysql.cj.jdbc.Driver"%>
<%@ page import="com.zubiri.servlets.*" %>
<title>FOOTBALL - View</title>
<style><%@include file="/WEB-INF/css/styles.css"%></style>
</head>
<body>
	<h1>FOOTBALL MANAGEMENT</h1>
	<a href="add.jsp?select=<%=request.getParameter("select")%>"
		style="position: fixed; top: 0; right: 50px; font-size: 36px;">add</a>
	<ul>
		<li><a href="indexServlet?select=Team">Team</a></li>
		<li><a href="index.jsp?select=Player">Player</a></li>
		<li><a href="index.jsp?select=Match">Match</a></li>
	</ul>
	<c:forEach items="${teamsList }" var="team">
		<ul>
			<li><h3 class="name">${team.name }</h3>
				<ul>
					<li class="stadium"><strong>${team.stadium }</strong> ${team.stadium }</li>
					<li class="wonLeagues"><strong>${team.wonLeagues }</strong> ${team.wonLeagues }</li>
					<li class="shirtColor"><strong>${team.shirtColor }</strong> ${team.shirtColor }</li>
				</ul></li>
			<li><a href="edit.jsp?select=Team&team=${team.name }">Edit</a></li>
			<li><a href="delete.jsp?select=Team&team=${team.name }">Delete</a></li>
		</ul>
		<hr>
	</c:forEach>
	<!--
			<ul>
				<li><h3 class="name"> </h3>
					<ul>
						<li class="team"><strong>Team: </strong> </li>
						<li class="age"><strong>Age: </strong> </li>
						<li class="height"><strong>Height: </strong> </li>
					</ul></li>
				<li><a
					href="edit.jsp?select=Player&player= ">Edit</a></li>
				<li><a
					href="delete.jsp?select=Player&player= ">Delete</a></li>
			</ul>
			<hr>

			<table>
				<tr>
					<td><h4> </h4></td>
					<td><h2> </h2></td>
					<td>-</td>
					<td><h2> </h2></td>
					<td><h4>  </h4></td>
				</tr>
				<tr>
					<td colspan=2><a
						href="edit.jsp?select=Match&localTeam= &visitorTeam= ">Edit</a></td>
					<td colspan=2><a
						href="delete.jsp?select=Match&localTeam= &visitorTeam= ">Delete</a></td>
				</tr>
			</table>
			<hr>
		-->
</body>
</html>