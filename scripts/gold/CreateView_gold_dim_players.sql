/*
=================================================================================
Create view to extract create dimension table containing player info
=================================================================================
*/

IF OBJECT_ID('gold.dim_players', 'V') IS NOT NULL
	DROP VIEW  gold.dim_players
GO

CREATE VIEW gold.dim_players AS

SELECT
	player_id,
	CONCAT(UPPER(SUBSTRING(name_first,1,1)),SUBSTRING(name_first,2,LEN(name_first)), ' ',
	UPPER(SUBSTRING(name_last,1,1)),SUBSTRING(name_last,2,LEN(name_last))) AS player_name,
	YEAR(first_season) AS first_season,
	YEAR(last_season) AS last_season
FROM silver.batters
UNION
SELECT
	player_id,
	CONCAT(UPPER(SUBSTRING(name_first,1,1)),SUBSTRING(name_first,2,LEN(name_first)), ' ',
	UPPER(SUBSTRING(name_last,1,1)),SUBSTRING(name_last,2,LEN(name_last))) AS player_name,
	YEAR(first_season) AS first_season,
	YEAR(last_season) AS last_season
FROM silver.pitchers