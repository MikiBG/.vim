#!/bin/bash
# install package.
# Usage:
#   ./install_package.sh "repo's URL"

URL=$1
NAME=${1##*/}
cd ./pack/plugins/start
git submodule add $URL
git add .
git commit -m "add package $NAME"
cd ../../../
