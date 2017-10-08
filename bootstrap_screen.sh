#!/bin/bash

LOG_DIR=/root/log
mkdir -p $LOG_DIR

screen -d -m -S aquariumHub
screen -S aquariumHub bash -c "mjpg_streamer -i 'input_uvc.so -f 10 -d /dev/video0' -o 'output_http.so'"
screen -S aquariumHub -X screen
screen -S aquariumHub bash -c "cd /root/aws_iot && python aquariumHub_subscribe.py"
screen -S aquariumHub -X screen
screen -S aquariumHub bash -c "python aquariumHub_publish.py"
screen -S aquariumHub -X screen
screen -S aquariumHub bash -c "cd /root/frp && ./frpc -c frpc.ini"
