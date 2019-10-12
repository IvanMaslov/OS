#!/bin/bash

# ps aux | awk '{print $11" "$2}' | grep -E "/sbin/"
ps aux | awk '{if ($11~'/sbin/') print $2}'
