#!/usr/bin/env -S bash

# 1) Fill these in with your own values (or load from a .env file)
SUBSCRIPTION_ID="<YOUR_SUBSCRIPTION_ID>"   # e.g. 00000000-0000-0000-0000-000000000000
RESOURCE_GROUP="<YOUR_RESOURCE_GROUP>"     # e.g. myResourceGroup
WORKSPACE_NAME="<YOUR_WORKSPACE_NAME>"     # e.g. mySentinelWorkspace

# 2) Fetch every table name
tables=$(az monitor log-analytics workspace table list \
  --subscription "$SUBSCRIPTION_ID" \
  --resource-group  "$RESOURCE_GROUP" \
  --workspace-name "$WORKSPACE_NAME" \
  --query '[].name' -o tsv)

# 3) Loop and update both retention settings to 730 days (2 years)
while IFS= read -r table; do
  echo "⏳ Updating table: $table"
  az monitor log-analytics workspace table update \
    --subscription         "$SUBSCRIPTION_ID" \
    --resource-group       "$RESOURCE_GROUP"   \
    --workspace-name       "$WORKSPACE_NAME"   \
    --name                 "$table"            \
    --retention-time       730                 \
    --total-retention-time 730
done <<< "$tables"
