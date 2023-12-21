#!/bin/bash

# Get a list of deployments (JSON format)
deployments_json=$(aws deploy list-deployments --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP --output json)

# Extract the latest deployment ID
latest_deployment_id=$(jq -r '.deployments | max_by(.createTime) | .deploymentId' <<< "$deployments_json")

# Handle potential errors
if [[ -z "$latest_deployment_id" ]]; then
  echo "Error: Failed to retrieve latest deployment ID."
  exit 1
fi

# Print the latest deployment ID
echo "Latest deployment ID: $latest_deployment_id"
