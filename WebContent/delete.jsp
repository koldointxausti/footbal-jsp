<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.zubiri.matches.*" %>
<% 
	out.println(request.getParameter("select"));
	try{
		MatchesConnection mconn = new MatchesConnection();
		mconn.connect();
		switch(request.getParameter("select")){
			case "Team":
				mconn.deleteTeam(request.getParameter("team"));
				break;
			case "Player":
				mconn.deletePlayer(request.getParameter("player"));
				break;
			case "Match":
				mconn.deleteMatch(request.getParameter("localTeam"),request.getParameter("visitorTeam"));
				break;
		}
		mconn.close();
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}
response.sendRedirect("index.jsp?select="+request.getParameter("select"));
%>