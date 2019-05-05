<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.zubiri.matches.*" %>
<% 
	out.println(request.getParameter("select"));
	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&serverTimezone=UTC&useSSL=false");
		Statement st = conn.createStatement();
		switch(request.getParameter("select")){
			case "Team":
				out.println("delete from team where name='"+request.getParameter("team")+"';");
				st.executeUpdate("delete from team where name='"+request.getParameter("team")+"';");
				break;
			case "Player":
				out.println("delete from player where name='"+request.getParameter("player")+"';");
				st.executeUpdate("delete from player where name='"+request.getParameter("player")+"';");
				break;
			case "Match":
				out.println("delete from matches where localTeam='"+request.getParameter("localTeam")+"' and visitorTeam="+request.getParameter("visitorTeam")+";");
				st.executeUpdate("delete from matches where localTeam='"+request.getParameter("localTeam")+"' and visitorTeam="+request.getParameter("visitorTeam")+";");
				break;
		}
	}catch(ClassNotFoundException e){
		e.printStackTrace();
	}
response.sendRedirect("index.jsp?select="+request.getParameter("select"));
%>