library(rvest)
library(htmltools)
library(magrittr)
library(dplyr)
library(tidyverse)

# The solution is the same for all types, including batting, bowling, fielding, and partnership. # nolint
# The comments only provides instructions for the batting loop.
# Four separate tables will be created because the column number and content are different for each table.  # nolint
# Team 1 is England, the 2019 World Cup Champion. Team 2 is Australia, the 2015 World Cup Champion. Team 6 is India, the 2011 World Cup Champion. # nolint
# The nolint flag is used to ignore any linter warnings for characters exceeding 80. # nolint


# Defining teams and seasons to scrape
teamz <- c(1, 2, 6)
season <- c("2007%2F08", "2008%2F09", "2009%2F10", "2010%2F11", "2011%2F12",
            "2012%2F13", "2013%2F14", "2014%2F15", "2015%2F16", "2016%2F17",
            "2017%2F18", "2018%2F19", "2019%2F20", "2020%2F21", "2021%2F22",
            "2022%2F23")

# ---------------------Code for scrapping batting Table------------------------

# Initializing an empty list to store all scraped data
all_team_batting_table <- list()

# Looping through each team and season to scrape data
for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      # Building URL for each page to scrape
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=batting;view=innings") # nolint

      # Reading HTML from URL and extract number of pages of data available
      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      # Using if function to go only to pages with available data as page numbers are uncertain  # nolint
      if (length(html_object) > 0 && i <= html_object) {
        # Read HTML from URL and extract batting table data
        temp_batting_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        # Adding year and team columns to batting table data
        temp_batting_table$year <- paste0(year, "_", i)
        temp_batting_table$team <- team
        # Adding scraped data to list of all scraped data
        all_team_batting_table[[length(all_team_batting_table) + 1]] <- temp_batting_table # nolint
        # Print message indicating progress
        # Page and Column number is included for checking every page have same number of columns # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_batting_table), "columns")) # nolint
      }
    }
  }
  # Print message indicating progress
  print(year)
  # Print message indicating completion
print(team)
}

# Combining all scraped data into a single data frame
final_table_batting<- do.call(rbind, all_team_battingg_table)

# View and save the final data frame
View(final_table_batting)
# Set your working director before exporting
write.csv(final_table_batting, "final_table_batting.csv")
#---------------------End for scrapping batting Table------------------------

# ---------------------Code for scrapping Bowling Table------------------------

all_team_bowling_table <- list()

for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=bowling;view=innings") # nolint

      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      if (length(html_object) > 0 && i <= html_object) {
        temp_bowling_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        temp_bowling_table$year <- paste0(year, "_", i)
        temp_bowling_table$team <- team
        all_team_bowling_table[[length(all_team_bowling_table) + 1]] <- temp_bowling_table # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_bowling_table), "columns")) # nolint
      }
    }
     print(year)
  }
print(team)
}

final_table_bowling <- do.call(rbind, all_team_bowling_table)

View(final_table_bowling)
write.csv(final_table_bowling, "final_table_bowling.csv")
#---------------------End for scrapping bowling Table------------------------

# ---------------------Code for scrapping Fielding Table------------------------

all_team_fielding_table <- list()

for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=fielding;view=innings") # nolint

      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      if (length(html_object) > 0 && i <= html_object) {
        temp_fielding_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        temp_fielding_table$year <- paste0(year, "_", i)
        temp_fielding_table$team <- team
        all_team_fielding_table[[length(all_team_fielding_table) + 1]] <- temp_fielding_table # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_fielding_table), "columns")) # nolint
      }
    }
     print(year)
  }
print(team)
}

final_table_fielding <- do.call(rbind, all_team_fielding_table)

View(final_table_fielding)
write.csv(final_table_fielding, "final_table_fielding.csv") # nolint
#---------------------End for scrapping fielding Table------------------------

# ---------------Code for scrapping Partnership/Fow Table----------------

# For partnership table the number of columns for 2011-12 season for team 6 not macthing from rest of the data. # nolint
# So it will be in three steps process :-
   # 1.Looping all the teams for all season except 2011-12 season
   # 2.Looing for all teams for 2011-12 season except team 6
   # 3.Looping for team 6 for 2011-12 season

# 1.Looping all the teams for all season except 2011-12 season

season <- c("2007%2F08", "2008%2F09", "2009%2F10", "2010%2F11",
            "2012%2F13", "2013%2F14", "2014%2F15", "2015%2F16", "2016%2F17",
            "2017%2F18", "2018%2F19", "2019%2F20", "2020%2F21", "2021%2F22",
            "2022%2F23")

all_team_fow_table <- list()

for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=fow;view=innings") # nolint

      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      if (length(html_object) > 0 && i <= html_object) {
        temp_fow_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        temp_fow_table$year <- paste0(year, "_", i)
        temp_fow_table$team <- team
        all_team_fow_table[[length(all_team_fow_table) + 1]] <- temp_fow_table # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_fow_table), "columns")) # nolint
      }
    }
     print(year)
  }
print(team)
}

final_table_fow <- do.call(rbind, all_team_fow_table)

View(final_table_fow)
write.csv(final_table_fow, "final_table_fow-1.csv")

 # 2.Looing for all teams for 2011-12 season except team 6

teamz <- c(1, 2)
season <- c("2011%2F12")

all_team_fow_table <- list()

for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=fow;view=innings") # nolint

      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      if (length(html_object) > 0 && i <= html_object) {
        temp_fow_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        temp_fow_table$year <- paste0(year, "_", i)
        temp_fow_table$team <- team
        all_team_fow_table[[length(all_team_fow_table) + 1]] <- temp_fow_table # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_fow_table), "columns")) # nolint
      }
    }
     print(year)
  }
print(team)
}

final_table_fow <- do.call(rbind, all_team_fow_table)

View(final_table_fow)
write.csv(final_table_fow, "final_table_fow-2.csv")

# 3.Looping for team 6 for 2011-12 season

teamz <- c(6)
season <- c("2011%2F12")

all_team_fow_table <- list()

for (team in teamz) {
  for (year in season) {
    for (i in 1:9) {
      url <- paste0("https://stats.espncricinfo.com/ci/engine/stats/index.html?class=2;page=",i,";season=",year, # nolint
                    ";team=", team, ";template=results;type=fow;view=innings") # nolint

      html_object <- url %>%
                     read_html() %>%
                     html_nodes(".engineTable:nth-child(4) .left:nth-child(1) b+ b") %>% # nolint
                     html_text()

      if (length(html_object) > 0 && i <= html_object) {
        temp_fow_table <- url %>%
                              read_html() %>%
                              html_nodes("#ciHomeContentlhs > div.pnl650M > table:nth-child(5)") %>% # nolint
                              html_table() %>%
                              as.data.frame()
        temp_fow_table$year <- paste0(year, "_", i)
        temp_fow_table$team <- team
        all_team_fow_table[[length(all_team_fow_table) + 1]] <- temp_fow_table # nolint
        print(paste("Team",team,"page",i,"for",year, "has", ncol(temp_fow_table), "columns")) # nolint
      }
    }
     print(year)
  }
print(team)
}

final_table_fow <- do.call(rbind, all_team_fow_table)

View(final_table_fow)
write.csv(final_table_fow, "final_table_fow-3.csv") 

#---------------------End for scrapping fow Table------------------------