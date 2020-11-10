## Proposed change
Successor of #35713 - adds support for legacy Plugwise Circle+, Circle and Stealth devices. 
These devices are controlled by using a UBS-stick which communicates directly to the devices. 
More details is written down in the related documentation PR.

We'll adhere to trying it small and per platform, so this PR only contains the `switch` platform to control the power relays. 
In future PR's the other platform will be added to support multiple sensors (mainly) related to the power consumption.

## Type of change

- [ ] Dependency upgrade
- [ ] Bugfix (non-breaking change which fixes an issue)
- [ ] New integration (thank you!)
- [x] New feature (which adds functionality to an existing integration)
- [ ] Breaking change (fix/feature causing existing functionality to break)
- [ ] Code quality improvements to existing code or addition of tests

## Additional information

- This PR fixes or closes issue: fixes #35713
- This PR is related to issue: #35713
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
- [ ] Untested files have been added to `.coveragerc`.

To help with the load of incoming pull requests:

- [x] I have reviewed two other [open pull requests][prs] in this repository.
