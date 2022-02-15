# Plugwise for Home-Assistant Progress

See site details at [Github Plugwise pages](https://plugwise.github.io/progress/)

## How to use?

Manually enter things in `plugwise-beta` into `betabranches.txt`. So if you are working on the branch `do-something` just add that that to the file :)

Any thing we have ready in **our** `home-assistant.core` should be put in `branches.txt`. As we self-use `plugwise-{description}` for PRs add it as such.

As we don't want 'push-by-push', for now (until we make this a PR mandatory repository)  you'll have to manually trigger the workflow from https://github.com/plugwise/progress/actions/workflows/diffy.yml

## Gotcha's

The github actions on this repo run daily + will self-commit to the repo. As such 'auto'-triggering should be used with care.

Hence the above comment to implement a PR-only trigger (besides the daily one) and not react to 'all' commits.

## PR texts

If you want to prepare a PR text add a `{description}.md` file (as in the description from the core branch `plugwise-{description}`) it will generate a link to that markdown file.
