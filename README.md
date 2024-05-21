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
        permissions:
            actions: read
            contents: read
            security-events: write
    call-releaser:
        if: github.event_name == 'push' && startsWith(github.ref, 'refs/tags/')
        uses: fortio/workflows/.github/workflows/releaser.yml@main
        with:
            ### *** Don't forget to update this: *** ###
            description: "Fortio ...update description...."
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
        permissions:
            actions: read
            contents: read
            security-events: write
```

Sample conversion for server/cli: https://github.com/fortio/logc/pull/44/files

For a library: https://github.com/fortio/sets/pull/64

Dependabot will regularly update pinned github actions - to pin a new dependency:

Use https://github.com/mheap/pin-github-action
```
npm install -g pin-github-action
```
for each action:
```
pin-github-action .github/workflows/...yml
```


Note about `golangci-lint` make sure to run locally `make` before MRs (see also https://github.com/fortio/workflows/issues/38)
