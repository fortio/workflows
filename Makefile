test: validate
	go test -race ./...

validate:
	golangci-lint version
	golangci-lint config verify --config golangci.yml
	golangci-lint run --config golangci.yml

.PHONY: validate test
