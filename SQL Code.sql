USE ESPN;

-- Query to get all rows from result_table
SELECT * FROM result_table;

-- Query to get number of matches played, wins, and losses for each team between 2007 and 2011
-- Indian won the world cup in 2011
SELECT 
    Team_name, 
    COUNT(1) AS no_of_matches_played, 
    sum(win_flag) AS no_of_wins, 
    COUNT(1) - sum(win_flag) AS no_of_loss 
FROM (
    SELECT 
        Team1 AS Team_name,
        CASE
            WHEN Team1 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2007-04-29' AND '2011-02-18'
    UNION ALL
    SELECT 
        Team2 AS Team_name,
        CASE
            WHEN Team2 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2007-04-29' AND '2011-02-18'
) A
GROUP BY 1
ORDER BY 2 DESC;

-- Query to get number of matches played, wins, and losses for each team between 2011 and 2015
-- Australia won the world cup in 2015
SELECT 
    Team_name, 
    COUNT(1) AS no_of_matches_played, 
    sum(win_flag) AS no_of_wins, 
    COUNT(1) - sum(win_flag) AS no_of_loss 
FROM (
    SELECT 
        Team1 AS Team_name,
        CASE
            WHEN Team1 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2011-04-03' AND '2015-02-13'
    UNION ALL
    SELECT 
        Team2 AS Team_name,
        CASE
            WHEN Team2 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2011-04-03' AND '2015-02-13'
) A
GROUP BY 1
ORDER BY 2 DESC;

-- Query to get number of matches played, wins, and losses for each team between 2015 and 2019
-- England won the world cup in 2019
SELECT 
    Team_name, 
    COUNT(1) AS no_of_matches_played, 
    SUM(win_flag) AS no_of_wins, 
    COUNT(1) - SUM(win_flag) AS no_of_loss 
FROM (
    SELECT 
        Team1 AS Team_name,
        CASE
            WHEN Team1 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2015-03-30' AND '2019-05-29'
    UNION ALL
    SELECT 
        Team2 AS Team_name,
        CASE
            WHEN Team2 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2015-03-30' AND '2019-05-29'
) A
GROUP BY 1
ORDER BY 2 DESC;
-- Query to get number of matches played, wins, and losses for each team between 2019 and 2022
-- 2023 data will be colleted in September 2023 as in October 2023 the world cup will begin.
SELECT 
    Team_name, 
    COUNT(1) AS no_of_matches_played, 
    SUM(win_flag) AS no_of_wins, 
    COUNT(1) - SUM(win_flag) AS no_of_loss 
FROM (
    SELECT 
        Team1 AS Team_name,
        CASE
            WHEN Team1 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2019-05-15' AND '2022-12-31'
    UNION ALL
    SELECT 
        Team2 AS Team_name,
        CASE
            WHEN Team2 = Winner THEN 1
            ELSE 0
        END AS win_flag 
    FROM result_table
    WHERE Match_Date BETWEEN '2019-05-15' AND '2022-12-31'
) A
GROUP BY 1
ORDER BY 2 DESC;





