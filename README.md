# Plugwise for Home-Assistant Progress

See site details at [Github Plugwise pages](https://plugwise.github.io/progress/)

## How to use?

Manually enter things in `plugwise-beta` into `beta-branches.txt`. So if you are working on the branch `do-something` just add that that to the file :)

Any thing we have ready in **our** `home-assistant.core` should be put in `branches.txt`. As we self-use `plugwise-{description}` for PRs add it as such.

As we don't want 'push-by-push', for now (until we make this a PR mandatory repository)  you'll have to manually trigger the workflow from https://github.com/plugwise/progress/actions/workflows/diffy.yml
