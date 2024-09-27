test: validate
	go test -race ./...

validate:
	@if command -v golangci-lint >/dev/null 2>&1; then \
		echo "golangci-lint found, running validation..."; \
		golangci-lint version; \
		golangci-lint config verify --config golangci.yml || exit 1; \
	else \
		echo "golangci-lint not found, skipping validation."; \
	fi

check:
	goreleaser check
	DOCKERFILE=./Dockerfile MAIN_PATH=./testing/workflow_test BINARY_NAME=workflow_test TAP_DESCRIPTION=test goreleaser release --clean --snapshot

.PHONY: validate test check
