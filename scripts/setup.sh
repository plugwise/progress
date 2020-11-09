#!/bin/bash -x
clonedir="$(pwd)/clones"
coredir="${clonedir}/ha-core/homeassistant/components/plugwise/"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
betadir="${clonedir}/beta/custom_components/plugwise/"
bmdir="${clonedir}/beta-master/custom_components/plugwise/"
difffile="${clonedir}/plugwise.diff"
pdir="$(pwd)"

branches="$(cat ${pdir}/branches.txt)"
betabranches="$(cat ${pdir}/betabranches.txt)"

mkdir -p ${clonedir}

# Clone all repos (and set upstream where needed)
cd $clonedir
#if [ ! -d ha-core ]; then
#        git clone https://github.com/home-assistant/core ha-core
#fi
if [ ! -d pw-core ]; then
#        git clone https://github.com/plugwise/home-assistant.core pw-core
        cd ${prdir}
#        git remote add upstream https://github.com/home-assistant/core.git
fi
#if [ ! -d beta ]; then
#        git clone https://github.com/plugwise/plugwise-beta beta
#fi
#if [ ! -d beta-master ]; then
#        git clone https://github.com/plugwise/plugwise-beta beta-master
#fi

