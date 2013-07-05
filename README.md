Installation
============

Linux
-----

Step 1

	Extract darkone-firewall-<VERSION>.tar.gz file.
	darkone-firewall directory will be created in the current working directory.

Step 2

	$ cd darkone-firewall
	$ sudo ./install.sh

Stept 3

	Add configuration files to /etc/darkone/
	Note: A configuration file contains rules for the firewall and its name is finished in .conf


Configuration
=============

Configuration files are located in /etc/darkone/.

interfaces and firewall.conf files will be found in that directory:

* interfaces file contains the definition of interfaces
* firewall.conf contains firewall rules.

Modularity
==========

Darkone Firewall is modular. That means a new modules
can be easily added to it. Version 0.10.0 comes with
only one module: filter. This module is used for traffic
filtering and you can use it by adding "[filter]" in the
rules configuration file(s). Rules configuration files
can be placed in /etc/darkone/ and /etc/darkone/firewall.conf
is mandatory. If you look in that file you'll find a line
which contains "[filter]" keyword. Under that line all
filtering rules are written.

If you want to add a new module to the script you have to
follow the next steps:

Step 1:

        Choose a name for your module. For example "filter-ng"
        Edit the rules configuration file and add the filter
        name on one line: "[filter-ng]"
        Under this line you write your own rules syntax.

Step 2:

        Create a file (bash script) in /opt/darkone/modules/filter-ng
        In this file you'll write all the functiones needed by this module.
        There is only one condition: you must create at least one function
        named "filter-ng ()". This function will be called by the Darkone Firewall.


Change Log
==========

### Version 0.10.3 ### 05-07-2013 (DD-MM-YYYY)

* Move the project from google code to github.
* Add support for DROP target in filter module. 
* Functions modified:
		- apply_iptables_rule
		- check_target

### Version 0.10.2 ### 23-03-2010 (DD-MM-YYYY)

* Added "nat" module. Supports the following targets: SNAT,DNAT and MASQUERADE
* Remove targets MASQUERADE and SNAT from filter module. 

### Version 0.10.1 ### 18-03-2010 (DD-MM-YYYY)

* Updating some configuration changes. Minor changes.

### Version 0.10.0 ### 15-03-2010 (DD-MM-YYYY)

* Make the script firewall modular. Now it is possible to configure the script based on modules. Read the README.txt file for more detailes.
* Added "interfaces" configuration file. This file will be used for interface name mapping.
* Added description to the rules.(you can see that when iptables -L -n -v -t mangle is used)
* Changing installation directory to /opt/darkone/
* Adding /opt/darkone/lib and /opt/darkone/modules directoris.
* Renamed the following files:
	/etc/init.d/firewall.sh to /etc/init.d/darkone
	/etc/default/firewall to /etc/default/darkone
* Changed the symlink from /sbin/firewall /sbin/darkone
* Installation script was updated.

### Version 0.9.1 ### 18-02-2010 (DD-MM-YYYY)

* Added SNAT Support (Valid only in the nat table, in the POSTROUTING chain).
* Added MASQUERADE (Valid only in the nat table, in the POSTROUTING chain. This should only be used with dynamically assigned IP (dialup) connections)
* Added interface name mapping. (i.e. local=eth1, wan=eth1).
* Added support for multiple independent configuration file. Configuration files name must be finished in ".conf"
* Functions added: get_parameters, do_some_checks, log_rule
* Added TARGET filed to the rule
	 <IP_SRC>:<IP_DST>:<IN_INTERFACE>:<CHAIN>: <Protocol>|<port1,port2, ...>; <protocol>|<port1,port2, ...>; ... : <TARGET>[ | <IP> ]

Bug Fix:

	[1] - Critical - Script is not exiting when an error is found in rules conf file.
	[2] - Critical - Interface chaecking is not working.


## Version 0.9.0 ### 09-02-2010 (DD-MM-YYYY)

 The first beta release

* Rules are added only to mangle table
* Policy: DROP for INPUT and FORWARD chaines and ACCEPT for the rest.
* Only Filter rules can be added to chaines: INPUT, OUTPUT, FORWARD.
* SPI - State Packet Inspection => This is a stateful firewall.
* Accepted traffic (by default): DNS traffic, Established and Related connections for INPUT and FORWARD chains.
* All rules in the mangle table are logged if there is no match.
* Valid IP verification
* Valid Chain verification
* Valid Interface verification
* Valid Rule verification
* Rules file verification
* Files:
	* /etc/init.d/firewall.sh - init script.
	* /etc/default/firewall  - Configuration file for the firewall.
	* /etc/firewall/ 
			-> firewall.conf - rules configuration file. One rule per line.
			-> firewall - This file contains all the necessary functions for the firewall.
* Rules:
	 SYNOPSIS: <IP_SRC>:<IP_DST>:<IN_INTERFACE>:<CHAIN>: <Protocol>|<port1,port2, ...>; <protocol>|<port1,port2, ...>; ...

	 IP_SRC = [any | IP | Network ]
	 IP_DST = [any | IP | Network ]
	 IN_INTERFACE = [ any | int_name ]
	 CHAIN = [ chain_name ]
	 <Protocol>|<port1,port2, ...> = [ any | tcp | udp | icmp ] | <nr>,<nr>, ...
