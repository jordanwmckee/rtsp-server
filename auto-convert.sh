#!/bin/bash

#Exit when a command fails
set -o errexit
#Exit upon attempt to use undeclared vars
set -o nounset
#Causes a non-zero exit code in a piped stream to be returned
set -o pipefail
#Uncomment for tracing
#set -o xtrace

for FILE in source-videos/*; do ./convert.sh $FILE; done
