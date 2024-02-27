#!/bin/bash

# Function to validate input
validate_input() {
    local input=$1
    local options=$2

    for option in $options; do
        if [ "${input,,}" == "${option,,}" ]; then  # Convert both input and option to lowercase for comparison
            return 0
        fi
    done
    return 1
}

# Function to prompt user for input with validation
prompt_input() {
    local prompt_message=$1
    local options=$2
    local input

    while true; do
        read -p "$prompt_message: " input
        input=$(echo "$input" | tr '[:upper:]' '[:lower:]')  # Convert input to lowercase
        if validate_input "$input" "$options"; then
            echo "$input"
            break
        else
            echo "Invalid input. Please choose from options: $options"
        fi
    done
}

# Prompt user for input
component=$(prompt_input "Enter Component Name[INGESTOR,JOINER,WRANGLER,VALIDATOR]" "INGESTOR JOINER WRANGLER VALIDATOR")
scale=$(prompt_input "Enter Scale[MID,HIGH,LOW]" "MID HIGH LOW")
view=$(prompt_input "Enter View[Auction,Bid]" "Auction Bid")
count=$(prompt_input "Enter Count (single digit)" "0 1 2 3 4 5 6 7 8 9")

# Replace view with appropriate values
if [ "$view" == "auction" ]; then
    view="vdopiasample"
elif [ "$view" == "bid" ]; then
    view="vdopiasample-bid"
fi

# Write to conf file
echo "$view ; $scale ; $component ; ETL ; vdopia-etl= $count" > sig2.conf

echo "Configuration updated successfully."
                                                                                                                                                   1,11          Top
