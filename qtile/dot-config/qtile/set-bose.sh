#!/bin/bash

pacmd set-default-sink "$(pacmd list-sinks | grep -nE -B 1 -e ^[[:space:]]*name[:].*output.*Bose_Corp.* | head -n1 | rev | cut -w -f1)"
