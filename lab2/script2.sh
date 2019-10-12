#!/bin/bash
file=$1
regWarn="(ww)"
regInfo="(ii)"
grep -E $regWarn $file | sed -E "s/$regWarn/WARNING: /" > full.log
grep -E $regInfo $file | sed -E "s/$regInfo/INFORMATION: /" >> full.log
