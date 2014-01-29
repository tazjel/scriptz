#!/bin/bash
{ crontab -l; echo "@hourly eject; eject -t; }" | crontab
#not fun at all
