#!/bin/bash

file="commitment_schedule_trigger_ids.txt"
output_file="commitment_schedule_trigger_ids_result.txt"

base_command='nu ser curl put s19 xico "/api/admin/trigger-type/commitment-schedule-trigger/trigger-id/<trigger-id>/schedule-execution?trigger-commitment=true&trigger-date=2024-08-22" --cid xico-crash-tempo-<trigger-id>'

while IFS= read -r trigger_id
do
   if [ -n "$trigger_id" ]; then
      command="${base_command//<trigger-id>/$trigger_id}"
      output=$(eval "$command" 2>&1)
      echo $command
      #echo "$output" >> "$output_file"
   fi
done < "$file"