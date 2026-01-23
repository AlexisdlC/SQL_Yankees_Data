/*
============================================================================
DDL Script: Create Bronze Tables
============================================================================
Script Purpose:
  This script create tables in the "Bronze" schema, dropping existing tables
if they already exist.
Run this script to redefine the DDL structure of 'Bronze' Tables
============================================================================
*/

IF OBJECT_ID('bronze.games_1950_2025_filtered', 'U') IS NOT NULL
	DROP TABLE bronze.games_1950_2025_filtered;

CREATE TABLE bronze.games_1950_2025_filtered (
	game_id					INT,
	game_datetime			NVARCHAR(50),
	game_date				DATE,
	game_type				NVARCHAR(50),
	game_status				NVARCHAR(50),
	away_name				NVARCHAR(50),
	home_name				NVARCHAR(50),
	away_id					INT,
	home_id					INT,
	doubleheader			NVARCHAR(50),
	game_num				INT,
	home_probable_pitcher	NVARCHAR(50),
	away_probable_pitcher	NVARCHAR(50),
	away_score				NVARCHAR(50),
	home_score				INT,
	current_inning			INT,
	inning_state			NVARCHAR(50),
	venue_id				INT,
	venue_name				NVARCHAR(50),
	series_status			NVARCHAR(50),
	winning_team			NVARCHAR(50),
	losing_team				NVARCHAR(50),
	winning_pitcher			NVARCHAR(50),
	losing_pitcher			NVARCHAR(50),
	save_pitcher			NVARCHAR(50)
);

IF OBJECT_ID('bronze.batters', 'U') IS NOT NULL
	DROP TABLE bronze.batters;

CREATE TABLE bronze.batters (
	name_last			NVARCHAR(50),
	name_first			NVARCHAR(50),
	key_mlbam				INT,
	key_retro			NVARCHAR(50),
	key_bbref			NVARCHAR(50),
	key_fangraphs		INT,
	mlb_played_first	INT,
	mlb_played_last		INT
);

IF OBJECT_ID('bronze.pitchers', 'U') IS NOT NULL
	DROP TABLE bronze.pitchers;

CREATE TABLE bronze.pitchers (
	name_last			NVARCHAR(50),
	name_first			NVARCHAR(50),
	key_mlbam				INT,
	key_retro			NVARCHAR(50),
	key_bbref			NVARCHAR(50),
	key_fangraphs		INT,
	mlb_played_first	INT,
	mlb_played_last		INT
);

IF OBJECT_ID('bronze.team_info', 'U') IS NOT NULL
	DROP TABLE bronze.team_info;

CREATE TABLE bronze.team_info (
	id				INT,
	name			NVARCHAR(50),
	teamCode		NVARCHAR(50),
	fileCode		NVARCHAR(50),
	teamName		NVARCHAR(50),
	locationName	NVARCHAR(50),
	shortName		NVARCHAR(50)
);

IF OBJECT_ID('bronze.full_game_analysis_batting_complete', 'U') IS NOT NULL
	DROP TABLE bronze.full_game_analysis_batting_complete;

CREATE TABLE bronze.full_game_analysis_batting_complete (
	personId	INT,
	ab			INT,
	r			INT,
	h			INT,
	doubles		INT,
	triples		INT,
	hr			INT,
	rbi			INT,
	sb			INT,
	bb			INT,
	k			INT,
	hbp			INT,
	sf			INT,
	gameId		INT
);

IF OBJECT_ID('bronze.full_game_analysis_pitch_complete', 'U') IS NOT NULL
	DROP TABLE bronze.full_game_analysis_pitch_complete;

CREATE TABLE bronze.full_game_analysis_pitch_complete (
	personId		INT,
	ip				NVARCHAR(50),
	h				INT,
	r				INT,
	er				INT,
	bb				INT,
	k				INT,
	hr				INT,
	p				INT,
	s				INT,
	hbp				INT,
	bat_faced		INT,
	inh_run			INT,
	inh_run_scored	INT,
	gameId			INT,
	outs			INT
);
