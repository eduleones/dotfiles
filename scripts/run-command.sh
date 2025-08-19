#!/bin/bash

file="commands.txt"
output_file="commands_result.txt"

while IFS= read -r line
do
   if [ -n "$line" ]; then
      output=$(eval "$line" 2>&1)
      echo "$output" >> "$output_file"
   fi
done < "$file"
