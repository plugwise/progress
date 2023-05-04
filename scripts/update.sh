#!/bin/bash
rdir="$(pwd)"

echo "<html>
        <head>
                <title>Plugwise beta's (USB/Networked) vs Core progress</title>
        </head>
        <body>
                        <li><a href='beta/index.html'>Plugwise Smile beta</a>
                        <li><a href='usb-beta/index.html'>Plugwise USB beta</a>

	</body>
</html>" >> "${rdir}/index.html"

#git remote set-url origin https://x-access-token:${PROGRESS_DEPLOYKEY}@github.com/$GITHUB_REPOSITORY
git checkout "${GITHUB_HEAD_REF}"
git add -A 
git commit -m "Update: ${GITHUB_REF##*/} - Diff report completed"
git push origin "${GITHUB_REF##*/}"

