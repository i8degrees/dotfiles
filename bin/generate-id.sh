#!/bin/sh
# 2011-09-19:jeffrey.carp@gmail.com
#
#		~/generate-id.sh
#
# 	Helper script for generating SSH auth keys
#
#		TODO
#	1. add key name / scheme support
#

ssh-keygen -b 1024 -t dsa -f -C"$(id -un)@$(hostname)-$(date --rfc-3339=date)"
#ssh-keygen -b 521 -t ecdsa -f ~/.ssh/id_ecdsa -C"$(id -un)@$(hostname)-$(date --rfc-3339=date)"

#chmod go-w ~/.ssh
chmod 700 $HOME/.ssh
chmod 600 $HOME/.ssh/id_ecdsa
chmod 600 ~/.ssh/authorized_keys

#echo "Be sure to disable password logins within the local sshd config."

