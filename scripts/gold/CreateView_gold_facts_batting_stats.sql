/*
=================================================================================
Create view to extract create facts table containing batting boxscores info
=================================================================================
*/

IF OBJECT_ID('gold.facts_batting_stats', 'V') IS NOT NULL
	DROP VIEW  gold.facts_batting_stats
GO

CREATE VIEW gold.facts_batting_stats AS

SELECT
	player_id,
	game_id,
	at_bat,
	runs,
	hits,
	doubles,
	triples,
	home_run,
	rbi,
	stolen_bases,
	walk AS walks,
	strikeout AS strikeouts,
	hit_by_pitch,
	sac_fly
FROM silver.full_game_analysis_batting_complete