#!/bin/bash

#################################################################
#								#
#	Darkone Firewall - Make it easyer as possible		#
#								#
#	Copyright (C) 2010 Alexandru Loredan Stancu		#
#			   salecss@gmail.com			#
#								#
#################################################################

#########################################################################
#									#
# This program is free software: you can redistribute it and/or modify	#
# it under the terms of the GNU General Public License as published by	#
# the Free Software Foundation, either version 3 of the License, or	#
# (at your option) any later version.					#
#									#
# This program is distributed in the hope that it will be useful,	#
# but WITHOUT ANY WARRANTY; without even the implied warranty of	#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the		#
# GNU General Public License for more details.				#
#									#
# You should have received a copy of the GNU General Public License	#
# along with this program.  If not, see <http://www.gnu.org/licenses/>.	#
#									#
#########################################################################


CONF_FILE="/etc/default/darkone"

if [[ "$UID" -ne 0 ]]; then
	
	echo
	echo " Only root can use firewall script! Exiting ... "
	echo
	exit 1000

fi

if [[ ! -s "$CONF_FILE" ]]; then

	echo 
	echo "Error: Could not find configuration file $CONF_FILE. Exiting ..."
	echo
	exit 11

else

	. "$CONF_FILE"
fi


if [[ ! -s "${INSTALL_DIR}/lib/firewall" ]]; then

        echo 
        echo "Error: Could not find library file \"${INSTALL_DIR}/lib/firewall\". Exiting ..."
        echo
        exit 12

else

        . "${INSTALL_DIR}/lib/firewall"
fi



case "$1" in

	start)
		echo "Starting firewall ..."
		stop
		firewall_start
		;;
	stop)
		echo "Stopping firewall ..."
		stop
		;;
	restart)
		echo "Restarting firewall ..."
		restart
		;;
	show-rules) 
		echo "show rules"
		exit 0
		;;
	help) 
		show_help
		exit 0
		;;
	version)
		echo
		echo " Darkone Firewall By Alexandru Loredan Stancu. Version $VERSION"
		echo
		echo " Copyright (C) 2010 Alexandru Loredan Stancu - salecss@gmail.com"
		echo " This program comes with ABSOLUTELY NO WARRANTY;"
		echo " This is free software, and you are welcome to redistribute it under GPLv3 conditions."
		echo
		exit 0
		;;
	*)
		show_help
		exit 0


esac
