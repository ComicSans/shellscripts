#!/bin/sh
 
TODAY=`date +"%Y%m%d"`
YESTERDAY=$(date -D %s -d $(($(date +%s) - 86400)) +%Y%m%d)
 
# Set the path to rsync on the remote server so it runs with sudo.
RSYNC="/usr/local/bin/sudo /usr/local/bin/rsync"
 
# This is a list of files to ignore from backups.
EXCLUDES="/volume1/backup.excludes"
 
DESTINATION="/volume1/hostname/$TODAY/"
  
# The "rsync" user is a special user on the remote server that has permissions
# to run a specific rsync command. We limit it so that if the backup server is
# compromised it can't use rsync to overwrite remote files by setting a remote
# destination. I determined the sudo command to allow by running the backup
# with the rsync user granted permission to use any flags for rsync, and then
# copied the actual command run from ps auxww. With these options, under
# Ubuntu, the sudo line is:
#
#   rsync	ALL=(ALL) NOPASSWD: /usr/bin/rsync --server --sender -logDtprze.iLsf --numeric-ids . /
#
# Note the NOPASSWD option in the sudo configuration. For remote
# authentication use a password-less SSH key only allowed read permissions by
# the backup server's root user.
rsync  -e "ssh" \
	--rsync-path="$RSYNC" \
	--archive \
	--exclude-from=$EXCLUDES \
	--numeric-ids \
	--link-dest=../$YESTERDAY user@hostname:/ $DESTINATION
	
	
