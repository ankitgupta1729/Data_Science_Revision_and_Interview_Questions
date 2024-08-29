# START CRON JOB
* * * * * /usr/local/bin/python /app/cron_tab.py > /proc/1/fd/1 2>/proc/1/fd/2
# END CRON JOB
