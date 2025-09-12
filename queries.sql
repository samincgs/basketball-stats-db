-- In this SQL file, write (and comment!) the typical SQL queries users will run on your database

-- SELECT STATEMENTS

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

-- INSERT STATEMENTS
-- 1. Insert a new player into a team
INSERT INTO players (first_name, last_name, position, height_cm, weight_kg, team_id)
VALUES ('Lebron', 'James', 'Small Forward', 206, 113.4, 1);

-- 2. Insert a new game between two teams in a season
INSERT INTO games (game_date, home_team_id, away_team_id, score_home, score_away, season_id)
VALUES ('2025-01-15', 1, 2, 121, 96, 3);

-- 3. Insert player stats for a game
INSERT INTO player_stats (player_id, game_id, points, rebounds, assists, steals, blocks, fouls, minutes_played)
SELECT p.id, 10, 22, 7, 4, 1, 0, 3, 34
FROM players p
WHERE p.first_name = 'LeBron' AND p.last_name = 'James';

-- UPDATE STATEMENTS
-- 1. Update a players team (trade to another team)
UPDATE players
SET team_id = (SELECT id FROM teams WHERE name = 'Heat')
WHERE first_name = 'LeBron' AND last_name = 'James';

-- 2. Update a game's score after it finishes (lookup game by date and teams)
UPDATE games
SET score_home = 125, score_away = 110
WHERE game_date = '2025-01-15' AND home_team_id = (SELECT id FROM teams WHERE name = 'Lakers') AND away_team_id = (SELECT id FROM teams WHERE name = 'Warriors');

-- 3. Update a players stats after the game
UPDATE player_stats
SET points = 30, rebounds = 8, assists = 5
WHERE player_id = (SELECT id FROM players WHERE first_name = 'LeBron' AND last_name = 'James') AND game_id = (SELECT id FROM games WHERE game_date = '2025-01-15' AND home_team_id = (SELECT id FROM teams WHERE name = 'Lakers') AND away_team_id = (SELECT id FROM teams WHERE name = 'Warriors'));

-- DELETE STATEMENTS
-- 1. Delete a player from the database (e.g., retired or removed)
DELETE FROM players WHERE first_name = 'LeBron' AND last_name = 'James';

-- 2. Delete a game and all associated player stats
DELETE FROM player_stats WHERE game_id = (SELECT id FROM games WHERE game_date = '2025-01-15' AND home_team_id = 1 AND away_team_id = 2);
