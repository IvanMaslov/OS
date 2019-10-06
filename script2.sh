#!/bin/bash
file=$1
regWarn="warning"
regInfo="info"
grep -E $regWarn $file | sed -E "s/$regWarn/WARNING: /" > full.log
grep -E $regInfo $file | sed -E "s/$regInfo/INFORMATION: /" >> full.log
