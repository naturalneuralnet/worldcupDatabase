#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

# cat and pipe the data from the csv file
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
# if year is not year
  if [[ $YEAR != "year" ]]
  then
    echo $WINNER
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
  # if winner is not in teams
    if [[ -z $WINNER_ID ]]
    then
  # add winner and opponent to teams
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Team $WINNER inserted into teams.
      fi
    fi
    if [[ -z $OPPONENT_ID ]]
    then
    # add winner and opponent to teams
      INSERT_TEAM_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ $INSERT_TEAM_RESULT == "INSERT 0 1" ]]
      then
        echo Team $OPPONENT inserted into teams.
      fi
    fi
  
  # get game_id
   
    
  
  fi
    # if insert successful echo INSERT 0 1
  
  
  
done
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    echo $WINNER
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    echo $YEAR $ROUND $WINNER_ID $OPPONENT_ID
    GAME_INSERT_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
    VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS)")
    echo $GAME_INSERT_RESULT
    if [[ GAME_INSERT_RESULT = "INSERT 0 1" ]]
    then
      echo Game $YEAR $ROUND with Winner $WINNER and Opponent $OPPONENT
    fi
  fi
done
# teams data, team names? every unique country?

# loop through the data somehow and insert it into the database