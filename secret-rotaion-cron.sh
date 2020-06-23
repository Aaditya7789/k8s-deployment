#!/bin/bash
PATH="/usr/local/bin:/usr/bin:/bin"
date
now=$(date)
aws ecr get-login >>  /home/ubuntu/ecr-login.sh
sudo chmod  744 /home/ubuntu/ecr-login.sh
sed -i 's/ \-e none/ /g' /home/ubuntu/ecr-login.sh
sed -i 's/  / /g' /home/ubuntu/ecr-login.sh
/home/ubuntu/ecr-login.sh >> cron-output.txt
if [ $? -eq 0 ]; then
        echo "$now login successfully done" >> cron-output.txt
else
        echo  "login failed" >> cron-output.txt
fi
>ecr-login.sh
kubectl delete secret ecr-registry-key >> cron-output.txt
kubectl create secret generic ecr-registry-key --from-file=.dockerconfigjson=.docker/config.json --type=kubernetes.io/dockerconfigjson >> cron-output.txt