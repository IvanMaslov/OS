#!/bin/bash
man bash | grep -Eo "[[:alpha:]]{4}[[:alpha:]]*" | sort | uniq -c | sort -nr | head -n 3
