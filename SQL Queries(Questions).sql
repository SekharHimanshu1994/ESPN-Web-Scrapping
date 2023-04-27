/*1. How many matches were played between 2007 and 2011, and what was the average score per innings for each team?*/
SELECT
    team,
    COUNT(DISTINCT(start_date)) AS total_matches,
    CEIL(SUM(Runs)/COUNT(DISTINCT(start_date))) AS avg_score /*total runs by total matches, rounding up to the nearest integer*/
FROM batting
/*Selecting the dates after completion of previous world cup and before beginning of current world cup*/
WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                         (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
GROUP BY 1
ORDER By 1;

/*2. What was the total matches, total runs, batting average, strike rate, and number of centuries for each player between 2007 and 2011 for Team India?*/
SELECT
    player,
    COUNT(DISTINCT(Start_Date)) AS total_matches,
    SUM(Runs) AS total_runs,
    ROUND((SUM(Runs)/COUNT(Inns)),2) AS Avg_Score, -- dividing total runs by total innings, rounding to 2 decimal places
    ROUND((SUM(Strike_Rate)/(COUNT(Inns))),2) AS Avg_Strike_Rate, -- dividing total Strike Rate by total innings, rounding to 2 decimal places
    SUM(CASE WHEN Runs >=100 THEN 1 ELSE 0 END) AS No_of_Century -- Count the number of centuries scored by the player
FROM batting
WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                         (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
AND team = 6 -- Filter for Team India
AND Runs NOT IN ('DNB', 'TDNB', 'sub') -- Exclude cases where the player did not bat
AND Strike_Rate <> 'No Ball Faced' -- Exclude cases where the player did not face a ball
GROUP BY 1
ORDER BY 2 DESC;

/*3. What was the total overs, total wickets, Average Economy for each player between 2007 and 2011 for Team India?*/
WITH CTE AS(
            SELECT
                Player,
 /*Using Truncate to remove decimal places like 8.3 to (8*6+0.3*10)=51 balls otherwise the code will add 8.3+8.5=16.8 which is incorrect*/
                SUM((TRUNCATE(Overs, 0)*6) + ((ROUND((Overs - TRUNCATE(Overs, 0)),1))*10)) AS total_balls, 
                SUM(Wkts) AS total_wickets,
                ROUND((SUM(Econ)/COUNT(Inns)),2) AS Average_Economy -- total runs conceded by total innings
            FROM bowling
            WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                                     (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
            AND team = 6
            AND Overs NOT IN ('DNB', 'TDNB') 
            AND Inns NOT IN ('DNB', 'TDNB') 
            GROUP BY 1
            ORDER BY 3 DESC)
/*Using CTE expression to calculate total over by a player after the aggregation and group statement */
SELECT
    *,
/*Using Truncate to remove decimal places and modulus functio otherwise the code will take 40 balls to 6.66 over instead of 6.4 over*/
    CONCAT(TRUNCATE((total_balls/6),0), '.',(total_balls % 6)) AS total_over -- Converting total balls to overs
FROM CTE;

/*4. What was the total dismissal, total cathces taken for each player between 2007 and 2011 for Team India?*/
SELECT
    Player,
    SUM(dismissal) AS total_dismissal,
    SUM(catches) AS total_catches
FROM fielding
WHERE Start_Date BETWEEN (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) 
                                                        AND
                         (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
AND team = 6
GROUP BY 1
ORDER BY 2 DESC, 3 DESC;
