#!/bin/bash
# remove installed plugin. 
# Usage: 
#   ./remove_package.sh <name of package>

NAME=$1
git submodule deinit -f ./pack/plugins/start/$NAME
git rm ./pack/plugins/start/$NAME
rm -Rf .git/modules/pack/plugins/start/$NAME
git commit -m "remove package $NAME"
