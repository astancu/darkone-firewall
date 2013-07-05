#!/bin/bash

###########################################
#                                         #
# This file is part of Darkone Firewall.  #
#                                         #
###########################################

#############################################################################
#                                                                           #
# Darkone Firewall is free software: you can redistribute it and/or modify  #
# it under the terms of the GNU General Public License as published by      #
# the Free Software Foundation, either version 3 of the License, or         #
# (at your option) any later version.                                       #
#                                                                           #
# Darkone Firewall is distributed in the hope that it will be useful,       #
# but WITHOUT ANY WARRANTY; without even the implied warranty of            #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
# GNU General Public License for more details.                              #
#                                                                           #
# You should have received a copy of the GNU General Public License         #
# along with this program.  If not, see <http://www.gnu.org/licenses/>.     #
#                                                                           #
#############################################################################


CONF_DIR="/etc/darkone"
INSTALL_DIR="/opt/darkone"

print_status()
{
	local err_no="$1"
	if [[ "$err_no" -eq 0 ]]; then
                echo " OK"
        else
                echo " FAILED!"
                exit "$err_no"
        fi

}

echo
echo " Installing firewall ..."

if [[ "$UID" -ne 0 ]]; then
	
	echo
	echo " Error: Only root can run this script! Exiting ..."
	echo
	exit 1

fi

if [[ ! -d "$CONF_DIR" ]]; then

	echo -n " Creating $CONF_DIR directory ... "
	mkdir $CONF_DIR
	print_status "$?"
fi

if [[ ! -d "$INSTALL_DIR" ]]; then

        echo -n " Creating $INSTALL_DIR directory ... "
        mkdir $INSTALL_DIR
        print_status "$?"
fi

if [[ ! -d "${INSTALL_DIR}/lib" ]]; then

        echo -n " Creating ${INSTALL_DIR}/lib directory ... "
        mkdir ${INSTALL_DIR}/lib
        print_status "$?"
fi

if [[ ! -d "${INSTALL_DIR}/modules" ]]; then

        echo -n " Creating ${INSTALL_DIR}/modules directory ... "
        mkdir ${INSTALL_DIR}/modules
        print_status "$?"
fi


echo -n " Copy firewall.conf file to $CONF_DIR ... "
if [[ -e "${CONF_DIR}/firewall.conf" ]]; then

	echo
	echo -n " File ${CONF_DIR}/firewall.conf already exists. Do you want to replace it [y/N]? "
	read ans
	if [[ "`echo "$ans" | tr "[:upper:]" "[:lower:]"`" = "y" ]]; then
		
		cp -f firewall.conf $CONF_DIR

	fi
else
	cp -f firewall.conf $CONF_DIR
fi
print_status "$?"

echo -n " Copy libs to ${INSTALL_DIR}/lib ... "
cp -f lib/* ${INSTALL_DIR}/lib/
print_status "$?"

echo -n " Copy modules to ${INSTALL_DIR}/modules ... "
cp -f modules/* ${INSTALL_DIR}/modules/
print_status "$?"

echo -n " Copy interface configuration file to $CONF_DIR ... "
cp -f interfaces $CONF_DIR
print_status "$?"

echo -n " Copy init script to /etc/init.d/ ... "
cp -f darkone.sh /etc/init.d/darkone
print_status "$?"

echo -n " Copy firewall configuration file to /etc/default/darkone ... "
cp -f darkone.default /etc/default/darkone
print_status "$?"

echo -n " Setting permisions ... "
chmod a+x /etc/init.d/darkone
print_status "$?"

echo -n " Creating symlink to /etc/init.d/darkone on /sbin/firewall ... "
ln -fs /etc/init.d/darkone /sbin/darkone
print_status "$?"

echo "DONE"
