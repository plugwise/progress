#!/bin/sh
basedir="$(pwd)/clones"
coredir="${basedir}/ha-core/homeassistant/components/plugwise/"
prdir="${basedir}/pw-core/homeassistant/components/plugwise/"
betadir="${basedir}/beta/custom_components/plugwise/"
bmdir="${basedir}/beta-master/custom_components/plugwise/"
difffile="${basedir}/plugwise.diff"
pdir="$(pwd)"

branches="$(cat ${pdir}/branches.txt)"
betabranches="$(cat ${pdir}/betabranches.txt)"


# Clone all repos (and set upstream where needed)
cd $basedir
if [ ! -d ha-core ]; then
        git clone https://github.com/home-assistant/core ha-core
else
        echo "*** $coredir"
        cd ${coredir}
        git checkout dev
        git fetch
        git rebase
fi
cd $basedir
if [ ! -d pw-core ]; then
        git clone https://github.com/plugwise/home-assistant.core pw-core
        cd ${prdir}
        git remote add upstream https://github.com/home-assistant/core.git
else
        echo "*** $prdir"
        cd ${prdir}
        git checkout --track origin/dev
        git fetch upstream dev
        git rebase upstream/dev
fi
cd $basedir
if [ ! -d beta ]; then
        git clone https://github.com/plugwise/plugwise-beta beta
else
        echo "*** $betadir"
        cd ${betadir}
        git pull
fi
cd $basedir
if [ ! -d beta-master ]; then
        git clone https://github.com/plugwise/plugwise-beta beta-master
else
        echo "*** $bmdir"
        cd ${bmdir}
        git pull
fi


## MAIN check
cd $basedir
echo "" >  ${difffile}
diff -X ${basedir}/ignorelist -ur ${coredir}/ ${betadir}/ >> ${difffile}

diff2html -F ${pdir}/diff.html -i file -- ${difffile}

echo "<html>
        <head>
                <title>Plugwise Core/beta progress</title>
        </head>
        <body>

                <p>Active beta-branch vs active HA-core differences</p>
                <ul>
                        <li><a href='diff.html'>Unified diff core:dev vs beta:master</a></li>" > ${pdir}/index.html

echo "
                </ul>
                <p>Branch differences (still in beta)</p>
                <ul>" >> ${pdir}/index.html

echo ${betabranches}| while read betabranch
do
        cd ${betadir}
        git checkout ${betabranch}

        cd $basedir
        echo "" >  ${difffile}
        diff -X ${basedir}/ignorelist -ur ${betadir}/ ${coredir}/ >> ${difffile}

        diff2html -F ${pdir}/diff_${betabranch}.html -i file -- ${difffile}

        echo "
                        <li><a href='diff_${betabranch}.html'>Unified diff core:dev vs beta:${betabranch}</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout master
done

echo "
                </ul>
                <p>Various PR branch differences against Core (dev/upstreaming)</p>
                <ul>" >> ${pdir}/index.html

echo ${branches}| while read prbranch
do
        cd ${prdir}
        git checkout ${prbranch}
        git fetch origin ${prbranch}
        git rebase origin/${prbranch}

        cd $basedir
        echo "" >  ${difffile}
        diff -X ${basedir}/ignorelist -ur ${coredir}/ ${prdir}/ >> ${difffile}

        diff2html -F ${pdir}/diff_${prbranch}.html -i file -- ${difffile}

        justprbranch=`echo ${prbranch} | sed 's/^plugwise-//g'`
        echo "
                        <li><a href='diff_${prbranch}.html'>Unified diff core:dev vs pw-core:${prbranch}</a> - <a href='https://github.com/plugwise/progress/blob/master/${justprbranch}.md'>PR suggested text</a> (<a href='https://raw.githu
busercontent.com/plugwise/progress/master/${justprbranch}.md'>raw</a>) - <a href='https://github.com/home-assistant/core/compare/dev...plugwise:plugwise-${prbranch}?expand=1'>Create PR@Core</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout master
done


cd $basedir

echo "
                        <p>(Don't forget to click the 'PR suggested text' first (in raw) so you can copy it to the 'Create PR@core' link :)<p>
                </ul>" >> ${pdir}/index.html

echo "
                </ul>
                <p>Various PR branch differences against -beta master (downstreaming/verify)</p>
                <ul>" >> ${pdir}/index.html

echo ${branches}| while read prbranch
do
        cd ${prdir}
        git checkout ${prbranch}

        cd $basedir
        echo "" >  ${difffile}
        diff -X ${basedir}/ignorelist -ur ${bmdir}/ ${prdir}/ >> ${difffile}

        diff2html -F ${pdir}/bm_diff_${prbranch}.html -i file -- ${difffile}

        justprbranch=`echo ${prbranch} | sed 's/^plugwise-//g'`
        echo "
                        <li><a href='bm_diff_${prbranch}.html'>Unified diff beta:master vs pw-core:${prbranch}</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout master
done


cd $basedir

echo "
                </ul>
        </body>
</html>" >> ${pdir}/index.html

