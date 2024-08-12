# Huawei iBMC Fan Control script

This repository contains an script and a SystemD service to periodically monitor
CPU temperature and adjust fans.

## How to Install

建议采用计划任务执行

## Configure iBMC

In order for the script to be able to set the configuration of the fans, you
need to enable SNMP v2c and configure a community key.

To do so:

1. Log in into your iBMC
2. Go to `Configuration` > `System`
3. Enable `SNMPv2c`
4. Enagle 'SNMP agent'
5. Put a password-like value in `Read/Write Community` and in the `Confirm Read/Write Community` fields.
6. Save

**Warning:** Do not share your community value. It can be used to access your
iBMC configuration and change it. It is a password.

## Systems tested with:

- Huawei RH5288H v3
