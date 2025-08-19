#!/bin/bash

file="update-report-status.csv"
output_file="update-report-status_result.txt"

base_command='nu ser curl put s19 xico "/api/admin/commitment/execution/<execution_id>" --data "{\"report-status\":\"<report_status>\"}"'

while IFS=, read -r execution_id report_status
do
   if [ -n "$execution_id" ] && [ -n "$report_status" ]; then
      command="${base_command//<execution_id>/$execution_id}"
      command="${command//<report_status>/$report_status}"
      output=$(eval "$command" 2>&1)
      echo $command
      echo "$output" >> "$output_file"
   fi
done < "$file"