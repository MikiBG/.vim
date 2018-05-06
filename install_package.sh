#!/bin/bash
# install package.
# Usage:
#   ./install_package.sh <repo's URL>

URL=$1
NAME=${1##*/}
git submodule add $URL ./pack/plugins/start/$NAME
git add .
git commit -m "add package $NAME"
