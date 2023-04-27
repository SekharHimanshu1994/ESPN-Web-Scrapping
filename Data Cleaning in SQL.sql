SELECT * FROM fielding LIMIT 50;
-- Changing table names
ALTER TABLE final_table_batting RENAME TO batting;
ALTER TABLE final_table_bowling RENAME TO bowling;
ALTER TABLE final_table_fielding RENAME TO fielding;
-- Chnaging column names
    -- For Batting Table
ALTER TABLE batting
RENAME COLUMN `SCJ Broad` TO player
RENAME COLUMN SCJ Broad TO player,
RENAME COLUMN BF TO ball_faced,
RENAME COLUMN SR TO strike_rate,
RENAME COLUMN `Start.Date` TO `start_date`;
    -- For Bowling Table
ALTER TABLE bowling 
RENAME COLUMN Runs TO run_concealed,
RENAME COLUMN `Start.Date` TO `start_date`; 
    -- For Fielding Table
ALTER TABLE fielding 
RENAME COLUMN Dis TO dismissal,
RENAME COLUMN Ct TO catches,
RENAME COLUMN St TO stumping,
RENAME COLUMN `Ct.Wk` TO catches_wicket_keeper,
RENAME COLUMN `Ct.Fi` TO catches_fielder,
RENAME COLUMN `Start.Date` TO `start_date`;