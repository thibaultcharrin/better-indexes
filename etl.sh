#!/bin/bash

# VARIABLES
WORKSPACE=$(pwd)
INPUT="EXPORT"
OUTPUT="PHOTOS"

# FUNCTIONS
function whitespace_to_underscore() {
    echo -e "\n*** Replacing whitespaces with underscores in ${INPUT} ***"
    while [[ $(find -type f | grep " " | wc -l) != 0 ]]
    do    
        find -type d -name "* *" -print | awk '{print;gsub(" ","_",$0);print}' | xargs -r -n2 -d "\n" mv
        find -type f -name "* *" -print | awk '{print;gsub(" ","_",$0);print}' | xargs -r -n2 -d "\n" mv
    done
}

function ETL() {
    echo -e "\n*** Extract Transform Load ***"
    ELEMENTS=$(find $INPUT -type f)
    echo -e "\tSOURCE: "
    echo $ELEMENTS

    if [[ ! -d $OUTPUT ]]
    then
        mkdir $OUTPUT
    fi

    echo -e "\n\tDESTINATION:"
    for ELEMENT in ${ELEMENTS[*]};
    do
        src_path=$(echo $ELEMENT)
        DESTINATION=$(echo ${src_path#*/} | sed -e 's|/|_|g' )
        echo $DESTINATION
        cp -r $src_path $OUTPUT/$DESTINATION 
    done
}

# STEPS
whitespace_to_underscore
ETL
echo -e "\nYou're all set !"
read -p "Press enter to exit"
exit 0
