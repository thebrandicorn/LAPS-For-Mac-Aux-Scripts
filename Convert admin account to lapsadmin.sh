#!/bin/bash

#Gets current admin username  from Jamf's parameter 4
currentadmin="$4"

# Uses dscl to change the account shortname to lapsadmin. 
# This maintains the home folder, and fullname, so if your admin account is also your management account, Jamf should be able to maintain access
dscl . change /Users/$currentadmin RecordName $currentadmin lapsadmin

#Give lapsadmin admin access, just in case something went wrong
dscl . -append /groups/admin GroupMembership lapsadmin
