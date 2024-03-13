#!/bin/bash

sudo find /prd_logs/logs -type f ! -newermt "$(date -d '1 week ago' '+%Y-%m-%d')" -exec rm -f {}  \;

