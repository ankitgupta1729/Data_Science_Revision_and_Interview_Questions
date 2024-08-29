# START CRON JOB
# 1. use docker container ls -a to check the container_id
# 2. docker exec -it container_id bash to go in the container os and type which python to find where the python binary is installed. Here it is in 
# /usr/local/bin/python
45 09 * * * /usr/local/bin/python /app/run_app_temp.py > /proc/1/fd/1 2>/proc/1/fd/2
# END CRON JOB
