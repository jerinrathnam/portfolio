#!/bin/bash

# Get a list of deployments (JSON format)
deployments_json=$(aws deploy list-deployments --application-name $APPLICATION_NAME --deployment-group-name $DEPLOYMENT_GROUP --output json)

# Extract the latest deployment ID
#latest_deployment_id=$(cat $deployments_json | jq '.deployments[0]')
latest_deployment_id=$(jq -r '.deployments[0]' <<< "$deployments_json")

# Print the latest deployment ID
echo "Latest deployment ID: $latest_deployment_id"

aws deploy wait deployment-successful --deployment-id $latest_deployment_id