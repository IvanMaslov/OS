#!/bin/bash
find /bin/* | xargs -n1 head -n1 2>/dev/null | grep -a "#!" | sort | uniq -c | sort -rn | head -n1

