#!/bin/bash

sudo find /dev_logs/logs -type f ! -newermt "$(date -d '1 week ago' '+%Y-%m-%d')" -exec rm -f {}  \;

