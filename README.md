# ASUS Router Scripts

This project is a collection of scripts I wrote for my ASUS AC68U router. The scripts used to run on the official ASUS firmware, but new releases from ASUS made it impossible to run user scripts :(, in order to use them you will have to flash your router with the [Merlin Firmware](https://www.asuswrt-merlin.net/) instead.

## Reset Parent Control Rules

The purpose of this script is reset all parental control rules at a scheduled time. If you use and love the parental control features in ASUS routers, you must have had times when you temporarily added more time or turned on games/youtube but forgot to change the settings back. This script takes a snapshot of the schedules and content filters you set up for your kids and generates a reset script that can be scheduled in cron, so you don't have to remember changing the rules back!

To install the script, run the following commands on your router

```
mkdir /jffs/admin
cd /jffs/admin
wget https://raw.githubusercontent.com/jackxuhong/asus-router-scripts/master/regen.sh
```

To generate the reset script, simply `regen.sh` once you have rules set up for all parental controlled devices. The reset script will be generated in /jffs/admin by default, feel free to change the path in the script if you like to put it somewhere else.

E.g. the cron entry below calls the reset script right before midnight.

```
59 23 * * * /jffs/admin/reset.sh #resetall#
```
