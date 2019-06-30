#!/bin/bash

#Hard Coded variables
apiURL=""
#Prompted Variables
apiUser="$(osascript -e "display dialog \"Username:\" default answer \"\"" | cut -c 35-)"
apiPass="$(osascript -e "display dialog \"Password:\" default answer \"\" with hidden answer" | cut -c 35-)"
idInfo=$(osascript -e "display dialog \"Computer:\" default answer \"\" buttons {\"This Computer\", \"Serial Number\", \"Computer Name\"} default button \"Computer Name\"" | tr " " "_" | tr ":" " " | tr "," " ")

compid=$(echo "$idInfo" | awk '{print $NF;}')
jamfid=$(echo "$idInfo" | awk '{print $2;}')

if [ "$jamfid" = "This_Computer" ]; then
jamfid="serialnumber"
compid=$(ioreg -l | grep IOPlatformSerialNumber | awk '{print $NF}' | tr -d "\"")
elif [ "$jamfid" = "Computer_Name" ]; then
jamfid="name"
else
jamfid="serialnumber"
fi

extAttName="\"LAPS\""
oldpass=$(curl -s -f -u $apiUser:$apiPass -H "Accept: application/xml" $apiURL/JSSResource/computers/$jamfid/$compid/subset/extension_attributes | xpath "//extension_attribute[name=$extAttName]" 2>&1 | awk -F'<value>|</value>' '{print $2}')

if [ -z "$oldpass" ]
then
	#If no password found, report it
	oldpass="Not found/accessible"
fi

oldpass=$(echo "$oldpass" | tr -d "\n")
copyTest=$(osascript -e "display dialog \"Password: $oldpass\" buttons {\"Ok\"}")
