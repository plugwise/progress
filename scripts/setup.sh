#!/bin/bash -x
if [ "${1}" == "" ]; then
	echo "Syntax: ${0} {beta|usb-beta}"
fi
clonedir="$(pwd)/${1}/clones"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
rm index.html "${1}/index.html" "${1}/diff*html" "${1}/bm_diff*html" || exit 0
cd "${prdir}" || exit
git remote add upstream https://github.com/home-assistant/core.git || exit 0
