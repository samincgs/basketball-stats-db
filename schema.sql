-- In this SQL file, write (and comment!) the schema of your database, including the CREATE TABLE, CREATE INDEX, CREATE VIEW, etc. statements that compose it

-- schema
CREATE TABLE IF NOT EXISTS teams (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    coach VARCHAR(100),
    court_name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS players (
    id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position ENUM('Point Guard', 'Shooting Guard', 'Center', 'Power Forward', 'Small Forward') NOT NULL,
    height_cm INT NOT NULL,
    weight_kg DECIMAL(5, 2) NOT NULL,
    team_id INT,
    FOREIGN KEY(team_id) REFERENCES teams(id)
);

CREATE TABLE IF NOT EXISTS seasons (
    id INT PRIMARY KEY AUTO_INCREMENT,
    year INT NOT NULL UNIQUE,
    start_date DATE,
    end_date DATE
);

CREATE TABLE IF NOT EXISTS games (
    id INT PRIMARY KEY AUTO_INCREMENT,
    game_date DATE NOT NULL,
    home_team_id INT NOT NULL,
    away_team_id INT NOT NULL,
    score_home INT,
    score_away INT,
    season_id INT,
    FOREIGN KEY (home_team_id) REFERENCES teams(id),
    FOREIGN KEY (away_team_id) REFERENCES teams(id),
    FOREIGN KEY (season_id) REFERENCES seasons(id)
);

CREATE TABLE IF NOT EXISTS player_stats (
    id INT PRIMARY KEY AUTO_INCREMENT,
    player_id INT NOT NULL,
    game_id INT NOT NULL,
    points INT DEFAULT 0,
    rebounds INT DEFAULT 0,
    assists INT DEFAULT 0,
    steals INT DEFAULT 0,
    blocks INT DEFAULT 0,
    fouls INT DEFAULT 0,
    minutes_played INT,
    FOREIGN KEY (player_id) REFERENCES players(id),
    FOREIGN KEY (game_id) REFERENCES games(id),
    UNIQUE(player_id, game_id)
);

-- indexes
CREATE INDEX player_index ON player_stats(player_id)
CREATE INDEX player_game_index ON player_stats(game_id);

-- views

CREATE VIEW player_totals_by_season AS
SELECT 
    p.id AS player_id,
    p.first_name,
    p.last_name,
    s.year AS season,
    SUM(ps.points) AS total_points,
    SUM(ps.rebounds) AS total_rebounds,
    SUM(ps.assists) AS total_assists,
    SUM(ps.steals) AS total_steals,
    SUM(ps.blocks) AS total_blocks,
    SUM(ps.minutes_played) AS total_minutes
FROM player_stats ps
JOIN players p ON ps.player_id = p.id
JOIN games g ON ps.game_id = g.id
JOIN seasons s ON g.season_id = s.id
GROUP BY p.id, s.year;