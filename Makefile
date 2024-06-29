test: validate
	go test -race ./...

validate:
	golangci-lint version
	golangci-lint config verify --config golangci.yml
	golangci-lint run --config golangci.yml


check:
	goreleaser check
	TAP_DESCRIPTION=test goreleaser release --clean --snapshot

.PHONY: validate test check
