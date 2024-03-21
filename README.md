# workflows
Workflows reused across the go repos, to avoid dozens of same dependabot bumps

The goreleaser and  golangci-lint configs are shared and downloaded by the respective steps

A typical use is to setup the following (see for instance https://github.com/fortio/multicurl setup)
```yaml
name: "Shared cli/server fortio workflows"
on:
    push:
      branches: [ main ]
      tags:
        # so a vX.Y.Z-test1 doesn't trigger build
        - 'v[0-9]+.[0-9]+.[0-9]+'
        - 'v[0-9]+.[0-9]+.[0-9]+-pre*'
    pull_request:
      branches: [ main ]

jobs:
    call-gochecks:
        uses: fortio/workflows/.github/workflows/gochecks.yml@main
    call-codecov:
        uses: fortio/workflows/.github/workflows/codecov.yml@main
    call-codeql:
        uses: fortio/workflows/.github/workflows/codeql-analysis.yml@main
    call-releaser:
        uses: fortio/workflows/.github/workflows/releaser.yml@main
        with:
            description: "Fortio multi curl"
        secrets:
            GH_PAT: ${{ secrets.GH_PAT }}
            DOCKER_TOKEN: ${{ secrets.DOCKER_TOKEN }}
            DOCKER_USER: ${{ secrets.DOCKER_USER }}
```

Or for a library

```yaml
# Same as full workflow (eg from fortio/logc) but without the goreleaser step
name: "Shared library fortio workflows"

on:
    push:
      branches: [ main ]
    pull_request:
      branches: [ main ]

jobs:
    call-gochecks:
        uses: fortio/workflows/.github/workflows/gochecks.yml@main
    call-codecov:
        uses: fortio/workflows/.github/workflows/codecov.yml@main
    call-codeql:
        uses: fortio/workflows/.github/workflows/codeql-analysis.yml@main
```

Sample conversion for server/cli: https://github.com/fortio/logc/pull/44/files

For a library: https://github.com/fortio/sets/pull/64
