#!/bin/bash

printf "\n"

####### DEFINITIONS
RSYNC=/usr/bin/rsync
PEMKEY="$HOME/.ssh/machine-learning-aws.pem"
REMOTEHOST="user@server.com"

####### NUMBERS
HOSTNEGFILES=$(ssh -i $PEMKEY $REMOTEHOST 'ls ./dir_with_negative_files | wc -l; exit;')
HOSTPOSFILES=$(ssh -i $PEMKEY $REMOTEHOST 'ls ./dir_with_positive_files | wc -l; exit;')
echo "Remote Negative Files: " $HOSTNEGFILES
echo "Remote Positive Files: " $HOSTPOSFILES

printf "\n"

NEGLOCALFILES=$(ls ./negative_images/ | wc -l)
POSLOCALFILES=$(ls ./positive_images/ | wc -l)
COUNT_UPLOAD_NEG=`expr $NEGLOCALFILES - $HOSTNEGFILES`
COUNT_UPLOAD_POS=`expr $POSLOCALFILES - $HOSTPOSFILES`

echo "Local Negative Files:" $NEGLOCALFILES
echo "Local Positive Files:" $POSLOCALFILES

printf "\n"
echo "Starting Rsync"
printf "\n"
echo "Uploading $COUNT_UPLOAD_NEG negative images"

$RSYNC -auv --progress -e "ssh -i $PEMKEY" \
    ./negative_images/* \
    $REMOTEHOST:/home/ubuntu/some_dir

echo "\n ------------------------- \n"
echo "Uploading $COUNT_UPLOAD_POS positive images"

$RSYNC -auv --progress -e "ssh -i $PEMKEY" \
    ./positive_images/* \
    $REMOTEHOST:/home/ubuntu/some_other_dir
