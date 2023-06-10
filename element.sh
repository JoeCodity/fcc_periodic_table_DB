#!/usr/bin/env bash
PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"

#Check if variable is empty
if [[ -z $1 ]]
then
echo "Please provide an element as an argument."
else
# Check if the input is a number
pattern='^[0-9]+$'
#Make SQL querry to fetch data from database.
if [[ $1 =~ $pattern ]]
 then
    SEARCH_RESULT=$($PSQL "SELECT * FROM elements LEFT JOIN properties ON elements.atomic_number = properties.atomic_number where properties.atomic_number = '$1';")

else
    SEARCH_RESULT=$($PSQL "SELECT * FROM elements LEFT JOIN properties ON elements.atomic_number = properties.atomic_number where symbol = '$1' or name = '$1';")
fi
if [[ -z $SEARCH_RESULT ]]
then
echo "I could not find that element in the database."
else
# Split input and paste into string.
IFS='|' read -r atomic_number symbol name group a_type atomic_weight melting_point boiling_point period <<< "$SEARCH_RESULT"
echo "The element with atomic number $atomic_number is $name ($symbol). It's a $a_type, with a mass of $atomic_weight amu. $name has a melting point of $melting_point celsius and a boiling point of $boiling_point celsius."
fi
fi