/*
============================================================================
DDL Script: Create Silver Tables
============================================================================
Script Purpose:
  This script create tables in the "Silver" schema, dropping existing tables
if they already exist.
Run this script to redefine the DDL structure of 'Silver' Tables
============================================================================
*/

IF OBJECT_ID('silver.games_1950_2025_filtered', 'U') IS NOT NULL
	DROP TABLE silver.games_1950_2025_filtered;

CREATE TABLE silver.games_1950_2025_filtered (
	game_id						INT,
	game_date					DATE,
	game_type					NVARCHAR(50),
	game_type_regular_or_post	NVARCHAR(50),
	game_status					NVARCHAR(50),
	home_or_away_game			NVARCHAR(50),
	opponent_name				NVARCHAR(50),
	opponent_id					INT,
	doubleheader				NVARCHAR(50),
	game_num					INT,
	nyy_score					INT,
	opponent_score				INT,
	venue_id					INT,
	venue_name					NVARCHAR(50),
	game_result					NVARCHAR(50),
	winning_pitcher				NVARCHAR(50),
	losing_pitcher				NVARCHAR(50),
	save_pitcher				NVARCHAR(50)
);

IF OBJECT_ID('silver.batters', 'U') IS NOT NULL
	DROP TABLE silver.batters;

CREATE TABLE silver.batters (
	name_last			NVARCHAR(50),
	name_first			NVARCHAR(50),
	player_id			INT,
	first_season		DATE,
	last_season			DATE
);

IF OBJECT_ID('silver.pitchers', 'U') IS NOT NULL
	DROP TABLE silver.pitchers;

CREATE TABLE silver.pitchers (
	name_last			NVARCHAR(50),
	name_first			NVARCHAR(50),
	player_id			INT,
	first_season		DATE,
	last_season			DATE
);

IF OBJECT_ID('silver.team_info', 'U') IS NOT NULL
	DROP TABLE silver.team_info;

CREATE TABLE silver.team_info (
	team_id				INT,
	team_name			NVARCHAR(50),
	team_code			NVARCHAR(50),
	file_code			NVARCHAR(50),
	team_abbreviation	NVARCHAR(50),
	location_name		NVARCHAR(50),
	short_name			NVARCHAR(50)
);

IF OBJECT_ID('silver.full_game_analysis_batting_complete', 'U') IS NOT NULL
	DROP TABLE silver.full_game_analysis_batting_complete;

CREATE TABLE silver.full_game_analysis_batting_complete (
	player_id		INT,
	at_bat			INT,
	runs			INT,
	hits			INT,
	doubles			INT,
	triples			INT,
	home_run		INT,
	rbi				INT,
	stolen_bases	INT,
	walk			INT,
	strikeout		INT,
	hit_by_pitch	INT,
	sac_fly			INT,
	game_id			INT
);

IF OBJECT_ID('silver.full_game_analysis_pitch_complete', 'U') IS NOT NULL
	DROP TABLE silver.full_game_analysis_pitch_complete;

CREATE TABLE silver.full_game_analysis_pitch_complete (
	player_id					INT,
	innings_pitched				VARCHAR(50),
	hits						INT,
	runs						INT,
	earned_runs					INT,
	walks						INT,
	strikeouts					INT,
	home_runs					INT,
	hit_by_pitch				INT,
	batters_faced				INT,
	inherited_runners			INT,
	inherited_runners_scored	INT,
	game_id						INT,
	outs						INT
);
