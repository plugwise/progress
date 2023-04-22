#!/usr/bin/env bash -x
if [ "${1}" == "" ]; then
        echo "Syntax: ${0} {beta|usb-beta}"
fi
clonedir="$(pwd)/${1}/clones"
coredir="${clonedir}/ha-core/homeassistant/components/plugwise/"
prdir="${clonedir}/pw-core/homeassistant/components/plugwise/"
betadir="${clonedir}/${1}/custom_components/plugwise/"
bmdir="${clonedir}/${1}-main/custom_components/plugwise/"
difffile="${clonedir}/plugwise.diff"
pdir="$(pwd)/${1}"
rdir="$(pwd)"

branches="${pdir}/branches.txt"

git config --global user.name 'diff2html'
git config --global user.email 'plugwise@users.noreply.github.com'

cd "${clonedir}" || exit
echo "" >  "${difffile}"
diff -X "${pdir}/ignorelist.txt" -ur "${coredir}/" "${betadir}/" >> "${difffile}"

diff2html -F "${pdir}/diff.html" -i file -- "${difffile}" || exit 1

echo "<html>
        <head>
                <title>Plugwise ${1} Core/${1} progress</title>
        </head>
        <body>

                <p>Active ${1}-branch vs active HA-core differences</p>
                <ul>
                        <li><a href='diff.html'>Unified diff core:dev vs ${1}:main</a></li>" > "${pdir}/index.html"

echo "
                </ul>
                <p>Branch differences (still in ${1})</p>
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
                        <li><a href='diff_${betabranchname}.html'>Unified diff core:dev vs ${1}:${betabranch}</a></li>" >> "${pdir}/index.html"

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
                <p>Various PR branch differences against -${1} main (downstreaming/verify)</p>
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
                        <li><a href='bm_diff_${prbranch}.html'>Unified diff ${1}:main vs pw-core:${prbranch}</a></li>" >> "${pdir}/index.html"

        cd "${betadir}" || exit
        git checkout main
done


cd "${clonedir}" || exit

echo "
                </ul>
        </body>
</html>" >> "${pdir}/index.html"

echo "<html>
        <head>
                <title>Plugwise beta's (USB/Networked) vs Core progress</title>
        </head>
        <body>
                        <li><a href='beta/index.html'>Plugwise Smile beta</a>
                        <li><a href='usb-beta/index.html'>Plugwise USB beta</a>

	</body>
</html>" >> "${rdir}/index.html"

cd "${pdir}" || exit
pwd
ls -alrt


#git remote set-url origin https://x-access-token:${PROGRESS_DEPLOYKEY}@github.com/$GITHUB_REPOSITORY
git checkout "${GITHUB_HEAD_REF}"
git add -A 
git commit -m "Update: ${GITHUB_REF##*/} - Diff report completed"
git push origin "${GITHUB_REF##*/}"

