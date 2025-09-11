# Design Document

By YOUR NAME HERE

Video overview: <URL HERE>

## Scope

In this section you should answer the following questions:

### Purpose

I am a big fan of the NBA and basketball, so I wanted to create a SQL database to store all information about a regular NBA season. This database is designed to track basketball teams, players, games, and player performance statistics over multiple seasons. It allows users to store, organize, and query data such as player stats per game, team performance, and season records.

### Inside the Scope

- **Players:** Personal details such as first name, last name, position, height, weight, and team association.
- **Teams:** Name, city, coach, and home court.
- **Seasons:** Start and end dates, year of the season.
- **Games:** Home and away teams, game date, scores, and season association.
- **Player statistics:** Points, rebounds, assists, steals, blocks, fouls, and minutes played for each game.

### Outside the Scope

- **Detailed historical injury data, player contracts, or salaries.**
- **Off-court events or personal life information about players.**
- **Live tracking of games or real-time updates.**

## Functional Requirements

### User Capabilities

- Add, update, or delete teams, players, seasons, and games.
- Record player statistics for individual games.
- Query total stats for a player across games or within a season.
- Query team scores and game results.
- Identify top scorers, rebounders, or other performance leaders.
- Retrieve game schedules for a specific team or season.

### Beyond the Scope

- Real-time tracking of games or live updates.
- Predictive analytics or machine learning projections.
- Visualization dashboards or graphical reports (though the database can provide data for them).

## Representation

### Entities

In this section you should answer the following questions:

- Which entities will you choose to represent in your database?
- What attributes will those entities have?
- Why did you choose the types you did?
- Why did you choose the constraints you did?

### Relationships

The database is designed with clear relationships between its entities to accurately represent basketball teams, players, games, seasons, and player statistics. Each team can have many players, establishing a one to many relationship between the `teams` and `players` tables. Similarly, each season can include many games, creating a one to many relationship between `seasons` and `games`. The `games` table connects to teams twice, once for the home team and once for the away team, reflecting which teams participated in each game. Players participate in many games, and each game includes many players, which forms a many to many relationship between `players` and `games`. This relationship is implemented through the `player_stats` table, which serves as a bridge table storing performance data for each player in each game. Foreign keys enforce referential integrity across the database, ensuring that all player stats are linked to valid players and games, and all games are associated with existing teams and seasons. Overall, these relationships allow the database to accurately model team rosters, game schedules, player performance, and seasonal statistics.

## Optimizations

To improve the performance of the database, several optimizations were implemented. Indexes were created on the `player_stats` table to speed up common queries. An index on `player_id` allows for fast retrieval of all statistics for a specific player, while an index on `game_id` allows quick access to all player statistics for a particular game. Overall, these optimizations help maintain both speed and accuracy when querying player performance, team results, and season statistics. I only have one view that I commonly used. The `player_totals_by_season` view is an optimization that simplifies and speeds up queries for player performance over a season. Rather than writing a complex query each time to calculate total points, rebounds, assists, steals, blocks, and minutes played, this view pre-aggregates the data by player and season.

## Limitations

The database does not support real-time game tracking or live updates. It does not store detailed historical player injuries, contracts, salaries, or off-court events. Team and player transfers mid-season are not tracked in detail, as the database assumes static team membership per record. Advanced basketball analytics, such as player efficiency ratings, plus-minus, or advanced shooting metrics, are not included. Changes in team names, arenas, or coaching staff over time may be difficult to represent without additional tables or historical tracking. Overall, the database is primarily focused on standard box score statistics and may not capture every nuance of a game or player performance.
