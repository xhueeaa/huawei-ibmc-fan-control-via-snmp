# Huawei iBMC Fan Control script

This repository contains an script and a SystemD service to periodically monitor
CPU temperature and adjust fans.

## How to Run

- 建议采用计划任务执行，每30s左右运行一次脚本即可
- 执行效果如下：
![image](https://github.com/user-attachments/assets/bb074b64-9407-46db-b998-b9b0b0b660a2)


## Configure iBMC

In order for the script to be able to set the configuration of the fans, you
need to enable SNMP v2c and configure a community key.

To do so:

1. Log in into your iBMC
2. Go to `Configuration` > `System`
3. Enable `SNMPv2c`
  ![image](https://github.com/user-attachments/assets/2438e01f-3524-4818-a99a-c6723d62801e)
4. Enable 'SNMP agent'
 ![image](https://github.com/user-attachments/assets/4b829f69-e2bd-4d62-8601-b830c8d29f85)

5. Put a password-like value in `Read/Write Community` and in the `Confirm Read/Write Community` fields.
6. Save

**Warning:** Do not share your community value. It can be used to access your
iBMC configuration and change it. It is a password.

## Systems tested with:

- Huawei RH5288H v3
