#!/bin/sh
# https://github.com/symless/synergy-core/wiki/Autostarting#user-content-Linux
#
OP=${1}

# put the synergy server IP here (at boot time name lookup does not work
# and synergyc will fail and exit, using the IP prevents the problem)
SERVER_IP=192.168.15.100

SYNERGYC=/usr/bin/synergyc
PS=/bin/ps
GREP=/bin/grep
WC=/usr/bin/wc
PIDOF=/sbin/pidof
SLEEP=/bin/sleep

# check synergyc is running
function sc_check
{
  N=`${PS} -ef | ${GREP} "${SYNERGYC}"  | ${GREP} -v "${GREP}" | ${WC} -l`
  return $N
}

# kill synergyc if running
function sc_kill
{
  SIG=""
  while true
  do
    sc_check
    if [ $? -eq 1 ]
    then
      PIDS=`${PIDOF} "${SYNERGYC}"`
      if [ ${PIDS} != "" ]
      then
        kill ${SIG} ${PIDS}
      fi
    else
      break
    fi

    ${SLEEP} 1
    SIG="-9"
  done
}

# start synergyc
function sc_start
{
  while true
  do
    ${SYNERGYC} "${SERVER_IP}"

    ${SLEEP} 2

    sc_check
    if [ $? -eq 1 ]
    then
      break
    fi
  done
}

case "${OP}" in
  start)
    sc_kill
    sc_start
  ;;
  stop)
    sc_kill
  ;;
  *)
    echo "usage: synergyc-ctl [start|stop]"
    exit 1
  ;;
esac

exit 0
