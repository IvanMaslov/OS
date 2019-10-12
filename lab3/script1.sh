#!/bin/bash

ps a -u $USER | awk '{print $1":"$5}' > user_processes.out

