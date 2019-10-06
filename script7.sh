#!/bin/bash
man bash | grep -Eo "\S+" | sort | uniq -c | sort -nr | head -n 3
