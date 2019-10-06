#!/bin/bash
file /bin/* | grep 'script' | cut -d ':' -f1 | xargs -n1 head -n1 | sort | uniq -c | sort -rn | head -n1

