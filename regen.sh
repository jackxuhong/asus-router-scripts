#!/bin/sh
SCRIPT=/jffs/admin/reset.sh
LOG=/jffs/admin/admin.log

# Create a backup if the target script already exists
if test -f "$SCRIPT"; then
        mv $SCRIPT $SCRIPT.$(date +%F)
fi

echo '#!/bin/sh' > $SCRIPT
echo "LOG=$LOG" >> $SCRIPT
echo '# Reset schedules' >> $SCRIPT
echo nvram set MULTIFILTER_ALL=\'$(nvram get MULTIFILTER_ALL)\' >> $SCRIPT
echo nvram set MULTIFILTER_DEVICENAME=\'$(nvram get MULTIFILTER_DEVICENAME | sed s/\'/\'\\\\\'\'/g)\' >> $SCRIPT
echo nvram set MULTIFILTER_ENABLE=\'$(nvram get MULTIFILTER_ENABLE)\' >> $SCRIPT
echo nvram set MULTIFILTER_MAC=\'$(nvram get MULTIFILTER_MAC)\' >> $SCRIPT
echo nvram set MULTIFILTER_MACFILTER_DAYTIME=\'$(nvram get MULTIFILTER_MACFILTER_DAYTIME)\' >> $SCRIPT
echo nvram set MULTIFILTER_MACFILTER_DAYTIME_V2=\'$(nvram get MULTIFILTER_MACFILTER_DAYTIME_V2)\' >> $SCRIPT
echo nvram set MULTIFILTER_MACFILTER_DAYTIME_V2_CONVERTED=\'$(nvram get MULTIFILTER_MACFILTER_DAYTIME_V2_CONVERTED)\' >> $SCRIPT
echo nvram set MULTIFILTER_URL=\'$(nvram get MULTIFILTER_URL)\' >> $SCRIPT
echo nvram set MULTIFILTER_URL_ENABLE=\'$(nvram get MULTIFILTER_URL_ENABLE)\' >> $SCRIPT
echo '# Reset filters' >> $SCRIPT
echo nvram set wrs_rulelist=\'$(nvram get wrs_rulelist)\' >> $SCRIPT
echo nvram set wrs_app_rulelist=\'$(nvram get wrs_app_rulelist)\' >> $SCRIPT
echo '# Clear temp variable' >> $SCRIPT
echo 'nvram unset MULTIFILTER_TMP_T' >> $SCRIPT
echo '# Commit nvram changes' >> $SCRIPT
echo 'nvram commit' >> $SCRIPT

echo '# Restart services' >> $SCRIPT
echo 'service restart_firewall' >> $SCRIPT
echo 'service restart_wrs' >> $SCRIPT

echo 'echo "All rules have been reset on $(date)" >> $LOG' >> $SCRIPT

chmod +x $SCRIPT
