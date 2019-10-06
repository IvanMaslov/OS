#!/bin/bash
reg="(/([[:alnum:]]*))+\.([[:alnum:]_]+)"
grep -Ehra "ACPI" /var/log > errors.log
cat errors.log | grep -E "$reg"
