#!/bin/bash

file="trigger_ids.txt"
output_file="commitment_executions_result.txt"

base_command="nu datomic query s19 xico --env prod --accept application/edn <(echo '{:find [(pull ?commitment-execution [:commitment-execution/id])] :in [$] :where [[?trigger :trigger/id #uuid \"<trigger-id>\"] [?commitment-execution :commitment-execution/trigger ?trigger]]}')"


while IFS= read -r trigger_id
do
   if [ -n "$trigger_id" ]; then
      command="${base_command//<trigger-id>/$trigger_id}"
      output=$(eval "$command" 2>&1)
      echo "$command"
      echo "$output" | grep -oE '\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b' >> "$output_file"
   fi
done < "$file"