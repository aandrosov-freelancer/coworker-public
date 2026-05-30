#!/bin/bash

# Configuration
FUNCTION_URL="http://127.0.0.1:54321/functions/v1/match"
TASK_ID=1 # Change this to a valid task_id from your database

echo "--- Testing 'match' Edge Function ---"
echo "Target URL: $FUNCTION_URL"
echo "Task ID: $TASK_ID"
echo "--------------------------------------"

# Execute the request
curl -i --location --request POST "$FUNCTION_URL" \
  --header "Content-Type: application/json" \
  --data "{\"task_id\": $TASK_ID}"

echo -e "\n--------------------------------------"
echo "Test execution complete."
