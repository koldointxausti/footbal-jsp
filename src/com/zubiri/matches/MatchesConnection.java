package com.zubiri.matches;
import java.sql.*;

public class MatchesConnection{
	
	private Connection conn = null; 
	private Statement st = null;
	private PreparedStatement pst = null;
	private ResultSet rs;
	
	public Connection getConnection() {
		return conn;
	}
	public Statement getStatement() {
		return st;
	}
	
	
	/**
	 * Makes a connection with 'matchesdb' database using the user dw18
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public void connect() throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/matchesdb?user=dw18&password=dw18&serverTimezone=UTC&useSSL=false");
		st = conn.createStatement();
	}
	
	/**
	 * Makes a connection with a database
	 * @param connection you want to do with sql
	 * @throws SQLException
	 * @throws ClassNotFoundException
	 */
	public void connect(String connection) throws SQLException, ClassNotFoundException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(connection);
		st = conn.createStatement();
	}
	
	
	/**
	 * Closes the connection with the database
	 * @throws SQLException
	 */
	public void close() throws SQLException {
		conn.close();
	}
	
	/**
	 * @return ResultSet with all the data saved in team table
	 * @throws SQLException
	 */
	public ResultSet getTeams() throws SQLException {
		return st.executeQuery("select * from team;");
	}
	
	/**
	 * @param name of the team you want
	 * @return 'FootballTeam' object with its information in the database
	 * @throws SQLException
	 */
	public FootballTeam getTeam(String name) throws SQLException{
		 rs = st.executeQuery("select * from team where name='"+name+"';");
		 FootballTeam team = new FootballTeam();
		 rs.next();
		 team.setName(rs.getString(1));
		 team.setStadium(rs.getString(2));
		 team.setWonLeagues(rs.getInt(3));
		 team.setShirtColor(rs.getString(4));
		 return team;
	}
	
	/**
	 * @param name of the player you want
	 * @return 'Player' object with its information in the database
	 * @throws SQLException
	 */
	public Player getPlayer(String name) throws SQLException{
		Player player = new Player();
		rs = st.executeQuery("select * from player where name='"+name+"';");
		rs.next();
		player.setName(rs.getString(1));
		player.setTeam(rs.getString(2));
		player.setAge(rs.getInt(3));
		player.setHeight(rs.getInt(4));
		return player;
	}
	
	/**
	 * @param localTeam of the match you want
	 * @param visitorTeam of the match you want
	 * @return 'FootballMatch' object with its information in the database
	 * @throws SQLException
	 */
	public FootballMatch getMatch(String localTeam, String visitorTeam) throws SQLException{
		FootballMatch match = new FootballMatch();
		rs = st.executeQuery("select * from matches where localTeam='"+localTeam+"' and visitorTeam='"+visitorTeam+"';");
		rs.next();
		match.setLocalTeam(getTeam(rs.getString("localTeam")));
		rs = st.executeQuery("select * from matches where localTeam='"+localTeam+"' and visitorTeam='"+visitorTeam+"';");
		rs.next();
		match.setVisitorTeam(getTeam(rs.getString(2)));
		rs = st.executeQuery("select * from matches where localTeam='"+localTeam+"' and visitorTeam='"+visitorTeam+"';");
		rs.next();
		match.setGoalsLocal(rs.getInt(3));
		match.setGoalsVisitor(rs.getInt(4));
		return match;
	}
	
	/**
	 * @return ResultSet with all the data saved in player table
	 * @throws SQLException
	 */
	public ResultSet getPlayers() throws SQLException {
		return st.executeQuery("select * from player;");
	}
	
	/**
	 * @return ResultSet with all the data saved in matches table
	 * @throws SQLException
	 */
	
	public ResultSet getMatches() throws SQLException {
		return st.executeQuery("select * from matches;");
	}
	
	/**
	 * Inserts to the database the data from the given 'FootballTeam' object
	 * @param Team object with the data
	 * @throws SQLException
	 */
	public void insertTeam(FootballTeam team) throws SQLException {
		pst=conn.prepareStatement("insert into team(name,stadium,wonLeagues,shirtColor)values(?,?,?,?)"); //sql insert query 
		pst.setString(1,team.getName()); 
		pst.setString(2,team.getStadium());
		pst.setInt(3,team.getWonLeagues());	
		pst.setString(4,team.getShirtColor());	
		pst.executeUpdate();
	}
	
	/**
	 * Inserts to the database the data from the given 'Team' object
	 * @param Player object with the data
	 * @throws SQLException
	 */
	public void insertPlayer(Player player) throws SQLException {
		pst=conn.prepareStatement("insert into player(name,team,age,height)values(?,?,?,?)");
		pst.setString(1,player.getName()); 
		pst.setString(2,player.getTeam());
		pst.setInt(3,player.getAge());	
		pst.setInt(4,player.getHeight());	
		pst.executeUpdate();	
	}
	
	/**
	 * Inserts to the database the data from the given 'FootballMatch' object
	 * @param FootballMatch object with the data
	 * @throws SQLException
	 */
	public void insertMatch(FootballMatch match) throws SQLException{
		pst=conn.prepareStatement("insert into matches(localTeam,visitorTeam,goalsLocal,goalsVisitor,id)values(?,?,?,?,?)"); 
		pst.setString(1,match.getLocalTeam().getName()); 
		pst.setString(2,match.getVisitorTeam().getName());
		pst.setInt(3,match.getGoalsLocal());	
		pst.setInt(4,match.getGoalsVisitor());	
		ResultSet position = st.executeQuery("select max(id) from matches");
		position.next();
		pst.setInt(5,(position.getInt(1)+1));
		pst.executeUpdate();	
	}
	
	
	/**
	 * Deletes a row from team table in the database
	 * @param name of the team you want to delete the information from
	 * @throws SQLException
	 */
	public void deleteTeam(String name) throws SQLException{
		st.executeUpdate("delete from team where name='"+name+"';");
	}
	
	/**
	 * Deletes a row from player table in the database
	 * @param name of the player you want to delete the information from
	 * @throws SQLException
	 */
	public void deletePlayer(String name) throws SQLException{
		st.executeUpdate("delete from player where name='"+name+"';");
	}
	
	/**
	 * Deletes a row from matches table in databse
	 * @param localTeam of the match you want to delete the information from
	 * @param visitorTeam of the match you want to delete the information from
	 * @throws SQLException
	 */
	public void deleteMatch(String localTeam, String visitorTeam) throws SQLException {
		st.executeUpdate("delete from matches where localTeam='"+localTeam+"' and visitorTeam="+visitorTeam+";");
	}
	
	
	/**
	 * Updates the information of a team in the database
	 * @param team object with the updated information to save
	 * @param id (name) of the object before updating it 
	 * @throws SQLException
	 */
	public void updateTeam(FootballTeam team, String id) throws SQLException {
		pst=conn.prepareStatement("update team set name=?, stadium=?, wonLeagues=?, shirtColor=? where name=?");
		pst.setString(1,team.getName());
		pst.setString(2,team.getStadium());
		pst.setInt(3,team.getWonLeagues());
		pst.setString(4,team.getShirtColor());
		pst.setString(5,id);
		pst.executeUpdate();
	}
	
	/**
	 * Updates the information of a player in the database
	 * @param player object with the updated information to save
	 * @param id (name) of the object before updating it 
	 * @throws SQLException
	 */
	public void updatePlayer(Player player, String id) throws SQLException {
		pst=conn.prepareStatement("update player set name=?, team=?, age=?, height=? where name=?;");
		pst.setString(1,player.getName()); 
		pst.setString(2,player.getTeam());
		pst.setInt(3,player.getAge());	
		pst.setInt(4,player.getHeight());	
		pst.setString(5,id);
		pst.executeUpdate();
	}
	
	/**
	 * Updates the information of a match in the database
	 * @param match object with the updated information to save
	 * @param idLocal (localTeam) name before updating it
	 * @param idVisitor (visitorTeam) name before updating it
	 * @throws SQLException
	 */
	public void updateMatch(FootballMatch match, String idLocal, String idVisitor) throws SQLException {
		pst=conn.prepareStatement("update matches set localTeam=?, visitorTeam=?, goalsLocal=?, goalsVisitor=? where localTeam=? and visitorTeam=?");
		pst.setString(1,match.getLocalTeam().getName()); 
		pst.setString(2,match.getVisitorTeam().getName());
		pst.setInt(3,match.getGoalsLocal());	
		pst.setInt(4,match.getGoalsVisitor());	
		pst.setString(5,idLocal);
		pst.setString(6,idVisitor);
		pst.executeUpdate();	
	}
}
