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

cd "${clonedir}" || exit
echo "" >  "${difffile}"
diff -X "${pdir}/ignorelist.txt" -ur "${coredir}/" "${betadir}/" >> "${difffile}"

diff2html -F "${pdir}/diff.html" -i file -- "${difffile}" || exit 1

echo "<html>
        <head>
                <title>Plugwise Core/beta progress</title>
        </head>
        <body>

                <p>Active beta-branch vs active HA-core differences</p>
                <ul>
                        <li><a href='diff.html'>Unified diff core:dev vs beta:main</a></li>" > "${pdir}/index.html"

echo "
                </ul>
                <p>Branch differences (still in beta)</p>
                <ul>" >> "${pdir}/index.html"

cd "${betadir}" && git branch -r | while read -r betabranch
do
	# Strip origin/
	betabranchname=${betabranch//origin\//}

        cd "${betadir}" || exit
        git checkout "${betabranch}"

        cd "$clonedir" || exit
        echo "" >  "${difffile}"
        diff -X "${pdir}/ignorelist.txt" -ur "${betadir}/" "${coredir}/" >> "${difffile}"

        diff2html -F "${pdir}/diff_${betabranchname}.html" -i file -- "${difffile}"

        echo "
                        <li><a href='diff_${betabranchname}.html'>Unified diff core:dev vs beta:${betabranch}</a></li>" >> "${pdir}/index.html"

        cd "${betadir}" || exit
        git checkout main
done

echo "
                </ul>
                <p>Various PR branch differences against Core (dev/upstreaming)</p>
                <ul>" >> "${pdir}/index.html"

while read -r prbranch < "${branches}"
do
        cd "${prdir}" || exit
        git checkout "${prbranch}"
        git fetch origin "${prbranch}"
        git rebase "origin/${prbranch}"

        cd "$clonedir" || exit
        echo "" >  "${difffile}"
        diff -X "${pdir}/ignorelist.txt" -ur "${coredir}/" "${prdir}/" >> "${difffile}"

        diff2html -F "${pdir}/diff_${prbranch}.html" -i file -- "${difffile}"

        justprbranch=${prbranch//^plugwise-/}
        echo "
                        <li><a href='diff_${prbranch}.html'>Unified diff core:dev vs pw-core:${prbranch}</a> - <a href='https://github.com/plugwise/progress/blob/main/${justprbranch}.md'>PR suggested text</a> (<a href='https://raw.githu
busercontent.com/plugwise/progress/main/${justprbranch}.md'>raw</a>) - <a href='https://github.com/home-assistant/core/compare/dev...plugwise:${prbranch}?expand=1'>Create PR@Core</a></li>" >> "${pdir}/index.html"

        cd "${betadir}" || exit
        git checkout main
done


cd "${clonedir}" || exit

echo "
                        <p>(Don't forget to click the 'PR suggested text' first (in raw) so you can copy it to the 'Create PR@core' link :)<p>
                </ul>" >> "${pdir}/index.html"

echo "
                </ul>
                <p>Various PR branch differences against -beta main (downstreaming/verify)</p>
                <ul>" >> "${pdir}/index.html"

while read -r prbranch < "${branches}"
do
        cd "${prdir}" || exit
        git checkout "${prbranch}"

        cd "${clonedir}" || exit
        echo "" >  "${difffile}"
        diff -X "${pdir}/ignorelist.txt" -ur "${bmdir}/" "${prdir}/" >> "${difffile}"

        diff2html -F "${pdir}/bm_diff_${prbranch}.html" -i file -- "${difffile}"

        justprbranch=${prbranch//^plugwise-/}
        echo "
                        <li><a href='bm_diff_${prbranch}.html'>Unified diff beta:main vs pw-core:${prbranch}</a></li>" >> "${pdir}/index.html"

        cd "${betadir}" || exit
        git checkout main
done


cd "${clonedir}" || exit

echo "
                </ul>
        </body>
</html>" >> "${pdir}/index.html"

cd "${pdir}" || exit
pwd
ls -alrt


#git remote set-url origin https://x-access-token:${PROGRESS_DEPLOYKEY}@github.com/$GITHUB_REPOSITORY
git checkout "${GITHUB_HEAD_REF}"
git add -A 
git commit -m "Update: ${GITHUB_REF##*/} - Diff report completed"
git push origin "${GITHUB_REF##*/}"

