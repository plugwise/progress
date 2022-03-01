#!/bin/bash -x
clonedir="$(pwd)/clones"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
rm index.html diff*html bm_diff*html
cd "${prdir}" || exit
git remote add upstream https://github.com/home-assistant/core.git || exit 0
