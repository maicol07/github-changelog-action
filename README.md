# Generate changelog with git-chglog
[![GitHub release (latest SemVer)](https://img.shields.io/github/v/release/maicol07/github-changelog-action?sort=semver)]()
[![GitHub](https://img.shields.io/github/license/maicol07/github-changelog-action)]()
[![GitHub issues](https://img.shields.io/github/issues/maicol07/github-changelog-action)]()
[![GitHub pull requests](https://img.shields.io/github/issues-pr/maicol07/github-changelog-action)]()

GitHub Action for creating a CHANGELOG.md file based on semver and conventional commits.

## Usage
### Pre-requisites
Create a workflow .yml file in your repositories .github/workflows directory. An example workflow is available below. For more information, reference the GitHub Help Documentation for Creating a workflow file.

Furthermore you need to have [git-chlog](https://github.com/git-chglog/git-chglog) configured and have the configuration added to your git repository.

### Inputs
 - `next_version`: Next version number to use instead of "Unreleased"
 - `config_dir`: git-chglog configuration directory. Default: `.ghglog`
 - `filename`: Filename to write the changelog to. Default: `CHANGELOG.md`
 - `tag_query`: Optional, Generate changelog only for this tag.

### Outputs
 - `changelog`: Changelog content if no `filename` input is empty

### Example workflow
On every `push` to `master` generate a CHANGELOG.md file.

```yaml
name: Build and release
on: 
  push:
    branches:
      - master
  pull_request:
    branches:
      - master

jobs:
  package:
    runs-on: ubuntu-latest
    steps:
      - uses: maicol07/github-changelog-action@master
        with:
          tag_query: "1.0.0"      
```

## License
The scripts and documentation in this project are released under the [MIT License](LICENSE)

## Contributing

Please read [CONTRIBUTING.md](CONTRIBUTING.md) for details on our code of conduct, and the process for submitting pull requests to us.

## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/nuuday/github-changelog-action/tags). 

## Authors
* **Steffen F. Qvistgaard** - *Initial work* - [ssoerensen](https://github.com/ssoerensen)
* **Maicol Battistini** - *Maintainer* - [maicol07](https://github.com/maicol07)

See also the list of [contributors](https://github.com/maicol07/github-changelog-action/contributors) who participated in this project.
