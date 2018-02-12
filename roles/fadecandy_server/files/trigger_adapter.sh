#!/bin/bash
SCENE=$1
SCRIPT_FILE=$2
echo $SCENE > $SCRIPT_FILE
sudo /bin/systemctl reload-or-restart shelf_light
