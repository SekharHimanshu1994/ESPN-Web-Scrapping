USE ESPN;
SELECT * FROm result_table;
##
## In 2011 Indian won the world cup so we will look into how many matches every country played from
## 2007 worldcup ended on 28th April 2007 and 2011 worlcup started on 19th Feb 2011 so we will look between those dates
SELECT Team_name, 
COUNT(1) AS no_of_matches_played, 
sum(win_flag) AS no_of_wins, 
COUNT(1)- sum(win_flag) AS no_of_loss 
FROM(
SELECT Team1 AS Team_name,
CASE
 WHEN Team1 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2007-04-29' AND '2011-02-18'
 UNION ALL
 SELECT Team2 AS Team_name,
CASE
 WHEN Team2 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2007-04-29' AND '2011-02-18') A
 GROUP BY 1
 ORDER  BY 2 DESC;
## In 2015 Australia won the world cup so we will look into how many matches every country played from
## 2011 worldcup ended on 2nd April 2011 and 2015 worlcup started on 14th Feb 2015 so we will look between those dates
SELECT Team_name, 
COUNT(1) AS no_of_matches_played, 
sum(win_flag) AS no_of_wins, 
COUNT(1)- sum(win_flag) AS no_of_loss 
FROM(
SELECT Team1 AS Team_name,
CASE
 WHEN Team1 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2011-04-03' AND '2015-02-13'
 UNION ALL
 SELECT Team2 AS Team_name,
CASE
 WHEN Team2 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2011-04-03' AND '2015-02-13') A
 GROUP BY 1
 ORDER  BY 2 DESC;
## In 2019 England won the world cup so we will look into how many matches every country played from
## 2015 worldcup ended on 29th Mar 2015 and 2019 worlcup started on 30th May 2019 so we will look between those dates
SELECT Team_name, 
COUNT(1) AS no_of_matches_played, 
sum(win_flag) AS no_of_wins, 
COUNT(1)- sum(win_flag) AS no_of_loss 
FROM(
SELECT Team1 AS Team_name,
CASE
 WHEN Team1 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2015-03-30' AND '2019-05-29'
 UNION ALL
 SELECT Team2 AS Team_name,
CASE
 WHEN Team2 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2015-03-30' AND '2019-05-29') A
 GROUP BY 1
 ORDER  BY 2 DESC;
## Prediction or Trend Analysis
## 2019 worldcup ended on 14th July 2019  so we will look from this day to 2022 end
SELECT Team_name, 
COUNT(1) AS no_of_matches_played, 
sum(win_flag) AS no_of_wins, 
COUNT(1)- sum(win_flag) AS no_of_loss 
FROM(
SELECT Team1 AS Team_name,
CASE
 WHEN Team1 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2019-05-15' AND '2022-12-31'
 UNION ALL
 SELECT Team2 AS Team_name,
CASE
 WHEN Team2 = Winner THEN 1
 ELSE 0
 END AS win_flag FROM result_table
 WHERE Match_Date BETWEEN '2019-05-15' AND '2022-12-31') A
 GROUP BY 1
 ORDER  BY 2 DESC;





