#!/bin/sh

###### some variables for rsync #################

SOURCE=/srv/smb/*		# the ending /* will backup all folders & files inside /srv/smb
TARGET=/mnt/2TB/backup/		# path on the remote backup machine ## # ending '/' makes sure the '--link-dest' and the symlink are correct
TODAY=$(date +%y%m%d_%H%M)

###### mounting the backup disk #######################

sudo mount /mnt/2TB


###### back up with RSYNC #######################

sudo rsync   -Aav ${SOURCE}    ${TARGET}${TODAY}/ --link-dest=${TARGET}last/


##### make a new symlink ####

sudo rm ${TARGET}last
sudo ln -s ${TARGET}${TODAY}/ ${TARGET}last


###### umounting the backup disk #######################

sudo umount /mnt/2TB

exit 0
