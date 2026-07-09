#!/bin/bash
# Script to launch IGV from the workspace root
exec "$(dirname "$0")/tools/IGV_Linux_2.19.8/igv.sh" "$@"
