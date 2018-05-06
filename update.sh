#!/bin/bash
# update installed plugins
# Usage:
#   ./update.sh


git submodule update --remote --merge
git commit -m "update plugins"
