#!/bin/bash
# installs / update cron
   if [ `id -u`-ne 0 ]; then																#
																						
      echo "This script can only be executed only with root powers, Now exiting.."			#
      exit 1
   fi
		
		case "$1" in																		#
			install|update)									#Assisted by Hack
			Cron_File="/var/spool/cron/root"
			if [ ! -f $Cron_File ]; then
				echo "cron file for root does not exist, creating.."
				touch $Cron_File
				/usr/bin/crontab $Cron_File
			fi		
		grep -qi "cleanup_script" $Cron_File
			if [ $? != 0 ]; then
				echo "Updating cron job for cleaning temporary files"
				/bin/echo "0 0 * * * rm -f /home/eli/cleanup_script.sh" >> $Cron_File
			fi
		grep -qi "cleanup_script" $Cron_File												#
			if [ $? != 0 ]; then															#
				echo "Updating cron job for cleaning temporary files"				#
				crontab -u eli -l >/tmp/crontab												#
				/bin/echo "0 0 * * * rm -f /home/eli/cleanup_script.sh" >> /tmp/crontab 	#
				crontab -u eli /tmp/crontab													#
			fi
	;;
	*)
	echo "Usage: $0 {install|update}"									#Assisted by Hack
	exit 1
    ;;

esac
