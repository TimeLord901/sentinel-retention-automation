# Sentinel Retention Automation

This Bash script loops through every table in an Azure Sentinel workspace and sets retention to **730 days**.

## How to use
1. Fill in your `SUBSCRIPTION_ID`, `RESOURCE_GROUP`, and `WORKSPACE_NAME`.
2. Run:
   ```bash
   chmod +x update_retention.sh
   ./update_retention.sh
