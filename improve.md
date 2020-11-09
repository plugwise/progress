## Proposed change
Move consts centrally and general code improvements.

## Type of change

- [ ] Dependency upgrade
- [ ] Bugfix (non-breaking change which fixes an issue)
- [ ] New integration (thank you!)
- [ ] New feature (which adds functionality to an existing integration)
- [x] Breaking change (fix/feature causing existing functionality to break)
- [ ] Code quality improvements to existing code or addition of tests

## Additional information

- This PR fixes or closes issue: fixes #
- This PR is related to issue: 
- Link to documentation pull request: 

## Checklist

- [x] The code change is tested and works locally.
- [x] Local tests pass. **Your PR cannot be merged unless tests pass**
- [x] There is no commented out code in this PR.
- [x] I have followed the [development checklist][dev-checklist]
- [x] The code has been formatted using Black (`black --fast homeassistant tests`)
- [x] Tests have been added to verify that the new code works.

If user exposed functionality or configuration variables are added/changed:

- [ ] Documentation added/updated for [www.home-assistant.io][docs-repository]

If the code communicates with devices, web services, or third-party tools:

- [x] The [manifest file][manifest-docs] has all fields filled out correctly.  
      Updated and included derived files by running: `python3 -m script.hassfest`.
- [x] New or updated dependencies have been added to `requirements_all.txt`.  
      Updated by running `python3 -m script.gen_requirements_all`.
- [x] Untested files have been added to `.coveragerc`.

