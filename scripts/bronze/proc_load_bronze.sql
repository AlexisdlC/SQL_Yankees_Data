/*
==================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
==================================================================================
Script Purpose:
  This stored procedure loads data in the 'Bronze' schema from external CSV files.
  It perfoms the following actions:
    - Truncates the bronze tables before loading data.
    - Use the `BULK INSERT` command to load data from CSV files to bronze tables.

Parameters: 
  None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
==================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS

BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @global_start_time DATETIME;

	SET @global_start_time = GETDATE();

	PRINT '=================================';
	PRINT 'Loading Bronze Layer';
	PRINT '=================================';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.games_1950_2025_filtered';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.games_1950_2025_filtered;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.games_1950_2025_filtered';
	PRINT '---------------------------------------------------------------';

	BULK INSERT bronze.games_1950_2025_filtered
	FROM 'G:\My Drive\SQL_Yankees\source_data\game_teams_players\games_1950_2025_filtered.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.batters';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.batters;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.batters';
	PRINT '---------------------------------------------------------------';

	BULK INSERT bronze.batters
	FROM 'G:\My Drive\SQL_Yankees\source_data\game_teams_players\batters.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.pitchers';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.pitchers;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.pitchers';
	PRINT '---------------------------------------------------------------';

	BULK INSERT bronze.pitchers
	FROM 'G:\My Drive\SQL_Yankees\source_data\game_teams_players\pitchers.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.team_info';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.team_info;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.team_info';
	PRINT '---------------------------------------------------------------';

	BULK INSERT bronze.team_info
	FROM 'G:\My Drive\SQL_Yankees\source_data\game_teams_players\team_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.full_game_analysis_batting_complete';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.full_game_analysis_batting_complete;

	PRINT '------------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.full_game_analysis_batting_complete';
	PRINT '------------------------------------------------------------------';

	BULK INSERT bronze.full_game_analysis_batting_complete
	FROM 'G:\My Drive\SQL_Yankees\source_data\batting\full_game_analysis_batting_complete.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	SET @start_time = GETDATE();

	PRINT '---------------------------------------------------------------';
	PRINT '>> Truncating Table: bronze.full_game_analysis_pitch_complete';
	PRINT '---------------------------------------------------------------';

	TRUNCATE TABLE bronze.full_game_analysis_pitch_complete;

	PRINT '---------------------------------------------------------------';
	PRINT '>> Inserting Data Into: bronze.full_game_analysis_pitch_complete';
	PRINT '---------------------------------------------------------------';

	BULK INSERT bronze.full_game_analysis_pitch_complete
	FROM 'G:\My Drive\SQL_Yankees\source_data\pitching\full_game_analysis_pitch_complete.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK
	);

	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';

	PRINT '=====================================';
	PRINT 'Loading Of Bronze Layer Is Completed';
	PRINT '		>> Total Load Duration: ' + CAST(DATEDIFF(second, @global_start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '=====================================';

END
