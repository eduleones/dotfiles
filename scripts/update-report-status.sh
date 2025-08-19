#!/bin/bash

file="update-report-status.csv"
output_file="update-report-status_result.txt"

base_command='nu ser curl put s19 xico "/api/admin/commitment/execution/<execution-id>/schedule-execution?trigger-commitment=true&trigger-date=2024-08-22" --cid xico-crash-tempo-<trigger-id>'

while IFS= read -r trigger_id
do
   if [ -n "$trigger_id" ]; then
      command="${base_command//<trigger-id>/$trigger_id}"
      output=$(eval "$command" 2>&1)
      echo $command
      #echo "$output" >> "$output_file"
   fi
done < "$file"