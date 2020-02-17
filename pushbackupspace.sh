#!/bin/bash

###
# Base idea
# https://kb.paessler.com/en/topic/70771-how-can-i-monitor-and-automatically-restart-a-service-on-a-linux-host


### CONFIG ###
## HTTP only
# PRTG Host
prtghost="http://10.4.4.116:5050"
#identtoken=D9E87725-FB65-4EC3-9584-198C3D6328E9
identtoken=B7AB86F1-CEE5-46F3-B623-60894EBD9CD8

# base Path
basePath="/share"
# Folders to get size of (do have to be the folder name, separated by SPACE)
fldToCheck=("Public" "install")

# Sized used for the display value
# Byte, KiloByte, MegaByte, GigaByte, TeraByte
dispSize="GigaByte"

### CONFIG END ###






#echo "Array size: ${#fldToCheck[*]}"
#echo "Array items:"

# begin json output
output='{
	 "prtg": {
		"result": [ '


# Used to find last element in array
arrSize=${#fldToCheck[*]}
#echo "array size: $arrSize"
i=0

###
# Get each folder size and expand json
###
for fld in ${fldToCheck[*]}
do
	i=$((i+1))
	printf "Folder: %s\n" $fld

	output+='{
	   "channel": '
			output+=$fld","


			# Get folder size in bytes
			size=$(du -sb $basePath/$fld/ | awk '{print $1}')

			## Print size in kB (as read by du -s)
			#echo $((size/1024**2)) #GB
			echo "$size Byte"

			output+='"value":'
			output+=$size','
			output+='"Unit":"BytesDisk",'
			output+='"VolumeSize":"'$dispSize'"'
			
		output+="}"
		
		echo " "

	if [ $i -ne $arrSize ]
	then
		output+=","
	fi
done

output+="]}}"

echo $output
#echo "$prtghost/$identtocken"

# send data to prtg
curl --data "content=$output" "$prtghost/$identtoken"