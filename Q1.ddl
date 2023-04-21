SELECT * FROM batting LIMIT 50;
ALTER TABLE batting
RENAME COLUMN BF TO Ball_Faced,
RENAME COLUMN  SR TO Strike_Rate,
RENAME COLUMN  `Start.Date` TO Start_Date;
SELECT * FROM batting LIMIT 50;
UPDATE batting SET Start_Date = DATE(Start_Date);
SELECT * FROM batting LIMIT 50;
RENAME TABLE worlfcup_date_table TO worldcup_date_table;
SELECT * FROM worldcup_date_table;
ALTER TABLE worldcup_date_table
RENAME COLUMN `Starting Date` TO Start_Date,
RENAME COLUMN `Finshed Date` TO Finish_Date;
-- 1.	How many matches were played between 2007 and 2011, and what was the average score per innings for each team

SELECT 
    team, 
    COUNT(DISTINCT(Start_Date)) AS total_matches, 
    CEIL(SUM(Runs)/COUNT(DISTINCT(Start_Date))) AS Avg_Score
FROM batting
WHERE Start_Date BETWEEN  (SELECT (Finish_Date+1) FROM worldcup_date_table WHERE Worldcup = 2007) AND 
                          (SELECT (Start_Date-1) FROM worldcup_date_table WHERE Worldcup = 2011)
GROUP BY 1
ORDER By 1
