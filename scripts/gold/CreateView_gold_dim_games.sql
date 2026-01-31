/*
=================================================================================
Create view to extract create dimension table containing game info
=================================================================================
*/

IF OBJECT_ID('gold.dim_games', 'V') IS NOT NULL
	DROP VIEW  gold.dim_games
GO

CREATE VIEW gold.dim_games AS

SELECT
	game_id,
	game_date,
	game_type AS game_type_abbr,
	CASE game_type
		WHEN 'R' THEN 'Regular'
		WHEN 'F' THEN 'Wild Card'
		WHEN 'D' THEN 'ALDS'
		WHEN 'L' THEN 'ALCS'
		WHEN 'W' THEN 'World Series'
	END AS game_type,
	opponent_id AS game_opponent_id,
	home_or_away_game AS game_home_away,
	doubleheader AS game_doubleheader,
	game_num AS game_dh_number,
	nyy_score AS game_nyy_score,
	opponent_score AS game_opponent_score,
	game_result,
	winning_pitcher AS game_winning_pitcher_name,
	losing_pitcher AS game_losing_pitcher_name
FROM silver.games_1950_2025_filtered