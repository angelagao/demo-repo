#Title: Teams Table
#Description: Data Preparation
#Input: Ranking variables
#Output: Table

nba <- read.csv('/Users/angelagao/Desktop/hw-stat133/workout1/data/nba2018.csv')

levels(nba$position) <- c("center", "power_fwd", "point_guard", "small_fwd", "shoot_guard")

nba$experience = as.character(nba$experience)

nba$salary = nba$salary/1000000

nba$missed_field_goals <- nba$field_goals_atts - nba$field_goals
nba$missed_free_throws <- nba$points1_atts - nba$points1
nba$rebounds <- nba$off_rebounds + nba$def_rebounds
nba$efficiency <- (nba$points + nba$rebounds+ nba$assists+ nba$steals+ nba$blocks + nba$missed_field_goals + nba$missed_free_throws - nba$turnovers) /nba$games

sink("efficiency-summary.txt")
print(summary(nba$efficiency))
sink()


ex <- nba$experience[nba$experience == "R"] <- 0


aggdata <- aggregate(list(nba$points3, ex, nba$salary, nba$points2, nba$points1, nba$points, nba$off_rebounds, nba$def_rebounds, nba$assists, nba$steals, nba$blocks, nba$turnovers, nba$fouls, nba$efficiency), by=list(nba$team), FUN=sum)
names(aggdata) <- c("Points3", "Experience", "Salary", "Points2", "Points1", "Total Points", "Offensive Rebounds", "Defensive Rebounds", "Assists", "Steals", "Blocks", "Turnovers", "Fouls", "Efficiency")

sink("teams-summary.txt")
print(summary(aggdata))
sink()

team <- data.frame(aggdata)

sink("nba-teams.csv")
print(write.csv(aggdata))
sink()
