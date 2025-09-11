-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- 1. Get all players on a specific team
SELECT first_name, last_name, position
FROM players
WHERE team_id = 1;

-- 2. Find all games in a given season
SELECT id, game_date, home_team_id, away_team_id, score_home, score_away
FROM games
WHERE season_id = 2;

-- 3. Get the total points scored by a player in a season (using the player_totals_by_season view)
SELECT first_name, last_name, season, total_points
FROM player_totals_by_season
WHERE player_id = 5 AND season = 2024;

-- 4. Find the top 5 scorers in a season
SELECT first_name, last_name, season, total_points
FROM player_totals_by_season
WHERE season = 2024
ORDER BY total_points DESC
LIMIT 5;

-- 5. Get average points per game for a player in a specific season
SELECT p.first_name, p.last_name, s.year AS season, AVG(ps.points) AS avg_points_per_game
FROM player_stats ps
JOIN players p ON ps.player_id = p.id
JOIN games g ON ps.game_id = g.id
JOIN seasons s ON g.season_id = s.id
WHERE p.id = 5 AND s.year = 2024
GROUP BY p.id, s.year;

-- 6. List all players with their total points, rebounds, and assists across all games
SELECT p.first_name, p.last_name, SUM(ps.points) AS total_points,SUM(ps.rebounds) AS total_rebounds,SUM(ps.assists) AS total_assists
FROM player_stats ps
JOIN players p ON ps.player_id = p.id
GROUP BY p.id
ORDER BY total_points DESC;

