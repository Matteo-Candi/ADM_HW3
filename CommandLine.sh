#!/bin/bash

# We put in an array all the countries that we want to process
# For all the countries containing a space in its names (like United States), we replace it with an underscore (_)
# because otherwise we will not be able to get the full name when we will loop on the values of the array countries
countries=("Italy" "Spain" "France" "England" "United_States")

# We loop on each country
for country in ${countries[@]};
do
  country=${country/_/ } # we use this command for the string 'United_States' to get 'United States'
  echo Country : ${country}

  echo Number of places that can be found in ${country} :
  # Thanks to the command cut, we can get only the data of the attributes that we need : numPeopleVisited, numPeopleWant, placeAddress
  # Then, with the command grep we get the data only for the country that we are dealing with
  # We are sure that the country will match in placeAddress column because other attributes (numPeopleVisited, numPeopleWant) are not strings
  # So, we will not have rows with country matching on the descriptions attributes and not in placeAddress for example
  # And with the command wc -l we get all the lines of those data
  nb_places=$(cut -f 3,4,8 locations_data.tsv | grep "${country}" | wc -l)
  echo $nb_places

  s=0
  # here, cut -f 1 gives us only the data of the attribute numPeopleVisited of each place of this country
  for numPeopleVisited in $(cut -f 3,4,8 locations_data.tsv | grep "${country}" | cut -f 1); do
    s=$(( $s+$numPeopleVisited ))
  done
  echo Average visit of the places of ${country} :
  s=$(( $s/$nb_places ))
  echo $s

  c=0
  # here, cut -f 2 gives us only the data of the attribute numPeopleWant of each place of this country
  for numPeopleWant in $(cut -f 3,4,8 locations_data.tsv | grep "${country}" | cut -f 2); do
    c=$(( $c+$numPeopleWant ))
  done
  echo People that want to visit the places of ${country} :
  echo $c

  echo
done
