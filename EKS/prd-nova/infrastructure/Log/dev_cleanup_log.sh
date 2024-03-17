#!/bin/bash

sudo find /dev_logs/logs -type f ! -newermt "$(date -d '5 day ago' '+%Y-%m-%d')"  -exec rm -f {}  \;

