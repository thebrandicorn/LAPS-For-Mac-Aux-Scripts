#!/bin/bash

resetUser='lapsadmin'
oldPass="$4"
newPass="LAPST3mpP4s5word!"

passwdA=$(dscl /Local/Default -authonly $resetUser $oldPass)

if [ "$passwdA" == "" ];then
	echo "Password stored in LAPS is correct for $resetUser."
	echo "Updating password for $resetUser."
	/usr/local/jamf/bin/jamf resetPassword -updateLoginKeychain -username $resetUser -oldPassword "$oldPass" -password "$newPass"
else
	echo "Error: Password sent to script is not valid for $resetUser."
	oldPass=""
fi

passwdB=`dscl /Local/Default -authonly $resetUser $newPass`

if [ "$passwdB" == "" ];then
	echo "New password for $resetUser is verified."
	echo "Calling upload"
	/usr/local/jamf/bin/jamf policy -event LAPStempPassword
else
	echo "Error: Password reset for $resetUser was not successful!"
	echo "Aborting update"
	exit 1
fi