-- 1. How many matches were played between 2007 and 2011, and what was the average score per innings for each team
SELECT
    team,
    COUNT(DISTINCT(Start_Date)) AS total_matches,
    CEIL(SUM(Runs)/COUNT(DISTINCT(Start_Date))) AS Avg_Score -- Calculate the average score per innings by dividing total runs by total matches, rounding up to the nearest integer
FROM batting
-- Selecting the dates after completion of previous world cup and before beginning of current world cup
WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                         (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
GROUP BY 1
ORDER By 1;

-- 2. What was the total matches, total runs, batting average, strike rate, and number of centuries for each player between 2007 and 2011 for Team India?
SELECT
    Player,
    COUNT(DISTINCT(Start_Date)) AS total_matches,
    SUM(Runs) AS total_runs,
    ROUND((SUM(Runs)/COUNT(Inns)),2) AS Avg_Score, -- Calculate the batting average by dividing total runs by total innings, rounding to 2 decimal places
    ROUND((SUM(Strike_Rate)/(COUNT(Inns))),2) AS Avg_Strike_Rate, -- Calculate the strike rate by dividing total runs by total balls faced, rounding to 2 decimal places
    SUM(CASE WHEN Runs >=100 THEN 1 ELSE 0 END) AS No_of_Century -- Count the number of centuries scored by the player
FROM batting
WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                         (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
AND team = 6 -- Filter for Team India
AND Runs NOT IN ('DNB', 'TDNB') -- Exclude cases where the player did not bat
AND Strike_Rate <> 'No Ball Faced' -- Exclude cases where the player did not face a ball
GROUP BY 1
ORDER BY 2 DESC;

--3. What was the total overs, total wickets, Average Economy for each player between 2007 and 2011 for Team India?
WITH gg AS(
            SELECT
                Player,
                SUM((TRUNCATE(Overs, 0)*6) + ((ROUND((Overs - TRUNCATE(Overs, 0)),1))*10)) AS total_balls, -- Convert the overs to balls and calculate the total balls bowled
                SUM(Wkts) AS total_wickets, -- Calculate the total wickets taken
                ROUND((SUM(Econ)/COUNT(Inns)),2) AS Average_Economy -- Calculate the average economy by dividing total runs conceded by total innings, rounding to 2 decimal places
            FROM bowling
            WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                                     (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
            AND team = 6 -- Filter for Team India
            AND Overs NOT IN ('DNB', 'TDNB') -- Exclude cases where the player did not bowl
            AND Inns NOT IN ('DNB', 'TDNB') -- Exclude cases where the player did not bowl
            GROUP BY 1
            ORDER BY 3 DESC)
SELECT
    *,
    CONCAT(TRUNCATE((total_balls/6),0), '.',(total_balls % 6)) AS total_over -- Converting total balls to overs
FROM gg;