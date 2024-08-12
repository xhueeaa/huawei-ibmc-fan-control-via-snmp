#!/bin/bash

COMMUNITY="SNMP V2C COMMUNITY"
IBMC_IP="IBMC SERVER IP"

CPU1_TEMP=$(("$(snmpget -Oq -Ov -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.26.50.1.3.2)"/10))
echo "CPU1 Temperature: $CPU1_TEMP ℃"
CPU2_TEMP=$(("$(snmpget -Oq -Ov -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.26.50.1.3.3)"/10))
echo "CPU2 Temperature: $CPU2_TEMP ℃"
((CPU_MAX = CPU1_TEMP > CPU2_TEMP ? CPU1_TEMP : CPU2_TEMP))
echo "Max CPU Temperature: $CPU_MAX℃"

CURRENT_SPEED="$(snmpget -Oq -Ov -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.8.2.0)"
CURRENT_MODE="$(snmpget -Oq -Ov -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.8.1.0 | awk -F'[^0-9]+' '{ print $2 }')"

set_auto_mode() {
  if [[ $CURRENT_MODE = 1 ]]; then
    echo "Setting auto mode..."
    snmpset -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.8.1.0 s "0" > /dev/null
  fi
}

set_manual_mode() {
  if [[ $CURRENT_MODE = 0 ]]; then
    echo "Setting manual mode..."
    snmpset -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.8.1.0 s "1,0" > /dev/null
  fi

  if [[ $CURRENT_SPEED != $1 ]]; then
    echo "Fan adjusting at $1%."
    snmpset -v2c -c $COMMUNITY $IBMC_IP .1.3.6.1.4.1.2011.2.235.1.1.8.2.0 i $1 > /dev/null
  fi
}

if [[ $CPU_MAX > 70 ]]; then
    set_auto_mode
    echo "set_auto_mode"
elif [[ $CPU_MAX > 65 ]]; then
    set_manual_mode 35
    echo "set_manual_mode 35"
elif [[ $CPU_MAX > 55 ]]; then
    set_manual_mode 30
    echo "set_manual_mode 30"
elif [[ $CPU_MAX > 45 ]]; then
    set_manual_mode 25
    echo "set_manual_mode 25"
else
    set_manual_mode 20
    echo "set_manual_mode 20"
fi
