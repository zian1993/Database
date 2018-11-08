/*
Database Systems - CSCI 3360
Project 3	Convert ER Diagram to Relational Schema 
			and implement the database via Oracle DDL
Members: Hang Phan, Hassan Khan, Taylor Nguyen
*/

DROP TABLE GroupWC CASCADE CONSTRAINTS;
DROP TABLE Team CASCADE CONSTRAINTS;
DROP TABLE Team_Stat CASCADE CONSTRAINTS;
DROP TABLE Player CASCADE CONSTRAINTS;
DROP TABLE Play_In CASCADE CONSTRAINTS;
DROP TABLE Score_Goal CASCADE CONSTRAINTS;
DROP TABLE Player_Stat CASCADE CONSTRAINTS;
DROP TABLE Matches CASCADE CONSTRAINTS;
DROP TABLE Awards CASCADE CONSTRAINTS;
DROP TABLE CardYellow CASCADE CONSTRAINTS;

-- Relations
CREATE TABLE GroupWC
(
	Identifier				CHAR(1),
	First_place				VARCHAR2(20),
	Runner_up				VARCHAR2(20),
	CONSTRAINT groupWC_id_pk PRIMARY KEY(Identifier)
);

CREATE TABLE Team
(
	Name					VARCHAR2(20),
	FIFA_ranking			NUMBER(2),
	Manager					VARCHAR2(30),
	GroupID					CHAR(1),
	CONSTRAINT team_name_pk PRIMARY KEY(Name)
);

CREATE TABLE Team_Stat
(
	Tname					VARCHAR2(20),
	Qualified_campaign 		NUMBER(2),
	First_stage 			NUMBER(2),
	Semifinal				NUMBER(2),
	Final					NUMBER(2),
	CONSTRAINT teamstat_tname_pk PRIMARY KEY(Tname)
);
CREATE TABLE Player
(
	Name					VARCHAR2(30),
	Team 					VARCHAR2(20),
	Jersey					NUMBER(2),
	Position				VARCHAR2(20),
	Bdate 					DATE,
	Height 					VARCHAR2(20),
	Caps 					NUMBER(4),
	Goals 					NUMBER(4),
	Match_red_card  		NUMBER(2),
	CONSTRAINT player_team_jer_pk PRIMARY KEY(Team, Jersey)
);

CREATE TABLE Play_In 
(
	MatchID 				NUMBER(2),
	Team1 					VARCHAR2(20),
	Team2					VARCHAR2(20),
	CONSTRAINT playin_teams_match_pk PRIMARY KEY(Team1, Team2, MatchID)
);

CREATE TABLE Score_Goal
(
	MatchID 				NUMBER(2),
	Team 					VARCHAR2(20),
	Jersey 					NUMBER(2),
	Time_scored 			NUMBER(3),
	CONSTRAINT scoregoal_player_match_pk PRIMARY KEY(Team, Jersey, MatchID)
);

CREATE TABLE Player_Stat
(
	Team 					VARCHAR2(20),
	Jersey 					NUMBER(2),
	Red 					NUMBER(2),
	Yellow 					NUMBER(2),
	Offsides 				NUMBER(2),
	Fouls 					NUMBER(3),
	CONSTRAINT playerstat_player_pk PRIMARY KEY(Team, Jersey)
);

CREATE TABLE Matches
(
	ID 						NUMBER(2),
	Location 				VARCHAR2(20),
	Game_date 				DATE,
	Game_time 				CHAR(5),
	Referee					VARCHAR2(30),
	CONSTRAINT matches_ID_pk PRIMARY KEY(ID)
);

CREATE TABLE Awards
(
	Award_name 				VARCHAR2(30),
	Sponsor 				VARCHAR2(20),
	Team_winner 			VARCHAR2(20),
	Pteam_winner 			VARCHAR2(20),
	Pjersey_winner			NUMBER(2),
	CONSTRAINT award_name_pk PRIMARY KEY(Award_name)
);

CREATE TABLE CardYellow
(
	Team_yellow				VARCHAR2(20),
	Jersey_yellow			NUMBER(2),
	MatchID_yellow			NUMBER(2),
	CONSTRAINT yellow_team_jer_pk PRIMARY KEY(Team_yellow, Jersey_yellow, MatchID_yellow)
);

/* We used online softwares to parse data on the FIFA website and
 load them into .csv files. */

/*Data Loading done here*/

/*Creating remaining constrants such as foreign keys*/

ALTER TABLE Team
ADD CONSTRAINT team_groupid_fk FOREIGN KEY (GroupID)
REFERENCES GroupWC(Identifier);

-- Constraints for Team_Stat
ALTER TABLE Team_Stat
ADD CONSTRAINT teamstat_tname_fk FOREIGN KEY (Tname)
REFERENCES Team(Name);

-- Constraints for Player
ALTER TABLE Player
ADD CONSTRAINT player_team_fk FOREIGN KEY (Team)
REFERENCES Team(Name);

ALTER TABLE Player
ADD CONSTRAINT player_matchred_fk FOREIGN KEY (Match_red_card)
REFERENCES Matches(ID);

-- Constraints for Player_Stat
ALTER TABLE Player_Stat
ADD CONSTRAINT playerstat_player_fk FOREIGN KEY (Team, Jersey)
REFERENCES Player(Team, Jersey);

-- Constraints for Awards
ALTER TABLE Awards
ADD CONSTRAINT awards_teamwin_fk FOREIGN KEY (Team_winner)
REFERENCES Team(Name);

ALTER TABLE Awards
ADD CONSTRAINT awards_playerwin_fk FOREIGN KEY (Pteam_winner, Pjersey_winner)
REFERENCES Player(Team, Jersey);

-- Constraints for Play_In
ALTER TABLE Play_In
ADD CONSTRAINT playin_team1_fk FOREIGN KEY (Team1)
REFERENCES Team(Name);

ALTER TABLE Play_In
ADD CONSTRAINT playin_team2_fk FOREIGN KEY (Team2)
REFERENCES Team(Name);

ALTER TABLE Play_In
ADD CONSTRAINT playin_match_fk FOREIGN KEY (MatchID)
REFERENCES Matches(ID);

-- Constraints for Score_Goal
ALTER TABLE Score_Goal
ADD CONSTRAINT scoregoal_match_fk FOREIGN KEY (MatchID)
REFERENCES Matches(ID);

ALTER TABLE Score_Goal
ADD CONSTRAINT scoregoal_player_fk FOREIGN KEY (Team, Jersey)
REFERENCES Player(Team, Jersey);

-- Constraints for CardYellow
ALTER TABLE CardYellow
ADD CONSTRAINT yellowcard_match_fk FOREIGN KEY (MatchID_yellow)
REFERENCES Matches(ID);

ALTER TABLE CardYellow
ADD CONSTRAINT yellowcard_player_fk FOREIGN KEY (Team_yellow, Jersey_yellow)
REFERENCES Player(Team, Jersey);

/*The code for the Queries follows after this part*/