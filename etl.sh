#!/bin/bash

# VARIABLES
INPUT="IMPORT"
OUTPUT="EXPORT"

# ARGS
if [[ "$1" != "" ]]; then INPUT="$1"; fi
if [[ "$2" != "" ]]; then OUTPUT="$2"; fi

if [[ ! -d $INPUT ]]; then
    echo "Please add source folder (default: IMPORT), or specify name when running script"
    echo -e "\t./elt.sh [SOURCE_FOLDER]"
    echo "You can also specify the destination folder (default: EXPORT)"
    echo -e "\t./elt.sh [SOURCE_FOLDER] [DESTINATION_FOLDER]"
    read -rp "Press enter to exit"
    exit 0
fi

# FUNCTIONS
function whitespace_to_underscore() {
    echo -e "\n*** Replacing whitespaces with underscores in ${INPUT} ***"
    while [[ $(find -type f | grep -c " ") != 0 ]]
    do    
        find -type d -name "* *" -print | awk '{print;gsub(" ","_",$0);print}' | xargs -r -n2 -d "\n" mv
        find -type f -name "* *" -print | awk '{print;gsub(" ","_",$0);print}' | xargs -r -n2 -d "\n" mv
    done
}

function etl() {
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
etl
echo -e "\nYou're all set !"
read -rp "Press enter to exit"
exit 0
