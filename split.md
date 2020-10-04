## Proposed change
Prepare integration for 'same brand, same integration' as set in #35713.
Basically this PR only slightly rearranges the code in preparation for adding USB connectivity. Translations will have the most impact from what I can test now.

There are two placeholder comments to indicate where future logic will be present in `§config_flow`.More details can be found in our ongoing (but substantially larger) beta-PR at (`config_flow` changes)[https://github.com/plugwise/plugwise-beta/pull/117/files#diff-579ef1fe8eaa9f4e6f36cff7cdad0747] where we will ask the user (unless network device discovery is used) to first select between USB or Network type of Plugwise product.

## Type of change

- [ ] Dependency upgrade
- [x] Bugfix (non-breaking change which fixes an issue)
- [ ] New integration (thank you!)
- [ ] New feature (which adds functionality to an existing integration)
- [ ] Breaking change (fix/feature causing existing functionality to break)
- [ ] Code quality improvements to existing code or addition of tests

## Additional information

- This PR fixes or closes issue: 
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
- [ ] New or updated dependencies have been added to `requirements_all.txt`.  
      Updated by running `python3 -m script.gen_requirements_all`.
- [ ] Untested files have been added to `.coveragerc`.

To help with the load of incoming pull requests:

- [x] I have reviewed two other [open pull requests][prs] in this repository.
- [x] I have helped out with other users requests on discord core and core-devs channels.

