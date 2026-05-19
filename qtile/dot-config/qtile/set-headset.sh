#!/bin/bash

pacmd set-default-sink "$(pacmd list-sinks | grep -nE -B 1 -e ^[[:space:]]*name[:].*output.*Logitech_PRO_X.* | head -n1 | rev | cut -w -f1)"
