# LAPS for Mac Aux Scripts
This is a group of scripts I wrote to make the deployment and management of NU-ITS's LAPSforMac easier
Link: https://github.com/NU-ITS/LAPSforMac

# GetMacLAPS
You can use this script in Jamf as a Self Service policy scoped to IT machines, or as an automator application. It will prompt you for an account with API access, and then you can input a Computer Name, Serial Number, or you can select "This Computer". You will then get the LAPS password stored in Jamf.

# Convert admin account to lapsadmin
You can use this script to rename the account name of an existing account to lapsadmin. We had multiple sites, each with their own admin account. This script allowed them to start using a centrally managed LAPS, while retaining the secure token status of their existing admin accounts. Use parameter 4 to pass in the current account name.
