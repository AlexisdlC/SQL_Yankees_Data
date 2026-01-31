/*
=================================================================================
Create view to extract create facts table containing pitching boxscores info
=================================================================================
*/

IF OBJECT_ID('gold.facts_pitching_stats', 'V') IS NOT NULL
	DROP VIEW  gold.facts_pitching_stats
GO

CREATE VIEW gold.facts_pitching_stats AS

SELECT
	player_id,
	game_id,
	outs,
	hits,
	runs,
	earned_runs,
	walks,
	strikeouts,
	home_runs,
	hit_by_pitch,
	batters_faced
FROM silver.full_game_analysis_pitch_complete