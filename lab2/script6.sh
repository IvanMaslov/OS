#!/bin/bash
# cat /var/log/*.log | wc -l
find /var/log -name "*.log" 2>/dev/null | xargs -n1 cat 2>/dev/null | wc -l
