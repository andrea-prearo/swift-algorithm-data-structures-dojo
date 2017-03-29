#!/bin/bash

# This script produces and shows the Slather report when the unit tests pass.

# Allow for the script to execute outside of Xcode
if [ -z ${SRCROOT+x} ]; then
    SRCROOT="."
fi

# Run Slather
slather

# Show HTML report
open 'SlatherHtml/index.html' &
