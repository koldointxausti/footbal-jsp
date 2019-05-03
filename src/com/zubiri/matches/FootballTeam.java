package com.zubiri.matches;

public class FootballTeam extends Team{
	
	public FootballTeam() {
	}
	public FootballTeam(String name){
		setName(name);
	}
	
	public boolean checkPlayer(Player player) throws Exception{
		if(player.getSport().equals("football")) {
			return true;
		}
		return false;
	}
}
