#!/bin/bash -x
clonedir="$(pwd)/clones"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
cd ${prdir}
git remote add upstream https://github.com/home-assistant/core.git || exit 0
