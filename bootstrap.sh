#!/bin/bash

LOG_DIR=/root/log
mkdir -p $LOG_DIR

cd /root/aws_iot
(python aquariumHub_subscribe.py > $LOG_DIR/subscribe.log 2>&1) &
(python aquariumHub_publish.py > $LOG_DIR/publish.log 2>&1) &
(mjpg_streamer -i "input_uvc.so -f 10 -d /dev/video0" -o "output_http.so" > $LOG_DIR/streamer.log 2>&1) &
cd /root/python-ngrok
(python python-ngrok.py ngrok.config > $LOG_DIR/frp.log 2>&1) &
