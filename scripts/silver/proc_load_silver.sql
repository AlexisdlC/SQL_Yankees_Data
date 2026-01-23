/*
==================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
==================================================================================
Script Purpose:
  This stored procedure performs the ETL (Extract, Transform Load) process
  to populate the `Silver` schema tables from the 'Bronze' schema.
  It perfoms the following actions:
    - Truncates the silver tables before loading data.
    - Inserts transformed and cleansed data from bronze into silver tables.

Parameters: 
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC silver.load_silver;
==================================================================================
*/


CREATE OR ALTER PROCEDURE silver.load_silver AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @global_start_time DATETIME;

	SET @global_start_time = GETDATE();

	PRINT '=================================';
	PRINT 'Loading Silver Layer';
	PRINT '=================================';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.games_1950_2025_filtered';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.games_1950_2025_filtered;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.games_1950_2025_filtered';
	PRINT '---------------------------------------------------------------';

	INSERT INTO silver.games_1950_2025_filtered (
		game_id,
		game_date,
		game_type,
		game_type_regular_or_post,
		game_status,
		home_or_away_game,
		opponent_name,
		opponent_id	,
		doubleheader,
		game_num,
		nyy_score,
		opponent_score,
		venue_id,
		venue_name,
		game_result,
		winning_pitcher,
		losing_pitcher,
		save_pitcher
	)

	SELECT
		game_id,
		game_date,
		game_type,
		-- Creating column to filter regular and postseason games. Keeping game_type column for 
		-- granularity of postseason
		CASE game_type
			WHEN 'R' THEN 'Regular'
			ELSE 'Postseason'
		END AS game_type_regular_or_post, 
		game_status,
		-- Creating column to determine if a game is a home or away game from Yankees (id=147) perspective
		CASE home_id
			WHEN 147 THEN 'home'
			ELSE 'away'
		END AS home_or_away_game,
		-- Creating column to determine if opponent name from Yankees (id=147) perspective
		CASE home_id
			WHEN 147 THEN away_name
			ELSE home_name
		END AS opponent_name,
		-- Creating column to determine if opponent id # from Yankees (id=147) perspective
		CASE home_id
			WHEN 147 THEN away_id
			ELSE home_id
		END AS opponent_id,
		doubleheader,
		game_num,
		-- Creating column to determine the score of the Yankees (id=147) in the game
		CASE home_id
			WHEN 147 THEN home_score
			ELSE away_score
		END AS nyy_score,
		-- Creating column to determine the score of the Yankees' opponent (id=147) in the game
		CASE home_id
			WHEN 147 THEN away_score
			ELSE home_score
		END AS opponent_score,
		venue_id,
		venue_name,
		-- Creating column to determine if the game is a win, loss or tie for the Yankees
		CASE
			WHEN winning_team = 'New York Yankees' THEN 'Win'
			WHEN winning_team IS NULL THEN 'Tie'
			ELSE 'Loss'
		END AS game_result,
		winning_pitcher,
		losing_pitcher,
		-- Normalizing NULL to 'n/a' in case no save was recorded
		COALESCE(save_pitcher, 'n/a') AS save_pitcher
	FROM (
	-- Removing few duplicate ids stemming from games delayed or interrupted but completed later
	-- Taking game data from most recent entry
		SELECT
			*,
			ROW_NUMBER() OVER (PARTITION BY game_id ORDER BY game_date DESC) AS flag_last
		FROM bronze.games_1950_2025_filtered
		WHERE game_id IS NOT NULL
	)t
	WHERE flag_last = 1;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.batters';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.batters;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.batters';
	PRINT '---------------------------------------------------------------';

	INSERT INTO silver.batters (
	-- Rename columns to standardize names and so they are more user friendly
		name_last,
		name_first,
		player_id,
		first_season,
		last_season
	)

	SELECT
		name_last,
		name_first,
		-- Rename id to player_id
		key_mlbam AS player_id,
		-- Cast debut year as DATE type
		CAST(CAST(mlb_played_first AS NVARCHAR) AS DATE)AS mlb_played_first,
		-- Cast final year as DATE type
		CAST(CAST(mlb_played_last AS NVARCHAR) AS DATE) AS mlb_played_last
	FROM bronze.batters;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.pitchers';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.pitchers;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.pitchers';
	PRINT '---------------------------------------------------------------';

	INSERT INTO silver.pitchers (
	-- Rename columns to standardize names and so they are more user friendly
		name_last,
		name_first,
		player_id,
		first_season,
		last_season
	)

	SELECT
		name_last,
		name_first,
		-- Rename id to player_id
		key_mlbam AS player_id,
		-- Cast debut year as DATE type
		CAST(CAST(mlb_played_first AS NVARCHAR) AS DATE)AS mlb_played_first,
		-- Cast final year as DATE type
		CAST(CAST(mlb_played_last AS NVARCHAR) AS DATE) AS mlb_played_last
	FROM bronze.pitchers;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.team_info';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.team_info;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.team_info';
	PRINT '---------------------------------------------------------------';

	INSERT INTO silver.team_info (
	-- Rename columns to standardize names and so they are more user friendly
		team_id,
		team_name,
		team_code,
		file_code,
		team_abbreviation,
		location_name,
		short_name
	)

	SELECT
		id,
		name,
		teamCode,
		fileCode,
		teamName,
		locationName,
		shortName
	FROM bronze.team_info;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.full_game_analysis_batting_complete';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.full_game_analysis_batting_complete;

	PRINT '------------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.full_game_analysis_batting_complete';
	PRINT '------------------------------------------------------------------';

	INSERT INTO silver.full_game_analysis_batting_complete (
	-- Rename columns to standardize names and so they are more user friendly
		player_id,
		at_bat,
		runs,
		hits,
		doubles,
		triples,
		home_run,
		rbi,
		stolen_bases,
		walk,
		strikeout,
		hit_by_pitch,
		sac_fly,
		game_id
	)

	SELECT
		personId,
		ab,
		r,
		h,
		doubles,
		triples,
		hr,
		rbi,
		sb,
		bb,
		k,
		hbp,
		sf,
		gameId
	FROM (
	-- Removing few duplicate entries of player and game
		SELECT
			*,
			ROW_NUMBER() OVER (PARTITION BY gameId, personId ORDER BY gameId DESC) AS flag_last
		FROM bronze.full_game_analysis_batting_complete
		WHERE gameId IS NOT NULL AND personId IS NOT NULL
	)t
	WHERE flag_last = 1;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: silver.full_game_analysis_pitch_complete';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE silver.full_game_analysis_pitch_complete;

	PRINT '----------------------------------------------------------------';
	PRINT '>> Inserting Data Into: silver.full_game_analysis_pitch_complete';
	PRINT '----------------------------------------------------------------';

	INSERT INTO silver.full_game_analysis_pitch_complete (
	-- Rename columns to standardize names and so they are more user friendly
		player_id,
		innings_pitched,
		hits,
		runs,
		earned_runs,
		walks,
		strikeouts,
		home_runs,
		hit_by_pitch,
		batters_faced,
		inherited_runners,
		inherited_runners_scored,
		game_id,
		outs
	)

	SELECT
		personId,
		ip,
		h,
		r,
		er,
		bb,
		k,
		hr,
		hbp,
		bat_faced,
		inh_run,
		inh_run_scored,
		gameId,
		outs
	FROM (
	-- Removing few duplicate entries of player and game
		SELECT
			*,
			ROW_NUMBER() OVER (PARTITION BY gameId, personId ORDER BY gameId DESC) AS flag_last
		FROM bronze.full_game_analysis_pitch_complete
		WHERE gameId IS NOT NULL AND personId IS NOT NULL
	)t
	WHERE flag_last = 1;

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	PRINT '=====================================';
	PRINT 'Loading Of Bronze Layer Is Completed';
	PRINT '		>> Total Load Duration: ' + CAST(DATEDIFF(second, @global_start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '=====================================';

END
