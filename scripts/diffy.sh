#!/bin/bash -x
clonedir="$(pwd)/clones"
coredir="${clonedir}/ha-core/homeassistant/components/plugwise/"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
betadir="${clonedir}/beta/custom_components/plugwise/"
bmdir="${clonedir}/beta-main/custom_components/plugwise/"
difffile="${clonedir}/plugwise.diff"
pdir="$(pwd)"

branches="${pdir}/branches.txt"

git config --global user.name 'diff2html'
git config --global user.email 'plugwise@users.noreply.github.com'

cd $clonedir
echo "" >  ${difffile}
diff -X ${pdir}/ignorelist.txt -ur ${coredir}/ ${betadir}/ >> ${difffile}

diff2html -F ${pdir}/diff.html -i file -- ${difffile}

echo "<html>
        <head>
                <title>Plugwise Core/beta progress</title>
        </head>
        <body>

                <p>Active beta-branch vs active HA-core differences</p>
                <ul>
                        <li><a href='diff.html'>Unified diff core:dev vs beta:main</a></li>" > ${pdir}/index.html

echo "
                </ul>
                <p>Branch differences (still in beta)</p>
                <ul>" >> ${pdir}/index.html

cd ${betadir}; git branch -r | while read betabranch
do
	# Strip origin/
	betabranchname=$(echo ${betabranch} | sed 's/origin\///g')

        cd ${betadir}
        git checkout ${betabranch}

        cd $clonedir
        echo "" >  ${difffile}
        diff -X ${pdir}/ignorelist.txt -ur ${betadir}/ ${coredir}/ >> ${difffile}

        diff2html -F ${pdir}/diff_${betabranchname}.html -i file -- ${difffile}

        echo "
                        <li><a href='diff_${betabranchname}.html'>Unified diff core:dev vs beta:${betabranch}</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout main
done

echo "
                </ul>
                <p>Various PR branch differences against Core (dev/upstreaming)</p>
                <ul>" >> ${pdir}/index.html

cat ${branches}| while read prbranch
do
        cd ${prdir}
        git checkout ${prbranch}
        git fetch origin ${prbranch}
        git rebase origin/${prbranch}

        cd $clonedir
        echo "" >  ${difffile}
        diff -X ${pdir}/ignorelist.txt -ur ${coredir}/ ${prdir}/ >> ${difffile}

        diff2html -F ${pdir}/diff_${prbranch}.html -i file -- ${difffile}

        justprbranch=`echo ${prbranch} | sed 's/^plugwise-//g'`
        echo "
                        <li><a href='diff_${prbranch}.html'>Unified diff core:dev vs pw-core:${prbranch}</a> - <a href='https://github.com/plugwise/progress/blob/main/${justprbranch}.md'>PR suggested text</a> (<a href='https://raw.githu
busercontent.com/plugwise/progress/main/${justprbranch}.md'>raw</a>) - <a href='https://github.com/home-assistant/core/compare/dev...plugwise:${prbranch}?expand=1'>Create PR@Core</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout main
done


cd $clonedir

echo "
                        <p>(Don't forget to click the 'PR suggested text' first (in raw) so you can copy it to the 'Create PR@core' link :)<p>
                </ul>" >> ${pdir}/index.html

echo "
                </ul>
                <p>Various PR branch differences against -beta main (downstreaming/verify)</p>
                <ul>" >> ${pdir}/index.html

cat ${branches}| while read prbranch
do
        cd ${prdir}
        git checkout ${prbranch}

        cd $clonedir
        echo "" >  ${difffile}
        diff -X ${pdir}/ignorelist.txt -ur ${bmdir}/ ${prdir}/ >> ${difffile}

        diff2html -F ${pdir}/bm_diff_${prbranch}.html -i file -- ${difffile}

        justprbranch=`echo ${prbranch} | sed 's/^plugwise-//g'`
        echo "
                        <li><a href='bm_diff_${prbranch}.html'>Unified diff beta:main vs pw-core:${prbranch}</a></li>" >> ${pdir}/index.html

        cd ${betadir}
        git checkout main
done


cd $clonedir

echo "
                </ul>
        </body>
</html>" >> ${pdir}/index.html

cd ${pdir}
pwd
ls -alrt


#git remote set-url origin https://x-access-token:${PROGRESS_DEPLOYKEY}@github.com/$GITHUB_REPOSITORY
git checkout $GITHUB_HEAD_REF
git add -A 
git commit -m "Update: ${GITHUB_REF##*/} - Diff report completed"
git push origin ${GITHUB_REF##*/}

