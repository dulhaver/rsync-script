### when running this script with a dry-run the symlink is still upated. This ruins the --link-dest in the following run

#!/bin/sh

###### some variables for rsync #################

SOURCE=/srv/smb/*		# the ending /* will backup all folders & files inside /srv/smb
TARGET=/mnt/2TB/backup/		# path on the remote backup machine ## # ending '/' makes sure the '--link-dest' and the symlink are correct
TODAY=$(date +%y%m%d_%H%M)		

#EXCLUDE="--exclude 'VID*' --exclude '*.vmdk' --exclude '*.iso' --exclude '*.cqow2' --exclude 'test*' --exclude '*_cp' --exclude 'Software'"


###### mounting the backup disk #######################
echo ' '
echo '   mounting /mnt/2TB'
echo ' '

sudo mount /mnt/2TB


###### back up with RSYNC #######################
echo ' '
echo '   -backing up with RSYNC'
echo ' '

#sudo rsync            -Aav --exclude 'test*' --exclude '*_cp' --exclude 'Software'    ${SOURCE}    ${TARGET}${TODAY}/ --link-dest=${TARGET}last/
#sudo rsync		-Aav --exclude 'VID*' --exclude 'test*' --exclude '*_cp' --exclude 'Software'    ${SOURCE}    ${TARGET}${TODAY}/
sudo rsync   -Aav --exclude '*.vmdk' --exclude '*.iso' --exclude '*.qcow2' --exclude 'test*' --exclude '*_cp' --exclude 'Software' --exclude 'gbj-65' ${SOURCE}    ${TARGET}${TODAY}/ --link-dest=${TARGET}last/



##### make a new symlink ####

echo ' '
echo '   updating symlilnk to the latest backup'
echo ' '

sudo rm ${TARGET}last
sudo ln -s ${TARGET}${TODAY}/ ${TARGET}last



###### umounting the backup disk #######################
echo ' '
echo '   umounting /mnt/2TB'
echo ' '

sudo umount /mnt/2TB


###########################################3############
echo ' '
echo '  - DONE backing up !!!'
echo ' '

exit 0



################ restoring a backup  ####################


# The great thing about using rsync for backup is that restoration is a snap. Essentially, you simply reverse your backup script: 
# Instead of copying files to your EVBackup account, you'll copy files from your EVBackup account.
#
# If the script to backup your files looked like this (all on one line):

# rsync -avz -e "ssh -i /backup/ssh_key" /local/dir user@user.evbackup.com:remote/dir   # ... the command to restore files would look like this:

# sudo rsync -avz -e "ssh -i /backup/ssh_key" user@user.evbackup.com:remote/dir /local/dir

# Note the use of sudo: you'll be restoring files as root so that you can write to whatever directory you need to.

#Remember, help is just an email away: support@evbackup.com . 
